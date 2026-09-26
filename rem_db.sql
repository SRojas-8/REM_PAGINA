-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 26-09-2026 a las 05:59:02
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `rem_db`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `accesos_premium`
--

CREATE TABLE `accesos_premium` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `test_id` int(11) NOT NULL,
  `codigo_id` int(11) NOT NULL,
  `fecha_activacion` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `accesos_premium`
--

INSERT INTO `accesos_premium` (`id`, `usuario_id`, `test_id`, `codigo_id`, `fecha_activacion`) VALUES
(6, 5, 1, 11, '2026-09-23 23:12:59'),
(7, 5, 2, 12, '2026-09-23 23:29:56');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `codigos_acceso`
--

CREATE TABLE `codigos_acceso` (
  `id` int(11) NOT NULL,
  `solicitud_id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `test_id` int(11) NOT NULL,
  `codigo_hash` varchar(255) NOT NULL,
  `usado` tinyint(1) NOT NULL DEFAULT 0,
  `fecha_creacion` datetime DEFAULT current_timestamp(),
  `fecha_expiracion` datetime NOT NULL,
  `fecha_uso` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `codigos_acceso`
--

INSERT INTO `codigos_acceso` (`id`, `solicitud_id`, `usuario_id`, `test_id`, `codigo_hash`, `usado`, `fecha_creacion`, `fecha_expiracion`, `fecha_uso`) VALUES
(11, 20, 5, 1, '$2y$10$1JELKhAnnCavrT3lVl.Ic.urIMykbtHJmTdTcB9VoPY/9YMt.DWum', 1, '2026-09-23 23:11:46', '2026-09-23 23:41:46', '2026-09-23 23:12:59'),
(12, 17, 5, 2, '$2y$10$vhr7NSSVJHiRwV8zQgl4teYemdyn148NmSZRdEuzdDLWWo7Ry3GHm', 1, '2026-09-23 23:28:42', '2026-09-23 23:58:42', '2026-09-23 23:29:56');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `informes_enviados`
--

CREATE TABLE `informes_enviados` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  `intento_id` int(11) DEFAULT NULL,
  `tipo` enum('informe','codigo','solicitud','bienvenida') NOT NULL,
  `correo_destino` varchar(190) NOT NULL,
  `enviado` tinyint(1) NOT NULL DEFAULT 0,
  `error` varchar(255) DEFAULT NULL,
  `fecha` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `informes_enviados`
--

INSERT INTO `informes_enviados` (`id`, `usuario_id`, `intento_id`, `tipo`, `correo_destino`, `enviado`, `error`, `fecha`) VALUES
(1, 1, 1, 'informe', 'sararojas@iejorgerobledo.edu.co', 0, 'No se pudo enviar el correo.', '2026-09-07 23:15:52'),
(2, 1, 1, 'informe', 'sararojas@iejorgerobledo.edu.co', 0, 'No se pudo enviar el correo.', '2026-09-07 23:15:59'),
(3, 1, 1, 'informe', 'sararojas@iejorgerobledo.edu.co', 0, 'SMTP Error: Could not connect to SMTP host. Connection failed. stream_socket_enable_crypto(): Peer certificate CN=`smtp-relay-offshore-southamerica-east-v2.sendinblue.com\' did not match expected CN=`smtp-relay.brevo.com\' SMTP server error: QUIT command fa', '2026-09-07 23:18:33'),
(4, 1, 1, 'informe', 'sararojas@iejorgerobledo.edu.co', 0, 'SMTP Error: Could not connect to SMTP host. Connection failed. stream_socket_enable_crypto(): Peer certificate CN=`smtp-relay-offshore-southamerica-east-v2.sendinblue.com\' did not match expected CN=`smtp-relay.brevo.com\' SMTP server error: QUIT command fa', '2026-09-07 23:18:36'),
(5, 1, 1, 'informe', 'sararojas@iejorgerobledo.edu.co', 1, NULL, '2026-09-07 23:19:53'),
(6, 1, NULL, 'solicitud', 'remuniversidades@gmail.com', 1, NULL, '2026-09-07 23:23:16'),
(7, 1, NULL, 'codigo', 'sararojas@iejorgerobledo.edu.co', 1, NULL, '2026-09-07 23:46:56'),
(8, 1, NULL, 'solicitud', 'remuniversidades@gmail.com', 1, NULL, '2026-09-07 23:48:12'),
(9, 1, NULL, 'solicitud', 'remuniversidades@gmail.com', 1, NULL, '2026-09-07 23:48:57'),
(10, 1, NULL, 'codigo', 'sararojas@iejorgerobledo.edu.co', 1, NULL, '2026-09-08 00:31:14'),
(11, NULL, 4, 'informe', 'sararojasaya679@gmail.com', 1, NULL, '2026-09-08 03:08:23'),
(12, NULL, 4, 'informe', 'sararojasaya679@gmail.com', 1, NULL, '2026-09-08 03:08:26'),
(13, NULL, NULL, 'solicitud', 'remuniversidades@gmail.com', 1, NULL, '2026-09-08 03:09:42'),
(14, NULL, NULL, 'codigo', 'sararojasaya679@gmail.com', 1, NULL, '2026-09-08 03:11:45'),
(15, NULL, NULL, 'solicitud', 'remuniversidades@gmail.com', 1, NULL, '2026-09-08 03:12:23'),
(16, NULL, NULL, 'solicitud', 'remuniversidades@gmail.com', 1, NULL, '2026-09-08 03:13:36'),
(17, 1, NULL, 'solicitud', 'remuniversidades@gmail.com', 1, NULL, '2026-09-08 03:14:22'),
(18, 1, NULL, 'codigo', 'sararojas@iejorgerobledo.edu.co', 1, NULL, '2026-09-08 09:48:26'),
(19, 1, NULL, 'solicitud', 'remuniversidades@gmail.com', 1, NULL, '2026-09-08 09:48:49'),
(20, NULL, 7, 'informe', 'sararojasaya679@gmail.com', 1, NULL, '2026-09-08 09:54:05'),
(21, NULL, 7, 'informe', 'sararojasaya679@gmail.com', 1, NULL, '2026-09-08 09:54:11'),
(22, NULL, 7, 'informe', 'sararojasaya679@gmail.com', 1, NULL, '2026-09-08 09:54:16'),
(23, NULL, 9, 'informe', 'sararojasaya679@gmail.com', 1, NULL, '2026-09-08 10:04:27'),
(24, 1, NULL, 'codigo', 'sararojas@iejorgerobledo.edu.co', 1, NULL, '2026-09-08 10:06:15'),
(25, NULL, NULL, 'codigo', 'sararojasaya679@gmail.com', 1, NULL, '2026-09-08 10:06:22'),
(26, 1, NULL, 'solicitud', 'remuniversidades@gmail.com', 1, NULL, '2026-09-09 12:42:38'),
(27, 1, NULL, 'codigo', 'sararojas@iejorgerobledo.edu.co', 1, NULL, '2026-09-09 12:46:24'),
(28, 1, NULL, 'solicitud', 'remuniversidades@gmail.com', 1, NULL, '2026-09-09 12:47:47'),
(29, 1, NULL, 'solicitud', 'remuniversidades@gmail.com', 1, NULL, '2026-09-09 12:50:11'),
(30, 1, NULL, 'solicitud', 'remuniversidades@gmail.com', 1, NULL, '2026-09-09 12:50:21'),
(31, 1, NULL, 'solicitud', 'remuniversidades@gmail.com', 1, NULL, '2026-09-09 14:10:58'),
(32, 1, NULL, 'codigo', 'sararojas@iejorgerobledo.edu.co', 1, NULL, '2026-09-09 14:11:05'),
(33, 1, NULL, 'solicitud', 'remuniversidades@gmail.com', 1, NULL, '2026-09-09 14:11:14'),
(34, 1, NULL, 'solicitud', 'remuniversidades@gmail.com', 1, NULL, '2026-09-09 14:11:23'),
(35, 1, NULL, 'solicitud', 'remuniversidades@gmail.com', 1, NULL, '2026-09-09 14:56:35'),
(36, 5, NULL, 'solicitud', 'remuniversidades@gmail.com', 1, NULL, '2026-09-16 15:47:48'),
(37, 1, NULL, 'solicitud', 'remuniversidades@gmail.com', 1, NULL, '2026-09-16 15:53:12'),
(40, 5, NULL, 'solicitud', 'remuniversidades@gmail.com', 1, NULL, '2026-09-20 19:15:51'),
(41, 5, NULL, 'codigo', 'sararojasaya679@gmail.com', 1, NULL, '2026-09-23 23:11:50'),
(42, 5, NULL, 'solicitud', 'remuniversidades@gmail.com', 1, NULL, '2026-09-23 23:12:00'),
(43, 5, 19, 'informe', 'sararojasaya679@gmail.com', 1, NULL, '2026-09-23 23:17:03'),
(44, 5, NULL, 'codigo', 'sararojasaya679@gmail.com', 1, NULL, '2026-09-23 23:28:46'),
(45, 5, NULL, 'solicitud', 'remuniversidades@gmail.com', 1, NULL, '2026-09-23 23:28:53');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `intentos`
--

CREATE TABLE `intentos` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  `test_id` int(11) NOT NULL,
  `modo` enum('gratis','premium') NOT NULL,
  `total_preguntas` int(11) NOT NULL,
  `correctas` int(11) NOT NULL,
  `porcentaje` int(11) NOT NULL,
  `puntaje_estimado` int(11) DEFAULT NULL,
  `resumen` varchar(255) NOT NULL,
  `tiempo_segundos` int(11) DEFAULT NULL,
  `fecha` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `intentos`
--

