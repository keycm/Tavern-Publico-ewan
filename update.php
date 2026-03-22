<?php
// Start output buffering to prevent "headers already sent" errors.
ob_start();

session_start();
require_once 'db_connect.php'; 

// MODIFIED: More specific authorization check
$is_authorized = false;
if (isset($_SESSION['loggedin']) && $_SESSION['loggedin'] === true) {
    if (isset($_SESSION['is_admin']) && $_SESSION['is_admin'] === true) {
        $is_authorized = true;
    }
    elseif (isset($_SESSION['role']) && $_SESSION['role'] === 'manager') {
        if (isset($_SESSION['permissions']) && is_array($_SESSION['permissions']) && in_array('manage_uploads', $_SESSION['permissions'])) {
            $is_authorized = true;
        }
    }
}

if (!$is_authorized) {
    header('Location: login.php'); 
    exit;
}

// Helper function for logging and soft-deleting
function log_and_soft_delete($link, $item_id, $item_type) {
    $table_info = [
        'hero_slide' => ['table' => 'hero_slides', 'pk' => 'id'],
        'event' => ['table' => 'events', 'pk' => 'id'],
        'gallery_image' => ['table' => 'gallery', 'pk' => 'id'],
        'menu_item' => ['table' => 'menu', 'pk' => 'id'],
        'team_member' => ['table' => 'team', 'pk' => 'id'],
    ];

    if (!isset($table_info[$item_type])) return false;

    $table = $table_info[$item_type]['table'];
    $pk = $table_info[$item_type]['pk'];
    $action_by_username = $_SESSION['username'] ?? 'System';

    $sql_select = "SELECT * FROM {$table} WHERE {$pk} = ?";
    $stmt_select = mysqli_prepare($link, $sql_select);
    mysqli_stmt_bind_param($stmt_select, "i", $item_id);
    mysqli_stmt_execute($stmt_select);
    $result = mysqli_stmt_get_result($stmt_select);
    $item_data = mysqli_fetch_assoc($result);
    mysqli_stmt_close($stmt_select);

    if ($item_data) {
        $item_data_json = json_encode($item_data);
        mysqli_begin_transaction($link);
        try {
            $sql_log = "INSERT INTO deletion_history (item_type, item_id, item_data, action_by, purge_date) VALUES (?, ?, ?, ?, DATE_ADD(CURDATE(), INTERVAL 30 DAY))";
            $stmt_log = mysqli_prepare($link, $sql_log);
            mysqli_stmt_bind_param($stmt_log, "siss", $item_type, $item_id, $item_data_json, $action_by_username);
            mysqli_stmt_execute($stmt_log);
            mysqli_stmt_close($stmt_log);

            $sql_soft_delete = "UPDATE {$table} SET deleted_at = NOW() WHERE {$pk} = ?";
            $stmt_soft_delete = mysqli_prepare($link, $sql_soft_delete);
            mysqli_stmt_bind_param($stmt_soft_delete, "i", $item_id);
            mysqli_stmt_execute($stmt_soft_delete);
            mysqli_stmt_close($stmt_soft_delete);
            
            mysqli_commit($link);
            return true;
        } catch (Exception $e) {
            mysqli_rollback($link);
            error_log("Soft delete failed: " . $e->getMessage());
            return false;
        }
    }
    return false;
}

// Generates a unique filename
function uploadFile($file, $targetDir, $allowedTypes) {
    $fileType = strtolower(pathinfo($file["name"], PATHINFO_EXTENSION));
    $newFileName = uniqid('', true) . '.' . $fileType;
    $targetFile = $targetDir . $newFileName;
    $uploadOk = 1;

    if ($file["size"] > 300000000) { $uploadOk = 0; } // 300MB limit
    if(!in_array($fileType, $allowedTypes)) { $uploadOk = 0; }

    if ($uploadOk == 0) return false;
    if (move_uploaded_file($file["tmp_name"], $targetFile)) return $newFileName;
    return false;
}

function sanitize($link, $data) {
    return mysqli_real_escape_string($link, strip_tags($data));
}

// ==========================================
// --- HERO SLIDE HANDLING (ADD, EDIT, DELETE)
// ==========================================
if (isset($_POST['add_hero_slide'])) {
    $title = sanitize($link, $_POST['hero_title']);
    $subtitle = sanitize($link, $_POST['hero_subtitle']);
    $media_type = sanitize($link, $_POST['media_type']);
    $image_path = ''; $video_path = '';

    if ($media_type === 'image' && !empty($_FILES['hero_image']['name'])) {
        $new_filename = uploadFile($_FILES['hero_image'], "uploads/", ['jpg', 'png', 'jpeg', 'gif', 'webp']);
        if ($new_filename) { $image_path = 'uploads/' . $new_filename; }
    } elseif ($media_type === 'video' && !empty($_FILES['hero_video']['name'])) {
        $new_filename = uploadFile($_FILES['hero_video'], "uploads/", ['mp4', 'webm', 'ogg']);
        if ($new_filename) { $video_path = 'uploads/' . $new_filename; }
    }

    $sql = "INSERT INTO hero_slides (image_path, video_path, title, subtitle, media_type) VALUES (?, ?, ?, ?, ?)";
    $stmt = mysqli_prepare($link, $sql);
    mysqli_stmt_bind_param($stmt, "sssss", $image_path, $video_path, $title, $subtitle, $media_type);
    if (mysqli_stmt_execute($stmt)) { $_SESSION['message'] = "New hero slide added successfully."; }
    mysqli_stmt_close($stmt);
    header('Location: ' . $_SERVER['PHP_SELF'] . '?section=hero_section'); exit;
}

if (isset($_POST['edit_hero_slide'])) {
    $id = (int)$_POST['edit_slide_id'];
    $title = sanitize($link, $_POST['edit_hero_title']);
    $subtitle = sanitize($link, $_POST['edit_hero_subtitle']);
    
    // Check if new file was uploaded, otherwise keep existing
    $sql_update = "UPDATE hero_slides SET title=?, subtitle=? WHERE id=?";
    $stmt = mysqli_prepare($link, $sql_update);
    mysqli_stmt_bind_param($stmt, "ssi", $title, $subtitle, $id);
    
    // If a new image/video is uploaded, update those specific fields too
    $media_type = sanitize($link, $_POST['edit_media_type']);
    if ($media_type === 'image' && !empty($_FILES['edit_hero_image']['name'])) {
        $new_filename = uploadFile($_FILES['edit_hero_image'], "uploads/", ['jpg', 'png', 'jpeg', 'gif', 'webp']);
        if ($new_filename) {
            $image_path = 'uploads/' . $new_filename;
            mysqli_query($link, "UPDATE hero_slides SET image_path='$image_path' WHERE id=$id");
        }
    } elseif ($media_type === 'video' && !empty($_FILES['edit_hero_video']['name'])) {
        $new_filename = uploadFile($_FILES['edit_hero_video'], "uploads/", ['mp4', 'webm', 'ogg']);
        if ($new_filename) {
            $video_path = 'uploads/' . $new_filename;
            mysqli_query($link, "UPDATE hero_slides SET video_path='$video_path' WHERE id=$id");
        }
    }

    if (mysqli_stmt_execute($stmt)) { $_SESSION['message'] = "Hero slide updated successfully."; }
    mysqli_stmt_close($stmt);
    header('Location: ' . $_SERVER['PHP_SELF'] . '?section=hero_section'); exit;
}

if (isset($_POST['delete_hero_slide'])) {
    $id = (int)$_POST['slide_id'];
    if(log_and_soft_delete($link, $id, 'hero_slide')) { $_SESSION['message'] = "Hero slide moved to deletion history."; } 
    header('Location: ' . $_SERVER['PHP_SELF'] . '?section=hero_section'); exit;
}

