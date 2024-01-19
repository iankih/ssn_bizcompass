-- MySQL dump 10.13  Distrib 8.2.0, for Win64 (x86_64)
--
-- Host: localhost    Database: bizcompass
-- ------------------------------------------------------
-- Server version	8.2.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `documents`
--

DROP TABLE IF EXISTS `documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `documents` (
  `DocumentID` int NOT NULL AUTO_INCREMENT,
  `TaskID` int DEFAULT NULL,
  `DocumentName` varchar(255) DEFAULT NULL,
  `DocumentPath` text,
  PRIMARY KEY (`DocumentID`),
  KEY `TaskID` (`TaskID`),
  CONSTRAINT `documents_ibfk_1` FOREIGN KEY (`TaskID`) REFERENCES `tasks` (`TaskID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documents`
--

LOCK TABLES `documents` WRITE;
/*!40000 ALTER TABLE `documents` DISABLE KEYS */;
/*!40000 ALTER TABLE `documents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `leave`
--

DROP TABLE IF EXISTS `leave`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `leave` (
  `LeaveID` int NOT NULL AUTO_INCREMENT,
  `MemberID` int DEFAULT NULL,
  `LeaveDate` date DEFAULT NULL,
  `LeaveType` varchar(100) DEFAULT NULL,
  `Reason` text,
  PRIMARY KEY (`LeaveID`),
  KEY `MemberID` (`MemberID`),
  CONSTRAINT `leave_ibfk_1` FOREIGN KEY (`MemberID`) REFERENCES `teammembers` (`MemberID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `leave`
--

LOCK TABLES `leave` WRITE;
/*!40000 ALTER TABLE `leave` DISABLE KEYS */;
/*!40000 ALTER TABLE `leave` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reports`
--

DROP TABLE IF EXISTS `reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reports` (
  `ReportID` int NOT NULL AUTO_INCREMENT,
  `MemberID` int DEFAULT NULL,
  `SubmissionDate` date DEFAULT NULL,
  `ReportContent` text,
  PRIMARY KEY (`ReportID`),
  KEY `MemberID` (`MemberID`),
  CONSTRAINT `reports_ibfk_1` FOREIGN KEY (`MemberID`) REFERENCES `teammembers` (`MemberID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reports`
--

LOCK TABLES `reports` WRITE;
/*!40000 ALTER TABLE `reports` DISABLE KEYS */;
/*!40000 ALTER TABLE `reports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `taskhistory`
--

DROP TABLE IF EXISTS `taskhistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `taskhistory` (
  `HistoryID` int NOT NULL AUTO_INCREMENT,
  `TaskID` int DEFAULT NULL,
  `UpdateDate` date DEFAULT NULL,
  `Status` varchar(100) DEFAULT NULL,
  `Comments` text,
  PRIMARY KEY (`HistoryID`),
  KEY `TaskID` (`TaskID`),
  CONSTRAINT `taskhistory_ibfk_1` FOREIGN KEY (`TaskID`) REFERENCES `tasks` (`TaskID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `taskhistory`
--

LOCK TABLES `taskhistory` WRITE;
/*!40000 ALTER TABLE `taskhistory` DISABLE KEYS */;
/*!40000 ALTER TABLE `taskhistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tasks`
--

DROP TABLE IF EXISTS `tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tasks` (
  `TaskID` int NOT NULL AUTO_INCREMENT,
  `MemberID` int DEFAULT NULL,
  `StartDate` date DEFAULT NULL,
  `DueDate` date DEFAULT NULL,
  `Requester` varchar(255) DEFAULT NULL,
  `TaskType` varchar(50) DEFAULT NULL,
  `Priority` varchar(50) DEFAULT NULL,
  `Description` text,
  PRIMARY KEY (`TaskID`),
  KEY `MemberID` (`MemberID`),
  CONSTRAINT `tasks_ibfk_1` FOREIGN KEY (`MemberID`) REFERENCES `teammembers` (`MemberID`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tasks`
--

LOCK TABLES `tasks` WRITE;
/*!40000 ALTER TABLE `tasks` DISABLE KEYS */;
INSERT INTO `tasks` VALUES (1,NULL,'2024-01-01','2024-01-07','홍길동','개발','높음','API 개발'),(2,NULL,'2024-01-01','2024-01-07','홍길동','개발','높음','API 개발'),(7,4,'2024-01-20','2024-01-25',NULL,'개발','높음','새로운 기능 개발'),(8,4,'2024-01-20','2024-01-25',NULL,'개발','높음','새로운 기능 개발'),(9,4,'2024-01-20','2024-01-25',NULL,'개발','높음','새로운 기능 개발');
/*!40000 ALTER TABLE `tasks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teammembers`
--

DROP TABLE IF EXISTS `teammembers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teammembers` (
  `MemberID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `Email` varchar(255) DEFAULT NULL,
  `PasswordHash` varchar(255) DEFAULT NULL,
  `PhoneNumber` varchar(20) DEFAULT NULL,
  `Position` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`MemberID`),
  UNIQUE KEY `Email` (`Email`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teammembers`
--

LOCK TABLES `teammembers` WRITE;
/*!40000 ALTER TABLE `teammembers` DISABLE KEYS */;
INSERT INTO `teammembers` VALUES (4,'홍길동','hong@example.com','$2b$10$sv0pS6CNJUOn7E8dQmJ0ieUai0LT0cQL0rFjROhgERYlO3VgDHz8K','010-1234-5678','사원');
/*!40000 ALTER TABLE `teammembers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `UserID` int NOT NULL AUTO_INCREMENT,
  `Username` varchar(255) NOT NULL,
  `PasswordHash` varchar(255) NOT NULL,
  `Email` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`UserID`),
  UNIQUE KEY `Username` (`Username`),
  UNIQUE KEY `Email` (`Email`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'testuser','1234','testuser@example.com'),(3,'testuser1','$2b$10$oHMM2viBYvOufA5KzrqLLOE3t1l4b71DUGcXiGwaf9zoDk4BrmSWS','newuser1@example.com'),(5,'testuser2','$2b$10$dvj6S2p4Z70Zx5/b5vrTKe1NcbBBc.KgpdyF4LkQkNQtb2M6yakfi','newuser2@example.com');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-01-16 18:57:25
