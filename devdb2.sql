-- MySQL dump 10.13  Distrib 8.0.41, for Linux (x86_64)
--
-- Host: localhost    Database: invo_dev
-- ------------------------------------------------------
-- Server version	8.0.41

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
-- Table structure for table `tr_account`
--

DROP TABLE IF EXISTS `tr_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tr_account` (
  `id` int NOT NULL AUTO_INCREMENT,
  `account` varchar(20) DEFAULT NULL,
  `debt` int DEFAULT NULL,
  `credit` int DEFAULT NULL,
  `date` date DEFAULT NULL,
  `remarks` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tr_account`
--

LOCK TABLES `tr_account` WRITE;
/*!40000 ALTER TABLE `tr_account` DISABLE KEYS */;
/*!40000 ALTER TABLE `tr_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `buyer`
--

DROP TABLE IF EXISTS `buyer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `buyer` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `city` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `buyer`
--

LOCK TABLES `buyer` WRITE;
/*!40000 ALTER TABLE `buyer` DISABLE KEYS */;
INSERT INTO `buyer` VALUES (1,'test ','test@123','1234','tuni'),(2,'sri raj cmputers','srtraj@gmail.com','','pdp'),(3,'Sri Sai Computers','srisaicomputers@gmail.com','9502481285','visakhapatnam'),(4,'ARIYANTH COMPUTERS','ariyanth@gmailcom','9849449123','vizag'),(5,'SSS TECNOLAZYS(SIVA)','siva@gmail.com','9640443842','peddapuram'),(6,'SRI SOLUTIONS','','9948433334,','KKD'),(7,'ZYLAN INTER NATIONLAS','','9555936064','DELHI');
/*!40000 ALTER TABLE `buyer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item`
--

DROP TABLE IF EXISTS `item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `item` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `model` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item`
--

LOCK TABLES `item` WRITE;
/*!40000 ALTER TABLE `item` DISABLE KEYS */;
INSERT INTO `item` VALUES (1,'test item','model1'),(2,'mther board','61'),(3,'mother board','61'),(4,'mother board','81'),(5,'mother board','110'),(6,'RAM','DDR2'),(7,'RAM','DDR3  8GB'),(8,'RAM','DDR4  8GB'),(9,'PROCESSER','I3 3RD'),(10,'PROCESSER','I3 4TH'),(11,'PROCESSER','I3  6TH'),(12,'PROCESSER','I3 8TH'),(13,'PROCESSER','I3 9TH'),(14,'PROCESSER','I5  '),(15,'FAN','61'),(16,'SSD','128'),(17,'SSD','256'),(18,'SSD','512'),(19,'HDD','5000 GB'),(20,'HDD','1TB');
/*!40000 ALTER TABLE `item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventory_item`
--

DROP TABLE IF EXISTS `inventory_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventory_item` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL,
  `tag` varchar(100) DEFAULT NULL,
  `tagval` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventory_item`
--

LOCK TABLES `inventory_item` WRITE;
/*!40000 ALTER TABLE `inventory_item` DISABLE KEYS */;
INSERT INTO `inventory_item` VALUES (3,'BULLET IP','item,Specification,Model','1'),(4,'CABINET','item,Specification,Model','1'),(5,'CATARAGE','item,Specification,Model','1'),(6,'CC CEMRS','item,Specification,Model','1'),(7,'DOMS  IP','item,Specification,Model','1'),(8,'DOMS TV1','item,Specification,Model','1'),(9,'EPSON INKS','item,Specification,Model','1'),(10,'FAN','item,Specification,Model','1'),(11,'HDD','item,Specification,Model','1'),(12,'HDMI CABLES','item,Specification,Model','1'),(13,'HDMI TO LAN','item,Specification,Model','1'),(14,'INK PADS','item,Specification,Model','1'),(15,'KEY BOARDS','item,Specification,Model','1'),(16,'LAPTOP ADP','item,Specification,Model','1'),(17,'LAPTOP CASIN','item,Specification,Model','1'),(18,'MONITRS','item,Specification,Model','1'),(19,'MOTHER BOARD','item,Specification,Model','1'),(20,'MOUSE','item,Specification,Model','1'),(21,'POWER CARDS','item,Specification,Model','1'),(22,'PRITER DATA','item,Specification,Model','1'),(23,'PROCESER','item,Specification,Model','1'),(24,'RAM','item,Specification,Model','1'),(25,'S.M.PS','item,Specification,Model','1'),(26,'SATA DATA','item,Specification,Model','1'),(27,'SATA POWER','item,Specification,Model','1'),(28,'SSD','item,Specification,Model','1'),(29,'SSD CASING','item,Specification,Model','1'),(30,'USB','item,Specification,Model','1'),(31,'USB ','item,Specification,Model','1'),(32,'USB EXTENTION','item,Specification,Model','1'),(33,'VGA CABLES','item,Specification,Model','1');
/*!40000 ALTER TABLE `inventory_item` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-18 16:46:53
