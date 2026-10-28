/*
-- CREAR
INSERT INTO tabla (campo1, campo2)
VALUES ('dato1', 'dato2');

-- CONSULTAR
SELECT * FROM tabla;

-- EDITAR
UPDATE tabla
SET campo1 = 'nuevo dato'
WHERE id = 1;

-- ELIMINAR
DELETE FROM tabla
WHERE id = 1;*/







/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
DROP TABLE IF EXISTS `admision_opciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admision_opciones` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pregunta_id` int(11) NOT NULL,
  `texto` varchar(255) NOT NULL,
  `orden` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `pregunta_id` (`pregunta_id`),
  CONSTRAINT `admision_opciones_ibfk_1` FOREIGN KEY (`pregunta_id`) REFERENCES `admision_preguntas` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=201 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `admision_opciones` WRITE;
/*!40000 ALTER TABLE `admision_opciones` DISABLE KEYS */;
INSERT INTO `admision_opciones` VALUES (1,1,'5',1),(2,1,'6',2),(3,1,'7',3),(4,1,'8',4),(5,2,'13 cm²',1),(6,2,'26 cm²',2),(7,2,'40 cm²',3),(8,2,'45 cm²',4),(9,3,'4',1),(10,3,'5',2),(11,3,'6',3),(12,3,'8',4),(13,4,'2/5',1),(14,4,'3/6',2),(15,4,'4/9',3),(16,4,'5/8',4),(17,5,'100',1),(18,5,'150',2),(19,5,'200',3),(20,5,'250',4),(21,6,'Cuadrado',1),(22,6,'Rectángulo',2),(23,6,'Triángulo equilátero',3),(24,6,'Pentágono',4),(25,7,'Porque aumentan el estrés',1),(26,7,'Porque reducen la producción de melatonina',2),(27,7,'Porque generan ruido',3),(28,7,'Porque consumen mucha energía',4),(29,8,'Abundante',1),(30,8,'Reducido',2),(31,8,'Limitado',3),(32,8,'Insuficiente',4),(33,9,'Conclusión',1),(34,9,'Contraste',2),(35,9,'Adición',3),(36,9,'Ejemplo',4),(37,10,'Aumento de la pesca',1),(38,10,'Escasez de agua para las comunidades cercanas',2),(39,10,'Mayor cantidad de lluvias',3),(40,10,'Mejora en la calidad del agua',4),(41,11,'Narrar una historia',1),(42,11,'Convencer al lector de una idea',2),(43,11,'Describir un lugar',3),(44,11,'Dar instrucciones',4),(45,12,'Desinterés por la educación',1),(46,12,'Resignación',2),(47,12,'Esfuerzo y valor por la educación',3),(48,12,'Indiferencia',4),(49,13,'Átomo',1),(50,13,'Célula',2),(51,13,'Molécula',3),(52,13,'Tejido',4),(53,14,'Venus',1),(54,14,'Marte',2),(55,14,'Júpiter',3),(56,14,'Saturno',4),(57,15,'Combatir infecciones',1),(58,15,'Transportar oxígeno',2),(59,15,'Coagular la sangre',3),(60,15,'Producir hormonas',4),(61,16,'Respiración',1),(62,16,'Fotosíntesis',2),(63,16,'Transpiración',3),(64,16,'Digestión',4),(65,17,'Ley de la gravedad',1),(66,17,'Primera ley de Newton',2),(67,17,'Tercera ley de Newton',3),(68,17,'Ley de conservación de la energía',4),(69,18,'Homogénea',1),(70,18,'Heterogénea',2),(71,18,'Disolución',3),(72,18,'Aleación',4),(73,19,'Decreto',1),(74,19,'Constitución',2),(75,19,'Manual de convivencia',3),(76,19,'Tratado',4),(77,20,'FIFA',1),(78,20,'ONU',2),(79,20,'OTAN',3),(80,20,'OMC',4),(81,21,'No participar en política',1),(82,21,'Participar y aportar en la vida pública y social',2),(83,21,'Vivir aislado de la comunidad',3),(84,21,'Solo cumplir con pagar impuestos',4),(85,22,'Ignora los derechos sociales',1),(86,22,'Garantiza derechos económicos, sociales y culturales',2),(87,22,'Elimina la Constitución',3),(88,22,'No permite el voto',4),(89,23,'El aislamiento entre países',1),(90,23,'El proceso de integración económica, social y cultural entre países',2),(91,23,'La eliminación del comercio internacional',3),(92,23,'Un tipo de gobierno',4),(93,24,'El voto',1),(94,24,'Ignorar las noticias',2),(95,24,'No opinar sobre temas públicos',3),(96,24,'Evitar el diálogo',4),(97,25,'Childs',1),(98,25,'Children',2),(99,25,'Childes',3),(100,25,'Childrens',4),(101,26,'Goed',1),(102,26,'Went',2),(103,26,'Gone',3),(104,26,'Going',4),(105,27,'have',1),(106,27,'has',2),(107,27,'had',3),(108,27,'having',4),(109,28,'Large',1),(110,28,'Huge',2),(111,28,'Small',3),(112,28,'Tall',4),(113,29,'He don\'t like coffee',1),(114,29,'He doesn\'t likes coffee',2),(115,29,'He doesn\'t like coffee',3),(116,29,'He not like coffee',4),(117,30,'Librería',1),(118,30,'Biblioteca',2),(119,30,'Papelería',3),(120,30,'Oficina',4),(121,61,'14 horas',1),(122,61,'24 horas',2),(123,61,'2 horas',3),(124,61,'48 horas',4),(125,62,'35',1),(126,62,'70',2),(127,62,'65',3),(128,62,'135',4),(129,63,'3.75',1),(130,63,'4.0',2),(131,63,'4.25',3),(132,63,'4.5',4),(133,64,'7 cm',1),(134,64,'10 cm',2),(135,64,'14 cm',3),(136,64,'48 cm',4),(137,65,'Los jóvenes ya no usan redes sociales',1),(138,65,'El cambio en los hábitos de lectura preocupa a los educadores',2),(139,65,'Los videos cortos son mejores que los artículos',3),(140,65,'Los educadores prefieren las redes sociales',4),(141,66,'Descuidado',1),(142,66,'Minucioso',2),(143,66,'Apresurado',3),(144,66,'Distraído',4),(145,67,'No tenían otras opciones para comer',1),(146,67,'Confiaban en la reputación del restaurante',2),(147,67,'No les importaba la calidad de la comida',3),(148,67,'Estaban de mal humor',4),(149,68,'Narrativo',1),(150,68,'Instructivo',2),(151,68,'Argumentativo',3),(152,68,'Poético',4),(153,69,'Almacenar información genética',1),(154,69,'Producir energía para la célula',2),(155,69,'Sintetizar proteínas',3),(156,69,'Eliminar desechos celulares',4),(157,70,'La primera ley de Newton',1),(158,70,'La segunda ley de Newton',2),(159,70,'La tercera ley de Newton',3),(160,70,'La ley de gravitación universal',4),(161,71,'Es básica',1),(162,71,'Es ácida',2),(163,71,'Es neutra',3),(164,71,'Es un metal',4),(165,72,'Parasitismo',1),(166,72,'Depredación',2),(167,72,'Mutualismo',3),(168,72,'Competencia',4),(169,73,'Deflación',1),(170,73,'Inflación',2),(171,73,'Devaluación',3),(172,73,'Recesión',4),(173,74,'Región Caribe',1),(174,74,'Región Andina',2),(175,74,'Región Pacífica',3),(176,74,'Región Orinoquía',4),(177,75,'Rama ejecutiva',1),(178,75,'Rama legislativa',2),(179,75,'Rama judicial',3),(180,75,'Órgano electoral',4),(181,76,'Regular el comercio internacional',1),(182,76,'Reducir las emisiones de gases de efecto invernadero',2),(183,76,'Eliminar las fronteras entre países',3),(184,76,'Crear una moneda única mundial',4),(185,77,'stay',1),(186,77,'stayed',2),(187,77,'will stay',3),(188,77,'staying',4),(189,78,'Easy',1),(190,78,'Hard',2),(191,78,'Simple',3),(192,78,'Fast',4),(193,79,'interesting',1),(194,79,'more interesting',2),(195,79,'most interesting',3),(196,79,'interestinger',4),(197,80,'wrote',1),(198,80,'was written',2),(199,80,'is write',3),(200,80,'writes',4);
/*!40000 ALTER TABLE `admision_opciones` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `admision_preguntas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admision_preguntas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `clave` varchar(10) NOT NULL,
  `area_clave` varchar(30) NOT NULL,
  `texto` text NOT NULL,
  `respuesta` varchar(255) NOT NULL,
  `orden` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `clave` (`clave`)
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `admision_preguntas` WRITE;
/*!40000 ALTER TABLE `admision_preguntas` DISABLE KEYS */;
INSERT INTO `admision_preguntas` VALUES (1,'a05','mate','Si x + 5 = 12, ¿cuál es el valor de x?','7',5),(2,'a06','mate','¿Cuál es el área de un rectángulo de base 8 cm y altura 5 cm?','40 cm²',6),(3,'a07','mate','Un grupo de 24 estudiantes se divide en equipos de 4 personas. ¿Cuántos equipos se forman?','6',7),(4,'a08','mate','¿Cuál de las siguientes fracciones es equivalente a 1/2?','3/6',8),(5,'a09','mate','Si el 25% de un número es 50, ¿cuál es ese número?','200',9),(6,'a10','mate','Una figura tiene sus 3 lados iguales. ¿Cómo se llama esa figura?','Triángulo equilátero',10),(7,'a15','lectura','\"El uso excesivo de pantallas antes de dormir puede afectar el sueño, ya que la luz que emiten reduce la producción de melatonina.\" Según el texto, ¿por qué las pantallas afectan el sueño?','Porque reducen la producción de melatonina',15),(8,'a16','lectura','¿Cuál de las siguientes palabras es antónimo de \"escaso\"?','Abundante',16),(9,'a17','lectura','\"El equipo perdió el partido, sin embargo, clasificó a la siguiente ronda gracias a los resultados de los otros equipos.\" ¿Qué tipo de conector es \"sin embargo\"?','Contraste',17),(10,'a18','lectura','\"Los ríos de la región han bajado su caudal en los últimos años.\" ¿Cuál sería una consecuencia lógica de esta situación?','Escasez de agua para las comunidades cercanas',18),(11,'a19','lectura','¿Cuál es la función principal de un texto argumentativo?','Convencer al lector de una idea',19),(12,'a20','lectura','\"A pesar de las dificultades económicas, la familia logró enviar a sus tres hijos a la universidad.\" ¿Qué actitud se puede inferir de la familia?','Esfuerzo y valor por la educación',20),(13,'a25','ciencias','¿Cuál es la unidad básica de los seres vivos?','Célula',25),(14,'a26','ciencias','¿Qué planeta del sistema solar es conocido como el planeta rojo?','Marte',26),(15,'a27','ciencias','¿Cuál es la función principal de los glóbulos rojos?','Transportar oxígeno',27),(16,'a28','ciencias','¿Qué proceso permite a las plantas producir su propio alimento?','Fotosíntesis',28),(17,'a29','ciencias','¿Cuál ley explica que a toda acción corresponde una reacción de igual magnitud y sentido contrario?','Tercera ley de Newton',29),(18,'a30','ciencias','¿Qué tipo de mezcla se forma al combinar agua y aceite?','Heterogénea',30),(19,'a35','sociales','¿Qué nombre recibe el documento que establece las normas fundamentales de un Estado?','Constitución',35),(20,'a36','sociales','¿Cuál de estos organismos vela por los derechos humanos a nivel internacional?','ONU',36),(21,'a37','sociales','¿Qué se entiende por \"ciudadanía activa\"?','Participar y aportar en la vida pública y social',37),(22,'a38','sociales','¿Cuál es una característica de un Estado social de derecho?','Garantiza derechos económicos, sociales y culturales',38),(23,'a39','sociales','¿Qué es la globalización?','El proceso de integración económica, social y cultural entre países',39),(24,'a40','sociales','¿Cuál de las siguientes es una forma de participación ciudadana?','El voto',40),(25,'a45','ingles','What is the plural of \"child\"?','Children',45),(26,'a46','ingles','Choose the correct past tense of \"go\":','Went',46),(27,'a47','ingles','\"I ___ finished my homework.\" (present perfect)','have',47),(28,'a48','ingles','What is the opposite of \"big\"?','Small',48),(29,'a49','ingles','Choose the correct sentence:','He doesn\'t like coffee',49),(30,'a50','ingles','What does \"library\" mean in Spanish?','Biblioteca',50),(61,'a51','mate','Si un tanque se llena en 6 horas con una llave y se vacía en 8 horas con un desagüe abierto, ¿en cuántas horas se llena por completo si ambas permanecen abiertas al mismo tiempo?','24 horas',51),(62,'a52','mate','En una encuesta a 200 estudiantes, el 35% dijo preferir estudiar en la mañana. ¿Cuántos estudiantes prefieren estudiar en la mañana?','70',52),(63,'a53','mate','Las calificaciones de un estudiante en 4 materias fueron 3.5, 4.0, 4.5 y 4.0. ¿Cuál es su promedio?','4.0',53),(64,'a54','mate','Un triángulo rectángulo tiene catetos de 6 cm y 8 cm. ¿Cuál es la longitud de la hipotenusa?','10 cm',54),(65,'a55','lectura','\"Cada vez más jóvenes prefieren informarse a través de videos cortos en redes sociales en lugar de leer artículos completos, lo que ha generado preocupación entre educadores sobre la capacidad de análisis profundo de las nuevas generaciones.\" ¿Cuál es la idea principal del texto?','El cambio en los hábitos de lectura preocupa a los educadores',55),(66,'a56','lectura','¿Cuál palabra podría reemplazar a \"meticuloso\" sin cambiar el sentido de la oración \"El investigador fue meticuloso al revisar cada dato\"?','Minucioso',56),(67,'a57','lectura','\"Aunque el restaurante estaba lleno y había fila en la puerta, decidimos esperar porque ya habíamos escuchado muy buenos comentarios sobre la comida.\" ¿Qué se puede inferir de las personas que esperaron?','Confiaban en la reputación del restaurante',57),(68,'a58','lectura','Un texto que explica paso a paso cómo armar un mueble, usando numeración y verbos en modo imperativo (\"coloque\", \"ajuste\", \"asegure\"), es un texto de tipo:','Instructivo',58),(69,'a59','ciencias','¿Cuál es la principal función de las mitocondrias dentro de una célula?','Producir energía para la célula',59),(70,'a60','ciencias','\"Un cuerpo en reposo permanece en reposo, y un cuerpo en movimiento continúa en movimiento a menos que actúe sobre él una fuerza externa.\" Este enunciado corresponde a:','La primera ley de Newton',60),(71,'a61','ciencias','¿Qué característica tiene una sustancia con pH menor a 7?','Es ácida',61),(72,'a62','ciencias','¿Cómo se llama la relación biológica en la que dos especies se benefician mutuamente?','Mutualismo',62),(73,'a63','sociales','¿Cómo se conoce al aumento generalizado y sostenido de los precios de bienes y servicios en una economía?','Inflación',63),(74,'a64','sociales','¿En cuál región natural de Colombia se ubica la ciudad de Medellín?','Región Andina',64),(75,'a65','sociales','¿Cuál de las tres ramas del poder público en Colombia es la encargada de administrar justicia?','Rama judicial',65),(76,'a66','sociales','¿Cuál es el objetivo principal del Acuerdo de París, firmado por la mayoría de países del mundo?','Reducir las emisiones de gases de efecto invernadero',66),(77,'a67','ingles','Choose the correct option: \"If it rains tomorrow, I ___ at home.\"','will stay',67),(78,'a68','ingles','What is the synonym of \"difficult\"?','Hard',68),(79,'a69','ingles','Choose the correct comparative form: \"This book is ___ than that one.\"','more interesting',69),(80,'a70','ingles','Choose the correct passive voice: \"The letter ___ by Maria.\"','was written',70);
/*!40000 ALTER TABLE `admision_preguntas` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `informes_enviados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `informes_enviados` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `usuario_id` int(11) DEFAULT NULL,
  `intento_id` int(11) DEFAULT NULL,
  `tipo` enum('informe','bienvenida') NOT NULL,
  `correo_destino` varchar(190) NOT NULL,
  `enviado` tinyint(1) NOT NULL DEFAULT 0,
  `error` varchar(255) DEFAULT NULL,
  `fecha` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `usuario_id` (`usuario_id`),
  KEY `intento_id` (`intento_id`),
  CONSTRAINT `informes_enviados_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL,
  CONSTRAINT `informes_enviados_ibfk_2` FOREIGN KEY (`intento_id`) REFERENCES `intentos` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `informes_enviados` WRITE;
/*!40000 ALTER TABLE `informes_enviados` DISABLE KEYS */;
INSERT INTO `informes_enviados` VALUES (23,NULL,NULL,'informe','sararojasaya679@gmail.com',1,NULL,'2026-09-08 10:04:27'),(60,12,1,'informe','santigoct228@gmail.com',1,NULL,'2026-10-13 10:14:22'),(61,12,3,'informe','santigoct228@gmail.com',1,NULL,'2026-10-13 10:14:38'),(62,12,3,'informe','santigoct228@gmail.com',1,NULL,'2026-10-13 10:14:49'),(63,12,3,'informe','santigoct228@gmail.com',1,NULL,'2026-10-13 10:14:56'),(64,12,3,'informe','santigoct228@gmail.com',1,NULL,'2026-10-13 10:15:11'),(65,12,3,'informe','santigoct228@gmail.com',1,NULL,'2026-10-13 10:15:18'),(66,12,3,'informe','santigoct228@gmail.com',1,NULL,'2026-10-13 10:15:25'),(67,12,3,'informe','santigoct228@gmail.com',1,NULL,'2026-10-13 10:15:36'),(68,12,3,'informe','santigoct228@gmail.com',1,NULL,'2026-10-13 10:15:46'),(69,12,3,'informe','santigoct228@gmail.com',1,NULL,'2026-10-13 10:15:52'),(70,13,NULL,'informe','arleyflorez@iejorgerobledo.edu.co',1,NULL,'2026-10-13 10:35:22'),(71,13,NULL,'informe','arleyflorez@iejorgerobledo.edu.co',1,NULL,'2026-10-13 10:35:25'),(72,13,NULL,'informe','arleyflorez@iejorgerobledo.edu.co',1,NULL,'2026-10-13 10:35:28');
/*!40000 ALTER TABLE `informes_enviados` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `intentos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `intentos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `usuario_id` int(11) DEFAULT NULL,
  `test_id` int(11) NOT NULL,
  `total_preguntas` int(11) NOT NULL,
  `correctas` int(11) NOT NULL,
  `porcentaje` int(11) NOT NULL,
  `puntaje_estimado` int(11) DEFAULT NULL,
  `resumen` varchar(255) NOT NULL,
  `tiempo_segundos` int(11) DEFAULT NULL,
  `fecha` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `usuario_id` (`usuario_id`),
  KEY `test_id` (`test_id`),
  CONSTRAINT `intentos_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL,
  CONSTRAINT `intentos_ibfk_2` FOREIGN KEY (`test_id`) REFERENCES `tests` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `intentos` WRITE;
/*!40000 ALTER TABLE `intentos` DISABLE KEYS */;
INSERT INTO `intentos` VALUES (1,12,1,50,0,76,NULL,'Tu perfil vocacional predominante es 💼 Administración y Negocios (76% de afinidad).',NULL,'2026-10-13 10:14:06'),(2,12,1,50,0,76,NULL,'Tu perfil vocacional predominante es 💼 Administración y Negocios (76% de afinidad).',NULL,'2026-10-13 10:14:08'),(3,12,1,50,0,76,NULL,'Tu perfil vocacional predominante es 💼 Administración y Negocios (76% de afinidad).',NULL,'2026-10-13 10:14:08'),(4,5,1,50,0,46,NULL,'Tu perfil vocacional predominante es 🩺 Ciencias de la Salud (46% de afinidad).',NULL,'2026-10-13 10:17:43'),(5,13,1,50,0,64,NULL,'Tu perfil vocacional predominante es 💼 Administración y Negocios (64% de afinidad).',NULL,'2026-10-13 10:32:01'),(6,5,2,50,18,36,180,'Obtuviste 36% (18/50 correctas) — Nivel Bajo. Puntaje estimado: 180/500.',131,'2026-10-14 11:49:58'),(7,5,2,50,40,80,400,'Obtuviste 80% (40/50 correctas) — Nivel Muy Alto. Puntaje estimado: 400/500.',828,'2026-10-14 12:04:12');
/*!40000 ALTER TABLE `intentos` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `respuestas_intento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `respuestas_intento` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `intento_id` int(11) NOT NULL,
  `pregunta_clave` varchar(10) NOT NULL,
  `area_clave` varchar(30) NOT NULL,
  `respuesta_dada` varchar(255) DEFAULT NULL,
  `valor` int(11) DEFAULT NULL,
  `correcta` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `intento_id` (`intento_id`),
  CONSTRAINT `respuestas_intento_ibfk_1` FOREIGN KEY (`intento_id`) REFERENCES `intentos` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=290 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `respuestas_intento` WRITE;
/*!40000 ALTER TABLE `respuestas_intento` DISABLE KEYS */;
INSERT INTO `respuestas_intento` VALUES (1,1,'v69','negocios',NULL,4,NULL),(2,1,'v48','negocios',NULL,4,NULL),(3,1,'v08','stem',NULL,4,NULL),(4,1,'v57','salud',NULL,4,NULL),(5,1,'v54','stem',NULL,4,NULL),(6,1,'v35','arte',NULL,4,NULL),(7,1,'v46','negocios',NULL,5,NULL),(8,1,'v30','social',NULL,4,NULL),(9,1,'v06','stem',NULL,4,NULL),(10,1,'v47','negocios',NULL,4,NULL),(11,1,'v58','salud',NULL,4,NULL),(12,1,'v45','negocios',NULL,4,NULL),(13,1,'v38','arte',NULL,4,NULL),(14,1,'v60','social',NULL,4,NULL),(15,1,'v50','negocios',NULL,4,NULL),(16,1,'v16','salud',NULL,4,NULL),(17,1,'v67','negocios',NULL,4,NULL),(18,1,'v18','salud',NULL,5,NULL),(19,1,'v09','stem',NULL,5,NULL),(20,1,'v53','stem',NULL,4,NULL),(21,1,'v51','stem',NULL,4,NULL),(22,1,'v62','social',NULL,4,NULL),(23,1,'v63','arte',NULL,2,NULL),(24,1,'v49','negocios',NULL,5,NULL),(25,1,'v20','salud',NULL,4,NULL),(26,1,'v66','arte',NULL,4,NULL),(27,1,'v56','salud',NULL,4,NULL),(28,1,'v29','social',NULL,4,NULL),(29,1,'v70','negocios',NULL,4,NULL),(30,1,'v61','social',NULL,2,NULL),(31,1,'v07','stem',NULL,4,NULL),(32,1,'v55','salud',NULL,4,NULL),(33,1,'v39','arte',NULL,4,NULL),(34,1,'v59','social',NULL,4,NULL),(35,1,'v17','salud',NULL,4,NULL),(36,1,'v37','arte',NULL,4,NULL),(37,1,'v36','arte',NULL,4,NULL),(38,1,'v19','salud',NULL,4,NULL),(39,1,'v25','social',NULL,4,NULL),(40,1,'v40','arte',NULL,4,NULL),(41,1,'v28','social',NULL,4,NULL),(42,2,'v69','negocios',NULL,4,NULL),(43,2,'v48','negocios',NULL,4,NULL),(44,2,'v08','stem',NULL,4,NULL),(45,2,'v57','salud',NULL,4,NULL),(46,2,'v54','stem',NULL,4,NULL),(47,2,'v35','arte',NULL,4,NULL),(48,2,'v46','negocios',NULL,5,NULL),(49,2,'v30','social',NULL,4,NULL),(50,2,'v06','stem',NULL,4,NULL),(51,2,'v47','negocios',NULL,4,NULL),(52,2,'v58','salud',NULL,4,NULL),(53,2,'v45','negocios',NULL,4,NULL),(54,2,'v38','arte',NULL,4,NULL),(55,2,'v60','social',NULL,4,NULL),(56,2,'v50','negocios',NULL,4,NULL),(57,2,'v16','salud',NULL,4,NULL),(58,2,'v67','negocios',NULL,4,NULL),(59,2,'v18','salud',NULL,5,NULL),(60,2,'v09','stem',NULL,5,NULL),(61,2,'v53','stem',NULL,4,NULL),(62,2,'v51','stem',NULL,4,NULL),(63,2,'v62','social',NULL,4,NULL),(64,2,'v63','arte',NULL,2,NULL),(65,2,'v49','negocios',NULL,5,NULL),(66,2,'v20','salud',NULL,4,NULL),(67,2,'v66','arte',NULL,4,NULL),(68,2,'v56','salud',NULL,4,NULL),(69,2,'v29','social',NULL,4,NULL),(70,2,'v70','negocios',NULL,4,NULL),(71,2,'v61','social',NULL,2,NULL),(72,2,'v07','stem',NULL,4,NULL),(73,2,'v55','salud',NULL,4,NULL),(74,2,'v39','arte',NULL,4,NULL),(75,2,'v59','social',NULL,4,NULL),(76,2,'v17','salud',NULL,4,NULL),(77,2,'v37','arte',NULL,4,NULL),(78,2,'v36','arte',NULL,4,NULL),(79,2,'v19','salud',NULL,4,NULL),(80,2,'v25','social',NULL,4,NULL),(81,2,'v40','arte',NULL,4,NULL),(82,2,'v28','social',NULL,4,NULL),(83,3,'v69','negocios',NULL,4,NULL),(84,3,'v48','negocios',NULL,4,NULL),(85,3,'v08','stem',NULL,4,NULL),(86,3,'v57','salud',NULL,4,NULL),(87,3,'v54','stem',NULL,4,NULL),(88,3,'v35','arte',NULL,4,NULL),(89,3,'v46','negocios',NULL,5,NULL),(90,3,'v30','social',NULL,4,NULL),(91,3,'v06','stem',NULL,4,NULL),(92,3,'v47','negocios',NULL,4,NULL),(93,3,'v58','salud',NULL,4,NULL),(94,3,'v45','negocios',NULL,4,NULL),(95,3,'v38','arte',NULL,4,NULL),(96,3,'v60','social',NULL,4,NULL),(97,3,'v50','negocios',NULL,4,NULL),(98,3,'v16','salud',NULL,4,NULL),(99,3,'v67','negocios',NULL,4,NULL),(100,3,'v18','salud',NULL,5,NULL),(101,3,'v09','stem',NULL,5,NULL),(102,3,'v53','stem',NULL,4,NULL),(103,3,'v51','stem',NULL,4,NULL),(104,3,'v62','social',NULL,4,NULL),(105,3,'v63','arte',NULL,2,NULL),(106,3,'v49','negocios',NULL,5,NULL),(107,3,'v20','salud',NULL,4,NULL),(108,3,'v66','arte',NULL,4,NULL),(109,3,'v56','salud',NULL,4,NULL),(110,3,'v29','social',NULL,4,NULL),(111,3,'v70','negocios',NULL,4,NULL),(112,3,'v61','social',NULL,2,NULL),(113,3,'v07','stem',NULL,4,NULL),(114,3,'v55','salud',NULL,4,NULL),(115,3,'v39','arte',NULL,4,NULL),(116,3,'v59','social',NULL,4,NULL),(117,3,'v17','salud',NULL,4,NULL),(118,3,'v37','arte',NULL,4,NULL),(119,3,'v36','arte',NULL,4,NULL),(120,3,'v19','salud',NULL,4,NULL),(121,3,'v25','social',NULL,4,NULL),(122,3,'v40','arte',NULL,4,NULL),(123,3,'v28','social',NULL,4,NULL),(124,4,'v51','stem',NULL,3,NULL),(125,4,'v38','arte',NULL,4,NULL),(126,4,'v63','arte',NULL,2,NULL),(127,4,'v47','negocios',NULL,2,NULL),(128,4,'v40','arte',NULL,1,NULL),(129,4,'v50','negocios',NULL,1,NULL),(130,4,'v17','salud',NULL,5,NULL),(131,4,'v30','social',NULL,5,NULL),(132,4,'v62','social',NULL,5,NULL),(133,4,'v36','arte',NULL,5,NULL),(134,4,'v54','stem',NULL,5,NULL),(135,4,'v45','negocios',NULL,5,NULL),(136,4,'v46','negocios',NULL,5,NULL),(137,4,'v15','salud',NULL,5,NULL),(138,4,'v16','salud',NULL,5,NULL),(139,4,'v19','salud',NULL,5,NULL),(140,4,'v07','stem',NULL,3,NULL),(141,4,'v29','social',NULL,3,NULL),(142,4,'v35','arte',NULL,3,NULL),(143,4,'v28','social',NULL,3,NULL),(144,4,'v52','stem',NULL,3,NULL),(145,4,'v66','arte',NULL,3,NULL),(146,4,'v39','arte',NULL,2,NULL),(147,4,'v70','negocios',NULL,1,NULL),(148,4,'v59','social',NULL,1,NULL),(149,4,'v53','stem',NULL,2,NULL),(150,4,'v20','salud',NULL,3,NULL),(151,5,'v66','arte',NULL,3,NULL),(152,5,'v48','negocios',NULL,5,NULL),(153,5,'v69','negocios',NULL,5,NULL),(154,5,'v62','social',NULL,4,NULL),(155,5,'v28','social',NULL,3,NULL),(156,5,'v08','stem',NULL,4,NULL),(157,5,'v30','social',NULL,2,NULL),(158,5,'v53','stem',NULL,3,NULL),(159,5,'v68','negocios',NULL,5,NULL),(160,5,'v58','salud',NULL,2,NULL),(161,5,'v51','stem',NULL,1,NULL),(162,5,'v47','negocios',NULL,5,NULL),(163,5,'v09','stem',NULL,5,NULL),(164,5,'v49','negocios',NULL,2,NULL),(165,5,'v05','stem',NULL,3,NULL),(166,5,'v40','arte',NULL,4,NULL),(167,5,'v46','negocios',NULL,4,NULL),(168,5,'v25','social',NULL,3,NULL),(169,5,'v26','social',NULL,5,NULL),(170,5,'v15','salud',NULL,3,NULL),(171,5,'v60','social',NULL,2,NULL),(172,5,'v59','social',NULL,2,NULL),(173,5,'v38','arte',NULL,3,NULL),(174,5,'v63','arte',NULL,3,NULL),(175,5,'v17','salud',NULL,5,NULL),(176,5,'v64','arte',NULL,4,NULL),(177,5,'v35','arte',NULL,5,NULL),(178,5,'v45','negocios',NULL,3,NULL),(179,5,'v61','social',NULL,2,NULL),(180,5,'v39','arte',NULL,1,NULL),(181,5,'v16','salud',NULL,3,NULL),(182,5,'v19','salud',NULL,2,NULL),(183,5,'v57','salud',NULL,1,NULL),(184,5,'v10','stem',NULL,3,NULL),(185,5,'v52','stem',NULL,2,NULL),(186,5,'v54','stem',NULL,3,NULL),(187,5,'v29','social',NULL,4,NULL),(188,5,'v70','negocios',NULL,3,NULL),(189,5,'v37','arte',NULL,4,NULL),(190,6,'a06','mate','26 cm²',NULL,0),(191,6,'a19','lectura','Dar instrucciones',NULL,0),(192,6,'a39','sociales','Un tipo de gobierno',NULL,0),(193,6,'a07','mate','5',NULL,0),(194,6,'a30','ciencias','Disolución',NULL,0),(195,6,'a20','lectura','Indiferencia',NULL,0),(196,6,'a59','ciencias','Producir energía para la célula',NULL,1),(197,6,'a37','sociales','Vivir aislado de la comunidad',NULL,0),(198,6,'a10','mate','Triángulo equilátero',NULL,1),(199,6,'a65','sociales','Órgano electoral',NULL,0),(200,6,'a49','ingles','He doesn\'t likes coffee',NULL,0),(201,6,'a35','sociales','Constitución',NULL,1),(202,6,'a55','lectura','Los jóvenes ya no usan redes sociales',NULL,0),(203,6,'a57','lectura','Confiaban en la reputación del restaurante',NULL,1),(204,6,'a64','sociales','Región Caribe',NULL,0),(205,6,'a60','ciencias','La primera ley de Newton',NULL,1),(206,6,'a15','lectura','Porque generan ruido',NULL,0),(207,6,'a36','sociales','OTAN',NULL,0),(208,6,'a69','ingles','more interesting',NULL,1),(209,6,'a09','mate','100',NULL,0),(210,6,'a70','ingles','writes',NULL,0),(211,6,'a18','lectura','Escasez de agua para las comunidades cercanas',NULL,1),(212,6,'a29','ciencias','Tercera ley de Newton',NULL,1),(213,6,'a53','mate','4.25',NULL,0),(214,6,'a62','ciencias','Mutualismo',NULL,1),(215,6,'a27','ciencias','Combatir infecciones',NULL,0),(216,6,'a16','lectura','Insuficiente',NULL,0),(217,6,'a17','lectura','Ejemplo',NULL,0),(218,6,'a68','ingles','Hard',NULL,1),(219,6,'a28','ciencias','Fotosíntesis',NULL,1),(220,6,'a08','mate','3/6',NULL,1),(221,6,'a45','ingles','Childs',NULL,0),(222,6,'a63','sociales','Inflación',NULL,1),(223,6,'a05','mate','5',NULL,0),(224,6,'a48','ingles','Huge',NULL,0),(225,6,'a47','ingles','having',NULL,0),(226,6,'a58','lectura','Narrativo',NULL,0),(227,6,'a25','ciencias','Átomo',NULL,0),(228,6,'a26','ciencias','Venus',NULL,0),(229,6,'a61','ciencias','Es ácida',NULL,1),(230,6,'a52','mate','135',NULL,0),(231,6,'a40','sociales','No opinar sobre temas públicos',NULL,0),(232,6,'a51','mate','24 horas',NULL,1),(233,6,'a56','lectura','Distraído',NULL,0),(234,6,'a67','ingles','will stay',NULL,1),(235,6,'a46','ingles','Going',NULL,0),(236,6,'a38','sociales','No permite el voto',NULL,0),(237,6,'a54','mate','10 cm',NULL,1),(238,6,'a50','ingles','Oficina',NULL,0),(239,6,'a66','sociales','Reducir las emisiones de gases de efecto invernadero',NULL,1),(240,7,'a20','lectura','Esfuerzo y valor por la educación',NULL,1),(241,7,'a10','mate','Triángulo equilátero',NULL,1),(242,7,'a60','ciencias','La segunda ley de Newton',NULL,0),(243,7,'a19','lectura','Convencer al lector de una idea',NULL,1),(244,7,'a37','sociales','Participar y aportar en la vida pública y social',NULL,1),(245,7,'a53','mate','4.0',NULL,1),(246,7,'a57','lectura','Confiaban en la reputación del restaurante',NULL,1),(247,7,'a25','ciencias','Molécula',NULL,0),(248,7,'a30','ciencias','Heterogénea',NULL,1),(249,7,'a36','sociales','ONU',NULL,1),(250,7,'a17','lectura','Contraste',NULL,1),(251,7,'a39','sociales','El proceso de integración económica, social y cultural entre países',NULL,1),(252,7,'a70','ingles','was written',NULL,1),(253,7,'a65','sociales','Rama judicial',NULL,1),(254,7,'a06','mate','40 cm²',NULL,1),(255,7,'a56','lectura','Minucioso',NULL,1),(256,7,'a52','mate','65',NULL,0),(257,7,'a38','sociales','Garantiza derechos económicos, sociales y culturales',NULL,1),(258,7,'a07','mate','6',NULL,1),(259,7,'a29','ciencias','Tercera ley de Newton',NULL,1),(260,7,'a59','ciencias','Producir energía para la célula',NULL,1),(261,7,'a63','sociales','Inflación',NULL,1),(262,7,'a58','lectura','Instructivo',NULL,1),(263,7,'a46','ingles','Went',NULL,1),(264,7,'a51','mate','14 horas',NULL,0),(265,7,'a28','ciencias','Fotosíntesis',NULL,1),(266,7,'a67','ingles','stay',NULL,0),(267,7,'a40','sociales','El voto',NULL,1),(268,7,'a54','mate','10 cm',NULL,1),(269,7,'a27','ciencias','Transportar oxígeno',NULL,1),(270,7,'a35','sociales','Constitución',NULL,1),(271,7,'a49','ingles','He doesn\'t like coffee',NULL,1),(272,7,'a09','mate','200',NULL,1),(273,7,'a66','sociales','Regular el comercio internacional',NULL,0),(274,7,'a26','ciencias','Marte',NULL,1),(275,7,'a15','lectura','Porque reducen la producción de melatonina',NULL,1),(276,7,'a69','ingles','more interesting',NULL,1),(277,7,'a47','ingles','had',NULL,0),(278,7,'a48','ingles','Small',NULL,1),(279,7,'a64','sociales','Región Andina',NULL,1),(280,7,'a62','ciencias','Mutualismo',NULL,1),(281,7,'a50','ingles','Librería',NULL,0),(282,7,'a68','ingles','Hard',NULL,1),(283,7,'a05','mate','7',NULL,1),(284,7,'a16','lectura','Abundante',NULL,1),(285,7,'a45','ingles','Childs',NULL,0),(286,7,'a61','ciencias','Es básica',NULL,0),(287,7,'a08','mate','3/6',NULL,1),(288,7,'a18','lectura','Escasez de agua para las comunidades cercanas',NULL,1),(289,7,'a55','lectura','El cambio en los hábitos de lectura preocupa a los educadores',NULL,1);
/*!40000 ALTER TABLE `respuestas_intento` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `resultados_areas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resultados_areas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `intento_id` int(11) NOT NULL,
  `area_clave` varchar(30) NOT NULL,
  `area_nombre` varchar(100) NOT NULL,
  `porcentaje` int(11) NOT NULL,
  `correctas` int(11) DEFAULT NULL,
  `total` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `intento_id` (`intento_id`),
  CONSTRAINT `resultados_areas_ibfk_1` FOREIGN KEY (`intento_id`) REFERENCES `intentos` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `resultados_areas` WRITE;
/*!40000 ALTER TABLE `resultados_areas` DISABLE KEYS */;
INSERT INTO `resultados_areas` VALUES (1,1,'negocios','💼 Administración y Negocios',76,NULL,NULL),(2,1,'salud','🩺 Ciencias de la Salud',74,NULL,NULL),(3,1,'social','🌍 Ciencias Sociales y Humanas',60,NULL,NULL),(4,1,'arte','🎨 Artes y Comunicación',60,NULL,NULL),(5,1,'stem','⚙️ Ciencias Exactas e Ingeniería',58,NULL,NULL),(6,2,'negocios','💼 Administración y Negocios',76,NULL,NULL),(7,2,'salud','🩺 Ciencias de la Salud',74,NULL,NULL),(8,2,'social','🌍 Ciencias Sociales y Humanas',60,NULL,NULL),(9,2,'arte','🎨 Artes y Comunicación',60,NULL,NULL),(10,2,'stem','⚙️ Ciencias Exactas e Ingeniería',58,NULL,NULL),(11,3,'negocios','💼 Administración y Negocios',76,NULL,NULL),(12,3,'salud','🩺 Ciencias de la Salud',74,NULL,NULL),(13,3,'social','🌍 Ciencias Sociales y Humanas',60,NULL,NULL),(14,3,'arte','🎨 Artes y Comunicación',60,NULL,NULL),(15,3,'stem','⚙️ Ciencias Exactas e Ingeniería',58,NULL,NULL),(16,4,'salud','🩺 Ciencias de la Salud',46,NULL,NULL),(17,4,'arte','🎨 Artes y Comunicación',40,NULL,NULL),(18,4,'social','🌍 Ciencias Sociales y Humanas',34,NULL,NULL),(19,4,'stem','⚙️ Ciencias Exactas e Ingeniería',32,NULL,NULL),(20,4,'negocios','💼 Administración y Negocios',28,NULL,NULL),(21,5,'negocios','💼 Administración y Negocios',64,NULL,NULL),(22,5,'social','🌍 Ciencias Sociales y Humanas',54,NULL,NULL),(23,5,'arte','🎨 Artes y Comunicación',54,NULL,NULL),(24,5,'stem','⚙️ Ciencias Exactas e Ingeniería',48,NULL,NULL),(25,5,'salud','🩺 Ciencias de la Salud',32,NULL,NULL),(26,6,'mate','➗ Matemáticas',40,4,10),(27,6,'lectura','📖 Lectura Crítica',20,2,10),(28,6,'ciencias','🔬 Ciencias Naturales',60,6,10),(29,6,'sociales','🏛️ Sociales y Ciudadanas',30,3,10),(30,6,'ingles','🌐 Inglés',30,3,10),(31,7,'mate','➗ Matemáticas',80,8,10),(32,7,'lectura','📖 Lectura Crítica',100,10,10),(33,7,'ciencias','🔬 Ciencias Naturales',70,7,10),(34,7,'sociales','🏛️ Sociales y Ciudadanas',90,9,10),(35,7,'ingles','🌐 Inglés',60,6,10);
/*!40000 ALTER TABLE `resultados_areas` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `tests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `clave` varchar(30) NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `clave` (`clave`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `tests` WRITE;
/*!40000 ALTER TABLE `tests` DISABLE KEYS */;
INSERT INTO `tests` VALUES (1,'vocacional','Test Vocacional',1),(2,'admision','Simulacro de Admisión',1);
/*!40000 ALTER TABLE `tests` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `universidades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `universidades` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(150) NOT NULL,
  `escudo` varchar(255) NOT NULL,
  `url_oferta` varchar(500) NOT NULL,
  `texto_oferta` varchar(255) DEFAULT NULL,
  `orden` int(11) NOT NULL DEFAULT 0,
  `activa` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `universidades` WRITE;
/*!40000 ALTER TABLE `universidades` DISABLE KEYS */;
INSERT INTO `universidades` VALUES (1,'Universidad de Antioquia','escudoudea.png','https://www.udea.edu.co/wps/portal/udea/web/inicio/estudiar-udea/quiero-estudiar-udea/pregrado/oferta-medellin',NULL,2,1),(2,'Universidad Nacional de Colombia','escudounal.png','https://pregrado.unal.edu.co/info_programas',NULL,1,1),(3,'Universidad Pontificia Bolivariana','escudoupb.png','https://portal.upb.edu.co/pregrados',NULL,3,1),(4,'Universidad EAFIT','escudoeafit.png','https://www.eafit.edu.co/pregrados',NULL,4,1),(5,'Instituto Tecnológico Metropolitano','escudoitm.png','https://www.itm.edu.co/aspirante-pregrado/programas-profesionales/',NULL,5,1),(6,'Universidad de Medellín','escudoumedellin.png','https://programas.udemedellin.edu.co/',NULL,6,1),(7,'Tecnológico de Antioquia','escudotdea.png','https://tdea.edu.co/programas-profesionales/',NULL,7,1),(8,'Universidad Pascual Bravo','escudopascualbravo.png','https://pascualbravo.edu.co/pregrados/',NULL,8,1),(9,'Universidad CES','universidad-ces.jpg','https://www.ces.edu.co/estudia-en-ces/carreras-de-pregrado/',NULL,9,1),(10,'Universidad Autónoma Latinoamericana','Universida-Autonoma.jpg','https://www.unaula.edu.co/oferta-academica#universitarios',NULL,10,1),(11,'Universidad de San Buenaventura','universidad-sanbuenaventura.png','https://usbmed.edu.co/programas/pregrados',NULL,11,1),(12,'Universidad Cooperativa de Colombia','universidad-cooperativa.jpg','https://ucc.edu.co/programas/Paginas/default.aspx?campus=Medell%C3%ADn+-+Envigado',NULL,12,1),(13,'Universidad Santo Tomás','universidad-santotomas.jpg','https://usantotomas.edu.co/pregrados-presenciales-med',NULL,13,1),(14,'Universidad Antonio Nariño','universidad-antonioNariño.png','https://www.uan.edu.co/pregrados',NULL,14,1),(15,'Universidad Colegio Mayor de Antioquia','universidad-ColeMayorAnt.png','https://www.colmayor.edu.co/programas/',NULL,15,1),(16,'Universidad Católica Luis Amigó','universidad_luisamigo.jpg','https://www.funlam.edu.co/modules/ofertaacademica/',NULL,16,1),(17,'Politécnico Colombiano Jaime Isaza Cadavid','universidad_jaimeIsaza.jpg','https://www.politecnicojic.edu.co/profesionales',NULL,17,1),(18,'Fundación Universitaria María Cano','universidad_mariaCano.png','https://www.fumc.edu.co/pregrado/',NULL,18,1),(19,'Corporación Universitaria Remington','universidad_remington.jpg','https://www.uniremington.edu.co/programas/',NULL,19,1),(20,'Corporación Universitaria Americana','universidad_americana.jpg','https://americana.edu.co/medellin/pregrado/',NULL,20,1),(21,'Fundación Universitaria Autónoma de las Américas','universidad_lasAmericas.jpg','https://uam.edu.co/pregrados/',NULL,21,1),(22,'Institución Universitaria ESUMER','universidad_ESUMER.jpg','https://esumer.edu.co/ofertacademica/',NULL,22,1),(23,'Escuela de Ingeniería de Antioquia (EIA)','Escuela_de_ingenieria_ant.jpg','https://www.eia.edu.co/pregrados/',NULL,23,1),(24,'Institución Universitaria Salazar y Herrera','universidad_salazarYherrera.jpg','https://www.iush.edu.co/inicio/pregados/',NULL,24,1),(25,'Institución Universitaria CEIPA','universidad_CEIPA.jpg','https://promo.ceipa.edu.co/pregrados-posgrados-mba',NULL,25,1),(26,'Institución Universitaria Colegiatura Colombiana','universidad_colegiatura_colombiana.jpg','https://www.colegiatura.edu.co/pregrado/',NULL,26,1),(27,'Fundación Universitaria Bellas Artes de Medellín','fundacion_bellas_artes.jpg','https://bellasartesmed.edu.co/pregrados/',NULL,27,1),(28,'Universidad Nacional Abierta y a Distancia (UNAD)','universidad_abierta_y_distancia.jpg','https://estudios.unad.edu.co/carreras',NULL,28,1),(29,'Corporación Universitaria Adventista (UNAC)','universidad_adventista.png','https://www.unac.edu.co/pregrado/',NULL,29,1),(30,'Institución Universitaria de Envigado (IUE)','universidad_envigado.jpg','https://www.iue.edu.co/pregrado/',NULL,31,1),(33,'SENA','sena.png','https://betowa.sena.edu.co/oferta','Conoce la oferta académica en técnicas y tecnologías del SENA',32,1),(34,'CESDE','cesde.svg','https://cesde.edu.co/nuestros-programas/','Conoce la oferta académica en técnicas y tecnologías de CESDE',33,1);
/*!40000 ALTER TABLE `universidades` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `apellido` varchar(100) NOT NULL,
  `correo` varchar(190) NOT NULL,
  `telefono` varchar(20) NOT NULL,
  `clave_hash` varchar(255) NOT NULL,
  `rol` enum('estudiante','admin') NOT NULL DEFAULT 'estudiante',
  `fecha_registro` datetime DEFAULT current_timestamp(),
  `ultimo_acceso` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `correo` (`correo`)
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'jessica','rojas','sararojas@iejorgerobledo.edu.co','3117064279','$2y$10$dMDvHTIDJ2D1j9h5jk2AEOJY18HA12f/B3aBnUiLtJX8nIyfOO6mO','admin','2026-09-07 23:14:12','2026-09-16 15:49:08'),(5,'sara','rojas','sararojasaya679@gmail.com','3567890','$2y$10$ANaRsZcFF3g5.tRH03Bv4OwQ5K2Xt9AdFJfa7nRx6lNrs/QI96gGW','admin','2026-09-16 13:39:30','2026-10-13 10:01:53'),(12,'santi','Calderon','santigoct228@gmail.com','3145040796','$2y$10$1TVByvUHHnG45c4bTLgqU.93sp2WK4M/eR9hda6KDJnCyurSkQD3y','estudiante','2026-10-13 10:13:19',NULL),(13,'Arley','Flórez','arleyflorez@iejorgerobledo.edu.co','3197021905','$2y$10$0VtnQB4IPidq0VJsatPSfuOL9NUgAgfcL3cLDAtKn0N5H/ifHsA3K','estudiante','2026-10-13 10:28:35',NULL);
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `vocacional_preguntas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vocacional_preguntas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `clave` varchar(10) NOT NULL,
  `area_clave` varchar(30) NOT NULL,
  `texto` text NOT NULL,
  `orden` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `clave` (`clave`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `vocacional_preguntas` WRITE;
/*!40000 ALTER TABLE `vocacional_preguntas` DISABLE KEYS */;
INSERT INTO `vocacional_preguntas` VALUES (31,'v05','stem','Disfruto programar o crear pequeños proyectos con el computador.',5),(32,'v06','stem','Me interesa saber cómo se genera y se transporta la energía.',6),(33,'v07','stem','Prefiero las materias de física y cálculo sobre las de historia o literatura.',7),(34,'v08','stem','Me gusta desarmar objetos para entender cómo están hechos por dentro.',8),(35,'v09','stem','Disfruto los retos que requieren pensamiento lógico paso a paso.',9),(36,'v10','stem','Me interesaría trabajar en un laboratorio o en el desarrollo de nueva tecnología.',10),(37,'v15','salud','Me interesa la biología y cómo funcionan los seres vivos.',15),(38,'v16','salud','Disfruto cuidar de otras personas, animales o de mí mismo/a en temas de salud.',16),(39,'v17','salud','Me gustaría aprender sobre nutrición, ejercicio o bienestar físico.',17),(40,'v18','salud','Siento curiosidad por entender las enfermedades y cómo se tratan.',18),(41,'v19','salud','Me gustaría acompañar procesos de recuperación o rehabilitación de otras personas.',19),(42,'v20','salud','Disfruto las actividades donde debo seguir protocolos y cuidar los detalles.',20),(43,'v25','social','Me interesa el debate y defender mis ideas con argumentos.',25),(44,'v26','social','Disfruto escribir ensayos, reflexiones o textos de opinión.',26),(45,'v27','social','Me llama la atención estudiar idiomas y otras culturas.',27),(46,'v28','social','Me gustaría trabajar orientando o acompañando a otras personas (educación, psicología, trabajo social).',28),(47,'v29','social','Me interesa participar en actividades de liderazgo social o comunitario.',29),(48,'v30','social','Disfruto analizar noticias y formar mi propia opinión sobre temas actuales.',30),(49,'v35','arte','Me interesa la fotografía, el cine o la producción audiovisual.',35),(50,'v36','arte','Me gustaría trabajar diseñando marcas, espacios o experiencias visuales.',36),(51,'v37','arte','Disfruto la música, el teatro o la danza como forma de expresión.',37),(52,'v38','arte','Me gusta estar al día con tendencias de redes sociales y comunicación digital.',38),(53,'v39','arte','Prefiero los proyectos donde puedo innovar y salirme de lo convencional.',39),(54,'v40','arte','Me gustaría que mi trabajo tuviera un componente artístico o creativo todos los días.',40),(55,'v45','negocios','Me gustaría emprender mi propio negocio en el futuro.',45),(56,'v46','negocios','Disfruto negociar, convencer o venderle una idea a otras personas.',46),(57,'v47','negocios','Me interesa la publicidad y cómo se posicionan las marcas en el mercado.',47),(58,'v48','negocios','Soy bueno/a tomando decisiones bajo presión o con información limitada.',48),(59,'v49','negocios','Me gustaría trabajar analizando el mercado y la competencia.',49),(60,'v50','negocios','Disfruto planear estrategias para alcanzar metas a corto y largo plazo.',50),(81,'v51','stem','Prefiero pasar horas depurando un error en un código o una fórmula, en lugar de dejarlo así aunque funcione a medias.',51),(82,'v52','stem','Me llama más la atención calcular cuánto peso puede soportar una estructura que decorar el espacio donde va construida.',52),(83,'v53','stem','Cuando algo eléctrico o mecánico falla en mi casa, soy de los primeros en querer revisar por qué antes de llamar a un técnico.',53),(84,'v54','stem','Prefiero un examen con un solo problema complejo de física o matemáticas a diez preguntas cortas de memoria.',54),(85,'v55','salud','Ante una emergencia médica cerca de mí, sería de los primeros en mantener la calma y ayudar mientras llega personal capacitado.',55),(86,'v56','salud','Me interesa más entender por qué funciona un tratamiento médico que simplemente saber que funciona.',56),(87,'v57','salud','No me incomoda estar cerca de sangre, heridas o fluidos corporales si eso significa poder ayudar a alguien.',57),(88,'v58','salud','Prefiero acompañar a alguien en un proceso de recuperación que dura semanas a resolverle un problema puntual en un solo día.',58),(89,'v59','social','Cuando surge un conflicto en mi grupo de amigos o en mi familia, suelo ser quien intenta mediar entre las partes.',59),(90,'v60','social','Prefiero investigar por qué ocurrió un problema en mi barrio o comunidad a simplemente donar dinero para ayudar.',60),(91,'v61','social','Me interesa más entender las razones detrás de una protesta o movimiento social que enterarme solo del resultado.',61),(92,'v62','social','Disfruto leer sobre cómo culturas distintas a la mía resuelven un mismo problema de forma diferente.',62),(93,'v63','arte','Prefiero pasar horas ajustando un detalle visual (un color, una tipografía, un encuadre) hasta que se vea exactamente como lo imaginé.',63),(94,'v64','arte','Cuando veo un anuncio o una película, me fijo más en cómo está hecho (edición, diseño, dirección) que en la historia misma.',64),(95,'v65','arte','Prefiero crear algo desde cero, aunque salga imperfecto, a seguir una plantilla o un instructivo paso a paso.',65),(96,'v66','arte','Me gustaría que mi trabajo se juzgara por lo original que es, y no solo por si cumple su propósito.',66),(97,'v67','negocios','Cuando trabajo en equipo, casi siempre termino organizando quién hace qué y para cuándo, aunque nadie me lo pida.',67),(98,'v68','negocios','Prefiero negociar un mejor precio o condición antes de aceptar la primera oferta que me dan.',68),(99,'v69','negocios','Me interesa más entender por qué un producto se vende bien que cómo está fabricado.',69),(100,'v70','negocios','Ante una decisión con información incompleta, prefiero decidir rápido y ajustar después, en lugar de esperar a tener todos los datos.',70);
/*!40000 ALTER TABLE `vocacional_preguntas` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

