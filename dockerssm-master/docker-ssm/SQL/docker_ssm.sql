/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50616
Source Host           : localhost:3306
Source Database       : docker_ssm

Target Server Type    : MYSQL
Target Server Version : 50616
File Encoding         : 65001

Date: 2020-01-17 11:12:24
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `docker_ssm_test`
-- ----------------------------
DROP TABLE IF EXISTS `docker_ssm_test`;
CREATE TABLE `docker_ssm_test` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of docker_ssm_test
-- ----------------------------
INSERT INTO `docker_ssm_test` VALUES ('1', '张三');
INSERT INTO `docker_ssm_test` VALUES ('2', '张三');
INSERT INTO `docker_ssm_test` VALUES ('3', '张三');
INSERT INTO `docker_ssm_test` VALUES ('4', '李四');
INSERT INTO `docker_ssm_test` VALUES ('5', '李四');
INSERT INTO `docker_ssm_test` VALUES ('6', '李四');
