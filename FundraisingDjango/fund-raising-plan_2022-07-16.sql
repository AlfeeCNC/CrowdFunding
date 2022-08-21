# ************************************************************
# Sequel Pro SQL dump
# Version 5446
#
# https://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.7.32)
# Database: fund-raising-plan
# Generation Time: 2022-07-16 05:05:11 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
SET NAMES utf8mb4;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table auth_group
# ------------------------------------------------------------

DROP TABLE IF EXISTS `auth_group`;

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table auth_group_permissions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `auth_group_permissions`;

CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table auth_permission
# ------------------------------------------------------------

DROP TABLE IF EXISTS `auth_permission`;

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`)
VALUES
	(1,'Can add log entry',1,'add_logentry'),
	(2,'Can change log entry',1,'change_logentry'),
	(3,'Can delete log entry',1,'delete_logentry'),
	(4,'Can view log entry',1,'view_logentry'),
	(5,'Can add permission',2,'add_permission'),
	(6,'Can change permission',2,'change_permission'),
	(7,'Can delete permission',2,'delete_permission'),
	(8,'Can view permission',2,'view_permission'),
	(9,'Can add group',3,'add_group'),
	(10,'Can change group',3,'change_group'),
	(11,'Can delete group',3,'delete_group'),
	(12,'Can view group',3,'view_group'),
	(13,'Can add user',4,'add_user'),
	(14,'Can change user',4,'change_user'),
	(15,'Can delete user',4,'delete_user'),
	(16,'Can view user',4,'view_user'),
	(17,'Can add content type',5,'add_contenttype'),
	(18,'Can change content type',5,'change_contenttype'),
	(19,'Can delete content type',5,'delete_contenttype'),
	(20,'Can view content type',5,'view_contenttype'),
	(21,'Can add session',6,'add_session'),
	(22,'Can change session',6,'change_session'),
	(23,'Can delete session',6,'delete_session'),
	(24,'Can view session',6,'view_session'),
	(25,'Can add fundraising plan',7,'add_fundraisingplan'),
	(26,'Can change fundraising plan',7,'change_fundraisingplan'),
	(27,'Can delete fundraising plan',7,'delete_fundraisingplan'),
	(28,'Can view fundraising plan',7,'view_fundraisingplan'),
	(29,'Can add fundraising products',8,'add_fundraisingproducts'),
	(30,'Can change fundraising products',8,'change_fundraisingproducts'),
	(31,'Can delete fundraising products',8,'delete_fundraisingproducts'),
	(32,'Can view fundraising products',8,'view_fundraisingproducts'),
	(33,'Can add test1',9,'add_test1'),
	(34,'Can change test1',9,'change_test1'),
	(35,'Can delete test1',9,'delete_test1'),
	(36,'Can view test1',9,'view_test1'),
	(37,'Can add member',10,'add_member'),
	(38,'Can change member',10,'change_member'),
	(39,'Can delete member',10,'delete_member'),
	(40,'Can view member',10,'view_member'),
	(41,'Can add investment record',11,'add_investmentrecord'),
	(42,'Can change investment record',11,'change_investmentrecord'),
	(43,'Can delete investment record',11,'delete_investmentrecord'),
	(44,'Can view investment record',11,'view_investmentrecord'),
	(45,'Can add products',12,'add_products'),
	(46,'Can change products',12,'change_products'),
	(47,'Can delete products',12,'delete_products'),
	(48,'Can view products',12,'view_products'),
	(49,'Can add sales record',13,'add_salesrecord'),
	(50,'Can change sales record',13,'change_salesrecord'),
	(51,'Can delete sales record',13,'delete_salesrecord'),
	(52,'Can view sales record',13,'view_salesrecord'),
	(53,'Can add profit sharing record',14,'add_profitsharingrecord'),
	(54,'Can change profit sharing record',14,'change_profitsharingrecord'),
	(55,'Can delete profit sharing record',14,'delete_profitsharingrecord'),
	(56,'Can view profit sharing record',14,'view_profitsharingrecord'),
	(57,'Can add completed task',15,'add_completedtask'),
	(58,'Can change completed task',15,'change_completedtask'),
	(59,'Can delete completed task',15,'delete_completedtask'),
	(60,'Can view completed task',15,'view_completedtask'),
	(61,'Can add task',16,'add_task'),
	(62,'Can change task',16,'change_task'),
	(63,'Can delete task',16,'delete_task'),
	(64,'Can view task',16,'view_task'),
	(65,'Can add crontab',17,'add_crontabschedule'),
	(66,'Can change crontab',17,'change_crontabschedule'),
	(67,'Can delete crontab',17,'delete_crontabschedule'),
	(68,'Can view crontab',17,'view_crontabschedule'),
	(69,'Can add interval',18,'add_intervalschedule'),
	(70,'Can change interval',18,'change_intervalschedule'),
	(71,'Can delete interval',18,'delete_intervalschedule'),
	(72,'Can view interval',18,'view_intervalschedule'),
	(73,'Can add periodic task',19,'add_periodictask'),
	(74,'Can change periodic task',19,'change_periodictask'),
	(75,'Can delete periodic task',19,'delete_periodictask'),
	(76,'Can view periodic task',19,'view_periodictask'),
	(77,'Can add periodic tasks',20,'add_periodictasks'),
	(78,'Can change periodic tasks',20,'change_periodictasks'),
	(79,'Can delete periodic tasks',20,'delete_periodictasks'),
	(80,'Can view periodic tasks',20,'view_periodictasks'),
	(81,'Can add solar event',21,'add_solarschedule'),
	(82,'Can change solar event',21,'change_solarschedule'),
	(83,'Can delete solar event',21,'delete_solarschedule'),
	(84,'Can view solar event',21,'view_solarschedule'),
	(85,'Can add clocked',22,'add_clockedschedule'),
	(86,'Can change clocked',22,'change_clockedschedule'),
	(87,'Can delete clocked',22,'delete_clockedschedule'),
	(88,'Can view clocked',22,'view_clockedschedule');

/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table auth_user
# ------------------------------------------------------------

DROP TABLE IF EXISTS `auth_user`;

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `first_name` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `last_name` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(254) COLLATE utf8_unicode_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;

INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`)
VALUES
	(1,'pbkdf2_sha256$260000$6WO05gqX1RzEnjEs5rDjsq$5b5niSowGHos3xya+bEuc1CDfkDerZEmBAbc+uZ2FNc=','2022-05-02 16:50:22.091992',1,'elsie','','','elsie@gmail.com',1,1,'2021-08-02 10:17:28.876727'),
	(2,'pbkdf2_sha256$260000$vDWEwu6vTo10JpWLcuALWD$VIngD4oP+3vSR49IfC08308uMOYVcL9CXdhYv0cmKB0=','2022-07-11 20:23:30.956210',0,'andy','','','andy@gmail.com',0,1,'2021-08-06 12:59:31.058825'),
	(3,'pbkdf2_sha256$260000$OJXSSkRmGNAaNBFT7PSSl6$ZF9lPNy1X8CGus7ZII8+A0DRe0ho6UCGTTg6zpQ6mvQ=','2022-05-02 16:46:06.114957',0,'anna','','','',0,1,'2021-08-25 14:13:57.891864');

