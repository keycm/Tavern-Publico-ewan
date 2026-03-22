<?php
error_reporting(E_ALL);
ini_set('display_errors', 0); // Don't display errors, it breaks JSON
ini_set('log_errors', 1);

session_start();
require_once 'db_connect.php';
require_once 'mail_config.php'; 
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

require 'PHPMailer/Exception.php';
require 'PHPMailer/PHPMailer.php';
require 'PHPMailer/SMTP.php';

header('Content-Type: application/json');

$response = ['success' => false, 'message' => ''];

// Authorization check
$is_authorized = false;
if (isset($_SESSION['loggedin']) && $_SESSION['loggedin'] === true) {
    if (isset($_SESSION['role']) && $_SESSION['role'] === 'owner') {
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

$action_by_username = $_SESSION['username'] ?? 'System'; 

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $reservation_id = $_POST['reservation_id'] ?? null;
    $newStatus = $_POST['status'] ?? null;
    $action = $_POST['action'] ?? null;

    if ($reservation_id === null || ($action === 'update' && $newStatus === null) || empty($action)) {
        $response['message'] = 'Missing required fields.';
        echo json_encode($response);
        exit;
    }

    if ($action === 'update') {
        
        // --- FIX: Added 'reservation_type' to the query ---
        $sql_select = "SELECT user_id, res_name, res_email, res_date, res_time, reservation_type FROM reservations WHERE reservation_id = ?";
        $stmt_select = mysqli_prepare($link, $sql_select);
        mysqli_stmt_bind_param($stmt_select, "i", $reservation_id);
        mysqli_stmt_execute($stmt_select);
        $result = mysqli_stmt_get_result($stmt_select);
        $reservation_data = mysqli_fetch_assoc($result);
        mysqli_stmt_close($stmt_select);

        if (!$reservation_data) {
            $response['message'] = 'Reservation not found.';
            echo json_encode($response);
            exit;
        }

        // --- FIX: Set 'is_notified = 0' to flag this as a new notification ---
        $sql_update = "UPDATE reservations SET status = ?, action_by = ?, is_notified = 0 WHERE reservation_id = ?";
        if ($stmt_update = mysqli_prepare($link, $sql_update)) {
            mysqli_stmt_bind_param($stmt_update, "ssi", $newStatus, $action_by_username, $reservation_id);
            
            if (mysqli_stmt_execute($stmt_update) && mysqli_stmt_affected_rows($stmt_update) > 0) {
                $response['success'] = true;
                $response['message'] = 'Reservation status updated successfully.';

                // --- Send Email Notification ---
                $mail = new PHPMailer(true);
                try {
                    $mail->isSMTP();
                    $mail->Host       = SMTP_HOST;
                    $mail->SMTPAuth   = true;
                    $mail->Username   = SMTP_USERNAME;
                    $mail->Password   = SMTP_PASSWORD;
                    $mail->SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS;
                    $mail->Port       = SMTP_PORT;

                    $mail->setFrom(SMTP_USERNAME, 'Tavern Publico');
                    $mail->addAddress($reservation_data['res_email'], $reservation_data['res_name']);
                    $mail->isHTML(true);
                    
                    // Format reservation details
                    $res_date_formatted = htmlspecialchars($reservation_data['res_date']);
                    $res_time_formatted = htmlspecialchars(date('g:i A', strtotime($reservation_data['res_time'])));
                    $customer_name = htmlspecialchars($reservation_data['res_name']);

                    if ($newStatus === 'Confirmed') {
                        $mail->Subject = 'Your Reservation is Confirmed!';
                        
                        // --- THIS IS THE NEW LOGIC ---
                        $reservation_type = $reservation_data['reservation_type'] ?? 'Dine-in';
                        
                        if ($reservation_type === 'Dine-in') {
                            // Standard Dine-in Email
                            $mail->Body    = "Dear " . $customer_name . ",<br><br>" .
                                             "Your <strong>Dine-in</strong> reservation for <strong>" . $res_date_formatted . "</strong> at <strong>" . $res_time_formatted . "</strong> has been confirmed.<br><br>" .
                                             "Please note: Your table will be held for a 30-minute grace period past your reservation time. If you are running late, please give us a call.<br><br>" .
                                             "We look forward to seeing you!<br>Tavern Publico";
                        } else {
                            // Formal Event / Special Occasion Email
                            $mail->Body    = "Dear " . $customer_name . ",<br><br>" .
                                             "We are pleased to confirm your <strong>" . htmlspecialchars($reservation_type) . "</strong> reservation for <strong>" . $res_date_formatted . "</strong> at <strong>" . $res_time_formatted . "</strong>.<br><br>" .
                                             "Our team is excited to help you celebrate. If you have any further requirements or need to coordinate details for your event, please do not hesitate to reply to this email or contact us directly.<br><br>" .
                                             "We look forward to welcoming you!<br>Tavern Publico";
                        }
                        // --- END OF NEW LOGIC ---

                    } elseif ($newStatus === 'Declined') {
                        $mail->Subject = 'Your Reservation has been Declined';
                        $mail->Body    = "Dear " . $customer_name . ",<br><br>We regret to inform you that your reservation for " . $res_date_formatted . " at " . $res_time_formatted . " has been declined due to unavailability.<br><br>Please try booking for another date or time.<br>Tavern Publico";
                    }
                    
                    // Only send if status is Confirmed or Declined
                    if (in_array($newStatus, ['Confirmed', 'Declined'])) {
                        $mail->send();
                        $response['message'] .= ' Email notification sent.';
                    }

                } catch (Exception $e) {
                    $response['message'] .= " Email could not be sent. Mailer Error: {$mail->ErrorInfo}";
                }
                // --- END: Send Email Notification ---

            } else {
                $response['message'] = 'No reservation found or status is the same.';
            }
            mysqli_stmt_close($stmt_update);
        } else {
            $response['message'] = 'Database error.';
        }
    }
}

mysqli_close($link);
echo json_encode($response);
?>