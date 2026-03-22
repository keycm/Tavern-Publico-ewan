<?php
session_start();

// --- MODIFICATION: Added PHPMailer requirements ---
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception as PHPMailerException;

require_once 'db_connect.php';

require_once 'mail_config.php';
require 'PHPMailer/Exception.php';
require 'PHPMailer/PHPMailer.php';
require 'PHPMailer/SMTP.php';
// --- END MODIFICATION ---

header('Content-Type: application/json');
$response = ['success' => false, 'message' => 'An unknown error occurred.'];

// Authorization check (Allows Owner or Manager)
if (!isset($_SESSION['loggedin']) || $_SESSION['loggedin'] !== true || !in_array($_SESSION['role'], ['owner', 'manager'])) {
    $response['message'] = 'Unauthorized access.';
    echo json_encode($response);
    exit;
}

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $action = $_POST['action'] ?? '';

    if ($action === 'deleteUser') {
        // This logic is only for the Owner
        if ($_SESSION['role'] !== 'owner') {
             $response['message'] = 'You do not have permission to delete users.';
             echo json_encode($response);
             exit;
        }
        
        $userId = filter_var($_POST['user_id'] ?? 0, FILTER_SANITIZE_NUMBER_INT);
        if ($userId > 0) {
            
            $action_by_username = $_SESSION['username'] ?? 'System';

            $sql_select = "SELECT * FROM users WHERE user_id = ? AND deleted_at IS NULL";
            $stmt_select = mysqli_prepare($link, $sql_select);
            mysqli_stmt_bind_param($stmt_select, "i", $userId);
            mysqli_stmt_execute($stmt_select);
            $result = mysqli_stmt_get_result($stmt_select);
            $item_data = mysqli_fetch_assoc($result);
            mysqli_stmt_close($stmt_select);
            
            if ($item_data) {
                unset($item_data['password_hash']);
                $item_data_json = json_encode($item_data);
                
                mysqli_begin_transaction($link);
                try {
                    $sql_log = "INSERT INTO deletion_history (item_type, item_id, item_data, action_by, purge_date) VALUES ('user', ?, ?, ?, DATE_ADD(CURDATE(), INTERVAL 30 DAY))";
                    $stmt_log = mysqli_prepare($link, $sql_log);
                    mysqli_stmt_bind_param($stmt_log, "iss", $userId, $item_data_json, $action_by_username);
                    mysqli_stmt_execute($stmt_log);
                    mysqli_stmt_close($stmt_log);

                    $sql_soft_delete = "UPDATE users SET deleted_at = NOW() WHERE user_id = ?";
                    $stmt_soft_delete = mysqli_prepare($link, $sql_soft_delete);
                    mysqli_stmt_bind_param($stmt_soft_delete, "i", $userId);
                    mysqli_stmt_execute($stmt_soft_delete);
                    mysqli_stmt_close($stmt_soft_delete);

                    mysqli_commit($link);
                    $response['success'] = true;
                    $response['message'] = 'User moved to deletion history.';

                } catch (Exception $e) {
                    mysqli_rollback($link);
                    $response['message'] = 'Error deleting user.';
                }
            } else {
                $response['message'] = 'User not found or has already been deleted.';
            }
        } else {
            $response['message'] = 'Invalid user ID.';
        }
    }
    elseif ($action === 'saveUser') {
        // This action can only be done by an Owner
        if ($_SESSION['role'] !== 'owner') {
             $response['message'] = 'You do not have permission to edit or add users.';
             echo json_encode($response);
             exit;
        }
        
        $userId = filter_var($_POST['user_id'] ?? 0, FILTER_SANITIZE_NUMBER_INT);
        $username = trim($_POST['username'] ?? '');
        $email = trim($_POST['email'] ?? '');
        $password = $_POST['password'] ?? '';

        if (empty($username) || empty($email)) {
            $response['message'] = 'Username and Email are required.';
            echo json_encode($response);
            exit;
        }

        if ($userId > 0) {
            // Logic for UPDATING an existing user
            if (!empty($password)) {
                $password_hash = password_hash($password, PASSWORD_DEFAULT);
                $sql = "UPDATE users SET username = ?, email = ?, password_hash = ? WHERE user_id = ?";
                $stmt = mysqli_prepare($link, $sql);
                mysqli_stmt_bind_param($stmt, "sssi", $username, $email, $password_hash, $userId);
            } else {
                $sql = "UPDATE users SET username = ?, email = ? WHERE user_id = ?";
                $stmt = mysqli_prepare($link, $sql);
                mysqli_stmt_bind_param($stmt, "ssi", $username, $email, $userId);
            }

            if ($stmt && mysqli_stmt_execute($stmt)) {
                $response['success'] = true;
                $response['message'] = 'User updated successfully.';
            } else {
                $response['message'] = 'Failed to update user. Username or email might already be taken.';
            }
            if ($stmt) mysqli_stmt_close($stmt);
        }
        else {
             // Logic for CREATING a new user
             if (empty($password)) {
                $response['message'] = 'Password is required for new users.';
                echo json_encode($response);
                exit;
            }
            
            // Check for duplicates
            $sql_check = "SELECT user_id FROM users WHERE username = ? OR email = ?";
            if ($stmt_check = mysqli_prepare($link, $sql_check)) {
                mysqli_stmt_bind_param($stmt_check, "ss", $username, $email);
                if (mysqli_stmt_execute($stmt_check)) {
                    mysqli_stmt_store_result($stmt_check);
                    if (mysqli_stmt_num_rows($stmt_check) > 0) {
                        $response['message'] = 'Username or Email already taken.';
                        echo json_encode($response);
                        mysqli_stmt_close($stmt_check);
                        mysqli_close($link);
                        exit;
                    }
                }
                mysqli_stmt_close($stmt_check);
            }

            $password_hash = password_hash($password, PASSWORD_DEFAULT);
            $default_avatar = 'Tavern.png';
            
            // MODIFICATION: Insert user as verified and with default avatar
            $sql = "INSERT INTO users (username, email, password_hash, is_admin, avatar, is_verified) VALUES (?, ?, ?, 0, ?, 1)";
            $stmt = mysqli_prepare($link, $sql);
            mysqli_stmt_bind_param($stmt, "ssss", $username, $email, $password_hash, $default_avatar);
            
            if ($stmt && mysqli_stmt_execute($stmt)) {
                $response['success'] = true;
                $response['message'] = 'User added successfully.';
                
                // --- NEW: Send notification email ---
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
                    $mail->addAddress($email, $username);

                    $mail->isHTML(true);
                    $mail->Subject = 'Your New Account at Tavern Publico';
                    $mail->Body    = "<h1>Welcome to Tavern Publico!</h1>
                                      <p>Hello, " . htmlspecialchars($username) . "!</p>
                                      <p>An account has been created for you by our administrator. You can now log in using these credentials:</p>
                                      <p><strong>Email:</strong> " . htmlspecialchars($email) . "<br>
                                      <strong>Password:</strong> " . htmlspecialchars($password) . "</p>
                                      <p>We recommend logging in and changing your password in your profile settings.</p>
                                      <br>
                                      <p>Thank you,<br>The Tavern Publico Team</p>";
                    $mail->AltBody = "Welcome, " . htmlspecialchars($username) . "! An account has been created for you at Tavern Publico. Log in with your email (" . htmlspecialchars($email) . ") and this password: " . htmlspecialchars($password);

                    $mail->send();
                    $response['message'] .= ' Notification email sent.';
                    
                } catch (PHPMailerException $e) {
                    // Log the error but don't fail the whole operation
                    error_log("Failed to send new user email to $email: " . $mail->ErrorInfo);
                    $response['message'] .= ' (Could not send notification email.)';
                }
                // --- END NEW ---
                
            } else {
                $response['message'] = 'Failed to add user. Please try again.';
            }
            if ($stmt) mysqli_stmt_close($stmt);
        }
    } else {
        $response['message'] = 'Invalid action.';
    }
} else {
    $response['message'] = 'Invalid request method.';
}

mysqli_close($link);
echo json_encode($response);
?>