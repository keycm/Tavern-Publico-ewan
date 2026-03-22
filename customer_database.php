<?php
session_start();
require_once 'db_connect.php';

// MODIFICATION: Only the 'owner' can access this page
if (!isset($_SESSION['loggedin']) || $_SESSION['loggedin'] !== true || !isset($_SESSION['role']) || $_SESSION['role'] !== 'owner') {
    header('Location: login.php');
    exit;
}

// Automatically delete unverified users whose OTP has expired.
$cleanup_sql = "DELETE FROM users WHERE is_verified = 0 AND otp_expiry < NOW()";
if (!mysqli_query($link, $cleanup_sql)) {
    error_log("Failed to cleanup expired users on customer_database.php: " . mysqli_error($link));
}

// Fetch all non-admin users from the database, including their role
$users = [];
// MODIFIED: Added permissions to the query
$sql = "SELECT user_id, username, email, created_at, is_verified, role, permissions FROM users WHERE is_admin = 0 AND deleted_at IS NULL ORDER BY created_at DESC";

if ($result = mysqli_query($link, $sql)) {
    while ($row = mysqli_fetch_assoc($result)) {
        $users[] = $row;
    }
    mysqli_free_result($result);
} else {
    error_log("Customer Database page error: " . mysqli_error($link));
}