// ==========================================
// --- EVENT HANDLING (ADD, EDIT, DELETE)
// ==========================================
if (isset($_POST['add_event'])) {
    $title = sanitize($link, $_POST['event_title']);
    $date = sanitize($link, $_POST['event_date']);
    $end_date = !empty($_POST['event_end_date']) ? sanitize($link, $_POST['event_end_date']) : NULL;
    $description = sanitize($link, $_POST['event_description']);
    $image = '';
    if (!empty($_FILES['event_image']['name'])) {
        $new_filename = uploadFile($_FILES['event_image'], "uploads/", ['jpg', 'png', 'jpeg', 'gif', 'webp']);
        if ($new_filename) { $image = 'uploads/' . $new_filename; }
    }
    $sql = "INSERT INTO events (title, date, end_date, description, image) VALUES (?, ?, ?, ?, ?)";
    $stmt = mysqli_prepare($link, $sql);
    mysqli_stmt_bind_param($stmt, "sssss", $title, $date, $end_date, $description, $image);
    if (mysqli_stmt_execute($stmt)) { $_SESSION['message'] = "New event added successfully."; }
    mysqli_stmt_close($stmt);
    header('Location: ' . $_SERVER['PHP_SELF'] . '?section=events'); exit;
}

if (isset($_POST['edit_event'])) {
    $id = (int)$_POST['edit_event_id'];
    $title = sanitize($link, $_POST['edit_event_title']);
    $date = sanitize($link, $_POST['edit_event_date']);
    $end_date = !empty($_POST['edit_event_end_date']) ? sanitize($link, $_POST['edit_event_end_date']) : NULL;
    $description = sanitize($link, $_POST['edit_event_description']);
    
    $sql_update = "UPDATE events SET title=?, date=?, end_date=?, description=? WHERE id=?";
    $stmt = mysqli_prepare($link, $sql_update);
    mysqli_stmt_bind_param($stmt, "ssssi", $title, $date, $end_date, $description, $id);
    
    if (!empty($_FILES['edit_event_image']['name'])) {
        $new_filename = uploadFile($_FILES['edit_event_image'], "uploads/", ['jpg', 'png', 'jpeg', 'gif', 'webp']);
        if ($new_filename) {
            $image_path = 'uploads/' . $new_filename;
            mysqli_query($link, "UPDATE events SET image='$image_path' WHERE id=$id");
        }
    }
    if (mysqli_stmt_execute($stmt)) { $_SESSION['message'] = "Event updated successfully."; }
    mysqli_stmt_close($stmt);
    header('Location: ' . $_SERVER['PHP_SELF'] . '?section=events'); exit;
}

if (isset($_POST['delete_event'])) {
    $id = (int)$_POST['event_id'];
    if (log_and_soft_delete($link, $id, 'event')) { $_SESSION['message'] = "Event moved to deletion history."; } 
    header('Location: ' . $_SERVER['PHP_SELF'] . '?section=events'); exit;
}

// ==========================================
// --- GALLERY HANDLING (ADD, EDIT, DELETE)
// ==========================================
if (isset($_POST['add_gallery_image'])) {
    $description = sanitize($link, $_POST['gallery_description']);
    if (!empty($_FILES['gallery_image']['name'])) {
        $new_filename = uploadFile($_FILES['gallery_image'], "uploads/", ['jpg', 'png', 'jpeg', 'gif', 'webp']);
        if ($new_filename) {
            $image = 'uploads/' . $new_filename;
            $sql = "INSERT INTO gallery (image, description) VALUES (?, ?)";
            $stmt = mysqli_prepare($link, $sql);
            mysqli_stmt_bind_param($stmt, "ss", $image, $description);
            if (mysqli_stmt_execute($stmt)) { $_SESSION['message'] = "New gallery image added successfully."; }
            mysqli_stmt_close($stmt);
        }
    }
    header('Location: ' . $_SERVER['PHP_SELF'] . '?section=gallery'); exit;
}

if (isset($_POST['edit_gallery_image'])) {
    $id = (int)$_POST['edit_gallery_id'];
    $description = sanitize($link, $_POST['edit_gallery_description']);
    
    $sql_update = "UPDATE gallery SET description=? WHERE id=?";
    $stmt = mysqli_prepare($link, $sql_update);
    mysqli_stmt_bind_param($stmt, "si", $description, $id);
    
    if (!empty($_FILES['edit_gallery_file']['name'])) {
        $new_filename = uploadFile($_FILES['edit_gallery_file'], "uploads/", ['jpg', 'png', 'jpeg', 'gif', 'webp']);
        if ($new_filename) {
            $image_path = 'uploads/' . $new_filename;
            mysqli_query($link, "UPDATE gallery SET image='$image_path' WHERE id=$id");
        }
    }
    if (mysqli_stmt_execute($stmt)) { $_SESSION['message'] = "Gallery image updated successfully."; }
    mysqli_stmt_close($stmt);
    header('Location: ' . $_SERVER['PHP_SELF'] . '?section=gallery'); exit;
}

if (isset($_POST['delete_gallery_image'])) {
    $id = (int)$_POST['gallery_id'];
    if (log_and_soft_delete($link, $id, 'gallery_image')) { $_SESSION['message'] = "Gallery image moved to deletion history."; } 
    header('Location: ' . $_SERVER['PHP_SELF'] . '?section=gallery'); exit;
}

// ==========================================
// --- MENU HANDLING (ADD, EDIT, DELETE)
// ==========================================
if (isset($_POST['add_menu_item'])) {
    $name = sanitize($link, $_POST['menu_name']);
    $category = sanitize($link, $_POST['menu_category']);
    $price = filter_var($_POST['menu_price'], FILTER_SANITIZE_NUMBER_FLOAT, FILTER_FLAG_ALLOW_FRACTION);
    $description = sanitize($link, $_POST['menu_description']);
    $image = '';
    if (!empty($_FILES['menu_image']['name'])) {
        $new_filename = uploadFile($_FILES['menu_image'], "uploads/", ['jpg', 'png', 'jpeg', 'gif', 'webp']);
        if ($new_filename) { $image = 'uploads/' . $new_filename; }
    }
    $sql = "INSERT INTO menu (name, category, price, description, image) VALUES (?, ?, ?, ?, ?)";
    $stmt = mysqli_prepare($link, $sql);
    mysqli_stmt_bind_param($stmt, "ssdss", $name, $category, $price, $description, $image);
    if (mysqli_stmt_execute($stmt)) { $_SESSION['message'] = "New menu item added successfully."; }
    mysqli_stmt_close($stmt);
    header('Location: ' . $_SERVER['PHP_SELF'] . '?section=menu'); exit;
}

if (isset($_POST['edit_menu_item'])) {
    $id = (int)$_POST['edit_menu_id'];
    $name = sanitize($link, $_POST['edit_menu_name']);
    $category = sanitize($link, $_POST['edit_menu_category']);
    $price = filter_var($_POST['edit_menu_price'], FILTER_SANITIZE_NUMBER_FLOAT, FILTER_FLAG_ALLOW_FRACTION);
    $description = sanitize($link, $_POST['edit_menu_description']);
    
    $sql_update = "UPDATE menu SET name=?, category=?, price=?, description=? WHERE id=?";
    $stmt = mysqli_prepare($link, $sql_update);
    mysqli_stmt_bind_param($stmt, "ssdsi", $name, $category, $price, $description, $id);
    
    if (!empty($_FILES['edit_menu_image']['name'])) {
        $new_filename = uploadFile($_FILES['edit_menu_image'], "uploads/", ['jpg', 'png', 'jpeg', 'gif', 'webp']);
        if ($new_filename) {
            $image_path = 'uploads/' . $new_filename;
            mysqli_query($link, "UPDATE menu SET image='$image_path' WHERE id=$id");
        }
    }
    if (mysqli_stmt_execute($stmt)) { $_SESSION['message'] = "Menu item updated successfully."; }
    mysqli_stmt_close($stmt);
    header('Location: ' . $_SERVER['PHP_SELF'] . '?section=menu'); exit;
}

