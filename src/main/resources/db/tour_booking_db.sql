-- MySQL dump 10.13  Distrib 8.4.8, for macos15 (arm64)
--
-- Host: localhost    Database: tour_booking_db
-- ------------------------------------------------------
-- Server version	8.4.8
USE tour_booking_db;
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
-- Table structure for table `accounts`
--

DROP TABLE IF EXISTS `accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `full_name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `role` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts`
--

LOCK TABLES `accounts` WRITE;
/*!40000 ALTER TABLE `accounts` DISABLE KEYS */;
INSERT INTO `accounts` VALUES (1,'Admin','admin@tuanvivu.com','admin','0909090909','ADMIN','active'),(2,'nguyen anh nam','nguyenanhtuank28@gmail.com','Anhtuan28112005#','0334523524','user','active'),(3,'Nguyen văn a','nguyenanhtuank11@gmail.com','Anhtuan28112005#','044454545','user','active'),(4,'Nguỹen van a','Nguyenanhtuan@gmail.com','$2a$10$/eRTrSjZ3IQIMe4HVCviJOb2ame.919Bc/OGaayiBuQ6AZQilvbsG','03345454','user','active'),(5,'Nguyễn văn nam','anhtuan@gmail.com','$2a$10$U6dVp/7DMrT9QY62UZ3RGu1Fj4IvH7UzB67Xqo42ZVj2A2O3Sa2b.','0345673128','user','active'),(6,'Vũ văn nam','nguyenanhtuank28hh@gmail.com','$2a$10$6kTO8RyXT2/RNVVlsAg9x.WmNyyPqMN8GhMatwwQMZtwc8tiEXTJ.','0345673127','user','active'),(7,'Nguyễn văn nam','NguyenNam@gmail.com','$2a$10$om/pLCtqr7vM5qe1EpIukuca2/KTIKAt0P8inAHzl5j2mKd39AgxK','0345435346','user','active'),(8,'NguyenVanNam','nguyenanhtuank2855@gmail.com','$2a$10$mu/X5pmj4iG7O4m277BtJOpLeekTJgE8Q7L/EnBvXyM5FkhMqoceC','0333333333','user','active'),(9,'Nguyễn Anh Tuấn','nguyenanhtuank18gmail.com','$2a$10$NHsFLlgubQmsZP6DpJjV.eOHjZhV4Z4WTMTcXNakhezKWvVedmjSG','0231242342','user','active'),(10,'Nguyễn Anh Tuấn','nguyenanhtuank28gmail.com','$2a$10$3MrEPzSdhl5Ernhif/zcIOJyM7t7.npx3HXNLvZiYbOHtqWQDwNZq','0334545433','user','active');
/*!40000 ALTER TABLE `accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `order_code` varchar(255) DEFAULT NULL,
  `account_id` bigint DEFAULT NULL,
  `tour_id` bigint DEFAULT NULL,
  `full_name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `adult_tickets` int DEFAULT NULL,
  `children_tickets` int DEFAULT NULL,
  `payment_method` varchar(255) DEFAULT NULL,
  `special_request` text,
  `status` varchar(255) DEFAULT NULL,
  `sub_total` double DEFAULT NULL,
  `discount_amount` double DEFAULT NULL,
  `total` double DEFAULT NULL,
  `promo_code` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_code` (`order_code`),
  KEY `account_id` (`account_id`),
  KEY `tour_id` (`tour_id`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`),
  CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`tour_id`) REFERENCES `tours` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,'ORD-7B56B403',1,2,'54-Nguyễn Anh Tuấn','admin@tuanvivu.com','0345673128',1,0,'Thanh toán tại văn phòng','','CONFIRMED',4500000,0,4500000,NULL),(2,'ORD-5ABDC5D1',1,2,'54-Nguyễn Anh Tuấn','nguyenanhtuank28@gmail.com','0345673128',1,0,'Thanh toán Momo','','PENDING',4500000,0,4500000,NULL),(3,'ORD-35AF9CCD',4,10,'54-Nguyễn Anh Tuấn','nguyenanhtuank28@gmail.com','0345673128',1,0,'Thanh toán Momo','','PENDING',6500000,0,6500000,NULL),(4,'ORD-057C570C',2,10,'54-Nguyễn Anh Tuấn','nguyenanhtuank28@gmail.com','0345673128',1,0,'Thanh toán qua Stripe (Visa/MasterCard)','','PENDING',6500000,0,6500000,NULL),(5,'ORD-DF475CBD',2,5,'54-Nguyễn Anh Tuấn','nguyenanhtuank28@gmail.com','0345673128',1,0,'Thanh toán qua Stripe (Visa/MasterCard)','','PENDING',3800000,0,3800000,''),(6,'ORD-EC626E59',2,5,'54-Nguyễn Anh Tuấn','nguyenanhtuank28@gmail.com','0345673128',1,0,'Thanh toán Momo','','PENDING',3800000,0,3800000,''),(7,'ORD-423BC797',2,6,'54-Nguyễn Anh Tuấn','nguyenanhtuank28@gmail.com','0345673128',1,0,'Thanh toán qua Stripe (Visa/MasterCard)','','PENDING',25000000,0,25000000,''),(8,'ORD-C4B56033',2,6,'54-Nguyễn Anh Tuấn','nguyenanhtuank28@gmail.com','0345673128',1,0,'Chuyển khoản ngân hàng','','PENDING',25000000,0,25000000,''),(9,'ORD-E97F3952',2,6,'54-Nguyễn Anh Tuấn','nguyenanhtuank28@gmail.com','0345673128',1,0,'Thanh toán qua Stripe (Visa/MasterCard)','','PAID',25000000,0,25000000,''),(10,'ORD-737A7106',2,7,'54-Nguyễn Anh Tuấn','nguyenanhtuank28@gmail.com','0345673128',1,0,'Thanh toán qua Stripe (Visa/MasterCard)','','PENDING',4200000,0,4200000,''),(11,'ORD-248A903A',2,7,'54-Nguyễn Anh Tuấn','nguyenanhtuank28@gmail.com','0345673128',1,0,'Thanh toán Momo','','PENDING',4200000,0,4200000,''),(12,'ORD-85590519',1,10,'Nguyễn Anh Tuấn','nguyenanhtuank28@gmail.com','0333333333',1,0,'Chuyển khoản ngân hàng','','PENDING',6500000,0,6500000,''),(13,'ORD-AF95554F',1,10,'Nguyễn Anh Tuấn','nguyenanhtuank28@gmail.com','0333333333',1,0,'Chuyển khoản ngân hàng','','PENDING',6500000,0,6500000,''),(14,'ORD-BB9DB69D',1,10,'Nguyễn Anh Tuấn','nguyenanhtuank28@gmail.com','0333333333',1,0,'Chuyển khoản ngân hàng','','PENDING',6500000,0,6500000,''),(15,'ORD-CE42A9BD',1,10,'Nguyễn Anh Tuấn','nguyenanhtuank28@gmail.com','0333333333',1,0,'Chuyển khoản ngân hàng','','PENDING',6500000,0,6500000,''),(16,'ORD-8885195C',4,10,'Nguyễn văn nam','NguyenAnhTuan@gmail.com','0345435346',1,0,'Chuyển khoản ngân hàng','','PENDING',6500000,1300000,5200000,'SUMMER20'),(17,'ORD-9EF7CC3A',4,10,'Nguyễn văn nam','NguyenAnhTuan@gmail.com','0345435346',1,0,'Chuyển khoản ngân hàng','','PENDING',6500000,1300000,5200000,'SUMMER20'),(18,'ORD-78573516',1,10,'Nguyễn Anh Tuấn','nguyenanhtuank28@gmail.com','0333333333',1,0,'Thanh toán qua Stripe (Visa/MasterCard)','','PAID',6500000,0,6500000,''),(19,'ORD-E160FA18',1,10,'Nguyễn Anh Tuấn','nguyenanhtuank28@gmail.com','0333333333',1,0,'Thanh toán qua Stripe (Visa/MasterCard)','','PAID',6500000,0,6500000,''),(20,'ORD-12D1DD48',1,10,'Nguyễn Anh Tuấn','nguyenanhtuank28@gmail.com','0333333333',1,0,'Thanh toán qua Stripe (Visa/MasterCard)','','PAID',6500000,0,6500000,''),(21,'ORD-7E32A546',1,10,'Nguyễn Anh Tuấn','nguyenanhtuank28@gmail.com','0333333333',1,0,'Thanh toán qua Stripe (Visa/MasterCard)','','PENDING',6500000,0,6500000,''),(22,'ORD-BA63C82C',1,10,'Nguyễn Anh Tuấn','nguyenanhtuank28@gmail.com','0333333333',1,0,'Thanh toán Momo','','PENDING',6500000,0,6500000,'EXPIRED99'),(23,'ORD-D214732D',1,10,'Nguyễn Anh Tuấn','nguyenanhtuank28@gmail.com','0333333333',1,0,'Thanh toán qua Stripe (Visa/MasterCard)','','PENDING',6500000,0,6500000,''),(24,'ORD-BA601A93',1,10,'Nguyễn Anh Tuấn','nguyenanhtuank28@gmail.com','0333333333',1,0,'Thanh toán qua Stripe (Visa/MasterCard)','','PAID',6500000,0,6500000,''),(25,'ORD-AE781566',4,10,'Nguyễn văn nam','NguyenAnhTuan@gmail.com','0345435346',1,0,'Thanh toán qua Stripe (Visa/MasterCard)','','PAID',6500000,1300000,5200000,'SUMMER20'),(26,'ORD-49665E5D',4,10,'Nguyen Van A','nguyenanhtuank18@gmail.com','0345673128',1,0,'Thanh toán qua Stripe (Visa/MasterCard)','','PAID',6500000,0,6500000,''),(27,'ORD-76B60227',4,10,'Nguyen Van A','nguyenanhtuank18@gmail.com','0345673128',1,0,'Thanh toán qua Stripe (Visa/MasterCard)','','PAID',6500000,0,6500000,''),(28,'ORD-31D5945F',4,10,'Nguyen Van A','nguyenanhtuank18@gmail.com','0345673128',1,0,'Thanh toán qua Stripe (Visa/MasterCard)','','PAID',6500000,0,6500000,''),(29,'ORD-B38E1789',4,10,'Nguyen Van A','nguyenanhtuank18@gmail.com','0345673128',1,0,'Thanh toán qua Stripe (Visa/MasterCard)','','PENDING',6500000,0,6500000,''),(30,'ORD-96B86C8D',4,10,'Nguyen Van A','nguyenanhtuank18@gmail.com','0345673128',1,0,'Thanh toán qua Stripe (Visa/MasterCard)','','PAID',6500000,0,6500000,''),(31,'ORD-0982C49A',4,10,'Nguyen Van A','nguyenanhtuank18@gmail.com','0345673128',1,0,'Thanh toán qua Stripe (Visa/MasterCard)','','PAID',6500000,0,6500000,''),(32,'ORD-4C3EFF48',4,10,'Nguyen Van A','nguyenanhtuank18@gmail.com','0345673128',1,0,'Thanh toán qua Stripe (Visa/MasterCard)','','PENDING',6500000,0,6500000,''),(33,'ORD-6C88A71D',4,10,'Nguyen Van A','nguyenanhtuank18@gmail.com','0345673128',1,0,'Thanh toán qua Stripe (Visa/MasterCard)','','PAID',6500000,0,6500000,''),(34,'ORD-9F725B12',1,10,'Nguyễn Anh Tuấn','nguyenanhtuank28@gmail.com','0333333333',1,0,'Chuyển khoản ngân hàng','','PENDING',6500000,0,6500000,''),(35,'ORD-A51DFEAA',4,10,'Nguyen Van A','nguyenanhtuank18@gmail.com','0345673128',1,0,'Chuyển khoản ngân hàng','','PENDING',6500000,0,6500000,''),(36,'ORD-7FD36D0C',4,10,'Nguyen Van A','nguyenanhtuank18@gmail.com','0345673128',1,0,'Chuyển khoản ngân hàng','','PENDING',6500000,0,6500000,''),(37,'ORD-0CEEF34F',4,10,'Nguyen A','nguyenanhtuank18@gmail.com','0345673128',1,0,'Thanh toán qua Stripe (Visa/MasterCard)','','PENDING',6500000,0,6500000,''),(38,'ORD-C2F11293',4,10,'Nguyen A','nguyenanhtuank18@gmail.com','0345673128',1,0,'Thanh toán qua Stripe (Visa/MasterCard)','','PENDING',6500000,0,6500000,''),(39,'ORD-AE17C004',4,10,'Nguyen A','nguyenanhtuank18@gmail.com','0345673128',1,0,'Thanh toán qua Stripe (Visa/MasterCard)','','PENDING',6500000,0,6500000,''),(40,'ORD-2375D8B9',4,10,'Nguyen A','nguyenanhtuank18@gmail.com','0345673128',1,0,'Thanh toán qua Stripe (Visa/MasterCard)','','PENDING',6500000,0,6500000,''),(41,'ORD-1D2BAB59',4,10,'Nguyen A','nguyenanhtuank18@gmail.com','0345673128',1,0,'Thanh toán qua Stripe (Visa/MasterCard)','','PENDING',6500000,0,6500000,''),(42,'ORD-B02BCE68',4,10,'Nguyen A','nguyenanhtuank18@gmail.com','0345673128',1,0,'Thanh toán qua Stripe (Visa/MasterCard)','','PENDING',6500000,0,6500000,''),(43,'ORD-473F5C5B',4,10,'Nguyen A','nguyenanhtuank18@gmail.com','0345673128',1,0,'Thanh toán qua Stripe (Visa/MasterCard)','','PENDING',6500000,0,6500000,''),(44,'ORD-650C9924',4,10,'Nguyen A','nguyenanhtuank18@gmail.com','0345673128',1,0,'Thanh toán qua Stripe (Visa/MasterCard)','','PENDING',6500000,0,6500000,''),(45,'ORD-690BF76C',4,10,'Nguyen A','nguyenanhtuank18@gmail.com','0345673128',1,0,'Thanh toán qua Stripe (Visa/MasterCard)','','PENDING',6500000,0,6500000,''),(46,'ORD-6C78A6A0',4,10,'Nguyen A','nguyenanhtuank18@gmail.com','0345673128',1,0,'Thanh toán qua Stripe (Visa/MasterCard)','','PENDING',6500000,0,6500000,''),(47,'ORD-81E9238F',4,10,'Nguyen A','nguyenanhtuank18@gmail.com','0345673128',1,0,'Thanh toán qua Stripe (Visa/MasterCard)','','PENDING',6500000,0,6500000,''),(48,'ORD-4D3DA8B3',4,10,'Nguyen A','nguyenanhtuank18@gmail.com','0345673128',1,0,'Thanh toán qua Stripe (Visa/MasterCard)','','PENDING',6500000,0,6500000,''),(49,'ORD-65EFA4C4',4,10,'Nguyen A','nguyenanhtuank18@gmail.com','0345673128',1,0,'Thanh toán qua Stripe (Visa/MasterCard)','','PENDING',6500000,0,6500000,''),(50,'ORD-D59411A0',4,10,'Nguyen A','nguyenanhtuank18@gmail.com','0345673128',1,0,'Thanh toán qua Stripe (Visa/MasterCard)','','PENDING',6500000,0,6500000,''),(51,'ORD-E5B48D1F',4,10,'Nguyen A','nguyenanhtuank18@gmail.com','0345673128',1,0,'Thanh toán qua Stripe (Visa/MasterCard)','','PENDING',6500000,0,6500000,''),(52,'ORD-FE20DC7F',4,10,'Nguyen A','nguyenanhtuank18@gmail.com','0345673128',1,0,'Thanh toán qua Stripe (Visa/MasterCard)','','PENDING',6500000,0,6500000,''),(53,'ORD-30AF0FB6',4,10,'Nguyen A','nguyenanhtuank18@gmail.com','0345673128',1,0,'Thanh toán qua Stripe (Visa/MasterCard)','','PENDING',6500000,0,6500000,''),(54,'ORD-8DC403AA',4,10,'Nguyen A','nguyenanhtuank18@gmail.com','0345673128',1,0,'Thanh toán qua Stripe (Visa/MasterCard)','','PENDING',6500000,0,6500000,''),(55,'ORD-25BBFA3E',4,10,'Nguyen A','nguyenanhtuank18@gmail.com','0345673128',1,0,'Thanh toán qua Stripe (Visa/MasterCard)','','PENDING',6500000,0,6500000,''),(56,'ORD-7AEEDD01',4,10,'Nguyen A','nguyenanhtuank18@gmail.com','0345673128',1,0,'Thanh toán qua Stripe (Visa/MasterCard)','','PENDING',6500000,0,6500000,''),(57,'ORD-BFEAFD80',4,10,'Nguyen A','nguyenanhtuank18@gmail.com','0345673128',1,0,'Thanh toán qua Stripe (Visa/MasterCard)','','PAID',6500000,0,6500000,''),(58,'ORD-C41B3CB2',4,10,'Nguyen A','nguyenanhtuank18@gmail.com','0345673128',1,0,'Thanh toán qua Stripe (Visa/MasterCard)','','PAID',6500000,0,6500000,''),(59,'ORD-C197919B',4,10,'nguuyen a','nguyenanhtuank18@gmail.com','0345673128',1,0,'Thanh toán qua Stripe (Visa/MasterCard)','','PENDING',6500000,0,6500000,''),(60,'ORD-8CF4F04E',4,10,'nguuyen a','nguyenanhtuank18@gmail.com','0345673128',1,0,'Thanh toán qua Stripe (Visa/MasterCard)','','PENDING',6500000,0,6500000,''),(61,'ORD-1DDB94A3',4,10,'nguuyen a','nguyenanhtuank18@gmail.com','0345673128',1,0,'Thanh toán qua Stripe (Visa/MasterCard)','','PENDING',6500000,0,6500000,''),(62,'ORD-EF783AF3',4,10,'nguuyen a','nguyenanhtuank18@gmail.com','0345673128',1,0,'Thanh toán tại văn phòng','','PENDING',6500000,1300000,5200000,'SUMMER20'),(63,'ORD-F6EF732D',4,10,'nguuyen a','nguyenanhtuank18@gmail.com','0345673128',1,0,'Thanh toán tại văn phòng','','PENDING',6500000,1300000,5200000,'SUMMER20'),(64,'ORD-BD8AB883',4,10,'nguuyen a','nguyenanhtuank18@gmail.com','0345673128',1,0,'Thanh toán tại văn phòng','','PENDING',6500000,1300000,5200000,'SUMMER20'),(65,'ORD-2B2453E5',4,10,'nguuyen a','nguyenanhtuank18@gmail.com','0345673128',1,0,'Thanh toán qua Stripe (Visa/MasterCard)','','PENDING',6500000,1300000,5200000,'SUMMER20'),(66,'ORD-31139407',4,10,'nguuyen a','nguyenanhtuank18@gmail.com','0345673128',1,0,'Thanh toán qua Stripe (Visa/MasterCard)','','PENDING',6500000,1300000,5200000,'SUMMER20'),(67,'ORD-043EF917',4,10,'nguuyen a','nguyenanhtuank18@gmail.com','0345673128',1,0,'Thanh toán tại văn phòng','','PENDING',6500000,1300000,5200000,'SUMMER20'),(68,'ORD-3306EBFA',4,10,'nguuyen a','nguyenanhtuank18@gmail.com','0345673128',1,0,'Thanh toán qua Stripe (Visa/MasterCard)','','PAID',6500000,1300000,5200000,'SUMMER20'),(69,'ORD-52854AF5',4,10,'nguuyen a','nguyenanhtuank18@gmail.com','0345673128',1,0,'Thanh toán qua Stripe (Visa/MasterCard)','','PAID',6500000,1300000,5200000,'SUMMER20'),(70,'ORD-75764335',4,10,'nguuyen a','nguyenanhtuank18@gmail.com','0345673128',1,0,'Thanh toán qua Stripe (Visa/MasterCard)','','PENDING',6500000,1300000,5200000,'SUMMER20'),(71,'ORD-3F555667',4,10,'nguuyen a','nguyenanhtuank18@gmail.com','0345673128',1,0,'Thanh toán qua Stripe (Visa/MasterCard)','','PAID',6500000,1300000,5200000,'SUMMER20'),(72,'ORD-1000F413',4,10,'nguuyen a','nguyenanhtuank18@gmail.com','0345673128',1,0,'Thanh toán qua Stripe (Visa/MasterCard)','','PAID',6500000,1300000,5200000,'SUMMER20'),(73,'ORD-BFB706A4',4,11,'Nguyen A','nguyenanhtuank18@gmail.com','0345673128',1,1,'Thanh toán tại văn phòng','','PENDING',24,0,24,''),(74,'ORD-46D6E98F',4,11,'Nguyen A','nguyenanhtuank18@gmail.com','0345673128',1,1,'Thanh toán tại văn phòng','','PENDING',24,0,24,''),(75,'ORD-FE1DF3FB',4,11,'Nguyen A','nguyenanhtuank18@gmail.com','0345673128',1,1,'Thanh toán tại văn phòng','','PENDING',24,0,24,''),(76,'ORD-3C512C30',4,10,'nguuyen a','nguyenanhtuank18@gmail.com','03456731288',1,10,'Thanh toán Momo','','PENDING',51500000,15450000,36050000,'SUMMER20');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tours`
--

DROP TABLE IF EXISTS `tours`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tours` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `category` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `price_adult` double DEFAULT NULL,
  `price_children` double DEFAULT NULL,
  `stock_adult` int DEFAULT NULL,
  `stock_children` int DEFAULT NULL,
  `departure_date` date DEFAULT NULL,
  `destination` varchar(255) DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `itinerary` text,
  `included_services` text,
  `excluded_services` text,
  `cancellation_policy` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tours`
--

LOCK TABLES `tours` WRITE;
/*!40000 ALTER TABLE `tours` DISABLE KEYS */;
INSERT INTO `tours` VALUES (1,'Nha Trang Biển Gọi','Biển','Active',5000000,3000000,20,10,'2026-08-27','Khánh Hòa','https://res.cloudinary.com/dk4hfh4un/image/upload/v1786089943/tour-booking/br7nfpfrtrshsbf0hvjr.jpg','Ngày 1: Đón khách tại sân bay Cam Ranh.\r\nNgày 2: Tham quan Vinpearl Land.\r\nNgày 3: Tắm bùn Tháp Bà và tiễn khách.','Vé máy bay khứ hồi\r\nKhách sạn 4 sao\r\nĂn sáng Buffet','Tip cho HDV\r\nChi phí cá nhân','Hủy trước 7 ngày miễn phí.'),(2,'Đà Lạt Mộng Mơ','Núi','Active',4500000,2500000,15,5,'2026-08-15','Lâm Đồng','https://res.cloudinary.com/dk4hfh4un/image/upload/v1786089988/tour-booking/r3a3sbv09omu9rohzoul.jpg','Ngày 1: Tham quan Ga Đà Lạt.\r\nNgày 2: Chinh phục đỉnh Langbiang.\r\nNgày 3: Mua sắm chợ Đà Lạt.','Xe giường nằm VIP\r\nKhách sạn trung tâm\r\nCác bữa ăn theo chương trình','Thuế VAT\r\nChi phí giặt ủi','Hủy trước 5 ngày: Phí 50%'),(3,'Hạ Long Bay Nghỉ Dưỡng','Nghỉ dưỡng','Active',6000000,4000000,30,15,'2026-07-15','Quảng Ninh','https://images.unsplash.com/photo-1528181304800-259b08848526?q=80&w=800','Ngày 1: Nhận phòng Du thuyền 5 sao.\nNgày 2: Khám phá hang Sửng Sốt.\nNgày 3: Chèo thuyền Kayak và về lại bờ.','Phòng Suite trên Du thuyền\nĂn hải sản cao cấp\nHướng dẫn viên nhiệt tình','Đồ uống có cồn\nChi phí không có trong mục bao gồm','Hủy trước 10 ngày miễn phí.'),(4,'Phú Quốc - Thiên Đường Đảo Ngọc','Biển','Active',5500000,3500000,30,15,'2026-08-08','Phú Quốc','https://res.cloudinary.com/dk4hfh4un/image/upload/v1786090214/tour-booking/wzsj136xtwmwqvc5zuvk.webp','Ngày 1: \r\nSáng: Xe đón quý khách tại sân bay Phú Quốc, nhận phòng Resort 5 sao ven biển.\r\nTrưa: Thưởng thức gỏi cá trích đặc sản tại nhà hàng Hàm Ninh.\r\nChiều: Tự do tắm biển, thư giãn tại hồ bơi vô cực.\r\nTối: Dùng tiệc nướng hải sản ngắm hoàng hôn trên bãi biển.\r\n\r\nNgày 2: \r\nSáng: Khám phá VinWonders và công viên bảo tồn Safari.\r\nTrưa: Ăn buffet Á-Âu tại công viên.\r\nChiều: Lặn ngắm san hô tại Hòn Thơm.\r\nTối: Đi dạo chợ đêm Dinh Cậu, tự do khám phá ẩm thực đường phố.\r\n\r\nNgày 3: \r\nSáng: Tham quan nhà thùng nước mắm và cơ sở nuôi cấy ngọc trai.\r\nTrưa: Trả phòng, xe đưa đoàn ra sân bay. Kết thúc hành trình.','Vé máy bay khứ hồi\r\nResort 5 sao (2 người/phòng)\r\nVé VinWonders & Safari\r\nCác bữa ăn theo chương trình','Chi phí mua sắm cá nhân\r\nĐồ uống ngoài menu','Hủy trước 10 ngày: Miễn phí.\r\nHủy trước 5 ngày: Phí 50%.\r\nHủy trong 24h: Phí 100%.'),(5,'Sapa - Chinh Phục Đỉnh Fansipan','Núi','Active',3800000,2000000,25,10,'2026-08-14','Lào Cai','https://res.cloudinary.com/dk4hfh4un/image/upload/v1786090256/tour-booking/mhswojtvhlmok3au96nx.jpg','Ngày 1: \r\nSáng: Khởi hành từ Hà Nội đi Sapa bằng xe giường nằm cao cấp.\r\nTrưa: Đến Sapa, nhận phòng khách sạn View Thung lũng.\r\nChiều: Đi bộ thăm bản Cát Cát, tìm hiểu đời sống người H\'Mông.\r\nTối: Ăn lẩu cá hồi đặc sản, dạo quanh nhà thờ đá Sapa trong sương mù.\r\n\r\nNgày 2: \r\nSáng: Trải nghiệm cáp treo chinh phục \"Nóc nhà Đông Dương\" - Đỉnh Fansipan.\r\nTrưa: Dùng bữa trên nhà hàng tại đỉnh núi.\r\nChiều: Trở về trung tâm, tự do mua sắm đặc sản và ngâm chân thuốc lá người Dao.\r\nTối: Tự do thưởng thức đồ nướng Sapa.\r\n\r\nNgày 3: \r\nSáng: Check-in tại đèo Ô Quy Hồ - Một trong tứ đại đỉnh đèo.\r\nTrưa: Ăn trưa, trả phòng và lên xe trở về Hà Nội.','Xe giường nằm khứ hồi HN-Sapa\r\nKhách sạn 4 sao\r\nVé cáp treo Fansipan\r\nHDV bản địa','Thuế VAT\r\nTiền tip cho HDV (không bắt buộc)','Hủy trước 7 ngày: Phí 20%.\r\nHủy trước 3 ngày: Phí 100%.'),(6,'Thiên Đường Maldives - Giấc Mơ Tình Yêu','Nghỉ dưỡng','Active',25000000,15000000,15,5,'2026-10-10','Maldives','https://images.unsplash.com/photo-1514282401047-d79a71a590e8?q=80&w=800','Ngày 1: \nSáng: Bay từ Việt Nam sang thủ đô Male (quá cảnh Singapore).\nTrưa: Di chuyển bằng Thủy phi cơ về Resort Water Villa.\nChiều: Nhận phòng Villa trên biển, tự do bơi lội ngắm cá đuối.\nTối: Bữa tối lãng mạn dưới ánh nến và rượu vang bên bờ biển.\n\nNgày 2: \nSáng: Thức dậy đón bình minh trên biển Ấn Độ Dương. Ăn sáng nổi (Floating Breakfast) tại hồ bơi.\nTrưa: Trải nghiệm lặn biển Scuba Diving ngắm rạn san hô.\nChiều: Trải nghiệm Spa phong cách Maldives.\nTối: Tham gia bữa tiệc âm nhạc tại quầy Bar của Resort.\n\nNgày 3: \nSáng: Tự do chèo Kayak trong vắt.\nTrưa: Ăn trưa tại nhà hàng dưới đại dương (Undersea Restaurant).\nChiều: Lên tàu cao tốc ra sân bay Male.\nTối: Chuyến bay đêm đưa quý khách trở về Việt Nam.','Vé máy bay quốc tế khứ hồi\nResort Water Villa 5 sao\nThủy phi cơ di chuyển\nBảo hiểm du lịch toàn cầu','Các dịch vụ Spa tự chọn\nChi phí Visa (nếu có)','Hủy trước 30 ngày: Phí 10%.\nHủy trước 15 ngày: Phí 50%.\nKhông hoàn tiền nếu hủy sát ngày.'),(7,'Hội An - Đà Nẵng: Hành Trình Di Sản','Khám phá','Active',4200000,2500000,35,20,'2026-08-20','Đà Nẵng','https://images.unsplash.com/photo-1559592413-7cec4d0cae2b?q=80&w=800','Ngày 1: \nSáng: Đón khách tại Đà Nẵng, tham quan Bán đảo Sơn Trà và Chùa Linh Ứng.\nTrưa: Thưởng thức Mỳ Quảng ếch đặc sản.\nChiều: Về khách sạn nghỉ ngơi, tắm biển Mỹ Khê.\nTối: Tham quan Phố cổ Hội An rực rỡ đèn lồng, đi thuyền thả hoa đăng trên sông Hoài.\n\nNgày 2: \nSáng: Khởi hành lên Bà Nà Hills, dạo bước trên Cầu Vàng huyền thoại.\nTrưa: Ăn buffet tại Làng Pháp trên đỉnh Bà Nà.\nChiều: Vui chơi tại Fantasy Park.\nTối: Trở về Đà Nẵng, ngồi du thuyền sông Hàn ngắm cầu Rồng phun lửa.\n\nNgày 3: \nSáng: Tham quan Ngũ Hành Sơn, làng đá mỹ nghệ Non Nước.\nTrưa: Trả phòng, dùng bữa trưa hải sản ven biển.\nChiều: Mua sắm đặc sản Chợ Hàn. Tiễn khách ra sân bay.','Xe du lịch đời mới\nKhách sạn 4 sao mặt biển\nVé cáp treo Bà Nà\nĂn uống theo lịch trình','Vé vui chơi các trò có thưởng\nNước uống gọi riêng trong bữa ăn','Miễn phí hủy trước 7 ngày.'),(8,'Bali - Hòn Đảo Của Những Vị Thần','Khám phá','Active',12500000,8000000,20,10,'2026-11-05','Indonesia','https://images.unsplash.com/photo-1537996194471-e657df975ab4?q=80&w=800','Ngày 1: \nSáng: Chuyến bay thẳng từ VN đến sân bay Ngurah Rai (Bali).\nTrưa: Nhận vòng hoa chào mừng, di chuyển về khu Ubud.\nChiều: Nhận phòng resort giữa rừng nhiệt đới.\nTối: Ăn tối với các điệu múa truyền thống Barong của người Bali.\n\nNgày 2: \nSáng: Khám phá Ruộng bậc thang Tegalalang và trải nghiệm Bali Swing (Xích đu tử thần).\nTrưa: Ăn trưa món Vịt chiên giòn Bebek Bengil.\nChiều: Thăm đền Suối thiêng Tirta Empul, làm lễ thanh tẩy.\nTối: Tự do dạo chơi thị trấn Ubud về đêm.\n\nNgày 3: \nSáng: Khởi hành đi bãi biển Kuta.\nTrưa: Ăn trưa ven biển.\nChiều: Ngắm hoàng hôn tuyệt đẹp tại đền Tanah Lot nằm chơ vơ giữa đại dương.\nTối: Thưởng thức hải sản Jimbaran.\n\nNgày 4: \nSáng: Tự do mua sắm quà lưu niệm.\nTrưa: Ra sân bay, kết thúc hành trình khám phá Bali.','Vé máy bay khứ hồi (Baggage 20kg)\nResort 4 sao tại Ubud & Kuta\nVé tham quan các đền đài\nHDV tiếng Việt','Phí Bali Swing (tự túc theo nhu cầu)\nTiền bồi dưỡng HDV địa phương','Hủy trước 20 ngày: Mất cọc 30%.\nHủy trước 10 ngày: Mất 100%.'),(9,'Quy Nhơn - Phú Yên: Hoa Vàng Cỏ Xanh','Biển','Active',3500000,2000000,40,15,'2026-08-22','Bình Định','https://res.cloudinary.com/dk4hfh4un/image/upload/v1786090303/tour-booking/aoa7xpq4hieqngrhv5gc.webp','Ngày 1: \r\nSáng: Đón đoàn tại sân bay Phù Cát. Thăm quan Tháp Đôi kiến trúc Chăm pa.\r\nTrưa: Thưởng thức Bún chả cá Quy Nhơn.\r\nChiều: Tự do tắm biển tại bãi biển trung tâm hình vầng trăng khuyết.\r\nTối: Ăn tối hải sản đường Xuân Diệu.\r\n\r\nNgày 2: \r\nSáng: Đi cano siêu tốc ra đảo Kỳ Co - Maldives thu nhỏ của Việt Nam.\r\nTrưa: Ăn trưa hải sản trên bè nổi.\r\nChiều: Khám phá Eo Gió - nơi ngắm hoàng hôn đẹp nhất Việt Nam.\r\nTối: Trở về khách sạn nghỉ ngơi, đi dạo quảng trường Nguyễn Tất Thành.\r\n\r\nNgày 3: \r\nSáng: Di chuyển sang Phú Yên, tham quan Gành Đá Đĩa - di sản địa chất độc đáo.\r\nTrưa: Ăn trưa tại đầm Ô Loan với món Sò huyết nức tiếng.\r\nChiều: Check-in Bãi Xép - phân cảnh phim \"Tôi thấy hoa vàng trên cỏ xanh\".\r\nTối: Trở về Quy Nhơn, chuẩn bị ra sân bay.','Xe đón tiễn suốt tuyến\r\nKhách sạn 3 sao view biển\r\nCano ra đảo Kỳ Co\r\nBảo hiểm du lịch','Các trò chơi thể thao nước\r\nĂn uống ngoài chương trình','Hủy trước 5 ngày: Miễn phí.'),(10,'Thái Lan - Xứ Sở Chùa Vàng','Khám phá','Active',6500000,4500000,30,10,'2026-08-30','Bangkok','https://images.unsplash.com/photo-1508009603885-50cf7c579365?q=80&w=800','Ngày 1: \nSáng: Tập trung tại sân bay Tân Sơn Nhất, làm thủ tục đi Bangkok.\nTrưa: Tới nơi, ăn trưa nhẹ. Khởi hành đi thành phố biển Pattaya.\nChiều: Tự do tắm biển Pattaya.\nTối: Thưởng thức BBQ Buffet Thái. Tự do xem show Alcazar (tự túc).\n\nNgày 2: \nSáng: Đi tàu cao tốc ra Đảo San Hô (Coral Island).\nTrưa: Trở về đất liền ăn trưa.\nChiều: Tham quan Trân Bảo Phật Sơn, Chợ nổi Bốn miền.\nTối: Trải nghiệm Massage Thái truyền thống 60 phút.\n\nNgày 3: \nSáng: Rời Pattaya về lại Bangkok, ghé trung tâm Vàng Bạc Đá Quý hoàng gia.\nTrưa: Ăn trưa lẩu Suki.\nChiều: Viếng chùa Thuyền Wat Yannawa, dạo thuyền trên sông Chao Phraya.\nTối: Mua sắm tự do tại Icon Siam hoặc Central World.\n\nNgày 4: \nSáng: Dâng hương tại Tượng Phật Bốn Mặt linh thiêng.\nTrưa: Dùng bữa trưa, ra sân bay bay về Việt Nam.','Vé máy bay khứ hồi khứ hồi\nKhách sạn 4 sao\nMassage Thái 1 giờ\nHDV tiếng Việt theo suốt tuyến','Tiền Tip 4$/ngày/người\nCác show diễn ngoài lịch trình','Hủy trước 15 ngày: Phí 20%.'),(11,'test','ư','Inactive',12,12,1,1,'2026-08-08','t','','','','','');
/*!40000 ALTER TABLE `tours` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-08-07 15:12:50
