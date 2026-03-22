<?php
session_start();
require_once 'db_connect.php';

// MODIFIED: More specific authorization check
$is_authorized = false;
if (isset($_SESSION['loggedin']) && $_SESSION['loggedin'] === true) {
    // Admins are always authorized
    if (isset($_SESSION['role']) && $_SESSION['role'] === 'owner') {
        $is_authorized = true;
    }
    // Managers are authorized only if they have the specific permission
    elseif (isset($_SESSION['role']) && $_SESSION['role'] === 'manager') {
        if (isset($_SESSION['permissions']) && is_array($_SESSION['permissions']) && in_array('access_tables', $_SESSION['permissions'])) {
            $is_authorized = true;
        }
    }
}

if (!$is_authorized) {
    header('Location: login.php'); // Redirect if not authorized
    exit;
}

// Get the current page name for active link highlighting
$currentPage = basename($_SERVER['SCRIPT_NAME']);

// Fetch blocked dates for display
$blocked_dates_list = [];
$sql_blocked_list = "SELECT id, block_date FROM blocked_dates ORDER BY block_date DESC"; // Order by DESC to show newest first
if ($result = mysqli_query($link, $sql_blocked_list)) {
    while ($row = mysqli_fetch_assoc($result)) {
        $blocked_dates_list[] = $row;
    }
}

