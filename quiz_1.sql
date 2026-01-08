-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 08, 2026 at 12:59 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `quiz_1`
--

-- --------------------------------------------------------

--
-- Table structure for table `branch`
--

CREATE TABLE `branch` (
  `branch_id` int(11) NOT NULL,
  `branch_name` varchar(40) NOT NULL,
  `mgr_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `branch`
--

INSERT INTO `branch` (`branch_id`, `branch_name`, `mgr_id`) VALUES
(1, 'Corporate', 100),
(2, 'Scranton', 101),
(3, 'Stamford', 102);

-- --------------------------------------------------------

--
-- Table structure for table `client`
--

CREATE TABLE `client` (
  `client_id` int(11) NOT NULL,
  `client_name` varchar(40) NOT NULL,
  `branch_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `client`
--

INSERT INTO `client` (`client_id`, `client_name`, `branch_id`) VALUES
(400, 'Dummore Highschool', 2),
(401, 'Lackawana County', 2),
(402, 'FedEx', 3),
(403, 'John Daly Law, LLC', 3),
(404, 'Scranton Whitepages', 2);

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

CREATE TABLE `employee` (
  `emp_id` int(11) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `birth_date` date NOT NULL,
  `sex` char(1) NOT NULL,
  `salary` int(11) NOT NULL CHECK (`salary` > 0),
  `branch_id` int(11) DEFAULT NULL,
  `super_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `employee`
--

INSERT INTO `employee` (`emp_id`, `first_name`, `last_name`, `birth_date`, `sex`, `salary`, `branch_id`, `super_id`) VALUES
(100, 'Jan', 'Levinson', '1999-03-11', 'F', 110000, 1, NULL),
(101, 'Michael', 'Scott', '1967-01-21', 'M', 75000, 2, 100),
(102, 'Josh', 'Porter', '1969-03-12', 'M', 78000, 3, 100),
(103, 'Angela', 'Martin', '1971-06-05', 'F', 63000, 3, 101),
(104, 'Andy', 'Bernard', '1973-07-22', 'M', 65000, 3, 101);

-- --------------------------------------------------------

--
-- Table structure for table `works_with`
--

CREATE TABLE `works_with` (
  `emp_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `total_sales` int(11) NOT NULL CHECK (`total_sales` >= 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `works_with`
--

INSERT INTO `works_with` (`emp_id`, `client_id`, `total_sales`) VALUES
(101, 401, 267000),
(102, 404, 45000),
(103, 402, 53000),
(104, 402, 62000);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `branch`
--
ALTER TABLE `branch`
  ADD PRIMARY KEY (`branch_id`),
  ADD KEY `fk_branch_mgr` (`mgr_id`);

--
-- Indexes for table `client`
--
ALTER TABLE `client`
  ADD PRIMARY KEY (`client_id`),
  ADD KEY `branch_id` (`branch_id`);

--
-- Indexes for table `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`emp_id`),
  ADD KEY `branch_id` (`branch_id`),
  ADD KEY `super_id` (`super_id`);

--
-- Indexes for table `works_with`
--
ALTER TABLE `works_with`
  ADD PRIMARY KEY (`emp_id`,`client_id`),
  ADD KEY `client_id` (`client_id`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `branch`
--
ALTER TABLE `branch`
  ADD CONSTRAINT `fk_branch_mgr` FOREIGN KEY (`mgr_id`) REFERENCES `employee` (`emp_id`) ON DELETE SET NULL;

--
-- Constraints for table `client`
--
ALTER TABLE `client`
  ADD CONSTRAINT `client_ibfk_1` FOREIGN KEY (`branch_id`) REFERENCES `branch` (`branch_id`) ON DELETE SET NULL;

--
-- Constraints for table `employee`
--
ALTER TABLE `employee`
  ADD CONSTRAINT `employee_ibfk_1` FOREIGN KEY (`branch_id`) REFERENCES `branch` (`branch_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `employee_ibfk_2` FOREIGN KEY (`super_id`) REFERENCES `employee` (`emp_id`) ON DELETE SET NULL;

--
-- Constraints for table `works_with`
--
ALTER TABLE `works_with`
  ADD CONSTRAINT `works_with_ibfk_1` FOREIGN KEY (`emp_id`) REFERENCES `employee` (`emp_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `works_with_ibfk_2` FOREIGN KEY (`client_id`) REFERENCES `client` (`client_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
