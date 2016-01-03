-- phpMyAdmin SQL Dump
-- version 4.0.10.7
-- http://www.phpmyadmin.net
--
-- Host: localhost:3306
-- Generation Time: Jan 02, 2016 at 05:46 PM
-- Server version: 5.1.73-cll
-- PHP Version: 5.4.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `poo`
--

-- --------------------------------------------------------

--
-- Table structure for table `buildings`
--

CREATE TABLE IF NOT EXISTS `buildings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` text NOT NULL,
  `slug` tinytext NOT NULL,
  `type` set('academic','administrative','athletic','other','residential','restaurant','test') NOT NULL DEFAULT 'academic',
  `location` set('north','south','off') NOT NULL DEFAULT 'off',
  `latitude` float NOT NULL,
  `longitude` float NOT NULL,
  `blurb` text,
  `updated` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=55 ;

--
-- Dumping data for table `buildings`
--

INSERT INTO `buildings` (`id`, `name`, `slug`, `type`, `location`, `latitude`, `longitude`, `blurb`, `updated`) VALUES
(6, 'A.W. Smith Building', 'aw-smith', 'academic', 'south', 41.503, -81.6069, NULL, '0000-00-00 00:00:00'),
(7, 'Bellflower Hall', 'bellflower', 'academic', 'north', 41.5119, -81.6052, NULL, '0000-00-00 00:00:00'),
(8, 'Bingham Building', 'bingham', 'academic', 'south', 41.5025, -81.6069, NULL, '0000-00-00 00:00:00'),
(9, 'Clark Hall', 'clark-hall', 'academic', 'north', 41.509, -81.6075, NULL, '0000-00-00 00:00:00'),
(13, 'Dively Building', 'dively', 'academic', 'north', 41.5102, -81.6066, NULL, '0000-00-00 00:00:00'),
(14, 'Eldred Hall', 'eldred', 'academic', 'south', 41.504, -81.6078, NULL, '0000-00-00 00:00:00'),
(16, 'Glennan Building', 'glennan', 'academic', 'south', 41.5016, -81.6072, NULL, '0000-00-00 00:00:00'),
(17, 'Guilford House', 'guilford-house', 'academic', 'north', 41.5085, -81.6082, NULL, '0000-00-00 00:00:00'),
(19, 'Harkness Chapel', 'harkness-chapel', 'academic', 'north', 41.5093, -81.6075, NULL, '0000-00-00 00:00:00'),
(20, 'Haydn Hall', 'haydn-hall', 'academic', 'north', 41.5086, -81.6077, NULL, '0000-00-00 00:00:00'),
(21, 'Mandel Community Center', 'mandel-community-center', 'academic', 'north', 41.511, -81.6056, NULL, '0000-00-00 00:00:00'),
(22, 'Kelvin Smith Library', 'ksl', 'academic', 'north', 41.5073, -81.6095, '<p>A <a href="http://library.case.edu/ksl/services/facilities/maps/">floor map can be found here</a> (requires Flash).</p>', '0000-00-00 00:00:00'),
(23, 'Kent Hale Smith Building', 'kent-hale-smith', 'academic', 'south', 41.5033, -81.6066, NULL, '0000-00-00 00:00:00'),
(24, 'Mandel School', 'msass', 'academic', 'north', 41.5104, -81.6072, NULL, '0000-00-00 00:00:00'),
(26, 'Mather House', 'mather-house', 'academic', 'north', 41.5079, -81.6079, NULL, '0000-00-00 00:00:00'),
(27, 'Mather Memorial Building', 'mather-memorial-building', 'academic', 'north', 41.5096, -81.6071, NULL, '0000-00-00 00:00:00'),
(28, 'Morley Building', 'morley', 'academic', 'south', 41.504, -81.607, '<p class="warning">Morley may be closed pending hazmat cleanup. Go at your own risk.</p>', '2014-09-08 21:12:26'),
(29, 'Nord Hall', 'nord', 'academic', 'south', 41.5026, -81.6079, NULL, '0000-00-00 00:00:00'),
(30, 'Olin Building', 'olin', 'academic', 'south', 41.5022, -81.6078, NULL, '0000-00-00 00:00:00'),
(31, 'Peter B. Lewis Building', 'pbl', 'academic', 'north', 41.5098, -81.6079, NULL, '0000-00-00 00:00:00'),
(32, 'Rockefeller Building', 'rockefeller', 'academic', 'south', 41.5036, -81.6078, NULL, '0000-00-00 00:00:00'),
(33, 'Sears Building', 'sears', 'academic', 'south', 41.5027, -81.6082, NULL, '0000-00-00 00:00:00'),
(34, 'Strosacker Auditorium', 'strosacker', 'academic', 'south', 41.5033, -81.6075, NULL, '0000-00-00 00:00:00'),
(35, 'White Building', 'white', 'academic', 'south', 41.502, -81.6075, NULL, '0000-00-00 00:00:00'),
(36, 'Wickenden Building', 'wickenden', 'academic', 'south', 41.5031, -81.6085, NULL, '0000-00-00 00:00:00'),
(37, 'Yost Hall', 'yost', 'academic', 'south', 41.5036, -81.609, NULL, '0000-00-00 00:00:00'),
(38, 'Adelbert Hall', 'adelbert-hall', 'administrative', 'south', 41.5048, -81.6082, NULL, '0000-00-00 00:00:00'),
(39, 'Allen Memorial Library', 'allen-library', 'administrative', 'south', 41.506, -81.6084, NULL, '0000-00-00 00:00:00'),
(41, 'Crawford Hall', 'crawford', 'administrative', 'south', 41.5046, -81.6098, NULL, '0000-00-00 00:00:00'),
(42, 'Thwing Center', 'thwing', 'administrative', 'north', 41.5074, -81.6084, '<p>A <a href="https://students.case.edu/thwing/facilities/floorplan/">floor map can be found here</a>.</p>', '0000-00-00 00:00:00'),
(43, 'Tinkham Veale Center', 'tinkham-veale', 'administrative', 'north', 41.5081, -81.6093, NULL, '0000-00-00 00:00:00'),
(44, 'Tomlinson Hall', 'tomlinson', 'administrative', 'south', 41.504, -81.6096, NULL, '0000-00-00 00:00:00'),
(45, 'Wolstein Hall', 'wolstein', 'administrative', 'north', 41.5107, -81.6059, NULL, '0000-00-00 00:00:00'),
(46, 'Veale Center', 'veale', 'athletic', 'south', 41.5014, -81.6055, NULL, '0000-00-00 00:00:00'),
(47, 'Adelbert Gym', 'adelbert-gym', 'athletic', 'south', 41.5031, -81.6059, NULL, '0000-00-00 00:00:00'),
(48, 'Wade Commons', 'wade', 'other', 'north', 41.513, -81.6052, NULL, '0000-00-00 00:00:00'),
(49, 'Leutner Commons', 'leutner', 'other', 'north', 41.5136, -81.606, NULL, '0000-00-00 00:00:00'),
(50, 'Fribley Commons', 'fribley', 'other', 'south', 41.5011, -81.6027, NULL, '0000-00-00 00:00:00'),
(51, 'Carlton Commons', 'carlton', 'other', 'south', 41.5003, -81.6018, NULL, '0000-00-00 00:00:00'),
(52, 'Clapp Hall', 'clapp', 'academic', 'south', 41.5039, -81.6067, '<p>Also known as Agnar Pytte Science Center. Contains Hovorka Atrium.</p>', '2014-09-08 21:09:42'),
(53, 'DeGrace Hall', 'degrace', 'academic', 'south', 41.5042, -81.6071, NULL, NULL),
(54, 'Millis Schmitt Hall', 'millis-schmitt', 'academic', 'south', 41.5038, -81.6068, '<p>Includes Schmitt Auditorium.</p>', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `floors`
--

CREATE TABLE IF NOT EXISTS `floors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` tinytext,
  `slug` tinytext NOT NULL,
  `building_id` int(11) NOT NULL,
  `level` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=175 ;

--
-- Dumping data for table `floors`
--

INSERT INTO `floors` (`id`, `name`, `slug`, `building_id`, `level`) VALUES
(3, NULL, '1', 49, 1),
(4, 'L3', 'l3', 49, -1),
(5, NULL, '1', 6, 1),
(6, NULL, '2', 6, 2),
(7, NULL, '3', 6, 3),
(8, NULL, '4', 6, 4),
(9, NULL, '1', 7, 1),
(10, NULL, '1', 8, 1),
(11, NULL, '2', 8, 2),
(12, NULL, '3', 8, 3),
(13, 'B1', 'b1', 8, -1),
(14, NULL, '1', 9, 1),
(15, NULL, '2', 9, 2),
(16, NULL, '3', 9, 3),
(17, NULL, '4', 9, 4),
(18, NULL, '1', 13, 1),
(19, NULL, '2', 13, 2),
(20, NULL, '1', 16, 1),
(21, NULL, '2', 16, 2),
(22, NULL, '3', 16, 3),
(23, NULL, '4', 16, 4),
(24, NULL, '5', 16, 5),
(25, NULL, '6', 16, 6),
(26, NULL, '7', 16, 7),
(27, NULL, '8', 16, 8),
(28, 'B1', 'b1', 17, -1),
(29, NULL, '1', 17, 1),
(30, NULL, '2', 17, 2),
(31, NULL, '3', 17, 3),
(32, NULL, '1', 19, 1),
(33, 'B1', 'b1', 20, -1),
(34, NULL, '1', 20, 1),
(35, NULL, '2', 20, 2),
(36, NULL, '3', 20, 3),
(37, NULL, '1', 21, 1),
(38, NULL, '2', 21, 2),
(39, 'LL', 'll', 22, -1),
(40, NULL, '1', 22, 1),
(41, NULL, '2', 22, 2),
(42, NULL, '3', 22, 3),
(43, NULL, '1', 23, 1),
(44, NULL, '2', 23, 2),
(45, NULL, '3', 23, 3),
(46, NULL, '4', 23, 4),
(47, NULL, '5', 23, 5),
(48, NULL, '1', 26, 1),
(49, NULL, '2', 26, 2),
(50, NULL, '3', 26, 3),
(51, NULL, '4', 26, 4),
(52, 'B1', 'b1', 27, -1),
(53, NULL, '1', 27, 1),
(54, NULL, '2', 27, 2),
(55, 'B1', 'b1', 28, -1),
(56, NULL, '1', 28, 1),
(57, NULL, '2', 28, 2),
(58, NULL, '3', 28, 3),
(59, NULL, '1', 29, 1),
(60, NULL, '2', 29, 2),
(61, NULL, '3', 29, 3),
(62, NULL, '4', 29, 4),
(63, NULL, '1', 30, 1),
(64, NULL, '2', 30, 2),
(65, NULL, '3', 30, 3),
(66, NULL, '4', 30, 4),
(67, NULL, '5', 30, 5),
(68, NULL, '6', 30, 6),
(69, NULL, '7', 30, 7),
(70, NULL, '8', 30, 8),
(71, 'LL', 'll', 31, -1),
(72, NULL, '1', 31, 1),
(73, NULL, '2', 31, 2),
(74, NULL, '3', 31, 3),
(75, NULL, '4', 31, 4),
(76, NULL, '5', 31, 5),
(77, NULL, '1', 32, 1),
(78, NULL, '2', 32, 2),
(79, NULL, '3', 32, 3),
(80, NULL, '4', 32, 4),
(81, NULL, '1', 33, 1),
(82, NULL, '2', 33, 2),
(83, NULL, '3', 33, 3),
(84, NULL, '4', 33, 4),
(85, NULL, '5', 33, 5),
(86, NULL, '6', 33, 6),
(87, NULL, '1', 34, 1),
(88, NULL, '1', 35, 1),
(89, NULL, '2', 35, 2),
(90, NULL, '3', 35, 3),
(91, NULL, '4', 35, 4),
(92, NULL, '5', 35, 5),
(93, NULL, '1', 36, 1),
(94, NULL, '2', 36, 2),
(95, NULL, '3', 36, 3),
(96, NULL, '4', 36, 4),
(97, NULL, '5', 36, 5),
(98, NULL, '1', 37, 1),
(99, NULL, '2', 37, 2),
(100, NULL, '3', 37, 3),
(101, NULL, '4', 37, 4),
(102, 'LL', 'll', 42, -1),
(103, NULL, '1', 42, 1),
(104, NULL, '2', 42, 2),
(105, NULL, '3', 42, 3),
(106, NULL, '1', 44, 1),
(107, NULL, '2', 44, 2),
(108, NULL, '3', 44, 3),
(109, NULL, '1', 45, 1),
(110, NULL, '2', 45, 2),
(111, NULL, '1', 47, 1),
(112, NULL, '1', 48, 1),
(115, 'B1', 'basement', 14, -1),
(116, NULL, '1', 14, 1),
(117, NULL, '2', 14, 2),
(118, NULL, '3', 14, 3),
(125, NULL, '1', 24, 1),
(126, NULL, '2', 24, 2),
(127, NULL, '3', 24, 3),
(128, 'B1', 'basement', 6, -1),
(129, NULL, '1', 50, 1),
(130, NULL, '2', 50, 2),
(131, NULL, '1', 51, 1),
(132, NULL, '2', 51, 2),
(133, NULL, '1', 46, 1),
(134, NULL, '2', 46, 2),
(135, NULL, '3', 46, 3),
(136, NULL, '4', 46, 4),
(137, 'LL', 'll', 41, -1),
(138, NULL, '1', 41, 1),
(139, NULL, '2', 41, 2),
(140, NULL, '3', 41, 3),
(141, NULL, '4', 41, 4),
(142, NULL, '5', 41, 5),
(143, NULL, '6', 41, 6),
(144, NULL, '7', 41, 7),
(149, 'B1', 'b1', 38, -1),
(150, NULL, '1', 38, 1),
(151, NULL, '2', 38, 2),
(152, NULL, '3', 38, 3),
(153, NULL, '4', 38, 4),
(154, NULL, '1', 43, 1),
(155, NULL, '2', 43, 2),
(156, 'B1', 'b1', 39, -1),
(157, NULL, '1', 39, 1),
(158, NULL, '2', 39, 2),
(159, NULL, '3', 39, 3),
(160, 'B1', 'b1', 43, -1),
(161, NULL, '1', 52, 1),
(164, NULL, '1', 53, 1),
(165, NULL, '2', 53, 2),
(166, NULL, '3', 53, 3),
(167, NULL, '1', 54, 1),
(168, NULL, '2', 52, 2),
(169, NULL, '3', 52, 3),
(170, NULL, '4', 52, 4),
(171, NULL, '2', 54, 2),
(172, NULL, '3', 54, 3),
(173, NULL, '2', 34, 2),
(174, 'LL', 'll', 47, -1);

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

CREATE TABLE IF NOT EXISTS `reviews` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `toilet_id` int(11) NOT NULL,
  `user` tinytext NOT NULL,
  `datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `cleanliness` tinyint(4) DEFAULT NULL,
  `location` tinyint(4) DEFAULT NULL,
  `wifi` tinyint(4) DEFAULT NULL,
  `writing` tinyint(4) DEFAULT NULL,
  `traffic` tinyint(4) DEFAULT NULL,
  `toilet_paper` tinyint(4) DEFAULT NULL,
  `overall` tinyint(4) DEFAULT NULL,
  `comments` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=108 ;

-- --------------------------------------------------------

--
-- Table structure for table `toilets`
--

CREATE TABLE IF NOT EXISTS `toilets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` tinytext NOT NULL,
  `slug` tinytext NOT NULL,
  `gender` set('male','female','other') NOT NULL DEFAULT 'male',
  `building_id` int(11) NOT NULL,
  `floor_id` int(11) NOT NULL,
  `verified` tinyint(1) NOT NULL,
  `stalls` int(11) DEFAULT NULL,
  `urinals` int(11) DEFAULT NULL,
  `sinks` int(11) DEFAULT NULL,
  `comments` text,
  `user` tinytext,
  `updated` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=114 ;


-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `case_id` varchar(8) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
  `gender` set('male','female','both') NOT NULL DEFAULT 'both',
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `joined` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `admin` tinyint(1) NOT NULL DEFAULT '0',
  UNIQUE KEY `case_id` (`case_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