INSERT INTO `intentos` (`id`, `usuario_id`, `test_id`, `modo`, `total_preguntas`, `correctas`, `porcentaje`, `puntaje_estimado`, `resumen`, `tiempo_segundos`, `fecha`) VALUES
(1, 1, 1, 'gratis', 20, 0, 55, NULL, 'Tu perfil vocacional predominante es Ciencias de la Salud (55% de afinidad).', NULL, '2026-09-07 23:15:46'),
(2, NULL, 1, 'gratis', 20, 0, 15, NULL, 'Tu perfil vocacional predominante es Artes y Comunicación (15% de afinidad).', NULL, '2026-09-07 23:42:14'),
(3, 1, 1, 'premium', 30, 0, 47, NULL, 'Tu perfil vocacional predominante es Ciencias Exactas e Ingeniería (47% de afinidad).', NULL, '2026-09-07 23:48:40'),
(4, NULL, 1, 'gratis', 20, 0, 50, NULL, 'Tu perfil vocacional predominante es Artes y Comunicación (50% de afinidad).', NULL, '2026-09-08 03:07:46'),
(5, NULL, 1, 'premium', 30, 0, 47, NULL, 'Tu perfil vocacional predominante es Ciencias Exactas e Ingeniería (47% de afinidad).', NULL, '2026-09-08 03:13:16'),
(6, NULL, 1, 'premium', 30, 0, 47, NULL, 'Tu perfil vocacional predominante es Ciencias Exactas e Ingeniería (47% de afinidad).', NULL, '2026-09-08 03:13:17'),
(7, NULL, 1, 'gratis', 20, 0, 55, NULL, 'Tu perfil vocacional predominante es Ciencias Sociales y Humanas (55% de afinidad).', NULL, '2026-09-08 09:53:52'),
(8, NULL, 1, 'gratis', 20, 0, 50, NULL, 'Tu perfil vocacional predominante es Ciencias Sociales y Humanas (50% de afinidad).', NULL, '2026-09-08 10:03:53'),
(9, NULL, 1, 'gratis', 20, 0, 50, NULL, 'Tu perfil vocacional predominante es Ciencias Sociales y Humanas (50% de afinidad).', NULL, '2026-09-08 10:03:53'),
(10, 1, 1, 'gratis', 20, 0, 55, NULL, 'Tu perfil vocacional predominante es Ciencias de la Salud (55% de afinidad).', NULL, '2026-09-09 14:51:20'),
(11, 1, 1, 'gratis', 20, 0, 55, NULL, 'Tu perfil vocacional predominante es Ciencias de la Salud (55% de afinidad).', NULL, '2026-09-09 14:51:20'),
(12, NULL, 1, 'gratis', 20, 0, 60, NULL, 'Tu perfil vocacional predominante es Ciencias de la Salud (60% de afinidad).', NULL, '2026-09-16 14:55:51'),
(13, 1, 1, 'gratis', 20, 0, 60, NULL, 'Tu perfil vocacional predominante es Ciencias Exactas e Ingeniería (60% de afinidad).', NULL, '2026-09-16 15:52:18'),
(14, 1, 1, 'gratis', 20, 0, 60, NULL, 'Tu perfil vocacional predominante es Ciencias Exactas e Ingeniería (60% de afinidad).', NULL, '2026-09-16 15:52:19'),
(16, 5, 1, 'gratis', 20, 0, 45, NULL, 'Tu perfil vocacional predominante es Administración y Negocios (45% de afinidad).', NULL, '2026-09-20 20:18:24'),
(17, 5, 2, 'gratis', 20, 17, 85, 425, 'Obtuviste 85% (17/20 correctas) — Nivel Muy Alto. Puntaje estimado: 425/500.', 97, '2026-09-20 20:28:52'),
(18, 5, 1, 'gratis', 20, 0, 55, NULL, 'Tu perfil vocacional predominante es 🩺 Ciencias de la Salud (55% de afinidad).', NULL, '2026-09-20 20:30:55'),
(19, 5, 1, 'premium', 50, 0, 86, NULL, 'Tu perfil vocacional predominante es 🌍 Ciencias Sociales y Humanas (86% de afinidad).', NULL, '2026-09-23 23:16:44');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `opciones_premium`
--

