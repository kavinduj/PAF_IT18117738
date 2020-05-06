-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3308
-- Generation Time: May 06, 2020 at 02:50 PM
-- Server version: 8.0.18
-- PHP Version: 7.3.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `paf`
--

-- --------------------------------------------------------

--
-- Table structure for table `appointment`
--

DROP TABLE IF EXISTS `appointment`;
CREATE TABLE IF NOT EXISTS `appointment` (
  `A_AppointmentID` int(11) NOT NULL AUTO_INCREMENT,
  `A_PatientName` varchar(30) NOT NULL,
  `A_PatientNIC` varchar(12) NOT NULL,
  `A_PatientPhoneNo` varchar(10) NOT NULL,
  `A_DoctorName` varchar(30) NOT NULL,
  `A_HospitalName` varchar(30) NOT NULL,
  `A_Date` date NOT NULL,
  `A_Time` time NOT NULL,
  PRIMARY KEY (`A_AppointmentID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `doctor_reg_req`
--

DROP TABLE IF EXISTS `doctor_reg_req`;
CREATE TABLE IF NOT EXISTS `doctor_reg_req` (
  `D_NIC` varchar(12) NOT NULL,
  `D_Name` varchar(30) NOT NULL,
  `D_PhoneNumber` varchar(10) NOT NULL,
  `D_Fee` decimal(5,2) NOT NULL,
  `D_Email` varchar(30) NOT NULL,
  `D_Specialization` varchar(30) NOT NULL,
  `D_RegisterNumber` varchar(10) NOT NULL,
  `D_Hospitals` varchar(100) NOT NULL,
  PRIMARY KEY (`D_NIC`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `hospitalrreq`
--

DROP TABLE IF EXISTS `hospitalrreq`;
CREATE TABLE IF NOT EXISTS `hospitalrreq` (
  `RegNumber` varchar(10) NOT NULL,
  `Hospital_Name` varchar(30) NOT NULL,
  `Address` varchar(50) NOT NULL,
  `PhoneNumber` varchar(10) NOT NULL,
  `Email` varchar(40) NOT NULL,
  PRIMARY KEY (`RegNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
CREATE TABLE IF NOT EXISTS `payment` (
  `P_PaymentID` int(11) NOT NULL AUTO_INCREMENT,
  `P_Amount` decimal(5,2) NOT NULL,
  `P_NameOnCard` varchar(30) NOT NULL,
  `P_CVC` varchar(4) NOT NULL,
  `P_ExpiringDate` date NOT NULL,
  `P_CardNumber` varchar(16) NOT NULL,
  `P_AppointmentID` int(11) NOT NULL,
  PRIMARY KEY (`P_PaymentID`),
  KEY `fk_appointmentid` (`P_AppointmentID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `registered_doctor`
--

DROP TABLE IF EXISTS `registered_doctor`;
CREATE TABLE IF NOT EXISTS `registered_doctor` (
  `RD_ID` int(11) NOT NULL AUTO_INCREMENT,
  `RD_Name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `RD_Specialization` varchar(30) NOT NULL,
  `RD_NIC` varchar(12) NOT NULL,
  `RD_Hospital` varchar(20) NOT NULL,
  `RD_RegisterNumber` varchar(15) NOT NULL,
  `RD_PhoneNumber` varchar(10) NOT NULL,
  `RD_Email` varchar(40) NOT NULL,
  `RD_Fee` decimal(5,2) NOT NULL,
  `RD_Monday` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `RD_Tuesday` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `RD_Wednesday` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `RD_Thursday` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `RD_Friday` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `RD_Saturday` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `RD_Sunday` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`RD_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `registered_doctor`
--

INSERT INTO `registered_doctor` (`RD_ID`, `RD_Name`, `RD_Specialization`, `RD_NIC`, `RD_Hospital`, `RD_RegisterNumber`, `RD_PhoneNumber`, `RD_Email`, `RD_Fee`, `RD_Monday`, `RD_Tuesday`, `RD_Wednesday`, `RD_Thursday`, `RD_Friday`, `RD_Saturday`, `RD_Sunday`) VALUES
(1, 'Manelka Gamage', 'E.N.T', '98765432V', 'Asiri', 'D1570LK', '077589346', 'doctor1@gmail.com', '999.99', 'unavailable', 'unavailable', 'unavailable', 'unavailable', 'unavailable', 'available at asiri 2.00pm - 5.', 'unavailable');

-- --------------------------------------------------------

--
-- Table structure for table `registered_hospital`
--

DROP TABLE IF EXISTS `registered_hospital`;
CREATE TABLE IF NOT EXISTS `registered_hospital` (
  `Hospital_ID` int(11) NOT NULL AUTO_INCREMENT,
  `HospitalName` varchar(30) NOT NULL,
  `Email` varchar(30) NOT NULL,
  `Address` varchar(50) NOT NULL,
  `PhoneNumber` varchar(10) NOT NULL,
  `Reg_Number` varchar(10) NOT NULL,
  PRIMARY KEY (`Hospital_ID`),
  KEY `fk_regNumber` (`Reg_Number`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `registered_hospital`
--

INSERT INTO `registered_hospital` (`Hospital_ID`, `HospitalName`, `Email`, `Address`, `PhoneNumber`, `Reg_Number`) VALUES
(11, 'Hemas', 'hemas@gmail.com', 'Thalawathugoda, Colombo', '011445591', 'LKH459'),
(18, 'Asiri', 'asiri@gmail.com', 'Galle', '091445591', 'LKH865'),
(24, 'Nawaloka', 'nawaloka@gmail.com', 'Nawaloka,Colombo 6', '0115445588', 'LKH456');

-- --------------------------------------------------------

--
-- Table structure for table `reguser`
--

DROP TABLE IF EXISTS `reguser`;
CREATE TABLE IF NOT EXISTS `reguser` (
  `NIC` varchar(12) NOT NULL,
  `Name` varchar(20) NOT NULL,
  `Password` varchar(20) NOT NULL,
  `PhoneNumber` varchar(10) NOT NULL,
  PRIMARY KEY (`NIC`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
