-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 10, 2025 at 05:40 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `tavern_publico`
--

-- --------------------------------------------------------

--
-- Table structure for table `blocked_dates`
--

CREATE TABLE `blocked_dates` (
  `id` int(11) NOT NULL,
  `block_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `blocked_dates`
--

INSERT INTO `blocked_dates` (`id`, `block_date`) VALUES
(22, '2025-10-12'),
(23, '2025-10-13'),
(24, '2025-10-14'),
(32, '2025-10-18');

-- --------------------------------------------------------

--
-- Table structure for table `blocked_slots`
--

CREATE TABLE `blocked_slots` (
  `block_id` int(11) NOT NULL,
  `block_reason` varchar(255) NOT NULL,
  `block_date` date NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `assigned_table` varchar(50) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `contact_messages`
--

CREATE TABLE `contact_messages` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `message` text NOT NULL,
  `admin_reply` text DEFAULT NULL,
  `replied_at` timestamp NULL DEFAULT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `contact_messages`
--

INSERT INTO `contact_messages` (`id`, `name`, `email`, `subject`, `message`, `admin_reply`, `replied_at`, `is_read`, `created_at`, `deleted_at`) VALUES
(5, 'user', 'penapaul858@gmail.com', 'reservation', 'good night', 'Good', '2025-09-26 16:13:46', 1, '2025-09-26 16:13:22', NULL),
(6, 'user', 'penapaul858@gmail.com', 'reservation', 'I want to rreserve', 'You\'ve found a PHP warning bug. The error messages you\'re seeing, \"Constant DB_SERVER already defined', '2025-09-26 17:04:36', 1, '2025-09-26 17:04:03', NULL),
(7, 'dfgh', '12jfksdfvk@gmail.com', 'dfg', 'dwfg', NULL, '2025-10-14 15:26:21', 1, '2025-09-27 06:54:57', NULL),
(8, 'fgh', '123454@gmail.com', 'Reservation Inquiry', 'efghjcvb', NULL, '2025-10-16 16:41:17', 1, '2025-09-27 06:59:18', NULL),
(9, 'admin', 'keycm109@gmail.com', 'Reservation Inquiry', 'HELLLO', 'sdfgh', '2025-09-28 12:44:50', 1, '2025-09-27 15:02:49', '2025-09-28 20:43:08'),
(10, 'user', 'penapaul858@gmail.com', 'Reservation Inquiry', 'Of course. I\'ve updated the notification_control.php file to include a \"View\" button for both messages and comments. Clicking this button will open a modal window displaying the full text, which is especially useful for longer entries.', 'joshua', '2025-09-29 07:41:34', 1, '2025-09-28 10:00:07', '2025-09-29 16:03:19'),
(11, 'Vincent paul D Pena', 'keycm109@gmail.com', 'Reservation Inquiry', 'HI i would know it your are reserve for oct 9 2025?', 'yes', '2025-10-09 12:07:01', 1, '2025-10-09 12:01:07', NULL),
(12, 'Vincent paul D Pena', 'penapaul858@gmail.com', 'Reservation Inquiry', 'HI hello good evening', 'karllllllll', '2025-10-13 04:22:29', 1, '2025-10-10 03:13:00', NULL),
(13, 'Vincent paul D Pena', 'penapaul858@gmail.com', 'Reservation Inquiry', 'hi', NULL, '2025-10-16 16:41:16', 1, '2025-10-14 17:21:35', NULL),
(14, 'user', 'penapaul858@gmail.com', 'Reservation Inquiry', 'Helllo', 'hi', '2025-10-19 04:02:43', 1, '2025-10-19 04:01:43', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `coupons`
--

CREATE TABLE `coupons` (
  `id` int(11) NOT NULL,
  `code` varchar(50) NOT NULL,
  `type` enum('percent','fixed') NOT NULL,
  `value` decimal(10,2) NOT NULL,
  `expiry_date` date DEFAULT NULL,
  `usage_limit` int(11) NOT NULL DEFAULT 100,
  `current_usage` int(11) NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `coupons`
--

INSERT INTO `coupons` (`id`, `code`, `type`, `value`, `expiry_date`, `usage_limit`, `current_usage`, `is_active`) VALUES
(1, 'TAVERN10', 'percent', 10.00, '2025-11-10', 2, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `deletion_history`
--

CREATE TABLE `deletion_history` (
  `log_id` int(11) NOT NULL,
  `item_type` varchar(50) NOT NULL,
  `item_id` int(11) NOT NULL,
  `item_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `deleted_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `purge_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `deletion_history`
--

INSERT INTO `deletion_history` (`log_id`, `item_type`, `item_id`, `item_data`, `deleted_at`, `purge_date`) VALUES
(3, 'contact_message', 9, '{\"id\":9,\"name\":\"admin\",\"email\":\"keycm109@gmail.com\",\"subject\":\"Reservation Inquiry\",\"message\":\"HELLLO\",\"admin_reply\":\"HElllo Karlll Louis\",\"replied_at\":\"2025-09-27 23:03:15\",\"is_read\":1,\"created_at\":\"2025-09-27 23:02:49\",\"deleted_at\":null}', '2025-09-28 12:43:08', '2025-10-28'),
(6, 'event', 7, '{\"id\":7,\"title\":\"dfghjkl\",\"date\":\"275760-07-06\",\"end_date\":null,\"description\":\"hgfdsdf\",\"image\":\"uploads\\/68d62b59851c63.68834595.png\",\"deleted_at\":null}', '2025-09-28 12:56:56', '2025-10-28'),
(7, 'menu_item', 24, '{\"id\":24,\"name\":\"ertgh\",\"category\":\"Specialty\",\"price\":\"400.00\",\"image\":\"uploads\\/68d6d906e925d9.11936485.jpg\",\"description\":\"dfg\",\"deleted_at\":null}', '2025-09-28 13:03:04', '2025-10-28'),
(8, 'testimonial', 2, '{\"id\":2,\"user_id\":14,\"reservation_id\":18,\"rating\":3,\"comment\":\"Based on the code, the rating feature will only appear on the homepage under specific conditions. It is not visible in your screenshot because one or more of the following requirements have not been met:\",\"is_featured\":1,\"created_at\":\"2025-09-26 23:04:18\",\"deleted_at\":null}', '2025-09-28 13:12:53', '2025-10-28'),
(9, 'testimonial', 3, '{\"id\":3,\"user_id\":14,\"reservation_id\":24,\"rating\":3,\"comment\":\"dfghn\",\"is_featured\":1,\"created_at\":\"2025-09-27 02:02:39\",\"deleted_at\":null}', '2025-09-28 13:20:14', '2025-10-28'),
(10, 'gallery_image', 12, '{\"id\":12,\"image\":\"uploads\\/68d62b9ea7afe7.31026399.png\",\"description\":\"seiokjhgfdsxcvbnmjhfdxcv\",\"deleted_at\":null}', '2025-09-28 13:23:23', '2025-10-28'),
(12, 'event', 9, '{\"id\":9,\"title\":\"Hallowen\",\"date\":\"2025-11-01\",\"end_date\":\"2025-11-05\",\"description\":\"Happ Halloween\",\"image\":\"uploads\\/68d9326184f316.63890607.jpeg\",\"deleted_at\":null}', '2025-09-29 03:28:20', '2025-10-29'),
(13, 'event', 10, '{\"id\":10,\"title\":\"Birthday ko ngayon\",\"date\":\"2025-09-30\",\"end_date\":\"2025-09-29\",\"description\":\"Anjing\",\"image\":\"uploads\\/68d9fd838946c2.41190803.png\",\"deleted_at\":null}', '2025-09-29 03:31:53', '2025-10-29'),
(14, 'testimonial', 6, '{\"id\":6,\"user_id\":14,\"reservation_id\":30,\"rating\":2,\"comment\":\"thank you\",\"is_featured\":1,\"created_at\":\"2025-09-29 15:39:51\",\"deleted_at\":null}', '2025-09-29 07:46:02', '2025-10-29'),
(15, 'blocked_date', 12, '{\"id\":12,\"block_date\":\"2025-09-29\"}', '2025-09-29 07:47:39', '2025-10-29'),
(16, 'blocked_date', 11, '{\"id\":11,\"block_date\":\"2025-09-28\"}', '2025-09-29 07:47:48', '2025-10-29'),
(17, 'blocked_date', 13, '{\"id\":13,\"block_date\":\"2025-09-30\"}', '2025-09-29 07:47:52', '2025-10-29'),
(18, 'blocked_date', 15, '{\"id\":15,\"block_date\":\"2025-10-02\"}', '2025-09-29 07:47:56', '2025-10-29'),
(19, 'blocked_date', 16, '{\"id\":16,\"block_date\":\"2025-09-29\"}', '2025-09-29 07:48:31', '2025-10-29'),
(20, 'blocked_date', 17, '{\"id\":17,\"block_date\":\"2025-08-07\"}', '2025-09-29 07:49:01', '2025-10-29'),
(21, 'contact_message', 10, '{\"id\":10,\"name\":\"user\",\"email\":\"penapaul858@gmail.com\",\"subject\":\"Reservation Inquiry\",\"message\":\"Of course. I\'ve updated the notification_control.php file to include a \\\"View\\\" button for both messages and comments. Clicking this button will open a modal window displaying the full text, which is especially useful for longer entries.\",\"admin_reply\":\"joshua\",\"replied_at\":\"2025-09-29 15:41:34\",\"is_read\":1,\"created_at\":\"2025-09-28 18:00:07\",\"deleted_at\":null}', '2025-09-29 08:03:19', '2025-10-29'),
(22, 'hero_slide', 15, '{\"id\":15,\"image_path\":\"uploads\\/68da9aa16c43f7.95794272.jpeg\",\"title\":\"HEllo\",\"subtitle\":\"cvbn\",\"video_path\":\"\",\"media_type\":\"image\",\"created_at\":\"2025-09-29 22:41:37\",\"deleted_at\":null}', '2025-09-29 17:47:48', '2025-10-30'),
(23, 'hero_slide', 14, '{\"id\":14,\"image_path\":\"uploads\\/68da9a94154ec6.29158311.jpeg\",\"title\":\"Tavern Publico\",\"subtitle\":\"fghjk\",\"video_path\":\"\",\"media_type\":\"image\",\"created_at\":\"2025-09-29 22:41:24\",\"deleted_at\":null}', '2025-09-29 17:47:51', '2025-10-30'),
(24, 'hero_slide', 17, '{\"id\":17,\"image_path\":\"uploads\\/68dac695b68195.67723369.jpg\",\"title\":\"2nd\",\"subtitle\":\"AWRSDSSSSSS\",\"video_path\":\"\",\"media_type\":\"image\",\"created_at\":\"2025-09-30 01:49:09\",\"deleted_at\":null}', '2025-09-29 17:50:20', '2025-10-30'),
(25, 'menu_item', 25, '{\"id\":25,\"name\":\"ert\",\"category\":\"Specialty\",\"price\":\"34.00\",\"image\":\"uploads\\/68d6d914ba4907.26884802.png\",\"description\":\"wertghj\",\"deleted_at\":null}', '2025-09-29 17:57:08', '2025-10-30'),
(26, 'menu_item', 18, '{\"id\":18,\"name\":\"sdfgh\",\"category\":\"Specialty\",\"price\":\"34.00\",\"image\":\"uploads\\/68d6239f7c51c5.11311157.png\",\"description\":\"dfgh\",\"deleted_at\":null}', '2025-09-29 17:57:15', '2025-10-30'),
(27, 'menu_item', 23, '{\"id\":23,\"name\":\"wdefg\",\"category\":\"Specialty\",\"price\":\"2.00\",\"image\":\"uploads\\/68d6d8f85b38e2.02182447.png\",\"description\":\"defgh\",\"deleted_at\":null}', '2025-09-29 17:57:20', '2025-10-30'),
(28, 'menu_item', 26, '{\"id\":26,\"name\":\"caramel\",\"category\":\"Coffee\",\"price\":\"85.00\",\"image\":\"uploads\\/68d9329e59bee4.03672499.jpg\",\"description\":\"yummy\",\"deleted_at\":null}', '2025-09-29 18:03:29', '2025-10-30'),
(29, 'menu_item', 22, '{\"id\":22,\"name\":\"asdf\",\"category\":\"Lunch\",\"price\":\"234.00\",\"image\":\"uploads\\/68d657427b8541.26434268.png\",\"description\":\"sdfghgfdvb\",\"deleted_at\":null}', '2025-09-29 18:03:32', '2025-10-30'),
(30, 'menu_item', 21, '{\"id\":21,\"name\":\"cfe\",\"category\":\"Lunch\",\"price\":\"23.00\",\"image\":\"uploads\\/68d62a9ca42191.99713898.png\",\"description\":\"Completely replace the code in your update.php file with this corrected version. The only change is to the sanitize function.\",\"deleted_at\":null}', '2025-09-29 18:03:34', '2025-10-30'),
(31, 'testimonial', 7, '{\"id\":7,\"user_id\":14,\"reservation_id\":27,\"rating\":3,\"comment\":\"You are right! My apologies, it looks like a default style from the icon library was overriding the rule meant to hide the icon on desktops.\\r\\n\\r\\nLet&#039;s apply a more specific and forceful CSS rule to fix this immediately.\",\"is_featured\":0,\"created_at\":\"2025-09-30 00:29:04\",\"deleted_at\":null}', '2025-09-29 18:13:05', '2025-10-30'),
(32, 'event', 8, '{\"id\":8,\"title\":\"Chrismast\",\"date\":\"2025-12-21\",\"end_date\":\"2025-12-25\",\"description\":\"My apologies. I shortened the code in my last response to make it easier to copy, but I see now that you\'d prefer to see it fully formatted. You are correct, no functionality was removed, it was only compressed.\",\"image\":\"uploads\\/68d62ec99388d6.32195318.png\",\"deleted_at\":null}', '2025-09-29 18:15:27', '2025-10-30'),
(40, 'hero_slide', 20, '{\"id\":20,\"image_path\":\"uploads\\/68e513aa9904e0.41391680.jpg\",\"title\":\"sd\",\"subtitle\":\"df\",\"video_path\":\"\",\"media_type\":\"image\",\"created_at\":\"2025-10-07 21:20:42\",\"deleted_at\":null}', '2025-10-07 13:50:31', '2025-11-06'),
(41, 'hero_slide', 19, '{\"id\":19,\"image_path\":\"uploads\\/68e5139a218796.02181646.jpg\",\"title\":\"food\",\"subtitle\":\"AWRSDSSSSSS\",\"video_path\":\"\",\"media_type\":\"image\",\"created_at\":\"2025-10-07 21:20:26\",\"deleted_at\":null}', '2025-10-07 13:50:35', '2025-11-06'),
(42, 'hero_slide', 12, '{\"id\":12,\"image_path\":\"uploads\\/68d80a5b4966f3.20083863.jpg\",\"title\":\"Tavern Publico\",\"subtitle\":\"Where good company gathers\",\"video_path\":\"\",\"media_type\":\"image\",\"created_at\":\"2025-09-28 00:01:31\",\"deleted_at\":null}', '2025-10-07 14:07:32', '2025-11-06'),
(43, 'hero_slide', 18, '{\"id\":18,\"image_path\":\"uploads\\/68dac70392b650.98291033.jpg\",\"title\":\"3\",\"subtitle\":\"efg\",\"video_path\":\"\",\"media_type\":\"image\",\"created_at\":\"2025-09-30 01:50:59\",\"deleted_at\":null}', '2025-10-07 14:07:34', '2025-11-06'),
(44, 'hero_slide', 16, '{\"id\":16,\"image_path\":\"uploads\\/68dac667d90566.26397573.jpg\",\"title\":\"1st\",\"subtitle\":\"2nd\",\"video_path\":\"\",\"media_type\":\"image\",\"created_at\":\"2025-09-30 01:48:23\",\"deleted_at\":null}', '2025-10-07 14:07:37', '2025-11-06'),
(45, 'blocked_date', 19, '{\"id\":19,\"block_date\":\"2025-10-07\"}', '2025-10-08 14:25:28', '2025-11-07'),
(47, 'blocked_date', 18, '{\"id\":18,\"block_date\":\"2025-09-29\"}', '2025-10-09 14:09:11', '2025-11-08'),
(66, 'blocked_date', 20, '{\"id\":20,\"block_date\":\"2025-10-10\"}', '2025-10-09 16:26:15', '2025-11-09'),
(71, 'blocked_date', 21, '{\"id\":21,\"block_date\":\"2025-10-12\"}', '2025-10-12 15:41:39', '2025-11-11'),
(72, 'blocked_date', 31, '{\"id\":31,\"block_date\":\"2025-10-21\"}', '2025-10-12 15:42:16', '2025-11-11'),
(73, 'blocked_date', 30, '{\"id\":30,\"block_date\":\"2025-10-20\"}', '2025-10-12 15:42:18', '2025-11-11'),
(74, 'blocked_date', 29, '{\"id\":29,\"block_date\":\"2025-10-19\"}', '2025-10-12 15:42:22', '2025-11-11'),
(75, 'blocked_date', 28, '{\"id\":28,\"block_date\":\"2025-10-18\"}', '2025-10-12 15:42:24', '2025-11-11'),
(76, 'blocked_date', 27, '{\"id\":27,\"block_date\":\"2025-10-17\"}', '2025-10-12 15:42:27', '2025-11-11'),
(77, 'blocked_date', 26, '{\"id\":26,\"block_date\":\"2025-10-16\"}', '2025-10-12 15:42:29', '2025-11-11'),
(81, 'user', 151, '{\"user_id\":151,\"username\":\"Vincent\",\"email\":\"publicotavern@gmail.com\",\"otp\":null,\"otp_expiry\":null,\"reset_token\":null,\"reset_token_expiry\":null,\"is_verified\":1,\"is_admin\":0,\"avatar\":null,\"mobile\":null,\"birthday\":null,\"created_at\":\"2025-10-09 23:43:33\",\"deleted_at\":null}', '2025-10-14 16:25:33', '2025-11-14'),
(82, 'menu_item', 30, '{\"id\":30,\"name\":\"ChickenSilog\",\"category\":\"Breakfast\",\"price\":\"148.00\",\"image\":\"uploads\\/68f20138293b19.50648522.jpeg\",\"description\":\"A perfectly crispy and juicy fried chicken served with fragrant garlic fried rice and a flawless sunny-side up egg. A simple, savory, and satisfying meal for any time of day.\",\"deleted_at\":null}', '2025-10-17 08:44:55', '2025-11-16'),
(83, 'menu_item', 29, '{\"id\":29,\"name\":\"Pork Steak\",\"category\":\"Specialty\",\"price\":\"178.00\",\"image\":\"uploads\\/68dac9ed426bc6.00407464.jpg\",\"description\":\"The sound of the sauce simmering, the scent of caramelized onions... Filipino Pork Steak is less a dish, and more a call home.\",\"deleted_at\":null}', '2025-10-17 08:45:57', '2025-11-16'),
(84, 'menu_item', 34, '{\"id\":34,\"name\":\"PorkSilog\",\"category\":\"Breakfast\",\"price\":\"148.00\",\"image\":\"uploads\\/68f202821ddda8.14563401.jpeg\",\"description\":\"A juicy, tender pork chop, seasoned and pan-fried to a perfect golden-brown. Served with a generous portion of garlic fried rice and a sunny-side up egg. A classic, hearty meal guaranteed to satisfy.\",\"deleted_at\":null}', '2025-10-17 08:49:10', '2025-11-16'),
(85, 'menu_item', 31, '{\"id\":31,\"name\":\"SisigSIlog\",\"category\":\"Breakfast\",\"price\":\"148.00\",\"image\":\"uploads\\/68f20198b955f5.19969128.jpeg\",\"description\":\"Classic Kapampangan-style pork sisig, sizzling with savory and tangy flavors, served with fragrant garlic fried rice and a perfectly fried egg. The ultimate satisfying meal.\",\"deleted_at\":null}', '2025-10-17 08:52:14', '2025-11-16'),
(86, 'menu_item', 38, '{\"id\":38,\"name\":\"Butter Shrimp\",\"category\":\"Lunch\",\"price\":\"298.00\",\"image\":\"uploads\\/68f2040f528af5.66022229.jpeg\",\"description\":\"Fresh, plump shrimp saut\\u00e9ed to perfection in a rich and luscious sauce of golden butter, toasted garlic, and a hint of spice. This decadent dish is simple, aromatic, and incredibly flavorful, making it a perfect main course or a luxurious appetizer.\",\"deleted_at\":null}', '2025-10-17 09:03:55', '2025-11-16'),
(87, 'hero_slide', 13, '{\"id\":13,\"image_path\":\"\",\"title\":\"\",\"subtitle\":\"\",\"video_path\":\"uploads\\/68d80a65aadfd9.10474346.mp4\",\"media_type\":\"video\",\"created_at\":\"2025-09-28 00:01:41\",\"deleted_at\":null}', '2025-10-17 09:20:28', '2025-11-16'),
(88, 'hero_slide', 24, '{\"id\":24,\"image_path\":\"\",\"title\":\"\",\"subtitle\":\"\",\"video_path\":\"\",\"media_type\":\"video\",\"created_at\":\"2025-10-17 17:32:59\",\"deleted_at\":null}', '2025-10-17 09:33:03', '2025-11-16'),
(89, 'hero_slide', 25, '{\"id\":25,\"image_path\":\"\",\"title\":\"\",\"subtitle\":\"\",\"video_path\":\"uploads\\/68f20d9764cb18.75387971.mp4\",\"media_type\":\"video\",\"created_at\":\"2025-10-17 17:34:15\",\"deleted_at\":null}', '2025-10-17 09:34:29', '2025-11-16'),
(90, 'user', 173, '{\"user_id\":173,\"username\":\"Vincent21\",\"email\":\"vinee0163@gmail.com\",\"otp\":null,\"otp_expiry\":null,\"reset_token\":null,\"reset_token_expiry\":null,\"is_verified\":1,\"is_admin\":0,\"avatar\":null,\"mobile\":null,\"birthday\":null,\"created_at\":\"2025-10-17 20:29:50\",\"deleted_at\":null}', '2025-10-17 12:31:16', '2025-11-16'),
(91, 'user', 175, '{\"user_id\":175,\"username\":\"Manager2002\",\"email\":\"Vincent@gmail.com\",\"otp\":null,\"otp_expiry\":null,\"reset_token\":null,\"reset_token_expiry\":null,\"is_verified\":0,\"is_admin\":0,\"role\":\"customer\",\"avatar\":null,\"mobile\":null,\"birthday\":null,\"created_at\":\"2025-10-19 14:23:21\",\"deleted_at\":null}', '2025-10-19 06:23:30', '2025-11-18'),
(92, 'reservation', 42, '{\"reservation_id\":42,\"user_id\":14,\"res_date\":\"2025-10-19\",\"res_time\":\"15:00:00\",\"num_guests\":23,\"res_name\":\"Vince\",\"res_phone\":\"09663195259\",\"res_email\":\"penapaul858@gmail.com\",\"status\":\"Confirmed\",\"created_at\":\"2025-10-17 22:02:06\",\"assigned_table\":null,\"table_id\":null,\"is_notified\":0,\"deleted_at\":null,\"source\":\"Online\",\"reservation_type\":\"Dine-in\",\"valid_id_path\":\"uploads\\/ids\\/id_68f24c5ecedc12.02522622.jpg\"}', '2025-10-19 06:34:30', '2025-11-18'),
(93, 'reservation', 43, '{\"reservation_id\":43,\"user_id\":183,\"res_date\":\"2025-11-06\",\"res_time\":\"17:00:00\",\"num_guests\":2,\"res_name\":\"Felix\",\"res_phone\":\"09667785843\",\"res_email\":\"johnfelix.dizon123@gmail.com\",\"status\":\"Declined\",\"created_at\":\"2025-11-06 16:16:21\",\"assigned_table\":null,\"table_id\":null,\"is_notified\":0,\"deleted_at\":null,\"source\":\"Online\",\"reservation_type\":\"Dine-in\",\"valid_id_path\":\"uploads\\/ids\\/id_690c5955a368b4.36716111.png\"}', '2025-11-06 12:33:22', '2025-12-06');

-- --------------------------------------------------------

--
-- Table structure for table `events`
--

CREATE TABLE `events` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `date` varchar(255) NOT NULL,
  `end_date` date DEFAULT NULL,
  `description` text NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `events`
--

INSERT INTO `events` (`id`, `title`, `date`, `end_date`, `description`, `image`, `deleted_at`) VALUES
(7, 'dfghjkl', '275760-07-06', NULL, 'hgfdsdf', 'uploads/68d62b59851c63.68834595.png', '2025-09-28 12:56:56'),
(8, 'Chrismast', '2025-12-21', '2025-12-25', 'My apologies. I shortened the code in my last response to make it easier to copy, but I see now that you\'d prefer to see it fully formatted. You are correct, no functionality was removed, it was only compressed.', 'uploads/68d62ec99388d6.32195318.png', '2025-09-29 18:15:27'),
(9, 'Hallowen', '2025-11-01', '2025-11-05', 'Happ Halloween', 'uploads/68d9326184f316.63890607.jpeg', '2025-09-29 03:28:20'),
(10, 'Birthday ko ngayon', '2025-09-30', '2025-09-29', 'Anjing', 'uploads/68d9fd838946c2.41190803.png', '2025-09-29 03:31:53'),
(11, 'New year', '2025-09-30', '2025-10-01', 'You\'ve spotted another layout bug.', 'uploads/68dac3bd409a75.76303681.jpg', NULL),
(12, 'Happy New Year', '2025-12-01', '2026-01-05', '\"Tonight is the midnight magic where endings become beautiful beginnings. Dream big; the whole year is listening.\"', 'uploads/68dacd3649c864.17654122.jpg', NULL),
(13, 'Happy Valentine\'s Day', '2026-02-14', NULL, '\"Love is the main course, and our atmosphere is the perfect accompaniment. A night you’ll both cherish.\"', 'uploads/68dacd8d9cb509.70007263.jpg', NULL),
(14, 'Happy Mother\'s Day', '2026-05-11', NULL, '\"A meal made with gratitude. This Mother\'s Day, we celebrate the woman who taught us everything about nourishment.\"', 'uploads/68dacdf1df31a4.48880259.jpg', NULL),
(15, 'Birthday ni Pet', '2025-10-16', '2025-10-30', 'ffjsd,', 'uploads/68ec80e3df00d4.52257072.jpg', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `gallery`
--

CREATE TABLE `gallery` (
  `id` int(11) NOT NULL,
  `image` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `gallery`
--

INSERT INTO `gallery` (`id`, `image`, `description`, `deleted_at`) VALUES
(12, 'uploads/68d62b9ea7afe7.31026399.png', 'seiokjhgfdsxcvbnmjhfdxcv', '2025-09-28 13:23:23'),
(14, 'uploads/68dacf0551c0c9.71677068.jpg', '.', NULL),
(15, 'uploads/68dacf13998cf3.82374254.jpg', '.', NULL),
(16, 'uploads/68dacf1f63f5f2.80098481.jpg', '.', NULL),
(17, 'uploads/68dacf30173f29.03142440.jpg', 'family', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `hero_slides`
--

CREATE TABLE `hero_slides` (
  `id` int(11) NOT NULL,
  `image_path` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `subtitle` varchar(255) DEFAULT NULL,
  `video_path` varchar(255) DEFAULT NULL,
  `media_type` varchar(10) NOT NULL DEFAULT 'image',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `hero_slides`
--

INSERT INTO `hero_slides` (`id`, `image_path`, `title`, `subtitle`, `video_path`, `media_type`, `created_at`, `deleted_at`) VALUES
(12, 'uploads/68d80a5b4966f3.20083863.jpg', 'Tavern Publico', 'Where good company gathers', '', 'image', '2025-09-27 16:01:31', '2025-10-07 22:07:32'),
(13, '', '', '', 'uploads/68d80a65aadfd9.10474346.mp4', 'video', '2025-09-27 16:01:41', '2025-10-17 17:20:28'),
(14, 'uploads/68da9a94154ec6.29158311.jpeg', 'Tavern Publico', 'fghjk', '', 'image', '2025-09-29 14:41:24', '2025-09-30 01:47:51'),
(15, 'uploads/68da9aa16c43f7.95794272.jpeg', 'HEllo', 'cvbn', '', 'image', '2025-09-29 14:41:37', '2025-09-30 01:47:48'),
(16, 'uploads/68dac667d90566.26397573.jpg', '1st', '2nd', '', 'image', '2025-09-29 17:48:23', '2025-10-07 22:07:37'),
(17, 'uploads/68dac695b68195.67723369.jpg', '2nd', 'AWRSDSSSSSS', '', 'image', '2025-09-29 17:49:09', '2025-09-30 01:50:20'),
(18, 'uploads/68dac70392b650.98291033.jpg', '3', 'efg', '', 'image', '2025-09-29 17:50:59', '2025-10-07 22:07:34'),
(19, 'uploads/68e5139a218796.02181646.jpg', 'food', 'AWRSDSSSSSS', '', 'image', '2025-10-07 13:20:26', '2025-10-07 21:50:35'),
(20, 'uploads/68e513aa9904e0.41391680.jpg', 'sd', 'df', '', 'image', '2025-10-07 13:20:42', '2025-10-07 21:50:31'),
(21, 'uploads/68e51ecbdc6b65.78559003.jpg', 'Where Good Food & Good Company Meet', 'Discover a menu crafted with passion, served in a place that feels like home', '', 'image', '2025-10-07 14:08:11', NULL),
(22, 'uploads/68e51ee46353d4.08216242.jpg', 'Your Daily Dose of Delicious', 'From morning coffee to evening comfort food, find your favorite flavor at Tavern Publico', '', 'image', '2025-10-07 14:08:36', NULL),
(23, 'uploads/68e51f03a9fb21.09517997.jpg', 'Savor the Moment, Taste the Tradition', 'We blend classic recipes with a modern twist to create an unforgettable dining experience', '', 'image', '2025-10-07 14:09:07', NULL),
(24, '', '', '', '', 'video', '2025-10-17 09:32:59', '2025-10-17 17:33:03'),
(25, '', '', '', 'uploads/68f20d9764cb18.75387971.mp4', 'video', '2025-10-17 09:34:15', '2025-10-17 17:34:29'),
(26, '', '', '', 'uploads/68f20de7b17da1.27086382.mp4', 'video', '2025-10-17 09:35:35', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `menu`
--

CREATE TABLE `menu` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `category` varchar(255) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `menu`
--

INSERT INTO `menu` (`id`, `name`, `category`, `price`, `image`, `description`, `deleted_at`) VALUES
(18, 'sdfgh', 'Specialty', 34.00, 'uploads/68d6239f7c51c5.11311157.png', 'dfgh', '2025-09-29 17:57:15'),
(21, 'cfe', 'Lunch', 23.00, 'uploads/68d62a9ca42191.99713898.png', 'Completely replace the code in your update.php file with this corrected version. The only change is to the sanitize function.', '2025-09-29 18:03:34'),
(22, 'asdf', 'Lunch', 234.00, 'uploads/68d657427b8541.26434268.png', 'sdfghgfdvb', '2025-09-29 18:03:32'),
(23, 'wdefg', 'Specialty', 2.00, 'uploads/68d6d8f85b38e2.02182447.png', 'defgh', '2025-09-29 17:57:20'),
(24, 'ertgh', 'Specialty', 400.00, 'uploads/68d6d906e925d9.11936485.jpg', 'dfg', '2025-09-28 13:03:04'),
(25, 'ert', 'Specialty', 34.00, 'uploads/68d6d914ba4907.26884802.png', 'wertghj', '2025-09-29 17:57:08'),
(26, 'caramel', 'Coffee', 85.00, 'uploads/68d9329e59bee4.03672499.jpg', 'yummy', '2025-09-29 18:03:29'),
(27, 'Chicken Inasal', 'Specialty', 178.00, 'uploads/68dac918c83784.54662868.jpg', 'That perfect bite of Inasal: smoky, tangy, garlicky, and utterly addictive. It\'s the taste of Filipino sunshine.', NULL),
(28, 'Carbonara', 'Specialty', 168.00, 'uploads/68dac99e467982.27663719.jpg', 'Carbonara is a testament to flavor alchemy. Eggs, cheese, pork fat, and pepper—transformed into a silk so rich, you need nothing else.', NULL),
(29, 'Pork Steak', 'Specialty', 178.00, 'uploads/68dac9ed426bc6.00407464.jpg', 'The sound of the sauce simmering, the scent of caramelized onions... Filipino Pork Steak is less a dish, and more a call home.', '2025-10-17 08:45:57'),
(30, 'ChickenSilog', 'Breakfast', 148.00, 'uploads/68f20138293b19.50648522.jpeg', 'A perfectly crispy and juicy fried chicken served with fragrant garlic fried rice and a flawless sunny-side up egg. A simple, savory, and satisfying meal for any time of day.', '2025-10-17 08:44:55'),
(31, 'SisigSIlog', 'Breakfast', 148.00, 'uploads/68f20198b955f5.19969128.jpeg', 'Classic Kapampangan-style pork sisig, sizzling with savory and tangy flavors, served with fragrant garlic fried rice and a perfectly fried egg. The ultimate satisfying meal.', '2025-10-17 08:52:14'),
(32, 'BagnetSilog', 'Specialty', 148.00, 'uploads/68f2022a058303.41254836.jpeg', 'Authentic Ilocano-style bagnet, deep-fried to golden perfection for an incredibly crispy skin and succulent, tender meat. Served with garlic fried rice, a fried egg, and a side of zesty vinegar dip to complete this classic favorite.', NULL),
(33, 'BagnetSilog', 'Breakfast', 148.00, 'uploads/68f2023eb25003.56417988.jpeg', 'Authentic Ilocano-style bagnet, deep-fried to golden perfection for an incredibly crispy skin and succulent, tender meat. Served with garlic fried rice, a fried egg, and a side of zesty vinegar dip to complete this classic favorite.', NULL),
(34, 'PorkSilog', 'Breakfast', 148.00, 'uploads/68f202821ddda8.14563401.jpeg', 'A juicy, tender pork chop, seasoned and pan-fried to a perfect golden-brown. Served with a generous portion of garlic fried rice and a sunny-side up egg. A classic, hearty meal guaranteed to satisfy.', '2025-10-17 08:49:10'),
(35, 'Chicken Inasal', 'Sizzlers', 178.00, 'uploads/68f202d930cdc4.52605195.jpeg', 'A whole chicken leg quarter, marinated in a special blend of lemongrass, ginger, and calamansi, then slow-grilled over live charcoal. Basted with annatto oil for its signature color and smoky aroma, each bite is tender, juicy, and bursting with authentic Bacolod flavor. Served with a traditional soy-vinegar dipping sauce.', NULL),
(36, 'Liempo', 'Sizzlers', 178.00, 'uploads/68f203230bb577.72594709.jpeg', 'A choice slab of pork belly, marinated in a classic blend of soy sauce, calamansi, and garlic, then grilled over live coals to perfection. The result is a smoky, savory, and incredibly juicy liempo with a delightfully crisp, charred skin. Served with a side of steamed rice and a toyomansi dipping sauce.', NULL),
(37, 'Sinigang na Bagnet', 'Lunch', 298.00, 'uploads/68f203ac39acb3.30977074.jpeg', 'A rich and tangy tamarind soup generously filled with fresh vegetables. The star of this dish is our authentic, deep-fried Ilocano bagnet, served crispy on top. The delightful contrast of the crunchy, savory pork belly with the hot, sour broth makes for a truly unforgettable and satisfying meal.', NULL),
(38, 'Butter Shrimp', 'Lunch', 298.00, 'uploads/68f2040f528af5.66022229.jpeg', 'Fresh, plump shrimp sautéed to perfection in a rich and luscious sauce of golden butter, toasted garlic, and a hint of spice. This decadent dish is simple, aromatic, and incredibly flavorful, making it a perfect main course or a luxurious appetizer.', '2025-10-17 09:03:55'),
(39, 'Sisig Kapampangan', 'Lunch', 298.00, 'uploads/68f204427e3cd6.97717664.jpeg', 'Classic Kapampangan-style pork sisig, sizzling with savory and tangy flavors, served with fragrant garlic fried rice and a perfectly fried egg. The ultimate satisfying meal.', NULL),
(40, 'Beef Nachos', 'Lunch', 178.00, 'uploads/68f2051cb9f223.09914588.jpeg', 'A generous mountain of crisp tortilla chips piled high with savory seasoned ground beef and smothered in a rich, creamy melted cheese sauce. Topped with fresh diced tomatoes, onions, and a kick of jalapeños for a perfect balance of flavors in every bite. Ideal for sharing!', NULL),
(41, 'Dark Chocolate Chip', 'Cool Creations', 188.00, 'uploads/68f205a3600ee1.42205823.jpeg', 'Rich. Decadent. Unforgettable.\\r\\n\\r\\nThe Perfect Indulgent Treat.\\r\\n\\r\\nA Classic Cookie, Elevated.\\r\\n\\r\\nChewy, Chocolatey, Panalo!', NULL),
(42, 'PorkSilog', 'Breakfast', 148.00, 'uploads/68f205d485a8a0.07979049.jpeg', 'A juicy, tender pork chop, seasoned and pan-fried to a perfect golden-brown. Served with a generous portion of garlic fried rice and a sunny-side up egg. A classic, hearty meal guaranteed to satisfy.', NULL),
(43, 'Embutido De Fiesta', 'Lunch', 298.00, 'uploads/68f2062e28e289.80379513.jpeg', 'A true taste of Filipino celebration, our Embutido De Fiesta is handcrafted with premium ground pork, generously mixed with sweet raisins, carrots, and bell peppers. Each roll is stuffed with savory sausage and hard-boiled eggs, then slow-steamed to lock in all the rich, savory-sweet flavors. Served sliced, it\\\'s the perfect festive centerpiece for any meal.', NULL),
(44, 'ChickenSilog', 'Specialty', 148.00, 'uploads/68f20660ea5162.34529114.jpeg', 'A perfectly crispy and juicy fried chicken served with fragrant garlic fried rice and a flawless sunny-side up egg. A simple, savory, and satisfying meal for any time of day.', NULL),
(45, 'Butter Shrimp', 'Lunch', 298.00, 'uploads/68f2069c67aba5.88090686.jpeg', 'Fresh, plump shrimp sautéed to perfection in a rich and luscious sauce of golden butter, toasted garlic, and a hint of spice. This decadent dish is simple, aromatic, and incredibly flavorful, making it a perfect main course or a luxurious appetizer.', NULL),
(46, 'Chopsey', 'Lunch', 288.00, 'uploads/68f207295c4fc5.00826198.jpeg', 'A classic Filipino-Chinese stir-fry featuring a colorful medley of fresh, crisp-tender vegetables like carrots, cabbage, bell peppers, and chayote. It\\\'s tossed with a savory mix of tender pork, chicken, and shrimp, and studded with quail eggs, all brought together in a delicious, light savory sauce. A wholesome and flavorful choice.', NULL),
(47, 'Dirty Matcha', 'Coffee', 168.00, 'uploads/68f207b728bdf7.01205058.jpeg', 'The Best of Both Worlds: Coffee & Tea.\\r\\n\\r\\nEarthy, Bold, & Perfectly Balanced.\\r\\n\\r\\nYour Ultimate Energy Boost in a Cup.\\r\\n\\r\\nWhen Matcha Met Espresso', NULL),
(48, 'Baby Back Ribs', 'Specialty', 188.00, 'uploads/68f2081a745571.80466884.jpeg', 'A premium rack of baby back ribs, slow-cooked for hours until incredibly tender and succulent. It\\\'s then generously glazed with our signature sweet and smoky barbecue sauce and grilled to a perfect caramelized char. Each bite is a fall-off-the-bone experience you won\\\'t forget. Served with your choice of side.', NULL),
(49, 'Chicken Cordon Blue', 'Specialty', 288.00, 'uploads/68f20881840c81.44946605.jpeg', 'A tender chicken breast, carefully pounded and rolled around savory smoked ham and premium, quick-melting cheese. It\\\'s then coated in a seasoned breading and fried to a perfect golden crisp. Served with a rich, creamy gravy, this dish is a delightful contrast of a crunchy exterior with a juicy, cheesy, and savory center.', NULL),
(50, 'Caramel ', 'Coffee', 168.00, 'uploads/68f208e1c4be59.32135009.jpeg', 'Your Perfect Sweet Escape.\\r\\n\\r\\nRich Espresso, Creamy Caramel.\\r\\n\\r\\nThe Sweet Boost Your Friday Needs.\\r\\n\\r\\nAng tamis na babalik-balikan mo. (The sweetness you\\\'ll always come back for.)', NULL),
(51, 'Strawberry Milk', 'Cool Creations', 168.00, 'uploads/68f2097076b7f2.92542648.jpeg', 'Creamy, Fruity, and Perfectly Pink.\\r\\n\\r\\nYour Childhood Favorite, Made Better.\\r\\n\\r\\nA Sweet Strawberry Escape.\\r\\n\\r\\nAng Paboritong Pink Drink! (The Favorite Pink Drink!)', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `message` varchar(255) NOT NULL,
  `link` varchar(255) DEFAULT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`id`, `user_id`, `message`, `link`, `is_read`, `created_at`) VALUES
(1, 1, 'his table is designed to store the ratings and comments that guests submit about their reservations. It also includes a', NULL, 1, '2025-09-26 16:03:27'),
(2, 1, 'his table is designed to store the ratings and comments that guests submit about their reservations. It also includes a', NULL, 1, '2025-09-26 16:03:28'),
(3, 1, 'his table is designed to store the ratings and comments that guests submit about their reservations. It also includes a', NULL, 1, '2025-09-26 16:03:28'),
(4, 1, 'cvbnhgsx', NULL, 1, '2025-09-26 16:05:31'),
(5, 14, 'gvfdcvccc', NULL, 1, '2025-09-26 16:10:02'),
(6, 14, 'Good', NULL, 1, '2025-09-26 16:13:46'),
(7, 14, 'You\'ve found a PHP warning bug. The error messages you\'re seeing, \"Constant DB_SERVER already defined', NULL, 1, '2025-09-26 17:04:36'),
(8, 1, 'HElllo Karlll Louis', NULL, 1, '2025-09-27 15:03:15'),
(9, 1, 'sdfgh', NULL, 1, '2025-09-28 12:44:50'),
(10, 14, 'hello', NULL, 1, '2025-09-28 14:16:26'),
(11, 14, 'joshua', NULL, 1, '2025-09-29 07:41:34'),
(12, 1, 'Hello vince yea we are availabe in that that', NULL, 0, '2025-10-09 12:02:13'),
(13, 1, 'yes', NULL, 0, '2025-10-09 12:07:01'),
(14, 14, 'karllllllll', NULL, 1, '2025-10-13 04:22:29'),
(15, 14, 'hi', NULL, 1, '2025-10-19 04:02:43');

-- --------------------------------------------------------

--
-- Table structure for table `reservations`
--

CREATE TABLE `reservations` (
  `reservation_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `res_date` date NOT NULL,
  `res_time` time NOT NULL,
  `num_guests` int(11) NOT NULL,
  `res_name` varchar(100) NOT NULL,
  `res_phone` varchar(20) NOT NULL,
  `res_email` varchar(100) NOT NULL,
  `status` varchar(50) DEFAULT 'Pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `assigned_table` varchar(50) DEFAULT NULL,
  `table_id` int(11) DEFAULT NULL,
  `is_notified` tinyint(1) NOT NULL DEFAULT 0,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `source` varchar(50) NOT NULL DEFAULT 'Online',
  `reservation_type` varchar(50) NOT NULL DEFAULT 'Dine-in',
  `valid_id_path` varchar(255) DEFAULT NULL,
  `applied_coupon_code` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `reservations`
--

INSERT INTO `reservations` (`reservation_id`, `user_id`, `res_date`, `res_time`, `num_guests`, `res_name`, `res_phone`, `res_email`, `status`, `created_at`, `assigned_table`, `table_id`, `is_notified`, `deleted_at`, `source`, `reservation_type`, `valid_id_path`, `applied_coupon_code`) VALUES
(15, NULL, '2025-09-16', '11:00:00', 1, 'Vincent paul GNC Pena', '09667785843', 'vincentpaul.pena@gnc.edu.ph', 'Confirmed', '2025-09-16 14:18:15', NULL, NULL, 0, NULL, 'Online', 'Dine-in', NULL, NULL),
(16, NULL, '2025-09-25', '11:00:00', 1, 'Vincent paul', '09667785843', 'vincentpaul.pena@gnc.edu.ph', 'Confirmed', '2025-09-25 07:46:26', NULL, NULL, 0, NULL, 'Online', 'Dine-in', NULL, NULL),
(17, 14, '2025-09-26', '11:00:00', 1, 'Vincent paul D Pena', '09667785843', 'keycm109@gmail.com', 'Cancelled', '2025-09-26 10:14:04', NULL, NULL, 1, NULL, 'Online', 'Dine-in', NULL, NULL),
(18, 14, '2025-09-26', '11:00:00', 1, 'Vincent paul D Pena', '09667785843', 'keycm109@gmail.com', 'Confirmed', '2025-09-26 10:15:37', NULL, NULL, 1, NULL, 'Online', 'Dine-in', NULL, NULL),
(19, 1, '2025-09-26', '11:00:00', 6, 'KIm', '09667785843', 'vincentpaul.pena@gnc.edu.ph', 'Pending', '2025-09-26 12:40:27', NULL, NULL, 0, NULL, 'Online', 'Dine-in', NULL, NULL),
(20, 14, '2025-09-26', '11:00:00', 1, 'Tavern Publico', '09663195259', 'karllouisnavarro@gmail.com', 'Confirmed', '2025-09-26 15:00:23', NULL, NULL, 1, NULL, 'Online', 'Dine-in', NULL, NULL),
(21, 14, '2025-09-26', '11:00:00', 1, 'Tavern', '09663195259', 'karllouisnavarro@gmail.com', 'Confirmed', '2025-09-26 15:10:00', NULL, NULL, 1, NULL, 'Online', 'Dine-in', NULL, NULL),
(22, 14, '2025-09-27', '11:00:00', 1, 'Vincent', '09663195259', 'karllouisnavarro@gmail.com', 'Declined', '2025-09-26 17:03:24', NULL, NULL, 1, NULL, 'Online', 'Dine-in', NULL, NULL),
(23, 14, '2025-09-27', '11:00:00', 56, 'isaac macaraeg', '09667785843', 'vincentpaul.pena@gnc.edu.ph', 'Pending', '2025-09-26 17:26:35', NULL, NULL, 0, NULL, 'Online', 'Dine-in', NULL, NULL),
(24, 14, '2025-09-27', '11:00:00', 12, 'Vincent paul D Pena', '09667785843', 'penapaul858@gmail.com', 'Confirmed', '2025-09-26 17:31:35', NULL, NULL, 1, NULL, 'Online', 'Dine-in', NULL, NULL),
(25, 14, '2025-09-27', '11:00:00', 54, 'Tavern', '09663195259', 'karllouisnavarro@gmail.com', 'Confirmed', '2025-09-26 17:52:10', NULL, NULL, 1, '2025-09-27 14:55:34', 'Online', 'Dine-in', NULL, NULL),
(26, 1, '2025-09-27', '11:00:00', 50, 'Tavern', '09663195259', 'karllouisnavarro@gmail.com', 'Confirmed', '2025-09-27 15:02:30', NULL, NULL, 1, NULL, 'Online', 'Dine-in', NULL, NULL),
(27, 14, '2025-09-28', '11:00:00', 10, 'Kimberly Anne D. Pena', '09663195259', 'karllouisnavarro@gmail.com', 'Confirmed', '2025-09-28 08:29:56', NULL, NULL, 1, NULL, 'Online', 'Dine-in', NULL, NULL),
(28, NULL, '2025-02-12', '20:47:00', 10, 'Vincent paul D Pena', '09667785843', 'keycm109@gmail.com', 'Confirmed', '2025-09-28 09:47:55', NULL, NULL, 0, NULL, 'Walk-in', 'Dine-in', NULL, NULL),
(29, 14, '2025-09-28', '14:00:00', 10, 'ed', '09663195259', 'karllouisnavarro@gmail.com', 'Confirmed', '2025-09-28 10:04:53', NULL, NULL, 1, NULL, 'Online', 'Dine-in', NULL, NULL),
(30, 14, '2025-10-01', '11:00:00', 10, 'James', '09667785843', 'keycm109@gmail.com', 'Confirmed', '2025-09-28 10:35:49', NULL, NULL, 1, NULL, 'Online', 'Dine-in', NULL, NULL),
(31, 14, '2025-10-05', '11:00:00', 8, 'Vincent paul D Pena', '09667785843', 'keycm109@gmail.com', 'Confirmed', '2025-10-05 14:20:58', NULL, NULL, 1, NULL, 'Online', 'Dine-in', NULL, NULL),
(32, 14, '2025-10-05', '11:00:00', 8, 'Vincent paul D Pena', '09667785843', 'keycm109@gmail.com', 'Confirmed', '2025-10-05 14:44:31', NULL, NULL, 1, NULL, 'Online', 'Dine-in', NULL, NULL),
(33, 14, '2025-10-05', '11:00:00', 8, 'Vincent paul D Pena', '09667785843', 'penapaul858@gmail.com', 'Confirmed', '2025-10-05 15:03:34', NULL, NULL, 1, NULL, 'Online', 'Dine-in', NULL, NULL),
(34, 14, '2025-11-07', '11:00:00', 8, 'Vincent paul D Pena', '09667785843', 'penapaul858@gmail.com', 'Declined', '2025-10-07 07:06:58', NULL, NULL, 1, NULL, 'Online', 'Dine-in', NULL, NULL),
(35, 14, '2025-10-08', '11:00:00', 10, 'Vincent paul D Pena', '09667785843', 'keycm109@gmail.com', 'Declined', '2025-10-07 08:11:23', NULL, NULL, 1, NULL, 'Online', 'Dine-in', NULL, NULL),
(37, 14, '2025-10-10', '11:00:00', 11, 'Kimberly Anne D. Pena', '09667785843', 'vincee293@gmail.com', 'Cancelled', '2025-10-09 16:40:09', NULL, NULL, 1, NULL, 'Online', 'Dine-in', NULL, NULL),
(38, NULL, '2025-10-10', '13:00:00', 11, 'Hansel', '09667785843', 'publicotavern@gmail.com', 'Declined', '2025-10-10 03:19:01', NULL, NULL, 0, NULL, 'Online', 'Dine-in', NULL, NULL),
(39, 14, '2025-10-23', '11:00:00', 10, 'Hansel', '09667785843', 'publicotavern@gmail.com', 'Confirmed', '2025-10-13 04:27:18', NULL, NULL, 1, NULL, 'Online', 'Dine-in', NULL, NULL),
(40, 14, '2025-10-18', '14:00:00', 2, 'user', '09667785843', 'penapaul858@gmail.com', 'Confirmed', '2025-10-17 13:14:44', NULL, NULL, 1, NULL, 'Online', 'Dine-in', 'uploads/ids/id_68f241443c0016.73019534.jpg', NULL),
(41, 14, '2025-10-19', '14:00:00', 5, 'user', '09663195259', 'penapaul858@gmail.com', 'Declined', '2025-10-17 13:51:12', NULL, NULL, 1, NULL, 'Online', 'Private Event', 'uploads/ids/id_68f249cfd494b5.83935044.png', NULL),
(42, 14, '2025-10-19', '15:00:00', 23, 'Vince', '09663195259', 'penapaul858@gmail.com', 'Confirmed', '2025-10-17 14:02:06', NULL, NULL, 1, '2025-10-19 06:34:30', 'Online', 'Dine-in', 'uploads/ids/id_68f24c5ecedc12.02522622.jpg', NULL),
(43, 183, '2025-11-06', '17:00:00', 2, 'Felix', '09667785843', 'johnfelix.dizon123@gmail.com', 'Declined', '2025-11-06 08:16:21', NULL, NULL, 0, '2025-11-06 12:33:22', 'Online', 'Dine-in', 'uploads/ids/id_690c5955a368b4.36716111.png', NULL),
(44, 14, '2025-11-09', '13:00:00', 50, 'user', '09667785843', 'penapaul858@gmail.com', 'Pending', '2025-11-08 14:40:31', NULL, NULL, 0, NULL, 'Online', 'Dine-in', 'uploads/ids/id_690f565f8cc9f8.20635478.png', 'TAVERN10');

-- --------------------------------------------------------

--
-- Table structure for table `tables`
--

CREATE TABLE `tables` (
  `table_id` int(11) NOT NULL,
  `table_name` varchar(100) NOT NULL,
  `capacity` int(11) NOT NULL,
  `status` enum('Available','Unavailable','Maintenance') DEFAULT 'Available',
  `description` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `team`
--

CREATE TABLE `team` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `title` varchar(100) NOT NULL,
  `bio` text NOT NULL,
  `image` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `team`
--

INSERT INTO `team` (`id`, `name`, `title`, `bio`, `image`, `created_at`, `deleted_at`) VALUES
(2, 'karl', 'CEO', 'FULL STACK', 'uploads/68d9322c4e2517.13457155.jpg', '2025-09-28 13:03:40', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `testimonials`
--

CREATE TABLE `testimonials` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `reservation_id` int(11) NOT NULL,
  `rating` int(1) NOT NULL,
  `comment` text NOT NULL,
  `is_featured` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `testimonials`
--

INSERT INTO `testimonials` (`id`, `user_id`, `reservation_id`, `rating`, `comment`, `is_featured`, `created_at`, `deleted_at`) VALUES
(1, 14, 20, 5, 'wonderul', 1, '2025-09-26 15:01:26', NULL),
(2, 14, 18, 3, 'Based on the code, the rating feature will only appear on the homepage under specific conditions. It is not visible in your screenshot because one or more of the following requirements have not been met:', 1, '2025-09-26 15:04:18', '2025-09-28 21:12:53'),
(3, 14, 24, 3, 'dfghn', 1, '2025-09-26 18:02:39', '2025-09-28 21:20:14'),
(4, 14, 25, 3, 'dsfghj', 1, '2025-09-26 18:05:48', NULL),
(5, 14, 21, 3, 'sdfgh', 0, '2025-09-26 18:10:52', NULL),
(6, 14, 30, 2, 'thank you', 1, '2025-09-29 07:39:51', '2025-09-29 15:46:02'),
(7, 14, 27, 3, 'You are right! My apologies, it looks like a default style from the icon library was overriding the rule meant to hide the icon on desktops.\r\n\r\nLet&#039;s apply a more specific and forceful CSS rule to fix this immediately.', 0, '2025-09-29 16:29:04', '2025-09-30 02:13:05'),
(8, 14, 35, 3, 'Very nice', 0, '2025-10-09 11:38:06', NULL),
(9, 14, 33, 3, 'i like it', 0, '2025-10-09 11:39:24', NULL),
(10, 14, 32, 3, 'good', 0, '2025-10-10 03:14:36', NULL),
(11, 14, 31, 3, 'excellent', 0, '2025-10-10 03:15:00', NULL),
(12, 14, 29, 3, 'fantastic', 1, '2025-10-10 03:15:21', NULL),
(13, 14, 39, 2, 'eddd', 0, '2025-10-13 04:30:11', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `otp` varchar(10) DEFAULT NULL,
  `otp_expiry` datetime DEFAULT NULL,
  `reset_token` varchar(255) DEFAULT NULL,
  `reset_token_expiry` datetime DEFAULT NULL,
  `is_verified` tinyint(1) NOT NULL DEFAULT 0,
  `is_admin` tinyint(1) NOT NULL DEFAULT 0,
  `role` varchar(50) NOT NULL DEFAULT 'customer',
  `permissions` text DEFAULT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `mobile` varchar(15) DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `birthday_last_updated` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `username`, `email`, `password_hash`, `otp`, `otp_expiry`, `reset_token`, `reset_token_expiry`, `is_verified`, `is_admin`, `role`, `permissions`, `avatar`, `mobile`, `birthday`, `birthday_last_updated`, `created_at`, `deleted_at`) VALUES
(1, 'admin', 'keycm109@gmail.com', '$2y$10$/3fYTIq9ymjPWjHRo9TVoOrTaDtdzRQ69miUzRMdbWL6HU3aXuOVe', NULL, NULL, '479339', '2025-10-17 14:45:49', 1, 1, 'owner', NULL, 'uploads/avatars/68ebcfe3ca9164.89317281.jpg', NULL, NULL, NULL, '2025-07-16 15:38:28', NULL),
(14, 'user', 'penapaul858@gmail.com', '$2y$10$A9bbVMXbAJCP/ywk9a/age6uhtfDhS6raf5RoZBoMhO1UAXocu4wm', NULL, NULL, NULL, NULL, 1, 0, 'user', NULL, 'uploads/avatars/68e50d4c97dbf4.70803573.jpg', NULL, '2002-02-12', '2025-11-06', '2025-09-25 09:10:18', NULL),
(174, 'Manager', 'vince@gmail.com', '$2y$10$oxFfl5XH.tFB9wqTfDyG1ugIfnYnFvYqEkMJUQX9BlZ.kpxNBK1Ui', NULL, NULL, NULL, NULL, 1, 0, 'user', NULL, NULL, NULL, NULL, NULL, '2025-10-19 06:22:23', NULL),
(175, 'Manager2002', 'Vincent@gmail.com', '$2y$10$iZUX.lRUWztbvapsHh.51uXNGzUOVHI23zWqPw3cq4uMpd0oEEPKq', NULL, NULL, NULL, NULL, 0, 0, 'customer', NULL, NULL, NULL, NULL, NULL, '2025-10-19 06:23:21', '2025-10-19 06:23:30'),
(178, 'Vincent2002', 'franzbeltran32@gmail.com', '$2y$10$4Y7zPMR56OsCgFMfQww/ReBGUaaIDbIw/3oSPZuU179FT8rnMiLo2', NULL, NULL, NULL, NULL, 1, 0, 'manager', '[\"access_tables\"]', NULL, NULL, NULL, NULL, '2025-10-19 12:43:36', NULL),
(182, 'Axus2002', 'vinee0163@gmail.com', '$2y$10$dz0vttONhIhTnPDtntCW6O1gr/R7iirQthjWsrZX0uvadVf6zw0ZG', NULL, NULL, NULL, NULL, 1, 0, 'customer', NULL, NULL, NULL, NULL, NULL, '2025-10-23 05:58:25', NULL),
(183, 'Felix', 'johnfelix.dizon123@gmail.com', '$2y$10$a/JJmKHQ7/QUXzYk/DENn.Z38aYc7VyIIay.uTolarbtrE0y1fyw2', NULL, NULL, NULL, NULL, 1, 0, 'user', NULL, 'uploads/avatars/690c5a7b2806c2.77112311.jpg', NULL, '2004-10-06', '2025-11-06', '2025-11-06 08:13:45', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `blocked_dates`
--
ALTER TABLE `blocked_dates`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `block_date` (`block_date`);

--
-- Indexes for table `blocked_slots`
--
ALTER TABLE `blocked_slots`
  ADD PRIMARY KEY (`block_id`);

--
-- Indexes for table `contact_messages`
--
ALTER TABLE `contact_messages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `coupons`
--
ALTER TABLE `coupons`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`);

--
-- Indexes for table `deletion_history`
--
ALTER TABLE `deletion_history`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `idx_item_type` (`item_type`),
  ADD KEY `idx_purge_date` (`purge_date`);

--
-- Indexes for table `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `gallery`
--
ALTER TABLE `gallery`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hero_slides`
--
ALTER TABLE `hero_slides`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `menu`
--
ALTER TABLE `menu`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `reservations`
--
ALTER TABLE `reservations`
  ADD PRIMARY KEY (`reservation_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `fk_table_id` (`table_id`);

--
-- Indexes for table `tables`
--
ALTER TABLE `tables`
  ADD PRIMARY KEY (`table_id`),
  ADD UNIQUE KEY `table_name` (`table_name`);

--
-- Indexes for table `team`
--
ALTER TABLE `team`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `testimonials`
--
ALTER TABLE `testimonials`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `reservation_id` (`reservation_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `blocked_dates`
--
ALTER TABLE `blocked_dates`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `blocked_slots`
--
ALTER TABLE `blocked_slots`
  MODIFY `block_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `contact_messages`
--
ALTER TABLE `contact_messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `coupons`
--
ALTER TABLE `coupons`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `deletion_history`
--
ALTER TABLE `deletion_history`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=94;

--
-- AUTO_INCREMENT for table `events`
--
ALTER TABLE `events`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `gallery`
--
ALTER TABLE `gallery`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `hero_slides`
--
ALTER TABLE `hero_slides`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `menu`
--
ALTER TABLE `menu`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `reservations`
--
ALTER TABLE `reservations`
  MODIFY `reservation_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT for table `tables`
--
ALTER TABLE `tables`
  MODIFY `table_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `team`
--
ALTER TABLE `team`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `testimonials`
--
ALTER TABLE `testimonials`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=184;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `reservations`
--
ALTER TABLE `reservations`
  ADD CONSTRAINT `fk_table_id` FOREIGN KEY (`table_id`) REFERENCES `tables` (`table_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `reservations_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE SET NULL;

--
-- Constraints for table `testimonials`
--
ALTER TABLE `testimonials`
  ADD CONSTRAINT `testimonials_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `testimonials_ibfk_2` FOREIGN KEY (`reservation_id`) REFERENCES `reservations` (`reservation_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
