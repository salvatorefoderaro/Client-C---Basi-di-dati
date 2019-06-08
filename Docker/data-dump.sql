CREATE USER 'tempUser'@'%%' IDENTIFIED BY 'tempUser';
GRANT ALL PRIVILEGES ON * . * TO 'tempUser'@'%%';

CREATE USER 'other'@'%%' IDENTIFIED BY 'otherUser';
GRANT ALL PRIVILEGES ON * . * TO 'other'@'%%';

CREATE USER 'amministrativo'@'%%' IDENTIFIED BY 'settoreAmministrativo';
GRANT ALL PRIVILEGES ON * . * TO 'amministrativo'@'%%';

CREATE USER 'spazi'@'%%' IDENTIFIED BY 'settoreSpazi';
GRANT ALL PRIVILEGES ON * . * TO 'spazi'@'%%';


-- MySQL dump 10.17  Distrib 10.3.14-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: mydb
-- ------------------------------------------------------
-- Server version	10.3.14-MariaDB-1:10.3.14+maria~cosmic-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Dipendente`
--

DROP TABLE IF EXISTS `Dipendente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Dipendente` (
  `idDipendente` int(11) NOT NULL AUTO_INCREMENT,
  `Mansione` int(11) NOT NULL DEFAULT 0,
  `Nome` varchar(45) NOT NULL,
  `IndirizoResidenza` varchar(45) NOT NULL,
  `EMailUfficio` varchar(45) NOT NULL DEFAULT 'dummyEmail@office.com',
  `EMailPersonale` varchar(45) NOT NULL,
  `DataNascita` date NOT NULL,
  `LuogoNascita` varchar(45) NOT NULL,
  `password` varchar(256) NOT NULL,
  `userType` int(11) NOT NULL,
  `Cognome` varchar(100) NOT NULL,
  `isDaTrasferire` tinyint(1) NOT NULL,
  PRIMARY KEY (`idDipendente`),
  KEY `fk_Dipendente_1` (`Mansione`),
  CONSTRAINT `fk_Dipendente_1` FOREIGN KEY (`Mansione`) REFERENCES `Mansione` (`idMansione`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Dipendente`
--