CREATE TABLE `opciones_premium` (
  `id` int(11) NOT NULL,
  `pregunta_id` int(11) NOT NULL,
  `texto` varchar(255) NOT NULL,
  `orden` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `opciones_premium`
--

INSERT INTO `opciones_premium` (`id`, `pregunta_id`, `texto`, `orden`) VALUES
(1, 1, '5', 1),
(2, 1, '6', 2),
(3, 1, '7', 3),
(4, 1, '8', 4),
(5, 2, '13 cm²', 1),
(6, 2, '26 cm²', 2),
(7, 2, '40 cm²', 3),
(8, 2, '45 cm²', 4),
(9, 3, '4', 1),
(10, 3, '5', 2),
(11, 3, '6', 3),
(12, 3, '8', 4),
(13, 4, '2/5', 1),
(14, 4, '3/6', 2),
(15, 4, '4/9', 3),
(16, 4, '5/8', 4),
(17, 5, '100', 1),
(18, 5, '150', 2),
(19, 5, '200', 3),
(20, 5, '250', 4),
(21, 6, 'Cuadrado', 1),
(22, 6, 'Rectángulo', 2),
(23, 6, 'Triángulo equilátero', 3),
(24, 6, 'Pentágono', 4),
(25, 7, 'Porque aumentan el estrés', 1),
(26, 7, 'Porque reducen la producción de melatonina', 2),
(27, 7, 'Porque generan ruido', 3),
(28, 7, 'Porque consumen mucha energía', 4),
(29, 8, 'Abundante', 1),
(30, 8, 'Reducido', 2),
(31, 8, 'Limitado', 3),
(32, 8, 'Insuficiente', 4),
(33, 9, 'Conclusión', 1),
(34, 9, 'Contraste', 2),
(35, 9, 'Adición', 3),
(36, 9, 'Ejemplo', 4),
(37, 10, 'Aumento de la pesca', 1),
(38, 10, 'Escasez de agua para las comunidades cercanas', 2),
(39, 10, 'Mayor cantidad de lluvias', 3),
(40, 10, 'Mejora en la calidad del agua', 4),
(41, 11, 'Narrar una historia', 1),
(42, 11, 'Convencer al lector de una idea', 2),
(43, 11, 'Describir un lugar', 3),
(44, 11, 'Dar instrucciones', 4),
(45, 12, 'Desinterés por la educación', 1),
(46, 12, 'Resignación', 2),
(47, 12, 'Esfuerzo y valor por la educación', 3),
(48, 12, 'Indiferencia', 4),
(49, 13, 'Átomo', 1),
(50, 13, 'Célula', 2),
(51, 13, 'Molécula', 3),
(52, 13, 'Tejido', 4),
(53, 14, 'Venus', 1),
(54, 14, 'Marte', 2),
(55, 14, 'Júpiter', 3),
(56, 14, 'Saturno', 4),
(57, 15, 'Combatir infecciones', 1),
(58, 15, 'Transportar oxígeno', 2),
(59, 15, 'Coagular la sangre', 3),
(60, 15, 'Producir hormonas', 4),
(61, 16, 'Respiración', 1),
(62, 16, 'Fotosíntesis', 2),
(63, 16, 'Transpiración', 3),
(64, 16, 'Digestión', 4),
(65, 17, 'Ley de la gravedad', 1),
(66, 17, 'Primera ley de Newton', 2),
(67, 17, 'Tercera ley de Newton', 3),
(68, 17, 'Ley de conservación de la energía', 4),
(69, 18, 'Homogénea', 1),
(70, 18, 'Heterogénea', 2),
(71, 18, 'Disolución', 3),
(72, 18, 'Aleación', 4),
(73, 19, 'Decreto', 1),
(74, 19, 'Constitución', 2),
(75, 19, 'Manual de convivencia', 3),
(76, 19, 'Tratado', 4),
(77, 20, 'FIFA', 1),
(78, 20, 'ONU', 2),
(79, 20, 'OTAN', 3),
(80, 20, 'OMC', 4),
(81, 21, 'No participar en política', 1),
(82, 21, 'Participar y aportar en la vida pública y social', 2),
(83, 21, 'Vivir aislado de la comunidad', 3),
(84, 21, 'Solo cumplir con pagar impuestos', 4),
(85, 22, 'Ignora los derechos sociales', 1),
(86, 22, 'Garantiza derechos económicos, sociales y culturales', 2),
(87, 22, 'Elimina la Constitución', 3),
(88, 22, 'No permite el voto', 4),
(89, 23, 'El aislamiento entre países', 1),
(90, 23, 'El proceso de integración económica, social y cultural entre países', 2),
(91, 23, 'La eliminación del comercio internacional', 3),
(92, 23, 'Un tipo de gobierno', 4),
(93, 24, 'El voto', 1),
(94, 24, 'Ignorar las noticias', 2),
(95, 24, 'No opinar sobre temas públicos', 3),
(96, 24, 'Evitar el diálogo', 4),
(97, 25, 'Childs', 1),
(98, 25, 'Children', 2),
(99, 25, 'Childes', 3),
(100, 25, 'Childrens', 4),
(101, 26, 'Goed', 1),
(102, 26, 'Went', 2),
(103, 26, 'Gone', 3),
(104, 26, 'Going', 4),
(105, 27, 'have', 1),
(106, 27, 'has', 2),
(107, 27, 'had', 3),
(108, 27, 'having', 4),
(109, 28, 'Large', 1),
(110, 28, 'Huge', 2),
(111, 28, 'Small', 3),
(112, 28, 'Tall', 4),
(113, 29, 'He don\'t like coffee', 1),
(114, 29, 'He doesn\'t likes coffee', 2),
(115, 29, 'He doesn\'t like coffee', 3),
(116, 29, 'He not like coffee', 4),
(117, 30, 'Librería', 1),
(118, 30, 'Biblioteca', 2),
(119, 30, 'Papelería', 3),
(120, 30, 'Oficina', 4),
(121, 61, '14 horas', 1),
(122, 61, '24 horas', 2),
(123, 61, '2 horas', 3),
(124, 61, '48 horas', 4),
(125, 62, '35', 1),
(126, 62, '70', 2),
(127, 62, '65', 3),
(128, 62, '135', 4),
(129, 63, '3.75', 1),
(130, 63, '4.0', 2),
(131, 63, '4.25', 3),
(132, 63, '4.5', 4),
(133, 64, '7 cm', 1),
(134, 64, '10 cm', 2),
(135, 64, '14 cm', 3),
(136, 64, '48 cm', 4),
(137, 65, 'Los jóvenes ya no usan redes sociales', 1),
(138, 65, 'El cambio en los hábitos de lectura preocupa a los educadores', 2),
(139, 65, 'Los videos cortos son mejores que los artículos', 3),
(140, 65, 'Los educadores prefieren las redes sociales', 4),
(141, 66, 'Descuidado', 1),
(142, 66, 'Minucioso', 2),
(143, 66, 'Apresurado', 3),
(144, 66, 'Distraído', 4),
(145, 67, 'No tenían otras opciones para comer', 1),
(146, 67, 'Confiaban en la reputación del restaurante', 2),
(147, 67, 'No les importaba la calidad de la comida', 3),
(148, 67, 'Estaban de mal humor', 4),
(149, 68, 'Narrativo', 1),
(150, 68, 'Instructivo', 2),
(151, 68, 'Argumentativo', 3),
(152, 68, 'Poético', 4),
(153, 69, 'Almacenar información genética', 1),
(154, 69, 'Producir energía para la célula', 2),
(155, 69, 'Sintetizar proteínas', 3),
(156, 69, 'Eliminar desechos celulares', 4),
(157, 70, 'La primera ley de Newton', 1),
(158, 70, 'La segunda ley de Newton', 2),
(159, 70, 'La tercera ley de Newton', 3),
(160, 70, 'La ley de gravitación universal', 4),
(161, 71, 'Es básica', 1),
(162, 71, 'Es ácida', 2),
(163, 71, 'Es neutra', 3),
(164, 71, 'Es un metal', 4),
(165, 72, 'Parasitismo', 1),
(166, 72, 'Depredación', 2),
(167, 72, 'Mutualismo', 3),
(168, 72, 'Competencia', 4),
(169, 73, 'Deflación', 1),
(170, 73, 'Inflación', 2),
(171, 73, 'Devaluación', 3),
(172, 73, 'Recesión', 4),
(173, 74, 'Región Caribe', 1),
(174, 74, 'Región Andina', 2),
(175, 74, 'Región Pacífica', 3),
(176, 74, 'Región Orinoquía', 4),
(177, 75, 'Rama ejecutiva', 1),
(178, 75, 'Rama legislativa', 2),
(179, 75, 'Rama judicial', 3),
(180, 75, 'Órgano electoral', 4),
(181, 76, 'Regular el comercio internacional', 1),
(182, 76, 'Reducir las emisiones de gases de efecto invernadero', 2),
(183, 76, 'Eliminar las fronteras entre países', 3),
(184, 76, 'Crear una moneda única mundial', 4),
(185, 77, 'stay', 1),
(186, 77, 'stayed', 2),
(187, 77, 'will stay', 3),
(188, 77, 'staying', 4),
(189, 78, 'Easy', 1),
(190, 78, 'Hard', 2),
(191, 78, 'Simple', 3),
(192, 78, 'Fast', 4),
(193, 79, 'interesting', 1),
(194, 79, 'more interesting', 2),
(195, 79, 'most interesting', 3),
(196, 79, 'interestinger', 4),
(197, 80, 'wrote', 1),
(198, 80, 'was written', 2),
(199, 80, 'is write', 3),
(200, 80, 'writes', 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `preguntas_premium`
--

CREATE TABLE `preguntas_premium` (
  `id` int(11) NOT NULL,
  `test_id` int(11) NOT NULL,
  `clave` varchar(10) NOT NULL,
  `area_clave` varchar(30) NOT NULL,
  `texto` text NOT NULL,
  `tipo` enum('opcion','escala') NOT NULL,
  `respuesta` varchar(255) DEFAULT NULL,
  `orden` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `preguntas_premium`
--

INSERT INTO `preguntas_premium` (`id`, `test_id`, `clave`, `area_clave`, `texto`, `tipo`, `respuesta`, `orden`) VALUES
(1, 2, 'a05', 'mate', 'Si x + 5 = 12, ¿cuál es el valor de x?', 'opcion', '7', 5),
(2, 2, 'a06', 'mate', '¿Cuál es el área de un rectángulo de base 8 cm y altura 5 cm?', 'opcion', '40 cm²', 6),
(3, 2, 'a07', 'mate', 'Un grupo de 24 estudiantes se divide en equipos de 4 personas. ¿Cuántos equipos se forman?', 'opcion', '6', 7),
(4, 2, 'a08', 'mate', '¿Cuál de las siguientes fracciones es equivalente a 1/2?', 'opcion', '3/6', 8),
(5, 2, 'a09', 'mate', 'Si el 25% de un número es 50, ¿cuál es ese número?', 'opcion', '200', 9),
(6, 2, 'a10', 'mate', 'Una figura tiene sus 3 lados iguales. ¿Cómo se llama esa figura?', 'opcion', 'Triángulo equilátero', 10),
(7, 2, 'a15', 'lectura', '\"El uso excesivo de pantallas antes de dormir puede afectar el sueño, ya que la luz que emiten reduce la producción de melatonina.\" Según el texto, ¿por qué las pantallas afectan el sueño?', 'opcion', 'Porque reducen la producción de melatonina', 15),
(8, 2, 'a16', 'lectura', '¿Cuál de las siguientes palabras es antónimo de \"escaso\"?', 'opcion', 'Abundante', 16),
(9, 2, 'a17', 'lectura', '\"El equipo perdió el partido, sin embargo, clasificó a la siguiente ronda gracias a los resultados de los otros equipos.\" ¿Qué tipo de conector es \"sin embargo\"?', 'opcion', 'Contraste', 17),
(10, 2, 'a18', 'lectura', '\"Los ríos de la región han bajado su caudal en los últimos años.\" ¿Cuál sería una consecuencia lógica de esta situación?', 'opcion', 'Escasez de agua para las comunidades cercanas', 18),
(11, 2, 'a19', 'lectura', '¿Cuál es la función principal de un texto argumentativo?', 'opcion', 'Convencer al lector de una idea', 19),
(12, 2, 'a20', 'lectura', '\"A pesar de las dificultades económicas, la familia logró enviar a sus tres hijos a la universidad.\" ¿Qué actitud se puede inferir de la familia?', 'opcion', 'Esfuerzo y valor por la educación', 20),
(13, 2, 'a25', 'ciencias', '¿Cuál es la unidad básica de los seres vivos?', 'opcion', 'Célula', 25),
(14, 2, 'a26', 'ciencias', '¿Qué planeta del sistema solar es conocido como el planeta rojo?', 'opcion', 'Marte', 26),
(15, 2, 'a27', 'ciencias', '¿Cuál es la función principal de los glóbulos rojos?', 'opcion', 'Transportar oxígeno', 27),
(16, 2, 'a28', 'ciencias', '¿Qué proceso permite a las plantas producir su propio alimento?', 'opcion', 'Fotosíntesis', 28),
(17, 2, 'a29', 'ciencias', '¿Cuál ley explica que a toda acción corresponde una reacción de igual magnitud y sentido contrario?', 'opcion', 'Tercera ley de Newton', 29),
(18, 2, 'a30', 'ciencias', '¿Qué tipo de mezcla se forma al combinar agua y aceite?', 'opcion', 'Heterogénea', 30),
(19, 2, 'a35', 'sociales', '¿Qué nombre recibe el documento que establece las normas fundamentales de un Estado?', 'opcion', 'Constitución', 35),
(20, 2, 'a36', 'sociales', '¿Cuál de estos organismos vela por los derechos humanos a nivel internacional?', 'opcion', 'ONU', 36),
(21, 2, 'a37', 'sociales', '¿Qué se entiende por \"ciudadanía activa\"?', 'opcion', 'Participar y aportar en la vida pública y social', 37),
(22, 2, 'a38', 'sociales', '¿Cuál es una característica de un Estado social de derecho?', 'opcion', 'Garantiza derechos económicos, sociales y culturales', 38),
(23, 2, 'a39', 'sociales', '¿Qué es la globalización?', 'opcion', 'El proceso de integración económica, social y cultural entre países', 39),
(24, 2, 'a40', 'sociales', '¿Cuál de las siguientes es una forma de participación ciudadana?', 'opcion', 'El voto', 40),
(25, 2, 'a45', 'ingles', 'What is the plural of \"child\"?', 'opcion', 'Children', 45),
(26, 2, 'a46', 'ingles', 'Choose the correct past tense of \"go\":', 'opcion', 'Went', 46),
(27, 2, 'a47', 'ingles', '\"I ___ finished my homework.\" (present perfect)', 'opcion', 'have', 47),
(28, 2, 'a48', 'ingles', 'What is the opposite of \"big\"?', 'opcion', 'Small', 48),
(29, 2, 'a49', 'ingles', 'Choose the correct sentence:', 'opcion', 'He doesn\'t like coffee', 49),
(30, 2, 'a50', 'ingles', 'What does \"library\" mean in Spanish?', 'opcion', 'Biblioteca', 50),
(31, 1, 'v05', 'stem', 'Disfruto programar o crear pequeños proyectos con el computador.', 'escala', NULL, 5),
(32, 1, 'v06', 'stem', 'Me interesa saber cómo se genera y se transporta la energía.', 'escala', NULL, 6),
(33, 1, 'v07', 'stem', 'Prefiero las materias de física y cálculo sobre las de historia o literatura.', 'escala', NULL, 7),
(34, 1, 'v08', 'stem', 'Me gusta desarmar objetos para entender cómo están hechos por dentro.', 'escala', NULL, 8),
(35, 1, 'v09', 'stem', 'Disfruto los retos que requieren pensamiento lógico paso a paso.', 'escala', NULL, 9),
(36, 1, 'v10', 'stem', 'Me interesaría trabajar en un laboratorio o en el desarrollo de nueva tecnología.', 'escala', NULL, 10),
(37, 1, 'v15', 'salud', 'Me interesa la biología y cómo funcionan los seres vivos.', 'escala', NULL, 15),
(38, 1, 'v16', 'salud', 'Disfruto cuidar de otras personas, animales o de mí mismo/a en temas de salud.', 'escala', NULL, 16),
(39, 1, 'v17', 'salud', 'Me gustaría aprender sobre nutrición, ejercicio o bienestar físico.', 'escala', NULL, 17),
(40, 1, 'v18', 'salud', 'Siento curiosidad por entender las enfermedades y cómo se tratan.', 'escala', NULL, 18),
(41, 1, 'v19', 'salud', 'Me gustaría acompañar procesos de recuperación o rehabilitación de otras personas.', 'escala', NULL, 19),
(42, 1, 'v20', 'salud', 'Disfruto las actividades donde debo seguir protocolos y cuidar los detalles.', 'escala', NULL, 20),
(43, 1, 'v25', 'social', 'Me interesa el debate y defender mis ideas con argumentos.', 'escala', NULL, 25),
(44, 1, 'v26', 'social', 'Disfruto escribir ensayos, reflexiones o textos de opinión.', 'escala', NULL, 26),
(45, 1, 'v27', 'social', 'Me llama la atención estudiar idiomas y otras culturas.', 'escala', NULL, 27),
(46, 1, 'v28', 'social', 'Me gustaría trabajar orientando o acompañando a otras personas (educación, psicología, trabajo social).', 'escala', NULL, 28),
(47, 1, 'v29', 'social', 'Me interesa participar en actividades de liderazgo social o comunitario.', 'escala', NULL, 29),
(48, 1, 'v30', 'social', 'Disfruto analizar noticias y formar mi propia opinión sobre temas actuales.', 'escala', NULL, 30),
(49, 1, 'v35', 'arte', 'Me interesa la fotografía, el cine o la producción audiovisual.', 'escala', NULL, 35),
(50, 1, 'v36', 'arte', 'Me gustaría trabajar diseñando marcas, espacios o experiencias visuales.', 'escala', NULL, 36),
(51, 1, 'v37', 'arte', 'Disfruto la música, el teatro o la danza como forma de expresión.', 'escala', NULL, 37),
(52, 1, 'v38', 'arte', 'Me gusta estar al día con tendencias de redes sociales y comunicación digital.', 'escala', NULL, 38),
(53, 1, 'v39', 'arte', 'Prefiero los proyectos donde puedo innovar y salirme de lo convencional.', 'escala', NULL, 39),
(54, 1, 'v40', 'arte', 'Me gustaría que mi trabajo tuviera un componente artístico o creativo todos los días.', 'escala', NULL, 40),
(55, 1, 'v45', 'negocios', 'Me gustaría emprender mi propio negocio en el futuro.', 'escala', NULL, 45),
(56, 1, 'v46', 'negocios', 'Disfruto negociar, convencer o venderle una idea a otras personas.', 'escala', NULL, 46),
(57, 1, 'v47', 'negocios', 'Me interesa la publicidad y cómo se posicionan las marcas en el mercado.', 'escala', NULL, 47),
(58, 1, 'v48', 'negocios', 'Soy bueno/a tomando decisiones bajo presión o con información limitada.', 'escala', NULL, 48),
(59, 1, 'v49', 'negocios', 'Me gustaría trabajar analizando el mercado y la competencia.', 'escala', NULL, 49),
(60, 1, 'v50', 'negocios', 'Disfruto planear estrategias para alcanzar metas a corto y largo plazo.', 'escala', NULL, 50),
(61, 2, 'a51', 'mate', 'Si un tanque se llena en 6 horas con una llave y se vacía en 8 horas con un desagüe abierto, ¿en cuántas horas se llena por completo si ambas permanecen abiertas al mismo tiempo?', 'opcion', '24 horas', 51),
(62, 2, 'a52', 'mate', 'En una encuesta a 200 estudiantes, el 35% dijo preferir estudiar en la mañana. ¿Cuántos estudiantes prefieren estudiar en la mañana?', 'opcion', '70', 52),
(63, 2, 'a53', 'mate', 'Las calificaciones de un estudiante en 4 materias fueron 3.5, 4.0, 4.5 y 4.0. ¿Cuál es su promedio?', 'opcion', '4.0', 53),
(64, 2, 'a54', 'mate', 'Un triángulo rectángulo tiene catetos de 6 cm y 8 cm. ¿Cuál es la longitud de la hipotenusa?', 'opcion', '10 cm', 54),
(65, 2, 'a55', 'lectura', '\"Cada vez más jóvenes prefieren informarse a través de videos cortos en redes sociales en lugar de leer artículos completos, lo que ha generado preocupación entre educadores sobre la capacidad de análisis profundo de las nuevas generaciones.\" ¿Cuál es la idea principal del texto?', 'opcion', 'El cambio en los hábitos de lectura preocupa a los educadores', 55),
(66, 2, 'a56', 'lectura', '¿Cuál palabra podría reemplazar a \"meticuloso\" sin cambiar el sentido de la oración \"El investigador fue meticuloso al revisar cada dato\"?', 'opcion', 'Minucioso', 56),
(67, 2, 'a57', 'lectura', '\"Aunque el restaurante estaba lleno y había fila en la puerta, decidimos esperar porque ya habíamos escuchado muy buenos comentarios sobre la comida.\" ¿Qué se puede inferir de las personas que esperaron?', 'opcion', 'Confiaban en la reputación del restaurante', 57),
(68, 2, 'a58', 'lectura', 'Un texto que explica paso a paso cómo armar un mueble, usando numeración y verbos en modo imperativo (\"coloque\", \"ajuste\", \"asegure\"), es un texto de tipo:', 'opcion', 'Instructivo', 58),
(69, 2, 'a59', 'ciencias', '¿Cuál es la principal función de las mitocondrias dentro de una célula?', 'opcion', 'Producir energía para la célula', 59),
(70, 2, 'a60', 'ciencias', '\"Un cuerpo en reposo permanece en reposo, y un cuerpo en movimiento continúa en movimiento a menos que actúe sobre él una fuerza externa.\" Este enunciado corresponde a:', 'opcion', 'La primera ley de Newton', 60),
(71, 2, 'a61', 'ciencias', '¿Qué característica tiene una sustancia con pH menor a 7?', 'opcion', 'Es ácida', 61),
(72, 2, 'a62', 'ciencias', '¿Cómo se llama la relación biológica en la que dos especies se benefician mutuamente?', 'opcion', 'Mutualismo', 62),
(73, 2, 'a63', 'sociales', '¿Cómo se conoce al aumento generalizado y sostenido de los precios de bienes y servicios en una economía?', 'opcion', 'Inflación', 63),
(74, 2, 'a64', 'sociales', '¿En cuál región natural de Colombia se ubica la ciudad de Medellín?', 'opcion', 'Región Andina', 64),
(75, 2, 'a65', 'sociales', '¿Cuál de las tres ramas del poder público en Colombia es la encargada de administrar justicia?', 'opcion', 'Rama judicial', 65),
(76, 2, 'a66', 'sociales', '¿Cuál es el objetivo principal del Acuerdo de París, firmado por la mayoría de países del mundo?', 'opcion', 'Reducir las emisiones de gases de efecto invernadero', 66),
(77, 2, 'a67', 'ingles', 'Choose the correct option: \"If it rains tomorrow, I ___ at home.\"', 'opcion', 'will stay', 67),
(78, 2, 'a68', 'ingles', 'What is the synonym of \"difficult\"?', 'opcion', 'Hard', 68),
(79, 2, 'a69', 'ingles', 'Choose the correct comparative form: \"This book is ___ than that one.\"', 'opcion', 'more interesting', 69),
(80, 2, 'a70', 'ingles', 'Choose the correct passive voice: \"The letter ___ by Maria.\"', 'opcion', 'was written', 70),
(81, 1, 'v51', 'stem', 'Prefiero pasar horas depurando un error en un código o una fórmula, en lugar de dejarlo así aunque funcione a medias.', 'escala', NULL, 51),
(82, 1, 'v52', 'stem', 'Me llama más la atención calcular cuánto peso puede soportar una estructura que decorar el espacio donde va construida.', 'escala', NULL, 52),
(83, 1, 'v53', 'stem', 'Cuando algo eléctrico o mecánico falla en mi casa, soy de los primeros en querer revisar por qué antes de llamar a un técnico.', 'escala', NULL, 53),
(84, 1, 'v54', 'stem', 'Prefiero un examen con un solo problema complejo de física o matemáticas a diez preguntas cortas de memoria.', 'escala', NULL, 54),
(85, 1, 'v55', 'salud', 'Ante una emergencia médica cerca de mí, sería de los primeros en mantener la calma y ayudar mientras llega personal capacitado.', 'escala', NULL, 55),
(86, 1, 'v56', 'salud', 'Me interesa más entender por qué funciona un tratamiento médico que simplemente saber que funciona.', 'escala', NULL, 56),
(87, 1, 'v57', 'salud', 'No me incomoda estar cerca de sangre, heridas o fluidos corporales si eso significa poder ayudar a alguien.', 'escala', NULL, 57),
(88, 1, 'v58', 'salud', 'Prefiero acompañar a alguien en un proceso de recuperación que dura semanas a resolverle un problema puntual en un solo día.', 'escala', NULL, 58),
(89, 1, 'v59', 'social', 'Cuando surge un conflicto en mi grupo de amigos o en mi familia, suelo ser quien intenta mediar entre las partes.', 'escala', NULL, 59),
(90, 1, 'v60', 'social', 'Prefiero investigar por qué ocurrió un problema en mi barrio o comunidad a simplemente donar dinero para ayudar.', 'escala', NULL, 60),
(91, 1, 'v61', 'social', 'Me interesa más entender las razones detrás de una protesta o movimiento social que enterarme solo del resultado.', 'escala', NULL, 61),
(92, 1, 'v62', 'social', 'Disfruto leer sobre cómo culturas distintas a la mía resuelven un mismo problema de forma diferente.', 'escala', NULL, 62),
(93, 1, 'v63', 'arte', 'Prefiero pasar horas ajustando un detalle visual (un color, una tipografía, un encuadre) hasta que se vea exactamente como lo imaginé.', 'escala', NULL, 63),
(94, 1, 'v64', 'arte', 'Cuando veo un anuncio o una película, me fijo más en cómo está hecho (edición, diseño, dirección) que en la historia misma.', 'escala', NULL, 64),
(95, 1, 'v65', 'arte', 'Prefiero crear algo desde cero, aunque salga imperfecto, a seguir una plantilla o un instructivo paso a paso.', 'escala', NULL, 65),
(96, 1, 'v66', 'arte', 'Me gustaría que mi trabajo se juzgara por lo original que es, y no solo por si cumple su propósito.', 'escala', NULL, 66),
(97, 1, 'v67', 'negocios', 'Cuando trabajo en equipo, casi siempre termino organizando quién hace qué y para cuándo, aunque nadie me lo pida.', 'escala', NULL, 67),
(98, 1, 'v68', 'negocios', 'Prefiero negociar un mejor precio o condición antes de aceptar la primera oferta que me dan.', 'escala', NULL, 68),
(99, 1, 'v69', 'negocios', 'Me interesa más entender por qué un producto se vende bien que cómo está fabricado.', 'escala', NULL, 69),
(100, 1, 'v70', 'negocios', 'Ante una decisión con información incompleta, prefiero decidir rápido y ajustar después, en lugar de esperar a tener todos los datos.', 'escala', NULL, 70);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `respuestas_intento`
--

CREATE TABLE `respuestas_intento` (
  `id` int(11) NOT NULL,
  `intento_id` int(11) NOT NULL,
  `pregunta_clave` varchar(10) NOT NULL,
  `area_clave` varchar(30) NOT NULL,
  `respuesta_dada` varchar(255) DEFAULT NULL,
  `valor` int(11) DEFAULT NULL,
  `correcta` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `respuestas_intento`
--

INSERT INTO `respuestas_intento` (`id`, `intento_id`, `pregunta_clave`, `area_clave`, `respuesta_dada`, `valor`, `correcta`) VALUES
(1, 1, 'v04', 'stem', NULL, 3, NULL),
(2, 1, 'v11', 'salud', NULL, 4, NULL),
(3, 1, 'v12', 'salud', NULL, 5, NULL),
(4, 1, 'v14', 'salud', NULL, 2, NULL),
(5, 1, 'v21', 'social', NULL, 1, NULL),
(6, 1, 'v31', 'arte', NULL, 3, NULL),
(7, 1, 'v24', 'social', NULL, 4, NULL),
(8, 1, 'v22', 'social', NULL, 5, NULL),
(9, 1, 'v33', 'arte', NULL, 3, NULL),
(10, 1, 'v34', 'arte', NULL, 4, NULL),
(11, 1, 'v03', 'stem', NULL, 3, NULL),
(12, 2, 'v33', 'arte', NULL, 3, NULL),
(13, 3, 'v46', 'negocios', NULL, 3, NULL),
(14, 3, 'v50', 'negocios', NULL, 4, NULL),
(15, 3, 'v15', 'salud', NULL, 3, NULL),
(16, 3, 'v49', 'negocios', NULL, 3, NULL),
(17, 3, 'v20', 'salud', NULL, 3, NULL),
(18, 3, 'v19', 'salud', NULL, 5, NULL),
(19, 3, 'v26', 'social', NULL, 5, NULL),
(20, 3, 'v30', 'social', NULL, 4, NULL),
(21, 3, 'v35', 'arte', NULL, 4, NULL),
(22, 3, 'v29', 'social', NULL, 2, NULL),
(23, 3, 'v09', 'stem', NULL, 2, NULL),
(24, 3, 'v45', 'negocios', NULL, 1, NULL),
(25, 3, 'v06', 'stem', NULL, 3, NULL),
(26, 3, 'v36', 'arte', NULL, 4, NULL),
(27, 3, 'v05', 'stem', NULL, 4, NULL),
(28, 3, 'v48', 'negocios', NULL, 2, NULL),
(29, 3, 'v10', 'stem', NULL, 2, NULL),
(30, 3, 'v08', 'stem', NULL, 3, NULL),
(31, 4, 'v01', 'stem', NULL, 2, NULL),
(32, 4, 'v14', 'salud', NULL, 3, NULL),
(33, 4, 'v13', 'salud', NULL, 4, NULL),
(34, 4, 'v44', 'negocios', NULL, 5, NULL),
(35, 4, 'v34', 'arte', NULL, 3, NULL),
(36, 4, 'v41', 'negocios', NULL, 1, NULL),
(37, 4, 'v31', 'arte', NULL, 2, NULL),
(38, 4, 'v32', 'arte', NULL, 3, NULL),
(39, 4, 'v21', 'social', NULL, 4, NULL),
(40, 4, 'v43', 'negocios', NULL, 3, NULL),
(41, 4, 'v33', 'arte', NULL, 2, NULL),
(42, 5, 'v36', 'arte', NULL, 3, NULL),
(43, 5, 'v16', 'salud', NULL, 4, NULL),
(44, 5, 'v35', 'arte', NULL, 2, NULL),
(45, 5, 'v10', 'stem', NULL, 2, NULL),
(46, 5, 'v38', 'arte', NULL, 4, NULL),
(47, 5, 'v28', 'social', NULL, 4, NULL),
(48, 5, 'v40', 'arte', NULL, 3, NULL),
(49, 5, 'v07', 'stem', NULL, 5, NULL),
(50, 5, 'v08', 'stem', NULL, 5, NULL),
(51, 5, 'v20', 'salud', NULL, 1, NULL),
(52, 5, 'v26', 'social', NULL, 2, NULL),
(53, 5, 'v47', 'negocios', NULL, 3, NULL),
(54, 5, 'v45', 'negocios', NULL, 4, NULL),
(55, 5, 'v39', 'arte', NULL, 2, NULL),
(56, 5, 'v05', 'stem', NULL, 2, NULL),
(57, 5, 'v48', 'negocios', NULL, 3, NULL),
(58, 6, 'v36', 'arte', NULL, 3, NULL),
(59, 6, 'v16', 'salud', NULL, 4, NULL),
(60, 6, 'v35', 'arte', NULL, 2, NULL),
(61, 6, 'v10', 'stem', NULL, 2, NULL),
(62, 6, 'v38', 'arte', NULL, 4, NULL),
(63, 6, 'v28', 'social', NULL, 4, NULL),
(64, 6, 'v40', 'arte', NULL, 3, NULL),
(65, 6, 'v07', 'stem', NULL, 5, NULL),
(66, 6, 'v08', 'stem', NULL, 5, NULL),
(67, 6, 'v20', 'salud', NULL, 1, NULL),
(68, 6, 'v26', 'social', NULL, 2, NULL),
(69, 6, 'v47', 'negocios', NULL, 3, NULL),
(70, 6, 'v45', 'negocios', NULL, 4, NULL),
(71, 6, 'v39', 'arte', NULL, 2, NULL),
(72, 6, 'v05', 'stem', NULL, 2, NULL),
(73, 6, 'v48', 'negocios', NULL, 3, NULL),
(74, 7, 'v14', 'salud', NULL, 3, NULL),
(75, 7, 'v22', 'social', NULL, 4, NULL),
(76, 7, 'v04', 'stem', NULL, 2, NULL),
(77, 7, 'v12', 'salud', NULL, 1, NULL),
(78, 7, 'v44', 'negocios', NULL, 5, NULL),
(79, 7, 'v21', 'social', NULL, 4, NULL),
(80, 7, 'v11', 'salud', NULL, 2, NULL),
(81, 7, 'v23', 'social', NULL, 3, NULL),
(82, 7, 'v34', 'arte', NULL, 4, NULL),
(83, 7, 'v01', 'stem', NULL, 1, NULL),
(84, 8, 'v21', 'social', NULL, 2, NULL),
(85, 8, 'v34', 'arte', NULL, 3, NULL),
(86, 8, 'v32', 'arte', NULL, 3, NULL),
(87, 8, 'v33', 'arte', NULL, 4, NULL),
(88, 8, 'v24', 'social', NULL, 4, NULL),
(89, 8, 'v11', 'salud', NULL, 1, NULL),
(90, 8, 'v12', 'salud', NULL, 5, NULL),
(91, 8, 'v44', 'negocios', NULL, 4, NULL),
(92, 8, 'v22', 'social', NULL, 4, NULL),
(93, 8, 'v41', 'negocios', NULL, 3, NULL),
(94, 8, 'v43', 'negocios', NULL, 2, NULL),
(95, 9, 'v21', 'social', NULL, 2, NULL),
(96, 9, 'v34', 'arte', NULL, 3, NULL),
(97, 9, 'v32', 'arte', NULL, 3, NULL),
(98, 9, 'v33', 'arte', NULL, 4, NULL),
(99, 9, 'v24', 'social', NULL, 4, NULL),
(100, 9, 'v11', 'salud', NULL, 1, NULL),
(101, 9, 'v12', 'salud', NULL, 5, NULL),
(102, 9, 'v44', 'negocios', NULL, 4, NULL),
(103, 9, 'v22', 'social', NULL, 4, NULL),
(104, 9, 'v41', 'negocios', NULL, 3, NULL),
(105, 9, 'v43', 'negocios', NULL, 2, NULL),
(106, 10, 'v12', 'salud', NULL, 2, NULL),
(107, 10, 'v23', 'social', NULL, 3, NULL),
(108, 10, 'v13', 'salud', NULL, 4, NULL),
(109, 10, 'v14', 'salud', NULL, 5, NULL),
(110, 10, 'v22', 'social', NULL, 5, NULL),
(111, 10, 'v44', 'negocios', NULL, 1, NULL),
(112, 10, 'v03', 'stem', NULL, 2, NULL),
(113, 10, 'v04', 'stem', NULL, 3, NULL),
(114, 10, 'v31', 'arte', NULL, 4, NULL),
(115, 10, 'v34', 'arte', NULL, 5, NULL),
(116, 10, 'v43', 'negocios', NULL, 4, NULL),
(117, 11, 'v12', 'salud', NULL, 2, NULL),
(118, 11, 'v23', 'social', NULL, 3, NULL),
(119, 11, 'v13', 'salud', NULL, 4, NULL),
(120, 11, 'v14', 'salud', NULL, 5, NULL),
(121, 11, 'v22', 'social', NULL, 5, NULL),
(122, 11, 'v44', 'negocios', NULL, 1, NULL),
(123, 11, 'v03', 'stem', NULL, 2, NULL),
(124, 11, 'v04', 'stem', NULL, 3, NULL),
(125, 11, 'v31', 'arte', NULL, 4, NULL),
(126, 11, 'v34', 'arte', NULL, 5, NULL),
(127, 11, 'v43', 'negocios', NULL, 4, NULL),
(128, 12, 'v41', 'negocios', NULL, 1, NULL),
(129, 12, 'v42', 'negocios', NULL, 2, NULL),
(130, 12, 'v14', 'salud', NULL, 3, NULL),
(131, 12, 'v12', 'salud', NULL, 4, NULL),
(132, 12, 'v43', 'negocios', NULL, 3, NULL),
(133, 12, 'v01', 'stem', NULL, 4, NULL),
(134, 12, 'v23', 'social', NULL, 4, NULL),
(135, 12, 'v33', 'arte', NULL, 2, NULL),
(136, 12, 'v02', 'stem', NULL, 1, NULL),
(137, 12, 'v24', 'social', NULL, 3, NULL),
(138, 12, 'v21', 'social', NULL, 3, NULL),
(139, 12, 'v34', 'arte', NULL, 5, NULL),
(140, 12, 'v11', 'salud', NULL, 5, NULL),
(141, 12, 'v31', 'arte', NULL, 3, NULL),
(142, 13, 'v23', 'social', NULL, 4, NULL),
(143, 13, 'v04', 'stem', NULL, 4, NULL),
(144, 13, 'v22', 'social', NULL, 4, NULL),
(145, 13, 'v43', 'negocios', NULL, 4, NULL),
(146, 13, 'v01', 'stem', NULL, 2, NULL),
(147, 13, 'v12', 'salud', NULL, 2, NULL),
(148, 13, 'v02', 'stem', NULL, 3, NULL),
(149, 13, 'v32', 'arte', NULL, 3, NULL),
(150, 13, 'v03', 'stem', NULL, 3, NULL),
(151, 13, 'v41', 'negocios', NULL, 5, NULL),
(152, 13, 'v21', 'social', NULL, 1, NULL),
(153, 14, 'v23', 'social', NULL, 4, NULL),
(154, 14, 'v04', 'stem', NULL, 4, NULL),
(155, 14, 'v22', 'social', NULL, 4, NULL),
(156, 14, 'v43', 'negocios', NULL, 4, NULL),
(157, 14, 'v01', 'stem', NULL, 2, NULL),
(158, 14, 'v12', 'salud', NULL, 2, NULL),
(159, 14, 'v02', 'stem', NULL, 3, NULL),
(160, 14, 'v32', 'arte', NULL, 3, NULL),
(161, 14, 'v03', 'stem', NULL, 3, NULL),
(162, 14, 'v41', 'negocios', NULL, 5, NULL),
(163, 14, 'v21', 'social', NULL, 1, NULL),
(165, 16, 'v12', 'salud', NULL, 1, NULL),
(166, 16, 'v13', 'salud', NULL, 1, NULL),
(167, 16, 'v33', 'arte', NULL, 2, NULL),
(168, 16, 'v02', 'stem', NULL, 3, NULL),
(169, 16, 'v01', 'stem', NULL, 4, NULL),
(170, 16, 'v24', 'social', NULL, 4, NULL),
(171, 16, 'v14', 'salud', NULL, 5, NULL),
(172, 16, 'v32', 'arte', NULL, 5, NULL),
(173, 16, 'v41', 'negocios', NULL, 3, NULL),
(174, 16, 'v44', 'negocios', NULL, 3, NULL),
(175, 16, 'v43', 'negocios', NULL, 2, NULL),
(176, 16, 'v42', 'negocios', NULL, 1, NULL),
(177, 17, 'a04', 'mate', '60 km/h', NULL, 1),
(178, 17, 'a21', 'ciencias', 'Corazón', NULL, 1),
(179, 17, 'a32', 'sociales', 'Elegir representantes', NULL, 1),
(180, 17, 'a24', 'ciencias', 'Energía solar', NULL, 1),
(181, 17, 'a11', 'lectura', 'La biblioteca amplió su horario por la demanda de estudiantes', NULL, 1),
(182, 17, 'a03', 'mate', '32', NULL, 1),
(183, 17, 'a41', 'ingles', 'is', NULL, 1),
(184, 17, 'a42', 'ingles', 'Glad', NULL, 1),
(185, 17, 'a23', 'ciencias', 'Sólido', NULL, 1),
(186, 17, 'a22', 'ciencias', 'Dióxido de carbono', NULL, 1),
(187, 17, 'a14', 'lectura', 'No recibió el descuento', NULL, 1),
(188, 17, 'a43', 'ingles', 'goes', NULL, 0),
(189, 17, 'a13', 'lectura', 'Contraste', NULL, 1),
(190, 17, 'a44', 'ingles', 'What', NULL, 1),
(191, 17, 'a31', 'sociales', 'Leyes', NULL, 1),
(192, 17, 'a01', 'mate', '41', NULL, 1),
(193, 17, 'a33', 'sociales', 'Separación de poderes', NULL, 1),
(194, 17, 'a12', 'lectura', 'Constante', NULL, 1),
(195, 17, 'a34', 'sociales', 'El derecho a no pagar impuestos', NULL, 0),
(196, 17, 'a02', 'mate', '$40.000', NULL, 0),
(197, 18, 'v23', 'social', NULL, 2, NULL),
(198, 18, 'v24', 'social', NULL, 3, NULL),
(199, 18, 'v41', 'negocios', NULL, 4, NULL),
(200, 18, 'v13', 'salud', NULL, 4, NULL),
(201, 18, 'v31', 'arte', NULL, 1, NULL),
(202, 18, 'v21', 'social', NULL, 1, NULL),
(203, 18, 'v22', 'social', NULL, 1, NULL),
(204, 18, 'v34', 'arte', NULL, 5, NULL),
(205, 18, 'v12', 'salud', NULL, 5, NULL),
(206, 18, 'v01', 'stem', NULL, 2, NULL),
(207, 18, 'v14', 'salud', NULL, 2, NULL),
(208, 18, 'v33', 'arte', NULL, 3, NULL),
(209, 18, 'v02', 'stem', NULL, 4, NULL),
(210, 19, 'v51', 'stem', NULL, 3, NULL),
(211, 19, 'v16', 'salud', NULL, 2, NULL),
(212, 19, 'v15', 'salud', NULL, 1, NULL),
(213, 19, 'v05', 'stem', NULL, 3, NULL),
(214, 19, 'v53', 'stem', NULL, 2, NULL),
(215, 19, 'v27', 'social', NULL, 2, NULL),
(216, 19, 'v39', 'arte', NULL, 2, NULL),
(217, 19, 'v55', 'salud', NULL, 3, NULL),
(218, 19, 'v52', 'stem', NULL, 2, NULL),
(219, 19, 'v63', 'arte', NULL, 4, NULL),
(220, 19, 'v66', 'arte', NULL, 3, NULL),
(221, 19, 'v36', 'arte', NULL, 2, NULL),
(222, 19, 'v50', 'negocios', NULL, 2, NULL),
(223, 19, 'v29', 'social', NULL, 5, NULL),
(224, 19, 'v25', 'social', NULL, 5, NULL),
(225, 19, 'v58', 'salud', NULL, 2, NULL),
(226, 19, 'v26', 'social', NULL, 5, NULL),
(227, 19, 'v46', 'negocios', NULL, 3, NULL),
(228, 19, 'v08', 'stem', NULL, 1, NULL),
(229, 19, 'v67', 'negocios', NULL, 5, NULL),
(230, 19, 'v07', 'stem', NULL, 1, NULL),
(231, 19, 'v47', 'negocios', NULL, 2, NULL),
(232, 19, 'v59', 'social', NULL, 2, NULL),
(233, 19, 'v64', 'arte', NULL, 2, NULL),
(234, 19, 'v06', 'stem', NULL, 2, NULL),
(235, 19, 'v35', 'arte', NULL, 4, NULL),
(236, 19, 'v60', 'social', NULL, 4, NULL),
(237, 19, 'v48', 'negocios', NULL, 3, NULL),
(238, 19, 'v49', 'negocios', NULL, 3, NULL),
(239, 19, 'v40', 'arte', NULL, 5, NULL),
(240, 19, 'v70', 'negocios', NULL, 3, NULL),
(241, 19, 'v37', 'arte', NULL, 4, NULL),
(242, 19, 'v62', 'social', NULL, 5, NULL),
(243, 19, 'v65', 'arte', NULL, 3, NULL),
(244, 19, 'v28', 'social', NULL, 5, NULL),
(245, 19, 'v54', 'stem', NULL, 5, NULL),
(246, 19, 'v56', 'salud', NULL, 2, NULL),
(247, 19, 'v38', 'arte', NULL, 2, NULL),
(248, 19, 'v20', 'salud', NULL, 2, NULL),
(249, 19, 'v18', 'salud', NULL, 2, NULL),
(250, 19, 'v61', 'social', NULL, 5, NULL),
(251, 19, 'v30', 'social', NULL, 5, NULL),
(252, 19, 'v09', 'stem', NULL, 5, NULL),
(253, 19, 'v19', 'salud', NULL, 3, NULL),
(254, 19, 'v45', 'negocios', NULL, 2, NULL),
(255, 19, 'v69', 'negocios', NULL, 2, NULL),
(256, 19, 'v17', 'salud', NULL, 2, NULL),
(257, 19, 'v57', 'salud', NULL, 3, NULL),
(258, 19, 'v10', 'stem', NULL, 2, NULL),
(259, 19, 'v68', 'negocios', NULL, 2, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `resultados_areas`
--

CREATE TABLE `resultados_areas` (
  `id` int(11) NOT NULL,
  `intento_id` int(11) NOT NULL,
  `area_clave` varchar(30) NOT NULL,
  `area_nombre` varchar(100) NOT NULL,
  `porcentaje` int(11) NOT NULL,
  `correctas` int(11) DEFAULT NULL,
  `total` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `resultados_areas`
--

INSERT INTO `resultados_areas` (`id`, `intento_id`, `area_clave`, `area_nombre`, `porcentaje`, `correctas`, `total`) VALUES
(1, 1, 'salud', 'Ciencias de la Salud', 55, NULL, NULL),
(2, 1, 'social', 'Ciencias Sociales y Humanas', 50, NULL, NULL),
(3, 1, 'arte', 'Artes y Comunicación', 50, NULL, NULL),
(4, 1, 'stem', 'Ciencias Exactas e Ingeniería', 30, NULL, NULL),
(5, 1, 'negocios', 'Administración y Negocios', 0, NULL, NULL),
(6, 2, 'arte', 'Artes y Comunicación', 15, NULL, NULL),
(7, 2, 'stem', 'Ciencias Exactas e Ingeniería', 0, NULL, NULL),
(8, 2, 'salud', 'Ciencias de la Salud', 0, NULL, NULL),
(9, 2, 'social', 'Ciencias Sociales y Humanas', 0, NULL, NULL),
(10, 2, 'negocios', 'Administración y Negocios', 0, NULL, NULL),
(11, 3, 'stem', 'Ciencias Exactas e Ingeniería', 47, NULL, NULL),
(12, 3, 'negocios', 'Administración y Negocios', 43, NULL, NULL),
(13, 3, 'salud', 'Ciencias de la Salud', 37, NULL, NULL),
(14, 3, 'social', 'Ciencias Sociales y Humanas', 37, NULL, NULL),
(15, 3, 'arte', 'Artes y Comunicación', 27, NULL, NULL),
(16, 4, 'arte', 'Artes y Comunicación', 50, NULL, NULL),
(17, 4, 'negocios', 'Administración y Negocios', 45, NULL, NULL),
(18, 4, 'salud', 'Ciencias de la Salud', 35, NULL, NULL),
(19, 4, 'social', 'Ciencias Sociales y Humanas', 20, NULL, NULL),
(20, 4, 'stem', 'Ciencias Exactas e Ingeniería', 10, NULL, NULL),
(21, 5, 'stem', 'Ciencias Exactas e Ingeniería', 47, NULL, NULL),
(22, 5, 'arte', 'Artes y Comunicación', 47, NULL, NULL),
(23, 5, 'negocios', 'Administración y Negocios', 33, NULL, NULL),
(24, 5, 'social', 'Ciencias Sociales y Humanas', 20, NULL, NULL),
(25, 5, 'salud', 'Ciencias de la Salud', 17, NULL, NULL),
(26, 6, 'stem', 'Ciencias Exactas e Ingeniería', 47, NULL, NULL),
(27, 6, 'arte', 'Artes y Comunicación', 47, NULL, NULL),
(28, 6, 'negocios', 'Administración y Negocios', 33, NULL, NULL),
(29, 6, 'social', 'Ciencias Sociales y Humanas', 20, NULL, NULL),
(30, 6, 'salud', 'Ciencias de la Salud', 17, NULL, NULL),
(31, 7, 'social', 'Ciencias Sociales y Humanas', 55, NULL, NULL),
(32, 7, 'salud', 'Ciencias de la Salud', 30, NULL, NULL),
(33, 7, 'negocios', 'Administración y Negocios', 25, NULL, NULL),
(34, 7, 'arte', 'Artes y Comunicación', 20, NULL, NULL),
(35, 7, 'stem', 'Ciencias Exactas e Ingeniería', 15, NULL, NULL),
(36, 8, 'social', 'Ciencias Sociales y Humanas', 50, NULL, NULL),
(37, 8, 'arte', 'Artes y Comunicación', 50, NULL, NULL),
(38, 8, 'negocios', 'Administración y Negocios', 45, NULL, NULL),
(39, 8, 'salud', 'Ciencias de la Salud', 30, NULL, NULL),
(40, 8, 'stem', 'Ciencias Exactas e Ingeniería', 0, NULL, NULL),
(41, 9, 'social', 'Ciencias Sociales y Humanas', 50, NULL, NULL),
(42, 9, 'arte', 'Artes y Comunicación', 50, NULL, NULL),
(43, 9, 'negocios', 'Administración y Negocios', 45, NULL, NULL),
(44, 9, 'salud', 'Ciencias de la Salud', 30, NULL, NULL),
(45, 9, 'stem', 'Ciencias Exactas e Ingeniería', 0, NULL, NULL),
(46, 10, 'salud', 'Ciencias de la Salud', 55, NULL, NULL),
(47, 10, 'arte', 'Artes y Comunicación', 45, NULL, NULL),
(48, 10, 'social', 'Ciencias Sociales y Humanas', 40, NULL, NULL),
(49, 10, 'stem', 'Ciencias Exactas e Ingeniería', 25, NULL, NULL),
(50, 10, 'negocios', 'Administración y Negocios', 25, NULL, NULL),
(51, 11, 'salud', 'Ciencias de la Salud', 55, NULL, NULL),
(52, 11, 'arte', 'Artes y Comunicación', 45, NULL, NULL),
(53, 11, 'social', 'Ciencias Sociales y Humanas', 40, NULL, NULL),
(54, 11, 'stem', 'Ciencias Exactas e Ingeniería', 25, NULL, NULL),
(55, 11, 'negocios', 'Administración y Negocios', 25, NULL, NULL),
(56, 12, 'salud', 'Ciencias de la Salud', 60, NULL, NULL),
(57, 12, 'social', 'Ciencias Sociales y Humanas', 50, NULL, NULL),
(58, 12, 'arte', 'Artes y Comunicación', 50, NULL, NULL),
(59, 12, 'negocios', 'Administración y Negocios', 30, NULL, NULL),
(60, 12, 'stem', 'Ciencias Exactas e Ingeniería', 25, NULL, NULL),
(61, 13, 'stem', 'Ciencias Exactas e Ingeniería', 60, NULL, NULL),
(62, 13, 'social', 'Ciencias Sociales y Humanas', 45, NULL, NULL),
(63, 13, 'negocios', 'Administración y Negocios', 45, NULL, NULL),
(64, 13, 'arte', 'Artes y Comunicación', 15, NULL, NULL),
(65, 13, 'salud', 'Ciencias de la Salud', 10, NULL, NULL),
(66, 14, 'stem', 'Ciencias Exactas e Ingeniería', 60, NULL, NULL),
(67, 14, 'social', 'Ciencias Sociales y Humanas', 45, NULL, NULL),
(68, 14, 'negocios', 'Administración y Negocios', 45, NULL, NULL),
(69, 14, 'arte', 'Artes y Comunicación', 15, NULL, NULL),
(70, 14, 'salud', 'Ciencias de la Salud', 10, NULL, NULL),
(72, 16, 'negocios', 'Administración y Negocios', 45, NULL, NULL),
(73, 16, 'stem', 'Ciencias Exactas e Ingeniería', 35, NULL, NULL),
(74, 16, 'salud', 'Ciencias de la Salud', 35, NULL, NULL),
(75, 16, 'arte', 'Artes y Comunicación', 35, NULL, NULL),
(76, 16, 'social', 'Ciencias Sociales y Humanas', 20, NULL, NULL),
(77, 17, 'mate', 'Matemáticas', 75, 3, 4),
(78, 17, 'lectura', 'Lectura Crítica', 100, 4, 4),
(79, 17, 'ciencias', 'Ciencias Naturales', 100, 4, 4),
(80, 17, 'sociales', 'Sociales y Ciudadanas', 75, 3, 4),
(81, 17, 'ingles', 'Inglés', 75, 3, 4),
(82, 18, 'salud', '🩺 Ciencias de la Salud', 55, NULL, NULL),
(83, 18, 'arte', '🎨 Artes y Comunicación', 45, NULL, NULL),
(84, 18, 'social', '🌍 Ciencias Sociales y Humanas', 35, NULL, NULL),
(85, 18, 'stem', '⚙️ Ciencias Exactas e Ingeniería', 30, NULL, NULL),
(86, 18, 'negocios', '💼 Administración y Negocios', 20, NULL, NULL),
(87, 19, 'social', '🌍 Ciencias Sociales y Humanas', 86, NULL, NULL),
(88, 19, 'arte', '🎨 Artes y Comunicación', 62, NULL, NULL),
(89, 19, 'negocios', '💼 Administración y Negocios', 54, NULL, NULL),
(90, 19, 'stem', '⚙️ Ciencias Exactas e Ingeniería', 52, NULL, NULL),
(91, 19, 'salud', '🩺 Ciencias de la Salud', 44, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `solicitudes_premium`
--

CREATE TABLE `solicitudes_premium` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `test_id` int(11) NOT NULL,
  `referencia` varchar(20) NOT NULL,
  `valor` int(11) NOT NULL,
  `estado` enum('pendiente','confirmada','rechazada') NOT NULL DEFAULT 'pendiente',
  `token_confirmacion` varchar(64) NOT NULL,
  `fecha_solicitud` datetime DEFAULT current_timestamp(),
  `fecha_confirmacion` datetime DEFAULT NULL,
  `confirmada_por` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `solicitudes_premium`
--

INSERT INTO `solicitudes_premium` (`id`, `usuario_id`, `test_id`, `referencia`, `valor`, `estado`, `token_confirmacion`, `fecha_solicitud`, `fecha_confirmacion`, `confirmada_por`) VALUES
(16, 1, 1, 'REM-911273', 15000, 'rechazada', '7d9748b46021411d677b26b2836d3e758e3f8788f58befdbaaf0614d42afcf71', '2026-09-09 14:56:29', NULL, 1),
(17, 5, 2, 'REM-065425', 15000, 'confirmada', '100e6298fd17c39432b6240e4353e78734c1e7aec06168a2d35abe3347edec06', '2026-09-16 15:47:27', '2026-09-23 23:28:42', 5),
(18, 1, 2, 'REM-800537', 15000, 'pendiente', '22cc9c9e37ac9259a718faf43d31912377bfffbbd9955e5588d03315f1cbb4f6', '2026-09-16 15:53:07', NULL, NULL),
(20, 5, 1, 'REM-871253', 15000, 'confirmada', '0bd2005fbb0b73f71d1cc02c5c64427b23262d0c17bcde05f043365830ffe10a', '2026-09-20 19:15:48', '2026-09-23 23:11:46', 5),
(21, 5, 1, 'REM-278267', 15000, 'pendiente', '970bddee3027b7fec3a46d966bdb683a81fc82745d9204b0d5eab26adc59f8fe', '2026-09-23 23:11:56', NULL, NULL),
(22, 5, 2, 'REM-695176', 15000, 'pendiente', '72985281aa01041e1940639b4901b48dbeb1e91bbb7c41c54f05d859911f14f0', '2026-09-23 23:28:50', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tests`
--

CREATE TABLE `tests` (
  `id` int(11) NOT NULL,
  `clave` varchar(30) NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `precio_premium` int(11) NOT NULL DEFAULT 15000,
  `activo` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tests`
--

INSERT INTO `tests` (`id`, `clave`, `nombre`, `precio_premium`, `activo`) VALUES
(1, 'vocacional', 'Test Vocacional', 15000, 1),
(2, 'admision', 'Simulacro de Admisión', 15000, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `universidades`
--

CREATE TABLE `universidades` (
  `id` int(11) NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `escudo` varchar(255) NOT NULL,
  `url_oferta` varchar(500) NOT NULL,
  `orden` int(11) NOT NULL DEFAULT 0,
  `activa` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `universidades`
--

INSERT INTO `universidades` (`id`, `nombre`, `escudo`, `url_oferta`, `orden`, `activa`) VALUES
(1, 'Universidad de Antioquia', 'escudoudea.png', 'https://www.udea.edu.co/wps/portal/udea/web/inicio/estudiar-udea/quiero-estudiar-udea/pregrado/oferta-medellin', 1, 1),
(2, 'Universidad Nacional de Colombia', 'escudounal.png', 'https://pregrado.unal.edu.co/info_programas', 2, 1),
(3, 'Universidad Pontificia Bolivariana', 'escudoupb.png', 'https://portal.upb.edu.co/pregrados', 3, 1),
(4, 'Universidad EAFIT', 'escudoeafit.png', 'https://www.eafit.edu.co/pregrados', 4, 1),
(5, 'Instituto Tecnológico Metropolitano', 'escudoitm.png', 'https://www.itm.edu.co/aspirante-pregrado/programas-profesionales/', 5, 1),
(6, 'Universidad de Medellín', 'escudoumedellin.png', 'https://programas.udemedellin.edu.co/', 6, 1),
(7, 'Tecnológico de Antioquia', 'escudotdea.png', 'https://tdea.edu.co/programas-profesionales/', 7, 1),
(8, 'Universidad Pascual Bravo', 'escudopascualbravo.png', 'https://pascualbravo.edu.co/pregrados/', 8, 1),
(9, 'Universidad CES', 'universidad-ces.jpg', 'https://www.ces.edu.co/estudia-en-ces/carreras-de-pregrado/', 9, 1),
(10, 'Universidad Autónoma Latinoamericana', 'Universida-Autonoma.jpg', 'https://www.unaula.edu.co/oferta-academica#universitarios', 10, 1),
(11, 'Universidad de San Buenaventura', 'universidad-sanbuenaventura.png', 'https://usbmed.edu.co/programas/pregrados', 11, 1),
(12, 'Universidad Cooperativa de Colombia', 'universidad-cooperativa.jpg', 'https://ucc.edu.co/programas/Paginas/default.aspx?campus=Medell%C3%ADn+-+Envigado', 12, 1),
(13, 'Universidad Santo Tomás', 'universidad-santotomas.jpg', 'https://usantotomas.edu.co/pregrados-presenciales-med', 13, 1),
(14, 'Universidad Antonio Nariño', 'universidad-antonioNariño.png', 'https://www.uan.edu.co/pregrados', 14, 1),
(15, 'Universidad Colegio Mayor de Antioquia', 'universidad-ColeMayorAnt.png', 'https://www.colmayor.edu.co/programas/', 15, 1),
(16, 'Universidad Católica Luis Amigó', 'universidad_luisamigo.jpg', 'https://www.funlam.edu.co/modules/ofertaacademica/', 16, 1),
(17, 'Politécnico Colombiano Jaime Isaza Cadavid', 'universidad_jaimeIsaza.jpg', 'https://www.politecnicojic.edu.co/profesionales', 17, 1),
(18, 'Fundación Universitaria María Cano', 'universidad_mariaCano.png', 'https://www.fumc.edu.co/pregrado/', 18, 1),
(19, 'Corporación Universitaria Remington', 'universidad_remington.jpg', 'https://www.uniremington.edu.co/programas/', 19, 1),
(20, 'Corporación Universitaria Americana', 'universidad_americana.jpg', 'https://americana.edu.co/medellin/pregrado/', 20, 1),
(21, 'Fundación Universitaria Autónoma de las Américas', 'universidad_lasAmericas.jpg', 'https://uam.edu.co/pregrados/', 21, 1),
(22, 'Institución Universitaria ESUMER', 'universidad_ESUMER.jpg', 'https://esumer.edu.co/ofertacademica/', 22, 1),
(23, 'Escuela de Ingeniería de Antioquia (EIA)', 'Escuela_de_ingenieria_ant.jpg', 'https://www.eia.edu.co/pregrados/', 23, 1),
(24, 'Institución Universitaria Salazar y Herrera', 'universidad_salazarYherrera.jpg', 'https://www.iush.edu.co/inicio/pregados/', 24, 1),
(25, 'Institución Universitaria CEIPA', 'universidad_CEIPA.jpg', 'https://promo.ceipa.edu.co/pregrados-posgrados-mba', 25, 1),
(26, 'Institución Universitaria Colegiatura Colombiana', 'universidad_colegiatura_colombiana.jpg', 'https://www.colegiatura.edu.co/pregrado/', 26, 1),
(27, 'Fundación Universitaria Bellas Artes de Medellín', 'fundacion_bellas_artes.jpg', 'https://bellasartesmed.edu.co/pregrados/', 27, 1),
(28, 'Universidad Nacional Abierta y a Distancia (UNAD)', 'universidad_abierta_y_distancia.jpg', 'https://estudios.unad.edu.co/carreras', 28, 1),
(29, 'Corporación Universitaria Adventista (UNAC)', 'universidad_adventista.png', 'https://www.unac.edu.co/pregrado/', 29, 1),
(30, 'Institución Universitaria de Envigado (IUE)', 'universidad_envigado.jpg', 'https://www.iue.edu.co/pregrado/', 30, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `apellido` varchar(100) NOT NULL,
  `correo` varchar(190) NOT NULL,
  `telefono` varchar(20) NOT NULL,
  `clave_hash` varchar(255) NOT NULL,
  `rol` enum('estudiante','admin') NOT NULL DEFAULT 'estudiante',
  `fecha_registro` datetime DEFAULT current_timestamp(),
  `ultimo_acceso` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `nombre`, `apellido`, `correo`, `telefono`, `clave_hash`, `rol`, `fecha_registro`, `ultimo_acceso`) VALUES
(1, 'sara', 'rojas', 'sararojas@iejorgerobledo.edu.co', '3117064279', '$2y$10$dMDvHTIDJ2D1j9h5jk2AEOJY18HA12f/B3aBnUiLtJX8nIyfOO6mO', 'admin', '2026-09-07 23:14:12', '2026-09-16 15:49:08'),
(5, 'sara', 'rojas', 'sararojasaya679@gmail.com', '3567890', '$2y$10$ANaRsZcFF3g5.tRH03Bv4OwQ5K2Xt9AdFJfa7nRx6lNrs/QI96gGW', 'admin', '2026-09-16 13:39:30', '2026-09-23 23:11:30');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `accesos_premium`
--
ALTER TABLE `accesos_premium`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unico_acceso` (`usuario_id`,`test_id`),
  ADD KEY `test_id` (`test_id`),
  ADD KEY `codigo_id` (`codigo_id`);

--
-- Indices de la tabla `codigos_acceso`
--
ALTER TABLE `codigos_acceso`
  ADD PRIMARY KEY (`id`),
  ADD KEY `solicitud_id` (`solicitud_id`),
  ADD KEY `usuario_id` (`usuario_id`),
  ADD KEY `test_id` (`test_id`);

--
-- Indices de la tabla `informes_enviados`
--
ALTER TABLE `informes_enviados`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario_id` (`usuario_id`),
  ADD KEY `intento_id` (`intento_id`);

--
-- Indices de la tabla `intentos`
--
ALTER TABLE `intentos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario_id` (`usuario_id`),
  ADD KEY `test_id` (`test_id`);

--
-- Indices de la tabla `opciones_premium`
--
ALTER TABLE `opciones_premium`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pregunta_id` (`pregunta_id`);

--
-- Indices de la tabla `preguntas_premium`
--
ALTER TABLE `preguntas_premium`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `clave` (`clave`),
  ADD KEY `test_id` (`test_id`);

--
-- Indices de la tabla `respuestas_intento`
--
ALTER TABLE `respuestas_intento`
  ADD PRIMARY KEY (`id`),
  ADD KEY `intento_id` (`intento_id`);

--
-- Indices de la tabla `resultados_areas`
--
ALTER TABLE `resultados_areas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `intento_id` (`intento_id`);

--
-- Indices de la tabla `solicitudes_premium`
--
ALTER TABLE `solicitudes_premium`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `referencia` (`referencia`),
  ADD KEY `usuario_id` (`usuario_id`),
  ADD KEY `test_id` (`test_id`),
  ADD KEY `confirmada_por` (`confirmada_por`);

--
-- Indices de la tabla `tests`
--
ALTER TABLE `tests`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `clave` (`clave`);

--
-- Indices de la tabla `universidades`
--
ALTER TABLE `universidades`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `correo` (`correo`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `accesos_premium`
--
ALTER TABLE `accesos_premium`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `codigos_acceso`
--
ALTER TABLE `codigos_acceso`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `informes_enviados`
--
ALTER TABLE `informes_enviados`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT de la tabla `intentos`
--
ALTER TABLE `intentos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT de la tabla `opciones_premium`
--
ALTER TABLE `opciones_premium`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=201;

--
-- AUTO_INCREMENT de la tabla `preguntas_premium`
--
ALTER TABLE `preguntas_premium`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;

--
-- AUTO_INCREMENT de la tabla `respuestas_intento`
--
ALTER TABLE `respuestas_intento`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=260;

--
-- AUTO_INCREMENT de la tabla `resultados_areas`
--
ALTER TABLE `resultados_areas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=92;

--
-- AUTO_INCREMENT de la tabla `solicitudes_premium`
--
ALTER TABLE `solicitudes_premium`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT de la tabla `tests`
--
ALTER TABLE `tests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `universidades`
--
ALTER TABLE `universidades`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `accesos_premium`
--
ALTER TABLE `accesos_premium`
  ADD CONSTRAINT `accesos_premium_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `accesos_premium_ibfk_2` FOREIGN KEY (`test_id`) REFERENCES `tests` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `accesos_premium_ibfk_3` FOREIGN KEY (`codigo_id`) REFERENCES `codigos_acceso` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `codigos_acceso`
--
ALTER TABLE `codigos_acceso`
  ADD CONSTRAINT `codigos_acceso_ibfk_1` FOREIGN KEY (`solicitud_id`) REFERENCES `solicitudes_premium` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `codigos_acceso_ibfk_2` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `codigos_acceso_ibfk_3` FOREIGN KEY (`test_id`) REFERENCES `tests` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `informes_enviados`
--
ALTER TABLE `informes_enviados`
  ADD CONSTRAINT `informes_enviados_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `informes_enviados_ibfk_2` FOREIGN KEY (`intento_id`) REFERENCES `intentos` (`id`) ON DELETE SET NULL;

--
-- Filtros para la tabla `intentos`
--
ALTER TABLE `intentos`
  ADD CONSTRAINT `intentos_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `intentos_ibfk_2` FOREIGN KEY (`test_id`) REFERENCES `tests` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `opciones_premium`
--
ALTER TABLE `opciones_premium`
  ADD CONSTRAINT `opciones_premium_ibfk_1` FOREIGN KEY (`pregunta_id`) REFERENCES `preguntas_premium` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `preguntas_premium`
--
ALTER TABLE `preguntas_premium`
  ADD CONSTRAINT `preguntas_premium_ibfk_1` FOREIGN KEY (`test_id`) REFERENCES `tests` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `respuestas_intento`
--
ALTER TABLE `respuestas_intento`
  ADD CONSTRAINT `respuestas_intento_ibfk_1` FOREIGN KEY (`intento_id`) REFERENCES `intentos` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `resultados_areas`
--
ALTER TABLE `resultados_areas`
  ADD CONSTRAINT `resultados_areas_ibfk_1` FOREIGN KEY (`intento_id`) REFERENCES `intentos` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `solicitudes_premium`
--
ALTER TABLE `solicitudes_premium`
  ADD CONSTRAINT `solicitudes_premium_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `solicitudes_premium_ibfk_2` FOREIGN KEY (`test_id`) REFERENCES `tests` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `solicitudes_premium_ibfk_3` FOREIGN KEY (`confirmada_por`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
