-- phpMyAdmin SQL Dump
-- version 3.5.7
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Nov 27, 2014 at 11:46 PM
-- Server version: 5.5.29
-- PHP Version: 5.4.10

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `contextivity`
--

-- --------------------------------------------------------

--
-- Table structure for table `applications`
--

USE contextivity;

CREATE TABLE `applications` (
  `app_id` varchar(8) NOT NULL,
  `platform_id` varchar(32) NOT NULL,
  `application_status` set('active','inactive','pending','destroyed','dormant') NOT NULL,
  `created_by_user_id` int(11) NOT NULL,
  `app_name` varchar(500) NOT NULL,
  `app_description` varchar(500) NOT NULL,
  `app_api_key` varchar(32) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`app_id`,`platform_id`),
  UNIQUE KEY `app_api_key` (`app_api_key`),
  UNIQUE KEY `app_name` (`app_name`),
  KEY `created_by_user_id` (`created_by_user_id`),
  KEY `platform_id` (`platform_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `applications`
--

INSERT INTO `applications` (`app_id`, `platform_id`, `application_status`, `created_by_user_id`, `app_name`, `app_description`, `app_api_key`, `created_at`, `updated_at`) VALUES
('05840592', '', '', 1, 'My New App', 'My new App', 't7F6YpIBv55MFBIRW5RtGV9k2hRVTUyj', '2014-10-13 16:57:18', '2014-10-13 05:57:18'),
('48305a38', '', '', 1, 'MyApp', 'ss', 'Vo8E6exYtbYvMHJWtGufWfKJ1i9HhkrB', '2014-10-13 17:15:42', '2014-10-13 06:15:42'),
('58e8386d', '', '', 1, 'Test New App Addition', 'Test', 'vO8k6RQjdTXUfTXawf2O7kezW5SN8oiB', '2014-11-27 22:18:29', '2014-11-27 11:18:29'),
('6f7316ce', '', '', 1, 'Satheeshwarans app', 'dghhknk', 'oSTfaZegbTB3j2QAnb0nA42LxobMT9l9', '2014-10-10 16:40:59', '2014-10-10 06:11:31');

-- --------------------------------------------------------

--
-- Table structure for table `beacon_analytics`
--

CREATE TABLE `beacon_analytics` (
  `analytics_app_id` varchar(8) NOT NULL,
  `beacon_uuid` varchar(64) NOT NULL,
  `user_id` varchar(200) NOT NULL,
  `user_name` varchar(200) NOT NULL,
  `session_start_time` varchar(200) NOT NULL,
  `session_end_time` varchar(200) NOT NULL,
  `session_duration` varchar(200) NOT NULL,
  KEY `beacon_analytics_index` (`beacon_uuid`) COMMENT 'beacon_analytics_index',
  KEY `analytics_app_index` (`analytics_app_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `beacon_analytics`
--

INSERT INTO `beacon_analytics` (`analytics_app_id`, `beacon_uuid`, `user_id`, `user_name`, `session_start_time`, `session_end_time`, `session_duration`) VALUES
('6f7316ce', 'B9407F30-F5F8-466E-AFF9-25556B57FE6D', '309222', 'Satheeshwaran', '11/11/2014 16:48:32', '11/11/2014 16:49:52', '01:50'),
('6f7316ce', 'B9407F30-F5F8-466E-AFF9-25556B57FE6D', '309222', 'Satheeshwaran', '11/11/2014 16:48:32', '11/11/2014 16:49:52', '01:50'),
('6f7316ce', 'B9407F30-F5F8-466E-AFF9-25556B57FE6D', '309222', 'Satheeshwaran', '11/11/2014 16:48:32', '11/11/2014 16:49:52', '01:50'),
('6f7316ce', 'B9407F30-F5F8-466E-AFF9-25556B57FE6D', '309222', 'Satheeshwaran', '11/11/2014 16:48:32', '11/11/2014 16:49:52', '01:50'),
('6f7316ce', 'B9407F30-F5F8-466E-AFF9-25556B57FE6D', '309222', 'Satheeshwaran', '11/11/2014 16:48:32', '11/11/2014 16:49:52', '01:50'),
('6f7316ce', 'B9407F30-F5F8-466E-AFF9-25556B57FE6D', '309222', 'Satheesh', '11/11/2014 16:49:52', '11/11/2014 16:49:52', '01:50'),
('6f7316ce', 'B9407F30-F5F8-466E-AFF9-25556B57FE6D', '309222', 'Satheesh', '11/11/2014 16:49:52', '11/11/2014 16:49:52', '01:50'),
('6f7316ce', 'B9407F30-F5F8-466E-AFF9-25556B57FE6D', '309222', 'Kavitha', '11/11/2014 16:49:52', '11/11/2014 16:49:52', '01:50');

-- --------------------------------------------------------

--
-- Table structure for table `members`
--

CREATE TABLE `members` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(30) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` char(128) NOT NULL,
  `salt` char(128) NOT NULL,
  `member_first_name` varchar(200) NOT NULL,
  `member_last_name` varchar(200) NOT NULL,
  `member_status` varchar(32) NOT NULL,
  `member_access_level` set('enduser','admin','level1','level2') NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `members`
--

INSERT INTO `members` (`id`, `username`, `email`, `password`, `salt`, `member_first_name`, `member_last_name`, `member_status`, `member_access_level`) VALUES
(1, 'Satheeshwaran', 'test@example.com', 'c3b7f061766fa13c6dce5bc93b46e1acfa80948ea7214840ea0bcf9b8cfa2f614898311452033e6b5450568d172a8a7cb67b1c3083b3720958457f19cb638dbd', 'f9aab579fc1b41ed0c44fe4ecdbfcdb4cb99b9023abb241a6db833288f4eea3c02f76e0d35204a8695077dcf81932aa59006423976224be0390395bae152d4ef', '', '', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `registered_beacons`
--

CREATE TABLE `registered_beacons` (
  `beacon_app_id` varchar(8) NOT NULL,
  `beacon_uuid` varchar(64) NOT NULL,
  `beacon_name` varchar(300) NOT NULL,
  `beacon_manufacturer` varchar(300) NOT NULL,
  `beacon_location` varchar(200) NOT NULL,
  `beacon_major_value` varchar(20) NOT NULL,
  `beacon_minor_value` varchar(20) NOT NULL,
  `beacon_broadcast_message` varchar(1000) NOT NULL,
  `beacon_exit_message` varchar(1000) NOT NULL,
  `beacon_broadcast_action` varchar(1000) NOT NULL,
  PRIMARY KEY (`beacon_uuid`),
  KEY `beacon_app_id_index` (`beacon_app_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `registered_beacons`
--

INSERT INTO `registered_beacons` (`beacon_app_id`, `beacon_uuid`, `beacon_name`, `beacon_manufacturer`, `beacon_location`, `beacon_major_value`, `beacon_minor_value`, `beacon_broadcast_message`, `beacon_exit_message`, `beacon_broadcast_action`) VALUES
('6f7316ce', 'B9407F30-F5F8-466E-AFF9-25556B57FE6D', 'Pharmacy Floor1', 'Estimote', 'Pharmacy Floor1, A Block', '25', '234', 'Welcome To Appollo Hospitals, Slide to check in', 'Thank you for visiting Appollo Hospitals', 'NO_ACTION_DEFINED'),
('6f7316ce', 'F3D6EA1C-A1FA-465E-BE88-F2FCE072E985', 'Canteen Second Floor', 'Radius-RadBeacon', 'Canteen Second Floor, Block A', '57875', '533', 'Welcome To Appollo Hospitals Canteen, Slide to check in to the hospital', 'Thank you for visiting Appollo Hospitals Canteen1 hehe', 'NO_ACTION_DEFINED'),
('05840592', 'g145435h', 'Prioper Name', 'ggjk', 'hkjhjkhkjj', 'hjkhjk23jkh', 'hjkhj', 'hjkhhk', 'hjkhk', 'hjkhk');

-- --------------------------------------------------------

--
-- Table structure for table `rogue_beacons`
--

CREATE TABLE `rogue_beacons` (
  `beacon_app_id` varchar(8) NOT NULL,
  `beacon_uuid` varchar(64) NOT NULL,
  `beacon_name` varchar(300) NOT NULL,
  `beacon_manufacturer` varchar(300) NOT NULL,
  `beacon_location` varchar(200) NOT NULL,
  `beacon_major_value` varchar(20) NOT NULL,
  `beacon_minor_value` varchar(20) NOT NULL,
  `beacon_broadcast_message` varchar(1000) NOT NULL,
  `beacon_exit_message` varchar(1000) NOT NULL,
  `beacon_broadcast_action` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `rogue_beacons`
--

INSERT INTO `rogue_beacons` (`beacon_app_id`, `beacon_uuid`, `beacon_name`, `beacon_manufacturer`, `beacon_location`, `beacon_major_value`, `beacon_minor_value`, `beacon_broadcast_message`, `beacon_exit_message`, `beacon_broadcast_action`) VALUES
('6f7316ce', '88551D48-3D04-4CDE-BEB5-E884D1573AE5', 'Rogue Beacon 123', 'Estimote', 'Not Available', '458', '44', 'Welcome To Appollo Hospitals Canteen, Slide to check in', 'Thank you for visiting Appollo Hospitals Canteen', 'NO_ACTION_DEFINED'),
('6f7316ce', '2F234454-CF6D-4A0F-ADF2-F4911BA9FFA6', 'Rogue Beacon 2', 'RadBeacon', 'Not Available', '789', '4446', 'Welcome to whatever place this is', 'Tata Bye Bye', 'NO_ACTION_DEFINED'),
('6f7316ce', 'hhhhh', 'ahafhkl', 'hkjhjkhk', 'hhkhkjh', 'kh', 'hjkhjk', 'hjkh', 'jkh', 'jkhjk');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `applications`
--
ALTER TABLE `applications`
  ADD CONSTRAINT `delete_apps_when_user_is_deleted` FOREIGN KEY (`created_by_user_id`) REFERENCES `members` (`id`);

--
-- Constraints for table `beacon_analytics`
--
ALTER TABLE `beacon_analytics`
  ADD CONSTRAINT `beacon_analytics_ibfk_2` FOREIGN KEY (`beacon_uuid`) REFERENCES `registered_beacons` (`beacon_uuid`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `beacon_analytics_ibfk_1` FOREIGN KEY (`analytics_app_id`) REFERENCES `registered_beacons` (`beacon_app_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `registered_beacons`
--
ALTER TABLE `registered_beacons`
  ADD CONSTRAINT `registered_beacons_ibfk_1` FOREIGN KEY (`beacon_app_id`) REFERENCES `applications` (`app_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
