-- MySQL dump 10.13  Distrib 8.0.44, for Linux (x86_64)
--
-- Host: localhost    Database: invo
-- ------------------------------------------------------
-- Server version	8.0.44

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
-- Table structure for table `acc_item`
--

DROP TABLE IF EXISTS `acc_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `acc_item` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL,
  `description` varchar(50) DEFAULT NULL,
  `category` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acc_item`
--

LOCK TABLES `acc_item` WRITE;
/*!40000 ALTER TABLE `acc_item` DISABLE KEYS */;
INSERT INTO `acc_item` VALUES (1,'LKP','',NULL),(2,'INVO','',NULL),(3,'AMMA INDUS','',NULL),(4,'VEG','',NULL),(5,'FRUITS','',NULL),(6,'MAINTENANCE','',NULL),(7,'DRESS','',NULL),(8,'MEDICINE','',NULL),(9,'FOOD','',NULL),(10,'ACCTR','',NULL),(11,'RENT','',NULL),(12,'MILK','',NULL),(13,'ICICI','',NULL),(14,'Medical Test','',NULL),(15,'Dress','',NULL),(16,'BOOK','',NULL),(17,'LALITHA','',NULL),(18,'GRT','',NULL),(19,'HOSPITAL','',NULL),(20,'MOBILE','',NULL),(21,'BROADBAND','',NULL),(22,'GROCERY','',NULL),(23,'AROGYAMASTU','',NULL),(24,'ISHA','',NULL),(25,'MOVIE','',NULL),(26,'Journey','',''),(27,'Thangamayil','',''),(28,'Arts','',''),(29,'Odugu','',''),(30,'School','',''),(31,'BOI-EMI','',''),(32,'Electronics','',''),(33,'Craft','',''),(34,'House Items','',''),(35,'Subscription','','');
/*!40000 ALTER TABLE `acc_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account`
--

DROP TABLE IF EXISTS `account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL,
  `description` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account`
--

LOCK TABLES `account` WRITE;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
INSERT INTO `account` VALUES (1,'HDFC',''),(2,'BOILN',''),(3,'BOIS',''),(4,'BOID',''),(5,'CASH',''),(6,'OWNER',''),(7,'SBIS',''),(8,'SBIU',''),(9,'SMAL OWNER',''),(10,'AMMA INDUS',''),(11,'HDFC CC',''),(12,'HDFC UPI',''),(13,'ITEM',''),(14,'ICICI',''),(15,'AmazonPay',''),(16,'Subscriptions','');
/*!40000 ALTER TABLE `account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assign_task`
--

DROP TABLE IF EXISTS `assign_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `assign_task` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `task_id` int DEFAULT NULL,
  `status` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `assign_task_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `invo_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assign_task`
--

LOCK TABLES `assign_task` WRITE;
/*!40000 ALTER TABLE `assign_task` DISABLE KEYS */;
INSERT INTO `assign_task` VALUES (1,1,1,1),(2,1,2,1),(3,2,1,1),(4,2,2,1),(5,3,1,1),(6,3,1,1),(7,1,1,1),(8,1,5,1),(9,1,6,1),(10,2,7,1),(11,1,8,1),(12,3,9,1),(13,3,10,1),(14,1,11,1),(15,2,12,1),(16,3,13,1),(17,1,14,1),(18,1,15,1),(19,1,16,1),(20,1,17,1),(21,1,18,1),(22,1,19,1),(23,2,20,1),(24,2,21,1),(25,1,22,1),(26,4,23,1),(27,1,24,1),(28,2,25,1),(29,1,26,1),(30,2,27,1),(31,1,28,1),(32,4,29,1),(33,4,30,1),(34,1,31,1),(35,1,32,1),(36,2,33,1),(37,3,34,1),(38,4,35,1),(39,1,36,1),(40,2,37,1),(41,3,38,1);
/*!40000 ALTER TABLE `assign_task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bucket`
--

DROP TABLE IF EXISTS `bucket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bucket` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` text,
  `duration` int DEFAULT NULL,
  `enabled_user` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bucket`
--

LOCK TABLES `bucket` WRITE;
/*!40000 ALTER TABLE `bucket` DISABLE KEYS */;
INSERT INTO `bucket` VALUES (1,'testbucket','Description for bucket 1',30,'1,2,3,3'),(2,'INVO','For Invo Self',365,NULL),(3,'Chandamama','Chandamama',365,'5'),(4,'Neelima','Neelima',365,'3'),(5,'Raji','Raji',365,'2'),(6,'US','US',3650,'5');
/*!40000 ALTER TABLE `bucket` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bucket_details`
--

DROP TABLE IF EXISTS `bucket_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bucket_details` (
  `name` varchar(50) DEFAULT NULL,
  `script` varchar(50) DEFAULT NULL,
  `exchange` varchar(10) DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `last_updated` date DEFAULT NULL,
  `avg_price` decimal(10,2) DEFAULT NULL,
  `current_price` decimal(10,2) DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  `bucket_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_bkt_id` (`bucket_id`),
  CONSTRAINT `fk_bkt_id` FOREIGN KEY (`bucket_id`) REFERENCES `bucket` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bucket_details`
--

LOCK TABLES `bucket_details` WRITE;
/*!40000 ALTER TABLE `bucket_details` DISABLE KEYS */;
INSERT INTO `bucket_details` VALUES ('INVO','SJVN','BSE',75,'2025-03-20',96.83,0.00,1,2),('Chandamama','RailTel Corporation of India Ltd','BSE',10,'2025-03-21',278.95,0.00,2,3),('Raji','RELAXO FOOTWEARS LTD','BSE',22,'2025-03-27',406.36,0.00,3,5),('None','Item 1','BSE',119,'2025-04-04',229.25,0.00,4,NULL),('Neelima','RailTel Corporation of India Ltd','BSE',51,'2025-04-04',292.25,0.00,5,4);
/*!40000 ALTER TABLE `bucket_details` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `buyer`
--

LOCK TABLES `buyer` WRITE;
/*!40000 ALTER TABLE `buyer` DISABLE KEYS */;
INSERT INTO `buyer` VALUES (1,'test ','test@123','1234','tuni'),(2,'sri raj cmputers','srtraj@gmail.com','','pdp'),(3,'Sri Sai Computers','srisaicomputers@gmail.com','9502481285','visakhapatnam'),(4,'ARIYANTH COMPUTERS','ariyanth@gmailcom','9849449123','vizag'),(5,'SSS TECNOLAZYS(SIVA)','siva@gmail.com','9640443842','peddapuram'),(6,'SRI SOLUTIONS','','9948433334,','KKD'),(7,'ZYLAN INTER NATIONLAS','','9555936064','DELHI'),(8,'test','test','6789','tuni'),(9,'santhosh','san','123456','chennai'),(10,'EPW','','9989790106','HYD'),(11,'sajnthosh','santhos.com','89898989','mas'),(12,'newbuyer','newbuyer.com','9988998899','mas'),(13,'sriram marketing','sunil.srirammkt@gmail.com','9030174574','hyd'),(14,'COMPUTER POINT','thecomputerpoint@hotmail.com','9246745965','Rajamundry'),(15,'R.K ELECTRINIOCS','rkelectricals.vj@gmail.com','9966820999','VIJAYAWADA'),(16,'SIDDI VINAYAKA TECHNOLOGY','srisiddivinayakatechnology2024@gmail.com','8125531098','VIJAYAWADA'),(17,'KAKINADA COMPUTERS','kakinadacomputers@gmail.com','9154334420','KAKINADA'),(18,'USHA  ELECTRONICS BHAVESH','bhavesh@gmail.com','9494935555','ANAKAPALLI'),(19,'RC OLD STOCK','raghucomputers.tni@gmail.com491','9246788660','Tuni'),(20,'DRUVA TECHNOLOGES','raghucomputers.tni@gmail.com491','8919519023','VIZAG'),(21,'SERVICE','raghucomputers.tni@gmail.com491','09246788660','Tuni');
/*!40000 ALTER TABLE `buyer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `daily_indicators`
--

DROP TABLE IF EXISTS `daily_indicators`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `daily_indicators` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date` varchar(15) DEFAULT NULL,
  `indicator` varchar(30) DEFAULT NULL,
  `indicator_id` int DEFAULT NULL,
  `remarks` varchar(30) DEFAULT NULL,
  `ind_change` varchar(20) DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `user_name` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=180 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `daily_indicators`
--

LOCK TABLES `daily_indicators` WRITE;
/*!40000 ALTER TABLE `daily_indicators` DISABLE KEYS */;
INSERT INTO `daily_indicators` VALUES (1,'2025-02-11','2',NULL,'Positive','Increasemarke',1,NULL),(2,'2025-02-11','2',NULL,'Negative','Rato dect',1,NULL),(3,'2025-02-11','3',NULL,'Negative','Tax updates',1,NULL),(4,'2025-02-11','2',NULL,'Positive','Gold decrease ',1,NULL),(5,'2025-02-11','2',NULL,'Positive','Gold decrease ',1,NULL),(8,'2025-02-11','1',NULL,'Positive','Rato cuts',1,NULL),(9,'2025-02-11','2',NULL,'Negative','Task',1,NULL),(10,'2025-02-11','3',NULL,'Negative','Issues',1,NULL),(11,'2025-02-11','2',NULL,'Negative','Task ',1,NULL),(12,'2025-02-11','4',NULL,'Positive','Task',1,NULL),(13,'2025-02-11','1',NULL,'Positive','Gold increase ',1,NULL),(14,'2025-02-11','2',NULL,'Negative','Trump policy ',1,NULL),(15,'2025-02-11','4',NULL,'Negative','Increase grossary ',1,NULL),(16,'2025-02-11','5',NULL,'Positive','Tax updates',1,NULL),(17,'2025-02-11','6',NULL,'Negative','Tax updates',1,NULL),(18,'2025-02-12','2',NULL,'Negative','Tariffs',1,NULL),(19,'2025-02-12','2',NULL,'Positive','Modi trip usa',1,NULL),(20,'2025-02-12','2',NULL,'Negative','Trump polacy',1,NULL),(21,'2025-02-12','1',NULL,'Positive','test',1,NULL),(22,'2025-02-01','1',NULL,'Positive','this is a test',1,NULL),(23,'2025-02-01','2',NULL,'Negative','fasdfasdf',1,NULL),(24,'2025-02-01','3',NULL,'Positive','adf',1,NULL),(25,'2025-02-01','4',NULL,'Negative','afffff',1,NULL),(26,'2025-02-01','6',NULL,'Positive','gggggg',1,NULL),(27,'2025-02-12','2',NULL,'Positive','Modi use trip',1,NULL),(28,'2025-02-12','2',NULL,'Negative','Fear',1,NULL),(29,'2025-02-12','1',NULL,'Positive','Tariffs',1,NULL),(30,'2025-02-12','3',NULL,'Positive','Task',1,NULL),(31,'2025-02-12','2',NULL,'Negative','Task',1,NULL),(32,'2025-02-12','2',NULL,'Negative','Task',1,NULL),(33,'2025-02-12','2',NULL,'Positive','Modi use trip',1,NULL),(34,'2025-02-12','2',NULL,'Positive','Modi use trip',1,NULL),(35,'2025-02-12','2',NULL,'Positive','Modi use trip',1,NULL),(36,'2025-02-12','1',NULL,'Positive','Gold decrease ',1,NULL),(37,'2025-02-12','2',NULL,'Negative','Tax updates',1,NULL),(38,'2025-02-12','2',NULL,'Negative','',1,NULL),(39,'2025-02-12','4',NULL,'Negative','Gold decrease ',1,NULL),(40,'2025-02-12','5',NULL,'Positive','Modi use trip',1,NULL),(45,'2025-02-04','Anouncements',NULL,'Bonus on birthday','Positive',NULL,'raji'),(46,'2025-01-01','Global Issues',NULL,'test','Positive',NULL,'raji'),(47,'2025-02-13','Anouncements',NULL,'Steel aluminium taries polacy ','Negative',NULL,'Lakshmi'),(48,'2025-02-13','Global Markets',NULL,'Gold increase ','Negative',NULL,'Lakshmi'),(49,'2025-02-13','Global Issues',NULL,'Q3 effects ','Negative',NULL,'Lakshmi'),(50,'2025-02-13','Global Issues',NULL,'Marketselling','Negative',NULL,'Lakshmi'),(51,'2025-02-13','Domestic Issues',NULL,'Decrease rupes value ','Negative',NULL,'Lakshmi'),(52,'2025-02-13','Anouncements',NULL,'Steel aluminium taries polacy ','Negative',NULL,'Lakshmi'),(53,'2025-02-13','Global Markets',NULL,'Gold increase ','Negative',NULL,'Lakshmi'),(54,'2025-02-13','Global Issues',NULL,'Q3 effects ','Negative',NULL,'Lakshmi'),(55,'2025-02-13','Global Issues',NULL,'Marketselling','Negative',NULL,'Lakshmi'),(56,'2025-02-13','Domestic Issues',NULL,'Decrease rupes value ','Negative',NULL,'Lakshmi'),(57,'2025-02-13','Anouncements',NULL,'Fear','Positive',NULL,'raji'),(58,'2025-02-13','Global Issues',NULL,'Task','Negative',NULL,'raji'),(59,'2025-02-13','Anouncements',NULL,'Task','Positive',NULL,'raji'),(60,'2025-02-13','Global Markets',NULL,'Task','Positive',NULL,'raji'),(61,'2025-02-13','Anouncements',NULL,'Task','Negative',NULL,'raji'),(62,'2025-02-13','Global Issues',NULL,'Steel aluminium taries polacy ','Negative',NULL,'Lakshmi'),(63,'2025-02-13','Global Markets',NULL,'Russa ukran war','Negative',NULL,'Lakshmi'),(64,'2025-02-11','Anouncements',NULL,'Selling price','Negative',NULL,'raji'),(65,'2025-02-11','Global Issues',NULL,'Task ','Positive',NULL,'raji'),(66,'2025-02-11','Anouncements',NULL,'Task','Positive',NULL,'raji'),(67,'2025-02-11','Global Markets',NULL,'Task','Positive',NULL,'raji'),(68,'2025-02-11','Global Issues',NULL,'Task','Negative',NULL,'raji'),(69,'2025-02-11','Anouncements',NULL,'Selling price','Negative',NULL,'raji'),(70,'2025-02-11','Global Issues',NULL,'Task ','Positive',NULL,'raji'),(71,'2025-02-11','Anouncements',NULL,'Task','Positive',NULL,'raji'),(72,'2025-02-11','Global Markets',NULL,'Task','Positive',NULL,'raji'),(73,'2025-02-11','Global Issues',NULL,'Task','Negative',NULL,'raji'),(74,'2025-02-11','Anouncements',NULL,'Selling price','Negative',NULL,'raji'),(75,'2025-02-11','Global Issues',NULL,'Task ','Positive',NULL,'raji'),(76,'2025-02-11','Anouncements',NULL,'Task','Positive',NULL,'raji'),(77,'2025-02-11','Global Markets',NULL,'Task','Positive',NULL,'raji'),(78,'2025-02-11','Global Issues',NULL,'Task','Negative',NULL,'raji'),(79,'2025-02-11','Anouncements',NULL,'Selling price','Negative',NULL,'raji'),(80,'2025-02-11','Global Issues',NULL,'Task ','Positive',NULL,'raji'),(81,'2025-02-11','Anouncements',NULL,'Task','Positive',NULL,'raji'),(82,'2025-02-11','Global Markets',NULL,'Task','Positive',NULL,'raji'),(83,'2025-02-11','Global Issues',NULL,'Task','Negative',NULL,'raji'),(84,'2025-02-13','Global Markets',NULL,'Bhdget','Positive',NULL,'Lakshmi'),(85,'2025-02-13','Anouncements',NULL,'Modi use trip','Positive',NULL,'Lakshmi'),(86,'2025-02-13','Anouncements',NULL,'Steel aluminium taries polacy ','Negative',NULL,'Lakshmi'),(87,'2025-02-13','Global Issues',NULL,'Spelling increase ','Negative',NULL,'Lakshmi'),(88,'2025-02-13','Domestic Issues',NULL,'Gold increase ','Negative',NULL,'Lakshmi'),(89,'2025-02-02','Global Markets',NULL,'wer','Positive',NULL,'raji'),(90,'2025-02-02','Anouncements',NULL,'tre','Positive',NULL,'raji'),(91,'2025-02-13','Global Markets',NULL,'Lakshmi ','Positive',NULL,'Lakshmi'),(92,'2025-02-13','Anouncements',NULL,'Lakshmi ','Positive',NULL,'Lakshmi'),(93,'2025-02-13','Domestic Issues',NULL,'Lakshmi ','Negative',NULL,'Lakshmi'),(94,'2025-02-13','Profit Booking',NULL,'Lakshmi ','Positive',NULL,'Lakshmi'),(95,'2025-02-13','Global Markets',NULL,'Lakshmi ','Negative',NULL,'Lakshmi'),(96,'2025-02-13','Anouncements',NULL,'9th','Positive',NULL,'raji'),(97,'2025-02-13','Anouncements',NULL,'Task','Negative',NULL,'raji'),(98,'2025-02-13','Global Issues',NULL,'Task','Positive',NULL,'raji'),(99,'2025-02-13','Global Issues',NULL,'Task','Negative',NULL,'raji'),(100,'2025-02-13','Global Issues',NULL,'Task','Negative',NULL,'raji'),(101,'2025-02-09','Anouncements',NULL,'Lakshmi ','Negative',NULL,'Lakshmi'),(102,'2025-02-09','Profit Booking',NULL,'Lakshay ','Negative',NULL,'Lakshmi'),(103,'2025-02-09','Anouncements',NULL,'Lak','Negative',NULL,'Lakshmi'),(104,'2025-02-09','Domestic Issues',NULL,'Lak','Positive',NULL,'Lakshmi'),(105,'2025-02-09','Sectoral Anouncements',NULL,'Lakshay ','Positive',NULL,'Lakshmi'),(106,'2025-02-09','Anouncements',NULL,'9th','Positive',NULL,'raji'),(107,'2025-02-09','Anouncements',NULL,'Task','Negative',NULL,'raji'),(108,'2025-02-09','Global Issues',NULL,'Task','Positive',NULL,'raji'),(109,'2025-02-09','Global Issues',NULL,'Task','Negative',NULL,'raji'),(110,'2025-02-09','Global Issues',NULL,'Task','Negative',NULL,'raji'),(111,'2025-02-13','Anouncements',NULL,'Rate cuts fear','Negative',NULL,'raji'),(112,'2025-02-13','Global Issues',NULL,'Task','Positive',NULL,'raji'),(113,'2025-02-13','Anouncements',NULL,'Task','Negative',NULL,'raji'),(114,'2025-02-13','Global Markets',NULL,'Task','Negative',NULL,'raji'),(115,'2025-02-13','Global Markets',NULL,'Task','Positive',NULL,'raji'),(116,'2025-02-14','Anouncements',NULL,'Week results','Negative',NULL,'raji'),(117,'2025-02-14','Global Markets',NULL,'Task','Negative',NULL,'raji'),(118,'2025-02-14','Anouncements',NULL,'Task','Positive',NULL,'raji'),(119,'2025-02-14','Global Issues',NULL,'Task','Positive',NULL,'raji'),(120,'2025-02-14','Global Markets',NULL,'Task','Negative',NULL,'raji'),(121,'2025-02-19','Global Markets',NULL,'Modi trip usa','Positive',NULL,'1'),(122,'2025-03-26','Global Markets',NULL,'consumetheamincrease','Positive',NULL,'1'),(123,'2025-03-26','Anouncements',NULL,'about ttaries meeting','Positive',NULL,'1'),(124,'2025-03-26','Global Markets',NULL,'rupesincrease doller vaule','Positive',NULL,'1'),(125,'2025-03-26','Sectoral Anouncements',NULL,'sigment events ott lncrease','Positive',NULL,'1'),(126,'2025-03-26','Sectoral Anouncements',NULL,'quterful number','Positive',NULL,'1'),(127,'2025-03-26','Global Markets',NULL,'test','Positive',NULL,'1'),(128,'2025-03-26','Anouncements',NULL,'asdf','Negative',NULL,'1'),(129,'2025-03-26','Anouncements',NULL,'selling price ','Positive',NULL,'1'),(130,'2025-03-26','Global Markets',NULL,'task','Negative',NULL,'1'),(131,'2025-03-26','Anouncements',NULL,'task','Positive',NULL,'1'),(132,'2025-03-26','Global Issues',NULL,'task','Positive',NULL,'1'),(133,'2025-03-26','Anouncements',NULL,'task','Positive',NULL,'1'),(136,'2025-03-27','Global Markets',NULL,'test','Positive',NULL,'1'),(137,'2025-03-27','Global Markets',NULL,'consumetheamincrease','Positive',NULL,'1'),(138,'2025-03-27','Global Markets',NULL,'trump taries april2 died line','Positive',NULL,'1'),(139,'2025-03-27','Global Markets',NULL,'consumetheamincrease','Positive',NULL,'1'),(140,'2025-03-27','Anouncements',NULL,'consumetheamincrease','Negative',NULL,'1'),(141,'2025-03-27','Global Issues',NULL,'trump taries april2 died line','Negative',NULL,'1'),(142,'2025-03-27','Global Markets',NULL,'cruid oil increase','Negative',NULL,'1'),(143,'2025-03-27','Global Markets',NULL,'trump taries april2 died line','Negative',NULL,'1'),(144,'2025-03-27','Global Markets',NULL,'last2 days rupees value down','Negative',NULL,'1'),(145,'2025-03-27','Global Markets',NULL,'cruid oil increase','Negative',NULL,'1'),(146,'2025-03-27','Global Markets',NULL,'trump taries april2e','Negative',NULL,'1'),(147,'2025-03-27','Global Markets',NULL,'last2 days rupen','Negative',NULL,'1'),(148,'2025-03-27','Anouncements',NULL,'8seatv vehicalv','Positive',NULL,'1'),(149,'2025-03-27','Anouncements',NULL,'hospital sta ','Positive',NULL,'1'),(150,'2025-03-27','Anouncements',NULL,'stock pressure','Positive',NULL,'1'),(151,'2025-03-27','Global Markets',NULL,'task','Positive',NULL,'1'),(152,'2025-03-27','Global Issues',NULL,'task','Negative',NULL,'1'),(153,'2025-03-27','Anouncements',NULL,'task','Positive',NULL,'1'),(154,'2025-03-27','Anouncements',NULL,'task','Negative',NULL,'1'),(155,'2025-03-28','Global Markets',NULL,'taries cut  expect india','Positive',NULL,'1'),(156,'2025-03-28','Global Markets',NULL,'restrurenfunds increase','Positive',NULL,'1'),(157,'2025-03-28','Global Issues',NULL,'trump effect on autoc ompanyc','Negative',NULL,'1'),(158,'2025-03-28','Anouncements',NULL,'bse sensex bonuces','Positive',NULL,'1'),(159,'2025-03-28','Anouncements',NULL,'pf use through atm','Positive',NULL,'1'),(160,'2025-04-02','Global Markets',NULL,'trump taries april2 died line','Positive',NULL,'1'),(161,'2025-04-02','Anouncements',NULL,'taries cut  expect india','Positive',NULL,'1'),(162,'2025-04-02','Anouncements',NULL,'s0me company benefit ','Positive',NULL,'1'),(163,'2025-04-02','Global Markets',NULL,'q4 result ','Positive',NULL,'1'),(164,'2025-04-02','Global Markets',NULL,'cruid oil increase','Negative',NULL,'1'),(165,'2025-04-02','Global Markets',NULL,'taries cut  expect india','Positive',NULL,'1'),(166,'2025-04-02','Anouncements',NULL,'auto mobiles taries','Negative',NULL,'1'),(167,'2025-04-02','Global Issues',NULL,'germentstaries','Positive',NULL,'1'),(168,'2025-04-02','Global Markets',NULL,'gold silver diamonds taries','Negative',NULL,'1'),(169,'2025-04-02','Global Markets',NULL,'wood rubber taries','Negative',NULL,'1'),(170,'2025-04-03','Global Markets',NULL,'chinajapan ne-to trump','Negative',NULL,'1'),(171,'2025-04-03','Global Markets',NULL,'decrease tariff to india','Positive',NULL,'1'),(172,'2025-04-03','Anouncements',NULL,'taries cut  expect india','Positive',NULL,'1'),(173,'2025-04-03','Global Markets',NULL,'q4 results infact','Positive',NULL,'1'),(174,'2025-04-03','Anouncements',NULL,'rbi support april 9','Positive',NULL,'1'),(175,'2025-04-01','Anouncements',NULL,'market pressure','Negative',NULL,'1'),(176,'2025-04-01','Global Issues',NULL,'selling price ','Positive',NULL,'1'),(177,'2025-04-01','Anouncements',NULL,'task','Positive',NULL,'1'),(178,'2025-04-01','Global Issues',NULL,'task','Negative',NULL,'1'),(179,'2025-04-01','Anouncements',NULL,'selling price ','Positive',NULL,'1');
/*!40000 ALTER TABLE `daily_indicators` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `daily_script_updates`
--

DROP TABLE IF EXISTS `daily_script_updates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `daily_script_updates` (
  `id` int NOT NULL AUTO_INCREMENT,
  `timestamp` varchar(10) DEFAULT NULL,
  `companyName` varchar(50) DEFAULT NULL,
  `currentValue` varchar(50) DEFAULT NULL,
  `changeValue` varchar(50) DEFAULT NULL,
  `pchange` varchar(50) DEFAULT NULL,
  `updatedOn` varchar(20) DEFAULT NULL,
  `securityID` varchar(50) DEFAULT NULL,
  `scripCode` int DEFAULT NULL,
  `scriptGroup` varchar(50) DEFAULT NULL,
  `faceValue` varchar(50) DEFAULT NULL,
  `industry` varchar(50) DEFAULT NULL,
  `previousClose` varchar(50) DEFAULT NULL,
  `previousOpen` varchar(50) DEFAULT NULL,
  `dayHigh` varchar(50) DEFAULT NULL,
  `dayLow` varchar(50) DEFAULT NULL,
  `52weekHigh` varchar(50) DEFAULT NULL,
  `52weekLow` varchar(50) DEFAULT NULL,
  `weightedAvgPrice` varchar(50) DEFAULT NULL,
  `totalTradedValue` varchar(50) DEFAULT NULL,
  `totalTradedUnit` varchar(10) DEFAULT NULL,
  `totalTradedQuantity` varchar(50) DEFAULT NULL,
  `2WeekAvgQuantity` varchar(50) DEFAULT NULL,
  `marketCapFull` varchar(50) DEFAULT NULL,
  `marketCapFreeFloat` varchar(50) DEFAULT NULL,
  `marketCapFreeFloatUnit` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `daily_script_updates`
--

LOCK TABLES `daily_script_updates` WRITE;
/*!40000 ALTER TABLE `daily_script_updates` DISABLE KEYS */;
INSERT INTO `daily_script_updates` VALUES (1,'20250303','RELAXO FOOTWEARS LTD.-$','417.90','-9.30','-2.18','03 Mar 25 | 09:48 AM','RELAXO',530517,'A  / BSE 500','1.00','Consumer Durables','427.20','433.90','433.95','415.00','949.85','415.00','423.00','0.28 Cr.','NA','0.07 Lakh','0.19 Lakh','10,403.14 Cr.','2,980.77 Cr.','NA'),(2,'20250303','SJVN Ltd','83.11','-1.08','-1.28','03 Mar 25 | 09:48 AM','SJVN',533206,'A  / BSE 500','10.00','Power','84.19','84.02','85.75','82.84','159.60','82.84','84.19','3.12 Cr.','NA','3.72 Lakh','6.65 Lakh','32,660.53 Cr.','5,928.34 Cr.','NA');
/*!40000 ALTER TABLE `daily_script_updates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `daily_task`
--

DROP TABLE IF EXISTS `daily_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `daily_task` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(200) DEFAULT NULL,
  `description` text,
  `task_id` int DEFAULT NULL,
  `remarks` varchar(30) DEFAULT NULL,
  `bucket_id` int DEFAULT NULL,
  `bucket_name` varchar(20) DEFAULT NULL,
  `status` enum('Open','Progress','Done','Error') DEFAULT NULL,
  `task_date` date DEFAULT NULL,
  `next_task_date` date DEFAULT NULL,
  `owner` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `task_id` (`task_id`),
  CONSTRAINT `daily_task_ibfk_1` FOREIGN KEY (`task_id`) REFERENCES `invo_task` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=196 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `daily_task`
--

LOCK TABLES `daily_task` WRITE;
/*!40000 ALTER TABLE `daily_task` DISABLE KEYS */;
INSERT INTO `daily_task` VALUES (1,'Daily Market Summary','test desc',1,'test remarks',1,'invo','Open','2025-01-31','2025-02-01',NULL),(2,'Daily Market Summary','test desc',1,'test remarks',1,'invo','Error','2025-01-31','2025-02-07',NULL),(3,'Weekly Mkt Summary','',2,'',1,'invo bucket','Done','2025-02-01','2025-02-07',NULL),(4,'Daily Market Summary','',1,'',1,'invo','Open','2025-02-01','2025-02-08',NULL),(5,'Daily Market Summary','Daily Market Summary',1,'',1,'invo bucket','Done','2025-02-04','2025-02-11','Lakshmi'),(6,'Daily Market Summary','Daily Market Summary',1,'',1,'invo bucket','Done','2025-02-04','2025-02-11','Lakshmi'),(7,'Daily Market Summary','Daily Market Summary',1,'',1,'invo bucket','Done','2025-02-04','2025-02-11','Raji'),(8,'Daily Market Summary','Daily Market Summary',1,'',1,'invo bucket','Done','2025-02-04','2025-02-11','Raji'),(50,'Daily Market Summary','Daily Market Summary',1,'',1,'invo bucket','Done','2025-02-09','2025-02-16','Lakshmi'),(51,'Daily Market Summary','Daily Market Summary',1,'',1,'invo bucket','Done','2025-02-09','2025-02-16','Raji'),(52,'Daily Market Summary','Daily Market Summary',1,'',1,'invo bucket','Done','2025-02-10','2025-02-17','Lakshmi'),(53,'Daily Market Summary','Daily Market Summary',1,'',1,'invo bucket','Done','2025-02-10','2025-02-17','Raji'),(54,'Daily Market Summary','Daily Market Summary',1,'',1,'invo bucket','Done','2025-02-11','2025-02-18','Lakshmi'),(55,'Daily Market Summary','Daily Market Summary',1,'',1,'invo bucket','Done','2025-02-11','2025-02-18','Raji'),(57,'Daily Market Summary','Daily Market Summary',1,'',1,'invo bucket','Done','2025-02-11','2025-02-18','Lakshmi'),(58,'Daily Market Summary','Daily Market Summary',1,'',1,'invo bucket','Done','2025-02-11','2025-02-18','Raji'),(60,'Daily Market Summary','Daily Market Summary',1,'',1,'invo bucket','Done','2025-02-11','2025-02-18','Lakshmi'),(61,'Daily Market Summary','Daily Market Summary',1,'',1,'invo bucket','Done','2025-02-11','2025-02-18','Raji'),(63,'Daily Market Summary','Daily Market Summary',1,'',1,'invo bucket','Done','2025-02-11','2025-02-18','Lakshmi'),(64,'Daily Market Summary','Daily Market Summary',1,'',1,'invo bucket','Done','2025-02-11','2025-02-18','Raji'),(66,'Daily Market Summary','Daily Market Summary',1,'',1,'invo bucket','Done','2025-02-11','2025-02-18','Lakshmi'),(67,'Daily Market Summary','Daily Market Summary',1,'',1,'invo bucket','Done','2025-02-11','2025-02-18','Raji'),(68,'Daily Market Summary','Daily Market Summary',1,'',1,'invo bucket','Done','2025-02-11','2025-02-18','Neelima'),(69,'Daily Market Summary','Daily Market Summary',1,'',1,'invo bucket','Done','2025-02-11','2025-02-18','Lakshmi'),(70,'Daily Market Summary','Daily Market Summary',1,'',1,'invo bucket','Done','2025-02-11','2025-02-18','Raji'),(71,'Daily Market Summary','Daily Market Summary',1,'',1,'invo bucket','Done','2025-02-11','2025-02-18','Neelima'),(72,'Daily Market Summary','Daily Market Summary',1,'',1,'invo bucket','Done','2025-02-12','2025-02-19','Lakshmi'),(73,'Daily Market Summary','Daily Market Summary',1,'',1,'invo bucket','Done','2025-02-12','2025-02-19','Raji'),(74,'Daily Market Summary','Daily Market Summary',1,'',1,'invo bucket','Done','2025-02-12','2025-02-19','Neelima'),(75,'Daily Market Summary','Daily Market Summary',1,'',1,'invo bucket','Done','2025-02-17','2025-02-24','Lakshmi'),(76,'Daily Market Summary','Daily Market Summary',1,'',1,'invo bucket','Done','2025-02-17','2025-02-24','Raji'),(77,'Daily Market Summary','Daily Market Summary',1,'',1,'invo bucket','Done','2025-02-17','2025-02-24','Neelima'),(78,'Daily Market Summary','Daily Market Summary',1,'',1,'invo bucket','Done','2025-02-17','2025-02-24','Lakshmi'),(79,'Daily Market Summary','Daily Market Summary',1,'',1,'invo bucket','Done','2025-02-17','2025-02-24','Raji'),(80,'Daily Market Summary','Daily Market Summary',1,'',1,'invo bucket','Done','2025-02-17','2025-02-24','Neelima'),(81,'Daily Market Summary','Daily Market Summary',1,'',1,'invo bucket','Done','2025-02-18','2025-02-25','Lakshmi'),(82,'Daily Market Summary','Daily Market Summary',1,'',1,'invo bucket','Done','2025-02-18','2025-02-25','Raji'),(83,'Daily Market Summary','Daily Market Summary',1,'',1,'invo bucket','Done','2025-02-18','2025-02-25','Neelima'),(84,'Daily Market Summary','Daily Market Summary',1,'',1,'invo bucket','Done','2025-02-18','2025-02-25','Lakshmi'),(85,'KisanMouldStudy','What are the products of KM. and compititors.',3,NULL,1,'INVO','Open','2025-02-18','2025-02-25','Lakshmi'),(86,'Daily Market Summary','Daily Market Summary',1,'',1,'invo bucket','Done','2025-02-18','2025-02-25','Raji'),(87,'Daily Market Summary','Daily Market Summary',1,'',1,'invo bucket','Done','2025-02-18','2025-02-25','Neelima'),(91,'Daily Market Summary','Daily Market Summary',1,'',1,'invo bucket','Done','2025-02-18','2025-02-25','Lakshmi'),(92,'KisanMouldStudy','What are the products of KM. and compititors.',3,NULL,1,'INVO','Done','2025-02-18','2025-02-25','Lakshmi'),(93,'Daily Market Summary','Daily Market Summary',1,'',1,'invo bucket','Done','2025-02-18','2025-02-25','Raji'),(94,'Daily Market Summary','Daily Market Summary',1,'',1,'invo bucket','Done','2025-02-18','2025-02-25','Neelima'),(98,'Daily Market Summary','Daily Market Summary',1,'',1,'invo bucket','Done','2025-02-18','2025-02-25','Lakshmi'),(99,'KisanMouldStudy','What are the products of KM. and compititors.',3,NULL,1,'INVO','Done','2025-02-18','2025-02-25','Lakshmi'),(100,'Daily Market Summary','Daily Market Summary',1,'',1,'invo bucket','Open','2025-02-18','2025-02-25','Lakshmi'),(101,'Daily Market Summary','Daily Market Summary',1,'',1,'invo bucket','Done','2025-02-18','2025-02-25','Raji'),(102,'Daily Market Summary','Daily Market Summary',1,'',1,'invo bucket','Done','2025-02-18','2025-02-25','Neelima'),(105,'Daily Market Summary','Daily Market Summary',1,'',1,'invo bucket','Done','2025-02-18','2025-02-25','Raji'),(106,'Daily Market Summary','Daily Market Summary',1,'',1,'invo bucket','Done','2025-02-18','2025-02-25','Raji'),(107,'Daily Market Summary','Daily Market Summary',1,'',1,'invo bucket','Done','2025-02-18','2025-02-25','Neelima'),(108,'Daily Market Summary','Daily Market Summary',1,'',1,'invo bucket','Done','2025-02-18','2025-02-25','Neelima'),(112,'Daily Market Summary','Daily Market Summary',1,'',1,'invo bucket','Done','2025-02-19','2025-02-26','Raji'),(113,'Daily Market Summary','Daily Market Summary',1,'',1,'invo bucket','Done','2025-02-19','2025-02-26','Neelima'),(115,'Daily Market Summary','Daily Market Summary',1,'',1,'invo bucket','Done','2025-02-19','2025-02-26','Raji'),(116,'Daily Market Summary','Daily Market Summary',1,'',1,'invo bucket','Done','2025-02-19','2025-02-26','Neelima'),(118,'Daily Market Summary','Daily Market Summary',1,'',1,'invo bucket','Done','2025-02-19','2025-02-26','Raji'),(119,'Daily Market Summary','Daily Market Summary',1,'',1,'invo bucket','Done','2025-02-19','2025-02-26','Neelima'),(121,'Daily Market Summary','Daily Market Summary',1,'',1,'invo bucket','Done','2025-02-19','2025-02-26','Raji'),(122,'Daily Market Summary','Daily Market Summary',1,'',1,'invo bucket','Done','2025-02-19','2025-02-26','Neelima'),(124,'Daily Market Summary','Daily Market Summary',1,'',1,'invo bucket','Done','2025-02-19','2025-02-26','Raji'),(125,'Daily Market Summary','Daily Market Summary',1,'',1,'invo bucket','Done','2025-02-19','2025-02-26','Neelima'),(127,'Daily Market Summary','Daily Market Summary',1,'',1,'invo bucket','Done','2025-02-19','2025-02-26','Raji'),(128,'Daily Market Summary','Daily Market Summary',1,'',1,'invo bucket','Done','2025-02-19','2025-02-26','Neelima'),(130,'KisanMouldStudy','Get the market share of KM',6,'None',1,'INVO','Done','2025-02-19','2025-02-26','1'),(131,'Comp analysis1','see https://www.youtube.com/watch?v=Fjr13Wlrl5s&list=PLFPxEPh85-qRQswzvpO-Jf3qw_OwaZZY0&index=5 ',7,'None',1,'INVO','Done','2025-02-19','2025-02-26','2'),(132,'Comp analysis1','See  https://www.youtube.com/watch?v=Fjr13Wlrl5s&list=PLFPxEPh85-qRQswzvpO-Jf3qw_OwaZZY0&index=5 ',8,'None',1,'INVO','Done','2025-02-19','2025-02-26','1'),(133,'Comp analysis1','See  https://www.youtube.com/watch?v=Fjr13Wlrl5s&list=PLFPxEPh85-qRQswzvpO-Jf3qw_OwaZZY0&index=5 ',9,'None',1,'INVO','Done','2025-02-19','2025-02-26','3'),(134,'Comp analysis1','See  https://www.youtube.com/watch?v=Fjr13Wlrl5s&list=PLFPxEPh85-qRQswzvpO-Jf3qw_OwaZZY0&index=5 ',10,'None',1,'None','Done','2025-02-19','2025-02-26','3'),(135,'Comp analysis1.2','note the items to check mentioned in previous video',11,'None',1,'None','Done','2025-02-19','2025-02-26','1'),(136,'Comp analysis1.2','note the items to check mentioned in previous video',12,'None',1,'INVO','Done','2025-02-19','2025-02-26','2'),(137,'Comp analysis1.2','note the items to check mentioned in previous video',13,'None',1,'INVO','Done','2025-02-19','2025-02-26','3'),(138,'Comp analysis1.2','see https://youtu.be/Fjr13Wlrl5s?si=vtaF7OyqGEDH_3Cd',14,'None',1,'INVO','Done','2025-02-19','2025-02-26','1'),(139,'Comp analysis1.2','See  https://www.youtube.com/watch?v=Fjr13Wlrl5s&list=PLFPxEPh85-qRQswzvpO-Jf3qw_OwaZZY0&index=5 ',15,'None',1,'INVO','Done','2025-02-19','2025-02-26','1'),(140,'Comp analysis1.2','See  https://www.youtube.com/watch?v=Fjr13Wlrl5s&list=PLFPxEPh85-qRQswzvpO-Jf3qw_OwaZZY0&index=5 ',16,'None',1,'INVO','Done','2025-02-19','2025-02-26','1'),(141,'Daily Market Summary','Daily Market Summary',1,'',1,'invo bucket','Done','2025-02-19','2025-02-26','Raji'),(142,'Daily Market Summary','Daily Market Summary',1,'',1,'invo bucket','Done','2025-02-19','2025-02-26','Neelima'),(144,'Daily Market Summary','Daily Market Summary',1,'',1,'invo bucket','Done','2025-02-19','2025-02-26','Raji'),(145,'Daily Market Summary','Daily Market Summary',1,'',1,'invo bucket','Done','2025-02-19','2025-02-26','Neelima'),(147,'Comp analysis1.2','See  https://www.youtube.com/watch?v=Fjr13Wlrl5s&list=PLFPxEPh85-qRQswzvpO-Jf3qw_OwaZZY0&index=5 ',17,'',1,'INVO','Done','2025-02-19','2025-02-26','1'),(148,'Comp analysis1.2','See  https://www.youtube.com/watch?v=Fjr13Wlrl5s&list=PLFPxEPh85-qRQswzvpO-Jf3qw_OwaZZY0&index=5 ',18,'',1,'INVO','Done','2025-02-19','2025-02-26','1'),(149,'Daily Market Summary','Daily Market Summary',1,'',1,'invo bucket','Done','2025-02-19','2025-02-26','Raji'),(150,'Daily Market Summary','Daily Market Summary',1,'',1,'invo bucket','Done','2025-02-19','2025-02-26','Neelima'),(152,'Daily Market Summary','Daily Market Summary',1,'',1,'invo bucket','Done','2025-02-19','2025-02-26','Raji'),(153,'Daily Market Summary','Daily Market Summary',1,'',1,'invo bucket','Done','2025-02-19','2025-02-26','Neelima'),(155,'Comp analysis1.2','See  https://www.youtube.com/watch?v=Fjr13Wlrl5s&list=PLFPxEPh85-qRQswzvpO-Jf3qw_OwaZZY0&index=5 ',19,'',1,'None','Done','2025-02-19','2025-02-26','1'),(156,'Daily Market Summary','Daily Market Summary',1,'',1,'invo bucket','Done','2025-02-19','2025-02-26','Raji'),(157,'Daily Market Summary','Daily Market Summary',1,'',1,'invo bucket','Done','2025-02-19','2025-02-26','Neelima'),(159,'Daily Market Summary','Daily Market Summary',1,'',1,'invo bucket','Done','2025-02-19','2025-02-26','Raji'),(160,'Daily Market Summary','Daily Market Summary',1,'',1,'invo bucket','Done','2025-02-19','2025-02-26','Neelima'),(162,'Daily Market Summary','Daily Market Summary',1,'',1,'invo bucket','Done','2025-02-19','2025-02-26','Raji'),(163,'Daily Market Summary','Daily Market Summary',1,'',1,'invo bucket','Done','2025-02-19','2025-02-26','Neelima'),(165,'Comp analysis1.2','See  https://www.youtube.com/watch?v=Fjr13Wlrl5s&list=PLFPxEPh85-qRQswzvpO-Jf3qw_OwaZZY0&index=5 ',20,'',1,'None','Done','2025-02-19','2025-02-26','2'),(166,'key points ','Update the words you underlined.',21,NULL,2,'None','Done','2025-02-22','2025-03-01','2'),(167,'What is liquidity','see videos and gather info',22,NULL,2,'None','Done','2025-02-24','2025-03-03','1'),(168,'What is liquidity','see videos and gather info',22,NULL,2,'None','Done','2025-03-03','2025-03-10','1'),(169,'What is liquidity','see videos and gather info',22,NULL,2,'None','Done','2025-03-03','2025-03-10','1'),(170,'What is liquidity','see videos and gather info',22,NULL,2,'None','Done','2025-03-03','2025-03-10','1'),(171,'check item page error','check item page error',23,NULL,1,'None','Done','2025-03-13','2025-03-20','4'),(172,'Check KM current status','Check current status',24,NULL,2,'None','Done','2025-03-20','2025-03-27','1'),(173,'Check Relaxo status','Check Relaxo status',25,NULL,2,'None','Done','2025-03-20','2025-03-27','2'),(174,'Set next buy price for KM','Set next buy price for KM',26,NULL,2,'None','Done','2025-03-20','2025-03-27','1'),(175,'Set next buy price for Relaxo','Set next buy price for Relaxo',27,NULL,2,'None','Done','2025-03-20','2025-03-27','2'),(176,'Get EBIT PBT and PAT for KM','Get EBIT PBT and PAT for KM',28,NULL,2,'None','Done','2025-03-20','2025-03-27','1'),(177,'Get Next Buy point for Railtel','Get Next Buy point for Railtel',29,NULL,3,'None','Done','2025-03-20','2025-03-27','4'),(178,'Set the plan for one time tasks in application','Set the plan for one time tasks in application',30,NULL,2,'None','Open','2025-03-20','2025-03-27','4'),(179,'Update item details from upstox','Update stocks taken from upstox in our application',31,NULL,2,'None','Done','2025-03-21','2025-03-28','1'),(180,'Get Daily status','Get daily status',32,NULL,2,'None','Done','2025-03-26','2025-04-02','1'),(181,'Get Daily status','Get Daily status',33,NULL,2,'None','Done','2025-03-26','2025-04-02','2'),(182,'Get Daily status','Get Daily status',34,NULL,2,'None','Done','2025-03-26','2025-04-02','3'),(183,'Set the plan for one time tasks in application','Set the plan for one time tasks in application',30,NULL,2,'None','Open','2025-03-27','2025-04-03','4'),(184,'Set the plan for one time tasks in application','Set the plan for one time tasks in application',30,NULL,2,'None','Open','2025-03-27','2025-04-03','4'),(185,'Add KM to items list','Add KM to items list',35,NULL,2,'None','Open','2025-03-28','2025-04-04','4'),(186,'Update item details from upstox','Update stocks taken from upstox in our application',31,NULL,2,'None','Done','2025-03-28','2025-04-04','1'),(187,'Update item details from upstox','Update stocks taken from upstox in our application',31,NULL,2,'None','Done','2025-03-28','2025-04-04','1'),(188,'Update item details from upstox','Update stocks taken from upstox in our application',31,NULL,2,'None','Done','2025-03-28','2025-04-04','1'),(189,'Update item details from upstox','Update stocks taken from upstox in our application',31,NULL,2,'None','Done','2025-03-28','2025-04-04','1'),(190,'Update item details from upstox','Update stocks taken from upstox in our application',31,NULL,2,'None','Done','2025-03-28','2025-04-04','1'),(191,'Update item details from upstox','Update stocks taken from upstox in our application',31,NULL,2,'None','Done','2025-03-28','2025-03-29','1'),(192,'Get daily status','Get daily status',36,NULL,2,'None','Done','2025-03-28','2025-03-29','1'),(193,'Get daily status','Get daily status',37,NULL,2,'None','Done','2025-03-28','2025-03-29','2'),(194,'Get daily status','Get daily status',38,NULL,2,'None','Done','2025-03-28','2025-03-29','3'),(195,'Update item details from upstox','Update stocks taken from upstox in our application',31,NULL,2,'None','Done','2025-03-28','2025-03-29','1');
/*!40000 ALTER TABLE `daily_task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indicators`
--

DROP TABLE IF EXISTS `indicators`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `indicators` (
  `id` int DEFAULT NULL,
  `name` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indicators`
--

LOCK TABLES `indicators` WRITE;
/*!40000 ALTER TABLE `indicators` DISABLE KEYS */;
INSERT INTO `indicators` VALUES (1,'Global Markets'),(2,'Anouncements'),(3,'Global Issues'),(4,'Domestic Issues'),(6,'Profit Booking'),(5,'Sectoral Anouncements');
/*!40000 ALTER TABLE `indicators` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inv_count`
--

DROP TABLE IF EXISTS `inv_count`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inv_count` (
  `item_id` int NOT NULL,
  `quantity` int DEFAULT NULL,
  PRIMARY KEY (`item_id`),
  CONSTRAINT `inv_count_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `item_details` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inv_count`
--

LOCK TABLES `inv_count` WRITE;
/*!40000 ALTER TABLE `inv_count` DISABLE KEYS */;
INSERT INTO `inv_count` VALUES (26,5),(27,0),(35,3),(40,4),(46,2),(52,4),(54,1),(56,1),(59,9),(61,3),(62,0),(63,10),(65,10),(68,2),(69,3),(72,12),(73,2),(74,0),(75,2),(76,3),(80,2),(84,8),(85,3),(87,3),(88,0),(89,0),(90,5),(92,0),(93,1),(94,2),(96,1),(97,2),(98,196),(99,204),(113,7),(120,14),(124,3),(131,2),(133,4),(137,0),(143,1),(144,3),(146,5),(147,3),(148,3),(150,2),(151,2),(152,7),(153,10),(154,0),(155,2),(156,3),(157,5),(158,0),(159,3),(160,6),(169,2),(171,-1),(172,12),(178,13),(181,0),(183,1),(185,1),(186,4),(187,2),(188,1),(189,3),(190,44),(191,1),(192,2),(193,5),(194,1),(195,5),(197,9);
/*!40000 ALTER TABLE `inv_count` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inv_customer`
--

DROP TABLE IF EXISTS `inv_customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inv_customer` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mobile` varchar(15) DEFAULT NULL,
  `name` varchar(30) DEFAULT NULL,
  `location` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=91 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inv_customer`
--

LOCK TABLES `inv_customer` WRITE;
/*!40000 ALTER TABLE `inv_customer` DISABLE KEYS */;
INSERT INTO `inv_customer` VALUES (1,'9502035329','Santhosh','Chennai'),(2,'9246788660','Raghu','Tuni'),(3,'9347910606','Raghu Comp','Tuni'),(4,'123546','Test','Test'),(5,'1245678','testcust','testcu'),(6,'12456710','asd','vfded'),(7,'154621','asdfffs','ccddcc'),(8,'65458','ttrryy','affee'),(9,'123214','jjjj','ffff'),(10,'47147','jhghj','lkljl'),(11,'32565','32565','32565'),(12,'321321','123123','231213'),(13,'126126','621621','333333'),(14,'9032325659','neelima','tuni'),(15,'8790331601','Devavaram sachivalayam','Devavaram'),(16,'8919292345','Narasimha','Chamavaram'),(17,'8142016330','KARTHIK','TUNI'),(18,'7399337777','viveka school','Agraharam'),(19,'7981020597','balu','rjy'),(20,'9701042602','KIRAN STUDIO','SANKAVARAM'),(21,'9000260809','gangaraju','TUNI'),(22,'7989495478','ravi kumar','nakkapalli'),(23,'9666667684','siva kumar','annavaram'),(24,'9014076092','hero','srikakulam'),(25,'9948248493','madhu sekhar','tuni'),(26,'9948248493','madhu sekhar','tuni'),(27,' 92466 94266','NOBLE SATYANARAYANA','tuni'),(28,'7287024062','HARYTHA','tuni'),(29,'98664 71591','Modi zerox','Tuni'),(30,'75694 71313','Ramshankar( sai priya)','Tuni'),(31,'9246694266','NOBLE SATYANARAYANA','tuni'),(32,'9492166116','CHAITANYA PENDYALA','TUNI'),(33,'9866471591','MODI XEROX','TUNI'),(34,'`9177352284','JAIRAJ','TUNI'),(35,'9553322998','SMILLING','PALTERU'),(36,'7989242660','SRINU DUNGA','TUNI'),(37,'9133759644','NANDA KISHORE','TUNI'),(38,'7013892707','BHASKAR ARUSH LAB','TUNI'),(39,'9885052108','vivek','tuni'),(40,'1234567890','SERVICE','TUNI'),(41,'9550950111','VIJAY','TUNI'),(42,'9705966037','murthy dulam','lova kothuru'),(43,'9966994941','vamsi','tuni'),(44,'9491686806','siri net cafe','tuni'),(45,'7893592553','RAVITEJA','ANV'),(46,'9866602385','sarma kits','diwili'),(47,'8187094934','ramana','lova kothuru'),(48,'7997733433','SRINIVAS','TUNI'),(49,'9848911786','SRINU','MANGAVARAM'),(50,'9491442283','LOVA RAJU','POLAVARAM'),(51,'8374267991','NANI','TUNI'),(52,'9398982400','SAGAR','TUNI'),(53,'9848435325','FINNY','PAYAKARAOPETA'),(54,'9963749074','SIVA  MEDICAL SHOP','TUNI'),(55,'9573784999','RAVINDRA','GANDI'),(56,'8885307268','apparao choppa','TUNI'),(57,'9000754391','GIVIND','HAMSAVARAM'),(58,'8686860056','SIVA ELE','TUNI'),(59,'8688404042','PRASAD','TUNI'),(60,'97056 07295','LAKSHMAN KATARI','TUNI'),(61,'90309 99183','vijay digitals','TUNI'),(62,'95022 25559','RAMESH LIC','TUNI'),(63,'6304887144','D. NAGESWARARAO','PADERU'),(64,'9550282473','pakkurthi nagu','TUNI'),(65,'8297284822','sagar','rowthulapudi'),(66,'9030999183','VIJAY PAPPU','TUNI'),(67,'7702 289 333','TEJA RTC','TUNI'),(68,'99123 17016','SURYANARAYANA','TUNI'),(69,'8919124116','KARTHIK','TUNI'),(70,'9292100625','SRINIVASA RAO','TUNI'),(71,'9347954587','GUPTA','TUNI'),(72,'9247954587','GUPTA','TUNI'),(73,'9652311563','CHINNA BABU','TUNI'),(74,'9550075231','UPVC','NAMAVARAM'),(75,'7330677438','SIVAKOTI','ADDARPETA'),(76,'9966398677','RAJA','TUNI'),(77,'9490083147','RANJAN TRADERS','TUNI'),(78,'8096799217','JAYA LAKSHMI','TUNI'),(79,'9502228816','YS','TUNI'),(80,'9000384893','SRINIVAS reporter','balarampuram'),(81,'7448691111','PRADEEP CH','TUNI'),(82,'9985246298','RAMANA BABU','TUNI'),(83,'6301089464','sairam surisetti','TUNI'),(84,'8688487114','murthy devarakonda','TUNI'),(85,'6304627834','shaik ayesha','rowthulapudi'),(86,'8555012885','RAVITEJA','TUNI'),(87,'9550747627','sateesh appana','srirampuram'),(88,'98484 35325','FINNY','TUNI'),(89,'9441059057','LAKSHMAN G','TUNI'),(90,'7416007513','NOOKARAJU LRS','TUNI');
/*!40000 ALTER TABLE `inv_customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inv_jobcard`
--

DROP TABLE IF EXISTS `inv_jobcard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inv_jobcard` (
  `id` int NOT NULL AUTO_INCREMENT,
  `custno` int DEFAULT NULL,
  `problem` text,
  `remarks` text,
  PRIMARY KEY (`id`),
  KEY `custno` (`custno`),
  CONSTRAINT `inv_jobcard_ibfk_1` FOREIGN KEY (`custno`) REFERENCES `inv_customer` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inv_jobcard`
--

LOCK TABLES `inv_jobcard` WRITE;
/*!40000 ALTER TABLE `inv_jobcard` DISABLE KEYS */;
/*!40000 ALTER TABLE `inv_jobcard` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inv_sale_reciept`
--

DROP TABLE IF EXISTS `inv_sale_reciept`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inv_sale_reciept` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cust_id` int DEFAULT NULL,
  `bill_date` date DEFAULT NULL,
  `amount` int DEFAULT NULL,
  `item_cnt` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cust_id` (`cust_id`),
  CONSTRAINT `inv_sale_reciept_ibfk_1` FOREIGN KEY (`cust_id`) REFERENCES `inv_customer` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=464 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inv_sale_reciept`
--

LOCK TABLES `inv_sale_reciept` WRITE;
/*!40000 ALTER TABLE `inv_sale_reciept` DISABLE KEYS */;
INSERT INTO `inv_sale_reciept` VALUES (442,72,'2026-01-03',7200,7),(443,66,'2026-01-06',175,2),(444,73,'2026-01-06',500,1),(445,74,'2026-01-06',450,1),(446,75,'2026-01-06',250,1),(447,76,'2026-01-06',500,1),(448,77,'2026-01-06',7700,9),(449,78,'2026-01-08',300,1),(450,79,'2026-01-09',14200,7),(451,80,'2026-01-09',920,2),(452,81,'2026-01-19',9000,6),(453,2,'2026-01-19',0,4),(454,82,'2026-01-21',6000,5),(455,83,'2026-01-21',2000,1),(456,84,'2026-01-21',350,1),(457,85,'2026-01-21',2900,2),(458,33,'2026-01-21',500,1),(459,86,'2026-01-26',360,2),(460,87,'2026-01-27',2000,1),(461,88,'2026-02-02',2000,1),(462,89,'2026-02-02',2000,1),(463,90,'2026-02-02',700,3);
/*!40000 ALTER TABLE `inv_sale_reciept` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventory_item`
--

LOCK TABLES `inventory_item` WRITE;
/*!40000 ALTER TABLE `inventory_item` DISABLE KEYS */;
INSERT INTO `inventory_item` VALUES (3,'BULLET IP','item,Specification,Model','1'),(4,'CABINET','item,Specification,Model','1'),(5,'CATARAGE','item,Specification,Model','1'),(6,'CC CEMRS','item,Specification,Model','1'),(7,'DOMS  IP','item,Specification,Model','1'),(8,'DOMS TV1','item,Specification,Model','1'),(9,'EPSON INKS','item,Specification,Model','1'),(10,'FAN','item,Specification,Model','1'),(11,'HDD','item,Specification,Model','1'),(12,'HDMI CABLES','item,Specification,Model','1'),(13,'HDMI TO LAN','item,Specification,Model','1'),(14,'INK PADS','item,Specification,Model','1'),(15,'KEY BOARDS','item,Specification,Model','1'),(16,'LAPTOP ADP','item,Specification,Model','1'),(17,'LAPTOP CASIN','item,Specification,Model','1'),(18,'MONITRS','item,Specification,Model','1'),(19,'MOTHER BOARD','item,Specification,Model','1'),(20,'MOUSE','item,Specification,Model','1'),(21,'POWER CARDS','item,Specification,Model','1'),(22,'PRITER DATA','item,Specification,Model','1'),(23,'PROCESER','item,Specification,Model','1'),(24,'RAM','item,Specification,Model','1'),(25,'S.M.PS','item,Specification,Model','1'),(26,'SATA DATA','item,Specification,Model','1'),(27,'SATA POWER','item,Specification,Model','1'),(28,'SSD','item,Specification,Model','1'),(29,'SSD CASING','item,Specification,Model','1'),(30,'USB','item,Specification,Model','1'),(31,'USB ','item,Specification,Model','1'),(32,'USB EXTENTION','item,Specification,Model','1'),(33,'VGA CABLES','item,Specification,Model','1'),(34,'PRINTER','item,Specification,Model','1'),(35,'CONSUMABLES','item,Specification,Model','1'),(36,'Others','item,Specification,Model','1');
/*!40000 ALTER TABLE `inventory_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invo_task`
--

DROP TABLE IF EXISTS `invo_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invo_task` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(200) DEFAULT NULL,
  `description` text,
  `bucket_id` int DEFAULT NULL,
  `bucket_name` varchar(20) DEFAULT NULL,
  `remarks` varchar(30) DEFAULT NULL,
  `recuring` int DEFAULT NULL,
  `day_of_week` varchar(20) DEFAULT NULL,
  `user_name` varchar(20) DEFAULT NULL,
  `status` enum('Open','Progress','Done','Error') DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `bucket_id` (`bucket_id`),
  CONSTRAINT `invo_task_ibfk_1` FOREIGN KEY (`bucket_id`) REFERENCES `bucket` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invo_task`
--

LOCK TABLES `invo_task` WRITE;
/*!40000 ALTER TABLE `invo_task` DISABLE KEYS */;
INSERT INTO `invo_task` VALUES (1,'Daily Market Summary','Daily Market Summary',1,'invo bucket','',1,'0',NULL,NULL),(2,'Weekly Mkt Summary','Weekly Market Summary',1,'invo bucket','',7,'6 7',NULL,NULL),(3,'KisanMouldStudy','What are the products of KM. and compititors.',1,'INVO',NULL,NULL,'3','None',NULL),(4,'KisanMouldStudy','What is the market share of KM.',1,'INVO',NULL,NULL,'3','Lakshmi',NULL),(5,'KisanMouldStudy','Get Market share of KM',1,'INVO',NULL,NULL,'3','Lakshmi',NULL),(6,'KisanMouldStudy','Get the market share of KM',1,'INVO',NULL,NULL,'0','Lakshmi','Progress'),(7,'Comp analysis1','see https://www.youtube.com/watch?v=Fjr13Wlrl5s&list=PLFPxEPh85-qRQswzvpO-Jf3qw_OwaZZY0&index=5 ',1,'INVO',NULL,NULL,'4','Raji','Progress'),(8,'Comp analysis1','See  https://www.youtube.com/watch?v=Fjr13Wlrl5s&list=PLFPxEPh85-qRQswzvpO-Jf3qw_OwaZZY0&index=5 ',1,'INVO',NULL,NULL,'4','Lakshmi','Progress'),(9,'Comp analysis1','See  https://www.youtube.com/watch?v=Fjr13Wlrl5s&list=PLFPxEPh85-qRQswzvpO-Jf3qw_OwaZZY0&index=5 ',1,'INVO',NULL,NULL,'4','Neelima','Progress'),(10,'Comp analysis1','See  https://www.youtube.com/watch?v=Fjr13Wlrl5s&list=PLFPxEPh85-qRQswzvpO-Jf3qw_OwaZZY0&index=5 ',1,'None',NULL,NULL,'4','Neelima','Progress'),(11,'Comp analysis1.2','note the items to check mentioned in previous video',1,'None',NULL,NULL,'4','Lakshmi','Progress'),(12,'Comp analysis1.2','note the items to check mentioned in previous video',1,'INVO',NULL,NULL,'4','Raji','Progress'),(13,'Comp analysis1.2','note the items to check mentioned in previous video',1,'INVO',NULL,NULL,'4','Neelima','Progress'),(14,'Comp analysis1.2','see https://youtu.be/Fjr13Wlrl5s?si=vtaF7OyqGEDH_3Cd',1,'INVO',NULL,NULL,'0','Lakshmi','Progress'),(15,'Comp analysis1.2','See  https://www.youtube.com/watch?v=Fjr13Wlrl5s&list=PLFPxEPh85-qRQswzvpO-Jf3qw_OwaZZY0&index=5 ',1,'INVO',NULL,NULL,'0','Lakshmi','Progress'),(16,'Comp analysis1.2','See  https://www.youtube.com/watch?v=Fjr13Wlrl5s&list=PLFPxEPh85-qRQswzvpO-Jf3qw_OwaZZY0&index=5 ',1,'INVO',NULL,NULL,'0','Lakshmi','Progress'),(17,'Comp analysis1.2','See  https://www.youtube.com/watch?v=Fjr13Wlrl5s&list=PLFPxEPh85-qRQswzvpO-Jf3qw_OwaZZY0&index=5 ',1,'INVO',NULL,NULL,'0','Lakshmi','Progress'),(18,'Comp analysis1.2','See  https://www.youtube.com/watch?v=Fjr13Wlrl5s&list=PLFPxEPh85-qRQswzvpO-Jf3qw_OwaZZY0&index=5 ',1,'INVO',NULL,NULL,'0','Lakshmi','Progress'),(19,'Comp analysis1.2','See  https://www.youtube.com/watch?v=Fjr13Wlrl5s&list=PLFPxEPh85-qRQswzvpO-Jf3qw_OwaZZY0&index=5 ',1,NULL,NULL,NULL,'0','Lakshmi','Progress'),(20,'Comp analysis1.2','See  https://www.youtube.com/watch?v=Fjr13Wlrl5s&list=PLFPxEPh85-qRQswzvpO-Jf3qw_OwaZZY0&index=5 ',1,NULL,NULL,NULL,'0','Raji','Progress'),(21,'key points ','Update the words you underlined.',2,NULL,NULL,NULL,'0','Raji','Progress'),(22,'What is liquidity','see videos and gather info',2,NULL,NULL,NULL,'0','Lakshmi','Progress'),(23,'check item page error','check item page error',1,NULL,NULL,NULL,'0','Santhosh','Progress'),(24,'Check KM current status','Check current status',2,NULL,NULL,NULL,'0','Lakshmi','Progress'),(25,'Check Relaxo status','Check Relaxo status',2,NULL,NULL,NULL,'0','Raji','Progress'),(26,'Set next buy price for KM','Set next buy price for KM',2,NULL,NULL,NULL,'0','Lakshmi','Progress'),(27,'Set next buy price for Relaxo','Set next buy price for Relaxo',2,NULL,NULL,NULL,'0','Raji','Progress'),(28,'Get EBIT PBT and PAT for KM','Get EBIT PBT and PAT for KM',2,NULL,NULL,NULL,'0','Lakshmi','Progress'),(29,'Get Next Buy point for Railtel','Get Next Buy point for Railtel',3,NULL,NULL,NULL,'0','Santhosh','Progress'),(30,'Set the plan for one time tasks in application','Set the plan for one time tasks in application',2,NULL,NULL,NULL,'0','Santhosh','Progress'),(31,'Update item details from upstox','Update stocks taken from upstox in our application',2,NULL,NULL,NULL,'0','Lakshmi','Progress'),(32,'Get Daily status','Get daily status',2,NULL,NULL,NULL,'0','Lakshmi','Progress'),(33,'Get Daily status','Get Daily status',2,NULL,NULL,NULL,'0','Raji','Progress'),(34,'Get Daily status','Get Daily status',2,NULL,NULL,NULL,'0','Neelima','Progress'),(35,'Add KM to items list','Add KM to items list',2,NULL,NULL,NULL,'0','Santhosh','Progress'),(36,'Get daily status','Get daily status',2,NULL,NULL,NULL,'0','Lakshmi','Progress'),(37,'Get daily status','Get daily status',2,NULL,NULL,NULL,'0','Raji','Progress'),(38,'Get daily status','Get daily status',2,NULL,NULL,NULL,'0','Neelima','Progress');
/*!40000 ALTER TABLE `invo_task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invo_user`
--

DROP TABLE IF EXISTS `invo_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invo_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL,
  `user_id` varchar(10) DEFAULT NULL,
  `status` int DEFAULT NULL,
  `passwd` varchar(20) DEFAULT NULL,
  `user_type` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invo_user`
--

LOCK TABLES `invo_user` WRITE;
/*!40000 ALTER TABLE `invo_user` DISABLE KEYS */;
INSERT INTO `invo_user` VALUES (1,'Lakshmi','lakshmi',1,'123',2),(2,'Raji','raji',1,'raji123',2),(3,'Neelima','neelima',1,'n123',2),(4,'Santhosh','santhosh',1,'s123',1),(5,'Uma','uma',1,'usag',2);
/*!40000 ALTER TABLE `invo_user` ENABLE KEYS */;
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
-- Table structure for table `item_details`
--

