-- Adminer 4.7.7 MySQL dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

SET NAMES utf8mb4;

DROP TABLE IF EXISTS `file_id`;
CREATE TABLE `file_id` (
  `_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(36) NOT NULL,
  PRIMARY KEY (`_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `file_id` (`_id`, `name`) VALUES
(1,	'test'),
(2,	'1234'),
(3,	'123'),
(4,	'12345');

DROP TABLE IF EXISTS `items`;
CREATE TABLE `items` (
  `_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `file_name` varchar(512) NOT NULL,
  `original_name` varchar(512) NOT NULL,
  `file_size` bigint(20) unsigned NOT NULL,
  `owner` int(10) unsigned DEFAULT NULL,
  `file_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`_id`),
  KEY `uuid` (`file_id`),
  CONSTRAINT `items_ibfk_1` FOREIGN KEY (`file_id`) REFERENCES `file_id` (`_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `items` (`_id`, `file_name`, `original_name`, `file_size`, `owner`, `file_id`) VALUES
(3,	'pom12.xml',	'pom.xml',	1636,	NULL,	4);

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(24) NOT NULL,
  `password` varchar(64) NOT NULL,
  PRIMARY KEY (`_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `user` (`_id`, `name`, `password`) VALUES
(1,	'admin',	'be9ad412f783dc9dd6c557e9a80cfdb4c45f0e5f4e6183e999f50026a1250c8c');

-- 2020-12-03 02:18:49