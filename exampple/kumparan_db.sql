-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Mar 10, 2019 at 05:42 PM
-- Server version: 10.1.19-MariaDB
-- PHP Version: 5.6.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `kumparan_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `msartikel`
--

CREATE TABLE `msartikel` (
  `ID` int(11) NOT NULL,
  `Status` varchar(3) NOT NULL,
  `UserIn` varchar(50) NOT NULL,
  `UserUp` varchar(50) DEFAULT NULL,
  `DateIn` datetime NOT NULL,
  `DateUp` datetime DEFAULT NULL,
  `Author` text NOT NULL,
  `body` text NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `msartikel`
--

INSERT INTO `msartikel` (`ID`, `Status`, `UserIn`, `UserUp`, `DateIn`, `DateUp`, `Author`, `body`, `created`) VALUES
(1, 'A', 'Admin', '', '2019-03-08 00:00:00', '0000-00-00 00:00:00', 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa', 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa', '2019-03-08 16:10:26'),
(2, 'D', 'Admin', NULL, '2019-03-09 03:06:08', NULL, 'asdadsa', 'asdasdasdsadasdsa', '2019-03-09 04:11:30'),
(2, 'A', 'Admin', NULL, '2019-03-09 08:41:02', NULL, 'USD', 'asdasdasdsad', '2019-03-09 01:41:02'),
(3, 'A', 'Admin', NULL, '2019-03-09 08:41:02', NULL, 'ASD', 'QWQWE', '2019-03-09 01:41:02'),
(3, 'A', 'Admin', NULL, '2019-03-09 08:42:15', NULL, 'USD', 'asdasdasdsad', '2019-03-09 01:42:15'),
(4, 'A', 'Admin', NULL, '2019-03-09 08:42:15', NULL, 'ASD', 'QWQWE', '2019-03-09 01:42:15'),
(5, 'A', 'Admin', NULL, '2019-03-09 09:22:46', NULL, 'USD', 'asdasdasdsad', '2019-03-09 02:22:46'),
(6, 'A', 'Admin', NULL, '2019-03-09 09:22:47', NULL, 'ASD', 'QWQWE', '2019-03-09 02:22:47'),
(7, 'A', 'Admin', NULL, '2019-03-09 09:23:37', NULL, 'fdfd', 'zxczxc', '2019-03-09 02:23:37'),
(8, 'A', 'Admin', NULL, '2019-03-09 09:23:38', NULL, 'gtgbg', 'qweqweqwe', '2019-03-09 02:23:38'),
(9, 'A', 'Admin', NULL, '2019-03-09 15:42:36', NULL, 'fdfd', 'zxczxc', '2019-03-09 08:42:36'),
(10, 'A', 'Admin', NULL, '2019-03-09 15:42:36', NULL, 'gtgbg', 'qweqweqwe', '2019-03-09 08:42:36'),
(11, 'A', 'Admin', NULL, '2019-03-09 15:45:20', NULL, 'aaaaaaa', 'zxczxc', '2019-03-09 08:45:20'),
(12, 'A', 'Admin', NULL, '2019-03-09 15:45:20', NULL, 'qqqqqqqq', 'qweqweqwe', '2019-03-09 08:45:20'),
(13, 'A', 'Admin', NULL, '2019-03-09 16:19:59', NULL, 'aaaaaaa', 'zxczxc', '2019-03-09 09:19:59'),
(14, 'A', 'Admin', NULL, '2019-03-09 16:20:33', NULL, 'qqqqqqqq', 'qweqweqwe', '2019-03-09 09:20:33'),
(15, 'A', 'Admin', NULL, '2019-03-09 16:23:08', NULL, 'aaaaaaa', 'zxczxc', '2019-03-09 09:23:08'),
(16, 'A', 'Admin', NULL, '2019-03-09 16:23:08', NULL, 'qqqqqqqq', 'qweqweqwe', '2019-03-09 09:23:08'),
(17, 'A', 'Admin', NULL, '2019-03-09 16:59:28', NULL, 'aaaaaaa', 'zxczxc', '2019-03-09 09:59:28'),
(18, 'A', 'Admin', NULL, '2019-03-09 16:59:29', NULL, 'qqqqqqqq', 'qweqweqwe', '2019-03-09 09:59:29'),
(19, 'A', 'Admin', NULL, '2019-03-09 17:45:35', NULL, 'aaaaaaa', 'zxczxc', '2019-03-09 10:45:35'),
(20, 'A', 'Admin', NULL, '2019-03-09 17:45:37', NULL, 'qqqqqqqq', 'qweqweqwe', '2019-03-09 10:45:37'),
(21, 'A', 'Admin', NULL, '2019-03-09 18:08:57', NULL, 'aaaaaaa', 'zxczxc', '2019-03-09 11:08:57'),
(22, 'A', 'Admin', NULL, '2019-03-09 18:08:58', NULL, 'qqqqqqqq', 'qweqweqwe', '2019-03-09 11:08:58'),
(23, 'A', 'Admin', NULL, '2019-03-09 18:31:38', NULL, 'aaaaaaa', 'zxczxc', '2019-03-09 11:31:38'),
(24, 'A', 'Admin', NULL, '2019-03-09 18:31:39', NULL, 'qqqqqqqq', 'qweqweqwe', '2019-03-09 11:31:39'),
(25, 'A', 'Admin', NULL, '2019-03-09 18:33:01', NULL, 'aaaaaaa', 'zxczxc', '2019-03-09 11:33:01'),
(26, 'A', 'Admin', NULL, '2019-03-09 18:33:01', NULL, 'qqqqqqqq', 'qweqweqwe', '2019-03-09 11:33:01'),
(27, 'A', 'Admin', NULL, '2019-03-09 18:50:13', NULL, 'aaaaaaa', 'zxczxc', '2019-03-09 11:50:13'),
(28, 'A', 'Admin', NULL, '2019-03-09 18:50:13', NULL, 'qqqqqqqq', 'qweqweqwe', '2019-03-09 11:50:13'),
(29, 'A', 'Admin', NULL, '2019-03-09 18:51:00', NULL, 'aaaaaaa', 'zxczxc', '2019-03-09 11:51:00'),
(30, 'A', 'Admin', NULL, '2019-03-09 18:51:00', NULL, 'qqqqqqqq', 'qweqweqwe', '2019-03-09 11:51:00'),
(31, 'A', 'Admin', NULL, '2019-03-09 18:53:01', NULL, 'aaaaaaa', 'zxczxc', '2019-03-09 11:53:01'),
(32, 'A', 'Admin', NULL, '2019-03-09 18:53:01', NULL, 'qqqqqqqq', 'qweqweqwe', '2019-03-09 11:53:01'),
(33, 'A', 'Admin', NULL, '2019-03-09 18:55:52', NULL, 'aaaaaaa', 'zxczxc', '2019-03-09 11:55:52'),
(34, 'A', 'Admin', NULL, '2019-03-09 18:55:52', NULL, 'qqqqqqqq', 'qweqweqwe', '2019-03-09 11:55:52'),
(35, 'A', 'Admin', NULL, '2019-03-09 18:59:03', NULL, 'aaaaaaa', 'zxczxc', '2019-03-09 11:59:03'),
(36, 'A', 'Admin', NULL, '2019-03-09 18:59:03', NULL, 'qqqqqqqq', 'qweqweqwe', '2019-03-09 11:59:03'),
(37, 'A', 'Admin', NULL, '2019-03-09 18:59:40', NULL, 'aaaaaaa', 'zxczxc', '2019-03-09 11:59:40'),
(38, 'A', 'Admin', NULL, '2019-03-09 18:59:41', NULL, 'qqqqqqqq', 'qweqweqwe', '2019-03-09 11:59:41'),
(39, 'A', 'Admin', NULL, '2019-03-09 19:00:54', NULL, 'aaaaaaa', 'zxczxc', '2019-03-09 12:00:54'),
(40, 'A', 'Admin', NULL, '2019-03-09 19:00:54', NULL, 'qqqqqqqq', 'qweqweqwe', '2019-03-09 12:00:54'),
(41, 'A', 'Admin', NULL, '2019-03-09 19:06:01', NULL, 'aaaaaaa', 'zxczxc', '2019-03-09 12:06:01'),
(42, 'A', 'Admin', NULL, '2019-03-09 19:06:01', NULL, 'qqqqqqqq', 'qweqweqwe', '2019-03-09 12:06:01'),
(43, 'A', 'Admin', NULL, '2019-03-09 19:07:23', NULL, 'aaaaaaa', 'zxczxc', '2019-03-09 12:07:23'),
(44, 'A', 'Admin', NULL, '2019-03-09 19:07:23', NULL, 'qqqqqqqq', 'qweqweqwe', '2019-03-09 12:07:23'),
(45, 'A', 'Admin', NULL, '2019-03-09 19:10:00', NULL, 'aaaaaaa', 'zxczxc', '2019-03-09 12:10:00'),
(46, 'A', 'Admin', NULL, '2019-03-09 19:10:00', NULL, 'qqqqqqqq', 'qweqweqwe', '2019-03-09 12:10:00'),
(47, 'A', 'Admin', NULL, '2019-03-09 19:15:14', NULL, 'aaaaaaa', 'zxczxc', '2019-03-09 12:15:14'),
(48, 'A', 'Admin', NULL, '2019-03-09 19:15:14', NULL, 'qqqqqqqq', 'qweqweqwe', '2019-03-09 12:15:14'),
(49, 'A', 'Admin', NULL, '2019-03-09 19:16:56', NULL, 'aaaaaaa', 'zxczxc', '2019-03-09 12:16:56'),
(50, 'A', 'Admin', NULL, '2019-03-09 19:16:56', NULL, 'qqqqqqqq', 'qweqweqwe', '2019-03-09 12:16:56'),
(51, 'A', 'Admin', NULL, '2019-03-09 19:19:30', NULL, 'aaaaaaa', 'zxczxc', '2019-03-09 12:19:30'),
(52, 'A', 'Admin', NULL, '2019-03-09 19:19:30', NULL, 'qqqqqqqq', 'qweqweqwe', '2019-03-09 12:19:30'),
(53, 'A', 'Admin', NULL, '2019-03-09 19:22:29', NULL, 'aaaaaaa', 'zxczxc', '2019-03-09 12:22:29'),
(54, 'A', 'Admin', NULL, '2019-03-09 19:22:29', NULL, 'qqqqqqqq', 'qweqweqwe', '2019-03-09 12:22:29'),
(55, 'A', 'Admin', NULL, '2019-03-09 19:25:00', NULL, 'aaaaaaa', 'zxczxc', '2019-03-09 12:25:00'),
(56, 'A', 'Admin', NULL, '2019-03-09 19:25:00', NULL, 'qqqqqqqq', 'qweqweqwe', '2019-03-09 12:25:00'),
(57, 'A', 'Admin', NULL, '2019-03-09 19:25:55', NULL, 'aaaaaaa', 'zxczxc', '2019-03-09 12:25:55'),
(58, 'A', 'Admin', NULL, '2019-03-09 19:25:55', NULL, 'qqqqqqqq', 'qweqweqwe', '2019-03-09 12:25:55'),
(59, 'A', 'Admin', NULL, '2019-03-09 19:26:51', NULL, 'aaaaaaa', 'zxczxc', '2019-03-09 12:26:51'),
(60, 'A', 'Admin', NULL, '2019-03-09 19:26:51', NULL, 'qqqqqqqq', 'qweqweqwe', '2019-03-09 12:26:51'),
(61, 'A', 'Admin', NULL, '2019-03-09 19:30:33', NULL, 'aaaaaaa', 'zxczxc', '2019-03-09 12:30:33'),
(62, 'A', 'Admin', NULL, '2019-03-09 19:30:33', NULL, 'qqqqqqqq', 'qweqweqwe', '2019-03-09 12:30:33'),
(63, 'A', 'Admin', NULL, '2019-03-09 19:36:09', NULL, 'aaaaaaa', 'zxczxc', '2019-03-09 12:36:09'),
(64, 'A', 'Admin', NULL, '2019-03-09 19:36:09', NULL, 'qqqqqqqq', 'qweqweqwe', '2019-03-09 12:36:09'),
(65, 'A', 'Admin', NULL, '2019-03-09 19:37:43', NULL, 'aaaaaaa', 'zxczxc', '2019-03-09 12:37:43'),
(66, 'A', 'Admin', NULL, '2019-03-09 19:37:43', NULL, 'qqqqqqqq', 'qweqweqwe', '2019-03-09 12:37:43'),
(67, 'A', 'Admin', NULL, '2019-03-09 19:39:42', NULL, 'aaaaaaa', 'zxczxc', '2019-03-09 12:39:42'),
(68, 'A', 'Admin', NULL, '2019-03-09 19:39:42', NULL, 'qqqqqqqq', 'qweqweqwe', '2019-03-09 12:39:42'),
(69, 'A', 'Admin', NULL, '2019-03-09 19:41:15', NULL, 'aaaaaaa', 'zxczxc', '2019-03-09 12:41:15'),
(70, 'A', 'Admin', NULL, '2019-03-09 19:41:15', NULL, 'qqqqqqqq', 'qweqweqwe', '2019-03-09 12:41:15'),
(71, 'A', 'Admin', NULL, '2019-03-09 19:46:08', NULL, 'aaaaaaa', 'zxczxc', '2019-03-09 12:46:08'),
(72, 'A', 'Admin', NULL, '2019-03-09 19:46:09', NULL, 'qqqqqqqq', 'qweqweqwe', '2019-03-09 12:46:09'),
(73, 'A', 'Admin', NULL, '2019-03-09 19:47:49', NULL, 'aaaaaaa', 'zxczxc', '2019-03-09 12:47:49'),
(74, 'A', 'Admin', NULL, '2019-03-09 19:47:49', NULL, 'qqqqqqqq', 'qweqweqwe', '2019-03-09 12:47:49'),
(75, 'A', 'Admin', NULL, '2019-03-10 03:47:18', NULL, 'USD', 'asdasdasdsad', '2019-03-09 20:47:18'),
(76, 'A', 'Admin', NULL, '2019-03-10 03:47:18', NULL, 'ASD', 'QWQWE', '2019-03-09 20:47:18'),
(77, 'A', 'Admin', NULL, '2019-03-10 03:48:57', NULL, 'USD', 'asdasdasdsad', '2019-03-09 20:48:57'),
(78, 'A', 'Admin', NULL, '2019-03-10 03:48:58', NULL, 'ASD', 'QWQWE', '2019-03-09 20:48:58'),
(79, 'A', 'Admin', NULL, '2019-03-10 03:49:48', NULL, 'USD', 'asdasdasdsad', '2019-03-09 20:49:48'),
(80, 'A', 'Admin', NULL, '2019-03-10 03:49:48', NULL, 'ASD', 'QWQWE', '2019-03-09 20:49:48'),
(81, 'A', 'Admin', NULL, '2019-03-10 03:50:50', NULL, 'USD', 'asdasdasdsad', '2019-03-09 20:50:50'),
(82, 'A', 'Admin', NULL, '2019-03-10 03:50:51', NULL, 'ASD', 'QWQWE', '2019-03-09 20:50:51'),
(83, 'A', 'Admin', NULL, '2019-03-10 03:51:59', NULL, 'USD', 'asdasdasdsad', '2019-03-09 20:51:59'),
(84, 'A', 'Admin', NULL, '2019-03-10 03:51:59', NULL, 'ASD', 'QWQWE', '2019-03-09 20:51:59'),
(85, 'A', 'Admin', NULL, '2019-03-10 03:54:06', NULL, 'USD', 'asdasdasdsad', '2019-03-09 20:54:06'),
(86, 'A', 'Admin', NULL, '2019-03-10 03:54:06', NULL, 'ASD', 'QWQWE', '2019-03-09 20:54:06');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
