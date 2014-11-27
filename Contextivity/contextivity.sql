-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Nov 27, 2014 at 09:27 AM
-- Server version: 5.6.17
-- PHP Version: 5.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
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

CREATE TABLE IF NOT EXISTS `applications` (
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
('05840592', '', '', 1, 'My New App', 'My new App', 't7F6YpIBv55MFBIRW5RtGV9k2hRVTUyj', '2014-10-13 16:57:18', '2014-10-13 11:27:18'),
('48305a38', '', '', 1, 'MyApp', 'ss', 'Vo8E6exYtbYvMHJWtGufWfKJ1i9HhkrB', '2014-10-13 17:15:42', '2014-10-13 11:45:42'),
('6f7316ce', '', '', 1, 'Satheeshwarans app', 'dghhknk', 'oSTfaZegbTB3j2QAnb0nA42LxobMT9l9', '2014-10-10 16:40:59', '2014-10-10 11:41:31');

-- --------------------------------------------------------

--
-- Table structure for table `beacon_analytics`
--

CREATE TABLE IF NOT EXISTS `beacon_analytics` (
  `beacon_uuid` varchar(64) NOT NULL,
  `user_id` varchar(200) NOT NULL,
  `user_name` varchar(200) NOT NULL,
  `session_start_time` varchar(200) NOT NULL,
  `session_end_time` varchar(200) NOT NULL,
  `session_duration` varchar(200) NOT NULL,
  KEY `beacon_analytics_index` (`beacon_uuid`) COMMENT 'beacon_analytics_index'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `members`
--

CREATE TABLE IF NOT EXISTS `members` (
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
(1, 'test_user', 'test@example.com', 'c3b7f061766fa13c6dce5bc93b46e1acfa80948ea7214840ea0bcf9b8cfa2f614898311452033e6b5450568d172a8a7cb67b1c3083b3720958457f19cb638dbd', 'f9aab579fc1b41ed0c44fe4ecdbfcdb4cb99b9023abb241a6db833288f4eea3c02f76e0d35204a8695077dcf81932aa59006423976224be0390395bae152d4ef', '', '', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `registered_beacons`
--

CREATE TABLE IF NOT EXISTS `registered_beacons` (
  `beacon_uuid` varchar(64) NOT NULL,
  `beacon_name` varchar(300) NOT NULL,
  `beacon_manufacturer` varchar(300) NOT NULL,
  `beacon_location` varchar(200) NOT NULL,
  `beacon_major_value` varchar(20) NOT NULL,
  `beacon_minor_value` varchar(20) NOT NULL,
  `beacon_broadcast_message` varchar(1000) NOT NULL,
  `beacon_broadcast_action` varchar(1000) NOT NULL,
  PRIMARY KEY (`beacon_uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `rogue_beacons`
--

CREATE TABLE IF NOT EXISTS `rogue_beacons` (
  `beacon_uuid` varchar(64) NOT NULL,
  `beacon_name` varchar(300) NOT NULL,
  `beacon_manufacturer` varchar(300) NOT NULL,
  `beacon_location` varchar(200) NOT NULL,
  `beacon_major_value` varchar(20) NOT NULL,
  `beacon_minor_value` varchar(20) NOT NULL,
  `beacon_broadcast_message` varchar(1000) NOT NULL,
  `beacon_broadcast_action` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
  ADD CONSTRAINT `beacon_analytics_uuid_constraint` FOREIGN KEY (`beacon_uuid`) REFERENCES `registered_beacons` (`beacon_uuid`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
