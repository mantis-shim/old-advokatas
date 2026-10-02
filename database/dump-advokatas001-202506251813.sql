-- MySQL dump 10.13  Distrib 9.3.0, for Linux (x86_64)
--
-- Host: localhost    Database: advokatas001
-- ------------------------------------------------------
-- Server version	8.4.5

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
-- Table structure for table `article`
--

DROP TABLE IF EXISTS `article`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `article` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date` datetime NOT NULL,
  `html` text COLLATE utf8mb4_general_ci NOT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `photosrc` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `article`
--

LOCK TABLES `article` WRITE;
/*!40000 ALTER TABLE `article` DISABLE KEYS */;
INSERT INTO `article` VALUES (17,'pavadinimas&quot;&quot;&quot;&quot;ticl&amp;lt&amp;gt&#039;&lt;&gt;awdwa ','info','2025-06-25 10:48:54','<p>EDITED a&lt;h1&gt;rticl&amp;lt&amp;gt\'awdwa \" \" awd\" a\"wd&amp;lt&amp;gt \'awdwa \"\" awdawd&amp;lt&amp;gt\'awdwa \"\" awdawde &amp;lt&amp;gt &amp;&amp;&amp; 17Skundžiant&lt;&lt;&lt;&lt;&lt;&lt;&lt;h1&gt; institucijos veiksmus ar sprendimus, būtina aiškiai nurodyti savo duomenis, ginčo esmę, kokių veiksmų tikiesi ir pridėti aktualius dokumentus. Taip pat svarbu žinoti, per kokį terminą reikia pateikti skundą – dažniausiai tai yra 1 mėnuo nuo sprendimo gavimo. Nepaisant turinio, sk\" \'\"\" \'\"\" \'\"\" \'\"\" \'\"\" \'\"undas turi būti mandagus, logiškas ir dokumentuotas. D ėl specifinių atvejų verta pasitarti su teisininku arba kreiptis į Valstybinę garantuojamos teisin&lt;&lt;&lt;&lt;&lt;&lt;&lt;ės pagalbos tarnybą.</p><p>&lt;&lt;&lt;&lt;</p><p>\" \' \"</p><p>\" \'\"\" \'\"\" \'\"</p><p>\" \'\"\" \'\"\" \'\"\" \'\"\" \'\"\" \'\"</p><p><br></p><p>&amp;lt&amp;gt\'awdwa \"\" awdawd&amp;lt&amp;gt\'awdwa \"\" awdawd</p><p><br></p><p><br></p><p><br></p><p><br></p><p><br></p><p><br></p><p><br></p><p><br></p><p><br></p><p><br></p><p><br></p><p><br></p><p><br></p><p><br></p><p><br></p><p><br></p><p><br></p><p><br></p><p><br></p><p><br></p><p><br></p><p><br></p><p><br></p><p><br></p><p><br></p><p><br></p><p><br></p><p><br></p><p><br></p><p><br></p><p><br></p><p><br></p><p><br></p><p><br></p><p><br></p>','pavadinimas',NULL),(18,'Smulkus verslas ir teisiniai reikalavimai: ką būtina žinoti?','info','2025-06-22 13:35:45','<p>Smulkusis verslas Lietuvoje gali veikti įvairiomis formomis: individuali veikla, mažoji bendrija, UAB ir kt. Kiekviena iš jų turi savo privalumų bei pareigų – mokesčių dydis, atsakomybės apimtis, reikalavimai dokumentacijai. Viena dažniausių klaidų – neturėti rašytinių sutarčių su klientais ar tiekėjais. Net ir mažose operacijose svarbu užfiksuoti sąlygas. Verslo pradžioje rekomenduojama turėti teisininko konsultaciją dėl pagrindinių dokumentų šablonų.</p>','Pradedant verslą dažnai susiduriama su teisinių žinių stoka. Tinkamai pasirinkta įmonės forma, apskaita ir sutarčių rengimas gali apsaugoti nuo finansinių bei teisių pažeidimų ateityje.',NULL),(19,'Elektroninis parašas: ar jis turi tokią pačią galią kaip fizinis?','info','2025-06-22 13:36:03','<p>Elektroninis parašas (pvz., mobilusis parašas ar Smart-ID) yra plačiai pripažįstamas dokumentų pasirašymo būdas tiek viešajame, tiek privačiame sektoriuje. Jo teisinę galią reglamentuoja ES eIDAS reglamentas ir Lietuvos elektroninės atpažinties įstatymas. Pasirašant dokumentą su kvalifikuotu e. parašu, jis laikomas lygiaverčiu ranka rašytam, ir teisme turi tokią pačią juridinę galią. Be to, naudojant e. parašą taupomas laikas, išvengiama kelionių ir galima pasirašyti dokumentus nuotoliniu būdu – net iš užsienio.</p>','Lietuvoje elektroninis parašas turi tokią pačią teisinę galią kaip ir ranka rašytas. Tačiau daugelis vis dar vengia juo naudotis dėl neaiškumo ar baimių dėl saugumo.',NULL),(27,'Ar Atsinaujins Cache?','info','2025-06-23 22:37:40','<h2>STRAIPSNIO TEKSTAS</h2><h2><br></h2>','Manau, kad taip',NULL),(28,'fds','info','2025-06-23 22:47:36','<h2><br></h2>','f',NULL),(29,'fds','info','2025-06-23 22:48:52','<h2>STRAIPSNIO TEKSTAS</h2><h2><br></h2>','fsd',NULL),(30,'Straipsnio pavadinimas100','info','2025-06-25 08:50:10','<p>STRAIPSNIO TEKSTAS 100</p>','Straipsnio aprašymas',NULL),(31,'2222Skundas institucijai: kaip tinkamai parengti pareiškimą?','info','2025-06-25 10:03:38','<p>22222222222Skundžiant institucijos veiksmus ar sprendimus, būtina aiškiai nurodyti savo duomenis, ginčo esmę, kokių veiksmų tikiesi ir pridėti aktualius dokumentus. Taip pat svarbu žinoti, per kokį terminą reikia pateikti skundą – dažniausiai tai yra 1 mėnuo nuo sprendimo gavimo. Nepaisant turinio, skundas turi būti mandagus, logiškas ir dokumentuotas. Dėl specifinių atvejų verta pasitarti su teisininku arba kreiptis į Valstybinę garantuojamos teisinės pagalbos tarnybą.</p><p><br></p><p><br></p>','2222Daugelis gyventojų nežino, kad neteisingai parengtas skundas gali būti atmestas formaliais pagrindais. Tinkamai struktūruotas pareiškimas padidina tikimybę, kad tavo situacija bus išnagrinėta greitai ir veiksmingai.',NULL),(32,'newStraipsnio pavadinimas','lawyer','2025-06-25 10:55:15','<p>newSTRAIPSNIO TEKSTAS</p>','Straipsnio aprašymas',NULL),(33,'neweditStraipsnio pavadinimas','lawyer','2025-06-25 10:55:51','<p>neweditSTRAIPSNIO TEKSTAS</p>','Straipsnio aprašymas',NULL),(68,'Straipsnio pavadinimas','info','2025-06-25 13:24:34','<p>STRAIPSNIO TEKSTAS</p><p><br></p><p><br></p><p><br></p><p><br></p><p><br></p>','Straipsnio aprašymas','static/images/articleImages/cat.jpg'),(69,'69Straipsnio pavadinimas','info','2025-06-25 14:28:57','<p>69STRAIPSNIO TEKSTAS</p>','69Straipsnio aprašymas','static/images/articleImages/HERBAS.JPG');
/*!40000 ALTER TABLE `article` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'advokatas001'
--