/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table auth_user_groups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `auth_user_groups`;

CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table auth_user_user_permissions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `auth_user_user_permissions`;

CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table django_admin_log
# ------------------------------------------------------------

DROP TABLE IF EXISTS `django_admin_log`;

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext COLLATE utf8_unicode_ci,
  `object_repr` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext COLLATE utf8_unicode_ci NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table django_celery_beat_clockedschedule
# ------------------------------------------------------------

DROP TABLE IF EXISTS `django_celery_beat_clockedschedule`;

CREATE TABLE `django_celery_beat_clockedschedule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `clocked_time` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table django_celery_beat_crontabschedule
# ------------------------------------------------------------

DROP TABLE IF EXISTS `django_celery_beat_crontabschedule`;

CREATE TABLE `django_celery_beat_crontabschedule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `minute` varchar(240) COLLATE utf8_unicode_ci NOT NULL,
  `hour` varchar(96) COLLATE utf8_unicode_ci NOT NULL,
  `day_of_week` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `day_of_month` varchar(124) COLLATE utf8_unicode_ci NOT NULL,
  `month_of_year` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `timezone` varchar(63) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table django_celery_beat_intervalschedule
# ------------------------------------------------------------

DROP TABLE IF EXISTS `django_celery_beat_intervalschedule`;

