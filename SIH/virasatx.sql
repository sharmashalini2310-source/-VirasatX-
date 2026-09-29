-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: localhost    Database: virasatx
-- ------------------------------------------------------
-- Server version	8.0.46

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `levels`
--

DROP TABLE IF EXISTS `levels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `levels` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `theme_id` int unsigned NOT NULL,
  `level_number` int NOT NULL,
  `level_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `difficulty` enum('Easy','Medium','Hard') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Easy',
  `intro_text` text COLLATE utf8mb4_unicode_ci,
  `reward_points` int NOT NULL DEFAULT '100',
  `is_locked` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `theme_id` (`theme_id`,`level_number`),
  KEY `idx_levels_theme` (`theme_id`),
  CONSTRAINT `levels_ibfk_1` FOREIGN KEY (`theme_id`) REFERENCES `themes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `levels`
--

LOCK TABLES `levels` WRITE;
/*!40000 ALTER TABLE `levels` DISABLE KEYS */;
INSERT INTO `levels` VALUES (1,1,1,'Origins','Explore ideas of creation and the cosmos.','Easy','Begin your exploration of ancient Indian cosmological ideas.',100,0),(2,1,2,'Cycles of Time','Discover ideas of vast cycles of time.','Medium','Journey through concepts of cyclical time.',150,0),(3,1,3,'Yugas & Kaalchakra','Explore traditional concepts of ages and cycles.','Hard','Complete the challenge of time and cycles.',200,0),(4,1,4,'Cosmic Challenge','A mixed challenge covering the theme.','Hard','Put your knowledge together in the final challenge.',300,0),(5,2,1,'Early Civilizations','Explore cities and early urban life.','Easy','Discover the foundations of ancient urban civilization.',100,0),(6,2,2,'Knowledge Systems','Explore mathematics, astronomy, medicine and learning.','Medium','Enter a world shaped by knowledge and learning.',150,0),(7,2,3,'Culture & Society','Explore art, architecture, literature and society.','Medium','Explore the cultural diversity of ancient Bharat.',200,0),(8,2,4,'Civilization Challenge','A mixed challenge covering ancient Bharat.','Hard','Test your knowledge across the realm.',300,0),(9,3,1,'Colonial Transformation','Understand major changes during colonial rule.','Easy','Explore a period of major social and economic transformation.',100,0),(10,3,2,'Resistance','Explore different forms of resistance and reform.','Medium','Discover how people and communities responded to colonial rule.',150,0),(11,3,3,'Freedom Movement','Explore important phases of the independence movement.','Medium','Follow key developments in the freedom movement.',200,0),(12,3,4,'History Challenge','A mixed historical challenge.','Hard','Test your understanding of the era.',300,0),(13,4,1,'Digital India','Explore digital technology and transformation.','Easy','Enter a rapidly changing technological landscape.',100,0),(14,4,2,'Innovation','Explore science, startups and innovation.','Medium','Discover how innovation shapes modern India.',150,0),(15,4,3,'Future India','Explore emerging technologies and future possibilities.','Medium','Imagine the technologies shaping tomorrow.',200,0),(16,4,4,'Future Challenge','A mixed challenge covering present India.','Hard','Complete the final challenge of the realm.',300,0);
/*!40000 ALTER TABLE `levels` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `question_options`
--

DROP TABLE IF EXISTS `question_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `question_options` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `question_id` int unsigned NOT NULL,
  `option_key` char(1) COLLATE utf8mb4_unicode_ci NOT NULL,
  `option_text` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_correct` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `question_id` (`question_id`,`option_key`),
  KEY `idx_options_question` (`question_id`),
  CONSTRAINT `question_options_ibfk_1` FOREIGN KEY (`question_id`) REFERENCES `questions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=117 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `question_options`
--