if (isset($_POST['delete_menu_item'])) {
    $id = (int)$_POST['menu_id'];
    if (log_and_soft_delete($link, $id, 'menu_item')) { $_SESSION['message'] = "Menu item moved to deletion history."; } 
    header('Location: ' . $_SERVER['PHP_SELF'] . '?section=menu'); exit;
}

// ==========================================
// --- TEAM HANDLING (ADD, EDIT, DELETE)
// ==========================================
if (isset($_POST['add_team_member'])) {
    $name = sanitize($link, $_POST['team_name']);
    $title = sanitize($link, $_POST['team_title']);
    $bio = sanitize($link, $_POST['team_bio']);
    $image = '';
    if (!empty($_FILES['team_image']['name'])) {
        $new_filename = uploadFile($_FILES['team_image'], "uploads/", ['jpg', 'png', 'jpeg', 'gif', 'webp']);
        if ($new_filename) { $image = 'uploads/' . $new_filename; }
    }
    $sql = "INSERT INTO team (name, title, bio, image) VALUES (?, ?, ?, ?)";
    $stmt = mysqli_prepare($link, $sql);
    mysqli_stmt_bind_param($stmt, "ssss", $name, $title, $bio, $image);
    if (mysqli_stmt_execute($stmt)) { $_SESSION['message'] = "New team member added successfully."; }
    mysqli_stmt_close($stmt);
    header('Location: ' . $_SERVER['PHP_SELF'] . '?section=team_members'); exit;
}

if (isset($_POST['edit_team_member'])) {
    $id = (int)$_POST['edit_team_id'];
    $name = sanitize($link, $_POST['edit_team_name']);
    $title = sanitize($link, $_POST['edit_team_title']);
    $bio = sanitize($link, $_POST['edit_team_bio']);
    
    $sql_update = "UPDATE team SET name=?, title=?, bio=? WHERE id=?";
    $stmt = mysqli_prepare($link, $sql_update);
    mysqli_stmt_bind_param($stmt, "sssi", $name, $title, $bio, $id);
    
    if (!empty($_FILES['edit_team_image']['name'])) {
        $new_filename = uploadFile($_FILES['edit_team_image'], "uploads/", ['jpg', 'png', 'jpeg', 'gif', 'webp']);
        if ($new_filename) {
            $image_path = 'uploads/' . $new_filename;
            mysqli_query($link, "UPDATE team SET image='$image_path' WHERE id=$id");
        }
    }
    if (mysqli_stmt_execute($stmt)) { $_SESSION['message'] = "Team member updated successfully."; }
    mysqli_stmt_close($stmt);
    header('Location: ' . $_SERVER['PHP_SELF'] . '?section=team_members'); exit;
}

if (isset($_POST['delete_team_member'])) {
    $id = (int)$_POST['team_id'];
    if (log_and_soft_delete($link, $id, 'team_member')) { $_SESSION['message'] = "Team member moved to deletion history."; } 
    header('Location: ' . $_SERVER['PHP_SELF'] . '?section=team_members'); exit;
}

$section = $_GET['section'] ?? 'hero_section';