CREATE TABLE `django_celery_beat_intervalschedule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `every` int(11) NOT NULL,
  `period` varchar(24) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table django_celery_beat_periodictask
# ------------------------------------------------------------

DROP TABLE IF EXISTS `django_celery_beat_periodictask`;

CREATE TABLE `django_celery_beat_periodictask` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `task` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `args` longtext COLLATE utf8_unicode_ci NOT NULL,
  `kwargs` longtext COLLATE utf8_unicode_ci NOT NULL,
  `queue` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `exchange` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `routing_key` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `expires` datetime(6) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL,
  `last_run_at` datetime(6) DEFAULT NULL,
  `total_run_count` int(10) unsigned NOT NULL,
  `date_changed` datetime(6) NOT NULL,
  `description` longtext COLLATE utf8_unicode_ci NOT NULL,
  `crontab_id` int(11) DEFAULT NULL,
  `interval_id` int(11) DEFAULT NULL,
  `solar_id` int(11) DEFAULT NULL,
  `one_off` tinyint(1) NOT NULL,
  `start_time` datetime(6) DEFAULT NULL,
  `priority` int(10) unsigned DEFAULT NULL,
  `headers` longtext COLLATE utf8_unicode_ci NOT NULL,
  `clocked_id` int(11) DEFAULT NULL,
  `expire_seconds` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `django_celery_beat_p_crontab_id_d3cba168_fk_django_ce` (`crontab_id`),
  KEY `django_celery_beat_p_interval_id_a8ca27da_fk_django_ce` (`interval_id`),
  KEY `django_celery_beat_p_solar_id_a87ce72c_fk_django_ce` (`solar_id`),
  KEY `django_celery_beat_p_clocked_id_47a69f82_fk_django_ce` (`clocked_id`),
  CONSTRAINT `django_celery_beat_p_clocked_id_47a69f82_fk_django_ce` FOREIGN KEY (`clocked_id`) REFERENCES `django_celery_beat_clockedschedule` (`id`),
  CONSTRAINT `django_celery_beat_p_crontab_id_d3cba168_fk_django_ce` FOREIGN KEY (`crontab_id`) REFERENCES `django_celery_beat_crontabschedule` (`id`),
  CONSTRAINT `django_celery_beat_p_interval_id_a8ca27da_fk_django_ce` FOREIGN KEY (`interval_id`) REFERENCES `django_celery_beat_intervalschedule` (`id`),
  CONSTRAINT `django_celery_beat_p_solar_id_a87ce72c_fk_django_ce` FOREIGN KEY (`solar_id`) REFERENCES `django_celery_beat_solarschedule` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table django_celery_beat_periodictasks
# ------------------------------------------------------------

DROP TABLE IF EXISTS `django_celery_beat_periodictasks`;

CREATE TABLE `django_celery_beat_periodictasks` (
  `ident` smallint(6) NOT NULL,
  `last_update` datetime(6) NOT NULL,
  PRIMARY KEY (`ident`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table django_celery_beat_solarschedule
# ------------------------------------------------------------

DROP TABLE IF EXISTS `django_celery_beat_solarschedule`;

CREATE TABLE `django_celery_beat_solarschedule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `event` varchar(24) COLLATE utf8_unicode_ci NOT NULL,
  `latitude` decimal(9,6) NOT NULL,
  `longitude` decimal(9,6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_celery_beat_solar_event_latitude_longitude_ba64999a_uniq` (`event`,`latitude`,`longitude`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table django_content_type
# ------------------------------------------------------------

DROP TABLE IF EXISTS `django_content_type`;

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `model` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;

INSERT INTO `django_content_type` (`id`, `app_label`, `model`)
VALUES
	(1,'admin','logentry'),
	(3,'auth','group'),
	(2,'auth','permission'),
	(4,'auth','user'),
	(15,'background_task','completedtask'),
	(16,'background_task','task'),
	(5,'contenttypes','contenttype'),
	(22,'django_celery_beat','clockedschedule'),
	(17,'django_celery_beat','crontabschedule'),
	(18,'django_celery_beat','intervalschedule'),
	(19,'django_celery_beat','periodictask'),
	(20,'django_celery_beat','periodictasks'),
	(21,'django_celery_beat','solarschedule'),
	(6,'sessions','session'),
	(7,'web','fundraisingplan'),
	(8,'web','fundraisingproducts'),
	(11,'web','investmentrecord'),
	(10,'web','member'),
	(12,'web','products'),
	(14,'web','profitsharingrecord'),
	(13,'web','salesrecord'),
	(9,'web','test1');

/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table django_migrations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `django_migrations`;

CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`)
VALUES
	(1,'contenttypes','0001_initial','2021-08-02 10:15:09.200059'),
	(2,'auth','0001_initial','2021-08-02 10:15:09.636585'),
	(3,'admin','0001_initial','2021-08-02 10:15:09.748857'),
	(4,'admin','0002_logentry_remove_auto_add','2021-08-02 10:15:09.762597'),
	(5,'admin','0003_logentry_add_action_flag_choices','2021-08-02 10:15:09.810936'),
	(6,'contenttypes','0002_remove_content_type_name','2021-08-02 10:15:09.875691'),
	(7,'auth','0002_alter_permission_name_max_length','2021-08-02 10:15:09.911249'),
	(8,'auth','0003_alter_user_email_max_length','2021-08-02 10:15:09.946967'),
	(9,'auth','0004_alter_user_username_opts','2021-08-02 10:15:09.960408'),
	(10,'auth','0005_alter_user_last_login_null','2021-08-02 10:15:09.997211'),
	(11,'auth','0006_require_contenttypes_0002','2021-08-02 10:15:09.999893'),
	(12,'auth','0007_alter_validators_add_error_messages','2021-08-02 10:15:10.011818'),
	(13,'auth','0008_alter_user_username_max_length','2021-08-02 10:15:10.049553'),
	(14,'auth','0009_alter_user_last_name_max_length','2021-08-02 10:15:10.093074'),
	(15,'auth','0010_alter_group_name_max_length','2021-08-02 10:15:10.141874'),
	(16,'auth','0011_update_proxy_permissions','2021-08-02 10:15:10.158076'),
	(17,'auth','0012_alter_user_first_name_max_length','2021-08-02 10:15:10.197801'),
	(18,'sessions','0001_initial','2021-08-02 10:15:10.245162'),
	(30,'web','0001_initial','2021-08-11 14:51:09.711415'),
	(31,'web','0002_test1_created_at','2021-08-11 14:51:09.718077'),
	(32,'web','0003_auto_20210802_2101','2021-08-11 14:51:09.725259'),
	(33,'web','0004_rename_produc_id_fundraisingproducts_product_id','2021-08-11 14:51:09.730493'),
	(34,'web','0005_investmentrecord','2021-08-11 14:51:09.736230'),
	(35,'web','0006_investmentrecord_etherscan_url','2021-08-11 14:51:09.746167'),
	(36,'web','0007_remove_fundraisingplan_current_investors','2021-08-11 14:51:09.750313'),
	(37,'web','0008_auto_20210807_2312','2021-08-11 14:51:09.766069'),
	(38,'web','0009_remove_products_plan721_id','2021-08-11 14:51:09.776259'),
	(39,'web','0010_profitsharingrecord','2021-08-11 14:51:09.787977'),
	(40,'web','0011_profitsharingrecord_etherscan_url','2021-08-11 14:51:09.805844'),
	(41,'web','0012_auto_20210815_1941','2021-08-15 19:41:33.012379'),
	(42,'web','0013_products_product_1155_id','2021-08-17 16:16:17.281358'),
	(43,'web','0014_auto_20210824_2239','2021-08-24 22:39:46.537040'),
	(44,'web','0015_alter_salesrecord_user_id','2021-08-24 22:41:49.970195'),
	(45,'web','0016_alter_salesrecord_user_id','2021-08-24 22:43:37.671090'),
	(46,'web','0017_auto_20210825_0001','2021-08-25 00:01:07.875475'),
	(47,'web','0018_auto_20210825_1602','2021-08-25 16:02:24.779869'),
	(48,'background_task','0001_initial','2021-08-30 00:18:56.732366'),
	(49,'background_task','0002_auto_20170927_1109','2021-08-30 00:18:56.782580'),
	(50,'django_celery_beat','0001_initial','2021-08-31 00:02:51.789648'),
	(51,'django_celery_beat','0002_auto_20161118_0346','2021-08-31 00:02:51.916435'),
	(52,'django_celery_beat','0003_auto_20161209_0049','2021-08-31 00:02:51.958486'),
	(53,'django_celery_beat','0004_auto_20170221_0000','2021-08-31 00:02:51.973452'),
	(54,'django_celery_beat','0005_add_solarschedule_events_choices','2021-08-31 00:02:51.991924'),
	(55,'django_celery_beat','0006_auto_20180322_0932','2021-08-31 00:02:52.188834'),
	(56,'django_celery_beat','0007_auto_20180521_0826','2021-08-31 00:02:52.333610'),
	(57,'django_celery_beat','0008_auto_20180914_1922','2021-08-31 00:02:52.379577'),
	(58,'django_celery_beat','0006_auto_20180210_1226','2021-08-31 00:02:52.404461'),
	(59,'django_celery_beat','0006_periodictask_priority','2021-08-31 00:02:52.442913'),
	(60,'django_celery_beat','0009_periodictask_headers','2021-08-31 00:02:52.484115'),
	(61,'django_celery_beat','0010_auto_20190429_0326','2021-08-31 00:02:52.649193'),
	(62,'django_celery_beat','0011_auto_20190508_0153','2021-08-31 00:02:52.713636'),
	(63,'django_celery_beat','0012_periodictask_expire_seconds','2021-08-31 00:02:52.756546'),
	(64,'django_celery_beat','0013_auto_20200609_0727','2021-08-31 00:02:52.766900'),
	(65,'django_celery_beat','0014_remove_clockedschedule_enabled','2021-08-31 00:02:52.800370'),
	(66,'django_celery_beat','0015_edit_solarschedule_events_choices','2021-08-31 00:02:52.815713'),
	(67,'web','0019_products_cost','2021-09-08 17:02:53.817973'),
	(68,'web','0020_auto_20210912_2128','2021-09-12 21:28:24.641393'),
	(69,'web','0021_auto_20210912_2131','2021-09-12 21:32:00.167243'),
	(70,'web','0022_investmentrecord_type','2021-10-18 01:26:31.733322'),
	(71,'web','0023_investmentrecord_invest_token_url','2021-10-23 23:37:27.549459');

/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table django_session
# ------------------------------------------------------------

DROP TABLE IF EXISTS `django_session`;

