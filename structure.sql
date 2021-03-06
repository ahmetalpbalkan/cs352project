
-- MySQL dump 10.13  Distrib 5.5.9, for osx10.4 (i386)
--
-- Host: localhost    Database: airline
-- ------------------------------------------------------
-- Server version	5.5.9

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `airport`
--

DROP TABLE IF EXISTS `airport`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `airport` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(4) NOT NULL,
  `name` varchar(100) NOT NULL,
  `city` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `city` (`city`),
  CONSTRAINT `airport_ibfk_2` FOREIGN KEY (`city`) REFERENCES `city` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `booking`
--

DROP TABLE IF EXISTS `booking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `booking` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `seat` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `booking_date` datetime NOT NULL CHECK (booking_date>=NOW()),
  `flight_id` int(11) NOT NULL,
  `payment` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `customer_id` (`customer_id`),
  KEY `flight_id` (`flight_id`),
  KEY `payment` (`payment`),
  CONSTRAINT `booking_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`) ON DELETE CASCADE,
  CONSTRAINT `booking_ibfk_2` FOREIGN KEY (`flight_id`) REFERENCES `flight` (`id`) ON DELETE CASCADE,
  CONSTRAINT `booking_ibfk_3` FOREIGN KEY (`payment`) REFERENCES `payment` (`transaction_id`) 
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `booking_luggage`
--

DROP TABLE IF EXISTS `booking_luggage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `booking_luggage` (
  `booking_id` int(11) NOT NULL,
  `luggage_id` int(11) NOT NULL,
  PRIMARY KEY (`booking_id`,`luggage_id`),
  KEY `luggage_id` (`luggage_id`),
  CONSTRAINT `booking_luggage_ibfk_1` FOREIGN KEY (`booking_id`) REFERENCES `booking` (`id`) ON DELETE CASCADE,
  CONSTRAINT `booking_luggage_ibfk_2` FOREIGN KEY (`luggage_id`) REFERENCES `luggage` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `city`
--

DROP TABLE IF EXISTS `city`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `city` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `phone` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `flight`
--

DROP TABLE IF EXISTS `flight`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flight` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `flight_number` varchar(10) NOT NULL,
  `departure_date` datetime NOT NULL,
  `fare` float DEFAULT '0',
  `route` int(11) NOT NULL,
  `plane` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `route` (`route`),
  KEY `plane` (`plane`),
  CONSTRAINT `flight_ibfk_1` FOREIGN KEY (`route`) REFERENCES `route` (`id`) ON DELETE CASCADE,
  CONSTRAINT `flight_ibfk_2` FOREIGN KEY (`plane`) REFERENCES `plane` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


DROP TABLE IF EXISTS `flight_crew`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flight_crew` (
  `flight_id` int(11) NOT NULL,
  `staff_id` int(11) NOT NULL,
  `role` enum('ASST','CPT','HOST') NOT NULL,
  PRIMARY KEY (`flight_id`,`staff_id`),
  KEY `staff_id` (`staff_id`),
  CONSTRAINT `flight_crew_ibfk_1` FOREIGN KEY (`flight_id`) REFERENCES `flight` (`id`) ON DELETE CASCADE,
  CONSTRAINT `flight_crew_ibfk_2` FOREIGN KEY (`staff_id`) REFERENCES `flight_staff` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


DROP TABLE IF EXISTS `flight_staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flight_staff` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `salary` float DEFAULT '0',
  `name` varchar(100) NOT NULL,
  `type` enum('PILOT','HOSTESS') NOT NULL,
  `date_joined` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;



DROP TABLE IF EXISTS `ground_staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ground_staff` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `salary` float DEFAULT '0',
  `name` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `type` enum('EXEC','SALES') DEFAULT 'SALES',
  `date_joined` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

DROP TABLE IF EXISTS `luggage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `luggage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `weight` float DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


DROP TABLE IF EXISTS `payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payment` (
  `transaction_id` int(11) NOT NULL AUTO_INCREMENT,
  `date` datetime DEFAULT NULL,
  `amount` float DEFAULT '0',
  PRIMARY KEY (`transaction_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;



DROP TABLE IF EXISTS `plane`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plane` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `capacity` int(11) NOT NULL,
  `model` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


DROP TABLE IF EXISTS `route`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `route` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `departure` int(11) NOT NULL,
  `destination` int(11) NOT NULL,
  `duration` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `departure` (`departure`),
  KEY `destination` (`destination`),
  CHECK (departure<>destination),
  CONSTRAINT `route_ibfk_1` FOREIGN KEY (`departure`) REFERENCES `airport` (`id`) ON DELETE CASCADE,
  CONSTRAINT `route_ibfk_2` FOREIGN KEY (`destination`) REFERENCES `airport` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


DROP TABLE IF EXISTS `route_listing`;
/*!50001 DROP VIEW IF EXISTS `route_listing`*/;

CREATE VIEW `route_listing` AS (select `r`.`id` AS `id`,concat(`f`.`name`,'-',`t`.`name`) AS `route_name`,`f`.`id` AS `departure`,`t`.`id` AS `destination`,`r`.`duration` AS `duration` from ((`route` `r` join `airport` `f`) join `airport` `t`) where ((`r`.`departure` = `f`.`id`) and (`r`.`destination` = `t`.`id`)));

--
-- Final view structure for view `route_listing`
--

/*!50001 DROP TABLE IF EXISTS `route_listing`*/;
/*!50001 DROP VIEW IF EXISTS `route_listing`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = latin1 */;
/*!50001 SET character_set_results     = latin1 */;
/*!50001 SET collation_connection      = latin1_swedish_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `route_listing` AS (select `r`.`id` AS `id`,concat(`f`.`name`,'-',`t`.`name`) AS `route_name`,`f`.`id` AS `departure`,`t`.`id` AS `destination`,`r`.`duration` AS `duration` from ((`route` `r` join `airport` `f`) join `airport` `t`) where ((`r`.`departure` = `f`.`id`) and (`r`.`destination` = `t`.`id`))) */;
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

-- Dump completed on 2011-05-04 18:07:09


INSERT INTO ground_staff(name,password,type) VALUES ('admin', '21232f297a57a5a743894a0e4a801fc3', 'EXEC');