DROP TABLE IF EXISTS `item_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `item_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `item_id` int DEFAULT NULL,
  `tag` varchar(20) DEFAULT NULL,
  `tagval` varchar(100) DEFAULT NULL,
  `is_active` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=202 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_details`
--

LOCK TABLES `item_details` WRITE;
/*!40000 ALTER TABLE `item_details` DISABLE KEYS */;
INSERT INTO `item_details` VALUES (25,15,'15','KEY BOARDS;Wired;Lapcare;',1),(26,25,'25','S.M.PS;;Enter;',1),(27,19,'19','MOTHER BOARD;61;Zebronics',1),(28,19,'19','MOTHER BOARD;81;enter',1),(29,19,'19','MOTHER BOARD;110;Zebronics',1),(30,24,'24','RAM; DDR3 4GB;AARVEX',1),(31,24,'24','RAM;DDR3  8GB;AARVEX',1),(32,24,'24','RAM;DDR4  4GB;SAMSUNG',1),(34,24,'24','RAM;DDR2  2GB;ADATA',1),(35,23,'23','PROCESER;I 3  3RD;Processor',1),(36,23,'23','PROCESER;I3  4TH;Processor',1),(37,23,'23','PROCESER;I3  6TH;Processor',1),(38,23,'23','PROCESER;I3 8TH;Processor',1),(39,23,'23','PROCESER;I3 9TH;Processor',1),(40,10,'10','FAN;61;Zebronics',1),(41,10,'10','del',0),(43,28,'28','SSD;256;LAPCARE',1),(44,28,'28','SSD;512;LAPCARE',1),(45,11,'11','HDD;500 GB;Servovlence',1),(46,11,'11','HDD;1TB;Consistent',1),(47,11,'11','HDD;2TB;Servovlence',1),(51,15,'15','KEY BOARDS;WIRELESS;HP',1),(52,15,'15','KEY BOARDS;BRANDED WIRE;LAPCARE',1),(53,15,'15','KEY BOARDS;MINI W LESS;HP',1),(54,15,'15','KEY BOARDS;BRANDED WIRELESS;LAPCARE',1),(55,20,'20','MOUSE;WIRED;LAPCARE',1),(56,20,'20','MOUSE;WIRELESS;LAPCARE',1),(57,20,'20','MOUSE;BRANDED WIRE;LOGITECH',1),(58,4,'4','CABINET;;Bluberry',1),(59,21,'21','POWER CARDS;;',1),(60,33,'33','VGA CABLES;5M;LAPCARE',1),(61,33,'33','VGA CABLES;1M;LAPCARE',1),(62,12,'12','HDMI CABLES;5M;LAPCARE',1),(63,12,'12','HDMI CABLES;1M;LAPCARE',1),(64,32,'32','USB EXTENTION;;Density',1),(65,22,'22','PRITER DATA;;',1),(66,26,'26','SATA DATA;;',1),(67,27,'27','SATA POWER;;',1),(68,5,'5','CATARAGE;12A;Geonix',1),(69,5,'5','CATARAGE;88A;Geonix',1),(70,5,'5','CATARAGE;110;Geonix',1),(72,9,'9','EPSON INKS;003 B;Epson',1),(73,9,'9','EPSON INKS;003M ;Epson',1),(74,9,'9','EPSON INKS;003C;Epson',1),(75,9,'9','EPSON INKS;003Y;Epson',1),(76,14,'14','INK PADS;3110;',1),(77,14,'14','INK PADS;380;',1),(78,18,'18','MONITRS;19.5;ENTER',1),(79,18,'18','MONITRS;19;Zebronics',1),(80,29,'29','SSD CASING;;Lapcare',1),(81,17,'17','LAPTOP CASIN;;',1),(82,16,'16','LAPTOP ADP;ADPTERS;LENOVO PIN',1),(83,16,'16','LAPTOP ADP;ADPTERS;SMALL PIN',1),(84,13,'13','HDMI TO LAN;;',1),(85,6,'6','CC CEMRS;DOMS  IP5MP;OME',1),(87,6,'6','CC CEMRS;BULLET IP5MP;HIKVISON',1),(88,6,'6','CC CEMRS;BULLET IP3MP;HIKVISON-DEL',1),(89,6,'6','CC CEMRS;DOMS   TV13MP;HIKVISON-DEL',1),(90,6,'6','CC CEMRS;DOMS TV15MP;HIKVISON',1),(92,6,'6','CC CEMRS;DVR;8CH;',1),(93,6,'6','CC CEMRS;DVR;4CH;',1),(94,24,'24','RAM;DDR2;2GB;',1),(95,24,'24','RAM;DDR3;4GB;',1),(96,24,'24','RAM;DDR3;8GB;',1),(97,24,'24','RAM;DDR4;8GB;',1),(98,6,'6','CC CEMRS;POWER CONETERS;;',1),(99,6,'6','CC CEMRS;BNC CONECTERS;;',1),(100,28,'28','SSD;1EVM;',1),(101,28,'28','SSD;256;EVM;',1),(102,28,'28','SSD;EVM;512;',1),(103,18,'18','MONITRS;BEN Q;27  INCH;',1),(104,11,'11','HDD;1TB;SEGATE;',1),(105,11,'11','HDD;2TB;SEAGATE;',1),(106,28,'28','SSD;AARVEX;512;',1),(107,15,'15','KEY BOARDS;WIRED;TVS GOLD;',1),(110,28,'28','SSD;1;LAPCARE;',1),(111,24,'24','RAM;DDR3 8GB;LAPCARE;',1),(112,28,'28','SSD;NVME 1;AARVEX;',1),(113,30,'30','USB;WIRELESS ADP;ENTER;',1),(114,31,'31','USB;SPAKERS;ENTER;',1),(115,10,'10','FAN;61;LAPCARE;',1),(116,15,'15','KEY BOARDS;USB CAMBO;LAPCARE;',1),(117,18,'18','MONITRS;19;LAPCARE;',1),(118,11,'11','HDD;4TB;CONSISTENT;',1),(120,5,'5','CATARAGE;TONER POWDER;12A;',1),(121,5,'5','CATARAGE;OPC DRUM;12A;',1),(122,5,'5','CATARAGE;TONER POWDER;PENTIUM;DEL',1),(123,25,'25','S.M.PS;ANT ESPORTS PSU ;700;',1),(124,6,'6','CC CEMRS;3 4U RACK;OEM;-DEL',1),(125,6,'6','CC CEMRS;DVR; HIKVISION 4CH ;',1),(126,6,'6','CC CEMRS;PVC JUNTION BOX;5*5;',1),(127,6,'6','CC CEMRS;PVC JUNTION BOX;4*4;',1),(128,19,'19','MOTHER BOARD;61;LAPCARE;',1),(129,19,'19','del',1),(130,25,'25','S.M.PS;zeb;;',1),(131,15,'15','KEY BOARDS;enter;;',1),(132,15,'15','KEY BOARDS;foxin;;',1),(133,6,'6','CC CEMRS;POE SWITH;8 PORT;',1),(134,20,'20','MOUSE;foxin;;',1),(135,28,'28','SSD;POWER-X;512;',1),(136,28,'28','SSD;256;AARVEX;',1),(137,28,'28','SSD;1AARVEX;',1),(138,28,'28','del',1),(139,15,'15','KEY BOARDS;lapcare wireless cambo;L102;',1),(140,15,'15','KEY BOARDS;lapcare wireless cambo;L901;',1),(141,12,'12','HDMI CABLES;LAPCARE;3M;',1),(142,35,'35','CONSUMABLES;CAT6 CABLE BUNDLE;ENTER;',1),(143,15,'15','KEY BOARDS;;ZEB;',1),(144,20,'20','MOUSE;;ZEB;',1),(145,5,'5','CATARAGE;12A;ZEB;',1),(146,4,'4','CABINET;;ZEB;',1),(147,35,'35','CONSUMABLES;12 1AMP;ADP;',1),(148,35,'35','CONSUMABLES;12V 2AMP;ADP;',1),(150,6,'6','CC CEMERA ;2MP BULLET ORG;-DEL',1),(151,9,'9','EPSON INKS;005;;',1),(152,21,'21','POWER CARDS;laptop;;',1),(153,17,'17','LAPTOP CASIN;candy;9.5;',1),(154,20,'20','MOUSE;WIRED;DELL;',1),(155,30,'30','USB;SOUND;U PORT;',1),(156,31,'31','USB;wifi+bluetooth;;',1),(157,35,'35','CONSUMABLES;C OTG CABLE;U PORT;',1),(158,30,'30','USB;WIFI DONGAL;300MBPS;',1),(159,30,'30','USB;HUB 2.0;;',1),(160,30,'30','USB;HUB  3.0;;',1),(161,5,'5','CATARAGE;LAPCARE;337A;',1),(162,5,'5','CATARAGE;LAPCARE;78A;',1),(163,25,'25','S.M.PS;LAPCARE;;',1),(165,5,'5','CATARAGE;SAMSUNG POWDER;-DEL;',1),(166,5,'5','CATARAGE;BROTHER POWDER;-DEL;',1),(167,19,'19','MOTHER BOARD;GIGABITE;610;',1),(168,23,'23','PROCESER;I 5;12TH GEN;',1),(169,24,'24','RAM;DDR4;16 GB;',1),(171,6,'6','CC CEMRS;BULLET;3MP HD;-DEL',1),(172,6,'6','CC CEMRS;BULLET;5MP HD;-DEL',1),(173,6,'6','CC CEMRS;8+4 CH;SMPS;-DEL',1),(174,6,'6','CC CEMRS;POE SWITCH;4CH;',1),(175,18,'18','MONITRS;22 INCH;ENTER;',1),(176,34,'34','PRINTER;EPSON;LX-310 DMP;',1),(177,34,'34','PRINTER;TVS E ;LP 46 DLITE;',1),(178,28,'28','SSD;256;FOXIN;',1),(179,6,'6','CC CEMRS;NVR;16 CH K1;',1),(180,6,'6','CC CEMRS;NVR;16 CH;',1),(181,28,'28','SSD;NVME;1',1),(182,3,'3','BULLET IP;Dummy;D1;',0),(183,6,'6','CC CEMRS;DVR;16 CH;',1),(184,6,'6','CC CEMRS;ROUTER;SIM BASED;',1),(185,6,'6','CC CEMRS;NVR;10 CH;',1),(186,18,'18','MONITRS;19 inch;ENTER;',1),(187,19,'19','MOTHER BOARD;61;POWER X;',1),(188,19,'19','MOTHER BOARD;310;AARVEX;',1),(189,10,'10','FAN;31;ZEB;',1),(190,20,'20','MOUSE;WIRED;ENTER;',1),(191,5,'5','CATARAGE;137A;ZEB;',1),(192,5,'5','CATARAGE;88A;TONER POWER-DEL;',1),(193,6,'6','CC CEMRS;8 CH;SMPS;',1),(194,6,'6','CC CEMRS;TAPO  CEMERA;;',1),(195,11,'11','HDD;1TB;servovlence;',1),(196,4,'4','CABINET;;;',1),(197,36,'36','Others;service  charges;;',1),(198,36,'36','Others;Dummy;Dummy;',0),(199,36,'36','Others;dum2;dum1;',0),(200,36,'36','Others;dum;dym1;',0),(201,36,'36','Others;dyme;dum3;',0);
/*!40000 ALTER TABLE `item_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_details_bkp`
--

DROP TABLE IF EXISTS `item_details_bkp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `item_details_bkp` (
  `id` int NOT NULL,
  `item_id` int DEFAULT NULL,
  `tag` varchar(20) DEFAULT NULL,
  `tagval` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_details_bkp`
--

LOCK TABLES `item_details_bkp` WRITE;
/*!40000 ALTER TABLE `item_details_bkp` DISABLE KEYS */;
INSERT INTO `item_details_bkp` VALUES (25,15,'15','KEY BOARDS;Wired;Lapcare;_bkp'),(26,25,'25','S.M.PS;;Enter;_bkp'),(27,19,'19','MOTHER BOARD;61;Zebronics_bkp'),(28,19,'19','MOTHER BOARD;81;enter_bkp'),(29,19,'19','MOTHER BOARD;110;Zebronics_bkp'),(30,24,'24','RAM; DDR3 4GB;AARVEX_bkp'),(31,24,'24','RAM;DDR3  8GB;AARVEX_bkp'),(32,24,'24','RAM;DDR4  4GB;SAMSUNG_bkp'),(33,24,'24','RAM;DDR4  8GB;SAMSUNG_bkp'),(34,24,'24','RAM;DDR2  2GB;ADATA_bkp'),(35,23,'23','PROCESER;I 3  3RD;Processor_bkp'),(36,23,'23','PROCESER;I3  4TH;Processor_bkp'),(37,23,'23','PROCESER;I3  6TH;Processor_bkp'),(38,23,'23','PROCESER;I3 8TH;Processor_bkp'),(39,23,'23','PROCESER;I3 9TH;Processor_bkp'),(40,10,'10','FAN;61;Zebronics_bkp'),(41,10,'10','FAN;1Zebronics_bkp'),(42,28,'28','SSD;1LAPCARE_bkp'),(43,28,'28','SSD;256;LAPCARE_bkp'),(44,28,'28','SSD;512;LAPCARE_bkp'),(45,11,'11','HDD;500 GB;Servovlence_bkp'),(46,11,'11','HDD;1TB;Consistent_bkp'),(47,11,'11','HDD;2TB;Servovlence_bkp'),(48,25,'25','S.M.PS;;EANTER_bkp'),(49,25,'25','S.M.PS;;EANTER_bkp'),(50,15,'15','KEY BOARDS;WIRED;LAPCARE_bkp'),(51,15,'15','KEY BOARDS;WIRELESS;HP_bkp'),(52,15,'15','KEY BOARDS;BRANDED WIRE;LAPCARE_bkp'),(53,15,'15','KEY BOARDS;MINI W LESS;HP_bkp'),(54,15,'15','KEY BOARDS;BRANDED WIRELESS;LAPCARE_bkp'),(55,20,'20','MOUSE;WIRED;LAPCARE_bkp'),(56,20,'20','MOUSE;WIRELESS;LAPCARE_bkp'),(57,20,'20','MOUSE;BRANDED WIRE;LOGITECH_bkp'),(58,4,'4','CABINET;;Bluberry_bkp'),(59,21,'21','POWER CARDS;;_bkp'),(60,33,'33','VGA CABLES;5M;LAPCARE_bkp'),(61,33,'33','VGA CABLES;1M;LAPCARE_bkp'),(62,12,'12','HDMI CABLES;5M;LAPCARE_bkp'),(63,12,'12','HDMI CABLES;1M;LAPCARE_bkp'),(64,32,'32','USB EXTENTION;;Density_bkp'),(65,22,'22','PRITER DATA;;_bkp'),(66,26,'26','SATA DATA;;_bkp'),(67,27,'27','SATA POWER;;_bkp'),(68,5,'5','CATARAGE;12A;Geonix_bkp'),(69,5,'5','CATARAGE;88A;Geonix_bkp'),(70,5,'5','CATARAGE;110;Geonix_bkp'),(71,5,'5','CATARAGE;92Geonix_bkp'),(72,9,'9','EPSON INKS;003 B;Epson_bkp'),(73,9,'9','EPSON INKS;003M ;Epson_bkp'),(74,9,'9','EPSON INKS;003C;Epson_bkp'),(75,9,'9','EPSON INKS;003Y;Epson_bkp'),(76,14,'14','INK PADS;3110;_bkp'),(77,14,'14','INK PADS;380;_bkp'),(78,18,'18','MONITRS;19.5;ENTER_bkp'),(79,18,'18','MONITRS;19;Zebronics_bkp'),(80,29,'29','SSD CASING;;Lapcare_bkp'),(81,17,'17','LAPTOP CASIN;;_bkp'),(82,16,'16','LAPTOP ADP;ADPTERS;LENOVO PIN_bkp'),(83,16,'16','LAPTOP ADP;ADPTERS;SMALL PIN_bkp'),(84,13,'13','HDMI TO LAN;;_bkp'),(85,6,'6','CC CEMRS;DOMS  IP5MP;HIKVISON_bkp'),(86,6,'6','CC CEMRS;DOMS  IP3MP;HIKVISON_bkp'),(87,6,'6','CC CEMRS;BULLET IP5MP;HIKVISON_bkp'),(88,6,'6','CC CEMRS;BULLET IP3MP;HIKVISON_bkp'),(89,6,'6','CC CEMRS;DOMS   TV13MP;HIKVISON_bkp'),(90,6,'6','CC CEMRS;DOMS TV15MP;HIKVISON_bkp'),(91,9,'9','9;EPSON INKS;PRITER;3210;_bkp'),(92,6,'6','6;CC CEMRS;DVR;8CH;_bkp'),(93,6,'6','6;CC CEMRS;DVR;4CH;_bkp'),(94,24,'24','24;RAM;DDR2;2GB;_bkp'),(95,24,'24','24;RAM;DDR3;4GB;_bkp'),(96,24,'24','24;RAM;DDR3;8GB;_bkp'),(97,24,'24','24;RAM;DDR4;8GB;_bkp'),(98,6,'6','6;CC CEMRS;POWER CONETERS;;_bkp'),(99,6,'6','6;CC CEMRS;BNC CONECTERS;;_bkp'),(100,28,'28','28;SSD;128;EVM;_bkp'),(101,28,'28','28;SSD;256;EVM;_bkp'),(102,28,'28','28;SSD;EVM;512;_bkp'),(103,18,'18','18;MONITRS;BEN Q;27  INCH;_bkp'),(104,11,'11','11;HDD;1TB;SEGATE;_bkp'),(105,11,'11','11;HDD;2TB;SEAGATE;_bkp'),(106,28,'28','28;SSD;AARVEX;512;_bkp'),(107,15,'15','15;KEY BOARDS;WIRED;TVS GOLD;_bkp'),(26,15,'15','KEY BOARDS;Wired;Lapcare;'),(27,25,'25','S.M.PS;;Enter;'),(28,19,'19','MOTHER BOARD;61;Zebronics'),(29,19,'19','MOTHER BOARD;81;enter'),(30,19,'19','MOTHER BOARD;110;Zebronics'),(31,24,'24','RAM; DDR3 4GB;AARVEX'),(32,24,'24','RAM;DDR3  8GB;AARVEX'),(33,24,'24','RAM;DDR4  4GB;SAMSUNG'),(35,24,'24','RAM;DDR2  2GB;ADATA'),(36,23,'23','PROCESER;I 3  3RD;Processor'),(37,23,'23','PROCESER;I3  4TH;Processor'),(38,23,'23','PROCESER;I3  6TH;Processor'),(39,23,'23','PROCESER;I3 8TH;Processor'),(40,23,'23','PROCESER;I3 9TH;Processor'),(41,10,'10','FAN;61;Zebronics'),(42,10,'10','del'),(44,28,'28','SSD;256;LAPCARE'),(45,28,'28','SSD;512;LAPCARE'),(46,11,'11','HDD;500 GB;Servovlence'),(47,11,'11','HDD;1TB;Consistent'),(48,11,'11','HDD;2TB;Servovlence'),(52,15,'15','KEY BOARDS;WIRELESS;HP'),(53,15,'15','KEY BOARDS;BRANDED WIRE;LAPCARE'),(54,15,'15','KEY BOARDS;MINI W LESS;HP'),(55,15,'15','KEY BOARDS;BRANDED WIRELESS;LAPCARE'),(56,20,'20','MOUSE;WIRED;LAPCARE'),(57,20,'20','MOUSE;WIRELESS;LAPCARE'),(58,20,'20','MOUSE;BRANDED WIRE;LOGITECH'),(59,4,'4','CABINET;;Bluberry'),(60,21,'21','POWER CARDS;;'),(61,33,'33','VGA CABLES;5M;LAPCARE'),(62,33,'33','VGA CABLES;1M;LAPCARE'),(63,12,'12','HDMI CABLES;5M;LAPCARE'),(64,12,'12','HDMI CABLES;1M;LAPCARE'),(65,32,'32','USB EXTENTION;;Density'),(66,22,'22','PRITER DATA;;'),(67,26,'26','SATA DATA;;'),(68,27,'27','SATA POWER;;'),(69,5,'5','CATARAGE;12A;Geonix'),(70,5,'5','CATARAGE;88A;Geonix'),(71,5,'5','CATARAGE;110;Geonix'),(72,5,'5','CATARAGE;92Geonix'),(73,9,'9','EPSON INKS;003 B;Epson'),(74,9,'9','EPSON INKS;003M ;Epson'),(75,9,'9','EPSON INKS;003C;Epson'),(76,9,'9','EPSON INKS;003Y;Epson'),(77,14,'14','INK PADS;3110;'),(78,14,'14','INK PADS;380;'),(79,18,'18','MONITRS;19.5;ENTER'),(80,18,'18','MONITRS;19;Zebronics'),(81,29,'29','SSD CASING;;Lapcare'),(82,17,'17','LAPTOP CASIN;;'),(83,16,'16','LAPTOP ADP;ADPTERS;LENOVO PIN'),(84,16,'16','LAPTOP ADP;ADPTERS;SMALL PIN'),(85,13,'13','HDMI TO LAN;;'),(86,6,'6','CC CEMRS;DOMS  IP5MP;HIKVISON'),(87,6,'6','CC CEMRS;DOMS  IP3MP;HIKVISON'),(88,6,'6','CC CEMRS;BULLET IP5MP;HIKVISON'),(89,6,'6','CC CEMRS;BULLET IP3MP;HIKVISON'),(90,6,'6','CC CEMRS;DOMS   TV13MP;HIKVISON'),(91,6,'6','CC CEMRS;DOMS TV15MP;HIKVISON'),(92,9,'9','EPSON INKS;PRITER;3210;'),(93,6,'6','CC CEMRS;DVR;8CH;'),(94,6,'6','CC CEMRS;DVR;4CH;'),(95,24,'24','RAM;DDR2;2GB;'),(96,24,'24','RAM;DDR3;4GB;'),(97,24,'24','RAM;DDR3;8GB;'),(98,24,'24','RAM;DDR4;8GB;'),(99,6,'6','CC CEMRS;POWER CONETERS;;'),(100,6,'6','CC CEMRS;BNC CONECTERS;;'),(101,28,'28','SSD;1EVM;'),(102,28,'28','SSD;256;EVM;'),(103,28,'28','SSD;EVM;512;'),(104,18,'18','MONITRS;BEN Q;27  INCH;'),(105,11,'11','HDD;1TB;SEGATE;'),(106,11,'11','HDD;2TB;SEAGATE;'),(107,28,'28','SSD;AARVEX;512;'),(108,15,'15','KEY BOARDS;WIRED;TVS GOLD;'),(111,28,'28','SSD;1;LAPCARE;'),(112,24,'24','RAM;DDR3 8GB;LAPCARE;'),(113,28,'28','SSD;NVME 1;AARVEX;'),(114,30,'30','USB;WIRELESS ADP;ENTER;'),(115,31,'31','USB;SPAKERS;ENTER;'),(116,10,'10','FAN;61;LAPCARE;'),(117,15,'15','KEY BOARDS;USB CAMBO;LAPCARE;'),(118,18,'18','MONITRS;19;LAPCARE;'),(119,11,'11','HDD;4TB;CONSISTENT;'),(120,6,'6','CC CEMRS;PVC JUNTION BOX;;'),(121,5,'5','CATARAGE;TONER POWDER;12A;'),(122,5,'5','CATARAGE;OPC DRUM;12A;'),(123,5,'5','CATARAGE;TONER POWDER;PENTIUM;'),(124,25,'25','S.M.PS;ANT ESPORTS PSU ;700;'),(125,6,'6','CC CEMRS;3 4U RACK;OEM;'),(126,6,'6','CC CEMRS;DVR; HIKVISION 4CH ;'),(127,6,'6','CC CEMRS;PVC JUNTION BOX;5*5;'),(128,6,'6','CC CEMRS;PVC JUNTION BOX;4*4;'),(129,19,'19','MOTHER BOARD;61;LAPCARE;'),(130,19,'19','del'),(131,25,'25','S.M.PS;zeb;;'),(132,15,'15','KEY BOARDS;enter;;'),(133,15,'15','KEY BOARDS;foxin;;'),(134,6,'6','CC CEMRS;POE SWITH;8 PORT;'),(135,20,'20','MOUSE;foxin;;'),(136,28,'28','SSD;POWER-X;512;'),(137,28,'28','SSD;256;AARVEX;'),(138,28,'28','SSD;1AARVEX;'),(139,28,'28','del'),(140,15,'15','KEY BOARDS;lapcare wireless cambo;L102;'),(141,15,'15','KEY BOARDS;lapcare wireless cambo;L901;'),(142,12,'12','HDMI CABLES;LAPCARE;3M;'),(143,35,'35','CONSUMABLES;CAT6 CABLE BUNDLE;ENTER;'),(144,15,'15','KEY BOARDS;;ZEB;'),(145,20,'20','MOUSE;;ZEB;'),(146,5,'5','CATARAGE;;ZEB;'),(147,4,'4','CABINET;;ZEB;'),(148,35,'35','CONSUMABLES;12 1AMP;ADP;'),(149,35,'35','CONSUMABLES;12V 2AMP;ADP;'),(150,6,'6','CC CEMRS;CC CEMERA ;2MP ORG;'),(151,6,'6','CC CEMRS;CC CEMERA ;2MP BULLET ORG;'),(152,9,'9','EPSON INKS;005;;'),(153,21,'21','POWER CARDS;laptop;;'),(154,17,'17','LAPTOP CASIN;candy;9.5;'),(155,20,'20','MOUSE;WIRED;DELL;'),(156,30,'30','USB;SOUND;U PORT;'),(157,31,'31','USB;wifi+bluetooth;;'),(158,35,'35','CONSUMABLES;C OTG CABLE;U PORT;'),(159,30,'30','USB;WIFI DONGAL;300MBPS;'),(160,30,'30','USB;HUB 2.0;;'),(161,30,'30','USB;HUB  3.0;;'),(162,5,'5','CATARAGE;LAPCARE;337A;'),(163,5,'5','CATARAGE;LAPCARE;78A;'),(164,25,'25','S.M.PS;LAPCARE;;'),(165,6,'6','CC CEMRS;LAPCARE;4+2;'),(166,5,'5','CATARAGE;SAMSUNG POWDER;;'),(167,5,'5','CATARAGE;BROTHER POWDER;;'),(168,19,'19','MOTHER BOARD;GIGABITE;610;'),(169,23,'23','PROCESER;I 5;12TH GEN;'),(170,24,'24','RAM;DDR4;16 GB;'),(171,4,'4','CABINET;RGB;;'),(172,6,'6','CC CEMRS;BULLET;3MP HD;'),(173,6,'6','CC CEMRS;BULLET;5MP HD;'),(174,6,'6','CC CEMRS;8+4 CH;SMPS;'),(175,6,'6','CC CEMRS;POE SWITCH;4CH;'),(176,18,'18','MONITRS;22 INCH;ENTER;'),(177,34,'34','PRINTER;EPSON;LX-310 DMP;'),(178,34,'34','PRINTER;TVS E ;LP 46 DLITE;'),(179,28,'28','SSD;256;FOXIN;'),(180,6,'6','CC CEMRS;NVR;16 CH K1;'),(181,6,'6','CC CEMRS;NVR;16 CH;'),(182,28,'28','SSD;NVME;1'),(183,3,'3','BULLET IP;Dummy;D1;'),(184,6,'6','CC CEMRS;DVR;16 CH;'),(185,6,'6','CC CEMRS;ROUTER;SIM BASED;'),(186,6,'6','CC CEMRS;NVR;10 CH;'),(187,18,'18','MONITRS;19 inch;ENTER;'),(188,19,'19','MOTHER BOARD;61;POWER X;'),(189,19,'19','MOTHER BOARD;310;AARVEX;'),(190,10,'10','FAN;31;ZEB;'),(191,20,'20','MOUSE;WIRED;ENTER;'),(192,5,'5','CATARAGE;137A;;'),(193,5,'5','CATARAGE;88A;TONER POWER;'),(194,6,'6','CC CEMRS;8 CH;SMPS;'),(195,6,'6','CC CEMRS;TAPO  CEMERA;;'),(196,11,'11','HDD;1TB;servovlence;'),(197,4,'4','CABINET;;;');
/*!40000 ALTER TABLE `item_details_bkp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `itembkp`
--

DROP TABLE IF EXISTS `itembkp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `itembkp` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `model` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `itembkp`
--

LOCK TABLES `itembkp` WRITE;
/*!40000 ALTER TABLE `itembkp` DISABLE KEYS */;
INSERT INTO `itembkp` VALUES (1,'test item','model1'),(2,'mther board','61'),(3,'mother board','61'),(4,'mother board','81'),(5,'mother board','110'),(6,'RAM','DDR2'),(7,'RAM','DDR3  8GB'),(8,'RAM','DDR4  8GB'),(9,'PROCESSER','I3 3RD'),(10,'PROCESSER','I3 4TH'),(11,'PROCESSER','I3  6TH'),(12,'PROCESSER','I3 8TH'),(13,'PROCESSER','I3 9TH'),(14,'PROCESSER','I5  '),(15,'FAN','61'),(16,'SSD','128'),(17,'SSD','256'),(18,'SSD','512'),(19,'HDD','5000 GB'),(20,'HDD','1TB');
/*!40000 ALTER TABLE `itembkp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `items`
--

DROP TABLE IF EXISTS `items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `items` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` text,
  `bucket_id` int DEFAULT NULL,
  `count` int DEFAULT NULL,
  `bucket` varchar(50) DEFAULT NULL,
  `script_code` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `bucket_id` (`bucket_id`),
  CONSTRAINT `items_ibfk_1` FOREIGN KEY (`bucket_id`) REFERENCES `bucket` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items`
--

LOCK TABLES `items` WRITE;
/*!40000 ALTER TABLE `items` DISABLE KEYS */;
INSERT INTO `items` VALUES (1,'Item 1','Description for item 1',1,NULL,NULL,NULL),(2,'SJVN','',1,0,'INVO','123'),(4,'RailTel Corporation of India Ltd','RailTel Corporation of India Ltd',3,0,'Chandamama','543265'),(5,'RailTel Corporation of India Ltd','RailTel Corporation of India Ltd',4,0,'Neelima','543265'),(6,'RELAXO FOOTWEARS LTD','RELAXO FOOTWEARS LTD',5,0,'Raji','530517');
/*!40000 ALTER TABLE `items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job_card_image`
--

DROP TABLE IF EXISTS `job_card_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `job_card_image` (
  `id` int NOT NULL AUTO_INCREMENT,
  `jobcard_id` int DEFAULT NULL,
  `img` mediumblob,
  `filename` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `jobcard_id` (`jobcard_id`),
  CONSTRAINT `job_card_image_ibfk_1` FOREIGN KEY (`jobcard_id`) REFERENCES `inv_jobcard` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job_card_image`
--

LOCK TABLES `job_card_image` WRITE;
/*!40000 ALTER TABLE `job_card_image` DISABLE KEYS */;
/*!40000 ALTER TABLE `job_card_image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kirana_category`
--

DROP TABLE IF EXISTS `kirana_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kirana_category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(30) DEFAULT NULL,
  `remarks` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kirana_category`
--

LOCK TABLES `kirana_category` WRITE;
/*!40000 ALTER TABLE `kirana_category` DISABLE KEYS */;
INSERT INTO `kirana_category` VALUES (1,'Pulses',''),(2,'Ravva',''),(3,'Four',''),(4,'Bathroom',''),(5,'Urad dal',''),(6,'Uraddal',''),(7,'Seeds',''),(8,'Seeds',''),(9,'Seeds',''),(10,'Millets','');
/*!40000 ALTER TABLE `kirana_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kirana_item`
--

DROP TABLE IF EXISTS `kirana_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kirana_item` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(30) DEFAULT NULL,
  `category_id` int DEFAULT NULL,
  `remarks` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `kirana_item_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `kirana_category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kirana_item`
--

LOCK TABLES `kirana_item` WRITE;
/*!40000 ALTER TABLE `kirana_item` DISABLE KEYS */;
INSERT INTO `kirana_item` VALUES (1,'Toordal',1,''),(2,'Wheat Ravva',2,''),(3,'Rice',3,''),(4,'Rice',3,''),(5,'Odonil',4,''),(6,'Chanadal',1,''),(7,'Uraddal',1,''),(8,'Groundnut oil',1,''),(9,'Sesame oil',1,''),(10,'Sunflower oil',1,''),(11,'Bansi ravva',1,''),(12,'Suji ravva',1,''),(13,'Ground nut',1,''),(14,'Bengalgram',1,''),(15,'Ragi flour',1,''),(16,'Wheat flour',1,''),(17,'Flax seeds',9,''),(18,'Makhana',9,''),(19,'Pumpkin',9,''),(20,'Watermelon',9,''),(21,'Foxtail',10,''),(22,'Browntop',10,''),(23,'Barnyard',10,''),(24,'Little millet',10,''),(25,'Little millet',10,''),(26,'Kodo',10,''),(27,'Jaggery',1,''),(28,'Dried chilli',1,''),(29,'Jeera',1,''),(30,'Detergent liquid cloth',1,''),(31,'Vatthulu',1,''),(32,'Matchbox',1,''),(33,'Soapnuts',1,''),(34,'Mustard yellow',1,''),(35,'Mustard black',1,''),(36,'Dhaniyalu',1,''),(37,'Moongdal',1,''),(38,'Gramdal',1,''),(39,'Tamarind',1,'');
/*!40000 ALTER TABLE `kirana_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scripts`
--

DROP TABLE IF EXISTS `scripts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `scripts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL,
  `code` varchar(20) DEFAULT NULL,
  `sector` varchar(20) DEFAULT NULL,
  `exchange` enum('NSE','BSE') DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scripts`
--

LOCK TABLES `scripts` WRITE;
/*!40000 ALTER TABLE `scripts` DISABLE KEYS */;
INSERT INTO `scripts` VALUES (1,'Kisan Mounldings','','Plastics','NSE'),(2,'SJVN','','Power','NSE');
/*!40000 ALTER TABLE `scripts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `seller`
--

DROP TABLE IF EXISTS `seller`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `seller` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `city` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seller`
--

LOCK TABLES `seller` WRITE;
/*!40000 ALTER TABLE `seller` DISABLE KEYS */;
INSERT INTO `seller` VALUES (1,'test','test@123','12345','tuni'),(2,'test','test@123','12345','tuni'),(3,'devavaram sachivalayam','','8790331601','Devavaram');
/*!40000 ALTER TABLE `seller` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `study_note`
--

DROP TABLE IF EXISTS `study_note`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `study_note` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL,
  `status` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `study_note`
--

LOCK TABLES `study_note` WRITE;
/*!40000 ALTER TABLE `study_note` DISABLE KEYS */;
INSERT INTO `study_note` VALUES (1,'test',1,1),(2,'test',1,1),(3,'test123',1,1),(4,'Relaxi',1,2),(5,'Relaxo',1,2),(6,'Relax',1,2),(7,'testnote',1,2),(8,'testrajinote123',1,2),(9,'Relaxofw',1,2),(10,'tst',1,2),(11,'tst',1,2),(12,'testnoteskm',1,2),(13,'Relaxofw2',1,2);
/*!40000 ALTER TABLE `study_note` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `study_note_file`
--

DROP TABLE IF EXISTS `study_note_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `study_note_file` (
  `note_id` int DEFAULT NULL,
  `filename` varchar(50) DEFAULT NULL,
  KEY `note_id` (`note_id`),
  CONSTRAINT `study_note_file_ibfk_1` FOREIGN KEY (`note_id`) REFERENCES `study_note` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `study_note_file`
--

LOCK TABLES `study_note_file` WRITE;
/*!40000 ALTER TABLE `study_note_file` DISABLE KEYS */;
INSERT INTO `study_note_file` VALUES (1,'study-notes/test.txt'),(2,'study-notes/test.txt'),(3,'study-notes/test123.txt'),(4,'study-notes/Relaxi.txt'),(5,'study-notes/Relaxo.txt'),(6,'study-notes/Relax.txt'),(7,'study-notes/testnote.txt'),(8,'study-notes/testrajinote123.txt'),(9,'study-notes/Relaxofw.txt'),(10,'study-notes/tst.txt'),(11,'study-notes/tst.txt'),(12,'study-notes/testnoteskm.txt'),(13,'study-notes/Relaxofw2.txt');
/*!40000 ALTER TABLE `study_note_file` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `temp_groc_list`
--

DROP TABLE IF EXISTS `temp_groc_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `temp_groc_list` (
  `listid` varchar(30) DEFAULT NULL,
  `item_id` int DEFAULT NULL,
  `qty` varchar(30) DEFAULT NULL,
  KEY `item_id` (`item_id`),
  CONSTRAINT `temp_groc_list_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `kirana_item` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `temp_groc_list`
--

LOCK TABLES `temp_groc_list` WRITE;
/*!40000 ALTER TABLE `temp_groc_list` DISABLE KEYS */;
/*!40000 ALTER TABLE `temp_groc_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tr_account`
--

DROP TABLE IF EXISTS `tr_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tr_account` (
  `id` int NOT NULL AUTO_INCREMENT,
  `debt` int DEFAULT NULL,
  `date` date DEFAULT NULL,
  `remarks` varchar(100) DEFAULT NULL,
  `item_id` int DEFAULT NULL,
  `from_acc_id` int DEFAULT NULL,
  `to_acc_id` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tr_account`
--

LOCK TABLES `tr_account` WRITE;
/*!40000 ALTER TABLE `tr_account` DISABLE KEYS */;
INSERT INTO `tr_account` VALUES (1,1100,'2025-03-22','',1,1,7),(2,200,'2025-04-12','',4,12,13),(3,200,'2025-04-10','',4,13,13),(4,9600,'2025-04-12','',6,1,13),(5,15000,'2025-04-12','',2,2,13),(6,550,'2025-04-12','',7,1,13),(7,576,'2025-04-12','',8,12,13),(8,97,'2025-04-12','',4,12,13),(9,435,'2025-04-12','',9,12,13),(10,40000,'2025-04-12','',10,2,10),(11,11000,'2025-04-12','',11,1,13),(12,1943,'2025-04-12','',12,1,13),(13,15000,'2025-04-12','',2,2,13),(14,675,'2025-04-12','',9,1,13),(15,35000,'2025-04-12','',10,1,14),(16,520,'2025-04-13','',14,11,13),(17,2386,'2025-04-10','',7,11,13),(18,3345,'2025-04-13','',7,11,13),(19,238,'2025-04-10','',4,11,13),(20,300,'2025-04-10','',16,11,13),(21,602,'2025-04-09','',4,11,13),(22,1500,'2025-04-06','',9,11,13),(23,2500,'2025-04-06','',1,11,13),(24,2500,'2025-04-06','',17,11,13),(25,5000,'2025-04-06','',17,11,13),(26,2000,'2025-04-06','',18,11,13),(27,339,'2025-04-05','',9,11,13),(28,703,'2025-04-05','',19,11,13),(29,305,'2025-04-14','',9,11,13),(30,506,'2025-04-05','',8,11,13),(31,600,'2025-04-05','',8,11,13),(32,220,'2025-04-05','',8,11,13),(33,942,'2025-04-05','',20,11,13),(34,874,'2025-04-05','',21,11,13),(35,395,'2025-04-05','',9,11,13),(36,510,'2025-04-04','',9,11,13),(37,78,'2025-04-03','',9,11,13),(38,88,'2025-04-03','',9,11,13),(39,1890,'2025-03-31','',22,11,13),(40,2610,'2025-03-30','',14,11,13),(41,420,'2025-03-29','',9,11,13),(42,225,'2025-03-29','',22,11,13),(43,1274,'2025-03-29','',22,11,13),(44,346,'2025-03-29','',9,11,13),(45,5789,'2025-03-27','',23,11,13),(46,2085,'2025-03-24','',24,11,13),(47,450,'2025-03-23','',25,11,13),(48,404,'2025-03-23','',25,11,13),(49,450,'2025-03-23','',9,11,13),(50,1534,'2025-03-23','',9,11,13),(51,2500,'2025-03-22','',17,11,13),(52,2000,'2025-03-22','',18,11,13),(53,160,'2025-04-14','',9,12,13),(54,1844,'2025-04-15','',19,12,13),(55,2072,'2025-07-18','Orgfarm',4,11,13),(56,145,'2025-07-18','',33,15,13),(57,12,'2025-07-18','',4,12,13),(58,1071,'2025-07-18','',34,15,13),(59,660,'2025-07-18','',22,15,13),(60,212,'2025-07-18','',8,12,13),(61,200,'2025-07-18','',34,12,13),(62,370,'2025-07-18','',9,12,13),(63,180,'2025-07-18','',34,12,13),(64,199,'2025-07-18','',35,12,13);
/*!40000 ALTER TABLE `tr_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tr_budget`
--

DROP TABLE IF EXISTS `tr_budget`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tr_budget` (
  `id` int NOT NULL AUTO_INCREMENT,
  `item_id` int DEFAULT NULL,
  `amount` int DEFAULT NULL,
  `month` varchar(10) DEFAULT NULL,
  `remarks` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tr_budget`
--

LOCK TABLES `tr_budget` WRITE;
/*!40000 ALTER TABLE `tr_budget` DISABLE KEYS */;
INSERT INTO `tr_budget` VALUES (1,1,1100,'JUL',''),(2,4,3000,'JUL',''),(3,5,3000,'JUL',''),(4,11,12000,'JUL',''),(5,17,5000,'JUL',''),(6,18,2000,'JUL',''),(7,17,2500,'JUL',''),(8,20,1000,'JUL',''),(9,21,1000,'JUL',''),(10,6,4000,'JUL',''),(11,8,2500,'JUL',''),(12,22,7000,'JUL',''),(13,13,33000,'JUL',''),(14,26,10000,'JUL',''),(15,27,2500,'JUL',''),(16,28,3000,'JUL',''),(17,19,3000,'JUL',''),(18,25,3000,'JUL',''),(19,29,2000,'JUL',''),(20,28,3000,'JUL',''),(21,30,15000,'JUL',''),(22,31,45000,'JUL',''),(23,33,800,'JUL','');
/*!40000 ALTER TABLE `tr_budget` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tr_daily_changes`
--

DROP TABLE IF EXISTS `tr_daily_changes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tr_daily_changes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tr_date` date DEFAULT NULL,
  `tr_open` int DEFAULT NULL,
  `tr_close` int DEFAULT NULL,
  `tr_low` int DEFAULT NULL,
  `tr_high` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `user_name` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tr_daily_changes`
--

LOCK TABLES `tr_daily_changes` WRITE;
/*!40000 ALTER TABLE `tr_daily_changes` DISABLE KEYS */;
INSERT INTO `tr_daily_changes` VALUES (1,'2025-02-13',76188,76293,75388,76459,NULL,'Lakshmi'),(2,'2025-02-12',76188,76171,75388,76459,NULL,'raji'),(3,'2025-02-09',78119,77860,77475,78356,NULL,'raji'),(4,'2025-02-09',78119,77860,77475,78356,NULL,'raji'),(5,'2025-02-09',78119,77860,77475,78356,NULL,'raji'),(6,'2025-02-13',76201,76138,76013,76764,NULL,'raji'),(7,'2025-02-14',76388,76138,76110,76483,NULL,'Lakshmi'),(8,'2025-02-14',76388,76138,76110,76483,NULL,'Lakshmi'),(9,'2025-02-14',76388,76138,76110,76483,NULL,'Lakshmi'),(10,'2025-02-14',76388,75939,75439,76483,NULL,'raji'),(11,'2025-02-17',75641,75939,75294,75041,NULL,'Lakshmi'),(12,'2025-03-26',100,150,50,200,NULL,'1'),(13,'2025-03-26',78021,77288,77194,78167,NULL,'1'),(14,'2025-03-27',77,77,77,78,NULL,'1'),(15,'2025-03-27',77087,77606,77082,77747,NULL,'1'),(16,'2025-03-28',78,78,77,78,NULL,'1'),(17,'2025-04-01',76025,77414,75912,77487,NULL,'1'),(18,'2025-04-01',77,77,77,78,NULL,'1'),(19,'2025-04-02',76,76,76,77,NULL,'1'),(20,'2025-04-03',76,77,76,76,NULL,'1'),(21,'2025-04-01',76882,76024,75912,77487,NULL,'1'),(22,'2025-04-07',71,75,71,73,NULL,'1');
/*!40000 ALTER TABLE `tr_daily_changes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tr_inv_sale`
--

DROP TABLE IF EXISTS `tr_inv_sale`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tr_inv_sale` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cust_id` int DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `itemid` int DEFAULT NULL,
  `cost` int DEFAULT NULL,
  `trdate` date DEFAULT NULL,
  `price` int DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `reciept_num` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `itemid` (`itemid`),
  KEY `cust_id` (`cust_id`),
  KEY `fk_reciept` (`reciept_num`),
  CONSTRAINT `fk_reciept` FOREIGN KEY (`reciept_num`) REFERENCES `inv_sale_reciept` (`id`),
  CONSTRAINT `tr_inv_sale_ibfk_1` FOREIGN KEY (`itemid`) REFERENCES `item_details` (`id`),
  CONSTRAINT `tr_inv_sale_ibfk_2` FOREIGN KEY (`cust_id`) REFERENCES `inv_customer` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=455 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tr_inv_sale`
--

LOCK TABLES `tr_inv_sale` WRITE;
/*!40000 ALTER TABLE `tr_inv_sale` DISABLE KEYS */;
INSERT INTO `tr_inv_sale` VALUES (395,NULL,NULL,146,800,'2026-01-03',800,1,442),(396,NULL,NULL,27,1900,'2026-01-03',1900,1,442),(397,NULL,NULL,96,1000,'2026-01-03',1000,1,442),(398,NULL,NULL,26,500,'2026-01-03',500,1,442),(399,NULL,NULL,40,200,'2026-01-03',200,1,442),(400,NULL,NULL,178,2000,'2026-01-03',2000,1,442),(401,NULL,NULL,35,800,'2026-01-03',800,1,442),(402,NULL,NULL,152,175,'2026-01-06',175,1,443),(403,NULL,NULL,182,0,'2026-01-06',0,0,443),(404,NULL,NULL,68,500,'2026-01-06',500,1,444),(405,NULL,NULL,26,450,'2026-01-06',450,1,445),(406,NULL,NULL,113,250,'2026-01-06',250,1,446),(407,NULL,NULL,68,500,'2026-01-06',500,1,447),(408,NULL,NULL,27,1900,'2026-01-06',1900,1,448),(409,NULL,NULL,35,600,'2026-01-06',600,1,448),(410,NULL,NULL,96,1200,'2026-01-06',1200,1,448),(411,NULL,NULL,146,800,'2026-01-06',800,1,448),(412,NULL,NULL,26,450,'2026-01-06',450,1,448),(413,NULL,NULL,131,200,'2026-01-06',200,1,448),(414,NULL,NULL,181,2000,'2026-01-06',2000,1,448),(415,NULL,NULL,154,300,'2026-01-06',300,1,448),(416,NULL,NULL,113,250,'2026-01-06',250,1,448),(417,NULL,NULL,120,300,'2026-01-08',300,1,449),(418,NULL,NULL,172,5200,'2026-01-09',2600,2,450),(419,NULL,NULL,85,2100,'2026-01-09',2100,1,450),(420,NULL,NULL,173,1000,'2026-01-09',1000,1,450),(421,NULL,NULL,92,5600,'2026-01-09',5600,1,450),(422,NULL,NULL,99,200,'2026-01-09',50,4,450),(423,NULL,NULL,98,100,'2026-01-09',50,2,450),(424,NULL,NULL,182,0,'2026-01-09',0,0,450),(425,NULL,NULL,74,460,'2026-01-09',460,1,451),(426,NULL,NULL,73,460,'2026-01-09',460,1,451),(427,NULL,NULL,90,3000,'2026-01-19',1500,2,452),(428,NULL,NULL,93,5100,'2026-01-19',5100,1,452),(429,NULL,NULL,173,500,'2026-01-19',500,1,452),(430,NULL,NULL,126,100,'2026-01-19',50,2,452),(431,NULL,NULL,99,200,'2026-01-19',50,4,452),(432,NULL,NULL,98,100,'2026-01-19',50,2,452),(433,NULL,NULL,88,0,'2026-01-19',0,3,453),(434,NULL,NULL,171,0,'2026-01-19',0,1,453),(435,NULL,NULL,89,0,'2026-01-19',0,1,453),(436,NULL,NULL,171,0,'2026-01-19',0,3,453),(437,NULL,NULL,187,2000,'2026-01-21',2000,1,454),(438,NULL,NULL,35,600,'2026-01-21',600,1,454),(439,NULL,NULL,96,1200,'2026-01-21',1200,1,454),(440,NULL,NULL,40,200,'2026-01-21',200,1,454),(441,NULL,NULL,137,2000,'2026-01-21',2000,1,454),(442,NULL,NULL,133,2000,'2026-01-21',2000,1,455),(443,NULL,NULL,62,350,'2026-01-21',350,1,456),(444,NULL,NULL,96,1100,'2026-01-21',1100,1,457),(445,NULL,NULL,187,1800,'2026-01-21',1800,1,457),(446,NULL,NULL,26,500,'2026-01-21',500,1,458),(447,NULL,NULL,72,360,'2026-01-26',360,1,459),(448,NULL,NULL,182,0,'2026-01-26',0,0,459),(449,NULL,NULL,187,2000,'2026-01-27',2000,1,460),(450,NULL,NULL,45,2000,'2026-02-02',2000,1,461),(451,NULL,NULL,45,2000,'2026-02-02',2000,1,462),(452,NULL,NULL,158,350,'2026-02-02',350,1,463),(453,NULL,NULL,61,150,'2026-02-02',150,1,463),(454,NULL,NULL,197,200,'2026-02-02',200,1,463);
/*!40000 ALTER TABLE `tr_inv_sale` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tr_kirana`
--

DROP TABLE IF EXISTS `tr_kirana`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tr_kirana` (
  `id` int NOT NULL AUTO_INCREMENT,
  `item_id` int DEFAULT NULL,
  `quantity` varchar(10) DEFAULT NULL,
  `brand` varchar(30) DEFAULT NULL,
  `amount` int DEFAULT NULL,
  `month` varchar(10) DEFAULT NULL,
  `remarks` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `item_id` (`item_id`),
  CONSTRAINT `tr_kirana_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `kirana_item` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tr_kirana`
--

LOCK TABLES `tr_kirana` WRITE;
/*!40000 ALTER TABLE `tr_kirana` DISABLE KEYS */;
INSERT INTO `tr_kirana` VALUES (1,1,'1KG','',0,'None',''),(2,2,'1KG','',0,'None',''),(3,5,'4','',0,'None',''),(4,3,'20kg','Mysore mallige',0,'None',''),(5,6,'500g','',0,'None',''),(6,7,'1kg','',0,'None',''),(7,8,'500g','',0,'None',''),(8,9,'500g','',0,'None',''),(9,10,'500g','',0,'None',''),(10,11,'500g','',0,'None',''),(11,12,'500g','',0,'None',''),(12,13,'500g','',0,'None',''),(13,14,'','',0,'None',''),(14,14,'500','',0,'None',''),(15,27,'500','',0,'None',''),(16,28,'500','',0,'None',''),(17,29,'50','',0,'None',''),(18,30,'1000','',0,'None',''),(19,31,'2pkt','',0,'None',''),(20,32,'1','',0,'None',''),(21,33,'250','',0,'None',''),(22,39,'500','',0,'None',''),(23,18,'200','',0,'None','');
/*!40000 ALTER TABLE `tr_kirana` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tr_share`
--

DROP TABLE IF EXISTS `tr_share`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tr_share` (
  `id` int NOT NULL AUTO_INCREMENT,
  `script_code` varchar(10) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` text,
  `quantity` int DEFAULT NULL,
  `price` int DEFAULT NULL,
  `tr_date` date DEFAULT NULL,
  `exchange` varchar(10) DEFAULT NULL,
  `bucket_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `bucket_id` (`bucket_id`),
  CONSTRAINT `tr_share_ibfk_1` FOREIGN KEY (`bucket_id`) REFERENCES `bucket` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tr_share`
--

LOCK TABLES `tr_share` WRITE;
/*!40000 ALTER TABLE `tr_share` DISABLE KEYS */;
INSERT INTO `tr_share` VALUES (1,'123','SJVN','',10,123,'2025-03-20','BSE',1),(2,'123','SJVN','',10,100,'2025-03-20','BSE',1),(3,'543265','RailTel Corporation of India Ltd','',10,279,'2025-03-21','BSE',3),(4,'543265','RailTel Corporation of India Ltd','',10,278,'2025-03-21','BSE',3),(5,'543265','RailTel Corporation of India Ltd','',10,278,'2025-03-21','BSE',3),(6,'543265','RailTel Corporation of India Ltd','',10,278,'2025-03-21','BSE',3),(7,'543265','RailTel Corporation of India Ltd','',10,279,'2025-03-21','BSE',3),(8,'530517','RELAXO FOOTWEARS LTD','',10,402,'2025-03-27','BSE',5),(9,'None','Item 1','',10,123,'2025-04-04','BSE',1),(10,'543265','RailTel Corporation of India Ltd','',16,295,'2025-04-04','BSE',4),(11,'None','Item 1','',3,1234,'2025-04-04','BSE',1),(12,'None','Item 1','',6,456,'2025-04-04','BSE',1),(13,'None','Item 1','',45,324,'2025-04-04','BSE',1),(14,'None','Item 1','',55,92,'2025-04-11','BSE',1),(15,'543265','RailTel Corporation of India Ltd','',35,291,'2025-04-11','BSE',4),(16,'123','SJVN','',55,92,'2025-04-11','BSE',1),(17,'530517','RELAXO FOOTWEARS LTD','',12,410,'2025-04-11','BSE',5);
/*!40000 ALTER TABLE `tr_share` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `update_inventory`
--

DROP TABLE IF EXISTS `update_inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `update_inventory` (
  `id` int NOT NULL AUTO_INCREMENT,
  `item_id` int DEFAULT NULL,
  `buyer_id` int DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `tr_date` date DEFAULT NULL,
  `amount` int DEFAULT NULL,
  `cost` int DEFAULT NULL,
  `mrp` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=335 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `update_inventory`
--

LOCK TABLES `update_inventory` WRITE;
/*!40000 ALTER TABLE `update_inventory` DISABLE KEYS */;
INSERT INTO `update_inventory` VALUES (79,27,4,3,'2025-06-12',925,NULL,NULL),(81,130,4,6,'2025-06-12',380,NULL,NULL),(82,25,3,1,'2025-07-01',460,NULL,NULL),(83,107,10,2,'2025-07-01',1000,NULL,NULL),(84,51,4,1,'2025-07-01',600,NULL,NULL),(87,131,3,2,'2025-07-01',250,NULL,NULL),(88,124,2,2,'2025-07-12',700,NULL,NULL),(89,63,3,1,'2025-07-01',180,NULL,NULL),(90,69,8,4,'2025-07-01',300,NULL,NULL),(93,86,7,6,'2025-07-11',1200,NULL,NULL),(94,88,7,4,'2025-07-11',1500,NULL,NULL),(95,87,7,4,'2025-07-11',1500,NULL,NULL),(97,99,7,100,'2025-07-03',900,NULL,NULL),(98,98,7,100,'2025-07-03',400,NULL,NULL),(103,133,7,2,'2025-07-03',1650,NULL,NULL),(104,64,2,2,'2025-07-01',200,NULL,NULL),(105,134,5,10,'2025-07-19',150,NULL,NULL),(106,35,5,5,'2025-07-19',450,NULL,NULL),(107,65,5,6,'2025-07-19',100,NULL,NULL),(108,135,10,2,'2025-07-19',2600,NULL,NULL),(109,27,4,4,'2025-07-22',955,NULL,NULL),(110,136,4,5,'2025-07-22',1335,NULL,NULL),(111,138,4,5,'2025-07-22',811,NULL,NULL),(112,31,4,5,'2025-07-22',606,NULL,NULL),(113,130,4,10,'2025-07-22',380,NULL,NULL),(114,41,4,10,'2025-07-22',133,NULL,NULL),(115,97,4,2,'2025-07-22',1297,NULL,NULL),(116,117,3,1,'2025-07-24',2500,NULL,NULL),(117,139,3,1,'2025-07-24',500,NULL,NULL),(118,140,3,1,'2025-07-24',700,NULL,NULL),(119,56,3,5,'2025-07-24',219,NULL,NULL),(120,63,3,3,'2025-07-24',80,NULL,NULL),(121,141,3,2,'2025-07-24',125,NULL,NULL),(122,133,3,1,'2025-07-24',1299,NULL,NULL),(123,126,3,10,'2025-07-24',35,NULL,NULL),(125,105,4,1,'2025-07-24',4500,NULL,NULL),(126,76,13,10,'2025-07-15',200,NULL,NULL),(127,72,13,4,'2025-07-07',325,NULL,NULL),(128,74,13,1,'2025-07-07',450,NULL,NULL),(129,73,13,1,'2025-07-07',450,NULL,NULL),(130,75,13,1,'2025-07-07',450,NULL,NULL),(131,68,13,4,'2025-07-11',300,NULL,NULL),(132,91,14,1,'2025-07-26',10700,NULL,NULL),(133,91,2,1,'2025-07-29',10300,NULL,NULL),(135,35,4,9,'2025-07-28',4050,NULL,NULL),(136,27,4,9,'2025-07-28',8370,NULL,NULL),(137,40,4,10,'2025-07-28',1300,NULL,NULL),(138,130,4,6,'2025-07-28',2280,NULL,NULL),(139,79,4,9,'2025-07-28',15300,NULL,NULL),(140,31,4,5,'2025-07-28',2750,NULL,NULL),(141,131,4,5,'2025-07-28',1000,NULL,NULL),(142,94,4,2,'2025-07-28',550,NULL,NULL),(143,27,4,5,'2025-08-22',950,NULL,NULL),(144,29,4,2,'2025-08-22',1450,NULL,NULL),(145,136,4,5,'2025-08-22',1300,NULL,NULL),(147,31,4,5,'2025-08-22',550,NULL,NULL),(148,143,4,10,'2025-08-26',200,NULL,NULL),(149,144,4,10,'2025-08-22',150,NULL,NULL),(150,145,4,5,'2025-08-22',280,NULL,NULL),(151,113,4,10,'2025-08-30',200,NULL,NULL),(152,146,4,10,'2025-08-30',600,NULL,NULL),(153,130,4,10,'2025-08-30',400,NULL,NULL),(159,150,15,10,'2025-09-01',1550,NULL,NULL),(160,150,15,10,'2025-09-01',1620,NULL,NULL),(161,29,4,1,'2025-09-08',3300,NULL,NULL),(162,35,4,3,'2025-09-08',500,NULL,NULL),(163,31,4,3,'2025-09-08',550,NULL,NULL),(164,51,4,3,'2025-09-08',620,NULL,NULL),(165,117,3,5,'2025-09-08',2000,NULL,NULL),(166,72,14,10,'2025-09-19',290,NULL,NULL),(167,151,14,3,'2025-09-19',595,NULL,NULL),(168,133,3,2,'2025-09-19',1250,NULL,NULL),(169,117,3,2,'2025-09-19',1950,NULL,NULL),(170,45,10,10,'2025-09-20',950,NULL,NULL),(171,35,10,5,'2025-10-20',450,NULL,NULL),(172,137,10,5,'2025-09-20',850,NULL,NULL),(173,136,10,5,'2025-09-20',1350,NULL,NULL),(174,124,10,4,'2025-09-20',325,NULL,NULL),(175,59,16,10,'2025-10-06',95,NULL,NULL),(176,153,16,10,'2025-10-06',80,NULL,NULL),(177,66,16,20,'2025-10-06',15,NULL,NULL),(178,67,16,10,'2025-10-06',15,NULL,NULL),(179,148,16,4,'2025-10-06',150,NULL,NULL),(180,154,16,5,'2025-10-06',250,NULL,NULL),(181,155,16,2,'2025-10-06',145,NULL,NULL),(182,156,16,5,'2025-10-06',95,NULL,NULL),(183,157,16,1,'2025-10-06',300,NULL,NULL),(184,158,16,5,'2025-10-06',200,NULL,NULL),(186,58,9,2,'2025-10-17',NULL,3,4),(187,161,3,1,'2025-10-24',NULL,410,550),(188,162,3,1,'2025-10-25',NULL,410,550),(189,120,3,20,'2025-10-25',NULL,80,100),(190,163,3,10,'2025-10-25',NULL,410,550),(192,165,3,5,'2025-10-25',NULL,85,100),(193,166,3,5,'2025-10-25',NULL,100,200),(194,169,17,2,'2025-10-14',NULL,2950,3200),(195,168,17,1,'2025-10-14',NULL,13700,14000),(196,170,17,1,'2025-10-14',NULL,2175,2500),(197,96,17,5,'2025-10-23',NULL,1000,1200),(198,27,17,5,'2025-10-23',NULL,1150,2000),(199,26,17,5,'2025-10-23',NULL,410,500),(200,41,17,5,'2025-10-23',NULL,120,200),(201,87,7,5,'2025-10-14',NULL,950,1200),(202,85,7,5,'2025-10-14',NULL,950,1200),(203,90,7,5,'2025-10-14',NULL,500,1000),(204,89,7,5,'2025-10-14',NULL,950,1200),(205,171,7,5,'2025-10-14',NULL,950,1200),(206,172,7,5,'2025-10-14',NULL,950,1200),(208,173,7,5,'2025-10-14',NULL,500,650),(209,99,7,300,'2025-10-14',NULL,10,15),(210,98,7,200,'2025-10-14',NULL,7,10),(211,93,7,1,'2025-10-14',NULL,5500,7000),(212,92,7,1,'2025-10-29',NULL,5500,7000),(213,174,7,1,'2025-10-14',NULL,950,1200),(214,87,7,5,'2025-10-28',NULL,950,1200),(215,85,7,5,'2025-10-28',NULL,950,1200),(216,133,3,2,'2025-10-31',NULL,1275,1600),(217,114,3,2,'2025-10-31',NULL,360,400),(218,68,3,5,'2025-10-31',NULL,320,550),(219,142,3,1,'2025-10-31',NULL,2499,3500),(220,146,3,3,'2025-10-31',NULL,900,1050),(221,175,3,4,'2025-10-31',NULL,2200,3500),(222,78,17,1,'2025-10-23',NULL,2050,2500),(223,176,6,1,'2025-11-03',NULL,11300,11900),(224,146,2,10,'2025-11-03',NULL,950,1050),(225,142,2,1,'2025-11-03',NULL,2550,3500),(226,178,2,5,'2025-11-03',NULL,1850,2300),(227,126,2,25,'2025-11-03',NULL,21,50),(228,127,2,25,'2025-11-03',NULL,18,50),(229,76,2,10,'2025-11-03',NULL,95,200),(230,133,2,5,'2025-11-03',NULL,1350,1900),(231,177,2,1,'2025-11-03',NULL,11900,12500),(232,74,2,2,'2025-11-03',NULL,440,460),(233,73,2,2,'2025-11-03',NULL,440,460),(234,75,2,2,'2025-11-03',NULL,440,460),(235,179,2,1,'2025-11-03',NULL,8950,14500),(236,180,18,1,'2025-10-24',NULL,7200,8500),(237,167,17,1,'2025-10-14',NULL,6000,7000),(238,123,17,1,'2025-11-10',NULL,2200,3200),(239,182,1,10,'2025-11-13',NULL,123,124),(240,87,7,4,'2025-11-11',NULL,950,1200),(241,85,7,4,'2025-11-11',NULL,950,1200),(242,93,7,1,'2025-11-11',NULL,2400,3500),(243,183,7,1,'2025-11-11',NULL,3500,6000),(244,172,7,2,'2025-11-11',NULL,950,1200),(245,184,7,1,'2025-11-11',NULL,1200,2000),(246,93,7,1,'2025-11-17',NULL,2400,3500),(247,180,7,1,'2025-11-17',NULL,3500,5500),(248,185,7,1,'2025-11-17',NULL,2400,3500),(249,182,1,10,'2025-11-20',NULL,1,1),(250,182,1,10,'2025-11-22',NULL,10,10),(251,182,1,50,'2025-11-25',NULL,1,1),(252,182,1,50,'2025-12-14',NULL,2,2),(253,174,3,1,'2025-11-20',NULL,950,1300),(254,186,19,4,'2026-01-01',NULL,1900,3000),(255,146,19,7,'2026-01-01',NULL,925,1050),(256,187,19,5,'2026-01-01',NULL,1180,1900),(257,96,19,5,'2026-01-01',NULL,1100,1600),(258,188,19,1,'2026-01-01',NULL,3600,4000),(259,40,19,6,'2026-01-01',NULL,130,200),(260,189,19,3,'2026-01-01',NULL,130,200),(261,94,19,2,'2026-01-01',NULL,300,450),(262,97,19,2,'2026-01-01',NULL,3200,4000),(263,169,19,2,'2026-01-01',NULL,9000,10000),(264,35,19,6,'2026-01-01',NULL,500,700),(265,178,19,14,'2026-01-01',NULL,2400,3000),(266,137,19,1,'2026-01-01',NULL,1400,1600),(267,181,19,1,'2026-01-01',NULL,2800,3000),(268,190,19,44,'2026-01-01',NULL,75,100),(269,144,19,3,'2026-01-01',NULL,80,100),(270,154,19,1,'2026-01-01',NULL,250,300),(271,56,19,1,'2026-01-01',NULL,350,430),(272,143,19,1,'2026-01-01',NULL,200,250),(273,52,19,4,'2026-01-01',NULL,200,250),(274,54,19,1,'2026-01-01',NULL,850,950),(275,131,19,3,'2026-01-01',NULL,200,250),(276,26,19,9,'2026-01-01',NULL,450,600),(277,68,19,4,'2026-01-01',NULL,380,500),(278,69,19,3,'2026-01-01',NULL,380,500),(279,191,19,1,'2026-01-01',NULL,550,750),(280,120,19,15,'2026-01-01',NULL,75,300),(281,192,19,2,'2026-01-01',NULL,75,300),(282,147,19,3,'2026-01-01',NULL,90,150),(283,148,19,3,'2026-01-01',NULL,120,250),(284,72,19,1,'2026-01-01',NULL,280,360),(285,151,19,2,'2026-01-01',NULL,590,700),(286,73,19,1,'2026-01-01',NULL,420,460),(287,74,19,1,'2026-01-01',NULL,420,460),(288,157,19,5,'2026-01-01',NULL,100,150),(289,160,19,6,'2026-01-01',NULL,140,250),(290,159,19,3,'2026-01-01',NULL,140,250),(291,155,19,2,'2026-01-01',NULL,100,200),(292,158,19,1,'2026-01-01',NULL,250,350),(293,156,19,3,'2026-01-01',NULL,250,400),(294,153,19,10,'2026-01-01',NULL,150,250),(295,113,19,9,'2026-01-01',NULL,200,250),(296,76,19,3,'2026-01-01',NULL,150,200),(297,59,19,9,'2026-01-01',NULL,100,150),(298,152,19,8,'2026-01-01',NULL,100,200),(299,65,19,10,'2026-01-01',NULL,75,150),(300,63,19,10,'2026-01-01',NULL,80,150),(301,62,19,1,'2026-01-01',NULL,300,350),(302,84,19,8,'2026-01-01',NULL,80,100),(303,61,19,4,'2026-01-01',NULL,90,150),(304,80,19,2,'2026-01-01',NULL,150,250),(305,124,19,3,'2026-01-01',NULL,700,1000),(306,99,19,112,'2026-01-01',NULL,10,15),(307,87,19,3,'2026-01-01',NULL,950,1200),(308,85,19,4,'2026-01-01',NULL,950,1200),(309,88,19,3,'2026-01-01',NULL,850,1200),(310,150,19,2,'2026-01-01',NULL,1500,2000),(311,183,19,1,'2026-01-01',NULL,6500,9000),(312,98,19,200,'2026-01-01',NULL,10,15),(313,172,19,4,'2026-01-01',NULL,850,1200),(314,172,19,5,'2026-01-01',NULL,850,1200),(315,171,19,3,'2026-01-01',NULL,850,1200),(316,89,19,1,'2026-01-01',NULL,850,1200),(317,46,19,2,'2026-01-01',NULL,3200,4000),(318,193,19,1,'2026-01-01',NULL,400,600),(319,194,19,1,'2026-01-01',NULL,950,1200),(320,193,7,4,'2026-01-03',NULL,325,500),(321,99,7,100,'2026-01-03',NULL,4,10),(322,93,7,1,'2026-01-03',NULL,2400,3200),(323,93,7,1,'2026-01-03',NULL,2400,3200),(324,92,7,1,'2026-01-03',NULL,3200,5200),(325,185,7,1,'2026-01-03',NULL,2400,5800),(326,27,19,2,'2026-01-03',NULL,1100,1950),(327,133,20,5,'2025-12-27',NULL,1050,1950),(328,195,10,5,'2026-01-21',NULL,4450,5200),(329,72,10,12,'2026-01-21',NULL,295,360),(330,73,10,2,'2026-01-21',NULL,395,460),(331,75,10,2,'2026-01-21',NULL,395,460),(332,172,7,5,'2026-01-26',NULL,750,1750),(333,90,7,5,'2026-01-26',NULL,750,1750),(334,197,21,10,'2026-02-02',NULL,1000,1000);
/*!40000 ALTER TABLE `update_inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `watchlist`
--

DROP TABLE IF EXISTS `watchlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `watchlist` (
  `name` varchar(30) DEFAULT NULL,
  `buckets` varchar(100) DEFAULT NULL,
  `count` int DEFAULT NULL,
  `script` varchar(10) DEFAULT NULL,
  `script_name` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `watchlist`
--

LOCK TABLES `watchlist` WRITE;
/*!40000 ALTER TABLE `watchlist` DISABLE KEYS */;
/*!40000 ALTER TABLE `watchlist` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-02-03  4:14:00