CREATE TABLE `django_session` (
  `session_key` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `session_data` longtext COLLATE utf8_unicode_ci NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`)
VALUES
	('169gkjb20l4j54dikoosmkq4edfayua6','.eJxVjDsOwjAQBe_iGlnrJRtsSvqcwfJnFweQI8VJhbg7iZQC2pl57618WJfi18azH7O6KlSnXxZDenLdRX6Eep90muoyj1HviT5s08OU-XU72r-DElrZ1gmIQQApGyRGi-BYspAjBJstidA5xMAGNnSBZBLaXpwVMZS6rlefL9a0N3o:1oAsRm:L3w42kMA233D-9M4G4S2EGhUT1OGV9WXhJnZf9wjm20','2022-07-25 20:23:30.984608'),
	('41wk1prc50nxtrd97c7afspgwsu459vw','.eJxVjMsOwiAQRf-FtSEWKA-X7vsNZIZhpGogKe3K-O_apAvd3nPOfYkI21ri1vMSZxIXMYjT74aQHrnugO5Qb02mVtdlRrkr8qBdTo3y83q4fwcFevnWgOB49GdjOXidnWPlUQVDmSCMlJz1Go3hYBUplRFZJ-P8YJiTt1qJ9wfxwjgm:1mxsGn:LZ-vPd3JiUZj7mMpTIwdBUsGgbh2s90PqZ3Vkd8gCsk','2021-12-30 23:02:09.091496'),
	('81qogzqhvwe7c75lqgili18swmow89s8','.eJxVjMsOwiAQRf-FtSE8ysC4dO83kAEmUjWQlHZl_Hdt0oVu7znnvkSkba1xG7zEuYizsOL0uyXKD247KHdqty5zb-syJ7kr8qBDXnvh5-Vw_w4qjfqtp0TILnkN7ArmYLJhcg4ZdSqJ0ZuAHgwBBGPNZNGCY86cSbECrcT7A-rgN7U:1mhCZr:woKNeCZx1pDOjUhlNsUOlIg5ITf68MgC01s_pUpS-Ww','2021-11-14 23:16:55.320456'),
	('bkqxc5vhhy44m708ktkokb5nuaoilmkc','.eJxVjMsOwiAQRf-FtSE8ysC4dO83kAEmUjWQlHZl_Hdt0oVu7znnvkSkba1xG7zEuYizsOL0uyXKD247KHdqty5zb-syJ7kr8qBDXnvh5-Vw_w4qjfqtp0TILnkN7ArmYLJhcg4ZdSqJ0ZuAHgwBBGPNZNGCY86cSbECrcT7A-rgN7U:1mImGT:4Ejo-aTX9FZHMp-i1JLqmxLJ79khN_CjuTWDO1cgA58','2021-09-08 14:19:57.055804'),
	('erzv91rdrl451cyjc4qfdous0z5x6mht','.eJxVjDsOwjAQBe_iGlnrJRtsSvqcwfJnFweQI8VJhbg7iZQC2pl57618WJfi18azH7O6KlSnXxZDenLdRX6Eep90muoyj1HviT5s08OU-XU72r-DElrZ1gmIQQApGyRGi-BYspAjBJstidA5xMAGNnSBZBLaXpwVMZS6rlefL9a0N3o:1mD4JL:7iZMehHk_Egym6IzJjKSGPx2pj7yzhEwsAsqmNYiHDA','2021-08-23 20:23:19.977394'),
	('hdsukadq9676e3pivftr0fqza0meun00','.eJxVjMsOwiAQRf-FtSEWKA-X7vsNZIZhpGogKe3K-O_apAvd3nPOfYkI21ri1vMSZxIXMYjT74aQHrnugO5Qb02mVtdlRrkr8qBdTo3y83q4fwcFevnWgOB49GdjOXidnWPlUQVDmSCMlJz1Go3hYBUplRFZJ-P8YJiTt1qJ9wfxwjgm:1nRTBY:kJNs4hFZKTyT7KNd8ffrux7-gPxQbW4-nXA0hsNsBBM','2022-03-22 14:19:04.652176'),
	('jfsz6x68x8j2nco4sryzy336iceh57m7','.eJxVjMsOwiAQRf-FtSE8ysC4dO83kAEmUjWQlHZl_Hdt0oVu7znnvkSkba1xG7zEuYizsOL0uyXKD247KHdqty5zb-syJ7kr8qBDXnvh5-Vw_w4qjfqtp0TILnkN7ArmYLJhcg4ZdSqJ0ZuAHgwBBGPNZNGCY86cSbECrcT7A-rgN7U:1mz8Lg:IJ_21yynQ5hDZVK-mIMKR04QnrFEqyjsmdF_O_MtJ-A','2022-01-03 10:24:24.536378'),
	('l5wtueeb42x7iime378ls5qhxo8x1lsx','.eJxVjMsOwiAQRf-FtSE8ysC4dO83kAEmUjWQlHZl_Hdt0oVu7znnvkSkba1xG7zEuYizsOL0uyXKD247KHdqty5zb-syJ7kr8qBDXnvh5-Vw_w4qjfqtp0TILnkN7ArmYLJhcg4ZdSqJ0ZuAHgwBBGPNZNGCY86cSbECrcT7A-rgN7U:1mh5sa:z1Fy0Lz9KyQvi1lwgMGjj_-jIaCPxcohXohlvNhB3Mc','2021-11-14 16:07:48.884698'),
	('qati83dwnbv09h0egsvf39n4bll8v6jq','.eJxVjMsOwiAQRf-FtSE8ysC4dO83kAEmUjWQlHZl_Hdt0oVu7znnvkSkba1xG7zEuYizsOL0uyXKD247KHdqty5zb-syJ7kr8qBDXnvh5-Vw_w4qjfqtp0TILnkN7ArmYLJhcg4ZdSqJ0ZuAHgwBBGPNZNGCY86cSbECrcT7A-rgN7U:1mImEI:vtbdvh9aD8vL32Ysr2ZcuxvjYkq26iAzIdL0MzqEsnk','2021-09-08 14:17:42.383556'),
	('qejz07mx2gb74m41an9yd2bhsxsdpcs6','.eJxVjDsOwjAQBe_iGlnrJRtsSvqcwfJnFweQI8VJhbg7iZQC2pl57618WJfi18azH7O6KlSnXxZDenLdRX6Eep90muoyj1HviT5s08OU-XU72r-DElrZ1gmIQQApGyRGi-BYspAjBJstidA5xMAGNnSBZBLaXpwVMZS6rlefL9a0N3o:1mrcAl:sLmC3_S9mPhCjQ-ZTPVxYdLQBG7YFg8NK_PgJOZYwjY','2021-12-13 16:38:03.908195'),
	('rg2avklf78e3rak0v07b1y6r7jbucpry','.eJxVjMsOwiAQRf-FtSEWKA-X7vsNZIZhpGogKe3K-O_apAvd3nPOfYkI21ri1vMSZxIXMYjT74aQHrnugO5Qb02mVtdlRrkr8qBdTo3y83q4fwcFevnWgOB49GdjOXidnWPlUQVDmSCMlJz1Go3hYBUplRFZJ-P8YJiTt1qJ9wfxwjgm:1mXI3L:KpdDwZi8hshP81rSFg2EG5-qjdQki8lA7q-98NOXj28','2021-10-18 15:06:23.704261'),
	('rhc9c1esyn0pnbxq4jybm1qqq6671ixf','.eJxVjDsOwjAQBe_iGlnrJRtsSvqcwfJnFweQI8VJhbg7iZQC2pl57618WJfi18azH7O6KlSnXxZDenLdRX6Eep90muoyj1HviT5s08OU-XU72r-DElrZ1gmIQQApGyRGi-BYspAjBJstidA5xMAGNnSBZBLaXpwVMZS6rlefL9a0N3o:1nquqV:yOB1OPFLabqW17FXnVIBcj8VtN6LBiJOA1jzJzC0jI8','2022-05-31 18:54:31.201010'),
	('t4pxfdq6v7vq4mk2efm6upmrr9a933g3','.eJxVjDsOwjAQBe_iGlnrJRtsSvqcwfJnFweQI8VJhbg7iZQC2pl57618WJfi18azH7O6KlSnXxZDenLdRX6Eep90muoyj1HviT5s08OU-XU72r-DElrZ1gmIQQApGyRGi-BYspAjBJstidA5xMAGNnSBZBLaXpwVMZS6rlefL9a0N3o:1nRWOZ:Gcv3TWCDpmlc6c7hcsiiGsjSF5msf7j4jwWQ9hwxx0Q','2022-03-22 17:44:43.260495'),
	('wj2j8svd06xkmk10fs8dey6w8ttniqw4','.eJxVjDsOwjAQBe_iGlnrJRtsSvqcwfJnFweQI8VJhbg7iZQC2pl57618WJfi18azH7O6KlSnXxZDenLdRX6Eep90muoyj1HviT5s08OU-XU72r-DElrZ1gmIQQApGyRGi-BYspAjBJstidA5xMAGNnSBZBLaXpwVMZS6rlefL9a0N3o:1mNuED:6QuR1jgaFisXE4RY6zPP5Y2Y8FALG2Sx9ltJygao-M8','2021-09-22 17:50:49.423720'),
	('xp7e18gq55nm2eivzu8kdj3m1rbrg18o','.eJxVjDsOwjAQBe_iGlnrJRtsSvqcwfJnFweQI8VJhbg7iZQC2pl57618WJfi18azH7O6KlSnXxZDenLdRX6Eep90muoyj1HviT5s08OU-XU72r-DElrZ1gmIQQApGyRGi-BYspAjBJstidA5xMAGNnSBZBLaXpwVMZS6rlefL9a0N3o:1nlRmI:ppPNYisP6WrT8hhVLzypIYQYjemEhzzbLEblsJPIjEk','2022-05-16 16:51:34.203291');

/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table fund_raising_plan
# ------------------------------------------------------------

DROP TABLE IF EXISTS `fund_raising_plan`;

CREATE TABLE `fund_raising_plan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `initiator_id` int(11) NOT NULL,
  `plan721_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `title` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `threshold_amount` int(11) NOT NULL,
  `target_amount` int(11) NOT NULL,
  `category` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `fundraising_start_date` datetime(6) NOT NULL,
  `fundraising_end_date` datetime(6) NOT NULL,
  `execution_start_date` datetime(6) NOT NULL,
  `execution_end_date` datetime(6) DEFAULT NULL,
  `revenue_standard` int(11) DEFAULT NULL,
  `profitsharing_investor` int(11) NOT NULL,
  `profitsharing_initiator` int(11) NOT NULL,
  `profitsharing_platform` int(11) NOT NULL,
  `content` longtext COLLATE utf8_unicode_ci NOT NULL,
  `current_money` int(11) NOT NULL,
  `product_number` int(11) NOT NULL,
  `image` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `status` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `tx_hash` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `wallet_address` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `liquidation_discount` int(11) NOT NULL,
  `liquidation_time` int(11) NOT NULL,
  `profit_sharing_frequency` int(11) DEFAULT NULL,
  `profit_sharing_start_date` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `fund_raising_plan` WRITE;
/*!40000 ALTER TABLE `fund_raising_plan` DISABLE KEYS */;

INSERT INTO `fund_raising_plan` (`id`, `initiator_id`, `plan721_id`, `title`, `threshold_amount`, `target_amount`, `category`, `fundraising_start_date`, `fundraising_end_date`, `execution_start_date`, `execution_end_date`, `revenue_standard`, `profitsharing_investor`, `profitsharing_initiator`, `profitsharing_platform`, `content`, `current_money`, `product_number`, `image`, `status`, `tx_hash`, `wallet_address`, `created_at`, `liquidation_discount`, `liquidation_time`, `profit_sharing_frequency`, `profit_sharing_start_date`)
VALUES
	(4,1,'29','SWANZ首創最輕陶瓷便當盒',5000,10000,'計畫及商品','2021-08-10 00:00:00.000000','2021-09-30 23:59:59.999999','2021-10-01 00:00:00.000000','2021-11-30 23:59:59.999999',6000,40,40,20,'最輕的芯動陶瓷便當盒\n讓帶便當不再是省錢，而是創造自己的心動\n吃飯不只是吃飯，吃的是一個生活態度\n將每一餐搭配的五彩斑斕，就像我們的人生！',750,3,'https://images.unsplash.com/photo-1558689509-900d3d3cc727?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1353&q=80','closed','https://ropsten.etherscan.io/tx/0x92d6db724495168888ba8d9837a1d1c6faa45abe33a6a1e83e10282c600cd7e8','0x6b45771c0502bA39f933D1037cB4f59B635eb906','2021-08-09 01:21:43.134417',5,30,NULL,NULL),
	(5,2,'3','完美設計珍奶吸管',500,1000,'計畫及商品','2021-08-11 00:00:00.000000','2021-09-11 23:59:59.999999','2021-09-12 00:00:00.000000','2021-10-31 23:59:59.999999',6000,50,30,20,'珍珠奶茶是代表台灣的著名飲食之一。由於食材特性，需要吸管飲用，\n然而許多國家地區已禁用一次性塑膠吸管，nuboPod藍鯨吸管全新珍珠款，隨身攜帶方便使用，讓你走到哪喝到哪！',1000,2,'https://images.unsplash.com/photo-1554327075-31266866daa7?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80','closed','https://ropsten.etherscan.io/tx/0x5c85e15a7d04f208c043c43ee958769cec0c8e9143fdf9fc40333080f3ddea85','0xF3f95311b2AA2E20f9234eF47fE40dcc0a5Fd6df','2021-08-10 17:45:00.854315',5,30,NULL,NULL),
	(8,1,'32','WANZ首創最輕陶瓷便當盒',10000,50000,'計畫及商品','2021-11-01 00:00:00.000000','2021-12-31 23:59:59.999999','2022-01-01 00:00:00.000000','2022-03-31 23:59:59.999999',0,40,30,30,'最輕的芯動陶瓷便當盒\r\n讓帶便當不再是省錢，而是創造自己的心動\r\n吃飯不只是吃飯，吃的是一個生活態度\r\n將每一餐搭配的五彩斑斕，就像我們的人生！',5000,3,'https://images.unsplash.com/photo-1558689509-900d3d3cc727?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1353&q=80','closed','https://ropsten.etherscan.io/tx/0x122e298b243f65e7309464de6d4c34071efff55f73e55dbf6330de5240bb912d','0x6b45771c0502bA39f933D1037cB4f59B635eb906','2021-10-31 23:04:45.971556',8,30,3,'2021-10-31 23:04:45.942803'),
	(9,2,'33','WANZ首創最輕陶瓷便當盒',10000,20000,'計畫及商品','2022-03-08 00:00:00.000000','2022-07-31 23:59:59.999999','2022-08-01 00:00:00.000000','2022-08-31 23:59:59.999999',0,40,40,20,'最輕的芯動陶瓷便當盒\r\n讓帶便當不再是省錢，而是創造自己的心動\r\n吃飯不只是吃飯，吃的是一個生活態度\r\n將每一餐搭配的五彩斑斕，就像我們的人生！',0,3,'https://images.unsplash.com/photo-1558689509-900d3d3cc727?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1353&q=80','fundraising','https://ropsten.etherscan.io/tx/0xe6bf78190ad1c896fed08176c3c2b9fb91f8f81b846e4b8de382269b85db08db','0xF3f95311b2AA2E20f9234eF47fE40dcc0a5Fd6df','2022-03-08 18:07:31.222226',8,30,3,'2022-03-08 18:07:31.201596');

/*!40000 ALTER TABLE `fund_raising_plan` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table investment_record
# ------------------------------------------------------------

DROP TABLE IF EXISTS `investment_record`;

CREATE TABLE `investment_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `user_wallet` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `plan_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `amount` int(11) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `etherscan_url` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `invest_token_url` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `investment_record` WRITE;
/*!40000 ALTER TABLE `investment_record` DISABLE KEYS */;

INSERT INTO `investment_record` (`id`, `user_id`, `user_wallet`, `plan_id`, `product_id`, `amount`, `created_at`, `etherscan_url`, `type`, `invest_token_url`)
VALUES
	(27,3,'0xff37C10cFDF87911A5129A412e9992ADF044F3dc',5,1,300,'2021-08-25 14:23:14.410024','https://ropsten.etherscan.io/tx/0xcee65a312ac98e9cca150f99fda3cf21f2a98a946ae4eec322b1b2741d75c29d','invest',''),
	(28,3,'0xff37C10cFDF87911A5129A412e9992ADF044F3dc',5,2,200,'2021-08-25 14:23:22.280032','https://ropsten.etherscan.io/tx/0x1fbce79b5b5820ea659551dd536155877076f418ad58417f902ddcf76fa57805','invest',''),
	(29,3,'0xff37C10cFDF87911A5129A412e9992ADF044F3dc',5,1,50,'2021-08-25 14:31:38.639510','https://ropsten.etherscan.io/tx/0xc4f7bb3a43b2d0d48cafe65a826a87002bc75a0c1c6c195508c83b26cda84487','invest',''),
	(30,3,'0xff37C10cFDF87911A5129A412e9992ADF044F3dc',5,2,50,'2021-08-25 14:31:51.523207','https://ropsten.etherscan.io/tx/0x2bae4ec36e01a3217751290709f2c43e8b86384f9b8c84819922821579b9e1bd','invest',''),
	(31,2,'0xa54d28cb36956887727ca8c71C9E50E9ec693C52',5,1,400,'2021-09-08 18:05:23.953097','https://ropsten.etherscan.io/tx/0x7997009880a3004df1a777efcc74f582dc1eac8e5b8bb4b1b65aa1191e8eb098','invest',''),
	(35,2,'0xF3f95311b2AA2E20f9234eF47fE40dcc0a5Fd6df',5,1,100,'2021-10-24 19:36:52.913082','https://ropsten.etherscan.io/tx/0x9a6b01eb8bb73dd2e9d27573752fa89fabe3b3cb3c681fe1a643200f9b2aabbd','transfer','https://ropsten.etherscan.io/tx/0x9a6b01eb8bb73dd2e9d27573752fa89fabe3b3cb3c681fe1a643200f9b2aabbd'),
	(36,3,'0xa54d28cb36956887727ca8c71C9E50E9ec693C52',5,1,100,'2021-10-24 19:36:52.916480','https://ropsten.etherscan.io/tx/0x9a6b01eb8bb73dd2e9d27573752fa89fabe3b3cb3c681fe1a643200f9b2aabbd','receive','https://ropsten.etherscan.io/tx/0x9a6b01eb8bb73dd2e9d27573752fa89fabe3b3cb3c681fe1a643200f9b2aabbd'),
	(37,3,'0xa54d28cb36956887727ca8c71C9E50E9ec693C52',5,1,100,'2021-10-25 19:27:44.885776','https://ropsten.etherscan.io/tx/0x634cd607ab8d4d519b2fc7c75f5ec638cac37c8b750215c7b14c4544d553077c','transfer','https://ropsten.etherscan.io/tx/0x634cd607ab8d4d519b2fc7c75f5ec638cac37c8b750215c7b14c4544d553077c'),
	(38,2,'0xF3f95311b2AA2E20f9234eF47fE40dcc0a5Fd6df',5,1,100,'2021-10-25 19:27:44.894343','https://ropsten.etherscan.io/tx/0x634cd607ab8d4d519b2fc7c75f5ec638cac37c8b750215c7b14c4544d553077c','receive','https://ropsten.etherscan.io/tx/0x634cd607ab8d4d519b2fc7c75f5ec638cac37c8b750215c7b14c4544d553077c'),
	(40,3,'0xa54d28cb36956887727ca8c71C9E50E9ec693C52',5,1,100,'2021-10-31 23:26:40.453246','https://ropsten.etherscan.io/tx/0xde7bf29a6c0acea3ff2a71a7d4e60f18ccadeb9cf78fd808eb4a3565b91d52a1','transfer','https://ropsten.etherscan.io/tx/0xde7bf29a6c0acea3ff2a71a7d4e60f18ccadeb9cf78fd808eb4a3565b91d52a1'),
	(41,1,'0x6b45771c0502bA39f933D1037cB4f59B635eb906',5,1,100,'2021-10-31 23:26:40.471638','https://ropsten.etherscan.io/tx/0xde7bf29a6c0acea3ff2a71a7d4e60f18ccadeb9cf78fd808eb4a3565b91d52a1','receive','https://ropsten.etherscan.io/tx/0xde7bf29a6c0acea3ff2a71a7d4e60f18ccadeb9cf78fd808eb4a3565b91d52a1'),
	(42,3,'0xa54d28cb36956887727ca8c71C9E50E9ec693C52',8,1,5000,'2021-10-31 23:32:25.151987','https://ropsten.etherscan.io/tx/0xb51a19c555a5cd08dd0b30cf83f595eaba71014180b12fdd0787b4922b83dbe2','invest','https://ropsten.etherscan.io/tx/0x4e18e455e3cd889553833f2d822dfbdeeccd4e7484aceb03a145b55209fe01ca');

/*!40000 ALTER TABLE `investment_record` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table product
# ------------------------------------------------------------

DROP TABLE IF EXISTS `product`;

CREATE TABLE `product` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `initiator_id` int(11) NOT NULL,
  `title` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `price` int(11) NOT NULL,
  `image` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `content` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `plan_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `issued_amount` int(11) NOT NULL,
  `sold_amount` int(11) NOT NULL,
  `etherscan_url` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `plan721_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `product_1155_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `cost` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;

INSERT INTO `product` (`id`, `initiator_id`, `title`, `price`, `image`, `content`, `plan_id`, `product_id`, `issued_amount`, `sold_amount`, `etherscan_url`, `plan721_id`, `product_1155_id`, `cost`)
VALUES
	(1,1,'便攜式磨豆機',100,'https://images.unsplash.com/photo-1611854778196-e8ab095456af?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80','設計5段刻度轉動切換，輕鬆對應不同研磨種類，不論是摩卡壺、手沖、冰滴、虹吸、法式濾壓都OK，從容應對一機搞定！',1,1,30,2,'','','',0),
	(2,1,'咖啡豆儲藏罐',150,'https://s3-ap-northeast-1.amazonaws.com/zeczec-prod/asset_352127_image_big.jpg?1628165438','結合工藝美學，磨豆機上蓋旋開和下方玻璃粉倉的蓋子組合，可以秒變換成粉倉或咖啡豆儲藏罐，方便攜帶、保鮮妙招。',1,2,50,2,'','','',0),
	(4,1,'SWANZ便當盒',300,'https://images.unsplash.com/photo-1543353071-c953d88f7033?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=925&q=80','輕量化一體成型陶瓷便當盒，好清洗不留污漬異味，專利矽膠套，精密防漏，隔熱保溫，可蒸可烤可微波，分隔設計，食物不混雜，完美品味每一餐！',4,1,0,0,'','','',0),
	(5,1,'多功能保溫袋',250,'https://images.unsplash.com/photo-1547949003-9792a18a2601?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80','使用三層不同材質組合，強化絕緣效果，保溫保冷時間至2小時，保留便當風味，讓每一口都是理想溫度。',4,2,0,0,'','','',0),
	(6,1,'不鏽鋼餐具組',150,'https://images.unsplash.com/photo-1619367300924-485907ff690d?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1424&q=80','以304不鏽鋼材質製作而成，不易生鏽、簡潔乾淨，湯匙、叉子一組兩入，可收納於多功能保溫袋中。',4,3,0,0,'','','',0),
	(7,2,'奶茶棕',200,'https://images.unsplash.com/photo-1554327075-31266866daa7?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80','奶茶棕色吸管',5,1,50,11,'https://ropsten.etherscan.io/tx/0x97855f5d6cc79bc5a7a04005f9ba0307fb49ae82219f9c936678807c40a21960','3','1',50),
	(8,2,'抹茶綠',200,'https://images.unsplash.com/photo-1447943549184-13f89172bcd4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80','抹茶綠色吸管',5,2,250,30,'https://ropsten.etherscan.io/tx/0xd897721e6b209b0b1ba3ee42375dd4840fdb82d94fe91c8f8884e8cbfc6e9f4e','3','2',0),
	(9,2,'SOMA西門店',0,'https://images.unsplash.com/photo-1518288319310-99bc48891084?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1052&q=80','西門町站附近',6,1,0,0,'','','',3000000),
	(10,2,'SOMA中山店',0,'https://images.unsplash.com/photo-1518288319310-99bc48891084?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1052&q=80','雙連站附近',6,2,0,0,'','','',4000000),
	(11,1,'WANZ便當盒',400,'https://images.unsplash.com/photo-1543353071-c953d88f7033?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=925&q=80','輕量化一體成型陶瓷便當盒，好清洗不留污漬異味，專利矽膠套，精密防漏，隔熱保溫，可蒸可烤可微波，分隔設計，食物不混雜，完美品味每一餐！',8,1,0,0,'','','',200),
	(12,1,'多功能保溫袋',300,'https://images.unsplash.com/photo-1547949003-9792a18a2601?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80','使用三層不同材質組合，強化絕緣效果，保溫保冷時間至2小時，保留便當風味，讓每一口都是理想溫度。',8,2,0,0,'','','',150),
	(13,1,'不鏽鋼餐具組',150,'https://images.unsplash.com/photo-1619367300924-485907ff690d?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1424&q=80','以304不鏽鋼材質製作而成，不易生鏽、簡潔乾淨，湯匙、叉子一組兩入，可收納於多功能保溫袋中。',8,3,0,0,'','','',100),
	(14,2,'WANZ便當盒',400,'https://images.unsplash.com/photo-1543353071-c953d88f7033?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=925&q=80','輕量化一體成型陶瓷便當盒，好清洗不留污漬異味，專利矽膠套，精密防漏，隔熱保溫，可蒸可烤可微波，分隔設計，食物不混雜，完美品味每一餐！',9,1,0,0,'','','',200),
	(15,2,'多功能保溫袋',300,'https://images.unsplash.com/photo-1547949003-9792a18a2601?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80','使用三層不同材質組合，強化絕緣效果，保溫保冷時間至2小時，保留便當風味，讓每一口都是理想溫度。',9,2,0,0,'','','',150),
	(16,2,'不鏽鋼餐具組',150,'https://images.unsplash.com/photo-1619367300924-485907ff690d?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1424&q=80','以304不鏽鋼材質製作而成，不易生鏽、簡潔乾淨，湯匙、叉子一組兩入，可收納於多功能保溫袋中。',9,3,0,0,'','','',100);

/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table profit_sharing_record
# ------------------------------------------------------------

DROP TABLE IF EXISTS `profit_sharing_record`;

CREATE TABLE `profit_sharing_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `profit` int(11) NOT NULL,
  `identity` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `plan_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `etherscan_url` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `profit_sharing_record_plan_id_3bb5cecc_fk_fund_raising_plan_id` (`plan_id`),
  KEY `profit_sharing_record_product_id_1db01b9f_fk_product_id` (`product_id`),
  CONSTRAINT `profit_sharing_record_plan_id_3bb5cecc_fk_fund_raising_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `fund_raising_plan` (`id`),
  CONSTRAINT `profit_sharing_record_product_id_1db01b9f_fk_product_id` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `profit_sharing_record` WRITE;
/*!40000 ALTER TABLE `profit_sharing_record` DISABLE KEYS */;

INSERT INTO `profit_sharing_record` (`id`, `user_id`, `profit`, `identity`, `created_at`, `plan_id`, `product_id`, `etherscan_url`)
VALUES
	(1,3,1366,'','2021-11-01 00:03:53.935635',5,1,'https://ropsten.etherscan.io/tx/0xb2df8c3a744138eed4653303265cbb52a624a883e379a53d6b005a2bf512d5f5'),
	(2,2,2186,'','2021-11-01 00:04:12.087103',5,1,'https://ropsten.etherscan.io/tx/0x8fa77030fbbd74713322586fc20a3e968a69cad07f140097541268b935191bbc'),
	(3,1,546,'','2021-11-01 00:04:38.700894',5,1,'https://ropsten.etherscan.io/tx/0x0bf8978527afdc56379f04cc22e002433367c7e222fe5364f540c81b27c86e50'),
	(4,3,4100,'','2021-11-01 00:05:13.358749',5,2,'https://ropsten.etherscan.io/tx/0x63ce75b48e6ec3be96f713502af6dd7ccf72b1b8f3f437883592117986ee250f'),
	(5,3,0,'','2022-03-08 14:37:22.935779',8,1,'https://ropsten.etherscan.io/tx/0xfa02ad10c1fca918bb9e883995e249981213f1f4112e6e3b945b79e8a69b0dad');

/*!40000 ALTER TABLE `profit_sharing_record` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sales_record
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sales_record`;

CREATE TABLE `sales_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `buyer_uid` int(11) DEFAULT NULL,
  `buyer_wallet` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `plan721_id` int(11) NOT NULL,
  `product1155_id` int(11) NOT NULL,
  `amount` int(11) NOT NULL,
  `etherscan_url` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `sales_record` WRITE;
/*!40000 ALTER TABLE `sales_record` DISABLE KEYS */;

INSERT INTO `sales_record` (`id`, `buyer_uid`, `buyer_wallet`, `plan721_id`, `product1155_id`, `amount`, `etherscan_url`, `created_at`)
VALUES
	(2,3,'0xa54d28cb36956887727ca8c71C9E50E9ec693C52',1,3,1,'https://ropsten.etherscan.io/tx/0xcd2f06a2d5bf89ab2c51590e20c84afc133a10185064cd07db38e0057086092d','2021-08-25 00:14:23.938029'),
	(3,3,'0xa54d28cb36956887727ca8c71C9E50E9ec693C52',1,4,2,'https://ropsten.etherscan.io/tx/0xc39bb2bec09825910bc96e051e0b3b1f54b5b2a82ff9eba4d67c0444a94cb49b','2021-08-25 16:01:05.804996'),
	(4,0,'0xff37C10cFDF87911A5129A412e9992ADF044F3dc',1,3,1,'https://ropsten.etherscan.io/tx/0x607a7650161360fc2dd422450fdc966a3d5fcc811a82cc6647177d2042930c34','2021-08-25 16:31:35.402820'),
	(5,0,'0xff37C10cFDF87911A5129A412e9992ADF044F3dc',3,1,1,'https://ropsten.etherscan.io/tx/0x942e161722c656b4aa36ad737710f93118808e9e953c9ae81e3e4551b73d4396','2021-09-27 14:49:59.933777'),
	(6,3,'0xa54d28cb36956887727ca8c71C9E50E9ec693C52',3,1,10,'https://ropsten.etherscan.io/tx/0xdffd57d607451f1dcc84155f38742f5055e9b34927c098a0326e4461778edab2','2021-10-31 19:03:09.322957'),
	(7,2,'0xF3f95311b2AA2E20f9234eF47fE40dcc0a5Fd6df',3,2,30,'https://ropsten.etherscan.io/tx/0xf2cff54044fb03d2bc7180337e6756c1f0cac3c3f91b8fc2160ac6423724c824','2021-10-31 19:08:53.676727');

/*!40000 ALTER TABLE `sales_record` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table test
# ------------------------------------------------------------

DROP TABLE IF EXISTS `test`;

CREATE TABLE `test` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `end_date` datetime(6) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `test` WRITE;
/*!40000 ALTER TABLE `test` DISABLE KEYS */;

INSERT INTO `test` (`id`, `name`, `end_date`, `created_at`)
VALUES
	(1,'Anna','2021-08-02 15:59:59.999999','2021-08-02 10:57:11.581066'),
	(2,'Anna','2021-08-01 16:00:00.000000','2021-08-02 10:57:11.581066'),
	(3,'Anna','2021-08-19 15:59:59.999999','2021-08-02 12:17:56.942474'),
	(4,'Anna','2021-08-02 12:19:50.208741','2021-08-02 12:19:50.227586'),
	(5,'Anna','2021-08-02 20:23:38.654178','2021-08-02 20:23:38.673336'),
	(6,'Anna','2021-08-04 23:59:59.999999','2021-08-02 20:27:57.879035'),
	(7,'Anna','2021-08-03 23:59:59.999999','2021-08-02 20:28:38.951587'),
	(8,'Elly','2021-08-04 15:01:19.648921','2021-08-04 15:01:19.681276'),
	(9,'Elly','2021-08-31 21:41:42.968194','2021-08-31 21:41:43.168837'),
	(10,'Elly','2021-08-31 21:42:02.941707','2021-08-31 21:42:02.976760'),
	(11,'Elly','2021-08-31 23:48:08.764466','2021-08-31 23:48:08.793987'),
	(12,'Elly','2021-08-31 23:48:18.738052','2021-08-31 23:48:18.754837');

/*!40000 ALTER TABLE `test` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table web_member
# ------------------------------------------------------------

DROP TABLE IF EXISTS `web_member`;

CREATE TABLE `web_member` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `blacklist` tinyint(1) NOT NULL,
  `wallet_address` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `web_member_user_id_7588b815_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `web_member` WRITE;
/*!40000 ALTER TABLE `web_member` DISABLE KEYS */;

INSERT INTO `web_member` (`id`, `blacklist`, `wallet_address`, `user_id`)
VALUES
	(1,0,'0x6b45771c0502bA39f933D1037cB4f59B635eb906',1),
	(2,0,'0xF3f95311b2AA2E20f9234eF47fE40dcc0a5Fd6df',2),
	(3,0,'0xa54d28cb36956887727ca8c71C9E50E9ec693C52',3);

/*!40000 ALTER TABLE `web_member` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
