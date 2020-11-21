-- Adminer 4.7.7 MySQL dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

SET NAMES utf8mb4;

DROP TABLE IF EXISTS `items`;
CREATE TABLE `items` (
  `_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `original_name` varchar(256) NOT NULL,
  `owner` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


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

-- 2020-11-21 05:57:00
