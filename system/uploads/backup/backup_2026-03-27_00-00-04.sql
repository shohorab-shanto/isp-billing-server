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
(14,'api_key','3de58e0e39baad40153d15bf3303e99319dcddf0'),
(15,'csrf_token','a67803cc561100f241d1e3cc69abdbbc'),
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
(51,'sms_url',''),
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
(92,'new_version_notify','enable'),
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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_bandwidth`
--

LOCK TABLES `tbl_bandwidth` WRITE;
/*!40000 ALTER TABLE `tbl_bandwidth` DISABLE KEYS */;
INSERT INTO `tbl_bandwidth` VALUES
(3,'5Mbps',60,'Mbps',60,'Mbps',''),
(4,'10Mbps',70,'Mbps',70,'Mbps','');
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
) ENGINE=InnoDB AUTO_INCREMENT=1215 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
(772,'s143','667788','/user.default.jpg','','','','s143','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(773,'s144','667788','/user.default.jpg','','','','s144','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(774,'s145','667788','/user.default.jpg','','','','s145','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(775,'s148','667788','/user.default.jpg','','','','s148','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(776,'s149','667788','/user.default.jpg','','','','s149','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
(777,'s150','667788','/user.default.jpg','','','','s150','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
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
(843,'stest','667788','/user.default.jpg','','','','stest','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
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
(887,'s280','667788','/user.default.jpg','','','','s280','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:06',NULL),
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
(911,'s464','667788','/user.default.jpg','','','','s464','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
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
(947,'s285','667788','/user.default.jpg','','','','s285','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
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
(1078,'s499','667788','/user.default.jpg','','','','s499','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
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
(1112,'office11','667788','/user.default.jpg','','','','office11','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
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
(1171,'s563','667788','/user.default.jpg','','','','s563','',NULL,NULL,NULL,NULL,'','','','Personal',0.00,'Others',1,'Active',0,'2026-03-22 14:19:07',NULL),
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
(1210,'s170','667788','/user.default.jpg','s170','667788','','munna','','',NULL,NULL,NULL,'','','','Personal',0.00,'PPPoE',1,'Active',1,'2026-03-22 16:55:59',NULL),
(1211,'s62','667788','/user.default.jpg','s62','667788','','s62','','','','','','','','','Personal',0.00,'PPPoE',1,'Active',2,'2026-03-22 17:11:54',NULL),
(1212,'s303','667788','/user.default.jpg','s303','667788','','s303','','','','','','','','','Personal',0.00,'Hotspot',1,'Active',2,'2026-03-22 17:13:51',NULL),
(1213,'s135','667788','/user.default.jpg','s135','667788','','Omit hasan','Posim Bazar bridge pase','','','','','8801916357209','','','Personal',0.00,'PPPoE',1,'Active',1,'2026-03-24 15:45:12',NULL),
(1214,'arian@01709541829','667788','/user.default.jpg','arian@01709541829','667788','','Arian','Porisod road forhad bare','','','','','8801709541829','','','Personal',0.00,'PPPoE',1,'Active',1,'2026-03-26 07:42:50',NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=122 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
(121,'2026-03-27 00:00:04','','Initiating Daily backup',0,'CLI');
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
(5,'WhatsApp HTTP Response','8801911908800','Payment Will be done.','Success','{\"success\":true,\"message\":\"message saved\",\"metadata\":{\"to\":\"8801911908800\",\"msg\":\"Payment Will be done.\"},\"result\":{\"type\":\"free\",\"queue_id\":\"a94d67942f9080ed79b6ffdd55e772f6\"}}','2026-03-24 10:48:34');
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_plans`
--

LOCK TABLES `tbl_plans` WRITE;
/*!40000 ALTER TABLE `tbl_plans` DISABLE KEYS */;
INSERT INTO `tbl_plans` VALUES
(1,'5Mbps',3,'500','','PPPOE','Unlimited','Time_Limit',0,'Hrs',0,'MB',30,'Days',NULL,'Shahed',0,'5Mbps',0,0,1,'yes','yes','Personal','MikrotikPppoe','',''),
(4,'10Mbps',4,'1000','','PPPOE','Unlimited','Time_Limit',0,'Hrs',0,'MB',30,'Days',NULL,'Shahed',0,'10Mbps',0,0,1,'yes','yes','Personal','MikrotikPppoe','','');
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_pool`
--

LOCK TABLES `tbl_pool` WRITE;
/*!40000 ALTER TABLE `tbl_pool` DISABLE KEYS */;
INSERT INTO `tbl_pool` VALUES
(1,'2Mbps','192.168.10.1','192.168.10.2-192.168.11.254','Shahed'),
(2,'3Mbps','192.168.20.1','192.168.20.2-192.168.21.254','Shahed'),
(3,'5Mbps','192.168.24.1','192.168.24.2-192.168.25.254','Shahed'),
(4,'10Mbps','192.168.40.1','192.168.40.2-192.168.41.254','Shahed');
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
(1,'Shahed','103.109.96.168:2026','api','1sDpAwUe5c','','24.027146446855763, 90.38696797894177','Online','2026-03-26 23:59:03','0',1);
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
) ENGINE=InnoDB AUTO_INCREMENT=621 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
(620,'INV-620','arian@01709541829',1214,'5Mbps','500','2026-03-26','14:00:26','2026-04-25','14:00:26','Bkash - Administrator','Shahed','PPPOE','',1);
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
) ENGINE=InnoDB AUTO_INCREMENT=615 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
(614,1214,'arian@01709541829',1,'5Mbps','2026-03-26','14:00:26','2026-04-25','14:00:26','on','Bkash - Administrator','Shahed','PPPOE',1);
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
(1,0,'/admin.default.png','admin','Administrator','e7092c4051ee492cfc09fd2f5e0e4248f3cb91a4','','','','','','SuperAdmin','Active',NULL,'2026-03-23 16:33:24','a91ef696e9ea0d9384d072d1bdcc5c13094ba433','2014-06-23 01:43:07'),
(2,0,'/admin.default.png','shahad','Md. Shahadur Rahman','bfe54caa6d483cc3887dce9d1b8eb91408f1ea7a','01911908800','shahadsalna@gmail.com','Gazipur','Gazipur','19','Admin','Active',NULL,'2026-03-22 22:46:03','737358044b1973d52a37a8726489161246aca37a','2026-03-22 21:21:19');
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

-- Dump completed on 2026-03-26 18:00:04
