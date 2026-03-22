<?php
session_start();
require_once 'db_connect.php'; 

// Check if the user is logged in AND is an admin or manager
if (!isset($_SESSION['loggedin']) || $_SESSION['loggedin'] !== true || !isset($_SESSION['role']) || !in_array($_SESSION['role'], ['owner', 'manager'])) {
    header('Location: login.php'); 
    exit;
}

// Get the current page name for active link highlighting
$currentPage = basename($_SERVER['SCRIPT_NAME']);

// Fetch all reservations from the database, including new fields
$allReservations = [];
$sql = "SELECT r.reservation_id, r.user_id, r.res_date, r.res_time, r.num_guests,
        r.res_name, r.res_phone, r.res_email, r.status, r.created_at,
        r.reservation_type, r.valid_id_path,
        r.applied_coupon_code,
        r.action_by, 
        r.special_requests,
        u.avatar
        FROM reservations r
        LEFT JOIN users u ON r.user_id = u.user_id
        WHERE r.deleted_at IS NULL
        ORDER BY r.created_at DESC";

if ($result = mysqli_query($link, $sql)) {
    while ($row = mysqli_fetch_assoc($result)) {
        $allReservations[] = $row;
    }
    mysqli_free_result($result);
} else {
    error_log("Reservation page database error: " . mysqli_error($link));
}

