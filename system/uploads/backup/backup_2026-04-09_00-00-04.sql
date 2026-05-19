/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19-11.4.10-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: digibdco_billing
-- ------------------------------------------------------
-- Server version	11.4.10-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*M!100616 SET @OLD_NOTE_VERBOSITY=@@NOTE_VERBOSITY, NOTE_VERBOSITY=0 */;

--
-- Table structure for table `nas`
--

DROP TABLE IF EXISTS `nas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `nas` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `nasname` varchar(128) NOT NULL,
  `shortname` varchar(32) DEFAULT NULL,
  `type` varchar(30) DEFAULT 'other',
  `ports` int(5) DEFAULT NULL,
  `secret` varchar(60) NOT NULL DEFAULT 'secret',
  `server` varchar(64) DEFAULT NULL,
  `community` varchar(50) DEFAULT NULL,
  `description` varchar(200) DEFAULT 'RADIUS Client',
  `routers` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `nasname` (`nasname`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nas`
--

LOCK TABLES `nas` WRITE;
/*!40000 ALTER TABLE `nas` DISABLE KEYS */;
INSERT INTO `nas` VALUES
(1,'103.109.96.168','NAS','other',2025,'1sDpAwUe5c',NULL,NULL,'','');
/*!40000 ALTER TABLE `nas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nasreload`
--

DROP TABLE IF EXISTS `nasreload`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `nasreload` (
  `nasipaddress` varchar(15) NOT NULL,
  `reloadtime` datetime NOT NULL,
  PRIMARY KEY (`nasipaddress`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nasreload`
--

LOCK TABLES `nasreload` WRITE;
/*!40000 ALTER TABLE `nasreload` DISABLE KEYS */;
/*!40000 ALTER TABLE `nasreload` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rad_acct`
--

DROP TABLE IF EXISTS `rad_acct`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `rad_acct` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `acctsessionid` varchar(64) NOT NULL DEFAULT '',
  `username` varchar(64) NOT NULL DEFAULT '',
  `realm` varchar(128) NOT NULL DEFAULT '',
  `nasid` varchar(32) NOT NULL DEFAULT '',
  `nasipaddress` varchar(15) NOT NULL DEFAULT '',
  `nasportid` varchar(32) DEFAULT NULL,
  `nasporttype` varchar(32) DEFAULT NULL,
  `framedipaddress` varchar(15) NOT NULL DEFAULT '',
  `acctsessiontime` bigint(20) NOT NULL DEFAULT 0,
  `acctinputoctets` bigint(20) NOT NULL DEFAULT 0,
  `acctoutputoctets` bigint(20) NOT NULL DEFAULT 0,
  `acctstatustype` varchar(32) DEFAULT NULL,
  `macaddr` varchar(50) NOT NULL,
  `dateAdded` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `username` (`username`),
  KEY `framedipaddress` (`framedipaddress`),
  KEY `acctsessionid` (`acctsessionid`),
  KEY `nasipaddress` (`nasipaddress`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rad_acct`
--

LOCK TABLES `rad_acct` WRITE;
/*!40000 ALTER TABLE `rad_acct` DISABLE KEYS */;
/*!40000 ALTER TABLE `rad_acct` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `radacct`
--

DROP TABLE IF EXISTS `radacct`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `radacct` (
  `radacctid` bigint(21) NOT NULL AUTO_INCREMENT,
  `acctsessionid` varchar(64) NOT NULL DEFAULT '',
  `acctuniqueid` varchar(32) NOT NULL DEFAULT '',
  `username` varchar(64) NOT NULL DEFAULT '',
  `realm` varchar(64) DEFAULT '',
  `nasipaddress` varchar(15) NOT NULL DEFAULT '',
  `nasportid` varchar(32) DEFAULT NULL,
  `nasporttype` varchar(32) DEFAULT NULL,
  `acctstarttime` datetime DEFAULT NULL,
  `acctupdatetime` datetime DEFAULT NULL,
  `acctstoptime` datetime DEFAULT NULL,
  `acctinterval` int(12) DEFAULT NULL,
  `acctsessiontime` int(12) unsigned DEFAULT NULL,
  `acctauthentic` varchar(32) DEFAULT NULL,
  `connectinfo_start` varchar(128) DEFAULT NULL,
  `connectinfo_stop` varchar(128) DEFAULT NULL,
  `acctinputoctets` bigint(20) DEFAULT NULL,
  `acctoutputoctets` bigint(20) DEFAULT NULL,
  `calledstationid` varchar(50) NOT NULL DEFAULT '',
  `callingstationid` varchar(50) NOT NULL DEFAULT '',
  `acctterminatecause` varchar(32) NOT NULL DEFAULT '',
  `servicetype` varchar(32) DEFAULT NULL,
  `framedprotocol` varchar(32) DEFAULT NULL,
  `framedipaddress` varchar(15) NOT NULL DEFAULT '',
  `framedipv6address` varchar(45) NOT NULL DEFAULT '',
  `framedipv6prefix` varchar(45) NOT NULL DEFAULT '',
  `framedinterfaceid` varchar(44) NOT NULL DEFAULT '',
  `delegatedipv6prefix` varchar(45) NOT NULL DEFAULT '',
  `class` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`radacctid`),
  UNIQUE KEY `acctuniqueid` (`acctuniqueid`),
  KEY `username` (`username`),
  KEY `framedipaddress` (`framedipaddress`),
  KEY `framedipv6address` (`framedipv6address`),
  KEY `framedipv6prefix` (`framedipv6prefix`),
  KEY `framedinterfaceid` (`framedinterfaceid`),
  KEY `delegatedipv6prefix` (`delegatedipv6prefix`),
  KEY `acctsessionid` (`acctsessionid`),
  KEY `acctsessiontime` (`acctsessiontime`),
  KEY `acctstarttime` (`acctstarttime`),
  KEY `acctinterval` (`acctinterval`),
  KEY `acctstoptime` (`acctstoptime`),
  KEY `nasipaddress` (`nasipaddress`),
  KEY `class` (`class`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `radacct`
--

LOCK TABLES `radacct` WRITE;
/*!40000 ALTER TABLE `radacct` DISABLE KEYS */;
/*!40000 ALTER TABLE `radacct` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `radcheck`
--

DROP TABLE IF EXISTS `radcheck`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `radcheck` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(64) NOT NULL DEFAULT '',
  `attribute` varchar(64) NOT NULL DEFAULT '',
  `op` char(2) NOT NULL DEFAULT '==',
  `value` varchar(253) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `username` (`username`(32))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `radcheck`
--

LOCK TABLES `radcheck` WRITE;
/*!40000 ALTER TABLE `radcheck` DISABLE KEYS */;
/*!40000 ALTER TABLE `radcheck` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `radgroupcheck`
--

DROP TABLE IF EXISTS `radgroupcheck`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `radgroupcheck` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `groupname` varchar(64) NOT NULL DEFAULT '',
  `attribute` varchar(64) NOT NULL DEFAULT '',
  `op` char(2) NOT NULL DEFAULT '==',
  `value` varchar(253) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `groupname` (`groupname`(32))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `radgroupcheck`
--

LOCK TABLES `radgroupcheck` WRITE;
/*!40000 ALTER TABLE `radgroupcheck` DISABLE KEYS */;
/*!40000 ALTER TABLE `radgroupcheck` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `radgroupreply`
--

DROP TABLE IF EXISTS `radgroupreply`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `radgroupreply` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `groupname` varchar(64) NOT NULL DEFAULT '',
  `attribute` varchar(64) NOT NULL DEFAULT '',
  `op` char(2) NOT NULL DEFAULT '=',
  `value` varchar(253) NOT NULL DEFAULT '',
  `plan_id` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `groupname` (`groupname`(32))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `radgroupreply`
--

LOCK TABLES `radgroupreply` WRITE;
/*!40000 ALTER TABLE `radgroupreply` DISABLE KEYS */;
/*!40000 ALTER TABLE `radgroupreply` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `radpostauth`
--

DROP TABLE IF EXISTS `radpostauth`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `radpostauth` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(64) NOT NULL DEFAULT '',
  `pass` varchar(64) NOT NULL DEFAULT '',
  `reply` varchar(32) NOT NULL DEFAULT '',
  `authdate` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `class` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `username` (`username`),
  KEY `class` (`class`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `radpostauth`
--

LOCK TABLES `radpostauth` WRITE;
/*!40000 ALTER TABLE `radpostauth` DISABLE KEYS */;
/*!40000 ALTER TABLE `radpostauth` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `radreply`
--

DROP TABLE IF EXISTS `radreply`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `radreply` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(64) NOT NULL DEFAULT '',
  `attribute` varchar(64) NOT NULL DEFAULT '',
  `op` char(2) NOT NULL DEFAULT '=',
  `value` varchar(253) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `username` (`username`(32))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `radreply`
--

LOCK TABLES `radreply` WRITE;
/*!40000 ALTER TABLE `radreply` DISABLE KEYS */;
/*!40000 ALTER TABLE `radreply` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `radusergroup`
--

DROP TABLE IF EXISTS `radusergroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `radusergroup` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(64) NOT NULL DEFAULT '',
  `groupname` varchar(64) NOT NULL DEFAULT '',
  `priority` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `username` (`username`(32))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `radusergroup`
--

LOCK TABLES `radusergroup` WRITE;
/*!40000 ALTER TABLE `radusergroup` DISABLE KEYS */;
/*!40000 ALTER TABLE `radusergroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_appconfig`
--

DROP TABLE IF EXISTS `tbl_appconfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_appconfig` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `setting` mediumtext NOT NULL,
  `value` mediumtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=120 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_appconfig`
--

LOCK TABLES `tbl_appconfig` WRITE;
/*!40000 ALTER TABLE `tbl_appconfig` DISABLE KEYS */;
INSERT INTO `tbl_appconfig` VALUES
(1,'CompanyName','Net Digital'),
(2,'currency_code','BDT.'),
(3,'language','english'),
(4,'show-logo','1'),
(5,'nstyle','blue'),
(6,'timezone','Asia/Dhaka'),
(7,'dec_point',','),
(8,'thousands_sep',','),
(9,'rtl','0'),
(10,'address','Dhakkin Salna'),
(11,'phone','01911908800'),
(12,'date_format','d M Y'),
(13,'note','Thank you...'),
(14,'api_key','721f7d89549121af9eec618caa86459c763daddd'),
(15,'csrf_token','a1e2415d74ea9640434586dfe8886800'),
(16,'CompanyFooter','Net Digital'),
(17,'printer_cols','37'),
(18,'theme','default'),
(19,'payment_usings','Bkash, Nagod, Rocket, Upay, Cash'),
(20,'reset_day','25'),
(21,'dashboard_cr','12.7,5.4,8.6,6.12'),
(22,'url_canonical','no'),
(23,'login_page_type','default'),
(24,'login_Page_template','moon'),
(25,'login_page_head',''),
(26,'login_page_description',''),
(27,'disable_registration','no'),
(28,'registration_username','username'),
(29,'photo_register','yes'),
(30,'sms_otp_registration','no'),
(31,'phone_otp_type','sms'),
(32,'reg_nofify_admin','yes'),
(33,'man_fields_email','yes'),
(34,'man_fields_fname','yes'),
(35,'man_fields_address','yes'),
(36,'session_timeout_duration',''),
(37,'single_session','no'),
(38,'csrf_enabled','no'),
(39,'disable_voucher','no'),
(40,'voucher_format','up'),
(41,'voucher_redirect',''),
(42,'radius_enable','1'),
(43,'extend_expired','0'),
(44,'extend_days',''),
(45,'extend_confirmation',''),
(46,'enable_balance','yes'),
(47,'allow_balance_transfer','no'),
(48,'minimum_transfer',''),
(49,'telegram_bot',''),
(50,'telegram_target_id',''),
(51,'sms_url','https://api.sms.net.bd/sendsms?api_key=Rh4S05kbP4Yz27isYtg9P1qZohC5So8aL4SY49NJ&msg={YOUR_MSG}&to=8801800000000'),
(52,'mikrotik_sms_command','/tool sms send'),
(53,'wa_url','https://wa.nux.my.id/api/sendWA?to=[number]&msg=[text]&secret=a3649822403ab941baf9e793b193f066'),
(54,'smtp_host',''),
(55,'smtp_port',''),
(56,'smtp_user',''),
(57,'smtp_pass',''),
(58,'smtp_ssltls',''),
(59,'mail_from',''),
(60,'mail_reply_to',''),
(61,'user_notification_expired','sms'),
(62,'user_notification_payment','sms'),
(63,'user_notification_reminder','sms'),
(64,'tawkto',''),
(65,'tawkto_api_key',''),
(66,'http_proxy',''),
(67,'http_proxyauth',''),
(68,'enable_tax','no'),
(69,'tax_rate','0.5'),
(70,'custom_tax_rate',''),
(71,'github_username',''),
(72,'github_token',''),
(73,'man_fields_custom','no'),
(74,'enable_session_timeout','0'),
(75,'hide_mrc','no'),
(76,'hide_tms','no'),
(77,'hide_al','no'),
(78,'hide_uet','no'),
(79,'hide_vs','no'),
(80,'hide_pg','no'),
(81,'hide_aui','no'),
(82,'country_code_phone','88'),
(83,'radius_plan','Radius Plan'),
(84,'hotspot_plan','Hotspot Plan'),
(85,'pppoe_plan','PPPOE Plan'),
(86,'vpn_plan','VPN Plan'),
(87,'allow_balance_custom','no'),
(88,'notification_reminder_1day','yes'),
(89,'notification_reminder_3days','yes'),
(90,'notification_reminder_7days','yes'),
(91,'asset_welcome_message_viewed','yes'),
(92,'new_version_notify','disable'),
(93,'router_check','1'),
(94,'allow_phone_otp','no'),
(95,'allow_email_otp','no'),
(96,'show_bandwidth_plan','no'),
(97,'hs_auth_method','api'),
(98,'frrest_interim_update','5'),
(99,'check_customer_online','yes'),
(100,'extend_expiry','yes'),
(101,'save','save'),
(102,'speedtest_mode','1'),
(103,'speedtest_template','a'),
(104,'docs_clicked','yes'),
(105,'general',''),
(106,'backup_auto','1'),
(107,'backup_clear_old','0'),
(108,'backup_backup_time','everyday'),
(109,'backup_retain_count',''),
(110,'backup_retain_days',NULL),
(111,'cloud_upload','0'),
(112,'backup_dropbox_upload','0'),
(113,'backup_dropbox_token',''),
(114,'backup_telegram_upload','0'),
(115,'backup_telegram_chatId',''),
(116,'alt_wga_server_url','https://ultramsg.com/m/4bK7z7V'),
(117,'alt_wga_device_id','7TH+An/BKRk5xdBWjPOlKw=='),
(118,'alt_wga_username',''),
(119,'alt_wga_password','');
/*!40000 ALTER TABLE `tbl_appconfig` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_asset_brands`
--

DROP TABLE IF EXISTS `tbl_asset_brands`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_asset_brands` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `status` enum('Active','Inactive') DEFAULT 'Active',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_brand_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_asset_brands`
--

LOCK TABLES `tbl_asset_brands` WRITE;
/*!40000 ALTER TABLE `tbl_asset_brands` DISABLE KEYS */;
INSERT INTO `tbl_asset_brands` VALUES
(1,'Cisco Systems','Leading provider of networking equipment','United States','https://www.cisco.com','Active','2026-03-19 18:03:59','2026-03-19 18:03:59'),
(2,'Ubiquiti Networks','Manufacturer of networking and wireless communication products','United States','https://www.ui.com','Active','2026-03-19 18:03:59','2026-03-19 18:03:59'),
(3,'MikroTik','Latvian manufacturer of computer networking equipment','Latvia','https://mikrotik.com','Active','2026-03-19 18:03:59','2026-03-19 18:03:59'),
(4,'TP-Link','Chinese manufacturer of computer networking products','China','https://www.tp-link.com','Active','2026-03-19 18:03:59','2026-03-19 18:03:59'),
(5,'Huawei','Chinese multinational technology corporation','China','https://www.huawei.com','Active','2026-03-19 18:03:59','2026-03-19 18:03:59');
/*!40000 ALTER TABLE `tbl_asset_brands` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_asset_categories`
--

DROP TABLE IF EXISTS `tbl_asset_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_asset_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `status` enum('Active','Inactive') DEFAULT 'Active',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_category_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_asset_categories`
--

LOCK TABLES `tbl_asset_categories` WRITE;
/*!40000 ALTER TABLE `tbl_asset_categories` DISABLE KEYS */;
INSERT INTO `tbl_asset_categories` VALUES
(1,'Network Equipment','Routers, switches, access points, and other networking hardware','Active','2026-03-19 18:03:59','2026-03-19 18:03:59'),
(2,'Power Equipment','UPS, power supplies, batteries, and power management devices','Active','2026-03-19 18:03:59','2026-03-19 18:03:59'),
(3,'Transmission Equipment','Fiber optic equipment, wireless transmission, antennas','Active','2026-03-19 18:03:59','2026-03-19 18:03:59'),
(4,'Computing Equipment','Servers, computers, storage devices','Active','2026-03-19 18:03:59','2026-03-19 18:03:59'),
(5,'Infrastructure','Towers, cabinets, cables, and physical infrastructure','Active','2026-03-19 18:03:59','2026-03-19 18:03:59');
/*!40000 ALTER TABLE `tbl_asset_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_asset_models`
--

DROP TABLE IF EXISTS `tbl_asset_models`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_asset_models` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `brand_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `model_number` varchar(100) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `specifications` text DEFAULT NULL,
  `status` enum('Active','Inactive') DEFAULT 'Active',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_brand_id` (`brand_id`),
  CONSTRAINT `fk_models_brand` FOREIGN KEY (`brand_id`) REFERENCES `tbl_asset_brands` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_asset_models`
--

LOCK TABLES `tbl_asset_models` WRITE;
/*!40000 ALTER TABLE `tbl_asset_models` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_asset_models` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_assets`
--

DROP TABLE IF EXISTS `tbl_assets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_assets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) NOT NULL,
  `brand_id` int(11) NOT NULL,
  `model_id` int(11) NOT NULL,
  `asset_tag` varchar(100) NOT NULL,
  `serial_number` varchar(255) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `purchase_date` date DEFAULT NULL,
  `purchase_cost` decimal(15,2) DEFAULT NULL,
  `warranty_expiry` date DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `latitude` decimal(10,8) DEFAULT NULL,
  `longitude` decimal(11,8) DEFAULT NULL,
  `assigned_to` int(11) DEFAULT NULL,
  `status` enum('Active','Inactive','Under Maintenance','Disposed') DEFAULT 'Active',
  `condition_status` enum('Excellent','Good','Fair','Poor') DEFAULT 'Good',
  `notes` text DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_asset_tag` (`asset_tag`),
  KEY `idx_category_id` (`category_id`),
  KEY `idx_brand_id` (`brand_id`),
  KEY `idx_model_id` (`model_id`),
  KEY `idx_assigned_to` (`assigned_to`),
  KEY `idx_status` (`status`),
  KEY `idx_coordinates` (`latitude`,`longitude`),
  CONSTRAINT `fk_assets_brand` FOREIGN KEY (`brand_id`) REFERENCES `tbl_asset_brands` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_assets_category` FOREIGN KEY (`category_id`) REFERENCES `tbl_asset_categories` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_assets_customer` FOREIGN KEY (`assigned_to`) REFERENCES `tbl_customers` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_assets_model` FOREIGN KEY (`model_id`) REFERENCES `tbl_asset_models` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_assets`
--

LOCK TABLES `tbl_assets` WRITE;
/*!40000 ALTER TABLE `tbl_assets` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_assets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_bandwidth`
--

DROP TABLE IF EXISTS `tbl_bandwidth`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_bandwidth` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name_bw` varchar(255) NOT NULL,
  `rate_down` int(10) unsigned NOT NULL,
  `rate_down_unit` enum('Kbps','Mbps') NOT NULL,
  `rate_up` int(10) unsigned NOT NULL,
  `rate_up_unit` enum('Kbps','Mbps') NOT NULL,
  `burst` varchar(128) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_bandwidth`
--

LOCK TABLES `tbl_bandwidth` WRITE;
/*!40000 ALTER TABLE `tbl_bandwidth` DISABLE KEYS */;
INSERT INTO `tbl_bandwidth` VALUES
(3,'5Mbps',60,'Mbps',60,'Mbps',''),
(4,'10Mbps',70,'Mbps',70,'Mbps',''),
(8,'600-Taka',60,'Mbps',60,'Mbps',''),
(9,'1000-Taka',80,'Mbps',80,'Mbps',''),
(10,'800-Taka',80,'Mbps',80,'Mbps','');
/*!40000 ALTER TABLE `tbl_bandwidth` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_coupons`
--

DROP TABLE IF EXISTS `tbl_coupons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_coupons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(50) NOT NULL,
  `type` enum('fixed','percent') NOT NULL,
  `value` decimal(10,2) NOT NULL,
  `description` text NOT NULL,
  `max_usage` int(11) NOT NULL DEFAULT 1,
  `usage_count` int(11) NOT NULL DEFAULT 0,
  `status` enum('active','inactive') NOT NULL,
  `min_order_amount` decimal(10,2) NOT NULL,
  `max_discount_amount` decimal(10,2) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_coupons`
--

LOCK TABLES `tbl_coupons` WRITE;
/*!40000 ALTER TABLE `tbl_coupons` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_coupons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_customers`
--

DROP TABLE IF EXISTS `tbl_customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_customers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `photo` varchar(128) NOT NULL DEFAULT '/user.default.jpg',
  `pppoe_username` varchar(32) NOT NULL DEFAULT '' COMMENT 'For PPPOE Login',
  `pppoe_password` varchar(45) NOT NULL DEFAULT '' COMMENT 'For PPPOE Login',
  `pppoe_ip` varchar(32) NOT NULL DEFAULT '' COMMENT 'For PPPOE Login',
  `fullname` varchar(45) NOT NULL,
  `address` mediumtext DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `district` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `zip` varchar(10) DEFAULT NULL,
  `phonenumber` varchar(20) DEFAULT '0',
  `email` varchar(128) NOT NULL DEFAULT '1',
  `coordinates` varchar(50) NOT NULL DEFAULT '' COMMENT 'Latitude and Longitude coordinates',
  `account_type` enum('Business','Personal') DEFAULT 'Personal' COMMENT 'For selecting account type',
  `balance` decimal(15,2) NOT NULL DEFAULT 0.00 COMMENT 'For Money Deposit',
  `service_type` enum('Hotspot','PPPoE','VPN','Others') DEFAULT 'Others' COMMENT 'For selecting user type',
  `auto_renewal` tinyint(1) NOT NULL DEFAULT 1 COMMENT 'Auto renewall using balance',
  `status` enum('Active','Banned','Disabled','Inactive','Limited','Suspended') NOT NULL DEFAULT 'Active',
  `created_by` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `last_login` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1324 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_customers`
--

LOCK TABLES `tbl_customers` WRITE;
/*!40000 ALTER TABLE `tbl_customers` DISABLE KEYS */;
INSERT INTO `tbl_customers` VALUES
(660,'s1','667788','/user.default.jpg','','','','s1','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(661,'s2','667788','/user.default.jpg','','','','s2','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(662,'s3','667788','/user.default.jpg','','','','s3','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(663,'s5','667788','/user.default.jpg','','','','s5','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(664,'s6','667788','/user.default.jpg','','','','s6','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(665,'s7','667788','/user.default.jpg','','','','s7','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(666,'s8','667788','/user.default.jpg','','','','s8','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(667,'s9','667788','/user.default.jpg','','','','s9','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(668,'s10','667788','/user.default.jpg','','','','s10','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(669,'s12','667788','/user.default.jpg','','','','s12','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(670,'s13','667788','/user.default.jpg','','','','s13','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(671,'s14','667788','/user.default.jpg','','','','s14','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(672,'s15','667788','/user.default.jpg','','','','s15','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(673,'s16','667788','/user.default.jpg','','','','s16','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(674,'s17','667788','/user.default.jpg','','','','s17','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(675,'s18','667788','/user.default.jpg','','','','s18','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(676,'s19','667788','/user.default.jpg','','','','s19','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(677,'s20','667788','/user.default.jpg','','','','s20','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(678,'s22','667788','/user.default.jpg','','','','s22','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(679,'s23','667788','/user.default.jpg','','','','s23','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(680,'s24','667788','/user.default.jpg','','','','s24','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(681,'s25','667788','/user.default.jpg','','','','s25','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(682,'s26','667788','/user.default.jpg','','','','s26','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(683,'s27','667788','/user.default.jpg','','','','s27','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(684,'s28','667788','/user.default.jpg','','','','s28','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(685,'s29','667788','/user.default.jpg','','','','s29','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(686,'s32','667788','/user.default.jpg','','','','s32','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(687,'s33','667788','/user.default.jpg','','','','s33','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(688,'s34','667788','/user.default.jpg','','','','s34','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(689,'s36','667788','/user.default.jpg','','','','s36','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(690,'s37','667788','/user.default.jpg','','','','s37','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(691,'s38','667788','/user.default.jpg','','','','s38','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(692,'s39','667788','/user.default.jpg','','','','s39','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(693,'s40','667788','/user.default.jpg','','','','s40','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(694,'s41','667788','/user.default.jpg','','','','s41','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(695,'s43','667788','/user.default.jpg','','','','s43','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(696,'s45','667788','/user.default.jpg','','','','s45','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(697,'s46','667788','/user.default.jpg','','','','s46','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(698,'s47','667788','/user.default.jpg','','','','s47','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(699,'s48','667788','/user.default.jpg','','','','s48','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(700,'s49','667788','/user.default.jpg','','','','s49','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(701,'s50','667788','/user.default.jpg','','','','s50','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(702,'s51','667788','/user.default.jpg','','','','s51','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(703,'s53','667788','/user.default.jpg','','','','s53','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(704,'s54','667788','/user.default.jpg','','','','s54','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(705,'s55','667788','/user.default.jpg','','','','s55','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(706,'s56','667788','/user.default.jpg','','','','s56','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(707,'s59','667788','/user.default.jpg','','','','s59','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(708,'s60','667788','/user.default.jpg','','','','s60','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(709,'s61','667788','/user.default.jpg','','','','s61','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(711,'s63','667788','/user.default.jpg','','','','s63','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(712,'s64','667788','/user.default.jpg','','','','s64','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(713,'s65','667788','/user.default.jpg','','','','s65','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(714,'s66','667788','/user.default.jpg','','','','s66','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(715,'s67','667788','/user.default.jpg','','','','s67','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(716,'s69','667788','/user.default.jpg','','','','s69','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(717,'s70','667788','/user.default.jpg','','','','s70','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(718,'s71','667788','/user.default.jpg','','','','s71','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(719,'s72','667788','/user.default.jpg','','','','s72','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(720,'s74','667788','/user.default.jpg','','','','s74','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(721,'s75','667788','/user.default.jpg','','','','s75','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(722,'s76','667788','/user.default.jpg','','','','s76','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(723,'s77','667788','/user.default.jpg','','','','s77','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(724,'s78','667788','/user.default.jpg','','','','s78','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(725,'s79','667788','/user.default.jpg','','','','s79','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(726,'s82','667788','/user.default.jpg','','','','s82','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(727,'s83','667788','/user.default.jpg','','','','s83','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(728,'s85','667788','/user.default.jpg','','','','s85','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(729,'s86','667788','/user.default.jpg','','','','s86','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(730,'s87','667788','/user.default.jpg','','','','s87','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(731,'s88','667788','/user.default.jpg','','','','s88','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(732,'s90','667788','/user.default.jpg','','','','s90','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(733,'s91','667788','/user.default.jpg','','','','s91','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(734,'s93','667788','/user.default.jpg','','','','s93','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(735,'s94','667788','/user.default.jpg','','','','s94','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(736,'s96','667788','/user.default.jpg','','','','s96','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(737,'s98','667788','/user.default.jpg','','','','s98','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(738,'s102','667788','/user.default.jpg','','','','s102','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(739,'s103','667788','/user.default.jpg','','','','s103','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(740,'s104','667788','/user.default.jpg','','','','s104','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(741,'s105','667788','/user.default.jpg','','','','s105','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(742,'s106','667788','/user.default.jpg','','','','s106','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(743,'s107','667788','/user.default.jpg','','','','s107','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(744,'s108','667788','/user.default.jpg','','','','s108','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(745,'s109','667788','/user.default.jpg','','','','s109','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(746,'s110','667788','/user.default.jpg','','','','s110','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(747,'s111','667788','/user.default.jpg','','','','s111','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(748,'s113','667788','/user.default.jpg','','','','s113','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(749,'s114','667788','/user.default.jpg','','','','s114','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(750,'s115','667788','/user.default.jpg','','','','s115','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(751,'s117','667788','/user.default.jpg','','','','s117','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(752,'s119','667788','/user.default.jpg','','','','s119','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(753,'s120','667788','/user.default.jpg','','','','s120','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(754,'s121','667788','/user.default.jpg','','','','s121','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(755,'s122','667788','/user.default.jpg','','','','s122','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(756,'s123','667788','/user.default.jpg','','','','s123','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(757,'s124','667788','/user.default.jpg','','','','s124','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(758,'s125','667788','/user.default.jpg','','','','s125','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(759,'s126','667788','/user.default.jpg','','','','s126','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(760,'s127','667788','/user.default.jpg','','','','s127','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(761,'s128','667788','/user.default.jpg','','','','s128','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(762,'s130','667788','/user.default.jpg','','','','s130','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(763,'s131','667788','/user.default.jpg','','','','s131','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(764,'s132','667788','/user.default.jpg','','','','s132','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(765,'s133','667788','/user.default.jpg','','','','s133','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(766,'s134','667788','/user.default.jpg','','','','s134','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(767,'s136','667788','/user.default.jpg','','','','s136','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(768,'s139','667788','/user.default.jpg','','','','s139','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(769,'s140','667788','/user.default.jpg','','','','s140','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(770,'s141','667788','/user.default.jpg','','','','s141','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(771,'s142','667788','/user.default.jpg','','','','s142','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(773,'s144','667788','/user.default.jpg','','','','s144','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(774,'s145','667788','/user.default.jpg','','','','s145','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(775,'s148','667788','/user.default.jpg','','','','s148','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(776,'s149','667788','/user.default.jpg','','','','s149','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(778,'s151','667788','/user.default.jpg','','','','s151','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(779,'s152','667788','/user.default.jpg','','','','s152','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(780,'s153','667788','/user.default.jpg','','','','s153','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(781,'s154','667788','/user.default.jpg','','','','s154','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(782,'s155','667788','/user.default.jpg','','','','s155','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(783,'s156','667788','/user.default.jpg','','','','s156','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(784,'s157','667788','/user.default.jpg','','','','s157','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(785,'s159','667788','/user.default.jpg','','','','s159','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(786,'s160','667788','/user.default.jpg','','','','s160','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(787,'s161','667788','/user.default.jpg','','','','s161','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(788,'s162','667788','/user.default.jpg','','','','s162','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(789,'s163','667788','/user.default.jpg','','','','s163','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(790,'s164','667788','/user.default.jpg','','','','s164','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(791,'s165','667788','/user.default.jpg','','','','s165','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(792,'s166','667788','/user.default.jpg','','','','s166','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(793,'s167','667788','/user.default.jpg','','','','s167','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(794,'s169','667788','/user.default.jpg','','','','s169','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(795,'s171','667788','/user.default.jpg','','','','s171','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(796,'s172','667788','/user.default.jpg','','','','s172','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(797,'s173','667788','/user.default.jpg','','','','s173','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(798,'s174','667788','/user.default.jpg','','','','s174','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(799,'s175','667788','/user.default.jpg','','','','s175','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(800,'s176','667788','/user.default.jpg','','','','s176','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(801,'s178','667788','/user.default.jpg','','','','s178','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(802,'s179','667788','/user.default.jpg','','','','s179','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(803,'s180','667788','/user.default.jpg','','','','s180','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(804,'s182','667788','/user.default.jpg','','','','s182','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(805,'s183','667788','/user.default.jpg','','','','s183','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(806,'s184','667788','/user.default.jpg','','','','s184','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(807,'s185','667788','/user.default.jpg','','','','s185','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(808,'s187','667788','/user.default.jpg','','','','s187','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(809,'s188','667788','/user.default.jpg','','','','s188','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(810,'s189','667788','/user.default.jpg','','','','s189','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(811,'s190','667788','/user.default.jpg','','','','s190','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(812,'s191','667788','/user.default.jpg','','','','s191','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(813,'s192','667788','/user.default.jpg','','','','s192','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(814,'s193','667788','/user.default.jpg','','','','s193','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(815,'s194','667788','/user.default.jpg','','','','s194','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(816,'s196','667788','/user.default.jpg','','','','s196','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(817,'s197','667788','/user.default.jpg','','','','s197','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(818,'s198','667788','/user.default.jpg','','','','s198','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(819,'s199','667788','/user.default.jpg','','','','s199','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(820,'s200','667788','/user.default.jpg','','','','s200','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(821,'s201','667788','/user.default.jpg','','','','s201','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(822,'s203','667788','/user.default.jpg','','','','s203','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(823,'s204','667788','/user.default.jpg','','','','s204','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(824,'s205','667788','/user.default.jpg','','','','s205','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(825,'s206','667788','/user.default.jpg','','','','s206','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(826,'s207','667788','/user.default.jpg','','','','s207','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(827,'s208','667788','/user.default.jpg','','','','s208','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(828,'s209','667788','/user.default.jpg','','','','s209','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(829,'s210','667788','/user.default.jpg','','','','s210','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(830,'s212','667788','/user.default.jpg','','','','s212','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(831,'s213','667788','/user.default.jpg','','','','s213','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(832,'s214','667788','/user.default.jpg','','','','s214','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(833,'s215','667788','/user.default.jpg','','','','s215','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(834,'s216','667788','/user.default.jpg','','','','s216','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(835,'s218','667788','/user.default.jpg','','','','s218','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(836,'s219','667788','/user.default.jpg','','','','s219','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(837,'s220','667788','/user.default.jpg','','','','s220','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(838,'s221','667788','/user.default.jpg','','','','s221','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(839,'s222','667788','/user.default.jpg','','','','s222','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(840,'s241','667788','/user.default.jpg','','','','s241','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(841,'s244','667788','/user.default.jpg','','','','s244','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(842,'s95','667788','/user.default.jpg','','','','s95','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(844,'stest1','667788','/user.default.jpg','','','','stest1','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(845,'s300','667788','/user.default.jpg','','','','s300','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(846,'s242','667788','/user.default.jpg','','','','s242','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(847,'s223','667788','/user.default.jpg','','','','s223','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(848,'s224','667788','/user.default.jpg','','','','s224','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(849,'s225','667788','/user.default.jpg','','','','s225','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(850,'s226','667788','/user.default.jpg','','','','s226','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(851,'s227','667788','/user.default.jpg','','','','s227','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(852,'s228','667788','/user.default.jpg','','','','s228','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(853,'s229','667788','/user.default.jpg','','','','s229','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(854,'s230','667788','/user.default.jpg','','','','s230','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(855,'s250','667788','/user.default.jpg','','','','s250','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(856,'s232','667788','/user.default.jpg','','','','s232','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(857,'s233','667788','/user.default.jpg','','','','s233','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(858,'s235','667788','/user.default.jpg','','','','s235','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(859,'s236','667788','/user.default.jpg','','','','s236','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(860,'s237','667788','/user.default.jpg','','','','s237','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(861,'s239','667788','/user.default.jpg','','','','s239','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(862,'s240','667788','/user.default.jpg','','','','s240','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(863,'s246','667788','/user.default.jpg','','','','s246','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(864,'s247','667788','/user.default.jpg','','','','s247','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(865,'s248','667788','/user.default.jpg','','','','s248','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(866,'s249','667788','/user.default.jpg','','','','s249','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(867,'s254','667788','/user.default.jpg','','','','s254','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(868,'s251','667788','/user.default.jpg','','','','s251','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(869,'s253','667788','/user.default.jpg','','','','s253','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(870,'s255','667788','/user.default.jpg','','','','s255','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(871,'s256','667788','/user.default.jpg','','','','s256','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(872,'s257','667788','/user.default.jpg','','','','s257','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(873,'s258','667788','/user.default.jpg','','','','s258','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(874,'s259','667788','/user.default.jpg','','','','s259','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(875,'s260','667788','/user.default.jpg','','','','s260','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(876,'s261','667788','/user.default.jpg','','','','s261','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(877,'s262','667788','/user.default.jpg','','','','s262','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(878,'s265','667788','/user.default.jpg','','','','s265','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(879,'s266','667788','/user.default.jpg','','','','s266','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(880,'s267','667788','/user.default.jpg','','','','s267','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(881,'s269','667788','/user.default.jpg','','','','s269','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(882,'s270','667788','/user.default.jpg','','','','s270','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(883,'office4','667788','/user.default.jpg','','','','office4','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(884,'office6','667788','/user.default.jpg','','','','office6','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(885,'office9','667788','/user.default.jpg','','','','office9','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(886,'s277','667788','/user.default.jpg','','','','s277','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(888,'s282','667788','/user.default.jpg','','','','s282','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(889,'s283','667788','/user.default.jpg','','','','s283','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(890,'s284','667788','/user.default.jpg','','','','s284','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(891,'s286','667788','/user.default.jpg','','','','s286','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(892,'s287','667788','/user.default.jpg','','','','s287','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(893,'s290','667788','/user.default.jpg','','','','s290','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(894,'s295','667788','/user.default.jpg','','','','s295','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(895,'s298','667788','/user.default.jpg','','','','s298','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(896,'s343','667788','/user.default.jpg','','','','s343','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(897,'s344','667788','/user.default.jpg','','','','s344','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(898,'s366','667788','/user.default.jpg','','','','s366','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(899,'s445','667788','/user.default.jpg','','','','s445','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(900,'s446','667788','/user.default.jpg','','','','s446','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(901,'s449','667788','/user.default.jpg','','','','s449','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(902,'s453','667788','/user.default.jpg','','','','s453','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(903,'s454','667788','/user.default.jpg','','','','s454','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(904,'s456','667788','/user.default.jpg','','','','s456','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(905,'s457','667788','/user.default.jpg','','','','s457','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(906,'s458','667788','/user.default.jpg','','','','s458','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(907,'s460','667788','/user.default.jpg','','','','s460','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(908,'s461','667788','/user.default.jpg','','','','s461','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(909,'s462','667788','/user.default.jpg','','','','s462','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(910,'s463','667788','/user.default.jpg','','','','s463','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(912,'s465','667788','/user.default.jpg','','','','s465','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(913,'s466','667788','/user.default.jpg','','','','s466','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(914,'s467','667788','/user.default.jpg','','','','s467','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(915,'s469','667788','/user.default.jpg','','','','s469','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(916,'s470','667788','/user.default.jpg','','','','s470','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(917,'s471','667788','/user.default.jpg','','','','s471','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(918,'s472','667788','/user.default.jpg','','','','s472','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(919,'s474','667788','/user.default.jpg','','','','s474','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(920,'s475','667788','/user.default.jpg','','','','s475','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(921,'s476','667788','/user.default.jpg','','','','s476','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(922,'s477','667788','/user.default.jpg','','','','s477','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(923,'s478','667788','/user.default.jpg','','','','s478','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(924,'s479','667788','/user.default.jpg','','','','s479','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(925,'s480','667788','/user.default.jpg','','','','s480','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(926,'s481','667788','/user.default.jpg','','','','s481','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(927,'s482','667788','/user.default.jpg','','','','s482','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(928,'s484','667788','/user.default.jpg','','','','s484','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(929,'s485','667788','/user.default.jpg','','','','s485','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(930,'s486','667788','/user.default.jpg','','','','s486','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(931,'s487','667788','/user.default.jpg','','','','s487','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(932,'s488','667788','/user.default.jpg','','','','s488','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(933,'s489','667788','/user.default.jpg','','','','s489','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(934,'s490','667788','/user.default.jpg','','','','s490','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(935,'s493','667788','/user.default.jpg','','','','s493','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(936,'s494','667788','/user.default.jpg','','','','s494','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(937,'s495','667788','/user.default.jpg','','','','s495','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(938,'s496','667788','/user.default.jpg','','','','s496','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(939,'s177','667788','/user.default.jpg','','','','s177','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(940,'s202','667788','/user.default.jpg','','','','s202','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(941,'s271','667788','/user.default.jpg','','','','s271','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(942,'s272','667788','/user.default.jpg','','','','s272','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(943,'s274','667788','/user.default.jpg','','','','s274','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(944,'s276','667788','/user.default.jpg','','','','s276','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(945,'s278','667788','/user.default.jpg','','','','s278','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(946,'s279','667788','/user.default.jpg','','','','s279','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(948,'s289','667788','/user.default.jpg','','','','s289','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(949,'s291','667788','/user.default.jpg','','','','s291','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(950,'s292','667788','/user.default.jpg','','','','s292','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(951,'s293','667788','/user.default.jpg','','','','s293','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(952,'s294','667788','/user.default.jpg','','','','s294','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(953,'s297','667788','/user.default.jpg','','','','s297','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(954,'s301','667788','/user.default.jpg','','','','s301','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(955,'s302','667788','/user.default.jpg','','','','s302','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(957,'s304','667788','/user.default.jpg','','','','s304','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(958,'s305','667788','/user.default.jpg','','','','s305','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(959,'s306','667788','/user.default.jpg','','','','s306','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(960,'s307','667788','/user.default.jpg','','','','s307','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(961,'s308','667788','/user.default.jpg','','','','s308','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(962,'s309','667788','/user.default.jpg','','','','s309','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(963,'s310','667788','/user.default.jpg','','','','s310','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(964,'s311','667788','/user.default.jpg','','','','s311','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(965,'s312','667788','/user.default.jpg','','','','s312','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(966,'s313','667788','/user.default.jpg','','','','s313','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(967,'s316','667788','/user.default.jpg','','','','s316','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(968,'s317','667788','/user.default.jpg','','','','s317','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(969,'s318','667788','/user.default.jpg','','','','s318','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(970,'s319','667788','/user.default.jpg','','','','s319','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(971,'s320','667788','/user.default.jpg','','','','s320','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(972,'s321','667788','/user.default.jpg','','','','s321','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(973,'s322','667788','/user.default.jpg','','','','s322','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(974,'s323','667788','/user.default.jpg','','','','s323','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(975,'s324','667788','/user.default.jpg','','','','s324','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(976,'s325','667788','/user.default.jpg','','','','s325','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(977,'s326','667788','/user.default.jpg','','','','s326','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(978,'s327','667788','/user.default.jpg','','','','s327','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(979,'s328','667788','/user.default.jpg','','','','Shakil','','','','','','881846214131','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(980,'s330','667788','/user.default.jpg','','','','s330','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(981,'s331','667788','/user.default.jpg','','','','s331','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(982,'s333','667788','/user.default.jpg','','','','s333','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(983,'s334','667788','/user.default.jpg','','','','s334','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(984,'s336','667788','/user.default.jpg','','','','s336','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(985,'s337','667788','/user.default.jpg','','','','s337','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(986,'s338','667788','/user.default.jpg','','','','s338','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(987,'s339','667788','/user.default.jpg','','','','s339','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(988,'s340','667788','/user.default.jpg','','','','s340','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(989,'s341','667788','/user.default.jpg','','','','s341','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(990,'s345','667788','/user.default.jpg','','','','s345','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(991,'s346','667788','/user.default.jpg','','','','s346','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(992,'s347','667788','/user.default.jpg','','','','s347','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(993,'s350','667788','/user.default.jpg','','','','s350','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(994,'s351','667788','/user.default.jpg','','','','s351','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(995,'s352','667788','/user.default.jpg','','','','s352','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(996,'s354','667788','/user.default.jpg','','','','s354','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(997,'s355','667788','/user.default.jpg','','','','s355','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(998,'s357','667788','/user.default.jpg','','','','s357','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(999,'s360','667788','/user.default.jpg','','','','s360','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1000,'s361','667788','/user.default.jpg','','','','s361','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1001,'s363','667788','/user.default.jpg','','','','s363','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1002,'s365','667788','/user.default.jpg','','','','s365','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1003,'s367','667788','/user.default.jpg','','','','s367','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1004,'s369','667788','/user.default.jpg','','','','s369','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1005,'s370','667788','/user.default.jpg','','','','s370','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1006,'s372','667788','/user.default.jpg','','','','s372','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1007,'s373','667788','/user.default.jpg','','','','s373','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1008,'s376','667788','/user.default.jpg','','','','s376','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1009,'s377','667788','/user.default.jpg','','','','s377','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1010,'s378','667788','/user.default.jpg','','','','s378','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1011,'s379','667788','/user.default.jpg','','','','s379','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1012,'s381','667788','/user.default.jpg','','','','s381','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1013,'s383','667788','/user.default.jpg','','','','s383','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1014,'s385','667788','/user.default.jpg','','','','s385','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1015,'s388','667788','/user.default.jpg','','','','s388','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1016,'s390','667788','/user.default.jpg','','','','s390','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1017,'s391','667788','/user.default.jpg','','','','s391','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1018,'s392','667788','/user.default.jpg','','','','s392','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1019,'s393','667788','/user.default.jpg','','','','s393','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1020,'s394','667788','/user.default.jpg','','','','s394','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1021,'s395','667788','/user.default.jpg','','','','s395','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1022,'s396','667788','/user.default.jpg','','','','s396','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1023,'s397','667788','/user.default.jpg','','','','s397','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1024,'s400','667788','/user.default.jpg','','','','s400','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1025,'s403','667788','/user.default.jpg','','','','s403','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1026,'s404','667788','/user.default.jpg','','','','s404','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1027,'s405','667788','/user.default.jpg','','','','s405','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1028,'s406','667788','/user.default.jpg','','','','s406','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1029,'s408','667788','/user.default.jpg','','','','s408','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1030,'s409','667788','/user.default.jpg','','','','s409','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1031,'s411','667788','/user.default.jpg','','','','s411','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1032,'s412','667788','/user.default.jpg','','','','s412','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1033,'s413','667788','/user.default.jpg','','','','s413','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1034,'s415','667788','/user.default.jpg','','','','s415','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1035,'s418','667788','/user.default.jpg','','','','s418','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1036,'s420','667788','/user.default.jpg','','','','s420','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1037,'s421','667788','/user.default.jpg','','','','s421','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1038,'s423','667788','/user.default.jpg','','','','s423','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1039,'s424','667788','/user.default.jpg','','','','s424','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1040,'s426','667788','/user.default.jpg','','','','s426','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1041,'s428','667788','/user.default.jpg','','','','s428','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1042,'s430','667788','/user.default.jpg','','','','s430','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1043,'s431','667788','/user.default.jpg','','','','s431','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1044,'s432','667788','/user.default.jpg','','','','s432','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1045,'s433','667788','/user.default.jpg','','','','s433','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1046,'s437','667788','/user.default.jpg','','','','s437','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1047,'s438','667788','/user.default.jpg','','','','s438','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1048,'s439','667788','/user.default.jpg','','','','s439','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1049,'s440','667788','/user.default.jpg','','','','s440','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1050,'s442','667788','/user.default.jpg','','','','s442','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1051,'s443','667788','/user.default.jpg','','','','s443','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1052,'s447','667788','/user.default.jpg','','','','s447','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1053,'s450','667788','/user.default.jpg','','','','s450','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1054,'s451','667788','/user.default.jpg','','','','s451','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1055,'s101','667788','/user.default.jpg','','','','s101','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1056,'s211','667788','/user.default.jpg','','','','s211','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1057,'s281','667788','/user.default.jpg','','','','s281','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1058,'s288','667788','/user.default.jpg','','','','s288','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1059,'s299','667788','/user.default.jpg','','','','s299','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1060,'s30','667788','/user.default.jpg','','','','s30','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1061,'s349','667788','/user.default.jpg','','','','s349','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1062,'s356','667788','/user.default.jpg','','','','s356','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1063,'s358','667788','/user.default.jpg','','','','s358','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1064,'s371','667788','/user.default.jpg','','','','s371','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1065,'s382','667788','/user.default.jpg','','','','s382','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1066,'s384','667788','/user.default.jpg','','','','s384','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1067,'s386','667788','/user.default.jpg','','','','s386','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1068,'s389','667788','/user.default.jpg','','','','s389','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1069,'s398','667788','/user.default.jpg','','','','s398','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1070,'s401','667788','/user.default.jpg','','','','s401','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1071,'s410','667788','/user.default.jpg','','','','s410','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1072,'s414','667788','/user.default.jpg','','','','s414','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1073,'s434','667788','/user.default.jpg','','','','s434','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1074,'s435','667788','/user.default.jpg','','','','s435','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1075,'s44','667788','/user.default.jpg','','','','s44','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1076,'s448','667788','/user.default.jpg','','','','s448','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1077,'s498','667788','/user.default.jpg','','','','s498','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1079,'s500','667788','/user.default.jpg','','','','s500','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1080,'s501','667788','/user.default.jpg','','','','s501','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1081,'s504','667788','/user.default.jpg','','','','s504','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1082,'s505','667788','/user.default.jpg','','','','s505','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1083,'s506','667788','/user.default.jpg','','','','s506','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1084,'s509','667788','/user.default.jpg','','','','s509','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1085,'s510','667788','/user.default.jpg','','','','s510','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1086,'s511','667788','/user.default.jpg','','','','s511','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1087,'s512','667788','/user.default.jpg','','','','s512','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1088,'s513','667788','/user.default.jpg','','','','s513','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1089,'s514','667788','/user.default.jpg','','','','s514','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1090,'s515','667788','/user.default.jpg','','','','s515','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1091,'s516','667788','/user.default.jpg','','','','s516','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1092,'s517','667788','/user.default.jpg','','','','s517','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1093,'s518','667788','/user.default.jpg','','','','s518','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1094,'s519','667788','/user.default.jpg','','','','s519','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1095,'s520','667788','/user.default.jpg','','','','s520','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1096,'s523','667788','/user.default.jpg','','','','s523','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1097,'s524','667788','/user.default.jpg','','','','s524','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1098,'s525','667788','/user.default.jpg','','','','s525','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1099,'s526','667788','/user.default.jpg','','','','s526','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1100,'s527','667788','/user.default.jpg','','','','s527','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1101,'s530','667788','/user.default.jpg','','','','s530','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1102,'s531','667788','/user.default.jpg','','','','s531','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1103,'s532','667788','/user.default.jpg','','','','s532','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1104,'s534','667788','/user.default.jpg','','','','s534','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1105,'s536','667788','/user.default.jpg','','','','s536','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1106,'s610','667788','/user.default.jpg','','','','s610','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1107,'office2','667788','/user.default.jpg','','','','office2','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1108,'office3','667788','/user.default.jpg','','','','office3','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1109,'office5','667788','/user.default.jpg','','','','office5','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1110,'office8','667788','/user.default.jpg','','','','office8','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1111,'office10','667788','/user.default.jpg','','','','office10','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1113,'office12','667788','/user.default.jpg','','','','office12','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1114,'office14','667788','/user.default.jpg','','','','office14','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1115,'office15','667788','/user.default.jpg','','','','office15','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1116,'office18','667788','/user.default.jpg','','','','office18','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1117,'office19','667788','/user.default.jpg','','','','office19','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1118,'office20','667788','/user.default.jpg','','','','office20','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1119,'office22','667788','/user.default.jpg','','','','office22','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1120,'office30','667788','/user.default.jpg','','','','office30','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1121,'s609','667788','/user.default.jpg','','','','s609','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1122,'office27','667788','/user.default.jpg','','','','office27','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1123,'office29','667788','/user.default.jpg','','','','office29','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1124,'office31','667788','/user.default.jpg','','','','office31','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1125,'s562','667788','/user.default.jpg','','','','s562','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1126,'s547','667788','/user.default.jpg','','','','s547','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1127,'s543','667788','/user.default.jpg','','','','s543','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1128,'s544','667788','/user.default.jpg','','','','s544','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1129,'s584','667788','/user.default.jpg','','','','s584','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1130,'s559','667788','/user.default.jpg','','','','s559','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1131,'s552','667788','/user.default.jpg','','','','s552','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1132,'s556','667788','/user.default.jpg','','','','s556','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1133,'s565','667788','/user.default.jpg','','','','s565','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1134,'s571','667788','/user.default.jpg','','','','s571','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1135,'s619','667788','/user.default.jpg','','','','s619','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1136,'s542','667788','/user.default.jpg','','','','s542','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1137,'s561','667788','/user.default.jpg','','','','s561','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1138,'s567','667788','/user.default.jpg','','','','s567','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1139,'s575','667788','/user.default.jpg','','','','s575','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1140,'s607','667788','/user.default.jpg','','','','s607','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1141,'s374','667788','/user.default.jpg','','','','s374','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1142,'s612','667788','/user.default.jpg','','','','s612','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1143,'s597','667788','/user.default.jpg','','','','s597','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1144,'s553','667788','/user.default.jpg','','','','s553','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1145,'s603','667788','/user.default.jpg','','','','s603','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1146,'s540','667788','/user.default.jpg','','','','s540','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1147,'s569','667788','/user.default.jpg','','','','s569','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1148,'s545','667788','/user.default.jpg','','','','s545','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1149,'s605','667788','/user.default.jpg','','','','s605','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1150,'s618','667788','/user.default.jpg','','','','s618','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1151,'s551','667788','/user.default.jpg','','','','s551','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1152,'s602','667788','/user.default.jpg','','','','s602','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1153,'s564','667788','/user.default.jpg','','','','s564','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1154,'s599','667788','/user.default.jpg','','','','s599','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1155,'s583','667788','/user.default.jpg','','','','s583','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1156,'s601','667788','/user.default.jpg','','','','s601','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1157,'s578','667788','/user.default.jpg','','','','s578','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1158,'s570','667788','/user.default.jpg','','','','s570','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1159,'s592','667788','/user.default.jpg','','','','s592','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1160,'s558','667788','/user.default.jpg','','','','s558','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1161,'s611','667788','/user.default.jpg','','','','s611','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1162,'s546','667788','/user.default.jpg','','','','s546','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1163,'s483','667788','/user.default.jpg','','','','s483','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1164,'s548','667788','/user.default.jpg','','','','s548','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1165,'s585','667788','/user.default.jpg','','','','s585','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1166,'s579','667788','/user.default.jpg','','','','s579','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1167,'s621','667788','/user.default.jpg','','','','s621','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1168,'s549','667788','/user.default.jpg','','','','s549','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1169,'s620','667788','/user.default.jpg','','','','s620','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1170,'s577','667788','/user.default.jpg','','','','s577','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1172,'s587','667788','/user.default.jpg','','','','s587','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1173,'s574','667788','/user.default.jpg','','','','s574','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1174,'s600','667788','/user.default.jpg','','','','s600','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1175,'s606','667788','/user.default.jpg','','','','s606','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1176,'s604','667788','/user.default.jpg','','','','s604','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1177,'s557','667788','/user.default.jpg','','','','s557','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1178,'s541','667788','/user.default.jpg','','','','s541','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1179,'s588','667788','/user.default.jpg','','','','s588','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1180,'s589','667788','/user.default.jpg','','','','s589','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1181,'s596','667788','/user.default.jpg','','','','s596','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1182,'s555','667788','/user.default.jpg','','','','s555','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1183,'s507','667788','/user.default.jpg','','','','s507','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1184,'s554','667788','/user.default.jpg','','','','s554','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1185,'s573','667788','/user.default.jpg','','','','s573','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1186,'s576','667788','/user.default.jpg','','','','s576','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1187,'s580','667788','/user.default.jpg','','','','s580','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1188,'s581','667788','/user.default.jpg','','','','s581','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1189,'s586','667788','/user.default.jpg','','','','s586','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1190,'s593','667788','/user.default.jpg','','','','s593','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1191,'s598','667788','/user.default.jpg','','','','s598','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1192,'s614','667788','/user.default.jpg','','','','s614','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1193,'s615','667788','/user.default.jpg','','','','s615','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1194,'s35','667788','/user.default.jpg','','','','s35','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1195,'s613','667788','/user.default.jpg','','','','s613','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1196,'s84','667788','/user.default.jpg','','','','s84','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1197,'s80','667788','/user.default.jpg','','','','s80','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1199,'s441','667788','/user.default.jpg','','','','s441','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1201,'s335','667788','/user.default.jpg','','','','s335','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1202,'s459','667788','/user.default.jpg','','','','s459','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1203,'s590','667788','/user.default.jpg','','','','s590','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1204,'s452','667788','/user.default.jpg','','','','s452','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1205,'s437a','667788','/user.default.jpg','','','','s437a','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1206,'s100','667788','/user.default.jpg','','','','s100','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1207,'s138','667788','/user.default.jpg','','','','s138','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1208,'office1','667788','/user.default.jpg','','','','office1','','','','','','8801911908800','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
(1211,'s62','667788','/user.default.jpg','s62','667788','','s62','','','','','','','','','Personal',0.00,'PPPoE',1,'Active',2,'2026-03-22 17:11:54',NULL),
(1212,'s303','667788','/user.default.jpg','s303','667788','','s303','','','','','','','','','Personal',0.00,'Hotspot',1,'Active',2,'2026-03-22 17:13:51',NULL),
(1213,'s135','667788','/user.default.jpg','s135','667788','','Omit hasan','Posim Bazar bridge pase','','','','','8801916357209','','','Personal',0.00,'PPPoE',1,'Active',1,'2026-03-24 15:45:12',NULL),
(1214,'arian@01709541829','667788','/user.default.jpg','arian@01709541829','667788','','Arian','Porisod road forhad bare','','','','','8801709541829','','','Personal',0.00,'PPPoE',1,'Active',1,'2026-03-26 07:42:50',NULL),
(1215,'omit@0191635720','66778','/user.default.jpg','omit@01916357209','667788','','Omit','Posim Bazar bridge pase','','','','','8801916357209','','','Personal',0.00,'PPPoE',1,'Active',1,'2026-03-27 13:54:49',NULL),
(1216,'salam@01706589569','338654','/user.default.jpg','salam@01706589569','667788','','salam','Montipara sobuj so room pase','',NULL,NULL,NULL,'8801706589569','','','Personal',0.00,'PPPoE',1,'Active',1,'2026-03-28 13:32:18',NULL),
(1217,'amir@01313496950','667788','/user.default.jpg','amir@01313496950','667788','','Amir','Bare same samsul hazi bare','',NULL,NULL,NULL,'8801313496950','','','Personal',0.00,'PPPoE',1,'Active',1,'2026-03-29 05:17:36',NULL),
(1218,'saikot@01915606414','667788','/user.default.jpg','saikot@01915606414','667788','','Saikot','','','','','','8801915606414','','','Personal',0.00,'PPPoE',1,'Active',1,'2026-03-29 09:24:28',NULL),
(1219,'sogram@01403968344','667788','/user.default.jpg','sogram@01403968344','667788','','sogram','Porisod road somrat box','',NULL,NULL,NULL,'8801403968344','','','Personal',0.00,'PPPoE',1,'Active',1,'2026-03-29 13:54:18',NULL),
(1220,'mokta@01402507488','667788','/user.default.jpg','mokta@01402507488','667788','','mokta','Posim Bazar rell pase','','','','','8801402507488','','','Personal',0.00,'PPPoE',1,'Active',1,'2026-03-29 14:30:16',NULL),
(1221,'nahid@01712154553','667788','/user.default.jpg','nahid@01712154553','667788','','Nahid chowdury','chowdury para','','','','','8801712154553','','','Personal',0.00,'PPPoE',1,'Active',1,'2026-03-30 04:08:28',NULL),
(1222,'gamaus@01701661619','667788','/user.default.jpg','gamaus@01701661619','667788','','Gamaus Office','posim Bazar angeo','','','','','8801701661619','','','Personal',0.00,'PPPoE',1,'Active',1,'2026-03-30 04:11:18',NULL),
(1223,'sanrise@01754146379','667788','/user.default.jpg','sanrise@01754146379','667788','','sanrise','chainige factory,desipara road','','','','','8801754146379','','','Personal',0.00,'PPPoE',1,'Active',1,'2026-03-30 05:49:22',NULL),
(1224,'sanrise2@01754146379','667788','/user.default.jpg','sanrise2@01754146379','667788','','sanrise2','chainige factory,desipara road','','','','','8801754146379','','','Personal',0.00,'PPPoE',1,'Active',1,'2026-03-30 06:03:51',NULL),
(1225,'gp@01746439345','667788','/user.default.jpg','gp@01746439345','667788','','gp','IMAM BHABON 5th floor','','','','','8801746439345','','','Personal',0.00,'PPPoE',1,'Active',1,'2026-03-30 06:13:06',NULL),
(1226,'hannan@01754146379','667788','/user.default.jpg','hannan@01754146379','667788','','Hannan','posim Bazar, kamarpotti','','','','','8801754146379','','','Personal',0.00,'PPPoE',1,'Active',1,'2026-03-30 06:14:31',NULL),
(1227,'jannat@01343504263','667788','/user.default.jpg','jannat@01343504263','667788','','jannat','actual garments pase','','','','','8801343504263','','','Personal',0.00,'PPPoE',1,'Active',1,'2026-03-30 11:22:08',NULL),
(1228,'jalal@01822501671','667788','/user.default.jpg','jalal@01822501671','667788','','Jalal','posim Bazar rell  bridge pase','','','','','8801822501671','','','Personal',0.00,'PPPoE',1,'Active',1,'2026-03-31 04:51:18',NULL),
(1229,'sujon@01406572876','667788','/user.default.jpg','sujon@01406572876','667788','','Sujon','Dostola tower same','','','','','8801406572876','','','Personal',0.00,'PPPoE',1,'Active',1,'2026-03-31 06:42:27',NULL),
(1230,'ebrahim@01868451762','667788','/user.default.jpg','ebrahim@01868451762','667788','','ebrahim','Janjaja road tetol gastol tola shop','','','','','8801868451762','','','Personal',0.00,'PPPoE',1,'Active',1,'2026-03-31 07:18:55',NULL),
(1231,'sayem@01923751394','667788','/user.default.jpg','sayem@01923751394','667788','','sayem','Porisod road Farjana pase','','','','','8801923751394','','','Personal',0.00,'PPPoE',1,'Active',1,'2026-03-31 09:39:57',NULL),
(1232,'maksu@01904745509','667788','/user.default.jpg','maksu@01904745509','667788','','maksu','','','','','','8801904745509','','','Personal',0.00,'PPPoE',1,'Active',1,'2026-03-31 09:40:48',NULL),
(1233,'safat@01742252677','667788','/user.default.jpg','safat@01742252677','667788','','safat','bare samne 4-5 tola','','','','','8801742252677','','','Personal',0.00,'PPPoE',1,'Active',1,'2026-03-31 12:59:54',NULL),
(1234,'mona@01684310647','667788','/user.default.jpg','mona@01684310647','667788','','Mona','chowdury para mosa bare','','','','','8801684310647','','','Personal',0.00,'PPPoE',1,'Active',1,'2026-03-31 14:41:43',NULL),
(1235,'shihab@01307786743','667788','/user.default.jpg','shihab@01307786743','667788','','shihab','janjaja road mosa bare','','','','','8801307786743','','','Personal',0.00,'PPPoE',1,'Active',1,'2026-03-31 14:51:01',NULL),
(1236,'zim@01911644580','667788','/user.default.jpg','zim@01911644580','667788','','shohidul  unik zim','Iman tower 4 th floor','','','','','8801911644580','','','Personal',0.00,'PPPoE',1,'Active',1,'2026-03-31 15:02:40',NULL),
(1237,'sumon@01925442162','667788','/user.default.jpg','sumon@01925442162','667788','','Sumon','chowdury Para','','','','','8801925442162','','','Personal',0.00,'PPPoE',1,'Active',1,'2026-03-31 16:35:28',NULL),
(1238,'toffajol@01613561077','667788','/user.default.jpg','toffajol@01613561077','667788','','Toffajol','','','','','','8801613561077','','','Personal',0.00,'PPPoE',1,'Active',1,'2026-03-31 16:36:51',NULL),
(1239,'kajol@01916126486','667788','/user.default.jpg','kajol@01916126486','667788','','Kajol','chainige factory pase','','','','','kajol@01916126486','','','Personal',0.00,'PPPoE',1,'Active',1,'2026-03-31 17:00:21',NULL),
(1240,'tashfe@01331104238','667788','/user.default.jpg','tashfe@01331104238','667788','','Tasken','Bare Piche','','','','','8801331104238','','','Personal',0.00,'PPPoE',1,'Active',1,'2026-03-31 17:03:34',NULL),
(1241,'shazahan@01941928232','667788','/user.default.jpg','shazahan@01941928232','667788','','shazahan','office pase','','','','','8801941-928232','','','Personal',0.00,'PPPoE',1,'Active',1,'2026-04-01 05:57:19',NULL),
(1242,'amanullah@01402794705','667788','/user.default.jpg','amanullah@01402794705','667788','','Amanullah','','','','','','8801402794705','','','Personal',0.00,'PPPoE',1,'Active',1,'2026-04-01 06:58:04',NULL),
(1243,'alif@01400989371','667788','/user.default.jpg','alif@01400989371','667788','','Alif','','','','','','8801400989371','','','Personal',0.00,'PPPoE',1,'Active',1,'2026-04-01 06:59:54',NULL),
(1244,'sajid@01910775366','667788','/user.default.jpg','sajid@01910775366','667788','','Sajid','','','','','','8801910775366','','','Personal',0.00,'PPPoE',1,'Active',1,'2026-04-01 07:22:19',NULL),
(1245,'rohim@01935430703','667788','/user.default.jpg','rohim@01935430703','667788','','Rohim','polastak sakhwat box','','','','','8801935430703','','','Personal',0.00,'PPPoE',1,'Active',1,'2026-04-01 08:09:07',NULL),
(1246,'city@01923006824','667788','/user.default.jpg','city@01923006824','667788','','City corporation','','','','','','8801923006824','','','Personal',0.00,'PPPoE',1,'Active',1,'2026-04-01 09:14:25',NULL),
(1247,'city2@01923006824','667788','/user.default.jpg','city2@01923006824','667788','','city2','City Corporation  majijtrat','','','','','8801923006824','','','Personal',0.00,'PPPoE',1,'Active',1,'2026-04-01 09:48:53',NULL),
(1248,'city3@01923006824','667788','/user.default.jpg','city3@01923006824','667788','','city3','City Corporation (inginiar )','','','','','8801923006824','','','Personal',0.00,'PPPoE',1,'Active',1,'2026-04-01 09:50:03',NULL),
(1249,'ajahar@01938012062','667788','/user.default.jpg','ajahar@01938012062','667788','','Ajahar','','','','','','8801938012062','','','Personal',0.00,'PPPoE',1,'Active',1,'2026-04-01 15:38:44','2026-04-02 12:31:36'),
(1250,'subahan@01777694229','667788','/user.default.jpg','subahan@01777694229','667788','','Subahan','','','','','','8801777694229','','','Personal',0.00,'PPPoE',1,'Active',1,'2026-04-01 15:40:34',NULL),
(1251,'sohelrana@01964688616','667788','/user.default.jpg','sohelrana@01964688616','667788','','Sohel Rana','','','','','','8801964688616','','','Personal',0.00,'PPPoE',1,'Active',1,'2026-04-01 15:42:28',NULL),
(1252,'rased@01605201112','667788','/user.default.jpg','rased@01605201112','667788','','Rased','','','','','','8801605201112','','','Personal',0.00,'PPPoE',1,'Active',1,'2026-04-01 15:43:53',NULL),
(1253,'aref@01930572254','667788','/user.default.jpg','aref@01930572254','667788','','Aref','Nogor sastho kendro','','','','','8801930572254','','','Personal',0.00,'PPPoE',1,'Active',1,'2026-04-01 18:29:24',NULL),
(1254,'mostafijur@01866949375','667788','/user.default.jpg','mostafijur@01866949375','667788','','Mostafijur','desipara asrafil basa','','','','','8801866949375','','','Personal',0.00,'PPPoE',1,'Active',1,'2026-04-01 18:31:24',NULL),
(1255,'naim@01863626305','667788','/user.default.jpg','naim@01863626305','667788','','Naim','amjat box','','','','','8801863626305','','','Personal',0.00,'PPPoE',1,'Active',1,'2026-04-01 18:32:26',NULL),
(1256,'anjeo@01700775435','667788','/user.default.jpg','anjeo@01700775435','667788','','Anjeo','Market Piche','','','','','8801700775435','','','Personal',0.00,'PPPoE',1,'Active',1,'2026-04-02 06:02:59',NULL),
(1257,'aminul@01908986887','667788','/user.default.jpg','aminul@01908986887','667788','','Aminul','chowdury para','','','','','8801908986887','','','Personal',0.00,'PPPoE',1,'Active',1,'2026-04-02 07:21:00',NULL),
(1258,'roton@01938320825','667788','/user.default.jpg','roton@01938320825','667788','','Roton','','','','','','8801938320825','','','Personal',0.00,'PPPoE',1,'Active',1,'2026-04-02 08:25:49',NULL),
(1259,'ajaharul@01938012062','667788','/user.default.jpg','ajaharul@01938012062','667788','','Azahar','','','','','','8801938012062','','','Personal',0.00,'PPPoE',1,'Active',1,'2026-04-02 08:32:19',NULL),
(1260,'saju@01762204089','667788','/user.default.jpg','saju@01762204089','667788','','Saju','','','','','','8801762204089','','','Personal',0.00,'PPPoE',1,'Active',1,'2026-04-02 11:48:51',NULL),
(1261,'monir@01777421000','667788','/user.default.jpg','monir@01777421000','667788','','Monir','','','','','','8801777421000','','','Personal',0.00,'PPPoE',1,'Active',1,'2026-04-02 12:53:24',NULL),
(1262,'mahamud@01778880568','667788','/user.default.jpg','mahamud@01778880568','667788','','Mahamud','','','','','','8801778880568','','','Personal',0.00,'PPPoE',1,'Active',1,'2026-04-02 12:55:04',NULL),
(1263,'istiya@01989071851','667788','/user.default.jpg','istiya@01989071851','667788','','Istiya','Porishod road','','','','','8801989071851','','','Personal',0.00,'PPPoE',1,'Active',1,'2026-04-02 15:26:57',NULL),
(1264,'fardul@01845218275','667788','/user.default.jpg','fardul@01845218275','667788','','Fardul','','','','','','8801845218275','','','Personal',0.00,'PPPoE',1,'Active',1,'2026-04-02 15:28:57',NULL),
(1265,'khadi@01605588462','667788','/user.default.jpg','khadi@01605588462','667788','','Khadi','','','','','','8801605588462','','','Personal',0.00,'PPPoE',1,'Active',1,'2026-04-02 15:30:59',NULL),
(1266,'foridul@01922272182','667788','/user.default.jpg','foridul@01922272182','667788','','Faridul','','','','','','8801922272182','','','Personal',0.00,'PPPoE',1,'Active',1,'2026-04-02 15:33:15',NULL),
(1267,'halim@01908806561','667788','/user.default.jpg','halim@01908806561','667788','','Halim','','','','','','8801908806561','','','Personal',0.00,'PPPoE',1,'Active',1,'2026-04-02 15:40:48',NULL),
(1268,'jaman@01923181402','667788','/user.default.jpg','jaman@01923181402','667788','','Jaman','','','','','','8801923181402','','','Personal',0.00,'PPPoE',1,'Active',1,'2026-04-03 05:51:15',NULL),
(1269,'sami@01712753012','667788','/user.default.jpg','sami@01712753012','667788','','Sami','','','','','','8801712753012','','','Personal',0.00,'PPPoE',1,'Active',1,'2026-04-03 05:52:13',NULL),
(1270,'shahad','667788','/user.default.jpg','shahad','667788','','MD.Shahadur Rahman','Salna bare','','','','','881911908800','','','Personal',0.00,'PPPoE',1,'Active',2,'2026-04-03 06:39:13',NULL),
(1271,'rasel','667788','/user.default.jpg','rasel','667788','','rasel','Farjana basa Porisod road','','','','','881700931925','','','Personal',0.00,'PPPoE',1,'Active',2,'2026-04-03 13:37:28',NULL),
(1272,'omor@01933805356','667788','/user.default.jpg','omor@01933805356','667788','','omor faruk','Desipara','','','','','881933805356','','','Personal',0.00,'PPPoE',1,'Active',2,'2026-04-03 13:58:17',NULL),
(1273,'azahar@01822106708','667788','/user.default.jpg','azahar@01822106708','667788','','azhar','Posim Bazar kolar arod','','','','','881822106708','','','Personal',0.00,'PPPoE',1,'Active',2,'2026-04-03 14:56:15',NULL),
(1274,'morseda@01743158805','667788','/user.default.jpg','morseda@01743158805','667788','','morseda','Posim Bazar madrasa piche','','','','','881743158805','','','Personal',0.00,'PPPoE',1,'Active',2,'2026-04-03 15:02:38',NULL),
(1275,'shahan@01734240129','667788','/user.default.jpg','shahan@01734240129','667788','','shahan','Chowdury para rahadulla bare','','','','','881734240129','','','Personal',0.00,'PPPoE',1,'Active',2,'2026-04-03 15:12:24',NULL),
(1276,'kalam@01727596671','667788','/user.default.jpg','kalam@01727596671','667788','','kalam','polastak mosjid pase','','','','','881727596671','','','Personal',0.00,'PPPoE',1,'Active',2,'2026-04-03 16:38:30',NULL),
(1277,'somon@01988641269','667788','/user.default.jpg','somon@01988641269','667788','','Somon','Poran Bazar bridge pase','','','','','881988641269','','','Personal',0.00,'PPPoE',1,'Active',2,'2026-04-03 16:59:17',NULL),
(1278,'manik@01996202594','667788','/user.default.jpg','manik@01996202594','667788','','manik','Dostola waser pase','','','','','881996202594','','','Personal',0.00,'PPPoE',1,'Active',2,'2026-04-04 13:21:57',NULL),
(1279,'shakibul@01908322525','667788','/user.default.jpg','shakibul@01908322525','667788','','shakibul','Kofo member bare pase','','','','','881908322525','','','Personal',0.00,'PPPoE',1,'Active',2,'2026-04-04 14:51:36',NULL),
(1280,'rafi@01745962511','667788','/user.default.jpg','rafi@01745962511','667788','','rafi','Porisod road kiron vila ,onu fiber','','','','','881745962511','','','Personal',0.00,'PPPoE',1,'Active',2,'2026-04-04 16:07:04',NULL),
(1281,'babu@01979676411','667788','/user.default.jpg','babu@01979676411','667788','','babu','Porisod road monir bari ,onu fiber','','','','','881979676411','','','Personal',0.00,'PPPoE',1,'Active',2,'2026-04-04 16:43:51',NULL),
(1282,'forhad@01962009387','667788','/user.default.jpg','forhad@01962009387','667788','','forhad','Bare piche','','','','','881962009387','','','Personal',0.00,'PPPoE',1,'Active',2,'2026-04-04 16:56:32',NULL),
(1283,'mosarof','667788','/user.default.jpg','mosarof','667788','','mosarof office','Office','','','','','881920779792','','','Personal',0.00,'PPPoE',1,'Active',2,'2026-04-04 18:15:12',NULL),
(1284,'01711084193','586229','/user.default.jpg','01711084193','01711084193','','Milon Mondol','Gazipur\r\nShimultali, Joydebpur','','','','','8801711084193','ecmilon@gmail.com','','Personal',0.00,'Hotspot',1,'Active',1,'2026-04-04 18:58:14',NULL),
(1285,'raju@01964553482','667788','/user.default.jpg','raju@01964553482','667788','','raju','Market Piche only fiber','','','','','881964553482','','','Personal',0.00,'PPPoE',1,'Active',2,'2026-04-05 07:29:16',NULL),
(1286,'ontos@01927954635','667788','/user.default.jpg','ontos@01927954635','667788','','ontos','Janjaja road hanif farmacy box','','','','','881927954635','','','Personal',0.00,'PPPoE',1,'Active',2,'2026-04-05 08:17:31',NULL),
(1287,'gias@01713536437','667788','/user.default.jpg','gias@01713536437','667788','','gias','Simultoli road onu fiber','','','','','881713536437','','','Personal',0.00,'PPPoE',1,'Active',2,'2026-04-05 08:40:37',NULL),
(1288,'rakib@01884545433','667788','/user.default.jpg','rakib@01884545433','667788','','rakib','Porisod road Ali hosen bare','','','','','881884545433','','','Personal',0.00,'PPPoE',1,'Active',2,'2026-04-05 08:52:46',NULL),
(1289,'rofiqul@01938319366','667788','/user.default.jpg','rofiqul@01938319366','667788','','Rofiqul','Barir pica','','','','','8801938319366','','','Personal',0.00,'PPPoE',1,'Active',1,'2026-04-05 13:11:49',NULL),
(1290,'mafuj@01731017096','667788','/user.default.jpg','mafuj@01731017096','667788','','mafuj','Bare 2 tola','','','','','881731017096','','','Personal',0.00,'PPPoE',1,'Active',2,'2026-04-05 13:53:02',NULL),
(1291,'shaurov@01981504856','667788','/user.default.jpg','shaurov@01981504856','667788','','Saidul Islam shaurov','Minister Bari Road','','','','','8801981504856','','','Personal',0.00,'PPPoE',1,'Active',1,'2026-04-05 14:50:05',NULL),
(1292,'sohag@01914135791','667788','/user.default.jpg','sohag@01914135791','667788','','Sohag','Salna Puran Bazar','','','','','8801914135791','','','Personal',0.00,'PPPoE',1,'Active',1,'2026-04-05 15:01:24',NULL),
(1293,'bokkor@01619461811','667788','/user.default.jpg','bokkor@01619461811','667788','','Abu bokkor','','','','','','881619461811','','','Personal',0.00,'PPPoE',1,'Active',2,'2026-04-05 15:59:40',NULL),
(1294,'riknit@01920995062','667788','/user.default.jpg','riknit@01920995062','667788','','rofi factory poran bazar','Poran bazar','','','','','881920995062','','','Personal',0.00,'PPPoE',1,'Active',2,'2026-04-06 06:40:20',NULL),
(1295,'shahin@01968841153','667788','/user.default.jpg','shahin@01968841153','667788','','shahin','Janjaja road amjat box','','','','','881968841153','','','Personal',0.00,'PPPoE',1,'Active',2,'2026-04-06 06:42:42',NULL),
(1296,'insurance@01716956699','667788','/user.default.jpg','insurance@01716956699','667788','','prime insurance','Salna bus stand','','','','','881716956699','','','Personal',0.00,'PPPoE',1,'Active',2,'2026-04-06 07:08:42',NULL),
(1297,'rana@01988728032','667788','/user.default.jpg','rana@01988728032','667788','','rana','New chowrasta hasem master bate onu fiber','','','','','881988728032','','','Personal',0.00,'PPPoE',1,'Active',2,'2026-04-06 08:30:22',NULL),
(1298,'shahin@01736762103','667788','/user.default.jpg','shahin@01736762103','667788','','shahin','Posim Bazar sequel pase','','','','','881736762103','','','Personal',0.00,'PPPoE',1,'Active',2,'2026-04-06 11:48:49',NULL),
(1299,'flaxiload@01912208878','667788','/user.default.jpg','flaxiload@01912208878','667788','','balal','Poran bazar','','','','','881912208878','','','Personal',0.00,'PPPoE',1,'Active',2,'2026-04-06 13:24:39',NULL),
(1300,'ansir@01911121210','667788','/user.default.jpg','ansir@01911121210','667788','','anser','Montipara sahida vila','','','','','881911121210','','','Personal',0.00,'PPPoE',1,'Active',2,'2026-04-06 13:54:30',NULL),
(1302,'sabbir@01718773949','667788','/user.default.jpg','sabbir@01718773949','667788','','sabbir','Montipara yeakub kaka basa','','','','','881718773949','','','Personal',0.00,'PPPoE',1,'Active',2,'2026-04-06 15:13:04',NULL),
(1303,'sujoy@01751512439','667788','/user.default.jpg','sujoy@01751512439','667788','','sujoy','Janjaja road hanif farmacy box','','','','','881751512439','','','Personal',0.00,'PPPoE',1,'Active',2,'2026-04-07 06:32:18',NULL),
(1304,'rayhan@01998628952','667788','/user.default.jpg','rayhan@01998628952','667788','','rayhan','Janjaja road kapasia bare onu fiber','','','','','881998628952','','','Personal',0.00,'PPPoE',1,'Active',2,'2026-04-07 07:30:53',NULL),
(1305,'mostafiz@01706589569','667788','/user.default.jpg','mostafiz@01706589569','667788','','mostafiz','Montipara onu fiber','','','','','881706589569','','','Personal',0.00,'PPPoE',1,'Active',2,'2026-04-07 08:12:11',NULL),
(1306,'aref@01735511111','667788','/user.default.jpg','aref@01735511111','667788','','aref','New chowrasta Dokan onu fiber','','','','','881735511111','','','Personal',0.00,'PPPoE',1,'Active',2,'2026-04-07 12:50:32',NULL),
(1307,'delowar@01783636616','667788','/user.default.jpg','delowar@01783636616','667788','','delowar','Forest office rakib Vai box','','','','','881783636616','','','Personal',0.00,'PPPoE',1,'Active',2,'2026-04-07 13:26:18',NULL),
(1308,'joyel@01797307872','667788','/user.default.jpg','joyel@01797307872','667788','','joyel','Forest office road rakib Vai box','','','','','881797307872','','','Personal',0.00,'PPPoE',1,'Active',2,'2026-04-07 20:40:36',NULL),
(1309,'ibrahim@01959663908','667788','/user.default.jpg','ibrahim@01959663908','667788','','ibrahim','Mowatola popular cosmetic onu fiber','','','','','881959663908','','','Personal',0.00,'PPPoE',1,'Active',2,'2026-04-08 05:58:49',NULL),
(1310,'masud@01845759852','667788','/user.default.jpg','masud@01845759852','667788','','masud','Posim Bazar sequel fahim basay','','','','','881845759852','','','Personal',0.00,'PPPoE',1,'Active',2,'2026-04-08 06:34:18',NULL),
(1311,'amarot@01753659302','667788','/user.default.jpg','amarot@01753659302','667788','','amarot','Porisod road Ali hosen pase','','','','','881753659302','','','Personal',0.00,'PPPoE',1,'Active',2,'2026-04-08 07:37:19',NULL),
(1312,'yeasin@01923441444','667788','/user.default.jpg','yeasin@01923441444','667788','','yeasin','Porisod road','','','','','881923441444','','','Personal',0.00,'PPPoE',1,'Active',2,'2026-04-08 07:55:08',NULL),
(1313,'jakiya@01980510418','667788','/user.default.jpg','jakiya@01980510418','667788','','jakiya','Porisod road awal zaji bare','','','','','881980510418','','','Personal',0.00,'PPPoE',1,'Active',2,'2026-04-08 08:07:57',NULL),
(1314,'noyon@01963021891','667788','/user.default.jpg','noyon@01963021891','667788','','noyon','Janjaja mosjid pase','','','','','881963021891','','','Personal',0.00,'PPPoE',1,'Active',2,'2026-04-08 12:58:29',NULL),
(1315,'imran@01773721112','667788','/user.default.jpg','imran01773721112','667788','','imran','Janjaja mosjid pase','','','','','881773721112','','','Personal',0.00,'PPPoE',1,'Active',2,'2026-04-08 13:12:39',NULL),
(1316,'somon@01932230511','6667788','/user.default.jpg','somon@01932230511','667788','','somon','Janjaja mosjid pase onu fiber','','','','','881932230511','','','Personal',0.00,'PPPoE',1,'Active',2,'2026-04-08 13:27:45',NULL),
(1317,'alamin@01404571513','667788','/user.default.jpg','alamin@01404571513','667788','','alamin','Harun polas bare','','','','','881404571513','','','Personal',0.00,'PPPoE',1,'Active',2,'2026-04-08 14:18:23',NULL),
(1318,'israt@01941832957','667788','/user.default.jpg','israt@01941832957','667788','','israt','Desipara road Jala bari onu fiber','','','','','881941832957','','','Personal',0.00,'PPPoE',1,'Active',2,'2026-04-08 14:34:08',NULL),
(1319,'janmia@01738668933','667788','/user.default.jpg','janmia@01738668933','667788','','janmia','Desipara Jala bari onu fiber','','','','','881738668933','','','Personal',0.00,'PPPoE',1,'Active',2,'2026-04-08 14:45:24',NULL),
(1320,'firoj@01892365222','667788','/user.default.jpg','firoj@01892365222','667788','','firoj','Desipara Jala bare fiber onu','','','','','881892365222','','','Personal',0.00,'PPPoE',1,'Active',2,'2026-04-08 14:50:06',NULL),
(1321,'rakib@01873345718','667788','/user.default.jpg','rakib@01873345718','667788','','amanulla','Polastak','','','','','881873345718','','','Personal',0.00,'PPPoE',1,'Active',2,'2026-04-08 15:02:18',NULL),
(1322,'saddam@01404532100','667788','/user.default.jpg','saddam@01404532100','667788','','saddam','Porisod road Ali hosen box','','','','','881404532100','','','Personal',0.00,'PPPoE',1,'Active',2,'2026-04-08 15:58:51',NULL),
(1323,'rayan@01302942761','667788','/user.default.jpg','rayan@01302942761','667788','','rayan','Posim Bazar kolar arod fiber onu','','','','','881302942761','','','Personal',0.00,'PPPoE',1,'Active',2,'2026-04-08 16:58:25',NULL);
/*!40000 ALTER TABLE `tbl_customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_customers_fields`
--

DROP TABLE IF EXISTS `tbl_customers_fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_customers_fields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) NOT NULL,
  `field_name` varchar(255) NOT NULL,
  `field_value` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `customer_id` (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_customers_fields`
--

LOCK TABLES `tbl_customers_fields` WRITE;
/*!40000 ALTER TABLE `tbl_customers_fields` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_customers_fields` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_customers_inbox`
--

DROP TABLE IF EXISTS `tbl_customers_inbox`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_customers_inbox` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `date_read` datetime DEFAULT NULL,
  `subject` varchar(64) NOT NULL,
  `body` text DEFAULT NULL,
  `from` varchar(8) NOT NULL DEFAULT 'System' COMMENT 'System or Admin or Else',
  `admin_id` int(11) NOT NULL DEFAULT 0 COMMENT 'other than admin is 0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_customers_inbox`
--

LOCK TABLES `tbl_customers_inbox` WRITE;
/*!40000 ALTER TABLE `tbl_customers_inbox` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_customers_inbox` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_logs`
--

DROP TABLE IF EXISTS `tbl_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` datetime DEFAULT NULL,
  `type` varchar(50) NOT NULL,
  `description` mediumtext NOT NULL,
  `userid` int(11) NOT NULL,
  `ip` mediumtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1043 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_logs`
--

LOCK TABLES `tbl_logs` WRITE;
/*!40000 ALTER TABLE `tbl_logs` DISABLE KEYS */;
INSERT INTO `tbl_logs` VALUES
(74,'2026-03-23 02:25:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(75,'2026-03-23 02:26:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(76,'2026-03-23 02:27:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(77,'2026-03-23 02:28:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(78,'2026-03-23 13:26:50','SuperAdmin','[admin]: Recharge office1 [10Mbps][BDT. 1,000]',1,'103.115.242.93'),
(79,'2026-03-23 13:28:53','User','Admin admin Deactivate 10Mbps for office1',1208,'103.115.242.92'),
(80,'2026-03-23 13:29:04','User','Admin admin Activated 10Mbps for office1',1208,'103.115.242.92'),
(81,'2026-03-23 16:33:24','SuperAdmin','admin Login Successful',1,'37.111.200.194'),
(82,'2026-03-23 16:58:19','SuperAdmin','[admin]: Recharge office10 [5Mbps][BDT. 500]',1,'103.115.242.92'),
(83,'2026-03-23 17:05:10','User','Admin admin Deactivate 10Mbps for office1',1208,'103.115.242.93'),
(84,'2026-03-23 17:25:12','User','Admin admin Activated 10Mbps for office1',1208,'103.115.242.93'),
(85,'2026-03-23 17:38:16','User','Admin admin Deactivate 10Mbps for office1',1208,'103.115.242.93'),
(86,'2026-03-23 17:38:20','User','Admin admin Activated 10Mbps for office1',1208,'103.115.242.93'),
(87,'2026-03-23 21:22:28','Admin','[shahad]: Recharge office10 [5Mbps][BDT. 500]',2,'103.109.96.170'),
(88,'2026-03-23 22:40:26','SuperAdmin','[admin]: Settings Saved Successfully',0,'103.115.242.93'),
(89,'2026-03-23 22:41:02','','Initiating Daily backup',0,'CLI'),
(90,'2026-03-23 22:41:02','','Daily backup completed successfully',0,'CLI'),
(91,'2026-03-24 00:00:04','','Initiating Daily backup',0,'CLI'),
(92,'2026-03-24 00:00:05','','Daily backup completed successfully',0,'CLI'),
(93,'2026-03-24 02:25:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(94,'2026-03-24 02:26:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(95,'2026-03-24 02:27:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(96,'2026-03-24 02:28:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(97,'2026-03-24 16:33:12','','WGA Get Devices: failed - count: 0',0,'103.115.242.94'),
(98,'2026-03-24 16:33:25','','WGA Pairing Code: failed',0,'103.115.242.95'),
(99,'2026-03-24 16:33:33','','WGA Get Devices: failed - count: 0',0,'103.115.242.95'),
(100,'2026-03-24 16:37:13','SuperAdmin','[admin]: Settings Saved Successfully',1,'103.115.242.93'),
(101,'2026-03-24 16:38:41','','WGA Get Devices: failed - count: 0',0,'103.115.242.94'),
(102,'2026-03-24 16:38:56','','WGA Get Devices: failed - count: 0',0,'103.115.242.94'),
(103,'2026-03-24 16:38:57','','WGA Get Devices: failed - count: 0',0,'103.115.242.94'),
(104,'2026-03-24 16:50:57','SuperAdmin','[admin]: Settings Saved Successfully',1,'103.115.242.93'),
(105,'2026-03-24 21:46:11','SuperAdmin','[admin]: Recharge s135 [5Mbps][BDT. 500]',1,'37.111.210.226'),
(106,'2026-03-24 23:42:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(107,'2026-03-25 00:00:04','','Initiating Daily backup',0,'CLI'),
(108,'2026-03-25 00:00:04','','Daily backup completed successfully',0,'CLI'),
(109,'2026-03-25 02:25:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(110,'2026-03-25 02:26:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(111,'2026-03-25 02:27:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(112,'2026-03-25 02:28:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(113,'2026-03-26 00:00:05','','Initiating Daily backup',0,'CLI'),
(114,'2026-03-26 00:00:05','','Daily backup completed successfully',0,'CLI'),
(115,'2026-03-26 04:31:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(116,'2026-03-26 04:32:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(117,'2026-03-26 04:33:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(118,'2026-03-26 04:34:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(119,'2026-03-26 14:00:27','SuperAdmin','[admin]: Recharge arian@01709541829 [5Mbps][BDT. 500]',1,'37.111.212.156'),
(120,'2026-03-26 19:28:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(121,'2026-03-27 00:00:04','','Initiating Daily backup',0,'CLI'),
(122,'2026-03-27 00:00:04','','Daily backup completed successfully',0,'CLI'),
(123,'2026-03-27 02:25:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(124,'2026-03-27 02:26:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(125,'2026-03-27 02:27:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(126,'2026-03-27 02:28:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(127,'2026-03-27 15:38:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(128,'2026-03-27 19:55:15','SuperAdmin','[admin]: Recharge omit@0191635720 [5Mbps][BDT. 500]',1,'103.115.242.92'),
(129,'2026-03-28 00:00:05','','Initiating Daily backup',0,'CLI'),
(130,'2026-03-28 00:00:05','','Daily backup completed successfully',0,'CLI'),
(131,'2026-03-28 02:25:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(132,'2026-03-28 02:26:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(133,'2026-03-28 02:27:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(134,'2026-03-28 02:28:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(135,'2026-03-28 13:46:16','SuperAdmin','admin Login Successful',1,'111.221.6.34'),
(136,'2026-03-28 13:47:31','SuperAdmin','admin Login Successful',1,'111.221.6.34'),
(137,'2026-03-28 19:29:27','SuperAdmin','admin Login Successful',1,'37.111.210.110'),
(138,'2026-03-28 20:05:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(139,'2026-03-28 20:16:13','Admin','[shahad]: Recharge salam@01706589569 [5Mbps][BDT. 500]',2,'103.109.96.169'),
(140,'2026-03-28 20:40:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(141,'2026-03-28 20:44:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(142,'2026-03-29 00:00:05','','Initiating Daily backup',0,'CLI'),
(143,'2026-03-29 00:00:05','','Daily backup completed successfully',0,'CLI'),
(144,'2026-03-29 04:30:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(145,'2026-03-29 04:31:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(146,'2026-03-29 04:32:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(147,'2026-03-29 04:33:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(148,'2026-03-29 15:25:10','SuperAdmin','[admin]: Recharge saikot@01915606414 [5Mbps][BDT. 500]',1,'37.111.207.87'),
(149,'2026-03-29 20:30:55','SuperAdmin','[admin]: Recharge mokta@01402507488 [5Mbps][BDT. 500]',1,'103.115.242.93'),
(150,'2026-03-29 20:31:07','SuperAdmin','[admin]: Recharge mokta@01402507488 [5Mbps][BDT. 500]',1,'103.115.242.93'),
(151,'2026-03-29 21:14:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(152,'2026-03-29 21:15:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(153,'2026-03-29 21:16:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(154,'2026-03-29 21:17:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(155,'2026-03-29 21:18:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(156,'2026-03-29 21:19:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(157,'2026-03-29 21:20:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(158,'2026-03-29 21:21:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(159,'2026-03-29 21:22:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(160,'2026-03-29 21:23:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(161,'2026-03-29 21:24:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(162,'2026-03-29 21:25:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(163,'2026-03-29 21:26:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(164,'2026-03-29 21:27:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(165,'2026-03-29 21:28:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(166,'2026-03-29 21:29:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(167,'2026-03-29 21:30:10','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(168,'2026-03-29 21:31:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(169,'2026-03-29 21:32:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(170,'2026-03-29 21:33:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(171,'2026-03-29 21:34:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(172,'2026-03-29 21:35:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(173,'2026-03-29 21:36:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(174,'2026-03-29 21:37:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(175,'2026-03-29 21:38:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(176,'2026-03-29 21:39:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(177,'2026-03-29 21:40:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(178,'2026-03-29 21:41:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(179,'2026-03-29 21:42:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(180,'2026-03-29 21:43:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(181,'2026-03-29 21:44:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(182,'2026-03-29 21:45:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(183,'2026-03-29 21:46:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(184,'2026-03-29 21:47:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(185,'2026-03-29 21:48:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(186,'2026-03-29 21:49:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(187,'2026-03-29 21:50:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(188,'2026-03-29 21:51:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(189,'2026-03-29 21:52:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(190,'2026-03-29 21:53:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(191,'2026-03-29 21:54:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(192,'2026-03-29 21:55:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(193,'2026-03-29 21:56:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(194,'2026-03-29 21:57:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(195,'2026-03-29 21:58:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(196,'2026-03-29 21:59:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(197,'2026-03-29 22:00:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(198,'2026-03-29 22:01:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(199,'2026-03-29 22:02:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(200,'2026-03-29 22:03:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(201,'2026-03-29 22:04:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(202,'2026-03-29 22:05:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(203,'2026-03-29 22:06:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(204,'2026-03-29 22:07:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(205,'2026-03-29 22:08:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(206,'2026-03-29 22:09:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(207,'2026-03-29 22:10:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(208,'2026-03-29 22:11:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(209,'2026-03-29 22:12:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(210,'2026-03-29 22:13:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(211,'2026-03-29 22:14:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(212,'2026-03-29 22:15:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(213,'2026-03-29 22:16:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(214,'2026-03-29 22:17:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(215,'2026-03-29 22:18:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(216,'2026-03-29 22:19:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(217,'2026-03-29 22:20:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(218,'2026-03-29 22:21:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(219,'2026-03-29 22:22:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(220,'2026-03-29 22:23:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(221,'2026-03-29 22:24:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(222,'2026-03-29 22:25:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(223,'2026-03-29 22:26:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(224,'2026-03-29 22:27:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(225,'2026-03-29 22:28:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(226,'2026-03-29 22:29:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(227,'2026-03-29 22:30:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(228,'2026-03-29 22:31:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(229,'2026-03-29 22:32:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(230,'2026-03-29 22:33:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(231,'2026-03-29 22:34:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(232,'2026-03-29 22:35:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(233,'2026-03-29 22:36:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(234,'2026-03-29 22:37:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(235,'2026-03-29 22:38:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(236,'2026-03-29 22:39:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(237,'2026-03-29 22:40:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(238,'2026-03-29 22:41:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(239,'2026-03-29 22:42:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(240,'2026-03-29 22:43:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(241,'2026-03-29 22:44:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(242,'2026-03-29 22:45:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(243,'2026-03-30 00:00:05','','Initiating Daily backup',0,'CLI'),
(244,'2026-03-30 00:00:05','','Daily backup completed successfully',0,'CLI'),
(245,'2026-03-30 04:30:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(246,'2026-03-30 04:31:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(247,'2026-03-30 04:32:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(248,'2026-03-30 04:33:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(249,'2026-03-30 10:08:54','SuperAdmin','[admin]: Recharge nahid@01712154553 [5Mbps][BDT. 500]',1,'103.115.242.93'),
(250,'2026-03-30 10:11:55','SuperAdmin','[admin]: Recharge gamaus@01701661619 [10Mbps][BDT. 1,000]',1,'103.115.242.93'),
(251,'2026-03-30 10:57:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(252,'2026-03-30 10:58:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(253,'2026-03-30 11:49:56','SuperAdmin','[admin]: Recharge sanrise@01754146379 [5Mbps][BDT. 500]',1,'103.115.242.93'),
(254,'2026-03-30 12:04:11','SuperAdmin','[admin]: Recharge sanrise2@01754146379 [10Mbps][BDT. 1,000]',1,'103.115.242.93'),
(255,'2026-03-30 12:13:20','SuperAdmin','[admin]: Recharge gp@01746439345 [5Mbps][BDT. 500]',1,'103.115.242.93'),
(256,'2026-03-30 12:14:45','SuperAdmin','[admin]: Recharge hannan@01754146379 [10Mbps][BDT. 1,000]',1,'103.115.242.93'),
(257,'2026-03-30 12:41:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(258,'2026-03-30 12:42:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(259,'2026-03-30 12:43:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(260,'2026-03-30 12:44:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(261,'2026-03-30 12:45:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(262,'2026-03-30 12:46:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(263,'2026-03-30 12:47:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(264,'2026-03-30 12:48:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(265,'2026-03-30 12:49:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(266,'2026-03-30 12:50:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(267,'2026-03-30 12:51:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(268,'2026-03-30 12:52:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(269,'2026-03-30 12:53:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(270,'2026-03-30 12:54:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(271,'2026-03-30 12:55:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(272,'2026-03-30 12:56:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(273,'2026-03-30 12:57:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(274,'2026-03-30 12:58:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(275,'2026-03-30 12:59:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(276,'2026-03-30 13:00:10','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(277,'2026-03-30 13:01:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(278,'2026-03-30 13:02:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(279,'2026-03-30 13:03:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(280,'2026-03-30 13:04:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(281,'2026-03-30 13:05:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(282,'2026-03-30 13:06:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(283,'2026-03-30 13:07:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(284,'2026-03-30 13:08:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(285,'2026-03-30 13:09:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(286,'2026-03-30 13:10:10','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(287,'2026-03-30 13:11:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(288,'2026-03-30 13:12:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(289,'2026-03-30 13:13:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(290,'2026-03-30 13:14:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(291,'2026-03-30 13:15:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(292,'2026-03-30 13:16:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(293,'2026-03-30 13:17:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(294,'2026-03-30 13:18:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(295,'2026-03-30 13:19:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(296,'2026-03-30 13:20:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(297,'2026-03-30 13:21:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(298,'2026-03-30 13:22:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(299,'2026-03-30 13:23:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(300,'2026-03-30 13:24:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(301,'2026-03-30 13:25:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(302,'2026-03-30 13:26:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(303,'2026-03-30 13:27:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(304,'2026-03-30 13:28:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(305,'2026-03-30 13:29:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(306,'2026-03-30 13:30:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(307,'2026-03-30 13:31:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(308,'2026-03-30 13:32:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(309,'2026-03-30 13:33:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(310,'2026-03-30 13:34:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(311,'2026-03-30 13:35:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(312,'2026-03-30 13:36:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(313,'2026-03-30 13:37:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(314,'2026-03-30 13:38:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(315,'2026-03-30 13:39:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(316,'2026-03-30 13:40:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(317,'2026-03-30 13:41:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(318,'2026-03-30 13:42:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(319,'2026-03-30 13:43:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(320,'2026-03-30 13:44:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(321,'2026-03-30 13:45:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(322,'2026-03-30 13:46:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(323,'2026-03-30 13:47:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(324,'2026-03-30 13:48:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(325,'2026-03-30 13:49:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(326,'2026-03-30 13:50:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(327,'2026-03-30 13:51:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(328,'2026-03-30 13:52:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(329,'2026-03-30 14:06:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(330,'2026-03-30 14:07:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(331,'2026-03-30 14:08:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(332,'2026-03-30 14:09:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(333,'2026-03-30 14:10:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(334,'2026-03-30 14:11:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(335,'2026-03-30 14:12:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(336,'2026-03-30 14:13:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(337,'2026-03-30 14:14:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(338,'2026-03-30 14:15:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(339,'2026-03-30 14:16:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(340,'2026-03-30 14:17:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(341,'2026-03-30 14:18:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(342,'2026-03-30 14:19:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(343,'2026-03-30 14:20:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(344,'2026-03-30 17:22:28','SuperAdmin','[admin]: Recharge jannat@01343504263 [5Mbps][BDT. 500]',1,'103.115.242.92'),
(345,'2026-03-30 17:36:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(346,'2026-03-30 17:37:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(347,'2026-03-30 17:38:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(348,'2026-03-30 17:39:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(349,'2026-03-30 17:40:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(350,'2026-03-30 17:41:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(351,'2026-03-30 17:42:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(352,'2026-03-30 17:43:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(353,'2026-03-30 17:44:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(354,'2026-03-30 17:45:10','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(355,'2026-03-30 17:46:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(356,'2026-03-30 17:47:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(357,'2026-03-30 17:48:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(358,'2026-03-30 17:49:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(359,'2026-03-30 17:50:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(360,'2026-03-30 17:51:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(361,'2026-03-30 17:52:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(362,'2026-03-30 17:53:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(363,'2026-03-30 17:54:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(364,'2026-03-30 17:55:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(365,'2026-03-30 17:56:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(366,'2026-03-30 17:57:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(367,'2026-03-30 17:58:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(368,'2026-03-30 17:59:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(369,'2026-03-30 18:00:10','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(370,'2026-03-30 18:01:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(371,'2026-03-30 18:02:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(372,'2026-03-30 18:03:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(373,'2026-03-30 18:04:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(374,'2026-03-30 18:05:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(375,'2026-03-30 18:06:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(376,'2026-03-30 18:07:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(377,'2026-03-30 18:08:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(378,'2026-03-30 18:09:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(379,'2026-03-30 18:10:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(380,'2026-03-30 18:11:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(381,'2026-03-30 18:12:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(382,'2026-03-30 18:13:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(383,'2026-03-30 18:14:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(384,'2026-03-30 18:15:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(385,'2026-03-30 18:22:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(386,'2026-03-30 18:23:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(387,'2026-03-30 18:24:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(388,'2026-03-30 18:25:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(389,'2026-03-30 18:26:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(390,'2026-03-30 18:27:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(391,'2026-03-30 18:28:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(392,'2026-03-30 18:29:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(393,'2026-03-30 18:30:10','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(394,'2026-03-30 18:31:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(395,'2026-03-30 18:32:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(396,'2026-03-30 18:33:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(397,'2026-03-30 18:34:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(398,'2026-03-30 18:35:10','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(399,'2026-03-30 18:36:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(400,'2026-03-30 18:37:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(401,'2026-03-30 18:38:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(402,'2026-03-30 18:39:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(403,'2026-03-30 18:40:10','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(404,'2026-03-30 18:41:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(405,'2026-03-30 18:42:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(406,'2026-03-30 18:43:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(407,'2026-03-30 18:44:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(408,'2026-03-30 18:45:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(409,'2026-03-30 18:46:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(410,'2026-03-30 18:47:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(411,'2026-03-30 18:48:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(412,'2026-03-30 18:49:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(413,'2026-03-30 18:50:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(414,'2026-03-30 18:51:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(415,'2026-03-30 18:52:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(416,'2026-03-30 18:53:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(417,'2026-03-30 18:54:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(418,'2026-03-30 18:55:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(419,'2026-03-30 18:56:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(420,'2026-03-30 18:57:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(421,'2026-03-30 18:58:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(422,'2026-03-30 18:59:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(423,'2026-03-30 19:00:10','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(424,'2026-03-30 19:01:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(425,'2026-03-30 19:02:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(426,'2026-03-30 19:03:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(427,'2026-03-30 19:04:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(428,'2026-03-30 19:05:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(429,'2026-03-30 19:06:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(430,'2026-03-30 19:07:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(431,'2026-03-30 19:08:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(432,'2026-03-30 19:09:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(433,'2026-03-30 19:10:10','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(434,'2026-03-30 19:11:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(435,'2026-03-30 19:12:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(436,'2026-03-30 19:13:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(437,'2026-03-30 19:14:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(438,'2026-03-30 19:15:11','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(439,'2026-03-30 19:16:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(440,'2026-03-30 19:17:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(441,'2026-03-30 19:18:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(442,'2026-03-30 19:19:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(443,'2026-03-30 19:20:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(444,'2026-03-30 19:21:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(445,'2026-03-30 19:22:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(446,'2026-03-30 19:23:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(447,'2026-03-30 19:24:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(448,'2026-03-30 19:25:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(449,'2026-03-30 19:26:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(450,'2026-03-30 19:27:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(451,'2026-03-30 19:28:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(452,'2026-03-30 19:29:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(453,'2026-03-30 19:30:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(454,'2026-03-30 19:31:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(455,'2026-03-30 19:32:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(456,'2026-03-30 19:33:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(457,'2026-03-30 19:34:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(458,'2026-03-30 19:35:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(459,'2026-03-30 19:36:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(460,'2026-03-30 19:37:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(461,'2026-03-30 19:38:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(462,'2026-03-30 19:39:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(463,'2026-03-30 19:40:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(464,'2026-03-30 19:41:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(465,'2026-03-30 19:42:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(466,'2026-03-30 19:43:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(467,'2026-03-30 19:44:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(468,'2026-03-30 19:45:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(469,'2026-03-30 19:46:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(470,'2026-03-30 19:47:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(471,'2026-03-30 19:48:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(472,'2026-03-30 19:49:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(473,'2026-03-30 19:50:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(474,'2026-03-30 19:51:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(475,'2026-03-30 19:52:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(476,'2026-03-30 19:53:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(477,'2026-03-30 19:54:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(478,'2026-03-30 19:55:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(479,'2026-03-30 19:56:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(480,'2026-03-30 19:57:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(481,'2026-03-30 19:58:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(482,'2026-03-30 19:59:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(483,'2026-03-30 20:00:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(484,'2026-03-30 20:01:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(485,'2026-03-30 20:02:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(486,'2026-03-30 20:03:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(487,'2026-03-30 20:04:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(488,'2026-03-30 20:05:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(489,'2026-03-30 20:06:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(490,'2026-03-30 20:07:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(491,'2026-03-30 20:08:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(492,'2026-03-30 20:09:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(493,'2026-03-30 20:10:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(494,'2026-03-30 20:11:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(495,'2026-03-30 20:12:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(496,'2026-03-30 20:13:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(497,'2026-03-30 20:14:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(498,'2026-03-30 20:15:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(499,'2026-03-30 20:16:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(500,'2026-03-30 20:17:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(501,'2026-03-30 20:18:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(502,'2026-03-30 20:19:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(503,'2026-03-30 20:20:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(504,'2026-03-30 20:21:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(505,'2026-03-30 20:22:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(506,'2026-03-30 20:23:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(507,'2026-03-30 20:24:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(508,'2026-03-30 20:25:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(509,'2026-03-30 20:26:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(510,'2026-03-30 20:27:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(511,'2026-03-30 20:28:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(512,'2026-03-30 20:29:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(513,'2026-03-30 20:30:10','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(514,'2026-03-30 20:31:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(515,'2026-03-30 20:32:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(516,'2026-03-30 20:33:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(517,'2026-03-30 20:34:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(518,'2026-03-30 20:35:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(519,'2026-03-30 20:36:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(520,'2026-03-30 20:37:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(521,'2026-03-30 20:38:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(522,'2026-03-30 20:39:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(523,'2026-03-30 20:40:10','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(524,'2026-03-30 20:41:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(525,'2026-03-30 20:42:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(526,'2026-03-30 20:43:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(527,'2026-03-30 20:44:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(528,'2026-03-30 20:45:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(529,'2026-03-30 20:46:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(530,'2026-03-30 20:47:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(531,'2026-03-30 20:48:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(532,'2026-03-30 20:49:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(533,'2026-03-30 20:50:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(534,'2026-03-30 20:51:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(535,'2026-03-30 20:52:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(536,'2026-03-30 20:53:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(537,'2026-03-30 20:54:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(538,'2026-03-30 20:55:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(539,'2026-03-30 20:56:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(540,'2026-03-30 20:57:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(541,'2026-03-30 20:58:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(542,'2026-03-30 20:59:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(543,'2026-03-30 21:00:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(544,'2026-03-30 21:01:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(545,'2026-03-30 21:02:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(546,'2026-03-30 21:03:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(547,'2026-03-30 21:04:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(548,'2026-03-30 21:05:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(549,'2026-03-30 21:06:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(550,'2026-03-30 21:07:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(551,'2026-03-30 21:08:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(552,'2026-03-30 21:09:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(553,'2026-03-30 21:10:10','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(554,'2026-03-30 21:11:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(555,'2026-03-30 21:12:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(556,'2026-03-30 21:13:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(557,'2026-03-30 21:14:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(558,'2026-03-30 21:15:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(559,'2026-03-30 21:16:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(560,'2026-03-30 21:17:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(561,'2026-03-30 21:18:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(562,'2026-03-30 21:19:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(563,'2026-03-30 21:20:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(564,'2026-03-30 21:21:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(565,'2026-03-30 21:22:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(566,'2026-03-30 21:23:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(567,'2026-03-30 21:24:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(568,'2026-03-30 21:25:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(569,'2026-03-30 21:26:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(570,'2026-03-30 21:27:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(571,'2026-03-30 21:28:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(572,'2026-03-30 21:29:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(573,'2026-03-30 21:30:10','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(574,'2026-03-30 21:31:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(575,'2026-03-30 21:32:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(576,'2026-03-30 21:33:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(577,'2026-03-30 21:34:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(578,'2026-03-30 21:35:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(579,'2026-03-30 21:36:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(580,'2026-03-30 21:37:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(581,'2026-03-30 21:38:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(582,'2026-03-30 21:39:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(583,'2026-03-30 21:40:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(584,'2026-03-30 21:41:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(585,'2026-03-30 21:42:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(586,'2026-03-30 21:43:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(587,'2026-03-30 21:44:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(588,'2026-03-30 21:45:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(589,'2026-03-30 21:46:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(590,'2026-03-30 21:47:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(591,'2026-03-30 21:48:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(592,'2026-03-30 21:49:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(593,'2026-03-30 21:50:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(594,'2026-03-30 21:51:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(595,'2026-03-30 21:52:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(596,'2026-03-30 21:53:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(597,'2026-03-30 21:54:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(598,'2026-03-30 21:55:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(599,'2026-03-30 21:56:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(600,'2026-03-30 21:57:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(601,'2026-03-30 21:58:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(602,'2026-03-30 21:59:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(603,'2026-03-30 22:00:10','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(604,'2026-03-30 22:01:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(605,'2026-03-30 22:02:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(606,'2026-03-30 22:03:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(607,'2026-03-30 22:04:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(608,'2026-03-30 22:05:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(609,'2026-03-30 22:06:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(610,'2026-03-30 22:07:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(611,'2026-03-30 22:08:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(612,'2026-03-30 22:09:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(613,'2026-03-30 22:10:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(614,'2026-03-30 22:11:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(615,'2026-03-30 22:12:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(616,'2026-03-30 22:13:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(617,'2026-03-30 22:14:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(618,'2026-03-30 22:15:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(619,'2026-03-30 22:16:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(620,'2026-03-30 22:17:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(621,'2026-03-30 22:18:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(622,'2026-03-30 22:19:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(623,'2026-03-30 22:20:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(624,'2026-03-30 22:21:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(625,'2026-03-30 22:22:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(626,'2026-03-30 22:23:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(627,'2026-03-30 22:24:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(628,'2026-03-30 22:25:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(629,'2026-03-30 22:26:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(630,'2026-03-30 22:27:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(631,'2026-03-30 22:28:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(632,'2026-03-30 22:29:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(633,'2026-03-30 22:30:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(634,'2026-03-30 22:31:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(635,'2026-03-30 22:32:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(636,'2026-03-30 22:33:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(637,'2026-03-30 22:34:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(638,'2026-03-30 22:35:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(639,'2026-03-30 22:36:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(640,'2026-03-30 22:37:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(641,'2026-03-30 22:38:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(642,'2026-03-30 22:39:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(643,'2026-03-30 22:40:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(644,'2026-03-30 22:41:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(645,'2026-03-30 22:42:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(646,'2026-03-30 22:43:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(647,'2026-03-30 22:44:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(648,'2026-03-30 22:45:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(649,'2026-03-30 22:46:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(650,'2026-03-30 22:47:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(651,'2026-03-30 22:48:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(652,'2026-03-30 22:49:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(653,'2026-03-30 22:50:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(654,'2026-03-30 22:51:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(655,'2026-03-30 22:52:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(656,'2026-03-30 22:53:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(657,'2026-03-30 22:54:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(658,'2026-03-30 22:55:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(659,'2026-03-30 22:56:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(660,'2026-03-30 22:57:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(661,'2026-03-30 22:58:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(662,'2026-03-30 22:59:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(663,'2026-03-30 23:00:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(664,'2026-03-30 23:01:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(665,'2026-03-30 23:02:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(666,'2026-03-30 23:03:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(667,'2026-03-30 23:04:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(668,'2026-03-30 23:05:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(669,'2026-03-30 23:06:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(670,'2026-03-30 23:07:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(671,'2026-03-30 23:08:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(672,'2026-03-30 23:09:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(673,'2026-03-30 23:10:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(674,'2026-03-30 23:11:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(675,'2026-03-30 23:12:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(676,'2026-03-30 23:13:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(677,'2026-03-30 23:14:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(678,'2026-03-30 23:15:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(679,'2026-03-30 23:16:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(680,'2026-03-30 23:17:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(681,'2026-03-30 23:18:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(682,'2026-03-30 23:19:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(683,'2026-03-30 23:20:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(684,'2026-03-30 23:21:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(685,'2026-03-30 23:22:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(686,'2026-03-30 23:23:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(687,'2026-03-30 23:24:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(688,'2026-03-30 23:25:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(689,'2026-03-30 23:26:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(690,'2026-03-30 23:27:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(691,'2026-03-30 23:28:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(692,'2026-03-30 23:29:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(693,'2026-03-30 23:30:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(694,'2026-03-30 23:31:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(695,'2026-03-30 23:32:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(696,'2026-03-30 23:33:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(697,'2026-03-30 23:34:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(698,'2026-03-30 23:35:37','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(699,'2026-03-30 23:36:58','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(700,'2026-03-30 23:37:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(701,'2026-03-30 23:38:26','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(702,'2026-03-30 23:39:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(703,'2026-03-30 23:40:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(704,'2026-03-30 23:41:22','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(705,'2026-03-30 23:42:15','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(706,'2026-03-30 23:43:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(707,'2026-03-30 23:44:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(708,'2026-03-30 23:45:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(709,'2026-03-30 23:46:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(710,'2026-03-30 23:47:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(711,'2026-03-30 23:48:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(712,'2026-03-30 23:49:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(713,'2026-03-30 23:50:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(714,'2026-03-30 23:51:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(715,'2026-03-30 23:52:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(716,'2026-03-30 23:53:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(717,'2026-03-30 23:54:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(718,'2026-03-30 23:55:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(719,'2026-03-30 23:56:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(720,'2026-03-30 23:57:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(721,'2026-03-30 23:58:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(722,'2026-03-30 23:59:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(723,'2026-03-31 00:00:05','','Initiating Daily backup',0,'CLI'),
(724,'2026-03-31 00:00:05','','Daily backup completed successfully',0,'CLI'),
(725,'2026-03-31 00:00:10','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(726,'2026-03-31 00:01:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(727,'2026-03-31 00:02:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(728,'2026-03-31 00:03:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(729,'2026-03-31 00:04:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(730,'2026-03-31 00:05:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(731,'2026-03-31 00:06:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(732,'2026-03-31 00:07:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(733,'2026-03-31 00:08:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(734,'2026-03-31 00:09:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(735,'2026-03-31 00:10:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(736,'2026-03-31 00:11:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(737,'2026-03-31 00:12:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(738,'2026-03-31 00:13:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(739,'2026-03-31 00:14:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(740,'2026-03-31 00:15:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(741,'2026-03-31 00:16:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(742,'2026-03-31 00:17:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(743,'2026-03-31 00:18:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(744,'2026-03-31 00:19:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(745,'2026-03-31 00:20:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(746,'2026-03-31 00:21:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(747,'2026-03-31 00:22:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(748,'2026-03-31 00:23:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(749,'2026-03-31 00:24:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(750,'2026-03-31 03:55:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(751,'2026-03-31 03:56:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(752,'2026-03-31 03:57:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(753,'2026-03-31 03:58:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(754,'2026-03-31 03:59:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(755,'2026-03-31 04:00:10','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(756,'2026-03-31 04:01:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(757,'2026-03-31 04:02:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(758,'2026-03-31 04:03:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(759,'2026-03-31 04:04:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(760,'2026-03-31 04:05:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(761,'2026-03-31 04:06:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(762,'2026-03-31 04:07:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(763,'2026-03-31 04:08:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(764,'2026-03-31 04:09:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(765,'2026-03-31 04:10:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(766,'2026-03-31 04:11:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(767,'2026-03-31 04:12:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(768,'2026-03-31 04:13:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(769,'2026-03-31 04:14:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(770,'2026-03-31 04:15:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(771,'2026-03-31 04:16:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(772,'2026-03-31 04:17:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(773,'2026-03-31 04:18:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(774,'2026-03-31 04:19:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(775,'2026-03-31 04:20:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(776,'2026-03-31 04:21:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(777,'2026-03-31 04:22:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(778,'2026-03-31 04:23:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(779,'2026-03-31 04:24:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(780,'2026-03-31 04:25:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(781,'2026-03-31 04:26:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(782,'2026-03-31 04:27:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(783,'2026-03-31 04:28:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(784,'2026-03-31 04:29:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(785,'2026-03-31 04:30:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(786,'2026-03-31 04:31:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(787,'2026-03-31 04:32:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(788,'2026-03-31 04:33:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(789,'2026-03-31 04:34:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(790,'2026-03-31 04:35:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(791,'2026-03-31 04:36:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(792,'2026-03-31 04:37:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(793,'2026-03-31 04:38:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(794,'2026-03-31 04:39:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(795,'2026-03-31 04:40:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(796,'2026-03-31 04:41:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(797,'2026-03-31 04:42:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(798,'2026-03-31 04:43:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(799,'2026-03-31 04:44:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(800,'2026-03-31 04:45:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(801,'2026-03-31 04:46:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(802,'2026-03-31 04:47:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(803,'2026-03-31 04:48:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(804,'2026-03-31 04:49:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(805,'2026-03-31 04:50:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(806,'2026-03-31 04:51:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(807,'2026-03-31 04:52:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(808,'2026-03-31 04:53:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(809,'2026-03-31 04:54:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(810,'2026-03-31 04:55:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(811,'2026-03-31 04:56:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(812,'2026-03-31 04:57:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(813,'2026-03-31 04:58:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(814,'2026-03-31 04:59:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(815,'2026-03-31 05:00:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(816,'2026-03-31 05:01:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(817,'2026-03-31 05:02:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(818,'2026-03-31 05:03:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(819,'2026-03-31 05:04:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(820,'2026-03-31 05:05:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(821,'2026-03-31 05:06:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(822,'2026-03-31 05:07:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(823,'2026-03-31 05:08:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(824,'2026-03-31 05:09:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(825,'2026-03-31 05:10:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(826,'2026-03-31 05:11:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(827,'2026-03-31 05:12:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(828,'2026-03-31 05:13:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(829,'2026-03-31 05:14:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(830,'2026-03-31 05:15:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(831,'2026-03-31 05:16:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(832,'2026-03-31 05:17:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(833,'2026-03-31 05:18:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(834,'2026-03-31 05:19:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(835,'2026-03-31 05:20:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(836,'2026-03-31 05:21:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(837,'2026-03-31 05:22:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(838,'2026-03-31 05:23:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(839,'2026-03-31 05:24:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(840,'2026-03-31 05:25:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(841,'2026-03-31 05:26:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(842,'2026-03-31 05:27:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(843,'2026-03-31 05:28:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(844,'2026-03-31 05:29:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(845,'2026-03-31 05:30:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(846,'2026-03-31 05:31:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(847,'2026-03-31 05:32:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(848,'2026-03-31 05:33:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(849,'2026-03-31 05:34:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(850,'2026-03-31 05:35:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(851,'2026-03-31 05:36:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(852,'2026-03-31 05:37:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(853,'2026-03-31 05:38:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(854,'2026-03-31 05:39:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(855,'2026-03-31 05:40:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(856,'2026-03-31 05:41:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(857,'2026-03-31 05:42:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(858,'2026-03-31 05:43:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(859,'2026-03-31 05:44:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(860,'2026-03-31 05:45:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(861,'2026-03-31 05:46:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(862,'2026-03-31 05:47:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(863,'2026-03-31 05:48:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(864,'2026-03-31 05:49:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(865,'2026-03-31 05:50:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(866,'2026-03-31 05:51:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(867,'2026-03-31 05:52:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(868,'2026-03-31 05:53:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(869,'2026-03-31 05:54:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(870,'2026-03-31 05:55:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(871,'2026-03-31 05:56:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(872,'2026-03-31 05:57:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(873,'2026-03-31 05:58:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(874,'2026-03-31 05:59:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(875,'2026-03-31 06:00:11','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(876,'2026-03-31 06:01:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(877,'2026-03-31 06:02:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(878,'2026-03-31 06:03:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(879,'2026-03-31 06:04:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(880,'2026-03-31 06:05:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(881,'2026-03-31 06:06:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(882,'2026-03-31 06:07:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(883,'2026-03-31 06:08:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(884,'2026-03-31 06:09:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(885,'2026-03-31 06:10:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(886,'2026-03-31 06:11:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(887,'2026-03-31 06:12:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(888,'2026-03-31 06:13:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(889,'2026-03-31 06:14:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(890,'2026-03-31 06:15:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(891,'2026-03-31 06:16:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(892,'2026-03-31 06:17:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(893,'2026-03-31 06:18:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(894,'2026-03-31 06:19:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(895,'2026-03-31 06:25:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(896,'2026-03-31 10:46:35','SuperAdmin','admin Failed Login',0,'103.115.242.93'),
(897,'2026-03-31 10:46:42','SuperAdmin','admin Login Successful',1,'103.115.242.93'),
(898,'2026-03-31 10:46:55','SuperAdmin','admin Login Successful',1,'103.115.242.93'),
(899,'2026-03-31 10:47:16','SuperAdmin','admin Failed Login',0,'103.115.242.93'),
(900,'2026-03-31 10:47:22','SuperAdmin','admin Login Successful',1,'103.115.242.93'),
(901,'2026-03-31 10:48:38','SuperAdmin','admin Login Successful',1,'103.115.242.93'),
(902,'2026-03-31 10:49:11','SuperAdmin','admin Login Successful',1,'103.115.242.93'),
(903,'2026-03-31 10:49:31','SuperAdmin','admin Login Successful',1,'103.115.242.93'),
(904,'2026-03-31 10:49:54','SuperAdmin','admin Login Successful',1,'103.115.242.93'),
(905,'2026-03-31 10:51:39','SuperAdmin','[admin]: Recharge jalal@01822501671 [5Mbps][BDT. 500]',1,'103.115.242.93'),
(906,'2026-03-31 13:17:57','SuperAdmin','[admin]: Recharge sujon@01406572876 [600-Taka][BDT. 600]',1,'103.115.242.93'),
(907,'2026-03-31 13:19:12','SuperAdmin','[admin]: Recharge ebrahim@01868451762 [5Mbps][BDT. 500]',1,'103.115.242.93'),
(908,'2026-03-31 15:40:17','SuperAdmin','[admin]: Recharge sayem@01923751394 [5Mbps][BDT. 500]',1,'103.115.242.93'),
(909,'2026-03-31 15:41:24','SuperAdmin','[admin]: Recharge maksu@01904745509 [5Mbps][BDT. 500]',1,'103.115.242.93'),
(910,'2026-03-31 19:00:10','SuperAdmin','[admin]: Recharge safat@01742252677 [5Mbps][BDT. 500]',1,'103.115.242.94'),
(911,'2026-03-31 20:44:58','SuperAdmin','[admin]: Recharge mona@01684310647 [800-Taka][BDT. 800]',1,'103.115.242.94'),
(912,'2026-03-31 20:51:24','SuperAdmin','[admin]: Recharge shihab@01307786743 [5Mbps][BDT. 500]',1,'103.115.242.95'),
(913,'2026-03-31 21:02:56','SuperAdmin','[admin]: Recharge zim@019116445800 [5Mbps][BDT. 500]',1,'103.115.242.93'),
(914,'2026-03-31 22:35:53','SuperAdmin','[admin]: Recharge sumon@01925442162 [5Mbps][BDT. 500]',1,'103.115.242.94'),
(915,'2026-03-31 22:37:12','SuperAdmin','[admin]: Recharge toffajol@01613561077 [5Mbps][BDT. 500]',1,'103.115.242.95'),
(916,'2026-03-31 23:01:23','SuperAdmin','[admin]: Recharge kajol@01916126486 [5Mbps][BDT. 500]',1,'103.115.242.95'),
(917,'2026-03-31 23:03:53','SuperAdmin','[admin]: Recharge tashfe@01331104238 [5Mbps][BDT. 500]',1,'103.115.242.93'),
(918,'2026-04-01 00:00:05','','Initiating Daily backup',0,'CLI'),
(919,'2026-04-01 00:00:05','','Daily backup completed successfully',0,'CLI'),
(920,'2026-04-01 04:30:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(921,'2026-04-01 04:31:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(922,'2026-04-01 04:32:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(923,'2026-04-01 04:33:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(924,'2026-04-01 11:57:45','SuperAdmin','[admin]: Recharge shazahan@01941928232 [5Mbps][BDT. 500]',1,'103.115.242.93'),
(925,'2026-04-01 12:47:49','SuperAdmin','admin Login Successful',1,'45.127.245.208'),
(926,'2026-04-01 12:56:34','SuperAdmin','admin Login Successful',1,'37.111.194.161'),
(927,'2026-04-01 12:58:42','SuperAdmin','[admin]: Recharge amanullah@01402794705 [5Mbps][BDT. 500]',1,'37.111.194.161'),
(928,'2026-04-01 13:00:23','SuperAdmin','[admin]: Recharge alif@01400989371 [5Mbps][BDT. 500]',1,'37.111.194.161'),
(929,'2026-04-01 13:22:43','SuperAdmin','[admin]: Recharge sajid@01910775366 [5Mbps][BDT. 500]',1,'37.111.194.161'),
(930,'2026-04-01 14:08:26','SuperAdmin','admin Login Successful',1,'103.115.242.94'),
(931,'2026-04-01 14:09:27','SuperAdmin','[admin]: Recharge rohim@01935430703 [5Mbps][BDT. 500]',1,'103.115.242.93'),
(932,'2026-04-01 15:13:23','SuperAdmin','[admin]: Recharge sajid@01910775366 [5Mbps][BDT. 500]',1,'37.111.222.127'),
(933,'2026-04-01 15:15:05','SuperAdmin','[admin]: Recharge city@01923006824 [1000-Taka][BDT. 1,000]',1,'103.115.242.93'),
(934,'2026-04-01 15:47:27','SuperAdmin','admin Failed Login',0,'103.115.242.93'),
(935,'2026-04-01 15:47:33','SuperAdmin','admin Login Successful',1,'103.115.242.93'),
(936,'2026-04-01 15:49:15','SuperAdmin','[admin]: Recharge city2@01923006824 [5Mbps][BDT. 500]',1,'103.115.242.95'),
(937,'2026-04-01 21:29:20','SuperAdmin','admin Login Successful',1,'103.25.248.130'),
(938,'2026-04-01 21:39:23','SuperAdmin','[admin]: Recharge ajahar@01938012062 [5Mbps][BDT. 500]',1,'103.25.248.130'),
(939,'2026-04-01 21:41:14','SuperAdmin','[admin]: Recharge subahan@01777694229 [5Mbps][BDT. 500]',1,'103.25.248.130'),
(940,'2026-04-01 21:42:49','SuperAdmin','[admin]: Recharge sohelrana@01964688616 [5Mbps][BDT. 500]',1,'103.25.248.130'),
(941,'2026-04-01 21:44:32','SuperAdmin','[admin]: Recharge rased@01605201112 [600-Taka][BDT. 600]',1,'103.25.248.130'),
(942,'2026-04-02 00:00:05','','Initiating Daily backup',0,'CLI'),
(943,'2026-04-02 00:00:05','','Daily backup completed successfully',0,'CLI'),
(944,'2026-04-02 00:27:43','SuperAdmin','admin Failed Login',0,'103.115.242.93'),
(945,'2026-04-02 00:27:50','SuperAdmin','admin Login Successful',1,'103.115.242.93'),
(946,'2026-04-02 00:29:43','SuperAdmin','[admin]: Recharge aref@01930572254 [5Mbps][BDT. 500]',1,'103.115.242.93'),
(947,'2026-04-02 00:31:47','SuperAdmin','[admin]: Recharge mostafijur@01866949375 [5Mbps][BDT. 500]',1,'103.115.242.95'),
(948,'2026-04-02 00:32:41','SuperAdmin','[admin]: Recharge naim@01863626305 [600-Taka][BDT. 600]',1,'103.115.242.95'),
(949,'2026-04-02 04:30:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(950,'2026-04-02 04:31:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(951,'2026-04-02 04:32:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(952,'2026-04-02 12:01:21','SuperAdmin','admin Login Successful',1,'103.115.242.92'),
(953,'2026-04-02 12:03:19','SuperAdmin','[admin]: Recharge anjeo@01700775435 [5Mbps][BDT. 500]',1,'103.115.242.92'),
(954,'2026-04-02 12:31:36','User','ajahar@01938012062 Login Successful',1249,'45.127.245.208'),
(955,'2026-04-02 13:21:17','SuperAdmin','[admin]: Recharge aminul@01908986887 [5Mbps][BDT. 500]',1,'103.115.242.93'),
(956,'2026-04-02 14:26:10','SuperAdmin','[admin]: Recharge roton@01938320825 [5Mbps][BDT. 500]',1,'37.111.213.149'),
(957,'2026-04-02 14:33:25','SuperAdmin','[admin]: Recharge ajaharul@01938012062 [5Mbps][BDT. 500]',1,'37.111.213.149'),
(958,'2026-04-02 17:49:10','SuperAdmin','[admin]: Recharge saju@01762204089 [5Mbps][BDT. 500]',1,'37.111.213.149'),
(959,'2026-04-02 18:54:01','SuperAdmin','[admin]: Recharge monir@01777421000 [5Mbps][BDT. 500]',1,'103.91.228.178'),
(960,'2026-04-02 18:55:35','SuperAdmin','[admin]: Recharge mahamud@01778880568 [5Mbps][BDT. 500]',1,'103.91.228.178'),
(961,'2026-04-02 19:49:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(962,'2026-04-02 19:50:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(963,'2026-04-02 19:51:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(964,'2026-04-02 19:52:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(965,'2026-04-02 19:53:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(966,'2026-04-02 19:54:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(967,'2026-04-02 19:55:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(968,'2026-04-02 19:56:10','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(969,'2026-04-02 19:57:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(970,'2026-04-02 19:58:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(971,'2026-04-02 19:59:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(972,'2026-04-02 20:00:10','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(973,'2026-04-02 20:01:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(974,'2026-04-02 20:02:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(975,'2026-04-02 20:20:10','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(976,'2026-04-02 21:27:26','SuperAdmin','[admin]: Recharge istiya@01989071851 [5Mbps][BDT. 500]',1,'103.25.250.129'),
(977,'2026-04-02 21:29:26','SuperAdmin','[admin]: Recharge fardul@01845218275 [5Mbps][BDT. 500]',1,'103.25.250.129'),
(978,'2026-04-02 21:31:29','SuperAdmin','[admin]: Recharge khadi@01605588462 [5Mbps][BDT. 500]',1,'103.25.250.129'),
(979,'2026-04-02 21:33:36','SuperAdmin','[admin]: Recharge foridul@01922272182 [5Mbps][BDT. 500]',1,'103.25.250.129'),
(980,'2026-04-02 21:40:10','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(981,'2026-04-02 21:41:29','SuperAdmin','[admin]: Recharge halim@01908806561 [5Mbps][BDT. 500]',1,'103.25.250.129'),
(982,'2026-04-02 23:59:52','SuperAdmin','admin Login Successful',1,'103.115.242.93'),
(983,'2026-04-03 00:00:07','','Initiating Daily backup',0,'CLI'),
(984,'2026-04-03 00:00:07','','Daily backup completed successfully',0,'CLI'),
(985,'2026-04-03 04:30:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(986,'2026-04-03 04:31:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(987,'2026-04-03 04:32:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(988,'2026-04-03 04:33:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(989,'2026-04-03 11:50:43','SuperAdmin','admin Login Successful',1,'103.115.242.93'),
(990,'2026-04-03 11:51:42','SuperAdmin','[admin]: Recharge jaman@01923181402 [5Mbps][BDT. 500]',1,'103.115.242.93'),
(991,'2026-04-03 11:52:26','SuperAdmin','[admin]: Recharge sami@01712753012 [5Mbps][BDT. 500]',1,'103.115.242.93'),
(992,'2026-04-03 12:29:44','Admin','shahad Failed Login',0,'103.115.242.93'),
(993,'2026-04-03 12:30:37','Admin','Shahad Login Successful',2,'103.115.242.93'),
(994,'2026-04-03 12:31:01','SuperAdmin','admin Login Successful',1,'103.115.242.93'),
(995,'2026-04-03 12:31:29','Admin','shahad Login Successful',2,'103.115.242.94'),
(996,'2026-04-03 21:00:49','SuperAdmin','admin Login Successful',1,'103.109.96.170'),
(997,'2026-04-04 00:00:05','','Initiating Daily backup',0,'CLI'),
(998,'2026-04-04 00:00:05','','Daily backup completed successfully',0,'CLI'),
(999,'2026-04-04 04:30:10','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(1000,'2026-04-04 04:31:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(1001,'2026-04-04 04:32:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(1002,'2026-04-04 10:35:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(1003,'2026-04-04 18:49:40','SuperAdmin','admin Login Successful',1,'103.115.242.93'),
(1004,'2026-04-04 18:53:52','SuperAdmin','[admin]: Settings Saved Successfully',1,'103.115.242.93'),
(1005,'2026-04-04 19:04:19','SuperAdmin','[admin]: Settings Saved Successfully',1,'103.115.242.93'),
(1006,'2026-04-04 19:09:59','SuperAdmin','[admin]: Settings Saved Successfully',1,'103.115.242.95'),
(1007,'2026-04-04 19:10:28','SuperAdmin','[admin]: Settings Saved Successfully',1,'103.115.242.93'),
(1008,'2026-04-04 19:34:17','SuperAdmin','[admin]: Settings Saved Successfully',1,'103.115.242.94'),
(1009,'2026-04-04 20:56:53','SuperAdmin','admin Login Successful',1,'103.115.242.93'),
(1010,'2026-04-05 00:00:04','','Initiating Daily backup',0,'CLI'),
(1011,'2026-04-05 00:00:04','','Daily backup completed successfully',0,'CLI'),
(1012,'2026-04-05 00:52:57','SuperAdmin','[admin]: Settings Saved Successfully',1,'103.115.242.93'),
(1013,'2026-04-05 00:58:29','SuperAdmin','[admin]: Recharge 01711084193 [5Mbps][BDT. 500]',1,'103.115.242.93'),
(1014,'2026-04-05 04:30:10','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(1015,'2026-04-05 04:31:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(1016,'2026-04-05 04:32:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(1017,'2026-04-05 19:13:08','SuperAdmin','[admin]: Recharge rofiqul@01938319366 [5Mbps][BDT. 500]',1,'37.111.210.180'),
(1018,'2026-04-05 20:50:24','SuperAdmin','[admin]: Recharge shaurov@01981504856 [5Mbps][BDT. 500]',1,'103.115.242.93'),
(1019,'2026-04-05 21:01:37','SuperAdmin','[admin]: Recharge sohag@01914135791 [5Mbps][BDT. 500]',1,'103.115.242.93'),
(1020,'2026-04-06 00:00:04','','Initiating Daily backup',0,'CLI'),
(1021,'2026-04-06 00:00:05','','Daily backup completed successfully',0,'CLI'),
(1022,'2026-04-06 04:30:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(1023,'2026-04-06 04:31:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(1024,'2026-04-06 04:32:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(1025,'2026-04-06 13:40:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(1026,'2026-04-06 13:41:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(1027,'2026-04-06 13:42:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(1028,'2026-04-06 13:43:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(1029,'2026-04-06 22:52:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(1030,'2026-04-07 00:00:05','','Initiating Daily backup',0,'CLI'),
(1031,'2026-04-07 00:00:05','','Daily backup completed successfully',0,'CLI'),
(1032,'2026-04-07 04:30:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(1033,'2026-04-07 04:31:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(1034,'2026-04-07 04:32:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(1035,'2026-04-08 00:00:04','','Initiating Daily backup',0,'CLI'),
(1036,'2026-04-08 00:00:05','','Daily backup completed successfully',0,'CLI'),
(1037,'2026-04-08 04:30:09','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(1038,'2026-04-08 04:31:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(1039,'2026-04-08 04:32:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(1040,'2026-04-08 22:01:08','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(1041,'2026-04-08 22:47:07','','Unable to connect to 103.109.96.168 on port 2026 using fsockopen: Connection timed out (110)',0,'CLI'),
(1042,'2026-04-09 00:00:04','','Initiating Daily backup',0,'CLI');
/*!40000 ALTER TABLE `tbl_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_message_logs`
--

DROP TABLE IF EXISTS `tbl_message_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_message_logs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `message_type` varchar(50) DEFAULT NULL,
  `recipient` varchar(255) DEFAULT NULL,
  `message_content` text DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `error_message` text DEFAULT NULL,
  `sent_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_message_logs`
--

LOCK TABLES `tbl_message_logs` WRITE;
/*!40000 ALTER TABLE `tbl_message_logs` DISABLE KEYS */;
INSERT INTO `tbl_message_logs` VALUES
(1,'WhatsApp HTTP Response','8801711084193','PHPNuxBill Test Whatsapp','Success','{\"success\":true,\"message\":\"message saved\",\"metadata\":{\"to\":\"8801711084193\",\"msg\":\"PHPNuxBill Test Whatsapp\"},\"result\":{\"type\":\"free\",\"queue_id\":\"1e0fcbf46536fd24ba3b629d6dad84c4\"}}','2026-03-24 10:37:35'),
(2,'WhatsApp HTTP Response','8801911908800','hi','Success','{\"success\":true,\"message\":\"message saved\",\"metadata\":{\"to\":\"8801911908800\",\"msg\":\"hi\"},\"result\":{\"type\":\"free\",\"queue_id\":\"cf7227841b135558b16329fa9e81d9f5\"}}','2026-03-24 10:40:30'),
(3,'WhatsApp HTTP Response','8801911908800','hi','Success','{\"success\":true,\"message\":\"message saved\",\"metadata\":{\"to\":\"8801911908800\",\"msg\":\"hi\"},\"result\":{\"type\":\"free\",\"queue_id\":\"533839e4416c8544d7cfeb043e5a03a9\"}}','2026-03-24 10:41:30'),
(4,'WhatsApp HTTP Response','8801911908800','hi','Success','{\"success\":true,\"message\":\"message saved\",\"metadata\":{\"to\":\"8801911908800\",\"msg\":\"hi\"},\"result\":{\"type\":\"free\",\"queue_id\":\"778169bd0b9fdc937838befadbc722c6\"}}','2026-03-24 10:41:52'),
(5,'WhatsApp HTTP Response','8801911908800','Payment Will be done.','Success','{\"success\":true,\"message\":\"message saved\",\"metadata\":{\"to\":\"8801911908800\",\"msg\":\"Payment Will be done.\"},\"result\":{\"type\":\"free\",\"queue_id\":\"a94d67942f9080ed79b6ffdd55e772f6\"}}','2026-03-24 10:48:34'),
(6,'SMS HTTP Response','01711084193','PHPNuxBill Test SMS','Success','{\"error\":405,\"msg\":\"Authorization required\"}','2026-04-04 13:05:37'),
(7,'SMS HTTP Response','01711084193','PHPNuxBill Test SMS','Success','{\"error\":405,\"msg\":\"Authorization required\"}','2026-04-04 13:10:43'),
(8,'SMS HTTP Response','881996202594','*Net Digital*\r\nDhakkin Salna\r\n01911908800\r\n\r\n\r\nINVOICE: *INV-687*\r\nDate : 04 Apr 2026 19:22\r\nBulk Recharge Md. Shahadur Rahman\r\n\r\n\r\nType : *PPPOE*\r\nPackage : *5Mbps*\r\nPrice : *BDT. 500*\r\n\r\nUsername : *manik@01996202594*\r\nPassword : ***********\r\n\r\nExpired : *04 May 2026 19:22*\r\n\r\n====================\r\nThank you...','Success','{\"error\":405,\"msg\":\"Authorization required\"}','2026-04-04 13:22:41'),
(9,'SMS HTTP Response','01711084193','PHPNuxBill Test SMS','Success','{\"error\":405,\"msg\":\"Authorization required\"}','2026-04-04 13:30:35'),
(10,'MikroTikSMS','Shahed','881908322525','Success',NULL,'2026-04-04 14:52:25'),
(11,'SMS','881908322525','*Net Digital*\r\nDhakkin Salna\r\n01911908800\r\n\r\n\r\nINVOICE: *INV-688*\r\nDate : 04 Apr 2026 20:52\r\nBulk Recharge Md. Shahadur Rahman\r\n\r\n\r\nType : *PPPOE*\r\nPackage : *5','Success',NULL,'2026-04-04 14:52:25'),
(12,'MikroTikSMS','Shahed','881908322525','Success',NULL,'2026-04-04 14:52:25'),
(13,'SMS','881908322525','Mbps*\r\nPrice : *BDT. 500*\r\n\r\nUsername : *shakibul@01908322525*\r\nPassword : ***********\r\n\r\nExpired : *04 May 2026 20:52*\r\n\r\n====================\r\nThank you...','Success',NULL,'2026-04-04 14:52:25'),
(14,'MikroTikSMS','01711084193','PHPNuxBill Test SMS','Success',NULL,'2026-04-04 15:06:43'),
(15,'MikroTikSMS','Shahed','881908322525','Success',NULL,'2026-04-04 15:40:35'),
(16,'SMS','881908322525','*Net Digital*\r\nDhakkin Salna\r\n01911908800\r\n\r\n\r\nINVOICE: *INV-689*\r\nDate : 04 Apr 2026 21:40\r\nBulk Recharge Md. Shahadur Rahman\r\n\r\n\r\nType : *PPPOE*\r\nPackage : *5','Success',NULL,'2026-04-04 15:40:35'),
(17,'MikroTikSMS','Shahed','881908322525','Success',NULL,'2026-04-04 15:40:35'),
(18,'SMS','881908322525','Mbps*\r\nPrice : *BDT. 500*\r\n\r\nUsername : *shakibul@01908322525*\r\nPassword : ***********\r\n\r\nExpired : *03 Jun 2026 20:52*\r\n\r\n====================\r\nThank you...','Success',NULL,'2026-04-04 15:40:35'),
(19,'MikroTikSMS','Shahed','881745962511','Success',NULL,'2026-04-04 16:07:41'),
(20,'SMS','881745962511','*Net Digital*\r\nDhakkin Salna\r\n01911908800\r\n\r\n\r\nINVOICE: *INV-690*\r\nDate : 04 Apr 2026 22:07\r\nBulk Recharge Md. Shahadur Rahman\r\n\r\n\r\nType : *PPPOE*\r\nPackage : *5','Success',NULL,'2026-04-04 16:07:41'),
(21,'MikroTikSMS','Shahed','881745962511','Success',NULL,'2026-04-04 16:07:42'),
(22,'SMS','881745962511','Mbps*\r\nPrice : *BDT. 500*\r\n\r\nUsername : *rafi@01745962511*\r\nPassword : ***********\r\n\r\nExpired : *04 May 2026 22:07*\r\n\r\n====================\r\nThank you...','Success',NULL,'2026-04-04 16:07:42'),
(23,'MikroTikSMS','Shahed','881745962511','Success',NULL,'2026-04-04 16:18:39'),
(24,'SMS','881745962511','*Net Digital*\r\nDhakkin Salna\r\n01911908800\r\n\r\n\r\nINVOICE: *INV-691*\r\nDate : 04 Apr 2026 22:18\r\nBulk Recharge Md. Shahadur Rahman\r\n\r\n\r\nType : *PPPOE*\r\nPackage : *6','Success',NULL,'2026-04-04 16:18:39'),
(25,'MikroTikSMS','Shahed','881745962511','Success',NULL,'2026-04-04 16:18:39'),
(26,'SMS','881745962511','00-Taka*\r\nPrice : *BDT. 600*\r\n\r\nUsername : *rafi@01745962511*\r\nPassword : ***********\r\n\r\nExpired : *04 May 2026 22:18*\r\n\r\n====================\r\nThank you...','Success',NULL,'2026-04-04 16:18:39'),
(27,'MikroTikSMS','Shahed','881979676411','Success',NULL,'2026-04-04 16:44:18'),
(28,'SMS','881979676411','*Net Digital*\r\nDhakkin Salna\r\n01911908800\r\n\r\n\r\nINVOICE: *INV-692*\r\nDate : 04 Apr 2026 22:44\r\nBulk Recharge Md. Shahadur Rahman\r\n\r\n\r\nType : *PPPOE*\r\nPackage : *5','Success',NULL,'2026-04-04 16:44:18'),
(29,'MikroTikSMS','Shahed','881979676411','Success',NULL,'2026-04-04 16:44:18'),
(30,'SMS','881979676411','Mbps*\r\nPrice : *BDT. 500*\r\n\r\nUsername : *babu@01979676411*\r\nPassword : ***********\r\n\r\nExpired : *04 May 2026 22:44*\r\n\r\n====================\r\nThank you...','Success',NULL,'2026-04-04 16:44:18'),
(31,'MikroTikSMS','Shahed','881962009387','Success',NULL,'2026-04-04 16:56:57'),
(32,'SMS','881962009387','*Net Digital*\r\nDhakkin Salna\r\n01911908800\r\n\r\n\r\nINVOICE: *INV-693*\r\nDate : 04 Apr 2026 22:56\r\nBulk Recharge Md. Shahadur Rahman\r\n\r\n\r\nType : *PPPOE*\r\nPackage : *5','Success',NULL,'2026-04-04 16:56:57'),
(33,'MikroTikSMS','Shahed','881962009387','Success',NULL,'2026-04-04 16:56:57'),
(34,'SMS','881962009387','Mbps*\r\nPrice : *BDT. 500*\r\n\r\nUsername : *forhad@01962009387*\r\nPassword : ***********\r\n\r\nExpired : *04 May 2026 22:56*\r\n\r\n====================\r\nThank you...','Success',NULL,'2026-04-04 16:56:57'),
(35,'MikroTikSMS','Shahed','881920779792','Success',NULL,'2026-04-04 18:15:37'),
(36,'SMS','881920779792','*Net Digital*\r\nDhakkin Salna\r\n01911908800\r\n\r\n\r\nINVOICE: *INV-694*\r\nDate : 05 Apr 2026 00:15\r\nBulk Recharge Md. Shahadur Rahman\r\n\r\n\r\nType : *PPPOE*\r\nPackage : *5','Success',NULL,'2026-04-04 18:15:37'),
(37,'MikroTikSMS','Shahed','881920779792','Success',NULL,'2026-04-04 18:15:37'),
(38,'SMS','881920779792','Mbps*\r\nPrice : *BDT. 500*\r\n\r\nUsername : *mosarof*\r\nPassword : ***********\r\n\r\nExpired : *05 May 2026 00:15*\r\n\r\n====================\r\nThank you...','Success',NULL,'2026-04-04 18:15:37'),
(39,'MikroTikSMS','01711084193','PHPNuxBill Test SMS','Error','Error connecting to RouterOS','2026-04-04 18:45:56'),
(40,'MikroTikSMS','01711084193','PHPNuxBill Test SMS','Error','Error connecting to RouterOS','2026-04-04 18:48:02'),
(41,'MikroTikSMS','01711084193','PHPNuxBill Test SMS','Error','Error connecting to RouterOS','2026-04-04 18:48:54'),
(42,'SMS HTTP Response','','*Net Digital*\r\nDhakkin Salna\r\n01911908800\r\n\r\n\r\nINVOICE: *INV-695*\r\nDate : 05 Apr 2026 00:58\r\nBkash Administrator\r\n\r\n\r\nType : *PPPOE*\r\nPackage : *5Mbps*\r\nPrice : *BDT. 500*\r\n\r\nUsername : *01711084193*\r\nPassword : ***********\r\n\r\nExpired : *05 May 2026 00:58*\r\n\r\n====================\r\nThank you...','Success','{\"error\":405,\"msg\":\"Authorization required\"}','2026-04-04 18:58:29'),
(43,'SMS HTTP Response','','test','Success','{\"error\":0,\"msg\":\"Request successfully submitted\",\"data\":{\"request_id\":18421761}}','2026-04-04 19:03:23'),
(44,'SMS HTTP Response','','test','Success','{\"error\":405,\"msg\":\"Authorization required\"}','2026-04-04 19:11:04'),
(45,'SMS HTTP Response','','test','Success','{\"error\":416,\"msg\":\"No valid number found\"}','2026-04-04 19:13:45'),
(46,'SMS HTTP Response','','test','Success','{\"error\":416,\"msg\":\"No valid number found\"}','2026-04-04 19:15:09'),
(47,'SMS HTTP Response','','test','Success','{\"error\":0,\"msg\":\"Request successfully submitted\",\"data\":{\"request_id\":18421834}}','2026-04-04 19:16:21'),
(48,'SMS HTTP Response','01711084193','PHPNuxBill Test SMS','Success','{\"error\":0,\"msg\":\"Request successfully submitted\",\"data\":{\"request_id\":18421856}}','2026-04-04 19:18:53'),
(49,'SMS HTTP Response','','test','Success','{\"error\":404,\"msg\":\"Request not found.\"}','2026-04-04 19:32:51'),
(50,'SMS HTTP Response','','test','Success','{\"error\":0,\"msg\":\"Request successfully submitted\",\"data\":{\"request_id\":18421954}}','2026-04-04 19:34:31'),
(51,'SMS HTTP Response','881964553482','*Net Digital*\r\nDhakkin Salna\r\n01911908800\r\n\r\n\r\nINVOICE: *INV-696*\r\nDate : 05 Apr 2026 13:29\r\nBulk Recharge Md. Shahadur Rahman\r\n\r\n\r\nType : *PPPOE*\r\nPackage : *5Mbps*\r\nPrice : *BDT. 500*\r\n\r\nUsername : *raju@01964553482*\r\nPassword : ***********\r\n\r\nExpired : *05 May 2026 13:29*\r\n\r\n====================\r\nThank you...','Success','{\"error\":0,\"msg\":\"Request successfully submitted\",\"data\":{\"request_id\":18430246}}','2026-04-05 07:29:47'),
(52,'SMS HTTP Response','881927954635','*Net Digital*\r\nDhakkin Salna\r\n01911908800\r\n\r\n\r\nINVOICE: *INV-697*\r\nDate : 05 Apr 2026 14:17\r\nBulk Recharge Md. Shahadur Rahman\r\n\r\n\r\nType : *PPPOE*\r\nPackage : *5Mbps*\r\nPrice : *BDT. 500*\r\n\r\nUsername : *ontos@01927954635*\r\nPassword : ***********\r\n\r\nExpired : *05 May 2026 14:17*\r\n\r\n====================\r\nThank you...','Success','{\"error\":417,\"msg\":\"Insufficient balance\"}','2026-04-05 08:17:55'),
(53,'SMS HTTP Response','881713536437','*Net Digital*\r\nDhakkin Salna\r\n01911908800\r\n\r\n\r\nINVOICE: *INV-698*\r\nDate : 05 Apr 2026 14:40\r\nBulk Recharge Md. Shahadur Rahman\r\n\r\n\r\nType : *PPPOE*\r\nPackage : *5Mbps*\r\nPrice : *BDT. 500*\r\n\r\nUsername : *gias@01713536437*\r\nPassword : ***********\r\n\r\nExpired : *05 May 2026 14:40*\r\n\r\n====================\r\nThank you...','Success','{\"error\":417,\"msg\":\"Insufficient balance\"}','2026-04-05 08:41:00'),
(54,'SMS HTTP Response','881884545433','*Net Digital*\r\nDhakkin Salna\r\n01911908800\r\n\r\n\r\nINVOICE: *INV-699*\r\nDate : 05 Apr 2026 14:53\r\nBulk Recharge Md. Shahadur Rahman\r\n\r\n\r\nType : *PPPOE*\r\nPackage : *5Mbps*\r\nPrice : *BDT. 500*\r\n\r\nUsername : *rakib@01884545433*\r\nPassword : ***********\r\n\r\nExpired : *05 May 2026 14:53*\r\n\r\n====================\r\nThank you...','Success','{\"error\":417,\"msg\":\"Insufficient balance\"}','2026-04-05 08:53:08'),
(55,'SMS HTTP Response','8801938319366','*Net Digital*\r\nDhakkin Salna\r\n01911908800\r\n\r\n\r\nINVOICE: *INV-700*\r\nDate : 05 Apr 2026 19:13\r\nBkash Administrator\r\n\r\n\r\nType : *PPPOE*\r\nPackage : *5Mbps*\r\nPrice : *BDT. 500*\r\n\r\nUsername : *rofiqul@01938319366*\r\nPassword : ***********\r\n\r\nExpired : *05 May 2026 19:13*\r\n\r\n====================\r\nThank you...','Success','{\"error\":417,\"msg\":\"Insufficient balance\"}','2026-04-05 13:13:08'),
(56,'SMS HTTP Response','881731017096','*Net Digital*\r\nDhakkin Salna\r\n01911908800\r\n\r\n\r\nINVOICE: *INV-701*\r\nDate : 05 Apr 2026 19:54\r\nBulk Recharge Md. Shahadur Rahman\r\n\r\n\r\nType : *PPPOE*\r\nPackage : *600-Taka*\r\nPrice : *BDT. 600*\r\n\r\nUsername : *mafuj@01731017096*\r\nPassword : ***********\r\n\r\nExpired : *05 May 2026 19:54*\r\n\r\n====================\r\nThank you...','Success','{\"error\":417,\"msg\":\"Insufficient balance\"}','2026-04-05 13:54:06'),
(57,'SMS HTTP Response','8801981504856','*Net Digital*\r\nDhakkin Salna\r\n01911908800\r\n\r\n\r\nINVOICE: *INV-702*\r\nDate : 05 Apr 2026 20:50\r\nBkash Administrator\r\n\r\n\r\nType : *PPPOE*\r\nPackage : *5Mbps*\r\nPrice : *BDT. 500*\r\n\r\nUsername : *shaurov@01981504856*\r\nPassword : ***********\r\n\r\nExpired : *05 May 2026 20:50*\r\n\r\n====================\r\nThank you...','Success','{\"error\":417,\"msg\":\"Insufficient balance\"}','2026-04-05 14:50:24'),
(58,'SMS HTTP Response','8801914135791','*Net Digital*\r\nDhakkin Salna\r\n01911908800\r\n\r\n\r\nINVOICE: *INV-703*\r\nDate : 05 Apr 2026 21:01\r\nBkash Administrator\r\n\r\n\r\nType : *PPPOE*\r\nPackage : *5Mbps*\r\nPrice : *BDT. 500*\r\n\r\nUsername : *sohag@01914135791*\r\nPassword : ***********\r\n\r\nExpired : *05 May 2026 21:01*\r\n\r\n====================\r\nThank you...','Success','{\"error\":417,\"msg\":\"Insufficient balance\"}','2026-04-05 15:01:37'),
(59,'SMS HTTP Response','8801914135791','*Net Digital*\r\nDhakkin Salna\r\n01911908800\r\n\r\n\r\nINVOICE: *INV-704*\r\nDate : 05 Apr 2026 21:04\r\nBulk Recharge Md. Shahadur Rahman\r\n\r\n\r\nType : *PPPOE*\r\nPackage : *600-Taka*\r\nPrice : *BDT. 600*\r\n\r\nUsername : *sohag@01914135791*\r\nPassword : ***********\r\n\r\nExpired : *05 May 2026 21:04*\r\n\r\n====================\r\nThank you...','Success','{\"error\":417,\"msg\":\"Insufficient balance\"}','2026-04-05 15:04:55'),
(60,'SMS HTTP Response','881619461811','*Net Digital*\r\nDhakkin Salna\r\n01911908800\r\n\r\n\r\nINVOICE: *INV-705*\r\nDate : 05 Apr 2026 22:00\r\nBulk Recharge Md. Shahadur Rahman\r\n\r\n\r\nType : *PPPOE*\r\nPackage : *5Mbps*\r\nPrice : *BDT. 500*\r\n\r\nUsername : *bokkor@01619461811*\r\nPassword : ***********\r\n\r\nExpired : *05 May 2026 22:00*\r\n\r\n====================\r\nThank you...','Success','{\"error\":417,\"msg\":\"Insufficient balance\"}','2026-04-05 16:00:06'),
(61,'SMS HTTP Response','881920995062','*Net Digital*\r\nDhakkin Salna\r\n01911908800\r\n\r\n\r\nINVOICE: *INV-706*\r\nDate : 06 Apr 2026 12:40\r\nBulk Recharge Md. Shahadur Rahman\r\n\r\n\r\nType : *PPPOE*\r\nPackage : *5Mbps*\r\nPrice : *BDT. 500*\r\n\r\nUsername : *riknit@01920995062*\r\nPassword : ***********\r\n\r\nExpired : *06 May 2026 12:40*\r\n\r\n====================\r\nThank you...','Success','{\"error\":417,\"msg\":\"Insufficient balance\"}','2026-04-06 06:40:44'),
(62,'SMS HTTP Response','881968841153','*Net Digital*\r\nDhakkin Salna\r\n01911908800\r\n\r\n\r\nINVOICE: *INV-707*\r\nDate : 06 Apr 2026 12:43\r\nBulk Recharge Md. Shahadur Rahman\r\n\r\n\r\nType : *PPPOE*\r\nPackage : *5Mbps*\r\nPrice : *BDT. 500*\r\n\r\nUsername : *shahin@01968841153*\r\nPassword : ***********\r\n\r\nExpired : *06 May 2026 12:43*\r\n\r\n====================\r\nThank you...','Success','{\"error\":417,\"msg\":\"Insufficient balance\"}','2026-04-06 06:43:02'),
(63,'SMS HTTP Response','881716956699','*Net Digital*\r\nDhakkin Salna\r\n01911908800\r\n\r\n\r\nINVOICE: *INV-708*\r\nDate : 06 Apr 2026 13:09\r\nBulk Recharge Md. Shahadur Rahman\r\n\r\n\r\nType : *PPPOE*\r\nPackage : *1000-Taka*\r\nPrice : *BDT. 1,000*\r\n\r\nUsername : *insurance@01716956699*\r\nPassword : ***********\r\n\r\nExpired : *06 May 2026 13:09*\r\n\r\n====================\r\nThank you...','Success','{\"error\":417,\"msg\":\"Insufficient balance\"}','2026-04-06 07:09:13'),
(64,'SMS HTTP Response','881988728032','*Net Digital*\r\nDhakkin Salna\r\n01911908800\r\n\r\n\r\nINVOICE: *INV-709*\r\nDate : 06 Apr 2026 14:30\r\nBulk Recharge Md. Shahadur Rahman\r\n\r\n\r\nType : *PPPOE*\r\nPackage : *5Mbps*\r\nPrice : *BDT. 500*\r\n\r\nUsername : *rana@01988728032*\r\nPassword : ***********\r\n\r\nExpired : *06 May 2026 14:30*\r\n\r\n====================\r\nThank you...','Success','{\"error\":417,\"msg\":\"Insufficient balance\"}','2026-04-06 08:30:46'),
(65,'SMS HTTP Response','881736762103','*Net Digital*\r\nDhakkin Salna\r\n01911908800\r\n\r\n\r\nINVOICE: *INV-710*\r\nDate : 06 Apr 2026 17:49\r\nBulk Recharge Md. Shahadur Rahman\r\n\r\n\r\nType : *PPPOE*\r\nPackage : *10Mbps*\r\nPrice : *BDT. 1,000*\r\n\r\nUsername : *shahin@01736762103*\r\nPassword : ***********\r\n\r\nExpired : *06 May 2026 17:49*\r\n\r\n====================\r\nThank you...','Success','{\"error\":417,\"msg\":\"Insufficient balance\"}','2026-04-06 11:49:26'),
(66,'SMS HTTP Response','881912208878','*Net Digital*\r\nDhakkin Salna\r\n01911908800\r\n\r\n\r\nINVOICE: *INV-711*\r\nDate : 06 Apr 2026 19:25\r\nBulk Recharge Md. Shahadur Rahman\r\n\r\n\r\nType : *PPPOE*\r\nPackage : *5Mbps*\r\nPrice : *BDT. 500*\r\n\r\nUsername : *flaxiload@01912208878*\r\nPassword : ***********\r\n\r\nExpired : *06 May 2026 19:25*\r\n\r\n====================\r\nThank you...','Success','{\"error\":417,\"msg\":\"Insufficient balance\"}','2026-04-06 13:25:09'),
(67,'SMS HTTP Response','881911121210','*Net Digital*\r\nDhakkin Salna\r\n01911908800\r\n\r\n\r\nINVOICE: *INV-712*\r\nDate : 06 Apr 2026 20:03\r\nBulk Recharge Md. Shahadur Rahman\r\n\r\n\r\nType : *PPPOE*\r\nPackage : *5Mbps*\r\nPrice : *BDT. 500*\r\n\r\nUsername : *ansir@01911121210*\r\nPassword : ***********\r\n\r\nExpired : *06 May 2026 20:03*\r\n\r\n====================\r\nThank you...','Success','{\"error\":417,\"msg\":\"Insufficient balance\"}','2026-04-06 14:03:05'),
(68,'SMS HTTP Response','881718773949','*Net Digital*\r\nDhakkin Salna\r\n01911908800\r\n\r\n\r\nINVOICE: *INV-713*\r\nDate : 06 Apr 2026 20:51\r\nBulk Recharge Md. Shahadur Rahman\r\n\r\n\r\nType : *PPPOE*\r\nPackage : *5Mbps*\r\nPrice : *BDT. 500*\r\n\r\nUsername : *sabbir@01718773949*\r\nPassword : ***********\r\n\r\nExpired : *06 May 2026 20:51*\r\n\r\n====================\r\nThank you...','Success','{\"error\":417,\"msg\":\"Insufficient balance\"}','2026-04-06 14:51:11'),
(69,'SMS HTTP Response','881718773949','*Net Digital*\r\nDhakkin Salna\r\n01911908800\r\n\r\n\r\nINVOICE: *INV-714*\r\nDate : 06 Apr 2026 21:07\r\nBulk Recharge Md. Shahadur Rahman\r\n\r\n\r\nType : *PPPOE*\r\nPackage : *5Mbps*\r\nPrice : *BDT. 500*\r\n\r\nUsername : *sabbir@01718773949*\r\nPassword : ***********\r\n\r\nExpired : *05 Jun 2026 20:51*\r\n\r\n====================\r\nThank you...','Success','{\"error\":417,\"msg\":\"Insufficient balance\"}','2026-04-06 15:07:50'),
(70,'SMS HTTP Response','881718773949','*Net Digital*\r\nDhakkin Salna\r\n01911908800\r\n\r\n\r\nINVOICE: *INV-715*\r\nDate : 06 Apr 2026 21:13\r\nBulk Recharge Md. Shahadur Rahman\r\n\r\n\r\nType : *PPPOE*\r\nPackage : *5Mbps*\r\nPrice : *BDT. 500*\r\n\r\nUsername : *sabbir@01718773949*\r\nPassword : ***********\r\n\r\nExpired : *06 May 2026 21:13*\r\n\r\n====================\r\nThank you...','Success','{\"error\":417,\"msg\":\"Insufficient balance\"}','2026-04-06 15:13:28'),
(71,'SMS HTTP Response','881751512439','*Net Digital*\r\nDhakkin Salna\r\n01911908800\r\n\r\n\r\nINVOICE: *INV-716*\r\nDate : 07 Apr 2026 12:32\r\nBulk Recharge Md. Shahadur Rahman\r\n\r\n\r\nType : *PPPOE*\r\nPackage : *5Mbps*\r\nPrice : *BDT. 500*\r\n\r\nUsername : *sujoy@01751512439*\r\nPassword : ***********\r\n\r\nExpired : *07 May 2026 12:32*\r\n\r\n====================\r\nThank you...','Success','{\"error\":417,\"msg\":\"Insufficient balance\"}','2026-04-07 06:32:55'),
(72,'SMS HTTP Response','881998628952','*Net Digital*\r\nDhakkin Salna\r\n01911908800\r\n\r\n\r\nINVOICE: *INV-717*\r\nDate : 07 Apr 2026 13:31\r\nBulk Recharge Md. Shahadur Rahman\r\n\r\n\r\nType : *PPPOE*\r\nPackage : *5Mbps*\r\nPrice : *BDT. 500*\r\n\r\nUsername : *rayhan@01998628952*\r\nPassword : ***********\r\n\r\nExpired : *07 May 2026 13:31*\r\n\r\n====================\r\nThank you...','Success','{\"error\":417,\"msg\":\"Insufficient balance\"}','2026-04-07 07:31:28'),
(73,'SMS HTTP Response','881706589569','*Net Digital*\r\nDhakkin Salna\r\n01911908800\r\n\r\n\r\nINVOICE: *INV-718*\r\nDate : 07 Apr 2026 14:12\r\nBulk Recharge Md. Shahadur Rahman\r\n\r\n\r\nType : *PPPOE*\r\nPackage : *5Mbps*\r\nPrice : *BDT. 500*\r\n\r\nUsername : *mostafiz@01706589569*\r\nPassword : ***********\r\n\r\nExpired : *07 May 2026 14:12*\r\n\r\n====================\r\nThank you...','Success','{\"error\":417,\"msg\":\"Insufficient balance\"}','2026-04-07 08:12:41'),
(74,'SMS HTTP Response','881735511111','*Net Digital*\r\nDhakkin Salna\r\n01911908800\r\n\r\n\r\nINVOICE: *INV-719*\r\nDate : 07 Apr 2026 18:50\r\nBulk Recharge Md. Shahadur Rahman\r\n\r\n\r\nType : *PPPOE*\r\nPackage : *5Mbps*\r\nPrice : *BDT. 500*\r\n\r\nUsername : *aref@01735511111*\r\nPassword : ***********\r\n\r\nExpired : *07 May 2026 18:50*\r\n\r\n====================\r\nThank you...','Success','{\"error\":417,\"msg\":\"Insufficient balance\"}','2026-04-07 12:50:55'),
(75,'SMS HTTP Response','881783636616','*Net Digital*\r\nDhakkin Salna\r\n01911908800\r\n\r\n\r\nINVOICE: *INV-720*\r\nDate : 07 Apr 2026 19:26\r\nBulk Recharge Md. Shahadur Rahman\r\n\r\n\r\nType : *PPPOE*\r\nPackage : *5Mbps*\r\nPrice : *BDT. 500*\r\n\r\nUsername : *delowar@01783636616*\r\nPassword : ***********\r\n\r\nExpired : *07 May 2026 19:26*\r\n\r\n====================\r\nThank you...','Success','{\"error\":417,\"msg\":\"Insufficient balance\"}','2026-04-07 13:26:55'),
(76,'SMS HTTP Response','881797307872','*Net Digital*\r\nDhakkin Salna\r\n01911908800\r\n\r\n\r\nINVOICE: *INV-721*\r\nDate : 08 Apr 2026 02:41\r\nBulk Recharge Md. Shahadur Rahman\r\n\r\n\r\nType : *PPPOE*\r\nPackage : *5Mbps*\r\nPrice : *BDT. 500*\r\n\r\nUsername : *joyel@01797307872*\r\nPassword : ***********\r\n\r\nExpired : *08 May 2026 02:41*\r\n\r\n====================\r\nThank you...','Success','{\"error\":417,\"msg\":\"Insufficient balance\"}','2026-04-07 20:41:09'),
(77,'SMS HTTP Response','881959663908','*Net Digital*\r\nDhakkin Salna\r\n01911908800\r\n\r\n\r\nINVOICE: *INV-722*\r\nDate : 08 Apr 2026 11:59\r\nBulk Recharge Md. Shahadur Rahman\r\n\r\n\r\nType : *PPPOE*\r\nPackage : *5Mbps*\r\nPrice : *BDT. 500*\r\n\r\nUsername : *ibrahim@01959663908*\r\nPassword : ***********\r\n\r\nExpired : *08 May 2026 11:59*\r\n\r\n====================\r\nThank you...','Success','{\"error\":417,\"msg\":\"Insufficient balance\"}','2026-04-08 05:59:28'),
(78,'SMS HTTP Response','881845759852','*Net Digital*\r\nDhakkin Salna\r\n01911908800\r\n\r\n\r\nINVOICE: *INV-723*\r\nDate : 08 Apr 2026 12:34\r\nBulk Recharge Md. Shahadur Rahman\r\n\r\n\r\nType : *PPPOE*\r\nPackage : *5Mbps*\r\nPrice : *BDT. 500*\r\n\r\nUsername : *masud@01845759852*\r\nPassword : ***********\r\n\r\nExpired : *08 May 2026 12:34*\r\n\r\n====================\r\nThank you...','Success','{\"error\":417,\"msg\":\"Insufficient balance\"}','2026-04-08 06:34:44'),
(79,'SMS HTTP Response','881753659302','*Net Digital*\r\nDhakkin Salna\r\n01911908800\r\n\r\n\r\nINVOICE: *INV-724*\r\nDate : 08 Apr 2026 13:37\r\nBulk Recharge Md. Shahadur Rahman\r\n\r\n\r\nType : *PPPOE*\r\nPackage : *5Mbps*\r\nPrice : *BDT. 500*\r\n\r\nUsername : *amarot@01753659302*\r\nPassword : ***********\r\n\r\nExpired : *08 May 2026 13:37*\r\n\r\n====================\r\nThank you...','Success','{\"error\":417,\"msg\":\"Insufficient balance\"}','2026-04-08 07:37:44'),
(80,'SMS HTTP Response','8801711084193','test','Success','{\"error\":0,\"msg\":\"Request successfully submitted\",\"data\":{\"request_id\":18521024}}','2026-04-08 07:40:17'),
(81,'SMS HTTP Response','881923441444','*Net Digital*\r\nDhakkin Salna\r\n01911908800\r\n\r\n\r\nINVOICE: *INV-725*\r\nDate : 08 Apr 2026 13:55\r\nBulk Recharge Md. Shahadur Rahman\r\n\r\n\r\nType : *PPPOE*\r\nPackage : *5Mbps*\r\nPrice : *BDT. 500*\r\n\r\nUsername : *yeasin@01923441444*\r\nPassword : ***********\r\n\r\nExpired : *08 May 2026 13:55*\r\n\r\n====================\r\nThank you...','Success','{\"error\":0,\"msg\":\"Request successfully submitted\",\"data\":{\"request_id\":18522922}}','2026-04-08 07:55:41'),
(82,'SMS HTTP Response','881980510418','*Net Digital*\r\nDhakkin Salna\r\n01911908800\r\n\r\n\r\nINVOICE: *INV-726*\r\nDate : 08 Apr 2026 14:09\r\nBulk Recharge Md. Shahadur Rahman\r\n\r\n\r\nType : *PPPOE*\r\nPackage : *5Mbps*\r\nPrice : *BDT. 500*\r\n\r\nUsername : *jakiya@01980510418*\r\nPassword : ***********\r\n\r\nExpired : *08 May 2026 14:09*\r\n\r\n====================\r\nThank you...','Success','{\"error\":0,\"msg\":\"Request successfully submitted\",\"data\":{\"request_id\":18523389}}','2026-04-08 08:09:36'),
(83,'SMS HTTP Response','881963021891','*Net Digital*\r\nDhakkin Salna\r\n01911908800\r\n\r\n\r\nINVOICE: *INV-727*\r\nDate : 08 Apr 2026 18:58\r\nBulk Recharge Md. Shahadur Rahman\r\n\r\n\r\nType : *PPPOE*\r\nPackage : *5Mbps*\r\nPrice : *BDT. 500*\r\n\r\nUsername : *noyon@01963021891*\r\nPassword : ***********\r\n\r\nExpired : *08 May 2026 18:58*\r\n\r\n====================\r\nThank you...','Success','{\"error\":0,\"msg\":\"Request successfully submitted\",\"data\":{\"request_id\":18535849}}','2026-04-08 12:58:49'),
(84,'SMS HTTP Response','881773721112','*Net Digital*\r\nDhakkin Salna\r\n01911908800\r\n\r\n\r\nINVOICE: *INV-728*\r\nDate : 08 Apr 2026 19:12\r\nBulk Recharge Md. Shahadur Rahman\r\n\r\n\r\nType : *PPPOE*\r\nPackage : *5Mbps*\r\nPrice : *BDT. 500*\r\n\r\nUsername : *imran@01773721112*\r\nPassword : ***********\r\n\r\nExpired : *08 May 2026 19:12*\r\n\r\n====================\r\nThank you...','Success','{\"error\":0,\"msg\":\"Request successfully submitted\",\"data\":{\"request_id\":18536485}}','2026-04-08 13:13:00'),
(85,'SMS HTTP Response','881932230511','*Net Digital*\r\nDhakkin Salna\r\n01911908800\r\n\r\n\r\nINVOICE: *INV-729*\r\nDate : 08 Apr 2026 19:28\r\nBulk Recharge Md. Shahadur Rahman\r\n\r\n\r\nType : *PPPOE*\r\nPackage : *5Mbps*\r\nPrice : *BDT. 500*\r\n\r\nUsername : *somon@01932230511*\r\nPassword : ***********\r\n\r\nExpired : *08 May 2026 19:28*\r\n\r\n====================\r\nThank you...','Success','{\"error\":0,\"msg\":\"Request successfully submitted\",\"data\":{\"request_id\":18537284}}','2026-04-08 13:28:08'),
(86,'SMS HTTP Response','881404571513','*Net Digital*\r\nDhakkin Salna\r\n01911908800\r\n\r\n\r\nINVOICE: *INV-730*\r\nDate : 08 Apr 2026 20:18\r\nBulk Recharge Md. Shahadur Rahman\r\n\r\n\r\nType : *PPPOE*\r\nPackage : *5Mbps*\r\nPrice : *BDT. 500*\r\n\r\nUsername : *alamin@01404571513*\r\nPassword : ***********\r\n\r\nExpired : *08 May 2026 20:18*\r\n\r\n====================\r\nThank you...','Success','{\"error\":0,\"msg\":\"Request successfully submitted\",\"data\":{\"request_id\":18539229}}','2026-04-08 14:18:53'),
(87,'SMS HTTP Response','881941832957','*Net Digital*\r\nDhakkin Salna\r\n01911908800\r\n\r\n\r\nINVOICE: *INV-731*\r\nDate : 08 Apr 2026 20:34\r\nBulk Recharge Md. Shahadur Rahman\r\n\r\n\r\nType : *PPPOE*\r\nPackage : *5Mbps*\r\nPrice : *BDT. 500*\r\n\r\nUsername : *israt@01941832957*\r\nPassword : ***********\r\n\r\nExpired : *08 May 2026 20:34*\r\n\r\n====================\r\nThank you...','Success','{\"error\":0,\"msg\":\"Request successfully submitted\",\"data\":{\"request_id\":18539720}}','2026-04-08 14:34:39'),
(88,'SMS HTTP Response','881738668933','*Net Digital*\r\nDhakkin Salna\r\n01911908800\r\n\r\n\r\nINVOICE: *INV-732*\r\nDate : 08 Apr 2026 20:45\r\nBulk Recharge Md. Shahadur Rahman\r\n\r\n\r\nType : *PPPOE*\r\nPackage : *600-Taka*\r\nPrice : *BDT. 600*\r\n\r\nUsername : *janmia@01738668933*\r\nPassword : ***********\r\n\r\nExpired : *08 May 2026 20:45*\r\n\r\n====================\r\nThank you...','Success','{\"error\":0,\"msg\":\"Request successfully submitted\",\"data\":{\"request_id\":18540017}}','2026-04-08 14:45:48'),
(89,'SMS HTTP Response','881892365222','*Net Digital*\r\nDhakkin Salna\r\n01911908800\r\n\r\n\r\nINVOICE: *INV-733*\r\nDate : 08 Apr 2026 20:50\r\nBulk Recharge Md. Shahadur Rahman\r\n\r\n\r\nType : *PPPOE*\r\nPackage : *5Mbps*\r\nPrice : *BDT. 500*\r\n\r\nUsername : *firoj@01892365222*\r\nPassword : ***********\r\n\r\nExpired : *08 May 2026 20:50*\r\n\r\n====================\r\nThank you...','Success','{\"error\":0,\"msg\":\"Request successfully submitted\",\"data\":{\"request_id\":18540135}}','2026-04-08 14:50:31'),
(90,'SMS HTTP Response','881873345718','*Net Digital*\r\nDhakkin Salna\r\n01911908800\r\n\r\n\r\nINVOICE: *INV-734*\r\nDate : 08 Apr 2026 21:02\r\nBulk Recharge Md. Shahadur Rahman\r\n\r\n\r\nType : *PPPOE*\r\nPackage : *10Mbps*\r\nPrice : *BDT. 1,000*\r\n\r\nUsername : *rakib@01873345718*\r\nPassword : ***********\r\n\r\nExpired : *08 May 2026 21:02*\r\n\r\n====================\r\nThank you...','Success','{\"error\":0,\"msg\":\"Request successfully submitted\",\"data\":{\"request_id\":18540464}}','2026-04-08 15:02:42'),
(91,'SMS HTTP Response','881404532100','*Net Digital*\r\nDhakkin Salna\r\n01911908800\r\n\r\n\r\nINVOICE: *INV-735*\r\nDate : 08 Apr 2026 21:59\r\nBulk Recharge Md. Shahadur Rahman\r\n\r\n\r\nType : *PPPOE*\r\nPackage : *5Mbps*\r\nPrice : *BDT. 500*\r\n\r\nUsername : *saddam@01404532100*\r\nPassword : ***********\r\n\r\nExpired : *08 May 2026 21:59*\r\n\r\n====================\r\nThank you...','Success','{\"error\":0,\"msg\":\"Request successfully submitted\",\"data\":{\"request_id\":18542303}}','2026-04-08 15:59:14'),
(92,'SMS HTTP Response','881773721112','*Net Digital*\r\nDhakkin Salna\r\n01911908800\r\n\r\n\r\nINVOICE: *INV-736*\r\nDate : 08 Apr 2026 22:54\r\nBulk Recharge Md. Shahadur Rahman\r\n\r\n\r\nType : *PPPOE*\r\nPackage : *5Mbps*\r\nPrice : *BDT. 500*\r\n\r\nUsername : *imran@01773721112*\r\nPassword : ***********\r\n\r\nExpired : *07 Jun 2026 19:12*\r\n\r\n====================\r\nThank you...','Success','{\"error\":0,\"msg\":\"Request successfully submitted\",\"data\":{\"request_id\":18543437}}','2026-04-08 16:54:36'),
(93,'SMS HTTP Response','881302942761','*Net Digital*\r\nDhakkin Salna\r\n01911908800\r\n\r\n\r\nINVOICE: *INV-737*\r\nDate : 08 Apr 2026 22:58\r\nBulk Recharge Md. Shahadur Rahman\r\n\r\n\r\nType : *PPPOE*\r\nPackage : *600-Taka*\r\nPrice : *BDT. 600*\r\n\r\nUsername : *rayan@01302942761*\r\nPassword : ***********\r\n\r\nExpired : *08 May 2026 22:58*\r\n\r\n====================\r\nThank you...','Success','{\"error\":0,\"msg\":\"Request successfully submitted\",\"data\":{\"request_id\":18543524}}','2026-04-08 16:58:53');
/*!40000 ALTER TABLE `tbl_message_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_meta`
--

DROP TABLE IF EXISTS `tbl_meta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_meta` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tbl` varchar(32) NOT NULL COMMENT 'Table name',
  `tbl_id` int(11) NOT NULL COMMENT 'table value id',
  `name` varchar(32) NOT NULL,
  `value` mediumtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='This Table to add additional data for any table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_meta`
--

LOCK TABLES `tbl_meta` WRITE;
/*!40000 ALTER TABLE `tbl_meta` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_meta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_odps`
--

DROP TABLE IF EXISTS `tbl_odps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_odps` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `port_amount` int(11) NOT NULL,
  `attenuation` decimal(15,2) NOT NULL DEFAULT 0.00,
  `address` mediumtext CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `coordinates` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `coverage` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_odps`
--

LOCK TABLES `tbl_odps` WRITE;
/*!40000 ALTER TABLE `tbl_odps` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_odps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_payment_gateway`
--

DROP TABLE IF EXISTS `tbl_payment_gateway`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_payment_gateway` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(32) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `gateway` varchar(32) NOT NULL COMMENT 'xendit | midtrans',
  `gateway_trx_id` varchar(512) NOT NULL DEFAULT '',
  `plan_id` int(11) NOT NULL,
  `plan_name` varchar(40) NOT NULL,
  `routers_id` int(11) NOT NULL,
  `routers` varchar(32) NOT NULL,
  `price` varchar(40) NOT NULL,
  `pg_url_payment` varchar(512) NOT NULL DEFAULT '',
  `payment_method` varchar(32) NOT NULL DEFAULT '',
  `payment_channel` varchar(32) NOT NULL DEFAULT '',
  `pg_request` text DEFAULT NULL,
  `pg_paid_response` text DEFAULT NULL,
  `expired_date` datetime DEFAULT NULL,
  `created_date` datetime NOT NULL,
  `paid_date` datetime DEFAULT NULL,
  `trx_invoice` varchar(25) NOT NULL DEFAULT '' COMMENT 'from tbl_transactions',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1 unpaid 2 paid 3 failed 4 canceled',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_payment_gateway`
--

LOCK TABLES `tbl_payment_gateway` WRITE;
/*!40000 ALTER TABLE `tbl_payment_gateway` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_payment_gateway` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_plans`
--

DROP TABLE IF EXISTS `tbl_plans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_plans` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name_plan` varchar(40) NOT NULL,
  `id_bw` int(11) NOT NULL,
  `price` varchar(40) NOT NULL,
  `price_old` varchar(40) NOT NULL DEFAULT '',
  `type` enum('Hotspot','PPPOE','VPN','Balance') NOT NULL,
  `typebp` enum('Unlimited','Limited') DEFAULT NULL,
  `limit_type` enum('Time_Limit','Data_Limit','Both_Limit') DEFAULT NULL,
  `time_limit` int(10) unsigned DEFAULT NULL,
  `time_unit` enum('Mins','Hrs') DEFAULT NULL,
  `data_limit` int(10) unsigned DEFAULT NULL,
  `data_unit` enum('MB','GB') DEFAULT NULL,
  `validity` int(11) NOT NULL,
  `validity_unit` enum('Mins','Hrs','Days','Months','Period') NOT NULL,
  `shared_users` int(11) DEFAULT NULL,
  `routers` varchar(32) NOT NULL,
  `is_radius` tinyint(1) NOT NULL DEFAULT 0 COMMENT '1 is radius',
  `pool` varchar(40) DEFAULT NULL,
  `plan_expired` int(11) NOT NULL DEFAULT 0,
  `expired_date` tinyint(1) NOT NULL DEFAULT 20,
  `enabled` tinyint(1) NOT NULL DEFAULT 1 COMMENT '0 disabled\r\n',
  `allow_purchase` enum('yes','no') DEFAULT 'yes' COMMENT 'allow to show package in buy package page',
  `prepaid` enum('yes','no') DEFAULT 'yes' COMMENT 'is prepaid',
  `plan_type` enum('Business','Personal') DEFAULT 'Personal' COMMENT 'For selecting account type',
  `device` varchar(32) NOT NULL DEFAULT '',
  `on_login` text DEFAULT NULL,
  `on_logout` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_plans`
--

LOCK TABLES `tbl_plans` WRITE;
/*!40000 ALTER TABLE `tbl_plans` DISABLE KEYS */;
INSERT INTO `tbl_plans` VALUES
(1,'5Mbps',3,'500','','PPPOE','Unlimited','Time_Limit',0,'Hrs',0,'MB',30,'Days',NULL,'Shahed',0,'5Mbps',0,0,1,'yes','yes','Personal','MikrotikPppoe','',''),
(4,'10Mbps',4,'1000','','PPPOE','Unlimited','Time_Limit',0,'Hrs',0,'MB',30,'Days',NULL,'Shahed',0,'10Mbps',0,0,1,'yes','yes','Personal','MikrotikPppoe','',''),
(5,'600-Taka',8,'600','','PPPOE',NULL,NULL,NULL,NULL,NULL,NULL,1,'Months',NULL,'Shahed',0,'600-Taka',0,0,1,'yes','yes','Personal','MikrotikPppoe',NULL,NULL),
(6,'1000-Taka',9,'1000','','PPPOE',NULL,NULL,NULL,NULL,NULL,NULL,1,'Months',NULL,'Shahed',0,'1000-Taka',0,0,1,'yes','yes','Personal','MikrotikPppoe',NULL,NULL),
(7,'800-Taka',10,'800','','PPPOE',NULL,NULL,NULL,NULL,NULL,NULL,1,'Months',NULL,'Shahed',0,'800-Taka',0,0,1,'yes','yes','Personal','MikrotikPppoe',NULL,NULL);
/*!40000 ALTER TABLE `tbl_plans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_pool`
--

DROP TABLE IF EXISTS `tbl_pool`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_pool` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pool_name` varchar(40) NOT NULL,
  `local_ip` varchar(40) NOT NULL DEFAULT '',
  `range_ip` varchar(40) NOT NULL,
  `routers` varchar(40) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_pool`
--

LOCK TABLES `tbl_pool` WRITE;
/*!40000 ALTER TABLE `tbl_pool` DISABLE KEYS */;
INSERT INTO `tbl_pool` VALUES
(3,'5Mbps','192.168.24.1','192.168.24.2-192.168.25.254','Shahed'),
(4,'10Mbps','192.168.40.1','192.168.40.2-192.168.41.254','Shahed'),
(5,'600-Taka','192.168.60.1','192.168.60.2-192.168.61.254','Shahed'),
(6,'1000-Taka','192.168.70.1','192.168.70.2-192.168.71.254','Shahed'),
(7,'800-Taka','192.168.80.1','192.168.80.1-192.168.91.254','Shahed');
/*!40000 ALTER TABLE `tbl_pool` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_port_pool`
--

DROP TABLE IF EXISTS `tbl_port_pool`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_port_pool` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `public_ip` varchar(40) NOT NULL,
  `port_name` varchar(40) NOT NULL,
  `range_port` varchar(40) NOT NULL,
  `routers` varchar(40) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_port_pool`
--

LOCK TABLES `tbl_port_pool` WRITE;
/*!40000 ALTER TABLE `tbl_port_pool` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_port_pool` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_routers`
--

DROP TABLE IF EXISTS `tbl_routers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_routers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `ip_address` varchar(128) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(60) NOT NULL,
  `description` varchar(256) DEFAULT NULL,
  `coordinates` varchar(50) NOT NULL DEFAULT '',
  `status` enum('Online','Offline') DEFAULT 'Online',
  `last_seen` datetime DEFAULT NULL,
  `coverage` varchar(8) NOT NULL DEFAULT '0',
  `enabled` tinyint(1) NOT NULL DEFAULT 1 COMMENT '0 disabled',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_routers`
--

LOCK TABLES `tbl_routers` WRITE;
/*!40000 ALTER TABLE `tbl_routers` DISABLE KEYS */;
INSERT INTO `tbl_routers` VALUES
(1,'Shahed','103.109.96.168:2026','api','1sDpAwUe5c','','24.027146446855763, 90.38696797894177','Online','2026-04-08 23:59:03','0',1);
/*!40000 ALTER TABLE `tbl_routers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_transactions`
--

DROP TABLE IF EXISTS `tbl_transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_transactions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `invoice` varchar(25) NOT NULL,
  `username` varchar(32) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `plan_name` varchar(40) NOT NULL,
  `price` varchar(40) NOT NULL,
  `recharged_on` date NOT NULL,
  `recharged_time` time NOT NULL DEFAULT '00:00:00',
  `expiration` date NOT NULL,
  `time` time NOT NULL,
  `method` varchar(128) NOT NULL,
  `routers` varchar(32) NOT NULL,
  `type` enum('Hotspot','PPPOE','VPN','Balance') NOT NULL,
  `note` varchar(256) NOT NULL DEFAULT '' COMMENT 'for note',
  `admin_id` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=738 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_transactions`
--

LOCK TABLES `tbl_transactions` WRITE;
/*!40000 ALTER TABLE `tbl_transactions` DISABLE KEYS */;
INSERT INTO `tbl_transactions` VALUES
(615,'INV-1','office1',1208,'10Mbps','1000','2026-03-23','13:26:50','2026-04-22','13:26:50','Bkash - Administrator','Shahed','PPPOE','',1),
(616,'INV-616','office10',1111,'5Mbps','500','2026-03-23','16:58:18','2026-04-22','16:58:18','Bkash - Administrator','Shahed','PPPOE','',1),
(617,'INV-617','s106',742,'10Mbps','1000','2026-03-23','20:16:26','2026-04-22','20:16:26','Bulk Recharge - Administrator','1','PPPOE','',1),
(618,'INV-618','office10',1111,'5Mbps','500','2026-03-23','21:22:28','2026-05-22','16:58:18','Bkash - Md. Shahadur Rahman','Shahed','PPPOE','',2),
(619,'INV-619','s135',1213,'5Mbps','500','2026-03-24','21:46:10','2026-04-23','21:46:10','Bkash - Administrator','Shahed','PPPOE','',1),
(620,'INV-620','arian@01709541829',1214,'5Mbps','500','2026-03-26','14:00:26','2026-04-25','14:00:26','Bkash - Administrator','Shahed','PPPOE','',1),
(621,'INV-621','omit@0191635720',1215,'5Mbps','500','2026-03-27','19:55:14','2026-04-26','19:55:14','Bkash - Administrator','Shahed','PPPOE','',1),
(622,'INV-622','salam@01706589569',1216,'5Mbps','500','2026-03-28','19:32:18','2026-04-27','19:32:18','Bkash - Administrator','Shahed','PPPOE','',1),
(623,'INV-623','salam@01706589569',1216,'5Mbps','500','2026-03-28','20:16:11','2026-05-27','19:32:18','Bkash - Md. Shahadur Rahman','Shahed','PPPOE','',2),
(624,'INV-624','amir@01313496950',1217,'5Mbps','500','2026-03-29','11:17:36','2026-04-28','11:17:36','Bkash - Administrator','Shahed','PPPOE','',1),
(625,'INV-625','saikot@01915606414',1218,'5Mbps','500','2026-03-29','15:25:09','2026-04-28','15:25:09','Bkash - Administrator','Shahed','PPPOE','',1),
(626,'INV-626','sogram@01403968344',1219,'5Mbps','500','2026-03-29','19:54:18','2026-04-28','19:54:18','Bkash - Administrator','Shahed','PPPOE','',1),
(627,'INV-627','mokta@01402507488',1220,'5Mbps','500','2026-03-29','20:30:53','2026-04-28','20:30:53','Bkash - Administrator','Shahed','PPPOE','',1),
(628,'INV-628','mokta@01402507488',1220,'5Mbps','500','2026-03-29','20:31:01','2026-05-28','20:30:53','Bkash - Administrator','Shahed','PPPOE','',1),
(629,'INV-629','nahid@01712154553',1221,'5Mbps','500','2026-03-30','10:08:54','2026-04-29','10:08:54','Bkash - Administrator','Shahed','PPPOE','',1),
(630,'INV-630','gamaus@01701661619',1222,'10Mbps','1000','2026-03-30','10:11:54','2026-04-29','10:11:54','Bkash - Administrator','Shahed','PPPOE','',1),
(631,'INV-631','sanrise@01754146379',1223,'5Mbps','500','2026-03-30','11:49:55','2026-04-29','11:49:55','Bkash - Administrator','Shahed','PPPOE','',1),
(632,'INV-632','sanrise2@01754146379',1224,'10Mbps','1000','2026-03-30','12:04:10','2026-04-29','12:04:10','Bkash - Administrator','Shahed','PPPOE','',1),
(633,'INV-633','gp@01746439345',1225,'5Mbps','500','2026-03-30','12:13:19','2026-04-29','12:13:19','Bkash - Administrator','Shahed','PPPOE','',1),
(634,'INV-634','hannan@01754146379',1226,'10Mbps','1000','2026-03-30','12:14:44','2026-04-29','12:14:44','Bkash - Administrator','Shahed','PPPOE','',1),
(635,'INV-635','jannat@01343504263',1227,'5Mbps','500','2026-03-30','17:22:27','2026-04-29','17:22:27','Bkash - Administrator','Shahed','PPPOE','',1),
(636,'INV-636','jalal@01822501671',1228,'5Mbps','500','2026-03-31','10:51:38','2026-04-30','10:51:38','Bkash - Administrator','Shahed','PPPOE','',1),
(637,'INV-637','sujon@01406572876',1229,'600-Taka','600','2026-03-31','13:17:56','2026-05-01','13:17:56','Bkash - Administrator','Shahed','PPPOE','',1),
(638,'INV-638','ebrahim@01868451762',1230,'5Mbps','500','2026-03-31','13:19:11','2026-04-30','13:19:11','Bkash - Administrator','Shahed','PPPOE','',1),
(639,'INV-639','sayem@01923751394',1231,'5Mbps','500','2026-03-31','15:40:16','2026-04-30','15:40:16','Bkash - Administrator','Shahed','PPPOE','',1),
(640,'INV-640','maksu@01904745509',1232,'5Mbps','500','2026-03-31','15:41:06','2026-04-30','15:41:06','Bkash - Administrator','Shahed','PPPOE','',1),
(641,'INV-641','safat@01742252677',1233,'5Mbps','500','2026-03-31','19:00:09','2026-04-30','19:00:09','Bkash - Administrator','Shahed','PPPOE','',1),
(642,'INV-642','mona@01684310647',1234,'800-Taka','800','2026-03-31','20:44:57','2026-05-01','20:44:57','Bkash - Administrator','Shahed','PPPOE','',1),
(643,'INV-643','shihab@01307786743',1235,'5Mbps','500','2026-03-31','20:51:23','2026-04-30','20:51:23','Bkash - Administrator','Shahed','PPPOE','',1),
(644,'INV-644','zim@019116445800',1236,'5Mbps','500','2026-03-31','21:02:55','2026-04-30','21:02:55','Bkash - Administrator','Shahed','PPPOE','',1),
(645,'INV-645','sumon@01925442162',1237,'5Mbps','500','2026-03-31','22:35:52','2026-04-30','22:35:52','Bkash - Administrator','Shahed','PPPOE','',1),
(646,'INV-646','toffajol@01613561077',1238,'5Mbps','500','2026-03-31','22:37:11','2026-04-30','22:37:11','Bkash - Administrator','Shahed','PPPOE','',1),
(647,'INV-647','kajol@01916126486',1239,'5Mbps','500','2026-03-31','23:01:22','2026-04-30','23:01:22','Bkash - Administrator','Shahed','PPPOE','',1),
(648,'INV-648','tashfe@01331104238',1240,'5Mbps','500','2026-03-31','23:03:52','2026-04-30','23:03:52','Bkash - Administrator','Shahed','PPPOE','',1),
(649,'INV-649','shazahan@01941928232',1241,'5Mbps','500','2026-04-01','11:57:44','2026-05-01','11:57:44','Bkash - Administrator','Shahed','PPPOE','',1),
(650,'INV-650','amanullah@01402794705',1242,'5Mbps','500','2026-04-01','12:58:41','2026-05-01','12:58:41','Bkash - Administrator','Shahed','PPPOE','',1),
(651,'INV-651','alif@01400989371',1243,'5Mbps','500','2026-04-01','13:00:22','2026-05-01','13:00:22','Bkash - Administrator','Shahed','PPPOE','',1),
(652,'INV-652','sajid@01910775366',1244,'5Mbps','500','2026-04-01','13:22:42','2026-05-01','13:22:42','Bkash - Administrator','Shahed','PPPOE','',1),
(653,'INV-653','rohim@01935430703',1245,'5Mbps','500','2026-04-01','14:09:26','2026-05-01','14:09:26','Bkash - Administrator','Shahed','PPPOE','',1),
(654,'INV-654','sajid@01910775366',1244,'5Mbps','500','2026-04-01','15:13:22','2026-05-31','13:22:42','Bkash - Administrator','Shahed','PPPOE','',1),
(655,'INV-655','city@01923006824',1246,'1000-Taka','1000','2026-04-01','15:15:03','2026-05-01','15:15:03','Bkash - Administrator','Shahed','PPPOE','',1),
(656,'INV-656','city2@01923006824',1247,'5Mbps','500','2026-04-01','15:49:14','2026-05-01','15:49:14','Bkash - Administrator','Shahed','PPPOE','',1),
(657,'INV-657','ajahar@01938012062',1249,'5Mbps','500','2026-04-01','21:39:22','2026-05-01','21:39:22','Bkash - Administrator','Shahed','PPPOE','',1),
(658,'INV-658','subahan@01777694229',1250,'5Mbps','500','2026-04-01','21:41:13','2026-05-01','21:41:13','Bkash - Administrator','Shahed','PPPOE','',1),
(659,'INV-659','sohelrana@01964688616',1251,'5Mbps','500','2026-04-01','21:42:48','2026-05-01','21:42:48','Bkash - Administrator','Shahed','PPPOE','',1),
(660,'INV-660','rased@01605201112',1252,'600-Taka','600','2026-04-01','21:44:31','2026-05-01','21:44:31','Bkash - Administrator','Shahed','PPPOE','',1),
(661,'INV-661','aref@01930572254',1253,'5Mbps','500','2026-04-02','00:29:42','2026-05-02','00:29:42','Bkash - Administrator','Shahed','PPPOE','',1),
(662,'INV-662','mostafijur@01866949375',1254,'5Mbps','500','2026-04-02','00:31:46','2026-05-02','00:31:46','Bkash - Administrator','Shahed','PPPOE','',1),
(663,'INV-663','naim@01863626305',1255,'600-Taka','600','2026-04-02','00:32:40','2026-05-02','00:32:40','Bkash - Administrator','Shahed','PPPOE','',1),
(664,'INV-664','anjeo@01700775435',1256,'5Mbps','500','2026-04-02','12:03:18','2026-05-02','12:03:18','Bkash - Administrator','Shahed','PPPOE','',1),
(665,'INV-665','aminul@01908986887',1257,'5Mbps','500','2026-04-02','13:21:16','2026-05-02','13:21:16','Bkash - Administrator','Shahed','PPPOE','',1),
(666,'INV-666','roton@01938320825',1258,'5Mbps','500','2026-04-02','14:26:09','2026-05-02','14:26:09','Bkash - Administrator','Shahed','PPPOE','',1),
(667,'INV-667','ajaharul@01938012062',1259,'5Mbps','500','2026-04-02','14:33:24','2026-05-02','14:33:24','Bkash - Administrator','Shahed','PPPOE','',1),
(668,'INV-668','saju@01762204089',1260,'5Mbps','500','2026-04-02','17:49:09','2026-05-02','17:49:09','Bkash - Administrator','Shahed','PPPOE','',1),
(669,'INV-669','monir@01777421000',1261,'5Mbps','500','2026-04-02','18:54:01','2026-05-02','18:54:01','Bkash - Administrator','Shahed','PPPOE','',1),
(670,'INV-670','mahamud@01778880568',1262,'5Mbps','500','2026-04-02','18:55:34','2026-05-02','18:55:34','Bkash - Administrator','Shahed','PPPOE','',1),
(671,'INV-671','istiya@01989071851',1263,'5Mbps','500','2026-04-02','21:27:24','2026-05-02','21:27:24','Bkash - Administrator','Shahed','PPPOE','',1),
(672,'INV-672','fardul@01845218275',1264,'5Mbps','500','2026-04-02','21:29:25','2026-05-02','21:29:25','Bkash - Administrator','Shahed','PPPOE','',1),
(673,'INV-673','khadi@01605588462',1265,'5Mbps','500','2026-04-02','21:31:28','2026-05-02','21:31:28','Bkash - Administrator','Shahed','PPPOE','',1),
(674,'INV-674','foridul@01922272182',1266,'5Mbps','500','2026-04-02','21:33:35','2026-05-02','21:33:35','Bkash - Administrator','Shahed','PPPOE','',1),
(675,'INV-675','halim@01908806561',1267,'5Mbps','500','2026-04-02','21:41:28','2026-05-02','21:41:28','Bkash - Administrator','Shahed','PPPOE','',1),
(676,'INV-676','jaman@01923181402',1268,'5Mbps','500','2026-04-03','11:51:41','2026-05-03','11:51:41','Bkash - Administrator','Shahed','PPPOE','',1),
(677,'INV-677','sami@01712753012',1269,'5Mbps','500','2026-04-03','11:52:25','2026-05-03','11:52:25','Bkash - Administrator','Shahed','PPPOE','',1),
(678,'INV-678','shahad',1270,'5Mbps','500','2026-04-03','12:40:52','2026-05-03','12:40:52','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE','',2),
(679,'INV-679','shahad',1270,'5Mbps','500','2026-04-03','12:53:27','2026-06-02','12:40:52','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE','',2),
(680,'INV-680','rasel',1271,'5Mbps','500','2026-04-03','19:38:53','2026-05-03','19:38:53','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE','',2),
(681,'INV-681','omor@01933805356',1272,'5Mbps','500','2026-04-03','19:59:34','2026-05-03','19:59:34','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE','',2),
(682,'INV-682','azahar@01822106708',1273,'5Mbps','500','2026-04-03','20:56:41','2026-05-03','20:56:41','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE','',2),
(683,'INV-683','morseda@01743158805',1274,'5Mbps','500','2026-04-03','21:03:02','2026-05-03','21:03:02','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE','',2),
(684,'INV-684','shahan@01734240129',1275,'5Mbps','500','2026-04-03','21:12:48','2026-05-03','21:12:48','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE','',2),
(685,'INV-685','kalam@01727596671',1276,'5Mbps','500','2026-04-03','22:38:55','2026-05-03','22:38:55','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE','',2),
(686,'INV-686','somon@01988641269',1277,'5Mbps','500','2026-04-03','22:59:43','2026-05-03','22:59:43','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE','',2),
(687,'INV-687','manik@01996202594',1278,'5Mbps','500','2026-04-04','19:22:39','2026-05-04','19:22:39','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE','',2),
(688,'INV-688','shakibul@01908322525',1279,'5Mbps','500','2026-04-04','20:52:23','2026-05-04','20:52:23','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE','',2),
(689,'INV-689','shakibul@01908322525',1279,'5Mbps','500','2026-04-04','21:40:34','2026-06-03','20:52:23','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE','',2),
(690,'INV-690','rafi@01745962511',1280,'5Mbps','500','2026-04-04','22:07:39','2026-05-04','22:07:39','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE','',2),
(691,'INV-691','rafi@01745962511',1280,'600-Taka','600','2026-04-04','22:18:37','2026-05-04','22:18:37','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE','',2),
(692,'INV-692','babu@01979676411',1281,'5Mbps','500','2026-04-04','22:44:16','2026-05-04','22:44:16','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE','',2),
(693,'INV-693','forhad@01962009387',1282,'5Mbps','500','2026-04-04','22:56:56','2026-05-04','22:56:56','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE','',2),
(694,'INV-694','mosarof',1283,'5Mbps','500','2026-04-05','00:15:36','2026-05-05','00:15:36','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE','',2),
(695,'INV-695','01711084193',1284,'5Mbps','500','2026-04-05','00:58:28','2026-05-05','00:58:28','Bkash - Administrator','Shahed','PPPOE','',1),
(696,'INV-696','raju@01964553482',1285,'5Mbps','500','2026-04-05','13:29:45','2026-05-05','13:29:45','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE','',2),
(697,'INV-697','ontos@01927954635',1286,'5Mbps','500','2026-04-05','14:17:53','2026-05-05','14:17:53','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE','',2),
(698,'INV-698','gias@01713536437',1287,'5Mbps','500','2026-04-05','14:40:59','2026-05-05','14:40:59','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE','',2),
(699,'INV-699','rakib@01884545433',1288,'5Mbps','500','2026-04-05','14:53:07','2026-05-05','14:53:07','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE','',2),
(700,'INV-700','rofiqul@01938319366',1289,'5Mbps','500','2026-04-05','19:13:07','2026-05-05','19:13:07','Bkash - Administrator','Shahed','PPPOE','',1),
(701,'INV-701','mafuj@01731017096',1290,'600-Taka','600','2026-04-05','19:54:05','2026-05-05','19:54:05','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE','',2),
(702,'INV-702','shaurov@01981504856',1291,'5Mbps','500','2026-04-05','20:50:22','2026-05-05','20:50:22','Bkash - Administrator','Shahed','PPPOE','',1),
(703,'INV-703','sohag@01914135791',1292,'5Mbps','500','2026-04-05','21:01:36','2026-05-05','21:01:36','Bkash - Administrator','Shahed','PPPOE','',1),
(704,'INV-704','sohag@01914135791',1292,'600-Taka','600','2026-04-05','21:04:53','2026-05-05','21:04:53','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE','',2),
(705,'INV-705','bokkor@01619461811',1293,'5Mbps','500','2026-04-05','22:00:04','2026-05-05','22:00:04','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE','',2),
(706,'INV-706','riknit@01920995062',1294,'5Mbps','500','2026-04-06','12:40:43','2026-05-06','12:40:43','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE','',2),
(707,'INV-707','shahin@01968841153',1295,'5Mbps','500','2026-04-06','12:43:01','2026-05-06','12:43:01','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE','',2),
(708,'INV-708','insurance@01716956699',1296,'1000-Taka','1000','2026-04-06','13:09:12','2026-05-06','13:09:12','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE','',2),
(709,'INV-709','rana@01988728032',1297,'5Mbps','500','2026-04-06','14:30:45','2026-05-06','14:30:45','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE','',2),
(710,'INV-710','shahin@01736762103',1298,'10Mbps','1000','2026-04-06','17:49:24','2026-05-06','17:49:24','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE','',2),
(711,'INV-711','flaxiload@01912208878',1299,'5Mbps','500','2026-04-06','19:25:08','2026-05-06','19:25:08','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE','',2),
(712,'INV-712','ansir@01911121210',1300,'5Mbps','500','2026-04-06','20:03:03','2026-05-06','20:03:03','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE','',2),
(713,'INV-713','sabbir@01718773949',1301,'5Mbps','500','2026-04-06','20:51:09','2026-05-06','20:51:09','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE','',2),
(714,'INV-714','sabbir@01718773949',1301,'5Mbps','500','2026-04-06','21:07:49','2026-06-05','20:51:09','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE','',2),
(715,'INV-715','sabbir@01718773949',1302,'5Mbps','500','2026-04-06','21:13:27','2026-05-06','21:13:27','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE','',2),
(716,'INV-716','sujoy@01751512439',1303,'5Mbps','500','2026-04-07','12:32:54','2026-05-07','12:32:54','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE','',2),
(717,'INV-717','rayhan@01998628952',1304,'5Mbps','500','2026-04-07','13:31:26','2026-05-07','13:31:26','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE','',2),
(718,'INV-718','mostafiz@01706589569',1305,'5Mbps','500','2026-04-07','14:12:40','2026-05-07','14:12:40','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE','',2),
(719,'INV-719','aref@01735511111',1306,'5Mbps','500','2026-04-07','18:50:54','2026-05-07','18:50:54','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE','',2),
(720,'INV-720','delowar@01783636616',1307,'5Mbps','500','2026-04-07','19:26:53','2026-05-07','19:26:53','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE','',2),
(721,'INV-721','joyel@01797307872',1308,'5Mbps','500','2026-04-08','02:41:07','2026-05-08','02:41:07','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE','',2),
(722,'INV-722','ibrahim@01959663908',1309,'5Mbps','500','2026-04-08','11:59:26','2026-05-08','11:59:26','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE','',2),
(723,'INV-723','masud@01845759852',1310,'5Mbps','500','2026-04-08','12:34:42','2026-05-08','12:34:42','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE','',2),
(724,'INV-724','amarot@01753659302',1311,'5Mbps','500','2026-04-08','13:37:42','2026-05-08','13:37:42','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE','',2),
(725,'INV-725','yeasin@01923441444',1312,'5Mbps','500','2026-04-08','13:55:40','2026-05-08','13:55:40','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE','',2),
(726,'INV-726','jakiya@01980510418',1313,'5Mbps','500','2026-04-08','14:09:35','2026-05-08','14:09:35','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE','',2),
(727,'INV-727','noyon@01963021891',1314,'5Mbps','500','2026-04-08','18:58:48','2026-05-08','18:58:48','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE','',2),
(728,'INV-728','imran@01773721112',1315,'5Mbps','500','2026-04-08','19:12:57','2026-05-08','19:12:57','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE','',2),
(729,'INV-729','somon@01932230511',1316,'5Mbps','500','2026-04-08','19:28:06','2026-05-08','19:28:06','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE','',2),
(730,'INV-730','alamin@01404571513',1317,'5Mbps','500','2026-04-08','20:18:52','2026-05-08','20:18:52','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE','',2),
(731,'INV-731','israt@01941832957',1318,'5Mbps','500','2026-04-08','20:34:38','2026-05-08','20:34:38','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE','',2),
(732,'INV-732','janmia@01738668933',1319,'600-Taka','600','2026-04-08','20:45:46','2026-05-08','20:45:46','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE','',2),
(733,'INV-733','firoj@01892365222',1320,'5Mbps','500','2026-04-08','20:50:30','2026-05-08','20:50:30','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE','',2),
(734,'INV-734','rakib@01873345718',1321,'10Mbps','1000','2026-04-08','21:02:41','2026-05-08','21:02:41','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE','',2),
(735,'INV-735','saddam@01404532100',1322,'5Mbps','500','2026-04-08','21:59:12','2026-05-08','21:59:12','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE','',2),
(736,'INV-736','imran@01773721112',1315,'5Mbps','500','2026-04-08','22:54:34','2026-06-07','19:12:57','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE','',2),
(737,'INV-737','rayan@01302942761',1323,'600-Taka','600','2026-04-08','22:58:50','2026-05-08','22:58:50','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE','',2);
/*!40000 ALTER TABLE `tbl_transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_user_recharges`
--

DROP TABLE IF EXISTS `tbl_user_recharges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_user_recharges` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) NOT NULL,
  `username` varchar(32) NOT NULL,
  `plan_id` int(11) NOT NULL,
  `namebp` varchar(40) NOT NULL,
  `recharged_on` date NOT NULL,
  `recharged_time` time NOT NULL DEFAULT '00:00:00',
  `expiration` date NOT NULL,
  `time` time NOT NULL,
  `status` varchar(20) NOT NULL,
  `method` varchar(128) NOT NULL DEFAULT '',
  `routers` varchar(32) NOT NULL,
  `type` varchar(15) NOT NULL,
  `admin_id` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=724 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_user_recharges`
--

LOCK TABLES `tbl_user_recharges` WRITE;
/*!40000 ALTER TABLE `tbl_user_recharges` DISABLE KEYS */;
INSERT INTO `tbl_user_recharges` VALUES
(610,1208,'office1',4,'10Mbps','2026-03-23','13:26:50','2026-04-22','17:38:20','on','Bkash - Administrator','Shahed','PPPOE',1),
(611,1111,'office10',1,'5Mbps','2026-03-23','21:22:28','2026-05-22','16:58:18','on','Bkash - Md. Shahadur Rahman','Shahed','PPPOE',2),
(612,742,'s106',4,'10Mbps','2026-03-23','20:16:26','2026-04-22','20:16:26','on','Bulk Recharge - Administrator','1','PPPOE',1),
(613,1213,'s135',1,'5Mbps','2026-03-24','21:46:10','2026-04-23','21:46:10','on','Bkash - Administrator','Shahed','PPPOE',1),
(614,1214,'arian@01709541829',1,'5Mbps','2026-03-26','14:00:26','2026-04-25','14:00:26','on','Bkash - Administrator','Shahed','PPPOE',1),
(615,1215,'omit@0191635720',1,'5Mbps','2026-03-27','19:55:14','2026-04-26','19:55:14','on','Bkash - Administrator','Shahed','PPPOE',1),
(616,1216,'salam@01706589569',1,'5Mbps','2026-03-28','20:16:11','2026-05-27','19:32:18','on','Bkash - Md. Shahadur Rahman','Shahed','PPPOE',2),
(617,1217,'amir@01313496950',1,'5Mbps','2026-03-29','11:17:36','2026-04-28','11:17:36','on','Bkash - Administrator','Shahed','PPPOE',1),
(618,1218,'saikot@01915606414',1,'5Mbps','2026-03-29','15:25:09','2026-04-28','15:25:09','on','Bkash - Administrator','Shahed','PPPOE',1),
(619,1219,'sogram@01403968344',1,'5Mbps','2026-03-29','19:54:18','2026-04-28','19:54:18','on','Bkash - Administrator','Shahed','PPPOE',1),
(620,1220,'mokta@01402507488',1,'5Mbps','2026-03-29','20:31:01','2026-05-28','20:30:53','on','Bkash - Administrator','Shahed','PPPOE',1),
(621,1221,'nahid@01712154553',1,'5Mbps','2026-03-30','10:08:54','2026-04-29','10:08:54','on','Bkash - Administrator','Shahed','PPPOE',1),
(622,1222,'gamaus@01701661619',4,'10Mbps','2026-03-30','10:11:54','2026-04-29','10:11:54','on','Bkash - Administrator','Shahed','PPPOE',1),
(623,1223,'sanrise@01754146379',1,'5Mbps','2026-03-30','11:49:55','2026-04-29','11:49:55','on','Bkash - Administrator','Shahed','PPPOE',1),
(624,1224,'sanrise2@01754146379',4,'10Mbps','2026-03-30','12:04:10','2026-04-29','12:04:10','on','Bkash - Administrator','Shahed','PPPOE',1),
(625,1225,'gp@01746439345',1,'5Mbps','2026-03-30','12:13:19','2026-04-29','12:13:19','on','Bkash - Administrator','Shahed','PPPOE',1),
(626,1226,'hannan@01754146379',4,'10Mbps','2026-03-30','12:14:44','2026-04-29','12:14:44','on','Bkash - Administrator','Shahed','PPPOE',1),
(627,1227,'jannat@01343504263',1,'5Mbps','2026-03-30','17:22:27','2026-04-29','17:22:27','on','Bkash - Administrator','Shahed','PPPOE',1),
(628,1228,'jalal@01822501671',1,'5Mbps','2026-03-31','10:51:38','2026-04-30','10:51:38','on','Bkash - Administrator','Shahed','PPPOE',1),
(629,1229,'sujon@01406572876',5,'600-Taka','2026-03-31','13:17:56','2026-05-01','13:17:56','on','Bkash - Administrator','Shahed','PPPOE',1),
(630,1230,'ebrahim@01868451762',1,'5Mbps','2026-03-31','13:19:11','2026-04-30','13:19:11','on','Bkash - Administrator','Shahed','PPPOE',1),
(631,1231,'sayem@01923751394',1,'5Mbps','2026-03-31','15:40:16','2026-04-30','15:40:16','on','Bkash - Administrator','Shahed','PPPOE',1),
(632,1232,'maksu@01904745509',1,'5Mbps','2026-03-31','15:41:06','2026-04-30','15:41:06','on','Bkash - Administrator','Shahed','PPPOE',1),
(633,1233,'safat@01742252677',1,'5Mbps','2026-03-31','19:00:09','2026-04-30','19:00:09','on','Bkash - Administrator','Shahed','PPPOE',1),
(634,1234,'mona@01684310647',7,'800-Taka','2026-03-31','20:44:57','2026-05-01','20:44:57','on','Bkash - Administrator','Shahed','PPPOE',1),
(635,1235,'shihab@01307786743',1,'5Mbps','2026-03-31','20:51:23','2026-04-30','20:51:23','on','Bkash - Administrator','Shahed','PPPOE',1),
(636,1236,'zim@01911644580',1,'5Mbps','2026-03-31','21:02:55','2026-04-30','21:02:55','on','Bkash - Administrator','Shahed','PPPOE',1),
(637,1237,'sumon@01925442162',1,'5Mbps','2026-03-31','22:35:52','2026-04-30','22:35:52','on','Bkash - Administrator','Shahed','PPPOE',1),
(638,1238,'toffajol@01613561077',1,'5Mbps','2026-03-31','22:37:11','2026-04-30','22:37:11','on','Bkash - Administrator','Shahed','PPPOE',1),
(639,1239,'kajol@01916126486',1,'5Mbps','2026-03-31','23:01:22','2026-04-30','23:01:22','on','Bkash - Administrator','Shahed','PPPOE',1),
(640,1240,'tashfe@01331104238',1,'5Mbps','2026-03-31','23:03:52','2026-04-30','23:03:52','on','Bkash - Administrator','Shahed','PPPOE',1),
(641,1241,'shazahan@01941928232',1,'5Mbps','2026-04-01','11:57:44','2026-05-01','11:57:44','on','Bkash - Administrator','Shahed','PPPOE',1),
(642,1242,'amanullah@01402794705',1,'5Mbps','2026-04-01','12:58:41','2026-05-01','12:58:41','on','Bkash - Administrator','Shahed','PPPOE',1),
(643,1243,'alif@01400989371',1,'5Mbps','2026-04-01','13:00:22','2026-05-01','13:00:22','on','Bkash - Administrator','Shahed','PPPOE',1),
(644,1244,'sajid@01910775366',1,'5Mbps','2026-04-01','15:13:22','2026-05-31','13:22:42','on','Bkash - Administrator','Shahed','PPPOE',1),
(645,1245,'rohim@01935430703',1,'5Mbps','2026-04-01','14:09:26','2026-05-01','14:09:26','on','Bkash - Administrator','Shahed','PPPOE',1),
(646,1246,'city@01923006824',6,'1000-Taka','2026-04-01','15:15:03','2026-05-01','15:15:03','on','Bkash - Administrator','Shahed','PPPOE',1),
(647,1247,'city2@01923006824',1,'5Mbps','2026-04-01','15:49:14','2026-05-01','15:49:14','on','Bkash - Administrator','Shahed','PPPOE',1),
(648,1249,'ajahar@01938012062',1,'5Mbps','2026-04-01','21:39:22','2026-05-01','21:39:22','on','Bkash - Administrator','Shahed','PPPOE',1),
(649,1250,'subahan@01777694229',1,'5Mbps','2026-04-01','21:41:13','2026-05-01','21:41:13','on','Bkash - Administrator','Shahed','PPPOE',1),
(650,1251,'sohelrana@01964688616',1,'5Mbps','2026-04-01','21:42:48','2026-05-01','21:42:48','on','Bkash - Administrator','Shahed','PPPOE',1),
(651,1252,'rased@01605201112',5,'600-Taka','2026-04-01','21:44:31','2026-05-01','21:44:31','on','Bkash - Administrator','Shahed','PPPOE',1),
(652,1253,'aref@01930572254',1,'5Mbps','2026-04-02','00:29:42','2026-05-02','00:29:42','on','Bkash - Administrator','Shahed','PPPOE',1),
(653,1254,'mostafijur@01866949375',1,'5Mbps','2026-04-02','00:31:46','2026-05-02','00:31:46','on','Bkash - Administrator','Shahed','PPPOE',1),
(654,1255,'naim@01863626305',5,'600-Taka','2026-04-02','00:32:40','2026-05-02','00:32:40','on','Bkash - Administrator','Shahed','PPPOE',1),
(655,1256,'anjeo@01700775435',1,'5Mbps','2026-04-02','12:03:18','2026-05-02','12:03:18','on','Bkash - Administrator','Shahed','PPPOE',1),
(656,1257,'aminul@01908986887',1,'5Mbps','2026-04-02','13:21:16','2026-05-02','13:21:16','on','Bkash - Administrator','Shahed','PPPOE',1),
(657,1258,'roton@01938320825',1,'5Mbps','2026-04-02','14:26:09','2026-05-02','14:26:09','on','Bkash - Administrator','Shahed','PPPOE',1),
(658,1259,'ajaharul@01938012062',1,'5Mbps','2026-04-02','14:33:24','2026-05-02','14:33:24','on','Bkash - Administrator','Shahed','PPPOE',1),
(659,1260,'saju@01762204089',1,'5Mbps','2026-04-02','17:49:09','2026-05-02','17:49:09','on','Bkash - Administrator','Shahed','PPPOE',1),
(660,1261,'monir@01777421000',1,'5Mbps','2026-04-02','18:54:01','2026-05-02','18:54:01','on','Bkash - Administrator','Shahed','PPPOE',1),
(661,1262,'mahamud@01778880568',1,'5Mbps','2026-04-02','18:55:34','2026-05-02','18:55:34','on','Bkash - Administrator','Shahed','PPPOE',1),
(662,1263,'istiya@01989071851',1,'5Mbps','2026-04-02','21:27:24','2026-05-02','21:27:24','on','Bkash - Administrator','Shahed','PPPOE',1),
(663,1264,'fardul@01845218275',1,'5Mbps','2026-04-02','21:29:25','2026-05-02','21:29:25','on','Bkash - Administrator','Shahed','PPPOE',1),
(664,1265,'khadi@01605588462',1,'5Mbps','2026-04-02','21:31:28','2026-05-02','21:31:28','on','Bkash - Administrator','Shahed','PPPOE',1),
(665,1266,'foridul@01922272182',1,'5Mbps','2026-04-02','21:33:35','2026-05-02','21:33:35','on','Bkash - Administrator','Shahed','PPPOE',1),
(666,1267,'halim@01908806561',1,'5Mbps','2026-04-02','21:41:28','2026-05-02','21:41:28','on','Bkash - Administrator','Shahed','PPPOE',1),
(667,1268,'jaman@01923181402',1,'5Mbps','2026-04-03','11:51:41','2026-05-03','11:51:41','on','Bkash - Administrator','Shahed','PPPOE',1),
(668,1269,'sami@01712753012',1,'5Mbps','2026-04-03','11:52:25','2026-05-03','11:52:25','on','Bkash - Administrator','Shahed','PPPOE',1),
(669,1270,'shahad',1,'5Mbps','2026-04-03','12:53:27','2026-06-02','12:40:52','on','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE',2),
(670,1271,'rasel',1,'5Mbps','2026-04-03','19:38:53','2026-05-03','19:38:53','on','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE',2),
(671,1272,'omor@01933805356',1,'5Mbps','2026-04-03','19:59:34','2026-05-03','19:59:34','on','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE',2),
(672,1273,'azahar@01822106708',1,'5Mbps','2026-04-03','20:56:41','2026-05-03','20:56:41','on','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE',2),
(673,1274,'morseda@01743158805',1,'5Mbps','2026-04-03','21:03:02','2026-05-03','21:03:02','on','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE',2),
(674,1275,'shahan@01734240129',1,'5Mbps','2026-04-03','21:12:48','2026-05-03','21:12:48','on','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE',2),
(675,1276,'kalam@01727596671',1,'5Mbps','2026-04-03','22:38:55','2026-05-03','22:38:55','on','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE',2),
(676,1277,'somon@01988641269',1,'5Mbps','2026-04-03','22:59:43','2026-05-03','22:59:43','on','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE',2),
(677,1278,'manik@01996202594',1,'5Mbps','2026-04-04','19:22:39','2026-05-04','19:22:39','on','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE',2),
(678,1279,'shakibul@01908322525',1,'5Mbps','2026-04-04','21:40:34','2026-06-03','20:52:23','on','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE',2),
(679,1280,'rafi@01745962511',5,'600-Taka','2026-04-04','22:18:37','2026-05-04','22:18:37','on','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE',2),
(680,1281,'babu@01979676411',1,'5Mbps','2026-04-04','22:44:16','2026-05-04','22:44:16','on','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE',2),
(681,1282,'forhad@01962009387',1,'5Mbps','2026-04-04','22:56:56','2026-05-04','22:56:56','on','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE',2),
(682,1283,'mosarof',1,'5Mbps','2026-04-05','00:15:36','2026-05-05','00:15:36','on','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE',2),
(683,1284,'01711084193',1,'5Mbps','2026-04-05','00:58:28','2026-05-05','00:58:28','on','Bkash - Administrator','Shahed','PPPOE',1),
(684,1285,'raju@01964553482',1,'5Mbps','2026-04-05','13:29:45','2026-05-05','13:29:45','on','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE',2),
(685,1286,'ontos@01927954635',1,'5Mbps','2026-04-05','14:17:53','2026-05-05','14:17:53','on','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE',2),
(686,1287,'gias@01713536437',1,'5Mbps','2026-04-05','14:40:59','2026-05-05','14:40:59','on','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE',2),
(687,1288,'rakib@01884545433',1,'5Mbps','2026-04-05','14:53:07','2026-05-05','14:53:07','on','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE',2),
(688,1289,'rofiqul@01938319366',1,'5Mbps','2026-04-05','19:13:07','2026-05-05','19:13:07','on','Bkash - Administrator','Shahed','PPPOE',1),
(689,1290,'mafuj@01731017096',5,'600-Taka','2026-04-05','19:54:05','2026-05-05','19:54:05','on','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE',2),
(690,1291,'shaurov@01981504856',1,'5Mbps','2026-04-05','20:50:22','2026-05-05','20:50:22','on','Bkash - Administrator','Shahed','PPPOE',1),
(691,1292,'sohag@01914135791',1,'5Mbps','2026-04-05','21:01:36','2026-05-05','21:01:36','on','Bkash - Administrator','Shahed','PPPOE',1),
(692,1292,'sohag@01914135791',5,'600-Taka','2026-04-05','21:04:53','2026-05-05','21:04:53','on','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE',2),
(693,1293,'bokkor@01619461811',1,'5Mbps','2026-04-05','22:00:04','2026-05-05','22:00:04','on','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE',2),
(694,1294,'riknit@01920995062',1,'5Mbps','2026-04-06','12:40:43','2026-05-06','12:40:43','on','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE',2),
(695,1295,'shahin@01968841153',1,'5Mbps','2026-04-06','12:43:01','2026-05-06','12:43:01','on','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE',2),
(696,1296,'insurance@01716956699',6,'1000-Taka','2026-04-06','13:09:12','2026-05-06','13:09:12','on','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE',2),
(697,1297,'rana@01988728032',1,'5Mbps','2026-04-06','14:30:45','2026-05-06','14:30:45','on','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE',2),
(698,1298,'shahin@01736762103',4,'10Mbps','2026-04-06','17:49:24','2026-05-06','17:49:24','on','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE',2),
(699,1299,'flaxiload@01912208878',1,'5Mbps','2026-04-06','19:25:08','2026-05-06','19:25:08','on','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE',2),
(700,1300,'ansir@01911121210',1,'5Mbps','2026-04-06','20:03:03','2026-05-06','20:03:03','on','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE',2),
(702,1302,'sabbir@01718773949',1,'5Mbps','2026-04-06','21:13:27','2026-05-06','21:13:27','on','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE',2),
(703,1303,'sujoy@01751512439',1,'5Mbps','2026-04-07','12:32:54','2026-05-07','12:32:54','on','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE',2),
(704,1304,'rayhan@01998628952',1,'5Mbps','2026-04-07','13:31:26','2026-05-07','13:31:26','on','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE',2),
(705,1305,'mostafiz@01706589569',1,'5Mbps','2026-04-07','14:12:40','2026-05-07','14:12:40','on','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE',2),
(706,1306,'aref@01735511111',1,'5Mbps','2026-04-07','18:50:54','2026-05-07','18:50:54','on','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE',2),
(707,1307,'delowar@01783636616',1,'5Mbps','2026-04-07','19:26:53','2026-05-07','19:26:53','on','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE',2),
(708,1308,'joyel@01797307872',1,'5Mbps','2026-04-08','02:41:07','2026-05-08','02:41:07','on','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE',2),
(709,1309,'ibrahim@01959663908',1,'5Mbps','2026-04-08','11:59:26','2026-05-08','11:59:26','on','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE',2),
(710,1310,'masud@01845759852',1,'5Mbps','2026-04-08','12:34:42','2026-05-08','12:34:42','on','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE',2),
(711,1311,'amarot@01753659302',1,'5Mbps','2026-04-08','13:37:42','2026-05-08','13:37:42','on','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE',2),
(712,1312,'yeasin@01923441444',1,'5Mbps','2026-04-08','13:55:40','2026-05-08','13:55:40','on','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE',2),
(713,1313,'jakiya@01980510418',1,'5Mbps','2026-04-08','14:09:35','2026-05-08','14:09:35','on','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE',2),
(714,1314,'noyon@01963021891',1,'5Mbps','2026-04-08','18:58:48','2026-05-08','18:58:48','on','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE',2),
(715,1315,'imran@01773721112',1,'5Mbps','2026-04-08','22:54:34','2026-06-07','19:12:57','on','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE',2),
(716,1316,'somon@01932230511',1,'5Mbps','2026-04-08','19:28:06','2026-05-08','19:28:06','on','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE',2),
(717,1317,'alamin@01404571513',1,'5Mbps','2026-04-08','20:18:52','2026-05-08','20:18:52','on','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE',2),
(718,1318,'israt@01941832957',1,'5Mbps','2026-04-08','20:34:38','2026-05-08','20:34:38','on','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE',2),
(719,1319,'janmia@01738668933',5,'600-Taka','2026-04-08','20:45:46','2026-05-08','20:45:46','on','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE',2),
(720,1320,'firoj@01892365222',1,'5Mbps','2026-04-08','20:50:30','2026-05-08','20:50:30','on','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE',2),
(721,1321,'rakib@01873345718',4,'10Mbps','2026-04-08','21:02:41','2026-05-08','21:02:41','on','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE',2),
(722,1322,'saddam@01404532100',1,'5Mbps','2026-04-08','21:59:12','2026-05-08','21:59:12','on','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE',2),
(723,1323,'rayan@01302942761',5,'600-Taka','2026-04-08','22:58:50','2026-05-08','22:58:50','on','Bulk Recharge - Md. Shahadur Rahman','1','PPPOE',2);
/*!40000 ALTER TABLE `tbl_user_recharges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_users`
--

DROP TABLE IF EXISTS `tbl_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `root` int(11) NOT NULL DEFAULT 0 COMMENT 'for sub account',
  `photo` varchar(128) NOT NULL DEFAULT '/admin.default.png',
  `username` varchar(45) NOT NULL DEFAULT '',
  `fullname` varchar(45) NOT NULL DEFAULT '',
  `password` varchar(64) NOT NULL,
  `phone` varchar(32) NOT NULL DEFAULT '',
  `email` varchar(128) NOT NULL DEFAULT '',
  `city` varchar(64) NOT NULL DEFAULT '' COMMENT 'kota',
  `subdistrict` varchar(64) NOT NULL DEFAULT '' COMMENT 'kecamatan',
  `ward` varchar(64) NOT NULL DEFAULT '' COMMENT 'kelurahan',
  `user_type` enum('SuperAdmin','Admin','Report','Agent','Sales') NOT NULL,
  `status` enum('Active','Inactive') NOT NULL DEFAULT 'Active',
  `data` text DEFAULT NULL COMMENT 'to put additional data',
  `last_login` datetime DEFAULT NULL,
  `login_token` varchar(40) DEFAULT NULL,
  `creationdate` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_users`
--

LOCK TABLES `tbl_users` WRITE;
/*!40000 ALTER TABLE `tbl_users` DISABLE KEYS */;
INSERT INTO `tbl_users` VALUES
(1,0,'/admin.default.png','admin','Administrator','e7092c4051ee492cfc09fd2f5e0e4248f3cb91a4','','','','','','SuperAdmin','Active',NULL,'2026-04-04 20:56:53','a4b69d2e1f446184705317baafaf799a1764846d','2014-06-23 01:43:07'),
(2,0,'/admin.default.png','shahad','Md. Shahadur Rahman','bfe54caa6d483cc3887dce9d1b8eb91408f1ea7a','01911908800','shahadsalna@gmail.com','Gazipur','Gazipur','19','Admin','Active',NULL,'2026-04-03 12:31:29','0de0906cc34823db8c260cf535a2ea2d17335828','2026-03-22 21:21:19');
/*!40000 ALTER TABLE `tbl_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_voucher`
--

DROP TABLE IF EXISTS `tbl_voucher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_voucher` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` enum('Hotspot','PPPOE') NOT NULL,
  `routers` varchar(32) NOT NULL,
  `id_plan` int(11) NOT NULL,
  `code` varchar(55) NOT NULL,
  `user` varchar(45) NOT NULL,
  `status` varchar(25) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `used_date` datetime DEFAULT NULL,
  `generated_by` int(11) NOT NULL DEFAULT 0 COMMENT 'id admin',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_voucher`
--

LOCK TABLES `tbl_voucher` WRITE;
/*!40000 ALTER TABLE `tbl_voucher` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_voucher` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_widgets`
--

DROP TABLE IF EXISTS `tbl_widgets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_widgets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `orders` int(11) NOT NULL DEFAULT 99,
  `position` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1. top 2. left 3. right 4. bottom',
  `user` enum('Admin','Agent','Sales','Customer') NOT NULL DEFAULT 'Admin',
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `title` varchar(64) NOT NULL,
  `widget` varchar(64) NOT NULL DEFAULT '',
  `content` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_widgets`
--

LOCK TABLES `tbl_widgets` WRITE;
/*!40000 ALTER TABLE `tbl_widgets` DISABLE KEYS */;
INSERT INTO `tbl_widgets` VALUES
(1,1,1,'Admin',1,'Top Widget','top_widget',''),
(2,2,1,'Admin',1,'Default Info','default_info_row',''),
(3,1,2,'Admin',1,'Graph Monthly Registered Customers','graph_monthly_registered_customers',''),
(4,2,2,'Admin',1,'Graph Monthly Sales','graph_monthly_sales',''),
(5,3,2,'Admin',1,'Voucher Stocks','voucher_stocks',''),
(6,4,2,'Admin',1,'Customer Expired','customer_expired',''),
(7,1,3,'Admin',1,'Cron Monitor','cron_monitor',''),
(8,2,3,'Admin',1,'Mikrotik Cron Monitor','mikrotik_cron_monitor',''),
(9,3,3,'Admin',1,'Info Payment Gateway','info_payment_gateway',''),
(10,4,3,'Admin',1,'Graph Customers Insight','graph_customers_insight',''),
(11,5,3,'Admin',1,'Activity Log','activity_log',''),
(30,1,1,'Agent',1,'Top Widget','top_widget',''),
(31,2,1,'Agent',1,'Default Info','default_info_row',''),
(32,1,2,'Agent',1,'Graph Monthly Registered Customers','graph_monthly_registered_customers',''),
(33,2,2,'Agent',1,'Graph Monthly Sales','graph_monthly_sales',''),
(34,3,2,'Agent',1,'Voucher Stocks','voucher_stocks',''),
(35,4,2,'Agent',1,'Customer Expired','customer_expired',''),
(36,1,3,'Agent',1,'Cron Monitor','cron_monitor',''),
(37,2,3,'Agent',1,'Mikrotik Cron Monitor','mikrotik_cron_monitor',''),
(38,3,3,'Agent',1,'Info Payment Gateway','info_payment_gateway',''),
(39,4,3,'Agent',1,'Graph Customers Insight','graph_customers_insight',''),
(40,5,3,'Agent',1,'Activity Log','activity_log',''),
(41,1,1,'Sales',1,'Top Widget','top_widget',''),
(42,2,1,'Sales',1,'Default Info','default_info_row',''),
(43,1,2,'Sales',1,'Graph Monthly Registered Customers','graph_monthly_registered_customers',''),
(44,2,2,'Sales',1,'Graph Monthly Sales','graph_monthly_sales',''),
(45,3,2,'Sales',1,'Voucher Stocks','voucher_stocks',''),
(46,4,2,'Sales',1,'Customer Expired','customer_expired',''),
(47,1,3,'Sales',1,'Cron Monitor','cron_monitor',''),
(48,2,3,'Sales',1,'Mikrotik Cron Monitor','mikrotik_cron_monitor',''),
(49,3,3,'Sales',1,'Info Payment Gateway','info_payment_gateway',''),
(50,4,3,'Sales',1,'Graph Customers Insight','graph_customers_insight',''),
(51,5,3,'Sales',1,'Activity Log','activity_log',''),
(60,1,2,'Customer',1,'Account Info','account_info',''),
(61,3,1,'Customer',1,'Active Internet Plan','active_internet_plan',''),
(62,4,1,'Customer',1,'Balance Transfer','balance_transfer',''),
(63,1,1,'Customer',1,'Unpaid Order','unpaid_order',''),
(64,2,1,'Customer',1,'Announcement','announcement',''),
(65,5,1,'Customer',1,'Recharge A Friend','recharge_a_friend',''),
(66,2,2,'Customer',1,'Voucher Activation','voucher_activation','');
/*!40000 ALTER TABLE `tbl_widgets` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

-- Dump completed on 2026-04-08 18:00:04