?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tavern Publico - Calendar Management</title>
    <link rel="stylesheet" href="CSS/admin.css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.10.2/fullcalendar.min.css" />
    <style>
        /* --- ENHANCED & RESPONSIVE UI STYLING --- */

        .management-grid {
            display: grid;
            grid-template-columns: 1fr 1.5fr; 
            gap: 25px;
            margin-bottom: 25px;
            align-items: stretch;
        }

        .block-date-form, .blocked-dates-list, .calendar-container {
            background-color: #fff;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.03);
            border: 1px solid #eaedf1;
        }

        .block-date-form h3, .blocked-dates-list h3 {
             margin-top: 0;
             color: #1e293b;
             font-size: 18px;
             font-weight: 700;
             border-bottom: 2px solid #f1f5f9;
             padding-bottom: 12px;
             margin-bottom: 20px;
        }

        /* Form Inputs */
        .form-group { margin-bottom: 18px; }
        .form-group label { display: block; margin-bottom: 8px; font-weight: 600; color: #444; font-size: 14px; }
        .form-group input[type="date"] { width: 100%; padding: 12px 15px; border: 1px solid #d1d5db; border-radius: 6px; box-sizing: border-box; transition: border-color 0.2s, box-shadow 0.2s; font-family: inherit; font-size: 14px; background: #fdfdfd; }
        .form-group input[type="date"]:focus { border-color: #007bff; outline: none; box-shadow: 0 0 0 3px rgba(0,123,255,0.1); background: #fff; }

        /* Buttons */
        .btn { display: inline-flex; align-items: center; justify-content: center; padding: 10px 18px; font-size: 14px; font-weight: 500; border: none; border-radius: 6px; cursor: pointer; transition: all 0.2s ease; gap: 6px; text-decoration: none; }
        .btn i { font-size: 18px; margin-right: 2px; }
        .btn-small { padding: 6px 12px; font-size: 13px; }
        .btn-small i { font-size: 16px; margin-right: 4px; }
        
        .btn-danger { background-color: #ef4444; color: white; box-shadow: 0 4px 6px rgba(239,68,68,0.2); }
        .btn-danger:hover { background-color: #dc2626; transform: translateY(-1px); }

        /* Blocked Dates List Container */
        #blocked-dates-container {
            max-height: 250px;
            overflow-y: auto;
            padding-right: 10px;
        }
        #blocked-dates-container::-webkit-scrollbar { width: 6px; }
        #blocked-dates-container::-webkit-scrollbar-track { background: #f1f5f9; border-radius: 10px; }
        #blocked-dates-container::-webkit-scrollbar-thumb { background: #cbd5e1; border-radius: 10px; }
        #blocked-dates-container::-webkit-scrollbar-thumb:hover { background: #94a3b8; }

        /* Individual List Item */
        .blocked-date-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 14px 18px;
            border-radius: 8px;
            background-color: #f8fafc;
            border: 1px solid #e2e8f0;
            margin-bottom: 12px;
            transition: transform 0.2s, box-shadow 0.2s;
        }
        .blocked-date-item:hover { 
            transform: translateY(-2px); 
            box-shadow: 0 4px 6px rgba(0,0,0,0.05); 
            background-color: #fff; 
            border-color: #cbd5e1; 
        }
        .blocked-date-item span { font-weight: 600; color: #334155; font-size: 15px; display: flex; align-items: center; gap: 8px; }
        
        .unblock-date-btn { background-color: #fee2e2; color: #991b1b; }
        .unblock-date-btn:hover { background-color: #fecaca; }

        .calendar-container { cursor: pointer; }
        
        /* Modals Formatting */
        .modal { display: none; position: fixed; z-index: 2000; left: 0; top: 0; width: 100%; height: 100%; background-color: rgba(15, 23, 42, 0.6); align-items: center; justify-content: center; padding: 15px; backdrop-filter: blur(4px); }
        .modal-content { background-color: #fff; border-radius: 12px; width: 100%; max-width: 600px; box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1); display: flex; flex-direction: column; overflow: hidden; max-height: 90vh; }
        
        .modal-header { padding: 20px 25px; border-bottom: 1px solid #e2e8f0; display: flex; justify-content: space-between; align-items: center; background-color: #f8fafc; }
        .modal-header h2 { margin: 0; font-size: 18px; color: #1e293b; font-weight: 700; }
        .modal-body { padding: 25px; overflow-y: auto; }
        .modal-actions { padding: 20px 25px; border-top: 1px solid #e2e8f0; display: flex; justify-content: flex-end; gap: 10px; background-color: #f8fafc; }
        
        .close-button { font-size: 24px; color: #94a3b8; cursor: pointer; background: none; border: none; padding: 0; line-height: 1; transition: color 0.2s; }
        .close-button:hover { color: #334155; }

        /* Specific Modals */
        #dateDetailsModal .modal-content { max-width: 750px; }
        .table-responsive { width: 100%; overflow-x: auto; -webkit-overflow-scrolling: touch; border-radius: 8px; border: 1px solid #eaedf1; }
        #dateDetailsModal table { width: 100%; border-collapse: collapse; min-width: 600px; }
        #dateDetailsModal th, #dateDetailsModal td { padding: 12px 15px; text-align: left; border-bottom: 1px solid #eaedf1; vertical-align: middle; }
        #dateDetailsModal th { background-color: #f8fafc; font-weight: 600; color: #475569; font-size: 13px; text-transform: uppercase; letter-spacing: 0.5px; }
        
        #notificationModal .modal-content { text-align: center; max-width: 400px; }
        #notificationModal .modal-header { border-bottom: none; justify-content: flex-end; padding-bottom: 0; }
        #notificationModal .modal-body { padding-top: 0; }
        #notificationModal .modal-header-icon { font-size: 60px; margin-bottom: 15px; }
        #notificationModal .modal-header-icon.success { color: #10b981; }
        #notificationModal .modal-header-icon.error { color: #ef4444; }
        #notificationModal #modalTitle { margin-bottom: 12px; font-size: 22px; color: #1e293b; }
        #notificationModal #modalMessage { color: #64748b; margin-bottom: 0; }
        #notificationModal .modal-actions { justify-content: center; border-top: none; background: #fff; }
        #notificationModal .modal-close-btn { background-color: #0ea5e9; color: white; padding: 10px 30px; border-radius: 20px; }

        @media (max-width: 992px) { 
            .management-grid { grid-template-columns: 1fr; } 
        }
    </style>
</head>
<body>

    <div class="page-wrapper">
        <?php
        if (isset($_SESSION['role']) && $_SESSION['role'] === 'manager') {
            include 'partials/manager_sidebar.php';
        } else {
        ?>
            <aside class="admin-sidebar">
                 <div class="sidebar-header"><img src="Tavern.png" alt="Home Icon" class="home-icon"></div>
                <nav>
                     <ul class="sidebar-menu">
                        <li class="menu-item"><a href="admin.php"><i class="material-icons">dashboard</i> Dashboard</a></li>
                        <li class="menu-item"><a href="reservation.php"><i class="material-icons">event_note</i> Reservation</a></li>
                        <li class="menu-item"><a href="update.php"><i class="material-icons">file_upload</i> Upload Management</a></li>
                    </ul>
                    <div class="user-management-title">User Management</div>
                    <ul class="sidebar-menu user-management-menu">
                       <li class="menu-item"><a href="customer_database.php"><i class="material-icons">people</i> Customer Database</a></li>
                       <li class="menu-item"><a href="notification_control.php"><i class="material-icons">notifications</i> Notification Control</a></li>
                        <li class="menu-item active"><a href="table_management.php"><i class="material-icons">table_chart</i>Calendar management</a></li>
                        <li class="menu-item"><a href="reports.php"><i class="material-icons">analytics</i>Reservation Reports</a></li>
                        <li class="menu-item"><a href="deletion_history.php"><i class="material-icons">history</i>Archive</a></li>
                    </ul>
                </nav>
            </aside>
        <?php } ?>

        <div class="admin-content-area">
            <header class="main-header">
                <div class="header-content">
                    <h1 class="header-page-title">Calendar Management</h1>
                    
                    <div class="admin-header-right">
                        <div class="admin-notification-area">
                            <div class="admin-notification-item">
                                <button class="admin-notification-button" id="adminMessageBtn" title="Messages">
                                    <i class="material-icons">email</i>
                                    <span class="admin-notification-badge" id="adminMessageCount" style="display: none;">0</span>
                                </button>
                                <div class="admin-notification-dropdown" id="adminMessageDropdown"></div>
                            </div>
                            <div class="admin-notification-item">
                                <button class="admin-notification-button" id="adminReservationBtn" title="Reservations">
                                    <i class="material-icons">notifications</i> <span class="admin-notification-badge" id="adminReservationCount" style="display: none;">0</span>
                                </button>
                                <div class="admin-notification-dropdown" id="adminReservationDropdown"></div>
                            </div>
                        </div>

                        <div class="header-separator"></div>

                        <div class="admin-profile-dropdown">
                            <div class="admin-profile-area" id="adminProfileBtn">
                                <?php $admin_avatar_path = isset($_SESSION['avatar']) && file_exists($_SESSION['avatar']) ? htmlspecialchars($_SESSION['avatar']) : 'images/default_avatar.png'; ?>
                                <img src="<?php echo $admin_avatar_path; ?>" alt="Admin Avatar" class="admin-avatar">
                                <div class="admin-user-info">
                                    <span class="admin-username"><?php echo htmlspecialchars($_SESSION['username']); ?></span>
                                    <span class="admin-role"><?php echo ucfirst(htmlspecialchars($_SESSION['role'])); ?></span>
                                </div>
                                <i class="material-icons" style="color: #666; margin-left: 5px;">arrow_drop_down</i>
                            </div>
                            <div class="admin-dropdown" id="adminProfileDropdown">
                                <a href="logout.php" class="admin-dropdown-item"><i class="material-icons">logout</i><span>Log Out</span></a>
                            </div>
                        </div>
                    </div>
                </div>
            </header>

            <main class="dashboard-main-content">
                <div class="management-grid">
                    <div class="block-date-form">
                        <h3><i class="material-icons" style="vertical-align: middle; margin-right: 8px; color: #ef4444;">block</i> Block Reservations</h3>
                        <form id="blockDateForm">
                            <div class="form-group">
                                <label for="block_date_start">Start Date:</label>
                                <input type="date" id="block_date_start" name="block_date_start" min="<?php echo date('Y-m-d'); ?>" required>
                            </div>
                            <div class="form-group">
                                <label for="block_date_end">End Date (Optional):</label>
                                <input type="date" id="block_date_end" name="block_date_end" min="<?php echo date('Y-m-d'); ?>">
                            </div>
                            <button type="submit" class="btn btn-danger" style="width: 100%; margin-top: 10px;"><i class="material-icons">lock</i> Block Selected Date(s)</button>
                        </form>
                    </div>
                    
                    <div class="blocked-dates-list">
                        <h3><i class="material-icons" style="vertical-align: middle; margin-right: 8px; color: #1e293b;">event_busy</i> Currently Blocked Dates</h3>
                        <div id="blocked-dates-container">
                            <?php if (empty($blocked_dates_list)): ?>
                                <div style="text-align: center; color: #94a3b8; padding: 20px 0;">
                                    <i class="material-icons" style="font-size: 40px; margin-bottom: 10px;">event_available</i>
                                    <p style="margin:0;">No dates are currently blocked.</p>
                                </div>
                            <?php else: ?>
                                <?php foreach ($blocked_dates_list as $date): ?>
                                    <div class="blocked-date-item" data-id="<?php echo $date['id']; ?>">
                                        <span><i class="material-icons" style="color: #ef4444; font-size: 20px;">calendar_today</i> <?php echo htmlspecialchars(date('F j, Y', strtotime($date['block_date']))); ?></span>
                                        <button class="btn btn-small unblock-date-btn"><i class="material-icons">lock_open</i> Unblock</button>
                                    </div>
                                <?php endforeach; ?>
                            <?php endif; ?>
                        </div>
                    </div>
                </div>
                
                <div class="calendar-container">
                    <h3 style="margin-top: 0; color: #1e293b; font-size: 18px; font-weight: 700; border-bottom: 2px solid #f1f5f9; padding-bottom: 12px; margin-bottom: 20px;">Reservation Calendar</h3>
                    <div id="calendar"></div>
                </div>
            </main>
        </div>
    </div>

    <div id="dateDetailsModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2 id="modalDateTitle">Reservations</h2>
                <button class="close-button">&times;</button>
            </div>
            <div class="modal-body">
                <div id="modalReservationsList" class="table-responsive"></div>
            </div>
        </div>
    </div>

    <div id="notificationModal" class="modal">
        <div class="modal-content">
             <div class="modal-header">
                <button class="close-button">&times;</button>
            </div>
            <div class="modal-body">
                <div id="modalHeaderIcon" class="modal-header-icon"></div>
                <h2 id="modalTitle"></h2>
                <p id="modalMessage"></p>
            </div>
            <div class="modal-actions">
                <button class="btn modal-close-btn">OK</button>
            </div>
        </div>
    </div>
    
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.10.2/fullcalendar.min.js"></script>
    
    <script src="JS/table_management.js"></script>
    
    <script>
    document.addEventListener('DOMContentLoaded', () => {
        
        const notificationModal = $('#notificationModal');
            
        function showNotificationModal(type, title, message) {
            const iconHtml = type === 'success' 
                ? '<i class="material-icons">check_circle_outline</i>' 
                : '<i class="material-icons">error_outline</i>';
            
            notificationModal.find('#modalHeaderIcon').html(iconHtml).removeClass('success error').addClass(type);
            notificationModal.find('#modalTitle').text(title);
            notificationModal.find('#modalMessage').text(message);
            notificationModal.css('display', 'flex');
        }
        
        // Modal close button bindings
        $('.close-button, .modal-close-btn').on('click', function() {
            $(this).closest('.modal').css('display', 'none');
        });
        
        $(window).on('click', function(event) {
            if ($(event.target).is('.modal')) {
                $(event.target).css('display', 'none');
            }
        });

        // Admin Header Notifications Dropdown Logic
        const messageBtn = document.getElementById('adminMessageBtn');
        const reservationBtn = document.getElementById('adminReservationBtn');
        const messageDropdown = document.getElementById('adminMessageDropdown');
        const reservationDropdown = document.getElementById('adminReservationDropdown');
        const messageCountBadge = document.getElementById('adminMessageCount');
        const reservationCountBadge = document.getElementById('adminReservationCount');
        const adminProfileBtn = document.getElementById('adminProfileBtn');
        const adminProfileDropdown = document.getElementById('adminProfileDropdown');

        async function fetchAdminNotifications() {
            try {
                const response = await fetch('/get_admin_notifications');
                const data = await response.json();

                if (data.success) {
                    if (data.new_messages > 0) {
                        messageCountBadge.textContent = data.new_messages;
                        messageCountBadge.style.display = 'block';
                    } else {
                        messageCountBadge.style.display = 'none';
                    }
                    messageDropdown.innerHTML = data.messages_html;

                    if (data.pending_reservations > 0) {
                        reservationCountBadge.textContent = data.pending_reservations;
                        reservationCountBadge.style.display = 'block';
                    } else {
                        reservationCountBadge.style.display = 'none';
                    }
                    reservationDropdown.innerHTML = data.reservations_html;
                }
            } catch (error) { console.error('Error fetching admin notifications:', error); }
        }

        if (messageBtn) {
            messageBtn.addEventListener('click', (e) => {
                e.stopPropagation();
                if (reservationDropdown) reservationDropdown.classList.remove('show');
                if (adminProfileDropdown) adminProfileDropdown.classList.remove('show');
                if (messageDropdown) messageDropdown.classList.toggle('show');
            });
        }

        if (reservationBtn) {
            reservationBtn.addEventListener('click', (e) => {
                e.stopPropagation();
                if (messageDropdown) messageDropdown.classList.remove('show');
                if (adminProfileDropdown) adminProfileDropdown.classList.remove('show');
                if (reservationDropdown) reservationDropdown.classList.toggle('show');
            });
        }

        if (adminProfileBtn) {
            adminProfileBtn.addEventListener('click', (e) => {
                e.stopPropagation();
                if (messageDropdown) messageDropdown.classList.remove('show');
                if (reservationDropdown) reservationDropdown.classList.remove('show');
                if (adminProfileDropdown) adminProfileDropdown.classList.toggle('show');
            });
        }

        window.addEventListener('click', () => {
            if (messageDropdown) messageDropdown.classList.remove('show');
            if (reservationDropdown) reservationDropdown.classList.remove('show');
            if (adminProfileDropdown) adminProfileDropdown.classList.remove('show');
        });
        
        [messageDropdown, reservationDropdown, adminProfileDropdown].forEach(dropdown => {
            if (dropdown) {
                dropdown.addEventListener('click', (e) => {
                    if (!e.target.classList.contains('admin-notification-dismiss')) {
                        e.stopPropagation();
                    }
                });
            }
        });

        async function handleDismiss(e) {
            if (!e.target.classList.contains('admin-notification-dismiss')) return;

            e.preventDefault();
            e.stopPropagation();

            const button = e.target;
            const id = button.dataset.id;
            const type = button.dataset.type;
            const itemWrapper = button.parentElement;
            
            const formData = new FormData();
            formData.append('id', id);
            formData.append('type', type);

            try {
                const response = await fetch('/clear_admin_notification', { method: 'POST', body: formData });
                const result = await response.json();

                if (result.success) {
                    itemWrapper.style.transition = 'opacity 0.3s ease, transform 0.3s ease';
                    itemWrapper.style.opacity = '0';
                    itemWrapper.style.transform = 'translateX(-20px)';
                    setTimeout(() => {
                        itemWrapper.remove();
                        fetchAdminNotifications(); 
                    }, 300);
                } else {
                    showNotificationModal('error', 'Action Failed', result.message);
                }
            } catch (error) {
                console.error('Error dismissing notification:', error);
                showNotificationModal('error', 'Error', 'An error occurred. Please try again.');
            }
        }

        if (messageDropdown) messageDropdown.addEventListener('click', handleDismiss);
        if (reservationDropdown) reservationDropdown.addEventListener('click', handleDismiss);

        fetchAdminNotifications();
        setInterval(fetchAdminNotifications, 30000); 
    });
    </script>
</body>
</html>