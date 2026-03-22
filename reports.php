<?php
session_start();
require_once 'db_connect.php';

// Check if the user is logged in AND is an admin
if (!isset($_SESSION['loggedin']) || $_SESSION['loggedin'] !== true || !$_SESSION['is_admin']) {
    header('Location: login.php');
    exit;
}

// --- Date Filtering Logic ---
$currentYear = date('Y');
$startDate = $_GET['startDate'] ?? "$currentYear-01-01";
$endDate = $_GET['endDate'] ?? "$currentYear-12-31";

// --- Data Fetching for Reports with Date Filtering ---

// 1. Pacing Report Data (This Year vs Last Year)
$pacing_labels = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
$pacing_this_year_data = array_fill_keys($pacing_labels, 0);
$pacing_last_year_data = array_fill_keys($pacing_labels, 0);

$sql_ty = "SELECT MONTHNAME(res_date) as month, COUNT(reservation_id) as count FROM reservations WHERE res_date BETWEEN ? AND ? AND deleted_at IS NULL GROUP BY MONTH(res_date), MONTHNAME(res_date) ORDER BY MONTH(res_date)";
if ($stmt_ty = mysqli_prepare($link, $sql_ty)) {
    mysqli_stmt_bind_param($stmt_ty, "ss", $startDate, $endDate);
    mysqli_stmt_execute($stmt_ty);
    $result_ty = mysqli_stmt_get_result($stmt_ty);
    while ($row = mysqli_fetch_assoc($result_ty)) {
        $month_short = substr($row['month'], 0, 3);
        if (isset($pacing_this_year_data[$month_short])) {
            $pacing_this_year_data[$month_short] = $row['count'];
        }
    }
    mysqli_stmt_close($stmt_ty);
}

$startDateLY = date('Y-m-d', strtotime('-1 year', strtotime($startDate)));
$endDateLY = date('Y-m-d', strtotime('-1 year', strtotime($endDate)));
$sql_ly = "SELECT MONTHNAME(res_date) as month, COUNT(reservation_id) as count FROM reservations WHERE res_date BETWEEN ? AND ? AND deleted_at IS NULL GROUP BY MONTH(res_date), MONTHNAME(res_date) ORDER BY MONTH(res_date)";
if ($stmt_ly = mysqli_prepare($link, $sql_ly)) {
    mysqli_stmt_bind_param($stmt_ly, "ss", $startDateLY, $endDateLY);
    mysqli_stmt_execute($stmt_ly);
    $result_ly = mysqli_stmt_get_result($stmt_ly);
    while ($row = mysqli_fetch_assoc($result_ly)) {
        $month_short = substr($row['month'], 0, 3);
        if (isset($pacing_last_year_data[$month_short])) {
            $pacing_last_year_data[$month_short] = $row['count'];
        }
    }
    mysqli_stmt_close($stmt_ly);
}

// 2. Reservation Types Data
$sql_type = "SELECT 
                CASE 
                    WHEN reservation_type IS NULL OR reservation_type = '' THEN 'Dine-in'
                    ELSE reservation_type
                END AS res_type_name, 
                COUNT(reservation_id) as count
               FROM reservations
               WHERE res_date BETWEEN ? AND ? AND deleted_at IS NULL
               GROUP BY res_type_name";
$type_counts = [];
if ($stmt_type = mysqli_prepare($link, $sql_type)) {
    mysqli_stmt_bind_param($stmt_type, "ss", $startDate, $endDate);
    mysqli_stmt_execute($stmt_type);
    $result_type = mysqli_stmt_get_result($stmt_type);
    while ($row = mysqli_fetch_assoc($result_type)) {
        $type_counts[$row['res_type_name']] = $row['count'];
    }
    mysqli_stmt_close($stmt_type);
}

// 3. Guest Demographics (New vs. Returning) - MATCHING ADMIN.PHP LOGIC
$new_guests = 0;
$returning_guests = 0;

// Step A: Find the absolute first visit date for EVERY guest in the database
$sql_all_guests = "SELECT res_email, MIN(res_date) as first_visit FROM reservations WHERE deleted_at IS NULL GROUP BY res_email";
$result_all_guests = mysqli_query($link, $sql_all_guests);
$guest_first_visits = [];
if ($result_all_guests) {
    while ($guest = mysqli_fetch_assoc($result_all_guests)) {
        $guest_first_visits[$guest['res_email']] = $guest['first_visit'];
    }
    mysqli_free_result($result_all_guests);
}

