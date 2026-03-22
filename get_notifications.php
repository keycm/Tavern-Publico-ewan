<?php
session_start();
require_once 'db_connect.php';

header('Content-Type: application/json');

$response = ['success' => false, 'notifications' => []];

if (!isset($_SESSION['loggedin']) || $_SESSION['loggedin'] !== true) {
    echo json_encode(['success' => false, 'message' => 'Unauthorized']);
    exit;
}

$user_id = $_SESSION['user_id'];
$notifications = [];

// --- THIS IS THE FIX ---
// The query now uses a CASE statement to add the 30-minute warning
// only to 'Confirmed' reservations.
$sql = "
    (SELECT
        reservation_id as id,
        CASE
            WHEN status = 'Confirmed' THEN CONCAT('Your reservation for ', res_date, ' has been Confirmed. Please arrive within 30 minutes of your time, or your table may be released.')
            WHEN status = 'Declined' THEN CONCAT('Your reservation for ', res_date, ' has been Declined.')
            WHEN status = 'Cancelled' THEN CONCAT('Your reservation for ', res_date, ' has been Cancelled.')
            ELSE CONCAT('Your reservation for ', res_date, ' is now ', status, '.')
        END as message,
        '#' as link, -- Link to # to ensure the modal always opens
        'reservation' as type,
        created_at
    FROM reservations
    WHERE user_id = ? AND status != 'Pending' AND is_notified = 0 AND deleted_at IS NULL)
    UNION ALL
    (SELECT
        id,
        CASE 
            WHEN type = 'custom' THEN CONCAT('Admin Reply: ', message)
            ELSE message
        END as message,
        link,
        type,
        created_at
    FROM notifications
    WHERE user_id = ? AND is_read = 0)
    ORDER BY created_at DESC
";
// --- END FIX ---

if ($stmt = mysqli_prepare($link, $sql)) {
    // Bind the user_id parameter for both parts of the UNION query
    mysqli_stmt_bind_param($stmt, "ii", $user_id, $user_id);
    
    if (mysqli_stmt_execute($stmt)) {
        $result = mysqli_stmt_get_result($stmt);
        while ($row = mysqli_fetch_assoc($result)) {
            // Build the final notification array for the frontend
            $notifications[] = [
                'id' => $row['id'],
                'message' => $row['message'],
                'link' => $row['link'],
                'type' => $row['type']
            ];
        }
        $response['success'] = true;
        $response['notifications'] = $notifications;
    } else {
         $response['message'] = 'Failed to execute notification query.';
    }
    mysqli_stmt_close($stmt);
} else {
    $response['message'] = 'Failed to prepare notification query.';
}

mysqli_close($link);
echo json_encode($response);
?>