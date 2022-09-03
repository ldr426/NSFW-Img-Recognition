/*
Navicat MySQL Data Transfer

Source Server         : local
Source Server Version : 50712
Source Host           : localhost:3306
Source Database       : pic

Target Server Type    : MYSQL
Target Server Version : 50712
File Encoding         : 65001

Date: 2022-01-10 11:10:16
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for auth_group
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_group
-- ----------------------------

-- ----------------------------
-- Table structure for auth_group_permissions
-- ----------------------------
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_group_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for auth_permission
-- ----------------------------
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_permission
-- ----------------------------
INSERT INTO `auth_permission` VALUES ('1', 'Can add log entry', '1', 'add_logentry');
INSERT INTO `auth_permission` VALUES ('2', 'Can change log entry', '1', 'change_logentry');
INSERT INTO `auth_permission` VALUES ('3', 'Can delete log entry', '1', 'delete_logentry');
INSERT INTO `auth_permission` VALUES ('4', 'Can view log entry', '1', 'view_logentry');
INSERT INTO `auth_permission` VALUES ('5', 'Can add permission', '2', 'add_permission');
INSERT INTO `auth_permission` VALUES ('6', 'Can change permission', '2', 'change_permission');
INSERT INTO `auth_permission` VALUES ('7', 'Can delete permission', '2', 'delete_permission');
INSERT INTO `auth_permission` VALUES ('8', 'Can view permission', '2', 'view_permission');
INSERT INTO `auth_permission` VALUES ('9', 'Can add group', '3', 'add_group');
INSERT INTO `auth_permission` VALUES ('10', 'Can change group', '3', 'change_group');
INSERT INTO `auth_permission` VALUES ('11', 'Can delete group', '3', 'delete_group');
INSERT INTO `auth_permission` VALUES ('12', 'Can view group', '3', 'view_group');
INSERT INTO `auth_permission` VALUES ('13', 'Can add user', '4', 'add_user');
INSERT INTO `auth_permission` VALUES ('14', 'Can change user', '4', 'change_user');
INSERT INTO `auth_permission` VALUES ('15', 'Can delete user', '4', 'delete_user');
INSERT INTO `auth_permission` VALUES ('16', 'Can view user', '4', 'view_user');
INSERT INTO `auth_permission` VALUES ('17', 'Can add content type', '5', 'add_contenttype');
INSERT INTO `auth_permission` VALUES ('18', 'Can change content type', '5', 'change_contenttype');
INSERT INTO `auth_permission` VALUES ('19', 'Can delete content type', '5', 'delete_contenttype');
INSERT INTO `auth_permission` VALUES ('20', 'Can view content type', '5', 'view_contenttype');
INSERT INTO `auth_permission` VALUES ('21', 'Can add session', '6', 'add_session');
INSERT INTO `auth_permission` VALUES ('22', 'Can change session', '6', 'change_session');
INSERT INTO `auth_permission` VALUES ('23', 'Can delete session', '6', 'delete_session');
INSERT INTO `auth_permission` VALUES ('24', 'Can view session', '6', 'view_session');
INSERT INTO `auth_permission` VALUES ('25', 'Can add captcha store', '7', 'add_captchastore');
INSERT INTO `auth_permission` VALUES ('26', 'Can change captcha store', '7', 'change_captchastore');
INSERT INTO `auth_permission` VALUES ('27', 'Can delete captcha store', '7', 'delete_captchastore');
INSERT INTO `auth_permission` VALUES ('28', 'Can view captcha store', '7', 'view_captchastore');

-- ----------------------------
-- Table structure for auth_user
-- ----------------------------
DROP TABLE IF EXISTS `auth_user`;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_user
-- ----------------------------

-- ----------------------------
-- Table structure for auth_user_groups
-- ----------------------------
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_user_groups
-- ----------------------------

-- ----------------------------
-- Table structure for auth_user_user_permissions
-- ----------------------------
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_user_user_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for captcha_captchastore
-- ----------------------------
DROP TABLE IF EXISTS `captcha_captchastore`;
CREATE TABLE `captcha_captchastore` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `challenge` varchar(32) NOT NULL,
  `response` varchar(32) NOT NULL,
  `hashkey` varchar(40) NOT NULL,
  `expiration` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `hashkey` (`hashkey`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of captcha_captchastore
-- ----------------------------
INSERT INTO `captcha_captchastore` VALUES ('21', 'OSDC', 'osdc', '14565e74da40915f05b5504aac341087cf6da850', '2021-03-13 11:15:04.391261');
INSERT INTO `captcha_captchastore` VALUES ('22', 'KMIL', 'kmil', '34d24115cc60999040dff44258b6260956a047f5', '2021-03-13 11:15:09.479475');
INSERT INTO `captcha_captchastore` VALUES ('23', 'OUCQ', 'oucq', '86ed1a8fd7efd9223c76f3a842d98559a25c9385', '2021-03-13 11:15:18.870100');

-- ----------------------------
-- Table structure for django_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_admin_log
-- ----------------------------

-- ----------------------------
-- Table structure for django_content_type
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_content_type
-- ----------------------------
INSERT INTO `django_content_type` VALUES ('1', 'admin', 'logentry');
INSERT INTO `django_content_type` VALUES ('3', 'auth', 'group');
INSERT INTO `django_content_type` VALUES ('2', 'auth', 'permission');
INSERT INTO `django_content_type` VALUES ('4', 'auth', 'user');
INSERT INTO `django_content_type` VALUES ('7', 'captcha', 'captchastore');
INSERT INTO `django_content_type` VALUES ('5', 'contenttypes', 'contenttype');
INSERT INTO `django_content_type` VALUES ('6', 'sessions', 'session');

-- ----------------------------
-- Table structure for django_migrations
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_migrations
-- ----------------------------
INSERT INTO `django_migrations` VALUES ('1', 'contenttypes', '0001_initial', '2021-02-21 14:21:19.344084');
INSERT INTO `django_migrations` VALUES ('2', 'auth', '0001_initial', '2021-02-21 14:21:19.591423');
INSERT INTO `django_migrations` VALUES ('3', 'admin', '0001_initial', '2021-02-21 14:21:20.123107');
INSERT INTO `django_migrations` VALUES ('4', 'admin', '0002_logentry_remove_auto_add', '2021-02-21 14:21:20.405930');
INSERT INTO `django_migrations` VALUES ('5', 'admin', '0003_logentry_add_action_flag_choices', '2021-02-21 14:21:20.413908');
INSERT INTO `django_migrations` VALUES ('6', 'contenttypes', '0002_remove_content_type_name', '2021-02-21 14:21:20.510650');
INSERT INTO `django_migrations` VALUES ('7', 'auth', '0002_alter_permission_name_max_length', '2021-02-21 14:21:20.572517');
INSERT INTO `django_migrations` VALUES ('8', 'auth', '0003_alter_user_email_max_length', '2021-02-21 14:21:20.647369');
INSERT INTO `django_migrations` VALUES ('9', 'auth', '0004_alter_user_username_opts', '2021-02-21 14:21:20.656345');
INSERT INTO `django_migrations` VALUES ('10', 'auth', '0005_alter_user_last_login_null', '2021-02-21 14:21:20.703220');
INSERT INTO `django_migrations` VALUES ('11', 'auth', '0006_require_contenttypes_0002', '2021-02-21 14:21:20.705215');
INSERT INTO `django_migrations` VALUES ('12', 'auth', '0007_alter_validators_add_error_messages', '2021-02-21 14:21:20.713193');
INSERT INTO `django_migrations` VALUES ('13', 'auth', '0008_alter_user_username_max_length', '2021-02-21 14:21:20.772036');
INSERT INTO `django_migrations` VALUES ('14', 'auth', '0009_alter_user_last_name_max_length', '2021-02-21 14:21:20.844841');
INSERT INTO `django_migrations` VALUES ('15', 'auth', '0010_alter_group_name_max_length', '2021-02-21 14:21:20.907704');
INSERT INTO `django_migrations` VALUES ('16', 'auth', '0011_update_proxy_permissions', '2021-02-21 14:21:20.914686');
INSERT INTO `django_migrations` VALUES ('17', 'auth', '0012_alter_user_first_name_max_length', '2021-02-21 14:21:20.973529');
INSERT INTO `django_migrations` VALUES ('18', 'captcha', '0001_initial', '2021-02-21 14:21:21.014419');
INSERT INTO `django_migrations` VALUES ('19', 'sessions', '0001_initial', '2021-02-21 14:21:21.051356');

-- ----------------------------
-- Table structure for django_session
-- ----------------------------
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_session
-- ----------------------------
INSERT INTO `django_session` VALUES ('1dt2a7shwk993ux99b5oyz83pxj13yay', '.eJxFzEEKgCAQQNG7zLpFNaOpZwlCbQqhFMpZRXevRdD6P_4F6Zy2sqYMrh7CDcjJx5RmcBCiUh2RR-qRkI3vglmiQY3WWt0O8OHsd375KHogHkXpObwpllz9v41FcgXX3w_vNSNP:1lM1Ny:ZeDB35S0qrEY1N8ZmyQKhZN0aI7ytcJtDovVvKTCqvY', '2021-03-30 12:32:50.583925');
INSERT INTO `django_session` VALUES ('8gzkv6f4d5eo1l4ga78ok4li9gblinl0', '.eJwtzEEOwyAMRNG7eN1FDMaYXCYCbCqkJJWSZlX17kVKt6M3_wP9XNbXs-8wv4_LHnCddixdYYagLLEGZEtExYtUm3zTgiYswRD-eM-bDZ51G5Wx3ecUeZKQyYgIg88mlrJPrXBghzxg66stt27ELD4qqkWq4pI6LiVSTA4jS4bvD9R6MHw:1lEODq:nmwQBQWkmo5VdPQq-cb5SBwbP_ck3mFaASOo2UQEBvQ', '2021-03-09 03:18:50.987051');
INSERT INTO `django_session` VALUES ('mgterlheyeh6qicmu881bjin4orhblol', '.eJwtzEsKgCAUQNG9vHGDxE8vNyN-XiGUgp9RtPcUGl443AdiNVc-YwLdSqcFeqViYgANMijcvGSKdiEcR_S08iM4RqhQEoMfJ3vT4Dbc47KAz6nZ-TvsVWl2Tw30-n5QYSJk:1lEWix:EPBzOvSsqIdWNoeyqxVpZCDshyX6rTPlpWVQwO_ajys', '2021-03-09 20:23:31.302626');

-- ----------------------------
-- Table structure for historypath
-- ----------------------------
DROP TABLE IF EXISTS `historypath`;
CREATE TABLE `historypath` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid_id` varchar(255) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `c_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `result` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `historypath_ibfk_1` (`uid_id`),
  CONSTRAINT `historypath_ibfk_1` FOREIGN KEY (`uid_id`) REFERENCES `user` (`uid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of historypath
-- ----------------------------
INSERT INTO `historypath` VALUES ('16', '5d687c516e944b388ce03fdb1e8685e1', './upload/admin/e02eec6fba1449e6a9eec40487eafc6c', '2021-03-13 10:19:00', '不包含非法图片');
INSERT INTO `historypath` VALUES ('17', '5d687c516e944b388ce03fdb1e8685e1', './upload/admin/fe843f79e4cd4a8f8ac86f4ec60d4656', '2021-03-13 10:19:17', '包含1张非法图片');
INSERT INTO `historypath` VALUES ('18', '5d687c516e944b388ce03fdb1e8685e1', './upload/admin/125da999839a45ffb44331b4d8372abd', '2021-03-13 10:18:54', '不包含非法图片');
INSERT INTO `historypath` VALUES ('19', '5d687c516e944b388ce03fdb1e8685e1', './upload/admin/5ed86e4f9d204bf382e5ddc27a606f28', '2021-03-13 10:18:48', '包含1张非法图片');
INSERT INTO `historypath` VALUES ('20', '5d687c516e944b388ce03fdb1e8685e1', './upload/admin/d87e6595ce4b4334a04f053ae8647481', '2021-03-13 10:18:46', '包含1张非法图片');
INSERT INTO `historypath` VALUES ('21', '5d687c516e944b388ce03fdb1e8685e1', './upload/admin/e0e178997ff8486caf4ec4605daa3e99', '2021-03-13 10:18:45', '包含2张非法图片');
INSERT INTO `historypath` VALUES ('22', '5d687c516e944b388ce03fdb1e8685e1', './upload/admin/1641da0bf54248e9a0646436599ca5dc', '2021-03-13 10:18:39', '包含1张非法图片');
INSERT INTO `historypath` VALUES ('23', '5d687c516e944b388ce03fdb1e8685e1', './upload/admin/7b20499bd5844be29261b7d06bc8c457', '2021-03-13 10:18:33', '不包含非法图片');
INSERT INTO `historypath` VALUES ('25', 'bc55144a342343e8a1b8fc8363999607', './upload/李四/f09e9d4e64de42cea2c5c9b4bf382dca', '2021-03-16 12:32:51', '包含2张非法图片');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `uid` varchar(255) NOT NULL,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('5d687c516e944b388ce03fdb1e8685e1', 'admin', 'a3392a81ceb2b409aed64336df24b032019b7e3d31a7886995ffaa94de9c682d');
INSERT INTO `user` VALUES ('bc55144a342343e8a1b8fc8363999607', '李四', 'a3392a81ceb2b409aed64336df24b032019b7e3d31a7886995ffaa94de9c682d');
INSERT INTO `user` VALUES ('c5f2f2bda5be4ba88826bfaac48d62c3', '赵六', 'a3392a81ceb2b409aed64336df24b032019b7e3d31a7886995ffaa94de9c682d');
INSERT INTO `user` VALUES ('e261cb1cafa841b28d3e77a6198c9d98', '王五', 'a3392a81ceb2b409aed64336df24b032019b7e3d31a7886995ffaa94de9c682d');
