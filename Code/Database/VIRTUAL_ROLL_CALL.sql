-- phpMyAdmin SQL Dump
-- version 4.7.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:8889
-- Generation Time: Oct 27, 2017 at 05:25 PM
-- Server version: 5.6.35
-- PHP Version: 7.1.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Database: `VIRTUAL_ROLL_CALL`
--

-- --------------------------------------------------------

--
-- Table structure for table `CATEGORIES`
--

CREATE TABLE `CATEGORIES` (
  `category_ID` int(10) UNSIGNED NOT NULL,
  `Category_Name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
(15, 'Written Directives'),
(16, 'Free Text');

-- --------------------------------------------------------

--
-- Table structure for table `DOCUMENTS`
--

CREATE TABLE `DOCUMENTS` (
  `document_ID` int(10) UNSIGNED NOT NULL,
  `Document_Name` varchar(50) NOT NULL,
  `Category_ID` int(10) UNSIGNED NOT NULL,
  `Upload_Date` date NOT NULL,
  `Pinned` tinyint(1) NOT NULL,
  `Uploaded_By` varchar(255) NOT NULL,
  `Upload_Name` varchar(255) NOT NULL,
  `Description` varchar(200) NOT NULL,
  `Manual_Archived` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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

CREATE TABLE `DOCUMENT_STATUS` (
  `Id` int(11) NOT NULL,
  `Description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `DOCUMENT_STATUS`
--

INSERT INTO `DOCUMENT_STATUS` (`Id`, `Description`) VALUES
(1, 'Pending'),
(2, 'Reviewed'),
(3, 'Done');

-- --------------------------------------------------------

--
-- Table structure for table `LOGIN_LOGS`
--

CREATE TABLE `LOGIN_LOGS` (
  `log_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `lock_count` tinyint(4) NOT NULL,
  `lock_status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `LOGIN_LOGS`
--

INSERT INTO `LOGIN_LOGS` (`log_id`, `created_at`, `updated_at`, `lock_count`, `lock_status`) VALUES
(2, '2017-10-19 12:53:01', '2017-10-26 17:59:23', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `LOGS`
--

CREATE TABLE `LOGS` (
  `id` int(11) NOT NULL,
  `DOC` datetime NOT NULL,
  `userid` int(11) NOT NULL,
  `documentid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
(128, '2017-07-24 23:44:21', 3, 106),
(129, '2017-10-19 12:53:18', 2, 100),
(130, '2017-10-19 12:53:24', 2, 100),
(131, '2017-10-19 12:55:57', 1, 100),
(132, '2017-10-19 12:57:28', 27, 100),
(133, '2017-10-19 17:59:50', 1, 104),
(134, '2017-10-19 22:43:07', 1, 102),
(135, '2017-10-19 22:43:12', 1, 102),
(136, '2017-10-20 16:59:51', 2, 104),
(137, '2017-10-20 16:59:55', 2, 104),
(138, '2017-10-20 16:59:58', 2, 102),
(139, '2017-10-26 19:12:59', 2, 105),
(140, '2017-10-26 23:53:34', 1, 105),
(141, '2017-10-26 23:53:42', 1, 107);

-- --------------------------------------------------------

--
-- Table structure for table `OFFICERS`
--

CREATE TABLE `OFFICERS` (
  `userID` int(10) UNSIGNED NOT NULL,
  `First_Name` varchar(20) NOT NULL,
  `Last_Name` varchar(20) NOT NULL,
  `Username` varchar(20) NOT NULL,
  `Password` varchar(60) NOT NULL,
  `Role` varchar(40) NOT NULL,
  `Active` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `OFFICERS`
--

INSERT INTO `OFFICERS` (`userID`, `First_Name`, `Last_Name`, `Username`, `Password`, `Role`, `Active`) VALUES
(1, 'Jason', 'Cohen', 'jcohen001', '$2y$10$PfU/BmmtIzwszGmWWGqoi.eDWDBLNSC4IiXC94ELRLqXONmcOuqIS', 'Administrator', 1),
(2, 'Super', 'Super', 'supervisor', '$2y$10$iXegOwJ96slhTLcMFTz6W.e5yMyfZQ6F5oeXP4I/.dG4IaKZoW43e', 'Supervisor', 1),
(3, 'Juan', 'Gonzales', 'officer', '$2y$10$J.Bl3AyWveiHed.uBhlCNONcbw0MKjJjp.G55i4WKDJmjDoEK/7ky', 'Officer', 1),
(13, 'Ivana', 'Rodriguez', 'irodr041', '$2y$10$qNa2mOnevOnHvn7BdG6tY.W8cmgIHWx24IKM5kxkahSbD77HIGxP2', 'Supervisor', 1),
(15, 'Shonda', 'Witherspoon', 'swith004', '$2y$10$mUBvXvLxY2DfIwZG1OsmSeMK8lLBa6aETdbjJwKlX8.ph8ND6PGVG', 'Supervisor', 1),
(16, 'Frank', 'Alvarado', 'falva001', '$2y$10$0CftMSQ9naAKHyW2u/.F5.u0h9MxWoo6GcRxIZ85gWyRpEzxvleJ6', 'Administrator', 1),
(22, 'Test', 'Tester', 'test001', '$2y$10$brSJDzFjow79t.62DY0VF.p.O2qdFoKh81N3/GBOiQosHEl6rjrYe', 'Officer', 1),
(23, 'Admin', 'Admin', 'administrator', '$2y$10$lThJX.sp5ftsZ.WBBCx5RenM/MwrYOIOE140Yrw09G6nVdIsGF9ui', 'Administrator', 1),
(25, 'Tomas', 'Smith', 'tomas', '$2y$10$iH9.7NqjBFo1jGCBInb78uXTcYnddmrotvXSSHuW.MhwtQelyNjSe', 'Officer', 1);

-- --------------------------------------------------------

--
-- Table structure for table `SETTINGS`
--

CREATE TABLE `SETTINGS` (
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
-- Table structure for table `MESSAGES`
--

CREATE TABLE `MESSAGES` (
  `MessageId` int(11) NOT NULL,
  `OfficerId` int(11) NOT NULL,
  `Message` int(11) NOT NULL,
  `Created_at` datetime NOT NULL,
  `Update_by` varchar(60),
  `Updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `USER_DOC_STATUS`
--

CREATE TABLE `USER_DOC_STATUS` (
  `OfficerId` int(11) NOT NULL,
  `StatusId` int(11) NOT NULL,
  `DocumentId` int(11) NOT NULL,
  `StartDateTime` datetime NOT NULL,
  `EndDateTime` datetime NOT NULL,
  `Id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `USER_DOC_STATUS`
--

INSERT INTO `USER_DOC_STATUS` (`OfficerId`, `StatusId`, `DocumentId`, `StartDateTime`, `EndDateTime`, `Id`) VALUES
(1, 3, 102, '2017-10-19 22:43:07', '2017-10-19 22:43:11', 74),
(2, 3, 104, '2017-10-20 16:59:51', '2017-10-20 16:59:55', 75),
(2, 2, 102, '2017-10-20 16:59:58', '0000-00-00 00:00:00', 76),
(2, 2, 105, '2017-10-26 19:12:59', '0000-00-00 00:00:00', 77),
(1, 2, 105, '2017-10-26 23:53:34', '0000-00-00 00:00:00', 78),
(1, 2, 107, '2017-10-26 23:53:42', '0000-00-00 00:00:00', 79);

-- --------------------------------------------------------

--
-- Table structure for table `WATCH_ORDERS`
--

CREATE TABLE `WATCH_ORDERS` (
  `Id` int(10) NOT NULL,
  `Desc` varchar(60) DEFAULT 'No Description',
  `Address` varchar(100) NOT NULL,
  `Lat` float(10,6) NOT NULL,
  `Lng` float(10,6) NOT NULL,
  `Date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `WATCH_ORDERS`
--

INSERT INTO `WATCH_ORDERS` (`Id`, `Desc`, `Address`, `Lat`, `Lng`, `Date`) VALUES
(228, 'robbery', '8888 SW 136th St, Miami, FL 33176, USA', 25.642885, -80.339722, '2017-10-27'),
(229, 'emergency	', '7535 N Kendall Dr, Kendall, FL 33156, USA', 25.689037, -80.315445, '2017-10-27'),
(230, 'accident', '11000 Red Rd, Pinecrest, FL 33156, USA', 25.668188, -80.286591, '2017-10-27');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `CATEGORIES`
--
ALTER TABLE `CATEGORIES`
  ADD PRIMARY KEY (`category_ID`),
  ADD UNIQUE KEY `category_name` (`Category_Name`);

--
-- Indexes for table `DOCUMENTS`
--
ALTER TABLE `DOCUMENTS`
  ADD PRIMARY KEY (`document_ID`),
  ADD UNIQUE KEY `Document_Name` (`Document_Name`),
  ADD KEY `Category_ID` (`Category_ID`);

--
-- Indexes for table `DOCUMENT_STATUS`
--
ALTER TABLE `DOCUMENT_STATUS`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `LOGIN_LOGS`
--
ALTER TABLE `LOGIN_LOGS`
  ADD PRIMARY KEY (`log_id`);

--
-- Indexes for table `LOGS`
--
ALTER TABLE `MESSAGES`
  ADD PRIMARY KEY (`MessageId`);

--
-- Indexes for table `LOGS`
--
ALTER TABLE `LOGS`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `OFFICERS`
--
ALTER TABLE `OFFICERS`
  ADD PRIMARY KEY (`userID`),
  ADD UNIQUE KEY `Username` (`Username`),
  ADD UNIQUE KEY `Username_2` (`Username`);

--
-- Indexes for table `USER_DOC_STATUS`
--
ALTER TABLE `USER_DOC_STATUS`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `WATCH_ORDERS`
--
ALTER TABLE `WATCH_ORDERS`
  ADD PRIMARY KEY (`Id`);

--
-- AUTO_INCREMENT for dumped tables
--
--
-- AUTO_INCREMENT for table `MESSAGES`
--
ALTER TABLE `CATEGORIES`
  MODIFY `MessageId` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `CATEGORIES`
--
ALTER TABLE `CATEGORIES`
  MODIFY `category_ID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
--
-- AUTO_INCREMENT for table `DOCUMENTS`
--
ALTER TABLE `DOCUMENTS`
  MODIFY `document_ID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=115;
--
-- AUTO_INCREMENT for table `DOCUMENT_STATUS`
--
ALTER TABLE `DOCUMENT_STATUS`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `LOGIN_LOGS`
--
ALTER TABLE `LOGIN_LOGS`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `LOGS`
--
ALTER TABLE `LOGS`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=142;
--
-- AUTO_INCREMENT for table `OFFICERS`
--
ALTER TABLE `OFFICERS`
  MODIFY `userID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;
--
-- AUTO_INCREMENT for table `USER_DOC_STATUS`
--
ALTER TABLE `USER_DOC_STATUS`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=80;
--
-- AUTO_INCREMENT for table `WATCH_ORDERS`
--
ALTER TABLE `WATCH_ORDERS`
  MODIFY `Id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=231;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `DOCUMENTS`
--
ALTER TABLE `DOCUMENTS`
  ADD CONSTRAINT `DOCUMENTS_ibfk_1` FOREIGN KEY (`Category_ID`) REFERENCES `CATEGORIES` (`category_ID`) ON DELETE CASCADE;
