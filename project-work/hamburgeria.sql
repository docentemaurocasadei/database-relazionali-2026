-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: localhost    Database: hamburgeria
-- ------------------------------------------------------
-- Server version	8.0.42

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
-- Table structure for table `allergens`
--

DROP TABLE IF EXISTS `allergens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `allergens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `allergens`
--

LOCK TABLES `allergens` WRITE;
/*!40000 ALTER TABLE `allergens` DISABLE KEYS */;
INSERT INTO `allergens` VALUES (1,'Glutine','Cereali contenenti glutine'),(2,'Latte','Latte e derivati'),(3,'Uova','Uova e prodotti a base di uova'),(4,'Soia','Soia e derivati'),(5,'Senape','Senape e derivati'),(6,'Sesamo','Semi di sesamo'),(7,'Frutta a Guscio','Mandorle, nocciole, noci ecc'),(8,'Arachidi','Arachidi e derivati');
/*!40000 ALTER TABLE `allergens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`),
  KEY `idx_categories_slug` (`slug`),
  KEY `idx_categories_active` (`is_active`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'Burger Classici','burger-classici','I grandi classici della tradizione americana',1,'2026-02-11 08:40:37','2026-02-11 08:40:37'),(2,'Special Burger','special-burger','Ricette gourmet e stagionali',1,'2026-02-11 08:40:37','2026-02-11 08:40:37'),(3,'Vegetariani','vegetariani','Burger senza carne',1,'2026-02-11 08:40:37','2026-02-11 08:40:37'),(4,'Vegani','vegani','Proposte 100% vegetali',1,'2026-02-11 08:40:37','2026-02-11 08:40:37'),(5,'Gluten Free','gluten-free','Burger senza glutine',1,'2026-02-11 08:40:37','2026-02-11 08:40:37'),(6,'Menù Completi','menu-completi','Burger + patatine + bibita',1,'2026-02-11 08:40:37','2026-02-11 08:40:37'),(7,'Limited Edition','limited-edition','Edizioni limitate e speciali',1,'2026-02-11 08:40:37','2026-02-11 08:40:37');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dietary_preferences`
--

DROP TABLE IF EXISTS `dietary_preferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dietary_preferences` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`),
  KEY `idx_dietary_slug` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dietary_preferences`
--

LOCK TABLES `dietary_preferences` WRITE;
/*!40000 ALTER TABLE `dietary_preferences` DISABLE KEYS */;
INSERT INTO `dietary_preferences` VALUES (1,'Vegetariano','vegetariano','Non contiene carne o pesce'),(2,'Vegano','vegano','Non contiene ingredienti di origine animale'),(3,'Gluten Free','gluten-free','Senza glutine'),(4,'Lactose Free','lactose-free','Senza lattosio'),(5,'Halal','halal','Carne certificata Halal'),(6,'Keto','keto','Basso contenuto di carboidrati'),(7,'High Protein','high-protein','Alto contenuto proteico');
/*!40000 ALTER TABLE `dietary_preferences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ingredient_allergen`
--

DROP TABLE IF EXISTS `ingredient_allergen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ingredient_allergen` (
  `ingredient_id` bigint unsigned NOT NULL,
  `allergen_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`ingredient_id`,`allergen_id`),
  KEY `idx_ia_allergen` (`allergen_id`,`ingredient_id`),
  CONSTRAINT `ingredient_allergen_ibfk_1` FOREIGN KEY (`ingredient_id`) REFERENCES `ingredients` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ingredient_allergen_ibfk_2` FOREIGN KEY (`allergen_id`) REFERENCES `allergens` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ingredient_allergen`
--

LOCK TABLES `ingredient_allergen` WRITE;
/*!40000 ALTER TABLE `ingredient_allergen` DISABLE KEYS */;
INSERT INTO `ingredient_allergen` VALUES (1,1),(1,3),(5,4),(6,2),(15,5);
/*!40000 ALTER TABLE `ingredient_allergen` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ingredients`
--

DROP TABLE IF EXISTS `ingredients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ingredients` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_ingredients_active` (`is_active`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ingredients`
--

LOCK TABLES `ingredients` WRITE;
/*!40000 ALTER TABLE `ingredients` DISABLE KEYS */;
INSERT INTO `ingredients` VALUES (1,'Pane Brioche','Pane morbido con burro e uova',1,'2026-02-11 08:40:37','2026-02-11 08:40:37'),(2,'Pane Senza Glutine','Pane certificato gluten free',1,'2026-02-11 08:40:37','2026-02-11 08:40:37'),(3,'Hamburger Manzo 150gr','Carne bovina 100% italiana',1,'2026-02-11 08:40:37','2026-02-11 08:40:37'),(4,'Hamburger Manzo 250gr','Carne bovina 100% italiana',1,'2026-02-11 08:40:37','2026-02-11 08:40:37'),(5,'Burger Vegetale','Burger a base di proteine vegetali',1,'2026-02-11 08:40:37','2026-02-11 08:40:37'),(6,'Cheddar','Formaggio cheddar fuso',1,'2026-02-11 08:40:37','2026-02-11 08:40:37'),(7,'Bacon','Pancetta croccante',1,'2026-02-11 08:40:37','2026-02-11 08:40:37'),(8,'Insalata','Lattuga fresca',1,'2026-02-11 08:40:37','2026-02-11 08:40:37'),(9,'Pomodoro','Pomodoro fresco a fette',1,'2026-02-11 08:40:37','2026-02-11 08:40:37'),(10,'Cipolla','Cipolla fresca',1,'2026-02-11 08:40:37','2026-02-11 08:40:37'),(11,'Cipolla Caramellata','Cipolla stufata con zucchero di canna',1,'2026-02-11 08:40:37','2026-02-11 08:40:37'),(12,'Salsa BBQ','Salsa barbecue affumicata',1,'2026-02-11 08:40:37','2026-02-11 08:40:37'),(13,'Maionese','Maionese classica',1,'2026-02-11 08:40:37','2026-02-11 08:40:37'),(14,'Ketchup','Salsa ketchup',1,'2026-02-11 08:40:37','2026-02-11 08:40:37'),(15,'Senape','Senape delicata',1,'2026-02-11 08:40:37','2026-02-11 08:40:37'),(16,'Jalapeños','Peperoncini piccanti messicani',1,'2026-02-11 08:40:37','2026-02-11 08:40:37'),(17,'Uovo','Uovo fresco alla piastra',1,'2026-02-11 08:40:37','2026-02-11 08:40:37'),(18,'Avocado','Fette di avocado fresco',1,'2026-02-11 08:40:37','2026-02-11 08:40:37');
/*!40000 ALTER TABLE `ingredients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_category`
--

DROP TABLE IF EXISTS `product_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_category` (
  `product_id` bigint unsigned NOT NULL,
  `category_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`product_id`,`category_id`),
  KEY `idx_pc_category` (`category_id`,`product_id`),
  CONSTRAINT `product_category_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product_category_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_category`
--

LOCK TABLES `product_category` WRITE;
/*!40000 ALTER TABLE `product_category` DISABLE KEYS */;
INSERT INTO `product_category` VALUES (1,1),(2,1),(3,1),(3,2),(4,1),(4,2),(5,1),(5,2),(6,1),(6,3),(7,1),(7,4),(8,1),(8,2),(9,1),(9,2),(10,1),(11,1),(12,1),(13,1),(14,1),(14,5),(15,1),(16,1),(16,2),(17,1),(17,2),(18,1),(18,2),(19,1),(20,1),(20,7);
/*!40000 ALTER TABLE `product_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_dietary_preference`
--

DROP TABLE IF EXISTS `product_dietary_preference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_dietary_preference` (
  `product_id` bigint unsigned NOT NULL,
  `dietary_preference_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`product_id`,`dietary_preference_id`),
  KEY `idx_pdp_pref` (`dietary_preference_id`,`product_id`),
  CONSTRAINT `product_dietary_preference_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product_dietary_preference_ibfk_2` FOREIGN KEY (`dietary_preference_id`) REFERENCES `dietary_preferences` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_dietary_preference`
--

LOCK TABLES `product_dietary_preference` WRITE;
/*!40000 ALTER TABLE `product_dietary_preference` DISABLE KEYS */;
INSERT INTO `product_dietary_preference` VALUES (6,1),(7,1),(7,2),(13,6),(14,3),(15,5),(19,7);
/*!40000 ALTER TABLE `product_dietary_preference` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_images`
--

DROP TABLE IF EXISTS `product_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_images` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `product_id` bigint unsigned NOT NULL,
  `image_path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `alt_text` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sort_order` int DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_images_product` (`product_id`),
  CONSTRAINT `fk_image_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_images`
--

LOCK TABLES `product_images` WRITE;
/*!40000 ALTER TABLE `product_images` DISABLE KEYS */;
INSERT INTO `product_images` VALUES (1,1,'images/burgers/classico-italiano.jpg','Classico Italiano',1,'2026-02-11 08:59:12','2026-02-11 08:59:12'),(2,2,'images/burgers/doppio-bbq.jpg','Doppio BBQ',1,'2026-02-11 08:59:12','2026-02-11 08:59:12'),(3,3,'images/burgers/esplosione-formaggi.jpg','Esplosione di Formaggi',1,'2026-02-11 08:59:12','2026-02-11 08:59:12'),(4,4,'images/burgers/messicano-piccante.jpg','Messicano Piccante',1,'2026-02-11 08:59:12','2026-02-11 08:59:12'),(5,5,'images/burgers/gourmet-tricolore.jpg','Gourmet Tricolore',1,'2026-02-11 08:59:12','2026-02-11 08:59:12'),(6,6,'images/burgers/vegetariano-verde.jpg','Vegetariano Verde',1,'2026-02-11 08:59:12','2026-02-11 08:59:12'),(7,7,'images/burgers/vegano-mediterraneo.jpg','Vegano Mediterraneo',1,'2026-02-11 08:59:12','2026-02-11 08:59:12'),(8,8,'images/burgers/amante-del-bacon.jpg','Amante del Bacon',1,'2026-02-11 08:59:12','2026-02-11 08:59:12'),(9,9,'images/burgers/affumicato-americano.jpg','Affumicato Americano',1,'2026-02-11 08:59:12','2026-02-11 08:59:12'),(10,10,'images/burgers/tradizionale-americano.jpg','Tradizionale Americano',1,'2026-02-11 08:59:12','2026-02-11 08:59:12'),(11,11,'images/burgers/croccante-di-pollo.jpg','Croccante di Pollo',1,'2026-02-11 08:59:12','2026-02-11 08:59:12'),(12,12,'images/burgers/diavolo-rosso.jpg','Diavolo Rosso',1,'2026-02-11 08:59:12','2026-02-11 08:59:12'),(13,13,'images/burgers/keto-protein.jpg','Keto Protein',1,'2026-02-11 08:59:12','2026-02-11 08:59:12'),(14,14,'images/burgers/senza-glutine-speciale.jpg','Senza Glutine Speciale',1,'2026-02-11 08:59:12','2026-02-11 08:59:12'),(15,15,'images/burgers/smash-halal.jpg','Smash Halal',1,'2026-02-11 08:59:12','2026-02-11 08:59:12'),(16,16,'images/burgers/avocado-deluxe.jpg','Avocado Deluxe',1,'2026-02-11 08:59:12','2026-02-11 08:59:12'),(17,17,'images/burgers/torre-tripla.jpg','Torre Tripla',1,'2026-02-11 08:59:12','2026-02-11 08:59:12'),(18,18,'images/burgers/street-bbq.jpg','Street BBQ',1,'2026-02-11 08:59:12','2026-02-11 08:59:12'),(19,19,'images/burgers/fit-proteico.jpg','Fit Proteico',1,'2026-02-11 08:59:12','2026-02-11 08:59:12'),(20,20,'images/burgers/black-edition-limitata.jpg','Black Edition Limitata',1,'2026-02-11 08:59:12','2026-02-11 08:59:12');
/*!40000 ALTER TABLE `product_images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_ingredient`
--

DROP TABLE IF EXISTS `product_ingredient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_ingredient` (
  `product_id` bigint unsigned NOT NULL,
  `ingredient_id` bigint unsigned NOT NULL,
  `is_optional` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`product_id`,`ingredient_id`),
  KEY `idx_pi_ingredient` (`ingredient_id`,`product_id`),
  CONSTRAINT `product_ingredient_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product_ingredient_ibfk_2` FOREIGN KEY (`ingredient_id`) REFERENCES `ingredients` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_ingredient`
--

LOCK TABLES `product_ingredient` WRITE;
/*!40000 ALTER TABLE `product_ingredient` DISABLE KEYS */;
INSERT INTO `product_ingredient` VALUES (1,1,0),(1,3,0),(1,6,0),(1,8,0),(1,9,0),(2,1,0),(2,3,0),(2,6,0),(2,8,0),(2,9,0),(3,1,0),(3,3,0),(3,6,0),(3,8,0),(3,9,0),(4,1,0),(4,3,0),(4,6,0),(4,8,0),(4,9,0),(4,12,0),(4,16,0),(5,1,0),(5,3,0),(5,6,0),(5,8,0),(5,9,0),(6,1,0),(6,5,0),(6,8,0),(6,9,0),(6,18,0),(7,5,0),(7,8,0),(7,9,0),(8,1,0),(8,3,0),(8,6,0),(8,7,0),(8,8,0),(8,9,0),(9,1,0),(9,3,0),(9,6,0),(9,8,0),(9,9,0),(10,1,0),(10,3,0),(10,6,0),(10,8,0),(10,9,0),(11,1,0),(11,3,0),(11,6,0),(11,8,0),(11,9,0),(12,1,0),(12,3,0),(12,6,0),(12,8,0),(12,9,0),(13,1,0),(13,3,0),(13,6,0),(13,8,0),(13,9,0),(14,2,0),(14,3,0),(14,6,0),(14,8,0),(14,9,0),(15,1,0),(15,3,0),(15,6,0),(15,8,0),(15,9,0),(16,1,0),(16,3,0),(16,6,0),(16,8,0),(16,9,0),(17,1,0),(17,3,0),(17,6,0),(17,8,0),(17,9,0),(18,1,0),(18,3,0),(18,6,0),(18,8,0),(18,9,0),(19,1,0),(19,3,0),(19,6,0),(19,8,0),(19,9,0),(20,1,0),(20,3,0),(20,6,0),(20,8,0),(20,9,0);
/*!40000 ALTER TABLE `product_ingredient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_variants`
--

DROP TABLE IF EXISTS `product_variants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_variants` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `product_id` bigint unsigned NOT NULL,
  `sku` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price` decimal(8,2) NOT NULL,
  `weight_grams` int DEFAULT NULL,
  `is_default` tinyint(1) DEFAULT '0',
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sku` (`sku`),
  KEY `idx_variants_product` (`product_id`),
  KEY `idx_variants_price` (`price`),
  KEY `idx_variants_active` (`is_active`),
  CONSTRAINT `fk_variant_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_variants`
--

LOCK TABLES `product_variants` WRITE;
/*!40000 ALTER TABLE `product_variants` DISABLE KEYS */;
INSERT INTO `product_variants` VALUES (1,1,'BUR001-150',8.90,150,1,1,'2026-02-11 08:46:06','2026-02-11 08:46:06'),(2,2,'BUR002-150',11.90,150,1,1,'2026-02-11 08:46:06','2026-02-11 08:46:06'),(3,3,'BUR003-150',10.50,150,1,1,'2026-02-11 08:46:06','2026-02-11 08:46:06'),(4,4,'BUR004-150',9.90,150,1,1,'2026-02-11 08:46:06','2026-02-11 08:46:06'),(5,5,'BUR005-150',10.90,150,1,1,'2026-02-11 08:46:06','2026-02-11 08:46:06'),(6,8,'BUR008-150',11.50,150,1,1,'2026-02-11 08:46:06','2026-02-11 08:46:06'),(7,9,'BUR009-150',10.90,150,1,1,'2026-02-11 08:46:06','2026-02-11 08:46:06'),(8,10,'BUR010-150',8.50,150,1,1,'2026-02-11 08:46:06','2026-02-11 08:46:06'),(9,11,'BUR011-150',8.90,150,1,1,'2026-02-11 08:46:06','2026-02-11 08:46:06'),(10,12,'BUR012-150',10.90,150,1,1,'2026-02-11 08:46:06','2026-02-11 08:46:06'),(11,13,'BUR013-150',9.90,150,1,1,'2026-02-11 08:46:06','2026-02-11 08:46:06'),(12,14,'BUR014-150',10.90,150,1,1,'2026-02-11 08:46:06','2026-02-11 08:46:06'),(13,15,'BUR015-150',9.90,150,1,1,'2026-02-11 08:46:06','2026-02-11 08:46:06'),(14,16,'BUR016-150',11.90,150,1,1,'2026-02-11 08:46:06','2026-02-11 08:46:06'),(15,18,'BUR018-150',9.90,150,1,1,'2026-02-11 08:46:06','2026-02-11 08:46:06'),(16,19,'BUR019-150',9.50,150,1,1,'2026-02-11 08:46:06','2026-02-11 08:46:06'),(17,20,'BUR020-150',12.90,150,1,1,'2026-02-11 08:46:06','2026-02-11 08:46:06'),(32,1,'BUR001-250',11.90,250,0,1,'2026-02-11 08:46:09','2026-02-11 08:46:09'),(33,2,'BUR002-250',14.90,250,0,1,'2026-02-11 08:46:09','2026-02-11 08:46:09'),(34,3,'BUR003-250',13.50,250,0,1,'2026-02-11 08:46:09','2026-02-11 08:46:09'),(35,4,'BUR004-250',12.90,250,0,1,'2026-02-11 08:46:09','2026-02-11 08:46:09'),(36,5,'BUR005-250',13.90,250,0,1,'2026-02-11 08:46:09','2026-02-11 08:46:09'),(37,8,'BUR008-250',14.50,250,0,1,'2026-02-11 08:46:09','2026-02-11 08:46:09'),(38,9,'BUR009-250',13.90,250,0,1,'2026-02-11 08:46:09','2026-02-11 08:46:09'),(39,10,'BUR010-250',11.50,250,0,1,'2026-02-11 08:46:09','2026-02-11 08:46:09'),(40,11,'BUR011-250',11.90,250,0,1,'2026-02-11 08:46:09','2026-02-11 08:46:09'),(41,12,'BUR012-250',13.90,250,0,1,'2026-02-11 08:46:09','2026-02-11 08:46:09'),(42,13,'BUR013-250',12.90,250,0,1,'2026-02-11 08:46:09','2026-02-11 08:46:09'),(43,14,'BUR014-250',13.90,250,0,1,'2026-02-11 08:46:09','2026-02-11 08:46:09'),(44,15,'BUR015-250',12.90,250,0,1,'2026-02-11 08:46:09','2026-02-11 08:46:09'),(45,16,'BUR016-250',14.90,250,0,1,'2026-02-11 08:46:09','2026-02-11 08:46:09'),(46,18,'BUR018-250',12.90,250,0,1,'2026-02-11 08:46:09','2026-02-11 08:46:09'),(47,19,'BUR019-250',12.50,250,0,1,'2026-02-11 08:46:09','2026-02-11 08:46:09'),(48,20,'BUR020-250',15.90,250,0,1,'2026-02-11 08:46:09','2026-02-11 08:46:09'),(63,6,'BUR006-150',9.50,150,1,1,'2026-02-11 08:46:14','2026-02-11 08:46:14'),(64,7,'BUR007-150',9.90,150,1,1,'2026-02-11 08:46:14','2026-02-11 08:46:14'),(66,17,'BUR017-350',16.90,350,1,1,'2026-02-11 08:46:19','2026-02-11 08:46:19');
/*!40000 ALTER TABLE `product_variants` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `base_price` decimal(8,2) NOT NULL DEFAULT '0.00',
  `sku` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`),
  UNIQUE KEY `sku` (`sku`),
  KEY `idx_products_slug` (`slug`),
  KEY `idx_products_active` (`is_active`),
  FULLTEXT KEY `ft_products_search` (`name`,`description`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'Classico Italiano','classico-italiano','Hamburger tradizionale con cheddar e salsa burger',8.90,'BUR001',1,'2026-02-11 08:45:19','2026-02-11 08:45:19'),(2,'Doppio BBQ','doppio-bbq','Doppio hamburger con bacon croccante e salsa BBQ',11.90,'BUR002',1,'2026-02-11 08:45:19','2026-02-11 08:45:19'),(3,'Esplosione di Formaggi','esplosione-formaggi','Triplo formaggio filante',10.50,'BUR003',1,'2026-02-11 08:45:19','2026-02-11 08:45:19'),(4,'Messicano Piccante','messicano-piccante','Jalapeños e salsa piccante',9.90,'BUR004',1,'2026-02-11 08:45:19','2026-02-11 08:45:19'),(5,'Gourmet Tricolore','gourmet-tricolore','Mozzarella, pomodoro e rucola',10.90,'BUR005',1,'2026-02-11 08:45:19','2026-02-11 08:45:19'),(6,'Vegetariano Verde','vegetariano-verde','Burger vegetale con avocado',9.50,'BUR006',1,'2026-02-11 08:45:19','2026-02-11 08:45:19'),(7,'Vegano Mediterraneo','vegano-mediterraneo','Burger vegano con verdure grigliate',9.90,'BUR007',1,'2026-02-11 08:45:19','2026-02-11 08:45:19'),(8,'Amante del Bacon','amante-del-bacon','Extra bacon croccante',11.50,'BUR008',1,'2026-02-11 08:45:19','2026-02-11 08:45:19'),(9,'Affumicato Americano','affumicato-americano','Salsa BBQ affumicata',10.90,'BUR009',1,'2026-02-11 08:45:19','2026-02-11 08:45:19'),(10,'Tradizionale Americano','tradizionale-americano','Pane brioche e manzo 100%',8.50,'BUR010',1,'2026-02-11 08:45:19','2026-02-11 08:45:19'),(11,'Croccante di Pollo','croccante-di-pollo','Petto di pollo panato e croccante',8.90,'BUR011',1,'2026-02-11 08:45:19','2026-02-11 08:45:19'),(12,'Diavolo Rosso','diavolo-rosso','Piccantezza estrema',10.90,'BUR012',1,'2026-02-11 08:45:19','2026-02-11 08:45:19'),(13,'Keto Protein','keto-protein','Senza pane, low carb',9.90,'BUR013',1,'2026-02-11 08:45:19','2026-02-11 08:45:19'),(14,'Senza Glutine Speciale','senza-glutine-speciale','Pane certificato gluten free',10.90,'BUR014',1,'2026-02-11 08:45:19','2026-02-11 08:45:19'),(15,'Smash Halal','smash-halal','Carne certificata Halal',9.90,'BUR015',1,'2026-02-11 08:45:19','2026-02-11 08:45:19'),(16,'Avocado Deluxe','avocado-deluxe','Avocado fresco e cheddar premium',11.90,'BUR016',1,'2026-02-11 08:45:19','2026-02-11 08:45:19'),(17,'Torre Tripla','torre-tripla','Tre hamburger e triplo formaggio',14.90,'BUR017',1,'2026-02-11 08:45:19','2026-02-11 08:45:19'),(18,'Street BBQ','street-bbq','Stile street food affumicato',9.90,'BUR018',1,'2026-02-11 08:45:19','2026-02-11 08:45:19'),(19,'Fit Proteico','fit-proteico','Hamburger leggero e proteico',9.50,'BUR019',1,'2026-02-11 08:45:19','2026-02-11 08:45:19'),(20,'Black Edition Limitata','black-edition-limitata','Pane nero al carbone',12.90,'BUR020',1,'2026-02-11 08:45:19','2026-02-11 08:45:19');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `v_check_gluten_free_errors`
--

DROP TABLE IF EXISTS `v_check_gluten_free_errors`;
/*!50001 DROP VIEW IF EXISTS `v_check_gluten_free_errors`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_check_gluten_free_errors` AS SELECT 
 1 AS `id`,
 1 AS `name`,
 1 AS `ingredienti_con_glutine`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_check_vegan_errors`
--

DROP TABLE IF EXISTS `v_check_vegan_errors`;
/*!50001 DROP VIEW IF EXISTS `v_check_vegan_errors`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_check_vegan_errors` AS SELECT 
 1 AS `id`,
 1 AS `name`,
 1 AS `allergeni_animali_trovati`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_product_full_json`
--

DROP TABLE IF EXISTS `v_product_full_json`;
/*!50001 DROP VIEW IF EXISTS `v_product_full_json`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_product_full_json` AS SELECT 
 1 AS `id`,
 1 AS `product_json`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_product_full_json_complete`
--

DROP TABLE IF EXISTS `v_product_full_json_complete`;
/*!50001 DROP VIEW IF EXISTS `v_product_full_json_complete`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_product_full_json_complete` AS SELECT 
 1 AS `id`,
 1 AS `product_json`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_products_full_allergens`
--

DROP TABLE IF EXISTS `v_products_full_allergens`;
/*!50001 DROP VIEW IF EXISTS `v_products_full_allergens`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_products_full_allergens` AS SELECT 
 1 AS `id`,
 1 AS `name`,
 1 AS `allergeni`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `v_check_gluten_free_errors`
--

/*!50001 DROP VIEW IF EXISTS `v_check_gluten_free_errors`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_check_gluten_free_errors` AS select `p`.`id` AS `id`,`p`.`name` AS `name`,group_concat(distinct `i`.`name` separator ',') AS `ingredienti_con_glutine` from ((((`products` `p` join `product_dietary_preference` `pdp` on((`p`.`id` = `pdp`.`product_id`))) join `product_ingredient` `pi` on((`p`.`id` = `pi`.`product_id`))) join `ingredient_allergen` `ia` on((`pi`.`ingredient_id` = `ia`.`ingredient_id`))) join `ingredients` `i` on((`pi`.`ingredient_id` = `i`.`id`))) where ((`pdp`.`dietary_preference_id` = 3) and (`ia`.`allergen_id` = 1)) group by `p`.`id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_check_vegan_errors`
--

/*!50001 DROP VIEW IF EXISTS `v_check_vegan_errors`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_check_vegan_errors` AS select `p`.`id` AS `id`,`p`.`name` AS `name`,group_concat(distinct `a`.`name` separator ',') AS `allergeni_animali_trovati` from ((((`products` `p` join `product_dietary_preference` `pdp` on((`p`.`id` = `pdp`.`product_id`))) join `product_ingredient` `pi` on((`p`.`id` = `pi`.`product_id`))) join `ingredient_allergen` `ia` on((`pi`.`ingredient_id` = `ia`.`ingredient_id`))) join `allergens` `a` on((`ia`.`allergen_id` = `a`.`id`))) where ((`pdp`.`dietary_preference_id` = 2) and (`ia`.`allergen_id` in (2,3))) group by `p`.`id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_product_full_json`
--

/*!50001 DROP VIEW IF EXISTS `v_product_full_json`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_product_full_json` AS select `p`.`id` AS `id`,json_object('id',`p`.`id`,'nome',`p`.`name`,'descrizione',`p`.`description`,'prezzo_base',`p`.`base_price`,'categorie',(select json_arrayagg(`x`.`name`) from (select distinct `c`.`name` AS `name` from (`product_category` `pc` join `categories` `c` on((`pc`.`category_id` = `c`.`id`))) where (`pc`.`product_id` = `p`.`id`)) `x`),'allergeni',(select json_arrayagg(`x`.`name`) from (select distinct `a`.`name` AS `name` from ((`product_ingredient` `pi` join `ingredient_allergen` `ia` on((`pi`.`ingredient_id` = `ia`.`ingredient_id`))) join `allergens` `a` on((`ia`.`allergen_id` = `a`.`id`))) where (`pi`.`product_id` = `p`.`id`)) `x`),'ingredienti',(select json_arrayagg(`x`.`name`) from (select distinct `i`.`name` AS `name` from (`product_ingredient` `pi` join `ingredients` `i` on((`pi`.`ingredient_id` = `i`.`id`))) where (`pi`.`product_id` = `p`.`id`)) `x`),'preferenze_dieta',(select json_arrayagg(`x`.`name`) from (select distinct `dp`.`name` AS `name` from (`product_dietary_preference` `pdp` join `dietary_preferences` `dp` on((`pdp`.`dietary_preference_id` = `dp`.`id`))) where (`pdp`.`product_id` = `p`.`id`)) `x`),'immagine',(select `pi`.`image_path` from `product_images` `pi` where (`pi`.`product_id` = `p`.`id`) order by `pi`.`sort_order` limit 1),'varianti',(select json_arrayagg(json_object('peso_grammi',`pv`.`weight_grams`,'prezzo',`pv`.`price`,'default',`pv`.`is_default`)) from `product_variants` `pv` where (`pv`.`product_id` = `p`.`id`))) AS `product_json` from `products` `p` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_product_full_json_complete`
--

/*!50001 DROP VIEW IF EXISTS `v_product_full_json_complete`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_product_full_json_complete` AS select `p`.`id` AS `id`,json_object('id',`p`.`id`,'nome',`p`.`name`,'descrizione',`p`.`description`,'prezzo_base',`p`.`base_price`,'prezzo_minimo',(select min(`pv`.`price`) from `product_variants` `pv` where (`pv`.`product_id` = `p`.`id`)),'categorie',(select json_arrayagg(`x`.`name`) from (select distinct `c`.`name` AS `name` from (`product_category` `pc` join `categories` `c` on((`pc`.`category_id` = `c`.`id`))) where (`pc`.`product_id` = `p`.`id`)) `x`),'allergeni',(select json_arrayagg(`x`.`name`) from (select distinct `a`.`name` AS `name` from ((`product_ingredient` `pi` join `ingredient_allergen` `ia` on((`pi`.`ingredient_id` = `ia`.`ingredient_id`))) join `allergens` `a` on((`ia`.`allergen_id` = `a`.`id`))) where (`pi`.`product_id` = `p`.`id`)) `x`),'ingredienti',(select json_arrayagg(`x`.`name`) from (select distinct `i`.`name` AS `name` from (`product_ingredient` `pi` join `ingredients` `i` on((`pi`.`ingredient_id` = `i`.`id`))) where (`pi`.`product_id` = `p`.`id`)) `x`),'preferenze_dieta',(select json_arrayagg(`x`.`name`) from (select distinct `dp`.`name` AS `name` from (`product_dietary_preference` `pdp` join `dietary_preferences` `dp` on((`pdp`.`dietary_preference_id` = `dp`.`id`))) where (`pdp`.`product_id` = `p`.`id`)) `x`),'immagine_principale',(select `pi`.`image_path` from `product_images` `pi` where (`pi`.`product_id` = `p`.`id`) order by `pi`.`sort_order` limit 1),'gallery',(select json_arrayagg(`pi`.`image_path`) from `product_images` `pi` where (`pi`.`product_id` = `p`.`id`)),'varianti',(select json_arrayagg(json_object('peso_grammi',`pv`.`weight_grams`,'prezzo',`pv`.`price`,'default',`pv`.`is_default`)) from `product_variants` `pv` where (`pv`.`product_id` = `p`.`id`))) AS `product_json` from `products` `p` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_products_full_allergens`
--

/*!50001 DROP VIEW IF EXISTS `v_products_full_allergens`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_products_full_allergens` AS select `p`.`id` AS `id`,`p`.`name` AS `name`,group_concat(distinct `a`.`name` order by `a`.`name` ASC separator ', ') AS `allergeni` from (((`products` `p` left join `product_ingredient` `pi` on((`p`.`id` = `pi`.`product_id`))) left join `ingredient_allergen` `ia` on((`pi`.`ingredient_id` = `ia`.`ingredient_id`))) left join `allergens` `a` on((`ia`.`allergen_id` = `a`.`id`))) group by `p`.`id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-02-11 10:36:00
