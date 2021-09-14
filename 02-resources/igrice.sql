SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `igrice`
--

-- --------------------------------------------------------

--
-- Table structure for table `catalog`
--

CREATE TABLE `catalog` (
  `id` int(11) NOT NULL,
  `catalog_show` bit(1) NOT NULL,
  `price` decimal(30,2) NOT NULL,
  `discount` decimal(30,2) DEFAULT NULL,
  `review` decimal(10,0) DEFAULT NULL,
  `idGame` int(11) NOT NULL,
  `idUser` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



/*!40000 ALTER TABLE `catalog` DISABLE KEYS */;
INSERT INTO `catalog` (`id`, `catalog_show`, `price`, `discount`, `review`, `idGame`, `idUser`) VALUES
	(16, '1', '100', '0', '5', 1, 1, 1),
	(17, '1', '80', '0', '7', 1, 2, 2),
	(18, '1', '35', '0', '4', 1, 3, 1),
	(19, '1', '40', '0', '7', 1, 4, 3),
	(20, '1', '75', '0', '3', 1, 5, 1);
/*!40000 ALTER TABLE `catalog` ENABLE KEYS */;
-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `id` int(11) NOT NULL,
  `catergory` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `category` (`id`, `category`) VALUES
	(1, '1'),
	(2, '2');
-- --------------------------------------------------------

--
-- Table structure for table `city`
--

CREATE TABLE `city` (
  `id` int(11) NOT NULL,
  `city` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `category` (`id`, `city`) VALUES
	(1, 'Beograd'),
	(2, 'Novi Sad');
-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `id` int(11) NOT NULL,
  `comment` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `rate` int(11) NOT NULL,
  `status` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `admin_review` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `idUser` int(11) NOT NULL,
  `idGame` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `comments` (`id`, `comment`,`rate`,`status`,`admin_review`,`idUser`,`idGame`) VALUES
(1,'Igrica je u top 10 igara koje sam ikada odigrao','10','Odobren komentar','Validan komentar','1','2'),
(2,'Igrica nije zadovoljila moje standarde','4','Odobren komentar','Validan komentar','2','5'),
(3,'Igrica je zadovoljavajuca','7', 'Komentar na cekanju','Komentar u razmatranju','3','4');


-- --------------------------------------------------------

--
-- Table structure for table `esrb`
--

CREATE TABLE `esrb` (test
  `id` int(11) NOT NULL,
  `title` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `esrb` (`id`, `title`) VALUES
(1,'GTA V'),
(2,'FIFA 2021'),
(3,'Elder Scrolls V Skyrim Special Edition'),
(4,'Witcher 3 Wild Hunt'),
(5,'Assassins Creed Vallhala');
-- --------------------------------------------------------

--
-- Table structure for table `games`
--

CREATE TABLE `games` (
  `id` int(11) NOT NULL,
  `title` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `released` int(4) NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `idEsrb` int(11) NOT NULL,
  `idCategory` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `esrb` (`id`, `title`,`released`,`description`,`idEsrb`,`idCategory`) VALUES
(1,'GTA V',`2021`,`Igrica za pc`,`1`,`1`),
(2,'FIFA 2021'`2021`,`Igrica za playstation`,`2`,`2`),
(3,'Elder Scrolls V Skyrim Special Edition',`2011`,`Igrica za pc`,`3`,`1`),
(4,'Witcher 3 Wild Hunt'`2015`,`Igrica za playstation`,`4`,`2`),
(5,'Assassins Creed Vallhala'`2019`,`Igrica za pc`,`5`,`1`);
-- --------------------------------------------------------

--
-- Table structure for table `game_platform`
--

CREATE TABLE `game_platform` (
  `id` int(11) NOT NULL,
  `idGame` int(11) NOT NULL,
  `idPlatform` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `game_platform` (`id`, `idGame`,`idPlatform`) VALUES
(1,`1`,`1`),
(2,`2`,`2`),
(3,`3`,`1`),
(4,`4`,`2`),
(5,`5`,`1`);


-- --------------------------------------------------------

--
-- Table structure for table `platform`
--

CREATE TABLE `platform` (
  `id` int(11) NOT NULL,
  `type` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `platform` (`id`, `type`,`idPlatform`) VALUES
(1,`Igrica za pc`),
(2,`Igrica za playstation`),
(3,`Igrica za pc`),
(4,`Igrica za playstation`),
(5,`Igrica za pc`);

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` int(11) NOT NULL,
  `roles` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `roles` (`id`,`roles`) VALUES 
(1,`Administrator`),
(2,`Korisnik`)
-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `first_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `telephone` int(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `idRole` int(11) NOT NULL,
  `idCity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


INSERT INTO `users` (`id`, `first_name`,`last_name`,`address`,`password`,`email`,`telephone`,`idRole`,`idCity`) VALUES
(1,'Mladen',`Paunovic`,`Stojana Protica 12`,`e64b78fc3bc91bcbc7dc232ba8ec59e0`,`mladenp@gmail.com`,`06222770`,`1`,`1`),
(2,'Ivan',`Mladenovic`,`Stojana Protica 30`,`60c5b02d7e7c682f4d56a64d99b9731a`,`ivanm@gmail.com`,`06227725`,`2`,`2`),
(3,'Milan',`Miladinovic`,`Vojvode Stepe 302`,`a3fda065bed7bb3979fd1f8f820233d9`,`mmilan@gmail.com`,`0642207730`,`2`,`1`);

CREATE TABLE `manufacturer` (
  `id` int(11) NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL
  `idGame` int(11) NOT NULL,
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

  INSERT INTO `users` (`id`, `name`,`idGame`) VALUES
(1,'Rockstar',`1`),
(2,'Bethesda',`3`);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `catalog`
--
ALTER TABLE `catalog`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idGame` (`idGame`),
  ADD KEY `idUser` (`idUser`);

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `city`
--
ALTER TABLE `city`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idGame` (`idGame`),
  ADD KEY `idUser` (`idUser`);

--
-- Indexes for table `esrb`
--
ALTER TABLE `esrb`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `games`
--
ALTER TABLE `games`
  ADD PRIMARY KEY (`id`),
  ADD KEY `games_ibfk_1` (`idEsrb`),
  ADD KEY `idCategory` (`idCategory`);

--
-- Indexes for table `game_platform`
--
ALTER TABLE `game_platform`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idGame` (`idGame`),
  ADD KEY `idPlatform` (`idPlatform`);

--
-- Indexes for table `platform`
--
ALTER TABLE `platform`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idCity` (`idCity`),
  ADD KEY `idRole` (`idRole`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `catalog`
--
ALTER TABLE `catalog`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `city`
--
ALTER TABLE `city`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `esrb`
--
ALTER TABLE `esrb`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `games`
--
ALTER TABLE `games`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `game_platform`
--
ALTER TABLE `game_platform`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `platform`
--
ALTER TABLE `platform`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `catalog`
--
ALTER TABLE `catalog`
  ADD CONSTRAINT `catalog_ibfk_1` FOREIGN KEY (`idGame`) REFERENCES `games` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `catalog_ibfk_2` FOREIGN KEY (`idUser`) REFERENCES `users` (`id`);

--
-- Constraints for table `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`idGame`) REFERENCES `games` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`idUser`) REFERENCES `users` (`id`);

--
-- Constraints for table `games`
--
ALTER TABLE `games`
  ADD CONSTRAINT `games_ibfk_1` FOREIGN KEY (`idEsrb`) REFERENCES `esrb` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `games_ibfk_2` FOREIGN KEY (`idCategory`) REFERENCES `category` (`id`);

--
-- Constraints for table `game_platform`
--
ALTER TABLE `game_platform`
  ADD CONSTRAINT `game_platform_ibfk_1` FOREIGN KEY (`idGame`) REFERENCES `games` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `game_platform_ibfk_2` FOREIGN KEY (`idPlatform`) REFERENCES `platform` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`idCity`) REFERENCES `city` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `users_ibfk_2` FOREIGN KEY (`idRole`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
mysql