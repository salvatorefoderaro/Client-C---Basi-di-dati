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
  `Mansione` int(11) NOT NULL,
  `Nome` varchar(45) DEFAULT NULL,
  `IndirizoResidenza` varchar(45) DEFAULT NULL,
  `daTrasferire` tinyint(4) DEFAULT NULL,
  `EMailUfficio` varchar(45) DEFAULT NULL,
  `EMailPersonale` varchar(45) DEFAULT NULL,
  `DataNascita` date DEFAULT NULL,
  `LuogoNascita` varchar(45) DEFAULT NULL,
  `isSettoreSpazi` tinyint(4) DEFAULT NULL,
  `isSettoreAmministrativo` tinyint(4) DEFAULT NULL,
  `isDaTrasferire` tinyint(1) NOT NULL,
  `password` varchar(256) NOT NULL,
  `userType` int(11) NOT NULL,
  PRIMARY KEY (`idDipendente`),
  KEY `fk_Dipendente_1` (`Mansione`),
  CONSTRAINT `fk_Dipendente_1` FOREIGN KEY (`Mansione`) REFERENCES `Mansione` (`idMansione`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Dipendente`
--

LOCK TABLES `Dipendente` WRITE;
/*!40000 ALTER TABLE `Dipendente` DISABLE KEYS */;
INSERT INTO `Dipendente` VALUES (1,2,'Giuseppe','Via Argada, 2',1,'ufficio1@test.com','giuseppe@gmail.com','1995-04-10','Catanzaro',0,0,1,'asd',1),(2,1,'Francesco','Via Argada, 3',0,'ufficio1@test.com','francesco@gmail.com','1996-04-11','Girifalco',0,0,1,'ddf',2);
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
		SET NEW.daTrasferire = true;
    END IF;
       
	IF (NEW.Mansione = OLD.Mansione) THEN
		signal sqlstate '45000'
		SET MESSAGE_TEXT = 'La nuova mansione corrisponde con quella attuale!';
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
  `DataInizio` date DEFAULT NULL,
  `DataFine` date DEFAULT NULL,
  `Postazione` int(11) NOT NULL,
  `Dipendente` int(11) NOT NULL,
  PRIMARY KEY (`idImpiegoPassato`,`Postazione`,`Dipendente`),
  KEY `fk_ImpiegoPassato_1` (`Postazione`),
  KEY `fk_ImpiegoPassato_2` (`Dipendente`),
  CONSTRAINT `fk_ImpiegoPassato_1` FOREIGN KEY (`Postazione`) REFERENCES `Postazione` (`idPostazione`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ImpiegoPassato_2` FOREIGN KEY (`Dipendente`) REFERENCES `Dipendente` (`idDipendente`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ImpiegoPassato`
--

LOCK TABLES `ImpiegoPassato` WRITE;
/*!40000 ALTER TABLE `ImpiegoPassato` DISABLE KEYS */;
INSERT INTO `ImpiegoPassato` VALUES (1,'2019-04-02','2019-04-02',2,1),(2,'2019-04-02','2019-04-02',1,2);
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
  `NomeMansione` varchar(45) DEFAULT NULL,
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
  KEY `fk_Postazione_1` (`Ufficio`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Postazione`
--

LOCK TABLES `Postazione` WRITE;
/*!40000 ALTER TABLE `Postazione` DISABLE KEYS */;
INSERT INTO `Postazione` VALUES (1,1),(2,1),(3,5),(4,654321),(5,1);
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

IF NOT EXISTS (SELECT 1 FROM Ufficio WHERE idUfficio = NEW.Ufficio) THEN

	signal sqlstate '45000'
		SET MESSAGE_TEXT = 'L\'ID dell\'ufficio indicato non è corretto!';
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

IF EXISTS (SELECT 1 FROM PostazioneAttiva WHERE idPostazioneAttiva = idPostazione and Disponibile is false) THEN

	signal sqlstate '45000'
		SET MESSAGE_TEXT = 'Non è possibile eliminare una postazione attualmente occupata!';
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
  `Disponibile` tinyint(4) DEFAULT NULL,
  `Ufficio` int(11) NOT NULL,
  `idPostazione` int(11) NOT NULL,
  PRIMARY KEY (`idPostazioneAttiva`,`Ufficio`,`idPostazione`),
  KEY `fk_table1_1` (`Ufficio`),
  KEY `PostazioneAttiva_Postazione_FK` (`idPostazione`,`Ufficio`),
  CONSTRAINT `PostazioneAttiva_Postazione_FK` FOREIGN KEY (`idPostazione`, `Ufficio`) REFERENCES `Postazione` (`idPostazione`, `Ufficio`),
  CONSTRAINT `fk_table1_1` FOREIGN KEY (`Ufficio`) REFERENCES `Ufficio` (`idUfficio`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PostazioneAttiva`
--

LOCK TABLES `PostazioneAttiva` WRITE;
/*!40000 ALTER TABLE `PostazioneAttiva` DISABLE KEYS */;
INSERT INTO `PostazioneAttiva` VALUES (1,0,1,0),(2,1,1,0);
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
	ELSE
		UPDATE Ufficio set NumeroPostazioniLibere = NumeroPostazioniLibere - 1 WHERE idUfficio = NEW.Ufficio;
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

IF NEW.Disponibile = false then
	UPDATE Ufficio set NumeroPostazioniLibere = NumeroPostazioniLibere -1 WHERE idUfficio = NEW.Ufficio;
END IF;

IF NEW.Disponibile = true then
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
		SET MESSAGE_TEXT = 'Non è possibile disabilitare una postazione attualmente attiva!';
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
  `Piano` int(11) DEFAULT NULL,
  `Edificio` varchar(10) DEFAULT NULL,
  `TelefonoInterno` varchar(45) DEFAULT NULL,
  `TelefonoEsterno` varchar(45) DEFAULT NULL,
  `NumeroPostazioniLibere` int(11) DEFAULT NULL,
  `Mansione` int(11) NOT NULL,
  `Email` varchar(100) NOT NULL,
  PRIMARY KEY (`idUfficio`,`Mansione`),
  KEY `fk_Ufficio_1` (`Mansione`),
  CONSTRAINT `fk_Ufficio_1` FOREIGN KEY (`Mansione`) REFERENCES `Mansione` (`idMansione`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Ufficio`
--

LOCK TABLES `Ufficio` WRITE;
/*!40000 ALTER TABLE `Ufficio` DISABLE KEYS */;
INSERT INTO `Ufficio` VALUES (1,1,'1','000001','010101',1,1,'ufficio1@test.com');
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
  `idImpiegoCorrente` int(11) NOT NULL,
  `DataInizio` date DEFAULT NULL,
  `Postazione` int(11) NOT NULL,
  `Dipendente` int(11) NOT NULL,
  `dummyValue` tinyint(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`idImpiegoCorrente`,`Postazione`,`Dipendente`),
  KEY `fk_ImpiegoCorrente_1` (`Postazione`),
  KEY `fk_ImpiegoCorrente_2` (`Dipendente`),
  CONSTRAINT `fk_ImpiegoCorrente_1` FOREIGN KEY (`Postazione`) REFERENCES `PostazioneAttiva` (`idPostazioneAttiva`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ImpiegoCorrente_2` FOREIGN KEY (`Dipendente`) REFERENCES `Dipendente` (`idDipendente`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `impiegoCorrente`
--

LOCK TABLES `impiegoCorrente` WRITE;
/*!40000 ALTER TABLE `impiegoCorrente` DISABLE KEYS */;
INSERT INTO `impiegoCorrente` VALUES (1,'2019-04-02',1,1,0),(2,'2019-04-02',2,2,1);
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
	
	IF NOT EXISTS (SELECT 1 FROM Dipendente WHERE idDipendente = NEW.Dipendente AND daTrasferire is true) THEN
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
    UPDATE Dipendente set eMailUfficio = (SELECT ufficio.Email FROM PostazioneAttiva JOIN Ufficio as ufficio on PostazioneAttiva.Ufficio = ufficio.idUfficio WHERE PostazioneAttiva.idPostazioneAttiva = NEW.Postazione) WHERE idDipendente = NEW.Dipendente; 
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
    INSERT INTO ImpiegoPassato(DataInizio, DataFine, Postazione, Dipendente) VALUES (OLD.dataInizio, NOW(), OLD.Postazione, OLD.Dipendente);
    UPDATE Dipendente set eMailUfficio = (SELECT ufficio.Email FROM PostazioneAttiva JOIN Ufficio as ufficio on PostazioneAttiva.Ufficio = ufficio.idUfficio WHERE PostazioneAttiva.idPostazioneAttiva = NEW.Postazione), daTrasferire = false WHERE idDipendente = NEW.Dipendente; 
	SET NEW.dummyValue = 1; 
 END IF;	
	
  IF (NEW.Postazione != OLD.Postazione AND OLD.dummyValue != 0) THEN
    INSERT INTO ImpiegoPassato(DataInizio, DataFine, Postazione, Dipendente) VALUES (OLD.dataInizio, NOW(), OLD.Postazione, OLD.Dipendente);
	UPDATE PostazioneAttiva set Disponibile = false WHERE idPostazioneAttiva = NEW.Postazione;
	UPDATE PostazioneAttiva set Disponibile = true WHERE idPostazioneAttiva = OLD.Postazione;
    UPDATE Dipendente set eMailUfficio = (SELECT ufficio.Email FROM PostazioneAttiva JOIN Ufficio as ufficio on PostazioneAttiva.Ufficio = ufficio.idUfficio WHERE PostazioneAttiva.idPostazioneAttiva = NEW.Postazione), daTrasferire = false WHERE idDipendente = NEW.Dipendente; 
  END IF;

	IF (NEW.Dipendente != OLD.Dipendente) THEN
	IF NOT EXISTS (SELECT 1 FROM Dipendente WHERE idDipendente = NEW.Dipendente and daTrasferire is true) THEN
		signal sqlstate '45000'
		SET MESSAGE_TEXT = 'L\'ID del dipendente non è valido o non disponibile per il trasferimento!';
	END IF;
	END IF;

  IF (NEW.Postazione != OLD.Postazione) THEN
  
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `mydb`.`ImpiegoCorrente_AFTER_UPDATE` AFTER UPDATE ON `impiegoCorrente` FOR EACH ROW
BEGIN
	

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping routines for database 'mydb'
--
/*!50003 DROP FUNCTION IF EXISTS `checkDaTrasferire` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `checkDaTrasferire`(newDipendente INT) RETURNS int(11)
    DETERMINISTIC
BEGIN

	DECLARE counter int;
    
    IF NOT EXISTS (SELECT COUNT(*) FROM Dipendente WHERE idDipendente = newDipendente and daTrasferire is true) THEN
	
		       		signal sqlstate '45000'
		SET MESSAGE_TEXT = 'Utente non indicato come da trasferire!';
    END IF;

RETURN 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `checkPostazione` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `checkPostazione`(ID int) RETURNS int(11)
    DETERMINISTIC
BEGIN

	DECLARE counter int;
    
    IF NOT EXISTS (SELECT 1 FROM PostazioneAttiva WHERE idPostazioneAttiva = 1 AND Disponibile = true) THEN
		signal sqlstate '45000'
		SET MESSAGE_TEXT = 'Postazione non esistente o attualmente già occupata!';
    END IF;

RETURN 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `checkUserExists` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `checkUserExists`(userID int) RETURNS int(11)
    DETERMINISTIC
BEGIN

	DECLARE counter int;
    
    IF NOT EXISTS (SELECT 1 FROM Dipendente WHERE idDipendente=userID) then
    
		signal sqlstate '45000'
		SET MESSAGE_TEXT = 'Il dipendente indicato non esiste!';
    END IF;
   
   RETURN counter;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `checkValidMansione` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `checkValidMansione`(ID int) RETURNS int(11)
    DETERMINISTIC
BEGIN

	DECLARE counter int;
    
    IF NOT EXISTS (SELECT 1 FROM Mansione WHERE idMansione = ID) THEN
		signal sqlstate '45000'
		SET MESSAGE_TEXT = 'Mansione non valida!';
    END IF;

RETURN 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `checkValidPostazione` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `checkValidPostazione`(postazione int) RETURNS int(11)
    DETERMINISTIC
BEGIN
    
    IF NOT EXISTS (SELECT 1 FROM Postazione WHERE idPostazione = postazione) then
		signal sqlstate '45000'
		SET MESSAGE_TEXT = 'Nessuna postazione associata all\'ID indicato!';
    END IF;

RETURN 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `checkValidUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `checkValidUser`(userID int) RETURNS int(11)
    DETERMINISTIC
BEGIN

	DECLARE counter int;
    
    IF NOT EXISTS (SELECT 1 FROM Dipendente WHERE idDipendente=userID and daTrasferire is true) then
		signal sqlstate '45000'
		SET MESSAGE_TEXT = 'Dipendente non esiste e/o non attualmente da trasferire!';
    END IF;

RETURN 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `getCurrentPostazione` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `getCurrentPostazione`(idDipendente INT) RETURNS int(11)
    DETERMINISTIC
BEGIN
	DECLARE idPostazione int;

	SELECT Postazione INTO idPostazione from impiegoCorrente where Dipendente = idDipendente LIMIT 1;

    IF idPostazione is null then
	signal sqlstate '45000'
    		SET MESSAGE_TEXT = 'Nessuna postazione assegnata al dipendente!';

END IF;

RETURN idPostazione;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `getMansioneUtente` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `getMansioneUtente`(dipendenteNum Int) RETURNS int(11)
    DETERMINISTIC
BEGIN

	DECLARE idMansione int;

	SELECT Mansione INTO idMansione FROM Dipendente WHERE idDipendente = dipendenteNum Limit 1;
    
    IF idMansione is null then
	signal sqlstate '45000'
    		SET MESSAGE_TEXT = 'Nessuna mansione associata al dipendente!';

END IF;

RETURN idMansione;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `assignPostazioneToUfficio` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `assignPostazioneToUfficio`(IN postazione Int, IN ufficioID Int)
BEGIN

    DECLARE validPostazione INT; 
	SET validPostazione = checkValidPostazione(postazione);
  
	UPDATE Postazione SET Postazione.Ufficio = ufficioID WHERE Postazione.idPostazione = postazione;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `assignToPostazioneFree` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `assignToPostazioneFree`(IN dipendente Int, IN newPostazione Int)
BEGIN

    DECLARE mansioneDipendente Int;
    DECLARE littleResult INT;
   	DECLARE postazioneDipendente INT;
   	DECLARE validUser INT;	
   
   	SET postazioneDipendente = getCurrentPostazione(dipendente); 
    SET mansioneDipendente = getMansioneUtente(dipendente);
   	SET littleResult = checkPostazione(newPostazione);
	SET validUser = checkValidUser(dipendente);
    
	IF postazioneDipendente is null then
		# SET littleResult =  disablePostazione(newPostazione);
		INSERT INTO impiegoCorrente(Inizio, Postazione, Dipendente) VALUES (NOW(), newPostazione, dipendente);
	END IF;

	IF postazioneDipendente is not null THEN
		# SET littleResult =  disablePostazione(newPostazione);
		UPDATE impiegoCorrente SET impiegoCorrente.Postazione = newPostazione WHERE impiegoCorrente.Dipendente = dipendente;
	END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `checkPostazioniDisponibili` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `checkPostazioniDisponibili`(IN newDipendente Int)
BEGIN
	
	DECLARE postazioneDipendente Int;
    DECLARE mansioneDipendente Int;
    DECLARE counter int;
	DECLARE postazioneExists int;
   
    /* Controllo che l'utenta esista e che sia indicato come da trasferire */
    SET counter = checkValidUser(newDipendente);
    SET mansioneDipendente = getMansioneUtente(newDipendente);
    SET postazioneDipendente = getCurrentPostazione(newDipendente);
   
   	SELECT Postazione INTO postazioneDipendente from impiegoCorrente where Dipendente = newDipendente;
    
    IF postazioneDipendente is null then
    
    SELECT idPostazioneAttiva FROM PostazioneAttiva
    JOIN Ufficio on PostazioneAttiva.Ufficio = Ufficio.idUfficio
    JOIN Mansione on Ufficio.Mansione = mansioneDipendente
    WHERE (
NOT EXISTS (SELECT * FROM ImpiegoPassato IP WHERE IP.dipendente = newDipendente and IP.postazione = idPostazioneAttva)
or
EXISTS (SELECT * from ImpiegoPassato IP WHERE IP.dipendente = newDipendente and IP.postazione = idPostazioneAttiva and IP.DataInizio < DATE(DATE_sub(NOW(), INTERVAL 2 YEAR)))
)
   	AND Disponibile is TRUE;
    
    ELSE
    
    SELECT idPostazioneAttiva FROM PostazioneAttiva
    JOIN Ufficio on PostazioneAttiva.Ufficio = Ufficio.idUfficio
    JOIN Mansione on Ufficio.Mansione = mansioneDipendente
    WHERE idPostazioneAttiva != postazioneDipendente
    AND (
NOT EXISTS (SELECT * FROM ImpiegoPassato IP WHERE IP.dipendente = newDipendente and IP.postazione = idPostazioneAttiva)
or
EXISTS (SELECT * from ImpiegoPassato IP WHERE IP.dipendente = newDipendente and IP.postazione = idPostazioneAttiva and IP.DataInizio < DATE(DATE_sub(NOW(), INTERVAL 2 YEAR)))
)
   	AND Disponibile is TRUE;
    
    END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `deletePostazione` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `deletePostazione`(IN postazione Int)
BEGIN

    DECLARE validPostazione INT;
   	/* Aggiungere per il controllo se la posizione poteva essere disabilitata */
   	/* Anche qui aggiungere il check */
   
    SET validPostazione = checkValidPostazione(postazione);
	
   	IF EXISTS (SELECT 1 FROM PostazioneAttiva WHERE idPostazioneAttiva = postazione) then
		signal sqlstate '45000'
		SET MESSAGE_TEXT = 'Non è possibile eliminare una postazione attualmente attiva!';
    END IF;
   
    DELETE FROM Postazione WHERE idPostazione = postazione;
   	COMMIT;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `disablePostazione` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `disablePostazione`(IN postazione Int)
BEGIN

    DECLARE validPostazione INT;
   	/* Aggiungere per il controllo se la posizione poteva essere disabilitata */
   	/* Anche qui aggiungere il check */
	SET validPostazione = checkValidPostazione(postazione);

    DELETE FROM PostazioneAttiva WHERE idPostazioneAttiva = postazione;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `editMansione` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `editMansione`(IN userID int, IN idMansione int)
BEGIN
	
    DECLARE validUser int;
   	DECLARE test int;
    set validUser = checkUserExists(userID);
	
    /* Al momento è implementato nel trigger, ed è Ok.
     * Il controllo del dipendente però va fatto prima, lui comunque non mi da errore
     * Però, se ho il check di una foreign key, lo potrei evitare */
    SET test = checkValidMansione(idMansione);

	UPDATE Dipendente SET Mansione = idMansione WHERE idDipendente = userID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `enablePostazione` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `enablePostazione`(IN postazione Int)
BEGIN

    DECLARE validPostazione INT;	
	DECLARE idPostazione2 int;
	DECLARE idUfficio int;

	SET validPostazione = checkValidPostazione(postazione);
	
    IF EXISTS (SELECT 1 FROM PostazioneAttiva WHERE idPostazioneAttiva = postazione) then
		signal sqlstate '45000'
		SET MESSAGE_TEXT = 'La postazione risulta già abilitata!';
    END IF;	
   
	SELECT idPostazione, Ufficio into idPostazione2, idUfficio from Postazione where idPostazione = postazione;
	
	INSERT INTO PostazioneAttiva(Disponibile, idPostazioneAttiva, Ufficio, idPostazione)
	VALUES (true, idPostazione2, idUfficio, idPostazione2);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getAssegnazioniPassate` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getAssegnazioniPassate`(IN idUtente int)
BEGIN
	
	/* Controllo l'esistenza del dipendente */
	DECLARE validUtente int;
	SET validUtente = checkUserExists(idUtente);
	
	SELECT idImpiegoPassato, DataInizio, DataFine, Postazione FROM ImpiegoPassato WHERE Dipendente = idUtente;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getAttualeLocazioneDipendente` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getAttualeLocazioneDipendente`()
BEGIN
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getPostazioni` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getPostazioni`()
BEGIN

	SELECT * from getPostazioni;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getPostazioniAttive` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getPostazioniAttive`()
BEGIN

	SELECT * from getPostazioniAttive;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getUserDaTrasferire` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getUserDaTrasferire`()
BEGIN

	SELECT * from getToTransfer;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getUserNumeroInterno` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getUserNumeroInterno`(IN numeroInterno int)
BEGIN
	
	/* In questo caso mi vengono restituiti due result set,
	 * quindi va gestita la cosa a livello di Query dopo.
	 */
	
	/* Devo prima mostrare le informazioni relative all'ufficio */
	
	SELECT Ufficio.idUfficio, Ufficio.Piano, Ufficio.Edificio, Ufficio.Mansione  
	FROM Ufficio
	WHERE Ufficio.TelefonoInterno = numeroInterno;
	
	/* Successivamente devo mostrare le informazioni relative ai dipendenti che stanno dentro
	 * l'ufficio
	 * */
	
	SELECT Dipendente.idDipendente, Dipendente.isDaTrasferire
	FROM impiegoCorrente
	JOIN PostazioneAttiva on impiegoCorrente.Postazione = PostazioneAttiva.idPostazioneAttiva
	JOIN Ufficio on Ufficio.idUfficio = PostazioneAttiva.Ufficio
	JOIN Dipendente on Dipendente.idDipendente = impiegoCorrente.Dipendente
	WHERE Ufficio.TelefonoInterno = numeroInterno;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getUserScambiabili` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getUserScambiabili`(`newUser` int)
BEGIN

DECLARE `newMansione` int;
DECLARE `newPostazione` int;

	/* Effettuo il controllo sull'esistenza ed il trasferire dell'utente */
	DECLARE `validUser` int;
	SET validUser = checkValidUser(newUser);

	SET newPostazione = getCurrentPostazione(newUser);
	SET newMansione = getMansioneUtente(newUser);

	SELECT I2.dipendente as idImpiegato, I2.postazione as idPostazione
	from impiegoCorrente I2
	JOIN Dipendente on Dipendente.idDipendente = I2.Dipendente
	WHERE 
	(
	(
	NOT EXISTS (SELECT * FROM ImpiegoPassato IP WHERE IP.dipendente = newUser and IP.postazione = I2.postazione)
	or
	EXISTS (SELECT * from ImpiegoPassato IP WHERE IP.dipendente = newUser and IP.postazione = I2.postazione and IP.DataInizio < DATE(DATE_sub(NOW(), INTERVAL 2 YEAR)))
	)
	and
	(
	NOT EXISTS(SELECT * FROM ImpiegoPassato IP WHERE IP.Dipendente = I2.Dipendente and IP.postazione = newPostazione)
	or
	EXISTS(SELECT * from ImpiegoPassato IP WHERE IP.Dipendente = I2.Dipendente and IP.postazione = newPostazione and IP.DataInizio < DATE(DATE_sub(NOW(), INTERVAL 2 YEAR)))
	)
	and I2.dipendente != newUser and Dipendente.Mansione = newMansione
	and Dipendente.daTrasferire = true
	and EXISTS (SELECT Dipendente FROM impiegoCorrente WHERE Dipendente = I2.Dipendente)
	);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertNewPostazione` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertNewPostazione`(IN ufficio INT)
BEGIN

    DECLARE validPostazione INT;
   
	/* SET validPostazione = checkValidPostazione(postazione); */
    
	INSERT INTO Postazione(Ufficio) VALUES (ufficio);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `loginUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `loginUser`(IN matricolaDipendente int, IN passwordDipendente Varchar(256), OUT tipoDipendente INT)
BEGIN
	
	 /* DECLARE EXIT HANDLER FOR SQLEXCEPTION 
 		SELECT 'SQLException invoked'; */
	
	SELECT userType INTO tipoDipendente FROM Dipendente WHERE idDipendente = matricolaDipendente AND password = passwordDipendente;	

	IF tipoDipendente is NULL THEN
	signal sqlstate '45000'
    		SET MESSAGE_TEXT = 'Nome utente e/o password errati!';
	END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `makeScambioUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `makeScambioUser`(user1 int, user2 int)
BEGIN

	DECLARE postazione1 int;
    DECLARE postazione2 int;
   
    DECLARE disable1 int;
    DECLARe disable2 int;
   
   	DECLARE validUser1 int;
   	DECLARE validUser2 int;
   
    /* SET validUser1 = checkValidUser(user1);
   	SET validUser2 = checkValidUser(user2);
    */
    
	SET postazione1 = getCurrentPostazione(user1);
	SET postazione2 = getCurrentPostazione(user2);
   
	IF (postazione1 is not null and postazione2 is not null) THEN
	
		/* Cercare di capire se effettivamente serve questo Disable
		 * SET disable1 = disablePostazione(postazione1);
        SET disable2 = disablePostazione(postazione2); */
        
		/* Aggiungere qualche meccanismo per la gestione dello scambio degli utenti */
	
		UPDATE impiegoCorrente SET impiegoCorrente.dummyValue = 0 WHERE impiegoCorrente.Dipendente = user1;
		UPDATE impiegoCorrente SET impiegoCorrente.Postazione = postazione2 WHERE impiegoCorrente.Dipendente = user1;
	
		UPDATE impiegoCorrente SET impiegoCorrente.dummyValue = 0 WHERE impiegoCorrente.Dipendente = user2;
		UPDATE impiegoCorrente SET impiegoCorrente.Postazione = postazione1 WHERE impiegoCorrente.Dipendente = user2;
	
END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `userNameSurname` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `userNameSurname`(name VARCHAR(255), surname VARCHAR(255))
BEGIN

DECLARE postazione1 int;
DECLARE postazione2 int;
   
    DECLARE disable1 int;
    DECLARe disable2 int;
   
   	DECLARE validUser1 int;
   	DECLARE validUser2 int;
    
	SET postazione1 = getCurrentPostazione(user1);
	SET postazione2 = getCurrentPostazione(user2);

	IF (name =  '') THEN
		# Modificare con la query nel caso in cui nome e cognome debba essere vuoto
		UPDATE impiegoCorrente SET impiegoCorrente.dummyValue = 0 WHERE impiegoCorrente.Dipendente = user1;
	END IF;
   
	IF (postazione1 is not null and postazione2 is not null) THEN
	
		UPDATE impiegoCorrente SET impiegoCorrente.dummyValue = 0 WHERE impiegoCorrente.Dipendente = user1;
		UPDATE impiegoCorrente SET impiegoCorrente.Postazione = postazione2 WHERE impiegoCorrente.Dipendente = user1;
	
		UPDATE impiegoCorrente SET impiegoCorrente.dummyValue = 0 WHERE impiegoCorrente.Dipendente = user2;
		UPDATE impiegoCorrente SET impiegoCorrente.Postazione = postazione1 WHERE impiegoCorrente.Dipendente = user2;
	
	END IF;

END ;;
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
/*!50001 VIEW `getToTransfer` AS select `Dipendente`.`idDipendente` AS `idDipendente` from `Dipendente` where `Dipendente`.`daTrasferire` is true */;
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

-- Dump completed on 2019-05-03  9:56:36
