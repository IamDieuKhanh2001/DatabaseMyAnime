-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: localhost    Database: hcmutemyanime
-- ------------------------------------------------------
-- Server version	8.0.32

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `attempt_logs`
--

DROP TABLE IF EXISTS `attempt_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `attempt_logs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `attempt_type` varchar(255) DEFAULT NULL,
  `create_at` datetime DEFAULT NULL,
  `ip_address` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `create_at` datetime DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `category_movie`
--

DROP TABLE IF EXISTS `category_movie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category_movie` (
  `id` int NOT NULL AUTO_INCREMENT,
  `category_id` int NOT NULL,
  `movie_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKqqveu4voyswj4kqfwumo8xgyu` (`category_id`),
  KEY `FKk688wshqwmqx2tonomm3qllta` (`movie_id`),
  CONSTRAINT `FKk688wshqwmqx2tonomm3qllta` FOREIGN KEY (`movie_id`) REFERENCES `movies` (`id`),
  CONSTRAINT `FKqqveu4voyswj4kqfwumo8xgyu` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=357 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `content` text,
  `create_at` datetime DEFAULT NULL,
  `episode_id` int NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKe1y835b37nm5wwrm2wwoxykhk` (`episode_id`),
  KEY `FK8omq0tc18jd43bu5tjh6jvraq` (`user_id`),
  CONSTRAINT `FK8omq0tc18jd43bu5tjh6jvraq` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `FKe1y835b37nm5wwrm2wwoxykhk` FOREIGN KEY (`episode_id`) REFERENCES `episodes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=315 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `email_confirmation`
--

DROP TABLE IF EXISTS `email_confirmation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `email_confirmation` (
  `id` int NOT NULL AUTO_INCREMENT,
  `confirmation_type` varchar(255) DEFAULT NULL,
  `create_at` datetime DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `expired_date` datetime DEFAULT NULL,
  `otp_code` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKjgs74pu45i7a3e1cb5g7280yg` (`user_id`),
  CONSTRAINT `FKjgs74pu45i7a3e1cb5g7280yg` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=90 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `episodes`
--

DROP TABLE IF EXISTS `episodes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `episodes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `create_at` datetime DEFAULT NULL,
  `enable` tinyint(1) DEFAULT '1',
  `premium_required` tinyint(1) DEFAULT '0',
  `resource` varchar(255) DEFAULT NULL,
  `resource_do` varchar(255) DEFAULT NULL,
  `resource_public_id` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `total_view` bigint DEFAULT '0',
  `series_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKhgushpuihey5i9ff1vvr1l680` (`series_id`),
  CONSTRAINT `FKhgushpuihey5i9ff1vvr1l680` FOREIGN KEY (`series_id`) REFERENCES `movie_series` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=282 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `favorites`
--

DROP TABLE IF EXISTS `favorites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `favorites` (
  `id` int NOT NULL AUTO_INCREMENT,
  `create_at` datetime DEFAULT NULL,
  `movie_series_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK7qwimfan4fp4mvkknv8qlk885` (`movie_series_id`),
  KEY `FKk7du8b8ewipawnnpg76d55fus` (`user_id`),
  CONSTRAINT `FK7qwimfan4fp4mvkknv8qlk885` FOREIGN KEY (`movie_series_id`) REFERENCES `movie_series` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FKk7du8b8ewipawnnpg76d55fus` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gift_codes`
--

DROP TABLE IF EXISTS `gift_codes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gift_codes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `create_at` datetime DEFAULT NULL,
  `redemption_code` varchar(255) DEFAULT NULL,
  `subcription_package_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKliyy5s5f973bn0fjvx9ibbn6t` (`subcription_package_id`),
  CONSTRAINT `FKliyy5s5f973bn0fjvx9ibbn6t` FOREIGN KEY (`subcription_package_id`) REFERENCES `subscription_packages` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `giftcodeview`
--

DROP TABLE IF EXISTS `giftcodeview`;
/*!50001 DROP VIEW IF EXISTS `giftcodeview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `giftcodeview` AS SELECT 
 1 AS `id`,
 1 AS `create_at`,
 1 AS `redemption_code`,
 1 AS `subcription_package_id`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `log_histories`
--

DROP TABLE IF EXISTS `log_histories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `log_histories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `create_at` datetime DEFAULT NULL,
  `last_second` bigint DEFAULT NULL,
  `episode_id` int DEFAULT NULL,
  `series_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKrw2up6i4hrhn70ak9dsnng221` (`episode_id`),
  KEY `FKex5yf2uqudhu613eye2mg4jwv` (`series_id`),
  KEY `FKn0spkbdfk8ot6xt7nlwh6kulq` (`user_id`),
  CONSTRAINT `FKex5yf2uqudhu613eye2mg4jwv` FOREIGN KEY (`series_id`) REFERENCES `movie_series` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FKn0spkbdfk8ot6xt7nlwh6kulq` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `FKrw2up6i4hrhn70ak9dsnng221` FOREIGN KEY (`episode_id`) REFERENCES `episodes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `movie_series`
--

DROP TABLE IF EXISTS `movie_series`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `movie_series` (
  `id` int NOT NULL AUTO_INCREMENT,
  `create_at` datetime DEFAULT NULL,
  `date_aired` datetime DEFAULT NULL,
  `description` text,
  `image` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `total_episode` int NOT NULL,
  `movie_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKfowgph3de8wuelojrdmvhsg65` (`movie_id`),
  CONSTRAINT `FKfowgph3de8wuelojrdmvhsg65` FOREIGN KEY (`movie_id`) REFERENCES `movies` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=150 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `movies`
--

DROP TABLE IF EXISTS `movies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `movies` (
  `id` int NOT NULL AUTO_INCREMENT,
  `create_at` datetime DEFAULT NULL,
  `studio_name` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=152 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `order_premium`
--

DROP TABLE IF EXISTS `order_premium`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_premium` (
  `id` int NOT NULL AUTO_INCREMENT,
  `create_at` datetime DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `method` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `bill_id` int DEFAULT NULL,
  `subcription_package_id` int NOT NULL,
  `user_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKsomvaoqoxjped8yui8o50ximw` (`bill_id`),
  KEY `FKb0d3s99j3yft0pyawhqvdyq2d` (`subcription_package_id`),
  KEY `FKs95xak7c9ghccna5amk3pr7kp` (`user_id`),
  CONSTRAINT `FKb0d3s99j3yft0pyawhqvdyq2d` FOREIGN KEY (`subcription_package_id`) REFERENCES `subscription_packages` (`id`),
  CONSTRAINT `FKs95xak7c9ghccna5amk3pr7kp` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `FKsomvaoqoxjped8yui8o50ximw` FOREIGN KEY (`bill_id`) REFERENCES `paypal_order` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `paypal_order`
--

DROP TABLE IF EXISTS `paypal_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `paypal_order` (
  `id` int NOT NULL AUTO_INCREMENT,
  `currency` varchar(255) DEFAULT 'USD',
  `description` varchar(255) DEFAULT NULL,
  `intent` varchar(255) DEFAULT 'sale',
  `method` varchar(255) DEFAULT 'paypal',
  `payer_id` varchar(255) DEFAULT NULL,
  `payment_id` varchar(255) DEFAULT NULL,
  `price` double NOT NULL,
  `status` varchar(255) DEFAULT 'pending',
  `token` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `premiumuser`
--

DROP TABLE IF EXISTS `premiumuser`;
/*!50001 DROP VIEW IF EXISTS `premiumuser`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `premiumuser` AS SELECT 
 1 AS `id`,
 1 AS `expired_at`,
 1 AS `subscribe_date`,
 1 AS `subscription_package_id`,
 1 AS `user_id`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `create_at` datetime DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `permission` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `subscription_packages`
--

DROP TABLE IF EXISTS `subscription_packages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subscription_packages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `day` bigint DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `enable` bit(1) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `price` double DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_premiums`
--

DROP TABLE IF EXISTS `user_premiums`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_premiums` (
  `id` int NOT NULL AUTO_INCREMENT,
  `expired_at` datetime DEFAULT NULL,
  `subscribe_date` datetime DEFAULT NULL,
  `subscription_package_id` int NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKr8wwghvegr5cgtl3ti3x00g7u` (`subscription_package_id`),
  KEY `FKjyl89cnhx3wwmt5tnf0g3kdcw` (`user_id`),
  CONSTRAINT `FKjyl89cnhx3wwmt5tnf0g3kdcw` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `FKr8wwghvegr5cgtl3ti3x00g7u` FOREIGN KEY (`subscription_package_id`) REFERENCES `subscription_packages` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `avatar` varchar(255) DEFAULT NULL,
  `create_at` datetime DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `enable` tinyint(1) DEFAULT '1',
  `full_name` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `user_role_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKeiotsurvwt38o0qs1w3kj32c9` (`user_role_id`),
  CONSTRAINT `FKeiotsurvwt38o0qs1w3kj32c9` FOREIGN KEY (`user_role_id`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `view_statistics`
--

DROP TABLE IF EXISTS `view_statistics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `view_statistics` (
  `id` int NOT NULL AUTO_INCREMENT,
  `create_at` datetime DEFAULT NULL,
  `ip_address` varchar(255) DEFAULT NULL,
  `episode_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKltthi0ki2va5qbkhhr6mloxj3` (`episode_id`),
  CONSTRAINT `FKltthi0ki2va5qbkhhr6mloxj3` FOREIGN KEY (`episode_id`) REFERENCES `episodes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=309 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Final view structure for view `giftcodeview`
--

/*!50001 DROP VIEW IF EXISTS `giftcodeview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `giftcodeview` AS select `gift_codes`.`id` AS `id`,`gift_codes`.`create_at` AS `create_at`,`gift_codes`.`redemption_code` AS `redemption_code`,`gift_codes`.`subcription_package_id` AS `subcription_package_id` from `gift_codes` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `premiumuser`
--

/*!50001 DROP VIEW IF EXISTS `premiumuser`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `premiumuser` AS select `user_premiums`.`id` AS `id`,`user_premiums`.`expired_at` AS `expired_at`,`user_premiums`.`subscribe_date` AS `subscribe_date`,`user_premiums`.`subscription_package_id` AS `subscription_package_id`,`user_premiums`.`user_id` AS `user_id` from `user_premiums` where (`user_premiums`.`expired_at` > now()) group by `user_premiums`.`user_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-04-04 13:06:55
