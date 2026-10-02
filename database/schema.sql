-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 23, 2025 at 09:57 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `advokatas001`
--

-- --------------------------------------------------------

--
-- Table structure for table `article`
--

CREATE TABLE `article` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `type` varchar(255) DEFAULT NULL,
  `date` datetime NOT NULL,
  `html` text NOT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `article`
--

INSERT INTO `article` (`id`, `name`, `type`, `date`, `html`, `description`) VALUES
(17, 'Skundas institucijai: kaip tinkamai parengti pareiškimą?', 'info', '2025-06-22 13:35:09', '<p>Skundžiant institucijos veiksmus ar sprendimus, būtina aiškiai nurodyti savo duomenis, ginčo esmę, kokių veiksmų tikiesi ir pridėti aktualius dokumentus. Taip pat svarbu žinoti, per kokį terminą reikia pateikti skundą – dažniausiai tai yra 1 mėnuo nuo sprendimo gavimo. Nepaisant turinio, skundas turi būti mandagus, logiškas ir dokumentuotas. Dėl specifinių atvejų verta pasitarti su teisininku arba kreiptis į Valstybinę garantuojamos teisinės pagalbos tarnybą.</p>', 'Daugelis gyventojų nežino, kad neteisingai parengtas skundas gali būti atmestas formaliais pagrindais. Tinkamai struktūruotas pareiškimas padidina tikimybę, kad tavo situacija bus išnagrinėta greitai ir veiksmingai.'),
(18, 'Smulkus verslas ir teisiniai reikalavimai: ką būtina žinoti?', 'info', '2025-06-22 13:35:45', '<p>Smulkusis verslas Lietuvoje gali veikti įvairiomis formomis: individuali veikla, mažoji bendrija, UAB ir kt. Kiekviena iš jų turi savo privalumų bei pareigų – mokesčių dydis, atsakomybės apimtis, reikalavimai dokumentacijai. Viena dažniausių klaidų – neturėti rašytinių sutarčių su klientais ar tiekėjais. Net ir mažose operacijose svarbu užfiksuoti sąlygas. Verslo pradžioje rekomenduojama turėti teisininko konsultaciją dėl pagrindinių dokumentų šablonų.</p>', 'Pradedant verslą dažnai susiduriama su teisinių žinių stoka. Tinkamai pasirinkta įmonės forma, apskaita ir sutarčių rengimas gali apsaugoti nuo finansinių bei teisių pažeidimų ateityje.'),
(19, 'Elektroninis parašas: ar jis turi tokią pačią galią kaip fizinis?', 'info', '2025-06-22 13:36:03', '<p>Elektroninis parašas (pvz., mobilusis parašas ar Smart-ID) yra plačiai pripažįstamas dokumentų pasirašymo būdas tiek viešajame, tiek privačiame sektoriuje. Jo teisinę galią reglamentuoja ES eIDAS reglamentas ir Lietuvos elektroninės atpažinties įstatymas. Pasirašant dokumentą su kvalifikuotu e. parašu, jis laikomas lygiaverčiu ranka rašytam, ir teisme turi tokią pačią juridinę galią. Be to, naudojant e. parašą taupomas laikas, išvengiama kelionių ir galima pasirašyti dokumentus nuotoliniu būdu – net iš užsienio.</p>', 'Lietuvoje elektroninis parašas turi tokią pačią teisinę galią kaip ir ranka rašytas. Tačiau daugelis vis dar vengia juo naudotis dėl neaiškumo ar baimių dėl saugumo.'),
(27, 'Ar Atsinaujins Cache?', 'info', '2025-06-23 22:37:40', '<h2>STRAIPSNIO TEKSTAS</h2><h2><br></h2>', 'Manau, kad taip'),
(28, 'fds', 'info', '2025-06-23 22:47:36', '<h2><br></h2>', 'f'),
(29, 'fds', 'info', '2025-06-23 22:48:52', '<h2>STRAIPSNIO TEKSTAS</h2><h2><br></h2>', 'fsd');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `article`
--
ALTER TABLE `article`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `article`
--
ALTER TABLE `article`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
