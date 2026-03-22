-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Mar 22, 2026 at 07:58 AM
-- Server version: 11.8.3-MariaDB-log
-- PHP Version: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `u165132681_t_publico`
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
(24, '2025-10-14'),
(36, '2025-11-14');

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
(6, 'user', 'penapaul858@gmail.com', 'reservation', 'I want to rreserve', 'You\'ve found a PHP warning bug. The error messages you\'re seeing, \"Constant DB_SERVER already defined', '2025-09-26 17:04:36', 1, '2025-09-26 17:04:03', '2025-11-25 13:15:10'),
(7, 'dfgh', '12jfksdfvk@gmail.com', 'dfg', 'dwfg', NULL, '2025-10-14 15:26:21', 1, '2025-09-27 06:54:57', '2025-11-11 17:00:56'),
(8, 'fgh', '123454@gmail.com', 'Reservation Inquiry', 'efghjcvb', NULL, '2025-10-16 16:41:17', 1, '2025-09-27 06:59:18', '2025-11-11 17:00:49'),
(9, 'admin', 'keycm109@gmail.com', 'Reservation Inquiry', 'HELLLO', 'sdfgh', '2025-09-28 12:44:50', 1, '2025-09-27 15:02:49', '2025-09-28 20:43:08'),
(10, 'user', 'penapaul858@gmail.com', 'Reservation Inquiry', 'Of course. I\'ve updated the notification_control.php file to include a \"View\" button for both messages and comments. Clicking this button will open a modal window displaying the full text, which is especially useful for longer entries.', 'joshua', '2025-09-29 07:41:34', 1, '2025-09-28 10:00:07', '2025-09-29 16:03:19'),
(11, 'Vincent paul D Pena', 'keycm109@gmail.com', 'Reservation Inquiry', 'HI i would know it your are reserve for oct 9 2025?', 'yes', '2025-10-09 12:07:01', 1, '2025-10-09 12:01:07', NULL),
(12, 'Vincent paul D Pena', 'penapaul858@gmail.com', 'Reservation Inquiry', 'HI hello good evening', 'HEllo goo evening', '2025-11-11 09:24:17', 1, '2025-10-10 03:13:00', NULL),
(13, 'Vincent paul D Pena', 'penapaul858@gmail.com', 'Reservation Inquiry', 'hi', NULL, '2025-10-16 16:41:16', 1, '2025-10-14 17:21:35', '2025-11-11 17:01:02'),
(14, 'user', 'penapaul858@gmail.com', 'Reservation Inquiry', 'Helllo', 'yes', '2025-11-12 00:46:07', 1, '2025-10-19 04:01:43', NULL),
(15, 'Hansel John', 'keycm109@gmail.com', 'Reservation Inquiry', 'How much the Downpayment for Events?', NULL, '2025-11-12 01:00:36', 1, '2025-11-12 00:57:55', NULL),
(16, 'Hansel John', 'keycm109@gmail.com', 'Reservation Inquiry', 'HELOOOOO', NULL, '2025-11-12 01:00:33', 1, '2025-11-12 00:58:11', '2025-11-16 14:42:27'),
(17, 'Hansel John', 'keycm109@gmail.com', 'Reservation Inquiry', 'HELOOOOO', NULL, '2025-11-12 01:00:34', 1, '2025-11-12 00:58:11', '2025-11-16 14:42:29'),
(18, 'Hansel John', 'keycm109@gmail.com', 'Reservation Inquiry', 'HELOOOOO', NULL, '2025-11-12 01:00:34', 1, '2025-11-12 00:58:11', '2025-11-16 14:42:31'),
(19, 'Hansel John', 'keycm109@gmail.com', 'Reservation Inquiry', 'HELOOOOO', NULL, '2025-11-12 01:00:35', 1, '2025-11-12 00:58:11', '2025-11-17 17:58:39'),
(20, 'Hansel John', 'keycm109@gmail.com', 'Reservation Inquiry', 'HELOOOOO', NULL, '2025-11-12 01:00:31', 1, '2025-11-12 00:58:12', '2025-11-16 03:47:16'),
(21, 'Hansel John', 'keycm109@gmail.com', 'Reservation Inquiry', 'HELOOOOO', NULL, '2025-11-12 01:00:31', 1, '2025-11-12 00:58:12', '2025-11-16 14:42:23'),
(22, 'Hansel John', 'keycm109@gmail.com', 'Reservation Inquiry', 'HELOOOOO', NULL, '2025-11-12 01:00:32', 1, '2025-11-12 00:58:12', '2025-11-16 14:42:33'),
(23, 'Hansel John', 'keycm109@gmail.com', 'Reservation Inquiry', 'HELOOOOO', NULL, '2025-11-12 01:00:30', 1, '2025-11-12 00:58:13', '2025-11-16 03:47:06'),
(24, 'Hansel John', 'keycm109@gmail.com', 'Reservation Inquiry', 'HELOOOOO', NULL, '2025-11-12 01:00:29', 1, '2025-11-12 00:58:13', '2025-11-16 03:47:08'),
(25, 'Hansel John', 'keycm109@gmail.com', 'Reservation Inquiry', 'HELOOOOO', NULL, '2025-11-12 01:00:28', 1, '2025-11-12 00:58:13', '2025-11-16 03:47:09'),
(26, 'Hansel John', 'keycm109@gmail.com', 'Reservation Inquiry', 'HELOOOOO', NULL, '2025-11-12 01:00:30', 1, '2025-11-12 00:58:13', '2025-11-16 03:47:11'),
(27, 'Hansel John', 'keycm109@gmail.com', 'Reservation Inquiry', 'HELOOOOO', NULL, '2025-11-12 01:00:30', 1, '2025-11-12 00:58:13', '2025-11-16 03:47:13'),
(28, 'Hansel John', 'keycm109@gmail.com', 'Reservation Inquiry', 'HELOOOOO', 'on the notification of reservation can you to a modal so that i can read full the notification when i click the reservation notification', '2025-11-12 02:08:31', 1, '2025-11-12 00:58:14', '2025-11-16 03:47:04'),
(29, 'Hansel John', 'keycm109@gmail.com', 'Reservation Inquiry', 'Good morning', NULL, NULL, 0, '2025-11-12 02:42:01', '2025-11-16 03:47:02'),
(30, 'Hansel John', 'keycm109@gmail.com', 'Reservation Inquiry', 'sdfghj', NULL, NULL, 0, '2025-11-12 05:48:05', '2025-11-16 03:47:00'),
(31, 'Tavernpublico', 'publicotavern@gmail.com', 'Reservation Inquiry', 'dfg', 'hi', '2025-11-16 06:37:47', 1, '2025-11-16 06:33:45', '2025-11-16 14:42:21'),
(32, 'Dendi', 'kylerefrado@gmail.com', 'Reservation Inquiry', 'jem', 'I love you', '2025-11-16 06:38:41', 1, '2025-11-16 06:38:19', '2025-11-16 14:42:21'),
(33, 'haze000', 'vibrancy0616@gmail.com', 'Reservation Inquiry', 'I want to Inquire', 'Ayoko nga HAHAHAHA', '2025-11-16 06:46:56', 1, '2025-11-16 06:46:11', '2025-11-17 17:58:35'),
(34, 'James', 'jamesvillapana99@gmail.com', 'Reservation Inquiry', 'Yung reporting naten', 'Cge mamayang GAbi', '2025-11-16 07:44:16', 1, '2025-11-16 07:43:50', '2025-11-16 14:42:07'),
(35, 'Vince', 'penapaul858@gmail.com', 'Reservation Inquiry', 'thank you', NULL, NULL, 0, '2025-11-17 06:03:09', '2025-11-17 17:58:30'),
(36, 'Diana Cruz', 'dianacruz.mkt@gmail.com', 'Re: Improve your website traffic and SEO', 'Hello team, \r\n\r\nI would love to help you enhance your website’s search engine ranking through tailored SEO strategies to improve its visibility and performance on Google, Yahoo, and Bing.\r\n\r\nWe can manage all as we have a 150+ expert team of professionals and help you save a hefty amount on hiring resources.\r\n\r\nWe will improve your website’s position on Google and get more traffic.\r\n\r\nProposal/Package Offer-\r\nIf you are interested, I would be happy to send you a proposal or package with more details. Kindly provide your preferred contact details.\r\n\r\nThank you,\r\nDiana Cruz\r\n\r\n\r\n\r\ntavernpublico.shop', NULL, NULL, 0, '2025-11-17 08:39:41', NULL),
(37, 'Anaya Prajapati', 'anaya.dgtlsolution@gmail.com', 'Website design that reflects your brand perfectly?', 'Hi http://tavernpublico.shop,\r\n \r\nI specialize in creating clean, responsive website designs that help businesses make a strong first impression online. If you can share your website link, I’ll take a quick look and suggest how it can be improved for better engagement and results.\r\n \r\nCan I share a few design suggestions for your site? Please share you\'r Website Link and Whatsapp Number.\r\n \r\nThank You,\r\nSonam', NULL, NULL, 0, '2025-11-17 11:13:57', NULL),
(38, 'Isaac', 'gcn.isaacjedm@gmail.com', 'Reservation Inquiry', 'hiiii', 'Tapusin moan', '2025-11-17 17:06:59', 1, '2025-11-17 17:00:14', '2025-11-17 17:58:19'),
(39, 'haze000', 'vibrancy0616@gmail.com', 'Reservation Inquiry', 'hello', NULL, NULL, 0, '2025-11-17 17:02:32', '2025-11-17 17:06:46'),
(40, 'Isaac', 'gnc.isaacjedm@gmail.com', 'Reservation Inquiry', 'hrlliliukjhgfds', NULL, NULL, 0, '2025-11-17 17:05:51', '2025-11-17 17:06:44'),
(41, 'Isaac', 'gnc.isaacjedm@gmail.com', 'Reservation Inquiry', 'heeeeeee', 'heeeeeeeeeee', '2025-11-17 17:09:04', 1, '2025-11-17 17:08:37', '2025-11-17 17:58:12'),
(42, 'Carmon Sandlin', 'contact@domainsubmit.pro', 'tavernpublico.shop', 'Hello,\r\n\r\nAdd tavernpublico.shop web site to Google Search Index in order to have it displayed in Web Search Results.\r\n\r\nRegister tavernpublico.shop at https://searchregister.org', NULL, NULL, 0, '2025-11-17 17:53:37', NULL),
(43, 'Lucy Johnson', 'lucyjohnson.web@gmail.com', 'Re: Improve your website traffic and SEO', '\"Hello there,\r\n\r\nI came across your Website, when searching on Google and noticed that you do not show in the organic listings.\r\n\r\nOur main focus will be to help generate more sales & online traffic.\r\n\r\nWe can place your website on Google\'s 1st page. We will improve your website’s position on Google and get more traffic.\r\n\r\nIf interested, kindly provide me your name, phone number, and email.\r\n\r\nYour sincerely,\r\nLucy Johnson\"', NULL, NULL, 0, '2025-11-18 11:54:22', '2025-11-25 13:15:17'),
(44, 'Julian Schwindt', 'join@simplyseo.pro', 'tavernpublico.shop', 'Hello,\r\n\r\nAdd tavernpublico.shop website to SEODIRECTORY fort a better position in Web Search results order and to get an improvement in traffic:\r\n\r\n https://seodir.pro', NULL, NULL, 0, '2025-11-18 23:58:07', NULL),
(45, 'Vincent paul', 'penapaul858@gmail.com', 'Reservation Inquiry', 'hello', NULL, NULL, 0, '2025-11-19 05:19:58', NULL),
(46, 'Ankit S', 'letsgetuoptimize@gmail.com', 'Re: Increase google organic ranking & SEO', 'Hey team tavernpublico.shop,\r\n\r\nI would like to discuss SEO!\r\n\r\nI can help your website to get on first page of Google and increase the number of leads and sales you are getting from your website.\r\n\r\nMay I send you a quote & price list?\r\n\r\nBests Regards,\r\nAnkit\r\nBest AI SEO Company\r\nAccounts Manager\r\nwww.letsgetoptimize.com\r\nPhone No: +1 (949) 508-0277', NULL, NULL, 0, '2025-11-19 20:52:34', NULL),
(47, 'Hayden Landon', 'hayden.landon@outlook.com', 'To the tavernpublico.shop Administrator!', 'Hi,\r\n\r\nI’m Danish from a SEO & PPC growth team helping businesses boost conversions through data-driven strategies.\r\n\r\nWe’ve helped many companies achieve:\r\n✅ 3x more website leads  \r\n✅ Lower CPC on Google Ads  \r\n✅ Consistent SEO growth through smart backlinks  \r\n\r\nWould you like a free growth audit?  \r\nIt reveals exactly what’s blocking your reach — and how to improve fast.\r\n\r\n������ WhatsApp: +1 913 735 7607  \r\n������ Telegram: @Professionals_experts_bot  \r\n✉️ Email: leads.scrapper@gmail.com  \r\n\r\n– Danish | Growth Specialist', NULL, NULL, 0, '2025-11-22 12:28:58', NULL),
(48, 'Rosemary Cremor', 'cremor.rosemary@hotmail.com', 'Hello tavernpublico.shop Webmaster.', 'Hi,\r\n\r\nI’m Danish from a SEO & PPC growth team helping businesses increase leads through data-driven strategies.\r\n\r\nWe’ve helped many companies achieve:\r\n✅ 3x more website leads  \r\n✅ Lower CPC on Google Ads  \r\n✅ Consistent SEO growth through smart backlinks  \r\n\r\nWould you like a quick growth audit?  \r\nIt reveals exactly what’s blocking your reach — and how to improve fast.\r\n\r\n������ WhatsApp: +1 913 735 7607  \r\n������ Telegram: @Professionals_experts_bot  \r\n✉️ Email: leads.scrapper@gmail.com  \r\n\r\n– Danish | Growth Specialist', NULL, NULL, 0, '2025-11-24 00:58:52', NULL),
(49, 'Gabriella Bettencourt', 'parker.harrison31023+gabriella.bettencourt@gmail.com', 'Increase audience fast', 'Want more eyes on tavernpublico.com pages today? Start your Free Test.', NULL, NULL, 0, '2025-11-24 22:21:51', NULL),
(50, 'Mike Maximilian Johnson', 'mike@monkeydigital.co', 'Boost Your Website Traffic with Targeted Social Ads – Only $10 for 10K Visits!', 'Hi there, \r\n \r\nI wanted to reach out with something that could seriously help your website’s visitor count. We work with a trusted ad network that allows us to deliver real, location-based social ads traffic for just $10 per 10,000 visits. \r\n \r\nThis isn\'t junk clicks—it’s engaged traffic, tailored to your preferred location and niche. \r\n \r\nWhat you get: \r\n \r\n10,000+ real visitors for just $10 \r\nGeo-targeted traffic for any country \r\nScalability available based on your needs \r\nUsed by marketers—w', NULL, NULL, 0, '2025-11-25 11:55:37', NULL),
(51, 'Julialic', 'cinkincaid@gmail.com', 'Support for Knowledge Bases', 'Greetings! Hope you\'re having a good one. \r\nDear Administrator, I provide grants to website owners for development and growth. No obligations involved. If this aligns with your needs, please reply. Please contact me on WhatsApp +380930262296', NULL, NULL, 0, '2025-11-27 03:46:21', NULL),
(52, 'Ankit S', 'info@bestaiseocompany.com', 'Re: SEO consultant', 'Hey team tavernpublico.com,\r\n\r\nHope your doing well!\r\n\r\nI just following your website and realized that despite having a good design; but it was not ranking high on any of the Search Engines (Google, Yahoo & Bing) for most of the keywords related to your business.\r\n\r\nWe can place your website on Google\'s 1st page.\r\n\r\n*  Top ranking on Google search!\r\n*  Improve website clicks and views!\r\n*  Increase Your Leads, clients & Revenue!\r\n\r\nInterested? Please provide your name, contact information, and email.\r\n\r\nBests Regards,\r\nAnkit\r\nBest AI SEO Company\r\nAccounts Manager\r\nwww.bestaiseocompany.com\r\nPhone No: +1 (949) 508-0277', NULL, NULL, 0, '2025-11-27 22:52:32', NULL),
(53, 'Mike Matheus Fischer', 'info@speed-seo.net', 'Find tavernpublico.com SEO Issues totally free', 'Hi, \r\nWorried about hidden SEO issues on your website? Let us help — completely free. \r\nRun a 100% free SEO check and discover the exact problems holding your site back from ranking higher on Google. \r\n \r\nRun Your Free SEO Check Now \r\nhttps://www.speed-seo.net/check-site-seo-score/ \r\n \r\nOr chat with us and our agent will run the report for you: https://www.speed-seo.net/whatsapp-with-us/ \r\n \r\nBest regards, \r\n \r\n \r\nMike Matheus Fischer\r\n \r\nSpeed SEO Digital \r\nEmail: info@speed-seo.net \r\nPhone/Wha', NULL, NULL, 0, '2025-11-28 08:56:50', NULL),
(54, 'Joanna Riggs', 'joannariggs83@gmail.com', 'Video Promotion for tavernpublico.com?', 'Hi,\r\n\r\nI just visited tavernpublico.com and wondered if you\'ve ever considered an impactful video to advertise your business? Our videos can generate impressive results on both your website and across social media.\r\n\r\nOur videos cost just $195 (USD) for a 30 second video ($239 for 60 seconds) and include a full script, voice-over and video.\r\n\r\nI can show you some previous videos we\'ve done if you want me to send some over. Let me know if you\'re interested in seeing samples of our previous work.\r\n\r\nRegards,\r\nJoanna\r\n\r\nUnsubscribe: https://unsubscribe.video/unsubscribe.php?d=tavernpublico.com', NULL, NULL, 0, '2025-11-29 06:38:09', NULL),
(55, 'Georgia Dibble', 'parkerharri.son31023+georgia.dibble@gmail.com', 'Curious about your website traffic?', 'Interested in sending real visitors to tavernpublico.com? Start tracking: https://rb.gy/p82gvr', NULL, NULL, 0, '2025-12-03 02:31:43', NULL),
(56, 'Mike Ralf Taylor', 'info@professionalseocleanup.com', 'Fix August Google Spam update ranking problems for free', 'Hi, \r\nWhile reviewing tavernpublico.com, we spotted toxic backlinks that could put your site at risk of a Google penalty. Especially that this Google SPAM update had a high impact in ranks. This is an easy and quick fix for you. Totally free of charge. No obligations. \r\n \r\nFix it now: \r\nhttps://www.professionalseocleanup.com/ \r\n \r\nNeed help or questions? Chat here: \r\nhttps://www.professionalseocleanup.com/whatsapp/ \r\n \r\nBest, \r\nMike Ralf Taylor\r\n \r\n+1 (855) 221-7591 \r\ninfo@professionalseocleanup', NULL, NULL, 0, '2025-12-07 06:59:23', NULL),
(57, 'Nikitalic', 'nikitafofanov46@gmail.com', 'Partnership: Developing Your Digital Asset', 'Warm greetings! Hope you\'re doing well. \r\n \r\nHello, I provide non-repayable grants to website administrators for development projects. If you have plans requiring funding, I\'d welcome a discussion. Please contact me on WhatsApp +79951399756', NULL, NULL, 0, '2025-12-08 08:40:27', NULL),
(58, 'Teodoro Sellars', 'sellars.teodoro22@googlemail.com', 'Want a consistent email income?', 'Want to discover a system where sending emails leads to real earnings? Try https://rb.gy/uxe0l2', NULL, NULL, 0, '2025-12-10 21:42:47', NULL),
(59, 'Myrtle Demaio', 'myrtle.demaio@gmail.com', 'Want an easy plug-and-profit setup?', 'Do you want to discover a system where automated emails provide daily profits? Visit https://rb.gy/uxe0l2', NULL, NULL, 0, '2025-12-12 12:38:59', NULL),
(60, 'AhmetOxity', 'morrismi1@outlook.com', 'Introduce', 'I\'m Ahmet, a bank staff in a Turkish bank. I\'ve been looking for someone who has the same nationality as you. A citizen of your country died in the recent earthquake in Turkey, he had in our bank fixed deposit of $11.5 million. \r\n \r\nIf my bank executive finds out about his death ,They would use the funds for themselves, I would like to prevent that from happening only if I get your cooperation, I knew about it because I was his account manager. Last week my bank held a meeting for the purpose of', NULL, NULL, 0, '2025-12-12 19:26:21', NULL),
(61, 'Ellie Edman', 'turnerfisher3.48382+ellie.edman@gmail.com', 'Get a free video for tavernpublico.com today', 'We can craft a video for tavernpublico.com to expand clicks and reach — want to see?\r\n\r\nVisit link here:  https://rb.gy/r6koew\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\nTo unsubscribe, please reply with subject:  Unsubscribe !tavernpublico.com', NULL, NULL, 0, '2025-12-15 20:54:15', NULL),
(62, 'Vince Mclain', 'tu.rnerfisher348382+vince.mclain@gmail.com', 'Curious how a video could grow tavernpublico.com?', 'We can craft a video for tavernpublico.com to grow your online audience — want to see?\r\n\r\nOverview here:  https://rb.gy/r6koew\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\nTo unsubscribe, please reply with subject:  Unsubscribe !tavernpublico.com', NULL, NULL, 0, '2025-12-16 19:40:37', NULL),
(63, 'Mike Nils Davies', 'info@strictlydigital.net', 'Semrush links for tavernpublico.com', 'Greetings, \r\n \r\nGetting some collection of links linking to tavernpublico.com may result in 0 value or harmful results for your business. \r\n \r\nIt really doesn’t matter how many inbound links you have, what matters is the total of search terms those websites are optimized for. \r\n \r\nThat is the most important factor. \r\nNot the overrated Moz DA or ahrefs DR score. \r\nThese can be faked easily. \r\nBUT the volume of high-traffic search terms the domains that link to you contain. \r\nThat’s it. \r\n \r\nMake', NULL, NULL, 0, '2025-12-18 10:08:17', NULL),
(64, 'Irene Zweig', 'zweig.irene@gmail.com', 'Curious about backlink visibility?', 'Want to see tavernpublico.com outrank competitors? Go here: https://rb.gy/19b0ah', NULL, NULL, 0, '2025-12-19 09:38:14', NULL),
(65, 'Marisa Hilton', 'turnerfi.sher348382+marisa.hilton@gmail.com', 'Would you like support with your social media?', 'Social media taking too much time for you?\r\n\r\nWe offer full Social Media Management, content creation, and engagement services to keep your brand visible across all platforms.\r\n\r\nClick for more info:  https://rb.gy/8ddzt2\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\nTo unsubscribe, please reply with subject:  Unsubscribe !tavernpublico.com', NULL, NULL, 0, '2025-12-21 11:33:08', NULL),
(66, 'Traci Dill', 't.urnerfisher348382+traci.dill@gmail.com', 'Recommendation for the person in charge of tavernpublico.com', 'This message is addressed to the administrator of tavernpublico.com.\r\n\r\nWe are an agency providing powerful SEO and digital marketing solutions designed to increase your visibility, traffic, and conversions. \r\n\r\nOUR SERVICES INCLUDE:\r\n- Social Media Management\r\n- Website Traffic\r\n- SEO Backlinks\r\n- Social Bookmarking Backlinks\r\n- Google Ranking\r\n- Google Maps Ranking\r\n- YouTube Ranking\r\n- Content Creation\r\n- Video Production\r\n- Get Real Clients\r\n- Full SEO Campaigns & Agency Services\r\n\r\nWhether your goal is boosting YouTube, driving more website traffic, or strengthening your SEO, we can help you achieve results.\r\n\r\nVisit the site here:  https://rb.gy/t7gc5i\r\n\r\nBest regards,\r\nSEO Expert & Specialist\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\nTo unsubscribe, please reply with subject:  Unsubscribe !tavernpublico.com', NULL, NULL, 0, '2025-12-22 01:10:48', NULL),
(67, 'Joanna Riggs', 'joannariggs83@gmail.com', 'Video Promotion for your website?', 'Hi,\r\n\r\nI just visited tavernpublico.com and wondered if you\'ve ever considered an impactful video to advertise your business? Our videos can generate impressive results on both your website and across social media.\r\n\r\nOur prices start from just $195 (USD).\r\n\r\nLet me know if you\'re interested in seeing samples of our previous work.\r\n\r\nRegards,\r\nJoanna\r\n\r\nUnsubscribe: https://unsubscribe.video/unsubscribe.php?d=tavernpublico.com', NULL, NULL, 0, '2026-01-06 13:38:28', NULL),
(68, 'Nilda Alger', 'nilda.alger@gmail.com', 'Traffic without paying for ads', 'The Rapid Traffic Flow system delivers tons of buyer-ready visitors to your links automatically. No paid ads, no site needed, no experience required — just set it up and see traffic pour in.\r\n\r\nGrab your spot now and begin driving leads today — don’t miss out:  https://rb.gy/t7m8dg', NULL, NULL, 0, '2026-01-07 13:18:54', NULL),
(69, 'Malorie Esteves', 'esteves.malorie@gmail.com', 'Boost website traffic', 'Ready to see tavernpublico.com traffic grow fast? Access now: https://rb.gy/p82gvr', NULL, NULL, 0, '2026-01-11 09:29:34', NULL),
(70, 'Jerilyn Garza', 'turnerfisher3483.82+jerilyn.garza@gmail.com', 'Do you struggle to keep your social media engaging?', 'Social media taking too much time for you?\r\n\r\nWe offer full Social Media Management, content creation, and engagement services to keep your brand visible across all platforms.\r\n\r\nInformation page:  https://rb.gy/8ddzt2\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\nTo unsubscribe, please reply with subject:  Unsubscribe !tavernpublico.com', NULL, NULL, 0, '2026-01-12 11:43:51', NULL),
(71, 'Ronnie Eldridge', 'ronnie.eldridge55@googlemail.com', 'Want to reach higher SEO authority?', 'Ready to see tavernpublico.com rank higher? Step in here: https://rb.gy/pcrbts', NULL, NULL, 0, '2026-01-17 16:16:34', NULL),
(72, 'LeonardTaido', 'jacksrenome@gmx.com', 'Derefhefjwdkifhgijfkwoddjeifj jiwdokdiwfheijfwjdiw jidjwksaodjegfijwokdaijdfe', 'Vertyowdiwjodko kofkosfjwgojfsjf oijwfwsfjowehgewjiofwj jewfkwkfdoeguhrfkadwknfew ijedkaoaswnfeugjfkadcajsfn tavernpublico.com', NULL, NULL, 0, '2026-01-20 04:13:59', NULL),
(73, 'Mike Jozef Morel', 'info@speed-seo.net', 'Find tavernpublico.com SEO Issues totally free', 'Hi, \r\nWorried about hidden SEO issues on your website? Let us help — completely free. \r\nRun a 100% free SEO check and discover the exact problems holding your site back from ranking higher on Google. \r\n \r\nRun Your Free SEO Check Now \r\nhttps://www.speed-seo.net/check-site-seo-score/ \r\n \r\nOr chat with us and our agent will run the report for you: https://www.speed-seo.net/whatsapp-with-us/ \r\n \r\nBest regards, \r\n \r\n \r\nMike Jozef Morel\r\n \r\nSpeed SEO Digital \r\nEmail: info@speed-seo.net \r\nPhone/WhatsAp', NULL, NULL, 0, '2026-01-22 11:36:26', NULL),
(74, 'Sarahlic', 'bsara5865@gmail.com', 'Supporting API Integration', 'Greetings! Hope you\'re having a good one. \r\nHello, I\'m contacting website owners about financial backing opportunities. If you\'re planning improvements or expansions that require funding, I may be able to help. Please contact me on WhatsApp +447464379544', NULL, NULL, 0, '2026-01-25 07:33:35', NULL),
(75, 'Sarahlic', 'bsara5865@gmail.com', 'Grant for Accessibility Improvements', 'Hi there! Wishing you a great day ahead. \r\n \r\nHello, I\'m contacting website owners about development grants. Your site shows promise. Would you be open to discussing financial support opportunities? Please contact me on WhatsApp +639561806316', NULL, NULL, 0, '2026-01-26 17:07:23', NULL),
(76, 'Ankit S', 'info@bestaiseocompany.com', 'Re: tavernpublico.com - google search results', 'Hey team tavernpublico.com,\r\n\r\nHope your doing well!\r\n\r\nI just following your website and realized that despite having a good design; but it was not ranking high on any of the Search Engines (Google, Yahoo & Bing) for most of the keywords related to your business.\r\n\r\nWe can place your website on Google\'s 1st page.\r\n\r\n*  Top ranking on Google search!\r\n*  Improve website clicks and views!\r\n*  Increase Your Leads, clients & Revenue!\r\n\r\nInterested? Please provide your name, contact information, and email.\r\n\r\nBests Regards,\r\nAnkit\r\nBest AI SEO Company\r\nAccounts Manager\r\nwww.bestaiseocompany.com\r\nPhone No: +1 (949) 508-0277', NULL, NULL, 0, '2026-01-29 05:11:54', NULL),
(77, 'Sarahlic', 'bsara5865@gmail.com', 'Grant Program for Website Development', 'Greetings! Hope you\'re having a good one. \r\nDear Administrator, I provide non-repayable grants for website development. Your site aligns with my interests. Would you consider this opportunity? Please contact me on WhatsApp +380668962476', NULL, NULL, 0, '2026-01-30 04:47:04', NULL),
(78, 'Mike Julien Richard', 'info@professionalseocleanup.com', 'Fix August Google Spam update ranking problems for free', 'Hi, \r\nWhile reviewing tavernpublico.com, we spotted toxic backlinks that could put your site at risk of a Google penalty. Especially that this Google SPAM update had a high impact in ranks. This is an easy and quick fix for you. Totally free of charge. No obligations. \r\n \r\nFix it now: \r\nhttps://www.professionalseocleanup.com/ \r\n \r\nNeed help or questions? Chat here: \r\nhttps://www.professionalseocleanup.com/whatsapp/ \r\n \r\nBest, \r\nMike Julien Richard\r\n \r\n+1 (855) 221-7591 \r\ninfo@professionalseoclea', NULL, NULL, 0, '2026-01-30 05:32:42', NULL),
(79, 'Sarahlic', 'bsara5865@gmail.com', 'Grant for Forum Development', 'Good day! Hope this message finds you well. \r\n \r\nGreetings, I\'m reaching out to offer development funding for your project. This is a genuine grant program. Would you like to talk details? Please contact me on WhatsApp +447464379544', NULL, NULL, 0, '2026-02-05 23:25:43', NULL),
(80, 'Ab Y', 'letsgetuoptimize@gmail.com', 'Re: Increase google organic ranking & SEO', 'Hey team tavernpublico.com,\r\n\r\nI would like to discuss SEO!\r\n\r\nI can help your website to get on first page of Google and increase the number of leads and sales you are getting from your website.\r\n\r\nMay I send you a quote & price list?\r\n\r\nBests Regards,\r\nAby\r\nBest AI SEO Company\r\nAccounts Manager\r\nwww.letsgetoptimize.com\r\nPhone No: +1 (949) 508-0277', NULL, NULL, 0, '2026-02-06 15:26:27', NULL),
(81, 'Mike Diego Visser', 'info@digital-x-press.com', 'Add AEO to your SEO strategies today !', 'Hi, \r\nI realize that some companies have difficulties recognizing that SEO is a long-term game and a well-planned ongoing investment. \r\n \r\nSadly, very few businesses have the dedication to observe the gradual yet impactful improvements that can completely change their online presence. \r\n \r\nWith regular search engine updates, a stable, ongoing approach including Answer Engine Optimization (AEO) is critical for getting a positive ROI. \r\n \r\nIf you recognize this as the ideal method, collaborate wit', NULL, NULL, 0, '2026-02-07 01:45:45', NULL),
(82, 'Joanna Riggs', 'joannariggs211@gmail.com', 'Video Promotion for tavernpublico.com', 'Hi,\r\n\r\nI just visited tavernpublico.com and wondered if you\'d ever thought about having an engaging video to explain what you do?\r\n\r\nOur videos cost just $195 (USD) for a 30 second video ($239 for 60 seconds) and include a full script, voice-over and video.\r\n\r\nI can show you some previous videos we\'ve done if you want me to send some over. Let me know if you\'re interested in seeing samples of our previous work.\r\n\r\nRegards,\r\nJoanna\r\n\r\nUnsubscribe: https://unsubscribe.video/unsubscribe.php?d=tavernpublico.com', NULL, NULL, 0, '2026-02-08 21:33:47', NULL),
(83, 'Ab Y', 'info@bestaiseocompany.com', 'Re : SEO Assistance', 'Hey team tavernpublico.com,\r\n\r\nHope your doing well!\r\n\r\nI just following your website and realized that despite having a good design; but it was not ranking high on any of the Search Engines (Google, Yahoo & Bing) for most of the keywords related to your business.\r\n\r\nWe can place your website on Google\'s 1st page.\r\n\r\n*  Top ranking on Google search!\r\n*  Improve website clicks and views!\r\n*  Increase Your Leads, clients & Revenue!\r\n\r\nInterested? Please provide your name, contact information, and email.\r\n\r\nBests Regards,\r\nAby\r\nBest AI SEO Company\r\nAccounts Manager\r\nwww.bestaiseocompany.com\r\nPhone No: +1 (949) 508-0277', NULL, NULL, 0, '2026-02-13 07:09:43', NULL),
(84, 'Nikitalic', 'nikitafofanov46@gmail.com', 'Supporting Informative Web Platforms', 'Warm greetings! Hope you\'re doing well. \r\n \r\nGreetings, I provide non-repayable grants to support website growth and maintenance. Your platform appears worthy of consideration. Open to discussion? Please contact me on WhatsApp +380733200811', NULL, NULL, 0, '2026-02-15 07:46:05', NULL),
(85, 'Nikitalic', 'nikitafofanov46@gmail.com', 'Support for Content Diversification', 'Hi! Hope your day is going smoothly. \r\n \r\nGreetings, I\'m writing to selected webmasters about sponsorship programs. This is a development grant offer. Interested in learning details? Please contact me on WhatsApp +37499940281', NULL, '2026-03-10 08:39:18', 1, '2026-02-17 00:45:55', NULL),
(86, 'Ab Y', 'info@bestaiseocompany.com', 'Re: SEO Packages and Costs', 'Hey team tavernpublico.com,\r\n\r\nHope your doing well!\r\n\r\nI just following your website and realized that despite having a good design; but it was not ranking high on any of the Search Engines (Google, Yahoo & Bing) for most of the keywords related to your business.\r\n\r\nWe can place your website on Google\'s 1st page.\r\n\r\n*  Top ranking on Google search!\r\n*  Improve website clicks and views!\r\n*  Increase Your Leads, clients & Revenue!\r\n\r\nInterested? Please provide your name, contact information, and email.\r\n\r\nBests Regards,\r\nAby\r\nBest AI SEO Company\r\nAccounts Manager\r\nwww.bestaiseocompany.com\r\nPhone No: +1 (949) 508-0277', NULL, '2026-03-10 08:39:17', 1, '2026-02-17 07:41:29', NULL),
(87, 'Ab Y', 'info@bestaiseocompany.com', 'Re: SEO Services', 'Hey team tavernpublico.com,\r\n\r\nHope your doing well!\r\n\r\nI just following your website and realized that despite having a good design; but it was not ranking high on any of the Search Engines (Google, Yahoo & Bing) for most of the keywords related to your business.\r\n\r\nWe can place your website on Google\'s 1st page.\r\n\r\n*  Top ranking on Google search!\r\n*  Improve website clicks and views!\r\n*  Increase Your Leads, clients & Revenue!\r\n\r\nInterested? Please provide your name, contact information, and email.\r\n\r\nBests Regards,\r\nAby\r\nBest AI SEO Company\r\nAccounts Manager\r\nwww.bestaiseocompany.com\r\nPhone No: +1 (949) 508-0277', NULL, '2026-03-10 08:39:17', 1, '2026-02-23 06:14:08', NULL),
(88, 'Kate Armstrong', 'katearmstrong1976@gmail.com', 'Youtube Growth Service: 400+ new subscribers each month', 'Hi there,\r\n\r\nWe run a YouTube growth service, which increases your number of subscribers both safely and practically.\r\n\r\n- We guarantee to gain you 400+ subscribers per month.\r\n- People subscribe because they are interested in your channel/videos, increasing likes, comments and interaction.\r\n- All actions are made manually by our team. We do not use any \'bots\'.\r\n\r\nIf you have any questions, let me know, and we can discuss further.\r\n\r\nKind Regards,\r\nKate\r\n\r\nOpt-out: https://unsubscribe.social/unsubscribe.php?d=tavernpublico.com', NULL, '2026-03-10 08:39:17', 1, '2026-02-25 01:11:43', NULL),
(89, 'Ab Y', 'info@bestaiseocompany.com', 'Re : SEO Assistance', 'Hey team tavernpublico.com,\r\n\r\nHope your doing well!\r\n\r\nI just following your website and realized that despite having a good design; but it was not ranking high on any of the Search Engines (Google, Yahoo & Bing) for most of the keywords related to your business.\r\n\r\nWe can place your website on Google\'s 1st page.\r\n\r\n*  Top ranking on Google search!\r\n*  Improve website clicks and views!\r\n*  Increase Your Leads, clients & Revenue!\r\n\r\nInterested? Please provide your name, contact information, and email.\r\n\r\nBests Regards,\r\nAby\r\nBest AI SEO Company\r\nAccounts Manager\r\nwww.bestaiseocompany.com\r\nPhone No: +1 (949) 508-0277', NULL, '2026-03-10 08:39:16', 1, '2026-03-05 14:37:34', NULL),
(90, 'Shona Beck', 'turnerfisher3.48382+shona.beck@gmail.com', 'Curious about your site’s backlinks?', 'Wondering how tavernpublico.com can gain quality backlinks? Claim your Free SEO Backlinks.  \r\n\r\nGo to the https://rb.gy/brgbb3, fill in your site details, then apply the coupon FREE_SEO at checkout to get the product for $0. \r\n\r\nDon’t forget to create a free account.\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\nTo unsubscribe, please reply with subject:  Unsubscribe !tavernpublico.com', NULL, '2026-03-10 08:39:15', 1, '2026-03-07 16:34:38', NULL),
(91, 'Denis Berger', 'denisberger.web@gmail.com', 'Re: Improve your website traffic and SEO', '\"Hello team,\r\n\r\n\r\nI was going through your website & I personally see a lot of potential in your website & business.\r\n\r\nWe can increase targeted traffic to your website so that it appears on Google\'s first page. Bing, Yahoo, etc.\r\n\r\nPlease provide your name, contact information, and email.\r\n\r\nWell wishes,\r\nDenis Berger\r\n\r\n\r\nWeb platform expertise across Squarespace, Shopify, Wix, WordPress, GoDaddy etc.\"', NULL, '2026-03-10 08:39:14', 1, '2026-03-09 08:22:42', NULL),
(92, 'Georgia Smith', 'georgia@getonglobe.com', 'Re: SEO - Expert', 'Hi there,\r\n\r\nI\'m Georgia, and I\'ve been creating powerful digital solutions for over 8 years as a web designer. \r\n\r\nTogether with my knowledgeable staff, I am an expert in e-commerce, WordPress, and Shopify development, backed by PPC, social media, and SEO tactics.\r\n\r\nOur purpose is to provide quantifiable online growth by coordinating design with business objectives. \r\n\r\nEvery project we work on is designed to satisfy customer demands and provide outcomes. \r\n\r\nI\'d be pleased to show you samples of our work and provide adjustable prices to meet your needs.\r\n\r\nThank you\r\nGeorgia | Founder & Marketing Director\r\nToll Free: +1 800 240 2815\r\nhttp://wa.me/917042524727\r\n\r\nNote: – If you’re not Interested in our Services, send us NO. \r\n\r\n\r\n\r\nYour website: tavernpublico.com', NULL, NULL, 0, '2026-03-11 12:02:36', NULL),
(93, 'Laura Cha', 'patrick.yup@mail.com', 'All Kind Of Business Loan', 'We are here to offer you the greatest option for the expansion of your company. To fulfil your needs, we offer the best possible business loan package                                                                                                                                                                      Email us today: info@financeworldwidehk.com \r\nBest regards, \r\nLaura Cha \r\nCustomer Service Representative', NULL, '2026-03-20 15:52:00', 1, '2026-03-13 05:11:04', NULL),
(94, 'Joanna Riggs', 'joannariggs211@gmail.com', 'Explainer Video for your website', 'Hi,\r\n\r\nI just visited tavernpublico.com and wondered if you\'ve ever considered an impactful video to advertise your business? Our videos can generate impressive results on both your website and across social media.\r\n\r\nOur prices start from just $195 (USD).\r\n\r\nLet me know if you\'re interested in seeing samples of our previous work.\r\n\r\nRegards,\r\nJoanna\r\n\r\nUnsubscribe: https://unsubscribe.video/unsubscribe.php?d=tavernpublico.com', NULL, NULL, 0, '2026-03-22 06:47:53', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `deletion_history`
--

CREATE TABLE `deletion_history` (
  `log_id` int(11) NOT NULL,
  `item_type` varchar(50) NOT NULL,
  `item_id` int(11) NOT NULL,
  `item_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `action_by` varchar(100) DEFAULT NULL,
  `deleted_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `purge_date` date NOT NULL,
  `deleted_by_user` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `deletion_history`
--

INSERT INTO `deletion_history` (`log_id`, `item_type`, `item_id`, `item_data`, `action_by`, `deleted_at`, `purge_date`, `deleted_by_user`) VALUES
(3, 'contact_message', 9, '{\"id\":9,\"name\":\"admin\",\"email\":\"keycm109@gmail.com\",\"subject\":\"Reservation Inquiry\",\"message\":\"HELLLO\",\"admin_reply\":\"HElllo Karlll Louis\",\"replied_at\":\"2025-09-27 23:03:15\",\"is_read\":1,\"created_at\":\"2025-09-27 23:02:49\",\"deleted_at\":null}', NULL, '2025-09-28 12:43:08', '2025-10-28', NULL),
(6, 'event', 7, '{\"id\":7,\"title\":\"dfghjkl\",\"date\":\"275760-07-06\",\"end_date\":null,\"description\":\"hgfdsdf\",\"image\":\"uploads\\/68d62b59851c63.68834595.png\",\"deleted_at\":null}', NULL, '2025-09-28 12:56:56', '2025-10-28', NULL),
(7, 'menu_item', 24, '{\"id\":24,\"name\":\"ertgh\",\"category\":\"Specialty\",\"price\":\"400.00\",\"image\":\"uploads\\/68d6d906e925d9.11936485.jpg\",\"description\":\"dfg\",\"deleted_at\":null}', NULL, '2025-09-28 13:03:04', '2025-10-28', NULL),
(8, 'testimonial', 2, '{\"id\":2,\"user_id\":14,\"reservation_id\":18,\"rating\":3,\"comment\":\"Based on the code, the rating feature will only appear on the homepage under specific conditions. It is not visible in your screenshot because one or more of the following requirements have not been met:\",\"is_featured\":1,\"created_at\":\"2025-09-26 23:04:18\",\"deleted_at\":null}', NULL, '2025-09-28 13:12:53', '2025-10-28', NULL),
(9, 'testimonial', 3, '{\"id\":3,\"user_id\":14,\"reservation_id\":24,\"rating\":3,\"comment\":\"dfghn\",\"is_featured\":1,\"created_at\":\"2025-09-27 02:02:39\",\"deleted_at\":null}', NULL, '2025-09-28 13:20:14', '2025-10-28', NULL),
(10, 'gallery_image', 12, '{\"id\":12,\"image\":\"uploads\\/68d62b9ea7afe7.31026399.png\",\"description\":\"seiokjhgfdsxcvbnmjhfdxcv\",\"deleted_at\":null}', NULL, '2025-09-28 13:23:23', '2025-10-28', NULL),
(12, 'event', 9, '{\"id\":9,\"title\":\"Hallowen\",\"date\":\"2025-11-01\",\"end_date\":\"2025-11-05\",\"description\":\"Happ Halloween\",\"image\":\"uploads\\/68d9326184f316.63890607.jpeg\",\"deleted_at\":null}', NULL, '2025-09-29 03:28:20', '2025-10-29', NULL),
(13, 'event', 10, '{\"id\":10,\"title\":\"Birthday ko ngayon\",\"date\":\"2025-09-30\",\"end_date\":\"2025-09-29\",\"description\":\"Anjing\",\"image\":\"uploads\\/68d9fd838946c2.41190803.png\",\"deleted_at\":null}', NULL, '2025-09-29 03:31:53', '2025-10-29', NULL),
(14, 'testimonial', 6, '{\"id\":6,\"user_id\":14,\"reservation_id\":30,\"rating\":2,\"comment\":\"thank you\",\"is_featured\":1,\"created_at\":\"2025-09-29 15:39:51\",\"deleted_at\":null}', NULL, '2025-09-29 07:46:02', '2025-10-29', NULL),
(15, 'blocked_date', 12, '{\"id\":12,\"block_date\":\"2025-09-29\"}', NULL, '2025-09-29 07:47:39', '2025-10-29', NULL),
(16, 'blocked_date', 11, '{\"id\":11,\"block_date\":\"2025-09-28\"}', NULL, '2025-09-29 07:47:48', '2025-10-29', NULL),
(17, 'blocked_date', 13, '{\"id\":13,\"block_date\":\"2025-09-30\"}', NULL, '2025-09-29 07:47:52', '2025-10-29', NULL),
(18, 'blocked_date', 15, '{\"id\":15,\"block_date\":\"2025-10-02\"}', NULL, '2025-09-29 07:47:56', '2025-10-29', NULL),
(19, 'blocked_date', 16, '{\"id\":16,\"block_date\":\"2025-09-29\"}', NULL, '2025-09-29 07:48:31', '2025-10-29', NULL),
(20, 'blocked_date', 17, '{\"id\":17,\"block_date\":\"2025-08-07\"}', NULL, '2025-09-29 07:49:01', '2025-10-29', NULL),
(21, 'contact_message', 10, '{\"id\":10,\"name\":\"user\",\"email\":\"penapaul858@gmail.com\",\"subject\":\"Reservation Inquiry\",\"message\":\"Of course. I\'ve updated the notification_control.php file to include a \\\"View\\\" button for both messages and comments. Clicking this button will open a modal window displaying the full text, which is especially useful for longer entries.\",\"admin_reply\":\"joshua\",\"replied_at\":\"2025-09-29 15:41:34\",\"is_read\":1,\"created_at\":\"2025-09-28 18:00:07\",\"deleted_at\":null}', NULL, '2025-09-29 08:03:19', '2025-10-29', NULL),
(22, 'hero_slide', 15, '{\"id\":15,\"image_path\":\"uploads\\/68da9aa16c43f7.95794272.jpeg\",\"title\":\"HEllo\",\"subtitle\":\"cvbn\",\"video_path\":\"\",\"media_type\":\"image\",\"created_at\":\"2025-09-29 22:41:37\",\"deleted_at\":null}', NULL, '2025-09-29 17:47:48', '2025-10-30', NULL),
(23, 'hero_slide', 14, '{\"id\":14,\"image_path\":\"uploads\\/68da9a94154ec6.29158311.jpeg\",\"title\":\"Tavern Publico\",\"subtitle\":\"fghjk\",\"video_path\":\"\",\"media_type\":\"image\",\"created_at\":\"2025-09-29 22:41:24\",\"deleted_at\":null}', NULL, '2025-09-29 17:47:51', '2025-10-30', NULL),
(24, 'hero_slide', 17, '{\"id\":17,\"image_path\":\"uploads\\/68dac695b68195.67723369.jpg\",\"title\":\"2nd\",\"subtitle\":\"AWRSDSSSSSS\",\"video_path\":\"\",\"media_type\":\"image\",\"created_at\":\"2025-09-30 01:49:09\",\"deleted_at\":null}', NULL, '2025-09-29 17:50:20', '2025-10-30', NULL),
(25, 'menu_item', 25, '{\"id\":25,\"name\":\"ert\",\"category\":\"Specialty\",\"price\":\"34.00\",\"image\":\"uploads\\/68d6d914ba4907.26884802.png\",\"description\":\"wertghj\",\"deleted_at\":null}', NULL, '2025-09-29 17:57:08', '2025-10-30', NULL),
(26, 'menu_item', 18, '{\"id\":18,\"name\":\"sdfgh\",\"category\":\"Specialty\",\"price\":\"34.00\",\"image\":\"uploads\\/68d6239f7c51c5.11311157.png\",\"description\":\"dfgh\",\"deleted_at\":null}', NULL, '2025-09-29 17:57:15', '2025-10-30', NULL),
(27, 'menu_item', 23, '{\"id\":23,\"name\":\"wdefg\",\"category\":\"Specialty\",\"price\":\"2.00\",\"image\":\"uploads\\/68d6d8f85b38e2.02182447.png\",\"description\":\"defgh\",\"deleted_at\":null}', NULL, '2025-09-29 17:57:20', '2025-10-30', NULL),
(28, 'menu_item', 26, '{\"id\":26,\"name\":\"caramel\",\"category\":\"Coffee\",\"price\":\"85.00\",\"image\":\"uploads\\/68d9329e59bee4.03672499.jpg\",\"description\":\"yummy\",\"deleted_at\":null}', NULL, '2025-09-29 18:03:29', '2025-10-30', NULL),
(29, 'menu_item', 22, '{\"id\":22,\"name\":\"asdf\",\"category\":\"Lunch\",\"price\":\"234.00\",\"image\":\"uploads\\/68d657427b8541.26434268.png\",\"description\":\"sdfghgfdvb\",\"deleted_at\":null}', NULL, '2025-09-29 18:03:32', '2025-10-30', NULL),
(30, 'menu_item', 21, '{\"id\":21,\"name\":\"cfe\",\"category\":\"Lunch\",\"price\":\"23.00\",\"image\":\"uploads\\/68d62a9ca42191.99713898.png\",\"description\":\"Completely replace the code in your update.php file with this corrected version. The only change is to the sanitize function.\",\"deleted_at\":null}', NULL, '2025-09-29 18:03:34', '2025-10-30', NULL),
(31, 'testimonial', 7, '{\"id\":7,\"user_id\":14,\"reservation_id\":27,\"rating\":3,\"comment\":\"You are right! My apologies, it looks like a default style from the icon library was overriding the rule meant to hide the icon on desktops.\\r\\n\\r\\nLet&#039;s apply a more specific and forceful CSS rule to fix this immediately.\",\"is_featured\":0,\"created_at\":\"2025-09-30 00:29:04\",\"deleted_at\":null}', NULL, '2025-09-29 18:13:05', '2025-10-30', NULL),
(32, 'event', 8, '{\"id\":8,\"title\":\"Chrismast\",\"date\":\"2025-12-21\",\"end_date\":\"2025-12-25\",\"description\":\"My apologies. I shortened the code in my last response to make it easier to copy, but I see now that you\'d prefer to see it fully formatted. You are correct, no functionality was removed, it was only compressed.\",\"image\":\"uploads\\/68d62ec99388d6.32195318.png\",\"deleted_at\":null}', NULL, '2025-09-29 18:15:27', '2025-10-30', NULL),
(40, 'hero_slide', 20, '{\"id\":20,\"image_path\":\"uploads\\/68e513aa9904e0.41391680.jpg\",\"title\":\"sd\",\"subtitle\":\"df\",\"video_path\":\"\",\"media_type\":\"image\",\"created_at\":\"2025-10-07 21:20:42\",\"deleted_at\":null}', NULL, '2025-10-07 13:50:31', '2025-11-06', NULL),
(41, 'hero_slide', 19, '{\"id\":19,\"image_path\":\"uploads\\/68e5139a218796.02181646.jpg\",\"title\":\"food\",\"subtitle\":\"AWRSDSSSSSS\",\"video_path\":\"\",\"media_type\":\"image\",\"created_at\":\"2025-10-07 21:20:26\",\"deleted_at\":null}', NULL, '2025-10-07 13:50:35', '2025-11-06', NULL),
(42, 'hero_slide', 12, '{\"id\":12,\"image_path\":\"uploads\\/68d80a5b4966f3.20083863.jpg\",\"title\":\"Tavern Publico\",\"subtitle\":\"Where good company gathers\",\"video_path\":\"\",\"media_type\":\"image\",\"created_at\":\"2025-09-28 00:01:31\",\"deleted_at\":null}', NULL, '2025-10-07 14:07:32', '2025-11-06', NULL),
(43, 'hero_slide', 18, '{\"id\":18,\"image_path\":\"uploads\\/68dac70392b650.98291033.jpg\",\"title\":\"3\",\"subtitle\":\"efg\",\"video_path\":\"\",\"media_type\":\"image\",\"created_at\":\"2025-09-30 01:50:59\",\"deleted_at\":null}', NULL, '2025-10-07 14:07:34', '2025-11-06', NULL),
(44, 'hero_slide', 16, '{\"id\":16,\"image_path\":\"uploads\\/68dac667d90566.26397573.jpg\",\"title\":\"1st\",\"subtitle\":\"2nd\",\"video_path\":\"\",\"media_type\":\"image\",\"created_at\":\"2025-09-30 01:48:23\",\"deleted_at\":null}', NULL, '2025-10-07 14:07:37', '2025-11-06', NULL),
(45, 'blocked_date', 19, '{\"id\":19,\"block_date\":\"2025-10-07\"}', NULL, '2025-10-08 14:25:28', '2025-11-07', NULL),
(47, 'blocked_date', 18, '{\"id\":18,\"block_date\":\"2025-09-29\"}', NULL, '2025-10-09 14:09:11', '2025-11-08', NULL),
(66, 'blocked_date', 20, '{\"id\":20,\"block_date\":\"2025-10-10\"}', NULL, '2025-10-09 16:26:15', '2025-11-09', NULL),
(71, 'blocked_date', 21, '{\"id\":21,\"block_date\":\"2025-10-12\"}', NULL, '2025-10-12 15:41:39', '2025-11-11', NULL),
(72, 'blocked_date', 31, '{\"id\":31,\"block_date\":\"2025-10-21\"}', NULL, '2025-10-12 15:42:16', '2025-11-11', NULL),
(73, 'blocked_date', 30, '{\"id\":30,\"block_date\":\"2025-10-20\"}', NULL, '2025-10-12 15:42:18', '2025-11-11', NULL),
(74, 'blocked_date', 29, '{\"id\":29,\"block_date\":\"2025-10-19\"}', NULL, '2025-10-12 15:42:22', '2025-11-11', NULL),
(75, 'blocked_date', 28, '{\"id\":28,\"block_date\":\"2025-10-18\"}', NULL, '2025-10-12 15:42:24', '2025-11-11', NULL),
(76, 'blocked_date', 27, '{\"id\":27,\"block_date\":\"2025-10-17\"}', NULL, '2025-10-12 15:42:27', '2025-11-11', NULL),
(77, 'blocked_date', 26, '{\"id\":26,\"block_date\":\"2025-10-16\"}', NULL, '2025-10-12 15:42:29', '2025-11-11', NULL),
(81, 'user', 151, '{\"user_id\":151,\"username\":\"Vincent\",\"email\":\"publicotavern@gmail.com\",\"otp\":null,\"otp_expiry\":null,\"reset_token\":null,\"reset_token_expiry\":null,\"is_verified\":1,\"is_admin\":0,\"avatar\":null,\"mobile\":null,\"birthday\":null,\"created_at\":\"2025-10-09 23:43:33\",\"deleted_at\":null}', NULL, '2025-10-14 16:25:33', '2025-11-14', NULL),
(82, 'menu_item', 30, '{\"id\":30,\"name\":\"ChickenSilog\",\"category\":\"Breakfast\",\"price\":\"148.00\",\"image\":\"uploads\\/68f20138293b19.50648522.jpeg\",\"description\":\"A perfectly crispy and juicy fried chicken served with fragrant garlic fried rice and a flawless sunny-side up egg. A simple, savory, and satisfying meal for any time of day.\",\"deleted_at\":null}', NULL, '2025-10-17 08:44:55', '2025-11-16', NULL),
(83, 'menu_item', 29, '{\"id\":29,\"name\":\"Pork Steak\",\"category\":\"Specialty\",\"price\":\"178.00\",\"image\":\"uploads\\/68dac9ed426bc6.00407464.jpg\",\"description\":\"The sound of the sauce simmering, the scent of caramelized onions... Filipino Pork Steak is less a dish, and more a call home.\",\"deleted_at\":null}', NULL, '2025-10-17 08:45:57', '2025-11-16', NULL),
(84, 'menu_item', 34, '{\"id\":34,\"name\":\"PorkSilog\",\"category\":\"Breakfast\",\"price\":\"148.00\",\"image\":\"uploads\\/68f202821ddda8.14563401.jpeg\",\"description\":\"A juicy, tender pork chop, seasoned and pan-fried to a perfect golden-brown. Served with a generous portion of garlic fried rice and a sunny-side up egg. A classic, hearty meal guaranteed to satisfy.\",\"deleted_at\":null}', NULL, '2025-10-17 08:49:10', '2025-11-16', NULL),
(85, 'menu_item', 31, '{\"id\":31,\"name\":\"SisigSIlog\",\"category\":\"Breakfast\",\"price\":\"148.00\",\"image\":\"uploads\\/68f20198b955f5.19969128.jpeg\",\"description\":\"Classic Kapampangan-style pork sisig, sizzling with savory and tangy flavors, served with fragrant garlic fried rice and a perfectly fried egg. The ultimate satisfying meal.\",\"deleted_at\":null}', NULL, '2025-10-17 08:52:14', '2025-11-16', NULL),
(86, 'menu_item', 38, '{\"id\":38,\"name\":\"Butter Shrimp\",\"category\":\"Lunch\",\"price\":\"298.00\",\"image\":\"uploads\\/68f2040f528af5.66022229.jpeg\",\"description\":\"Fresh, plump shrimp saut\\u00e9ed to perfection in a rich and luscious sauce of golden butter, toasted garlic, and a hint of spice. This decadent dish is simple, aromatic, and incredibly flavorful, making it a perfect main course or a luxurious appetizer.\",\"deleted_at\":null}', NULL, '2025-10-17 09:03:55', '2025-11-16', NULL),
(87, 'hero_slide', 13, '{\"id\":13,\"image_path\":\"\",\"title\":\"\",\"subtitle\":\"\",\"video_path\":\"uploads\\/68d80a65aadfd9.10474346.mp4\",\"media_type\":\"video\",\"created_at\":\"2025-09-28 00:01:41\",\"deleted_at\":null}', NULL, '2025-10-17 09:20:28', '2025-11-16', NULL),
(88, 'hero_slide', 24, '{\"id\":24,\"image_path\":\"\",\"title\":\"\",\"subtitle\":\"\",\"video_path\":\"\",\"media_type\":\"video\",\"created_at\":\"2025-10-17 17:32:59\",\"deleted_at\":null}', NULL, '2025-10-17 09:33:03', '2025-11-16', NULL),
(89, 'hero_slide', 25, '{\"id\":25,\"image_path\":\"\",\"title\":\"\",\"subtitle\":\"\",\"video_path\":\"uploads\\/68f20d9764cb18.75387971.mp4\",\"media_type\":\"video\",\"created_at\":\"2025-10-17 17:34:15\",\"deleted_at\":null}', NULL, '2025-10-17 09:34:29', '2025-11-16', NULL),
(90, 'user', 173, '{\"user_id\":173,\"username\":\"Vincent21\",\"email\":\"vinee0163@gmail.com\",\"otp\":null,\"otp_expiry\":null,\"reset_token\":null,\"reset_token_expiry\":null,\"is_verified\":1,\"is_admin\":0,\"avatar\":null,\"mobile\":null,\"birthday\":null,\"created_at\":\"2025-10-17 20:29:50\",\"deleted_at\":null}', NULL, '2025-10-17 12:31:16', '2025-11-16', NULL),
(91, 'user', 175, '{\"user_id\":175,\"username\":\"Manager2002\",\"email\":\"Vincent@gmail.com\",\"otp\":null,\"otp_expiry\":null,\"reset_token\":null,\"reset_token_expiry\":null,\"is_verified\":0,\"is_admin\":0,\"role\":\"customer\",\"avatar\":null,\"mobile\":null,\"birthday\":null,\"created_at\":\"2025-10-19 14:23:21\",\"deleted_at\":null}', NULL, '2025-10-19 06:23:30', '2025-11-18', NULL),
(92, 'reservation', 42, '{\"reservation_id\":42,\"user_id\":14,\"res_date\":\"2025-10-19\",\"res_time\":\"15:00:00\",\"num_guests\":23,\"res_name\":\"Vince\",\"res_phone\":\"09663195259\",\"res_email\":\"penapaul858@gmail.com\",\"status\":\"Confirmed\",\"created_at\":\"2025-10-17 22:02:06\",\"assigned_table\":null,\"table_id\":null,\"is_notified\":0,\"deleted_at\":null,\"source\":\"Online\",\"reservation_type\":\"Dine-in\",\"valid_id_path\":\"uploads\\/ids\\/id_68f24c5ecedc12.02522622.jpg\"}', NULL, '2025-10-19 06:34:30', '2025-11-18', NULL),
(93, 'reservation', 43, '{\"reservation_id\":43,\"user_id\":183,\"res_date\":\"2025-11-06\",\"res_time\":\"17:00:00\",\"num_guests\":2,\"res_name\":\"Felix\",\"res_phone\":\"09667785843\",\"res_email\":\"johnfelix.dizon123@gmail.com\",\"status\":\"Declined\",\"created_at\":\"2025-11-06 16:16:21\",\"assigned_table\":null,\"table_id\":null,\"is_notified\":0,\"deleted_at\":null,\"source\":\"Online\",\"reservation_type\":\"Dine-in\",\"valid_id_path\":\"uploads\\/ids\\/id_690c5955a368b4.36716111.png\"}', NULL, '2025-11-06 12:33:22', '2025-12-06', NULL),
(94, 'testimonial', 4, '{\"id\":4,\"user_id\":14,\"reservation_id\":25,\"rating\":3,\"comment\":\"dsfghj\",\"is_featured\":1,\"created_at\":\"2025-09-27 02:05:48\",\"deleted_at\":null}', NULL, '2025-11-11 07:44:37', '2025-12-11', NULL),
(95, 'testimonial', 5, '{\"id\":5,\"user_id\":14,\"reservation_id\":21,\"rating\":3,\"comment\":\"sdfgh\",\"is_featured\":0,\"created_at\":\"2025-09-27 02:10:52\",\"deleted_at\":null}', NULL, '2025-11-11 07:44:42', '2025-12-11', NULL),
(96, 'testimonial', 13, '{\"id\":13,\"user_id\":14,\"reservation_id\":39,\"rating\":2,\"comment\":\"eddd\",\"is_featured\":0,\"created_at\":\"2025-10-13 12:30:11\",\"deleted_at\":null}', NULL, '2025-11-11 07:44:45', '2025-12-11', NULL),
(97, 'reservation', 38, '{\"reservation_id\":38,\"user_id\":null,\"res_date\":\"2025-10-10\",\"res_time\":\"13:00:00\",\"num_guests\":11,\"res_name\":\"Hansel\",\"res_phone\":\"09667785843\",\"res_email\":\"publicotavern@gmail.com\",\"status\":\"Declined\",\"created_at\":\"2025-10-10 11:19:01\",\"assigned_table\":null,\"table_id\":null,\"is_notified\":0,\"deleted_at\":null,\"source\":\"Online\",\"reservation_type\":\"Dine-in\",\"valid_id_path\":null,\"applied_coupon_code\":null}', NULL, '2025-11-11 07:45:04', '2025-12-11', NULL),
(98, 'reservation', 39, '{\"reservation_id\":39,\"user_id\":14,\"res_date\":\"2025-10-23\",\"res_time\":\"11:00:00\",\"num_guests\":10,\"res_name\":\"Hansel\",\"res_phone\":\"09667785843\",\"res_email\":\"publicotavern@gmail.com\",\"status\":\"Confirmed\",\"created_at\":\"2025-10-13 12:27:18\",\"assigned_table\":null,\"table_id\":null,\"is_notified\":1,\"deleted_at\":null,\"source\":\"Online\",\"reservation_type\":\"Dine-in\",\"valid_id_path\":null,\"applied_coupon_code\":null}', NULL, '2025-11-11 07:45:07', '2025-12-11', NULL),
(99, 'reservation', 37, '{\"reservation_id\":37,\"user_id\":14,\"res_date\":\"2025-10-10\",\"res_time\":\"11:00:00\",\"num_guests\":11,\"res_name\":\"Kimberly Anne D. Pena\",\"res_phone\":\"09667785843\",\"res_email\":\"vincee293@gmail.com\",\"status\":\"Cancelled\",\"created_at\":\"2025-10-10 00:40:09\",\"assigned_table\":null,\"table_id\":null,\"is_notified\":1,\"deleted_at\":null,\"source\":\"Online\",\"reservation_type\":\"Dine-in\",\"valid_id_path\":null,\"applied_coupon_code\":null}', NULL, '2025-11-11 07:45:11', '2025-12-11', NULL),
(100, 'contact_message', 8, '{\"id\":8,\"name\":\"fgh\",\"email\":\"123454@gmail.com\",\"subject\":\"Reservation Inquiry\",\"message\":\"efghjcvb\",\"admin_reply\":null,\"replied_at\":\"2025-10-17 00:41:17\",\"is_read\":1,\"created_at\":\"2025-09-27 14:59:18\",\"deleted_at\":null}', NULL, '2025-11-11 09:00:49', '2025-12-11', NULL),
(101, 'contact_message', 7, '{\"id\":7,\"name\":\"dfgh\",\"email\":\"12jfksdfvk@gmail.com\",\"subject\":\"dfg\",\"message\":\"dwfg\",\"admin_reply\":null,\"replied_at\":\"2025-10-14 23:26:21\",\"is_read\":1,\"created_at\":\"2025-09-27 14:54:57\",\"deleted_at\":null}', NULL, '2025-11-11 09:00:56', '2025-12-11', NULL),
(102, 'contact_message', 13, '{\"id\":13,\"name\":\"Vincent paul D Pena\",\"email\":\"penapaul858@gmail.com\",\"subject\":\"Reservation Inquiry\",\"message\":\"hi\",\"admin_reply\":null,\"replied_at\":\"2025-10-17 00:41:16\",\"is_read\":1,\"created_at\":\"2025-10-15 01:21:35\",\"deleted_at\":null}', NULL, '2025-11-11 09:01:02', '2025-12-11', NULL),
(103, 'event', 13, '{\"id\":13,\"title\":\"Happy Valentine\'s Day\",\"date\":\"2026-02-14\",\"end_date\":null,\"description\":\"\\\"Love is the main course, and our atmosphere is the perfect accompaniment. A night you\\u2019ll both cherish.\\\"\",\"image\":\"uploads\\/68dacd8d9cb509.70007263.jpg\",\"deleted_at\":null}', NULL, '2025-11-11 09:16:43', '2025-12-11', NULL),
(107, 'blocked_date', 34, '{\"id\":34,\"block_date\":\"2025-11-13\"}', 'Tavernpublico', '2025-11-11 16:03:01', '2025-12-12', NULL),
(108, 'reservation', 44, '{\"reservation_id\":44,\"user_id\":null,\"res_date\":\"2025-11-09\",\"res_time\":\"13:00:00\",\"num_guests\":50,\"res_name\":\"user\",\"res_phone\":\"09667785843\",\"res_email\":\"penapaul858@gmail.com\",\"status\":\"Declined\",\"created_at\":\"2025-11-08 22:40:31\",\"assigned_table\":null,\"table_id\":null,\"is_notified\":0,\"deleted_at\":null,\"source\":\"Online\",\"reservation_type\":\"Dine-in\",\"valid_id_path\":\"uploads\\/ids\\/id_690f565f8cc9f8.20635478.png\",\"applied_coupon_code\":\"TAVERN10\",\"action_by\":\"Tavernpublico\"}', NULL, '2025-11-11 16:50:18', '2025-12-12', NULL),
(109, 'reservation', 41, '{\"reservation_id\":41,\"user_id\":null,\"res_date\":\"2025-10-19\",\"res_time\":\"14:00:00\",\"num_guests\":5,\"res_name\":\"user\",\"res_phone\":\"09663195259\",\"res_email\":\"penapaul858@gmail.com\",\"status\":\"Declined\",\"created_at\":\"2025-10-17 21:51:12\",\"assigned_table\":null,\"table_id\":null,\"is_notified\":1,\"deleted_at\":null,\"source\":\"Online\",\"reservation_type\":\"Private Event\",\"valid_id_path\":\"uploads\\/ids\\/id_68f249cfd494b5.83935044.png\",\"applied_coupon_code\":null,\"action_by\":null}', NULL, '2025-11-11 16:50:21', '2025-12-12', NULL),
(110, 'reservation', 40, '{\"reservation_id\":40,\"user_id\":null,\"res_date\":\"2025-10-18\",\"res_time\":\"14:00:00\",\"num_guests\":2,\"res_name\":\"user\",\"res_phone\":\"09667785843\",\"res_email\":\"penapaul858@gmail.com\",\"status\":\"Confirmed\",\"created_at\":\"2025-10-17 21:14:44\",\"assigned_table\":null,\"table_id\":null,\"is_notified\":1,\"deleted_at\":null,\"source\":\"Online\",\"reservation_type\":\"Dine-in\",\"valid_id_path\":\"uploads\\/ids\\/id_68f241443c0016.73019534.jpg\",\"applied_coupon_code\":null,\"action_by\":null}', NULL, '2025-11-11 16:50:24', '2025-12-12', NULL),
(111, 'reservation', 35, '{\"reservation_id\":35,\"user_id\":null,\"res_date\":\"2025-10-08\",\"res_time\":\"11:00:00\",\"num_guests\":10,\"res_name\":\"Vincent paul D Pena\",\"res_phone\":\"09667785843\",\"res_email\":\"keycm109@gmail.com\",\"status\":\"Declined\",\"created_at\":\"2025-10-07 16:11:23\",\"assigned_table\":null,\"table_id\":null,\"is_notified\":1,\"deleted_at\":null,\"source\":\"Online\",\"reservation_type\":\"Dine-in\",\"valid_id_path\":null,\"applied_coupon_code\":null,\"action_by\":null}', NULL, '2025-11-11 16:50:27', '2025-12-12', NULL),
(112, 'reservation', 34, '{\"reservation_id\":34,\"user_id\":null,\"res_date\":\"2025-11-07\",\"res_time\":\"11:00:00\",\"num_guests\":8,\"res_name\":\"Vincent paul D Pena\",\"res_phone\":\"09667785843\",\"res_email\":\"penapaul858@gmail.com\",\"status\":\"Declined\",\"created_at\":\"2025-10-07 15:06:58\",\"assigned_table\":null,\"table_id\":null,\"is_notified\":1,\"deleted_at\":null,\"source\":\"Online\",\"reservation_type\":\"Dine-in\",\"valid_id_path\":null,\"applied_coupon_code\":null,\"action_by\":null}', NULL, '2025-11-11 16:50:30', '2025-12-12', NULL),
(113, 'reservation', 33, '{\"reservation_id\":33,\"user_id\":null,\"res_date\":\"2025-10-05\",\"res_time\":\"11:00:00\",\"num_guests\":8,\"res_name\":\"Vincent paul D Pena\",\"res_phone\":\"09667785843\",\"res_email\":\"penapaul858@gmail.com\",\"status\":\"Confirmed\",\"created_at\":\"2025-10-05 23:03:34\",\"assigned_table\":null,\"table_id\":null,\"is_notified\":1,\"deleted_at\":null,\"source\":\"Online\",\"reservation_type\":\"Dine-in\",\"valid_id_path\":null,\"applied_coupon_code\":null,\"action_by\":null}', NULL, '2025-11-11 16:50:33', '2025-12-12', NULL),
(114, 'reservation', 32, '{\"reservation_id\":32,\"user_id\":null,\"res_date\":\"2025-10-05\",\"res_time\":\"11:00:00\",\"num_guests\":8,\"res_name\":\"Vincent paul D Pena\",\"res_phone\":\"09667785843\",\"res_email\":\"keycm109@gmail.com\",\"status\":\"Confirmed\",\"created_at\":\"2025-10-05 22:44:31\",\"assigned_table\":null,\"table_id\":null,\"is_notified\":1,\"deleted_at\":null,\"source\":\"Online\",\"reservation_type\":\"Dine-in\",\"valid_id_path\":null,\"applied_coupon_code\":null,\"action_by\":null}', NULL, '2025-11-11 16:50:36', '2025-12-12', NULL),
(115, 'reservation', 31, '{\"reservation_id\":31,\"user_id\":null,\"res_date\":\"2025-10-05\",\"res_time\":\"11:00:00\",\"num_guests\":8,\"res_name\":\"Vincent paul D Pena\",\"res_phone\":\"09667785843\",\"res_email\":\"keycm109@gmail.com\",\"status\":\"Confirmed\",\"created_at\":\"2025-10-05 22:20:58\",\"assigned_table\":null,\"table_id\":null,\"is_notified\":1,\"deleted_at\":null,\"source\":\"Online\",\"reservation_type\":\"Dine-in\",\"valid_id_path\":null,\"applied_coupon_code\":null,\"action_by\":null}', NULL, '2025-11-11 16:50:38', '2025-12-12', NULL),
(116, 'reservation', 30, '{\"reservation_id\":30,\"user_id\":null,\"res_date\":\"2025-10-01\",\"res_time\":\"11:00:00\",\"num_guests\":10,\"res_name\":\"James\",\"res_phone\":\"09667785843\",\"res_email\":\"keycm109@gmail.com\",\"status\":\"Confirmed\",\"created_at\":\"2025-09-28 18:35:49\",\"assigned_table\":null,\"table_id\":null,\"is_notified\":1,\"deleted_at\":null,\"source\":\"Online\",\"reservation_type\":\"Dine-in\",\"valid_id_path\":null,\"applied_coupon_code\":null,\"action_by\":null}', NULL, '2025-11-11 16:50:40', '2025-12-12', NULL),
(117, 'reservation', 29, '{\"reservation_id\":29,\"user_id\":null,\"res_date\":\"2025-09-28\",\"res_time\":\"14:00:00\",\"num_guests\":10,\"res_name\":\"ed\",\"res_phone\":\"09663195259\",\"res_email\":\"karllouisnavarro@gmail.com\",\"status\":\"Confirmed\",\"created_at\":\"2025-09-28 18:04:53\",\"assigned_table\":null,\"table_id\":null,\"is_notified\":1,\"deleted_at\":null,\"source\":\"Online\",\"reservation_type\":\"Dine-in\",\"valid_id_path\":null,\"applied_coupon_code\":null,\"action_by\":null}', NULL, '2025-11-11 16:50:43', '2025-12-12', NULL),
(118, 'reservation', 23, '{\"reservation_id\":23,\"user_id\":null,\"res_date\":\"2025-09-27\",\"res_time\":\"11:00:00\",\"num_guests\":56,\"res_name\":\"isaac macaraeg\",\"res_phone\":\"09667785843\",\"res_email\":\"vincentpaul.pena@gnc.edu.ph\",\"status\":\"Pending\",\"created_at\":\"2025-09-27 01:26:35\",\"assigned_table\":null,\"table_id\":null,\"is_notified\":0,\"deleted_at\":null,\"source\":\"Online\",\"reservation_type\":\"Dine-in\",\"valid_id_path\":null,\"applied_coupon_code\":null,\"action_by\":null}', NULL, '2025-11-11 16:50:45', '2025-12-12', NULL),
(119, 'blocked_date', 33, '{\"id\":33,\"block_date\":\"2025-11-12\"}', 'Tavernpublico', '2025-11-11 17:14:57', '2025-12-12', NULL),
(120, 'blocked_date', 35, '{\"id\":35,\"block_date\":\"2025-11-27\"}', 'Tavernpublico', '2025-11-11 17:37:44', '2025-12-12', NULL),
(121, 'blocked_date', 23, '{\"id\":23,\"block_date\":\"2025-10-13\"}', 'Tavernpublico', '2025-11-12 00:55:00', '2025-12-12', NULL),
(122, 'blocked_date', 32, '{\"id\":32,\"block_date\":\"2025-10-18\"}', 'Tavernpublico', '2025-11-12 01:00:18', '2025-12-12', NULL),
(127, 'reservation', 50, '{\"reservation_id\":50,\"user_id\":null,\"res_date\":\"2025-11-14\",\"res_time\":\"11:00:00\",\"num_guests\":4,\"res_name\":\"Vincent paul D Pena\",\"res_phone\":\"09667785843\",\"res_email\":\"penapaul858@gmail.com\",\"status\":\"Confirmed\",\"created_at\":\"2025-11-12 23:26:05\",\"assigned_table\":null,\"table_id\":null,\"is_notified\":1,\"deleted_at\":null,\"source\":\"Online\",\"reservation_type\":\"Dine-in\",\"valid_id_path\":\"uploads\\/ids\\/id_6914a70d187052.32781682.png\",\"applied_coupon_code\":null,\"action_by\":\"Tavernpublico\"}', NULL, '2025-11-12 21:21:51', '2025-12-13', NULL),
(128, 'reservation', 49, '{\"reservation_id\":49,\"user_id\":null,\"res_date\":\"2025-11-13\",\"res_time\":\"12:00:00\",\"num_guests\":5,\"res_name\":\"Vince\",\"res_phone\":\"09667785843\",\"res_email\":\"penapaul858@gmail.com\",\"status\":\"Confirmed\",\"created_at\":\"2025-11-12 23:19:33\",\"assigned_table\":null,\"table_id\":null,\"is_notified\":1,\"deleted_at\":null,\"source\":\"Online\",\"reservation_type\":\"Dine-in\",\"valid_id_path\":\"uploads\\/ids\\/id_6914a5858e7432.81506592.jpg\",\"applied_coupon_code\":null,\"action_by\":\"Tavernpublico\"}', NULL, '2025-11-12 21:21:55', '2025-12-13', NULL),
(129, 'reservation', 48, '{\"reservation_id\":48,\"user_id\":null,\"res_date\":\"2025-11-13\",\"res_time\":\"12:00:00\",\"num_guests\":5,\"res_name\":\"Vince\",\"res_phone\":\"09667785843\",\"res_email\":\"penapaul858@gmail.com\",\"status\":\"Confirmed\",\"created_at\":\"2025-11-12 23:12:18\",\"assigned_table\":null,\"table_id\":null,\"is_notified\":1,\"deleted_at\":null,\"source\":\"Online\",\"reservation_type\":\"Dine-in\",\"valid_id_path\":\"uploads\\/ids\\/id_6914a3d2889336.30350759.png\",\"applied_coupon_code\":null,\"action_by\":\"Tavernpublico\"}', NULL, '2025-11-12 21:21:58', '2025-12-13', NULL),
(130, 'reservation', 28, '{\"reservation_id\":28,\"user_id\":null,\"res_date\":\"2025-02-12\",\"res_time\":\"20:47:00\",\"num_guests\":10,\"res_name\":\"Vincent paul D Pena\",\"res_phone\":\"09667785843\",\"res_email\":\"keycm109@gmail.com\",\"status\":\"Confirmed\",\"created_at\":\"2025-09-28 17:47:55\",\"assigned_table\":null,\"table_id\":null,\"is_notified\":0,\"deleted_at\":null,\"source\":\"Walk-in\",\"reservation_type\":\"Dine-in\",\"valid_id_path\":null,\"applied_coupon_code\":null,\"action_by\":null}', NULL, '2025-11-12 21:22:07', '2025-12-13', NULL),
(131, 'reservation', 27, '{\"reservation_id\":27,\"user_id\":null,\"res_date\":\"2025-09-28\",\"res_time\":\"11:00:00\",\"num_guests\":10,\"res_name\":\"Kimberly Anne D. Pena\",\"res_phone\":\"09663195259\",\"res_email\":\"karllouisnavarro@gmail.com\",\"status\":\"Declined\",\"created_at\":\"2025-09-28 16:29:56\",\"assigned_table\":null,\"table_id\":null,\"is_notified\":1,\"deleted_at\":null,\"source\":\"Online\",\"reservation_type\":\"Dine-in\",\"valid_id_path\":null,\"applied_coupon_code\":null,\"action_by\":\"Tavernpublico\"}', NULL, '2025-11-12 21:22:09', '2025-12-13', NULL),
(132, 'reservation', 26, '{\"reservation_id\":26,\"user_id\":null,\"res_date\":\"2025-09-27\",\"res_time\":\"11:00:00\",\"num_guests\":50,\"res_name\":\"Tavern\",\"res_phone\":\"09663195259\",\"res_email\":\"karllouisnavarro@gmail.com\",\"status\":\"Confirmed\",\"created_at\":\"2025-09-27 23:02:30\",\"assigned_table\":null,\"table_id\":null,\"is_notified\":1,\"deleted_at\":null,\"source\":\"Online\",\"reservation_type\":\"Dine-in\",\"valid_id_path\":null,\"applied_coupon_code\":null,\"action_by\":null}', NULL, '2025-11-12 21:22:12', '2025-12-13', NULL),
(133, 'reservation', 24, '{\"reservation_id\":24,\"user_id\":null,\"res_date\":\"2025-09-27\",\"res_time\":\"11:00:00\",\"num_guests\":12,\"res_name\":\"Vincent paul D Pena\",\"res_phone\":\"09667785843\",\"res_email\":\"penapaul858@gmail.com\",\"status\":\"Confirmed\",\"created_at\":\"2025-09-27 01:31:35\",\"assigned_table\":null,\"table_id\":null,\"is_notified\":1,\"deleted_at\":null,\"source\":\"Online\",\"reservation_type\":\"Dine-in\",\"valid_id_path\":null,\"applied_coupon_code\":null,\"action_by\":null}', NULL, '2025-11-12 21:22:15', '2025-12-13', NULL),
(134, 'reservation', 22, '{\"reservation_id\":22,\"user_id\":null,\"res_date\":\"2025-09-27\",\"res_time\":\"11:00:00\",\"num_guests\":1,\"res_name\":\"Vincent\",\"res_phone\":\"09663195259\",\"res_email\":\"karllouisnavarro@gmail.com\",\"status\":\"Declined\",\"created_at\":\"2025-09-27 01:03:24\",\"assigned_table\":null,\"table_id\":null,\"is_notified\":1,\"deleted_at\":null,\"source\":\"Online\",\"reservation_type\":\"Dine-in\",\"valid_id_path\":null,\"applied_coupon_code\":null,\"action_by\":null}', NULL, '2025-11-12 21:22:18', '2025-12-13', NULL),
(136, 'contact_message', 30, '{\"id\":30,\"name\":\"Hansel John\",\"email\":\"keycm109@gmail.com\",\"subject\":\"Reservation Inquiry\",\"message\":\"sdfghj\",\"admin_reply\":null,\"replied_at\":null,\"is_read\":0,\"created_at\":\"2025-11-12 05:48:05\",\"deleted_at\":null}', 'Tavernpublico', '2025-11-16 03:47:00', '2025-12-16', NULL),
(137, 'contact_message', 29, '{\"id\":29,\"name\":\"Hansel John\",\"email\":\"keycm109@gmail.com\",\"subject\":\"Reservation Inquiry\",\"message\":\"Good morning\",\"admin_reply\":null,\"replied_at\":null,\"is_read\":0,\"created_at\":\"2025-11-12 02:42:01\",\"deleted_at\":null}', 'Tavernpublico', '2025-11-16 03:47:02', '2025-12-16', NULL),
(138, 'contact_message', 28, '{\"id\":28,\"name\":\"Hansel John\",\"email\":\"keycm109@gmail.com\",\"subject\":\"Reservation Inquiry\",\"message\":\"HELOOOOO\",\"admin_reply\":\"on the notification of reservation can you to a modal so that i can read full the notification when i click the reservation notification\",\"replied_at\":\"2025-11-12 02:08:31\",\"is_read\":1,\"created_at\":\"2025-11-12 00:58:14\",\"deleted_at\":null}', 'Tavernpublico', '2025-11-16 03:47:04', '2025-12-16', NULL),
(139, 'contact_message', 23, '{\"id\":23,\"name\":\"Hansel John\",\"email\":\"keycm109@gmail.com\",\"subject\":\"Reservation Inquiry\",\"message\":\"HELOOOOO\",\"admin_reply\":null,\"replied_at\":\"2025-11-12 01:00:30\",\"is_read\":1,\"created_at\":\"2025-11-12 00:58:13\",\"deleted_at\":null}', 'Tavernpublico', '2025-11-16 03:47:06', '2025-12-16', NULL),
(140, 'contact_message', 24, '{\"id\":24,\"name\":\"Hansel John\",\"email\":\"keycm109@gmail.com\",\"subject\":\"Reservation Inquiry\",\"message\":\"HELOOOOO\",\"admin_reply\":null,\"replied_at\":\"2025-11-12 01:00:29\",\"is_read\":1,\"created_at\":\"2025-11-12 00:58:13\",\"deleted_at\":null}', 'Tavernpublico', '2025-11-16 03:47:08', '2025-12-16', NULL),
(141, 'contact_message', 25, '{\"id\":25,\"name\":\"Hansel John\",\"email\":\"keycm109@gmail.com\",\"subject\":\"Reservation Inquiry\",\"message\":\"HELOOOOO\",\"admin_reply\":null,\"replied_at\":\"2025-11-12 01:00:28\",\"is_read\":1,\"created_at\":\"2025-11-12 00:58:13\",\"deleted_at\":null}', 'Tavernpublico', '2025-11-16 03:47:09', '2025-12-16', NULL),
(142, 'contact_message', 26, '{\"id\":26,\"name\":\"Hansel John\",\"email\":\"keycm109@gmail.com\",\"subject\":\"Reservation Inquiry\",\"message\":\"HELOOOOO\",\"admin_reply\":null,\"replied_at\":\"2025-11-12 01:00:30\",\"is_read\":1,\"created_at\":\"2025-11-12 00:58:13\",\"deleted_at\":null}', 'Tavernpublico', '2025-11-16 03:47:11', '2025-12-16', NULL),
(143, 'contact_message', 27, '{\"id\":27,\"name\":\"Hansel John\",\"email\":\"keycm109@gmail.com\",\"subject\":\"Reservation Inquiry\",\"message\":\"HELOOOOO\",\"admin_reply\":null,\"replied_at\":\"2025-11-12 01:00:30\",\"is_read\":1,\"created_at\":\"2025-11-12 00:58:13\",\"deleted_at\":null}', 'Tavernpublico', '2025-11-16 03:47:13', '2025-12-16', NULL),
(144, 'contact_message', 20, '{\"id\":20,\"name\":\"Hansel John\",\"email\":\"keycm109@gmail.com\",\"subject\":\"Reservation Inquiry\",\"message\":\"HELOOOOO\",\"admin_reply\":null,\"replied_at\":\"2025-11-12 01:00:31\",\"is_read\":1,\"created_at\":\"2025-11-12 00:58:12\",\"deleted_at\":null}', 'Tavernpublico', '2025-11-16 03:47:16', '2025-12-16', NULL),
(146, 'contact_message', 34, '{\"id\":34,\"name\":\"James\",\"email\":\"jamesvillapana99@gmail.com\",\"subject\":\"Reservation Inquiry\",\"message\":\"Yung reporting naten\",\"admin_reply\":\"Cge mamayang GAbi\",\"replied_at\":\"2025-11-16 07:44:16\",\"is_read\":1,\"created_at\":\"2025-11-16 07:43:50\",\"deleted_at\":null}', 'Tavernpublico', '2025-11-16 14:42:07', '2025-12-16', NULL),
(147, 'contact_message', 32, '{\"id\":32,\"name\":\"Dendi\",\"email\":\"kylerefrado@gmail.com\",\"subject\":\"Reservation Inquiry\",\"message\":\"jem\",\"admin_reply\":\"I love you\",\"replied_at\":\"2025-11-16 06:38:41\",\"is_read\":1,\"created_at\":\"2025-11-16 06:38:19\",\"deleted_at\":null}', 'Tavernpublico', '2025-11-16 14:42:17', '2025-12-16', NULL),
(148, 'contact_message', 32, '{\"id\":32,\"name\":\"Dendi\",\"email\":\"kylerefrado@gmail.com\",\"subject\":\"Reservation Inquiry\",\"message\":\"jem\",\"admin_reply\":\"I love you\",\"replied_at\":\"2025-11-16 06:38:41\",\"is_read\":1,\"created_at\":\"2025-11-16 06:38:19\",\"deleted_at\":\"2025-11-16 14:42:17\"}', 'Tavernpublico', '2025-11-16 14:42:21', '2025-12-16', NULL),
(149, 'contact_message', 31, '{\"id\":31,\"name\":\"Tavernpublico\",\"email\":\"publicotavern@gmail.com\",\"subject\":\"Reservation Inquiry\",\"message\":\"dfg\",\"admin_reply\":\"hi\",\"replied_at\":\"2025-11-16 06:37:47\",\"is_read\":1,\"created_at\":\"2025-11-16 06:33:45\",\"deleted_at\":null}', 'Tavernpublico', '2025-11-16 14:42:21', '2025-12-16', NULL),
(150, 'contact_message', 21, '{\"id\":21,\"name\":\"Hansel John\",\"email\":\"keycm109@gmail.com\",\"subject\":\"Reservation Inquiry\",\"message\":\"HELOOOOO\",\"admin_reply\":null,\"replied_at\":\"2025-11-12 01:00:31\",\"is_read\":1,\"created_at\":\"2025-11-12 00:58:12\",\"deleted_at\":null}', 'Tavernpublico', '2025-11-16 14:42:23', '2025-12-16', NULL),
(151, 'contact_message', 16, '{\"id\":16,\"name\":\"Hansel John\",\"email\":\"keycm109@gmail.com\",\"subject\":\"Reservation Inquiry\",\"message\":\"HELOOOOO\",\"admin_reply\":null,\"replied_at\":\"2025-11-12 01:00:33\",\"is_read\":1,\"created_at\":\"2025-11-12 00:58:11\",\"deleted_at\":null}', 'Tavernpublico', '2025-11-16 14:42:27', '2025-12-16', NULL),
(152, 'contact_message', 17, '{\"id\":17,\"name\":\"Hansel John\",\"email\":\"keycm109@gmail.com\",\"subject\":\"Reservation Inquiry\",\"message\":\"HELOOOOO\",\"admin_reply\":null,\"replied_at\":\"2025-11-12 01:00:34\",\"is_read\":1,\"created_at\":\"2025-11-12 00:58:11\",\"deleted_at\":null}', 'Tavernpublico', '2025-11-16 14:42:29', '2025-12-16', NULL),
(153, 'contact_message', 18, '{\"id\":18,\"name\":\"Hansel John\",\"email\":\"keycm109@gmail.com\",\"subject\":\"Reservation Inquiry\",\"message\":\"HELOOOOO\",\"admin_reply\":null,\"replied_at\":\"2025-11-12 01:00:34\",\"is_read\":1,\"created_at\":\"2025-11-12 00:58:11\",\"deleted_at\":null}', 'Tavernpublico', '2025-11-16 14:42:31', '2025-12-16', NULL),
(154, 'contact_message', 22, '{\"id\":22,\"name\":\"Hansel John\",\"email\":\"keycm109@gmail.com\",\"subject\":\"Reservation Inquiry\",\"message\":\"HELOOOOO\",\"admin_reply\":null,\"replied_at\":\"2025-11-12 01:00:32\",\"is_read\":1,\"created_at\":\"2025-11-12 00:58:12\",\"deleted_at\":null}', 'Tavernpublico', '2025-11-16 14:42:33', '2025-12-16', NULL),
(155, 'hero_slide', 27, '{\"id\":27,\"image_path\":\"uploads\\/6912ff80058be2.16483212.jpg\",\"title\":\"Tavern Publico\",\"subtitle\":\"hELLO\",\"video_path\":\"\",\"media_type\":\"image\",\"created_at\":\"2025-11-11 09:18:56\",\"deleted_at\":null}', 'Tavernpublico', '2025-11-16 14:43:47', '2025-12-16', NULL),
(156, 'event', 15, '{\"id\":15,\"title\":\"Birthday ni Pet\",\"date\":\"2025-10-16\",\"end_date\":\"2025-10-30\",\"description\":\"ffjsd,\",\"image\":\"uploads\\/68ec80e3df00d4.52257072.jpg\",\"deleted_at\":null}', 'Tavernpublico', '2025-11-17 03:35:19', '2025-12-17', NULL),
(157, 'event', 11, '{\"id\":11,\"title\":\"New year\",\"date\":\"2025-09-30\",\"end_date\":\"2025-10-01\",\"description\":\"You\'ve spotted another layout bug.\",\"image\":\"uploads\\/68dac3bd409a75.76303681.jpg\",\"deleted_at\":null}', 'Tavernpublico', '2025-11-17 03:36:04', '2025-12-17', NULL),
(159, 'contact_message', 40, '{\"id\":40,\"name\":\"Isaac\",\"email\":\"gnc.isaacjedm@gmail.com\",\"subject\":\"Reservation Inquiry\",\"message\":\"hrlliliukjhgfds\",\"admin_reply\":null,\"replied_at\":null,\"is_read\":0,\"created_at\":\"2025-11-17 17:05:51\",\"deleted_at\":null}', 'Tavernpublico', '2025-11-17 17:06:44', '2025-12-17', NULL),
(160, 'contact_message', 39, '{\"id\":39,\"name\":\"haze000\",\"email\":\"vibrancy0616@gmail.com\",\"subject\":\"Reservation Inquiry\",\"message\":\"hello\",\"admin_reply\":null,\"replied_at\":null,\"is_read\":0,\"created_at\":\"2025-11-17 17:02:32\",\"deleted_at\":null}', 'Tavernpublico', '2025-11-17 17:06:46', '2025-12-17', NULL),
(163, 'user', 190, '{\"user_id\":190,\"username\":\"Edjohn123\",\"email\":\"garciaedjohn022@gmail.com\",\"otp\":null,\"otp_expiry\":null,\"reset_token\":null,\"reset_token_expiry\":null,\"is_verified\":1,\"is_admin\":0,\"role\":\"user\",\"permissions\":null,\"avatar\":\"Tavern.png\",\"mobile\":null,\"birthday\":null,\"birthday_last_updated\":null,\"created_at\":\"2025-11-12 06:18:21\",\"deleted_at\":null}', 'Tavernpublico', '2025-11-17 17:20:33', '2025-12-17', NULL),
(164, 'contact_message', 41, '{\"id\":41,\"name\":\"Isaac\",\"email\":\"gnc.isaacjedm@gmail.com\",\"subject\":\"Reservation Inquiry\",\"message\":\"heeeeeee\",\"admin_reply\":\"heeeeeeeeeee\",\"replied_at\":\"2025-11-17 17:09:04\",\"is_read\":1,\"created_at\":\"2025-11-17 17:08:37\",\"deleted_at\":null}', 'Tavernpublico', '2025-11-17 17:58:12', '2025-12-17', NULL),
(165, 'contact_message', 38, '{\"id\":38,\"name\":\"Isaac\",\"email\":\"gcn.isaacjedm@gmail.com\",\"subject\":\"Reservation Inquiry\",\"message\":\"hiiii\",\"admin_reply\":\"Tapusin moan\",\"replied_at\":\"2025-11-17 17:06:59\",\"is_read\":1,\"created_at\":\"2025-11-17 17:00:14\",\"deleted_at\":null}', 'Tavernpublico', '2025-11-17 17:58:19', '2025-12-17', NULL),
(166, 'contact_message', 35, '{\"id\":35,\"name\":\"Vince\",\"email\":\"penapaul858@gmail.com\",\"subject\":\"Reservation Inquiry\",\"message\":\"thank you\",\"admin_reply\":null,\"replied_at\":null,\"is_read\":0,\"created_at\":\"2025-11-17 06:03:09\",\"deleted_at\":null}', 'Tavernpublico', '2025-11-17 17:58:30', '2025-12-17', NULL),
(167, 'contact_message', 33, '{\"id\":33,\"name\":\"haze000\",\"email\":\"vibrancy0616@gmail.com\",\"subject\":\"Reservation Inquiry\",\"message\":\"I want to Inquire\",\"admin_reply\":\"Ayoko nga HAHAHAHA\",\"replied_at\":\"2025-11-16 06:46:56\",\"is_read\":1,\"created_at\":\"2025-11-16 06:46:11\",\"deleted_at\":null}', 'Tavernpublico', '2025-11-17 17:58:35', '2025-12-17', NULL),
(168, 'contact_message', 19, '{\"id\":19,\"name\":\"Hansel John\",\"email\":\"keycm109@gmail.com\",\"subject\":\"Reservation Inquiry\",\"message\":\"HELOOOOO\",\"admin_reply\":null,\"replied_at\":\"2025-11-12 01:00:35\",\"is_read\":1,\"created_at\":\"2025-11-12 00:58:11\",\"deleted_at\":null}', 'Tavernpublico', '2025-11-17 17:58:39', '2025-12-17', NULL),
(169, 'blocked_date', 39, '{\"id\":39,\"block_date\":\"2025-11-20\"}', 'Tavernpublico', '2025-11-19 08:12:48', '2025-12-19', NULL),
(170, 'contact_message', 6, '{\"id\":6,\"name\":\"user\",\"email\":\"penapaul858@gmail.com\",\"subject\":\"reservation\",\"message\":\"I want to rreserve\",\"admin_reply\":\"You\'ve found a PHP warning bug. The error messages you\'re seeing, \\\"Constant DB_SERVER already defined\",\"replied_at\":\"2025-09-26 17:04:36\",\"is_read\":1,\"created_at\":\"2025-09-26 17:04:03\",\"deleted_at\":null}', 'Tavernpublico', '2025-11-25 13:15:10', '2025-12-25', NULL),
(171, 'contact_message', 43, '{\"id\":43,\"name\":\"Lucy Johnson\",\"email\":\"lucyjohnson.web@gmail.com\",\"subject\":\"Re: Improve your website traffic and SEO\",\"message\":\"\\\"Hello there,\\r\\n\\r\\nI came across your Website, when searching on Google and noticed that you do not show in the organic listings.\\r\\n\\r\\nOur main focus will be to help generate more sales & online traffic.\\r\\n\\r\\nWe can place your website on Google\'s 1st page. We will improve your website\\u2019s position on Google and get more traffic.\\r\\n\\r\\nIf interested, kindly provide me your name, phone number, and email.\\r\\n\\r\\nYour sincerely,\\r\\nLucy Johnson\\\"\",\"admin_reply\":null,\"replied_at\":null,\"is_read\":0,\"created_at\":\"2025-11-18 11:54:22\",\"deleted_at\":null}', 'Tavernpublico', '2025-11-25 13:15:17', '2025-12-25', NULL),
(172, 'event', 16, '{\"id\":16,\"title\":\"New year\",\"date\":\"2026-01-01\",\"end_date\":\"2026-01-02\",\"description\":\"Happy new year\",\"image\":\"uploads\\/6912feea2d08f7.35015123.jpg\",\"deleted_at\":null}', 'Tavernpublico', '2025-11-25 13:15:42', '2025-12-25', NULL),
(173, 'team_member', 2, '{\"id\":2,\"name\":\"karl\",\"title\":\"CEO\",\"bio\":\"FULL STACK\",\"image\":\"uploads\\/68d9322c4e2517.13457155.jpg\",\"created_at\":\"2025-09-28 13:03:40\",\"deleted_at\":null}', 'Tavernpublico', '2025-11-25 13:18:23', '2025-12-25', NULL),
(174, 'team_member', 3, '{\"id\":3,\"name\":\"kerl\",\"title\":\"Chef\",\"bio\":\"Hello\",\"image\":\"uploads\\/6919761a023f64.96611362.jpg\",\"created_at\":\"2025-11-16 06:58:34\",\"deleted_at\":null}', 'Tavernpublico', '2025-11-25 13:18:25', '2025-12-25', NULL),
(175, 'event', 14, '{\"id\":14,\"title\":\"Happy Mother\'s Day\",\"date\":\"2026-05-11\",\"end_date\":null,\"description\":\"\\\"A meal made with gratitude. This Mother\'s Day, we celebrate the woman who taught us everything about nourishment.\\\"\",\"image\":\"uploads\\/68dacdf1df31a4.48880259.jpg\",\"deleted_at\":null}', 'Tavernpublico', '2025-11-25 13:19:50', '2025-12-25', NULL),
(176, 'event', 12, '{\"id\":12,\"title\":\"Happy New Year\",\"date\":\"2025-12-01\",\"end_date\":\"2026-01-05\",\"description\":\"\\\"Tonight is the midnight magic where endings become beautiful beginnings. Dream big; the whole year is listening.\\\"\",\"image\":\"uploads\\/68dacd3649c864.17654122.jpg\",\"deleted_at\":null}', 'Tavernpublico', '2025-11-25 13:19:53', '2025-12-25', NULL),
(177, 'menu_item', 42, '{\"id\":42,\"name\":\"PorkSilog\",\"category\":\"Breakfast\",\"price\":\"148.00\",\"image\":\"uploads\\/68f205d485a8a0.07979049.jpeg\",\"description\":\"A juicy, tender pork chop, seasoned and pan-fried to a perfect golden-brown. Served with a generous portion of garlic fried rice and a sunny-side up egg. A classic, hearty meal guaranteed to satisfy.\",\"deleted_at\":null}', 'Tavernpublico', '2026-02-21 13:48:08', '2026-03-23', NULL),
(178, 'menu_item', 33, '{\"id\":33,\"name\":\"BagnetSilog\",\"category\":\"Breakfast\",\"price\":\"148.00\",\"image\":\"uploads\\/68f2023eb25003.56417988.jpeg\",\"description\":\"Authentic Ilocano-style bagnet, deep-fried to golden perfection for an incredibly crispy skin and succulent, tender meat. Served with garlic fried rice, a fried egg, and a side of zesty vinegar dip to complete this classic favorite.\",\"deleted_at\":null}', 'Tavernpublico', '2026-02-21 13:48:13', '2026-03-23', NULL),
(179, 'menu_item', 50, '{\"id\":50,\"name\":\"Caramel \",\"category\":\"Coffee\",\"price\":\"168.00\",\"image\":\"uploads\\/68f208e1c4be59.32135009.jpeg\",\"description\":\"Your Perfect Sweet Escape.\\\\r\\\\n\\\\r\\\\nRich Espresso, Creamy Caramel.\\\\r\\\\n\\\\r\\\\nThe Sweet Boost Your Friday Needs.\\\\r\\\\n\\\\r\\\\nAng tamis na babalik-balikan mo. (The sweetness you\\\\\'ll always come back for.)\",\"deleted_at\":null}', 'Tavernpublico', '2026-02-21 13:48:18', '2026-03-23', NULL),
(180, 'menu_item', 47, '{\"id\":47,\"name\":\"Dirty Matcha\",\"category\":\"Coffee\",\"price\":\"168.00\",\"image\":\"uploads\\/68f207b728bdf7.01205058.jpeg\",\"description\":\"The Best of Both Worlds: Coffee & Tea.\\\\r\\\\n\\\\r\\\\nEarthy, Bold, & Perfectly Balanced.\\\\r\\\\n\\\\r\\\\nYour Ultimate Energy Boost in a Cup.\\\\r\\\\n\\\\r\\\\nWhen Matcha Met Espresso\",\"deleted_at\":null}', 'Tavernpublico', '2026-02-21 13:48:23', '2026-03-23', NULL),
(181, 'menu_item', 41, '{\"id\":41,\"name\":\"Dark Chocolate Chip\",\"category\":\"Cool Creations\",\"price\":\"188.00\",\"image\":\"uploads\\/68f205a3600ee1.42205823.jpeg\",\"description\":\"Rich. Decadent. Unforgettable.\\\\r\\\\n\\\\r\\\\nThe Perfect Indulgent Treat.\\\\r\\\\n\\\\r\\\\nA Classic Cookie, Elevated.\\\\r\\\\n\\\\r\\\\nChewy, Chocolatey, Panalo!\",\"deleted_at\":null}', 'Tavernpublico', '2026-02-21 13:48:26', '2026-03-23', NULL),
(182, 'menu_item', 51, '{\"id\":51,\"name\":\"Strawberry Milk\",\"category\":\"Cool Creations\",\"price\":\"168.00\",\"image\":\"uploads\\/68f2097076b7f2.92542648.jpeg\",\"description\":\"Creamy, Fruity, and Perfectly Pink.\\\\r\\\\n\\\\r\\\\nYour Childhood Favorite, Made Better.\\\\r\\\\n\\\\r\\\\nA Sweet Strawberry Escape.\\\\r\\\\n\\\\r\\\\nAng Paboritong Pink Drink! (The Favorite Pink Drink!)\",\"deleted_at\":null}', 'Tavernpublico', '2026-02-21 13:48:31', '2026-03-23', NULL),
(183, 'menu_item', 40, '{\"id\":40,\"name\":\"Beef Nachos\",\"category\":\"Lunch\",\"price\":\"178.00\",\"image\":\"uploads\\/68f2051cb9f223.09914588.jpeg\",\"description\":\"A generous mountain of crisp tortilla chips piled high with savory seasoned ground beef and smothered in a rich, creamy melted cheese sauce. Topped with fresh diced tomatoes, onions, and a kick of jalape\\u00f1os for a perfect balance of flavors in every bite. Ideal for sharing!\",\"deleted_at\":null}', 'Tavernpublico', '2026-02-21 13:48:35', '2026-03-23', NULL),
(184, 'menu_item', 45, '{\"id\":45,\"name\":\"Butter Shrimp\",\"category\":\"Lunch\",\"price\":\"298.00\",\"image\":\"uploads\\/68f2069c67aba5.88090686.jpeg\",\"description\":\"Fresh, plump shrimp saut\\u00e9ed to perfection in a rich and luscious sauce of golden butter, toasted garlic, and a hint of spice. This decadent dish is simple, aromatic, and incredibly flavorful, making it a perfect main course or a luxurious appetizer.\",\"deleted_at\":null}', 'Tavernpublico', '2026-02-21 13:48:40', '2026-03-23', NULL),
(185, 'menu_item', 52, '{\"id\":52,\"name\":\"Caramel\",\"category\":\"Non-Coffee\",\"price\":\"150.00\",\"image\":\"uploads\\/6912ff31342fb3.09098390.jpg\",\"description\":\"carmel\",\"deleted_at\":null}', 'Tavernpublico', '2026-02-21 13:48:48', '2026-03-23', NULL),
(186, 'reservation', 59, '{\"reservation_id\":59,\"user_id\":206,\"res_date\":\"2025-11-25\",\"res_time\":\"20:00:00\",\"num_guests\":1,\"res_name\":\"note0429\",\"res_phone\":\"09366666666\",\"res_email\":\"valenciajeremiah29@gmail.com\",\"status\":\"Pending\",\"created_at\":\"2025-11-24 14:03:22\",\"assigned_table\":null,\"table_id\":null,\"is_notified\":0,\"deleted_at\":null,\"source\":\"Online\",\"reservation_type\":\"Special Occasion\",\"valid_id_path\":\"uploads\\/ids\\/id_692465aaa318b9.19957720.jpg\",\"special_requests\":\"I love u &lt;3\",\"applied_coupon_code\":null,\"action_by\":null}', NULL, '2026-02-21 13:49:44', '2026-03-23', NULL),
(187, 'reservation', 58, '{\"reservation_id\":58,\"user_id\":197,\"res_date\":\"2025-11-25\",\"res_time\":\"11:00:00\",\"num_guests\":2,\"res_name\":\"Vince\",\"res_phone\":\"09663195259\",\"res_email\":\"penapaul858@gmail.com\",\"status\":\"Confirmed\",\"created_at\":\"2025-11-20 10:18:41\",\"assigned_table\":null,\"table_id\":null,\"is_notified\":1,\"deleted_at\":null,\"source\":\"Online\",\"reservation_type\":\"Dine-in\",\"valid_id_path\":\"uploads\\/ids\\/id_691eeb01a94ae0.45462321.jpg\",\"special_requests\":\"Hello\",\"applied_coupon_code\":null,\"action_by\":\"Tavernpublico\"}', NULL, '2026-02-21 13:49:52', '2026-03-23', NULL),
(188, 'reservation', 57, '{\"reservation_id\":57,\"user_id\":197,\"res_date\":\"2025-11-22\",\"res_time\":\"11:00:00\",\"num_guests\":2,\"res_name\":\"Vince\",\"res_phone\":\"09663195259\",\"res_email\":\"penapaul858@gmail.com\",\"status\":\"Confirmed\",\"created_at\":\"2025-11-19 08:13:20\",\"assigned_table\":null,\"table_id\":null,\"is_notified\":1,\"deleted_at\":null,\"source\":\"Online\",\"reservation_type\":\"Dine-in\",\"valid_id_path\":\"uploads\\/ids\\/id_691d7c2076dfc9.08393736.jpg\",\"special_requests\":null,\"applied_coupon_code\":null,\"action_by\":\"Tavernpublico\"}', NULL, '2026-02-21 13:49:57', '2026-03-23', NULL);
INSERT INTO `deletion_history` (`log_id`, `item_type`, `item_id`, `item_data`, `action_by`, `deleted_at`, `purge_date`, `deleted_by_user`) VALUES
(189, 'reservation', 56, '{\"reservation_id\":56,\"user_id\":197,\"res_date\":\"2025-11-20\",\"res_time\":\"16:00:00\",\"num_guests\":2,\"res_name\":\"Vince\",\"res_phone\":\"09334257317\",\"res_email\":\"penapaul858@gmail.com\",\"status\":\"Pending\",\"created_at\":\"2025-11-19 07:35:36\",\"assigned_table\":null,\"table_id\":null,\"is_notified\":0,\"deleted_at\":null,\"source\":\"Online\",\"reservation_type\":\"Dine-in\",\"valid_id_path\":\"uploads\\/ids\\/id_691d73483d8365.20099586.png\",\"special_requests\":null,\"applied_coupon_code\":null,\"action_by\":null}', NULL, '2026-02-21 13:50:02', '2026-03-23', NULL),
(190, 'reservation', 55, '{\"reservation_id\":55,\"user_id\":197,\"res_date\":\"2025-11-18\",\"res_time\":\"12:00:00\",\"num_guests\":2,\"res_name\":\"Vince\",\"res_phone\":\"09334257317\",\"res_email\":\"penapaul858@gmail.com\",\"status\":\"Declined\",\"created_at\":\"2025-11-17 06:00:46\",\"assigned_table\":null,\"table_id\":null,\"is_notified\":1,\"deleted_at\":null,\"source\":\"Online\",\"reservation_type\":\"Dine-in\",\"valid_id_path\":\"uploads\\/ids\\/id_691aba0ee518e2.35635807.jpg\",\"special_requests\":null,\"applied_coupon_code\":null,\"action_by\":\"Tavernpublico\"}', NULL, '2026-02-21 13:50:08', '2026-03-23', NULL),
(191, 'reservation', 47, '{\"reservation_id\":47,\"user_id\":186,\"res_date\":\"2025-11-12\",\"res_time\":\"11:00:00\",\"num_guests\":4,\"res_name\":\"Hansel John\",\"res_phone\":\"09667785843\",\"res_email\":\"keycm109@gmail.com\",\"status\":\"Confirmed\",\"created_at\":\"2025-11-12 02:05:10\",\"assigned_table\":null,\"table_id\":null,\"is_notified\":1,\"deleted_at\":null,\"source\":\"Online\",\"reservation_type\":\"Dine-in\",\"valid_id_path\":\"uploads\\/ids\\/id_6913eb56a5cfd1.07733474.jpg\",\"special_requests\":null,\"applied_coupon_code\":null,\"action_by\":\"Tavernpublico\"}', NULL, '2026-02-21 13:50:13', '2026-03-23', NULL),
(192, 'reservation', 46, '{\"reservation_id\":46,\"user_id\":186,\"res_date\":\"2025-11-11\",\"res_time\":\"11:00:00\",\"num_guests\":2,\"res_name\":\"Hansel John\",\"res_phone\":\"09334257317\",\"res_email\":\"keycm109@gmail.com\",\"status\":\"Confirmed\",\"created_at\":\"2025-11-11 17:04:57\",\"assigned_table\":null,\"table_id\":null,\"is_notified\":1,\"deleted_at\":null,\"source\":\"Online\",\"reservation_type\":\"Dine-in\",\"valid_id_path\":\"uploads\\/ids\\/id_69136cb98ec171.44172131.png\",\"special_requests\":null,\"applied_coupon_code\":null,\"action_by\":\"Tavernpublico\"}', NULL, '2026-02-21 13:50:18', '2026-03-23', NULL),
(193, 'reservation', 54, '{\"reservation_id\":54,\"user_id\":197,\"res_date\":\"2025-11-18\",\"res_time\":\"12:00:00\",\"num_guests\":50,\"res_name\":\"Vince\",\"res_phone\":\"09667785843\",\"res_email\":\"penapaul858@gmail.com\",\"status\":\"Confirmed\",\"created_at\":\"2025-11-16 14:31:21\",\"assigned_table\":null,\"table_id\":null,\"is_notified\":1,\"deleted_at\":null,\"source\":\"Online\",\"reservation_type\":\"Private Event\",\"valid_id_path\":\"uploads\\/ids\\/id_6919e039362c60.54337658.jpg\",\"special_requests\":\"FOr my son BIrthday\",\"applied_coupon_code\":null,\"action_by\":\"Tavernpublico\"}', NULL, '2026-02-21 13:50:22', '2026-03-23', NULL),
(194, 'reservation', 53, '{\"reservation_id\":53,\"user_id\":201,\"res_date\":\"2025-11-16\",\"res_time\":\"16:00:00\",\"num_guests\":15,\"res_name\":\"James\",\"res_phone\":\"09164934855\",\"res_email\":\"jamesvillapana99@gmail.com\",\"status\":\"Declined\",\"created_at\":\"2025-11-16 07:47:46\",\"assigned_table\":null,\"table_id\":null,\"is_notified\":1,\"deleted_at\":null,\"source\":\"Online\",\"reservation_type\":\"Dine-in\",\"valid_id_path\":\"uploads\\/ids\\/id_691981a202f704.28102857.jpg\",\"special_requests\":null,\"applied_coupon_code\":null,\"action_by\":\"Tavernpublico\"}', NULL, '2026-02-21 13:50:26', '2026-03-23', NULL),
(195, 'reservation', 52, '{\"reservation_id\":52,\"user_id\":197,\"res_date\":\"2025-11-16\",\"res_time\":\"15:00:00\",\"num_guests\":2,\"res_name\":\"Vince\",\"res_phone\":\"09667785843\",\"res_email\":\"penapaul858@gmail.com\",\"status\":\"Confirmed\",\"created_at\":\"2025-11-16 06:42:53\",\"assigned_table\":null,\"table_id\":null,\"is_notified\":1,\"deleted_at\":null,\"source\":\"Online\",\"reservation_type\":\"Dine-in\",\"valid_id_path\":\"uploads\\/ids\\/id_6919726d695172.54770322.png\",\"special_requests\":\"Thank you\",\"applied_coupon_code\":null,\"action_by\":\"Tavernpublico\"}', NULL, '2026-02-21 13:50:31', '2026-03-23', NULL),
(196, 'reservation', 18, '{\"reservation_id\":18,\"user_id\":null,\"res_date\":\"2025-09-26\",\"res_time\":\"11:00:00\",\"num_guests\":1,\"res_name\":\"Vincent paul D Pena\",\"res_phone\":\"09667785843\",\"res_email\":\"keycm109@gmail.com\",\"status\":\"Confirmed\",\"created_at\":\"2025-09-26 10:15:37\",\"assigned_table\":null,\"table_id\":null,\"is_notified\":1,\"deleted_at\":null,\"source\":\"Online\",\"reservation_type\":\"Dine-in\",\"valid_id_path\":null,\"special_requests\":null,\"applied_coupon_code\":null,\"action_by\":null}', NULL, '2026-02-21 13:50:36', '2026-03-23', NULL),
(197, 'reservation', 51, '{\"reservation_id\":51,\"user_id\":null,\"res_date\":\"2025-11-17\",\"res_time\":\"04:10:00\",\"num_guests\":20,\"res_name\":\"Vincent paul D Pena\",\"res_phone\":\"09667785843\",\"res_email\":\"keycm109@gmail.com\",\"status\":\"Confirmed\",\"created_at\":\"2025-11-16 04:11:07\",\"assigned_table\":null,\"table_id\":null,\"is_notified\":0,\"deleted_at\":null,\"source\":\"Walk-in\",\"reservation_type\":\"Dine-in\",\"valid_id_path\":null,\"special_requests\":null,\"applied_coupon_code\":null,\"action_by\":\"Tavernpublico\"}', NULL, '2026-02-21 13:50:41', '2026-03-23', NULL),
(198, 'reservation', 21, '{\"reservation_id\":21,\"user_id\":null,\"res_date\":\"2025-09-26\",\"res_time\":\"11:00:00\",\"num_guests\":1,\"res_name\":\"Tavern\",\"res_phone\":\"09663195259\",\"res_email\":\"karllouisnavarro@gmail.com\",\"status\":\"Confirmed\",\"created_at\":\"2025-09-26 15:10:00\",\"assigned_table\":null,\"table_id\":null,\"is_notified\":1,\"deleted_at\":null,\"source\":\"Online\",\"reservation_type\":\"Dine-in\",\"valid_id_path\":null,\"special_requests\":null,\"applied_coupon_code\":null,\"action_by\":null}', NULL, '2026-02-21 13:50:46', '2026-03-23', NULL),
(199, 'reservation', 20, '{\"reservation_id\":20,\"user_id\":null,\"res_date\":\"2025-09-26\",\"res_time\":\"11:00:00\",\"num_guests\":1,\"res_name\":\"Tavern Publico\",\"res_phone\":\"09663195259\",\"res_email\":\"karllouisnavarro@gmail.com\",\"status\":\"Confirmed\",\"created_at\":\"2025-09-26 15:00:23\",\"assigned_table\":null,\"table_id\":null,\"is_notified\":1,\"deleted_at\":null,\"source\":\"Online\",\"reservation_type\":\"Dine-in\",\"valid_id_path\":null,\"special_requests\":null,\"applied_coupon_code\":null,\"action_by\":null}', NULL, '2026-02-21 13:50:50', '2026-03-23', NULL),
(200, 'reservation', 19, '{\"reservation_id\":19,\"user_id\":null,\"res_date\":\"2025-09-26\",\"res_time\":\"11:00:00\",\"num_guests\":6,\"res_name\":\"KIm\",\"res_phone\":\"09667785843\",\"res_email\":\"vincentpaul.pena@gnc.edu.ph\",\"status\":\"Pending\",\"created_at\":\"2025-09-26 12:40:27\",\"assigned_table\":null,\"table_id\":null,\"is_notified\":0,\"deleted_at\":null,\"source\":\"Online\",\"reservation_type\":\"Dine-in\",\"valid_id_path\":null,\"special_requests\":null,\"applied_coupon_code\":null,\"action_by\":null}', NULL, '2026-02-21 13:50:54', '2026-03-23', NULL),
(201, 'reservation', 17, '{\"reservation_id\":17,\"user_id\":null,\"res_date\":\"2025-09-26\",\"res_time\":\"11:00:00\",\"num_guests\":1,\"res_name\":\"Vincent paul D Pena\",\"res_phone\":\"09667785843\",\"res_email\":\"keycm109@gmail.com\",\"status\":\"Cancelled\",\"created_at\":\"2025-09-26 10:14:04\",\"assigned_table\":null,\"table_id\":null,\"is_notified\":1,\"deleted_at\":null,\"source\":\"Online\",\"reservation_type\":\"Dine-in\",\"valid_id_path\":null,\"special_requests\":null,\"applied_coupon_code\":null,\"action_by\":null}', NULL, '2026-02-21 13:50:58', '2026-03-23', NULL),
(202, 'reservation', 16, '{\"reservation_id\":16,\"user_id\":null,\"res_date\":\"2025-09-25\",\"res_time\":\"11:00:00\",\"num_guests\":1,\"res_name\":\"Vincent paul\",\"res_phone\":\"09667785843\",\"res_email\":\"vincentpaul.pena@gnc.edu.ph\",\"status\":\"Confirmed\",\"created_at\":\"2025-09-25 07:46:26\",\"assigned_table\":null,\"table_id\":null,\"is_notified\":0,\"deleted_at\":null,\"source\":\"Online\",\"reservation_type\":\"Dine-in\",\"valid_id_path\":null,\"special_requests\":null,\"applied_coupon_code\":null,\"action_by\":null}', NULL, '2026-02-21 13:51:04', '2026-03-23', NULL),
(203, 'reservation', 15, '{\"reservation_id\":15,\"user_id\":null,\"res_date\":\"2025-09-16\",\"res_time\":\"11:00:00\",\"num_guests\":1,\"res_name\":\"Vincent paul GNC Pena\",\"res_phone\":\"09667785843\",\"res_email\":\"vincentpaul.pena@gnc.edu.ph\",\"status\":\"Confirmed\",\"created_at\":\"2025-09-16 14:18:15\",\"assigned_table\":null,\"table_id\":null,\"is_notified\":0,\"deleted_at\":null,\"source\":\"Online\",\"reservation_type\":\"Dine-in\",\"valid_id_path\":null,\"special_requests\":null,\"applied_coupon_code\":null,\"action_by\":null}', NULL, '2026-02-21 13:51:08', '2026-03-23', NULL),
(204, 'menu_item', 44, '{\"id\":44,\"name\":\"ChickenSilog\",\"category\":\"Specialty\",\"price\":\"148.00\",\"image\":\"uploads\\/68f20660ea5162.34529114.jpeg\",\"description\":\"A perfectly crispy and juicy fried chicken served with fragrant garlic fried rice and a flawless sunny-side up egg. A simple, savory, and satisfying meal for any time of day.\",\"deleted_at\":null}', 'Tavernpublico', '2026-02-21 13:52:50', '2026-03-23', NULL),
(205, 'menu_item', 48, '{\"id\":48,\"name\":\"Baby Back Ribs\",\"category\":\"Specialty\",\"price\":\"188.00\",\"image\":\"uploads\\/68f2081a745571.80466884.jpeg\",\"description\":\"A premium rack of baby back ribs, slow-cooked for hours until incredibly tender and succulent. It\\\\\'s then generously glazed with our signature sweet and smoky barbecue sauce and grilled to a perfect caramelized char. Each bite is a fall-off-the-bone experience you won\\\\\'t forget. Served with your choice of side.\",\"deleted_at\":null}', 'Tavernpublico', '2026-02-21 13:52:59', '2026-03-23', NULL),
(206, 'menu_item', 32, '{\"id\":32,\"name\":\"BagnetSilog\",\"category\":\"Specialty\",\"price\":\"148.00\",\"image\":\"uploads\\/68f2022a058303.41254836.jpeg\",\"description\":\"Authentic Ilocano-style bagnet, deep-fried to golden perfection for an incredibly crispy skin and succulent, tender meat. Served with garlic fried rice, a fried egg, and a side of zesty vinegar dip to complete this classic favorite.\",\"deleted_at\":null}', 'Tavernpublico', '2026-02-21 13:53:10', '2026-03-23', NULL),
(207, 'menu_item', 49, '{\"id\":49,\"name\":\"Chicken Cordon Blue\",\"category\":\"Specialty\",\"price\":\"288.00\",\"image\":\"uploads\\/68f20881840c81.44946605.jpeg\",\"description\":\"A tender chicken breast, carefully pounded and rolled around savory smoked ham and premium, quick-melting cheese. It\\\\\'s then coated in a seasoned breading and fried to a perfect golden crisp. Served with a rich, creamy gravy, this dish is a delightful contrast of a crunchy exterior with a juicy, cheesy, and savory center.\",\"deleted_at\":null}', 'Tavernpublico', '2026-02-21 13:53:27', '2026-03-23', NULL),
(208, 'menu_item', 28, '{\"id\":28,\"name\":\"Carbonara\",\"category\":\"Specialty\",\"price\":\"168.00\",\"image\":\"uploads\\/68dac99e467982.27663719.jpg\",\"description\":\"Carbonara is a testament to flavor alchemy. Eggs, cheese, pork fat, and pepper\\u2014transformed into a silk so rich, you need nothing else.\",\"deleted_at\":null}', 'Tavernpublico', '2026-02-21 13:53:37', '2026-03-23', NULL),
(209, 'menu_item', 46, '{\"id\":46,\"name\":\"Chopsey\",\"category\":\"Lunch\",\"price\":\"288.00\",\"image\":\"uploads\\/68f207295c4fc5.00826198.jpeg\",\"description\":\"A classic Filipino-Chinese stir-fry featuring a colorful medley of fresh, crisp-tender vegetables like carrots, cabbage, bell peppers, and chayote. It\\\\\'s tossed with a savory mix of tender pork, chicken, and shrimp, and studded with quail eggs, all brought together in a delicious, light savory sauce. A wholesome and flavorful choice.\",\"deleted_at\":null}', 'Tavernpublico', '2026-02-21 15:16:20', '2026-03-23', NULL),
(210, 'menu_item', 43, '{\"id\":43,\"name\":\"Embutido De Fiesta\",\"category\":\"Lunch\",\"price\":\"298.00\",\"image\":\"uploads\\/68f2062e28e289.80379513.jpeg\",\"description\":\"A true taste of Filipino celebration, our Embutido De Fiesta is handcrafted with premium ground pork, generously mixed with sweet raisins, carrots, and bell peppers. Each roll is stuffed with savory sausage and hard-boiled eggs, then slow-steamed to lock in all the rich, savory-sweet flavors. Served sliced, it\\\\\'s the perfect festive centerpiece for any meal.\",\"deleted_at\":null}', 'Tavernpublico', '2026-02-21 15:16:30', '2026-03-23', NULL),
(211, 'menu_item', 37, '{\"id\":37,\"name\":\"Sinigang na Bagnet\",\"category\":\"Lunch\",\"price\":\"298.00\",\"image\":\"uploads\\/68f203ac39acb3.30977074.jpeg\",\"description\":\"A rich and tangy tamarind soup generously filled with fresh vegetables. The star of this dish is our authentic, deep-fried Ilocano bagnet, served crispy on top. The delightful contrast of the crunchy, savory pork belly with the hot, sour broth makes for a truly unforgettable and satisfying meal.\",\"deleted_at\":null}', 'Tavernpublico', '2026-02-21 15:16:40', '2026-03-23', NULL),
(212, 'menu_item', 39, '{\"id\":39,\"name\":\"Sisig Kapampangan\",\"category\":\"Lunch\",\"price\":\"298.00\",\"image\":\"uploads\\/68f204427e3cd6.97717664.jpeg\",\"description\":\"Classic Kapampangan-style pork sisig, sizzling with savory and tangy flavors, served with fragrant garlic fried rice and a perfectly fried egg. The ultimate satisfying meal.\",\"deleted_at\":null}', 'Tavernpublico', '2026-02-21 15:16:45', '2026-03-23', NULL),
(213, 'menu_item', 35, '{\"id\":35,\"name\":\"Chicken Inasal\",\"category\":\"Sizzlers\",\"price\":\"178.00\",\"image\":\"uploads\\/68f202d930cdc4.52605195.jpeg\",\"description\":\"A whole chicken leg quarter, marinated in a special blend of lemongrass, ginger, and calamansi, then slow-grilled over live charcoal. Basted with annatto oil for its signature color and smoky aroma, each bite is tender, juicy, and bursting with authentic Bacolod flavor. Served with a traditional soy-vinegar dipping sauce.\",\"deleted_at\":null}', 'Tavernpublico', '2026-02-21 15:17:39', '2026-03-23', NULL),
(214, 'menu_item', 36, '{\"id\":36,\"name\":\"Liempo\",\"category\":\"Sizzlers\",\"price\":\"178.00\",\"image\":\"uploads\\/68f203230bb577.72594709.jpeg\",\"description\":\"A choice slab of pork belly, marinated in a classic blend of soy sauce, calamansi, and garlic, then grilled over live coals to perfection. The result is a smoky, savory, and incredibly juicy liempo with a delightfully crisp, charred skin. Served with a side of steamed rice and a toyomansi dipping sauce.\",\"deleted_at\":null}', 'Tavernpublico', '2026-02-21 15:17:44', '2026-03-23', NULL),
(215, 'menu_item', 27, '{\"id\":27,\"name\":\"Chicken Inasal\",\"category\":\"Specialty\",\"price\":\"178.00\",\"image\":\"uploads\\/68dac918c83784.54662868.jpg\",\"description\":\"That perfect bite of Inasal: smoky, tangy, garlicky, and utterly addictive. It\'s the taste of Filipino sunshine.\",\"deleted_at\":null}', 'Tavernpublico', '2026-02-21 15:18:16', '2026-03-23', NULL),
(216, 'menu_item', 53, '{\"id\":53,\"name\":\"Testing\",\"category\":\"Appetizer\",\"price\":\"23456.00\",\"image\":\"uploads\\/699a8eebb0dc38.70896950.png\",\"description\":\"Tasty\",\"deleted_at\":null}', 'Tavernpublico', '2026-02-22 05:27:27', '2026-03-24', NULL),
(217, 'blocked_date', 37, '{\"id\":37,\"block_date\":\"2025-11-19\"}', 'Tavernpublico', '2026-03-10 00:35:07', '2026-04-09', NULL),
(218, 'blocked_date', 38, '{\"id\":38,\"block_date\":\"2025-11-17\"}', 'Tavernpublico', '2026-03-10 08:39:02', '2026-04-09', NULL),
(219, 'user', 208, '{\"user_id\":208,\"username\":\"Darknesss\",\"email\":\"emmanuelcastillotulda@gmail.com\",\"otp\":null,\"otp_expiry\":null,\"reset_token\":null,\"reset_token_expiry\":null,\"is_verified\":1,\"is_admin\":0,\"role\":\"customer\",\"permissions\":null,\"avatar\":\"Temporary.jpg\",\"mobile\":null,\"birthday\":null,\"birthday_last_updated\":null,\"created_at\":\"2026-03-13 13:12:33\",\"deleted_at\":null}', 'Tavernpublico', '2026-03-14 00:17:10', '2026-04-13', NULL),
(220, 'user', 209, '{\"user_id\":209,\"username\":\"eman\",\"email\":\"emmanuelltulda21@gmail.com\",\"otp\":\"161166\",\"otp_expiry\":\"2026-03-14 00:28:57\",\"reset_token\":null,\"reset_token_expiry\":null,\"is_verified\":1,\"is_admin\":0,\"role\":\"customer\",\"permissions\":null,\"avatar\":\"Temporary.jpg\",\"mobile\":null,\"birthday\":null,\"birthday_last_updated\":null,\"created_at\":\"2026-03-14 00:13:57\",\"deleted_at\":null}', 'Tavernpublico', '2026-03-14 00:57:26', '2026-04-13', NULL),
(221, 'reservation', 76, '{\"reservation_id\":76,\"user_id\":210,\"res_date\":\"2026-03-15\",\"res_time\":\"14:00:00\",\"num_guests\":4,\"res_name\":\"shankz\",\"res_phone\":\"09812428540\",\"res_email\":\"angelaxvexana@gmail.com\",\"status\":\"Pending\",\"created_at\":\"2026-03-14 01:01:02\",\"assigned_table\":null,\"table_id\":null,\"is_notified\":0,\"deleted_at\":null,\"source\":\"Online\",\"reservation_type\":\"Dine-in\",\"valid_id_path\":\"uploads\\/ids\\/id_69b4b34e624999.40561912.png\",\"special_requests\":\"Birthday\",\"applied_coupon_code\":null,\"action_by\":null}', NULL, '2026-03-14 01:04:20', '2026-04-13', NULL),
(223, 'reservation', 79, '{\"reservation_id\":79,\"user_id\":212,\"res_date\":\"2026-03-26\",\"res_time\":\"15:00:00\",\"num_guests\":4,\"res_name\":\"juan\",\"res_phone\":\"09812428540\",\"res_email\":\"juanreyes1st@gmail.com\",\"status\":\"Pending\",\"created_at\":\"2026-03-14 01:09:57\",\"assigned_table\":null,\"table_id\":null,\"is_notified\":0,\"deleted_at\":null,\"source\":\"Online\",\"reservation_type\":\"Dine-in\",\"valid_id_path\":\"uploads\\/ids\\/id_69b4b5655ecd39.95301937.png\",\"special_requests\":null,\"applied_coupon_code\":null,\"action_by\":null}', NULL, '2026-03-20 15:49:32', '2026-04-19', NULL),
(224, 'reservation', 70, '{\"reservation_id\":70,\"user_id\":207,\"res_date\":\"2026-03-14\",\"res_time\":\"13:00:00\",\"num_guests\":4,\"res_name\":\"Darkness\",\"res_phone\":\"09812428540\",\"res_email\":\"ectulda@gmail.com\",\"status\":\"Pending\",\"created_at\":\"2026-03-13 13:22:11\",\"assigned_table\":null,\"table_id\":null,\"is_notified\":0,\"deleted_at\":null,\"source\":\"Online\",\"reservation_type\":\"Dine-in\",\"valid_id_path\":\"uploads\\/ids\\/id_69b40f83261086.86290318.png\",\"special_requests\":\"eating\",\"applied_coupon_code\":null,\"action_by\":null}', NULL, '2026-03-20 15:49:40', '2026-04-19', NULL),
(225, 'reservation', 69, '{\"reservation_id\":69,\"user_id\":207,\"res_date\":\"2026-03-14\",\"res_time\":\"13:00:00\",\"num_guests\":4,\"res_name\":\"Darkness\",\"res_phone\":\"09812428540\",\"res_email\":\"ectulda@gmail.com\",\"status\":\"Pending\",\"created_at\":\"2026-03-13 13:22:10\",\"assigned_table\":null,\"table_id\":null,\"is_notified\":0,\"deleted_at\":null,\"source\":\"Online\",\"reservation_type\":\"Dine-in\",\"valid_id_path\":\"uploads\\/ids\\/id_69b40f82ee1607.73047477.png\",\"special_requests\":\"eating\",\"applied_coupon_code\":null,\"action_by\":null}', NULL, '2026-03-20 15:50:02', '2026-04-19', NULL);

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
(11, 'New year', '2025-09-30', '2025-10-01', 'You\'ve spotted another layout bug.', 'uploads/68dac3bd409a75.76303681.jpg', '2025-11-17 03:36:04'),
(12, 'Happy New Year', '2025-12-01', '2026-01-05', '\"Tonight is the midnight magic where endings become beautiful beginnings. Dream big; the whole year is listening.\"', 'uploads/68dacd3649c864.17654122.jpg', '2025-11-25 13:19:53'),
(13, 'Happy Valentine\'s Day', '2026-02-14', NULL, '\"Love is the main course, and our atmosphere is the perfect accompaniment. A night you’ll both cherish.\"', 'uploads/68dacd8d9cb509.70007263.jpg', '2025-11-11 09:16:43'),
(14, 'Happy Mother\'s Day', '2026-05-11', NULL, '\"A meal made with gratitude. This Mother\'s Day, we celebrate the woman who taught us everything about nourishment.\"', 'uploads/68dacdf1df31a4.48880259.jpg', '2025-11-25 13:19:50'),
(15, 'Birthday ni Pet', '2025-10-16', '2025-10-30', 'ffjsd,', 'uploads/68ec80e3df00d4.52257072.jpg', '2025-11-17 03:35:19'),
(16, 'New year', '2026-01-01', '2026-01-02', 'Happy new year', 'uploads/6912feea2d08f7.35015123.jpg', '2025-11-25 13:15:42');

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
(23, 'uploads/68e51f03a9fb21.09517997.jpg', 'Savor the Moment, Taste the Traditions', 'We blend classic recipes with a modern twist to create an unforgettable dining experience', '', 'image', '2025-10-07 14:09:07', NULL),
(24, '', '', '', '', 'video', '2025-10-17 09:32:59', '2025-10-17 17:33:03'),
(25, '', '', '', 'uploads/68f20d9764cb18.75387971.mp4', 'video', '2025-10-17 09:34:15', '2025-10-17 17:34:29'),
(26, '', '', '', 'uploads/68f20de7b17da1.27086382.mp4', 'video', '2025-10-17 09:35:35', NULL),
(27, 'uploads/6912ff80058be2.16483212.jpg', 'Tavern Publico', 'hELLO', '', 'image', '2025-11-11 09:18:56', '2025-11-16 14:43:47');

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
(27, 'Chicken Inasal', 'Specialty', 178.00, 'uploads/68dac918c83784.54662868.jpg', 'That perfect bite of Inasal: smoky, tangy, garlicky, and utterly addictive. It\'s the taste of Filipino sunshine.', '2026-02-21 15:18:16'),
(28, 'Carbonara', 'Specialty', 168.00, 'uploads/68dac99e467982.27663719.jpg', 'Carbonara is a testament to flavor alchemy. Eggs, cheese, pork fat, and pepper—transformed into a silk so rich, you need nothing else.', '2026-02-21 13:53:37'),
(29, 'Pork Steak', 'Specialty', 178.00, 'uploads/68dac9ed426bc6.00407464.jpg', 'The sound of the sauce simmering, the scent of caramelized onions... Filipino Pork Steak is less a dish, and more a call home.', '2025-10-17 08:45:57'),
(30, 'ChickenSilog', 'Breakfast', 148.00, 'uploads/68f20138293b19.50648522.jpeg', 'A perfectly crispy and juicy fried chicken served with fragrant garlic fried rice and a flawless sunny-side up egg. A simple, savory, and satisfying meal for any time of day.', '2025-10-17 08:44:55'),
(31, 'SisigSIlog', 'Breakfast', 148.00, 'uploads/68f20198b955f5.19969128.jpeg', 'Classic Kapampangan-style pork sisig, sizzling with savory and tangy flavors, served with fragrant garlic fried rice and a perfectly fried egg. The ultimate satisfying meal.', '2025-10-17 08:52:14'),
(32, 'BagnetSilog', 'Specialty', 148.00, 'uploads/68f2022a058303.41254836.jpeg', 'Authentic Ilocano-style bagnet, deep-fried to golden perfection for an incredibly crispy skin and succulent, tender meat. Served with garlic fried rice, a fried egg, and a side of zesty vinegar dip to complete this classic favorite.', '2026-02-21 13:53:10'),
(33, 'BagnetSilog', 'Breakfast', 148.00, 'uploads/68f2023eb25003.56417988.jpeg', 'Authentic Ilocano-style bagnet, deep-fried to golden perfection for an incredibly crispy skin and succulent, tender meat. Served with garlic fried rice, a fried egg, and a side of zesty vinegar dip to complete this classic favorite.', '2026-02-21 13:48:13'),
(34, 'PorkSilog', 'Breakfast', 148.00, 'uploads/68f202821ddda8.14563401.jpeg', 'A juicy, tender pork chop, seasoned and pan-fried to a perfect golden-brown. Served with a generous portion of garlic fried rice and a sunny-side up egg. A classic, hearty meal guaranteed to satisfy.', '2025-10-17 08:49:10'),
(35, 'Chicken Inasal', 'Sizzlers', 178.00, 'uploads/68f202d930cdc4.52605195.jpeg', 'A whole chicken leg quarter, marinated in a special blend of lemongrass, ginger, and calamansi, then slow-grilled over live charcoal. Basted with annatto oil for its signature color and smoky aroma, each bite is tender, juicy, and bursting with authentic Bacolod flavor. Served with a traditional soy-vinegar dipping sauce.', '2026-02-21 15:17:39'),
(36, 'Liempo', 'Sizzlers', 178.00, 'uploads/68f203230bb577.72594709.jpeg', 'A choice slab of pork belly, marinated in a classic blend of soy sauce, calamansi, and garlic, then grilled over live coals to perfection. The result is a smoky, savory, and incredibly juicy liempo with a delightfully crisp, charred skin. Served with a side of steamed rice and a toyomansi dipping sauce.', '2026-02-21 15:17:44'),
(37, 'Sinigang na Bagnet', 'Lunch', 298.00, 'uploads/68f203ac39acb3.30977074.jpeg', 'A rich and tangy tamarind soup generously filled with fresh vegetables. The star of this dish is our authentic, deep-fried Ilocano bagnet, served crispy on top. The delightful contrast of the crunchy, savory pork belly with the hot, sour broth makes for a truly unforgettable and satisfying meal.', '2026-02-21 15:16:40'),
(38, 'Butter Shrimp', 'Lunch', 298.00, 'uploads/68f2040f528af5.66022229.jpeg', 'Fresh, plump shrimp sautéed to perfection in a rich and luscious sauce of golden butter, toasted garlic, and a hint of spice. This decadent dish is simple, aromatic, and incredibly flavorful, making it a perfect main course or a luxurious appetizer.', '2025-10-17 09:03:55'),
(39, 'Sisig Kapampangan', 'Lunch', 298.00, 'uploads/68f204427e3cd6.97717664.jpeg', 'Classic Kapampangan-style pork sisig, sizzling with savory and tangy flavors, served with fragrant garlic fried rice and a perfectly fried egg. The ultimate satisfying meal.', '2026-02-21 15:16:45'),
(40, 'Beef Nachos', 'Lunch', 178.00, 'uploads/68f2051cb9f223.09914588.jpeg', 'A generous mountain of crisp tortilla chips piled high with savory seasoned ground beef and smothered in a rich, creamy melted cheese sauce. Topped with fresh diced tomatoes, onions, and a kick of jalapeños for a perfect balance of flavors in every bite. Ideal for sharing!', '2026-02-21 13:48:35'),
(41, 'Dark Chocolate Chip', 'Cool Creations', 188.00, 'uploads/68f205a3600ee1.42205823.jpeg', 'Rich. Decadent. Unforgettable.\\r\\n\\r\\nThe Perfect Indulgent Treat.\\r\\n\\r\\nA Classic Cookie, Elevated.\\r\\n\\r\\nChewy, Chocolatey, Panalo!', '2026-02-21 13:48:26'),
(42, 'PorkSilog', 'Breakfast', 148.00, 'uploads/68f205d485a8a0.07979049.jpeg', 'A juicy, tender pork chop, seasoned and pan-fried to a perfect golden-brown. Served with a generous portion of garlic fried rice and a sunny-side up egg. A classic, hearty meal guaranteed to satisfy.', '2026-02-21 13:48:08'),
(43, 'Embutido De Fiesta', 'Lunch', 298.00, 'uploads/68f2062e28e289.80379513.jpeg', 'A true taste of Filipino celebration, our Embutido De Fiesta is handcrafted with premium ground pork, generously mixed with sweet raisins, carrots, and bell peppers. Each roll is stuffed with savory sausage and hard-boiled eggs, then slow-steamed to lock in all the rich, savory-sweet flavors. Served sliced, it\\\'s the perfect festive centerpiece for any meal.', '2026-02-21 15:16:30'),
(44, 'ChickenSilog', 'Specialty', 148.00, 'uploads/68f20660ea5162.34529114.jpeg', 'A perfectly crispy and juicy fried chicken served with fragrant garlic fried rice and a flawless sunny-side up egg. A simple, savory, and satisfying meal for any time of day.', '2026-02-21 13:52:50'),
(45, 'Butter Shrimp', 'Lunch', 298.00, 'uploads/68f2069c67aba5.88090686.jpeg', 'Fresh, plump shrimp sautéed to perfection in a rich and luscious sauce of golden butter, toasted garlic, and a hint of spice. This decadent dish is simple, aromatic, and incredibly flavorful, making it a perfect main course or a luxurious appetizer.', '2026-02-21 13:48:40'),
(46, 'Chopsey', 'Lunch', 288.00, 'uploads/68f207295c4fc5.00826198.jpeg', 'A classic Filipino-Chinese stir-fry featuring a colorful medley of fresh, crisp-tender vegetables like carrots, cabbage, bell peppers, and chayote. It\\\'s tossed with a savory mix of tender pork, chicken, and shrimp, and studded with quail eggs, all brought together in a delicious, light savory sauce. A wholesome and flavorful choice.', '2026-02-21 15:16:20'),
(47, 'Dirty Matcha', 'Coffee', 168.00, 'uploads/68f207b728bdf7.01205058.jpeg', 'The Best of Both Worlds: Coffee & Tea.\\r\\n\\r\\nEarthy, Bold, & Perfectly Balanced.\\r\\n\\r\\nYour Ultimate Energy Boost in a Cup.\\r\\n\\r\\nWhen Matcha Met Espresso', '2026-02-21 13:48:23'),
(48, 'Baby Back Ribs', 'Specialty', 188.00, 'uploads/68f2081a745571.80466884.jpeg', 'A premium rack of baby back ribs, slow-cooked for hours until incredibly tender and succulent. It\\\'s then generously glazed with our signature sweet and smoky barbecue sauce and grilled to a perfect caramelized char. Each bite is a fall-off-the-bone experience you won\\\'t forget. Served with your choice of side.', '2026-02-21 13:52:59'),
(49, 'Chicken Cordon Blue', 'Specialty', 288.00, 'uploads/68f20881840c81.44946605.jpeg', 'A tender chicken breast, carefully pounded and rolled around savory smoked ham and premium, quick-melting cheese. It\\\'s then coated in a seasoned breading and fried to a perfect golden crisp. Served with a rich, creamy gravy, this dish is a delightful contrast of a crunchy exterior with a juicy, cheesy, and savory center.', '2026-02-21 13:53:27'),
(50, 'Caramel ', 'Coffee', 168.00, 'uploads/68f208e1c4be59.32135009.jpeg', 'Your Perfect Sweet Escape.\\r\\n\\r\\nRich Espresso, Creamy Caramel.\\r\\n\\r\\nThe Sweet Boost Your Friday Needs.\\r\\n\\r\\nAng tamis na babalik-balikan mo. (The sweetness you\\\'ll always come back for.)', '2026-02-21 13:48:18'),
(51, 'Strawberry Milk', 'Cool Creations', 168.00, 'uploads/68f2097076b7f2.92542648.jpeg', 'Creamy, Fruity, and Perfectly Pink.\\r\\n\\r\\nYour Childhood Favorite, Made Better.\\r\\n\\r\\nA Sweet Strawberry Escape.\\r\\n\\r\\nAng Paboritong Pink Drink! (The Favorite Pink Drink!)', '2026-02-21 13:48:31'),
(52, 'Caramel', 'Non-Coffee', 150.00, 'uploads/6912ff31342fb3.09098390.jpg', 'carmel', '2026-02-21 13:48:48'),
(53, 'Testing', 'Appetizer', 23456.00, 'uploads/699a8eebb0dc38.70896950.png', 'Tasty', '2026-02-22 05:27:27'),
(54, 'Calamares', 'Lunch', 288.00, 'uploads/69b2aedc0f8e16.20694002.jpg', 'Crispy on the outside, tender on the inside—calamares is seafood perfection in every bite.', NULL),
(55, 'Pinakbet', 'Lunch', 288.00, 'uploads/69b2b0f0475114.49621482.png', 'A bowl of pinakbet carries the taste of home in every bite.', NULL),
(56, 'Kani Salad', 'Specialty', 168.00, 'uploads/69b2b1483d69e7.27108435.png', 'Kani salad is a perfect blend of freshness, flavor, and simplicity.', NULL),
(57, 'Beef Bulalo', 'Lunch', 358.00, 'uploads/69b2b18de32c69.92964485.png', 'Bulalo is comfort in a bowl, rich with flavor and Filipino tradition.', NULL),
(58, 'Fried Chicken', 'Sizzlers', 178.00, 'uploads/69b2b1e3c2ae99.08187743.png', 'Crispy, juicy, and golden—fried chicken is comfort food at its finest.', NULL),
(59, 'Pork Binagoongan', 'Lunch', 298.00, 'uploads/69b2b28c8c6a88.86396667.png', 'The salty taste of bagoong and tender pork makes binagoongan unforgettable.', NULL),
(60, 'Buttered Shrimp', 'Lunch', 298.00, 'uploads/69b2b333e950f1.26708146.jpg', 'Buttered shrimp is a perfect blend of rich butter and sweet seafood flavor.', NULL),
(61, 'Bagnet', 'Lunch', 298.00, 'uploads/69b2b36cea0b74.09556806.png', 'Bagnet is the perfect harmony of crispy skin and tender pork.', NULL),
(62, 'Kare Kare Bagnet', 'Lunch', 308.00, 'uploads/69b2b3bb4258d5.37742993.png', 'Tender vegetables, creamy peanut sauce, and crunchy bagnet—every bite is pure bliss.', NULL),
(63, 'Beef Nachos', 'Appetizer', 178.00, 'uploads/69b2b4010f3720.09638458.png', 'Beef nachos: layers of crispy chips, savory beef, and melty cheese—pure indulgence.', NULL),
(64, 'Kare Kare Seafood', 'Lunch', 308.00, 'uploads/69b2b480a42512.64548294.png', 'Kare-kare seafood brings the creamy richness of peanut sauce to the fresh flavors of the sea.', NULL),
(65, 'Shawarma Salad', 'Appetizer', 178.00, 'uploads/69b2b4e40bfee1.25727328.png', 'Shawarma salad: the perfect mix of fresh greens and savory marinated meat.', NULL),
(66, 'Clubhouse Sandwich', 'Appetizer', 178.00, 'uploads/69b2b5de7fb6d3.03764420.png', 'A classic sandwich that never goes out of style.', NULL),
(67, 'Fries Overload', 'Appetizer', 168.00, 'uploads/69b2b630576995.62249956.png', 'Every bite is a crunchy, cheesy, flavor-packed adventure.', NULL),
(68, 'Pancit Canton', 'Lunch', 278.00, 'uploads/69b2b696d0c3e3.89219856.png', 'Pancit Canton: savory noodles, colorful veggies, and Filipino flavor in every bite.', NULL),
(69, 'Pancit Guisado', 'Lunch', 278.00, 'uploads/69b2b6d56ce996.25370354.png', 'Pancit Guisado: a hearty Filipino favorite full of flavor and tradition.', NULL),
(70, 'Beef Caldereta', 'Lunch', 298.00, 'uploads/69b2b7179a8c71.49245902.png', 'Beef caldereta: tender beef, rich sauce, and Filipino comfort in every bite.', NULL),
(71, 'Tokwat Baboy', 'Lunch', 298.00, 'uploads/69b2b764813627.21262264.png', 'A perfect balance of flavors—savory, tangy, and utterly Filipino.', NULL),
(72, 'Embutido De Fiesta', 'Lunch', 298.00, 'uploads/69b2b797ecdd83.34672192.jpg', 'Every slice of embutido de fiesta tells a story of celebration and tradition.', NULL),
(73, 'Sisig Kapampangan', 'Lunch', 298.00, 'uploads/69b2b839743c55.68602323.jpg', 'Every bite of sisig is a crispy, savory celebration of Pampanga’s culinary heritage.', NULL),
(74, 'Dinakdakan', 'Lunch', 298.00, 'uploads/69b2b8857751f6.85129513.jpg', 'Every bite of dinakdakan is a perfect mix of charred pork, onions, and spice.', NULL),
(75, 'Liempo', 'Sizzlers', 178.00, 'uploads/69b2b8c69a0866.00591039.jpg', 'Liempo: juicy pork belly with crispy skin and savory, smoky flavor.', NULL),
(76, 'Pork Cutket', 'Sizzlers', 178.00, 'uploads/69b2b8f031df86.48027815.jpg', 'Every bite of pork cutket is golden, crunchy, and utterly satisfying.', NULL),
(77, 'Carbonara', 'Appetizer', 168.00, 'uploads/69b2b938a566c8.64866746.jpg', 'Carbonara: creamy, cheesy, and comfort in every bite.', NULL),
(78, 'Chicken Inasal', 'Sizzlers', 178.00, 'uploads/69b2b994f060c5.48237072.jpg', 'Chicken Inasal: smoky, juicy, and bursting with Filipino flavor.', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `message` varchar(255) NOT NULL,
  `link` varchar(255) DEFAULT NULL,
  `type` varchar(50) NOT NULL DEFAULT 'system',
  `is_read` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`id`, `user_id`, `message`, `link`, `type`, `is_read`, `created_at`) VALUES
(18, 186, 'HIIIIIII', NULL, 'system', 1, '2025-11-12 00:59:10'),
(19, 186, 'HIIIIIII', NULL, 'system', 1, '2025-11-12 00:59:14'),
(20, 186, 'HIIIIIII', NULL, 'system', 1, '2025-11-12 00:59:19'),
(21, 186, 'HIIIIIII', NULL, 'system', 1, '2025-11-12 00:59:24'),
(22, 186, 'HIIIIIII', NULL, 'system', 1, '2025-11-12 00:59:28'),
(23, 186, 'HIIIIIII', NULL, 'system', 1, '2025-11-12 00:59:32'),
(24, 186, 'HIIIIIII', NULL, 'system', 1, '2025-11-12 00:59:37'),
(25, 186, 'HIIIIIII', NULL, 'system', 1, '2025-11-12 00:59:42'),
(26, 186, 'HIIIIIII', NULL, 'system', 1, '2025-11-12 00:59:46'),
(27, 186, 'HIIIIIII', NULL, 'system', 1, '2025-11-12 00:59:51'),
(28, 186, 'HIIIIIII', NULL, 'system', 1, '2025-11-12 00:59:55'),
(29, 186, 'HIIIIIII', NULL, 'system', 1, '2025-11-12 00:59:58'),
(30, 186, 'HIIIIIII', NULL, 'system', 1, '2025-11-12 01:00:03'),
(31, 186, 'HIIIIIII', NULL, 'system', 1, '2025-11-12 01:00:08'),
(32, 186, 'OKay na?', NULL, 'system', 1, '2025-11-12 01:04:16'),
(33, 186, 'testing', NULL, 'system', 1, '2025-11-12 01:07:11'),
(34, 186, 'on the notification of reservation can you to a modal so that i can read full the notification when i click the reservation notification', NULL, 'system', 1, '2025-11-12 02:08:31'),
(36, 197, 'Welcome! Please complete your profile by adding your Birthday and Mobile Number for security purposes.', 'profile.php', 'system', 1, '2025-11-12 21:11:01'),
(37, 198, 'Welcome! Please complete your profile by adding your Birthday and Mobile Number for security purposes.', 'profile.php', 'system', 1, '2025-11-15 14:59:28'),
(38, 199, 'Welcome! Please complete your profile by adding your Birthday and Mobile Number for security purposes.', 'profile.php', 'system', 0, '2025-11-16 06:21:17'),
(39, 1, 'hi', '#', 'custom', 1, '2025-11-16 06:37:47'),
(40, 199, 'I love you', '#', 'custom', 0, '2025-11-16 06:38:41'),
(43, 201, 'Welcome! Please complete your profile by adding your Birthday and Mobile Number for security purposes.', 'profile.php', 'system', 1, '2025-11-16 07:41:27'),
(44, 201, 'Cge mamayang GAbi', '#', 'custom', 1, '2025-11-16 07:44:16'),
(45, 203, 'Welcome! Please complete your profile by adding your Birthday and Mobile Number for security purposes.', 'profile.php', 'system', 1, '2025-11-17 17:04:49'),
(46, 203, 'heeeeeeeeeee', '#', 'custom', 0, '2025-11-17 17:09:04'),
(47, 205, 'Welcome! Please complete your profile by adding your Birthday and Mobile Number for security purposes.', 'profile.php', 'system', 0, '2025-11-19 01:21:48'),
(48, 206, 'Welcome! Please complete your profile by adding your Birthday and Mobile Number for security purposes.', 'profile.php', 'system', 1, '2025-11-24 14:00:42'),
(49, 207, 'Welcome! Please complete your profile by adding your Birthday and Mobile Number for security purposes.', 'profile.php', 'system', 1, '2026-03-12 11:50:16'),
(50, 208, 'Welcome! Please complete your profile by adding your Birthday and Mobile Number for security purposes.', 'profile.php', 'system', 0, '2026-03-13 13:12:36'),
(51, 209, 'Welcome! Please complete your profile by adding your Birthday and Mobile Number for security purposes.', 'profile.php', 'system', 0, '2026-03-14 00:14:00'),
(52, 210, 'Welcome! Please complete your profile by adding your Birthday and Mobile Number for security purposes.', 'profile.php', 'system', 0, '2026-03-14 00:18:59'),
(53, 211, 'Welcome! Please complete your profile by adding your Birthday and Mobile Number for security purposes.', 'profile.php', 'system', 0, '2026-03-14 00:20:30'),
(54, 212, 'Welcome! Please complete your profile by adding your Birthday and Mobile Number for security purposes.', 'profile.php', 'system', 0, '2026-03-14 00:21:17'),
(55, 213, 'Welcome! Please complete your profile by adding your Birthday and Mobile Number for security purposes.', 'profile.php', 'system', 0, '2026-03-14 00:34:03'),
(56, 214, 'Welcome! Please complete your profile by adding your Birthday and Mobile Number for security purposes.', 'profile.php', 'system', 0, '2026-03-14 00:47:37'),
(57, 215, 'Welcome! Please complete your profile by adding your Birthday and Mobile Number for security purposes.', 'profile.php', 'system', 0, '2026-03-14 00:55:14'),
(58, 218, 'Welcome! Please complete your profile by adding your Birthday and Mobile Number for security purposes.', 'profile.php', 'system', 0, '2026-03-14 00:58:01');

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
  `special_requests` text DEFAULT NULL,
  `applied_coupon_code` varchar(50) DEFAULT NULL,
  `action_by` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `reservations`
--

INSERT INTO `reservations` (`reservation_id`, `user_id`, `res_date`, `res_time`, `num_guests`, `res_name`, `res_phone`, `res_email`, `status`, `created_at`, `assigned_table`, `table_id`, `is_notified`, `deleted_at`, `source`, `reservation_type`, `valid_id_path`, `special_requests`, `applied_coupon_code`, `action_by`) VALUES
(15, NULL, '2025-09-16', '11:00:00', 1, 'Vincent paul GNC Pena', '09667785843', 'vincentpaul.pena@gnc.edu.ph', 'Confirmed', '2025-09-16 14:18:15', NULL, NULL, 0, '2026-02-21 13:51:08', 'Online', 'Dine-in', NULL, NULL, NULL, 'Tavernpublico'),
(16, NULL, '2025-09-25', '11:00:00', 1, 'Vincent paul', '09667785843', 'vincentpaul.pena@gnc.edu.ph', 'Confirmed', '2025-09-25 07:46:26', NULL, NULL, 0, '2026-02-21 13:51:04', 'Online', 'Dine-in', NULL, NULL, NULL, 'Tavernpublico'),
(17, NULL, '2025-09-26', '11:00:00', 1, 'Vincent paul D Pena', '09667785843', 'keycm109@gmail.com', 'Cancelled', '2025-09-26 10:14:04', NULL, NULL, 1, '2026-02-21 13:50:58', 'Online', 'Dine-in', NULL, NULL, NULL, 'Tavernpublico'),
(18, NULL, '2025-09-26', '11:00:00', 1, 'Vincent paul D Pena', '09667785843', 'keycm109@gmail.com', 'Confirmed', '2025-09-26 10:15:37', NULL, NULL, 1, '2026-02-21 13:50:36', 'Online', 'Dine-in', NULL, NULL, NULL, 'Tavernpublico'),
(19, NULL, '2025-09-26', '11:00:00', 6, 'KIm', '09667785843', 'vincentpaul.pena@gnc.edu.ph', 'Pending', '2025-09-26 12:40:27', NULL, NULL, 0, '2026-02-21 13:50:54', 'Online', 'Dine-in', NULL, NULL, NULL, 'Tavernpublico'),
(20, NULL, '2025-09-26', '11:00:00', 1, 'Tavern Publico', '09663195259', 'karllouisnavarro@gmail.com', 'Confirmed', '2025-09-26 15:00:23', NULL, NULL, 1, '2026-02-21 13:50:50', 'Online', 'Dine-in', NULL, NULL, NULL, 'Tavernpublico'),
(21, NULL, '2025-09-26', '11:00:00', 1, 'Tavern', '09663195259', 'karllouisnavarro@gmail.com', 'Confirmed', '2025-09-26 15:10:00', NULL, NULL, 1, '2026-02-21 13:50:46', 'Online', 'Dine-in', NULL, NULL, NULL, 'Tavernpublico'),
(22, NULL, '2025-09-27', '11:00:00', 1, 'Vincent', '09663195259', 'karllouisnavarro@gmail.com', 'Declined', '2025-09-26 17:03:24', NULL, NULL, 1, '2025-11-12 21:22:18', 'Online', 'Dine-in', NULL, NULL, NULL, 'Tavernpublico'),
(23, NULL, '2025-09-27', '11:00:00', 56, 'isaac macaraeg', '09667785843', 'vincentpaul.pena@gnc.edu.ph', 'Pending', '2025-09-26 17:26:35', NULL, NULL, 0, '2025-11-11 16:50:45', 'Online', 'Dine-in', NULL, NULL, NULL, 'Tavernpublico'),
(24, NULL, '2025-09-27', '11:00:00', 12, 'Vincent paul D Pena', '09667785843', 'penapaul858@gmail.com', 'Confirmed', '2025-09-26 17:31:35', NULL, NULL, 1, '2025-11-12 21:22:15', 'Online', 'Dine-in', NULL, NULL, NULL, 'Tavernpublico'),
(25, NULL, '2025-09-27', '11:00:00', 54, 'Tavern', '09663195259', 'karllouisnavarro@gmail.com', 'Confirmed', '2025-09-26 17:52:10', NULL, NULL, 1, '2025-09-27 14:55:34', 'Online', 'Dine-in', NULL, NULL, NULL, NULL),
(26, NULL, '2025-09-27', '11:00:00', 50, 'Tavern', '09663195259', 'karllouisnavarro@gmail.com', 'Confirmed', '2025-09-27 15:02:30', NULL, NULL, 1, '2025-11-12 21:22:12', 'Online', 'Dine-in', NULL, NULL, NULL, 'Tavernpublico'),
(27, NULL, '2025-09-28', '11:00:00', 10, 'Kimberly Anne D. Pena', '09663195259', 'karllouisnavarro@gmail.com', 'Declined', '2025-09-28 08:29:56', NULL, NULL, 1, '2025-11-12 21:22:09', 'Online', 'Dine-in', NULL, NULL, NULL, 'Tavernpublico'),
(28, NULL, '2025-02-12', '20:47:00', 10, 'Vincent paul D Pena', '09667785843', 'keycm109@gmail.com', 'Confirmed', '2025-09-28 09:47:55', NULL, NULL, 0, '2025-11-12 21:22:06', 'Walk-in', 'Dine-in', NULL, NULL, NULL, 'Tavernpublico'),
(29, NULL, '2025-09-28', '14:00:00', 10, 'ed', '09663195259', 'karllouisnavarro@gmail.com', 'Confirmed', '2025-09-28 10:04:53', NULL, NULL, 1, '2025-11-11 16:50:43', 'Online', 'Dine-in', NULL, NULL, NULL, 'Tavernpublico'),
(30, NULL, '2025-10-01', '11:00:00', 10, 'James', '09667785843', 'keycm109@gmail.com', 'Confirmed', '2025-09-28 10:35:49', NULL, NULL, 1, '2025-11-11 16:50:40', 'Online', 'Dine-in', NULL, NULL, NULL, 'Tavernpublico'),
(31, NULL, '2025-10-05', '11:00:00', 8, 'Vincent paul D Pena', '09667785843', 'keycm109@gmail.com', 'Confirmed', '2025-10-05 14:20:58', NULL, NULL, 1, '2025-11-11 16:50:38', 'Online', 'Dine-in', NULL, NULL, NULL, 'Tavernpublico'),
(32, NULL, '2025-10-05', '11:00:00', 8, 'Vincent paul D Pena', '09667785843', 'keycm109@gmail.com', 'Confirmed', '2025-10-05 14:44:31', NULL, NULL, 1, '2025-11-11 16:50:36', 'Online', 'Dine-in', NULL, NULL, NULL, 'Tavernpublico'),
(33, NULL, '2025-10-05', '11:00:00', 8, 'Vincent paul D Pena', '09667785843', 'penapaul858@gmail.com', 'Confirmed', '2025-10-05 15:03:34', NULL, NULL, 1, '2025-11-11 16:50:33', 'Online', 'Dine-in', NULL, NULL, NULL, 'Tavernpublico'),
(34, NULL, '2025-11-07', '11:00:00', 8, 'Vincent paul D Pena', '09667785843', 'penapaul858@gmail.com', 'Declined', '2025-10-07 07:06:58', NULL, NULL, 1, '2025-11-11 16:50:30', 'Online', 'Dine-in', NULL, NULL, NULL, 'Tavernpublico'),
(35, NULL, '2025-10-08', '11:00:00', 10, 'Vincent paul D Pena', '09667785843', 'keycm109@gmail.com', 'Declined', '2025-10-07 08:11:23', NULL, NULL, 1, '2025-11-11 16:50:27', 'Online', 'Dine-in', NULL, NULL, NULL, 'Tavernpublico'),
(37, NULL, '2025-10-10', '11:00:00', 11, 'Kimberly Anne D. Pena', '09667785843', 'vincee293@gmail.com', 'Cancelled', '2025-10-09 16:40:09', NULL, NULL, 1, '2025-11-11 07:45:11', 'Online', 'Dine-in', NULL, NULL, NULL, NULL),
(38, NULL, '2025-10-10', '13:00:00', 11, 'Hansel', '09667785843', 'publicotavern@gmail.com', 'Declined', '2025-10-10 03:19:01', NULL, NULL, 0, '2025-11-11 07:45:04', 'Online', 'Dine-in', NULL, NULL, NULL, NULL),
(39, NULL, '2025-10-23', '11:00:00', 10, 'Hansel', '09667785843', 'publicotavern@gmail.com', 'Confirmed', '2025-10-13 04:27:18', NULL, NULL, 1, '2025-11-11 07:45:07', 'Online', 'Dine-in', NULL, NULL, NULL, NULL),
(40, NULL, '2025-10-18', '14:00:00', 2, 'user', '09667785843', 'penapaul858@gmail.com', 'Confirmed', '2025-10-17 13:14:44', NULL, NULL, 1, '2025-11-11 16:50:24', 'Online', 'Dine-in', 'uploads/ids/id_68f241443c0016.73019534.jpg', NULL, NULL, 'Tavernpublico'),
(41, NULL, '2025-10-19', '14:00:00', 5, 'user', '09663195259', 'penapaul858@gmail.com', 'Declined', '2025-10-17 13:51:12', NULL, NULL, 1, '2025-11-11 16:50:21', 'Online', 'Private Event', 'uploads/ids/id_68f249cfd494b5.83935044.png', NULL, NULL, 'Tavernpublico'),
(42, NULL, '2025-10-19', '15:00:00', 23, 'Vince', '09663195259', 'penapaul858@gmail.com', 'Confirmed', '2025-10-17 14:02:06', NULL, NULL, 1, '2025-10-19 06:34:30', 'Online', 'Dine-in', 'uploads/ids/id_68f24c5ecedc12.02522622.jpg', NULL, NULL, NULL),
(43, NULL, '2025-11-06', '17:00:00', 2, 'Felix', '09667785843', 'johnfelix.dizon123@gmail.com', 'Declined', '2025-11-06 08:16:21', NULL, NULL, 0, '2025-11-06 12:33:22', 'Online', 'Dine-in', 'uploads/ids/id_690c5955a368b4.36716111.png', NULL, NULL, NULL),
(44, NULL, '2025-11-09', '13:00:00', 50, 'user', '09667785843', 'penapaul858@gmail.com', 'Declined', '2025-11-08 14:40:31', NULL, NULL, 0, '2025-11-11 16:50:18', 'Online', 'Dine-in', 'uploads/ids/id_690f565f8cc9f8.20635478.png', NULL, 'TAVERN10', 'Tavernpublico'),
(46, 186, '2025-11-11', '11:00:00', 2, 'Hansel John', '09334257317', 'keycm109@gmail.com', 'Confirmed', '2025-11-11 17:04:57', NULL, NULL, 1, '2026-02-21 13:50:18', 'Online', 'Dine-in', 'uploads/ids/id_69136cb98ec171.44172131.png', NULL, NULL, 'Tavernpublico'),
(47, 186, '2025-11-12', '11:00:00', 4, 'Hansel John', '09667785843', 'keycm109@gmail.com', 'Confirmed', '2025-11-12 02:05:10', NULL, NULL, 1, '2026-02-21 13:50:13', 'Online', 'Dine-in', 'uploads/ids/id_6913eb56a5cfd1.07733474.jpg', NULL, NULL, 'Tavernpublico'),
(48, NULL, '2025-11-13', '12:00:00', 5, 'Vince', '09667785843', 'penapaul858@gmail.com', 'Confirmed', '2025-11-12 15:12:18', NULL, NULL, 1, '2025-11-12 21:21:58', 'Online', 'Dine-in', 'uploads/ids/id_6914a3d2889336.30350759.png', NULL, NULL, 'Tavernpublico'),
(49, NULL, '2025-11-13', '12:00:00', 5, 'Vince', '09667785843', 'penapaul858@gmail.com', 'Confirmed', '2025-11-12 15:19:33', NULL, NULL, 1, '2025-11-12 21:21:55', 'Online', 'Dine-in', 'uploads/ids/id_6914a5858e7432.81506592.jpg', NULL, NULL, 'Tavernpublico'),
(50, NULL, '2025-11-14', '11:00:00', 4, 'Vincent paul D Pena', '09667785843', 'penapaul858@gmail.com', 'Confirmed', '2025-11-12 15:26:05', NULL, NULL, 1, '2025-11-12 21:21:51', 'Online', 'Dine-in', 'uploads/ids/id_6914a70d187052.32781682.png', NULL, NULL, 'Tavernpublico'),
(51, NULL, '2025-11-17', '04:10:00', 20, 'Vincent paul D Pena', '09667785843', 'keycm109@gmail.com', 'Confirmed', '2025-11-16 04:11:07', NULL, NULL, 0, '2026-02-21 13:50:41', 'Walk-in', 'Dine-in', NULL, NULL, NULL, 'Tavernpublico'),
(52, 197, '2025-11-16', '15:00:00', 2, 'Vince', '09667785843', 'penapaul858@gmail.com', 'Confirmed', '2025-11-16 06:42:53', NULL, NULL, 1, '2026-02-21 13:50:31', 'Online', 'Dine-in', 'uploads/ids/id_6919726d695172.54770322.png', 'Thank you', NULL, 'Tavernpublico'),
(53, 201, '2025-11-16', '16:00:00', 15, 'James', '09164934855', 'jamesvillapana99@gmail.com', 'Declined', '2025-11-16 07:47:46', NULL, NULL, 1, '2026-02-21 13:50:26', 'Online', 'Dine-in', 'uploads/ids/id_691981a202f704.28102857.jpg', NULL, NULL, 'Tavernpublico'),
(54, 197, '2025-11-18', '12:00:00', 50, 'Vince', '09667785843', 'penapaul858@gmail.com', 'Confirmed', '2025-11-16 14:31:21', NULL, NULL, 1, '2026-02-21 13:50:22', 'Online', 'Private Event', 'uploads/ids/id_6919e039362c60.54337658.jpg', 'FOr my son BIrthday', NULL, 'Tavernpublico'),
(55, 197, '2025-11-18', '12:00:00', 2, 'Vince', '09334257317', 'penapaul858@gmail.com', 'Declined', '2025-11-17 06:00:46', NULL, NULL, 1, '2026-02-21 13:50:08', 'Online', 'Dine-in', 'uploads/ids/id_691aba0ee518e2.35635807.jpg', NULL, NULL, 'Tavernpublico'),
(56, 197, '2025-11-20', '16:00:00', 2, 'Vince', '09334257317', 'penapaul858@gmail.com', 'Pending', '2025-11-19 07:35:36', NULL, NULL, 0, '2026-02-21 13:50:02', 'Online', 'Dine-in', 'uploads/ids/id_691d73483d8365.20099586.png', NULL, NULL, 'Tavernpublico'),
(57, 197, '2025-11-22', '11:00:00', 2, 'Vince', '09663195259', 'penapaul858@gmail.com', 'Confirmed', '2025-11-19 08:13:20', NULL, NULL, 1, '2026-02-21 13:49:57', 'Online', 'Dine-in', 'uploads/ids/id_691d7c2076dfc9.08393736.jpg', NULL, NULL, 'Tavernpublico'),
(58, 197, '2025-11-25', '11:00:00', 2, 'Vince', '09663195259', 'penapaul858@gmail.com', 'Confirmed', '2025-11-20 10:18:41', NULL, NULL, 1, '2026-02-21 13:49:52', 'Online', 'Dine-in', 'uploads/ids/id_691eeb01a94ae0.45462321.jpg', 'Hello', NULL, 'Tavernpublico'),
(59, 206, '2025-11-25', '20:00:00', 1, 'note0429', '09366666666', 'valenciajeremiah29@gmail.com', 'Pending', '2025-11-24 14:03:22', NULL, NULL, 0, '2026-02-21 13:49:44', 'Online', 'Special Occasion', 'uploads/ids/id_692465aaa318b9.19957720.jpg', 'I love u &lt;3', NULL, 'Tavernpublico'),
(60, 207, '2026-03-15', '15:00:00', 4, 'Darkness', '09812428540', 'ectulda@gmail.com', 'Pending', '2026-03-13 13:14:08', NULL, NULL, 0, NULL, 'Online', 'Dine-in', 'uploads/ids/id_69b40da0b708d9.37219743.png', 'birthday', NULL, NULL),
(61, 208, '2026-03-14', '13:00:00', 4, 'Darknesss', '09812428540', 'emmanuelcastillotulda@gmail.com', 'Declined', '2026-03-13 13:15:25', NULL, NULL, 0, NULL, 'Online', 'Dine-in', 'uploads/ids/id_69b40ded78f935.46087289.png', 'celebration', NULL, 'Tavernpublico'),
(62, 208, '2026-03-16', '14:00:00', 4, 'Darknesss', '09812428540', 'emmanuelcastillotulda@gmail.com', 'Pending', '2026-03-13 13:19:52', NULL, NULL, 0, NULL, 'Online', 'Dine-in', 'uploads/ids/id_69b40ef8784906.02074910.jpg', 'Eating', NULL, NULL),
(63, 208, '2026-03-14', '12:00:00', 4, 'Darknesss', '09812428540', 'emmanuelcastillotulda@gmail.com', 'Pending', '2026-03-13 13:20:25', NULL, NULL, 0, NULL, 'Online', 'Dine-in', 'uploads/ids/id_69b40f199a3a62.40334125.png', 'Eating', NULL, NULL),
(64, 208, '2026-03-14', '14:00:00', 4, 'Darknesss', '09812428540', 'emmanuelcastillotulda@gmail.com', 'Pending', '2026-03-13 13:20:37', NULL, NULL, 0, NULL, 'Online', 'Dine-in', 'uploads/ids/id_69b40f259c5363.62922410.png', 'eating', NULL, NULL),
(65, 208, '2026-03-14', '17:00:00', 4, 'Darknesss', '09812428540', 'emmanuelcastillotulda@gmail.com', 'Pending', '2026-03-13 13:20:53', NULL, NULL, 0, NULL, 'Online', 'Dine-in', 'uploads/ids/id_69b40f35d55db6.65440287.png', 'eating', NULL, NULL),
(66, 207, '2026-03-14', '14:00:00', 4, 'Darkness', '09812428540', 'ectulda@gmail.com', 'Pending', '2026-03-13 13:21:23', NULL, NULL, 0, NULL, 'Online', 'Dine-in', 'uploads/ids/id_69b40f53b614b6.29470994.png', 'eating', NULL, NULL),
(67, 207, '2026-03-14', '16:00:00', 4, 'Darkness', '09812428540', 'ectulda@gmail.com', 'Pending', '2026-03-13 13:21:40', NULL, NULL, 0, NULL, 'Online', 'Dine-in', 'uploads/ids/id_69b40f64a37612.37325273.png', 'eatings', NULL, NULL),
(68, 207, '2026-03-14', '13:00:00', 4, 'Darkness', '09812428540', 'ectulda@gmail.com', 'Pending', '2026-03-13 13:21:56', NULL, NULL, 0, NULL, 'Online', 'Dine-in', 'uploads/ids/id_69b40f74cf2618.53814863.png', 'eating', NULL, NULL),
(69, 207, '2026-03-14', '13:00:00', 4, 'Darkness', '09812428540', 'ectulda@gmail.com', 'Pending', '2026-03-13 13:22:10', NULL, NULL, 0, '2026-03-20 15:50:02', 'Online', 'Dine-in', 'uploads/ids/id_69b40f82ee1607.73047477.png', 'eating', NULL, 'Tavernpublico'),
(70, 207, '2026-03-14', '13:00:00', 4, 'Darkness', '09812428540', 'ectulda@gmail.com', 'Pending', '2026-03-13 13:22:11', NULL, NULL, 0, '2026-03-20 15:49:40', 'Online', 'Dine-in', 'uploads/ids/id_69b40f83261086.86290318.png', 'eating', NULL, 'Tavernpublico'),
(71, 208, '2026-03-14', '12:00:00', 4, 'Darknesss', '09812428540', 'emmanuelcastillotulda@gmail.com', 'Pending', '2026-03-13 13:22:27', NULL, NULL, 0, NULL, 'Online', 'Dine-in', 'uploads/ids/id_69b40f93ea10a6.27054301.png', NULL, NULL, NULL),
(72, 208, '2026-03-14', '12:00:00', 4, 'Darknesss', '09812428540', 'emmanuelcastillotulda@gmail.com', 'Pending', '2026-03-13 13:22:47', NULL, NULL, 0, NULL, 'Online', 'Dine-in', 'uploads/ids/id_69b40fa72185b1.99901232.png', NULL, NULL, NULL),
(73, 208, '2026-03-14', '14:00:00', 1, 'Darknesss', '09812428540', 'emmanuelcastillotulda@gmail.com', 'Pending', '2026-03-13 13:23:03', NULL, NULL, 0, NULL, 'Online', 'Dine-in', 'uploads/ids/id_69b40fb764bfa2.32544340.png', NULL, NULL, NULL),
(74, 208, '2026-03-21', '14:00:00', 4, 'Darknesss', '09812428540', 'emmanuelcastillotulda@gmail.com', 'Pending', '2026-03-13 13:23:16', NULL, NULL, 0, NULL, 'Online', 'Dine-in', 'uploads/ids/id_69b40fc4325b94.05591512.png', NULL, NULL, NULL),
(75, 218, '2026-03-16', '13:00:00', 4, 'emanuel', '09812428540', 'emmanueltulda21@gmail.com', 'Pending', '2026-03-14 00:59:42', NULL, NULL, 0, NULL, 'Online', 'Dine-in', 'uploads/ids/id_69b4b2fecc7d33.01904034.png', 'eating', NULL, NULL),
(76, 210, '2026-03-15', '14:00:00', 4, 'shankz', '09812428540', 'angelaxvexana@gmail.com', 'Pending', '2026-03-14 01:01:02', NULL, NULL, 0, '2026-03-14 01:04:20', 'Online', 'Dine-in', 'uploads/ids/id_69b4b34e624999.40561912.png', 'Birthday', NULL, 'Tavernpublico'),
(77, 210, '2026-03-14', '11:00:00', 4, 'Gerica Tingol', '09812428540', 'Gericavexana@gmail.com', 'Confirmed', '2026-03-14 01:01:42', NULL, NULL, 0, NULL, 'Online', 'Dine-in', 'uploads/valid_ids/id_69bd6af4751fe.png', 'celebrate', NULL, 'Tavernpublico'),
(78, 211, '2026-03-15', '15:00:00', 16, 'Wilfred Emperado', '09812428540', 'Wifred95@gmail.com', 'Confirmed', '2026-03-14 01:07:49', NULL, NULL, 0, NULL, 'Online', 'Special Occasion', 'uploads/valid_ids/id_69bd6ad1d3fe5.jpg', NULL, NULL, 'Tavernpublico'),
(79, 212, '2026-03-26', '15:00:00', 4, 'juan', '09812428540', 'juanreyes1st@gmail.com', 'Pending', '2026-03-14 01:09:57', NULL, NULL, 0, '2026-03-20 15:49:32', 'Online', 'Dine-in', 'uploads/ids/id_69b4b5655ecd39.95301937.png', NULL, NULL, 'Tavernpublico'),
(81, 213, '2026-03-19', '18:00:00', 7, 'Kimberly Anne De villa', '09812428540', 'Kiberlyanne834@gmail.com', 'Confirmed', '2026-03-14 01:13:33', NULL, NULL, 0, NULL, 'Online', 'Special Occasion', 'uploads/valid_ids/id_69bd6c3edb4b8.jpg', NULL, NULL, 'Tavernpublico'),
(82, 214, '2026-03-17', '11:00:00', 8, 'Rafael Morales', '09812428540', 'moralesrafaels095@gmail.com', 'Confirmed', '2026-03-14 01:16:18', NULL, NULL, 0, NULL, 'Online', 'Dine-in', 'uploads/valid_ids/id_69bd6c06cbc52.jpg', NULL, NULL, 'Tavernpublico'),
(83, 215, '2026-03-16', '11:00:00', 2, 'Maria Esteban', '09812428540', 'mariagarcia21v@gmail.com', 'Confirmed', '2026-03-14 01:17:24', NULL, NULL, 0, NULL, 'Online', 'Special Occasion', 'uploads/ids/id_69b4b724687843.28512897.png', NULL, NULL, 'Tavernpublico'),
(84, 215, '2026-03-24', '16:00:00', 6, 'Elizabeth Banag', '09812428540', 'elizzabethdelacruz21v@gmail.com', 'Confirmed', '2026-03-20 14:04:37', NULL, NULL, 0, NULL, 'Online', 'Private Event', 'uploads/valid_ids/id_69bd6a8aa28d1.jpeg', NULL, NULL, 'Tavernpublico');

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
(2, 'karl', 'CEO', 'FULL STACK', 'uploads/68d9322c4e2517.13457155.jpg', '2025-09-28 13:03:40', '2025-11-25 13:18:23'),
(3, 'kerl', 'Chef', 'Hello', 'uploads/6919761a023f64.96611362.jpg', '2025-11-16 06:58:34', '2025-11-25 13:18:25');

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
(14, 186, 46, 4, 'I like the environment in the restaurant', 0, '2025-11-12 02:01:04', NULL),
(15, 186, 47, 5, 'Thank you for your wonderful accommodation', 0, '2025-11-12 02:06:26', NULL);

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
(1, 'Tavernpublico', 'publicotavern@gmail.com', '$2y$10$mxLNZvG4/jYtqRqmymGCKupG3IImbNia2MC6lWhoPtkgjZp5j4V/K', NULL, NULL, NULL, NULL, 1, 1, 'owner', NULL, 'uploads/avatars/69135485ba01c0.41459726.jpg', NULL, NULL, NULL, '2025-11-11 13:56:13', NULL),
(186, 'Hansel John', 'keycm109@gmail.com', '$2y$10$Or/VIEAwxWwtIz50npOyFOZvdpvk6i9TTddw6xpnweRRwsTVn9BU6', NULL, NULL, '617073', '2026-03-11 06:36:15', 1, 0, 'manager', '[]', 'uploads/avatars/6913db510cadd1.68185178.png', NULL, NULL, NULL, '2025-11-11 14:02:39', NULL),
(190, 'Edjohn123', 'garciaedjohn022@gmail.com', '$2y$10$2CCGDRINTNkHSk9.x4Vq4.R2YMBOJqlflFjs3S9V/r0mdF3Kl3DnS', NULL, NULL, NULL, NULL, 1, 0, 'user', NULL, 'Tavern.png', NULL, NULL, NULL, '2025-11-12 06:18:21', '2025-11-17 17:20:33'),
(197, 'Vince', 'penapaul858@gmail.com', '$2y$10$fp5ufzOHIQQoDZVHlxiht.d8O/7w3wG3KktT67YZ0IpTwCsp0kzX.', NULL, NULL, NULL, NULL, 1, 0, 'customer', NULL, 'Temporary.jpg', NULL, NULL, NULL, '2025-11-12 21:10:56', NULL),
(198, 'Kim', 'vincee293@gmail.com', '$2y$12$KFCqkCKqF3.mbOl8XWk/1.VeOv104FvDqPNbqPa1j3IlPdPX4qkh2', NULL, NULL, NULL, NULL, 1, 0, 'customer', NULL, 'Temporary.jpg', NULL, NULL, NULL, '2025-11-15 14:59:25', NULL),
(199, 'Dendi', 'kylerefrado@gmail.com', '$2y$12$Dte2JItHl0CB05uhmOQqmOozJt8bAHLB2ZOIGkAkHGXmkwQFMfVRq', NULL, NULL, NULL, NULL, 1, 0, 'customer', NULL, 'Temporary.jpg', NULL, NULL, NULL, '2025-11-16 06:21:14', NULL),
(201, 'James', 'jamesvillapana99@gmail.com', '$2y$12$Q3fWyQQCJG3O6akgT0ytKOndesKICfhfguGP/gmHduX6qKzYJgw7q', NULL, NULL, NULL, NULL, 1, 0, 'customer', NULL, 'Temporary.jpg', NULL, NULL, NULL, '2025-11-16 07:41:24', NULL),
(203, 'Isaac', 'gnc.isaacjedm@gmail.com', '$2y$12$ENNYNZZ0sKJbNmwGRmApA.D/uh4GlJn3/90GUjqwH1IT3BduQu1wi', NULL, NULL, NULL, NULL, 1, 0, 'customer', NULL, 'Temporary.jpg', NULL, NULL, NULL, '2025-11-17 17:04:46', NULL),
(204, 'Vibrancy', 'vibrancy0616@gmail.com', '$2y$12$Oqxbg/WRQWLhO2d9YxDN/er/L/F3jOCH51vDZs/MjaLcviUEqvmZ2', NULL, NULL, NULL, NULL, 1, 0, 'customer', NULL, 'Tavern.png', NULL, NULL, NULL, '2025-11-17 17:10:43', NULL),
(205, 'peter', 'thgkrojs@gmail.com', '$2y$12$YLju0COcEAoaWj3DFZ1C.O/cRziewzP9xbapjJLUdLoLN5WVwEYy.', NULL, NULL, NULL, NULL, 1, 0, 'customer', NULL, 'Temporary.jpg', NULL, NULL, NULL, '2025-11-19 01:21:45', NULL),
(206, 'note0429', 'valenciajeremiah29@gmail.com', '$2y$12$jZl38ej.dIrLi4gJYW.0zuOc5ZBo4r.tl5u8PXVyvjzf/A0yFozAe', NULL, NULL, NULL, NULL, 1, 0, 'user', NULL, 'Temporary.jpg', NULL, NULL, NULL, '2025-11-24 14:00:38', NULL),
(207, 'Darkness', 'ectulda@gmail.com', '$2y$10$FxNd8tWUXPqOvEttkw1AW.gLU0NqzfUmn/EYU9Tvlt1TV3ALpwHn.', NULL, NULL, NULL, NULL, 1, 0, 'customer', NULL, 'Temporary.jpg', NULL, NULL, NULL, '2026-03-12 11:50:12', NULL),
(208, 'Darknesss', 'emmanuelcastillotulda@gmail.com', '$2y$10$qbvkaQFF4AI16hd80xWBd.oMROjXV3wYZuLvwbnAQkGv5cfTGgeJu', NULL, NULL, NULL, NULL, 1, 0, 'customer', NULL, 'Temporary.jpg', NULL, NULL, NULL, '2026-03-13 13:12:33', '2026-03-14 00:17:10'),
(209, 'eman', 'emmanuelltulda21@gmail.com', '$2y$10$.68f645.C6ZNmTyYyrF90etLWmn/oMzKPxzcmKIQlTJxHWWOXFtU2', '161166', '2026-03-14 00:28:57', NULL, NULL, 1, 0, 'customer', NULL, 'Temporary.jpg', NULL, NULL, NULL, '2026-03-14 00:13:57', '2026-03-14 00:57:26'),
(210, 'shankz', 'angelaxvexana@gmail.com', '$2y$10$dSoI3kYjW5/0ouOHwLgmYe0c.SZIexk4M/IDTEdXjBWCnFwiecmRG', NULL, NULL, NULL, NULL, 1, 0, 'customer', NULL, 'Temporary.jpg', NULL, NULL, NULL, '2026-03-14 00:18:55', NULL),
(211, 'Christ', 'blizkey95@gmail.com', '$2y$10$9K3vFOs1sDXv74R8qBYXp.fj1KVhtsT78e7YaOgrBqjrztZ.WMJye', NULL, NULL, NULL, NULL, 1, 0, 'customer', NULL, 'Temporary.jpg', NULL, NULL, NULL, '2026-03-14 00:20:27', NULL),
(212, 'juan', 'juanreyes1st@gmail.com', '$2y$10$J2JKjDQsY9Y.vDGTmTbHrepwWoORQ1fbjtERvEFkSuSJw1zY7SWBy', NULL, NULL, NULL, NULL, 1, 0, 'customer', NULL, 'Temporary.jpg', NULL, NULL, NULL, '2026-03-14 00:21:14', NULL),
(213, 'carlo', 'carlonarro8@gmail.com', '$2y$10$98dZRGC84S2/VLAeiXdXzumlSgU0OAP1brhbvGR.ktMwTU9MouzYy', NULL, NULL, NULL, NULL, 1, 0, 'customer', NULL, 'Temporary.jpg', NULL, NULL, NULL, '2026-03-14 00:34:00', NULL),
(214, 'rafael', 'moralesrafaels095@gmail.com', '$2y$10$96l3A.jGjVkNncKCZH2ojObgy9blUrQlgPNgOQeef999/naqOpD6a', NULL, NULL, NULL, NULL, 1, 0, 'customer', NULL, 'Temporary.jpg', NULL, NULL, NULL, '2026-03-14 00:47:34', NULL),
(215, 'maria', 'mariagarcia21v@gmail.com', '$2y$10$Zl7JtDvB.dasnmzfj.x0rOIsHiBsBzJISJorb3AP4I5TXvAoCIxFK', NULL, NULL, NULL, NULL, 1, 0, 'customer', NULL, 'Temporary.jpg', NULL, NULL, NULL, '2026-03-14 00:55:11', NULL),
(218, 'emanuel', 'emmanueltulda21@gmail.com', '$2y$10$5rJaxfVLC6Tc1WJfvUNMB.2A1hCbsZeMR89II.fWZaDHicUKoIN/m', NULL, NULL, NULL, NULL, 1, 0, 'customer', NULL, 'Temporary.jpg', NULL, NULL, NULL, '2026-03-14 00:57:57', NULL);

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
-- Indexes for table `contact_messages`
--
ALTER TABLE `contact_messages`
  ADD PRIMARY KEY (`id`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT for table `contact_messages`
--
ALTER TABLE `contact_messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=95;

--
-- AUTO_INCREMENT for table `deletion_history`
--
ALTER TABLE `deletion_history`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=228;

--
-- AUTO_INCREMENT for table `events`
--
ALTER TABLE `events`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `gallery`
--
ALTER TABLE `gallery`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `hero_slides`
--
ALTER TABLE `hero_slides`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `menu`
--
ALTER TABLE `menu`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=79;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;

--
-- AUTO_INCREMENT for table `reservations`
--
ALTER TABLE `reservations`
  MODIFY `reservation_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=85;

--
-- AUTO_INCREMENT for table `tables`
--
ALTER TABLE `tables`
  MODIFY `table_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `team`
--
ALTER TABLE `team`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `testimonials`
--
ALTER TABLE `testimonials`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=219;

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
