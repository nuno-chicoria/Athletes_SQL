CREATE DATABASE  IF NOT EXISTS `athletedb` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `athletedb`;
-- MySQL dump 10.13  Distrib 5.6.24, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: athlete_db
-- ------------------------------------------------------
-- Server version	5.6.26-log

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
-- Table structure for table `athlete`
--

DROP TABLE IF EXISTS `athlete`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `athlete` (
  `athleteID` int(11) NOT NULL,
  `Fname` text,
  `Lname` text,
  `Sex` text,
  `Club` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`athleteID`),
  KEY `club_athl_fk_one_idx` (`Club`),
  CONSTRAINT `club_athl_fk_one` FOREIGN KEY (`Club`) REFERENCES `club` (`clubID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `athlete`
--

LOCK TABLES `athlete` WRITE;
/*!40000 ALTER TABLE `athlete` DISABLE KEYS */;
INSERT INTO `athlete` VALUES (1034,'Gabriel','Castillo','M','5011'),(1094,'Stewart','Mitchell','M','5014'),(1161,'Rickey','McDaniel','M','5014'),(1285,'Marilyn','Little','F',''),(1328,'Bernard','Lamb','M','5014'),(1439,'Lawrence','Brown','F','5014'),(1523,'Preston','Fernandez','M','5012'),(1538,'Stacey','Diaz','F',''),(1740,'Ed','Reynolds','M','5015'),(1842,'Woodrow','Schneider','M','5015'),(1847,'Sophie','Henry','F',''),(1908,'Casey','Miller','F','5015'),(1947,'Patricia','Reyes','F','5012'),(2000,'Erma','Obrien','F','5015'),(2009,'Keith','Carlson','M','5012'),(2371,'Sharon','Kelly','F',''),(2591,'Edward','Woods','M','5014'),(2789,'Hubert','Dean','M','5011'),(3087,'Doyle','Shelton','M',''),(3156,'Cindy','Hogan','F','5011');
/*!40000 ALTER TABLE `athlete` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `club`
--

DROP TABLE IF EXISTS `club`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `club` (
  `clubID` varchar(45) NOT NULL,
  `ClubName` text,
  `Location` text,
  PRIMARY KEY (`clubID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `club`
--

LOCK TABLES `club` WRITE;
/*!40000 ALTER TABLE `club` DISABLE KEYS */;
INSERT INTO `club` VALUES ('5011','ALCD','Leuven'),('5012','Looise','Tessenderlo'),('5013','Running Antwerp','Antwerp'),('5014','ABOR','Mechelen'),('5015','KZVA','Aarschot');
/*!40000 ALTER TABLE `club` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event`
--

DROP TABLE IF EXISTS `event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event` (
  `eventID` int(11) NOT NULL,
  `Name` text,
  `Location` text,
  `Date` text,
  `Organizer` varchar(45) NOT NULL,
  `Distance_in_metres` int(11) DEFAULT NULL,
  PRIMARY KEY (`eventID`),
  KEY `organizer_fk_idx` (`Organizer`),
  CONSTRAINT `organizer_fk` FOREIGN KEY (`Organizer`) REFERENCES `club` (`clubID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event`
--

LOCK TABLES `event` WRITE;
/*!40000 ALTER TABLE `event` DISABLE KEYS */;
INSERT INTO `event` VALUES (13,'Loop zonder Dope','Kessel-lo','13/10/2013','5011',5000),(23,'Eindejaarscorrida','Leuven','29/12/2013','5011',8000),(35,'The Nike Classic','Tessenderlo','8/07/2013','5012',10000),(47,'Antwerp 10 miles','Antwerp','21/04/2013','5013',16000),(55,'Running event 1','Mechelen','7/06/2013','5014',5000),(67,'Running event 2','Mechelen','14/06/2013','5014',10000),(76,'Running event 3','Mechelen','21/06/2013','5014',10000),(81,'Running event 4','Mechelen','9/08/2013','5014',7000),(95,'Start-to-Run','Aarschot','8/03/2013','5015',5000),(97,'Keep-on-Running','Aarschot','15/12/2013','5015',10000);
/*!40000 ALTER TABLE `event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `participation_ind`
--

DROP TABLE IF EXISTS `participation_ind`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `participation_ind` (
  `athleteID` int(11) NOT NULL,
  `eventID` int(11) NOT NULL,
  `Performance_in_minutes` int(11) DEFAULT NULL,
  PRIMARY KEY (`athleteID`,`eventID`),
  KEY `event_particip_fk_idx` (`eventID`),
  CONSTRAINT `athlete_particip_fk` FOREIGN KEY (`athleteID`) REFERENCES `athlete` (`athleteID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `event_particip_fk` FOREIGN KEY (`eventID`) REFERENCES `event` (`eventID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `participation_ind`
--

LOCK TABLES `participation_ind` WRITE;
/*!40000 ALTER TABLE `participation_ind` DISABLE KEYS */;
INSERT INTO `participation_ind` VALUES (1034,35,NULL),(1034,67,45),(1094,13,18),(1094,81,28),(1161,67,46),(1161,81,34),(1285,13,21),(1285,47,77),(1285,76,43),(1285,95,45),(1328,95,41),(1439,13,25),(1439,35,45),(1439,55,24),(1523,13,17),(1523,47,59),(1523,67,38),(1523,81,26),(1538,35,59),(1740,13,22),(1740,35,41),(1740,55,17),(1842,35,52),(1842,95,44),(1908,35,48),(1908,95,46),(1947,95,51),(2000,35,43),(2009,55,21),(2009,95,49),(2371,55,22),(2371,76,49),(2789,47,70),(2789,55,23),(3087,47,81),(3087,81,33),(3156,35,55);
/*!40000 ALTER TABLE `participation_ind` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `participation_team`
--

DROP TABLE IF EXISTS `participation_team`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `participation_team` (
  `teamID` int(11) NOT NULL,
  `eventID` int(11) NOT NULL,
  `Performance_in_minutes` int(11) DEFAULT NULL,
  PRIMARY KEY (`teamID`,`eventID`),
  KEY `team_particip_event_fk_idx` (`eventID`),
  CONSTRAINT `team_particip_event_fk` FOREIGN KEY (`eventID`) REFERENCES `event` (`eventID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `team_particip_team_fk` FOREIGN KEY (`teamID`) REFERENCES `team` (`teamID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `participation_team`
--

LOCK TABLES `participation_team` WRITE;
/*!40000 ALTER TABLE `participation_team` DISABLE KEYS */;
INSERT INTO `participation_team` VALUES (1,76,25),(2,76,23),(4,76,22),(5,76,21);
/*!40000 ALTER TABLE `participation_team` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `team`
--

DROP TABLE IF EXISTS `team`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `team` (
  `teamID` int(11) NOT NULL,
  `teamName` text,
  PRIMARY KEY (`teamID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `team`
--

LOCK TABLES `team` WRITE;
/*!40000 ALTER TABLE `team` DISABLE KEYS */;
INSERT INTO `team` VALUES (1,'ALCD-team'),(2,'ABOR-team'),(3,'KZKA-team'),(4,'multi-team'),(5,'Belgian team');
/*!40000 ALTER TABLE `team` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `team_member`
--

DROP TABLE IF EXISTS `team_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `team_member` (
  `teamID` int(11) NOT NULL,
  `athleteID` int(11) NOT NULL,
  PRIMARY KEY (`teamID`,`athleteID`),
  KEY `team_member_athlete_fk_idx` (`athleteID`),
  CONSTRAINT `team_member_athlete_fk` FOREIGN KEY (`athleteID`) REFERENCES `athlete` (`athleteID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `team_member_team_fk` FOREIGN KEY (`teamID`) REFERENCES `team` (`teamID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `team_member`
--

LOCK TABLES `team_member` WRITE;
/*!40000 ALTER TABLE `team_member` DISABLE KEYS */;
INSERT INTO `team_member` VALUES (1,1034),(2,1094),(4,1161),(2,1328),(2,1439),(5,1523),(4,1538),(3,1740),(5,1740),(3,1842),(5,1842),(4,1847),(3,1908),(3,2000),(5,2009),(2,2591),(1,2789),(4,3156);
/*!40000 ALTER TABLE `team_member` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-11-21 10:12:26
