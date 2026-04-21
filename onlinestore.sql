-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 01, 2025 at 01:28 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `onlinestore`
--

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `ID` int(11) NOT NULL,
  `Description` varchar(50) DEFAULT NULL,
  `Name` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `contain`
--

CREATE TABLE `contain` (
  `Category_ID` int(11) DEFAULT NULL,
  `Warehouse_ID` int(11) DEFAULT NULL,
  `Product_ID` int(11) DEFAULT NULL,
  `Quantity` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `ID` int(11) NOT NULL,
  `First_Name` varchar(15) NOT NULL,
  `Last_Name` varchar(15) NOT NULL,
  `Gender` char(1) NOT NULL,
  `Status` varchar(10) DEFAULT NULL,
  `Email` varchar(50) DEFAULT NULL,
  `phone` varchar(15) NOT NULL,
  `Address` varchar(30) DEFAULT NULL,
  `Birth_Date` date DEFAULT NULL,
  `Registeration_Date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `departments`
--

CREATE TABLE `departments` (
  `ID` int(11) NOT NULL,
  `Dep_Name` varchar(15) NOT NULL,
  `Mgr_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE `employees` (
  `ID` int(11) NOT NULL,
  `Status` varchar(10) DEFAULT NULL,
  `Salary` decimal(10,2) DEFAULT NULL,
  `First_Name` varchar(15) NOT NULL,
  `Last_Name` varchar(15) NOT NULL,
  `Email` varchar(20) DEFAULT NULL,
  `Gender` varchar(10) NOT NULL,
  `Attribute` varchar(20) DEFAULT NULL,
  `Super_ID` int(11) DEFAULT NULL,
  `Phone` varchar(15) DEFAULT NULL,
  `Dep_ID` int(11) DEFAULT NULL,
  `Address` varchar(30) DEFAULT NULL,
  `Birth_Date` date DEFAULT NULL,
  `Hire_Date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `ID` int(11) NOT NULL,
  `Amount` int(11) DEFAULT NULL,
  `Order_Date` date DEFAULT NULL,
  `Delivery_Date` date DEFAULT NULL,
  `Status` varchar(10) DEFAULT NULL,
  `Customer_ID` int(11) DEFAULT NULL,
  `Delivery_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `order_details`
--

CREATE TABLE `order_details` (
  `Order_ID` int(11) DEFAULT NULL,
  `Product_ID` int(11) DEFAULT NULL,
  `Quantity` int(11) NOT NULL,
  `Price` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `ID` int(11) NOT NULL,
  `Price` decimal(10,2) DEFAULT NULL,
  `Name` varchar(15) NOT NULL,
  `Quantity` int(11) DEFAULT NULL,
  `Category_ID` int(11) DEFAULT NULL,
  `Status` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sell`
--

CREATE TABLE `sell` (
  `Product_ID` int(11) DEFAULT NULL,
  `Category_ID` int(11) DEFAULT NULL,
  `Vendor_ID` int(11) DEFAULT NULL,
  `Quantity` int(11) NOT NULL,
  `Date` date DEFAULT NULL,
  `Price` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `vendor`
--

CREATE TABLE `vendor` (
  `ID` int(11) NOT NULL,
  `First_Name` varchar(15) NOT NULL,
  `Last_Name` varchar(15) NOT NULL,
  `Email` varchar(30) DEFAULT NULL,
  `Address` varchar(30) DEFAULT NULL,
  `Phone` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `warehouse`
--

CREATE TABLE `warehouse` (
  `ID` int(11) NOT NULL,
  `Name` int(11) NOT NULL,
  `Location` varchar(30) NOT NULL,
  `Capacity` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `contain`
--
ALTER TABLE `contain`
  ADD KEY `CategoryFK1` (`Category_ID`),
  ADD KEY `ProductFK1` (`Product_ID`),
  ADD KEY `WarehouseFK` (`Warehouse_ID`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `departments`
--
ALTER TABLE `departments`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `MgrFk` (`Mgr_ID`);

--
-- Indexes for table `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `SuperFK` (`Super_ID`),
  ADD KEY `DepFK` (`Dep_ID`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `CustomerFK` (`Customer_ID`),
  ADD KEY `EmployeeFK` (`Delivery_ID`);

--
-- Indexes for table `order_details`
--
ALTER TABLE `order_details`
  ADD KEY `OrderFK` (`Order_ID`),
  ADD KEY `ProductFK` (`Product_ID`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `CategoryFK` (`Category_ID`);

--
-- Indexes for table `sell`
--
ALTER TABLE `sell`
  ADD KEY `CategoryFK2` (`Category_ID`),
  ADD KEY `ProductFK2` (`Product_ID`),
  ADD KEY `VendorFK` (`Vendor_ID`);

--
-- Indexes for table `vendor`
--
ALTER TABLE `vendor`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `warehouse`
--
ALTER TABLE `warehouse`
  ADD PRIMARY KEY (`ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `departments`
--
ALTER TABLE `departments`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `employees`
--
ALTER TABLE `employees`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `vendor`
--
ALTER TABLE `vendor`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `warehouse`
--
ALTER TABLE `warehouse`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `contain`
--
ALTER TABLE `contain`
  ADD CONSTRAINT `CategoryFK1` FOREIGN KEY (`Category_ID`) REFERENCES `categories` (`ID`),
  ADD CONSTRAINT `ProductFK1` FOREIGN KEY (`Product_ID`) REFERENCES `products` (`ID`),
  ADD CONSTRAINT `WarehouseFK` FOREIGN KEY (`Warehouse_ID`) REFERENCES `warehouse` (`ID`);

--
-- Constraints for table `departments`
--
ALTER TABLE `departments`
  ADD CONSTRAINT `MgrFk` FOREIGN KEY (`Mgr_ID`) REFERENCES `employees` (`ID`);

--
-- Constraints for table `employees`
--
ALTER TABLE `employees`
  ADD CONSTRAINT `DepFK` FOREIGN KEY (`Dep_ID`) REFERENCES `departments` (`ID`),
  ADD CONSTRAINT `SuperFK` FOREIGN KEY (`Super_ID`) REFERENCES `employees` (`ID`);

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `CustomerFK` FOREIGN KEY (`Customer_ID`) REFERENCES `customers` (`ID`),
  ADD CONSTRAINT `EmployeeFK` FOREIGN KEY (`Delivery_ID`) REFERENCES `employees` (`ID`);

--
-- Constraints for table `order_details`
--
ALTER TABLE `order_details`
  ADD CONSTRAINT `OrderFK` FOREIGN KEY (`Order_ID`) REFERENCES `orders` (`ID`),
  ADD CONSTRAINT `ProductFK` FOREIGN KEY (`Product_ID`) REFERENCES `products` (`ID`);

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `CategoryFK` FOREIGN KEY (`Category_ID`) REFERENCES `categories` (`ID`);

--
-- Constraints for table `sell`
--
ALTER TABLE `sell`
  ADD CONSTRAINT `CategoryFK2` FOREIGN KEY (`Category_ID`) REFERENCES `categories` (`ID`),
  ADD CONSTRAINT `ProductFK2` FOREIGN KEY (`Product_ID`) REFERENCES `products` (`ID`),
  ADD CONSTRAINT `VendorFK` FOREIGN KEY (`Vendor_ID`) REFERENCES `vendor` (`ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