mysqli_close($link);
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tavern Publico - Customer Database</title>
    <link rel="stylesheet" href="CSS/admin.css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <style>
        /* --- ENHANCED & RESPONSIVE UI STYLING --- */

        /* Headers and Search */
        .reservation-page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
            flex-wrap: wrap;
            gap: 15px;
            background: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.03);
            border: 1px solid #eaedf1;
        }

        .search-input {
            padding: 12px 20px;
            border: 1px solid #d1d5db;
            border-radius: 25px;
            width: 350px;
            max-width: 100%;
            font-size: 14px;
            outline: none;
            transition: border-color 0.3s, box-shadow 0.3s;
            background-color: #f8f9fa;
        }

        .search-input:focus {
            border-color: #007bff;
            box-shadow: 0 0 0 3px rgba(0, 123, 255, 0.15);
            background-color: #fff;
        }

        /* Table & Responsive Wrapper */
        .table-responsive {
            width: 100%;
            overflow-x: auto;
            -webkit-overflow-scrolling: touch;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.03);
            border: 1px solid #eaedf1;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            min-width: 900px; /* Forces scroll on small devices */
        }

        table th, table td {
            padding: 16px 20px;
            text-align: left;
            border-bottom: 1px solid #eaedf1;
            vertical-align: middle;
        }

        table th {
            background-color: #f8f9fa;
            font-weight: 600;
            color: #495057;
            font-size: 13px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        table tbody tr { transition: background-color 0.2s; }
        table tbody tr:hover { background-color: #fcfdfd; }

        /* Status Badges */
        .status-badge {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            display: inline-block;
            text-align: center;
        }
        .status-badge.confirmed { background-color: #d1e7dd; color: #0f5132; }
        .status-badge.pending { background-color: #fff3cd; color: #856404; }
        
        /* Role Cell */
        .role-cell {
            font-weight: 600;
            color: #495057;
        }
        .role-manager { color: #0284c7; }

        /* Action Buttons */
        .actions { display: flex; gap: 8px; flex-wrap: wrap; }
        .btn { border: none; padding: 10px 18px; border-radius: 6px; cursor: pointer; font-size: 14px; font-weight: 500; transition: all 0.2s; display: inline-flex; align-items: center; justify-content: center; }
        .btn i { font-size: 18px; margin-right: 6px; }
        .btn-small { padding: 6px 12px; font-size: 12px; }
        .btn-small i { font-size: 16px; margin-right: 4px; }
        
        .btn-primary { background-color: #28a745; color: white; box-shadow: 0 4px 6px rgba(40,167,69,0.2); }
        .btn-primary:hover { background-color: #218838; transform: translateY(-1px); }

        .view-edit-btn { background-color: #e0f2fe; color: #0284c7; }
        .view-edit-btn:hover { background-color: #bae6fd; }
        
        .delete-btn { background-color: #fee2e2; color: #991b1b; }
        .delete-btn:hover { background-color: #fecaca; }

        .verify-btn { background-color: #cff4fc; color: #055160; }
        .verify-btn:hover { background-color: #b6effb; }

        .promote-user-btn { background-color: #dcfce7; color: #166534; }
        .promote-user-btn:hover { background-color: #bbf7d0; }

        .demote-user-btn { background-color: #f3f4f6; color: #4b5563; }
        .demote-user-btn:hover { background-color: #e5e7eb; }

        .edit-permissions-btn { background-color: #fef3c7; color: #92400e; }
        .edit-permissions-btn:hover { background-color: #fde68a; }

        /* Modals Formatting */
        .modal { display: none; position: fixed; z-index: 1000; left: 0; top: 0; width: 100%; height: 100%; background-color: rgba(0,0,0,0.5); align-items: center; justify-content: center; padding: 15px; }
        .modal-content { background-color: #fff; border-radius: 12px; width: 100%; box-shadow: 0 10px 30px rgba(0,0,0,0.2); display: flex; flex-direction: column; overflow: hidden; max-height: 90vh; }
        
        #userModal .modal-content { max-width: 500px; }
        #managerPermissionsModal .modal-content { max-width: 600px; }
        
        .modal-header { padding: 20px 25px; border-bottom: 1px solid #eee; display: flex; justify-content: space-between; align-items: center; background-color: #fafbfc; }
        .modal-header h2 { margin: 0; font-size: 18px; color: #2c3e50; font-weight: 700; }
        .modal-body { padding: 25px; overflow-y: auto; }
        .modal-actions { padding: 20px 25px; border-top: 1px solid #eee; display: flex; justify-content: flex-end; gap: 10px; background-color: #fafbfc; }
        
        .close-button { font-size: 24px; color: #999; cursor: pointer; background: none; border: none; padding: 0; line-height: 1; transition: color 0.2s; }
        .close-button:hover { color: #333; }

        /* Form Inputs */
        .form-group { margin-bottom: 18px; }
        .form-group label { display: block; margin-bottom: 8px; font-weight: 600; color: #444; font-size: 14px; }
        .form-group input { width: 100%; padding: 12px 15px; border: 1px solid #d1d5db; border-radius: 6px; font-family: inherit; font-size: 14px; box-sizing: border-box; transition: border-color 0.2s; background: #fdfdfd; }
        .form-group input:focus { border-color: #007bff; outline: none; box-shadow: 0 0 0 3px rgba(0,123,255,0.1); }
        small#passwordHelp { display: block; margin-top: 6px; color: #777; font-size: 12px; }

        .modal-save-btn { background-color: #007bff; color: white; padding: 10px 20px; font-size: 14px; }
        .modal-save-btn:hover { background-color: #0056b3; }

        /* --- Styles for New Manager Permissions Modal --- */
        .permission-group { margin-top: 5px; }
        .permission-item { display: flex; align-items: center; padding: 18px 0; border-bottom: 1px solid #f1f3f5; gap: 20px; }
        .permission-item:last-child { border-bottom: none; padding-bottom: 0; }
        .permission-icon { display: flex; align-items: center; justify-content: center; flex-shrink: 0; font-size: 2em; color: #0284c7; width: 45px; height: 45px; background: #e0f2fe; border-radius: 50%; }
        
        .permission-text { flex-grow: 1; }
        .permission-text label { font-size: 15px; font-weight: 600; color: #333; display: block; margin-bottom: 4px; cursor: pointer; }
        .permission-text p { font-size: 13px; color: #666; margin: 0; line-height: 1.5; }
        .permission-toggle { flex-shrink: 0; }
        
        /* Toggle Switch CSS */
        .toggle-switch { height: 0; width: 0; visibility: hidden; position: absolute; }
        .toggle-switch + label { cursor: pointer; text-indent: -9999px; width: 48px; height: 26px; background: #d1d5db; display: block; border-radius: 100px; position: relative; transition: background-color 0.3s; }
        .toggle-switch + label:after { content: ''; position: absolute; top: 3px; left: 3px; width: 20px; height: 20px; background: #fff; border-radius: 90px; transition: 0.3s cubic-bezier(0.4, 0.0, 0.2, 1); box-shadow: 0 2px 4px rgba(0,0,0,0.2); }
        .toggle-switch:checked + label { background: #10b981; }
        .toggle-switch:checked + label:after { left: calc(100% - 3px); transform: translateX(-100%); }
        .toggle-switch + label:active:after { width: 26px; }

        /* Loading Spinner */
        .btn-loading { position: relative; color: transparent !important; cursor: wait; pointer-events: none; }
        .btn-loading::after { content: ''; position: absolute; left: 50%; top: 50%; width: 18px; height: 18px; margin-left: -9px; margin-top: -9px; border: 2px solid rgba(255,255,255,0.5); border-top-color: #fff; border-radius: 50%; animation: spin 0.8s linear infinite; }
        @keyframes spin { to { transform: rotate(360deg); } }

        /* --- RESPONSIVE MEDIA QUERIES --- */
        @media screen and (max-width: 768px) {
            .reservation-page-header { flex-direction: column; align-items: stretch; }
            .search-input { width: 100%; }
            #addNewUserBtn { width: 100%; }
            .actions { flex-direction: column; }
            .btn.btn-small { width: 100%; justify-content: flex-start; }
            .permission-item { flex-direction: column; align-items: flex-start; text-align: center; gap: 10px; }
            .permission-icon { margin: 0 auto; }
            .permission-toggle { align-self: center; margin-top: 10px; }
        }
    </style>
</head>
<body>

    <div class="page-wrapper">

        <aside class="admin-sidebar">
            <div class="sidebar-header">
                <img src="Tavern.png" alt="Home Icon" class="home-icon">
            </div>
            <nav>
                 <ul class="sidebar-menu">
                    <li class="menu-item"><a href="admin.php"><i class="material-icons">dashboard</i> Dashboard</a></li>
                    <li class="menu-item"><a href="reservation.php"><i class="material-icons">event_note</i> Reservation</a></li>
                    <li class="menu-item"><a href="update.php"><i class="material-icons">file_upload</i> Upload Management</a></li>
                </ul>
                <div class="user-management-title">User Management</div>
                <ul class="sidebar-menu user-management-menu">
                    <li class="menu-item active"><a href="customer_database.php"><i class="material-icons">people</i> Customer Database</a></li>
                    <li class="menu-item"><a href="notification_control.php"><i class="material-icons">notifications</i> Notification Control</a></li>
                    <li class="menu-item"><a href="table_management.php"><i class="material-icons">table_chart</i> Calendar Management</a></li>
                    <li class="menu-item"><a href="reports.php"><i class="material-icons">analytics</i>Reservation Reports</a></li>
                    <li class="menu-item"><a href="deletion_history.php"><i class="material-icons">history</i> Archive</a></li>
                </ul>
            </nav>
        </aside>

        <div class="admin-content-area">
            <header class="main-header">
                <div class="header-content">
                    <h1 class="header-page-title">Customer Database</h1>
                    
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
                <div class="reservation-page-header">
                    <input type="text" id="userSearch" class="search-input" placeholder="Search customers by name, email, or role...">
                    <button id="addNewUserBtn" class="btn btn-primary"><i class="material-icons">person_add</i> Add New Customer</button>
                </div>

                <section class="all-reservations-section">
                    <div class="table-responsive">
                        <table>
                            <thead>
                                <tr>
                                    <th>USER ID</th>
                                    <th>USERNAME</th>
                                    <th>EMAIL</th>
                                    <th>DATE JOINED</th>
                                    <th>STATUS</th>
                                    <th>ROLE</th>
                                    <th>ACTIONS</th>
                                </tr>
                            </thead>
                            <tbody id="usersTableBody">
                                <?php if (empty($users)): ?>
                                    <tr><td colspan="7" style="text-align: center; color: #777;">No customers found.</td></tr>
                                <?php else: ?>
                                    <?php foreach ($users as $user): ?>
                                        <tr data-user-id="<?= $user['user_id']; ?>"
                                            data-username="<?= htmlspecialchars($user['username'], ENT_QUOTES); ?>"
                                            data-email="<?= htmlspecialchars($user['email'], ENT_QUOTES); ?>"
                                            data-permissions='<?= htmlspecialchars($user['permissions'] ?? '[]', ENT_QUOTES); ?>'>
                                            
                                            <td style="font-weight: 500;">#<?= sprintf('%04d', $user['user_id']); ?></td>
                                            <td style="font-weight: 600; color: #333;"><?= htmlspecialchars($user['username']); ?></td>
                                            <td style="color: #555;"><?= htmlspecialchars($user['email']); ?></td>
                                            <td style="color: #666; font-size: 13px;"><?= htmlspecialchars(date('M d, Y', strtotime($user['created_at']))); ?></td>
                                            <td>
                                                <?php if ($user['is_verified']): ?>
                                                    <span class="status-badge confirmed">Verified</span>
                                                <?php else: ?>
                                                    <span class="status-badge pending">Not Verified</span>
                                                <?php endif; ?>
                                            </td>
                                            <td class="role-cell <?= $user['role'] === 'manager' ? 'role-manager' : '' ?>">
                                                <?= htmlspecialchars(ucfirst($user['role'])); ?>
                                            </td>
                                            
                                            <td class="actions">
                                                <?php if (!$user['is_verified']): ?>
                                                    <button class="btn btn-small verify-btn" title="Mark as Verified"><i class="material-icons">verified</i> Verify</button>
                                                <?php endif; ?>
                                                <button class="btn btn-small view-edit-btn"><i class="material-icons">edit</i> Edit</button>
                                                <button class="btn btn-small delete-btn"><i class="material-icons">delete</i> Delete</button>
                                                
                                                <?php if ($user['role'] === 'manager'): ?>
                                                    <button class="btn btn-small edit-permissions-btn"><i class="material-icons">tune</i> Perms</button>
                                                    <button class="btn btn-small demote-user-btn"><i class="material-icons">arrow_downward</i> Demote</button>
                                                <?php else: ?>
                                                    <button class="btn btn-small promote-user-btn"><i class="material-icons">arrow_upward</i> Promote</button>
                                                <?php endif; ?>
                                            </td>

                                        </tr>
                                    <?php endforeach; ?>
                                <?php endif; ?>
                            </tbody>
                        </table>
                    </div>
                </section>
            </main>

            <div id="userModal" class="modal">
                <div class="modal-content">
                    <div class="modal-header">
                        <h2 id="modalTitle">Add New Customer</h2>
                        <button class="close-button">&times;</button>
                    </div>
                    <div class="modal-body">
                        <form id="userForm"> 
                            <input type="hidden" id="userId" name="user_id">
                            <div class="form-group">
                                <label for="username">Username</label>
                                <input type="text" id="username" name="username" placeholder="Enter username" required>
                            </div>
                            <div class="form-group">
                                <label for="email">Email</label>
                                <input type="email" id="email" name="email" placeholder="Enter email address" required>
                            </div>
                            <div class="form-group">
                                <label for="password">Password</label>
                                <input type="password" id="password" name="password" placeholder="Enter password">
                                <small id="passwordHelp">Leave blank to keep the current password.</small>
                            </div>
                            <div class="form-group">
                                <label for="retype_password">Retype Password</label>
                                <input type="password" id="retype_password" name="retype_password" placeholder="Confirm password">
                            </div>
                        </form>
                    </div>
                    <div class="modal-actions">
                        <button type="submit" class="btn modal-save-btn btn-primary" form="userForm"><i class="material-icons" style="font-size: 18px; margin-right: 5px; vertical-align: bottom;">save</i> Save Changes</button>
                    </div>
                </div>
            </div>
            
            <div id="managerPermissionsModal" class="modal">
                <div class="modal-content">
                    <div class="modal-header">
                        <h2 id="managerPermissionsTitle">Set Manager Permissions</h2>
                        <button class="close-button">&times;</button>
                    </div>
                    <div class="modal-body">
                        <form id="managerPermissionsForm">
                            <input type="hidden" id="managerUserId" name="user_id">
                            <input type="hidden" id="permissionAction" name="action" value="promote">
                            
                            <div class="permission-group">
                                <div class="permission-item">
                                    <div class="permission-icon"><i class="material-icons">event_note</i></div>
                                    <div class="permission-text">
                                        <label for="perm_manage_reservations">Manage Reservations</label>
                                        <p>Allow access to the Reservations page to view, confirm, decline, and cancel bookings.</p>
                                    </div>
                                    <div class="permission-toggle">
                                        <input type="checkbox" id="perm_manage_reservations" name="permissions[]" value="manage_reservations" class="toggle-switch">
                                        <label for="perm_manage_reservations"></label>
                                    </div>
                                </div>

                                <div class="permission-item">
                                    <div class="permission-icon"><i class="material-icons">file_upload</i></div>
                                    <div class="permission-text">
                                        <label for="perm_manage_uploads">Manage Uploads</label>
                                        <p>Allow access to the Upload Management page to add/delete hero slides, events, gallery, etc.</p>
                                    </div>
                                    <div class="permission-toggle">
                                        <input type="checkbox" id="perm_manage_uploads" name="permissions[]" value="manage_uploads" class="toggle-switch">
                                        <label for="perm_manage_uploads"></label>
                                    </div>
                                </div>
                                <div class="permission-item">
                                    <div class="permission-icon"><i class="material-icons">notifications</i></div>
                                    <div class="permission-text">
                                        <label for="perm_access_notifications">Access Notifications</label>
                                        <p>Allow access to the Notification Control page to view and reply to customer messages.</p>
                                    </div>
                                    <div class="permission-toggle">
                                        <input type="checkbox" id="perm_access_notifications" name="permissions[]" value="access_notifications" class="toggle-switch">
                                        <label for="perm_access_notifications"></label>
                                    </div>
                                </div>

                                <div class="permission-item">
                                    <div class="permission-icon"><i class="material-icons">table_chart</i></div>
                                    <div class="permission-text">
                                        <label for="perm_access_tables">Manage Calendar</label>
                                        <p>Allow access to the Calendar Management page to block and unblock dates.</p>
                                    </div>
                                    <div class="permission-toggle">
                                        <input type="checkbox" id="perm_access_tables" name="permissions[]" value="access_tables" class="toggle-switch">
                                        <label for="perm_access_tables"></label>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="modal-actions">
                        <button type="button" class="btn" id="cancelPermissionsBtn" style="background-color: #f3f4f6; color: #4b5563; border: 1px solid #d1d5db;">Cancel</button>
                        <button type="submit" class="btn modal-save-btn btn-primary" id="permissionSubmitBtn" form="managerPermissionsForm"><i class="material-icons" style="font-size: 18px; margin-right: 5px; vertical-align: bottom;">check_circle</i> Save & Promote</button>
                    </div>
                </div>
            </div>

            <div id="alertModal" class="modal">
                <div class="modal-content" style="max-width: 400px; text-align: center;">
                    <div class="modal-header" style="padding: 30px 20px 0; border: none; justify-content: flex-end;">
                        <button class="close-button" style="position: absolute; top: 15px; right: 15px;">&times;</button>
                    </div>
                    <div class="modal-body" style="padding: 0 30px 20px;">
                        <div id="modalHeaderIcon" class="modal-header-icon" style="margin-bottom: 15px;"></div>
                        <h2 id="alertModalTitle" style="margin-top: 0; margin-bottom: 12px; font-size: 22px; color: #333;"></h2>
                        <p id="alertModalMessage" style="margin-bottom: 0; color: #666; font-size: 15px;"></p>
                    </div>
                    <div id="alertModalActions" class="modal-actions" style="justify-content: center; padding: 20px 30px 30px; border-top: none; background: #fff;">
                    </div>
                </div>
            </div>

        </div>
    </div>


    <script src="JS/customer_database.js"></script>
    <script>
    document.addEventListener('DOMContentLoaded', () => {
        
        const notificationModal = document.getElementById('alertModal');
        const modalHeaderIcon = document.getElementById('modalHeaderIcon'); 
        const modalTitle = document.getElementById('alertModalTitle');
        const modalMessage = document.getElementById('alertModalMessage');
        const modalActions = document.getElementById('alertModalActions');
        const notificationCloseButton = notificationModal ? notificationModal.querySelector('.close-button') : null;
        let notificationCallback = null;

        function showNotification(type, title, message, callback = null) {
            if (!notificationModal || !modalTitle || !modalMessage || !modalActions) {
                alert(message);
                return;
            }
            
            modalHeaderIcon.innerHTML = (type === 'success' ? '<i class="material-icons" style="color: #28a745; font-size: 60px;">check_circle_outline</i>' : '<i class="material-icons" style="color: #dc3545; font-size: 60px;">error_outline</i>');
            modalTitle.textContent = title;
            modalMessage.textContent = message;
            
            modalActions.innerHTML = '<button class="btn modal-close-btn btn-primary" style="padding: 10px 30px; border-radius: 20px;">OK</button>';
            
            const okButton = modalActions.querySelector('.modal-close-btn');
            
            notificationCallback = callback;
            
            const closeModal = () => {
                notificationModal.style.display = 'none';
                if(notificationCallback) notificationCallback();
                notificationCallback = null;
            };

            if(okButton) okButton.onclick = closeModal;
            if(notificationCloseButton) notificationCloseButton.onclick = closeModal;

            notificationModal.style.display = 'flex';
        }
        
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

        if(messageBtn) {
            messageBtn.addEventListener('click', (e) => {
                e.stopPropagation();
                if(reservationDropdown) reservationDropdown.classList.remove('show');
                if(adminProfileDropdown) adminProfileDropdown.classList.remove('show'); 
                if(messageDropdown) messageDropdown.classList.toggle('show');
            });
        }

        if(reservationBtn) {
            reservationBtn.addEventListener('click', (e) => {
                e.stopPropagation();
                if(messageDropdown) messageDropdown.classList.remove('show');
                if(adminProfileDropdown) adminProfileDropdown.classList.remove('show'); 
                if(reservationDropdown) reservationDropdown.classList.toggle('show');
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
            if(messageDropdown) messageDropdown.classList.remove('show');
            if(reservationDropdown) reservationDropdown.classList.remove('show');
            if(adminProfileDropdown) adminProfileDropdown.classList.remove('show'); 
        });
        
        [messageDropdown, reservationDropdown, adminProfileDropdown].forEach(dropdown => {
           if(dropdown) {
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
                    showNotification('error', 'Action Failed', result.message);
                }
            } catch (error) {
                console.error('Error dismissing notification:', error);
                showNotification('error', 'Error', 'An error occurred. Please try again.');
            }
        }

        if(messageDropdown) messageDropdown.addEventListener('click', handleDismiss);
        if(reservationDropdown) reservationDropdown.addEventListener('click', handleDismiss);

        fetchAdminNotifications();
        setInterval(fetchAdminNotifications, 30000);
    });
    </script>
</body>
</html>