-- phpMyAdmin SQL Dump
-- version 4.7.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:8889
-- Generation Time: Dec 05, 2017 at 08:49 PM
-- Server version: 5.6.35
-- PHP Version: 7.1.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Database: `virtual_roll_call`
--

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `category_ID` int(10) UNSIGNED NOT NULL,
  `Category_Name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`category_ID`, `Category_Name`) VALUES
(8, 'Archives files'),
(4, 'BOLO'),
(16, 'Free Text'),
(6, 'Internal Memos'),
(1, 'Message From Chief'),
(14, 'Officer Safety'),
(2, 'Shift Line Up'),
(5, 'Training'),
(15, 'Written Directives');

-- --------------------------------------------------------

--
-- Table structure for table `documents`
--

CREATE TABLE `documents` (
  `document_ID` int(10) UNSIGNED NOT NULL,
  `Document_Name` varchar(50) NOT NULL,
  `Category_ID` int(10) UNSIGNED NOT NULL,
  `Upload_Date` date NOT NULL,
  `Pinned` tinyint(1) NOT NULL,
  `Uploaded_By` varchar(255) NOT NULL,
  `Upload_Name` varchar(255) NOT NULL,
  `Description` varchar(200) NOT NULL,
  `Manual_Archived` tinyint(1) NOT NULL,
  `Has_Quiz` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `documents`
--

INSERT INTO `documents` (`document_ID`, `Document_Name`, `Category_ID`, `Upload_Date`, `Pinned`, `Uploaded_By`, `Upload_Name`, `Description`, `Manual_Archived`, `Has_Quiz`) VALUES
(100, 'face', 4, '2017-06-23', 1, 'Juan Gonzales', 'test.pdf', '', 0, 0),
(101, 'doc', 4, '2017-06-24', 0, 'test test', 'CDA4101_FinalProject (1).doc', '', 0, 0),
(104, 'new doc', 4, '2017-06-29', 1, 'Juan Gonzales', 'CDA4101_FinalProject (1) (1).doc', '', 0, 0),
(105, 'docnew123', 4, '2017-06-29', 1, 'Juan Gonzales', 'CDA4101_FinalProject (1).doc', '', 0, 0),
(106, 'web', 4, '2017-06-07', 0, 'Super Super', '10-web.pdf', 'web', 0, 0),
(108, 'Test Doc', 4, '2017-07-21', 0, 'Super Super', 'CDA4101_FinalProject (1).doc', 'Test Doc Desc', 0, 0),
(110, 'Test pdf', 4, '2017-07-21', 0, 'Admin Admin', 'AirWaybill.pdf', 'Test pdf dec', 0, 0),
(111, 'dispacher', 4, '2017-07-24', 0, 'Super Super', 'dispenser.jpg', 'suds', 0, 0),
(112, 'Bolo', 4, '2017-07-24', 1, 'Super Super', '9044_PB.pdf', 'bolo search', 0, 0),
(113, 'test updated', 2, '2017-07-25', 1, 'Super Super', '960.jpg', 'test', 0, 0),
(114, 'rrr', 4, '2017-07-25', 0, 'Super Super', '00081960.jpg', 'rrrr', 0, 0),
(115, 'Pension', 15, '2017-11-02', 1, 'Super Super', 'pension_sample_letter.pdf', 'this is a sample description', 0, 0),
(116, 'Jesper CV', 5, '2017-11-10', 1, 'Admin Admin', 'Jesper Reeh - CV.pdf', 'CV document for an orientation', 0, 0),
(125, 'Father Lincoln', 15, '2017-11-18', 0, 'Admin Admin', 'ourfather.jpg', 'The American Ancestor', 0, 1),
(129, 'Village Calendar', 6, '2017-11-20', 1, 'Admin Admin', 'ShowImage.jpeg', 'The Village Address by the Mayer', 0, 1),
(130, 'Graph', 5, '2017-12-01', 1, 'Jason Cohen', 'Screenshot at Nov 23 13-52-56.png', 'graph', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `document_status`
--

CREATE TABLE `document_status` (
  `Id` int(11) NOT NULL,
  `Description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `document_status`
