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
(4,	'12345'),
(5,	'123456'),
(6,	'waerawerwar'),
(7,	'aewfwaefwafeawefwa'),
(8,	'qwdqwdqwdqwdqwdwfq'),
(9,	'zxcv'),
(10,	'ㄻㄴㅇㅇㄴㅁㅍㄴㅁㅇㅍ'),
(11,	'awgwagawafdsfgd'),
(12,	'1234134124'),
(13,	'my-pom.xml'),
(17,	'12345'),
(18,	'12345'),
(19,	'12345'),
(20,	'12345');

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
                         CONSTRAINT `items_ibfk_1` FOREIGN KEY (`file_id`) REFERENCES `file_id` (`_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `items` (`_id`, `file_name`, `original_name`, `file_size`, `owner`, `file_id`, `owner_only`, `password`) VALUES
(3,	'pom12.xml',	'pom.xml',	1636,	NULL,	4,	CONV('0', 2, 10) + 0,	NULL),
(4,	'demo.iml',	'demo.iml',	2938,	NULL,	5,	CONV('0', 2, 10) + 0,	NULL),
(5,	'README10.md',	'README.md',	211,	NULL,	6,	CONV('0', 2, 10) + 0,	NULL),
(6,	'docker-compose4.yml',	'docker-compose.yml',	602,	NULL,	7,	CONV('0', 2, 10) + 0,	NULL),
(7,	'pom13.xml',	'pom.xml',	1636,	NULL,	8,	CONV('0', 2, 10) + 0,	NULL),
(8,	'README11.md',	'README.md',	211,	NULL,	9,	CONV('0', 2, 10) + 0,	NULL),
(9,	'docker-compose6.yml',	'docker-compose.yml',	602,	NULL,	10,	CONV('0', 2, 10) + 0,	NULL),
(10,	'docker-compose7.yml',	'docker-compose.yml',	602,	NULL,	11,	CONV('0', 2, 10) + 0,	NULL),
(11,	'README12.md',	'README.md',	211,	7,	12,	CONV('0', 2, 10) + 0,	NULL),
(12,	'pom14.xml',	'pom.xml',	1636,	7,	13,	CONV('0', 2, 10) + 0,	NULL),
(16,	'stack_maze.cpp',	'stack_maze.cpp',	315,	7,	17,	CONV('0', 2, 10) + 0,	NULL),
(17,	'stack_maze1.cpp',	'stack_maze.cpp',	315,	7,	18,	CONV('0', 2, 10) + 0,	NULL),
(18,	'stack1.cpp',	'stack.cpp',	511,	NULL,	19,	CONV('0', 2, 10) + 0,	NULL),
(19,	'queue_circular.cpp',	'queue_circular.cpp',	1165,	7,	20,	CONV('0', 2, 10) + 0,	NULL);

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

-- 2020-12-15 09:23:21