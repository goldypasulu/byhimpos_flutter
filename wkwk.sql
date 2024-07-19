-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jun 24, 2024 at 07:37 PM
-- Server version: 10.3.39-MariaDB-cll-lve
-- PHP Version: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `byhimperfume_admin`
--

-- --------------------------------------------------------

--
-- Table structure for table `bottle`
--

CREATE TABLE `bottle` (
  `id` int(11) NOT NULL,
  `bottle_name` varchar(255) DEFAULT NULL,
  `bottle_size` int(11) DEFAULT NULL,
  `bottle_type` varchar(255) DEFAULT NULL,
  `harga_ml` int(11) NOT NULL,
  `variant` enum('edt','edp','perfume','full_perfume') DEFAULT NULL,
  `created_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bottle`
--

INSERT INTO `bottle` (`id`, `bottle_name`, `bottle_size`, `bottle_type`, `harga_ml`, `variant`, `created_at`, `updated_at`) VALUES
(1, 'Bottle', 20, 'Type A', 40000, 'edt', '2024-06-05 21:51:24', '2024-06-05 21:51:24'),
(2, 'Bottle', 4, 'Type A', 16000, 'full_perfume', '2024-06-06 02:43:34', '2024-06-06 02:43:34'),
(3, 'Bottle', 10, 'Type A', 20000, 'edt', '2024-06-06 02:43:47', '2024-06-06 02:43:47'),
(4, 'Bottle', 50, 'Type A', 125000, 'edp', '2024-06-05 22:45:06', '2024-06-05 22:45:06'),
(5, 'Bottle', 30, 'Type A', 60000, 'edt', '2024-06-06 01:26:26', '2024-06-05 18:26:26'),
(6, 'Bottle', 55, 'Type A', 105000, 'edt', '2024-06-05 16:14:12', '2024-06-05 16:14:12'),
(7, 'Bottle', 30, 'Type A', 75000, 'edp', '2024-06-05 18:29:36', '2024-06-05 18:29:36'),
(8, 'Bottle', 30, 'Type A', 90000, 'perfume', '2024-06-05 18:31:09', '2024-06-05 18:31:09'),
(9, 'Bottle', 30, 'Type A', 130000, 'full_perfume', '2024-06-05 18:31:39', '2024-06-05 18:31:39'),
(10, 'Bottle', 32, 'Type A', 60000, 'edt', '2024-06-05 18:34:39', '2024-06-05 18:34:39'),
(11, 'Bottle', 32, 'Type A', 80000, 'edp', '2024-06-05 18:35:08', '2024-06-05 18:35:08'),
(12, 'Bottle', 32, 'Type A', 95000, 'perfume', '2024-06-05 18:35:48', '2024-06-05 18:35:48'),
(13, 'Bottle', 32, 'Type A', 210000, 'full_perfume', '2024-06-05 18:36:28', '2024-06-05 18:36:28');

-- --------------------------------------------------------

--
-- Table structure for table `branches`
--

CREATE TABLE `branches` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `branches`
--

INSERT INTO `branches` (`id`, `name`, `address`, `created_at`, `updated_at`) VALUES
(1, 'ROYAL UG', 'Royal Plaza UG E5-21', '2024-05-01 19:12:49', '2024-06-02 04:49:12'),
(2, 'MALIOBORO', 'Malioboro Mall Lt.1', '2024-06-02 05:38:08', '2024-06-02 05:38:24'),
(3, 'TUNJUNGAN PLAZA', 'Tunjungan Plaza 1 Lt. 1 Unit 9', '2024-06-02 05:39:01', '2024-06-02 05:39:01'),
(4, 'KAZA', 'Kaza City Mall Lt. UG', '2024-06-02 05:39:41', '2024-06-02 05:39:41'),
(5, 'MADIUN', 'Lawu Plaza', '2024-06-02 05:40:12', '2024-06-02 05:45:49'),
(6, 'ROYAL G', 'Royal Plaza Surabaya Lt. G B6-26', '2024-06-02 05:41:06', '2024-06-02 05:41:06'),
(7, 'TULUNGAGUNG', 'I Gusti Ngurah Rai IV/11', '2024-06-02 05:44:49', '2024-06-02 05:48:34'),
(8, 'LAMONGAN', 'Ahmad Dahlan No. 6', '2024-06-02 05:48:24', '2024-06-02 05:48:24');

-- --------------------------------------------------------

--
-- Table structure for table `bundles`
--

CREATE TABLE `bundles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `price` int(11) NOT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `bundles`
--

INSERT INTO `bundles` (`id`, `name`, `description`, `price`, `start_date`, `end_date`, `created_at`, `updated_at`) VALUES
(2, 'Promo Juni Ceria', 'promo', 72000, NULL, NULL, '2024-06-23 15:43:12', '2024-06-23 15:43:12');

-- --------------------------------------------------------

--
-- Table structure for table `bundle_items`
--

CREATE TABLE `bundle_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `bundle_id` bigint(20) UNSIGNED DEFAULT NULL,
  `product_id` bigint(20) UNSIGNED DEFAULT NULL,
  `bottle_id` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `discount` decimal(5,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `bundle_items`
--

INSERT INTO `bundle_items` (`id`, `bundle_id`, `product_id`, `bottle_id`, `quantity`, `discount`, `created_at`, `updated_at`) VALUES
(1, 2, 117, 2, 5, '25.00', '2024-06-23 15:43:12', '2024-06-23 15:43:12'),
(2, 2, 119, 7, 5, '20.00', '2024-06-23 15:43:12', '2024-06-23 15:43:12');

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `id` int(11) NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `branch_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `bottle_id` int(11) DEFAULT NULL,
  `discount` int(11) DEFAULT 0,
  `price_after_discount` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cart`
--

INSERT INTO `cart` (`id`, `product_id`, `branch_id`, `user_id`, `bottle_id`, `discount`, `price_after_discount`, `created_at`, `updated_at`) VALUES
(127, 117, 4, 7, 2, 25, 12000, '2024-06-24 17:44:17', '2024-06-24 17:44:17'),
(128, 119, 4, 7, 7, 20, 60000, '2024-06-24 17:44:17', '2024-06-24 17:44:17');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `fragrances_status` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `description`, `image`, `created_at`, `updated_at`, `fragrances_status`) VALUES
(1, 'BIBIT PARFUM', 'Setiap bibit memiliki karakteristik aroma unik, mulai dari floral hingga woody, dan informasi tentang asal, komposisi, serta sifat aromanya.', NULL, '2024-05-01 19:14:08', '2024-06-02 06:01:23', 1),
(2, 'LOTION', 'Diformulasikan untuk melembapkan dan merawat kulit.', NULL, '2024-05-01 20:23:24', '2024-06-02 06:02:50', 0),
(5, 'Men Perfume', 'Parfum untuk laki-laki', NULL, '2024-06-09 11:33:25', '2024-06-09 11:33:25', 1);

-- --------------------------------------------------------

--
-- Table structure for table `current_stock`
--

CREATE TABLE `current_stock` (
  `id` int(11) NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `current_stock` double DEFAULT NULL,
  `current_stock_gram` double DEFAULT NULL,
  `created_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `current_stock`
--

INSERT INTO `current_stock` (`id`, `product_id`, `current_stock`, `current_stock_gram`, `created_at`, `updated_at`) VALUES
(1, 1, 435.755, 0, '2024-06-20 07:45:03', '2024-06-20 07:45:03'),
(2, 2, 451.995, 0, '2024-06-10 09:32:11', '2024-06-10 02:32:11'),
(3, 5, 930, 0, '2024-06-06 15:11:33', '2024-06-06 15:11:33'),
(4, 8, 651, 0, '2024-06-10 08:36:30', '2024-06-10 01:36:30'),
(5, 108, 674, 0, '2024-06-08 19:23:48', '2024-06-08 12:23:48'),
(7, 115, 621.8104, 629, '2024-06-22 11:09:40', '2024-06-22 11:09:40'),
(10, 117, 299.14893617021, 300, '2024-06-23 22:43:12', '2024-06-23 22:43:12'),
(11, 118, 311.203319502075, 300, '2024-06-23 16:29:10', '2024-06-23 16:29:10'),
(12, 119, 244.14893617021, 300, '2024-06-23 22:43:12', '2024-06-23 22:43:12'),
(13, 120, 301.204819277109, 300, '2024-06-23 16:29:16', '2024-06-23 16:29:16');

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `phone_number` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `birthdate` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`id`, `name`, `phone_number`, `email`, `address`, `birthdate`, `created_at`, `updated_at`) VALUES
(1, 'Kamal', '08123456789', NULL, NULL, NULL, '2024-05-15 21:07:32', '2024-05-15 21:07:32'),
(2, 'Agus', '08127345345435', NULL, NULL, NULL, '2024-06-02 23:01:33', '2024-06-02 23:01:33'),
(3, 'Customer1', '11111', NULL, NULL, NULL, '2024-06-03 02:22:59', '2024-06-03 02:22:59'),
(5, 'goldy', '081223939679', NULL, NULL, NULL, '2024-06-03 05:21:45', '2024-06-03 05:21:45'),
(6, 'udin', '123', NULL, NULL, NULL, '2024-06-03 20:07:24', '2024-06-03 20:07:24'),
(7, 'gilang', '081234567893', NULL, NULL, NULL, '2024-06-04 22:53:07', '2024-06-04 22:53:07'),
(8, 'adesta', '082229331529', NULL, NULL, NULL, '2024-06-05 04:26:47', '2024-06-05 04:26:47'),
(9, 'Goldy', '081212929459', NULL, NULL, NULL, '2024-06-07 16:47:29', '2024-06-07 16:47:29'),
(10, 'victor', '081112233445566', NULL, NULL, NULL, '2024-06-19 09:46:47', '2024-06-19 09:46:47'),
(11, 'guest', '0', 'guest', 'null', '2001-01-01', '2024-06-20 00:40:27', '2024-06-20 00:40:27');

-- --------------------------------------------------------

--
-- Table structure for table `fragrances`
--

CREATE TABLE `fragrances` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `gram_to_ml` double DEFAULT NULL,
  `ml_to_gram` double DEFAULT NULL,
  `gram` double DEFAULT NULL,
  `mililiter` double DEFAULT NULL,
  `pump_weight` double DEFAULT NULL,
  `bottle_weight` double DEFAULT NULL,
  `total_weight` double DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `fragrances`
--

INSERT INTO `fragrances` (`id`, `product_id`, `name`, `gram_to_ml`, `ml_to_gram`, `gram`, `mililiter`, `pump_weight`, `bottle_weight`, `total_weight`, `created_at`, `updated_at`) VALUES
(1, 2, 'BM32', NULL, 5, 114, 570, 10, 30, 154, '2024-05-13 21:15:52', '2024-05-14 19:16:09'),
(2, 1, 'BM31', NULL, NULL, NULL, NULL, NULL, NULL, 153, '2024-05-14 19:17:23', '2024-05-14 19:17:23'),
(3, 5, 'BM33', NULL, NULL, NULL, NULL, NULL, NULL, 783, '2024-05-14 19:19:44', '2024-06-04 22:34:23'),
(4, 6, 'BM34', NULL, NULL, NULL, NULL, NULL, NULL, 154, '2024-05-14 19:20:11', '2024-05-14 19:20:11'),
(5, 7, 'BM35', NULL, NULL, NULL, NULL, NULL, NULL, 155, '2024-05-14 19:20:30', '2024-05-14 19:20:30'),
(6, 8, 'Dior Sauvage', NULL, NULL, NULL, NULL, NULL, NULL, 676, '2024-06-03 20:38:05', '2024-06-09 11:39:01'),
(9, 11, 'Maison Francis Baccarat', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-03 20:58:01', '2024-06-03 20:58:01'),
(12, 15, 'BLV Pour Homme', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 03:04:49', '2024-06-04 03:04:49'),
(13, 16, 'CK (ALL)', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 03:07:04', '2024-06-04 03:07:04'),
(14, 17, 'Lacoste 212', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 04:28:47', '2024-06-04 04:28:47'),
(15, 18, 'Dunhill Desire Blue', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 04:30:23', '2024-06-04 04:30:23'),
(16, 19, 'Escada Sexy Gravity', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 04:31:23', '2024-06-04 04:31:23'),
(17, 20, 'Justin Bieber Someday', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 04:32:31', '2024-06-04 04:32:31'),
(18, 21, 'Kenzo Men', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 04:35:33', '2024-06-04 04:35:33'),
(19, 22, 'Jo Malone (Star Magnolia)', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 04:37:35', '2024-06-04 04:37:35'),
(20, 23, 'Mont Blanc Legend', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 04:38:42', '2024-06-04 04:38:42'),
(21, 24, 'D&G L\'imperative', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 04:39:03', '2024-06-04 04:39:03'),
(22, 25, 'Mont Blanc Legend Spirit', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 04:39:31', '2024-06-04 04:39:31'),
(23, 26, 'Alien (Thierry Mugler)', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 04:39:57', '2024-06-04 04:39:57'),
(24, 27, 'Avril Lavigne Forbidden Rose', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 04:40:36', '2024-06-04 04:40:36'),
(25, 28, 'Channel Allure Sensual', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 04:41:23', '2024-06-04 04:41:23'),
(26, 29, 'Paco Rabanne (1Million Prive)', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 04:41:47', '2024-06-04 04:41:47'),
(27, 30, 'CK (All By CK)', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 04:42:24', '2024-06-04 04:42:24'),
(28, 31, 'Polo Red Extreme', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 04:42:59', '2024-06-04 04:42:59'),
(29, 32, 'Dior Addict', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 04:43:23', '2024-06-04 04:43:23'),
(30, 33, 'D&G Light Blue', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 04:43:54', '2024-06-04 04:43:54'),
(31, 34, 'Desperado Desired Red (Alfred Dunhill)', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 04:44:35', '2024-06-04 04:44:35'),
(32, 35, 'D&G Light Blue', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 04:45:39', '2024-06-04 04:45:39'),
(33, 36, 'Deep Chrome: Azzaro Chrome Intense (Azzaro Men)', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 04:46:06', '2024-06-04 04:46:06'),
(34, 37, 'Escada Cherry in the Air', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 04:46:08', '2024-06-04 04:46:08'),
(35, 38, 'Anna Sui (Flight of Fancy)', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 04:46:38', '2024-06-04 04:46:38'),
(36, 39, 'Estee Lauder Pleasure', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 04:47:11', '2024-06-04 04:47:11'),
(37, 40, 'Gucci Premier', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 04:47:38', '2024-06-04 04:47:38'),
(38, 41, 'Sailor Man: Le Male Popeye (Jean Paul Gaultier)', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 04:47:48', '2024-06-04 04:47:48'),
(39, 42, 'Bulgari Extreme', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 04:48:34', '2024-06-04 04:48:34'),
(40, 43, 'Hugo Boss Red', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 04:52:44', '2024-06-04 04:52:44'),
(41, 44, 'Polo Sport', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 04:54:56', '2024-06-04 04:54:56'),
(42, 45, 'Aqua Marine', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 05:12:49', '2024-06-04 05:12:49'),
(43, 46, 'Jlo Still', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 05:13:18', '2024-06-04 05:13:18'),
(44, 47, 'Aqua Tonic', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 05:13:27', '2024-06-04 05:13:27'),
(45, 48, 'JIo Glow Platinum', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 05:13:52', '2024-06-04 05:13:52'),
(46, 49, 'Paul Smith', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 05:13:59', '2024-06-04 05:13:59'),
(47, 50, 'CR 7 Legacy', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 05:14:30', '2024-06-04 05:14:30'),
(48, 51, 'Lovely (Sarah Jessica Parker)', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 05:14:33', '2024-06-04 05:14:33'),
(49, 52, 'Kilian Harmony Floral Fruity', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 05:15:10', '2024-06-04 05:15:10'),
(50, 53, 'Antonio Banderas Blue Seduction', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 05:15:17', '2024-06-04 05:15:17'),
(51, 54, 'Victoria Secret New Bombshell (Bloom)', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 05:15:43', '2024-06-04 05:15:43'),
(52, 55, 'Forza Tonino Lamborghini', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 05:16:13', '2024-06-04 05:16:13'),
(53, 56, 'Fiesta Carioca', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 05:16:17', '2024-06-04 05:16:17'),
(54, 57, 'Burberry', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 05:16:51', '2024-06-04 05:16:51'),
(55, 58, 'Creed Aventus', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 05:16:53', '2024-06-04 05:16:53'),
(56, 59, 'Aigner Blue', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 05:17:34', '2024-06-04 05:17:34'),
(57, 60, 'Jlo Still Rework', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 05:17:49', '2024-06-04 05:17:49'),
(58, 61, 'Passport Paris (Paris Hilton)', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 05:18:25', '2024-06-04 05:18:25'),
(59, 62, 'Aigner Black', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 05:19:01', '2024-06-04 05:19:01'),
(60, 63, 'Paris Hilton', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 05:19:08', '2024-06-04 05:19:08'),
(61, 64, 'Jaguar Vision', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 05:19:49', '2024-06-04 05:19:49'),
(62, 65, 'Jimmy Choo Blossom', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 05:19:58', '2024-06-04 05:19:58'),
(63, 66, 'Maison Francis Silk Mood', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 05:20:42', '2024-06-04 05:20:42'),
(64, 67, 'Olla Ramian', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 05:20:58', '2024-06-04 05:20:58'),
(65, 68, 'Victoria Secret Night', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 05:21:27', '2024-06-04 05:21:27'),
(66, 69, 'Paco Rabanne Invictus', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 05:21:34', '2024-06-04 05:21:34'),
(67, 70, 'Eternity Air Woman', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 05:22:02', '2024-06-04 05:22:02'),
(68, 71, 'Bulgari Au The Vert', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 05:22:12', '2024-06-04 05:22:12'),
(69, 72, 'Miss Dior Blue Mint', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 05:22:57', '2024-06-04 05:22:57'),
(70, 73, 'Baccarat Oud Satin Mood', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 05:23:07', '2024-06-04 05:23:07'),
(71, 74, 'Victoria Secret Romance Wish', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 05:23:38', '2024-06-04 05:23:38'),
(72, 75, 'By Him Signature', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 05:24:10', '2024-06-04 05:24:10'),
(73, 76, 'Selena Gomez', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 05:24:43', '2024-06-04 05:24:43'),
(74, 77, 'Victoria Secret Bombshell', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 05:25:23', '2024-06-04 05:25:23'),
(75, 78, 'Black Opium', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 05:26:11', '2024-06-04 05:26:11'),
(76, 79, 'Bulgari Pour Home', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 05:26:54', '2024-06-04 05:26:54'),
(77, 80, 'Bulgari Rose', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 05:27:41', '2024-06-04 05:27:41'),
(78, 81, 'Jo Malone English Pear & Freesia', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 05:28:18', '2024-06-04 05:28:18'),
(79, 82, 'Boucheron Quatre Feminin', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 05:28:51', '2024-06-04 05:28:51'),
(80, 83, 'Hermes Eau De Citron', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 05:29:26', '2024-06-04 05:29:26'),
(81, 84, 'Victoria Secret Scandalous', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 05:30:01', '2024-06-04 05:30:01'),
(82, 85, 'Jo Malone Peony and Blush Suede', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 05:30:35', '2024-06-04 05:30:35'),
(83, 86, 'Victoria Secret Aqua Kiss Water Bloom', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 05:31:10', '2024-06-04 05:31:10'),
(84, 87, 'Viva La Juicy Couture Noir', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 05:31:40', '2024-06-04 05:31:40'),
(85, 88, 'Moschino Glamour', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 05:32:13', '2024-06-04 05:32:13'),
(86, 89, 'Bulgari Omnia Amethyst', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 05:32:50', '2024-06-04 05:32:50'),
(87, 90, 'Bulgari Omnia Crystalline', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 05:33:21', '2024-06-04 05:33:21'),
(88, 91, 'Coco Channel Mademoiselle', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 05:33:48', '2024-06-04 05:33:48'),
(89, 92, 'Paco Rabanne Black XS L\'Exces for Her', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 05:34:19', '2024-06-04 05:34:19'),
(90, 93, 'CH Good Girl Velvet Fatale', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 05:34:53', '2024-06-04 05:34:53'),
(91, 94, 'Giorgio Armani', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 05:35:21', '2024-06-04 05:35:21'),
(92, 95, 'Acal Berry', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 05:49:07', '2024-06-04 05:49:07'),
(93, 96, 'Dark Chocolate', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 05:51:16', '2024-06-04 05:51:16'),
(94, 97, 'Black Coffee', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 05:51:50', '2024-06-04 05:51:50'),
(95, 98, 'Comfort', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 05:52:21', '2024-06-04 05:52:21'),
(96, 99, 'Green Tea', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 05:52:59', '2024-06-04 05:52:59'),
(97, 100, 'Musk', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 05:53:35', '2024-06-04 05:53:35'),
(98, 101, 'Bubblicious', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 05:54:04', '2024-06-04 05:54:04'),
(99, 102, 'Body & Soul', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 05:54:38', '2024-06-04 05:54:38'),
(100, 103, 'Vanilla', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 05:55:05', '2024-06-04 05:55:05'),
(101, 104, 'Capucinno', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 05:55:34', '2024-06-04 05:55:34'),
(102, 105, 'Wild Strawberry', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 05:55:59', '2024-06-04 05:55:59'),
(103, 106, 'Sandalwood', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-04 05:56:29', '2024-06-04 05:56:29'),
(105, 108, 'Dior Sauvage', NULL, NULL, NULL, NULL, NULL, NULL, 100, '2024-06-08 05:16:58', '2024-06-08 05:16:58'),
(106, 109, 'Dior Sauvage', NULL, NULL, NULL, NULL, NULL, NULL, 160, '2024-06-17 23:22:28', '2024-06-17 23:22:28'),
(109, 115, 'Carolina Herrera VIP Black', 1.05485232067511, 0.948, 298, 314.34599156118276, 60, 611, 969, '2024-06-20 09:11:17', '2024-06-20 09:11:17'),
(111, 117, 'TERRE D HERMES', 1.06382978723404, 0.94, 300, 319.14893617021204, 60, 611, 971, '2024-06-23 07:52:46', '2024-06-23 07:52:46'),
(112, 118, 'HUGO BOSS ENERGIZE', 1.03734439834025, 0.964, 300, 311.203319502075, 60, 611, 971, '2024-06-23 09:13:00', '2024-06-23 09:13:00'),
(113, 119, 'MICHAEL KORS', 1.06382978723404, 0.94, 300, 319.14893617021204, 60, 611, 971, '2024-06-23 09:19:15', '2024-06-23 09:25:39'),
(114, 120, 'MAISON FRANCIS BACCARAT', 1.00401606425703, 0.996, 300, 301.204819277109, 60, 611, 971, '2024-06-23 09:24:03', '2024-06-23 09:24:03');


-- --------------------------------------------------------

--
-- Table structure for table `other_product`
--

CREATE TABLE `other_product` (
  `id` int(11) NOT NULL,
  `product_name` varchar(255) DEFAULT NULL,
  `base_price` bigint(20) DEFAULT 0,
  `sale_price` bigint(20) DEFAULT 0,
  `product_description` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `other_product`
--

INSERT INTO `other_product` (`id`, `product_name`, `base_price`, `sale_price`, `product_description`, `image`, `created_at`, `updated_at`) VALUES
(2, 'Gelang', 2000, 34000, 'Gelang Wangi', '_20240602132348.png', '2024-06-12 18:28:01', '2024-06-12 18:28:01');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `category_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `price` bigint(20) NOT NULL,
  `stock` int(11) DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `is_favorite` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `branch_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `category_id`, `name`, `description`, `image`, `price`, `stock`, `status`, `is_favorite`, `created_at`, `updated_at`, `branch_id`) VALUES
(1, 1, 'BM31', '212 VIP Black by Carolina Herrera is a Aromatic Fougere fragrance for men. 212 VIP Black was launched in 2017. 212 VIP Black was created by Carlos Benaim and Anne Flipo. Top notes are Absinthe, Anise and Fennel; middle note is Lavender; base notes are Black Vanilla Husk and Musk.', 'bm31.jpg', 500, 1, 1, 1, '2024-05-01 19:14:31', '2024-06-09 17:12:48', 1),
(2, 1, 'BM32', 'Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content.', '_20240514041552.jpg', 500, 1, 1, 1, '2024-05-13 21:15:52', '2024-05-14 19:16:09', 1),
(5, 1, 'BM33', 'Hugo Energise by Hugo Boss is a Woody Aromatic fragrance for men', 'bm33.jpg', 500, 1, 1, 1, '2024-05-14 19:19:44', '2024-06-04 22:34:23', 1),
(6, 1, 'BM34', 'Michael Kors for Men by Michael Kors is a Amber Woody fragrance for men. Top notes are Star Anise, elemi, Black Pepper, Thyme, Bergamot and Coriander; middle notes are Suede, Incense and Sage; base notes are Patchouli, Sandalwood, Woody Notes and Musk.', 'bm34.jpg', 500, 1, 1, 1, '2024-05-14 19:20:11', '2024-05-14 19:20:11', 1),
(7, 1, 'BM35', 'Baccarat Rouge 540 by Maison Francis Kurkdjian is a Amber Floral fragrance for women and men. The nose behind this fragrance is Francis Kurkdjian. Top notes are Saffron and Jasmine; middle notes are Amberwood and Ambergris; base notes are Fir Resin and Cedar.', 'bm35.jpg', 400, 1, 1, 1, '2024-05-14 19:20:30', '2024-05-14 19:20:30', 1),
(8, 5, 'BM36', 'Sauvage by Dior is a Aromatic Fougere fragrance for men. Sauvage was launched in 2015. The nose behind this fragrance is François Demachy. Top notes are Calabrian bergamot and Pepper; middle notes are Sichuan Pepper, Lavender, Pink Pepper, Vetiver, Patchouli, Geranium and elemi; base notes are Ambroxan, Cedar and Labdanum.', '_20240604034344.webp', 500, 1, 1, 1, '2024-06-03 20:38:05', '2024-06-09 11:39:01', 1),
(11, 1, 'BM35', 'NICE', 'bm35.jpg', 500, 1, 1, 1, '2024-06-03 20:58:01', '2024-06-03 20:58:01', 6),
(12, 1, 'BM37', 'Boss Bottled United by Hugo Boss is a Woody Aromatic fragrance for men. Top notes are Blood Orange, Ozonic notes and Buchu or Agathosma; middle notes are Mint, Peppermint, Apple, Melon, Orris and Lily-of-the-Valley; base notes are Vetiver, Patchouli, White Musk, Amberwood, Cashmeran and Coumarin.', 'bm37.jpg', 500, 1, 1, 1, '2024-06-03 21:00:26', '2024-06-03 21:00:26', 1),
(14, 1, 'BM38', 'Lacoste Live by Lacoste Fragrances is a Aromatic Aquatic fragrance for men. The nose behind this fragrance is Jean-Michel Duriez. Top note is Lime; middle notes are Green Notes and Watery Notes; base notes are Licorice and Guaiac Wood.', 'bm38.jpg', 500, 1, 1, 1, '2024-06-03 21:01:24', '2024-06-03 21:01:24', 1),
(15, 1, 'BM01', 'BLV Pour Homme by Bvlgari is a Woody Spicy fragrance for men. The nose behind this fragrance is Alberto Morillas. Top notes are Cardamom and Sandalwood; middle notes are Ginger, Juniper and Galanga; base notes are Tobacco Blossom, Green Leaves and Teak Wood.', 'bm01.jpg', 500, 1, 1, 1, '2024-06-04 03:04:49', '2024-06-04 03:04:49', 1),
(16, 1, 'BM02', 'CK All by Calvin Klein is a Citrus fragrance for women and men. CK All was launched in 2017. CK All was created by Alberto Morillas and Harry Fremont. Top notes are Bergamot, Mandarin Orange and Grapefruit blossom; middle notes are Jasmine, Rhubarb, Freesia and Lily; base notes are Musk, Amber and Vetiver.', 'bm02.jpg', 500, 1, 1, 1, '2024-06-04 03:07:04', '2024-06-04 03:07:04', 1),
(17, 1, 'BM04', 'Lacoste 212', 'bm04.jpg', 500, 1, 1, 1, '2024-06-04 04:28:47', '2024-06-04 04:28:47', 1),
(18, 1, 'BM06', 'Dunhill Desire Blue', 'bm06.jpg', 500, 1, 1, 1, '2024-06-04 04:30:23', '2024-06-04 04:30:23', 1),
(19, 1, 'BM08', 'Escada Sexy Gravity', 'bm08.jpg', 500, 1, 1, 1, '2024-06-04 04:31:23', '2024-06-04 04:31:23', 1),
(20, 1, 'BM09', 'Justin Bieber Someday', 'bm09.jpg', 500, 1, 1, 1, '2024-06-04 04:32:31', '2024-06-04 04:32:31', 1),
(21, 1, 'BM11', 'Kenzo Men', 'bm11.jpg', 500, 1, 1, 1, '2024-06-04 04:35:33', '2024-06-04 04:35:33', 1),
(22, 1, 'BM10', 'Jo Malone (Star Magnolia)', 'bm10.jpg', 500, 1, 1, 1, '2024-06-04 04:37:35', '2024-06-04 04:37:35', 1),
(23, 1, 'BM14', 'Mont Blanc Legend', 'bm14.jpg', 500, 1, 1, 1, '2024-06-04 04:38:42', '2024-06-04 04:38:42', 1),
(24, 1, 'BF 01', 'D&G L\'imperative', NULL, 500, 1, 1, 1, '2024-06-04 04:39:03', '2024-06-04 04:39:03', 1),
(25, 1, 'BM15', 'Mont Blanc Legend Spirit', 'bm15.jpg', 500, 1, 1, 1, '2024-06-04 04:39:31', '2024-06-04 04:39:31', 1),
(26, 1, 'BF 02', 'Alien (Thierry Mugler)', NULL, 500, 1, 1, 1, '2024-06-04 04:39:57', '2024-06-04 04:39:57', 1),
(27, 1, 'BF 03', 'Avril Lavigne Forbidden Rose', NULL, 500, 1, 1, 1, '2024-06-04 04:40:36', '2024-06-04 04:40:36', 1),
(28, 1, 'BF 04', 'Channel Allure Sensual', NULL, 500, 1, 1, 1, '2024-06-04 04:41:23', '2024-06-04 04:41:23', 1),
(29, 1, 'BM16', 'Paco Rabanne (1Million Prive)', 'bm16.jpg', 500, 1, 1, 1, '2024-06-04 04:41:47', '2024-06-04 04:41:47', 1),
(30, 1, 'BF 05', 'CK (All By CK)', NULL, 500, 1, 1, 1, '2024-06-04 04:42:24', '2024-06-04 04:42:24', 1),
(31, 1, 'BM17', 'Polo Red Extreme', 'bm17.jpg', 500, 1, 1, 1, '2024-06-04 04:42:59', '2024-06-04 04:42:59', 1),
(32, 1, 'BF 07', 'Dior Addict', NULL, 500, 1, 1, 1, '2024-06-04 04:43:23', '2024-06-04 04:43:23', 1),
(33, 1, 'BF 08', 'D&G Light Blue', NULL, 500, 1, 1, 1, '2024-06-04 04:43:54', '2024-06-04 04:43:54', 1),
(34, 1, 'BM18', 'Desperado Desired Red (Alfred Dunhill)', 'bm18.jpg', 500, 1, 1, 1, '2024-06-04 04:44:35', '2024-06-04 04:44:35', 1),
(35, 1, 'BF 08', 'D&G Light Blue', NULL, 500, 1, 1, 1, '2024-06-04 04:45:39', '2024-06-04 04:45:39', 1),
(36, 1, 'BM19', 'Deep Chrome: Azzaro Chrome Intense (Azzaro Men)', 'bm19.jpg', 500, 1, 1, 1, '2024-06-04 04:46:06', '2024-06-04 04:46:06', 1),
(37, 1, 'BF 09', 'Escada Cherry in the Air', NULL, 500, 1, 1, 1, '2024-06-04 04:46:08', '2024-06-04 04:46:08', 1),
(38, 1, 'BF 10', 'Anna Sui (Flight of Fancy)', NULL, 500, 1, 1, 1, '2024-06-04 04:46:38', '2024-06-04 04:46:38', 1),
(39, 1, 'BF 11', 'Estee Lauder Pleasure', NULL, 500, 1, 1, 1, '2024-06-04 04:47:11', '2024-06-04 04:47:11', 1),
(40, 1, 'BF 13', 'Gucci Premier', NULL, 500, 1, 1, 1, '2024-06-04 04:47:38', '2024-06-04 04:47:38', 1),
(41, 1, 'BM20', 'Sailor Man: Le Male Popeye (Jean Paul Gaultier)', 'bm20.jpg', 500, 1, 1, 1, '2024-06-04 04:47:48', '2024-06-04 04:47:48', 1),
(42, 1, 'BM21', 'Bulgari Extreme', 'bm21.jpg', 500, 1, 1, 1, '2024-06-04 04:48:34', '2024-06-04 04:48:34', 1),
(43, 1, 'BM22', 'Hugo Boss Red', 'bm22.jpg', 500, 1, 1, 1, '2024-06-04 04:52:44', '2024-06-04 04:52:44', 1),
(44, 1, 'BM25', 'Polo Sport', 'bm25.jpg', 500, 1, 1, 1, '2024-06-04 04:54:56', '2024-06-04 04:54:56', 1),
(45, 1, 'BM26', 'Aqua Marine', 'bm26.jpg', 500, 1, 1, 1, '2024-06-04 05:12:49', '2024-06-04 05:12:49', 1),
(46, 1, 'BF 14', 'Jlo Still', NULL, 500, 1, 1, 1, '2024-06-04 05:13:18', '2024-06-04 05:13:18', 1),
(47, 1, 'BM27', 'Aqua Tonic', 'bm27.jpg', 500, 1, 1, 1, '2024-06-04 05:13:27', '2024-06-04 05:13:27', 1),
(48, 1, 'BF 15', 'JIo Glow Platinum', NULL, 500, 1, 1, 1, '2024-06-04 05:13:52', '2024-06-04 05:13:52', 1),
(49, 1, 'BM28', 'Paul Smith', 'bm28.jpg', 500, 1, 1, 1, '2024-06-04 05:13:59', '2024-06-04 05:13:59', 1),
(50, 1, 'BM29', 'CR 7 Legacy', 'bm29.jpg', 500, 1, 1, 1, '2024-06-04 05:14:30', '2024-06-04 05:14:30', 1),
(51, 1, 'BF 17', 'Lovely (Sarah Jessica Parker)', NULL, 500, 1, 1, 1, '2024-06-04 05:14:33', '2024-06-04 05:14:33', 1),
(52, 1, 'BF 18', 'Kilian Harmony Floral Fruity', NULL, 500, 1, 1, 1, '2024-06-04 05:15:10', '2024-06-04 05:15:10', 1),
(53, 1, 'BM30', 'Antonio Banderas Blue Seduction', 'bm30.jpg', 500, 1, 1, 1, '2024-06-04 05:15:17', '2024-06-04 05:15:17', 1),
(54, 1, 'BF 19', 'Victoria Secret New Bombshell (Bloom)', NULL, 500, 1, 1, 1, '2024-06-04 05:15:43', '2024-06-04 05:15:43', 1),
(55, 1, 'BM39', 'Forza Tonino Lamborghini', 'bm39.jpg', 500, 1, 1, 1, '2024-06-04 05:16:13', '2024-06-04 05:16:13', 1),
(56, 1, 'BF 20', 'Fiesta Carioca', NULL, 500, 1, 1, 1, '2024-06-04 05:16:17', '2024-06-04 05:16:17', 1),
(57, 1, 'BF 21', 'Burberry', NULL, 500, 1, 1, 1, '2024-06-04 05:16:51', '2024-06-04 05:16:51', 1),
(58, 1, 'BM40', 'Creed Aventus', 'bm40.jpeg', 500, 1, 1, 1, '2024-06-04 05:16:53', '2024-06-04 05:16:53', 1),
(59, 1, 'BM41', 'Aigner Blue', 'bm41.jpeg', 500, 1, 1, 1, '2024-06-04 05:17:34', '2024-06-04 05:17:34', 1),
(60, 1, 'BF 22', 'Jlo Still Rework', NULL, 500, 1, 1, 1, '2024-06-04 05:17:49', '2024-06-04 05:17:49', 1),
(61, 1, 'BF 23', 'Passport Paris (Paris Hilton)', NULL, 500, 1, 1, 1, '2024-06-04 05:18:25', '2024-06-04 05:18:25', 1),
(62, 1, 'BM42', 'Aigner Black', 'bm42.jpeg', 500, 1, 1, 1, '2024-06-04 05:19:01', '2024-06-04 05:19:01', 1),
(63, 1, 'BF 24', 'Paris Hilton', NULL, 500, 1, 1, 1, '2024-06-04 05:19:08', '2024-06-04 05:19:08', 1),
(64, 1, 'BM43', 'Jaguar Vision', 'bm43.jpg', 500, 1, 1, 1, '2024-06-04 05:19:49', '2024-06-04 05:19:49', 1),
(65, 1, 'BF 25', 'Jimmy Choo Blossom', NULL, 500, 1, 1, 1, '2024-06-04 05:19:58', '2024-06-04 05:19:58', 1),
(66, 1, 'BM44', 'Maison Francis Silk Mood', 'bm44.jpg', 500, 1, 1, 1, '2024-06-04 05:20:42', '2024-06-04 05:20:42', 1),
(67, 1, 'BF 26', 'Olla Ramian', NULL, 500, 1, 1, 1, '2024-06-04 05:20:58', '2024-06-04 05:20:58', 1),
(68, 1, 'BF 27', 'Victoria Secret Night', NULL, 500, 1, 1, 1, '2024-06-04 05:21:27', '2024-06-04 05:21:27', 1),
(69, 1, 'BM45', 'Paco Rabanne Invictus', 'bm45.jpg', 500, 1, 1, 1, '2024-06-04 05:21:34', '2024-06-04 05:21:34', 1),
(70, 1, 'BF 28', 'Eternity Air Woman', NULL, 500, 1, 1, 1, '2024-06-04 05:22:02', '2024-06-04 05:22:02', 1),
(71, 1, 'BM46', 'Bulgari Au The Vert', 'bm46.jpg', 500, 1, 1, 1, '2024-06-04 05:22:12', '2024-06-04 05:22:12', 1),
(72, 1, 'BF 29', 'Miss Dior Blue Mint', NULL, 500, 1, 1, 1, '2024-06-04 05:22:57', '2024-06-04 05:22:57', 1),
(73, 1, 'BM47', 'Baccarat Oud Satin Mood', 'bm47.jpg', 500, 1, 1, 1, '2024-06-04 05:23:07', '2024-06-04 05:23:07', 1),
(74, 1, 'BF 30', 'Victoria Secret Romance Wish', NULL, 500, 1, 1, 1, '2024-06-04 05:23:38', '2024-06-04 05:23:38', 1),
(75, 1, 'BF 31', 'By Him Signature', NULL, 500, 1, 1, 1, '2024-06-04 05:24:10', '2024-06-04 05:24:10', 1),
(76, 1, 'BF 32', 'Selena Gomez', NULL, 500, 1, 1, 1, '2024-06-04 05:24:43', '2024-06-04 05:24:43', 1),
(77, 1, 'BF 33', 'Victoria Secret Bombshell', NULL, 500, 1, 1, 1, '2024-06-04 05:25:23', '2024-06-04 05:25:23', 1),
(78, 1, 'BF 34', 'Black Opium', NULL, 500, 1, 1, 1, '2024-06-04 05:26:11', '2024-06-04 05:26:11', 1),
(79, 1, 'BF 35', 'Bulgari Pour Home', NULL, 500, 1, 1, 1, '2024-06-04 05:26:54', '2024-06-04 05:26:54', 1),
(80, 1, 'BF 36', 'Bulgari Rose', NULL, 500, 1, 1, 1, '2024-06-04 05:27:41', '2024-06-04 05:27:41', 1),
(81, 1, 'BF 37', 'Jo Malone English Pear & Freesia', NULL, 500, 1, 1, 1, '2024-06-04 05:28:18', '2024-06-04 05:28:18', 1),
(82, 1, 'BF 38', 'Boucheron Quatre Feminin', NULL, 500, 1, 1, 1, '2024-06-04 05:28:51', '2024-06-04 05:28:51', 1),
(83, 1, 'BF 39', 'Hermes Eau De Citron', NULL, 500, 1, 1, 1, '2024-06-04 05:29:26', '2024-06-04 05:29:26', 1),
(84, 1, 'BF 40', 'Victoria Secret Scandalous', NULL, 500, 1, 1, 1, '2024-06-04 05:30:01', '2024-06-04 05:30:01', 1),
(85, 1, 'BF 41', 'Jo Malone Peony and Blush Suede', NULL, 500, 1, 1, 1, '2024-06-04 05:30:35', '2024-06-04 05:30:35', 1),
(86, 1, 'BF 42', 'Victoria Secret Aqua Kiss Water Bloom', NULL, 500, 1, 1, 1, '2024-06-04 05:31:10', '2024-06-04 05:31:10', 1),
(87, 1, 'BF 43', 'Viva La Juicy Couture Noir', NULL, 500, 1, 1, 1, '2024-06-04 05:31:40', '2024-06-04 05:31:40', 1),
(88, 1, 'BF 44', 'Moschino Glamour', NULL, 500, 1, 1, 1, '2024-06-04 05:32:13', '2024-06-04 05:32:13', 1),
(89, 1, 'BF 45', 'Bulgari Omnia Amethyst', NULL, 500, 1, 1, 1, '2024-06-04 05:32:50', '2024-06-04 05:32:50', 1),
(90, 1, 'BF 46', 'Bulgari Omnia Crystalline', NULL, 500, 1, 1, 1, '2024-06-04 05:33:21', '2024-06-04 05:33:21', 1),
(91, 1, 'BF 47', 'Coco Channel Mademoiselle', NULL, 500, 1, 1, 1, '2024-06-04 05:33:48', '2024-06-04 05:33:48', 1),
(92, 1, 'BF 48', 'Paco Rabanne Black XS L\'Exces for Her', NULL, 500, 1, 1, 1, '2024-06-04 05:34:19', '2024-06-04 05:34:19', 1),
(93, 1, 'BF 49', 'CH Good Girl Velvet Fatale', NULL, 500, 1, 1, 1, '2024-06-04 05:34:53', '2024-06-04 05:34:53', 1),
(94, 1, 'BF 50', 'Giorgio Armani', NULL, 500, 1, 1, 1, '2024-06-04 05:35:21', '2024-06-04 05:35:21', 1),
(95, 1, 'BA 01', 'Acal Berry', NULL, 500, 1, 1, 1, '2024-06-04 05:49:07', '2024-06-04 05:49:07', 1),
(96, 1, 'BA 02', 'Dark Chocolate', NULL, 500, 1, 1, 1, '2024-06-04 05:51:16', '2024-06-04 05:51:16', 1),
(97, 1, 'BA 03', 'Black Coffee', NULL, 500, 1, 1, 1, '2024-06-04 05:51:50', '2024-06-04 05:51:50', 1),
(98, 1, 'BA 04', 'Comfort', NULL, 500, 1, 1, 1, '2024-06-04 05:52:21', '2024-06-04 05:52:21', 1),
(99, 1, 'BA 05', 'Green Tea', NULL, 500, 1, 1, 1, '2024-06-04 05:52:59', '2024-06-04 05:52:59', 1),
(100, 1, 'BA 06', 'Musk', NULL, 500, 1, 1, 1, '2024-06-04 05:53:35', '2024-06-04 05:53:35', 1),
(101, 1, 'BA 07', 'Bubblicious', NULL, 500, 1, 1, 1, '2024-06-04 05:54:04', '2024-06-04 05:54:04', 1),
(102, 1, 'BA 08', 'Body & Soul', NULL, 500, 1, 1, 1, '2024-06-04 05:54:38', '2024-06-04 05:54:38', 1),
(103, 1, 'BA 09', 'Vanilla', NULL, 500, 1, 1, 1, '2024-06-04 05:55:05', '2024-06-04 05:55:05', 1),
(104, 1, 'BA 10', 'Capucinno', NULL, 500, 1, 1, 1, '2024-06-04 05:55:34', '2024-06-04 05:55:34', 1),
(105, 1, 'BA 11', 'Wild Strawberry', NULL, 500, 1, 1, 1, '2024-06-04 05:55:59', '2024-06-04 05:55:59', 1),
(106, 1, 'BA 12', 'Sandalwood', NULL, 500, 1, 1, 1, '2024-06-04 05:56:29', '2024-06-04 05:56:29', 1),
(108, 1, 'BM36', 'Dior Sauvage', NULL, 500, 1, 1, 1, '2024-06-08 05:16:58', '2024-06-08 05:16:58', 2),
(109, 5, 'BM36', 'Dior Sauvage', NULL, 500, 1, 1, 1, '2024-06-17 23:22:28', '2024-06-17 23:22:28', 8),
(110, 5, 'BM31', 'Description1', NULL, 500, 600, 1, 1, '2024-06-18 09:56:21', '2024-06-18 09:56:21', 8),
(111, 5, 'BM32', 'Description2', NULL, 500, 600, 1, 1, '2024-06-18 09:56:21', '2024-06-18 09:56:21', 8),
(112, 5, 'BM33', 'Description3', NULL, 500, 600, 1, 1, '2024-06-18 09:56:21', '2024-06-18 09:56:21', 8),
(115, 5, 'BM31', 'Carolina Herrera VIP Black', 'bm31.jpg', 500, 1, 1, 1, '2024-06-20 09:11:17', '2024-06-20 09:11:17', 4),
(117, 5, 'BM32', 'Terre d\'Hermès by Hermès is a Woody Spicy fragrance for men. Terre d\'Hermès was launched in 2006. The nose behind this fragrance is Jean-Claude Ellena. Top notes are Orange and Grapefruit; middle notes are Pepper, Pelargonium and Flint; base notes are Vetiver, Cedar, Patchouli and Benzoin. This perfume is the winner of award FiFi Award Fragrance Of The Year Men`s Luxe 2007.', '_20240623145246.jpg', 500, 0, 1, 1, '2024-06-23 07:52:46', '2024-06-23 07:52:46', 4),
(118, 5, 'BM33', 'Hugo Energise by Hugo Boss is a Woody Aromatic fragrance for men. Hugo Energise was launched in 2005. The nose behind this fragrance is Claude Dir. Top notes are Pink Pepper, Lemon, Kumquat, Pineapple Leaf, Mint, Mandarin Orange and Cardamom; middle notes are Nutmeg, Jasmine, Juniper, Freesia, Coriander and Clary Sage; base notes are Vanilla, Leather and Teak Wood.', '_20240623161300.jpg', 500, 0, 1, 1, '2024-06-23 09:13:00', '2024-06-23 09:13:00', 4),
(119, 5, 'BM34', 'Michael Kors for Men by Michael Kors is a Amber Woody fragrance for men. Michael Kors for Men was launched in 2014. The nose behind this fragrance is Harry Fremont. Top notes are Star Anise, elemi, Black Pepper, Thyme, Bergamot and Coriander; middle notes are Suede, Incense and Sage; base notes are Patchouli, Sandalwood, Woody Notes and Musk.', '_20240623161915.jpg', 500, 1, 1, 1, '2024-06-23 09:19:15', '2024-06-23 09:25:39', 4),
(120, 5, 'BM35', 'Baccarat Rouge 540 by Maison Francis Kurkdjian is a Amber Floral fragrance for women and men. Baccarat Rouge 540 was launched in 2015. The nose behind this fragrance is Francis Kurkdjian. Top notes are Saffron and Jasmine; middle notes are Amberwood and Ambergris; base notes are Fir Resin and Cedar.', '_20240623162403.jpg', 500, 0, 1, 1, '2024-06-23 09:24:03', '2024-06-23 09:24:03', 4);

-- --------------------------------------------------------

--
-- Table structure for table `promotions`
--

CREATE TABLE `promotions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `discount_percent` decimal(5,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `promotions`
--

INSERT INTO `promotions` (`id`, `name`, `description`, `start_date`, `end_date`, `discount_percent`, `created_at`, `updated_at`) VALUES
(1, 'Promotions A', 'Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content.', '2024-05-23', '2024-05-25', '10.00', '2024-05-13 21:12:06', '2024-05-13 21:13:32');

-- --------------------------------------------------------

--
-- Table structure for table `restocks`
--

CREATE TABLE `restocks` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED DEFAULT NULL,
  `fragrances_id` bigint(20) UNSIGNED DEFAULT NULL,
  `mililiters` double DEFAULT NULL,
  `gram` double DEFAULT NULL,
  `restock_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `restocks`
--

INSERT INTO `restocks` (`id`, `product_id`, `fragrances_id`, `mililiters`, `gram`, `restock_date`) VALUES
(16, 115, 109, 236.8104, 249.8, '2024-06-22 08:37:33');

-- --------------------------------------------------------

--
-- Table structure for table `stock_cards`
--

CREATE TABLE `stock_cards` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED DEFAULT NULL,
  `branch_id` bigint(20) UNSIGNED DEFAULT NULL,
  `fragrance_id` bigint(20) UNSIGNED DEFAULT NULL,
  `opening_stock_gram` double DEFAULT NULL,
  `restock_gram` double DEFAULT NULL,
  `sales_ml` double DEFAULT NULL,
  `calc_g` double DEFAULT NULL,
  `calc_ml` double DEFAULT NULL,
  `real_g` double DEFAULT NULL,
  `real_ml` double DEFAULT NULL,
  `difference_g` double DEFAULT NULL,
  `difference_ml` double DEFAULT NULL,
  `stock_opname_start` date DEFAULT NULL,
  `stock_opname_end` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `stock_cards`
--

INSERT INTO `stock_cards` (`id`, `product_id`, `branch_id`, `fragrance_id`, `opening_stock_gram`, `restock_gram`, `sales_ml`, `calc_g`, `calc_ml`, `real_g`, `real_ml`, `difference_g`, `difference_ml`, `stock_opname_start`, `stock_opname_end`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 2, 0, 233, 227, 227, 240, 217, 228.935, -10.14, -10.7, NULL, NULL, NULL, NULL),
(2, 2, 1, 1, 0, 0, 6, 148, 156, 149, 157.159, 0.688, 0.7258, NULL, NULL, NULL, NULL),
(3, 1, 1, 1, 0, 145, 50, 250.6, 237.5688, 153, 145.044, 0, 0, '2024-05-16', NULL, '2024-05-15 23:21:07', '2024-05-15 23:21:07'),
(13, 2, 2, NULL, 0, 200, 435, -54.9, -51.606, 154, 307.235, 0, 0, '2024-06-10', NULL, '2024-06-09 19:30:24', '2024-06-09 19:30:24'),
(14, 2, 2, NULL, 0, 200, 435, -54.9, -51.606, 154, 451.995, 0, 0, '2024-06-10', NULL, '2024-06-09 19:32:11', '2024-06-09 19:32:11'),
(16, 117, 4, 111, 300, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-06-10', NULL, '2024-06-23 07:52:46', '2024-06-23 07:52:46'),
(17, 118, 4, 112, 300, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-06-23 09:13:00', '2024-06-23 09:13:00'),
(18, 119, 4, 113, 300, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-06-23 09:19:15', '2024-06-23 09:19:15'),
(19, 120, 4, 114, 300, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-06-23 09:24:03', '2024-06-23 09:24:03'),
(20, 119, 4, 113, 300, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-06-23 09:25:39', '2024-06-23 09:25:39');

-- --------------------------------------------------------


--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `transaction_number` varchar(255) DEFAULT '',
  `transaction_date` date DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `customer_id` bigint(20) UNSIGNED DEFAULT NULL,
  `branch_id` bigint(20) UNSIGNED DEFAULT NULL,
  `total_amount` decimal(10,2) DEFAULT NULL,
  `discount` decimal(5,2) DEFAULT NULL,
  `payment_method` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `transactions`
--

INSERT INTO `transactions` (`id`, `transaction_number`, `transaction_date`, `user_id`, `customer_id`, `branch_id`, `total_amount`, `discount`, `payment_method`, `created_at`, `updated_at`) VALUES
(10, 'INV/20240516/585', '2024-05-24', 2, 1, 1, '25000.00', '0.00', '1', '2024-05-15 21:09:22', '2024-05-15 21:09:22'),
(11, 'INV/20240516/585', '2024-05-31', 2, 1, 1, '50000.00', '0.00', '1', '2024-05-15 21:09:22', '2024-05-15 21:09:22'),
(12, 'INV/20240603/899', '2024-06-03', 5, 3, 2, '82500.00', '0.00', NULL, '2024-06-03 02:32:12', '2024-06-03 02:32:12'),
(13, 'INV/20240604/572', '2024-06-04', 5, NULL, 2, NULL, '0.00', NULL, '2024-06-03 21:10:03', '2024-06-03 21:10:03'),
(14, 'INV/20240604/110', '2024-06-04', 5, NULL, 2, NULL, '0.00', NULL, '2024-06-03 21:10:45', '2024-06-03 21:10:45'),
(15, 'INV/20240604/967', '2024-06-04', 5, NULL, 2, NULL, '0.00', NULL, '2024-06-03 21:13:03', '2024-06-03 21:13:03'),
(16, 'INV/20240604/232', '2024-06-04', 5, NULL, 2, NULL, '0.00', NULL, '2024-06-03 21:14:34', '2024-06-03 21:14:34'),
(17, 'INV/20240604/617', '2024-06-04', 4, NULL, 1, NULL, '0.00', NULL, '2024-06-03 21:16:00', '2024-06-03 21:16:00'),
(18, 'INV/20240604/432', '2024-06-04', 4, NULL, 1, NULL, '0.00', NULL, '2024-06-03 21:16:07', '2024-06-03 21:16:07'),
(19, 'INV/20240604/342', '2024-06-04', 5, 3, 2, '15000.00', '0.00', NULL, '2024-06-03 21:16:24', '2024-06-03 21:16:24'),
(20, 'INV/20240604/930', '2024-06-04', 4, 6, 1, '1500.00', '0.00', NULL, '2024-06-03 21:16:53', '2024-06-03 21:16:53'),
(21, 'INV/20240604/677', '2024-06-04', 4, 6, 1, '0.00', '0.00', NULL, '2024-06-03 21:16:58', '2024-06-03 21:16:58'),
(22, 'INV/20240604/702', '2024-06-04', 5, 3, 2, '10000.00', '0.00', NULL, '2024-06-03 21:20:08', '2024-06-03 21:20:08'),
(23, 'INV/20240604/241', '2024-06-04', 5, 3, 2, '25000.00', '0.00', NULL, '2024-06-03 21:22:50', '2024-06-03 21:22:50'),
(24, 'INV/20240604/632', '2024-06-04', 5, 3, 2, '5000.00', '0.00', NULL, '2024-06-03 21:24:50', '2024-06-03 21:24:50'),
(25, 'INV/20240604/593', '2024-06-04', 5, 3, 2, '5000.00', '0.00', NULL, '2024-06-03 21:26:10', '2024-06-03 21:26:10'),
(26, 'INV/20240604/569', '2024-06-04', 5, 3, 2, '5000.00', '0.00', NULL, '2024-06-03 21:27:23', '2024-06-03 21:27:23'),
(27, 'INV/20240604/382', '2024-06-04', 5, 3, 2, '2500.00', '0.00', NULL, '2024-06-03 21:30:17', '2024-06-03 21:30:17'),
(28, 'INV/20240604/88', '2024-06-04', 5, 3, 2, '2500.00', '0.00', NULL, '2024-06-03 21:32:51', '2024-06-03 21:32:51'),
(29, 'INV/20240604/377', '2024-06-04', 5, 3, 2, '500.00', '0.00', NULL, '2024-06-03 21:36:14', '2024-06-03 21:36:14'),
(30, 'INV/20240604/824', '2024-06-04', 5, 3, 2, '500.00', '0.00', NULL, '2024-06-03 21:39:46', '2024-06-03 21:39:46'),
(31, 'INV/20240604/795', '2024-06-04', 5, 3, 2, '500.00', '0.00', NULL, '2024-06-03 21:40:31', '2024-06-03 21:40:31'),
(32, 'INV/20240604/674', '2024-06-04', 5, 3, 2, '500.00', '0.00', NULL, '2024-06-03 21:41:46', '2024-06-03 21:41:46'),
(33, 'INV/20240604/81', '2024-06-04', 5, 3, 2, '500.00', '0.00', NULL, '2024-06-03 21:43:36', '2024-06-03 21:43:36'),
(34, 'INV/20240604/663', '2024-06-04', 4, 6, 1, '2500.00', '0.00', NULL, '2024-06-03 21:46:29', '2024-06-03 21:46:29'),
(35, 'INV/20240604/246', '2024-06-04', 4, 6, 1, '25000.00', '0.00', NULL, '2024-06-03 21:47:58', '2024-06-03 21:47:58'),
(36, 'INV/20240604/724', '2024-06-04', 4, 6, 1, '7500.00', '0.00', NULL, '2024-06-03 21:51:57', '2024-06-03 21:51:57'),
(37, 'INV/20240604/144', '2024-06-04', 5, 3, 2, '500.00', '0.00', NULL, '2024-06-03 21:54:32', '2024-06-03 21:54:32'),
(38, 'INV/20240604/47', '2024-06-04', 4, 6, 1, '2500.00', '0.00', NULL, '2024-06-03 21:55:56', '2024-06-03 21:55:56'),
(39, 'INV/20240604/70', '2024-06-04', 4, 6, 1, '12500.00', '0.00', NULL, '2024-06-03 22:59:44', '2024-06-03 22:59:44'),
(40, 'INV/20240604/657', '2024-06-04', 4, 6, 1, '7500.00', '0.00', NULL, '2024-06-03 23:05:31', '2024-06-03 23:05:31'),
(41, 'INV/20240604/109', '2024-06-04', 4, 6, 1, '5000.00', '0.00', NULL, '2024-06-04 00:13:32', '2024-06-04 00:13:32'),
(42, 'INV/20240605/111', '2024-06-05', 4, 6, 1, '25000.00', '0.00', NULL, '2024-06-04 20:25:26', '2024-06-04 20:25:26'),
(43, 'INV/20240605/490', '2024-06-05', 4, 7, 1, '10000.00', '0.00', NULL, '2024-06-04 22:53:56', '2024-06-04 22:53:56'),
(44, 'INV/20240605/454', '2024-06-05', 4, 6, 1, '25000.00', '0.00', NULL, '2024-06-05 03:59:03', '2024-06-05 03:59:03'),
(46, 'INV/20240605/663', '2024-06-05', 4, 8, 1, '5000.00', '0.00', NULL, '2024-06-05 04:27:09', '2024-06-05 04:27:09'),
(47, 'INV/20240605/630', '2024-06-05', 4, 6, 1, '5000.00', '0.00', NULL, '2024-06-05 07:10:13', '2024-06-05 07:10:13'),
(58, 'INV/20240606/806', '2024-06-06', 4, 6, 1, '95000.00', '0.00', NULL, '2024-06-05 20:04:44', '2024-06-05 20:04:44'),
(59, 'INV/20240606/774', '2024-06-06', 4, 6, 1, '130000.00', '0.00', NULL, '2024-06-05 20:08:44', '2024-06-05 20:08:44'),
(60, 'INV/20240606/962', '2024-06-06', 4, 6, 1, '105000.00', '0.00', NULL, '2024-06-05 22:40:30', '2024-06-05 22:40:30'),
(72, 'INV/20240607/905', '2024-06-07', 2, 1, 1, '0.00', '0.00', NULL, '2024-06-06 23:41:49', '2024-06-06 23:41:49'),
(77, 'INV/20240607/307', '2024-06-07', 2, 1, 1, '0.00', '0.00', NULL, '2024-06-07 00:14:23', '2024-06-07 00:14:23'),
(78, 'INV/20240607/922', '2024-06-07', 2, 1, 1, '0.00', '0.00', NULL, '2024-06-07 00:21:40', '2024-06-07 00:21:40'),
(79, 'INV/20240607/158', '2024-06-07', 2, 1, 1, '0.00', '10.00', NULL, '2024-06-07 00:23:35', '2024-06-07 00:23:35'),
(80, 'INV/20240607/240', '2024-06-07', 4, NULL, 1, NULL, '10.00', NULL, '2024-06-07 00:26:03', '2024-06-07 00:26:03'),
(81, 'INV/20240607/818', '2024-06-07', 2, NULL, 1, '80000.00', '10.00', NULL, '2024-06-07 00:28:36', '2024-06-07 00:28:36'),
(82, 'INV/20240607/510', '2024-06-07', 2, NULL, 1, NULL, '10.00', NULL, '2024-06-07 00:29:23', '2024-06-07 00:29:23'),
(83, 'INV/20240607/229', '2024-06-07', 2, NULL, 1, NULL, '10.00', NULL, '2024-06-07 00:29:35', '2024-06-07 00:29:35'),
(84, 'INV/20240607/361', '2024-06-07', 2, 1, 1, '80000.00', '10.00', NULL, '2024-06-07 00:31:18', '2024-06-07 00:31:18'),
(85, 'INV/20240607/186', '2024-06-07', 4, NULL, 1, NULL, '0.00', NULL, '2024-06-07 00:32:26', '2024-06-07 00:32:26'),
(86, 'INV/20240607/303', '2024-06-07', 4, NULL, 1, NULL, '0.00', NULL, '2024-06-07 00:35:13', '2024-06-07 00:35:13'),
(87, 'INV/20240607/871', '2024-06-07', 2, 1, 1, '80000.00', '10.00', NULL, '2024-06-07 00:41:05', '2024-06-07 00:41:05'),
(88, 'INV/20240607/476', '2024-06-07', 2, 6, 1, '80000.00', '10.00', NULL, '2024-06-07 00:41:23', '2024-06-07 00:41:24'),
(89, 'INV/20240607/393', '2024-06-07', 4, NULL, 1, NULL, '0.00', NULL, '2024-06-07 00:45:48', '2024-06-07 00:45:48'),
(90, 'INV/20240607/603', '2024-06-07', 2, 6, 1, NULL, '0.00', NULL, '2024-06-07 00:47:13', '2024-06-07 00:47:13'),
(91, 'INV/20240607/196', '2024-06-07', 4, NULL, 1, NULL, '10.00', NULL, '2024-06-07 00:47:56', '2024-06-07 00:47:56'),
(92, 'INV/20240607/295', '2024-06-07', 4, NULL, 1, NULL, '10.00', NULL, '2024-06-07 00:48:02', '2024-06-07 00:48:02'),
(93, 'INV/20240607/848', '2024-06-07', 4, NULL, 1, NULL, '0.00', NULL, '2024-06-07 00:50:35', '2024-06-07 00:50:35'),
(94, 'INV/20240607/847', '2024-06-07', 4, NULL, 1, NULL, '0.00', NULL, '2024-06-07 00:51:23', '2024-06-07 00:51:23'),
(95, 'INV/20240607/771', '2024-06-07', 4, 6, 1, NULL, '0.00', NULL, '2024-06-07 00:54:36', '2024-06-07 00:54:36'),
(96, 'INV/20240607/135', '2024-06-07', 4, 6, 1, NULL, '0.00', NULL, '2024-06-07 01:03:27', '2024-06-07 01:03:27'),
(97, 'INV/20240607/126', '2024-06-07', 4, 6, 1, NULL, '0.00', NULL, '2024-06-07 01:14:14', '2024-06-07 01:14:14'),
(98, 'INV/20240607/892', '2024-06-07', 4, 9, 1, NULL, '0.00', NULL, '2024-06-07 16:51:57', '2024-06-07 16:51:57'),
(99, 'INV/20240608/101', '2024-06-08', 4, 6, 1, NULL, '0.00', NULL, '2024-06-08 04:37:34', '2024-06-08 04:37:34'),
(100, 'INV/20240608/833', '2024-06-08', 4, 1, 1, '80000.00', '10.00', NULL, '2024-06-08 04:42:24', '2024-06-08 04:42:24'),
(101, 'INV/20240608/819', '2024-06-08', 4, 6, 1, '250000.00', '0.00', NULL, '2024-06-08 04:47:41', '2024-06-08 04:47:41'),
(102, 'INV/20240608/64', '2024-06-08', 5, 6, 2, '80000.00', '0.00', NULL, '2024-06-08 05:23:48', '2024-06-08 05:23:48'),
(103, 'INV/20240610/644', '2024-06-10', 6, 9, 1, '185000.00', '0.00', NULL, '2024-06-09 18:36:30', '2024-06-09 18:36:30'),
(104, 'INV/20240619/831', '2024-06-19', 4, 6, 1, '40000.00', '0.00', NULL, '2024-06-19 09:54:06', '2024-06-19 09:54:06'),
(105, 'INV/20240619/455', '2024-06-19', 4, 6, 1, '20000.00', '0.00', NULL, '2024-06-19 12:13:42', '2024-06-19 12:13:42'),
(106, 'INV/20240619/674', '2024-06-19', 4, 6, 1, '0.00', '0.00', NULL, '2024-06-19 12:21:11', '2024-06-19 12:21:11'),
(107, 'INV/20240620/844', '2024-06-20', 4, 11, 1, '20000.00', '0.00', NULL, '2024-06-20 00:45:03', '2024-06-20 00:45:03'),
(108, 'INV/20240622/395', '2024-06-22', 7, 11, 4, '75000.00', '0.00', NULL, '2024-06-22 04:09:40', '2024-06-22 04:09:40');

-- --------------------------------------------------------

--
-- Table structure for table `transaction_items`
--

CREATE TABLE `transaction_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `transaction_id` bigint(20) UNSIGNED DEFAULT NULL,
  `product_id` bigint(20) UNSIGNED DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `subtotal` decimal(10,2) DEFAULT NULL,
  `discount_amount` decimal(5,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `transaction_items`
--

INSERT INTO `transaction_items` (`id`, `transaction_id`, `product_id`, `quantity`, `price`, `subtotal`, `discount_amount`, `created_at`, `updated_at`) VALUES
(1, 10, 1, 50, '500.00', '25000.00', NULL, '2024-05-15 21:09:22', '2024-05-15 21:09:22'),
(2, 11, 1, 50, '500.00', '50000.00', NULL, '2024-05-15 21:09:22', '2024-05-15 21:09:22'),
(3, 12, 1, 15, '500.00', '7500.00', NULL, '2024-06-03 02:32:12', '2024-06-03 02:32:12'),
(4, 12, 2, 250, '300.00', '75000.00', NULL, '2024-06-03 02:32:12', '2024-06-03 02:32:12'),
(5, 13, 5, 100, '450.00', '45000.00', NULL, '2024-06-03 21:10:03', '2024-06-03 21:10:03'),
(6, 14, 5, 100, '450.00', '45000.00', NULL, '2024-06-03 21:10:45', '2024-06-03 21:10:45'),
(7, 15, 5, 100, '450.00', '45000.00', NULL, '2024-06-03 21:13:03', '2024-06-03 21:13:03'),
(8, 16, 5, 100, '450.00', '45000.00', NULL, '2024-06-03 21:14:34', '2024-06-03 21:14:34'),
(9, 17, 8, 5, '500.00', '2500.00', NULL, '2024-06-03 21:16:00', '2024-06-03 21:16:00'),
(10, 18, 8, 5, '500.00', '2500.00', NULL, '2024-06-03 21:16:07', '2024-06-03 21:16:07'),
(11, 19, 2, 50, '300.00', '15000.00', NULL, '2024-06-03 21:16:24', '2024-06-03 21:16:24'),
(12, 20, 2, 5, '300.00', '1500.00', NULL, '2024-06-03 21:16:53', '2024-06-03 21:16:53'),
(13, 22, 1, 20, '500.00', '10000.00', NULL, '2024-06-03 21:20:08', '2024-06-03 21:20:08'),
(14, 23, 1, 50, '500.00', '25000.00', NULL, '2024-06-03 21:22:50', '2024-06-03 21:22:50'),
(15, 24, 1, 10, '500.00', '5000.00', NULL, '2024-06-03 21:24:50', '2024-06-03 21:24:50'),
(16, 25, 1, 10, '500.00', '5000.00', NULL, '2024-06-03 21:26:10', '2024-06-03 21:26:10'),
(17, 26, 1, 10, '500.00', '5000.00', NULL, '2024-06-03 21:27:23', '2024-06-03 21:27:23'),
(18, 27, 1, 5, '500.00', '2500.00', NULL, '2024-06-03 21:30:17', '2024-06-03 21:30:17'),
(19, 28, 1, 5, '500.00', '2500.00', NULL, '2024-06-03 21:32:51', '2024-06-03 21:32:51'),
(20, 29, 1, 1, '500.00', '500.00', NULL, '2024-06-03 21:36:14', '2024-06-03 21:36:14'),
(21, 30, 1, 1, '500.00', '500.00', NULL, '2024-06-03 21:39:46', '2024-06-03 21:39:46'),
(22, 31, 1, 1, '500.00', '500.00', NULL, '2024-06-03 21:40:31', '2024-06-03 21:40:31'),
(23, 32, 1, 1, '500.00', '500.00', NULL, '2024-06-03 21:41:46', '2024-06-03 21:41:46'),
(24, 33, 1, 1, '500.00', '500.00', NULL, '2024-06-03 21:43:36', '2024-06-03 21:43:36'),
(25, 34, 1, 5, '500.00', '2500.00', NULL, '2024-06-03 21:46:29', '2024-06-03 21:46:29'),
(26, 35, 1, 50, '500.00', '25000.00', NULL, '2024-06-03 21:47:58', '2024-06-03 21:47:58'),
(27, 36, 1, 15, '500.00', '7500.00', NULL, '2024-06-03 21:51:57', '2024-06-03 21:51:57'),
(28, 37, 1, 1, '500.00', '500.00', NULL, '2024-06-03 21:54:32', '2024-06-03 21:54:32'),
(29, 38, 1, 5, '500.00', '2500.00', NULL, '2024-06-03 21:55:56', '2024-06-03 21:55:56'),
(30, 39, 1, 25, '500.00', '12500.00', NULL, '2024-06-03 22:59:44', '2024-06-03 22:59:44'),
(31, 40, 1, 15, '500.00', '7500.00', NULL, '2024-06-03 23:05:31', '2024-06-03 23:05:31'),
(32, 41, 2, 10, '500.00', '5000.00', NULL, '2024-06-04 00:13:32', '2024-06-04 00:13:32'),
(33, 42, 2, 50, '500.00', '25000.00', NULL, '2024-06-04 20:25:26', '2024-06-04 20:25:26'),
(34, 43, 1, 20, '500.00', '10000.00', NULL, '2024-06-04 22:53:56', '2024-06-04 22:53:56'),
(35, 44, 2, 50, '500.00', '25000.00', NULL, '2024-06-05 03:59:03', '2024-06-05 03:59:03'),
(36, 46, 1, 10, '500.00', '5000.00', NULL, '2024-06-05 04:27:09', '2024-06-05 04:27:09'),
(37, 47, 1, 10, '500.00', '5000.00', NULL, '2024-06-05 07:10:13', '2024-06-05 07:10:13'),
(58, 80, 6, 30, '15000.00', '60000.00', NULL, '2024-06-07 00:26:03', '2024-06-07 00:26:03'),
(59, 85, 6, 30, '15000.00', '60000.00', NULL, '2024-06-07 00:32:26', '2024-06-07 00:32:26'),
(60, 86, 6, 30, '15000.00', '60000.00', NULL, '2024-06-07 00:35:13', '2024-06-07 00:35:13'),
(61, 89, 6, 30, '15000.00', '60000.00', NULL, '2024-06-07 00:45:48', '2024-06-07 00:45:48'),
(62, 91, 6, 30, '15000.00', '60000.00', NULL, '2024-06-07 00:47:56', '2024-06-07 00:47:56'),
(63, 92, 6, 30, '15000.00', '60000.00', NULL, '2024-06-07 00:48:02', '2024-06-07 00:48:02'),
(64, 93, 6, 30, '15000.00', '60000.00', NULL, '2024-06-07 00:50:35', '2024-06-07 00:50:35'),
(65, 94, 6, 30, '15000.00', '60000.00', NULL, '2024-06-07 00:51:23', '2024-06-07 00:51:23'),
(66, 95, 1, 10, '5000.00', '20000.00', NULL, '2024-06-07 00:54:36', '2024-06-07 00:54:36'),
(67, 96, 1, 30, '15000.00', '60000.00', NULL, '2024-06-07 01:03:27', '2024-06-07 01:03:27'),
(68, 97, 1, 50, '25000.00', '125000.00', NULL, '2024-06-07 01:14:14', '2024-06-07 01:14:14'),
(69, 98, 1, 30, '15000.00', '75000.00', NULL, '2024-06-07 16:51:57', '2024-06-07 16:51:57'),
(70, 98, 8, 30, '15000.00', '130000.00', NULL, '2024-06-07 16:51:57', '2024-06-07 16:51:57'),
(71, 99, 1, 32, '16000.00', '210000.00', NULL, '2024-06-08 04:37:34', '2024-06-08 04:37:34'),
(72, 101, 1, 30, '15000.00', '130000.00', NULL, '2024-06-08 04:47:41', '2024-06-08 04:47:41'),
(73, 101, 2, 20, '10000.00', '40000.00', NULL, '2024-06-08 04:47:41', '2024-06-08 04:47:41'),
(74, 101, 8, 32, '16000.00', '80000.00', NULL, '2024-06-08 04:47:41', '2024-06-08 04:47:41'),
(75, 102, 108, 32, '16000.00', '80000.00', NULL, '2024-06-08 05:23:48', '2024-06-08 05:23:48'),
(76, 103, 8, 50, '25000.00', '125000.00', NULL, '2024-06-09 18:36:30', '2024-06-09 18:36:30'),
(77, 103, 1, 32, '16000.00', '60000.00', NULL, '2024-06-09 18:36:30', '2024-06-09 18:36:30'),
(78, 104, 1, 20, '10000.00', '40000.00', NULL, '2024-06-19 09:54:06', '2024-06-19 09:54:06'),
(79, 105, 1, 10, '5000.00', '20000.00', NULL, '2024-06-19 12:13:42', '2024-06-19 12:13:42'),
(80, 107, 1, 10, '5000.00', '20000.00', NULL, '2024-06-20 00:45:03', '2024-06-20 00:45:03'),
(81, 108, 115, 30, '15000.00', '75000.00', NULL, '2024-06-22 04:09:40', '2024-06-22 04:09:40');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `two_factor_secret` text DEFAULT NULL,
  `two_factor_recovery_codes` text DEFAULT NULL,
  `two_factor_confirmed_at` timestamp NULL DEFAULT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `role` enum('admin','user','staff') NOT NULL DEFAULT 'user',
  `branch_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `two_factor_secret`, `two_factor_recovery_codes`, `two_factor_confirmed_at`, `remember_token`, `created_at`, `updated_at`, `role`, `branch_id`) VALUES
(1, 'Admin', 'admin@gmail.com', NULL, '$2y$10$l6cYkyCvWoWTt9pfDx2dcOz7.xn9h5M5VsOZe3qYpt5iI3FKQABzO', NULL, NULL, NULL, NULL, NULL, '2024-05-01 19:14:53', 'admin', NULL),
(2, 'Kamal', 'kamal@gmail.com', NULL, '$2y$12$rbjHlVN9ui7/4v/ooeiA/OCcJENJbS0yeO2MmP.KCg1ZPRUb8GFju', NULL, NULL, NULL, NULL, '2024-05-01 19:15:34', '2024-05-03 20:08:50', 'staff', 1),
(3, 'Bambang', 'bambang@gmail.com', NULL, '$2y$12$ZLjdizp.sUeFPFssWCF.Z.HN94hPurSUTZ8hXMTHNyQMk/D3kae.2', NULL, NULL, NULL, NULL, '2024-05-01 19:19:54', '2024-05-03 19:50:07', 'user', 2),
(4, 'Ica', 'ica@gmail.com', NULL, '$2y$10$l6cYkyCvWoWTt9pfDx2dcOz7.xn9h5M5VsOZe3qYpt5iI3FKQABzO', NULL, NULL, NULL, NULL, NULL, '2024-05-03 20:06:10', 'user', 1),
(5, 'arkan', 'arkan@gmail.com', NULL, '$2y$12$bRlBnGToTemfILOWGbwlC.kwkEnWnqTuZZLI9i7NDwdUdhNgS6g5e', NULL, NULL, NULL, NULL, '2024-06-02 21:16:19', '2024-06-02 21:16:31', 'user', 2),
(6, 'RANI', 'rani@gmail.com', NULL, '$2y$12$8xyw1EjUokrvpwruqEEuQOtRUVR126xPDrEsnjIocs0IA3ac49/VC', NULL, NULL, NULL, NULL, '2024-06-09 10:50:17', '2024-06-09 10:50:17', 'user', 1),
(7, 'Mika', 'mika@gmail.com', NULL, '$2y$12$KWLuEbXg/j78/Km3IkrWseJjAOiI5GunDkZn2073uf324aoIBUcmC', NULL, NULL, NULL, NULL, '2024-06-20 07:35:59', '2024-06-20 07:35:59', 'user', 4);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bottle`
--
ALTER TABLE `bottle`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `branches`
--
ALTER TABLE `branches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `bundles`
--
ALTER TABLE `bundles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `bundle_items`
--
ALTER TABLE `bundle_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `bundle_items_bundle_id_foreign` (`bundle_id`),
  ADD KEY `bundle_items_product_id_foreign` (`product_id`),
  ADD KEY `bundle_items_bottle_id_foreign` (`bottle_id`);

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `current_stock`
--
ALTER TABLE `current_stock`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `fragrances`
--
ALTER TABLE `fragrances`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fragrances_bottle_id_foreign` (`product_id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `other_product`
--
ALTER TABLE `other_product`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `products_category_id_foreign` (`category_id`),
  ADD KEY `products_branch_id_foreign` (`branch_id`);

--
-- Indexes for table `promotions`
--
ALTER TABLE `promotions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `restocks`
--
ALTER TABLE `restocks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fragrances_id` (`fragrances_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `stock_cards`
--
ALTER TABLE `stock_cards`
  ADD PRIMARY KEY (`id`),
  ADD KEY `stock_cards_product_id_foreign` (`product_id`),
  ADD KEY `stock_cards_branch_id_foreign` (`branch_id`),
  ADD KEY `stock_cards_fragrance_id_foreign` (`fragrance_id`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `transactions_user_id_foreign` (`user_id`),
  ADD KEY `transactions_customer_id_foreign` (`customer_id`),
  ADD KEY `transactions_branch_id_foreign` (`branch_id`);

--
-- Indexes for table `transaction_items`
--
ALTER TABLE `transaction_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `transaction_items_transaction_id_foreign` (`transaction_id`),
  ADD KEY `transaction_items_product_id_foreign` (`product_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD KEY `users_branch_id_foreign` (`branch_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bottle`
--
ALTER TABLE `bottle`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `branches`
--
ALTER TABLE `branches`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `bundles`
--
ALTER TABLE `bundles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `bundle_items`
--
ALTER TABLE `bundle_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=129;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `current_stock`
--
ALTER TABLE `current_stock`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;


--
-- AUTO_INCREMENT for table `fragrances`
--
ALTER TABLE `fragrances`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=115;


--
-- AUTO_INCREMENT for table `other_product`
--
ALTER TABLE `other_product`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=121;

--
-- AUTO_INCREMENT for table `promotions`
--
ALTER TABLE `promotions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `restocks`
--
ALTER TABLE `restocks`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `stock_cards`
--
ALTER TABLE `stock_cards`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=109;

--
-- AUTO_INCREMENT for table `transaction_items`
--
ALTER TABLE `transaction_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=82;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bundle_items`
--
ALTER TABLE `bundle_items`
  ADD CONSTRAINT `bundle_items_bottle_id_foreign` FOREIGN KEY (`bottle_id`) REFERENCES `bottle` (`id`),
  ADD CONSTRAINT `bundle_items_bundle_id_foreign` FOREIGN KEY (`bundle_id`) REFERENCES `bundles` (`id`),
  ADD CONSTRAINT `bundle_items_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

--
-- Constraints for table `fragrances`
--
ALTER TABLE `fragrances`
  ADD CONSTRAINT `fragrances_bottle_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`),
  ADD CONSTRAINT `products_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`);

--
-- Constraints for table `restocks`
--
ALTER TABLE `restocks`
  ADD CONSTRAINT `restocks_ibfk_1` FOREIGN KEY (`fragrances_id`) REFERENCES `fragrances` (`id`),
  ADD CONSTRAINT `restocks_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

--
-- Constraints for table `stock_cards`
--
ALTER TABLE `stock_cards`
  ADD CONSTRAINT `stock_cards_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`),
  ADD CONSTRAINT `stock_cards_fragrance_id_foreign` FOREIGN KEY (`fragrance_id`) REFERENCES `fragrances` (`id`),
  ADD CONSTRAINT `stock_cards_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

--
-- Constraints for table `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `transactions_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`),
  ADD CONSTRAINT `transactions_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`),
  ADD CONSTRAINT `transactions_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `transaction_items`
--
ALTER TABLE `transaction_items`
  ADD CONSTRAINT `transaction_items_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  ADD CONSTRAINT `transaction_items_transaction_id_foreign` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`id`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
