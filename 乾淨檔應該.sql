CREATE DATABASE  IF NOT EXISTS `db_saproject1` /*!40100 DEFAULT CHARACTER SET utf8mb3 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `db_saproject1`;
-- MySQL dump 10.13  Distrib 8.0.33, for Win64 (x86_64)
--
-- Host: localhost    Database: db_saproject1
-- ------------------------------------------------------
-- Server version	8.0.33

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `inventory_tracking`
--

DROP TABLE IF EXISTS `inventory_tracking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventory_tracking` (
  `inventory_tracking_id` int NOT NULL AUTO_INCREMENT,
  `warhouse_id` int NOT NULL,
  `product_id` int NOT NULL,
  `quantity_change` int NOT NULL,
  `movement_change` datetime NOT NULL,
  PRIMARY KEY (`inventory_tracking_id`,`warhouse_id`,`product_id`),
  KEY `fk_product_idx` (`product_id`),
  KEY `fk_warhouse_idx` (`warhouse_id`),
  CONSTRAINT `fk_product_inventory` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`),
  CONSTRAINT `fk_warhouse_inventory` FOREIGN KEY (`warhouse_id`) REFERENCES `warhouse` (`warhouse_id`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventory_tracking`
--


/*!40000 ALTER TABLE `inventory_tracking` DISABLE KEYS */;
INSERT INTO `inventory_tracking` VALUES (2,1,2,60,'2023-12-11 21:35:48'),(6,1,3,40,'2023-12-11 22:10:46'),(7,1,4,200,'2023-12-12 13:50:31'),(8,1,3,-40,'2023-12-13 14:29:55'),(11,1,2,-20,'2023-12-16 00:18:47'),(12,2,2,20,'2023-12-16 00:18:47'),(13,1,2,-20,'2023-12-16 00:29:15'),(14,2,2,20,'2023-12-16 00:29:15'),(15,1,2,-20,'2023-12-16 00:30:53'),(16,2,2,20,'2023-12-16 00:30:53'),(22,2,5,290,'2023-12-16 21:48:51'),(23,2,6,20,'2023-12-16 23:59:38'),(25,1,5,-10,'2023-12-17 00:09:37'),(26,1,6,30,'2023-12-17 00:12:00'),(27,1,7,100,'2023-12-17 14:07:50'),(28,2,8,20,'2023-12-17 14:32:35'),(29,1,9,200,'2023-12-17 14:33:13'),(30,1,9,-20,'2023-12-17 14:48:33'),(31,2,9,20,'2023-12-17 14:48:33'),(45,1,10,200,'2023-12-17 15:28:25'),(46,1,10,-20,'2023-12-17 15:39:30'),(47,2,10,20,'2023-12-17 15:39:30'),(48,1,10,-20,'2023-12-17 15:40:31'),(49,2,10,20,'2023-12-17 15:40:31'),(50,2,11,200,'2023-12-17 15:46:17'),(51,1,12,200,'2023-12-18 18:19:30'),(52,1,12,300,'2023-12-18 18:20:11'),(53,1,12,200,'2023-12-18 18:20:58'),(54,1,12,20,'2023-12-18 18:24:30'),(55,1,12,3000,'2023-12-18 18:25:03'),(56,1,12,-200,'2023-12-18 18:39:40'),(57,1,12,200,'2023-12-19 10:14:18'),(58,1,9,200,'2023-12-19 22:51:23'),(59,1,9,200,'2023-12-20 20:46:36'),(60,1,10,200,'2023-12-20 20:50:53'),(61,2,11,200,'2023-12-20 20:51:31'),(62,1,12,200,'2023-12-20 21:49:27'),(63,1,13,100,'2023-12-20 21:50:12'),(64,1,10,200,'2023-12-20 21:51:20');
/*!40000 ALTER TABLE `inventory_tracking` ENABLE KEYS */;


--
-- Table structure for table `manager`
--