LOCK TABLES `Dipendente` WRITE;
/*!40000 ALTER TABLE `Dipendente` DISABLE KEYS */;
INSERT INTO `Dipendente` VALUES (1,2,'Giuseppe','Via Argada, 2','ufficio2@test.com','giuseppe@gmail.com','1995-04-10','Catanzaro','asd',1,'A',0),(2,2,'Francesco','Via Argada, 3','ufficio1@test.com','francesco@gmail.com','1996-04-11','Girifalco','ddf',2,'B',0),(3,2,'Salvatore','Via Argada, 4','ufficio2@test.com','salvatore@gmail.com','1995-04-12','Catanzaro','bbh',3,'C',0);
/*!40000 ALTER TABLE `Dipendente` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `mydb`.`Dipendente_BEFORE_UPDATE` BEFORE UPDATE ON `Dipendente` FOR EACH ROW
BEGIN

	IF (NEW.Mansione != OLD.Mansione) THEN
		SET NEW.isDaTrasferire = TRUE;
	END IF;
       
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `ImpiegoPassato`
--

DROP TABLE IF EXISTS `ImpiegoPassato`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ImpiegoPassato` (
  `idImpiegoPassato` int(11) NOT NULL AUTO_INCREMENT,
  `DataInizio` date NOT NULL,
  `DataFine` date NOT NULL,
  `Postazione` int(11) NOT NULL,
  `Dipendente` int(11) NOT NULL,
  PRIMARY KEY (`idImpiegoPassato`,`Postazione`,`Dipendente`),
  KEY `fk_ImpiegoPassato_1` (`Postazione`),
  KEY `fk_ImpiegoPassato_2` (`Dipendente`),
  CONSTRAINT `fk_ImpiegoPassato_1` FOREIGN KEY (`Postazione`) REFERENCES `Postazione` (`idPostazione`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ImpiegoPassato_2` FOREIGN KEY (`Dipendente`) REFERENCES `Dipendente` (`idDipendente`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ImpiegoPassato`
--

LOCK TABLES `ImpiegoPassato` WRITE;
/*!40000 ALTER TABLE `ImpiegoPassato` DISABLE KEYS */;
INSERT INTO `ImpiegoPassato` VALUES (19,'2019-05-03','2019-05-03',2,3),(20,'2019-05-03','2019-05-03',1,2),(21,'2019-05-03','2019-05-13',5,1),(22,'2019-05-13','2019-05-17',1,1);
/*!40000 ALTER TABLE `ImpiegoPassato` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Mansione`
--

DROP TABLE IF EXISTS `Mansione`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Mansione` (
  `idMansione` int(11) NOT NULL AUTO_INCREMENT,
  `NomeMansione` varchar(45) NOT NULL,
  PRIMARY KEY (`idMansione`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Mansione`
--

LOCK TABLES `Mansione` WRITE;
/*!40000 ALTER TABLE `Mansione` DISABLE KEYS */;
INSERT INTO `Mansione` VALUES (1,'Amministrazione'),(2,'MansioneProva');
/*!40000 ALTER TABLE `Mansione` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Postazione`
--

DROP TABLE IF EXISTS `Postazione`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Postazione` (
  `idPostazione` int(11) NOT NULL AUTO_INCREMENT,
  `Ufficio` int(11) NOT NULL,
  PRIMARY KEY (`idPostazione`,`Ufficio`),
  KEY `fk_Postazione_1` (`Ufficio`),
  CONSTRAINT `fk_Postazione_1` FOREIGN KEY (`Ufficio`) REFERENCES `Ufficio` (`idUfficio`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Postazione`
--

LOCK TABLES `Postazione` WRITE;
/*!40000 ALTER TABLE `Postazione` DISABLE KEYS */;
INSERT INTO `Postazione` VALUES (1,1),(2,2),(3,1),(4,2),(5,2),(6,1),(7,1);
/*!40000 ALTER TABLE `Postazione` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `mydb`.`Postazione_BEFORE_UPDATE` BEFORE UPDATE ON `Postazione` FOR EACH ROW
BEGIN

	IF (NEW.Ufficio != OLD.Ufficio) THEN
		IF EXISTS (SELECT 1 FROM PostazioneAttiva WHERE idPostazioneAttiva = OLD.idPostazione and Disponibile is false) THEN

		signal sqlstate '45000'
		SET MESSAGE_TEXT = 'Non è assegnare spostare una postazione attualmente occupata!';
	END IF;

IF NOT EXISTS (SELECT 1 FROM Ufficio WHERE idUfficio = NEW.Ufficio) THEN

	signal sqlstate '45000'
		SET MESSAGE_TEXT = 'L\'ID dell\'ufficio indicato non è corretto!';
	END IF;
	END IF;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `mydb`.`Postazione_BEFORE_DELETE` BEFORE DELETE ON `Postazione` FOR EACH ROW
BEGIN

IF EXISTS (SELECT * FROM PostazioneAttiva WHERE idPostazioneAttiva = OLD.idPostazione and Disponibile is false LIMIT 1) THEN

	signal sqlstate '44449'
		SET MESSAGE_TEXT = 'Non è possibile eliminare una postazione attualmente occupata!';
	END IF;

IF EXISTS (SELECT * FROM PostazioneAttiva WHERE idPostazioneAttiva = OLD.idPostazione LIMIT 1) THEN
		signal sqlstate '45001'
		SET MESSAGE_TEXT = 'Non è possibile eliminare una postazione attualmente attiva!';
    END IF;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `PostazioneAttiva`
--

DROP TABLE IF EXISTS `PostazioneAttiva`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PostazioneAttiva` (
  `idPostazioneAttiva` int(11) NOT NULL AUTO_INCREMENT COMMENT '			',
  `Disponibile` tinyint(4) NOT NULL,
  `Ufficio` int(11) NOT NULL,
  `idPostazione` int(11) NOT NULL,
  PRIMARY KEY (`idPostazioneAttiva`,`Ufficio`,`idPostazione`),
  KEY `fk_table1_1` (`Ufficio`),
  KEY `PostazioneAttiva_Postazione_FK` (`idPostazione`,`Ufficio`),
  CONSTRAINT `fk_table1_1` FOREIGN KEY (`Ufficio`) REFERENCES `Ufficio` (`idUfficio`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PostazioneAttiva`
--

LOCK TABLES `PostazioneAttiva` WRITE;
/*!40000 ALTER TABLE `PostazioneAttiva` DISABLE KEYS */;
INSERT INTO `PostazioneAttiva` VALUES (1,1,1,1),(2,0,2,2),(3,0,1,3),(4,0,2,4),(5,1,2,5);
/*!40000 ALTER TABLE `PostazioneAttiva` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `mydb`.`PostazioneAttiva_BEFORE_INSERT` BEFORE INSERT ON `PostazioneAttiva` FOR EACH ROW
BEGIN

IF NOT EXISTS (SELECT 1 FROM Postazione WHERE idPostazione = NEW.idPostazioneAttiva and Ufficio != 0) THEN

	signal sqlstate '45000'
		SET MESSAGE_TEXT = 'Nessuna postazione associata all\'ID indicato!';
	END IF;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `mydb`.`PostazioneAttiva_AFTER_INSERT` AFTER INSERT ON `PostazioneAttiva` FOR EACH ROW
BEGIN

	IF NEW.Disponibile is true THEN
		UPDATE Ufficio set NumeroPostazioniLibere = NumeroPostazioniLibere + 1 WHERE idUfficio = NEW.Ufficio;
	END IF;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `mydb`.`PostazioneAttiva_AFTER_UPDATE_1` AFTER UPDATE ON `PostazioneAttiva` FOR EACH ROW
BEGIN

IF (OLD.Disponibile != NEW.Disponibile and NEW.Disponibile = false) then
	UPDATE Ufficio set NumeroPostazioniLibere = NumeroPostazioniLibere - 1 WHERE idUfficio = NEW.Ufficio;
END IF;

IF (OLD.Disponibile != NEW.Disponibile and NEW.Disponibile = true) then
	UPDATE Ufficio set NumeroPostazioniLibere = numeroPostazioniLibere + 1 Where idUfficio = NEW.Ufficio;
END IF;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `mydb`.`PostazioneAttiva_BEFORE_DELETE` BEFORE Delete ON `PostazioneAttiva` FOR EACH ROW
BEGIN

	IF (OLD.Disponibile is false) THEN
	signal sqlstate '45000'
		SET MESSAGE_TEXT = 'Non è possibile disabilitare una postazione attualmente assegnata ad un dipendente!';
	END IF;

	UPDATE Ufficio SET NumeroPostazioniLibere = NumeroPostazioniLibere - 1 WHERE idUfficio = OLD.Ufficio;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Ufficio`
--

DROP TABLE IF EXISTS `Ufficio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Ufficio` (
  `idUfficio` int(11) NOT NULL AUTO_INCREMENT,
  `Piano` int(11) NOT NULL,
  `Edificio` varchar(10) NOT NULL,
  `TelefonoInterno` varchar(45) NOT NULL,
  `TelefonoEsterno` varchar(45) NOT NULL,
  `NumeroPostazioniLibere` int(11) NOT NULL,
  `Mansione` int(11) NOT NULL,
  `Email` varchar(100) NOT NULL,
  PRIMARY KEY (`idUfficio`,`Mansione`),
  KEY `fk_Ufficio_1` (`Mansione`),
  CONSTRAINT `fk_Ufficio_1` FOREIGN KEY (`Mansione`) REFERENCES `Mansione` (`idMansione`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Ufficio`
--

LOCK TABLES `Ufficio` WRITE;
/*!40000 ALTER TABLE `Ufficio` DISABLE KEYS */;
INSERT INTO `Ufficio` VALUES (1,1,'1','000001','010101',1,1,'ufficio1@test.com'),(2,2,'1','000002','020202',2,2,'ufficio2@test.com');
/*!40000 ALTER TABLE `Ufficio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `getPostazioni`
--

DROP TABLE IF EXISTS `getPostazioni`;
/*!50001 DROP VIEW IF EXISTS `getPostazioni`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `getPostazioni` (
  `idPostazione` tinyint NOT NULL,
  `Ufficio` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `getPostazioniAttive`
--

DROP TABLE IF EXISTS `getPostazioniAttive`;
/*!50001 DROP VIEW IF EXISTS `getPostazioniAttive`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `getPostazioniAttive` (
  `idPostazioneAttiva` tinyint NOT NULL,
  `Disponibile` tinyint NOT NULL,
  `Ufficio` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `getToTransfer`
--

DROP TABLE IF EXISTS `getToTransfer`;
/*!50001 DROP VIEW IF EXISTS `getToTransfer`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `getToTransfer` (
  `idDipendente` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `impiegoCorrente`
--

DROP TABLE IF EXISTS `impiegoCorrente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `impiegoCorrente` (
  `idImpiegoCorrente` int(11) NOT NULL AUTO_INCREMENT,
  `DataInizio` date NOT NULL,
  `Postazione` int(11) NOT NULL,
  `Dipendente` int(11) NOT NULL,
  `dummyValue` tinyint(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`idImpiegoCorrente`,`Postazione`,`Dipendente`),
  KEY `fk_ImpiegoCorrente_1` (`Postazione`),
  KEY `fk_ImpiegoCorrente_2` (`Dipendente`),
  CONSTRAINT `fk_ImpiegoCorrente_1` FOREIGN KEY (`Postazione`) REFERENCES `PostazioneAttiva` (`idPostazioneAttiva`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ImpiegoCorrente_2` FOREIGN KEY (`Dipendente`) REFERENCES `Dipendente` (`idDipendente`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `impiegoCorrente`
--

LOCK TABLES `impiegoCorrente` WRITE;
/*!40000 ALTER TABLE `impiegoCorrente` DISABLE KEYS */;
INSERT INTO `impiegoCorrente` VALUES (1,'2019-05-17',2,1,1),(2,'2019-05-03',3,2,1),(5,'2019-05-03',4,3,1);
/*!40000 ALTER TABLE `impiegoCorrente` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `mydb`.`impiegoCorrente_BEFORE_INSERT` BEFORE INSERT ON `impiegoCorrente` FOR EACH ROW

BEGIN
	
	IF NOT EXISTS (SELECT 1 FROM Dipendente WHERE idDipendente = NEW.Dipendente AND isDaTrasferire is true) THEN
		signal sqlstate '45000'
		SET MESSAGE_TEXT = 'L\'ID del dipendente non è valido o non disponibile per il trasferimento!';
	END IF;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `mydb`.`impiegoCorrente_AFTER_INSERT` AFTER INSERT ON `impiegoCorrente` FOR EACH ROW

BEGIN
	UPDATE PostazioneAttiva set Disponibile = false WHERE idPostazioneAttiva = NEW.Postazione;
    UPDATE Dipendente set eMailUfficio = (SELECT ufficio.Email FROM PostazioneAttiva JOIN Ufficio as ufficio on PostazioneAttiva.Ufficio = ufficio.idUfficio WHERE PostazioneAttiva.idPostazioneAttiva = NEW.Postazione), isDaTrasferire = FALSE WHERE idDipendente = NEW.Dipendente; 
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `mydb`.`impiegoCorrente_BEFORE_UPDATE` BEFORE UPDATE ON `impiegoCorrente` FOR EACH ROW
BEGIN

	DECLARE mansioneDipendente int;
	SET mansioneDipendente = getMansioneUtente(NEW.Dipendente);

  IF (NEW.Postazione != OLD.Postazione AND OLD.dummyValue = 0) THEN
  
      IF NOT EXISTS(SELECT idPostazioneAttiva FROM PostazioneAttiva
    JOIN Ufficio on PostazioneAttiva.Ufficio = Ufficio.idUfficio
    JOIN Mansione on Ufficio.Mansione = mansioneDipendente
    WHERE (
NOT EXISTS (SELECT * FROM ImpiegoPassato IP WHERE IP.dipendente = NEW.Dipendente and IP.postazione = NEW.Postazione)
or
EXISTS (SELECT * from ImpiegoPassato IP WHERE IP.dipendente = NEW.Dipendente and IP.postazione = NEW.Postazione and IP.DataInizio < DATE(DATE_sub(NOW(), INTERVAL 2 YEAR)))
)) THEN

	signal sqlstate '45000'
		SET MESSAGE_TEXT = 'Il dipendente è stato già assegnato a questa postazione nei precedenti due anni!';

	END IF;

  	SET NEW.DataInizio = NOW();
  
    INSERT INTO ImpiegoPassato(DataInizio, DataFine, Postazione, Dipendente) VALUES (OLD.dataInizio, NOW(), OLD.Postazione, OLD.Dipendente);
    UPDATE Dipendente set eMailUfficio = (SELECT ufficio.Email FROM PostazioneAttiva JOIN Ufficio as ufficio on PostazioneAttiva.Ufficio = ufficio.idUfficio WHERE PostazioneAttiva.idPostazioneAttiva = NEW.Postazione), isDaTrasferire = FALSE WHERE idDipendente = NEW.Dipendente; 
	SET NEW.dummyValue = 1; 
 END IF;	
	
  IF (NEW.Postazione != OLD.Postazione AND OLD.dummyValue != 0) THEN
  
        IF NOT EXISTS(SELECT idPostazioneAttiva FROM PostazioneAttiva
    JOIN Ufficio on PostazioneAttiva.Ufficio = Ufficio.idUfficio
    JOIN Mansione on Ufficio.Mansione = mansioneDipendente
    WHERE (
NOT EXISTS (SELECT * FROM ImpiegoPassato IP WHERE IP.dipendente = NEW.Dipendente and IP.postazione = NEW.Postazione)
or
EXISTS (SELECT * from ImpiegoPassato IP WHERE IP.dipendente = NEW.Dipendente and IP.postazione = NEW.Postazione and IP.DataInizio < DATE(DATE_sub(NOW(), INTERVAL 2 YEAR)))
)
   	AND Disponibile is TRUE) THEN

	signal sqlstate '45000'
		SET MESSAGE_TEXT = 'Il dipendente è stato già assegnato a questa postazione nei precedenti due anni!';

	END IF;

  	SET NEW.DataInizio = NOW();
  
  	INSERT INTO ImpiegoPassato(DataInizio, DataFine, Postazione, Dipendente) VALUES (OLD.dataInizio, NOW(), OLD.Postazione, OLD.Dipendente);
	UPDATE PostazioneAttiva set Disponibile = false WHERE idPostazioneAttiva = NEW.Postazione;
	UPDATE PostazioneAttiva set Disponibile = true WHERE idPostazioneAttiva = OLD.Postazione;
    UPDATE Dipendente set eMailUfficio = (SELECT ufficio.Email FROM PostazioneAttiva JOIN Ufficio as ufficio on PostazioneAttiva.Ufficio = ufficio.idUfficio WHERE PostazioneAttiva.idPostazioneAttiva = NEW.Postazione), isDaTrasferire = FALSE WHERE idDipendente = NEW.Dipendente; 
  END IF;

	IF (NEW.Dipendente != OLD.Dipendente) THEN
	IF NOT EXISTS (SELECT 1 FROM Dipendente WHERE idDipendente = NEW.Dipendente and isDaTrasferire is true) THEN
		signal sqlstate '45000'
		SET MESSAGE_TEXT = 'L\'ID del dipendente non è valido o non disponibile per il trasferimento!';
	END IF;
	END IF;




END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `getPostazioni`
--

/*!50001 DROP TABLE IF EXISTS `getPostazioni`*/;
/*!50001 DROP VIEW IF EXISTS `getPostazioni`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `getPostazioni` AS select `Postazione`.`idPostazione` AS `idPostazione`,`Postazione`.`Ufficio` AS `Ufficio` from `Postazione` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `getPostazioniAttive`
--

/*!50001 DROP TABLE IF EXISTS `getPostazioniAttive`*/;
/*!50001 DROP VIEW IF EXISTS `getPostazioniAttive`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `getPostazioniAttive` AS select `PostazioneAttiva`.`idPostazioneAttiva` AS `idPostazioneAttiva`,`PostazioneAttiva`.`Disponibile` AS `Disponibile`,`PostazioneAttiva`.`Ufficio` AS `Ufficio` from `PostazioneAttiva` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `getToTransfer`
--

/*!50001 DROP TABLE IF EXISTS `getToTransfer`*/;
/*!50001 DROP VIEW IF EXISTS `getToTransfer`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `getToTransfer` AS select `Dipendente`.`idDipendente` AS `idDipendente` from `Dipendente` where `Dipendente`.`isDaTrasferire` is true */;
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

-- Dump completed on 2019-06-08 12:01:42
