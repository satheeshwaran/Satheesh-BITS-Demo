-- phpMyAdmin SQL Dump
-- version 4.0.6
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Oct 14, 2014 at 08:57 AM
-- Server version: 5.5.33
-- PHP Version: 5.5.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `SatheeshwaranPushKit`
--
CREATE DATABASE IF NOT EXISTS `SatheeshwaranPushKit` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `SatheeshwaranPushKit`;

-- --------------------------------------------------------

--
-- Table structure for table `applications`
--

CREATE TABLE `applications` (
  `app_id` varchar(8) NOT NULL,
  `created_by_user_id` int(11) NOT NULL,
  `app_name` varchar(500) NOT NULL,
  `app_description` varchar(500) NOT NULL,
  `app_api_key` varchar(32) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`app_id`),
  UNIQUE KEY `app_api_key` (`app_api_key`),
  UNIQUE KEY `app_name` (`app_name`),
  KEY `created_by_user_id` (`created_by_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `applications`
--

INSERT INTO `applications` (`app_id`, `created_by_user_id`, `app_name`, `app_description`, `app_api_key`, `created_at`, `updated_at`) VALUES
('05840592', 1, 'My New App', 'My new App', 't7F6YpIBv55MFBIRW5RtGV9k2hRVTUyj', '2014-10-13 16:57:18', '2014-10-13 11:27:18'),
('1243', 1, 'Test_app', 'Test App', '1235634143253245', '2014-10-10 06:16:16', '2014-10-10 06:23:48'),
('1244', 1, 'Test_app1', 'Test App1', 'try346424', '2014-10-10 17:45:45', '2014-10-10 06:23:48'),
('48305a38', 1, 'MyApp', 'ss', 'Vo8E6exYtbYvMHJWtGufWfKJ1i9HhkrB', '2014-10-13 17:15:42', '2014-10-13 11:45:42'),
('4d922593', 1, 'afaf', 'afaf', '', '2014-10-10 08:18:21', '2014-10-10 11:16:42'),
('4fa80b2e', 1, 'adadafaf', 'fafafaf', 'V9JrsUW7xvtBjDe0l3MngSXUDhA4kF8O', '2014-10-13 16:59:13', '2014-10-13 11:29:13'),
('6f7316ce', 1, 'Satheeshwarans app', 'dghhknk', 'oSTfaZegbTB3j2QAnb0nA42LxobMT9l9', '2014-10-10 16:40:59', '2014-10-10 11:41:31'),
('70d64f2a', 1, 'fafgfaf', 'afafafa', 'aaaaggfffaffaafgfgaffagaaffafaff', '2014-10-10 10:27:28', '2014-10-10 11:26:29'),
('7d8f6fa6', 1, 'Satheeshwarans app1', 'dffdfgdgd', 'oUoYrFngyrnJkNJIQqax4d2UF7bBBxAe', '2014-10-10 17:24:21', '2014-10-10 11:54:21'),
('84cfee2c', 1, 'New APp with redirection', 'New app with redirection', 'F4dRdLG86JwhDmvsKQQpFQYulYl4TAHs', '2014-10-13 16:51:51', '2014-10-13 11:21:51'),
('a02e270f', 1, 'Testing Application', 'Terstin redirection', '9nOAg3VgNQCriuPNdCn4MCvf3bA6HAqN', '2014-10-13 16:50:23', '2014-10-13 11:20:23'),
('c8227388', 1, 'ADADA', 'ADDAQAD', 'QCjMF2Y3spfvyItBnNstDb986N2HhsaJ', '2014-10-13 16:58:55', '2014-10-13 11:28:55'),
('e29f5a40', 1, 'Testing APp', 'Testin INsert', 'UgoEjswFNsyT0YMo1Xr2c3wpaTODOx4k', '2014-10-13 16:49:07', '2014-10-13 11:19:07');

-- --------------------------------------------------------

--
-- Table structure for table `login_attempts`
--

CREATE TABLE `login_attempts` (
  `user_id` int(11) NOT NULL,
  `time` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `login_attempts`
--

INSERT INTO `login_attempts` (`user_id`, `time`) VALUES
(1, '1412780526'),
(1, '1413208310');

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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `members`
--

INSERT INTO `members` (`id`, `username`, `email`, `password`, `salt`) VALUES
(1, 'test_user', 'test@example.com', 'c3b7f061766fa13c6dce5bc93b46e1acfa80948ea7214840ea0bcf9b8cfa2f614898311452033e6b5450568d172a8a7cb67b1c3083b3720958457f19cb638dbd', 'f9aab579fc1b41ed0c44fe4ecdbfcdb4cb99b9023abb241a6db833288f4eea3c02f76e0d35204a8695077dcf81932aa59006423976224be0390395bae152d4ef');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `applications`
--
ALTER TABLE `applications`
  ADD CONSTRAINT `delete_apps_when_user_is_deleted` FOREIGN KEY (`created_by_user_id`) REFERENCES `members` (`id`) ON DELETE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