LOCK TABLES `question_options` WRITE;
/*!40000 ALTER TABLE `question_options` DISABLE KEYS */;
INSERT INTO `question_options` VALUES (33,1,'A','The creation of the universe',1),(34,1,'B','The British Empire',0),(35,1,'C','The Industrial Revolution',0),(36,1,'D','The Digital Age',0),(37,2,'A','Indus Valley Civilization',1),(38,2,'B','Roman Civilization',0),(39,2,'C','Egyptian Civilization',0),(40,2,'D','Greek Civilization',0),(41,3,'A','Planned streets and drainage systems',1),(42,3,'B','Large medieval castles',0),(43,3,'C','Railway networks',0),(44,3,'D','Modern skyscrapers',0),(45,4,'A','Planned urban development',1),(46,4,'B','A temporary military camp',0),(47,4,'C','A nomadic settlement',0),(48,4,'D','A natural forest settlement',0),(49,5,'A','Standardized fired bricks',1),(50,5,'B','Reinforced concrete',0),(51,5,'C','Modern steel blocks',0),(52,5,'D','Plastic bricks',0),(53,6,'A','Planned streets, wells and drainage',1),(54,6,'B','Only the presence of weapons',0),(55,6,'C','Only the size of the settlement',0),(56,6,'D','The presence of modern machinery',0),(57,7,'A','Brahmagupta',1),(58,7,'B','Kalidasa',0),(59,7,'C','Panini',0),(60,7,'D','Charaka',0),(61,8,'A','Aryabhatiya',1),(62,8,'B','Arthashastra',0),(63,8,'C','Natya Shastra',0),(64,8,'D','Charaka Samhita',0),(65,9,'A','Mathematics',1),(66,9,'B','Music',0),(67,9,'C','Architecture alone',0),(68,9,'D','Agriculture alone',0),(69,10,'A','Aryabhata',1),(70,10,'B','Sushruta',0),(71,10,'C','Chanakya',0),(72,10,'D','Valmiki',0),(73,11,'A','Mathematics and astronomy',1),(74,11,'B','Poetry and painting',0),(75,11,'C','Trade and sculpture',0),(76,11,'D','Music and theatre',0),(77,12,'A','Natya Shastra',1),(78,12,'B','Arthashastra',0),(79,12,'C','Rigveda',0),(80,12,'D','Sushruta Samhita',0),(81,13,'A','Decorated pillars and sacred spaces',1),(82,13,'B','Modern glass facades',0),(83,13,'C','Steel suspension bridges',0),(84,13,'D','Industrial factory chimneys',0),(85,14,'A','Organized social life and specialized craftsmanship',1),(86,14,'B','A completely nomadic lifestyle',0),(87,14,'C','A modern industrial society',0),(88,14,'D','An isolated natural environment',0),(89,15,'A','Stone',1),(90,15,'B','Plastic',0),(91,15,'C','Carbon fibre',0),(92,15,'D','Synthetic rubber',0),(93,16,'A','The community had developed social and economic organization',1),(94,16,'B','The community had no specialized skills',0),(95,16,'C','The settlement was necessarily temporary',0),(96,16,'D','The community depended entirely on modern technology',0),(97,17,'A','Indus Valley Civilization',1),(98,17,'B','Roman Civilization',0),(99,17,'C','Medieval European Civilization',0),(100,17,'D','Industrial-era Civilization',0),(101,18,'A','Aryabhata ? Mathematics and Astronomy',1),(102,18,'B','Aryabhata ? Modern Engineering',0),(103,18,'C','Kalidasa ? Industrial Chemistry',0),(104,18,'D','Charaka ? Computer Science',0),(105,19,'A','An organized society with specialized crafts and economic networks',1),(106,19,'B','A society with no permanent settlement',0),(107,19,'C','A completely isolated community',0),(108,19,'D','A modern industrial city',0),(109,20,'A','Urban planning, mathematics, astronomy, arts and crafts',1),(110,20,'B','Only military technology',0),(111,20,'C','Only agricultural practices',0),(112,20,'D','Only religious architecture',0),(113,21,'A','A complex society with developed urban, intellectual, artistic and economic traditions',1),(114,21,'B','A society with no organized knowledge systems',0),(115,21,'C','A purely nomadic community without specialized crafts',0),(116,21,'D','A modern industrial society',0);
/*!40000 ALTER TABLE `question_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `questions`
--

DROP TABLE IF EXISTS `questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `questions` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `level_id` int unsigned NOT NULL,
  `question_text` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `question_type` enum('MCQ','TRUE_FALSE') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'MCQ',
  `explanation` text COLLATE utf8mb4_unicode_ci,
  `points` int NOT NULL DEFAULT '10',
  `question_order` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `idx_questions_level` (`level_id`),
  CONSTRAINT `questions_ibfk_1` FOREIGN KEY (`level_id`) REFERENCES `levels` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questions`
--

LOCK TABLES `questions` WRITE;
/*!40000 ALTER TABLE `questions` DISABLE KEYS */;
INSERT INTO `questions` VALUES (1,1,'According to the Cosmology theme, what does the universe begin with?','MCQ','This question introduces the Origins level of the Cosmology theme.',10,1),(2,5,'Which ancient civilization is associated with planned cities such as Harappa and Mohenjo-daro?','MCQ','Harappa and Mohenjo-daro are major archaeological sites associated with the Indus Valley Civilization.',10,1),(3,5,'Which feature is strongly associated with cities of the Indus Valley Civilization?','MCQ','Many Indus Valley cities are known for planned streets, drainage systems and organized urban layouts.',10,2),(4,5,'Puzzle: A city is divided into streets that meet at organized angles, with houses connected to a drainage system. What does this most strongly suggest?','MCQ','An organized street and drainage network suggests planned urban development.',15,3),(5,5,'Which material was commonly used to make standardized bricks in many Indus Valley settlements?','MCQ','Standardized fired bricks were widely used in construction at many Indus Valley sites.',10,4),(6,5,'Challenge: Archaeologists find a settlement with planned streets, wells and an advanced drainage network. Which clue would be most useful for identifying it as an urban civilization?','MCQ','Planned infrastructure such as streets, wells and drainage provides strong evidence of organized urban settlement.',20,5),(7,6,'Which ancient Indian mathematician is traditionally associated with the concept of zero and important mathematical works?','MCQ','Brahmagupta wrote important mathematical works and gave rules for arithmetic involving zero and negative numbers.',10,1),(8,6,'Which ancient Indian text is primarily associated with astronomy and mathematical calculations?','MCQ','Aryabhatiya, composed by Aryabhata, contains important ideas related to astronomy and mathematics.',10,2),(9,6,'Puzzle: A student studies numbers, geometry, astronomy and methods of calculation in an ancient learning environment. Which area of knowledge connects these subjects most directly?','MCQ','Mathematics provides foundational methods used in geometry, astronomy and calculation.',15,3),(10,6,'Which ancient Indian scholar is famous for the work Aryabhatiya?','MCQ','Aryabhata is traditionally credited with composing the Aryabhatiya, a major work covering mathematics and astronomy.',10,4),(11,6,'Challenge: An ancient scholar needs to calculate planetary movements using mathematical methods. Which combination of knowledge would be most useful?','MCQ','Astronomy depends on mathematical calculations for studying and predicting celestial movements.',20,5),(12,7,'Which ancient Indian text is traditionally associated with performing arts, including drama, dance and music?','MCQ','The Natya Shastra is traditionally attributed to Bharata Muni and discusses drama, dance, music and related performing arts.',10,1),(13,7,'Which architectural feature is strongly associated with many ancient Indian temple traditions?','MCQ','Temple architecture developed diverse forms, including structures with decorated entrances, pillars and sacred spaces.',10,2),(14,7,'Puzzle: An ancient settlement contains carefully planned public spaces, decorated objects and evidence of skilled craftsmanship. What does this most strongly indicate?','MCQ','Such evidence can indicate organized social life and specialized craftsmanship within a settled community.',15,3),(15,7,'Which material was widely used in traditional Indian crafts and sculpture?','MCQ','Stone, metal, wood, clay and other materials were used across different Indian artistic and craft traditions.',10,4),(16,7,'Challenge: You discover an ancient community with specialized artisans, decorated objects and organized public spaces. What is the strongest conclusion?','MCQ','The combination of specialized crafts and organized spaces suggests a society with developed social and economic organization.',20,5),(17,8,'A historian finds evidence of planned streets, standardized bricks and an organized drainage system. Which ancient civilization does this evidence most strongly point toward?','MCQ','Planned streets, standardized bricks and sophisticated drainage are important archaeological features associated with Indus Valley urban settlements.',10,1),(18,8,'A student must connect an ancient scholar with the correct field. Which pairing is correct?','MCQ','Aryabhata is associated with mathematics and astronomy, while other scholars are associated with different fields of knowledge.',10,2),(19,8,'Puzzle Challenge: An archaeological site contains specialized craft objects, organized buildings and evidence of long-distance exchange. What combination best explains these findings?','MCQ','Specialized crafts, organized buildings and evidence of exchange can indicate an organized society with economic and social networks.',15,3),(20,8,'Which combination best represents the diversity of knowledge and culture explored in Ancient Bharat?','MCQ','Ancient Indian history includes diverse developments in urban planning, mathematics, astronomy, literature, arts, crafts and social life.',10,4),(21,8,'FINAL CHALLENGE: You are given evidence of urban planning, mathematical knowledge, artistic traditions and specialized craftsmanship. What is the best conclusion supported by all these clues?','MCQ','Taken together, these clues indicate a complex society with developed urban, intellectual, artistic and economic traditions.',25,5);
/*!40000 ALTER TABLE `questions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `themes`
--

DROP TABLE IF EXISTS `themes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `themes` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `theme_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `theme_code` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `image_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `video_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `display_order` int NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `theme_name` (`theme_name`),
  UNIQUE KEY `theme_code` (`theme_code`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `themes`
--

LOCK TABLES `themes` WRITE;
/*!40000 ALTER TABLE `themes` DISABLE KEYS */;
INSERT INTO `themes` VALUES (1,'Cosmology','COSMOLOGY','Ancient Indian ideas of cosmos, time and creation.','cosmology.png','cosmology.mp4',1,1),(2,'Ancient Bharat','ANCIENT_BHARAT','Cities, knowledge systems and civilizational glory.','ancient-bharat.png','ancient-bharat.mp4',2,1),(3,'British India','BRITISH_INDIA','Transformation, resistance and the struggle for freedom.','british-india.png','british-india.mp4',3,1),(4,'Present India','PRESENT_INDIA','Technology, innovation and a rapidly evolving future.','present-india.png','present-india.mp4',4,1);
/*!40000 ALTER TABLE `themes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_answers`
--

DROP TABLE IF EXISTS `user_answers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_answers` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `level_id` int unsigned NOT NULL,
  `question_id` int unsigned NOT NULL,
  `selected_option_id` int unsigned DEFAULT NULL,
  `is_correct` tinyint(1) NOT NULL DEFAULT '0',
  `points_earned` int NOT NULL DEFAULT '0',
  `answered_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `level_id` (`level_id`),
  KEY `question_id` (`question_id`),
  KEY `selected_option_id` (`selected_option_id`),
  KEY `idx_answers_user_level` (`user_id`,`level_id`),
  CONSTRAINT `user_answers_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `user_answers_ibfk_2` FOREIGN KEY (`level_id`) REFERENCES `levels` (`id`) ON DELETE CASCADE,
  CONSTRAINT `user_answers_ibfk_3` FOREIGN KEY (`question_id`) REFERENCES `questions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `user_answers_ibfk_4` FOREIGN KEY (`selected_option_id`) REFERENCES `question_options` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_answers`
--

LOCK TABLES `user_answers` WRITE;
/*!40000 ALTER TABLE `user_answers` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_answers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_progress`
--

DROP TABLE IF EXISTS `user_progress`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_progress` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `theme_id` int unsigned NOT NULL,
  `level_id` int unsigned NOT NULL,
  `status` enum('locked','available','in_progress','completed') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'available',
  `score` int NOT NULL DEFAULT '0',
  `total_questions` int NOT NULL DEFAULT '0',
  `correct_answers` int NOT NULL DEFAULT '0',
  `attempts` int NOT NULL DEFAULT '0',
  `completed_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`level_id`),
  KEY `theme_id` (`theme_id`),
  KEY `level_id` (`level_id`),
  KEY `idx_progress_user` (`user_id`),
  CONSTRAINT `user_progress_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `user_progress_ibfk_2` FOREIGN KEY (`theme_id`) REFERENCES `themes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `user_progress_ibfk_3` FOREIGN KEY (`level_id`) REFERENCES `levels` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_progress`
--

LOCK TABLES `user_progress` WRITE;
/*!40000 ALTER TABLE `user_progress` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_progress` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `full_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password_hash` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-09-29  0:26:45