mysqli_close($link);
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tavern Publico - All Reservations</title>
    <link rel="stylesheet" href="CSS/admin.css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <style>
        /* --- ENHANCED & RESPONSIVE UI STYLING --- */
        .reservation-page-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 25px; flex-wrap: wrap; gap: 15px; background: #fff; padding: 20px; border-radius: 10px; box-shadow: 0 4px 15px rgba(0,0,0,0.03); border: 1px solid #eaedf1; }
        .header-controls { display: flex; align-items: center; gap: 15px; flex-wrap: wrap; flex: 1; }
        .search-input { padding: 12px 20px; border: 1px solid #d1d5db; border-radius: 25px; width: 320px; max-width: 100%; font-size: 14px; outline: none; transition: border-color 0.3s, box-shadow 0.3s; background-color: #f8f9fa; }
        .search-input:focus { border-color: #007bff; box-shadow: 0 0 0 3px rgba(0, 123, 255, 0.15); background-color: #fff; }
        .sort-by-status label { font-weight: 600; color: #444; font-size: 14px; margin-right: 8px; }
        .sort-by-status select { padding: 10px 15px; border: 1px solid #d1d5db; border-radius: 20px; background-color: #f8f9fa; font-size: 14px; cursor: pointer; outline: none; transition: border-color 0.3s, box-shadow 0.3s; }
        .sort-by-status select:focus { border-color: #007bff; box-shadow: 0 0 0 3px rgba(0, 123, 255, 0.15); background-color: #fff; }
        .table-responsive { width: 100%; overflow-x: auto; -webkit-overflow-scrolling: touch; background: #fff; border-radius: 10px; box-shadow: 0 4px 15px rgba(0,0,0,0.03); border: 1px solid #eaedf1; }
        table { width: 100%; border-collapse: collapse; min-width: 1000px; }
        table th, table td { padding: 16px 20px; text-align: left; border-bottom: 1px solid #eaedf1; vertical-align: middle; }
        table th { background-color: #f8f9fa; font-weight: 600; color: #495057; font-size: 13px; text-transform: uppercase; letter-spacing: 0.5px; }
        table tbody tr { transition: background-color 0.2s; }
        table tbody tr:hover { background-color: #fcfdfd; }
        .customer-info { display: flex; align-items: center; gap: 12px; }
        .customer-avatar { width: 40px; height: 40px; border-radius: 50%; object-fit: cover; border: 1px solid #eee; }
        .customer-info strong { color: #333; font-size: 14px; }
        .customer-info small { color: #777; font-size: 13px; }
        .status-badge { padding: 6px 14px; border-radius: 20px; font-size: 12px; font-weight: 600; display: inline-block; text-align: center; }
        .status-badge.confirmed { background-color: #d1e7dd; color: #0f5132; }
        .status-badge.pending { background-color: #fff3cd; color: #856404; }
        .status-badge.cancelled { background-color: #f8d7da; color: #842029; }
        .status-badge.declined { background-color: #e2e3e5; color: #41464b; }
        .actions { display: flex; gap: 8px; flex-wrap: wrap; }
        .btn { border: none; padding: 10px 18px; border-radius: 6px; cursor: pointer; font-size: 14px; font-weight: 500; transition: all 0.2s; display: inline-flex; align-items: center; justify-content: center; text-decoration: none;}
        .btn i { font-size: 18px; margin-right: 6px; }
        .btn-small { padding: 6px 12px; font-size: 13px; }
        .btn-small i { font-size: 16px; margin-right: 4px; }
        .btn-primary { background-color: #28a745; color: white; box-shadow: 0 4px 6px rgba(40,167,69,0.2); }
        .btn-primary:hover { background-color: #218838; transform: translateY(-1px); }
        .view-edit-btn { background-color: #e0f2fe; color: #0284c7; }
        .view-edit-btn:hover { background-color: #bae6fd; }
        .delete-btn { background-color: #fee2e2; color: #991b1b; }
        .delete-btn:hover { background-color: #fecaca; }
        .modal { display: none; position: fixed; z-index: 2000; left: 0; top: 0; width: 100%; height: 100%; background-color: rgba(0,0,0,0.5); align-items: center; justify-content: center; padding: 15px; }
        .modal-content { background-color: #fff; border-radius: 12px; width: 100%; max-width: 600px; box-shadow: 0 10px 30px rgba(0,0,0,0.2); display: flex; flex-direction: column; overflow: hidden; max-height: 90vh; }
        .modal-header { padding: 20px 25px; border-bottom: 1px solid #eee; display: flex; justify-content: space-between; align-items: center; background-color: #fafbfc; }
        .modal-header h2 { margin: 0; font-size: 18px; color: #2c3e50; font-weight: 700; }
        .modal-body { padding: 25px; overflow-y: auto; }
        .modal-actions { padding: 20px 25px; border-top: 1px solid #eee; display: flex; justify-content: flex-end; gap: 10px; background-color: #fafbfc; }
        .close-button { font-size: 24px; color: #999; cursor: pointer; background: none; border: none; padding: 0; line-height: 1; transition: color 0.2s; }
        .close-button:hover { color: #333; }
        #editReservationForm, #addReservationForm { display: grid; grid-template-columns: 1fr 1fr; gap: 15px; }
        .form-group { margin-bottom: 0; }
        .form-group.full-width { grid-column: 1 / -1; }
        .form-group label { display: block; margin-bottom: 8px; font-weight: 600; color: #444; font-size: 13px; }
        .form-group input, .form-group select, .form-group textarea { width: 100%; padding: 10px 14px; border: 1px solid #d1d5db; border-radius: 6px; font-family: inherit; font-size: 14px; box-sizing: border-box; transition: border-color 0.2s; background: #fdfdfd; }
        .form-group input:focus, .form-group select:focus, .form-group textarea:focus { border-color: #007bff; outline: none; box-shadow: 0 0 0 3px rgba(0,123,255,0.1); background: #fff;}
        .form-group input[readonly] { background-color: #e9ecef; cursor: not-allowed; color: #666; }
        .form-group textarea { resize: vertical; min-height: 80px; }
        #validIdDisplay img { max-width: 100%; border-radius: 8px; border: 1px solid #eee; margin-top: 10px; }
        .pagination-container { display: flex; justify-content: center; align-items: center; margin-top: 25px; padding: 10px 0; gap: 8px; flex-wrap: wrap; }
        #pageNumbers { display: flex; gap: 6px; flex-wrap: wrap; }
        .page-number { padding: 8px 14px; border: 1px solid #dee2e6; border-radius: 6px; cursor: pointer; transition: all 0.2s; background-color: #fff; color: #495057; font-weight: 500; font-size: 14px; }
        .page-number:hover { background-color: #e9ecef; color: #212529; }
        .page-number.active { background-color: #007bff; color: white; border-color: #007bff; font-weight: 600; }
        .pagination-container .btn:disabled { background-color: #f8f9fa; color: #adb5bd; border: 1px solid #dee2e6; cursor: not-allowed; }
        @media screen and (max-width: 768px) {
            .reservation-page-header { flex-direction: column; align-items: stretch; }
            .header-controls { flex-direction: column; align-items: stretch; width: 100%; }
            .search-input { width: 100%; }
            .sort-by-status { flex-direction: column; align-items: flex-start; }
            .sort-by-status select { width: 100%; }
            #addReservationBtn { width: 100%; }
            #editReservationForm, #addReservationForm { grid-template-columns: 1fr; }
            .actions { flex-direction: column; }
            .btn.btn-small { width: 100%; justify-content: flex-start; }
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
                <div class="sidebar-header">
                    <img src="Tavern.png" alt="Home Icon" class="home-icon">
                </div>
                <nav>
                    <ul class="sidebar-menu">
                        <li class="menu-item"><a href="admin.php"><i class="material-icons">dashboard</i> Dashboard</a></li>
                        <li class="menu-item active"><a href="reservation.php"><i class="material-icons">event_note</i> Reservation</a></li>
                        <li class="menu-item"><a href="update.php"><i class="material-icons">file_upload</i> Upload Management</a></li>
                    </ul>
                    <div class="user-management-title">User Management</div>
                    <ul class="sidebar-menu user-management-menu">
                       <li class="menu-item"><a href="customer_database.php"><i class="material-icons">people</i> Customer Database</a></li>
                       <li class="menu-item"><a href="notification_control.php"><i class="material-icons">notifications</i> Notification Control</a></li>
                        <li class="menu-item"><a href="table_management.php"><i class="material-icons">table_chart</i>Calendar Management</a></li>
                        <li class="menu-item"><a href="reports.php"><i class="material-icons">analytics</i>Reservation Reports</a></li>
                        <li class="menu-item"><a href="deletion_history.php"><i class="material-icons">history</i>Archive</a></li>
                    </ul>
                </nav>
            </aside>
        <?php
        }
        ?>

        <div class="admin-content-area">
            <header class="main-header">
                <div class="header-content">
                    <h1 class="header-page-title">All Reservations</h1>
                    
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
                    <div class="header-controls">
                        <input type="text" id="reservationSearch" class="search-input" placeholder="Search customer, email, etc...">
                        
                        <div class="sort-by-status">
                            <label for="typeSort">Type:</label>
                            <select id="typeSort" class="form-control">
                                <option value="all">All Types</option>
                                <option value="Dine-in">Dine-in</option>
                                <option value="Private Event">Private Event</option>
                                <option value="Special Occasion">Special Occasion</option>
                            </select>
                        </div>

                        <div class="sort-by-status">
                            <label for="statusSort">Status:</label>
                            <select id="statusSort" class="form-control">
                                <option value="all">All Statuses</option>
                                <option value="Pending">Pending</option>
                                <option value="Confirmed">Confirmed</option>
                                <option value="Cancelled">Cancelled</option>
                                <option value="Declined">Declined</option>
                            </select>
                        </div>
                    </div>
                    <button id="addReservationBtn" class="btn btn-primary"><i class="material-icons">add_circle</i> Add Reservation</button>
                </div>

                <section class="all-reservations-section">
                    <div class="table-responsive">
                        <table>
                            <thead>
                                <tr>
                                    <th>CUSTOMER</th>
                                    <th>DATE & TIME</th>
                                    <th>GUESTS</th>
                                    <th>TYPE</th>
                                    <th>STATUS</th>
                                    <th>BOOKED AT</th>
                                    <th>ACTION BY</th> 
                                    <th>ACTIONS</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php if (empty($allReservations)): ?>
                                    <tr><td colspan="8" style="text-align: center; color: #777;">No reservations found.</td></tr>
                                <?php else: ?>
                                    <?php foreach ($allReservations as $reservation): ?>
                                        <?php
                                            $statusClass = strtolower($reservation['status']);
                                            $fullReservationData = [
                                                'reservation_id' => $reservation['reservation_id'], 'user_id' => $reservation['user_id'] ?? 'N/A',
                                                'res_date' => $reservation['res_date'], 'res_time' => $reservation['res_time'],
                                                'num_guests' => $reservation['num_guests'], 'res_name' => $reservation['res_name'],
                                                'res_phone' => $reservation['res_phone'], 'res_email' => $reservation['res_email'],
                                                'status' => $reservation['status'], 'created_at' => $reservation['created_at'],
                                                'reservation_type' => $reservation['reservation_type'],
                                                'valid_id_path' => $reservation['valid_id_path'],
                                                'applied_coupon_code' => $reservation['applied_coupon_code'] ?? null,
                                                'special_requests' => $reservation['special_requests'] ?? null,
                                                'action_by' => $reservation['action_by'] ?? null 
                                            ];
                                            $fullReservationJson = htmlspecialchars(json_encode($fullReservationData), ENT_QUOTES, 'UTF-8');
                                        ?>
                                        <tr data-reservation-id="<?php echo $reservation['reservation_id']; ?>"
                                            data-full-reservation='<?php echo $fullReservationJson; ?>'
                                            data-status="<?php echo htmlspecialchars($reservation['status']); ?>"
                                            data-type="<?php echo htmlspecialchars($reservation['reservation_type'] ?? 'Dine-in'); ?>">
                                            <td>
                                                <?php
                                                $avatar_path = !empty($reservation['avatar']) && file_exists($reservation['avatar']) ? $reservation['avatar'] : 'images/default_avatar.png';

                                                $customer_info_html = '
                                                    <div class="customer-info">
                                                        <img src="' . htmlspecialchars($avatar_path) . '" alt="Customer Avatar" class="customer-avatar">
                                                        <div>
                                                            <strong>' . htmlspecialchars($reservation['res_name']) . '</strong><br>
                                                            <small>' . htmlspecialchars($reservation['res_email']) . '</small>
                                                        </div>
                                                    </div>';

                                                if (!empty($reservation['user_id'])) {
                                                    echo '<a href="view_customer.php?id=' . $reservation['user_id'] . '&return_to=reservation" style="text-decoration: none; color: inherit;">' . $customer_info_html . '</a>';
                                                } else {
                                                    echo $customer_info_html;
                                                }
                                                ?>
                                            </td>
                                            <td>
                                                <span style="font-weight: 500; color: #333;"><?php echo htmlspecialchars(date('M d, Y', strtotime($reservation['res_date']))); ?></span><br>
                                                <small style="color: #666;"><i class="material-icons" style="font-size: 12px; vertical-align: text-bottom;">access_time</i> <?php echo htmlspecialchars(date('g:i A', strtotime($reservation['res_time']))); ?></small>
                                            </td>
                                            <td style="font-weight: 600; text-align: center;"><?php echo htmlspecialchars($reservation['num_guests']); ?></td>
                                            <td style="color: #555;"><?php echo htmlspecialchars($reservation['reservation_type'] ?? 'Dine-in'); ?></td>
                                            <td><span class="status-badge <?php echo $statusClass; ?>"><?php echo htmlspecialchars($reservation['status']); ?></span></td>
                                            <td style="color: #666; font-size: 13px;"><?php echo htmlspecialchars(date('M d, Y H:i', strtotime($reservation['created_at']))); ?></td>
                                            <td style="color: #555;"><?php echo htmlspecialchars($reservation['action_by'] ?? 'N/A'); ?></td>
                                            <td class="actions">
                                                <button class="btn btn-small view-edit-btn"><i class="material-icons">edit</i> Edit</button>
                                                <button class="btn btn-small delete-btn"><i class="material-icons">delete</i> Delete</button>
                                            </td>
                                        </tr>
                                    <?php endforeach; ?>
                                <?php endif; ?>
                            </tbody>
                        </table>
                    </div>
                    <div class="pagination-container">
                        <button class="btn" id="prevPageBtn" disabled>&laquo; Prev</button>
                        <div id="pageNumbers"></div>
                        <button class="btn" id="nextPageBtn">Next &raquo;</button>
                    </div>
                </section>
            </main>

            <div id="reservationModal" class="modal">
                <div class="modal-content">
                    <div class="modal-header">
                        <h2 id="modal-title-h2">Reservation Details</h2>
                        <button class="close-button">&times;</button>
                    </div>
                    <div class="modal-body">
                        <form id="editReservationForm">
                            <input type="hidden" id="modalReservationId" name="reservation_id">
                            <div class="form-group full-width" style="border-bottom: 2px solid #f1f3f5; padding-bottom: 10px; margin-bottom: 10px;">
                                <h3 style="margin:0; font-size: 16px; color: #0284c7;">Customer Details</h3>
                            </div>
                            <div class="form-group"><label for="modalResName">Customer Name:</label><input type="text" id="modalResName" name="res_name" required></div>
                            <div class="form-group"><label for="modalResEmail">Email Address:</label><input type="email" id="modalResEmail" name="res_email" required></div>
                            <div class="form-group"><label for="modalResPhone">Phone Number:</label><input type="tel" id="modalResPhone" name="res_phone"></div>
                            
                            <div class="form-group full-width" style="border-bottom: 2px solid #f1f3f5; padding-bottom: 10px; margin-top: 10px; margin-bottom: 10px;">
                                <h3 style="margin:0; font-size: 16px; color: #0284c7;">Booking Info</h3>
                            </div>
                            <div class="form-group"><label for="modalResDate">Date:</label><input type="date" id="modalResDate" name="res_date" required></div>
                            <div class="form-group"><label for="modalResTime">Time:</label><input type="time" id="modalResTime" name="res_time" required></div>
                            <div class="form-group"><label for="modalNumGuests">Number of Guests:</label><input type="number" id="modalNumGuests" name="num_guests" min="1" required></div>
                            <div class="form-group">
                                <label for="modalReservationType">Reservation Type:</label>
                                <select id="modalReservationType" name="reservation_type">
                                    <option value="Dine-in">Dine-in</option>
                                    <option value="Private Event">Private Event</option>
                                    <option value="Special Occasion">Special Occasion</option>
                                </select>
                            </div>
                            <div class="form-group"><label for="modalStatus">Status:</label>
                                <select id="modalStatus" name="status">
                                    <option value="Pending">Pending</option>
                                    <option value="Confirmed">Confirmed</option>
                                    <option value="Cancelled">Cancelled</option>
                                    <option value="Declined">Declined</option>
                                </select>
                            </div>

                            <div class="form-group"><label for="modalCreatedAt">Booked At:</label><input type="text" id="modalCreatedAt" name="created_at" readonly></div>
                            <div class="form-group"><label for="modalActionBy">Last Action By:</label><input type="text" id="modalActionBy" name="action_by" readonly></div>
                            
                            <div class="form-group full-width">
                                <label for="modalSpecialRequests">Special Requests / Comments:</label>
                                <textarea id="modalSpecialRequests" name="special_requests" placeholder="Customer comments or requests..."></textarea>
                            </div>
                            
                            <div class="form-group full-width" id="validIdGroup"> 
                                <label>Uploaded ID (If applicable):</label>
                                <div id="validIdDisplay" style="background: #f8f9fa; padding: 10px; border-radius: 6px; text-align: center; margin-bottom: 10px;">
                                </div>

                                <div id="editIdSection" style="padding: 15px; border: 1px dashed #cbd5e1; border-radius: 6px; background: #f8fafc;">
                                    <label style="font-size: 14px; color: #334155; display: block; margin-bottom: 8px; font-weight: 600;">Update/Upload New ID</label>
                                    <input type="file" id="newValidId" name="new_valid_id" accept="image/*,.pdf" style="margin-bottom: 5px; background: #fff;">
                                    <small style="color: #64748b; display: block; margin-top: 5px;">* Leave file empty if you are not changing the ID.</small>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="modal-actions">
                        <button type="button" class="btn delete-btn modal-delete-btn" style="margin-right: auto;"><i class="material-icons">delete</i> Delete</button>
                        <button type="button" class="btn" style="background-color: #f1f5f9; color: #475569;" onclick="document.getElementById('reservationModal').style.display='none'">Cancel</button>
                        <button type="submit" class="btn btn-primary modal-save-btn" form="editReservationForm"><i class="material-icons" style="font-size: 18px; margin-right: 5px;">save</i> Save</button>
                    </div>
                </div>
            </div>

            <div id="addReservationModal" class="modal">
                <div class="modal-content">
                    <div class="modal-header">
                        <h2>Add Walk-in Reservation</h2>
                        <button class="close-button">&times;</button>
                    </div>
                    <div class="modal-body">
                        <form id="addReservationForm">
                            <div class="form-group full-width" style="border-bottom: 2px solid #f1f3f5; padding-bottom: 10px; margin-bottom: 10px;">
                                <h3 style="margin:0; font-size: 16px; color: #0284c7;">Customer Details</h3>
                            </div>
                            <div class="form-group"><label for="addResName">Customer Name:</label><input type="text" id="addResName" name="res_name" required></div>
                            <div class="form-group"><label for="addResEmail">Email Address:</label><input type="email" id="addResEmail" name="res_email" required></div>
                            <div class="form-group full-width"><label for="addResPhone">Phone Number:</label><input type="tel" id="addResPhone" name="res_phone" required></div>
                            
                            <div class="form-group full-width" style="border-bottom: 2px solid #f1f3f5; padding-bottom: 10px; margin-top: 10px; margin-bottom: 10px;">
                                <h3 style="margin:0; font-size: 16px; color: #0284c7;">Booking Info</h3>
                            </div>
                            <div class="form-group"><label for="addResDate">Date:</label><input type="date" id="addResDate" name="res_date" required></div>
                            <div class="form-group"><label for="addResTime">Time:</label><input type="time" id="addResTime" name="res_time" required></div>
                            <div class="form-group"><label for="addNumGuests">Number of Guests:</label><input type="number" id="addNumGuests" name="num_guests" min="1" required></div>
                            <div class="form-group">
                                <label for="addReservationType">Reservation Type:</label>
                                <select id="addReservationType" name="reservation_type">
                                    <option value="Dine-in">Dine-in</option>
                                    <option value="Private Event">Private Event</option>
                                    <option value="Special Occasion">Special Occasion</option>
                                </select>
                            </div>
                            <div class="form-group full-width">
                                <label for="addSpecialRequests">Special Requests / Notes (Optional):</label>
                                <textarea id="addSpecialRequests" name="special_requests" placeholder="e.g., high chair, window seat..."></textarea>
                            </div>
                        </form>
                    </div>
                    <div class="modal-actions">
                        <button type="button" class="btn" style="background-color: #f1f5f9; color: #475569;" onclick="document.getElementById('addReservationModal').style.display='none'">Cancel</button>
                        <button type="submit" class="btn btn-primary modal-save-btn" form="addReservationForm"><i class="material-icons">add_circle</i> Add</button>
                    </div>
                </div>
            </div>

            <div id="confirmDeleteModal" class="modal">
                <div class="modal-content" style="max-width: 420px; text-align: center;">
                    <div class="modal-header" style="border:none; justify-content: flex-end; padding-bottom: 0;">
                        <button class="close-button">&times;</button>
                    </div>
                    <div class="modal-body" style="padding-top: 0;">
                        <i class="material-icons" style="font-size: 60px; color: #f5b301; margin-bottom: 15px;">help_outline</i>
                        <h2 id="modal-title-h2" style="margin-bottom: 10px;">Confirm Deletion</h2>
                        <p style="color: #666;">Move this reservation to the deletion history? It can be restored within 30 days.</p>
                    </div>
                    <div class="modal-actions" style="justify-content: center; background: #fff; border-top:none;">
                        <button type="button" class="btn" id="cancelDeleteBtn" style="background-color: #f1f5f9; color: #475569;">Cancel</button>
                        <button type="button" class="btn delete-btn" id="confirmDeleteBtn">Yes, Delete</button>
                    </div>
                </div>
            </div>

            <div id="notificationModal" class="modal">
                <div class="modal-content" style="max-width: 400px; text-align: center;">
                    <div class="modal-header" style="border:none; justify-content: flex-end; padding-bottom: 0;">
                        <button class="close-button">&times;</button>
                    </div>
                    <div class="modal-body" style="padding-top: 0;">
                        <div id="modalHeaderIcon" class="modal-header-icon" style="margin-bottom: 15px;"></div>
                        <h2 id="modalTitle" style="margin-bottom: 12px; font-size: 22px; color: #333;"></h2>
                        <p id="modalMessage" style="color: #666;"></p>
                    </div>
                    <div class="modal-actions" style="justify-content: center; background: #fff; border-top:none;">
                        <button class="btn btn-primary modal-close-btn" style="padding: 10px 30px; border-radius: 20px;">OK</button>
                    </div>
                </div>
            </div>

            <div id="imageIdModal" class="modal" style="background-color: rgba(0, 0, 0, 0.9); z-index: 3000;">
                <button class="close-button close-image-modal" style="color: #fff; font-size: 40px; position: absolute; top: 20px; right: 35px; background: none; border: none; cursor: pointer;">&times;</button>
                <img class="modal-content image-modal-content" id="modalImageContent" style="max-width: 90%; max-height: 85vh; padding: 0; border-radius: 8px; box-shadow: 0 10px 30px rgba(0,0,0,0.5); border: none;">
            </div>

        </div>
    </div>

    <script src="JS/reservation.js"></script>
</body>
</html>