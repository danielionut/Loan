-- phpMyAdmin SQL Dump
-- version 4.7.7
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jul 05, 2018 at 08:51 PM
-- Server version: 10.1.34-MariaDB
-- PHP Version: 5.6.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ep978_loan`
--

-- --------------------------------------------------------

--
-- Table structure for table `activations`
--

CREATE TABLE `activations` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `completed` tinyint(1) NOT NULL DEFAULT '0',
  `completed_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `activations`
--

INSERT INTO `activations` (`id`, `user_id`, `code`, `completed`, `completed_at`, `created_at`, `updated_at`) VALUES
(1, 1, 'mtqVeTfxae04N0o2Y5ttSeWnqR1qICy5', 1, '2018-06-28 09:08:08', '2018-06-28 09:08:08', '2018-06-28 09:08:08'),
(2, 2, 'FtginMKjXHyWaVO10i4vXWjDK6vj4pPd', 1, '2018-07-04 11:43:32', '2018-07-04 11:43:32', '2018-07-04 11:43:32'),
(3, 3, 'EFQHcgUbEa5D07qKO6nboahUI20lEjzs', 1, '2018-07-05 08:17:48', '2018-07-05 08:17:48', '2018-07-05 08:17:48');

-- --------------------------------------------------------

--
-- Table structure for table `assets`
--

