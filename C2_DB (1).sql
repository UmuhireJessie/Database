-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Nov 22, 2021 at 08:52 AM
-- Server version: 10.4.18-MariaDB
-- PHP Version: 7.3.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `C2_DB`
--

-- --------------------------------------------------------

--
-- Table structure for table `Branch`
--

CREATE TABLE `Branch` (
  `branchNo` varchar(5) NOT NULL,
  `branchStreet` varchar(20) DEFAULT NULL,
  `branchCity` varchar(20) DEFAULT NULL,
  `branchState` varchar(10) DEFAULT NULL,
  `branchZipCode` varchar(5) DEFAULT NULL,
  `branchTelNo` int(11) DEFAULT NULL,
  `branchFaxNo` int(11) DEFAULT NULL,
  `managerStaffNo` varchar(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `Branch`
--

INSERT INTO `Branch` (`branchNo`, `branchStreet`, `branchCity`, `branchState`, `branchZipCode`, `branchTelNo`, `branchFaxNo`, `managerStaffNo`) VALUES
('B001', 'Kimronko', 'Kigali', 'Kiga', '001', 10034, 12, 'SG16'),
('B002', 'Kimronko', 'Kigali', 'Kiga', '001', 10035, 13, 'SG20'),
('B003', 'Kimronko', 'Kigali', 'Kiga', '001', 10036, 14, 'SG18'),
('B004', 'Kimronko', 'Kigali', 'Kiga', '001', 10037, 15, 'SG19'),
('B005', 'Kimronko', 'Kigali', 'Kiga', '001', 10038, 16, 'SG17');

-- --------------------------------------------------------

--
-- Table structure for table `CUSTOMER_T`
--

CREATE TABLE `CUSTOMER_T` (
  `CUSTOMER_ID` int(11) NOT NULL,
  `CUSTOMER_NAME` varchar(25) NOT NULL,
  `CUSTOMER_ADDRESS` varchar(50) DEFAULT NULL,
  `CITY` varchar(20) DEFAULT NULL,
  `STATE` varchar(2) DEFAULT NULL,
  `POSTAL_CODE` varchar(9) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `ORDER_LINE_T`
--

CREATE TABLE `ORDER_LINE_T` (
  `ORDER_ID` int(11) NOT NULL,
  `PRODUCT_ID` int(11) NOT NULL,
  `ORDERED_QUANTITY` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `ORDER_T`
--

CREATE TABLE `ORDER_T` (
  `ORDER_ID` int(11) NOT NULL,
  `ORDER_DATE` date DEFAULT NULL,
  `CUSTOMER_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `PrivateOwner`
--

CREATE TABLE `PrivateOwner` (
  `ownerNo` varchar(5) NOT NULL,
  `ownerName` varchar(20) DEFAULT NULL,
  `ownerAddress` varchar(100) DEFAULT NULL,
  `ownerTelNo` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `PrivateOwner`
--

INSERT INTO `PrivateOwner` (`ownerNo`, `ownerName`, `ownerAddress`, `ownerTelNo`) VALUES
('1', 'James', 'kg 34465', 789944),
('121', 'Jimmy', 'kk 54465', 78879944),
('198', 'Mercy', 'kg 365', 788744),
('2341', 'Diane', 'kk 34465', 5439944);

-- --------------------------------------------------------

--
-- Table structure for table `PRODUCT_T`
--

CREATE TABLE `PRODUCT_T` (
  `PRODUCT_ID` int(11) NOT NULL,
  `PRODUCT_DESCRIPTION` varchar(50) DEFAULT NULL,
  `PRODUCT_FINISH` varchar(20) DEFAULT NULL CHECK (`PRODUCT_FINISH` in ('Cherry','Natural Ash','White Ash','Red Oak','Natural Oak','Walnut')),
  `STANDARD_PRICE` decimal(6,2) DEFAULT NULL,
  `PRODUCT_LINE_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `PropertyForRent`
--

CREATE TABLE `PropertyForRent` (
  `propertyNo` varchar(5) NOT NULL,
  `street` varchar(20) NOT NULL,
  `city` varchar(20) NOT NULL,
  `postcode` varchar(5) DEFAULT NULL,
  `type` varchar(20) NOT NULL DEFAULT 'F',
  `rooms` int(11) NOT NULL DEFAULT 4,
  `rent` int(11) NOT NULL DEFAULT 600,
  `ownerNo` varchar(5) NOT NULL,
  `staffNo` varchar(5) NOT NULL,
  `branchNo` varchar(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `PropertyForRent`
--

INSERT INTO `PropertyForRent` (`propertyNo`, `street`, `city`, `postcode`, `type`, `rooms`, `rent`, `ownerNo`, `staffNo`, `branchNo`) VALUES
('PA14', 'Zindiro', 'Kigali', '0023', 'Flat', 7, 620, '1', 'SG16', 'B003'),
('PA15', 'Kimronko', 'Kigali', '0023', 'House', 5, 520, '121', 'SG17', 'B003'),
('PA16', 'Gikondo', 'Kigali', '0023', 'House', 4, 400, '198', 'SG18', 'B001'),
('PA17', 'Kayciru', 'Kigali', '0023', 'House', 8, 820, '2341', 'SG19', 'B001');

-- --------------------------------------------------------

--
-- Table structure for table `PropertyType`
--

CREATE TABLE `PropertyType` (
  `propTypeNo` varchar(5) NOT NULL,
  `propTypeDescription` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `PropertyType`
--

INSERT INTO `PropertyType` (`propTypeNo`, `propTypeDescription`) VALUES
('12', 'Big,spacoius,8 rooms'),
('5', 'Big,spacoius,4 rooms'),
('6', 'small,clean,1room'),
('8', 'Big,spacoius,3 rooms');

-- --------------------------------------------------------

--
-- Table structure for table `renter`
--

CREATE TABLE `renter` (
  `renterNo` varchar(5) NOT NULL,
  `rFName` varchar(20) DEFAULT NULL,
  `rLName` varchar(20) DEFAULT NULL,
  `rAddress` varchar(100) DEFAULT NULL,
  `rTelNo` int(11) DEFAULT NULL,
  `maxRent` decimal(6,2) DEFAULT NULL,
  `prefTypeNo` varchar(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `renter`
--

INSERT INTO `renter` (`renterNo`, `rFName`, `rLName`, `rAddress`, `rTelNo`, `maxRent`, `prefTypeNo`) VALUES
('11', 'Jerry', 'Makune', 'kk234', 7865433, '100.00', '12'),
('111', 'Mary', 'Jane', 'KG 633', 789907789, '120.00', '8'),
('12', 'Winny', 'Munyana', 'KG196', 788990077, '250.00', '5'),
('135', 'Maikem', 'Victorine', 'kk325', 788346578, '300.00', '8'),
('137', 'Emile', 'Kamana', 'ee325', 788346955, '900.00', '5'),
('145', 'Vanessa', 'Dube', 'KG230', 723923001, '400.00', '12'),
('220', 'Divine', 'Iradukunda', 'KK762', 780649032, '47.00', '6'),
('472', 'Vicky', 'Ishimwe', 'KK796', 790909031, '85.00', '6'),
('474', 'paul', 'jerry', 'kg345', 78457674, '50.00', '5');

-- --------------------------------------------------------

--
-- Table structure for table `staff`
--

CREATE TABLE `staff` (
  `staffNo` varchar(5) NOT NULL,
  `fName` varchar(20) NOT NULL,
  `lName` varchar(20) DEFAULT NULL,
  `position` varchar(15) DEFAULT NULL,
  `sex` char(1) DEFAULT NULL CHECK (`sex` in ('M','F')),
  `d_o_b` date DEFAULT NULL,
  `salary` decimal(7,2) DEFAULT NULL,
  `branchNo` varchar(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `staff`
--

INSERT INTO `staff` (`staffNo`, `fName`, `lName`, `position`, `sex`, `d_o_b`, `salary`, `branchNo`) VALUES
('SG16', 'Alan', 'Brown', 'Assistant', 'M', '1957-05-25', '8300.00', 'B003'),
('SG17', 'Adrine', 'Uwera', 'Supervisor', 'F', '2001-06-25', '8700.00', 'B003'),
('SG18', 'Harriet', 'Mwanza', 'Manager', 'F', '2002-07-25', '9000.00', 'B001'),
('SG19', 'John', 'Mwangi', 'Assistant', 'M', '2003-07-25', '9500.00', 'B001'),
('SG20', 'Peter', 'Mwanza', 'Manager', 'F', '2002-07-25', '6700.00', 'B002'),
('SG21', 'Alan', 'Brown', 'Assistant', 'M', '1957-05-25', '8300.00', 'B003'),
('SG22', 'Mary', 'Awuse', 'Supervisor', 'F', '2001-05-25', '9000.00', 'B003'),
('SG23', 'John', 'Odonkor', 'Supervisor', 'M', '1998-05-25', '9500.00', 'B001'),
('SG24', 'Diana', 'Kode', 'Manager', 'F', '2002-06-25', '9500.00', 'B002'),
('SG25', 'JOHN', 'MATHEWS', 'CLEANER', 'M', '1998-07-24', '4300.00', 'B002'),
('SG27', 'Alan', 'Brown', 'Assistant', 'M', '1957-05-25', '8300.00', 'B003'),
('SG28', 'Abraham', 'Deng', 'Supervisor', 'M', '2000-05-25', '9000.00', 'B003'),
('SG29', 'Edna', 'Akoth', 'Manager', 'F', '2001-06-25', '9500.00', 'B001'),
('SG30', 'Grace', 'Gihozo', 'Supervisor', 'F', '1998-01-25', '9800.00', 'B002');

-- --------------------------------------------------------

--
-- Table structure for table `Viewing`
--

CREATE TABLE `Viewing` (
  `propertyNo` varchar(5) NOT NULL,
  `renterNo` varchar(5) NOT NULL,
  `dateView` date NOT NULL,
  `comments` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `Viewing`
--

INSERT INTO `Viewing` (`propertyNo`, `renterNo`, `dateView`, `comments`) VALUES
('PA14', '11', '2021-11-04', 'I like this house'),
('PA15', '111', '2021-11-04', 'This house is too small'),
('PA15', '137', '2020-12-11', 'I liked the view'),
('PA16', '135', '2021-08-10', 'I like this house'),
('PA17', '220', '2021-04-04', 'Perfect');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Branch`
--
ALTER TABLE `Branch`
  ADD PRIMARY KEY (`branchNo`),
  ADD UNIQUE KEY `branchTelNo` (`branchTelNo`,`branchFaxNo`),
  ADD KEY `Branch_FK` (`managerStaffNo`);

--
-- Indexes for table `CUSTOMER_T`
--
ALTER TABLE `CUSTOMER_T`
  ADD PRIMARY KEY (`CUSTOMER_ID`);

--
-- Indexes for table `ORDER_LINE_T`
--
ALTER TABLE `ORDER_LINE_T`
  ADD PRIMARY KEY (`ORDER_ID`,`PRODUCT_ID`),
  ADD KEY `ORDER_LINE_FK2` (`PRODUCT_ID`);

--
-- Indexes for table `ORDER_T`
--
ALTER TABLE `ORDER_T`
  ADD PRIMARY KEY (`ORDER_ID`),
  ADD KEY `ORDER_FK` (`CUSTOMER_ID`);

--
-- Indexes for table `PrivateOwner`
--
ALTER TABLE `PrivateOwner`
  ADD PRIMARY KEY (`ownerNo`);

--
-- Indexes for table `PRODUCT_T`
--
ALTER TABLE `PRODUCT_T`
  ADD PRIMARY KEY (`PRODUCT_ID`);

--
-- Indexes for table `PropertyForRent`
--
ALTER TABLE `PropertyForRent`
  ADD PRIMARY KEY (`propertyNo`),
  ADD KEY `PropertyForRent_FK1` (`staffNo`),
  ADD KEY `PropertyForRent_FK2` (`ownerNo`),
  ADD KEY `PropertyForRent_FK3` (`branchNo`);

--
-- Indexes for table `PropertyType`
--
ALTER TABLE `PropertyType`
  ADD PRIMARY KEY (`propTypeNo`);

--
-- Indexes for table `renter`
--
ALTER TABLE `renter`
  ADD PRIMARY KEY (`renterNo`),
  ADD KEY `renter_FK` (`prefTypeNo`);

--
-- Indexes for table `staff`
--
ALTER TABLE `staff`
  ADD PRIMARY KEY (`staffNo`),
  ADD KEY `staff_fk` (`branchNo`);

--
-- Indexes for table `Viewing`
--
ALTER TABLE `Viewing`
  ADD PRIMARY KEY (`propertyNo`,`renterNo`,`dateView`),
  ADD KEY `Viewing_FK2` (`renterNo`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Branch`
--
ALTER TABLE `Branch`
  ADD CONSTRAINT `Branch_FK` FOREIGN KEY (`managerStaffNo`) REFERENCES `staff` (`staffNo`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Constraints for table `ORDER_LINE_T`
--
ALTER TABLE `ORDER_LINE_T`
  ADD CONSTRAINT `ORDER_LINE_FK1` FOREIGN KEY (`ORDER_ID`) REFERENCES `ORDER_T` (`ORDER_ID`),
  ADD CONSTRAINT `ORDER_LINE_FK2` FOREIGN KEY (`PRODUCT_ID`) REFERENCES `PRODUCT_T` (`PRODUCT_ID`);

--
-- Constraints for table `ORDER_T`
--
ALTER TABLE `ORDER_T`
  ADD CONSTRAINT `ORDER_FK` FOREIGN KEY (`CUSTOMER_ID`) REFERENCES `CUSTOMER_T` (`CUSTOMER_ID`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `PropertyForRent`
--
ALTER TABLE `PropertyForRent`
  ADD CONSTRAINT `PropertyForRent_FK1` FOREIGN KEY (`staffNo`) REFERENCES `staff` (`staffNo`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `PropertyForRent_FK2` FOREIGN KEY (`ownerNo`) REFERENCES `PrivateOwner` (`ownerNo`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `PropertyForRent_FK3` FOREIGN KEY (`branchNo`) REFERENCES `Branch` (`branchNo`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Constraints for table `renter`
--
ALTER TABLE `renter`
  ADD CONSTRAINT `renter_FK` FOREIGN KEY (`prefTypeNo`) REFERENCES `PropertyType` (`propTypeNo`);

--
-- Constraints for table `staff`
--
ALTER TABLE `staff`
  ADD CONSTRAINT `staff_fk` FOREIGN KEY (`branchNo`) REFERENCES `Branch` (`branchNo`);

--
-- Constraints for table `Viewing`
--
ALTER TABLE `Viewing`
  ADD CONSTRAINT `Viewing_FK1` FOREIGN KEY (`propertyNo`) REFERENCES `PropertyForRent` (`propertyNo`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `Viewing_FK2` FOREIGN KEY (`renterNo`) REFERENCES `renter` (`renterNo`) ON DELETE NO ACTION ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
