<?php
error_reporting(E_ALL);
ini_set('display_errors', 0); 
ini_set('log_errors', 1);

session_start();
require_once 'db_connect.php';

header('Content-Type: application/json');
$response = ['success' => false, 'message' => 'An unknown error occurred.'];

// Authorization check
$is_authorized = false;
if (isset($_SESSION['loggedin']) && $_SESSION['loggedin'] === true) {
    if (isset($_SESSION['is_admin']) && $_SESSION['is_admin'] === true) {
        $is_authorized = true;
    } elseif (isset($_SESSION['role']) && $_SESSION['role'] === 'manager') {
        $manager_permissions = $_SESSION['permissions'] ?? [];
        if (is_array($manager_permissions) && in_array('manage_reservations', $manager_permissions)) {
            $is_authorized = true;
        }
    }
}

if (!$is_authorized) {
    $response['message'] = 'Unauthorized access. You do not have permission to perform this action.';
    echo json_encode($response);
    exit;
}

// Get the username of the admin/manager performing the action
$action_by_username = $_SESSION['username'] ?? 'System';

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $action = $_POST['action'] ?? null;
    
    if ($action === 'create') {
        $res_name = htmlspecialchars(trim($_POST['res_name'] ?? ''));
        $res_email = filter_var(trim($_POST['res_email'] ?? ''), FILTER_SANITIZE_EMAIL);
        $res_phone = htmlspecialchars(trim($_POST['res_phone'] ?? ''));
        $res_date = htmlspecialchars(trim($_POST['res_date'] ?? ''));
        $res_time = htmlspecialchars(trim($_POST['res_time'] ?? ''));
        $num_guests = filter_var(trim($_POST['num_guests'] ?? ''), FILTER_SANITIZE_NUMBER_INT);
        $reservation_type = htmlspecialchars(trim($_POST['reservation_type'] ?? 'Dine-in'));
        $status = "Confirmed"; 
        $source = "Walk-in";
        $special_requests = !empty($_POST['special_requests']) ? htmlspecialchars(trim($_POST['special_requests'])) : null;
        
        $sql = "INSERT INTO reservations (res_name, res_email, res_phone, res_date, res_time, num_guests, reservation_type, status, source, action_by, special_requests) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        if ($stmt = mysqli_prepare($link, $sql)) {
            mysqli_stmt_bind_param($stmt, "sssssisssss", $res_name, $res_email, $res_phone, $res_date, $res_time, $num_guests, $reservation_type, $status, $source, $action_by_username, $special_requests);
            if (mysqli_stmt_execute($stmt)) {
                $response['success'] = true;
                $response['message'] = 'Walk-in reservation added successfully.';
            } else {
                $response['message'] = 'Database error: Could not add reservation.';
                error_log("Create reservation error: " . mysqli_stmt_error($stmt));
            }
            mysqli_stmt_close($stmt);
        } else {
            $response['message'] = 'Database error: Could not prepare statement for creation.';
            error_log("Prepare create statement error: " . mysqli_error($link));
        }
    }
    elseif ($action === 'update') {
        $reservation_id = filter_input(INPUT_POST, 'reservation_id', FILTER_SANITIZE_NUMBER_INT);
        if(empty($reservation_id)) {
             $response['message'] = 'Missing reservation ID for update.';
             echo json_encode($response);
             exit;
        }

        $res_name = htmlspecialchars(trim($_POST['res_name'] ?? ''));
        $res_email = filter_var(trim($_POST['res_email'] ?? ''), FILTER_SANITIZE_EMAIL);
        $res_phone = htmlspecialchars(trim($_POST['res_phone'] ?? ''));
        $res_date = htmlspecialchars(trim($_POST['res_date'] ?? ''));
        $res_time = htmlspecialchars(trim($_POST['res_time'] ?? ''));
        $num_guests = filter_var(trim($_POST['num_guests'] ?? ''), FILTER_SANITIZE_NUMBER_INT);
        $status = htmlspecialchars(trim($_POST['status'] ?? ''));
        $special_requests = !empty($_POST['special_requests']) ? htmlspecialchars(trim($_POST['special_requests'])) : null;
        $reservation_type = htmlspecialchars(trim($_POST['reservation_type'] ?? 'Dine-in'));

        if (empty($res_name) || empty($res_email) || empty($res_date) || empty($res_time) || empty($num_guests) || empty($status)) {
            $response['message'] = 'Missing required fields for update.';
            echo json_encode($response);
            exit;
        }

        $new_valid_id_path = null;

        // --- HANDLE UPLOADED ID (Password Requirement Removed) ---
        if (isset($_FILES['new_valid_id']) && $_FILES['new_valid_id']['error'] === UPLOAD_ERR_OK) {
            
            $upload_dir = 'uploads/valid_ids/';
            if (!is_dir($upload_dir)) {
                mkdir($upload_dir, 0755, true);
            }

            $file_extension = strtolower(pathinfo($_FILES['new_valid_id']['name'], PATHINFO_EXTENSION));
            $allowed_extensions = ['jpg', 'jpeg', 'png', 'gif', 'pdf'];

            if (in_array($file_extension, $allowed_extensions)) {
                $new_filename = uniqid('id_') . '.' . $file_extension;
                $target_file = $upload_dir . $new_filename;

                if (move_uploaded_file($_FILES['new_valid_id']['tmp_name'], $target_file)) {
                    $new_valid_id_path = $target_file;
                } else {
                    $response['message'] = 'Server Error: Failed to save the uploaded ID file.';
                    echo json_encode($response);
                    exit;
                }
            } else {
                $response['message'] = 'Invalid file type. Only JPG, PNG, GIF, and PDF are allowed.';
                echo json_encode($response);
                exit;
            }
        }

        // --- Execute the Update Statement ---
        $stmt = null;
        if ($new_valid_id_path !== null) {
            $sql = "UPDATE reservations SET res_name = ?, res_email = ?, res_phone = ?, res_date = ?, res_time = ?, num_guests = ?, status = ?, action_by = ?, special_requests = ?, valid_id_path = ?, reservation_type = ? WHERE reservation_id = ?";
            $stmt = mysqli_prepare($link, $sql);
            if ($stmt) {
                mysqli_stmt_bind_param($stmt, "sssssisssssi", $res_name, $res_email, $res_phone, $res_date, $res_time, $num_guests, $status, $action_by_username, $special_requests, $new_valid_id_path, $reservation_type, $reservation_id);
            }
        } else {
            $sql = "UPDATE reservations SET res_name = ?, res_email = ?, res_phone = ?, res_date = ?, res_time = ?, num_guests = ?, status = ?, action_by = ?, special_requests = ?, reservation_type = ? WHERE reservation_id = ?";
            $stmt = mysqli_prepare($link, $sql);
            if ($stmt) {
                mysqli_stmt_bind_param($stmt, "sssssissssi", $res_name, $res_email, $res_phone, $res_date, $res_time, $num_guests, $status, $action_by_username, $special_requests, $reservation_type, $reservation_id);
            }
        }

        if ($stmt) {
            if (mysqli_stmt_execute($stmt)) {
                $response['success'] = true;
                $response['message'] = 'Reservation updated successfully.';
            } else {
                $response['message'] = 'Database error: Could not update reservation.';
                error_log("Update reservation error: " . mysqli_stmt_error($stmt));
            }
            mysqli_stmt_close($stmt);
        } else {
            $response['message'] = 'Database error: Could not prepare statement. ' . mysqli_error($link);
            error_log("Prepare update statement error: " . mysqli_error($link));
        }

    } elseif ($action === 'delete') {
        $reservation_id = filter_input(INPUT_POST, 'reservation_id', FILTER_SANITIZE_NUMBER_INT);
         if(empty($reservation_id)) {
             $response['message'] = 'Missing reservation ID for deletion.';
             echo json_encode($response);
             exit;
        }

        $sql_select = "SELECT * FROM reservations WHERE reservation_id = ?";
        $stmt_select = mysqli_prepare($link, $sql_select);
        mysqli_stmt_bind_param($stmt_select, "i", $reservation_id);
        mysqli_stmt_execute($stmt_select);
        $result = mysqli_stmt_get_result($stmt_select);
        $reservation_data = mysqli_fetch_assoc($result);
        mysqli_free_result($result); 
        mysqli_stmt_close($stmt_select);

        if ($reservation_data) {
            $item_data_json = json_encode($reservation_data);

            mysqli_begin_transaction($link);

            try {
                $sql_soft_delete = "UPDATE reservations SET deleted_at = NOW(), action_by = ? WHERE reservation_id = ?";
                $stmt_soft_delete = mysqli_prepare($link, $sql_soft_delete);
                mysqli_stmt_bind_param($stmt_soft_delete, "si", $action_by_username, $reservation_id);
                mysqli_stmt_execute($stmt_soft_delete);
                mysqli_stmt_close($stmt_soft_delete);

                $sql_log = "INSERT INTO deletion_history (item_type, item_id, item_data, purge_date) VALUES ('reservation', ?, ?, DATE_ADD(CURDATE(), INTERVAL 30 DAY))";
                $stmt_log = mysqli_prepare($link, $sql_log);
                mysqli_stmt_bind_param($stmt_log, "is", $reservation_id, $item_data_json);
                mysqli_stmt_execute($stmt_log);
                mysqli_stmt_close($stmt_log);

                mysqli_commit($link);
                $response['success'] = true;
                $response['message'] = 'Reservation moved to deletion history successfully.';

            } catch (mysqli_sql_exception $exception) {
                mysqli_rollback($link);
                $response['message'] = 'Database error during deletion process.';
                error_log("Reservation deletion transaction failed: " . $exception->getMessage());
            }
        } else {
            $response['message'] = 'No reservation found with the given ID to delete.';
        }
    } else {
        $response['message'] = 'Invalid action specified.';
    }

    mysqli_close($link);
} else {
    $response['message'] = 'Invalid request method.';
}

echo json_encode($response);
?>