DROP TABLE IF EXISTS `manager`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `manager` (
  `manager_id` int NOT NULL,
  `manager_name` varchar(45) NOT NULL,
  `manager_email` varchar(45) NOT NULL,
  `manager_password` varchar(45) NOT NULL,
  PRIMARY KEY (`manager_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manager`
--


/*!40000 ALTER TABLE `manager` DISABLE KEYS */;
INSERT INTO `manager` VALUES (1,'ianchu','123','123'),(2,'gaba','888','888');
/*!40000 ALTER TABLE `manager` ENABLE KEYS */;


--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `order_id` int NOT NULL AUTO_INCREMENT,
  `manager_id` int NOT NULL,
  `orders_product_name` varchar(45) NOT NULL,
  `orders_product_price` int NOT NULL,
  `orders_product_quantity` int NOT NULL,
  `orders_packed_time` datetime NOT NULL,
  `orders_statement` varchar(45) NOT NULL,
  PRIMARY KEY (`order_id`,`manager_id`),
  KEY `fk_order_manager_idx` (`manager_id`),
  CONSTRAINT `fk_order_manager` FOREIGN KEY (`manager_id`) REFERENCES `manager` (`manager_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--


/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,1,'牛',20,20,'2023-12-11 22:04:48','Packed'),(2,1,'電腦',500,40,'2023-12-13 14:29:55','Packed'),(3,1,'馬',100,10,'2023-12-17 00:09:37','Packed'),(4,1,'飛可老師',400,200,'2023-12-18 18:39:40','Packed'),(5,1,'飛可老師',400,100,'2023-12-19 12:12:48','Not Packed'),(6,1,'天使',200,10,'2023-12-19 14:59:53','Not Packed'),(7,1,'天使',200,10,'2023-12-19 21:55:34','Not Packed');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;


--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `product_id` int NOT NULL,
  `product_name` varchar(45) NOT NULL,
  `supplier_id` int NOT NULL,
  `product_location` varchar(45) NOT NULL,
  `product_quantity` int NOT NULL,
  `product_price` int NOT NULL,
  PRIMARY KEY (`product_id`,`supplier_id`),
  KEY `fk_porduct_supplier1_idx` (`supplier_id`),
  CONSTRAINT `fk_porduct_supplier1` FOREIGN KEY (`supplier_id`) REFERENCES `supplier` (`supplier_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--


/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,'牛',1,'中央大學',140,20),(2,'鳥',1,'中央大學',60,20),(3,'電腦',1,'中央大學',0,500),(4,'平板',2,'中央大學',200,20),(5,'馬',1,'台大',280,100),(6,'狗',2,'中央大學',50,20),(7,'鼠',2,'11號4樓',100,100),(8,'天使',1,'台大',20,200),(9,'天使',1,'11號4樓',600,20),(10,'酒',1,'11號4樓',440,20),(11,'酒',2,'台大',400,200),(12,'飛可老師',1,'11號4樓',3920,400),(13,'鼠',2,'11號4樓',100,100);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;


--
-- Table structure for table `reporting`
--

DROP TABLE IF EXISTS `reporting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reporting` (
  `reporting_id` int NOT NULL AUTO_INCREMENT,
  `manager_id` int NOT NULL,
  PRIMARY KEY (`reporting_id`,`manager_id`),
  KEY `fk_reporting_manager_idx` (`manager_id`),
  CONSTRAINT `fk_reporting_manager` FOREIGN KEY (`manager_id`) REFERENCES `manager` (`manager_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reporting`
--


/*!40000 ALTER TABLE `reporting` DISABLE KEYS */;
/*!40000 ALTER TABLE `reporting` ENABLE KEYS */;


--
-- Table structure for table `supplier`
--

DROP TABLE IF EXISTS `supplier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `supplier` (
  `supplier_id` int NOT NULL,
  `supplier_name` varchar(45) NOT NULL,
  PRIMARY KEY (`supplier_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `supplier`
--


/*!40000 ALTER TABLE `supplier` DISABLE KEYS */;
INSERT INTO `supplier` VALUES (1,'小夫'),(2,'567'),(3,'456');
/*!40000 ALTER TABLE `supplier` ENABLE KEYS */;


--
-- Table structure for table `tbl_manager_supplier`
--

DROP TABLE IF EXISTS `tbl_manager_supplier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_manager_supplier` (
  `manager_id` int NOT NULL,
  `supplier_id` int NOT NULL,
  PRIMARY KEY (`manager_id`,`supplier_id`),
  KEY `fk_supplier_idx` (`supplier_id`),
  CONSTRAINT `fk_manager_supplier` FOREIGN KEY (`manager_id`) REFERENCES `manager` (`manager_id`),
  CONSTRAINT `fk_supplier_manager` FOREIGN KEY (`supplier_id`) REFERENCES `supplier` (`supplier_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_manager_supplier`
--


/*!40000 ALTER TABLE `tbl_manager_supplier` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_manager_supplier` ENABLE KEYS */;


--
-- Table structure for table `tbl_orders_reporting`
--

DROP TABLE IF EXISTS `tbl_orders_reporting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_orders_reporting` (
  `reporting_id` int NOT NULL,
  `orders_id` int NOT NULL,
  PRIMARY KEY (`reporting_id`,`orders_id`),
  KEY `fk_report_orders_idx` (`orders_id`),
  CONSTRAINT `fk_orders_report` FOREIGN KEY (`reporting_id`) REFERENCES `reporting` (`reporting_id`),
  CONSTRAINT `fk_report_orders` FOREIGN KEY (`orders_id`) REFERENCES `orders` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_orders_reporting`
--


/*!40000 ALTER TABLE `tbl_orders_reporting` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_orders_reporting` ENABLE KEYS */;


--
-- Table structure for table `tbl_product_manager`
--

DROP TABLE IF EXISTS `tbl_product_manager`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_product_manager` (
  `product_id` int NOT NULL,
  `manager_id` int NOT NULL,
  PRIMARY KEY (`product_id`,`manager_id`),
  KEY `fk_manager_idx` (`manager_id`),
  CONSTRAINT `fk_manager_product` FOREIGN KEY (`manager_id`) REFERENCES `manager` (`manager_id`),
  CONSTRAINT `fk_product_manager` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_product_manager`
--


/*!40000 ALTER TABLE `tbl_product_manager` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_product_manager` ENABLE KEYS */;


--
-- Table structure for table `tbl_product_orders`
--

DROP TABLE IF EXISTS `tbl_product_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_product_orders` (
  `product_id` int NOT NULL,
  `order_id` int NOT NULL,
  PRIMARY KEY (`product_id`,`order_id`),
  KEY `fk_order_idx` (`order_id`),
  CONSTRAINT `fk_order_product` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  CONSTRAINT `fk_product_orders` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_product_orders`
--


/*!40000 ALTER TABLE `tbl_product_orders` DISABLE KEYS */;
INSERT INTO `tbl_product_orders` VALUES (3,2),(5,3),(12,4),(12,5),(8,6),(8,7);
/*!40000 ALTER TABLE `tbl_product_orders` ENABLE KEYS */;


--
-- Table structure for table `tbl_reporting_product`
--

DROP TABLE IF EXISTS `tbl_reporting_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_reporting_product` (
  `product_id` int NOT NULL,
  `repoting_id` int NOT NULL,
  PRIMARY KEY (`product_id`,`repoting_id`),
  KEY `fk_repoting_idx` (`repoting_id`),
  CONSTRAINT `fk_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`),
  CONSTRAINT `fk_reporting` FOREIGN KEY (`repoting_id`) REFERENCES `reporting` (`reporting_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_reporting_product`
--


/*!40000 ALTER TABLE `tbl_reporting_product` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_reporting_product` ENABLE KEYS */;


--
-- Table structure for table `tbl_warhouse_manager`
--

DROP TABLE IF EXISTS `tbl_warhouse_manager`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_warhouse_manager` (
  `warhouse_id` int NOT NULL,
  `manager_id` int NOT NULL,
  PRIMARY KEY (`warhouse_id`,`manager_id`),
  KEY `fk_manager_idx` (`manager_id`),
  CONSTRAINT `fk_manager_warhouse` FOREIGN KEY (`manager_id`) REFERENCES `manager` (`manager_id`),
  CONSTRAINT `fk_warhouse_manager` FOREIGN KEY (`warhouse_id`) REFERENCES `warhouse` (`warhouse_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_warhouse_manager`
--


/*!40000 ALTER TABLE `tbl_warhouse_manager` DISABLE KEYS */;
INSERT INTO `tbl_warhouse_manager` VALUES (1,1),(2,1);
/*!40000 ALTER TABLE `tbl_warhouse_manager` ENABLE KEYS */;


--
-- Table structure for table `tbl_warhouse_product`
--

DROP TABLE IF EXISTS `tbl_warhouse_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_warhouse_product` (
  `warhouse_id` int NOT NULL,
  `product_id` int NOT NULL,
  PRIMARY KEY (`warhouse_id`,`product_id`),
  KEY `fk_product_idx` (`product_id`),
  CONSTRAINT `fk_product_warhouse` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`),
  CONSTRAINT `fk_warhouse_product` FOREIGN KEY (`warhouse_id`) REFERENCES `warhouse` (`warhouse_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_warhouse_product`
--


/*!40000 ALTER TABLE `tbl_warhouse_product` DISABLE KEYS */;
INSERT INTO `tbl_warhouse_product` VALUES (2,8),(1,9),(2,9),(1,10),(2,11),(1,12),(1,13);
/*!40000 ALTER TABLE `tbl_warhouse_product` ENABLE KEYS */;


--
-- Table structure for table `warhouse`
--

DROP TABLE IF EXISTS `warhouse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `warhouse` (
  `warhouse_name` varchar(60) NOT NULL,
  `warhouse_location` varchar(60) NOT NULL,
  `warhouse_id` int NOT NULL,
  PRIMARY KEY (`warhouse_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `warhouse`
--


/*!40000 ALTER TABLE `warhouse` DISABLE KEYS */;
INSERT INTO `warhouse` VALUES ('倉庫3號','11號4樓',1),('2號','台大',2);
/*!40000 ALTER TABLE `warhouse` ENABLE KEYS */;


--
-- Dumping routines for database 'db_saproject1'
--
/*!50003 DROP PROCEDURE IF EXISTS `sp_addproduct` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_addproduct`(
    IN p_product_name VARCHAR(45),
    IN p_supplier_id INT,
    IN p_warhouse_id INT,
    IN p_product_quantity INT,
    IN p_product_price INT
)
BEGIN
    DECLARE v_supplier_exists INT;
    DECLARE v_warhouse_location VARCHAR(60);
    DECLARE v_product_id INT;

    -- 檢查供應商是否存在
    SELECT COUNT(*) INTO v_supplier_exists
    FROM supplier
    WHERE supplier_id = p_supplier_id;

    IF v_supplier_exists = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Supplier not found.';
    ELSE
        -- 檢查倉庫是否存在，並取得倉庫位置
        SELECT warhouse_location INTO v_warhouse_location
        FROM warhouse
        WHERE warhouse_id = p_warhouse_id;

        IF v_warhouse_location IS NULL THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Error: Warehouse not found.';
        ELSE
            -- 檢查同名產品在不同倉庫的情況
            SELECT p.product_id INTO v_product_id
            FROM tbl_warhouse_product wp
            INNER JOIN product p ON wp.product_id = p.product_id
            WHERE p.product_name = p_product_name AND wp.warhouse_id = p_warhouse_id;

            IF v_product_id IS NOT NULL THEN
                -- 如果存在相同產品，則更新產品數量
                UPDATE product
                SET product_quantity = product_quantity + p_product_quantity
                WHERE product.product_id = v_product_id;

                -- 更新 inventory_tracking
                INSERT INTO inventory_tracking (warhouse_id, product_id, quantity_change, movement_change)
                VALUES (p_warhouse_id, v_product_id, p_product_quantity, NOW());

                SELECT 'Product quantity updated successfully.' AS result;
            ELSE
                -- 如果不存在相同產品，則新增一個新的 product_id
                SET v_product_id := (SELECT MAX(product_id) + 1 FROM product);

                -- 新增產品，將倉庫位置存入 product_location
                INSERT INTO product (product_id, product_name, supplier_id, product_location, product_quantity, product_price)
                VALUES (v_product_id, p_product_name, p_supplier_id, v_warhouse_location, p_product_quantity, p_product_price);

                -- 新增產品到 tbl_warhouse_product
                INSERT INTO tbl_warhouse_product (warhouse_id, product_id)
                VALUES (p_warhouse_id, v_product_id);

                -- 新增產品數量和產品到 inventory_tracking
                INSERT INTO inventory_tracking (warhouse_id, product_id, quantity_change, movement_change)
                VALUES (p_warhouse_id, v_product_id, p_product_quantity, NOW());

                SELECT 'Product added successfully.' AS result;
            END IF;
        END IF;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_addsupplier` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_addsupplier`(
    IN p_supplier_name VARCHAR(45)
)
BEGIN
    DECLARE v_supplier_id INT;

    -- 查找已被刪除的供應商，優先使用被刪除的ID
    SELECT MIN(supplier_id) INTO v_supplier_id
    FROM supplier
    WHERE supplier_name IS NULL;

    IF v_supplier_id IS NOT NULL THEN
        -- 使用被刪除的ID
        UPDATE supplier
        SET supplier_name = p_supplier_name
        WHERE supplier_id = v_supplier_id AND supplier_name IS NULL;
    ELSE
        -- 使用循環查找可用的 supplier_id
        SET v_supplier_id = 1;

        -- 使用循環查找可用的 supplier_id
        WHILE EXISTS (SELECT 1 FROM supplier WHERE supplier_id = v_supplier_id) DO
            SET v_supplier_id = v_supplier_id + 1;
        END WHILE;

        -- 自動產生新的供應商ID
        INSERT INTO supplier (supplier_id, supplier_name)
        VALUES (v_supplier_id, p_supplier_name);
    END IF;

    SELECT v_supplier_id AS new_supplier_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_addwarhouse` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_addwarhouse`(
    IN p_warhouse_name VARCHAR(60),
    IN p_warhouse_location VARCHAR(60),
    IN p_manager_id INT
)
BEGIN
    DECLARE v_manager_exists INT;
    DECLARE v_warhouse_id INT;

    -- 檢查管理員是否存在
    SELECT COUNT(*) INTO v_manager_exists
    FROM manager
    WHERE manager_id = p_manager_id;

    IF v_manager_exists = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Manager not found.';
    ELSE
        -- 獲取下一個可用的 warhouse_id
        SET v_warhouse_id = 1;

        -- 使用循環查找可用的 warhouse_id
        WHILE EXISTS (SELECT 1 FROM warhouse WHERE warhouse_id = v_warhouse_id) DO
            SET v_warhouse_id = v_warhouse_id + 1;
        END WHILE;

        -- 新增倉庫
        INSERT INTO warhouse (warhouse_name, warhouse_location, warhouse_id)
        VALUES (p_warhouse_name, p_warhouse_location, v_warhouse_id);

        -- 將倉庫與管理員關聯
        INSERT INTO tbl_warhouse_manager (warhouse_id, manager_id)
        VALUES (v_warhouse_id, p_manager_id);
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_add_order1` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_add_order1`(
    IN p_manager_id INT,
    IN p_product_name VARCHAR(45),
    IN p_product_location VARCHAR(60),
    IN p_product_quantity INT
)
BEGIN
    DECLARE v_product_id INT;
    DECLARE v_product_price INT;
    DECLARE v_order_id INT;

    -- 檢查產品是否存在並取得產品ID和價格
    SELECT product_id, product_price INTO v_product_id, v_product_price
    FROM product
    WHERE product_name = p_product_name AND product_location = p_product_location;

    IF v_product_id IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Product not found in the specified location.';
    ELSE
        -- 新增訂單
        INSERT INTO orders(manager_id, orders_product_name, orders_product_price, orders_product_quantity, orders_packed_time, orders_statement)
        VALUES (p_manager_id, p_product_name, v_product_price, p_product_quantity, CURRENT_TIMESTAMP, 'Not Packed');

        -- 取得新增的訂單ID
        SELECT LAST_INSERT_ID() INTO v_order_id;

        -- 新增訂單與產品的關聯
        INSERT INTO tbl_product_orders(product_id, order_id)
        VALUES (v_product_id, v_order_id);

        SELECT 'Order added successfully.' AS result;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_compare_max_sales_order` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_compare_max_sales_order`()
BEGIN
    DECLARE max_sales DECIMAL(10, 2);
    DECLARE v_orders_product_name VARCHAR(45);
    DECLARE total_price DECIMAL(10, 2);

    -- 獲取已打包訂單的最大銷售總額
    SELECT MAX(orders_product_price * orders_product_quantity) INTO max_sales
    FROM orders
    WHERE orders_statement = 'packed';

    -- 獲取對應最大銷售總額的產品名稱和總價
    SELECT orders_product_name, orders_product_price * orders_product_quantity INTO v_orders_product_name, total_price
    FROM orders
    WHERE orders_product_price * orders_product_quantity = max_sales AND orders_statement = 'packed'
    LIMIT 1;

    -- 列印最大銷售總額的產品名稱和總價
    SELECT 'Maximum Sales Total for Packed Orders: ' AS result, max_sales AS max_sales_total,
           'Product Name: ' AS product_result, v_orders_product_name AS orders_product_name_result,
           'Total Price: ' AS total_price_result, total_price AS total_price_result;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_compare_packed_orders` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_compare_packed_orders`()
BEGIN
    DECLARE max_sales INT;
    DECLARE product_name VARCHAR(45);

    -- 獲取已打包訂單的最大銷售總量
    SELECT MAX(orders_product_quantity) INTO max_sales
    FROM orders
    WHERE orders_statement = 'packed';

    -- 獲取對應最大銷售總量的產品名稱
    SELECT orders_product_name INTO product_name
    FROM orders
    WHERE orders_product_quantity = max_sales AND orders_statement = 'packed'
    LIMIT 1;

    -- 列印最大銷售總量和對應的產品名稱
    SELECT 'Maximum Sales Total for Packed Orders: ' AS result, max_sales AS max_sales_total, 'Product Name: ' AS product_result, product_name AS product_name_result;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_deleteproduct` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_deleteproduct`(
    IN p_product_id INT
)
BEGIN
    DECLARE v_product_exists INT;

    -- 檢查產品是否存在
    SELECT COUNT(*) INTO v_product_exists
    FROM product
    WHERE product_id = p_product_id;

    IF v_product_exists = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Product not found.';
    ELSE
        -- 刪除與產品相關聯的 inventory_tracking 記錄
        DELETE FROM inventory_tracking
        WHERE product_id = p_product_id;

        -- 刪除與產品相關聯的 tbl_product_orders 記錄
        DELETE FROM tbl_product_orders
        WHERE product_id = p_product_id;

        -- 刪除與產品相關聯的 tbl_warhouse_product 記錄
        DELETE FROM tbl_warhouse_product
        WHERE product_id = p_product_id;

        -- 刪除產品
        DELETE FROM product
        WHERE product_id = p_product_id;

        SELECT 'Delete successful.' AS result;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_deletesupplier` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_deletesupplier`(
    IN p_supplier_id INT
)
BEGIN
    -- 檢查供應商是否存在
    DECLARE v_supplier_exists INT;
    SELECT COUNT(*) INTO v_supplier_exists
    FROM supplier
    WHERE supplier_id = p_supplier_id;

    IF v_supplier_exists = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Supplier not found.';
    ELSE
        -- 刪除供應商，相應的產品記錄也會被刪除
        DELETE FROM product
        WHERE supplier_id = p_supplier_id;

        DELETE FROM supplier
        WHERE supplier_id = p_supplier_id;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_deletewarhouse` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_deletewarhouse`(
    IN p_warhouse_id INT
)
BEGIN
    -- 刪除關聯
    DELETE FROM tbl_warhouse_manager
    WHERE warhouse_id = p_warhouse_id;

    -- 刪除倉庫
    DELETE FROM warhouse
    WHERE warhouse_id = p_warhouse_id;

    SELECT 'Delete successful.' AS result;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_delete_order` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_delete_order`(
    IN p_order_id INT
)
BEGIN
    DECLARE v_order_exists INT;

    -- 檢查訂單是否存在
    SELECT COUNT(*) INTO v_order_exists
    FROM orders
    WHERE order_id = p_order_id;

    IF v_order_exists = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Order not found.';
    ELSE
        -- 刪除與訂單相關聯的 tbl_product_orders 記錄
        DELETE FROM tbl_product_orders
        WHERE order_id = p_order_id;

        -- 刪除訂單
        DELETE FROM orders
        WHERE order_id = p_order_id;

        SELECT 'Order deleted successfully.' AS result;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_generate_inventory_report` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_generate_inventory_report`()
BEGIN
    -- 查询所有产品的库存信息
    SELECT 
        p.product_id,
        p.product_name,
        p.supplier_id,
        p.product_location,
        p.product_quantity,
        p.product_price
    FROM 
        product p;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_generate_sales_report` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_generate_sales_report`()
BEGIN
    -- 查询已打包的销售报告
    SELECT 
        o.orders_product_name AS product_name,
        SUM(o.orders_product_quantity) AS total_quantity,
        o.orders_product_price AS unit_price,
        SUM(o.orders_product_quantity * o.orders_product_price) AS total_sales
    FROM 
        orders o
    WHERE
        o.orders_statement = 'Packed'
    GROUP BY 
        o.orders_product_name, o.orders_product_price;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_pack_order` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_pack_order`(
    IN p_order_id INT
)
BEGIN
    DECLARE v_product_id INT;
    DECLARE v_order_quantity INT;
    DECLARE v_available_quantity INT;
    DECLARE error_message VARCHAR(255);

    -- 取得訂單對應的產品ID和訂單數量
    SELECT p.product_id, o.orders_product_quantity, p.product_quantity AS available_quantity
    INTO v_product_id, v_order_quantity, v_available_quantity
    FROM tbl_product_orders po
    JOIN orders o ON po.order_id = o.order_id
    JOIN product p ON po.product_id = p.product_id
    LEFT JOIN inventory_tracking it ON p.product_id = it.product_id
    WHERE po.order_id = p_order_id
    GROUP BY p.product_id, p.product_quantity, o.orders_product_quantity;

    IF v_product_id IS NULL THEN
        SET error_message = 'Error: Order not found.';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = error_message;
    ELSE
        IF v_available_quantity >= v_order_quantity AND v_order_quantity > 0 THEN
            -- 更新產品數量
            UPDATE product
            SET product_quantity = v_available_quantity - v_order_quantity
            WHERE product_id = v_product_id;

            -- 更新庫存變動
            INSERT INTO inventory_tracking(warhouse_id, product_id, quantity_change, movement_change)
            VALUES (
                COALESCE((SELECT warhouse_id FROM tbl_warhouse_product WHERE product_id = v_product_id), 1),
                v_product_id, 
                -v_order_quantity, 
                CURRENT_TIMESTAMP
            );

            -- 更新訂單打包時間
            UPDATE orders
            SET orders_packed_time = CURRENT_TIMESTAMP,
                orders_statement = 'Packed'  -- 新增這一行
            WHERE order_id = p_order_id;

            SELECT 'Packaging successful.' AS result;
        ELSE
            SET error_message = CONCAT('Error: Insufficient inventory or invalid order quantity for packaging. v_available_quantity: ', v_available_quantity, ', v_order_quantity: ', v_order_quantity);
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = error_message;
        END IF;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_product_info` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_product_info`(
    IN p_product_name VARCHAR(45)
)
BEGIN
    -- 宣告變數
    DECLARE done INT DEFAULT 0;
    DECLARE v_product_location VARCHAR(60);
    DECLARE v_product_quantity INT;
    DECLARE v_warhouse_id INT;

    -- 定義游標
    DECLARE cur CURSOR FOR
        SELECT
            p.product_location,
            p.product_quantity,
            w.warhouse_id
        FROM
            product p
        JOIN
            warhouse w ON p.product_location = w.warhouse_location
        WHERE
            p.product_name = p_product_name;

    -- 定義例外
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    -- 開啟游標
    OPEN cur;

    -- 列印結果
    SET SESSION group_concat_max_len = 1000000;
    SET @result = '';
    
    print_result: LOOP
        FETCH cur INTO
            v_product_location,
            v_product_quantity,
            v_warhouse_id;

        IF done THEN
            LEAVE print_result;
        END IF;

        -- 使用 CONCAT 函數整合結果
        SET @result = CONCAT(
            @result,
            'Warehouse ID: ', v_warhouse_id, ', ',
            'Product Location: ', v_product_location, ', ',
            'Product Quantity: ', v_product_quantity, '\n'
            
        );
    END LOOP;

    -- 關閉游標
    CLOSE cur;

    -- 如果沒有找到任何產品，則列印相應的消息
    IF v_product_location IS NULL THEN
        SET @result = 'Product not found.';
    END IF;

    -- 列印整合後的結果
    SELECT @result AS result;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_transfer_product4` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_transfer_product4`(
    IN p_product_name VARCHAR(45),
    IN p_source_warehouse_id INT,
    IN p_destination_warehouse_id INT,
    IN p_transfer_quantity INT
)
BEGIN
    DECLARE v_source_available_quantity INT;
    DECLARE v_destination_available_quantity INT;
    DECLARE v_product_id INT;

    -- 根據產品名稱查詢源倉庫中的庫存及產品ID
    SELECT p.product_id, p.product_quantity
    INTO v_product_id, v_source_available_quantity
    FROM product p
    JOIN tbl_warhouse_product wp ON p.product_id = wp.product_id
    WHERE p.product_name = p_product_name AND wp.warhouse_id = p_source_warehouse_id;

    IF v_product_id IS NULL OR v_source_available_quantity < p_transfer_quantity THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Insufficient inventory in the source warehouse.';
    ELSE
        -- 檢查目標倉庫中的相同產品
        SELECT p.product_id, p.product_quantity INTO v_product_id, v_destination_available_quantity
        FROM product p
        JOIN tbl_warhouse_product wp ON p.product_id = wp.product_id
        WHERE p.product_name = p_product_name AND wp.warhouse_id = p_destination_warehouse_id;

        -- 如果目標倉庫沒有相同產品，則新增 product 表中的資料並獲取新生成的 product_id
        IF v_product_id IS NULL THEN
            INSERT INTO product (product_name, supplier_id, product_location, product_quantity, product_price)
            VALUES (p_product_name, 1, 'Default Location', 0, 0); -- 請根據實際情況調整供應商ID和默認值

            -- 獲取新生成的 product_id
            SELECT LAST_INSERT_ID() INTO v_product_id;
        END IF;

        -- 更新源倉庫的庫存
        UPDATE product
        SET product_quantity = product_quantity - p_transfer_quantity
        WHERE product_id = v_product_id AND v_product_id IN (SELECT product_id FROM tbl_warhouse_product WHERE warhouse_id = p_source_warehouse_id);

        -- 更新目標倉庫的庫存
        UPDATE product
        SET product_quantity = COALESCE(v_destination_available_quantity, 0) + p_transfer_quantity
        WHERE product_id = v_product_id;

        -- 在inventory_tracking表中記錄庫存變動
        INSERT INTO inventory_tracking (warhouse_id, product_id, quantity_change, movement_change)
        VALUES (p_source_warehouse_id, v_product_id, -p_transfer_quantity, CURRENT_TIMESTAMP);

        INSERT INTO inventory_tracking (warhouse_id, product_id, quantity_change, movement_change)
        VALUES (p_destination_warehouse_id, v_product_id, p_transfer_quantity, CURRENT_TIMESTAMP);

        -- 更新轉移數量
        UPDATE product
        SET product_quantity = product_quantity + p_transfer_quantity
        WHERE product_id = v_product_id;

        SELECT 'Product transfer successful.' AS result;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_updateproduct` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_updateproduct`(
    IN p_product_id INT,
    IN p_product_name VARCHAR(45),
    IN p_supplier_id INT,
    IN p_warhouse_id INT,
    IN p_product_quantity INT,
    IN p_product_price INT
)
BEGIN
    DECLARE v_supplier_exists INT;
    DECLARE v_warhouse_location VARCHAR(60);
    DECLARE v_current_quantity INT;
    DECLARE v_quantity_change INT;
    DECLARE v_movement_time DATETIME;

    -- 檢查供應商是否存在
    SELECT COUNT(*) INTO v_supplier_exists
    FROM supplier
    WHERE supplier_id = p_supplier_id;

    IF v_supplier_exists = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Supplier not found.';
    ELSE
        -- 檢查倉庫是否存在，並取得倉庫位置
        SELECT warhouse_location INTO v_warhouse_location
        FROM warhouse
        WHERE warhouse_id = p_warhouse_id;

        IF v_warhouse_location IS NULL THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Error: Warehouse not found.';
        ELSE
            -- 獲取當前產品數量
            SELECT product_quantity INTO v_current_quantity
            FROM product
            WHERE product_id = p_product_id;

            -- 計算數量變化
            SET v_quantity_change = p_product_quantity - v_current_quantity;

            -- 獲取當前時間
            SET v_movement_time = NOW();

            -- 更新產品資訊，包括位置和價格
            UPDATE product
            SET
                product_name = p_product_name,
                supplier_id = p_supplier_id,
                product_location = v_warhouse_location,
                product_quantity = p_product_quantity,
                product_price = p_product_price
            WHERE product_id = p_product_id;

            -- 新增數量變化和產品到 inventory_tracking
            INSERT INTO inventory_tracking (warhouse_id, product_id, quantity_change, movement_change)
            VALUES (p_warhouse_id, p_product_id, v_quantity_change, v_movement_time);
        END IF;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_updatesupplier` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_updatesupplier`(
    IN p_supplier_id INT,
    IN p_supplier_name VARCHAR(45)
)
BEGIN
    -- 檢查供應商是否存在
    DECLARE v_supplier_exists INT;
    SELECT COUNT(*) INTO v_supplier_exists
    FROM supplier
    WHERE supplier_id = p_supplier_id;

    IF v_supplier_exists = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Supplier not found.';
    ELSE
        -- 更新供應商信息
        UPDATE supplier
        SET supplier_name = p_supplier_name
        WHERE supplier_id = p_supplier_id;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_updatewarhouse` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_updatewarhouse`(
    IN p_warhouse_id INT,
    IN p_warhouse_name VARCHAR(60),
    IN p_warhouse_location VARCHAR(60)
)
BEGIN
    -- 檢查倉庫是否存在
    DECLARE v_warhouse_exists INT;
    SELECT COUNT(*) INTO v_warhouse_exists
    FROM warhouse
    WHERE warhouse_id = p_warhouse_id;

    IF v_warhouse_exists = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Warehouse not found.';
    ELSE
        -- 更新倉庫資訊
        UPDATE warhouse
        SET warhouse_name = p_warhouse_name, warhouse_location = p_warhouse_location
        WHERE warhouse_id = p_warhouse_id;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_update_orders` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_update_orders`(
    IN p_order_id INT,
    IN p_new_quantity INT
)
BEGIN
    DECLARE v_order_status VARCHAR(45);

    -- 檢查訂單是否存在並且未打包
    SELECT orders_statement INTO v_order_status
    FROM orders
    WHERE order_id = p_order_id;

    IF v_order_status IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Order not found.';
    ELSE
        IF v_order_status = 'Packed' THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Error: Cannot modify a packed order.';
        ELSE
            -- 更新訂單數量
            UPDATE orders
            SET orders_product_quantity = p_new_quantity
            WHERE order_id = p_order_id;

            SELECT 'Order updated successfully.' AS result;
        END IF;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_view_house` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_view_house`()
BEGIN
    -- 選擇所有倉庫的信息
    SELECT
        'Warehouse ID: ' AS result,
        warhouse_id AS warhouse_id_result,
        'Warehouse Location: ' AS location_result,
        warhouse_location AS warhouse_location_result
    FROM
        warhouse;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_view_inventory_tracking` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_view_inventory_tracking`()
BEGIN
    -- 選擇inventory_tracking表的內容
    SELECT
        inventory_tracking_id,
        warhouse_id,
        product_id,
        quantity_change,
        movement_change
    FROM
        inventory_tracking;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_view_orders` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_view_orders`()
BEGIN
    -- 查看所有訂單
    SELECT 
        o.order_id,
        o.manager_id,
        o.orders_product_name,
        o.orders_product_price,
        o.orders_product_quantity,
        o.orders_packed_time,
        o.orders_statement
    FROM 
        orders o;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_view_total_product_quantity` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_view_total_product_quantity`(
    IN p_product_name VARCHAR(45)
)
BEGIN
    DECLARE v_total_quantity INT;

    -- Calculate the total quantity of the product across all warehouses
    SELECT COALESCE(SUM(product_quantity), 0) INTO v_total_quantity
    FROM product
    WHERE product_name = p_product_name;

    -- Print the result
    SELECT
        'Product Name: ' AS result,
        p_product_name AS product_name_result,
        'Total Quantity: ' AS total_quantity_result,
        v_total_quantity AS total_quantity_result;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_view_warehouse` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_view_warehouse`(
    IN p_warehouse_location VARCHAR(60)
)
BEGIN
    -- 宣告變數
    DECLARE done INT DEFAULT 0;
    DECLARE v_product_id INT;
    DECLARE v_product_name VARCHAR(45);
    DECLARE v_product_quantity INT;
    DECLARE v_product_price DECIMAL(10, 2);

    -- 定義游標
    DECLARE cur CURSOR FOR
        SELECT
            p.product_id,
            p.product_name,
            p.product_quantity,
            p.product_price
        FROM
            product p
        LEFT JOIN
            tbl_warhouse_product wp ON p.product_id = wp.product_id
        WHERE
            p.product_location = p_warehouse_location;

    -- 定義例外
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    -- 開啟游標
    OPEN cur;

    -- 列印結果
    print_result: LOOP
        FETCH cur INTO
            v_product_id,
            v_product_name,
            v_product_quantity,
            v_product_price;

        IF done THEN
            LEAVE print_result;
        END IF;

        -- 使用 SELECT 將每個產品的資料作為一個獨立的結果輸出
        SELECT
            'Product ID: ' AS result,
            v_product_id AS product_id_result,
            'Product Name: ' AS product_result,
            v_product_name AS product_name_result,
            'Product Quantity: ' AS quantity_result,
            v_product_quantity AS product_quantity_result,
            'Product Price: ' AS price_result,
            v_product_price AS product_price_result;

    END LOOP;

    -- 關閉游標
    CLOSE cur;

    -- 如果沒有找到任何產品，則列印相應的消息
    IF v_product_id IS NULL THEN
        SELECT 'No products found in the specified warehouse.' AS result;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-12-24 17:48:00