CREATE TABLE `assets` (
  `id` int(10) UNSIGNED NOT NULL,
  `created_by_id` int(11) DEFAULT NULL,
  `asset_type_id` int(11) DEFAULT NULL,
  `office_id` int(11) DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `purchase_date` date DEFAULT NULL,
  `purchase_price` decimal(65,2) DEFAULT NULL,
  `value` decimal(65,2) DEFAULT NULL,
  `life_span` int(11) DEFAULT NULL,
  `salvage_value` decimal(65,2) DEFAULT NULL,
  `serial_number` text COLLATE utf8mb4_unicode_ci,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `files` text COLLATE utf8mb4_unicode_ci,
  `purchase_year` text COLLATE utf8mb4_unicode_ci,
  `status` enum('active','inactive','sold','damaged','written_off') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active` tinyint(4) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `asset_depreciation`
--

CREATE TABLE `asset_depreciation` (
  `id` int(10) UNSIGNED NOT NULL,
  `asset_id` int(11) DEFAULT NULL,
  `year` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `beginning_value` decimal(65,2) DEFAULT NULL,
  `depreciation_value` decimal(65,2) DEFAULT NULL,
  `rate` decimal(65,2) DEFAULT NULL,
  `cost` decimal(65,2) DEFAULT NULL,
  `accumulated` decimal(65,2) DEFAULT NULL,
  `ending_value` decimal(65,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `asset_types`
--

CREATE TABLE `asset_types` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gl_account_fixed_asset_id` int(11) DEFAULT NULL,
  `gl_account_asset_id` int(11) DEFAULT NULL,
  `gl_account_contra_asset_id` int(11) DEFAULT NULL,
  `gl_account_expense_id` int(11) DEFAULT NULL,
  `gl_account_liability_id` int(11) DEFAULT NULL,
  `gl_account_income_id` int(11) DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `audit_trail`
--

CREATE TABLE `audit_trail` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `office_id` int(11) DEFAULT NULL,
  `module` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `action` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `audit_trail`
--

INSERT INTO `audit_trail` (`id`, `user_id`, `name`, `office_id`, `module`, `action`, `notes`, `created_at`, `updated_at`) VALUES
(1, 1, 'Admin Admin', NULL, 'Clients', 'Create', '1', '2018-06-28 11:10:34', '2018-06-28 11:10:34'),
(2, 1, 'Admin Admin', NULL, 'Loan Product', 'Create', '1', '2018-07-01 08:43:17', '2018-07-01 08:43:17'),
(3, 1, 'Admin Admin', NULL, 'Clients', 'Create', '2', '2018-07-01 08:44:16', '2018-07-01 08:44:16'),
(4, 1, 'Admin Admin', NULL, 'Clients', 'Approve', '2', '2018-07-01 08:44:21', '2018-07-01 08:44:21'),
(5, 1, 'Admin Admin', NULL, 'Custom Fields', 'Create', '1', '2018-07-02 08:00:32', '2018-07-02 08:00:32'),
(6, 1, 'Admin Admin', NULL, 'Loan Product', 'Delete', '1', '2018-07-04 05:16:34', '2018-07-04 05:16:34'),
(7, 1, 'Admin Admin', NULL, 'Loan Product', 'Create', '2', '2018-07-04 05:17:19', '2018-07-04 05:17:19'),
(8, 1, 'Admin Admin', NULL, 'Loan Product', 'Create', '3', '2018-07-04 05:18:46', '2018-07-04 05:18:46'),
(9, 1, 'Admin Admin', NULL, 'Loan Product', 'Create', '4', '2018-07-04 05:19:17', '2018-07-04 05:19:17'),
(10, 1, 'Admin Admin', NULL, 'Users', 'Update', '1', '2018-07-04 05:20:28', '2018-07-04 05:20:28'),
(11, 1, 'Admin Admin', NULL, 'Branches', 'Update', '1', '2018-07-04 05:21:55', '2018-07-04 05:21:55'),
(12, 1, 'Admin Admin', NULL, 'Branches', 'Create', '2', '2018-07-04 05:22:08', '2018-07-04 05:22:08'),
(13, 1, 'Admin Admin', NULL, 'Users', 'Update Role', '1', '2018-07-04 05:57:56', '2018-07-04 05:57:56'),
(14, 1, 'Admin Admin', NULL, 'Users', 'Update Role', '1', '2018-07-04 05:58:55', '2018-07-04 05:58:55'),
(15, 1, 'Admin Admin', NULL, 'Users', 'Update Role', '1', '2018-07-04 05:59:47', '2018-07-04 05:59:47'),
(16, 1, 'Admin Admin', NULL, 'Users', 'Update Role', '1', '2018-07-04 06:00:44', '2018-07-04 06:00:44'),
(17, 1, 'Admin Admin', NULL, 'Grants', 'Create', '1', '2018-07-04 06:01:17', '2018-07-04 06:01:17'),
(18, 1, 'Admin Admin', NULL, 'Grants', 'Approve', '1', '2018-07-04 06:01:34', '2018-07-04 06:01:34'),
(19, 1, 'Admin Admin', NULL, 'Users', 'Create', '2', '2018-07-04 11:43:32', '2018-07-04 11:43:32'),
(20, 1, 'Admin Admin', NULL, 'Grants', 'Create', '2', '2018-07-04 13:01:06', '2018-07-04 13:01:06'),
(21, 1, 'Admin Admin', NULL, 'Grants', 'Create Document', '1', '2018-07-04 13:12:12', '2018-07-04 13:12:12'),
(22, 1, 'Admin Admin', NULL, 'Custom Fields', 'Create', '2', '2018-07-04 13:19:27', '2018-07-04 13:19:27'),
(23, 1, 'Admin Admin', NULL, 'Users', 'Update', '2', '2018-07-04 13:25:25', '2018-07-04 13:25:25'),
(24, 1, 'Admin Admin', NULL, 'Branches', 'Delete', '2', '2018-07-05 07:41:32', '2018-07-05 07:41:32'),
(25, 1, 'Admin Admin', NULL, 'Branches', 'Update', '1', '2018-07-05 07:42:31', '2018-07-05 07:42:31'),
(26, 1, 'Admin Admin', NULL, 'Clients', 'Delete', '2', '2018-07-05 07:43:07', '2018-07-05 07:43:07'),
(27, 1, 'Admin Admin', NULL, 'Clients', 'Delete', '1', '2018-07-05 07:43:25', '2018-07-05 07:43:25'),
(28, 1, 'Admin Admin', NULL, 'Grants', 'Delete', '2', '2018-07-05 07:53:23', '2018-07-05 07:53:23'),
(29, 1, 'Admin Admin', NULL, 'Grants', 'Unapprove', '1', '2018-07-05 07:53:51', '2018-07-05 07:53:51'),
(30, 1, 'Admin Admin', NULL, 'Grants', 'Decline', '1', '2018-07-05 07:54:06', '2018-07-05 07:54:06'),
(31, 1, 'Admin Admin', NULL, 'Grants', 'Delete', '1', '2018-07-05 07:54:12', '2018-07-05 07:54:12'),
(32, 1, 'Admin Admin', NULL, 'Clients', 'Create', '3', '2018-07-05 08:04:38', '2018-07-05 08:04:38'),
(33, 1, 'Admin Admin', NULL, 'Clients', 'Approve', '3', '2018-07-05 08:04:55', '2018-07-05 08:04:55'),
(34, 1, 'Admin Admin', NULL, 'Users', 'Create', '3', '2018-07-05 08:17:48', '2018-07-05 08:17:48'),
(35, 1, 'Admin Admin', NULL, 'Grants', 'Create', '3', '2018-07-05 08:19:46', '2018-07-05 08:19:46'),
(36, 1, 'Admin Admin', NULL, 'Grants', 'Update', '3', '2018-07-05 08:20:15', '2018-07-05 08:20:15'),
(37, 1, 'Admin Admin', NULL, 'Grants', 'Create Document', '3', '2018-07-05 08:21:53', '2018-07-05 08:21:53'),
(38, 1, 'Admin Admin', NULL, 'Grants', 'Create Document', '3', '2018-07-05 08:22:14', '2018-07-05 08:22:14'),
(39, 1, 'Admin Admin', NULL, 'Grants', 'Delete Document', '3', '2018-07-05 08:22:26', '2018-07-05 08:22:26'),
(40, 1, 'Admin Admin', NULL, 'Grants', 'Delete Document', '2', '2018-07-05 08:22:33', '2018-07-05 08:22:33'),
(41, 1, 'Admin Admin', NULL, 'Grants', 'Create Document', '3', '2018-07-05 08:24:44', '2018-07-05 08:24:44'),
(42, 1, 'Admin Admin', NULL, 'Grants', 'Create Document', '3', '2018-07-05 08:26:05', '2018-07-05 08:26:05'),
(43, 1, 'Admin Admin', NULL, 'Grants', 'Create Document', '3', '2018-07-05 08:29:02', '2018-07-05 08:29:02'),
(44, 1, 'Admin Admin', NULL, 'Grants', 'Create Document', '3', '2018-07-05 08:29:35', '2018-07-05 08:29:35'),
(45, 1, 'Admin Admin', NULL, 'Grants', 'Update', '3', '2018-07-05 08:30:01', '2018-07-05 08:30:01'),
(46, 1, 'Admin Admin', NULL, 'Grants', 'Approve', '3', '2018-07-05 08:30:10', '2018-07-05 08:30:10'),
(47, 1, 'Admin Admin', NULL, 'Custom Fields', 'Create', '3', '2018-07-05 08:33:22', '2018-07-05 08:33:22'),
(48, 1, 'Admin Admin', NULL, 'Custom Fields', 'Create', '4', '2018-07-05 08:38:05', '2018-07-05 08:38:05'),
(49, 1, 'Admin Admin', NULL, 'Custom Fields', 'Create', '5', '2018-07-05 08:40:15', '2018-07-05 08:40:15'),
(50, 1, 'Admin Admin', NULL, 'Custom Fields', 'Create', '6', '2018-07-05 08:43:33', '2018-07-05 08:43:33'),
(51, 1, 'Capidava Financial Admin', NULL, 'Users', 'Update Role', '1', '2018-07-05 12:36:42', '2018-07-05 12:36:42');

-- --------------------------------------------------------

--
-- Table structure for table `charges`
--

CREATE TABLE `charges` (
  `id` int(10) UNSIGNED NOT NULL,
  `created_by_id` int(11) DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `currency_id` int(11) DEFAULT NULL,
  `product` enum('loan','savings','shares','client') COLLATE utf8mb4_unicode_ci NOT NULL,
  `charge_type` enum('disbursement','disbursement_repayment','specified_due_date','installment_fee','overdue_installment_fee','loan_rescheduling_fee','overdue_maturity','savings_activation','withdrawal_fee','annual_fee','monthly_fee','activation','shares_purchase','shares_redeem') COLLATE utf8mb4_unicode_ci NOT NULL,
  `charge_option` enum('flat','percentage','installment_principal_due','installment_principal_interest_due','installment_interest_due','installment_total_due','total_due','principal_due','interest_due','total_outstanding','original_principal') COLLATE utf8mb4_unicode_ci NOT NULL,
  `charge_frequency` tinyint(4) NOT NULL DEFAULT '0',
  `charge_frequency_type` enum('days','weeks','months','years') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'days',
  `charge_frequency_amount` int(11) NOT NULL DEFAULT '0',
  `amount` decimal(65,2) DEFAULT NULL,
  `minimum_amount` decimal(65,2) DEFAULT NULL,
  `maximum_amount` decimal(65,2) DEFAULT NULL,
  `charge_payment_mode` enum('regular','account_transfer') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'regular',
  `active` tinyint(4) NOT NULL DEFAULT '1',
  `penalty` tinyint(4) NOT NULL DEFAULT '0',
  `override` tinyint(4) NOT NULL DEFAULT '0',
  `gl_account_income_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `clients`
--

CREATE TABLE `clients` (
  `id` int(10) UNSIGNED NOT NULL,
  `country_id` int(11) DEFAULT NULL,
  `office_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `staff_id` int(11) DEFAULT NULL,
  `referred_by_id` int(11) DEFAULT NULL,
  `account_no` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `external_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `first_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `middle_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `full_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `incorporation_number` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `display_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `picture` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mobile` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gender` enum('male','female','other','unspecified') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `client_type` enum('individual','business','ngo','other') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('pending','active','inactive','declined','closed') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `marital_status` enum('married','single','divorced','widowed','unspecified') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `street` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ward` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `district` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `region` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `joined_date` date DEFAULT NULL,
  `activated_date` date DEFAULT NULL,
  `reactivated_date` date DEFAULT NULL,
  `declined_date` date DEFAULT NULL,
  `declined_reason` text COLLATE utf8mb4_unicode_ci,
  `closed_reason` text COLLATE utf8mb4_unicode_ci,
  `closed_date` date DEFAULT NULL,
  `created_by_id` int(11) DEFAULT NULL,
  `inactive_reason` text COLLATE utf8mb4_unicode_ci,
  `inactive_date` date DEFAULT NULL,
  `inactive_by_id` int(11) DEFAULT NULL,
  `activated_by_id` int(11) DEFAULT NULL,
  `reactivated_by_id` int(11) DEFAULT NULL,
  `declined_by_id` int(11) DEFAULT NULL,
  `closed_by_id` int(11) DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `clients`
--

INSERT INTO `clients` (`id`, `country_id`, `office_id`, `user_id`, `staff_id`, `referred_by_id`, `account_no`, `external_id`, `title`, `first_name`, `middle_name`, `last_name`, `full_name`, `incorporation_number`, `display_name`, `picture`, `mobile`, `phone`, `email`, `gender`, `client_type`, `status`, `marital_status`, `dob`, `street`, `ward`, `district`, `region`, `address`, `joined_date`, `activated_date`, `reactivated_date`, `declined_date`, `declined_reason`, `closed_reason`, `closed_date`, `created_by_id`, `inactive_reason`, `inactive_date`, `inactive_by_id`, `activated_by_id`, `reactivated_by_id`, `declined_by_id`, `closed_by_id`, `notes`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, NULL, 1, NULL, 1, NULL, '-1', NULL, NULL, 'Daniel', 'danuiel', 'Cojocaru', NULL, NULL, NULL, NULL, '757273779', NULL, NULL, 'female', 'individual', 'pending', 'single', '2018-06-20', '1 Mai 26 sc 1 ap 23 et 1 bloc 6s14', NULL, NULL, NULL, '1 Mai 26 sc 1 ap 23 et 1 bloc 6s14', '2018-06-28', NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2018-06-28 11:10:34', '2018-07-05 07:43:25', '2018-07-05 07:43:25'),
(2, NULL, 1, NULL, 1, NULL, '-2', NULL, NULL, 'test', 'test', 'test', NULL, NULL, NULL, NULL, '0753421528', NULL, NULL, 'male', 'individual', 'active', 'divorced', '1992-11-25', NULL, NULL, NULL, NULL, NULL, '2018-07-01', '2018-07-01', NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, '2018-07-01 08:44:16', '2018-07-05 07:43:07', '2018-07-05 07:43:07'),
(3, NULL, 1, NULL, 1, NULL, '1-3', NULL, NULL, NULL, NULL, NULL, 'NettStrade JK Solution SRL', '28343553', NULL, NULL, '+40', NULL, NULL, NULL, 'business', 'active', NULL, NULL, 'Aleea Rozilor Nr.15 , Bl. FB.23', NULL, NULL, NULL, 'Mun. Slatina, Jud. Olt', '2018-07-05', '2018-07-05', NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, 1, NULL, NULL, NULL, 'Atentie, evita predarea contragarantiilor, cauta metode de sustragere de la semnarea documentelor', '2018-07-05 08:04:38', '2018-07-05 08:04:55', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `client_identifications`
--

CREATE TABLE `client_identifications` (
  `id` int(10) UNSIGNED NOT NULL,
  `client_id` int(11) DEFAULT NULL,
  `client_identification_type_id` int(11) DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  `notes` text COLLATE utf8mb4_unicode_ci,
  `attachment` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `client_identification_types`
--

CREATE TABLE `client_identification_types` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `client_next_of_kin`
--

CREATE TABLE `client_next_of_kin` (
  `id` int(10) UNSIGNED NOT NULL,
  `client_id` int(11) DEFAULT NULL,
  `client_relationship_id` int(11) DEFAULT NULL,
  `qualification` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `first_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `middle_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ward` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `street` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `district` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `region` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `picture` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mobile` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gender` enum('male','female','other','unspecified') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `client_profession`
--

CREATE TABLE `client_profession` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `client_relationships`
--

CREATE TABLE `client_relationships` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `client_users`
--

CREATE TABLE `client_users` (
  `id` int(10) UNSIGNED NOT NULL,
  `created_by_id` int(11) DEFAULT NULL,
  `client_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `collateral`
--

CREATE TABLE `collateral` (
  `id` int(10) UNSIGNED NOT NULL,
  `loan_id` int(11) DEFAULT NULL,
  `client_id` int(11) DEFAULT NULL,
  `collateral_type_id` int(11) DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `serial` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` decimal(65,4) DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `picture` text COLLATE utf8mb4_unicode_ci,
  `gallery` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `collateral_types`
--

CREATE TABLE `collateral_types` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `collateral_types`
--

INSERT INTO `collateral_types` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'CEC', '2018-07-01 08:41:45', '2018-07-05 07:49:42'),
(2, 'Bilet la Ordin', '2018-07-03 05:38:21', '2018-07-05 07:49:30'),
(3, 'Bilet la Ordin Avalizat', '2018-07-05 07:49:55', '2018-07-05 07:49:55'),
(4, 'Contract de Fideiusiune', '2018-07-05 07:50:11', '2018-07-05 07:50:11'),
(5, 'Garantie Paternala', '2018-07-05 07:50:29', '2018-07-05 07:50:29');

-- --------------------------------------------------------

--
-- Table structure for table `communication_campaigns`
--

CREATE TABLE `communication_campaigns` (
  `id` int(10) UNSIGNED NOT NULL,
  `created_by_id` int(11) DEFAULT NULL,
  `type` enum('sms','email') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` text COLLATE utf8mb4_unicode_ci,
  `description` text COLLATE utf8mb4_unicode_ci,
  `report_start_date` date DEFAULT NULL,
  `report_start_time` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `recurrence_type` enum('none','schedule') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `recur_frequency` enum('days','months','weeks','years') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `recur_interval` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_recipients` text COLLATE utf8mb4_unicode_ci,
  `email_subject` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `message` text COLLATE utf8mb4_unicode_ci,
  `email_attachment_file_format` enum('pdf','csv','xls') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `recipients_category` enum('all_clients','active_clients','prospective_clients','active_loans','loans_in_arrears','overdue_loans','happy_birthday') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `report_attachment` enum('loan_schedule','loan_statement','savings_statement','audit_report','group_indicator_report') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `from_day` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `to_day` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `office_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `loan_officer_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gl_account_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `manual_entries` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `loan_status` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `loan_product_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_run_date` date DEFAULT NULL,
  `next_run_date` date DEFAULT NULL,
  `last_run_time` date DEFAULT NULL,
  `next_run_time` date DEFAULT NULL,
  `number_of_runs` int(11) NOT NULL DEFAULT '0',
  `number_of_recipients` int(11) NOT NULL DEFAULT '0',
  `active` tinyint(4) NOT NULL DEFAULT '1',
  `sent` tinyint(4) NOT NULL DEFAULT '0',
  `status` enum('pending','active','declined','inactive') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `approved_by_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `countries`
--

CREATE TABLE `countries` (
  `id` int(10) UNSIGNED NOT NULL,
  `sortname` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `countries`
--

INSERT INTO `countries` (`id`, `sortname`, `name`) VALUES
(1, 'AF', 'Afghanistan'),
(2, 'AL', 'Albania'),
(3, 'DZ', 'Algeria'),
(4, 'AS', 'American Samoa'),
(5, 'AD', 'Andorra'),
(6, 'AO', 'Angola'),
(7, 'AI', 'Anguilla'),
(8, 'AQ', 'Antarctica'),
(9, 'AG', 'Antigua And Barbuda'),
(10, 'AR', 'Argentina'),
(11, 'AM', 'Armenia'),
(12, 'AW', 'Aruba'),
(13, 'AU', 'Australia'),
(14, 'AT', 'Austria'),
(15, 'AZ', 'Azerbaijan'),
(16, 'BS', 'Bahamas The'),
(17, 'BH', 'Bahrain'),
(18, 'BD', 'Bangladesh'),
(19, 'BB', 'Barbados'),
(20, 'BY', 'Belarus'),
(21, 'BE', 'Belgium'),
(22, 'BZ', 'Belize'),
(23, 'BJ', 'Benin'),
(24, 'BM', 'Bermuda'),
(25, 'BT', 'Bhutan'),
(26, 'BO', 'Bolivia'),
(27, 'BA', 'Bosnia and Herzegovina'),
(28, 'BW', 'Botswana'),
(29, 'BV', 'Bouvet Island'),
(30, 'BR', 'Brazil'),
(31, 'IO', 'British Indian Ocean Territory'),
(32, 'BN', 'Brunei'),
(33, 'BG', 'Bulgaria'),
(34, 'BF', 'Burkina Faso'),
(35, 'BI', 'Burundi'),
(36, 'KH', 'Cambodia'),
(37, 'CM', 'Cameroon'),
(38, 'CA', 'Canada'),
(39, 'CV', 'Cape Verde'),
(40, 'KY', 'Cayman Islands'),
(41, 'CF', 'Central African Republic'),
(42, 'TD', 'Chad'),
(43, 'CL', 'Chile'),
(44, 'CN', 'China'),
(45, 'CX', 'Christmas Island'),
(46, 'CC', 'Cocos (Keeling) Islands'),
(47, 'CO', 'Colombia'),
(48, 'KM', 'Comoros'),
(49, 'CG', 'Congo'),
(50, 'CD', 'Congo The Democratic Republic Of The'),
(51, 'CK', 'Cook Islands'),
(52, 'CR', 'Costa Rica'),
(53, 'CI', 'Cote D\'Ivoire (Ivory Coast)'),
(54, 'HR', 'Croatia (Hrvatska)'),
(55, 'CU', 'Cuba'),
(56, 'CY', 'Cyprus'),
(57, 'CZ', 'Czech Republic'),
(58, 'DK', 'Denmark'),
(59, 'DJ', 'Djibouti'),
(60, 'DM', 'Dominica'),
(61, 'DO', 'Dominican Republic'),
(62, 'TP', 'East Timor'),
(63, 'EC', 'Ecuador'),
(64, 'EG', 'Egypt'),
(65, 'SV', 'El Salvador'),
(66, 'GQ', 'Equatorial Guinea'),
(67, 'ER', 'Eritrea'),
(68, 'EE', 'Estonia'),
(69, 'ET', 'Ethiopia'),
(70, 'XA', 'External Territories of Australia'),
(71, 'FK', 'Falkland Islands'),
(72, 'FO', 'Faroe Islands'),
(73, 'FJ', 'Fiji Islands'),
(74, 'FI', 'Finland'),
(75, 'FR', 'France'),
(76, 'GF', 'French Guiana'),
(77, 'PF', 'French Polynesia'),
(78, 'TF', 'French Southern Territories'),
(79, 'GA', 'Gabon'),
(80, 'GM', 'Gambia The'),
(81, 'GE', 'Georgia'),
(82, 'DE', 'Germany'),
(83, 'GH', 'Ghana'),
(84, 'GI', 'Gibraltar'),
(85, 'GR', 'Greece'),
(86, 'GL', 'Greenland'),
(87, 'GD', 'Grenada'),
(88, 'GP', 'Guadeloupe'),
(89, 'GU', 'Guam'),
(90, 'GT', 'Guatemala'),
(91, 'XU', 'Guernsey and Alderney'),
(92, 'GN', 'Guinea'),
(93, 'GW', 'Guinea-Bissau'),
(94, 'GY', 'Guyana'),
(95, 'HT', 'Haiti'),
(96, 'HM', 'Heard and McDonald Islands'),
(97, 'HN', 'Honduras'),
(98, 'HK', 'Hong Kong S.A.R.'),
(99, 'HU', 'Hungary'),
(100, 'IS', 'Iceland'),
(101, 'IN', 'India'),
(102, 'ID', 'Indonesia'),
(103, 'IR', 'Iran'),
(104, 'IQ', 'Iraq'),
(105, 'IE', 'Ireland'),
(106, 'IL', 'Israel'),
(107, 'IT', 'Italy'),
(108, 'JM', 'Jamaica'),
(109, 'JP', 'Japan'),
(110, 'XJ', 'Jersey'),
(111, 'JO', 'Jordan'),
(112, 'KZ', 'Kazakhstan'),
(113, 'KE', 'Kenya'),
(114, 'KI', 'Kiribati'),
(115, 'KP', 'Korea North'),
(116, 'KR', 'Korea South'),
(117, 'KW', 'Kuwait'),
(118, 'KG', 'Kyrgyzstan'),
(119, 'LA', 'Laos'),
(120, 'LV', 'Latvia'),
(121, 'LB', 'Lebanon'),
(122, 'LS', 'Lesotho'),
(123, 'LR', 'Liberia'),
(124, 'LY', 'Libya'),
(125, 'LI', 'Liechtenstein'),
(126, 'LT', 'Lithuania'),
(127, 'LU', 'Luxembourg'),
(128, 'MO', 'Macau S.A.R.'),
(129, 'MK', 'Macedonia'),
(130, 'MG', 'Madagascar'),
(131, 'MW', 'Malawi'),
(132, 'MY', 'Malaysia'),
(133, 'MV', 'Maldives'),
(134, 'ML', 'Mali'),
(135, 'MT', 'Malta'),
(136, 'XM', 'Man (Isle of)'),
(137, 'MH', 'Marshall Islands'),
(138, 'MQ', 'Martinique'),
(139, 'MR', 'Mauritania'),
(140, 'MU', 'Mauritius'),
(141, 'YT', 'Mayotte'),
(142, 'MX', 'Mexico'),
(143, 'FM', 'Micronesia'),
(144, 'MD', 'Moldova'),
(145, 'MC', 'Monaco'),
(146, 'MN', 'Mongolia'),
(147, 'MS', 'Montserrat'),
(148, 'MA', 'Morocco'),
(149, 'MZ', 'Mozambique'),
(150, 'MM', 'Myanmar'),
(151, 'NA', 'Namibia'),
(152, 'NR', 'Nauru'),
(153, 'NP', 'Nepal'),
(154, 'AN', 'Netherlands Antilles'),
(155, 'NL', 'Netherlands The'),
(156, 'NC', 'New Caledonia'),
(157, 'NZ', 'New Zealand'),
(158, 'NI', 'Nicaragua'),
(159, 'NE', 'Niger'),
(160, 'NG', 'Nigeria'),
(161, 'NU', 'Niue'),
(162, 'NF', 'Norfolk Island'),
(163, 'MP', 'Northern Mariana Islands'),
(164, 'NO', 'Norway'),
(165, 'OM', 'Oman'),
(166, 'PK', 'Pakistan'),
(167, 'PW', 'Palau'),
(168, 'PS', 'Palestinian Territory Occupied'),
(169, 'PA', 'Panama'),
(170, 'PG', 'Papua new Guinea'),
(171, 'PY', 'Paraguay'),
(172, 'PE', 'Peru'),
(173, 'PH', 'Philippines'),
(174, 'PN', 'Pitcairn Island'),
(175, 'PL', 'Poland'),
(176, 'PT', 'Portugal'),
(177, 'PR', 'Puerto Rico'),
(178, 'QA', 'Qatar'),
(179, 'RE', 'Reunion'),
(180, 'RO', 'Romania'),
(181, 'RU', 'Russia'),
(182, 'RW', 'Rwanda'),
(183, 'SH', 'Saint Helena'),
(184, 'KN', 'Saint Kitts And Nevis'),
(185, 'LC', 'Saint Lucia'),
(186, 'PM', 'Saint Pierre and Miquelon'),
(187, 'VC', 'Saint Vincent And The Grenadines'),
(188, 'WS', 'Samoa'),
(189, 'SM', 'San Marino'),
(190, 'ST', 'Sao Tome and Principe'),
(191, 'SA', 'Saudi Arabia'),
(192, 'SN', 'Senegal'),
(193, 'RS', 'Serbia'),
(194, 'SC', 'Seychelles'),
(195, 'SL', 'Sierra Leone'),
(196, 'SG', 'Singapore'),
(197, 'SK', 'Slovakia'),
(198, 'SI', 'Slovenia'),
(199, 'XG', 'Smaller Territories of the UK'),
(200, 'SB', 'Solomon Islands'),
(201, 'SO', 'Somalia'),
(202, 'ZA', 'South Africa'),
(203, 'GS', 'South Georgia'),
(204, 'SS', 'South Sudan'),
(205, 'ES', 'Spain'),
(206, 'LK', 'Sri Lanka'),
(207, 'SD', 'Sudan'),
(208, 'SR', 'Suriname'),
(209, 'SJ', 'Svalbard And Jan Mayen Islands'),
(210, 'SZ', 'Swaziland'),
(211, 'SE', 'Sweden'),
(212, 'CH', 'Switzerland'),
(213, 'SY', 'Syria'),
(214, 'TW', 'Taiwan'),
(215, 'TJ', 'Tajikistan'),
(216, 'TZ', 'Tanzania'),
(217, 'TH', 'Thailand'),
(218, 'TG', 'Togo'),
(219, 'TK', 'Tokelau'),
(220, 'TO', 'Tonga'),
(221, 'TT', 'Trinidad And Tobago'),
(222, 'TN', 'Tunisia'),
(223, 'TR', 'Turkey'),
(224, 'TM', 'Turkmenistan'),
(225, 'TC', 'Turks And Caicos Islands'),
(226, 'TV', 'Tuvalu'),
(227, 'UG', 'Uganda'),
(228, 'UA', 'Ukraine'),
(229, 'AE', 'United Arab Emirates'),
(230, 'GB', 'United Kingdom'),
(231, 'US', 'United States'),
(232, 'UM', 'United States Minor Outlying Islands'),
(233, 'UY', 'Uruguay'),
(234, 'UZ', 'Uzbekistan'),
(235, 'VU', 'Vanuatu'),
(236, 'VA', 'Vatican City State (Holy See)'),
(237, 'VE', 'Venezuela'),
(238, 'VN', 'Vietnam'),
(239, 'VG', 'Virgin Islands (British)'),
(240, 'VI', 'Virgin Islands (US)'),
(241, 'WF', 'Wallis And Futuna Islands'),
(242, 'EH', 'Western Sahara'),
(243, 'YE', 'Yemen'),
(244, 'YU', 'Yugoslavia'),
(245, 'ZM', 'Zambia'),
(246, 'ZW', 'Zimbabwe');

-- --------------------------------------------------------

--
-- Table structure for table `currencies`
--

CREATE TABLE `currencies` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `code` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `symbol` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `decimals` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT '2',
  `xrate` decimal(65,8) DEFAULT NULL,
  `international_code` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `currencies`
--

INSERT INTO `currencies` (`id`, `name`, `code`, `symbol`, `decimals`, `xrate`, `international_code`, `active`, `created_at`, `updated_at`) VALUES
(1, 'United Arab Emirates Dirham', 'AED', 'ARE', '2', '3.67310000', NULL, 1, NULL, NULL),
(2, 'Australian Dollar', 'AUD', '$', '2', '1.30887000', NULL, 1, NULL, NULL),
(3, 'Brazilian Real', 'BRL', 'R$', '2', '3.28990000', NULL, 1, NULL, NULL),
(4, 'Canadian Dollar', 'CAD', '$', '2', '1.28699000', NULL, 1, NULL, NULL),
(5, 'Swiss Franc', 'CHF', 'Fr', '2', '0.99879000', NULL, 1, NULL, NULL),
(6, 'Chilean Peso', 'CLP', '$', '2', '634.92703000', NULL, 1, NULL, NULL),
(7, 'Chinese Yuan', 'CNY', '¥', '2', '6.65090000', NULL, 1, NULL, NULL),
(8, 'Czech Koruna', 'CZK', 'Kč', '2', '22.07896000', NULL, 1, NULL, NULL),
(9, 'Danish Krone', 'DKK', 'kr', '2', '6.39641000', NULL, 1, NULL, NULL),
(10, 'Euro', 'EUR', '€', '2', '0.85947000', NULL, 1, NULL, NULL),
(11, 'British Pound', 'GBP', '£', '2', '0.76160000', NULL, 1, NULL, NULL),
(12, 'Hong Kong Dollar', 'HKD', '$', '2', '7.80429000', NULL, 1, NULL, NULL),
(13, 'Hungarian Forint', 'HUF', 'Ft', '2', '266.94000000', NULL, 1, NULL, NULL),
(14, 'Indonesian Rupiah', 'IDR', 'Rp', '2', '13579.08005000', NULL, 1, NULL, NULL),
(15, 'Israeli New Shekel', 'ILS', '₪', '2', '3.52770000', NULL, 1, NULL, NULL),
(16, 'Indian Rupee', 'INR', 'INR', '2', '65.02500000', NULL, 1, NULL, NULL),
(17, 'Japanese Yen', 'JPY', '¥', '2', '114.15367000', NULL, 1, NULL, NULL),
(18, 'Kenya shillings', 'KES', 'kes', '2', '103.83500000', NULL, 1, NULL, NULL),
(19, 'Korean Won', 'KRW', '₩', '2', '1130.15833000', NULL, 1, NULL, NULL),
(20, 'Mexican Peso', 'MXN', '$', '2', '19.22180000', NULL, 1, NULL, NULL),
(21, 'Malaysian Ringgit', 'MYR', 'RM', '2', '4.23999000', NULL, 1, NULL, NULL),
(22, 'Norwegian Krone', 'NOK', 'kr', '2', '8.18854000', NULL, 1, NULL, NULL),
(23, 'New Zealand Dollar', 'NZD', '$', '2', '1.46185000', NULL, 1, NULL, NULL),
(24, 'Philippine Peso', 'PHP', '₱', '2', '51.82000000', NULL, 1, NULL, NULL),
(25, 'Pakistan Rupee', 'PKR', '₨', '2', '105.34574000', NULL, 1, NULL, NULL),
(26, 'Polish Zloty', 'PLN', 'zł', '2', '3.65669000', NULL, 1, NULL, NULL),
(27, 'Russian Ruble', 'RUB', '₽', '2', '57.79350000', NULL, 1, NULL, NULL),
(28, 'Swedish Krona', 'SEK', 'kr', '2', '8.37433000', NULL, 1, NULL, NULL),
(29, 'Singapore Dollar', 'SGD', '$', '2', '1.36899000', NULL, 1, NULL, NULL),
(30, 'Thai Baht', 'THB', '฿', '2', '33.28950000', NULL, 1, NULL, NULL),
(31, 'Turkish Lira', 'TRY', '₺', '2', '3.82340000', NULL, 1, NULL, NULL),
(32, 'Taiwan Dollar', 'TWD', '$', '2', '30.27400000', NULL, 1, NULL, NULL),
(33, 'US Dollar', 'USD', '$', '2', '1.00000000', NULL, 1, NULL, NULL),
(34, 'Bolívar Fuerte', 'VEF', 'Bs.', '2', '10.06907000', NULL, 1, NULL, NULL),
(35, 'South African Rand', 'ZAR', 'R', '2', '14.24180000', NULL, 1, NULL, NULL),
(36, 'Zim Dollar', 'ZWD', '$', '2', NULL, NULL, 1, NULL, NULL),
(37, 'Leu Romanesc', 'RON', 'RON', '2', NULL, NULL, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `custom_fields`
--

CREATE TABLE `custom_fields` (
  `id` int(10) UNSIGNED NOT NULL,
  `created_by_id` int(11) DEFAULT NULL,
  `category` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_type` enum('number','textfield','date','decimal','textarea','checkbox','radiobox','select') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'textfield',
  `required` tinyint(4) NOT NULL DEFAULT '0',
  `radio_box_values` text COLLATE utf8mb4_unicode_ci,
  `checkbox_values` text COLLATE utf8mb4_unicode_ci,
  `select_values` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `custom_fields`
--

INSERT INTO `custom_fields` (`id`, `created_by_id`, `category`, `name`, `field_type`, `required`, `radio_box_values`, `checkbox_values`, `select_values`, `created_at`, `updated_at`) VALUES
(1, NULL, 'clients', 'CNP', 'number', 0, NULL, NULL, NULL, '2018-07-02 08:00:32', '2018-07-02 08:00:32'),
(2, NULL, 'clients', 'Optiune', 'checkbox', 0, NULL, 'test1, test2, test3', NULL, '2018-07-04 13:19:27', '2018-07-04 13:19:27'),
(3, NULL, 'grants', 'Collateral', 'select', 0, NULL, NULL, 'Bilet la Ordin, Bilet la Ordin Avalizat, CEC, Contract de Fideiusiune, Garantie Parentala', '2018-07-05 08:33:22', '2018-07-05 08:33:22'),
(4, NULL, 'grants', 'Prima de Garantare', 'decimal', 1, NULL, NULL, NULL, '2018-07-05 08:38:05', '2018-07-05 08:38:05'),
(5, NULL, 'grants', 'Esalonare Plata', 'select', 0, NULL, NULL, 'Rate Anuale , Rate Lunare , Rate Saptamanale,', '2018-07-05 08:40:15', '2018-07-05 08:40:15'),
(6, NULL, 'grants', 'Contragarantie', 'checkbox', 0, NULL, 'Bilet la Ordin, Bilet la Ordin Avalizat, CEC, Contract Fideiusiune, Garantie Parentala', NULL, '2018-07-05 08:43:33', '2018-07-05 08:43:33');

-- --------------------------------------------------------

--
-- Table structure for table `custom_fields_meta`
--

CREATE TABLE `custom_fields_meta` (
  `id` int(10) UNSIGNED NOT NULL,
  `created_by_id` int(11) DEFAULT NULL,
  `category` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `custom_field_id` int(11) DEFAULT NULL,
  `name` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `custom_fields_meta`
--

INSERT INTO `custom_fields_meta` (`id`, `created_by_id`, `category`, `parent_id`, `custom_field_id`, `name`, `created_at`, `updated_at`) VALUES
(1, NULL, 'clients', 3, 1, NULL, '2018-07-05 08:04:38', '2018-07-05 08:04:38'),
(2, NULL, 'clients', 3, 2, 'a:0:{}', '2018-07-05 08:04:38', '2018-07-05 08:04:38');

-- --------------------------------------------------------

--
-- Table structure for table `documents`
--

CREATE TABLE `documents` (
  `id` int(10) UNSIGNED NOT NULL,
  `type` enum('client','loan','group','savings','identification','shares','repayment','grant') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `record_id` int(11) DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `size` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `location` text COLLATE utf8mb4_unicode_ci,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `documents`
--

INSERT INTO `documents` (`id`, `type`, `record_id`, `name`, `size`, `location`, `notes`, `created_at`, `updated_at`) VALUES
(1, 'grant', 1, 'test', NULL, 'test5b3cd5bc58442.docx', NULL, '2018-07-04 13:12:12', '2018-07-04 13:12:12'),
(4, 'grant', 3, 'Acord asociere Todini Nettstrade JSK', NULL, 'acord_asociere_todini_nettstrade_jsk5b3de3dc4c36f.pdf', 'Documente contract de baza', '2018-07-05 08:24:44', '2018-07-05 08:24:44'),
(5, 'grant', 3, 'Fisa de Date', NULL, 'fisa_de_date5b3de42d9b78a.pdf', 'Documente contract de baza', '2018-07-05 08:26:05', '2018-07-05 08:26:05'),
(6, 'grant', 3, 'Oferta City Insurance p1', NULL, 'oferta_city_insurance_p15b3de4de3fcc4.jpeg', 'Documente contract de baza', '2018-07-05 08:29:02', '2018-07-05 08:29:02'),
(7, 'grant', 3, 'Oferta City Insurance p2', NULL, 'oferta_city_insurance_p25b3de4ff91035.jpeg', 'Documente contract de baza', '2018-07-05 08:29:35', '2018-07-05 08:29:35');

-- --------------------------------------------------------

--
-- Table structure for table `expenses`
--

CREATE TABLE `expenses` (
  `id` int(10) UNSIGNED NOT NULL,
  `office_id` int(10) UNSIGNED DEFAULT NULL,
  `created_by_id` int(10) UNSIGNED DEFAULT NULL,
  `expense_type_id` int(10) UNSIGNED DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount` decimal(65,2) NOT NULL DEFAULT '0.00',
  `date` date DEFAULT NULL,
  `year` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `month` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `recurring` tinyint(4) NOT NULL DEFAULT '0',
  `recur_frequency` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '31',
  `recur_start_date` date DEFAULT NULL,
  `recur_end_date` date DEFAULT NULL,
  `recur_next_date` date DEFAULT NULL,
  `recur_type` enum('day','week','month','year') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'month',
  `status` enum('pending','approved','declined') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'approved',
  `approved_date` date DEFAULT NULL,
  `approved_by_id` int(10) UNSIGNED DEFAULT NULL,
  `declined_date` date DEFAULT NULL,
  `declined_by_id` int(10) UNSIGNED DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `files` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `expense_budgets`
--

CREATE TABLE `expense_budgets` (
  `id` int(10) UNSIGNED NOT NULL,
  `created_by_id` int(10) UNSIGNED DEFAULT NULL,
  `office_id` int(10) UNSIGNED DEFAULT NULL,
  `expense_type_id` int(11) DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `year` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `month` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date` date DEFAULT NULL,
  `amount` decimal(65,2) DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `status` enum('pending','approved','declined') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'approved',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `expense_types`
--

CREATE TABLE `expense_types` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gl_account_asset_id` int(11) DEFAULT NULL,
  `gl_account_expense_id` int(11) DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `funds`
--

CREATE TABLE `funds` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `gl_accounts`
--

CREATE TABLE `gl_accounts` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `gl_code` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `account_type` enum('asset','liability','equity','income','expense') COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  `manual_entries` tinyint(4) NOT NULL DEFAULT '1',
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `gl_closures`
--

CREATE TABLE `gl_closures` (
  `id` int(10) UNSIGNED NOT NULL,
  `office_id` int(11) DEFAULT NULL,
  `created_by_id` int(11) DEFAULT NULL,
  `closing_date` date NOT NULL,
  `modified_by_id` int(11) DEFAULT NULL,
  `gl_reference` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `gl_journal_entries`
--

CREATE TABLE `gl_journal_entries` (
  `id` int(10) UNSIGNED NOT NULL,
  `office_id` int(11) DEFAULT NULL,
  `gl_account_id` int(11) DEFAULT NULL,
  `currency_id` int(11) DEFAULT NULL,
  `transaction_type` enum('disbursement','accrual','deposit','withdrawal','manual_entry','pay_charge','transfer_fund','expense','payroll','income','fee','penalty','interest','dividend','guarantee','write_off','repayment','repayment_disbursement','repayment_recovery','interest_accrual','fee_accrual','savings','shares','asset','asset_income','asset_expense','asset_depreciation') COLLATE utf8mb4_unicode_ci DEFAULT 'repayment',
  `transaction_sub_type` enum('overpayment','repayment_interest','repayment_principal','repayment_fees','repayment_penalty') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `debit` decimal(65,4) DEFAULT NULL,
  `credit` decimal(65,4) DEFAULT NULL,
  `reversed` tinyint(4) NOT NULL DEFAULT '0',
  `name` text COLLATE utf8mb4_unicode_ci,
  `reference` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `loan_id` int(11) DEFAULT NULL,
  `loan_transaction_id` int(11) DEFAULT NULL,
  `savings_transaction_id` int(11) DEFAULT NULL,
  `savings_id` int(11) DEFAULT NULL,
  `shares_transaction_id` int(11) DEFAULT NULL,
  `payroll_transaction_id` int(11) DEFAULT NULL,
  `payment_detail_id` int(11) DEFAULT NULL,
  `transaction_id` int(11) DEFAULT NULL,
  `gl_closure_id` int(11) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `month` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `year` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_by_id` int(11) DEFAULT NULL,
  `modified_by_id` int(11) DEFAULT NULL,
  `reconciled` tinyint(4) NOT NULL DEFAULT '0',
  `manual_entry` tinyint(4) NOT NULL DEFAULT '0',
  `approved` tinyint(4) NOT NULL DEFAULT '1',
  `approved_by_id` int(11) DEFAULT NULL,
  `approved_date` date DEFAULT NULL,
  `approved_notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `grants`
--

CREATE TABLE `grants` (
  `id` int(10) UNSIGNED NOT NULL,
  `client_type` enum('client','group') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'client',
  `grant_product_id` int(11) DEFAULT NULL,
  `payment_detail_id` int(11) DEFAULT NULL,
  `client_id` int(11) DEFAULT NULL,
  `office_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `grant_fund_id` int(11) DEFAULT NULL,
  `grant_purpose_id` int(11) DEFAULT NULL,
  `currency_id` int(11) DEFAULT NULL,
  `decimals` int(11) NOT NULL DEFAULT '2',
  `account_number` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `external_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `grant_officer_id` int(11) DEFAULT NULL,
  `amount` decimal(65,4) DEFAULT NULL,
  `applied_amount` decimal(65,4) DEFAULT NULL,
  `approved_amount` decimal(65,4) DEFAULT NULL,
  `expected_disbursement_date` date DEFAULT NULL,
  `disbursement_date` date DEFAULT NULL,
  `status` enum('new','pending','approved','need_changes','disbursed','declined','rejected','withdrawn','closed','paid') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `created_by_id` int(11) DEFAULT NULL,
  `modified_by_id` int(11) DEFAULT NULL,
  `approved_by_id` int(11) DEFAULT NULL,
  `need_changes_by_id` int(11) DEFAULT NULL,
  `withdrawn_by_id` int(11) DEFAULT NULL,
  `declined_by_id` int(11) DEFAULT NULL,
  `written_off_by_id` int(11) DEFAULT NULL,
  `disbursed_by_id` int(11) DEFAULT NULL,
  `closed_by_id` int(11) DEFAULT NULL,
  `created_date` date DEFAULT NULL,
  `modified_date` date DEFAULT NULL,
  `approved_date` date DEFAULT NULL,
  `need_changes_date` date DEFAULT NULL,
  `withdrawn_date` date DEFAULT NULL,
  `declined_date` date DEFAULT NULL,
  `written_off_date` date DEFAULT NULL,
  `closed_date` date DEFAULT NULL,
  `month` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `year` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `approved_notes` text COLLATE utf8mb4_unicode_ci,
  `declined_notes` text COLLATE utf8mb4_unicode_ci,
  `written_off_notes` text COLLATE utf8mb4_unicode_ci,
  `disbursed_notes` text COLLATE utf8mb4_unicode_ci,
  `withdrawn_notes` text COLLATE utf8mb4_unicode_ci,
  `closed_notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `grants`
--

INSERT INTO `grants` (`id`, `client_type`, `grant_product_id`, `payment_detail_id`, `client_id`, `office_id`, `group_id`, `grant_fund_id`, `grant_purpose_id`, `currency_id`, `decimals`, `account_number`, `external_id`, `grant_officer_id`, `amount`, `applied_amount`, `approved_amount`, `expected_disbursement_date`, `disbursement_date`, `status`, `created_by_id`, `modified_by_id`, `approved_by_id`, `need_changes_by_id`, `withdrawn_by_id`, `declined_by_id`, `written_off_by_id`, `disbursed_by_id`, `closed_by_id`, `created_date`, `modified_date`, `approved_date`, `need_changes_date`, `withdrawn_date`, `declined_date`, `written_off_date`, `closed_date`, `month`, `year`, `notes`, `approved_notes`, `declined_notes`, `written_off_notes`, `disbursed_notes`, `withdrawn_notes`, `closed_notes`, `created_at`, `updated_at`) VALUES
(3, 'client', NULL, NULL, 3, 1, NULL, NULL, NULL, 37, 2, NULL, NULL, 3, '1750000.0000', '1750000.0000', '1750000.0000', NULL, NULL, 'approved', 1, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-07-05', NULL, '2018-07-05', NULL, NULL, NULL, NULL, NULL, '07', '2018', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2018-07-05 08:19:46', '2018-07-05 08:30:10');

-- --------------------------------------------------------

--
-- Table structure for table `groups`
--

CREATE TABLE `groups` (
  `id` int(10) UNSIGNED NOT NULL,
  `office_id` int(11) DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `account_no` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `external_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `staff_id` int(11) DEFAULT NULL,
  `joined_date` date DEFAULT NULL,
  `activated_date` date DEFAULT NULL,
  `reactivated_date` date DEFAULT NULL,
  `declined_date` date DEFAULT NULL,
  `declined_reason` text COLLATE utf8mb4_unicode_ci,
  `closed_reason` text COLLATE utf8mb4_unicode_ci,
  `closed_date` date DEFAULT NULL,
  `created_by_id` int(11) DEFAULT NULL,
  `activated_by_id` int(11) DEFAULT NULL,
  `reactivated_by_id` int(11) DEFAULT NULL,
  `declined_by_id` int(11) DEFAULT NULL,
  `closed_by_id` int(11) DEFAULT NULL,
  `mobile` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `street` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ward` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `district` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `region` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `status` enum('pending','active','inactive','declined','closed') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `group_clients`
--

CREATE TABLE `group_clients` (
  `id` int(10) UNSIGNED NOT NULL,
  `group_id` int(11) DEFAULT NULL,
  `client_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `group_loan_allocation`
--

CREATE TABLE `group_loan_allocation` (
  `id` int(10) UNSIGNED NOT NULL,
  `loan_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `client_id` int(11) DEFAULT NULL,
  `amount` decimal(65,4) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `group_users`
--

CREATE TABLE `group_users` (
  `id` int(10) UNSIGNED NOT NULL,
  `created_by_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `guarantors`
--

CREATE TABLE `guarantors` (
  `id` int(10) UNSIGNED NOT NULL,
  `country_id` int(11) DEFAULT NULL,
  `client_id` int(11) DEFAULT NULL,
  `savings_id` int(11) DEFAULT NULL,
  `loan_id` int(11) DEFAULT NULL,
  `loan_application_id` int(11) DEFAULT NULL,
  `is_client` tinyint(4) NOT NULL DEFAULT '0',
  `client_relationship_id` int(11) DEFAULT NULL,
  `amount` decimal(65,4) DEFAULT NULL,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `first_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `middle_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gender` enum('male','female','other','unspecified') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `street` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `mobile` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `picture` text COLLATE utf8mb4_unicode_ci,
  `work` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `work_address` text COLLATE utf8mb4_unicode_ci,
  `lock_funds` tinyint(4) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `loans`
--

CREATE TABLE `loans` (
  `id` int(10) UNSIGNED NOT NULL,
  `client_type` enum('client','group') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'client',
  `loan_product_id` int(11) DEFAULT NULL,
  `client_id` int(11) DEFAULT NULL,
  `office_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `fund_id` int(11) DEFAULT NULL,
  `loan_purpose_id` int(11) DEFAULT NULL,
  `currency_id` int(11) DEFAULT NULL,
  `decimals` int(11) NOT NULL DEFAULT '2',
  `account_number` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `external_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `loan_officer_id` int(11) DEFAULT NULL,
  `principal` decimal(65,4) DEFAULT NULL,
  `applied_amount` decimal(65,4) DEFAULT NULL,
  `approved_amount` decimal(65,4) DEFAULT NULL,
  `principal_derived` decimal(65,4) DEFAULT NULL,
  `interest_derived` decimal(65,4) DEFAULT NULL,
  `fees_derived` decimal(65,4) DEFAULT NULL,
  `penalty_derived` decimal(65,4) DEFAULT NULL,
  `disbursement_fees` decimal(65,4) DEFAULT NULL,
  `processing_fee` decimal(65,4) DEFAULT NULL,
  `loan_term` int(11) DEFAULT NULL,
  `loan_term_type` enum('days','weeks','months','years') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `repayment_frequency` int(11) DEFAULT NULL,
  `repayment_frequency_type` enum('days','weeks','months','years') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `override_interest` tinyint(4) DEFAULT '0',
  `interest_rate` decimal(65,4) DEFAULT NULL,
  `override_interest_rate` decimal(65,4) DEFAULT NULL,
  `interest_rate_type` enum('day','week','month','year') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `expected_disbursement_date` date DEFAULT NULL,
  `disbursement_date` date DEFAULT NULL,
  `expected_maturity_date` date DEFAULT NULL,
  `expected_first_repayment_date` date DEFAULT NULL,
  `repayments_number` int(11) DEFAULT NULL,
  `first_repayment_date` date DEFAULT NULL,
  `interest_method` enum('flat','declining_balance') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `armotization_method` enum('equal_installment','equal_principal') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `grace_on_interest_charged` int(11) DEFAULT NULL,
  `grace_on_principal` int(11) DEFAULT NULL,
  `grace_on_interest_payment` int(11) DEFAULT NULL,
  `status` enum('new','pending','approved','need_changes','disbursed','declined','rejected','withdrawn','written_off','closed','pending_reschedule','rescheduled','paid') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `created_by_id` int(11) DEFAULT NULL,
  `modified_by_id` int(11) DEFAULT NULL,
  `approved_by_id` int(11) DEFAULT NULL,
  `need_changes_by_id` int(11) DEFAULT NULL,
  `withdrawn_by_id` int(11) DEFAULT NULL,
  `declined_by_id` int(11) DEFAULT NULL,
  `written_off_by_id` int(11) DEFAULT NULL,
  `disbursed_by_id` int(11) DEFAULT NULL,
  `rescheduled_by_id` int(11) DEFAULT NULL,
  `closed_by_id` int(11) DEFAULT NULL,
  `created_date` date DEFAULT NULL,
  `modified_date` date DEFAULT NULL,
  `approved_date` date DEFAULT NULL,
  `need_changes_date` date DEFAULT NULL,
  `withdrawn_date` date DEFAULT NULL,
  `declined_date` date DEFAULT NULL,
  `written_off_date` date DEFAULT NULL,
  `rescheduled_date` date DEFAULT NULL,
  `closed_date` date DEFAULT NULL,
  `month` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `year` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `approved_notes` text COLLATE utf8mb4_unicode_ci,
  `declined_notes` text COLLATE utf8mb4_unicode_ci,
  `written_off_notes` text COLLATE utf8mb4_unicode_ci,
  `disbursed_notes` text COLLATE utf8mb4_unicode_ci,
  `withdrawn_notes` text COLLATE utf8mb4_unicode_ci,
  `rescheduled_notes` text COLLATE utf8mb4_unicode_ci,
  `closed_notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `loan_applications`
--

CREATE TABLE `loan_applications` (
  `id` int(10) UNSIGNED NOT NULL,
  `client_type` enum('client','group') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'client',
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `loan_id` int(10) UNSIGNED DEFAULT NULL,
  `loan_purpose_id` int(11) DEFAULT NULL,
  `currency_id` int(11) DEFAULT NULL,
  `office_id` int(10) UNSIGNED DEFAULT NULL,
  `client_id` int(10) UNSIGNED DEFAULT NULL,
  `group_id` int(10) UNSIGNED DEFAULT NULL,
  `loan_product_id` int(11) NOT NULL,
  `amount` decimal(65,4) NOT NULL DEFAULT '0.0000',
  `status` enum('approved','pending','declined') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `guarantor_ids` text COLLATE utf8mb4_unicode_ci,
  `loan_term` int(11) DEFAULT NULL,
  `loan_term_type` enum('days','weeks','months','years') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `approved_by_id` int(11) DEFAULT NULL,
  `declined_by_id` int(11) DEFAULT NULL,
  `approved_notes` text COLLATE utf8mb4_unicode_ci,
  `declined_notes` text COLLATE utf8mb4_unicode_ci,
  `declined_date` date DEFAULT NULL,
  `approved_date` date DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `loan_charges`
--

CREATE TABLE `loan_charges` (
  `id` int(10) UNSIGNED NOT NULL,
  `loan_id` int(11) DEFAULT NULL,
  `charge_id` int(11) DEFAULT NULL,
  `penalty` tinyint(4) NOT NULL DEFAULT '0',
  `waived` tinyint(4) NOT NULL DEFAULT '0',
  `charge_type` enum('disbursement','disbursement_repayment','specified_due_date','installment_fee','overdue_installment_fee','loan_rescheduling_fee','overdue_maturity') COLLATE utf8mb4_unicode_ci NOT NULL,
  `charge_option` enum('flat','percentage','installment_principal_due','installment_principal_interest_due','installment_interest_due','installment_total_due','total_due','original_principal') COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` decimal(65,2) DEFAULT NULL,
  `amount_paid` decimal(65,2) DEFAULT NULL,
  `due_date` date DEFAULT NULL,
  `grace_period` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `loan_products`
--

CREATE TABLE `loan_products` (
  `id` int(10) UNSIGNED NOT NULL,
  `created_by_id` int(11) DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `short_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `fund_id` int(11) DEFAULT NULL,
  `currency_id` int(11) DEFAULT NULL,
  `decimals` int(11) NOT NULL DEFAULT '2',
  `minimum_principal` decimal(65,4) DEFAULT NULL,
  `default_principal` decimal(65,4) DEFAULT NULL,
  `maximum_principal` decimal(65,4) DEFAULT NULL,
  `minimum_loan_term` int(11) DEFAULT NULL,
  `default_loan_term` int(11) DEFAULT NULL,
  `maximum_loan_term` int(11) DEFAULT NULL,
  `repayment_frequency` int(11) DEFAULT NULL,
  `repayment_frequency_type` enum('days','weeks','months','years') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `minimum_interest_rate` decimal(65,4) DEFAULT NULL,
  `default_interest_rate` decimal(65,4) DEFAULT NULL,
  `maximum_interest_rate` decimal(65,4) DEFAULT NULL,
  `interest_rate_type` enum('day','week','month','year') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `grace_on_interest_charged` int(11) DEFAULT NULL,
  `grace_on_principal` int(11) DEFAULT NULL,
  `grace_on_interest_payment` int(11) DEFAULT NULL,
  `allow_custom_grace` tinyint(4) NOT NULL DEFAULT '0',
  `allow_standing_instuctions` tinyint(4) NOT NULL DEFAULT '0',
  `interest_method` enum('flat','declining_balance') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `armotization_method` enum('equal_installment','equal_principal') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `interest_calculation_period_type` enum('daily','same') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'same',
  `year_days` enum('actual','360','364','365') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '365',
  `month_days` enum('actual','30','31') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '30',
  `loan_transaction_strategy` enum('penalty_fees_interest_principal','principal_interest_penalty_fees','interest_principal_penalty_fees') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'interest_principal_penalty_fees',
  `include_in_cycle` tinyint(4) NOT NULL DEFAULT '0',
  `lock_guarantee` tinyint(4) NOT NULL DEFAULT '0',
  `allocate_overpayments` tinyint(4) NOT NULL DEFAULT '0',
  `allow_additional_charges` tinyint(4) NOT NULL DEFAULT '0',
  `accounting_rule` enum('none','cash','accrual_periodic','accrual_upfront') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'cash',
  `npa_days` int(11) DEFAULT NULL,
  `arrears_grace_days` int(11) DEFAULT NULL,
  `npa_suspend_income` tinyint(4) NOT NULL DEFAULT '0',
  `gl_account_fund_source_id` int(11) DEFAULT NULL,
  `gl_account_loan_portfolio_id` int(11) DEFAULT NULL,
  `gl_account_receivable_interest_id` int(11) DEFAULT NULL,
  `gl_account_receivable_fee_id` int(11) DEFAULT NULL,
  `gl_account_receivable_penalty_id` int(11) DEFAULT NULL,
  `gl_account_loan_over_payments_id` int(11) DEFAULT NULL,
  `gl_account_suspended_income_id` int(11) DEFAULT NULL,
  `gl_account_income_interest_id` int(11) DEFAULT NULL,
  `gl_account_income_fee_id` int(11) DEFAULT NULL,
  `gl_account_income_penalty_id` int(11) DEFAULT NULL,
  `gl_account_income_recovery_id` int(11) DEFAULT NULL,
  `gl_account_loans_written_off_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `loan_products`
--

INSERT INTO `loan_products` (`id`, `created_by_id`, `name`, `short_name`, `description`, `fund_id`, `currency_id`, `decimals`, `minimum_principal`, `default_principal`, `maximum_principal`, `minimum_loan_term`, `default_loan_term`, `maximum_loan_term`, `repayment_frequency`, `repayment_frequency_type`, `minimum_interest_rate`, `default_interest_rate`, `maximum_interest_rate`, `interest_rate_type`, `grace_on_interest_charged`, `grace_on_principal`, `grace_on_interest_payment`, `allow_custom_grace`, `allow_standing_instuctions`, `interest_method`, `armotization_method`, `interest_calculation_period_type`, `year_days`, `month_days`, `loan_transaction_strategy`, `include_in_cycle`, `lock_guarantee`, `allocate_overpayments`, `allow_additional_charges`, `accounting_rule`, `npa_days`, `arrears_grace_days`, `npa_suspend_income`, `gl_account_fund_source_id`, `gl_account_loan_portfolio_id`, `gl_account_receivable_interest_id`, `gl_account_receivable_fee_id`, `gl_account_receivable_penalty_id`, `gl_account_loan_over_payments_id`, `gl_account_suspended_income_id`, `gl_account_income_interest_id`, `gl_account_income_fee_id`, `gl_account_income_penalty_id`, `gl_account_income_recovery_id`, `gl_account_loans_written_off_id`, `created_at`, `updated_at`) VALUES
(2, 1, 'Credite de nevoi personale', 'CNP', 'Credite de nevoi personale', NULL, 10, 2, '0.0000', '1.0000', '2.0000', 3, 5, 4, 1, 'months', '2.0000', '10.0000', '9.0000', 'month', 0, 0, 0, 0, 0, 'flat', 'equal_installment', 'same', 'actual', 'actual', 'penalty_fees_interest_principal', 0, 1, 0, 0, 'none', NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(3, 1, 'Factoring', 'Factoring', 'Factoring', NULL, 10, 2, '1.0000', '1.0000', '5.0000', 1, 2, 2, 1, 'months', '2.0000', '45.0000', '12.0000', 'month', 0, 0, 0, 0, 0, 'flat', 'equal_installment', 'same', 'actual', 'actual', 'penalty_fees_interest_principal', 0, 1, 0, 0, 'none', NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(4, 1, 'Scontare', 'Scontare', 'Scontare', NULL, 10, 2, '2.0000', '1.0000', '5.0000', 2, 1, 5, 1, 'months', '12.0000', '55.0000', '52.0000', 'month', 0, 0, 0, 0, 0, 'flat', 'equal_installment', 'same', 'actual', 'actual', 'penalty_fees_interest_principal', 0, 1, 0, 0, 'none', NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `loan_product_charges`
--

CREATE TABLE `loan_product_charges` (
  `id` int(10) UNSIGNED NOT NULL,
  `loan_product_id` int(11) DEFAULT NULL,
  `charge_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `loan_provisioning_criteria`
--

CREATE TABLE `loan_provisioning_criteria` (
  `id` int(10) UNSIGNED NOT NULL,
  `created_by_id` int(11) DEFAULT NULL,
  `name` text COLLATE utf8mb4_unicode_ci,
  `min` int(11) DEFAULT NULL,
  `max` int(11) DEFAULT NULL,
  `percentage` int(11) DEFAULT NULL,
  `gl_account_liability_id` int(11) DEFAULT NULL,
  `gl_account_expense_id` int(11) DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `loan_provisioning_criteria`
--

INSERT INTO `loan_provisioning_criteria` (`id`, `created_by_id`, `name`, `min`, `max`, `percentage`, `gl_account_liability_id`, `gl_account_expense_id`, `notes`, `active`, `created_at`, `updated_at`) VALUES
(1, NULL, 'Current', 0, 30, 0, NULL, NULL, NULL, 1, NULL, NULL),
(2, NULL, 'Especially Mentioned', 31, 60, 5, NULL, NULL, NULL, 1, NULL, NULL),
(3, NULL, 'Substandard', 61, 90, 10, NULL, NULL, NULL, 1, NULL, NULL),
(4, NULL, 'Doubtful', 91, 180, 50, NULL, NULL, NULL, 1, NULL, NULL),
(5, NULL, 'Loss', 181, 5000, 100, NULL, NULL, NULL, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `loan_purposes`
--

CREATE TABLE `loan_purposes` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `loan_purposes`
--

INSERT INTO `loan_purposes` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Credite Persoane Fizice', '2018-07-04 05:16:09', '2018-07-04 05:16:09'),
(2, 'Credite Persoane Juridice', '2018-07-04 05:16:18', '2018-07-04 05:16:18');

-- --------------------------------------------------------

--
-- Table structure for table `loan_repayment_schedules`
--

CREATE TABLE `loan_repayment_schedules` (
  `id` int(10) UNSIGNED NOT NULL,
  `loan_id` int(11) DEFAULT NULL,
  `installment` int(11) DEFAULT NULL,
  `due_date` date DEFAULT NULL,
  `from_date` date DEFAULT NULL,
  `month` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `year` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `principal` decimal(65,4) DEFAULT NULL,
  `principal_waived` decimal(65,4) DEFAULT NULL,
  `principal_written_off` decimal(65,4) DEFAULT NULL,
  `principal_paid` decimal(65,4) DEFAULT NULL,
  `interest` decimal(65,4) DEFAULT NULL,
  `interest_waived` decimal(65,4) DEFAULT NULL,
  `interest_written_off` decimal(65,4) DEFAULT NULL,
  `interest_paid` decimal(65,4) DEFAULT NULL,
  `fees` decimal(65,4) DEFAULT NULL,
  `fees_waived` decimal(65,4) DEFAULT NULL,
  `fees_written_off` decimal(65,4) DEFAULT NULL,
  `fees_paid` decimal(65,4) DEFAULT NULL,
  `penalty` decimal(65,4) DEFAULT NULL,
  `penalty_waived` decimal(65,4) DEFAULT NULL,
  `penalty_written_off` decimal(65,4) DEFAULT NULL,
  `penalty_paid` decimal(65,4) DEFAULT NULL,
  `total_due` decimal(65,4) DEFAULT NULL,
  `total_paid_advance` decimal(65,4) DEFAULT NULL,
  `total_paid_late` decimal(65,4) DEFAULT NULL,
  `paid` tinyint(4) NOT NULL DEFAULT '0',
  `modified_by_id` int(11) DEFAULT NULL,
  `created_by_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `loan_reschedule_requests`
--

CREATE TABLE `loan_reschedule_requests` (
  `id` int(10) UNSIGNED NOT NULL,
  `loan_id` int(11) DEFAULT NULL,
  `principal` decimal(65,4) DEFAULT NULL,
  `status` enum('pending','approved','rejected') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `created_by_id` int(11) DEFAULT NULL,
  `modified_by_id` int(11) DEFAULT NULL,
  `approved_by_id` int(11) DEFAULT NULL,
  `rejected_by_id` int(11) DEFAULT NULL,
  `created_date` date DEFAULT NULL,
  `modified_date` date DEFAULT NULL,
  `approved_date` date DEFAULT NULL,
  `rejected_date` date DEFAULT NULL,
  `reschedule_from_date` date DEFAULT NULL,
  `recalculate_interest` int(11) NOT NULL DEFAULT '0',
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `loan_transactions`
--

CREATE TABLE `loan_transactions` (
  `id` int(10) UNSIGNED NOT NULL,
  `loan_id` int(11) DEFAULT NULL,
  `office_id` int(11) DEFAULT NULL,
  `client_id` int(11) DEFAULT NULL,
  `payment_type_id` int(11) DEFAULT NULL,
  `transaction_type` enum('repayment','repayment_disbursement','write_off','write_off_recovery','disbursement','interest_accrual','fee_accrual','penalty_accrual','deposit','withdrawal','manual_entry','pay_charge','transfer_fund','interest','income','fee','disbursement_fee','installment_fee','specified_due_date_fee','overdue_maturity','overdue_installment_fee','loan_rescheduling_fee','penalty','interest_waiver','charge_waiver') COLLATE utf8mb4_unicode_ci DEFAULT 'repayment',
  `created_by_id` int(11) DEFAULT NULL,
  `modified_by_id` int(11) DEFAULT NULL,
  `payment_detail_id` int(11) DEFAULT NULL,
  `charge_id` int(11) DEFAULT NULL,
  `loan_repayment_schedule_id` int(11) DEFAULT NULL,
  `debit` decimal(65,4) DEFAULT NULL,
  `credit` decimal(65,4) DEFAULT NULL,
  `balance` decimal(65,4) DEFAULT NULL,
  `amount` decimal(65,4) DEFAULT NULL,
  `reversible` tinyint(4) NOT NULL DEFAULT '0',
  `reversed` tinyint(4) NOT NULL DEFAULT '0',
  `reversal_type` enum('system','user','none') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'none',
  `payment_apply_to` enum('interest','principal','fees','penalty','regular') COLLATE utf8mb4_unicode_ci DEFAULT 'regular',
  `status` enum('pending','approved','declined') COLLATE utf8mb4_unicode_ci DEFAULT 'pending',
  `approved_by_id` int(11) DEFAULT NULL,
  `approved_date` date DEFAULT NULL,
  `interest` decimal(65,4) DEFAULT NULL,
  `principal` decimal(65,4) DEFAULT NULL,
  `fee` decimal(65,4) DEFAULT NULL,
  `penalty` decimal(65,4) DEFAULT NULL,
  `overpayment` decimal(65,4) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `month` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `year` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `receipt` text COLLATE utf8mb4_unicode_ci,
  `principal_derived` decimal(65,4) DEFAULT NULL,
  `interest_derived` decimal(65,4) DEFAULT NULL,
  `fees_derived` decimal(65,4) DEFAULT NULL,
  `penalty_derived` decimal(65,4) DEFAULT NULL,
  `overpayment_derived` decimal(65,4) DEFAULT NULL,
  `unrecognized_income_derived` decimal(65,4) DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `loan_transaction_repayment_schedule_mappings`
--

CREATE TABLE `loan_transaction_repayment_schedule_mappings` (
  `id` int(10) UNSIGNED NOT NULL,
  `loan_repayment_schedule_id` int(11) DEFAULT NULL,
  `loan_transaction_id` int(11) DEFAULT NULL,
  `interest` decimal(65,4) DEFAULT NULL,
  `principal` decimal(65,4) DEFAULT NULL,
  `fee` decimal(65,4) DEFAULT NULL,
  `penalty` decimal(65,4) DEFAULT NULL,
  `overpayment` decimal(65,4) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_07_02_230147_migration_cartalyst_sentinel', 1),
(2, '2018_04_17_142054_create_clients_table', 1),
(3, '2018_04_17_143536_create_offices_table', 1),
(4, '2018_04_17_143618_create_office_transactions_table', 1),
(5, '2018_04_17_145018_create_group_clients_table', 1),
(6, '2018_04_17_145018_create_groups_table', 1),
(7, '2018_04_17_145135_create_gl_accounts_table', 1),
(8, '2018_04_17_145228_create_gl_closures_table', 1),
(9, '2018_04_17_145702_create_loans_table', 1),
(10, '2018_04_17_145803_create_loan_repayment_schedules_table', 1),
(11, '2018_04_17_154317_create_gl_journal_entries_table', 1),
(12, '2018_04_17_155148_create_funds_table', 1),
(13, '2018_04_17_155538_create_documents_table', 1),
(14, '2018_04_17_155601_create_loan_products_table', 1),
(15, '2018_04_17_160526_create_payment_type_details_table', 1),
(16, '2018_04_17_160526_create_payment_types_table', 1),
(17, '2018_04_17_160706_create_currencies_table', 1),
(18, '2018_04_17_161015_create_charges_table', 1),
(19, '2018_04_17_161955_create_loan_charges_table', 1),
(20, '2018_04_17_162008_create_loan_product_charges_table', 1),
(21, '2018_04_17_162337_create_loan_reschedule_requests_table', 1),
(22, '2018_04_17_162446_create_loan_transactions_table', 1),
(23, '2018_04_17_162650_create_loan_transaction_repayment_schedule_mappings_table', 1),
(24, '2018_04_17_162728_create_notes_table', 1),
(25, '2018_04_17_173153_create_client_next_of_kin_table', 1),
(26, '2018_04_17_174617_create_client_identifications_table', 1),
(27, '2018_04_17_175118_create_client_identification_types_table', 1),
(28, '2018_04_17_175504_create_client_relationships_table', 1),
(29, '2018_04_17_175600_create_client_profession_table', 1),
(30, '2018_04_22_230823_create_settings_table', 1),
(31, '2018_04_22_230940_create_countries_table', 1),
(32, '2018_04_22_233825_create_permissions_table', 1),
(33, '2018_04_26_230414_create_loan_purposes_table', 1),
(34, '2018_04_27_230233_create_collateral_table', 1),
(35, '2018_04_27_230233_create_collateral_types_table', 1),
(36, '2018_04_28_111043_create_guarantors_table', 1),
(37, '2018_04_29_140913_create_payment_details_table', 1),
(38, '2018_04_30_172023_create_sms_gateways_table', 1),
(39, '2018_05_03_012752_create_loan_provisioning_criteria_table', 1),
(40, '2018_05_07_141744_create_group_loan_allocation_table', 1),
(41, '2018_05_08_232948_create_savings_products_table', 1),
(42, '2018_05_08_233244_create_savings_table', 1),
(43, '2018_05_08_233314_create_savings_charges_table', 1),
(44, '2018_05_08_233328_create_savings_transactions_table', 1),
(45, '2018_05_08_233440_create_savings_product_charges_table', 1),
(46, '2018_05_11_030728_create_report_scheduler_table', 1),
(47, '2018_05_11_041541_create_report_scheduler_run_history_table', 1),
(48, '2018_05_11_042659_create_communication_campaigns_table', 1),
(49, '2018_05_11_155900_create_audit_trail_table', 1),
(50, '2018_05_21_224207_create_custom_fields_table', 1),
(51, '2018_05_21_224603_create_custom_fields_meta_table', 1),
(52, '2018_05_24_121405_create_asset_types_table', 1),
(53, '2018_05_24_122537_create_assets_table', 1),
(54, '2018_05_24_122554_create_asset_depreciation_table', 1),
(55, '2018_05_24_162316_create_expense_types_table', 1),
(56, '2018_05_24_162910_create_expenses_table', 1),
(57, '2018_05_24_163811_create_expense_budgets_table', 1),
(58, '2018_05_24_165943_create_other_income_table', 1),
(59, '2018_05_24_165945_create_other_income_types_table', 1),
(60, '2018_05_27_182007_create_client_users_table', 1),
(61, '2018_05_27_182033_create_group_users_table', 1),
(62, '2018_05_28_154830_create_payroll_templates_table', 1),
(63, '2018_05_28_161903_create_payroll_template_meta_table', 1),
(64, '2018_05_28_163251_create_payroll_table', 1),
(65, '2018_05_28_163322_create_payroll_meta_table', 1),
(66, '2018_06_05_092031_create_loan_applications_table', 1),
(67, '2018_06_13_130729_create_grants_table', 1),
(68, '2018_06_13_165435_add_grant_details_to_notes_documents_table', 1),
(69, '2018_06_14_090150_set_version_to_2_1', 1);

-- --------------------------------------------------------

--
-- Table structure for table `notes`
--

CREATE TABLE `notes` (
  `id` int(10) UNSIGNED NOT NULL,
  `reference_id` int(11) DEFAULT NULL,
  `type` enum('client','loan','group','savings','identification','shares','repayment','grant') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by_id` int(11) DEFAULT NULL,
  `modified_by_id` int(11) DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `offices`
--

CREATE TABLE `offices` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `external_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `opening_date` date DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `phone` text COLLATE utf8mb4_unicode_ci,
  `email` text COLLATE utf8mb4_unicode_ci,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `manager_id` int(11) DEFAULT NULL,
  `active` tinyint(4) DEFAULT '1',
  `default_office` tinyint(4) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `offices`
--

INSERT INTO `offices` (`id`, `name`, `parent_id`, `external_id`, `opening_date`, `address`, `phone`, `email`, `notes`, `manager_id`, `active`, `default_office`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Capidava Centrala', NULL, '1', '2018-03-15', NULL, NULL, NULL, NULL, NULL, 1, 1, NULL, '2018-07-05 07:42:31', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `office_transactions`
--

CREATE TABLE `office_transactions` (
  `id` int(10) UNSIGNED NOT NULL,
  `from_office_id` int(11) DEFAULT NULL,
  `to_office_id` int(11) DEFAULT NULL,
  `currency_id` int(11) DEFAULT NULL,
  `amount` decimal(65,8) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `other_income`
--

CREATE TABLE `other_income` (
  `id` int(10) UNSIGNED NOT NULL,
  `office_id` int(10) UNSIGNED DEFAULT NULL,
  `created_by_id` int(10) UNSIGNED DEFAULT NULL,
  `other_income_type_id` int(10) UNSIGNED DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount` decimal(65,2) NOT NULL DEFAULT '0.00',
  `date` date DEFAULT NULL,
  `year` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `month` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `files` text COLLATE utf8mb4_unicode_ci,
  `status` enum('pending','approved','declined') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'approved',
  `approved_date` date DEFAULT NULL,
  `approved_by_id` int(10) UNSIGNED DEFAULT NULL,
  `declined_date` date DEFAULT NULL,
  `declined_by_id` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `other_income_types`
--

CREATE TABLE `other_income_types` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gl_account_asset_id` int(11) DEFAULT NULL,
  `gl_account_income_id` int(11) DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payment_details`
--

CREATE TABLE `payment_details` (
  `id` int(10) UNSIGNED NOT NULL,
  `payment_type_id` int(11) DEFAULT NULL,
  `account_number` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cheque_number` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `routing_code` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `receipt_number` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payment_types`
--

CREATE TABLE `payment_types` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `is_cash` tinyint(4) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payment_type_details`
--

CREATE TABLE `payment_type_details` (
  `id` int(10) UNSIGNED NOT NULL,
  `type` enum('loan','savings','share','client','journal') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reference_id` int(11) NOT NULL,
  `account_number` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cheque_number` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `routing_code` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `receipt_number` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payroll`
--

CREATE TABLE `payroll` (
  `id` int(10) UNSIGNED NOT NULL,
  `payroll_template_id` int(10) UNSIGNED DEFAULT NULL,
  `gl_account_expense_id` int(10) UNSIGNED DEFAULT NULL,
  `gl_account_asset_id` int(10) UNSIGNED DEFAULT NULL,
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `office_id` int(10) UNSIGNED DEFAULT NULL,
  `employee_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `business_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_method` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_type_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `account_number` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `comments` text COLLATE utf8mb4_unicode_ci,
  `paid_amount` decimal(10,2) NOT NULL DEFAULT '0.00',
  `date` date DEFAULT NULL,
  `year` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `month` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `recurring` tinyint(4) NOT NULL DEFAULT '0',
  `recur_frequency` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '31',
  `recur_start_date` date DEFAULT NULL,
  `recur_end_date` date DEFAULT NULL,
  `recur_next_date` date DEFAULT NULL,
  `recur_type` enum('days','weeks','months','years') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'months',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payroll_meta`
--

CREATE TABLE `payroll_meta` (
  `id` int(10) UNSIGNED NOT NULL,
  `payroll_id` int(10) UNSIGNED NOT NULL,
  `payroll_template_meta_id` int(10) UNSIGNED DEFAULT NULL,
  `value` decimal(65,2) DEFAULT NULL,
  `is_tax` tinyint(4) DEFAULT '0',
  `is_percentage` tinyint(4) DEFAULT '0',
  `position` enum('top_left','top_right','bottom_left','bottom_right') COLLATE utf8mb4_unicode_ci DEFAULT 'bottom_left',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payroll_templates`
--

CREATE TABLE `payroll_templates` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `picture` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active` tinyint(4) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `payroll_templates`
--

INSERT INTO `payroll_templates` (`id`, `name`, `notes`, `picture`, `active`, `created_at`, `updated_at`) VALUES
(1, 'Default', 'Default Payroll Template', 'default_payroll_template.jpg', 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `payroll_template_meta`
--

CREATE TABLE `payroll_template_meta` (
  `id` int(10) UNSIGNED NOT NULL,
  `payroll_template_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `position` enum('top_left','top_right','bottom_left','bottom_right','none') COLLATE utf8mb4_unicode_ci DEFAULT 'bottom_left',
  `type` enum('addition','deduction') COLLATE utf8mb4_unicode_ci DEFAULT 'addition',
  `is_default` tinyint(4) NOT NULL DEFAULT '0',
  `is_tax` tinyint(4) NOT NULL DEFAULT '0',
  `is_percentage` tinyint(4) NOT NULL DEFAULT '0',
  `tax_on` enum('net','gross') COLLATE utf8mb4_unicode_ci DEFAULT 'net',
  `default_value` decimal(65,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` int(10) UNSIGNED NOT NULL,
  `parent_id` int(11) DEFAULT '0',
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `parent_id`, `name`, `slug`, `description`) VALUES
(1, 0, 'Users', 'users', 'Access Users Module'),
(2, 1, 'View Users', 'users.view', 'View Users'),
(3, 1, 'Create Users', 'users.create', 'Create Users'),
(4, 1, 'Update Users', 'users.update', 'Update Users'),
(5, 1, 'Delete Users', 'users.delete', 'Delete users'),
(7, 1, 'View Roles', 'users.roles.view', 'View Roles'),
(8, 1, 'Create Roles', 'users.roles.create', 'Create Roles'),
(9, 1, 'Update Roles', 'users.roles.update', 'Update Roles'),
(10, 1, 'Delete Roles', 'users.roles.delete', 'Delete Roles'),
(11, 1, 'Assign Roles', 'users.roles.assign', 'Assign User Roles'),
(12, 0, 'Settings', 'settings', 'Access Settings Module'),
(13, 12, 'Update Settings', 'settings.update', 'Update Settings'),
(14, 12, 'View General Settings', 'settings.general.view', 'View General Settings'),
(15, 12, 'View Organisation Settings', 'settings.organisation.view', 'View Organisation Settings'),
(16, 0, 'Accounting', 'accounting', 'Access Accounting Module'),
(17, 16, 'View Chart of Accounts', 'accounting.gl_accounts.view', 'View Chart of Accounts'),
(18, 16, 'Create Chart of Accounts', 'accounting.gl_accounts.create', 'Create Chart of Accounts'),
(19, 16, 'Update Chart of Accounts', 'accounting.gl_accounts.update', 'Update Chart of Accounts'),
(20, 16, 'Delete Chart of Accounts', 'accounting.gl_accounts.delete', 'Delete Chart of Accounts'),
(21, 16, 'View Journals', 'accounting.journals.view', 'View Journals'),
(22, 16, 'Create Manual Journals', 'accounting.journals.create', 'Create Manual Journals'),
(23, 16, 'Delete Manual Journals', 'accounting.journals.delete', 'Delete Manual Journals'),
(24, 16, 'Approve Manual Journals', 'accounting.journals.approve', 'Approve Manual Journals'),
(25, 16, 'View Reconciliations', 'accounting.journals.reconciliation.view', 'View Reconciliations'),
(26, 16, 'Reconcile Journal Entries', 'accounting.journals.reconciliation.create', 'Reconcile Journal Entries'),
(27, 16, 'View Accounting Close Period', 'accounting.period.view', 'View  Accounting Close Period'),
(28, 16, 'Create Accounting Close Period', 'accounting.period.create', 'Create Accounting Close Period'),
(29, 16, 'Delete Accounting Close Period', 'accounting.period.delete', 'Delete Accounting Close Period'),
(30, 0, 'Audit Trail', 'audit_trail', 'Access Audit Trail Module'),
(31, 0, 'Branches', 'offices', 'Access Branches Module'),
(32, 31, 'View Branches', 'offices.view', 'View Branches'),
(33, 31, 'Create Branches', 'offices.create', 'Create Branches'),
(34, 31, 'Update Branches', 'offices.update', 'Update Branches'),
(35, 31, 'Delete Branches', 'offices.delete', 'Delete Branches'),
(36, 0, 'Clients', 'clients', 'Access Clients Module'),
(37, 36, 'View Clients', 'clients.view', 'View Clients'),
(38, 36, 'Create Clients', 'clients.create', 'Create Clients'),
(39, 36, 'Update Clients', 'clients.update', 'Update Clients'),
(40, 36, 'Delete Clients', 'clients.delete', 'Delete Clients'),
(41, 36, 'Approve Clients', 'clients.approve', 'Approve Clients'),
(42, 36, 'Close Client', 'clients.close', 'Close Client'),
(43, 36, 'View  Client Pending approval', 'clients.pending_approval', 'View  Client Pending approval'),
(44, 36, 'View Closed Clients', 'clients.closed', 'View Closed Clients'),
(45, 36, 'Create Client Document', 'clients.documents.create', 'Create Client Document'),
(46, 36, 'Read Client Document', 'clients.documents.view', 'Read Client Document'),
(47, 36, 'Delete Client Document', 'clients.documents.delete', 'Delete Client Document'),
(48, 36, 'Update Client Document', 'clients.documents.update', 'Update Client Document'),
(49, 36, 'Read Next Of Kin', 'clients.next_of_kin.view', 'Read Next Of Kin'),
(50, 36, 'Create Next Of Kin', 'clients.next_of_kin.create', 'Create Next Of Kin'),
(51, 36, 'Update Next Of Kin', 'clients.next_of_kin.update', 'Update Next Of Kin'),
(52, 36, 'Delete Next Of Kin', 'clients.next_of_kin.delete', 'Delete Next Of Kin'),
(53, 36, 'Read Client Identifiers', 'clients.identification.view', 'Read Client Identifiers'),
(54, 36, 'Create Client Identifiers', 'clients.identification.create', 'Create Client Identifiers'),
(55, 36, 'Update Client Identifiers', 'clients.identification.update', 'Update Client Identifiers'),
(56, 36, 'Delete Client identifier', 'clients.identification.delete', 'Delete Client identifier'),
(57, 36, 'Read Client notes', 'clients.notes.view', 'Read Client notes'),
(58, 36, 'Create Client notes', 'clients.notes.create', 'Create Client notes'),
(59, 36, 'Update Client notes', 'clients.notes.update', 'Update Client notes'),
(60, 36, 'Delete Client notes', 'clients.notes.delete', 'Delete Client notes'),
(61, 36, 'Read Client Accounts', 'clients.accounts.view', 'Read Client Accounts'),
(62, 36, 'Transfer Client', 'clients.transfer.client', 'Transfer Client'),
(63, 36, 'Approve Client Transfer', 'clients.transfer.approve', 'Approve Client Transfer'),
(64, 0, 'Groups', 'groups', 'Access Groups Module'),
(65, 64, 'View Groups', 'groups.view', 'View Groups'),
(66, 64, 'Create Group', 'groups.create', 'Create Group'),
(67, 64, 'Approve Group', 'groups.approve', 'Approve Group'),
(68, 64, 'Update Groups', 'groups.update', 'Update Groups'),
(69, 64, 'Add Client to Group', 'groups.client.create', 'Add Client to Group'),
(70, 64, 'Remove Client', 'groups.client.delete', 'Remove Client'),
(71, 64, 'View Group Document', 'groups.documents.view', 'View  Group Document'),
(72, 64, 'Add Group Document', 'groups.documents.create', 'Add Group Document'),
(73, 64, 'Update Group Document', 'groups.documents.update', 'Update Group Document'),
(74, 64, 'Delete Group Document', 'groups.documents.delete', 'Delete Group Document'),
(75, 64, 'View Group Note', 'groups.notes.view', 'View Group Note'),
(76, 64, 'Create Group Note', 'groups.notes.create', 'Create Group Note'),
(77, 64, 'Update Group Note', 'groups.notes.update', 'Update Group Note'),
(78, 64, 'Delete Group Note', 'groups.notes.delete', 'Delete Group Note'),
(79, 64, 'View Assigned Groups', 'groups.view_assigned', 'View Assigned Groups'),
(80, 64, 'View Created', 'groups.view_created', 'View Created'),
(81, 36, 'View Assigned', 'clients.view_assigned', 'View Assigned'),
(82, 36, 'View Created', 'clients.view_created', 'View Created'),
(83, 0, 'Loans', 'loans', 'Access Loans Module'),
(84, 83, 'View Loans', 'loans.view', 'View Loans'),
(85, 83, 'View Pending Loans', 'loans.pending_approval', 'View Pending Loans'),
(86, 64, 'View Groups Pending Approval', 'groups.pending_approval', 'View Groups Pending Approval'),
(87, 83, 'Awaiting Disbursement', 'loans.awaiting_disbursement', 'Loans Awaiting Disbursement'),
(88, 83, 'Loans Declined', 'loans.declined', 'View Loans Declined'),
(89, 83, 'View Loans Written Off', 'loans.written_off', 'View Loans Written Off'),
(90, 83, 'View Loans Closed', 'loans.closed', 'View Loans Closed'),
(91, 83, 'View Loans Rescheduled', 'loans.rescheduled', 'View Loans Rescheduled'),
(92, 83, 'View Loans Evaluated', 'loans.evaluated', 'View Loans Evaluated'),
(93, 83, 'Create Loans', 'loans.create', 'Create Loans'),
(94, 83, 'Update Loans', 'loans.update', 'Update Loans'),
(95, 83, 'Approve Loan', 'loans.approve', 'Approve Loan'),
(96, 83, 'Disburse Loans', 'loans.disburse', 'Disburse Loans'),
(97, 83, 'Undo Approval', 'loans.undo_approval', 'Disburse Loans'),
(98, 83, 'Undo Disbursement', 'loans.undo_disbursement', 'Undo Disbursement'),
(99, 83, 'Write off loan', 'loans.write_off', 'Write off loan'),
(100, 83, 'Undo Write off', 'loans.undo_write_off', 'Undo Write off'),
(101, 83, 'Waive Loan Interest', 'loans.waive_interest', 'Waive Loan Interest'),
(102, 83, 'Apply charge to loan', 'loans.charge.create', 'Apply charge to loan'),
(103, 83, 'Waive Loan Charge', 'loans.charge.waive', 'Waive Loan Charge'),
(104, 83, 'View Assigned Loans', 'loans.view_assigned', 'View Assigned Loans'),
(105, 83, 'Create Loan Reschedule', 'loans.reschedule.create', 'Create Loan Reschedule'),
(106, 83, 'Make Repayment', 'loans.transactions.create', 'Make Repayment'),
(107, 83, 'View Transactions', 'loans.transactions.view', 'View Transactions'),
(108, 83, 'Approve Loan Repayment', 'loans.transactions.approve', 'Approve Loan Repayment'),
(109, 83, 'Adjust Loan Transaction', 'loans.transactions.update', 'Adjust Loan Transaction'),
(110, 83, 'View System Reversed Transactions', 'loans.transactions.system_reversed', 'View System Reversed Transactions'),
(111, 83, 'View Loan Repayment Schedule', 'loans.view_repayment_schedule', 'View Loan Repayment Schedule'),
(112, 83, 'View Loan Documents', 'loans.documents.view', 'View Loan Documents'),
(113, 83, 'Create Loan Documents', 'loans.documents.create', 'Create Loan Documents'),
(114, 83, 'Update Loan Documents', 'loans.documents.update', 'Update Loan Documents'),
(115, 83, 'Delete Loan Documents', 'loans.documents.delete', 'Delete Loan Documents'),
(116, 83, 'View Collateral', 'loans.collateral.view', 'View Collateral'),
(117, 83, 'Create Collateral', 'loans.collateral.create', 'Create Collateral'),
(118, 83, 'Update Collateral', 'loans.collateral.update', 'Update Collateral'),
(119, 83, 'Delete Collateral', 'loans.collateral.delete', 'Delete Collateral'),
(120, 83, 'View Guarantors', 'loans.guarantors.view', 'View Guarantors'),
(121, 83, 'Create Guarantors', 'loans.guarantors.create', 'Create Guarantors'),
(122, 83, 'Update Guarantors', 'loans.guarantors.update', 'Update Guarantors'),
(123, 83, 'Delete Guarantors', 'loans.guarantors.delete', 'Delete Guarantors'),
(124, 83, 'View Loan Notes', 'loans.notes.view', 'View Loan Notes'),
(125, 83, 'Create Loan Notes', 'loans.notes.create', 'Create Loan Notes'),
(126, 83, 'Update Loan Notes', 'loans.notes.update', 'Update Loan Notes'),
(127, 83, 'Delete Loan Notes', 'loans.notes.delete', 'Delete Loan Notes'),
(128, 83, 'View Group Allocation', 'loans.view_group_allocation', 'View Group Allocation'),
(129, 83, 'View Client Details', 'loans.view_client_details', 'View Client Details'),
(130, 83, 'Email Schedule', 'loans.email_schedule', 'Email Schedule'),
(131, 83, 'Pdf Schedule', 'loans.pdf_schedule', 'Pdf Schedule'),
(132, 0, 'Savings', 'savings', 'Access Savings Module'),
(133, 132, 'View Savings', 'savings.view', 'View Savings'),
(134, 132, 'View Savings Pending Approval', 'savings.pending_approval', 'View Savings Pending Approval'),
(135, 132, 'View Approved Savings Accounts', 'savings.approved', 'View Approved Savings Accounts'),
(136, 132, 'View Savings Closed', 'savings.closed', 'View Savings Closed'),
(137, 132, 'Create Savings', 'savings.create', 'Create Savings'),
(138, 132, 'Update Savings', 'savings.update', 'Update Savings'),
(139, 132, 'Delete Savings', 'savings.delete', 'Delete Savings'),
(140, 132, 'Approve Savings', 'savings.approve', 'Approve Savings'),
(141, 132, 'Undo Approval', 'savings.undo_approval', 'Undo Approval'),
(142, 132, 'Close Savings Account', 'savings.close', 'Close Savings Account'),
(143, 132, 'View Transactions', 'savings.transactions.view', 'View Transactions'),
(144, 132, 'Create Transactions', 'savings.transactions.create', 'Create Transactions'),
(145, 132, 'Update Transactions', 'savings.transactions.update', 'Update Transactions'),
(146, 132, 'Delete Transactions', 'savings.transactions.delete', 'Delete Transaction'),
(147, 132, 'View Documents', 'savings.documents.view', 'View Documents'),
(148, 132, 'Create Savings Documents', 'savings.documents.create', 'Create Savings Documents'),
(149, 132, 'Update Savings Documents', 'savings.documents.update', 'Update Savings Documents'),
(150, 132, 'Delete Savings Documents', 'savings.documents.delete', 'Delete Savings Documents'),
(151, 132, 'View Savings Notes', 'savings.notes.view', 'View Savings Notes'),
(152, 132, 'Create Savings Notes', 'savings.notes.create', 'Create Savings Notes'),
(153, 132, 'Update Savings Notes', 'savings.notes.update', 'Update Savings Notes'),
(154, 132, 'Delete Savings Notes', 'savings.notes.delete', 'Delete Savings Notes'),
(155, 132, 'Post Interest', 'savings.post_interest', 'Post Interest'),
(156, 132, 'Email Statement', 'savings.email_statement', 'Email Statement'),
(157, 132, 'Pdf Statement', 'savings.pdf_statement', 'Pdf Statement'),
(158, 132, 'Add Charge To Savings Account', 'savings.charge.create', 'Add Charge To Savings Account'),
(159, 132, 'Waive Saving Account Charge', 'savings.charge.waive', 'Waive Saving Account Charge'),
(160, 132, 'Approve Savings Transaction', 'savings.transactions.approve', 'Approve Savings Transaction'),
(161, 132, 'Make Deposit', 'savings.transactions.deposit', 'Make Deposit'),
(162, 132, 'Make Withdrawal', 'savings.transactions.withdrawal', 'Make Withdrawal'),
(163, 0, 'Products', 'products', 'Access Savings & Loan Products and related modules'),
(164, 163, 'View Charges', 'products.charges.view', 'View Charges'),
(165, 163, 'Create Charge', 'products.charges.create', 'Create Charge'),
(166, 163, 'Update Charge', 'products.charges.update', 'Update Charge'),
(167, 163, 'Delete Charge', 'products.charge.delete', 'Delete Charge'),
(168, 163, 'View Currencies', 'products.currencies.view', 'View Currencies'),
(169, 163, 'Create Currency', 'products.currencies.create', 'Create Currency'),
(170, 163, 'Update Currency', 'products.currencies.update', 'Update Currency'),
(171, 163, 'Delete Currencies', 'products.currencies.delete', 'Delete Currencies'),
(172, 163, 'Funds', 'products.funds.view', 'Funds'),
(173, 163, 'Create Funds', 'products.funds.create', 'Create Funds'),
(174, 163, 'Update Funds', 'products.funds.update', 'Update Funds'),
(175, 163, 'Delete Funds', 'products.funds.delete', 'Delete Funds'),
(176, 163, 'View Payment Types', 'products.payment_types.view', 'View Payment Types'),
(177, 163, 'Create Payment types', 'products.payment_types.create', 'Create Payment types'),
(178, 163, 'Update Payment Types', 'products.payment_types.update', 'Update Payment Types'),
(179, 163, 'Delete Payment Types', 'products.payment_types.delete', 'Delete Payment Types'),
(180, 163, 'View Loan Purpose', 'products.loan_purposes.view', 'View Loan Purpose'),
(181, 163, 'Create Loan Purpose', 'products.loan_purposes.create', 'Create Loan Purpose'),
(182, 163, 'Delete Loan Purpose', 'products.loan_purposes.delete', 'Delete Loan Purpose'),
(183, 163, 'Update Loan Purpose', 'products.loan_purposes.update', 'Update Loan Purpose'),
(184, 163, 'View Collateral Types', 'products.collateral_types.view', 'View Collateral Types'),
(185, 163, 'Create Collateral Types', 'products.collateral_types.create', 'Create Collateral Types'),
(186, 163, 'Update Collateral Types', 'products.collateral_types.update', 'Update Collateral Types'),
(187, 163, 'Delete Collateral Types', 'products.collateral_types.delete', 'Delete Collateral Types'),
(188, 163, 'View Client Relationship', 'products.client_relationships.view', 'View Client Relationship'),
(189, 163, 'Create Client Relationship', 'products.client_relationships.create', 'Create Client Relationship'),
(190, 163, 'Update Client Relationship', 'products.client_relationships.update', 'Update Client Relationship'),
(191, 163, 'Delete Client Relationship', 'products.client_relationships.delete', 'Delete Client Relationship'),
(192, 163, 'View Client Identification Type', 'products.client_identification_types.view', 'View Client Identification Type'),
(193, 163, 'Create Client Identification Type', 'products.client_identification_types.create', 'Create Client Identification Type'),
(194, 163, 'Update Client Identification Type', 'products.client_identification_types.update', 'Update Client Identification Type'),
(195, 163, 'Delete Client Identification Type', 'products.client_identification_types.delete', 'Delete Client Identification Type'),
(196, 163, 'Manage Loan Provisioning Criteria', 'products.loan_provisioning_criteria.update', 'Manage Loan Provisioning Criteria'),
(197, 163, 'View Loan Products', 'products.loan_products.view', 'View Loan Products'),
(198, 163, 'Create Loan Products', 'products.loan_products.create', 'Create Loan Products'),
(199, 163, 'Update Loan Products', 'products.loan_products.update', 'Update Loan Products'),
(200, 163, 'Delete Loan Products', 'products.loan_products.delete', 'Delete Loan Products'),
(201, 163, 'View Savings Products', 'products.savings_products.view', 'View Savings Products'),
(202, 163, 'Create Savings Products', 'products.savings_products.create', 'Create View Savings Products'),
(203, 163, 'Update Savings Products', 'products.savings_products.update', 'Update Savings Products'),
(204, 163, 'Delete Savings Products', 'products.savings_products.delete', 'Delete Savings Products'),
(205, 0, 'Reports', 'reports', 'Access Reports Module'),
(206, 205, 'Downloading/Exporting of Reports', 'reports.downloading_exporting_of_reports', 'Downloading/Exporting of Reports'),
(207, 205, 'Client Reports', 'reports.client_reports', 'Access Client Reports Menu'),
(208, 205, 'Loan Reports', 'reports.loan_reports', 'Access Loan Reports Menu'),
(209, 205, 'Financial Reports', 'reports.financial_reports', 'Financial Reports'),
(210, 205, 'Savings Reports', 'reports.savings_reports', 'Access Savings Reports Menu'),
(211, 205, 'Reports Scheduler', 'reports.reports_scheduler', 'Access Reports Scheduler Menu'),
(212, 205, 'Client Numbers Report', 'reports.client_numbers_report', 'Client Numbers Report'),
(213, 205, 'Collection Sheet', 'reports.collection_sheet', 'Collection Sheet'),
(214, 205, 'Repayments Report', 'reports.repayments_report', 'Repayments Report'),
(215, 205, 'Expected Repayment', 'reports.expected_repayment', 'Expected Repayment'),
(216, 205, 'Arrears Report', 'reports.arrears_report', 'Arrears Report'),
(217, 205, 'Disbursed Loans', 'reports.disbursed_loans', 'Disbursed Loans'),
(218, 205, 'Loan Portfolio', 'reports.loan_portfolio', 'Loan Portfolio'),
(219, 205, 'Balance Sheet', 'reports.balance_sheet', 'Balance Sheet'),
(220, 205, 'Trial Balance', 'reports.trial_balance', 'Trial Balance'),
(221, 205, 'Income Statement', 'reports.income_statement', 'Income Statement'),
(222, 205, 'Provisioning', 'reports.provisioning', 'Provisioning'),
(223, 205, 'Journals Report', 'reports.journals_report', 'Journals Report'),
(224, 205, 'Savings Transactions', 'reports.savings_transactions', 'Savings Transactions'),
(225, 205, 'Savings Accounts Report', 'reports.savings_accounts_report', 'Savings Accounts Report'),
(226, 205, 'View Report Scheduler', 'reports.reports_scheduler.view', 'View Report Scheduler'),
(227, 205, 'Create Report Scheduler', 'reports.reports_scheduler.create', 'Create Report Scheduler'),
(228, 205, 'Update Report Scheduler', 'reports.reports_scheduler.update', 'Update Report Scheduler'),
(229, 205, 'Delete Report Scheduler', 'reports.reports_scheduler.delete', 'Delete Report Scheduler'),
(230, 0, 'Communication', 'communication', 'Access Communication Module'),
(231, 230, 'View Campaigns', 'communication.view', 'View Campaigns'),
(232, 230, 'Create Campaign', 'communication.create', 'Create Campaign'),
(233, 230, 'Update Campaign', 'communication.update', 'Update Campaign'),
(234, 230, 'Delete Campaign', 'communication.delete', 'Delete Campaign'),
(235, 230, 'Approve Campaign', 'communication.approve', 'Approve Campaign'),
(236, 0, 'Dashboard', 'dashboard', 'Dashboard'),
(237, 236, 'Loans Disbursed', 'dashboard.loans_disbursed', 'View Loans Disbursed'),
(238, 236, 'Total Repayments', 'dashboard.total_repayments', 'Total Repayments'),
(239, 236, 'Total Outstanding', 'dashboard.total_outstanding', 'Total Outstanding'),
(240, 236, 'Amount in Arrears', 'dashboard.amount_in_arrears', 'Amount in Arrears'),
(241, 236, 'Fees Earned', 'dashboard.fees_earned', 'Fees Earned'),
(242, 236, 'Fees Paid', 'dashboard.fees_paid', 'Fees Paid'),
(243, 236, 'Penalties Paid', 'dashboard.penalties_paid', 'Penalties Paid'),
(244, 236, 'Penalties Earned', 'dashboard.penalties_earned', 'Penalties Earned'),
(245, 236, 'Loans Status Overview', 'dashboard.loans_status_overview', 'Loans Status Overview'),
(246, 236, 'Clients Overview', 'dashboard.clients_overview', 'Clients Overview'),
(247, 236, 'Savings Balances Overview', 'dashboard.savings_balances_overview', 'Savings Balances Overview'),
(248, 236, 'My Loan Repayments', 'dashboard.my_loan_repayments', 'My Loan Repayments'),
(249, 236, 'My Disbursed loans', 'dashboard.my_disbursed_loans', 'My Disbursed loans'),
(250, 236, 'My Number of outstanding loans', 'dashboard.my_number_of_outstanding_loans', 'My Number of outstanding loans'),
(251, 236, 'My Outstanding Loan balance', 'dashboard.my_outstanding_loan_balance', 'My Outstanding Loan balance'),
(252, 236, 'My Clients', 'dashboard.my_clients', 'My Clients'),
(253, 236, 'My written off Amount', 'dashboard.my_written_off_amount', 'My written off Amount'),
(254, 236, 'Collection Statistics', 'dashboard.collection_statistics', 'Collection Statistics'),
(255, 0, 'Custom Fields', 'custom_fields', 'Access Custom Fields'),
(256, 255, 'View Custom Fields', 'custom_fields.view', 'View Custom Fields'),
(257, 255, 'Create Custom Fields', 'custom_fields.create', 'Create Custom Fields'),
(258, 255, 'Update Custom Fields', 'custom_fields.update', 'Update Custom Fields'),
(259, 255, 'Delete Custom Fields', 'custom_fields.delete', 'Delete Custom Fields'),
(260, 0, 'Assets', 'assets', 'Access assets module'),
(261, 260, 'View Assets', 'assets.view', 'View Assets'),
(262, 260, 'Create Assets', 'assets.create', 'Create Assets'),
(263, 260, 'Update Assets', 'assets.update', 'Update Assets'),
(264, 260, 'Delete Assets', 'assets.delete', 'Delete Assets'),
(265, 260, 'View Asset Types', 'assets.types.view', 'View Asset Types'),
(266, 260, 'Create  Asset Types', 'assets.types.create', 'Create  Asset Types'),
(267, 260, 'Update Asset Types', 'assets.types.update', 'Update Asset Types'),
(268, 260, 'Delete Asset Types', 'assets.types.delete', 'Delete Asset Types'),
(269, 0, 'Expenses', 'expenses', 'View Expenses Module'),
(270, 269, 'View Expenses Module', 'expenses.view', 'View Expenses Module'),
(271, 269, 'Create Expenses', 'expenses.create', 'Create Expenses Module'),
(272, 269, 'Update Expenses', 'expenses.update', 'Update Expenses'),
(273, 269, 'Delete Expenses', 'expenses.delete', 'Delete Expenses'),
(274, 269, 'View Expense Types', 'expenses.types.view', 'View Expense Types'),
(275, 269, 'Create Expenses Types', 'expenses.types.create', 'Create Expenses Types'),
(276, 269, 'Update Expenses Types', 'expenses.types.update', 'Update Expenses Types'),
(277, 269, 'Delete Expense Types', 'expenses.types.delete', 'Delete Expense Types'),
(278, 0, 'Other Income', 'other_income', 'View Other Income'),
(279, 278, 'View Other Income', 'other_income.view', 'View Other Income'),
(280, 278, 'Create Other Income', 'other_income.create', 'Create Other Income'),
(281, 278, 'Update Other Income', 'other_income.update', 'Update Other Income'),
(282, 278, 'Delete Other Income', 'other_income.delete', 'Delete Other Income'),
(283, 278, 'View Other Income types', 'other_income.types.view', 'View Other Income types'),
(284, 278, 'Create Other Income types', 'other_income.types.create', 'Create Other Income types'),
(285, 278, 'Update Other Income types', 'other_income.types.update', 'Update Other Income types'),
(286, 278, 'Delete Other Income types', 'other_income.types.delete', 'Delete Other Income types'),
(287, 269, 'View Budget', 'expenses.budget.view', 'View Budget'),
(288, 269, 'Create Budget', 'expenses.budget.create', 'Create Budget'),
(289, 269, 'Update Budget', 'expenses.budget.update', 'Update Budget'),
(290, 269, 'Delete Budget', 'expenses.budget.delete', 'Delete Budget'),
(291, 0, 'Payroll', 'payroll', 'Access Payroll templates'),
(292, 291, 'View Payroll', 'payroll.view', 'View Payroll'),
(293, 291, 'Create Payroll', 'payroll.create', NULL),
(294, 291, 'Update Payroll', 'payroll.update', NULL),
(295, 291, 'Delete Payroll', 'payroll.delete', NULL),
(296, 0, 'Grants', 'grants', 'Access Grants Menu'),
(297, 296, 'View Grants', 'grants.view', 'View Grants'),
(298, 296, 'Create Grant', 'grants.create', NULL),
(299, 296, 'Update Grant', 'grants.update', NULL),
(300, 296, 'Delete Grant', 'grants.delete', NULL),
(301, 296, 'Approve Grants', 'grants.approve', NULL),
(302, 296, 'Undo approval', 'grants.undo_approval', NULL),
(303, 296, 'Disburse Grants', 'grants.disburse', NULL),
(304, 296, 'Undo disbursement', 'grants.undo_disbursement', NULL),
(305, 296, 'View Grants Pending Approval', 'grants.pending_approval', NULL),
(306, 296, 'View Grants Awaiting Disbursement', 'grants.awaiting_disbursement', NULL),
(307, 296, 'View Grants Declined', 'grants.declined', NULL),
(308, 296, 'View Documents', 'grants.documents.view', NULL),
(309, 296, 'Create Documents', 'grants.documents.create', NULL),
(310, 296, 'Update Documents', 'grants.documents.update', NULL),
(311, 296, 'Delete Documents', 'grants.documents.delete', NULL),
(312, 296, 'View Notes', 'grants.notes.view', NULL),
(313, 296, 'Create Notes', 'grants.notes.create', NULL),
(314, 296, 'Update Notes', 'grants.notes.update', NULL),
(315, 296, 'Delete Notes', 'grants.notes.delete', NULL),
(316, 236, 'Grants Status Overview', 'dashboard.grants_status_overview', NULL),
(317, 236, 'Grants Disbursement Overview', 'dashboard.grants_disbursement_overview', NULL),
(318, 205, 'Grant Reports', 'reports.grant_reports', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `persistences`
--

CREATE TABLE `persistences` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `persistences`
--

INSERT INTO `persistences` (`id`, `user_id`, `code`, `created_at`, `updated_at`) VALUES
(1, 1, 'aSCBYGGAtOVGQC8YJ3KYoEPZU0El5pid', '2018-06-28 11:09:05', '2018-06-28 11:09:05'),
(2, 1, 'C3ven4aZInNSbKFynqzyJQ3OouHnrURF', '2018-06-28 11:31:01', '2018-06-28 11:31:01'),
(3, 1, 'hbMpDrBs9VS8cARy6XqLt4fwOTCLosZx', '2018-07-01 08:34:37', '2018-07-01 08:34:37'),
(4, 1, 'TZ9WAi7AukovZIvTznEZc56HMfnZWu4O', '2018-07-01 08:50:58', '2018-07-01 08:50:58'),
(5, 1, 'zozHSSxUCjAUhwO0yU3tPl9lfmZvI47G', '2018-07-01 09:00:18', '2018-07-01 09:00:18'),
(6, 1, 'a2rR59dznzzFyfnwcnoVmwFZZqeIUlOU', '2018-07-01 09:01:14', '2018-07-01 09:01:14'),
(7, 1, '9d2BUBET8GZlxf9NluWE9tLanSUJqq0L', '2018-07-01 09:02:10', '2018-07-01 09:02:10'),
(8, 1, '8mzduCYmFsVGyuDuAiL8fT0cjtEmvH3f', '2018-07-01 09:02:10', '2018-07-01 09:02:10'),
(9, 1, 'mYDpCxXpgwXjrwfQToeFbivdwBjebRVx', '2018-07-02 07:38:15', '2018-07-02 07:38:15'),
(10, 1, 'SuV0m6Pdvlfq78in2EtjRnPj9RvMsshV', '2018-07-03 05:37:12', '2018-07-03 05:37:12'),
(11, 1, 'sQQKH7E6eVhwwlILy6chQ007HeqefYrr', '2018-07-04 04:56:45', '2018-07-04 04:56:45'),
(12, 1, 'AtGMcUZWNVgvIfxXJ5w26TChuQpMd78v', '2018-07-04 06:11:03', '2018-07-04 06:11:03'),
(13, 1, 'CavDuNJqWNjMDBdCmJrQ9szAjON3nk8C', '2018-07-04 10:52:15', '2018-07-04 10:52:15'),
(14, 1, 'rC3bkpXQEPl4RkQtjAIutGMpdLfH34fh', '2018-07-04 11:42:42', '2018-07-04 11:42:42'),
(15, 1, 'CR83kNwwHj2U6vVPd4UgeV8peA63u5Ih', '2018-07-04 12:55:20', '2018-07-04 12:55:20'),
(16, 2, 'XTefIF0OADFMiLkGXkJgehz4FMTNLN2q', '2018-07-04 13:24:25', '2018-07-04 13:24:25'),
(17, 1, 'TDJwWeLDWcKvapYCmof86augOME7rveb', '2018-07-04 13:25:09', '2018-07-04 13:25:09'),
(18, 2, 'XM5X4AiOx8sbC5QlQ6rlKwZqTK41NXI2', '2018-07-04 13:25:48', '2018-07-04 13:25:48'),
(19, 1, 'bjxKEy1bIY4nNJ8T5qEfhch35ETj14I5', '2018-07-04 16:48:03', '2018-07-04 16:48:03'),
(20, 1, 'DZElPYPFytfy3FnJbqJOFyPRnk4UtHdm', '2018-07-04 16:59:27', '2018-07-04 16:59:27'),
(21, 1, 'DXxQp4XLmY6O3GQFsUL7Vd0VNwqasPIR', '2018-07-04 17:50:38', '2018-07-04 17:50:38'),
(22, 1, 'tJ8zNh4dSIFXKYOQlzjet1FKAtBBRwNY', '2018-07-05 07:40:30', '2018-07-05 07:40:30'),
(23, 1, 'V7xFgSLnzm2RnLvU22QUteC0QrPtfalt', '2018-07-05 09:46:40', '2018-07-05 09:46:40'),
(24, 1, 's0I0tZbEttI9DXR0BgqcMrZoJlyST0j2', '2018-07-05 11:46:44', '2018-07-05 11:46:44'),
(25, 2, 'mRfZ4UxjC2S3RHgyOYFeqoxFd6bIXb5W', '2018-07-05 12:21:16', '2018-07-05 12:21:16'),
(26, 1, 'SdbqNTvUxpcH5AuI7Gmr0XTSGgSHNX4W', '2018-07-05 12:30:17', '2018-07-05 12:30:17'),
(27, 2, 'i5UOYnMVEYQalhgJg92ty7qLOGXyUpCZ', '2018-07-05 16:43:48', '2018-07-05 16:43:48');

-- --------------------------------------------------------

--
-- Table structure for table `reminders`
--

CREATE TABLE `reminders` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `completed` tinyint(1) NOT NULL DEFAULT '0',
  `completed_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `report_scheduler`
--

CREATE TABLE `report_scheduler` (
  `id` int(10) UNSIGNED NOT NULL,
  `created_by_id` int(11) DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `report_start_date` date DEFAULT NULL,
  `report_start_time` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `recurrence_type` enum('none','schedule') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `recur_frequency` enum('daily','monthly','weekly','yearly') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `recur_interval` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_recipients` text COLLATE utf8mb4_unicode_ci,
  `email_subject` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_message` text COLLATE utf8mb4_unicode_ci,
  `email_attachment_file_format` enum('pdf','csv','xls') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `report_category` enum('client_report','loan_report','financial_report','group_report','savings_report','organisation_report') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `report_name` enum('disbursed_loans_report','loan_portfolio_report','expected_repayments_report','repayments_report','collection_report','arrears_report','balance_sheet','trial_balance','profit_and_loss','cash_flow','provisioning','historical_income_statement','journals_report','accrued_interest','client_numbers_report','clients_overview','top_clients_report','loan_sizes_report','group_report','group_breakdown','savings_account_report','savings_balance_report','savings_transaction_report','fixed_term_maturity_report','products_summary','individual_indicator_report','loan_officer_performance_report','audit_report','group_indicator_report') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `start_date_type` enum('date_picker','today','yesterday','tomorrow') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date_type` enum('date_picker','today','yesterday','tomorrow') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `office_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `loan_officer_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gl_account_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `manual_entries` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `loan_status` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `loan_product_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_run_date` date DEFAULT NULL,
  `next_run_date` date DEFAULT NULL,
  `last_run_time` date DEFAULT NULL,
  `next_run_time` date DEFAULT NULL,
  `number_of_runs` int(11) NOT NULL DEFAULT '0',
  `active` tinyint(4) NOT NULL DEFAULT '1',
  `status` enum('pending','approved','declined') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `approved_by_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `report_scheduler_run_history`
--

CREATE TABLE `report_scheduler_run_history` (
  `id` int(10) UNSIGNED NOT NULL,
  `report_schedule_id` int(11) DEFAULT NULL,
  `report_start_date` date DEFAULT NULL,
  `report_start_time` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` int(10) UNSIGNED NOT NULL,
  `slug` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `time_limit` tinyint(4) NOT NULL DEFAULT '0',
  `from_time` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `to_time` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `access_days` text COLLATE utf8mb4_unicode_ci,
  `permissions` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `slug`, `name`, `time_limit`, `from_time`, `to_time`, `access_days`, `permissions`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'Admin', 0, NULL, NULL, '[]', '{\"users\":true,\"users.view\":true,\"users.create\":true,\"users.update\":true,\"users.delete\":true,\"users.roles.view\":true,\"users.roles.create\":true,\"users.roles.update\":true,\"users.roles.delete\":true,\"users.roles.assign\":true,\"settings\":true,\"settings.update\":true,\"settings.general.view\":true,\"settings.organisation.view\":true,\"accounting\":true,\"accounting.gl_accounts.view\":true,\"accounting.gl_accounts.create\":true,\"accounting.gl_accounts.update\":true,\"accounting.gl_accounts.delete\":true,\"accounting.journals.view\":true,\"accounting.journals.create\":true,\"accounting.journals.delete\":true,\"accounting.journals.approve\":true,\"accounting.journals.reconciliation.view\":true,\"accounting.journals.reconciliation.create\":true,\"accounting.period.view\":true,\"accounting.period.create\":true,\"accounting.period.delete\":true,\"audit_trail\":true,\"offices\":true,\"offices.view\":true,\"offices.create\":true,\"offices.update\":true,\"offices.delete\":true,\"clients\":true,\"clients.view\":true,\"clients.create\":true,\"clients.update\":true,\"clients.delete\":true,\"clients.approve\":true,\"clients.close\":true,\"clients.pending_approval\":true,\"clients.closed\":true,\"clients.documents.create\":true,\"clients.documents.view\":true,\"clients.documents.delete\":true,\"clients.documents.update\":true,\"clients.next_of_kin.view\":true,\"clients.next_of_kin.create\":true,\"clients.next_of_kin.update\":true,\"clients.next_of_kin.delete\":true,\"clients.identification.view\":true,\"clients.identification.create\":true,\"clients.identification.update\":true,\"clients.identification.delete\":true,\"clients.notes.view\":true,\"clients.notes.create\":true,\"clients.notes.update\":true,\"clients.notes.delete\":true,\"clients.accounts.view\":true,\"clients.transfer.client\":true,\"clients.transfer.approve\":true,\"clients.view_assigned\":true,\"clients.view_created\":true,\"groups\":true,\"groups.view\":true,\"groups.create\":true,\"groups.approve\":true,\"groups.update\":true,\"groups.client.create\":true,\"groups.client.delete\":true,\"groups.documents.view\":true,\"groups.documents.create\":true,\"groups.documents.update\":true,\"groups.documents.delete\":true,\"groups.notes.view\":true,\"groups.notes.create\":true,\"groups.notes.update\":true,\"groups.notes.delete\":true,\"groups.view_assigned\":true,\"groups.view_created\":true,\"groups.pending_approval\":true,\"loans\":true,\"loans.view\":true,\"loans.pending_approval\":true,\"loans.awaiting_disbursement\":true,\"loans.declined\":true,\"loans.written_off\":true,\"loans.closed\":true,\"loans.rescheduled\":true,\"loans.evaluated\":true,\"loans.create\":true,\"loans.update\":true,\"loans.approve\":true,\"loans.disburse\":true,\"loans.undo_approval\":true,\"loans.undo_disbursement\":true,\"loans.write_off\":true,\"loans.undo_write_off\":true,\"loans.waive_interest\":true,\"loans.charge.create\":true,\"loans.charge.waive\":true,\"loans.view_assigned\":true,\"loans.reschedule.create\":true,\"loans.transactions.create\":true,\"loans.transactions.view\":true,\"loans.transactions.approve\":true,\"loans.transactions.update\":true,\"loans.transactions.system_reversed\":true,\"loans.view_repayment_schedule\":true,\"loans.documents.view\":true,\"loans.documents.create\":true,\"loans.documents.update\":true,\"loans.documents.delete\":true,\"loans.collateral.view\":true,\"loans.collateral.create\":true,\"loans.collateral.update\":true,\"loans.collateral.delete\":true,\"loans.guarantors.view\":true,\"loans.guarantors.create\":true,\"loans.guarantors.update\":true,\"loans.guarantors.delete\":true,\"loans.notes.view\":true,\"loans.notes.create\":true,\"loans.notes.update\":true,\"loans.notes.delete\":true,\"loans.view_group_allocation\":true,\"loans.view_client_details\":true,\"loans.email_schedule\":true,\"loans.pdf_schedule\":true,\"savings\":true,\"savings.view\":true,\"savings.pending_approval\":true,\"savings.approved\":true,\"savings.closed\":true,\"savings.create\":true,\"savings.update\":true,\"savings.delete\":true,\"savings.approve\":true,\"savings.undo_approval\":true,\"savings.close\":true,\"savings.transactions.view\":true,\"savings.transactions.create\":true,\"savings.transactions.update\":true,\"savings.transactions.delete\":true,\"savings.documents.view\":true,\"savings.documents.create\":true,\"savings.documents.update\":true,\"savings.documents.delete\":true,\"savings.notes.view\":true,\"savings.notes.create\":true,\"savings.notes.update\":true,\"savings.notes.delete\":true,\"savings.post_interest\":true,\"savings.email_statement\":true,\"savings.pdf_statement\":true,\"savings.charge.create\":true,\"savings.charge.waive\":true,\"savings.transactions.approve\":true,\"savings.transactions.deposit\":true,\"savings.transactions.withdrawal\":true,\"products\":true,\"products.charges.view\":true,\"products.charges.create\":true,\"products.charges.update\":true,\"products.charge.delete\":true,\"products.currencies.view\":true,\"products.currencies.create\":true,\"products.currencies.update\":true,\"products.currencies.delete\":true,\"products.funds.view\":true,\"products.funds.create\":true,\"products.funds.update\":true,\"products.funds.delete\":true,\"products.payment_types.view\":true,\"products.payment_types.create\":true,\"products.payment_types.update\":true,\"products.payment_types.delete\":true,\"products.loan_purposes.view\":true,\"products.loan_purposes.create\":true,\"products.loan_purposes.delete\":true,\"products.loan_purposes.update\":true,\"products.collateral_types.view\":true,\"products.collateral_types.create\":true,\"products.collateral_types.update\":true,\"products.collateral_types.delete\":true,\"products.client_relationships.view\":true,\"products.client_relationships.create\":true,\"products.client_relationships.update\":true,\"products.client_relationships.delete\":true,\"products.client_identification_types.view\":true,\"products.client_identification_types.create\":true,\"products.client_identification_types.update\":true,\"products.client_identification_types.delete\":true,\"products.loan_provisioning_criteria.update\":true,\"products.loan_products.view\":true,\"products.loan_products.create\":true,\"products.loan_products.update\":true,\"products.loan_products.delete\":true,\"products.savings_products.view\":true,\"products.savings_products.create\":true,\"products.savings_products.update\":true,\"products.savings_products.delete\":true,\"reports\":true,\"reports.downloading_exporting_of_reports\":true,\"reports.client_reports\":true,\"reports.loan_reports\":true,\"reports.financial_reports\":true,\"reports.savings_reports\":true,\"reports.reports_scheduler\":true,\"reports.client_numbers_report\":true,\"reports.collection_sheet\":true,\"reports.repayments_report\":true,\"reports.expected_repayment\":true,\"reports.arrears_report\":true,\"reports.disbursed_loans\":true,\"reports.loan_portfolio\":true,\"reports.balance_sheet\":true,\"reports.trial_balance\":true,\"reports.income_statement\":true,\"reports.provisioning\":true,\"reports.journals_report\":true,\"reports.savings_transactions\":true,\"reports.savings_accounts_report\":true,\"reports.reports_scheduler.view\":true,\"reports.reports_scheduler.create\":true,\"reports.reports_scheduler.update\":true,\"reports.reports_scheduler.delete\":true,\"reports.grant_reports\":true,\"communication\":true,\"communication.view\":true,\"communication.create\":true,\"communication.update\":true,\"communication.delete\":true,\"communication.approve\":true,\"dashboard\":true,\"dashboard.loans_disbursed\":true,\"dashboard.total_repayments\":true,\"dashboard.total_outstanding\":true,\"dashboard.amount_in_arrears\":true,\"dashboard.fees_earned\":true,\"dashboard.fees_paid\":true,\"dashboard.penalties_paid\":true,\"dashboard.penalties_earned\":true,\"dashboard.loans_status_overview\":true,\"dashboard.clients_overview\":true,\"dashboard.savings_balances_overview\":true,\"dashboard.my_loan_repayments\":true,\"dashboard.my_disbursed_loans\":true,\"dashboard.my_number_of_outstanding_loans\":true,\"dashboard.my_outstanding_loan_balance\":true,\"dashboard.my_clients\":true,\"dashboard.my_written_off_amount\":true,\"dashboard.collection_statistics\":true,\"dashboard.grants_status_overview\":true,\"dashboard.grants_disbursement_overview\":true,\"custom_fields\":true,\"custom_fields.view\":true,\"custom_fields.create\":true,\"custom_fields.update\":true,\"custom_fields.delete\":true,\"grants\":true,\"grants.view\":true,\"grants.create\":true,\"grants.update\":true,\"grants.delete\":true,\"grants.approve\":true,\"grants.undo_approval\":true,\"grants.disburse\":true,\"grants.undo_disbursement\":true,\"grants.pending_approval\":true,\"grants.awaiting_disbursement\":true,\"grants.declined\":true,\"grants.documents.view\":true,\"grants.documents.create\":true,\"grants.documents.update\":true,\"grants.documents.delete\":true,\"grants.notes.view\":true,\"grants.notes.create\":true,\"grants.notes.update\":true,\"grants.notes.delete\":true}', NULL, '2018-07-05 12:36:42'),
(2, 'client', 'Client', 0, NULL, NULL, '[]', '{}', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `role_users`
--

CREATE TABLE `role_users` (
  `user_id` int(10) UNSIGNED NOT NULL,
  `role_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `role_users`
--

INSERT INTO `role_users` (`user_id`, `role_id`, `created_at`, `updated_at`) VALUES
(1, 1, '2018-06-28 09:08:08', '2018-06-28 09:08:08'),
(2, 2, '2018-07-04 13:25:25', '2018-07-04 13:25:25'),
(3, 1, '2018-07-05 08:17:48', '2018-07-05 08:17:48');

-- --------------------------------------------------------

--
-- Table structure for table `savings`
--

CREATE TABLE `savings` (
  `id` int(10) UNSIGNED NOT NULL,
  `client_type` enum('client','group') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'client',
  `client_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `office_id` int(11) DEFAULT NULL,
  `field_officer_id` int(11) DEFAULT NULL,
  `savings_product_id` int(11) DEFAULT NULL,
  `external_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `account_number` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `currency_id` int(11) DEFAULT NULL,
  `decimals` int(11) NOT NULL DEFAULT '2',
  `interest_rate` decimal(65,4) DEFAULT NULL,
  `allow_overdraft` tinyint(4) NOT NULL DEFAULT '0',
  `minimum_balance` decimal(65,4) DEFAULT NULL,
  `overdraft_limit` decimal(65,4) DEFAULT NULL,
  `interest_compounding_period` enum('daily','monthly','quarterly','biannual','annually') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `interest_posting_period` enum('monthly','quarterly','biannual','annually') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `allow_transfer_withdrawal_fee` tinyint(4) NOT NULL DEFAULT '0',
  `opening_balance` decimal(65,4) DEFAULT NULL,
  `allow_additional_charges` tinyint(4) NOT NULL DEFAULT '0',
  `year_days` enum('360','365') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '365',
  `status` enum('pending','approved','closed','declined','withdrawn') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `created_by_id` int(11) DEFAULT NULL,
  `modified_by_id` int(11) DEFAULT NULL,
  `approved_by_id` int(11) DEFAULT NULL,
  `closed_by_id` int(11) DEFAULT NULL,
  `declined_by_id` int(11) DEFAULT NULL,
  `created_date` date DEFAULT NULL,
  `modified_date` date DEFAULT NULL,
  `approved_date` date DEFAULT NULL,
  `declined_date` date DEFAULT NULL,
  `closed_date` date DEFAULT NULL,
  `month` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `year` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `approved_notes` text COLLATE utf8mb4_unicode_ci,
  `declined_notes` text COLLATE utf8mb4_unicode_ci,
  `closed_notes` text COLLATE utf8mb4_unicode_ci,
  `balance` decimal(65,4) DEFAULT NULL,
  `deposits` decimal(65,4) DEFAULT NULL,
  `interest_earned` decimal(65,4) DEFAULT NULL,
  `interest_posted` decimal(65,4) DEFAULT NULL,
  `interest_overdraft` decimal(65,4) DEFAULT NULL,
  `withdrawals` decimal(65,4) DEFAULT NULL,
  `fees` decimal(65,4) DEFAULT NULL,
  `penalty` decimal(65,4) DEFAULT NULL,
  `start_interest_calculation_date` date DEFAULT NULL,
  `last_interest_calculation_date` date DEFAULT NULL,
  `next_interest_calculation_date` date DEFAULT NULL,
  `next_interest_posting_date` date DEFAULT NULL,
  `last_interest_posting_date` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `savings_charges`
--

CREATE TABLE `savings_charges` (
  `id` int(10) UNSIGNED NOT NULL,
  `savings_id` int(11) DEFAULT NULL,
  `charge_id` int(11) DEFAULT NULL,
  `penalty` tinyint(4) NOT NULL DEFAULT '0',
  `waived` tinyint(4) NOT NULL DEFAULT '0',
  `charge_type` enum('savings_activation','withdrawal_fee','annual_fee','monthly_fee','specified_due_date') COLLATE utf8mb4_unicode_ci NOT NULL,
  `charge_option` enum('flat','percentage') COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` decimal(65,2) DEFAULT NULL,
  `amount_paid` decimal(65,2) DEFAULT NULL,
  `due_date` date DEFAULT NULL,
  `grace_period` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `savings_products`
--

CREATE TABLE `savings_products` (
  `id` int(10) UNSIGNED NOT NULL,
  `created_by_id` int(11) DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `short_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `currency_id` int(11) DEFAULT NULL,
  `decimals` int(11) NOT NULL DEFAULT '2',
  `interest_rate` decimal(65,4) DEFAULT NULL,
  `allow_overdraft` tinyint(4) NOT NULL DEFAULT '0',
  `minimum_balance` decimal(65,4) DEFAULT NULL,
  `interest_compounding_period` enum('daily','monthly','quarterly','biannual','annually') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `interest_posting_period` enum('monthly','quarterly','biannual','annually') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `interest_calculation_type` enum('daily','average') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `allow_transfer_withdrawal_fee` tinyint(4) NOT NULL DEFAULT '0',
  `opening_balance` decimal(65,4) DEFAULT NULL,
  `allow_additional_charges` tinyint(4) NOT NULL DEFAULT '0',
  `year_days` enum('360','365') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '365',
  `accounting_rule` enum('none','cash') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'cash',
  `gl_account_savings_reference_id` int(11) DEFAULT NULL,
  `gl_account_overdraft_portfolio_id` int(11) DEFAULT NULL,
  `gl_account_savings_control_id` int(11) DEFAULT NULL,
  `gl_account_interest_on_savings_id` int(11) DEFAULT NULL,
  `gl_account_savings_written_off_id` int(11) DEFAULT NULL,
  `gl_account_income_interest_id` int(11) DEFAULT NULL,
  `gl_account_income_fee_id` int(11) DEFAULT NULL,
  `gl_account_income_penalty_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `savings_product_charges`
--

CREATE TABLE `savings_product_charges` (
  `id` int(10) UNSIGNED NOT NULL,
  `created_by_id` int(11) DEFAULT NULL,
  `charge_id` int(11) DEFAULT NULL,
  `savings_product_id` int(11) DEFAULT NULL,
  `amount` decimal(65,2) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `grace_period` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `savings_transactions`
--

CREATE TABLE `savings_transactions` (
  `id` int(10) UNSIGNED NOT NULL,
  `created_by_id` int(11) DEFAULT NULL,
  `office_id` int(11) DEFAULT NULL,
  `modified_by_id` int(11) DEFAULT NULL,
  `payment_detail_id` int(11) DEFAULT NULL,
  `savings_id` int(10) UNSIGNED DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT '0.00',
  `debit` decimal(65,4) DEFAULT NULL,
  `credit` decimal(65,4) DEFAULT NULL,
  `balance` decimal(65,4) DEFAULT NULL,
  `transaction_type` enum('deposit','withdrawal','bank_fees','interest','dividend','guarantee','guarantee_restored','fees_payment','transfer_loan','transfer_savings','specified_due_date_fee') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reversible` tinyint(4) NOT NULL DEFAULT '0',
  `reversed` tinyint(4) NOT NULL DEFAULT '0',
  `reversal_type` enum('system','user','none') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'none',
  `status` enum('pending','approved','declined') COLLATE utf8mb4_unicode_ci DEFAULT 'pending',
  `approved_by_id` int(11) DEFAULT NULL,
  `approved_date` date DEFAULT NULL,
  `system_interest` tinyint(4) NOT NULL DEFAULT '0',
  `date` date DEFAULT NULL,
  `time` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `year` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `month` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `balance_date` date DEFAULT NULL,
  `balance_days` int(11) DEFAULT NULL,
  `cumulative_balance_days` int(11) DEFAULT NULL,
  `cumulative_balance` decimal(65,4) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` int(10) UNSIGNED NOT NULL,
  `setting_key` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `setting_value` text COLLATE utf8mb4_unicode_ci
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `setting_key`, `setting_value`) VALUES
(1, 'company_name', 'Capidava Financial'),
(2, 'company_address', 'Suite 608'),
(3, 'company_currency', '37'),
(4, 'company_website', 'capidava.com'),
(5, 'company_country', '180'),
(6, 'system_version', '1.0'),
(7, 'sms_enabled', '1'),
(8, 'active_sms', NULL),
(9, 'portal_address', 'http://www.'),
(10, 'company_email', 'contact@capidava.com'),
(11, 'currency_symbol', '$'),
(12, 'currency_position', 'left'),
(13, 'company_logo', 'lj2k-5z9l8cfw5s83-7wtwn.jpg'),
(14, 'paypal_email', ''),
(15, 'currency', 'USD'),
(16, 'password_reset_subject', 'Password reset instructions'),
(17, 'password_reset_template', '<div class=\"WordSection1\">\r\n<p>{companyLogo}</p>\r\n<p>Hello {firstName} {lastName},</p>\r\n<p>Your password has been reset. Please click the link below to reset it. If you did not request a password reset just ignore this ms</p>\r\n<p>Click <a href=\"{resetLink}\">{resetLink}</a></p>\r\n<p>Best Wishes, <br /> Webstudio Support Team<br /> The Web Specialists</p>\r\n</div>'),
(18, 'payment_received_sms_template', 'Dear {clientName}, we have received your payment of ${paymentAmount} for loan {loanNumber}. New loan balance:${loanBalance}. Thank you'),
(19, 'payment_received_email_template', '<p>Dear {clientName}, we have received your payment of ${paymentAmount} for loan {loanNumber}. New loan balance:${loanBalance}. Thank you</p>\r\n<p>&nbsp;</p>'),
(20, 'payment_received_email_subject', 'Payment Received'),
(21, 'savings_transaction_sms_template', 'Dear {clientName}, a {transactionType}   of ${transactionAmount} was made on your savings {savingsNumber}. New Savings balance:${savingsBalance}. Thank you'),
(22, 'savings_transaction_email_template', '<p>Dear {clientName}, a {transactionType} of ${transactionAmount} was made on your savings {savingsNumber}. New Savings balance:${savingsBalance}. Thank you</p>'),
(23, 'savings_transaction_email_subject', 'New Transaction'),
(24, 'payment_email_subject', 'Payment Receipt'),
(25, 'payment_email_template', '<p>Dear {clientName}, find attached receipt of your payment of ${paymentAmount} for loan {loanNumber} on {paymentDate}. New loan balance:${loanBalance}. Thank you</p>'),
(26, 'client_statement_email_subject', 'Client Statement'),
(27, 'client_statement_email_template', '<p>Dear {clientName}, find attached statement of your loans with us. Thank you</p>'),
(28, 'loan_statement_email_subject', 'Loan Statement'),
(29, 'loan_statement_email_template', '<p>Dear {clientName}, find attached loan statement for loan {loanNumber}. Thank you</p>'),
(30, 'loan_schedule_email_subject', 'Loan Schedule'),
(31, 'loan_schedule_email_template', '<p>Dear {clientName}, find attached loan schedule for loan {loanNumber}. Thank you</p>'),
(32, 'cron_last_run', ''),
(33, 'auto_apply_penalty', NULL),
(34, 'auto_payment_receipt_sms', '0'),
(35, 'auto_payment_receipt_email', '1'),
(36, 'auto_repayment_sms_reminder', '0'),
(37, 'auto_repayment_email_reminder', '1'),
(38, 'auto_repayment_days', '4'),
(39, 'auto_overdue_repayment_sms_reminder', '0'),
(40, 'auto_overdue_repayment_email_reminder', '1'),
(41, 'auto_overdue_repayment_days', '2'),
(42, 'auto_overdue_loan_sms_reminder', '0'),
(43, 'auto_overdue_loan_email_reminder', '1'),
(44, 'auto_overdue_loan_days', '2'),
(45, 'loan_overdue_email_subject', 'Loan Overdue'),
(46, 'loan_overdue_email_template', '<p>Dear {clientName}, Your loan {loanNumber} is overdue. Please make your payment. Thank you</p>'),
(47, 'loan_overdue_sms_template', 'Dear {clientName}, Your loan {loanNumber} is overdue. Please make your payment. Thank you'),
(48, 'loan_payment_reminder_subject', 'Upcoming Payment Reminder'),
(49, 'loan_payment_reminder_email_template', '<p>Dear {clientName},You have an upcoming payment of {paymentAmount} due on {paymentDate} for loan {loanNumber}. Please make your payment. Thank you</p>'),
(50, 'loan_payment_reminder_sms_template', 'Dear {clientName},You have an upcoming payment of {paymentAmount} due on {paymentDate} for loan {loanNumber}. Please make your payment. Thank you'),
(51, 'missed_payment_email_subject', 'Missed Payment'),
(52, 'missed_payment_email_template', '<p>Dear {clientName},You missed payment of {paymentAmount} which was due on {paymentDate} for loan {loanNumber}. Please make your payment. Thank you</p>'),
(53, 'missed_payment_sms_template', 'Dear {clientName},You missed  payment of {paymentAmount} which was due on {paymentDate} for loan {loanNumber}. Please make your payment. Thank you'),
(54, 'enable_cron', '1'),
(55, 'loan_approved_auto_email', '0'),
(56, 'loan_approved_auto_sms', '0'),
(57, 'loan_disbursed_auto_email', '0'),
(58, 'loan_disbursed_auto_sms', '0'),
(59, 'loan_approved_email_subject', 'Loan Approved'),
(60, 'loan_approved_email_template', '<p>Dear {clientName},Your loan {loanNumber} has been approved, amount {approvedAmount}. Thank you</p>'),
(61, 'loan_approved_sms_template', 'Dear {clientName},Your loan {loanNumber} has been approved, amount {approvedAmount}. Thank you'),
(62, 'loan_disbursed_email_subject', 'Loan Disbursed'),
(63, 'loan_disbursed_email_template', '<p>Dear {clientName},Your loan {loanNumber} has been disbursed.First payment:{firstPaymentDate},amount {firstPaymentAmount}. Thank you</p>'),
(64, 'loan_disbursed_sms_template', 'Dear {clientName},Your loan {loanNumber} has been disbursed.First payment:{firstPaymentDate},amount {firstPaymentAmount}. Thank you'),
(65, 'savings_statement_email_template', 'Dear {clientName},Find your statement for {savingsNumber} attached. Thank you'),
(66, 'allow_self_registration', '1'),
(67, 'allow_client_apply', '1'),
(68, 'enable_google_recaptcha', '0'),
(69, 'google_recaptcha_site_key', NULL),
(70, 'google_recaptcha_secret_key', NULL),
(71, 'update_url', 'http://webstudio.co.zw'),
(72, 'enable_custom_fields', '1'),
(73, 'login_details_email_subject', 'Login Details'),
(74, 'login_details_email_template', 'Dear {clientName},Your login details have been created. Your username is: {email}<br>Password  {password}.You can login <a href=\"{loginUrl}\">here</a> Thank you'),
(75, 'payroll_gl_account_expense_id', NULL),
(76, 'payroll_gl_account_asset_id', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sms_gateways`
--

CREATE TABLE `sms_gateways` (
  `id` int(10) UNSIGNED NOT NULL,
  `created_by_id` int(11) DEFAULT NULL,
  `name` text COLLATE utf8mb4_unicode_ci,
  `from_name` text COLLATE utf8mb4_unicode_ci,
  `to_name` text COLLATE utf8mb4_unicode_ci,
  `url` text COLLATE utf8mb4_unicode_ci,
  `msg_name` text COLLATE utf8mb4_unicode_ci,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `throttle`
--

CREATE TABLE `throttle` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ip` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `throttle`
--

INSERT INTO `throttle` (`id`, `user_id`, `type`, `ip`, `created_at`, `updated_at`) VALUES
(1, NULL, 'global', NULL, '2018-06-28 09:26:47', '2018-06-28 09:26:47'),
(2, NULL, 'ip', '93.122.249.55', '2018-06-28 09:26:47', '2018-06-28 09:26:47'),
(3, NULL, 'global', NULL, '2018-06-28 10:19:47', '2018-06-28 10:19:47'),
(4, NULL, 'ip', '93.122.249.55', '2018-06-28 10:19:47', '2018-06-28 10:19:47'),
(5, NULL, 'global', NULL, '2018-07-04 10:51:59', '2018-07-04 10:51:59'),
(6, NULL, 'ip', '93.122.249.177', '2018-07-04 10:51:59', '2018-07-04 10:51:59'),
(7, 1, 'user', NULL, '2018-07-04 10:51:59', '2018-07-04 10:51:59'),
(8, NULL, 'global', NULL, '2018-07-04 16:47:56', '2018-07-04 16:47:56'),
(9, NULL, 'ip', '78.96.80.67', '2018-07-04 16:47:56', '2018-07-04 16:47:56'),
(10, NULL, 'global', NULL, '2018-07-05 12:20:43', '2018-07-05 12:20:43'),
(11, NULL, 'ip', '95.76.1.232', '2018-07-05 12:20:43', '2018-07-05 12:20:43'),
(12, NULL, 'global', NULL, '2018-07-05 12:20:51', '2018-07-05 12:20:51'),
(13, NULL, 'ip', '95.76.1.232', '2018-07-05 12:20:51', '2018-07-05 12:20:51'),
(14, NULL, 'global', NULL, '2018-07-05 12:20:55', '2018-07-05 12:20:55'),
(15, NULL, 'ip', '95.76.1.232', '2018-07-05 12:20:55', '2018-07-05 12:20:55'),
(16, NULL, 'global', NULL, '2018-07-05 12:21:07', '2018-07-05 12:21:07'),
(17, NULL, 'ip', '95.76.1.232', '2018-07-05 12:21:07', '2018-07-05 12:21:07'),
(18, NULL, 'global', NULL, '2018-07-05 12:21:25', '2018-07-05 12:21:25'),
(19, NULL, 'ip', '95.76.1.232', '2018-07-05 12:21:25', '2018-07-05 12:21:25'),
(20, NULL, 'global', NULL, '2018-07-05 12:21:37', '2018-07-05 12:21:37'),
(21, NULL, 'ip', '95.76.1.232', '2018-07-05 12:21:37', '2018-07-05 12:21:37'),
(22, NULL, 'global', NULL, '2018-07-05 12:26:34', '2018-07-05 12:26:34'),
(23, NULL, 'ip', '109.166.130.2', '2018-07-05 12:26:34', '2018-07-05 12:26:34'),
(24, NULL, 'global', NULL, '2018-07-05 12:28:05', '2018-07-05 12:28:05'),
(25, NULL, 'ip', '149.56.223.241', '2018-07-05 12:28:06', '2018-07-05 12:28:06');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `office_id` int(11) DEFAULT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `permissions` text COLLATE utf8mb4_unicode_ci,
  `last_login` timestamp NULL DEFAULT NULL,
  `first_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gender` enum('male','female','other','unspecified') COLLATE utf8mb4_unicode_ci DEFAULT 'unspecified',
  `enable_google2fa` tinyint(4) NOT NULL DEFAULT '0',
  `blocked` tinyint(4) NOT NULL DEFAULT '0',
  `google2fa_secret` text COLLATE utf8mb4_unicode_ci,
  `address` text COLLATE utf8mb4_unicode_ci,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `time_limit` tinyint(4) NOT NULL DEFAULT '0',
  `from_time` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `to_time` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `access_days` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `office_id`, `email`, `password`, `permissions`, `last_login`, `first_name`, `last_name`, `phone`, `gender`, `enable_google2fa`, `blocked`, `google2fa_secret`, `address`, `notes`, `time_limit`, `from_time`, `to_time`, `access_days`, `created_at`, `updated_at`) VALUES
(1, NULL, 'contact@capidava.com', '$2y$10$rM.aAbmUUUyh4KZF8Qxqj.h4dyloqHuuQNw2DPJgLhs/ng0EyuZyW', NULL, '2018-07-05 12:30:17', 'Capidava Financial', 'Admin', NULL, 'male', 0, 0, NULL, NULL, NULL, 0, NULL, NULL, '[]', '2018-06-28 09:08:08', '2018-07-05 12:30:17'),
(2, NULL, 'cojocarudaniel@icloud.com', '$2y$10$UItFIHeNBu7dbuqTdK56PeoItY.KVjBIjYyNXOToAL5Pq8b5iTcjq', NULL, '2018-07-05 16:43:48', 'Daniel', 'Cojocaru', '0757273779', 'male', 0, 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, '2018-07-04 11:43:32', '2018-07-05 16:43:48'),
(3, NULL, 'george.n@capidava.com', '$2y$10$QEnxzldMJ3ommpPiX0jzJObDQB4OQ8bdIxZnX1s5bqaGYSKcIi8Rm', NULL, NULL, 'Niculae', 'George', '+40733.515.333', 'male', 0, 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, '2018-07-05 08:17:48', '2018-07-05 08:17:48');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `activations`
--
ALTER TABLE `activations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `assets`
--
ALTER TABLE `assets`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `asset_depreciation`
--
ALTER TABLE `asset_depreciation`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `asset_types`
--
ALTER TABLE `asset_types`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `audit_trail`
--
ALTER TABLE `audit_trail`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `charges`
--
ALTER TABLE `charges`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `clients`
--
ALTER TABLE `clients`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `client_identifications`
--
ALTER TABLE `client_identifications`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `client_identification_types`
--
ALTER TABLE `client_identification_types`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `client_next_of_kin`
--
ALTER TABLE `client_next_of_kin`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `client_profession`
--
ALTER TABLE `client_profession`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `client_relationships`
--
ALTER TABLE `client_relationships`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `client_users`
--
ALTER TABLE `client_users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `collateral`
--
ALTER TABLE `collateral`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `collateral_types`
--
ALTER TABLE `collateral_types`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `communication_campaigns`
--
ALTER TABLE `communication_campaigns`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `countries`
--
ALTER TABLE `countries`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `currencies`
--
ALTER TABLE `currencies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `custom_fields`
--
ALTER TABLE `custom_fields`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `custom_fields_meta`
--
ALTER TABLE `custom_fields_meta`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `documents`
--
ALTER TABLE `documents`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `expenses`
--
ALTER TABLE `expenses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `expense_budgets`
--
ALTER TABLE `expense_budgets`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `expense_types`
--
ALTER TABLE `expense_types`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `funds`
--
ALTER TABLE `funds`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `gl_accounts`
--
ALTER TABLE `gl_accounts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `gl_closures`
--
ALTER TABLE `gl_closures`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `gl_journal_entries`
--
ALTER TABLE `gl_journal_entries`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `grants`
--
ALTER TABLE `grants`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `groups`
--
ALTER TABLE `groups`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `group_clients`
--
ALTER TABLE `group_clients`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `group_loan_allocation`
--
ALTER TABLE `group_loan_allocation`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `group_users`
--
ALTER TABLE `group_users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `guarantors`
--
ALTER TABLE `guarantors`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `loans`
--
ALTER TABLE `loans`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `loan_applications`
--
ALTER TABLE `loan_applications`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `loan_charges`
--
ALTER TABLE `loan_charges`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `loan_products`
--
ALTER TABLE `loan_products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `loan_product_charges`
--
ALTER TABLE `loan_product_charges`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `loan_provisioning_criteria`
--
ALTER TABLE `loan_provisioning_criteria`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `loan_purposes`
--
ALTER TABLE `loan_purposes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `loan_repayment_schedules`
--
ALTER TABLE `loan_repayment_schedules`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `loan_reschedule_requests`
--
ALTER TABLE `loan_reschedule_requests`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `loan_transactions`
--
ALTER TABLE `loan_transactions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `loan_transaction_repayment_schedule_mappings`
--
ALTER TABLE `loan_transaction_repayment_schedule_mappings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notes`
--
ALTER TABLE `notes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `offices`
--
ALTER TABLE `offices`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `office_transactions`
--
ALTER TABLE `office_transactions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `other_income`
--
ALTER TABLE `other_income`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `other_income_types`
--
ALTER TABLE `other_income_types`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payment_details`
--
ALTER TABLE `payment_details`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payment_types`
--
ALTER TABLE `payment_types`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payment_type_details`
--
ALTER TABLE `payment_type_details`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payroll`
--
ALTER TABLE `payroll`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payroll_meta`
--
ALTER TABLE `payroll_meta`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payroll_templates`
--
ALTER TABLE `payroll_templates`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payroll_template_meta`
--
ALTER TABLE `payroll_template_meta`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `persistences`
--
ALTER TABLE `persistences`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `persistences_code_unique` (`code`);

--
-- Indexes for table `reminders`
--
ALTER TABLE `reminders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `report_scheduler`
--
ALTER TABLE `report_scheduler`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `report_scheduler_run_history`
--
ALTER TABLE `report_scheduler_run_history`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_slug_unique` (`slug`);

--
-- Indexes for table `role_users`
--
ALTER TABLE `role_users`
  ADD PRIMARY KEY (`user_id`,`role_id`);

--
-- Indexes for table `savings`
--
ALTER TABLE `savings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `savings_charges`
--
ALTER TABLE `savings_charges`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `savings_products`
--
ALTER TABLE `savings_products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `savings_product_charges`
--
ALTER TABLE `savings_product_charges`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `savings_transactions`
--
ALTER TABLE `savings_transactions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sms_gateways`
--
ALTER TABLE `sms_gateways`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `throttle`
--
ALTER TABLE `throttle`
  ADD PRIMARY KEY (`id`),
  ADD KEY `throttle_user_id_index` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `activations`
--
ALTER TABLE `activations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `assets`
--
ALTER TABLE `assets`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `asset_depreciation`
--
ALTER TABLE `asset_depreciation`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `asset_types`
--
ALTER TABLE `asset_types`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `audit_trail`
--
ALTER TABLE `audit_trail`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT for table `charges`
--
ALTER TABLE `charges`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `clients`
--
ALTER TABLE `clients`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `client_identifications`
--
ALTER TABLE `client_identifications`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `client_identification_types`
--
ALTER TABLE `client_identification_types`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `client_next_of_kin`
--
ALTER TABLE `client_next_of_kin`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `client_profession`
--
ALTER TABLE `client_profession`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `client_relationships`
--
ALTER TABLE `client_relationships`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `client_users`
--
ALTER TABLE `client_users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `collateral`
--
ALTER TABLE `collateral`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `collateral_types`
--
ALTER TABLE `collateral_types`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `communication_campaigns`
--
ALTER TABLE `communication_campaigns`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `countries`
--
ALTER TABLE `countries`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=247;

--
-- AUTO_INCREMENT for table `currencies`
--
ALTER TABLE `currencies`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT for table `custom_fields`
--
ALTER TABLE `custom_fields`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `custom_fields_meta`
--
ALTER TABLE `custom_fields_meta`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `documents`
--
ALTER TABLE `documents`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `expenses`
--
ALTER TABLE `expenses`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `expense_budgets`
--
ALTER TABLE `expense_budgets`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `expense_types`
--
ALTER TABLE `expense_types`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `funds`
--
ALTER TABLE `funds`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `gl_accounts`
--
ALTER TABLE `gl_accounts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `gl_closures`
--
ALTER TABLE `gl_closures`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `gl_journal_entries`
--
ALTER TABLE `gl_journal_entries`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `grants`
--
ALTER TABLE `grants`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `groups`
--
ALTER TABLE `groups`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `group_clients`
--
ALTER TABLE `group_clients`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `group_loan_allocation`
--
ALTER TABLE `group_loan_allocation`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `group_users`
--
ALTER TABLE `group_users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `guarantors`
--
ALTER TABLE `guarantors`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `loans`
--
ALTER TABLE `loans`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `loan_applications`
--
ALTER TABLE `loan_applications`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `loan_charges`
--
ALTER TABLE `loan_charges`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `loan_products`
--
ALTER TABLE `loan_products`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `loan_product_charges`
--
ALTER TABLE `loan_product_charges`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `loan_provisioning_criteria`
--
ALTER TABLE `loan_provisioning_criteria`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `loan_purposes`
--
ALTER TABLE `loan_purposes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `loan_repayment_schedules`
--
ALTER TABLE `loan_repayment_schedules`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `loan_reschedule_requests`
--
ALTER TABLE `loan_reschedule_requests`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `loan_transactions`
--
ALTER TABLE `loan_transactions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `loan_transaction_repayment_schedule_mappings`
--
ALTER TABLE `loan_transaction_repayment_schedule_mappings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=70;

--
-- AUTO_INCREMENT for table `notes`
--
ALTER TABLE `notes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `offices`
--
ALTER TABLE `offices`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `office_transactions`
--
ALTER TABLE `office_transactions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `other_income`
--
ALTER TABLE `other_income`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `other_income_types`
--
ALTER TABLE `other_income_types`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payment_details`
--
ALTER TABLE `payment_details`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payment_types`
--
ALTER TABLE `payment_types`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payment_type_details`
--
ALTER TABLE `payment_type_details`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payroll`
--
ALTER TABLE `payroll`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payroll_meta`
--
ALTER TABLE `payroll_meta`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payroll_templates`
--
ALTER TABLE `payroll_templates`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `payroll_template_meta`
--
ALTER TABLE `payroll_template_meta`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=319;

--
-- AUTO_INCREMENT for table `persistences`
--
ALTER TABLE `persistences`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `reminders`
--
ALTER TABLE `reminders`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `report_scheduler`
--
ALTER TABLE `report_scheduler`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `report_scheduler_run_history`
--
ALTER TABLE `report_scheduler_run_history`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `savings`
--
ALTER TABLE `savings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `savings_charges`
--
ALTER TABLE `savings_charges`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `savings_products`
--
ALTER TABLE `savings_products`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `savings_product_charges`
--
ALTER TABLE `savings_product_charges`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `savings_transactions`
--
ALTER TABLE `savings_transactions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=77;

--
-- AUTO_INCREMENT for table `sms_gateways`
--
ALTER TABLE `sms_gateways`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `throttle`
--
ALTER TABLE `throttle`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