--

INSERT INTO `document_status` (`Id`, `Description`) VALUES
(1, 'Pending'),
(2, 'Reviewed'),
(3, 'Done');

-- --------------------------------------------------------

--
-- Table structure for table `login_logs`
--

CREATE TABLE `login_logs` (
  `log_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `lock_count` tinyint(4) NOT NULL,
  `lock_status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `login_logs`
--

INSERT INTO `login_logs` (`log_id`, `created_at`, `updated_at`, `lock_count`, `lock_status`) VALUES
(2, '2017-11-30 23:56:37', NULL, 1, 0),
(3, '2017-12-01 18:46:37', '2017-12-01 18:46:29', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `logs`
--

CREATE TABLE `logs` (
  `id` int(11) NOT NULL,
  `DOC` datetime NOT NULL,
  `userid` int(11) NOT NULL,
  `documentid` int(11) NOT NULL,
  `categoryid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `logs`
--

INSERT INTO `logs` (`id`, `DOC`, `userid`, `documentid`, `categoryid`) VALUES
(1, '2017-11-10 11:49:31', 23, 107, 4),
(2, '2017-11-10 15:05:54', 23, 11, 16),
(3, '2017-11-10 19:22:21', 23, 3, 16),
(4, '2017-11-19 20:15:45', 23, 125, 15),
(5, '2017-11-19 20:17:29', 23, 125, 15),
(6, '2017-11-19 20:19:32', 23, 125, 15),
(7, '2017-11-19 20:20:40', 23, 125, 15),
(8, '2017-11-19 20:25:17', 23, 125, 15),
(9, '2017-11-19 20:28:59', 23, 125, 15),
(10, '2017-11-19 20:39:42', 23, 125, 15),
(11, '2017-11-20 19:07:07', 23, 126, 2),
(12, '2017-11-20 19:13:05', 23, 126, 2),
(13, '2017-11-20 19:42:41', 3, 129, 1),
(14, '2017-11-20 22:32:49', 3, 129, 1),
(15, '2017-11-20 22:35:42', 3, 129, 1),
(16, '2017-11-20 22:47:22', 3, 129, 1),
(17, '2017-11-20 22:53:45', 3, 129, 1),
(18, '2017-11-20 22:54:36', 3, 129, 1),
(19, '2017-11-20 22:55:15', 3, 129, 1),
(20, '2017-11-20 23:04:44', 3, 129, 1),
(21, '2017-11-20 23:12:16', 3, 129, 1),
(22, '2017-11-20 23:13:29', 3, 129, 1),
(23, '2017-11-20 23:18:38', 3, 129, 1),
(24, '2017-11-20 23:47:02', 3, 129, 1),
(25, '2017-11-20 23:47:16', 3, 129, 1),
(26, '2017-11-21 00:26:10', 3, 129, 1),
(27, '2017-11-21 00:47:54', 3, 112, 4),
(28, '2017-11-21 01:17:43', 23, 105, 4),
(29, '2017-11-21 01:17:51', 23, 102, 4),
(30, '2017-11-24 02:46:55', 23, 129, 1),
(31, '2017-11-24 02:48:42', 23, 129, 1),
(32, '2017-11-25 00:33:37', 23, 113, 2),
(33, '2017-11-25 02:09:12', 23, 111, 4),
(34, '2017-11-25 02:09:17', 23, 111, 4),
(35, '2017-11-25 02:32:38', 23, 116, 5),
(36, '2017-11-25 10:25:11', 23, 100, 4),
(37, '2017-11-25 10:36:11', 23, 115, 15),
(38, '2017-11-25 10:41:34', 23, 115, 15),
(39, '2017-11-25 12:03:14', 23, 104, 4),
(40, '2017-11-30 23:58:16', 1, 113, 2),
(41, '2017-11-30 23:58:28', 1, 100, 4),
(42, '2017-11-30 23:58:38', 1, 100, 4),
(43, '2017-11-30 23:58:39', 1, 112, 4),
(44, '2017-12-01 02:17:59', 1, 129, 4),
(45, '2017-12-01 02:18:04', 1, 104, 4),
(46, '2017-12-01 02:18:20', 1, 105, 4),
(47, '2017-12-01 02:18:31', 1, 129, 4),
(48, '2017-12-01 15:09:41', 1, 112, 4),
(49, '2017-12-01 15:11:20', 1, 112, 4),
(50, '2017-12-01 15:11:22', 1, 105, 4),
(51, '2017-12-01 15:11:27', 1, 104, 4),
(52, '2017-12-01 15:13:23', 1, 129, 6),
(53, '2017-12-01 15:13:42', 1, 129, 6),
(54, '2017-12-01 15:15:04', 1, 11, 16),
(55, '2017-12-01 15:15:16', 1, 12, 16),
(56, '2017-12-01 15:15:22', 1, 12, 16),
(57, '2017-12-01 15:15:45', 1, 100, 4),
(58, '2017-12-01 15:19:51', 1, 130, 5),
(59, '2017-12-01 15:19:59', 1, 130, 5),
(60, '2017-12-01 15:21:21', 1, 113, 2),
(61, '2017-12-01 17:20:25', 1, 129, 6),
(62, '2017-12-01 17:20:38', 1, 129, 6),
(63, '2017-12-01 18:17:59', 1, 11, 16),
(64, '2017-12-01 18:21:38', 1, 129, 6),
(65, '2017-12-01 18:22:05', 1, 129, 6),
(66, '2017-12-01 18:31:50', 1, 112, 4),
(67, '2017-12-01 18:32:07', 1, 112, 4),
(68, '2017-12-01 18:37:48', 1, 104, 4),
(69, '2017-12-01 18:49:34', 1, 100, 4),
(70, '2017-12-01 18:49:53', 1, 100, 4),
(71, '2017-12-01 19:03:45', 1, 105, 4),
(72, '2017-12-01 19:26:19', 1, 112, 4),
(73, '2017-12-01 19:26:38', 1, 112, 4),
(74, '2017-12-01 19:36:48', 1, 129, 6),
(75, '2017-12-01 19:46:45', 1, 105, 4),
(76, '2017-12-01 19:46:48', 1, 104, 4),
(77, '2017-12-01 19:57:07', 1, 100, 4),
(78, '2017-12-01 19:57:45', 1, 100, 4),
(79, '2017-12-01 19:57:46', 1, 104, 4),
(80, '2017-12-01 19:59:03', 1, 129, 6);

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `MessageId` int(10) UNSIGNED NOT NULL,
  `Pinned` tinyint(1) NOT NULL DEFAULT '0',
  `Title` varchar(100) NOT NULL,
  `Description` varchar(100) DEFAULT NULL,
  `Message` text NOT NULL,
  `Created_by` int(11) NOT NULL,
  `Created_at` datetime NOT NULL,
  `Updated_by` int(11) DEFAULT NULL,
  `Updated_at` datetime DEFAULT NULL,
  `Manual_Archived` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `messages`
--

INSERT INTO `messages` (`MessageId`, `Pinned`, `Title`, `Description`, `Message`, `Created_by`, `Created_at`, `Updated_by`, `Updated_at`, `Manual_Archived`) VALUES
(9, 0, 'Than you, boss!', 'A note for my boss', 'Thanks for converting our mistakes into lessons, pressure into productivity and skills into strengths. You really know how to bring out the best in us.\nYou are to us what Warren Buffet would be to an apprentice investor, Gordon Ramsay would be to an aspiring chef, David Beckham would be to an aspiring footballer and Brad Pitt would be to an aspiring actor â€“ Demigod. Thanks boss.2', 2, '2017-11-08 19:56:00', 1, '2017-12-01 02:14:51', 0),
(11, 1, 'A Message from the Director.', 'Research and Findings', '2015 was a year during which the breadth and reach of our membership grew with faculty from the departments of Public Health and Bioengineering and Biostatistics, as well as up-and-coming talents such as Elaine Hsiao who studies microbial cells and Hakwan Lau who elucidates the psychophysics of visual perception.\r\n\r\nAt the same time, our researchers continued to make significant breakthroughs in basic and clinical neuroscience. Lara Rayâ€™s recent study confirmed that Naltrexone, a drug helped into clinical practice here by Walter Ling, lessens the drug cravings of methamphetamine addicts. This work continues the long history of the preeminence of UCLA addiction researchers. \r\n\r\nHowever, with Walterâ€™s Lingâ€™s retirement and several other departures from the ISAP, we have lost key figures in the addiction research community. I hope that the recent establishment of the BRI\'s Integrative Center for Addictive Disorders will attract new scientific talent to UCLA, and develop even closer collaborations between neuroscientists and clinicians across campus. ', 2, '2017-11-08 20:11:24', 2, '2017-11-08 20:29:57', 0),
(12, 1, 'something', 'something in here', 'some text in here.', 1, '2017-12-01 15:14:36', 1, '2017-12-01 17:14:14', 0);

-- --------------------------------------------------------

--
-- Table structure for table `officers`
--

CREATE TABLE `officers` (
  `userID` int(10) UNSIGNED NOT NULL,
  `First_Name` varchar(20) NOT NULL,
  `Last_Name` varchar(20) NOT NULL,
  `Username` varchar(20) NOT NULL,
  `Password` varchar(60) NOT NULL,
  `Role` varchar(40) NOT NULL,
  `Active` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `officers`
--

INSERT INTO `officers` (`userID`, `First_Name`, `Last_Name`, `Username`, `Password`, `Role`, `Active`) VALUES
(1, 'Jason', 'Cohen', 'jcohen001', '$2y$10$PfU/BmmtIzwszGmWWGqoi.eDWDBLNSC4IiXC94ELRLqXONmcOuqIS', 'Administrator', 1),
(2, 'Super', 'Super', 'supervisor', '$2y$10$iXegOwJ96slhTLcMFTz6W.e5yMyfZQ6F5oeXP4I/.dG4IaKZoW43e', 'Supervisor', 1),
(3, 'Juan', 'Gonzales', 'officer', '$2y$10$vFzGKTZEco3hF.dWzJQRXeBQYNfMf0qR8wxE7JBQFj9nJBBTzky4S', 'Officer', 1),
(13, 'Ivana', 'Rodriguez', 'irodr041', '$2y$10$qNa2mOnevOnHvn7BdG6tY.W8cmgIHWx24IKM5kxkahSbD77HIGxP2', 'Supervisor', 1),
(15, 'Shonda2', 'Witherspoon', 'swith004', '$2y$10$mUBvXvLxY2DfIwZG1OsmSeMK8lLBa6aETdbjJwKlX8.ph8ND6PGVG', 'Administrator', 1),
(16, 'Frank', 'Alvarado', 'falva001', '$2y$10$0CftMSQ9naAKHyW2u/.F5.u0h9MxWoo6GcRxIZ85gWyRpEzxvleJ6', 'Administrator', 1),
(23, 'Admin', 'Admin', 'administrator', '$2y$10$lThJX.sp5ftsZ.WBBCx5RenM/MwrYOIOE140Yrw09G6nVdIsGF9ui', 'Administrator', 1),
(25, 'Tomas', 'Smith', 'tomas', '$2y$10$iH9.7NqjBFo1jGCBInb78uXTcYnddmrotvXSSHuW.MhwtQelyNjSe', 'Officer', 1),
(60, 'Juan', 'Gonzales', 'officer 2', '$2y$10$J.Bl3AyWveiHed.uBhlCNONcbw0MKjJjp.G55i4WKDJmjDoEK/7ky', 'Officer', 1),
(77, 'tom ', 'smith', 'toms1', '$2y$10$dDJ/f3IEWaNcKcAAPnc4eeSw1bTozzR9/qi8SXa0NpikD1NvoG3OC', 'Administrator', 1),
(78, 'tom ', 'smith', 'tom2', '$2y$10$zPWw3HhXJWUqABfhfr0N/eHusDDSLllIt/9jsJnk5JoUYUN25tu5y', 'Supervisor', 1),
(79, 'tom ', 'smith', 'tom3', '$2y$10$.Bjd59ezYY5bss2EkhlmQeqvG9yL3QKEqdp/BKUtOJJqBZmzsI92e', 'Supervisor', 1),
(80, 'tom ', 'smith', 'tom4', '$2y$10$aWVu4hEqt.qH3n77Apuiv.bCbCoeCa6Tv92psMZiQTrfVWahflUQW', 'Supervisor', 1),
(88, 'tom ', 'smith', 'toms12', '$2y$10$nxkmv7dqqTS1NLYyYuK5G.Jl2IL8elJJBQfv/d7HmIAvRtC7rfsPe', 'Administrator', 1),
(94, 'tom ', 'smith', 'tom256', '$2y$10$unAivQugohM3.kYd36FzxOaah1EEamdF3EfN/k1LGM3.g.lWTzLdq', 'Supervisor', 1);

-- --------------------------------------------------------

--
-- Table structure for table `quizzes`
--

CREATE TABLE `quizzes` (
  `id` int(11) NOT NULL,
  `document_name` varchar(50) NOT NULL,
  `QA` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `quizzes`
--

INSERT INTO `quizzes` (`id`, `document_name`, `QA`) VALUES
(5, 'Father Lincoln', '[{\"q_order\": \"qa_1\",\"question\": \"Who was Abraham Lincoln?\",\"answer_1\": \"The 16th President of the United States\",\"answer_2\": \"Uncle Sam\",\"answer_3\": \"A Nigerian President\",\"answer_4\": \"\",\"correct_answer\": \"The 16th President of the United States\"},{\"q_order\": \"qa_2\",\"question\": \"Did Abraham Lincoln have children?\",\"answer_1\": \"Yes, 4 children\",\"answer_2\": \"No\",\"answer_3\": \"Yes, 3 children\",\"answer_4\": \"No. He adopted.\",\"correct_answer\": \"Yes, 4 children\"}]'),
(7, 'Village Calendar', '[{\"q_order\":\"qa_1\",\"question\":\"When is the Village Address?\",\"answer_1\":\"12\\/06\\/2017 7:00 PM\",\"answer_2\":\"12\\/01\\/2017 7:00 PM\",\"answer_3\":\"12\\/16\\/2017 7:00 PM\",\"answer_4\":\"12\\/26\\/2017 7:00 PM\",\"correct_answer\":\"12\\/06\\/2017 7:00 PM\"},{\"q_order\":\"qa_2\",\"question\":\"Who is in charge of the Address?\",\"answer_1\":\"The Mayor\",\"answer_2\":\"The District\",\"answer_3\":\"The City\",\"answer_4\":\"The People\",\"correct_answer\":\"The Mayor\"},{\"q_order\":\"qa_3\",\"question\":\"Where is this event taken place?\",\"answer_1\":\"11000 Red Road\",\"answer_2\":\"9000 Blue Road\",\"answer_3\":\"11050 Orange Road\",\"answer_4\":\"\",\"correct_answer\":\"11000 Red Road\"},{\"q_order\":\"qa_4\",\"question\":\"Article IV) does not provide for the establishment of the following departments?\",\"answer_1\":\"Hospitals\",\"answer_2\":\"Police\",\"answer_3\":\"Finance\",\"answer_4\":\"Public Works\",\"correct_answer\":\"Hospitals\"}]');

-- --------------------------------------------------------

--
-- Table structure for table `quiz_logs`
--

CREATE TABLE `quiz_logs` (
  `id` int(11) NOT NULL,
  `officer_id` int(11) NOT NULL,
  `document_id` int(11) NOT NULL,
  `score` decimal(3,2) NOT NULL,
  `answers` text NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `quiz_logs`
--

INSERT INTO `quiz_logs` (`id`, `officer_id`, `document_id`, `score`, `answers`, `created_at`) VALUES
(11, 1, 129, '0.50', '[\"12\\/16\\/2017 7:00 PM\",\"The City\",\"11000 Red Road\",\"Hospitals\"]', '2017-12-01 19:59:03');

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `Application_Name` varchar(255) NOT NULL,
  `Department_Name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`Application_Name`, `Department_Name`) VALUES
('Virtual Roll Call', 'Pinecrest Police Department');

-- --------------------------------------------------------

--
-- Table structure for table `user_doc_status`
--

CREATE TABLE `user_doc_status` (
  `OfficerId` int(11) NOT NULL,
  `StatusId` int(11) NOT NULL,
  `DocumentId` int(11) NOT NULL,
  `CategoryId` int(11) NOT NULL,
  `StartDateTime` datetime NOT NULL,
  `EndDateTime` datetime NOT NULL,
  `Id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `watch_orders`
--

CREATE TABLE `watch_orders` (
  `Id` int(10) NOT NULL,
  `Desc` varchar(60) DEFAULT 'No Description',
  `Address` varchar(100) NOT NULL,
  `Lat` float(10,6) NOT NULL,
  `Lng` float(10,6) NOT NULL,
  `AddDate` date NOT NULL,
  `ExpDate` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `watch_orders`
--

INSERT INTO `watch_orders` (`Id`, `Desc`, `Address`, `Lat`, `Lng`, `AddDate`, `ExpDate`) VALUES
(271, 'townhouse', '1400 NW 96th Ave, Doral, FL 33172, USA', 25.787062, -80.351112, '2017-12-01', '2017-12-13'),
(272, 'house', '11000 Red Rd, Pinecrest, FL 33156, USA', 25.669537, -80.285240, '2017-12-01', '2017-12-15'),
(273, 'apartment', '1040 W Flagler St, Miami, FL 33130, USA', 25.773518, -80.212059, '2017-12-01', '2017-12-14');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`category_ID`),
  ADD UNIQUE KEY `category_name` (`Category_Name`);

--
-- Indexes for table `documents`
--
ALTER TABLE `documents`
  ADD PRIMARY KEY (`document_ID`),
  ADD UNIQUE KEY `Document_Name` (`Document_Name`),
  ADD KEY `Category_ID` (`Category_ID`);

--
-- Indexes for table `document_status`
--
ALTER TABLE `document_status`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `login_logs`
--
ALTER TABLE `login_logs`
  ADD PRIMARY KEY (`log_id`);

--
-- Indexes for table `logs`
--
ALTER TABLE `logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`MessageId`);

--
-- Indexes for table `officers`
--
ALTER TABLE `officers`
  ADD PRIMARY KEY (`userID`),
  ADD UNIQUE KEY `Username` (`Username`),
  ADD UNIQUE KEY `Username_2` (`Username`);

--
-- Indexes for table `quizzes`
--
ALTER TABLE `quizzes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `document_id` (`document_name`);

--
-- Indexes for table `quiz_logs`
--
ALTER TABLE `quiz_logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_doc_status`
--
ALTER TABLE `user_doc_status`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `watch_orders`
--
ALTER TABLE `watch_orders`
  ADD PRIMARY KEY (`Id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `category_ID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;
--
-- AUTO_INCREMENT for table `documents`
--
ALTER TABLE `documents`
  MODIFY `document_ID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=131;
--
-- AUTO_INCREMENT for table `document_status`
--
ALTER TABLE `document_status`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `login_logs`
--
ALTER TABLE `login_logs`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `logs`
--
ALTER TABLE `logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=81;
--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `MessageId` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT for table `officers`
--
ALTER TABLE `officers`
  MODIFY `userID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=95;
--
-- AUTO_INCREMENT for table `quizzes`
--
ALTER TABLE `quizzes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `quiz_logs`
--
ALTER TABLE `quiz_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT for table `user_doc_status`
--
ALTER TABLE `user_doc_status`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `watch_orders`
--
ALTER TABLE `watch_orders`
  MODIFY `Id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=274;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `documents`
--
ALTER TABLE `documents`
  ADD CONSTRAINT `DOCUMENTS_ibfk_1` FOREIGN KEY (`Category_ID`) REFERENCES `categories` (`category_ID`) ON DELETE CASCADE;