// Step B: Fetch only the reservations that fall within your filtered date range
$sql_range_reservations = "SELECT res_email, res_date FROM reservations WHERE res_date BETWEEN ? AND ? AND deleted_at IS NULL";
if ($stmt_range = mysqli_prepare($link, $sql_range_reservations)) {
    mysqli_stmt_bind_param($stmt_range, "ss", $startDate, $endDate);
    mysqli_stmt_execute($stmt_range);
    $result_range = mysqli_stmt_get_result($stmt_range);
    
    while ($res = mysqli_fetch_assoc($result_range)) {
        if (isset($guest_first_visits[$res['res_email']])) {
            // If the reservation date is their first recorded visit date, they are New
            if ($res['res_date'] == $guest_first_visits[$res['res_email']]) {
                $new_guests++;
            } else {
                // If the reservation date is after their first recorded visit date, they are Returning
                $returning_guests++;
            }
        }
    }
    mysqli_free_result($result_range);
    mysqli_stmt_close($stmt_range);
}

mysqli_close($link);
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tavern Publico - Reservation Reports</title>
    <link rel="stylesheet" href="CSS/admin.css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        /* --- ENHANCED & RESPONSIVE UI STYLING --- */

        .filter-card {
            background-color: #fff;
            padding: 20px 25px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.03);
            border: 1px solid #eaedf1;
            margin-bottom: 25px;
        }

        .filter-card h3 {
            margin-top: 0;
            margin-bottom: 15px;
            font-size: 16px;
            color: #1e293b;
            display: flex;
            align-items: center;
            gap: 8px;
            font-weight: 700;
        }

        .filter-form {
            display: flex;
            gap: 20px;
            align-items: flex-end;
            flex-wrap: wrap;
        }

        .form-group { display: flex; flex-direction: column; flex: 1; min-width: 200px; }
        .form-group label { font-size: 13px; font-weight: 600; color: #475569; margin-bottom: 6px; }
        .form-group input[type="date"] {
            width: 100%;
            padding: 10px 14px;
            border: 1px solid #d1d5db;
            border-radius: 6px;
            font-family: inherit;
            font-size: 14px;
            transition: border-color 0.2s, box-shadow 0.2s;
            background-color: #fdfdfd;
        }
        .form-group input[type="date"]:focus {
            border-color: #0ea5e9;
            outline: none;
            box-shadow: 0 0 0 3px rgba(14, 165, 233, 0.15);
            background-color: #fff;
        }

        .btn {
            display: inline-flex; align-items: center; justify-content: center;
            padding: 10px 18px; font-size: 14px; font-weight: 500;
            border: none; border-radius: 6px; cursor: pointer; transition: all 0.2s ease; gap: 6px;
        }
        .btn-primary { background-color: #0ea5e9; color: white; box-shadow: 0 4px 6px rgba(14, 165, 233, 0.2); height: 40px; }
        .btn-primary:hover { background-color: #0284c7; transform: translateY(-1px); }

        .btn-small { padding: 6px 12px; font-size: 13px; }
        .btn-small i { font-size: 16px; }
        
        .export-csv { background-color: #e0f2fe; color: #0284c7; }
        .export-csv:hover { background-color: #bae6fd; }
        .print-chart { background-color: #f1f5f9; color: #475569; }
        .print-chart:hover { background-color: #e2e8f0; color: #1e293b; }

        .report-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 25px;
            margin-bottom: 25px;
            align-items: stretch;
        }

        .report-section {
            background-color: #fff;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.03);
            border: 1px solid #eaedf1;
            display: flex;
            flex-direction: column;
            margin-bottom: 25px;
        }

        .report-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            border-bottom: 2px solid #f1f5f9;
            padding-bottom: 12px;
            flex-wrap: wrap;
            gap: 15px;
        }

        .report-header h3 {
            margin: 0;
            font-size: 17px;
            color: #1e293b;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .export-options { display: flex; gap: 8px; }
        .chart-container { position: relative; flex-grow: 1; min-height: 300px; width: 100%; }

        /* --- RESPONSIVE MEDIA QUERIES --- */
        @media (max-width: 992px) {
            .report-grid { grid-template-columns: 1fr; }
        }
        @media (max-width: 576px) {
            .filter-form { flex-direction: column; align-items: stretch; }
            .btn-primary { width: 100%; }
            .report-header { flex-direction: column; align-items: flex-start; }
            .export-options { width: 100%; }
            .export-options .btn { flex: 1; }
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
                        <li class="menu-item"><a href="table_management.php"><i class="material-icons">table_chart</i> Calendar Management</a></li>
                        <li class="menu-item active"><a href="reports.php"><i class="material-icons">analytics</i>Reservation Reports</a></li>
                        <li class="menu-item"><a href="deletion_history.php"><i class="material-icons">history</i> Archive</a></li>
                    </ul>
            </nav>
        </aside>
    <?php } ?>

    <div class="admin-content-area">
            <header class="main-header">
                <div class="header-content">
                    <h1 class="header-page-title">Analytics & Reports</h1>
                    
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
                                <a href="logout.php" class="admin-dropdown-item">
                                    <i class="material-icons">logout</i>
                                    <span>Log Out</span>
                                </a>
                            </div>
                        </div>

                    </div>
                    </div>
            </header>

        <main class="dashboard-main-content">

            <div class="filter-card">
                <h3><i class="material-icons" style="color: #0ea5e9;">date_range</i> Filter Reports by Date Range</h3>
                <form method="GET" action="reports.php" class="filter-form">
                    <div class="form-group">
                        <label for="startDate">Start Date</label>
                        <input type="date" id="startDate" name="startDate" value="<?= htmlspecialchars($startDate) ?>">
                    </div>
                    <div class="form-group">
                        <label for="endDate">End Date</label>
                        <input type="date" id="endDate" name="endDate" value="<?= htmlspecialchars($endDate) ?>">
                    </div>
                    <button type="submit" class="btn btn-primary"><i class="material-icons">filter_list</i> Apply Filter</button>
                </form>
            </div>

            <section class="report-section">
                <div class="report-header">
                    <h3><i class="material-icons" style="color: #10b981;">trending_up</i> Pacing Report (This Year vs. Last Year)</h3>
                    <div class="export-options">
                        <button class="btn btn-small export-csv" data-target="pacingChart" data-title="Pacing Report"><i class="material-icons">download</i> CSV</button>
                        <button class="btn btn-small print-chart" data-target="pacingChart" data-title="Pacing Report"><i class="material-icons">print</i> Print</button>
                    </div>
                </div>
                <div class="chart-container">
                    <canvas id="pacingChart"></canvas>
                </div>
            </section>

            <div class="report-grid">
                <section class="report-section" style="margin-bottom: 0;">
                    <div class="report-header">
                        <h3><i class="material-icons" style="color: #f59e0b;">pie_chart</i> Reservation Types</h3>
                        <div class="export-options">
                            <button class="btn btn-small export-csv" data-target="typeChart" data-title="Reservation Types Report"><i class="material-icons">download</i> CSV</button>
                            <button class="btn btn-small print-chart" data-target="typeChart" data-title="Reservation Types Report"><i class="material-icons">print</i> Print</button>
                        </div>
                    </div>
                    <div class="chart-container">
                        <canvas id="typeChart"></canvas>
                    </div>
                </section>
                
                <section class="report-section" style="margin-bottom: 0;">
                    <div class="report-header">
                        <h3><i class="material-icons" style="color: #8b5cf6;">groups</i> Guest Retention</h3>
                        <div class="export-options">
                            <button class="btn btn-small export-csv" data-target="demographicsChart" data-title="Guest Retention Report"><i class="material-icons">download</i> CSV</button>
                            <button class="btn btn-small print-chart" data-target="demographicsChart" data-title="Guest Retention Report"><i class="material-icons">print</i> Print</button>
                        </div>
                    </div>
                    <div class="chart-container">
                        <canvas id="demographicsChart"></canvas>
                    </div>
                </section>
            </div>

        </main>
    </div>
</div>

<script>
    // Passing dynamically filtered data from PHP to our separate JS file
    const reportData = {
        startDate: "<?= htmlspecialchars($startDate) ?>",
        endDate: "<?= htmlspecialchars($endDate) ?>",
        pacing: {
            labels: <?= json_encode(array_values($pacing_labels)); ?>,
            thisYear: <?= json_encode(array_values($pacing_this_year_data)); ?>,
            lastYear: <?= json_encode(array_values($pacing_last_year_data)); ?>
        },
        type: {
            labels: <?= json_encode(array_keys($type_counts)); ?>,
            counts: <?= json_encode(array_values($type_counts)); ?>
        },
        demographics: {
            newGuests: <?= $new_guests; ?>,
            returningGuests: <?= $returning_guests; ?>
        }
    };
</script>
<script src="JS/reports.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', () => {
        // Dropdown Logic
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
            } catch (error) {
                console.error('Error fetching admin notifications:', error);
            }
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
                    alert(result.message); 
                }
            } catch (error) {
                console.error('Error dismissing notification:', error);
                alert('An error occurred. Please try again.');
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