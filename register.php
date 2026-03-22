<?php
// Start output buffering to catch any stray PHP warnings or errors
ob_start();

// Import PHPMailer classes into the global namespace
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception as PHPMailerException;

// Include the necessary files
require_once 'db_connect.php';
require_once 'mail_config.php';

// Manually include the PHPMailer files
require 'PHPMailer/Exception.php';
require 'PHPMailer/PHPMailer.php';
require 'PHPMailer/SMTP.php';

// Automatically delete unverified users whose OTP has expired (older than 15 minutes)
$cleanup_sql = "DELETE FROM users WHERE is_verified = 0 AND otp_expiry < NOW()";
if (!mysqli_query($link, $cleanup_sql)) {
    error_log("Failed to cleanup expired unverified users: " . mysqli_error($link));
}


$response = ['success' => false, 'message' => ''];

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $username = trim($_POST['username'] ?? '');
    $email = trim($_POST['email'] ?? '');
    $password = $_POST['password'] ?? '';

    // --- Validation ---
    if (empty($username) || empty($email) || empty($password)) {
        $response['message'] = 'Please fill in all fields.';
    } elseif (strlen($username) > 10) {
        $response['message'] = 'Username must be 10 characters or less.';
    } elseif (!filter_var($email, FILTER_VALIDATE_EMAIL) || substr($email, -10) !== '@gmail.com') {
        $response['message'] = 'Invalid email format or not a Gmail address.';
    } elseif (strlen($password) < 6 || !preg_match('/[A-Z]/', $password) || !preg_match('/[^A-Za-z0-9]/', $password)) {
        $response['message'] = 'Password does not meet the requirements.';
    } else {
        // Check if username or email already exists
        $sql_check = "SELECT user_id FROM users WHERE (username = ? OR email = ?) AND deleted_at IS NULL";
        if ($stmt_check = mysqli_prepare($link, $sql_check)) {
            mysqli_stmt_bind_param($stmt_check, "ss", $username, $email);
            mysqli_stmt_execute($stmt_check);
            mysqli_stmt_store_result($stmt_check);
            if (mysqli_stmt_num_rows($stmt_check) > 0) {
                $response['message'] = 'Username or Email already taken.';
            }
            mysqli_stmt_close($stmt_check);
        }

        // If no validation errors so far, proceed
        if (empty($response['message'])) {
            $password_hash = password_hash($password, PASSWORD_DEFAULT);
            $otp = rand(100000, 999999);
            $otp_expiry = date('Y-m-d H:i:s', strtotime('+15 minutes'));
            $default_avatar = 'Temporary.jpg'; 

            mysqli_begin_transaction($link);
            
            try {
                // Step 1: Prepare and execute the user insertion
                $sql_insert = "INSERT INTO users (username, email, password_hash, is_verified, otp, otp_expiry, avatar) VALUES (?, ?, ?, 0, ?, ?, ?)";
                $stmt_insert = mysqli_prepare($link, $sql_insert);
                if ($stmt_insert === false) {
                    throw new Exception('Database error: Could not prepare the user insertion statement.');
                }

                mysqli_stmt_bind_param($stmt_insert, "sssiss", $username, $email, $password_hash, $otp, $otp_expiry, $default_avatar);

                if (!mysqli_stmt_execute($stmt_insert)) {
                    throw new Exception('Database error: ' . mysqli_stmt_error($stmt_insert));
                }
                
                $new_user_id = mysqli_insert_id($link); 
                mysqli_stmt_close($stmt_insert);
                
                if ($new_user_id <= 0) {
                    throw new Exception('Failed to create user or retrieve user ID.');
                }


                // Step 2: If insertion is successful, send the verification email
                $mail = new PHPMailer(true);
                
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
                $mail->Subject = 'Your Verification Code - Tavern Publico';
                $mail->Body    = "<h1>Welcome to Tavern Publico!</h1><p>Your verification code is: <strong>$otp</strong>. This code will expire in 15 minutes.</p>";
                $mail->AltBody = "Your verification code is: $otp. This code will expire in 15 minutes.";

                $mail->send(); 

                // --- MODIFIED: This is the fix ---
                // Step 3: Create the "Complete Your Profile" notification
                $notification_message = "Welcome! Please complete your profile by adding your Birthday and Mobile Number for security purposes.";
                $notification_link = "profile.php";
                $notification_type = "system"; // Use the new 'type' column
                
                $sql_notify = "INSERT INTO notifications (user_id, message, link, type) VALUES (?, ?, ?, ?)";
                
                $stmt_notify = mysqli_prepare($link, $sql_notify);
                if ($stmt_notify === false) {
                    error_log("Failed to prepare notification statement for user $new_user_id: " . mysqli_error($link));
                } else {
                    // Bind 4 parameters: user_id (i), message (s), link (s), type (s)
                    mysqli_stmt_bind_param($stmt_notify, "isss", $new_user_id, $notification_message, $notification_link, $notification_type);
                    if (!mysqli_stmt_execute($stmt_notify)) {
                        error_log("Failed to insert notification for user $new_user_id: " . mysqli_stmt_error($stmt_notify));
                    }
                    mysqli_stmt_close($stmt_notify);
                }
                // --- END FIX ---

                // If all steps were successful, commit the transaction
                mysqli_commit($link);
                $response['success'] = true;
                $response['message'] = 'Registration successful! A verification code has been sent to your email.';

            } catch (Throwable $e) {
                mysqli_rollback($link);

                $response['success'] = false; 
                if ($e instanceof PHPMailerException) {
                    $response['message'] = "Could not send verification email. Please check your email address and try again.";
                    error_log("PHPMailer Error: " . ($mail->ErrorInfo ?? $e->getMessage()));
                } else {
                    $response['message'] = $e->getMessage();
                    error_log("Registration Error: " . $e->getMessage());
                }
            }
        }
    }
    mysqli_close($link);
} else {
    $response['message'] = 'Invalid request method.';
}

// Clean (erase) any stray output from the buffer
ob_end_clean();

// Send the final, clean JSON response
header('Content-Type: application/json');
echo json_encode($response);
?>