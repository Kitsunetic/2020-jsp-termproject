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
(5,	'123456'),
(6,	'waerawerwar'),
(7,	'aewfwaefwafeawefwa'),
(8,	'qwdqwdqwdqwdqwdwfq'),
(9,	'zxcv'),
(10,	'ㄻㄴㅇㅇㄴㅁㅍㄴㅁㅇㅍ'),
(11,	'awgwagawafdsfgd'),
(19,	'12345'),
(20,	'12345'),
(21,	'12345'),
(22,	'x'),
(23,	'XX');

DROP TABLE IF EXISTS `items`;
CREATE TABLE `items` (
                         `_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
                         `file_name` varchar(512) NOT NULL,
                         `original_name` varchar(512) NOT NULL,
                         `file_size` bigint(20) unsigned NOT NULL,
                         `owner` int(10) unsigned DEFAULT NULL,
                         `file_id` int(10) unsigned NOT NULL,
                         `owner_only` bit(1) NOT NULL DEFAULT b'0',
                         `password` varchar(64) DEFAULT NULL,
                         PRIMARY KEY (`_id`),
                         KEY `uuid` (`file_id`),
                         KEY `owner` (`owner`),
                         CONSTRAINT `items_ibfk_1` FOREIGN KEY (`file_id`) REFERENCES `file_id` (`_id`) ON DELETE CASCADE ON UPDATE CASCADE,
                         CONSTRAINT `items_ibfk_2` FOREIGN KEY (`owner`) REFERENCES `user` (`_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `items` (`_id`, `file_name`, `original_name`, `file_size`, `owner`, `file_id`, `owner_only`, `password`) VALUES
(4,	'demo.iml',	'demo.iml',	2938,	NULL,	5,	CONV('0', 2, 10) + 0,	NULL),
(5,	'README10.md',	'README.md',	211,	NULL,	6,	CONV('0', 2, 10) + 0,	NULL),
(6,	'docker-compose4.yml',	'docker-compose.yml',	602,	NULL,	7,	CONV('0', 2, 10) + 0,	NULL),
(7,	'pom13.xml',	'pom.xml',	1636,	NULL,	8,	CONV('0', 2, 10) + 0,	NULL),
(8,	'README11.md',	'README.md',	211,	NULL,	9,	CONV('0', 2, 10) + 0,	NULL),
(9,	'docker-compose6.yml',	'docker-compose.yml',	602,	NULL,	10,	CONV('0', 2, 10) + 0,	NULL),
(10,	'docker-compose7.yml',	'docker-compose.yml',	602,	NULL,	11,	CONV('0', 2, 10) + 0,	NULL),
(18,	'stack1.cpp',	'stack.cpp',	511,	NULL,	19,	CONV('0', 2, 10) + 0,	NULL),
(19,	'queue_circular.cpp',	'queue_circular.cpp',	1165,	7,	20,	CONV('0', 2, 10) + 0,	NULL),
(20,	'중후위식.cpp',	'중후위식.cpp',	1071,	7,	21,	CONV('1', 2, 10) + 0,	NULL),
(21,	'bag1.cpp',	'bag.cpp',	271,	7,	22,	CONV('0', 2, 10) + 0,	NULL),
(22,	'중후위식1.cpp',	'중후위식.cpp',	1071,	7,	22,	CONV('0', 2, 10) + 0,	NULL),
(23,	'bag2.cpp',	'bag.cpp',	271,	NULL,	23,	CONV('0', 2, 10) + 0,	'03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4'),
(24,	'bag3.cpp',	'bag.cpp',	271,	7,	19,	CONV('1', 2, 10) + 0,	'03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4'),
(25,	'[Electro Swing Remix] A Friend Like Me.mp3',	'[Electro Swing Remix] A Friend Like Me.mp3',	2301067,	NULL,	19,	CONV('0', 2, 10) + 0,	'5994471abb01112afcc18159f6cc74b4f511b99806da59b3caf5a9c173cacfc5');

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
                        `_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
                        `name` varchar(24) NOT NULL,
                        `nickname` varchar(24) NOT NULL,
                        `password` varchar(64) NOT NULL,
                        PRIMARY KEY (`_id`),
                        UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `user` (`_id`, `name`, `nickname`, `password`) VALUES
(1,	'admin',	'admin',	'be9ad412f783dc9dd6c557e9a80cfdb4c45f0e5f4e6183e999f50026a1250c8c'),
(7,	'admin3',	'admin3',	'be9ad412f783dc9dd6c557e9a80cfdb4c45f0e5f4e6183e999f50026a1250c8c'),
(8,	'admin4',	'admin4',	'be9ad412f783dc9dd6c557e9a80cfdb4c45f0e5f4e6183e999f50026a1250c8c'),
(9,	'admin5',	'admin5',	'be9ad412f783dc9dd6c557e9a80cfdb4c45f0e5f4e6183e999f50026a1250c8c');

-- 2020-12-16 07:45:19