?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tavern Publico - Admin Dashboard</title>
    <link rel="stylesheet" href="CSS/admin.css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <style>
        /* --- ENHANCED UI STYLING --- */
        .content-card { background-color: #fff; padding: 30px; border-radius: 12px; box-shadow: 0 4px 15px rgba(0, 0, 0, 0.03); margin-bottom: 25px; border: 1px solid #eaedf1; }
        .content-card h2 { color: #2c3e50; margin-bottom: 20px; font-size: 22px; font-weight: 700; }
        .content-card h3 { color: #34495e; margin-top: 30px; margin-bottom: 15px; padding-bottom: 10px; border-bottom: 2px solid #f1f3f5; font-size: 18px; }
        
        /* Form Inputs */
        .form-group { margin-bottom: 18px; }
        .form-group label { display: block; margin-bottom: 8px; font-weight: 600; color: #444; font-size: 14px; }
        .form-group input[type="text"], .form-group input[type="date"], .form-group input[type="file"], .form-group textarea, .form-group select, .form-group input[type="number"] { width: 100%; padding: 12px 15px; border: 1px solid #d1d5db; border-radius: 6px; box-sizing: border-box; transition: border-color 0.2s, box-shadow 0.2s; font-family: inherit; font-size: 14px; background: #fdfdfd;}
        .form-group input:focus, .form-group textarea:focus, .form-group select:focus { border-color: #007bff; outline: none; box-shadow: 0 0 0 3px rgba(0,123,255,0.1); background: #fff; }
        .form-group textarea { resize: vertical; min-height: 100px; }

        /* Buttons */
        .btn { display: inline-flex; align-items: center; justify-content: center; padding: 10px 18px; font-size: 14px; font-weight: 500; border: none; border-radius: 6px; cursor: pointer; transition: all 0.2s ease; gap: 6px; text-decoration: none; }
        .btn i { font-size: 18px; }
        .btn-small { padding: 6px 12px; font-size: 13px; }
        .btn-small i { font-size: 16px; margin-right: 2px; }

        button[type="submit"], .btn-primary { background-color: #28a745; color: #fff; box-shadow: 0 4px 6px rgba(40,167,69,0.2); }
        button[type="submit"]:hover, .btn-primary:hover { background-color: #218838; transform: translateY(-1px); }
        
        .view-edit-btn { background-color: #e0f2fe; color: #0284c7; }
        .view-edit-btn:hover { background-color: #bae6fd; }

        .delete-btn { background-color: #fee2e2; color: #991b1b; }
        .delete-btn:hover { background-color: #fecaca; }

        /* Data Grid Elements */
        .admin-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap: 20px; }
        .data-item { background-color: #fff; border: 1px solid #e2e8f0; padding: 20px; border-radius: 10px; display: flex; flex-direction: column; gap: 12px; transition: transform 0.2s, box-shadow 0.2s; }
        .data-item:hover { transform: translateY(-3px); box-shadow: 0 8px 15px rgba(0,0,0,0.05); }
        .data-item h4 { margin: 0; color: #1e293b; font-size: 18px; }
        .data-item p { margin: 0; color: #64748b; font-size: 14px; line-height: 1.5; }
        .data-item img, .data-item video { border-radius: 8px; max-width: 100%; height: 200px; object-fit: cover; width: 100%; border: 1px solid #f1f5f9; background: #f8fafc; }
        
        .item-actions { display: flex; gap: 8px; margin-top: auto; padding-top: 15px; border-top: 1px solid #f1f5f9; }
        .item-actions form { margin: 0; }
        .item-actions .btn { flex: 1; width: 100%; }

        /* Menu Navigation */
        .menu-nav { display: flex; flex-wrap: wrap; gap: 8px; margin-bottom: 25px; padding-bottom: 15px; border-bottom: 1px solid #e2e8f0; }
        .menu-nav-link { padding: 8px 16px; background-color: #f1f5f9; color: #475569; text-decoration: none; border-radius: 20px; font-size: 14px; font-weight: 500; transition: all 0.2s ease; border: 1px solid transparent; }
        .menu-nav-link:hover { background-color: #e2e8f0; color: #0f172a; }
        .menu-nav-link.active { background-color: #0ea5e9; color: #fff; border-color: #0284c7; box-shadow: 0 4px 6px rgba(14,165,233,0.2); }

        /* Tabs */
        .tab-container { display: flex; border-bottom: 2px solid #e2e8f0; margin-bottom: 25px; gap: 5px; flex-wrap: wrap; }
        .tab-link { padding: 12px 20px; cursor: pointer; border: none; background-color: transparent; font-size: 15px; font-weight: 600; color: #64748b; text-decoration: none; border-top-left-radius: 8px; border-top-right-radius: 8px; display: flex; align-items: center; gap: 8px; transition: all 0.2s; margin-bottom: -2px; border-bottom: 2px solid transparent; }
        .tab-link:hover { background-color: #f8fafc; color: #0ea5e9; }
        .tab-link.active { color: #0ea5e9; border-bottom: 2px solid #0ea5e9; }
        .tab-content { display: none; }
        .tab-content.active { display: block; animation: fadeIn 0.4s ease-in-out; }
        @keyframes fadeIn { from { opacity: 0; transform: translateY(5px); } to { opacity: 1; transform: translateY(0); } }

        /* Modals Formatting */
        .modal { display: none; position: fixed; z-index: 2000; left: 0; top: 0; width: 100%; height: 100%; background-color: rgba(0,0,0,0.5); align-items: center; justify-content: center; padding: 15px; }
        .modal-content { background-color: #fff; border-radius: 12px; width: 100%; max-width: 500px; box-shadow: 0 10px 30px rgba(0,0,0,0.2); display: flex; flex-direction: column; overflow: hidden; max-height: 90vh; }
        .modal-header { padding: 20px 25px; border-bottom: 1px solid #eee; display: flex; justify-content: space-between; align-items: center; background-color: #fafbfc; }
        .modal-header h2 { margin: 0; font-size: 18px; color: #2c3e50; font-weight: 700; }
        .modal-body { padding: 25px; overflow-y: auto; }
        .modal-actions { padding: 20px 25px; border-top: 1px solid #eee; display: flex; justify-content: flex-end; gap: 10px; background-color: #fafbfc; }
        .close-button { font-size: 24px; color: #999; cursor: pointer; background: none; border: none; padding: 0; line-height: 1; transition: color 0.2s; }
        .close-button:hover { color: #333; }
        
        .message-box { position: fixed; top: 20px; left: 50%; transform: translateX(-50%); padding: 15px 30px; background-color: #10b981; color: white; border-radius: 8px; z-index: 9999; box-shadow: 0 4px 10px rgba(0,0,0,0.2); font-weight: bold; display: none; opacity: 0; transition: opacity 0.5s ease; }
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
                    <li class="menu-item active"><a href="update.php"><i class="material-icons">file_upload</i> Upload Management</a></li>
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
        <?php } ?>

        <div class="admin-content-area">
            <header class="main-header">
                <div class="header-content">
                    <h1 class="header-page-title">Upload Management</h1>
                    
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
                <div id="message-box" class="message-box"></div>

                <div class="tab-container">
                    <a href="?section=hero_section" class="tab-link <?php echo ($section == 'hero_section') ? 'active' : ''; ?>"><i class="material-icons">view_carousel</i> Hero Section</a>
                    <a href="?section=team_members" class="tab-link <?php echo ($section == 'team_members') ? 'active' : ''; ?>"><i class="material-icons">group</i> Team Members</a>
                    <a href="?section=events" class="tab-link <?php echo ($section == 'events') ? 'active' : ''; ?>"><i class="material-icons">event</i> Events</a>
                    <a href="?section=gallery" class="tab-link <?php echo ($section == 'gallery') ? 'active' : ''; ?>"><i class="material-icons">collections</i> Gallery</a>
                    <a href="?section=menu" class="tab-link <?php echo ($section == 'menu') ? 'active' : ''; ?>"><i class="material-icons">restaurant_menu</i> Menu</a>
                </div>

                <div id="hero_section" class="tab-content <?php echo ($section == 'hero_section') ? 'active' : ''; ?>">
                    <section class="content-card">
                        <h2><i class="material-icons" style="vertical-align: middle;">add_photo_alternate</i> Add New Hero Slide</h2>
                        <form action="" method="post" enctype="multipart/form-data">
                            <div class="form-group" id="hero_text_inputs">
                                <div class="form-group"><label>Title:</label><input type="text" id="hero_title" name="hero_title" placeholder="Enter slide title"></div>
                                <div class="form-group"><label>Subtitle (Optional):</label><input type="text" id="hero_subtitle" name="hero_subtitle" placeholder="Enter short subtitle"></div>
                            </div>
                            <div class="form-group">
                                <label>Media Type:</label>
                                <select id="media_type" name="media_type" required>
                                    <option value="image">Image</option>
                                    <option value="video">Video</option>
                                </select>
                            </div>
                            <div class="form-group" id="hero_image_group"><label>Image Upload:</label><input type="file" name="hero_image" accept="image/*"></div>
                            <div class="form-group" id="hero_video_group" style="display: none;"><label>Video Upload:</label><input type="file" name="hero_video" accept="video/*"></div>
                            <button type="submit" name="add_hero_slide" class="btn btn-primary"><i class="material-icons">save</i> Add Slide</button>
                        </form>
                        
                        <h3>Existing Hero Slides</h3>
                        <div class="admin-grid">
                            <?php
                            $sql = "SELECT * FROM hero_slides WHERE deleted_at IS NULL ORDER BY media_type DESC, id DESC";
                            $result = mysqli_query($link, $sql);
                            if (mysqli_num_rows($result) > 0) {
                                while($row = mysqli_fetch_assoc($result)) {
                                    echo "<div class='data-item'>";
                                    if ($row['media_type'] === 'image' && $row['image_path']) {
                                        echo "<img src='" . htmlspecialchars($row['image_path']) . "' alt='Slide Image'>";
                                    } elseif ($row['media_type'] === 'video' && $row['video_path']) {
                                        echo "<video src='" . htmlspecialchars($row['video_path']) . "' controls></video>";
                                    }
                                    echo "<div><h4>" . htmlspecialchars($row['title']) . "</h4><p>" . htmlspecialchars($row['subtitle']) . "</p></div>";
                                    echo "<div class='item-actions'>
                                            <button type='button' class='btn btn-small view-edit-btn edit-hero-btn' data-id='{$row['id']}' data-title='" . htmlspecialchars($row['title'], ENT_QUOTES) . "' data-subtitle='" . htmlspecialchars($row['subtitle'], ENT_QUOTES) . "' data-type='{$row['media_type']}'><i class='material-icons'>edit</i> Edit</button>
                                            <form action='' method='post' class='delete-form' style='flex:1;'>
                                                <input type='hidden' name='slide_id' value='{$row['id']}'>
                                                <input type='hidden' name='delete_hero_slide' value='1'>
                                                <button type='button' class='btn btn-small delete-btn delete-trigger-btn' style='width:100%;'><i class='material-icons'>delete</i> Delete</button>
                                            </form>
                                          </div>";
                                    echo "</div>";
                                }
                            } else { echo "<p style='color:#777;'>No hero slides found.</p>"; }
                            ?>
                        </div>
                    </section>
                </div>
                
                <div id="team_members" class="tab-content <?php echo ($section == 'team_members') ? 'active' : ''; ?>">
                     <section class="content-card">
                        <h2><i class="material-icons" style="vertical-align: middle;">person_add</i> Add Team Member</h2>
                        <form action="" method="post" enctype="multipart/form-data">
                            <div class="form-group"><label>Name:</label><input type="text" name="team_name" required placeholder="Full Name"></div>
                            <div class="form-group"><label>Title / Position:</label><input type="text" name="team_title" required placeholder="e.g. Head Chef"></div>
                            <div class="form-group"><label>Short Bio:</label><textarea name="team_bio" required placeholder="Brief description..."></textarea></div>
                            <div class="form-group"><label>Profile Image:</label><input type="file" name="team_image" required accept="image/*"></div>
                            <button type="submit" name="add_team_member" class="btn btn-primary"><i class="material-icons">save</i> Add Member</button>
                        </form>
                        
                        <h3>Existing Team Members</h3>
                        <div class="admin-grid">
                            <?php
                            $sql = "SELECT * FROM team WHERE deleted_at IS NULL ORDER BY id DESC";
                            $result = mysqli_query($link, $sql);
                            if (mysqli_num_rows($result) > 0) {
                                while($row = mysqli_fetch_assoc($result)) {
                                    echo "<div class='data-item' style='text-align: center;'>";
                                    if ($row['image']) { echo "<img src='" . htmlspecialchars($row['image']) . "' alt='Team Member' style='width: 140px; height: 140px; border-radius: 50%; margin: 0 auto;'>"; }
                                    echo "<div><h4>" . htmlspecialchars($row['name']) . "</h4><p style='color: #0ea5e9; font-weight: 500; margin: 4px 0;'>" . htmlspecialchars($row['title']) . "</p><p>" . htmlspecialchars($row['bio']) . "</p></div>";
                                    echo "<div class='item-actions'>
                                            <button type='button' class='btn btn-small view-edit-btn edit-team-btn' data-id='{$row['id']}' data-name='" . htmlspecialchars($row['name'], ENT_QUOTES) . "' data-title='" . htmlspecialchars($row['title'], ENT_QUOTES) . "' data-bio='" . htmlspecialchars($row['bio'], ENT_QUOTES) . "'><i class='material-icons'>edit</i> Edit</button>
                                            <form action='' method='post' class='delete-form' style='flex:1;'>
                                                <input type='hidden' name='team_id' value='{$row['id']}'>
                                                <input type='hidden' name='delete_team_member' value='1'>
                                                <button type='button' class='btn btn-small delete-btn delete-trigger-btn' style='width:100%;'><i class='material-icons'>delete</i> Delete</button>
                                            </form>
                                          </div>";
                                    echo "</div>";
                                }
                            } else { echo "<p style='color:#777;'>No team members found.</p>"; }
                            ?>
                        </div>
                    </section>
                </div>

                <div id="events" class="tab-content <?php echo ($section == 'events') ? 'active' : ''; ?>">
                    <section class="content-card">
                        <h2><i class="material-icons" style="vertical-align: middle;">event_available</i> Add New Event</h2>
                        <form action="" method="post" enctype="multipart/form-data">
                            <div class="form-group"><label>Event Title:</label><input type="text" name="event_title" required placeholder="Event Name"></div>
                            <div style="display: flex; gap: 15px;">
                                <div class="form-group" style="flex: 1;"><label>Start Date:</label><input type="date" name="event_date" required></div>
                                <div class="form-group" style="flex: 1;"><label>End Date (Optional):</label><input type="date" name="event_end_date"></div>
                            </div>
                            <div class="form-group"><label>Description:</label><textarea name="event_description" required placeholder="Event details..."></textarea></div>
                            <div class="form-group"><label>Event Poster/Banner:</label><input type="file" name="event_image" accept="image/*"></div>
                            <button type="submit" name="add_event" class="btn btn-primary"><i class="material-icons">save</i> Add Event</button>
                        </form>
                        
                        <h3>Upcoming & Past Events</h3>
                        <div class="admin-grid">
                            <?php
                            $sql = "SELECT * FROM events WHERE deleted_at IS NULL ORDER BY date DESC";
                            $result = mysqli_query($link, $sql);
                            if (mysqli_num_rows($result) > 0) {
                                while($row = mysqli_fetch_assoc($result)) {
                                    $start_date_formatted = date("M d, Y", strtotime($row['date']));
                                    $date_display = $start_date_formatted;
                                    if (!empty($row['end_date'])) {
                                        $end_date_formatted = date("M d, Y", strtotime($row['end_date']));
                                        if ($start_date_formatted !== $end_date_formatted) { $date_display .= " to " . $end_date_formatted; }
                                    }
                                    echo "<div class='data-item'>";
                                    if ($row['image']) { echo "<img src='" . htmlspecialchars($row['image']) . "' alt='Event Image'>"; }
                                    echo "<div><h4>" . htmlspecialchars($row['title']) . "</h4><p style='color: #0ea5e9; font-weight: 500; margin: 4px 0;'><i class='material-icons' style='font-size: 14px; vertical-align:middle;'>calendar_today</i> " . $date_display . "</p><p>" . htmlspecialchars($row['description']) . "</p></div>";
                                    echo "<div class='item-actions'>
                                            <button type='button' class='btn btn-small view-edit-btn edit-event-btn' data-id='{$row['id']}' data-title='" . htmlspecialchars($row['title'], ENT_QUOTES) . "' data-date='{$row['date']}' data-end-date='{$row['end_date']}' data-desc='" . htmlspecialchars($row['description'], ENT_QUOTES) . "'><i class='material-icons'>edit</i> Edit</button>
                                            <form action='' method='post' class='delete-form' style='flex:1;'>
                                                <input type='hidden' name='event_id' value='{$row['id']}'>
                                                <input type='hidden' name='delete_event' value='1'>
                                                <button type='button' class='btn btn-small delete-btn delete-trigger-btn' style='width:100%;'><i class='material-icons'>delete</i> Delete</button>
                                            </form>
                                          </div>";
                                    echo "</div>";
                                }
                            } else { echo "<p style='color:#777;'>No events found.</p>"; }
                            ?>
                        </div>
                    </section>
                </div>

                <div id="gallery" class="tab-content <?php echo ($section == 'gallery') ? 'active' : ''; ?>">
                    <section class="content-card">
                        <h2><i class="material-icons" style="vertical-align: middle;">add_photo_alternate</i> Upload Gallery Image</h2>
                        <form action="" method="post" enctype="multipart/form-data">
                            <div class="form-group"><label>Image File:</label><input type="file" name="gallery_image" required accept="image/*"></div>
                            <div class="form-group"><label>Image Caption/Description:</label><textarea name="gallery_description" required placeholder="Describe the image..."></textarea></div>
                            <button type="submit" name="add_gallery_image" class="btn btn-primary"><i class="material-icons">cloud_upload</i> Upload Image</button>
                        </form>
                        
                        <h3>Current Gallery</h3>
                        <div class="admin-grid">
                            <?php
                            $sql = "SELECT * FROM gallery WHERE deleted_at IS NULL ORDER BY id DESC";
                            $result = mysqli_query($link, $sql);
                            if (mysqli_num_rows($result) > 0) {
                                while($row = mysqli_fetch_assoc($result)) {
                                    echo "<div class='data-item'>";
                                    echo "<img src='" . htmlspecialchars($row['image']) . "' alt='Gallery Image' style='height: 220px;'>";
                                    echo "<p>" . htmlspecialchars($row['description']) . "</p>";
                                    echo "<div class='item-actions'>
                                            <button type='button' class='btn btn-small view-edit-btn edit-gallery-btn' data-id='{$row['id']}' data-desc='" . htmlspecialchars($row['description'], ENT_QUOTES) . "'><i class='material-icons'>edit</i> Edit</button>
                                            <form action='' method='post' class='delete-form' style='flex:1;'>
                                                <input type='hidden' name='gallery_id' value='{$row['id']}'>
                                                <input type='hidden' name='delete_gallery_image' value='1'>
                                                <button type='button' class='btn btn-small delete-btn delete-trigger-btn' style='width:100%;'><i class='material-icons'>delete</i> Delete</button>
                                            </form>
                                          </div>";
                                    echo "</div>";
                                }
                            } else { echo "<p style='color:#777;'>No gallery images found.</p>"; }
                            ?>
                        </div>
                    </section>
                </div>

                <div id="menu" class="tab-content <?php echo ($section == 'menu') ? 'active' : ''; ?>">
                    <section class="content-card">
                        <h2><i class="material-icons" style="vertical-align: middle;">restaurant</i> Add Menu Item</h2>
                        <form action="" method="post" enctype="multipart/form-data">
                            <div style="display:flex; gap: 15px; flex-wrap: wrap;">
                                <div class="form-group" style="flex: 1; min-width: 200px;">
                                    <label>Category:</label>
                                    <select name="menu_category" required>
                                        <option value='Specialty'>Specialty</option>
                                        <option value='Appetizer'>Appetizer</option>
                                        <option value='Breakfast'>All Day Breakfast</option>
                                        <option value='Lunch'>Ala Carte/For Sharing</option>
                                        <option value='Sizzlers'>Sizzling Plates</option>
                                        <option value='Coffee'>Cafe Drinks</option>
                                        <option value='Non-Coffee'>Non-Coffee</option>
                                        <option value='Cool Creations'>Frappe</option>
                                        <option value='Cakes'>Cakes</option>
                                    </select>
                                </div>
                                <div class="form-group" style="flex: 2; min-width: 250px;"><label>Dish Name:</label><input type="text" name="menu_name" required placeholder="e.g. Tavern Burger"></div>
                                <div class="form-group" style="flex: 1; min-width: 150px;"><label>Price (₱):</label><input type="number" name="menu_price" step="0.01" min="0" required placeholder="0.00"></div>
                            </div>
                            <div class="form-group"><label>Description:</label><textarea name="menu_description" required placeholder="Ingredients, flavor profile..."></textarea></div>
                            <div class="form-group"><label>Food Image:</label><input type="file" name="menu_image" accept="image/*"></div>
                            <button type="submit" name="add_menu_item" class="btn btn-primary"><i class="material-icons">save</i> Add to Menu</button>
                        </form>
                        
                        <h3>Current Menu</h3>
                        <nav class="menu-nav">
                            <a href="#" class="menu-nav-link active" data-category="all">View All</a>
                            <a href="#" class="menu-nav-link" data-category="Specialty">Specialty</a>
                            <a href="#" class="menu-nav-link" data-category="Appetizer">Appetizer</a>
                            <a href="#" class="menu-nav-link" data-category="Breakfast">Breakfast</a>
                            <a href="#" class="menu-nav-link" data-category="Lunch">Ala Carte</a>
                            <a href="#" class="menu-nav-link" data-category="Sizzlers">Sizzlers</a>
                            <a href="#" class="menu-nav-link" data-category="Coffee">Coffee</a>
                            <a href="#" class="menu-nav-link" data-category="Non-Coffee">Non-Coffee</a>
                            <a href="#" class="menu-nav-link" data-category="Cool Creations">Frappe</a>
                            <a href="#" class="menu-nav-link" data-category="Cakes">Cakes</a>
                        </nav>

                        <div class="menu-container">
                            <?php
                            $sql_menu = "SELECT * FROM menu WHERE deleted_at IS NULL ORDER BY category, name ASC";
                            $result_menu = mysqli_query($link, $sql_menu);
                            if (mysqli_num_rows($result_menu) > 0) {
                                $menu_items_by_category = [];
                                while($row_menu = mysqli_fetch_assoc($result_menu)) { $menu_items_by_category[$row_menu['category']][] = $row_menu; }

                                foreach ($menu_items_by_category as $category => $items) {
                                    echo "<div class='category-items-wrapper' data-category='" . htmlspecialchars($category) . "'>";
                                    echo "<h4 style='color: #333; margin: 30px 0 15px; border-bottom: 2px solid #0ea5e9; padding-bottom: 5px; display: inline-block;'>" . htmlspecialchars($category) . "</h4>";
                                    echo "<div class='admin-grid'>";
                                    foreach ($items as $row) {
                                        echo "<div class='data-item'>";
                                        if ($row['image']) { echo "<img src='" . htmlspecialchars($row['image']) . "' alt='Menu Image'>"; }
                                        echo "<div>";
                                        echo "<div style='display:flex; justify-content:space-between; align-items:flex-start;'>";
                                        echo "<h4 style='margin-right:10px;'>" . htmlspecialchars($row['name']) . "</h4>";
                                        echo "<span style='background:#ecfdf5; color:#059669; font-weight:700; padding:4px 8px; border-radius:6px; font-size:14px; white-space:nowrap;'>₱" . number_format($row['price'], 2) . "</span>";
                                        echo "</div>";
                                        echo "<p style='margin-top: 8px;'>" . htmlspecialchars($row['description']) . "</p>";
                                        echo "</div>";
                                        echo "<div class='item-actions'>
                                                <button type='button' class='btn btn-small view-edit-btn edit-menu-btn' data-id='{$row['id']}' data-name='" . htmlspecialchars($row['name'], ENT_QUOTES) . "' data-cat='{$row['category']}' data-price='{$row['price']}' data-desc='" . htmlspecialchars($row['description'], ENT_QUOTES) . "'><i class='material-icons'>edit</i> Edit</button>
                                                <form action='' method='post' class='delete-form' style='flex:1;'>
                                                    <input type='hidden' name='menu_id' value='{$row['id']}'>
                                                    <input type='hidden' name='delete_menu_item' value='1'>
                                                    <button type='button' class='btn btn-small delete-btn delete-trigger-btn' style='width:100%;'><i class='material-icons'>delete</i> Delete</button>
                                                </form>
                                              </div>";
                                        echo "</div>";
                                    }
                                    echo "</div></div>";
                                }
                            } else { echo "<p style='color:#777;'>No menu items found.</p>"; }
                            ?>
                        </div>
                    </section>
                </div>

            </main>
        </div>
    </div>
    
    <div id="editHeroModal" class="modal">
        <div class="modal-content">
            <div class="modal-header"><h2>Edit Hero Slide</h2><button class="close-button">&times;</button></div>
            <div class="modal-body">
                <form action="" method="post" enctype="multipart/form-data" id="editHeroForm">
                    <input type="hidden" name="edit_slide_id" id="edit_hero_id">
                    <input type="hidden" name="edit_media_type" id="edit_hero_media_type">
                    <div class="form-group"><label>Title:</label><input type="text" name="edit_hero_title" id="edit_hero_title"></div>
                    <div class="form-group"><label>Subtitle:</label><input type="text" name="edit_hero_subtitle" id="edit_hero_subtitle"></div>
                    <div class="form-group" id="edit_hero_image_group"><label>Replace Image (Leave blank to keep current):</label><input type="file" name="edit_hero_image" accept="image/*"></div>
                    <div class="form-group" id="edit_hero_video_group" style="display:none;"><label>Replace Video (Leave blank to keep current):</label><input type="file" name="edit_hero_video" accept="video/*"></div>
                </form>
            </div>
            <div class="modal-actions">
                <button type="submit" form="editHeroForm" name="edit_hero_slide" class="btn btn-primary"><i class="material-icons">save</i> Save Changes</button>
            </div>
        </div>
    </div>

    <div id="editTeamModal" class="modal">
        <div class="modal-content">
            <div class="modal-header"><h2>Edit Team Member</h2><button class="close-button">&times;</button></div>
            <div class="modal-body">
                <form action="" method="post" enctype="multipart/form-data" id="editTeamForm">
                    <input type="hidden" name="edit_team_id" id="edit_team_id">
                    <div class="form-group"><label>Name:</label><input type="text" name="edit_team_name" id="edit_team_name" required></div>
                    <div class="form-group"><label>Title / Position:</label><input type="text" name="edit_team_title" id="edit_team_title" required></div>
                    <div class="form-group"><label>Short Bio:</label><textarea name="edit_team_bio" id="edit_team_bio" required></textarea></div>
                    <div class="form-group"><label>Replace Profile Image (Leave blank to keep current):</label><input type="file" name="edit_team_image" accept="image/*"></div>
                </form>
            </div>
            <div class="modal-actions">
                <button type="submit" form="editTeamForm" name="edit_team_member" class="btn btn-primary"><i class="material-icons">save</i> Save Changes</button>
            </div>
        </div>
    </div>

    <div id="editEventModal" class="modal">
        <div class="modal-content">
            <div class="modal-header"><h2>Edit Event</h2><button class="close-button">&times;</button></div>
            <div class="modal-body">
                <form action="" method="post" enctype="multipart/form-data" id="editEventForm">
                    <input type="hidden" name="edit_event_id" id="edit_event_id">
                    <div class="form-group"><label>Event Title:</label><input type="text" name="edit_event_title" id="edit_event_title" required></div>
                    <div style="display: flex; gap: 15px;">
                        <div class="form-group" style="flex: 1;"><label>Start Date:</label><input type="date" name="edit_event_date" id="edit_event_date" required></div>
                        <div class="form-group" style="flex: 1;"><label>End Date (Optional):</label><input type="date" name="edit_event_end_date" id="edit_event_end_date"></div>
                    </div>
                    <div class="form-group"><label>Description:</label><textarea name="edit_event_description" id="edit_event_description" required></textarea></div>
                    <div class="form-group"><label>Replace Poster (Leave blank to keep current):</label><input type="file" name="edit_event_image" accept="image/*"></div>
                </form>
            </div>
            <div class="modal-actions">
                <button type="submit" form="editEventForm" name="edit_event" class="btn btn-primary"><i class="material-icons">save</i> Save Changes</button>
            </div>
        </div>
    </div>

    <div id="editGalleryModal" class="modal">
        <div class="modal-content">
            <div class="modal-header"><h2>Edit Gallery Image</h2><button class="close-button">&times;</button></div>
            <div class="modal-body">
                <form action="" method="post" enctype="multipart/form-data" id="editGalleryForm">
                    <input type="hidden" name="edit_gallery_id" id="edit_gallery_id">
                    <div class="form-group"><label>Description/Caption:</label><textarea name="edit_gallery_description" id="edit_gallery_desc" required></textarea></div>
                    <div class="form-group"><label>Replace Image (Leave blank to keep current):</label><input type="file" name="edit_gallery_file" accept="image/*"></div>
                </form>
            </div>
            <div class="modal-actions">
                <button type="submit" form="editGalleryForm" name="edit_gallery_image" class="btn btn-primary"><i class="material-icons">save</i> Save Changes</button>
            </div>
        </div>
    </div>

    <div id="editMenuModal" class="modal">
        <div class="modal-content">
            <div class="modal-header"><h2>Edit Menu Item</h2><button class="close-button">&times;</button></div>
            <div class="modal-body">
                <form action="" method="post" enctype="multipart/form-data" id="editMenuForm">
                    <input type="hidden" name="edit_menu_id" id="edit_menu_id">
                    <div style="display:flex; gap: 15px; flex-wrap: wrap;">
                        <div class="form-group" style="flex: 1; min-width: 150px;">
                            <label>Category:</label>
                            <select name="edit_menu_category" id="edit_menu_category" required>
                                <option value='Specialty'>Specialty</option>
                                <option value='Appetizer'>Appetizer</option>
                                <option value='Breakfast'>All Day Breakfast</option>
                                <option value='Lunch'>Ala Carte/For Sharing</option>
                                <option value='Sizzlers'>Sizzling Plates</option>
                                <option value='Coffee'>Cafe Drinks</option>
                                <option value='Non-Coffee'>Non-Coffee</option>
                                <option value='Cool Creations'>Frappe</option>
                                <option value='Cakes'>Cakes</option>
                            </select>
                        </div>
                        <div class="form-group" style="flex: 2; min-width: 200px;"><label>Dish Name:</label><input type="text" name="edit_menu_name" id="edit_menu_name" required></div>
                        <div class="form-group" style="flex: 1; min-width: 100px;"><label>Price (₱):</label><input type="number" name="edit_menu_price" id="edit_menu_price" step="0.01" min="0" required></div>
                    </div>
                    <div class="form-group"><label>Description:</label><textarea name="edit_menu_description" id="edit_menu_description" required></textarea></div>
                    <div class="form-group"><label>Replace Image (Leave blank to keep current):</label><input type="file" name="edit_menu_image" accept="image/*"></div>
                </form>
            </div>
            <div class="modal-actions">
                <button type="submit" form="editMenuForm" name="edit_menu_item" class="btn btn-primary"><i class="material-icons">save</i> Save Changes</button>
            </div>
        </div>
    </div>


    <div id="confirmDeleteModal" class="modal">
        <div class="modal-content" style="max-width: 400px; text-align:center;">
            <div class="modal-header" style="border:none; justify-content: flex-end; padding-bottom: 0;"><button class="close-button">&times;</button></div>
            <div class="modal-body" style="padding-top: 0;">
                <i class="material-icons" style="font-size: 60px; color: #f5b301; margin-bottom: 15px;">help_outline</i>
                <h2 style="margin-bottom: 10px;">Confirm Deletion</h2>
                <p>Move this item to the deletion history? It can be restored later from the archive.</p>
            </div>
            <div class="modal-actions" style="justify-content: center; background: #fff; border-top:none;">
                <button type="button" class="btn" id="cancelDeleteBtn" style="background-color: #f1f5f9; color: #475569;">Cancel</button>
                <button type="button" class="btn delete-btn" id="confirmDeleteBtn">Yes, Delete</button>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', () => {
            // --- UI Interactions ---
            const mediaTypeSelect = document.getElementById('media_type');
            const heroImageGroup = document.getElementById('hero_image_group');
            const heroVideoGroup = document.getElementById('hero_video_group');
            const heroTextInputs = document.getElementById('hero_text_inputs');
            
            if (mediaTypeSelect) {
                mediaTypeSelect.addEventListener('change', () => {
                    if (mediaTypeSelect.value === 'image') {
                        heroImageGroup.style.display = 'block'; heroVideoGroup.style.display = 'none'; heroTextInputs.style.display = 'block';
                    } else {
                        heroImageGroup.style.display = 'none'; heroVideoGroup.style.display = 'block'; heroTextInputs.style.display = 'none';
                    }
                });
            }

            // --- Delete Confirmation ---
            const confirmDeleteModal = document.getElementById('confirmDeleteModal');
            const confirmDeleteBtn = document.getElementById('confirmDeleteBtn');
            const cancelDeleteBtn = document.getElementById('cancelDeleteBtn');
            const deleteTriggerButtons = document.querySelectorAll('.delete-trigger-btn');
            let formToSubmit = null;

            deleteTriggerButtons.forEach(button => {
                button.addEventListener('click', (e) => {
                    e.preventDefault();
                    formToSubmit = e.target.closest('form');
                    if (confirmDeleteModal) confirmDeleteModal.style.display = 'flex';
                });
            });

            if (confirmDeleteBtn) confirmDeleteBtn.addEventListener('click', () => { if (formToSubmit) formToSubmit.submit(); });
            if (cancelDeleteBtn) cancelDeleteBtn.addEventListener('click', () => { confirmDeleteModal.style.display = 'none'; formToSubmit = null; });

            // --- Flash Messages ---
            const messageBox = document.getElementById('message-box');
            <?php
            if (isset($_SESSION['message'])) {
                echo "if(messageBox) { messageBox.textContent = '{$_SESSION['message']}'; messageBox.style.display = 'block'; setTimeout(() => { messageBox.style.opacity = '1'; }, 10); setTimeout(() => { messageBox.style.opacity = '0'; }, 3000); setTimeout(() => { messageBox.style.display = 'none'; }, 3500); }";
                unset($_SESSION['message']);
            }
            ?>

            // --- Menu Category Filtering ---
            const menuNavLinks = document.querySelectorAll('.menu-nav-link');
            const categoryWrappers = document.querySelectorAll('.category-items-wrapper');

            menuNavLinks.forEach(link => {
                link.addEventListener('click', (e) => {
                    e.preventDefault();
                    menuNavLinks.forEach(l => l.classList.remove('active'));
                    link.classList.add('active');
                    const selectedCategory = link.dataset.category;
                    categoryWrappers.forEach(wrapper => {
                        if (selectedCategory === 'all' || wrapper.dataset.category === selectedCategory) {
                            wrapper.style.display = 'block';
                        } else {
                            wrapper.style.display = 'none';
                        }
                    });
                });
            });

            // --- EDIT MODALS LOGIC ---
            function openModal(modalId) { document.getElementById(modalId).style.display = 'flex'; }
            
            // Close Modals setup
            document.querySelectorAll('.close-button').forEach(btn => {
                btn.addEventListener('click', function() { this.closest('.modal').style.display = 'none'; });
            });
            window.addEventListener('click', (event) => {
                if (event.target.classList.contains('modal')) event.target.style.display = 'none';
            });

            // Edit Hero
            document.querySelectorAll('.edit-hero-btn').forEach(btn => {
                btn.addEventListener('click', function() {
                    document.getElementById('edit_hero_id').value = this.dataset.id;
                    document.getElementById('edit_hero_title').value = this.dataset.title;
                    document.getElementById('edit_hero_subtitle').value = this.dataset.subtitle;
                    document.getElementById('edit_hero_media_type').value = this.dataset.type;
                    
                    if(this.dataset.type === 'image') {
                        document.getElementById('edit_hero_image_group').style.display = 'block';
                        document.getElementById('edit_hero_video_group').style.display = 'none';
                    } else {
                        document.getElementById('edit_hero_image_group').style.display = 'none';
                        document.getElementById('edit_hero_video_group').style.display = 'block';
                    }
                    openModal('editHeroModal');
                });
            });

            // Edit Team
            document.querySelectorAll('.edit-team-btn').forEach(btn => {
                btn.addEventListener('click', function() {
                    document.getElementById('edit_team_id').value = this.dataset.id;
                    document.getElementById('edit_team_name').value = this.dataset.name;
                    document.getElementById('edit_team_title').value = this.dataset.title;
                    document.getElementById('edit_team_bio').value = this.dataset.bio;
                    openModal('editTeamModal');
                });
            });

            // Edit Event
            document.querySelectorAll('.edit-event-btn').forEach(btn => {
                btn.addEventListener('click', function() {
                    document.getElementById('edit_event_id').value = this.dataset.id;
                    document.getElementById('edit_event_title').value = this.dataset.title;
                    document.getElementById('edit_event_date').value = this.dataset.date;
                    document.getElementById('edit_event_end_date').value = this.dataset.endDate;
                    document.getElementById('edit_event_description').value = this.dataset.desc;
                    openModal('editEventModal');
                });
            });

            // Edit Gallery
            document.querySelectorAll('.edit-gallery-btn').forEach(btn => {
                btn.addEventListener('click', function() {
                    document.getElementById('edit_gallery_id').value = this.dataset.id;
                    document.getElementById('edit_gallery_desc').value = this.dataset.desc;
                    openModal('editGalleryModal');
                });
            });

            // Edit Menu
            document.querySelectorAll('.edit-menu-btn').forEach(btn => {
                btn.addEventListener('click', function() {
                    document.getElementById('edit_menu_id').value = this.dataset.id;
                    document.getElementById('edit_menu_name').value = this.dataset.name;
                    document.getElementById('edit_menu_category').value = this.dataset.cat;
                    document.getElementById('edit_menu_price').value = this.dataset.price;
                    document.getElementById('edit_menu_description').value = this.dataset.desc;
                    openModal('editMenuModal');
                });
            });

        });
    </script>
    <script>
    document.addEventListener('DOMContentLoaded', () => {
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
                        messageCountBadge.textContent = data.new_messages; messageCountBadge.style.display = 'block';
                    } else { messageCountBadge.style.display = 'none'; }
                    messageDropdown.innerHTML = data.messages_html;

                    if (data.pending_reservations > 0) {
                        reservationCountBadge.textContent = data.pending_reservations; reservationCountBadge.style.display = 'block';
                    } else { reservationCountBadge.style.display = 'none'; }
                    reservationDropdown.innerHTML = data.reservations_html;
                }
            } catch (error) { console.error('Error fetching admin notifications:', error); }
        }

        if (messageBtn) messageBtn.addEventListener('click', (e) => { e.stopPropagation(); if (reservationDropdown) reservationDropdown.classList.remove('show'); if (adminProfileDropdown) adminProfileDropdown.classList.remove('show'); if (messageDropdown) messageDropdown.classList.toggle('show'); });
        if (reservationBtn) reservationBtn.addEventListener('click', (e) => { e.stopPropagation(); if (messageDropdown) messageDropdown.classList.remove('show'); if (adminProfileDropdown) adminProfileDropdown.classList.remove('show'); if (reservationDropdown) reservationDropdown.classList.toggle('show'); });
        if (adminProfileBtn) adminProfileBtn.addEventListener('click', (e) => { e.stopPropagation(); if (messageDropdown) messageDropdown.classList.remove('show'); if (reservationDropdown) reservationDropdown.classList.remove('show'); if (adminProfileDropdown) adminProfileDropdown.classList.toggle('show'); });
        
        window.addEventListener('click', () => {
            if (messageDropdown) messageDropdown.classList.remove('show');
            if (reservationDropdown) reservationDropdown.classList.remove('show');
            if (adminProfileDropdown) adminProfileDropdown.classList.remove('show'); 
        });
        
        [messageDropdown, reservationDropdown, adminProfileDropdown].forEach(dropdown => {
            if (dropdown) dropdown.addEventListener('click', (e) => { if (!e.target.classList.contains('admin-notification-dismiss')) { e.stopPropagation(); } });
        });

        async function handleDismiss(e) {
            if (!e.target.classList.contains('admin-notification-dismiss')) return;
            e.preventDefault(); e.stopPropagation();
            const button = e.target; const id = button.dataset.id; const type = button.dataset.type; const itemWrapper = button.parentElement;
            const formData = new FormData(); formData.append('id', id); formData.append('type', type);

            try {
                const response = await fetch('/clear_admin_notification', { method: 'POST', body: formData }); 
                const result = await response.json();
                if (result.success) {
                    itemWrapper.style.transition = 'opacity 0.3s ease, transform 0.3s ease'; itemWrapper.style.opacity = '0'; itemWrapper.style.transform = 'translateX(-20px)';
                    setTimeout(() => { itemWrapper.remove(); fetchAdminNotifications(); }, 300);
                }
            } catch (error) { console.error('Error dismissing notification:', error); }
        }

        if (messageDropdown) messageDropdown.addEventListener('click', handleDismiss);
        if (reservationDropdown) reservationDropdown.addEventListener('click', handleDismiss);

        fetchAdminNotifications(); setInterval(fetchAdminNotifications, 30000); 
    });
    </script>
</body>
</html>
<?php
mysqli_close($link);
ob_end_flush();
?>