/*
SQLyog Ultimate v12.09 (64 bit)
MySQL - 5.7.21-0ubuntu0.17.10.1 : Database - eshop
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`eshop` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `eshop`;

/*Table structure for table `brand` */

DROP TABLE IF EXISTS `brand`;

CREATE TABLE `brand` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

/*Data for the table `brand` */

insert  into `brand`(`id`,`name`) values (5,'sali'),(6,'abs'),(7,'adidas'),(8,'nike'),(9,'aldo');

/*Table structure for table `category` */

DROP TABLE IF EXISTS `category`;

CREATE TABLE `category` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `parent_id` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;

/*Data for the table `category` */

insert  into `category`(`id`,`name`,`parent_id`) values (7,'shalvar',0),(8,'glxark',0),(9,'botas',0),(10,'shub',0),(11,'bluss',0);

/*Table structure for table `comment` */

DROP TABLE IF EXISTS `comment`;

CREATE TABLE `comment` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `description` text NOT NULL,
  `product_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `comment` */

insert  into `comment`(`id`,`name`,`email`,`description`,`product_id`) values (1,'Angela','angel@mail.com','iyaaaaaaaaaaaaaaaaaaaaaaaa\r\naaaaaaaaaaaaaaaaaaa\r\naaaaaaaaaaaaaaaaaaa\r\naaaaaaaaaaaaaaaaaa',17),(2,'Angela','angel@mail.com','shat sirune kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj',14),(3,'Angela','angel@mail.com','sklks[wkswwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwxxxx',14);

/*Table structure for table `product` */

DROP TABLE IF EXISTS `product`;

CREATE TABLE `product` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `description` text,
  `price` double DEFAULT NULL,
  `category_id` int(11) unsigned NOT NULL,
  `brand_id` int(11) unsigned DEFAULT NULL,
  `pic_url` varchar(255) NOT NULL,
  `quantity` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `category_id` (`category_id`),
  KEY `brand_id` (`brand_id`),
  CONSTRAINT `product_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`),
  CONSTRAINT `product_ibfk_2` FOREIGN KEY (`brand_id`) REFERENCES `brand` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=latin1;

/*Data for the table `product` */

insert  into `product`(`id`,`name`,`description`,`price`,`category_id`,`brand_id`,`pic_url`,`quantity`) values (14,'botas','shat sirun botas',1000,9,7,'1520274420977_download.jpeg',10),(15,'Botas','shat sirun serii ',500,9,8,'1520274455957_muzhskie-vozdukhopronicaemye-krasovki.jpg',20),(16,'glxark','arevayin',200,8,6,'1520274486181_download (7).jpeg',5),(17,'glxark','dasakan shat sirun',100,8,6,'1520274537736_download (6).jpeg',45),(18,'shub','serii bnakan',2000,10,9,'1520274582685_picture1520263129319_product.jpg',2),(19,'shub','shaganakaguyn arhestakan',200,10,6,'1520274608752_download (1).jpeg',8),(20,'shalvar','sprtayin txamardu',800,7,6,'1520274635405_download (2).jpeg',10),(23,'bluss','txamardu taq shat lavne',1000,11,6,'1520274736878_download (4).jpeg',7),(24,'bluss','kanaci sirun ',800,11,5,'1520274772188_download (5).jpeg',4),(25,'shalvar','dasakan sirun',850,7,6,'1520274854470_download (3).jpeg',7),(26,'botas','sirun',78,9,5,'1520348867144_muzhskie-vozdukhopronicaemye-krasovki.jpg',4),(27,'aknoc','aknoc',799,7,7,'1520348903526_1953c3a8814d8a750246040ad6672c9c.jpg',3),(28,'shalvar','shalvar',822,7,5,'1520348930426_download (2).jpeg',9),(29,'shub','shub',799,10,5,'1520348985832_download (1).jpeg',1),(30,'glxark','glxark',78,8,5,'1520349010682_download (6).jpeg',2),(31,'shalvar','shalalal',8999,8,5,'1520349038878_download (7).jpeg',7);

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `type` enum('ADMIN','USER') NOT NULL DEFAULT 'USER',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `user` */

insert  into `user`(`id`,`name`,`email`,`password`,`type`) values (2,'Angela','angel@mail.com','$2a$10$jb6bNLAL6YVFmpUZvESf8eUwKBzSa1.1HiIG4zoOSsbVusMHE10Tm','ADMIN');

/*Table structure for table `user_cart_product` */

DROP TABLE IF EXISTS `user_cart_product`;

CREATE TABLE `user_cart_product` (
  `user_cartid` int(11) unsigned NOT NULL,
  `product_cartid` int(11) unsigned NOT NULL,
  KEY `user_id` (`user_cartid`),
  KEY `product_id` (`product_cartid`),
  CONSTRAINT `user_cart_product_ibfk_1` FOREIGN KEY (`user_cartid`) REFERENCES `user` (`id`),
  CONSTRAINT `user_cart_product_ibfk_2` FOREIGN KEY (`product_cartid`) REFERENCES `product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `user_cart_product` */

insert  into `user_cart_product`(`user_cartid`,`product_cartid`) values (2,18);

/*Table structure for table `user_product` */

DROP TABLE IF EXISTS `user_product`;

CREATE TABLE `user_product` (
  `user_id` int(11) unsigned NOT NULL,
  `product_id` int(11) unsigned NOT NULL,
  KEY `user_id` (`user_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `user_product_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `user_product_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `user_product` */

insert  into `user_product`(`user_id`,`product_id`) values (2,14);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
