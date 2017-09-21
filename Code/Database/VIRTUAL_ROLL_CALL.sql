-- phpMyAdmin SQL Dump
-- version 4.0.10deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jul 28, 2017 at 02:41 PM
-- Server version: 5.5.55-0ubuntu0.14.04.1
-- PHP Version: 5.5.9-1ubuntu4.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `VIRTUAL_ROLL_CALL`
--

-- --------------------------------------------------------

--
-- Table structure for table `CATEGORIES`
--

CREATE TABLE IF NOT EXISTS `CATEGORIES` (
  `category_ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Category_Name` varchar(50) NOT NULL,
  PRIMARY KEY (`category_ID`),
  UNIQUE KEY `category_name` (`Category_Name`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=17 ;

--
-- Dumping data for table `CATEGORIES`
--

INSERT INTO `CATEGORIES` (`category_ID`, `Category_Name`) VALUES
(8, 'Archives files'),
(4, 'BOLO'),
(6, 'Internal Memos'),
(1, 'Message From Chief'),
(14, 'Officer Safety'),
(2, 'Shift Line Up'),
(5, 'Training'),
(3, 'Watch Orders'),
(15, 'Written Directives');

-- --------------------------------------------------------

--
-- Table structure for table `DOCUMENTS`
--

CREATE TABLE IF NOT EXISTS `DOCUMENTS` (
  `document_ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Document_Name` varchar(50) NOT NULL,
  `Category_ID` int(10) unsigned NOT NULL,
  `Upload_Date` date NOT NULL,
  `Pinned` tinyint(1) NOT NULL,
  `Uploaded_By` varchar(255) NOT NULL,
  `Upload_Name` varchar(255) NOT NULL,
  `Description` varchar(200) NOT NULL,
  `Manual_Archived` tinyint(1) NOT NULL,
  PRIMARY KEY (`document_ID`),
  UNIQUE KEY `Document_Name` (`Document_Name`),
  KEY `Category_ID` (`Category_ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=118 ;

--
-- Dumping data for table `DOCUMENTS`
--

INSERT INTO `DOCUMENTS` (`document_ID`, `Document_Name`, `Category_ID`, `Upload_Date`, `Pinned`, `Uploaded_By`, `Upload_Name`, `Description`, `Manual_Archived`) VALUES
(100, 'face', 4, '2017-06-23', 1, 'Juan Gonzales', 'MIAhubresultsfeedmia16379993834523384043242677485241.pdf', '', 0),
(101, 'doc', 4, '2017-06-24', 0, 'test test', 'CDA4101_FinalProject (1).doc', '', 0),
(102, 'screen shot', 4, '2017-06-24', 1, 'test test', 'Screen shot 2010-10-26 at 10.11.18 AM.png', '', 0),
(104, 'new doc', 4, '2017-06-29', 1, 'Juan Gonzales', 'CDA4101_FinalProject (1) (1).doc', '', 0),
(105, 'docnew123', 4, '2017-06-29', 1, 'Juan Gonzales', 'CDA4101_FinalProject (1).doc', '', 0),
(106, 'web', 4, '2017-06-07', 0, 'Super Super', '10-web.pdf', 'web', 0),
(107, 'Resume', 4, '2017-07-21', 1, 'Admin Admin', 'Resume.pdf', 'Resume', 0),
(108, 'Test Doc', 4, '2017-07-21', 0, 'Super Super', 'CDA4101_FinalProject (1).doc', 'Test Doc Desc', 0),
(110, 'Test pdf', 4, '2017-07-21', 0, 'Admin Admin', 'AirWaybill.pdf', 'Test pdf dec', 0),
(111, 'dispacher', 4, '2017-07-24', 0, 'Super Super', 'dispenser.jpg', 'suds', 0),
(112, 'Bolo', 4, '2017-07-24', 1, 'Super Super', '9044-35235-1-PB.pdf', 'bolo search', 0),
(113, 'test', 4, '2017-07-25', 0, 'Super Super', '960.jpg', 'test', 0),
(114, 'rrr', 4, '2017-07-25', 0, 'Super Super', '00081960.jpg', 'rrrr', 0);

-- --------------------------------------------------------

--
-- Table structure for table `DOCUMENT_STATUS`
--

CREATE TABLE IF NOT EXISTS `DOCUMENT_STATUS` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Description` text NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `DOCUMENT_STATUS`
--

INSERT INTO `DOCUMENT_STATUS` (`Id`, `Description`) VALUES
(1, 'Pending'),
(2, 'Reviewed'),
(3, 'Done');

-- --------------------------------------------------------

--
-- Table structure for table `LOGS`
--

CREATE TABLE IF NOT EXISTS `LOGS` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `DOC` datetime NOT NULL,
  `userid` int(11) NOT NULL,
  `documentid` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=129 ;

--
-- Dumping data for table `LOGS`
--

INSERT INTO `LOGS` (`id`, `DOC`, `userid`, `documentid`) VALUES
(7, '2017-06-06 11:00:13', 3, 71),
(8, '2017-06-06 11:00:17', 3, 74),
(9, '2017-06-06 11:01:38', 3, 74),
(10, '2017-06-06 11:02:01', 3, 74),
(11, '2017-06-07 09:41:28', 3, 71),
(12, '2017-06-08 10:29:48', 3, 71),
(13, '2017-06-08 12:26:35', 3, 71),
(14, '2017-06-08 12:26:39', 3, 73),
(15, '2017-06-08 12:26:44', 3, 74),
(16, '2017-06-08 12:26:49', 3, 71),
(17, '2017-06-08 12:26:52', 3, 71),
(18, '2017-06-08 12:27:43', 3, 71),
(19, '2017-06-08 12:27:59', 3, 71),
(20, '2017-06-08 13:27:01', 3, 71),
(21, '2017-06-08 13:27:11', 3, 73),
(22, '2017-06-08 13:28:02', 3, 73),
(23, '2017-06-14 12:34:21', 3, 71),
(24, '2017-06-14 12:34:24', 3, 73),
(25, '2017-06-14 12:34:27', 3, 74),
(26, '2017-06-19 15:24:20', 3, 85),
(27, '2017-06-19 15:24:27', 3, 84),
(28, '2017-06-19 15:24:41', 3, 85),
(29, '2017-06-21 11:51:43', 3, 88),
(30, '2017-06-21 14:00:31', 3, 88),
(31, '2017-06-22 10:07:58', 3, 88),
(32, '2017-06-22 10:08:09', 3, 88),
(33, '2017-06-22 10:08:15', 3, 88),
(34, '2017-06-22 10:08:22', 3, 88),
(35, '2017-06-22 10:09:25', 3, 88),
(36, '2017-06-22 10:09:35', 3, 88),
(37, '2017-06-22 10:09:46', 3, 88),
(38, '2017-06-22 10:10:09', 3, 88),
(39, '2017-06-22 10:10:23', 3, 88),
(40, '2017-06-22 12:40:43', 3, 88),
(41, '2017-06-22 12:40:51', 3, 88),
(42, '2017-06-22 12:40:56', 3, 88),
(43, '2017-06-22 12:41:06', 3, 88),
(44, '2017-06-22 13:24:48', 3, 88),
(45, '2017-06-22 13:26:42', 3, 88),
(46, '2017-06-22 13:28:39', 3, 88),
(47, '2017-06-22 13:28:49', 3, 88),
(48, '2017-06-22 13:32:04', 3, 93),
(49, '2017-06-22 13:34:29', 3, 91),
(50, '2017-06-22 13:49:00', 3, 91),
(51, '2017-06-22 13:50:10', 22, 92),
(52, '2017-06-22 13:50:14', 22, 88),
(53, '2017-06-22 13:51:01', 22, 93),
(54, '2017-06-22 14:16:36', 22, 92),
(55, '2017-06-22 14:23:25', 22, 91),
(56, '2017-06-22 14:23:28', 22, 92),
(57, '2017-06-22 14:23:30', 22, 93),
(58, '2017-06-22 14:23:37', 22, 88),
(59, '2017-06-22 14:23:48', 22, 91),
(60, '2017-06-22 14:50:26', 3, 89),
(61, '2017-06-23 10:52:20', 3, 91),
(62, '2017-06-23 10:52:30', 3, 93),
(63, '2017-06-23 10:55:05', 3, 98),
(64, '2017-06-23 10:56:39', 3, 100),
(65, '2017-06-23 10:56:43', 3, 98),
(66, '2017-06-23 10:56:45', 3, 99),
(67, '2017-06-24 18:05:25', 3, 101),
(68, '2017-06-24 18:11:36', 3, 102),
(69, '2017-06-24 18:11:43', 3, 102),
(70, '2017-06-24 18:12:39', 3, 101),
(71, '2017-06-26 16:23:12', 3, 102),
(72, '2017-06-26 16:23:15', 3, 98),
(73, '2017-06-26 16:23:17', 3, 100),
(74, '2017-06-26 16:23:20', 3, 99),
(75, '2017-06-29 10:09:43', 3, 100),
(76, '2017-06-29 10:09:54', 3, 99),
(77, '2017-06-29 13:31:36', 3, 99),
(78, '2017-06-29 13:31:54', 3, 101),
(79, '2017-06-29 13:31:58', 3, 101),
(80, '2017-06-29 13:32:23', 3, 102),
(81, '2017-06-29 13:32:31', 3, 99),
(82, '2017-06-29 13:32:49', 3, 100),
(83, '2017-07-06 10:08:26', 3, 101),
(84, '2017-07-06 10:08:27', 3, 102),
(85, '2017-07-06 10:08:29', 3, 102),
(86, '2017-07-06 10:08:33', 3, 101),
(87, '2017-07-06 13:15:31', 3, 105),
(88, '2017-07-06 13:15:34', 3, 102),
(89, '2017-07-06 13:15:50', 3, 102),
(90, '2017-07-06 13:15:58', 3, 106),
(91, '2017-07-06 13:16:45', 3, 106),
(92, '2017-07-06 13:17:02', 3, 106),
(93, '2017-07-18 14:55:05', 23, 100),
(94, '2017-07-18 14:55:13', 23, 100),
(95, '2017-07-18 14:57:00', 23, 101),
(96, '2017-07-18 14:57:05', 23, 101),
(97, '2017-07-18 15:02:17', 23, 100),
(98, '2017-07-18 15:02:22', 23, 102),
(99, '2017-07-18 15:02:25', 23, 104),
(100, '2017-07-18 15:02:27', 23, 105),
(101, '2017-07-18 15:02:36', 23, 101),
(102, '2017-07-18 15:02:38', 23, 106),
(103, '2017-07-18 15:03:05', 23, 102),
(104, '2017-07-18 15:08:46', 23, 102),
(105, '2017-07-18 15:08:50', 23, 100),
(106, '2017-07-18 15:08:53', 23, 104),
(107, '2017-07-18 15:08:57', 23, 105),
(108, '2017-07-18 15:09:03', 23, 106),
(109, '2017-07-18 15:09:08', 23, 101),
(110, '2017-07-18 15:10:09', 23, 106),
(111, '2017-07-21 15:29:08', 3, 102),
(112, '2017-07-21 15:29:12', 3, 100),
(113, '2017-07-21 15:29:18', 3, 105),
(114, '2017-07-21 15:29:25', 3, 105),
(115, '2017-07-21 17:51:02', 2, 109),
(116, '2017-07-21 17:55:28', 23, 110),
(117, '2017-07-21 18:27:27', 23, 107),
(118, '2017-07-21 18:27:34', 23, 110),
(119, '2017-07-21 18:27:44', 23, 110),
(120, '2017-07-21 20:00:49', 23, 108),
(121, '2017-07-21 20:01:08', 23, 108),
(122, '2017-07-21 20:29:45', 23, 100),
(123, '2017-07-21 20:55:53', 3, 102),
(124, '2017-07-24 21:08:45', 3, 108),
(125, '2017-07-24 21:09:09', 3, 108),
(126, '2017-07-24 23:43:24', 3, 110),
(127, '2017-07-24 23:43:57', 3, 110),
(128, '2017-07-24 23:44:21', 3, 106);

-- --------------------------------------------------------

--
-- Table structure for table `OFFICERS`
--

CREATE TABLE IF NOT EXISTS `OFFICERS` (
  `userID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `First_Name` varchar(20) NOT NULL,
  `Last_Name` varchar(20) NOT NULL,
  `Username` varchar(20) NOT NULL,
  `Password` varchar(40) NOT NULL,
  `Role` varchar(40) NOT NULL,
  `Active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`userID`),
  UNIQUE KEY `Username` (`Username`),
  UNIQUE KEY `Username_2` (`Username`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=26 ;

--
-- Dumping data for table `OFFICERS`
--

INSERT INTO `OFFICERS` (`userID`, `First_Name`, `Last_Name`, `Username`, `Password`, `Role`, `Active`) VALUES
(1, 'Jason', 'Cohen', 'jcohen001', 'jason123', 'Administrator', 1),
(2, 'Super', 'Super', 'supervisor', 'test', 'Supervisor', 1),
(3, 'Juan', 'Gonzales', 'officer', 'test', 'Officer', 1),
(13, 'Ivana', 'Rodriguez', 'irodr041', '12345678', 'Supervisor', 1),
(15, 'Shonda', 'Witherspoon', 'swith004', 'shonda123', 'Supervisor', 1),
(16, 'Frank', 'Alvarado', 'falva001', 'frank123', 'Administrator', 1),
(22, 'Test', 'Tester', 'test001', 'test1234', 'Officer', 1),
(23, 'Admin', 'Admin', 'administrator', 'test', 'Administrator', 1),
(25, 'Tomas', 'Smith', 'tomas', '12345678', 'Officer', 1);

-- --------------------------------------------------------

--
-- Table structure for table `SETTINGS`
--

CREATE TABLE IF NOT EXISTS `SETTINGS` (
  `Application_Name` varchar(255) NOT NULL,
  `Department_Name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `SETTINGS`
--

INSERT INTO `SETTINGS` (`Application_Name`, `Department_Name`) VALUES
('Virtual Roll Call', 'Pinecrest Police Department');

-- --------------------------------------------------------

--
-- Table structure for table `USER_DOC_STATUS`
--

CREATE TABLE IF NOT EXISTS `USER_DOC_STATUS` (
  `OfficerId` int(11) NOT NULL,
  `StatusId` int(11) NOT NULL,
  `DocumentId` int(11) NOT NULL,
  `StartDateTime` datetime NOT NULL,
  `EndDateTime` datetime NOT NULL,
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=70 ;

--
-- Dumping data for table `USER_DOC_STATUS`
--

INSERT INTO `USER_DOC_STATUS` (`OfficerId`, `StatusId`, `DocumentId`, `StartDateTime`, `EndDateTime`, `Id`) VALUES
(3, 2, 93, '2017-06-22 13:32:04', '0000-00-00 00:00:00', 45),
(3, 3, 91, '2017-06-22 13:34:29', '2017-06-22 13:34:51', 46),
(22, 2, 92, '2017-06-22 13:50:10', '0000-00-00 00:00:00', 47),
(22, 2, 88, '2017-06-22 13:50:14', '0000-00-00 00:00:00', 48),
(3, 3, 92, '2017-06-22 14:50:21', '2017-06-22 14:50:30', 49),
(3, 2, 89, '2017-06-22 14:50:26', '0000-00-00 00:00:00', 50),
(3, 2, 98, '2017-06-23 10:55:05', '0000-00-00 00:00:00', 51),
(3, 3, 100, '2017-06-23 10:56:39', '2017-06-29 10:09:38', 52),
(3, 3, 99, '2017-06-23 10:56:45', '2017-06-29 10:09:49', 53),
(3, 3, 101, '2017-06-24 18:05:25', '2017-07-06 10:08:26', 54),
(3, 3, 102, '2017-06-24 18:11:36', '2017-07-06 10:08:27', 55),
(3, 3, 105, '2017-07-06 13:15:31', '2017-07-21 15:29:25', 56),
(3, 3, 106, '2017-07-06 13:15:58', '2017-07-06 13:17:02', 57),
(23, 3, 100, '2017-07-18 14:55:05', '2017-07-18 14:55:13', 58),
(23, 3, 101, '2017-07-18 14:57:00', '2017-07-18 14:57:05', 59),
(23, 2, 102, '2017-07-18 15:02:22', '0000-00-00 00:00:00', 60),
(23, 2, 104, '2017-07-18 15:02:25', '0000-00-00 00:00:00', 61),
(23, 2, 105, '2017-07-18 15:02:27', '0000-00-00 00:00:00', 62),
(23, 2, 106, '2017-07-18 15:02:39', '0000-00-00 00:00:00', 63),
(2, 2, 109, '2017-07-21 17:51:02', '0000-00-00 00:00:00', 64),
(23, 3, 110, '2017-07-21 17:55:28', '2017-07-21 18:27:44', 65),
(23, 2, 107, '2017-07-21 18:27:27', '0000-00-00 00:00:00', 66),
(23, 3, 108, '2017-07-21 20:00:49', '2017-07-21 20:01:08', 67),
(3, 3, 108, '2017-07-24 21:08:45', '2017-07-24 21:09:09', 68),
(3, 3, 110, '2017-07-24 23:43:25', '2017-07-24 23:43:57', 69);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `DOCUMENTS`
--
ALTER TABLE `DOCUMENTS`
  ADD CONSTRAINT `DOCUMENTS_ibfk_1` FOREIGN KEY (`Category_ID`) REFERENCES `CATEGORIES` (`category_ID`) ON DELETE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
