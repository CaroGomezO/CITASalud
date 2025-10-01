-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Servidor: sql213.infinityfree.com
-- Tiempo de generación: 30-09-2025 a las 15:45:17
-- Versión del servidor: 11.4.7-MariaDB
-- Versión de PHP: 7.2.22

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `if0_39993702_feature1_db`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ausencias_profesionales`
--

CREATE TABLE `ausencias_profesionales` (
  `id_ausencia` int(11) NOT NULL,
  `id_profesional` int(11) NOT NULL,
  `id_tipo` int(11) NOT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `citas`
--

CREATE TABLE `citas` (
  `id_cita` int(11) NOT NULL,
  `id_paciente` int(11) NOT NULL,
  `id_profesional` int(11) NOT NULL,
  `id_sede` int(11) NOT NULL,
  `id_especialidad` int(11) NOT NULL,
  `id_horario` int(11) NOT NULL,
  `id_estado` int(11) NOT NULL,
  `recordatorio_enviado` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `citas`
--

INSERT INTO `citas` (`id_cita`, `id_paciente`, `id_profesional`, `id_sede`, `id_especialidad`, `id_horario`, `id_estado`, `recordatorio_enviado`) VALUES
(5, 3, 11, 12, 19, 18, 1, 0),
(6, 10, 2, 1, 1, 15, 1, 0),
(7, 10, 7, 8, 7, 17, 1, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ciudades`
--

CREATE TABLE `ciudades` (
  `id_ciudad` int(11) NOT NULL,
  `nombre_ciudad` varchar(100) NOT NULL,
  `departamento` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ciudades`
--

INSERT INTO `ciudades` (`id_ciudad`, `nombre_ciudad`, `departamento`) VALUES
(1, 'Bogotá', 'Cundinamarca'),
(2, 'Medellín', 'Antioquia'),
(3, 'Cali', 'Valle del Cauca'),
(4, 'Barranquilla', 'Atlántico'),
(5, 'Cartagena', 'Bolívar'),
(6, 'Bucaramanga', 'Santander'),
(7, 'Pereira', 'Risaralda'),
(8, 'Manizales', 'Caldas'),
(9, 'Cúcuta', 'Norte de Santander'),
(10, 'Bello', 'Antioquia'),
(11, 'Itagüí', 'Antioquia'),
(12, 'Envigado', 'Antioquia'),
(13, 'Floridablanca', 'Santander'),
(14, 'Girón', 'Santander'),
(15, 'Soledad', 'Atlántico'),
(16, 'Malambo', 'Atlántico'),
(17, 'Soacha', 'Cundinamarca'),
(18, 'Madrid', 'Cundinamarca'),
(19, 'Zipaquirá', 'Cundinamarca'),
(20, 'Palmira', 'Valle del Cauca'),
(21, 'Tuluá', 'Valle del Cauca'),
(22, 'Dosquebradas', 'Risaralda'),
(23, 'Santa Rosa de Cabal', 'Risaralda'),
(24, 'Villavicencio', 'Meta'),
(25, 'Ibagué', 'Tolima'),
(26, 'Popayán', 'Cauca'),
(27, 'Tunja', 'Boyacá'),
(28, 'Pasto', 'Nariño'),
(29, 'Montería', 'Córdoba');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `especialidades`
--

CREATE TABLE `especialidades` (
  `id_especialidad` int(11) NOT NULL,
  `nombre_especialidad` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `especialidades`
--

INSERT INTO `especialidades` (`id_especialidad`, `nombre_especialidad`, `descripcion`) VALUES
(1, 'Cardiología', 'Especialidad médica que se ocupa del diagnóstico y tratamiento de las enfermedades del corazón y del sistema circulatorio.'),
(2, 'Pediatría', 'Especialidad médica que se encarga del estudio del crecimiento y desarrollo de los niños hasta la adolescencia, así como del diagnóstico y tratamiento de sus enfermedades.'),
(3, 'Dermatología', 'Rama de la medicina que se especializa en el estudio, diagnóstico y tratamiento de las enfermedades de la piel, cabello y uñas.'),
(4, 'Ginecología', 'Especialidad médica y quirúrgica que se encarga de la salud integral de la mujer, especialmente en el diagnóstico y tratamiento de las enfermedades del sistema reproductor femenino.'),
(5, 'Neurología', 'Especialidad de la medicina que estudia el sistema nervioso y las enfermedades relacionadas con el cerebro, la médula espinal y los nervios periféricos.'),
(6, 'Odontología', 'Ciencia de la salud que se encarga del diagnóstico, tratamiento y prevención de las enfermedades de los dientes, encías y la cavidad oral en general.'),
(7, 'Ortopedia', 'Especialidad que se dedica al diagnóstico, corrección y prevención de deformidades o trastornos del sistema musculoesquelético.'),
(8, 'Oftalmología', 'Especialidad médica que estudia y trata las enfermedades relacionadas con los ojos, la visión y las estructuras oculares.'),
(9, 'Urología', 'Especialidad médico-quirúrgica que se ocupa del diagnóstico y tratamiento de las enfermedades del sistema urinario en hombres y mujeres, y del sistema reproductor masculino.'),
(10, 'Psiquiatría', 'Rama de la medicina que se dedica al estudio, diagnóstico y tratamiento de los trastornos mentales, emocionales y del comportamiento.'),
(11, 'Medicina Interna', 'Especialidad clínica que aborda de manera integral las enfermedades que afectan a los órganos internos de los adultos, sin procedimientos quirúrgicos.'),
(12, 'Nutrición', 'Especialidad que estudia la relación entre la alimentación y la salud humana, enfocada en la prevención y tratamiento de enfermedades a través de la dieta.'),
(13, 'Fisioterapia', 'Especialidad de la salud que utiliza medios físicos para prevenir, tratar y rehabilitar a personas con dolencias o discapacidades físicas.'),
(14, 'Oncología', 'Especialidad de la medicina que se dedica al diagnóstico y tratamiento del cáncer.'),
(15, 'Radiología', 'Especialidad médica que utiliza imágenes (rayos X, resonancia, etc.) para diagnosticar y, en algunos casos, tratar enfermedades y lesiones.'),
(16, 'Anestesiología', 'Especialidad que se encarga de la atención y cuidado del paciente antes, durante y después de un procedimiento quirúrgico, controlando la anestesia y las funciones vitales.'),
(17, 'Cirugía General', 'Especialidad quirúrgica que se ocupa del diagnóstico y tratamiento de enfermedades a través de procedimientos operatorios, principalmente en el abdomen.'),
(18, 'Endocrinología', 'Especialidad que estudia las glándulas endocrinas, sus hormonas y las enfermedades asociadas, como la diabetes y los trastornos de la tiroides.'),
(19, 'Gastroenterología', 'Especialidad médica que se enfoca en el estudio y tratamiento de las enfermedades del sistema digestivo, incluyendo el esófago, estómago, intestinos, hígado y páncreas.'),
(20, 'Hematología', 'Rama de la medicina que estudia la sangre, los órganos hematopoyéticos y el tratamiento de sus enfermedades.'),
(21, 'Nefrología', 'Especialidad que se dedica al estudio de la estructura y función de los riñones, y al diagnóstico y tratamiento de sus enfermedades.'),
(22, 'Neumología', 'Especialidad médica que se encarga del estudio y tratamiento de las enfermedades del sistema respiratorio, incluyendo los pulmones y las vías aéreas.'),
(23, 'Reumatología', 'Especialidad que se ocupa de las enfermedades del tejido conectivo, articulaciones, músculos y huesos.'),
(24, 'Inmunología', 'Ciencia que estudia el sistema inmunitario y las enfermedades relacionadas con sus funciones, como las alergias y las enfermedades autoinmunes.'),
(25, 'Genética Médica', 'Especialidad que diagnostica, previene y gestiona trastornos genéticos o hereditarios en individuos y sus familias.'),
(26, 'Toxicología', 'Disciplina que estudia los efectos adversos de sustancias químicas sobre los organismos vivos.'),
(27, 'Geriatría', 'Especialidad médica que se encarga de la salud y el bienestar de los adultos mayores, abordando sus enfermedades y necesidades específicas.'),
(28, 'Medicina Familiar', 'Especialidad que proporciona atención integral y continua a los individuos y sus familias, considerando su contexto biológico, psicológico y social.'),
(29, 'Patología', 'Especialidad médica que diagnostica enfermedades mediante el análisis de tejidos, fluidos corporales y órganos.'),
(30, 'Alergología', 'Especialidad que diagnostica y trata las enfermedades alérgicas, incluyendo asma, rinitis y reacciones a alimentos o medicamentos.'),
(31, 'Otorrinolaringología', 'Especialidad médico-quirúrgica que se enfoca en el oído, la nariz, la garganta y las estructuras relacionadas en la cabeza y el cuello.'),
(32, 'Terapia Respiratoria', 'Profesión de la salud que se encarga de la prevención, diagnóstico, tratamiento y rehabilitación de enfermedades que afectan el sistema respiratorio.'),
(33, 'Medicina Nuclear', 'Especialidad que utiliza sustancias radioactivas para diagnosticar y tratar enfermedades.'),
(34, 'Dermopatología', 'Subespecialidad que combina la dermatología y la patología, enfocándose en el diagnóstico de enfermedades de la piel a nivel microscópico.'),
(35, 'Oftalmología Pediátrica', 'Subespecialidad de la oftalmología que se enfoca en el cuidado de los ojos y la visión en niños.'),
(36, 'Cardiología Intervencionista', 'Subespecialidad de la cardiología que utiliza cateterismo para diagnosticar y tratar enfermedades cardíacas.'),
(37, 'Cirugía Plástica', 'Especialidad quirúrgica que se dedica a la restauración, reconstrucción o alteración de la forma del cuerpo humano.'),
(38, 'Medicina Estética', 'Rama de la medicina que se enfoca en mejorar la apariencia física de las personas a través de procedimientos no invasivos o mínimamente invasivos.'),
(39, 'Acupuntura', 'Práctica de la medicina tradicional china que utiliza agujas finas para estimular puntos específicos del cuerpo con fines terapéuticos.'),
(40, 'Homeopatía', 'Sistema de medicina alternativa que utiliza dosis mínimas de sustancias naturales para estimular la capacidad de autocuración del cuerpo.'),
(41, 'Quiropráctica', 'Disciplina de la salud que se centra en el diagnóstico, tratamiento y prevención de trastornos del sistema musculoesquelético, especialmente de la columna vertebral.'),
(42, 'Osteopatía', 'Sistema de medicina alternativa que se basa en la idea de que el cuerpo tiene la capacidad de curarse a sí mismo, a través de la manipulación del sistema musculoesquelético.'),
(43, 'Podología', 'Especialidad que se dedica al estudio, diagnóstico y tratamiento de las enfermedades y afecciones del pie.'),
(44, 'Medicina del Deporte', 'Especialidad que se enfoca en el cuidado médico de atletas y personas activas, incluyendo la prevención y tratamiento de lesiones deportivas.'),
(45, 'Sexología', 'Disciplina que estudia la sexualidad humana y sus trastornos.'),
(46, 'Epidemiología', 'Rama de la medicina que estudia la distribución, frecuencia y determinantes de las enfermedades en las poblaciones.'),
(47, 'Medicina Forense', 'Especialidad médica que se encarga de investigar las causas y circunstancias de la muerte para propósitos legales.'),
(48, 'Infectología', 'Especialidad que se dedica al diagnóstico y tratamiento de enfermedades causadas por agentes infecciosos como bacterias, virus y hongos.'),
(49, 'Nefrología Pediátrica', 'Subespecialidad de la nefrología que se enfoca en el diagnóstico y tratamiento de enfermedades renales en niños.'),
(50, 'Medicina Crítica', 'Especialidad médica que se encarga del cuidado de pacientes con enfermedades graves y potencialmente mortales.'),
(51, 'Endoscopia', 'Procedimiento médico que utiliza un endoscopio para examinar el interior del cuerpo, especialmente el sistema digestivo o respiratorio.');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estados_cita`
--

CREATE TABLE `estados_cita` (
  `id_estado` int(11) NOT NULL,
  `nombre_estado` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `estados_cita`
--

INSERT INTO `estados_cita` (`id_estado`, `nombre_estado`) VALUES
(1, 'Agendada'),
(4, 'Asistida'),
(3, 'Cancelada'),
(2, 'Modificada'),
(5, 'Sin asistencia');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estados_profesional`
--

CREATE TABLE `estados_profesional` (
  `id_estado` int(11) NOT NULL,
  `nombre_estado` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `estados_profesional`
--

INSERT INTO `estados_profesional` (`id_estado`, `nombre_estado`) VALUES
(1, 'Activo'),
(4, 'Inactivo'),
(3, 'Licencia Médica'),
(2, 'Vacaciones');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historiales_cita`
--

CREATE TABLE `historiales_cita` (
  `id_historial` int(11) NOT NULL,
  `id_cita` int(11) NOT NULL,
  `id_estado` int(11) NOT NULL,
  `fecha_cambio` timestamp NOT NULL DEFAULT current_timestamp(),
  `observacion` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `historiales_cita`
--

INSERT INTO `historiales_cita` (`id_historial`, `id_cita`, `id_estado`, `fecha_cambio`, `observacion`) VALUES
(2, 5, 1, '2025-09-19 19:48:11', 'Cita agendada por el paciente.'),
(3, 6, 1, '2025-09-19 19:57:32', 'Cita agendada por el paciente.'),
(4, 7, 1, '2025-09-19 20:06:14', 'Cita agendada por el paciente.');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `horarios_profesionales`
--

CREATE TABLE `horarios_profesionales` (
  `id_horario` int(11) NOT NULL,
  `id_profesional` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `disponible` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `horarios_profesionales`
--

INSERT INTO `horarios_profesionales` (`id_horario`, `id_profesional`, `fecha`, `hora`, `disponible`) VALUES
(1, 2, '2025-09-17', '08:00:00', 1),
(2, 2, '2025-09-17', '08:30:00', 1),
(3, 2, '2025-09-17', '09:00:00', 1),
(4, 4, '2025-09-17', '10:00:00', 1),
(5, 4, '2025-09-17', '10:30:00', 1),
(6, 7, '2025-09-17', '11:00:00', 1),
(7, 7, '2025-09-17', '11:30:00', 1),
(8, 7, '2025-09-17', '12:00:00', 1),
(9, 11, '2025-09-18', '14:00:00', 1),
(10, 11, '2025-09-18', '14:30:00', 1),
(11, 11, '2025-09-18', '15:00:00', 1),
(12, 11, '2025-09-18', '15:30:00', 1),
(13, 19, '2025-09-18', '15:30:00', 1),
(14, 19, '2025-09-18', '17:30:00', 1),
(15, 2, '2025-09-19', '08:00:00', 0),
(16, 4, '2025-09-19', '10:30:00', 1),
(17, 7, '2025-09-26', '11:00:00', 0),
(18, 11, '2025-09-27', '15:00:00', 0),
(20, 2, '2025-10-24', '09:00:00', 1),
(21, 11, '2025-12-18', '10:00:00', 1),
(22, 19, '2026-02-16', '14:30:00', 1),
(23, 13, '2025-10-02', '08:00:00', 1),
(24, 13, '2025-10-02', '08:30:00', 1),
(25, 13, '2025-10-03', '09:00:00', 1),
(26, 13, '2025-10-03', '09:30:00', 1),
(27, 13, '2025-10-04', '10:00:00', 1),
(28, 13, '2025-10-04', '10:30:00', 1),
(29, 13, '2025-10-05', '11:00:00', 1),
(30, 13, '2025-10-05', '11:30:00', 1),
(31, 14, '2025-10-02', '12:00:00', 1),
(32, 14, '2025-10-02', '12:30:00', 1),
(33, 14, '2025-10-03', '13:00:00', 1),
(34, 14, '2025-10-03', '13:30:00', 1),
(35, 14, '2025-10-04', '14:00:00', 1),
(36, 14, '2025-10-04', '14:30:00', 1),
(37, 14, '2025-10-05', '15:00:00', 1),
(38, 14, '2025-10-05', '15:30:00', 1),
(39, 15, '2025-10-02', '16:00:00', 1),
(40, 15, '2025-10-02', '16:30:00', 1),
(41, 15, '2025-10-03', '17:00:00', 1),
(42, 15, '2025-10-03', '17:30:00', 1),
(43, 15, '2025-10-04', '18:00:00', 1),
(44, 15, '2025-10-04', '18:30:00', 1),
(45, 15, '2025-10-05', '19:00:00', 1),
(46, 15, '2025-10-05', '19:30:00', 1),
(47, 16, '2025-10-06', '07:00:00', 1),
(48, 16, '2025-10-06', '07:30:00', 1),
(49, 16, '2025-10-07', '08:00:00', 1),
(50, 16, '2025-10-07', '08:30:00', 1),
(51, 16, '2025-10-08', '09:00:00', 1),
(52, 16, '2025-10-08', '09:30:00', 1),
(53, 16, '2025-10-09', '10:00:00', 1),
(54, 16, '2025-10-09', '10:30:00', 1),
(55, 17, '2025-10-06', '11:00:00', 1),
(56, 17, '2025-10-06', '11:30:00', 1),
(57, 17, '2025-10-07', '12:00:00', 1),
(58, 17, '2025-10-07', '12:30:00', 1),
(59, 17, '2025-10-08', '13:00:00', 1),
(60, 17, '2025-10-08', '13:30:00', 1),
(61, 17, '2025-10-09', '14:00:00', 1),
(62, 17, '2025-10-09', '14:30:00', 1),
(63, 18, '2025-10-06', '15:00:00', 1),
(64, 18, '2025-10-06', '15:30:00', 1),
(65, 18, '2025-10-07', '16:00:00', 1),
(66, 18, '2025-10-07', '16:30:00', 1),
(67, 18, '2025-10-08', '17:00:00', 1),
(68, 18, '2025-10-08', '17:30:00', 1),
(69, 18, '2025-10-09', '18:00:00', 1),
(70, 18, '2025-10-09', '18:30:00', 1),
(71, 19, '2025-10-10', '07:00:00', 1),
(72, 19, '2025-10-10', '07:30:00', 1),
(73, 19, '2025-10-11', '08:00:00', 1),
(74, 19, '2025-10-11', '08:30:00', 1),
(75, 19, '2025-10-12', '09:00:00', 1),
(76, 19, '2025-10-12', '09:30:00', 1),
(77, 19, '2025-10-13', '10:00:00', 1),
(78, 19, '2025-10-13', '10:30:00', 1),
(79, 20, '2025-10-10', '11:00:00', 1),
(80, 20, '2025-10-10', '11:30:00', 1),
(81, 20, '2025-10-11', '12:00:00', 1),
(82, 20, '2025-10-11', '12:30:00', 1),
(83, 20, '2025-10-12', '13:00:00', 1),
(84, 20, '2025-10-12', '13:30:00', 1),
(85, 20, '2025-10-13', '14:00:00', 1),
(86, 20, '2025-10-13', '14:30:00', 1),
(215, 1, '2025-10-14', '07:00:00', 1),
(216, 1, '2025-10-14', '07:15:00', 1),
(217, 1, '2025-10-15', '07:45:00', 1),
(218, 1, '2025-10-15', '08:15:00', 1),
(219, 1, '2025-10-16', '08:45:00', 1),
(220, 1, '2025-10-16', '09:15:00', 1),
(221, 1, '2025-10-17', '09:45:00', 1),
(222, 1, '2025-10-17', '10:15:00', 1),
(223, 2, '2025-10-14', '10:45:00', 1),
(224, 2, '2025-10-14', '11:15:00', 1),
(225, 2, '2025-10-15', '11:45:00', 1),
(226, 2, '2025-10-15', '12:15:00', 1),
(227, 2, '2025-10-16', '12:45:00', 1),
(228, 2, '2025-10-16', '13:15:00', 1),
(229, 2, '2025-10-17', '13:45:00', 1),
(230, 2, '2025-10-17', '14:15:00', 1),
(231, 3, '2025-10-14', '14:45:00', 1),
(232, 3, '2025-10-14', '15:15:00', 1),
(233, 3, '2025-10-15', '15:45:00', 1),
(234, 3, '2025-10-15', '16:15:00', 1),
(235, 3, '2025-10-16', '16:45:00', 1),
(236, 3, '2025-10-16', '17:15:00', 1),
(237, 3, '2025-10-17', '17:45:00', 1),
(238, 3, '2025-10-17', '18:15:00', 1),
(239, 4, '2025-10-14', '18:45:00', 1),
(240, 4, '2025-10-14', '19:15:00', 1),
(241, 4, '2025-10-15', '19:45:00', 1),
(242, 4, '2025-10-15', '20:15:00', 1),
(243, 4, '2025-10-18', '07:00:00', 1),
(244, 4, '2025-10-18', '07:30:00', 1),
(245, 4, '2025-10-19', '08:00:00', 1),
(246, 4, '2025-10-19', '08:30:00', 1),
(247, 5, '2025-10-18', '09:00:00', 1),
(248, 5, '2025-10-18', '09:30:00', 1),
(249, 5, '2025-10-19', '10:00:00', 1),
(250, 5, '2025-10-19', '10:30:00', 1),
(251, 5, '2025-10-20', '11:00:00', 1),
(252, 5, '2025-10-20', '11:30:00', 1),
(253, 5, '2025-10-21', '12:00:00', 1),
(254, 5, '2025-10-21', '12:30:00', 1),
(255, 6, '2025-10-18', '13:00:00', 1),
(256, 6, '2025-10-18', '13:30:00', 1),
(257, 6, '2025-10-19', '14:00:00', 1),
(258, 6, '2025-10-19', '14:30:00', 1),
(259, 6, '2025-10-20', '15:00:00', 1),
(260, 6, '2025-10-20', '15:30:00', 1),
(261, 6, '2025-10-21', '16:00:00', 1),
(262, 6, '2025-10-21', '16:30:00', 1),
(263, 7, '2025-10-18', '17:00:00', 1),
(264, 7, '2025-10-18', '17:30:00', 1),
(265, 7, '2025-10-19', '18:00:00', 1),
(266, 7, '2025-10-19', '18:30:00', 1),
(267, 7, '2025-10-20', '19:00:00', 1),
(268, 7, '2025-10-20', '19:30:00', 1),
(269, 7, '2025-10-21', '20:00:00', 1),
(270, 7, '2025-10-21', '20:30:00', 1),
(271, 8, '2025-10-22', '06:30:00', 1),
(272, 8, '2025-10-22', '07:00:00', 1),
(273, 8, '2025-10-23', '07:30:00', 1),
(274, 8, '2025-10-23', '08:00:00', 1),
(275, 8, '2025-10-24', '08:30:00', 1),
(276, 8, '2025-10-24', '09:00:00', 1),
(277, 8, '2025-10-25', '09:30:00', 1),
(278, 8, '2025-10-25', '10:00:00', 1),
(279, 9, '2025-10-22', '10:30:00', 1),
(280, 9, '2025-10-22', '11:00:00', 1),
(281, 9, '2025-10-23', '11:30:00', 1),
(282, 9, '2025-10-23', '12:00:00', 1),
(283, 9, '2025-10-24', '12:30:00', 1),
(284, 9, '2025-10-24', '13:00:00', 1),
(285, 9, '2025-10-25', '13:30:00', 1),
(286, 9, '2025-10-25', '14:00:00', 1),
(287, 10, '2025-10-22', '14:30:00', 1),
(288, 10, '2025-10-22', '15:00:00', 1),
(289, 10, '2025-10-23', '15:30:00', 1),
(290, 10, '2025-10-23', '16:00:00', 1),
(291, 10, '2025-10-24', '16:30:00', 1),
(292, 10, '2025-10-24', '17:00:00', 1),
(293, 10, '2025-10-25', '17:30:00', 1),
(294, 10, '2025-10-25', '18:00:00', 1),
(295, 11, '2025-10-22', '18:30:00', 1),
(296, 11, '2025-10-22', '19:00:00', 1),
(297, 11, '2025-10-23', '19:30:00', 1),
(298, 11, '2025-10-23', '20:00:00', 1),
(299, 11, '2025-10-26', '06:00:00', 1),
(300, 11, '2025-10-26', '06:30:00', 1),
(301, 11, '2025-10-27', '07:00:00', 1),
(302, 11, '2025-10-27', '07:30:00', 1),
(303, 12, '2025-10-26', '08:00:00', 1),
(304, 12, '2025-10-26', '08:30:00', 1),
(305, 12, '2025-10-27', '09:00:00', 1),
(306, 12, '2025-10-27', '09:30:00', 1),
(307, 12, '2025-10-28', '10:00:00', 1),
(308, 12, '2025-10-28', '10:30:00', 1),
(309, 12, '2025-10-29', '11:00:00', 1),
(310, 12, '2025-10-29', '11:30:00', 1),
(311, 13, '2025-10-26', '12:00:00', 1),
(312, 13, '2025-10-26', '12:30:00', 1),
(313, 13, '2025-10-27', '13:00:00', 1),
(314, 13, '2025-10-27', '13:30:00', 1),
(315, 13, '2025-10-28', '14:00:00', 1),
(316, 13, '2025-10-28', '14:30:00', 1),
(317, 13, '2025-10-29', '15:00:00', 1),
(318, 13, '2025-10-29', '15:30:00', 1),
(319, 14, '2025-10-26', '16:00:00', 1),
(320, 14, '2025-10-26', '16:30:00', 1),
(321, 14, '2025-10-27', '17:00:00', 1),
(322, 14, '2025-10-27', '17:30:00', 1),
(323, 14, '2025-10-28', '18:00:00', 1),
(324, 14, '2025-10-28', '18:30:00', 1),
(325, 14, '2025-10-29', '19:00:00', 1),
(326, 14, '2025-10-29', '19:30:00', 1),
(327, 15, '2025-10-26', '20:00:00', 1),
(328, 15, '2025-10-26', '20:30:00', 1),
(329, 15, '2025-10-30', '06:15:00', 1),
(330, 15, '2025-10-30', '06:45:00', 1),
(331, 15, '2025-10-31', '07:15:00', 1),
(332, 15, '2025-10-31', '07:45:00', 1),
(333, 15, '2025-11-01', '08:15:00', 1),
(334, 15, '2025-11-01', '08:45:00', 1),
(335, 16, '2025-10-30', '09:15:00', 1),
(336, 16, '2025-10-30', '09:45:00', 1),
(337, 16, '2025-10-31', '10:15:00', 1),
(338, 16, '2025-10-31', '10:45:00', 1),
(339, 16, '2025-11-01', '11:15:00', 1),
(340, 16, '2025-11-01', '11:45:00', 1),
(341, 16, '2025-11-02', '12:15:00', 1),
(342, 16, '2025-11-02', '12:45:00', 1),
(343, 17, '2025-10-30', '13:15:00', 1),
(344, 17, '2025-10-30', '13:45:00', 1),
(345, 17, '2025-10-31', '14:15:00', 1),
(346, 17, '2025-10-31', '14:45:00', 1),
(347, 17, '2025-11-01', '15:15:00', 1),
(348, 17, '2025-11-01', '15:45:00', 1),
(349, 17, '2025-11-02', '16:15:00', 1),
(350, 17, '2025-11-02', '16:45:00', 1),
(351, 18, '2025-10-30', '17:15:00', 1),
(352, 18, '2025-10-30', '17:45:00', 1),
(353, 18, '2025-10-31', '18:15:00', 1),
(354, 18, '2025-10-31', '18:45:00', 1),
(355, 18, '2025-11-01', '19:15:00', 1),
(356, 18, '2025-11-01', '19:45:00', 1),
(357, 18, '2025-11-02', '20:15:00', 1),
(358, 18, '2025-11-02', '20:45:00', 1),
(359, 19, '2025-11-03', '06:00:00', 1),
(360, 19, '2025-11-03', '06:30:00', 1),
(361, 19, '2025-11-04', '07:00:00', 1),
(362, 19, '2025-11-04', '07:30:00', 1),
(363, 19, '2025-11-05', '08:00:00', 1),
(364, 19, '2025-11-05', '08:30:00', 1),
(365, 19, '2025-11-06', '09:00:00', 1),
(366, 19, '2025-11-06', '09:30:00', 1),
(367, 20, '2025-11-03', '10:00:00', 1),
(368, 20, '2025-11-03', '10:30:00', 1),
(369, 20, '2025-11-04', '11:00:00', 1),
(370, 20, '2025-11-04', '11:30:00', 1),
(371, 20, '2025-11-05', '12:00:00', 1),
(372, 20, '2025-11-05', '12:30:00', 1),
(373, 20, '2025-11-06', '13:00:00', 1),
(374, 20, '2025-11-06', '13:30:00', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notificaciones`
--

CREATE TABLE `notificaciones` (
  `id_notificacion` int(11) NOT NULL,
  `id_cita` int(11) DEFAULT NULL,
  `tipo_notificacion` varchar(50) NOT NULL,
  `destinatario` varchar(200) NOT NULL,
  `asunto` varchar(200) DEFAULT NULL,
  `mensaje` text NOT NULL,
  `enviado` tinyint(1) DEFAULT 0,
  `fecha_programada` timestamp NULL DEFAULT NULL,
  `fecha_enviado` timestamp NULL DEFAULT NULL,
  `intentos_envio` int(11) DEFAULT 0,
  `error_envio` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pacientes`
--

CREATE TABLE `pacientes` (
  `id_paciente` int(11) NOT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  `id_tipo_doc` int(11) NOT NULL,
  `numero_documento` varchar(20) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `apellido` varchar(100) NOT NULL,
  `correo` varchar(150) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `pacientes`
--

INSERT INTO `pacientes` (`id_paciente`, `id_usuario`, `id_tipo_doc`, `numero_documento`, `nombre`, `apellido`, `correo`, `telefono`) VALUES
(1, 26, 1, '1001001001', 'Juan', 'Pérez', 'paciente1@eps.co', '3001112233'),
(2, 27, 2, '1002002002', 'Ana', 'Gómez', 'paciente2@eps.co', '3004445566'),
(3, 28, 1, '1003003003', 'Carlos', 'Rodríguez', 'paciente3@eps.co', '3007778899'),
(4, 29, 3, '1004004004', 'María', 'López', 'paciente4@eps.co', '3009990011'),
(5, 30, 1, '1005005005', 'Pedro', 'Sánchez', 'paciente5@eps.co', '3002223344'),
(6, 31, 2, '1006006006', 'Laura', 'Díaz', 'paciente6@eps.co', '3005556677'),
(7, 32, 4, '1007007007', 'Felipe', 'Muñoz', 'paciente7@eps.co', '3008889900'),
(8, 33, 1, '1008008008', 'Sofía', 'Castro', 'paciente8@eps.co', '3001110022'),
(9, 34, 1, '1009009009', 'Diego', 'Vargas', 'paciente9@eps.co', '3003334455'),
(10, 35, 5, '1010101010', 'Valeria', 'Ruiz', 'paciente10@eps.co', '3006667788');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `profesionales`
--

CREATE TABLE `profesionales` (
  `id_profesional` int(11) NOT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  `id_tipo_doc` int(11) NOT NULL,
  `numero_documento` varchar(20) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `apellido` varchar(100) NOT NULL,
  `titulo_profesional` varchar(100) NOT NULL,
  `anos_experiencia` int(11) DEFAULT NULL,
  `id_estado` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `profesionales`
--

INSERT INTO `profesionales` (`id_profesional`, `id_usuario`, `id_tipo_doc`, `numero_documento`, `nombre`, `apellido`, `titulo_profesional`, `anos_experiencia`, `id_estado`) VALUES
(1, 1, 1, '1234567890', 'Sara', 'Martínez', 'Médica Pediatra', 10, 1),
(2, 2, 1, '1234567891', 'Andrés', 'Gómez', 'Médico Cardiólogo', 15, 1),
(3, 3, 1, '1234567892', 'Laura', 'Pérez', 'Médica Dermatóloga', 8, 1),
(4, 4, 1, '1234567893', 'Carlos', 'Rojas', 'Médico Ginecólogo', 18, 1),
(5, 5, 1, '1234567894', 'Mario', 'Sánchez', 'Médico Neurólogo', 12, 1),
(6, 6, 1, '1234567895', 'Ana', 'López', 'Odontóloga', 9, 1),
(7, 7, 1, '1234567896', 'Juan', 'Ramírez', 'Ortopedista', 22, 1),
(8, 8, 1, '1234567897', 'Paula', 'Castro', 'Médica Oftalmóloga', 14, 1),
(9, 9, 1, '1234567898', 'Daniel', 'Jiménez', 'Médico Urólogo', 11, 1),
(10, 10, 1, '1234567899', 'Sofía', 'Ruiz', 'Psicóloga', 7, 1),
(11, 11, 1, '1234567900', 'Luis', 'Fernández', 'Médico Internista', 19, 1),
(12, 12, 1, '1234567901', 'Camila', 'Guzmán', 'Nutricionista', 6, 1),
(13, 13, 1, '1234567902', 'David', 'Mora', 'Fisioterapeuta', 13, 1),
(14, 14, 1, '1234567903', 'Valentina', 'Vargas', 'Médica Oncólogo', 17, 1),
(15, 15, 1, '1234567904', 'Felipe', 'Herrera', 'Médico Radiólogo', 20, 1),
(16, 16, 1, '1234567905', 'Isabella', 'Muñoz', 'Anestesióloga', 16, 1),
(17, 17, 1, '1234567906', 'Jorge', 'Ortiz', 'Cirujano General', 25, 1),
(18, 18, 1, '1234567907', 'Claudia', 'García', 'Endocrinóloga', 10, 1),
(19, 19, 1, '1234567908', 'Hugo', 'Díaz', 'Gastroenterólogo', 14, 1),
(20, 20, 1, '1234567909', 'Patricia', 'Silva', 'Médica Familiar', 9, 1),
(21, 21, 1, '1234567910', 'Esteban', 'Castañeda', 'Alergólogo', 11, 1),
(22, 22, 1, '1234567911', 'Elena', 'Pardo', 'Otorrinolaringóloga', 15, 1),
(23, 23, 1, '1234567912', 'Ricardo', 'Pineda', 'Médico Neurólogo', 13, 1),
(24, 24, 1, '1234567913', 'Liliana', 'Cortés', 'Cardióloga', 18, 1),
(25, 25, 1, '1234567914', 'Gustavo', 'Quiroga', 'Cirujano Plástico', 21, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `profesionales_especialidades`
--

CREATE TABLE `profesionales_especialidades` (
  `id_profesional` int(11) NOT NULL,
  `id_especialidad` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `profesionales_especialidades`
--

INSERT INTO `profesionales_especialidades` (`id_profesional`, `id_especialidad`) VALUES
(2, 1),
(24, 1),
(1, 2),
(3, 3),
(4, 4),
(5, 5),
(23, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(5, 10),
(10, 10),
(2, 11),
(11, 11),
(12, 12),
(13, 13),
(14, 14),
(15, 15),
(16, 16),
(17, 17),
(18, 18),
(11, 19),
(19, 19),
(1, 28),
(20, 28),
(21, 30),
(22, 31),
(24, 36),
(25, 37),
(17, 51);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `profesionales_sedes`
--

CREATE TABLE `profesionales_sedes` (
  `id_profesional` int(11) NOT NULL,
  `id_sede` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `profesionales_sedes`
--

INSERT INTO `profesionales_sedes` (`id_profesional`, `id_sede`) VALUES
(2, 1),
(1, 2),
(5, 2),
(3, 3),
(4, 4),
(6, 7),
(7, 8),
(8, 9),
(9, 10),
(10, 11),
(11, 12),
(12, 13),
(13, 14),
(14, 15),
(15, 16),
(16, 17),
(17, 18),
(18, 19),
(19, 20),
(20, 21),
(21, 22),
(22, 23),
(23, 24),
(24, 25),
(25, 26);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `id_rol` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id_rol`, `nombre`) VALUES
(2, 'Paciente'),
(1, 'Profesional');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sedes`
--

CREATE TABLE `sedes` (
  `id_sede` int(11) NOT NULL,
  `nombre_sede` varchar(100) NOT NULL,
  `direccion` varchar(150) NOT NULL,
  `id_ciudad` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `sedes`
--

INSERT INTO `sedes` (`id_sede`, `nombre_sede`, `direccion`, `id_ciudad`) VALUES
(1, 'Clínica de la 80', 'Calle 80 # 35-12', 2),
(2, 'Centro Médico Galerías', 'Avenida Caracas # 53-90', 1),
(3, 'IPS de la Loma', 'Carrera 56 # 15-30', 3),
(4, 'Hospital del Norte', 'Calle 50 # 8C-22', 4),
(5, 'Unidad de Urgencias', 'Carrera 5 # 71-45', 5),
(6, 'Clínica de Especialidades', 'Avenida Quebrada Seca # 30-10', 6),
(7, 'Sede Médica de la 20', 'Calle 20 # 25-15', 8),
(8, 'Hospital de la Pradera', 'Carrera 7 # 28-56', 7),
(9, 'IPS Cúcuta Centro', 'Avenida 0 # 13-05', 9),
(10, 'Centro de Salud Bello', 'Carrera 50 # 45-67', 10),
(11, 'Sede Itagüí', 'Calle 70 # 50-89', 11),
(12, 'Clínica Envigado', 'Carrera 43A # 36 Sur-12', 12),
(13, 'IPS Floridablanca', 'Calle 20 # 22-34', 13),
(14, 'Hospital Girón', 'Carrera 28 # 31-50', 14),
(15, 'Clínica Soledad', 'Avenida Murillo # 15-40', 15),
(16, 'Centro Médico Malambo', 'Calle 10 # 5-10', 16),
(17, 'Sede Soacha', 'Calle 22 # 11-20', 17),
(18, 'IPS Madrid', 'Carrera 3 # 4-50', 18),
(19, 'Clínica Zipaquirá', 'Calle 8 # 9-10', 19),
(20, 'Hospital Palmira', 'Carrera 28 # 42-12', 20),
(21, 'Centro de Salud Tuluá', 'Calle 25 # 25-50', 21),
(22, 'IPS Dosquebradas', 'Avenida Simones # 4-30', 22),
(23, 'Clínica Santa Rosa', 'Carrera 14 # 19-25', 23),
(24, 'Hospital Villavicencio', 'Calle 40 # 25-15', 24),
(25, 'Sede Ibagué', 'Carrera 5 # 32-05', 25),
(26, 'IPS Popayán', 'Calle 5 # 10-20', 26),
(27, 'Clínica Tunja', 'Avenida Norte # 20-30', 27),
(28, 'Hospital Pasto', 'Carrera 27 # 16-55', 28),
(29, 'Centro Médico Montería', 'Calle 29 # 10-15', 29);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipos_ausencia`
--

CREATE TABLE `tipos_ausencia` (
  `id_tipo` int(11) NOT NULL,
  `nombre_tipo` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tipos_ausencia`
--

INSERT INTO `tipos_ausencia` (`id_tipo`, `nombre_tipo`) VALUES
(3, 'Capacitación'),
(6, 'Comisión de Servicios'),
(4, 'Licencia de Maternidad'),
(5, 'Licencia de Paternidad'),
(2, 'Licencia Médica'),
(7, 'Permiso Personal'),
(1, 'Vacaciones');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipos_documento`
--

CREATE TABLE `tipos_documento` (
  `id_tipo` int(11) NOT NULL,
  `nombre_tipo` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tipos_documento`
--

INSERT INTO `tipos_documento` (`id_tipo`, `nombre_tipo`) VALUES
(1, 'Cédula de Ciudadanía'),
(3, 'Cédula de Extranjería'),
(4, 'Pasaporte'),
(5, 'Registro Civil'),
(2, 'Tarjeta de Identidad');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL,
  `correo` varchar(150) NOT NULL,
  `contrasena` varchar(200) NOT NULL COMMENT 'encriptada',
  `id_rol` int(11) NOT NULL,
  `activo` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id_usuario`, `correo`, `contrasena`, `id_rol`, `activo`) VALUES
(1, 'dra.sara.martinez@eps.co', '9b8769a4a742959a2d0298c36fb70623f2dfacda8436237df08d8dfd5b37374c', 1, 1),
(2, 'dr.andres.gomez@eps.co', '9b8769a4a742959a2d0298c36fb70623f2dfacda8436237df08d8dfd5b37374c', 1, 1),
(3, 'dra.laura.perez@eps.co', '9b8769a4a742959a2d0298c36fb70623f2dfacda8436237df08d8dfd5b37374c', 1, 1),
(4, 'dr.carlos.rojas@eps.co', '9b8769a4a742959a2d0298c36fb70623f2dfacda8436237df08d8dfd5b37374c', 1, 1),
(5, 'dr.mario.sanchez@eps.co', '9b8769a4a742959a2d0298c36fb70623f2dfacda8436237df08d8dfd5b37374c', 1, 1),
(6, 'dra.ana.lopez@eps.co', '9b8769a4a742959a2d0298c36fb70623f2dfacda8436237df08d8dfd5b37374c', 1, 1),
(7, 'dr.juan.ramirez@eps.co', '9b8769a4a742959a2d0298c36fb70623f2dfacda8436237df08d8dfd5b37374c', 1, 1),
(8, 'dra.paula.castro@eps.co', '9b8769a4a742959a2d0298c36fb70623f2dfacda8436237df08d8dfd5b37374c', 1, 1),
(9, 'dr.daniel.jimenez@eps.co', '9b8769a4a742959a2d0298c36fb70623f2dfacda8436237df08d8dfd5b37374c', 1, 1),
(10, 'dra.sofia.ruiz@eps.co', '9b8769a4a742959a2d0298c36fb70623f2dfacda8436237df08d8dfd5b37374c', 1, 1),
(11, 'dr.luis.fernandez@eps.co', '9b8769a4a742959a2d0298c36fb70623f2dfacda8436237df08d8dfd5b37374c', 1, 1),
(12, 'dra.camila.guzman@eps.co', '9b8769a4a742959a2d0298c36fb70623f2dfacda8436237df08d8dfd5b37374c', 1, 1),
(13, 'dr.david.mora@eps.co', '9b8769a4a742959a2d0298c36fb70623f2dfacda8436237df08d8dfd5b37374c', 1, 1),
(14, 'dra.valentina.vargas@eps.co', '9b8769a4a742959a2d0298c36fb70623f2dfacda8436237df08d8dfd5b37374c', 1, 1),
(15, 'dr.felipe.herrera@eps.co', '9b8769a4a742959a2d0298c36fb70623f2dfacda8436237df08d8dfd5b37374c', 1, 1),
(16, 'dra.isabella.munoz@eps.co', '9b8769a4a742959a2d0298c36fb70623f2dfacda8436237df08d8dfd5b37374c', 1, 1),
(17, 'dr.jorge.ortiz@eps.co', '9b8769a4a742959a2d0298c36fb70623f2dfacda8436237df08d8dfd5b37374c', 1, 1),
(18, 'dra.claudia.garcia@eps.co', '9b8769a4a742959a2d0298c36fb70623f2dfacda8436237df08d8dfd5b37374c', 1, 1),
(19, 'dr.hugo.diaz@eps.co', '9b8769a4a742959a2d0298c36fb70623f2dfacda8436237df08d8dfd5b37374c', 1, 1),
(20, 'dra.patricia.silva@eps.co', '9b8769a4a742959a2d0298c36fb70623f2dfacda8436237df08d8dfd5b37374c', 1, 1),
(21, 'dr.esteban.castaneda@eps.co', '9b8769a4a742959a2d0298c36fb70623f2dfacda8436237df08d8dfd5b37374c', 1, 1),
(22, 'dra.elena.pardo@eps.co', '9b8769a4a742959a2d0298c36fb70623f2dfacda8436237df08d8dfd5b37374c', 1, 1),
(23, 'dr.ricardo.pineda@eps.co', '9b8769a4a742959a2d0298c36fb70623f2dfacda8436237df08d8dfd5b37374c', 1, 1),
(24, 'dra.liliana.cortes@eps.co', '9b8769a4a742959a2d0298c36fb70623f2dfacda8436237df08d8dfd5b37374c', 1, 1),
(25, 'dr.gustavo.quiroga@eps.co', '9b8769a4a742959a2d0298c36fb70623f2dfacda8436237df08d8dfd5b37374c', 1, 1),
(26, 'paciente1@eps.co', '9b8769a4a742959a2d0298c36fb70623f2dfacda8436237df08d8dfd5b37374c', 2, 1),
(27, 'paciente2@eps.co', '9b8769a4a742959a2d0298c36fb70623f2dfacda8436237df08d8dfd5b37374c', 2, 1),
(28, 'paciente3@eps.co', '9b8769a4a742959a2d0298c36fb70623f2dfacda8436237df08d8dfd5b37374c', 2, 1),
(29, 'paciente4@eps.co', '9b8769a4a742959a2d0298c36fb70623f2dfacda8436237df08d8dfd5b37374c', 2, 1),
(30, 'paciente5@eps.co', '9b8769a4a742959a2d0298c36fb70623f2dfacda8436237df08d8dfd5b37374c', 2, 1),
(31, 'paciente6@eps.co', '9b8769a4a742959a2d0298c36fb70623f2dfacda8436237df08d8dfd5b37374c', 2, 1),
(32, 'paciente7@eps.co', '9b8769a4a742959a2d0298c36fb70623f2dfacda8436237df08d8dfd5b37374c', 2, 1),
(33, 'paciente8@eps.co', '9b8769a4a742959a2d0298c36fb70623f2dfacda8436237df08d8dfd5b37374c', 2, 1),
(34, 'paciente9@eps.co', '9b8769a4a742959a2d0298c36fb70623f2dfacda8436237df08d8dfd5b37374c', 2, 1),
(35, 'paciente10@eps.co', '9b8769a4a742959a2d0298c36fb70623f2dfacda8436237df08d8dfd5b37374c', 2, 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `ausencias_profesionales`
--
ALTER TABLE `ausencias_profesionales`
  ADD PRIMARY KEY (`id_ausencia`),
  ADD KEY `fk_ausencias_profesional` (`id_profesional`),
  ADD KEY `fk_ausencias_tipo` (`id_tipo`);

--
-- Indices de la tabla `citas`
--
ALTER TABLE `citas`
  ADD PRIMARY KEY (`id_cita`),
  ADD KEY `fk_citas_paciente` (`id_paciente`),
  ADD KEY `fk_citas_profesional` (`id_profesional`),
  ADD KEY `fk_citas_sede` (`id_sede`),
  ADD KEY `fk_citas_especialidad` (`id_especialidad`),
  ADD KEY `fk_citas_horario` (`id_horario`),
  ADD KEY `fk_citas_estado` (`id_estado`);

--
-- Indices de la tabla `ciudades`
--
ALTER TABLE `ciudades`
  ADD PRIMARY KEY (`id_ciudad`),
  ADD UNIQUE KEY `nombre_ciudad` (`nombre_ciudad`);

--
-- Indices de la tabla `especialidades`
--
ALTER TABLE `especialidades`
  ADD PRIMARY KEY (`id_especialidad`),
  ADD UNIQUE KEY `nombre_especialidad` (`nombre_especialidad`);

--
-- Indices de la tabla `estados_cita`
--
ALTER TABLE `estados_cita`
  ADD PRIMARY KEY (`id_estado`),
  ADD UNIQUE KEY `nombre_estado` (`nombre_estado`);

--
-- Indices de la tabla `estados_profesional`
--
ALTER TABLE `estados_profesional`
  ADD PRIMARY KEY (`id_estado`),
  ADD UNIQUE KEY `nombre_estado` (`nombre_estado`);

--
-- Indices de la tabla `historiales_cita`
--
ALTER TABLE `historiales_cita`
  ADD PRIMARY KEY (`id_historial`),
  ADD KEY `fk_historial_cita` (`id_cita`),
  ADD KEY `fk_historial_estado` (`id_estado`);

--
-- Indices de la tabla `horarios_profesionales`
--
ALTER TABLE `horarios_profesionales`
  ADD PRIMARY KEY (`id_horario`),
  ADD UNIQUE KEY `uk_profesional_fecha_hora` (`id_profesional`,`fecha`,`hora`);

--
-- Indices de la tabla `notificaciones`
--
ALTER TABLE `notificaciones`
  ADD PRIMARY KEY (`id_notificacion`),
  ADD KEY `fk_notificaciones_cita` (`id_cita`);

--
-- Indices de la tabla `pacientes`
--
ALTER TABLE `pacientes`
  ADD PRIMARY KEY (`id_paciente`),
  ADD UNIQUE KEY `numero_documento` (`numero_documento`),
  ADD UNIQUE KEY `id_usuario` (`id_usuario`),
  ADD KEY `fk_pacientes_tipo_doc` (`id_tipo_doc`);

--
-- Indices de la tabla `profesionales`
--
ALTER TABLE `profesionales`
  ADD PRIMARY KEY (`id_profesional`),
  ADD UNIQUE KEY `numero_documento` (`numero_documento`),
  ADD UNIQUE KEY `id_usuario` (`id_usuario`),
  ADD KEY `fk_profesionales_tipo_doc` (`id_tipo_doc`),
  ADD KEY `fk_profesionales_estado` (`id_estado`);

--
-- Indices de la tabla `profesionales_especialidades`
--
ALTER TABLE `profesionales_especialidades`
  ADD PRIMARY KEY (`id_profesional`,`id_especialidad`),
  ADD KEY `fk_prof_esp_especialidad` (`id_especialidad`);

--
-- Indices de la tabla `profesionales_sedes`
--
ALTER TABLE `profesionales_sedes`
  ADD PRIMARY KEY (`id_profesional`,`id_sede`),
  ADD KEY `fk_prof_sede_sede` (`id_sede`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id_rol`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- Indices de la tabla `sedes`
--
ALTER TABLE `sedes`
  ADD PRIMARY KEY (`id_sede`),
  ADD KEY `fk_sedes_ciudad` (`id_ciudad`);

--
-- Indices de la tabla `tipos_ausencia`
--
ALTER TABLE `tipos_ausencia`
  ADD PRIMARY KEY (`id_tipo`),
  ADD UNIQUE KEY `nombre_tipo` (`nombre_tipo`);

--
-- Indices de la tabla `tipos_documento`
--
ALTER TABLE `tipos_documento`
  ADD PRIMARY KEY (`id_tipo`),
  ADD UNIQUE KEY `nombre_tipo` (`nombre_tipo`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id_usuario`),
  ADD UNIQUE KEY `correo` (`correo`),
  ADD KEY `fk_usuarios_rol` (`id_rol`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `ausencias_profesionales`
--
ALTER TABLE `ausencias_profesionales`
  MODIFY `id_ausencia` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `citas`
--
ALTER TABLE `citas`
  MODIFY `id_cita` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `ciudades`
--
ALTER TABLE `ciudades`
  MODIFY `id_ciudad` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT de la tabla `especialidades`
--
ALTER TABLE `especialidades`
  MODIFY `id_especialidad` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=79;

--
-- AUTO_INCREMENT de la tabla `estados_cita`
--
ALTER TABLE `estados_cita`
  MODIFY `id_estado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `estados_profesional`
--
ALTER TABLE `estados_profesional`
  MODIFY `id_estado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `historiales_cita`
--
ALTER TABLE `historiales_cita`
  MODIFY `id_historial` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `horarios_profesionales`
--
ALTER TABLE `horarios_profesionales`
  MODIFY `id_horario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=375;

--
-- AUTO_INCREMENT de la tabla `notificaciones`
--
ALTER TABLE `notificaciones`
  MODIFY `id_notificacion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `pacientes`
--
ALTER TABLE `pacientes`
  MODIFY `id_paciente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `profesionales`
--
ALTER TABLE `profesionales`
  MODIFY `id_profesional` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id_rol` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `sedes`
--
ALTER TABLE `sedes`
  MODIFY `id_sede` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT de la tabla `tipos_ausencia`
--
ALTER TABLE `tipos_ausencia`
  MODIFY `id_tipo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `tipos_documento`
--
ALTER TABLE `tipos_documento`
  MODIFY `id_tipo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `ausencias_profesionales`
--
ALTER TABLE `ausencias_profesionales`
  ADD CONSTRAINT `fk_ausencias_profesional` FOREIGN KEY (`id_profesional`) REFERENCES `profesionales` (`id_profesional`),
  ADD CONSTRAINT `fk_ausencias_tipo` FOREIGN KEY (`id_tipo`) REFERENCES `tipos_ausencia` (`id_tipo`);

--
-- Filtros para la tabla `citas`
--
ALTER TABLE `citas`
  ADD CONSTRAINT `fk_citas_especialidad` FOREIGN KEY (`id_especialidad`) REFERENCES `especialidades` (`id_especialidad`),
  ADD CONSTRAINT `fk_citas_estado` FOREIGN KEY (`id_estado`) REFERENCES `estados_cita` (`id_estado`),
  ADD CONSTRAINT `fk_citas_horario` FOREIGN KEY (`id_horario`) REFERENCES `horarios_profesionales` (`id_horario`),
  ADD CONSTRAINT `fk_citas_paciente` FOREIGN KEY (`id_paciente`) REFERENCES `pacientes` (`id_paciente`),
  ADD CONSTRAINT `fk_citas_profesional` FOREIGN KEY (`id_profesional`) REFERENCES `profesionales` (`id_profesional`),
  ADD CONSTRAINT `fk_citas_sede` FOREIGN KEY (`id_sede`) REFERENCES `sedes` (`id_sede`);

--
-- Filtros para la tabla `historiales_cita`
--
ALTER TABLE `historiales_cita`
  ADD CONSTRAINT `fk_historial_cita` FOREIGN KEY (`id_cita`) REFERENCES `citas` (`id_cita`),
  ADD CONSTRAINT `fk_historial_estado` FOREIGN KEY (`id_estado`) REFERENCES `estados_cita` (`id_estado`);

--
-- Filtros para la tabla `horarios_profesionales`
--
ALTER TABLE `horarios_profesionales`
  ADD CONSTRAINT `fk_horarios_profesional` FOREIGN KEY (`id_profesional`) REFERENCES `profesionales` (`id_profesional`);

--
-- Filtros para la tabla `notificaciones`
--
ALTER TABLE `notificaciones`
  ADD CONSTRAINT `fk_notificaciones_cita` FOREIGN KEY (`id_cita`) REFERENCES `citas` (`id_cita`);

--
-- Filtros para la tabla `pacientes`
--
ALTER TABLE `pacientes`
  ADD CONSTRAINT `fk_pacientes_tipo_doc` FOREIGN KEY (`id_tipo_doc`) REFERENCES `tipos_documento` (`id_tipo`),
  ADD CONSTRAINT `fk_pacientes_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`);

--
-- Filtros para la tabla `profesionales`
--
ALTER TABLE `profesionales`
  ADD CONSTRAINT `fk_profesionales_estado` FOREIGN KEY (`id_estado`) REFERENCES `estados_profesional` (`id_estado`),
  ADD CONSTRAINT `fk_profesionales_tipo_doc` FOREIGN KEY (`id_tipo_doc`) REFERENCES `tipos_documento` (`id_tipo`),
  ADD CONSTRAINT `fk_profesionales_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`);

--
-- Filtros para la tabla `profesionales_especialidades`
--
ALTER TABLE `profesionales_especialidades`
  ADD CONSTRAINT `fk_prof_esp_especialidad` FOREIGN KEY (`id_especialidad`) REFERENCES `especialidades` (`id_especialidad`),
  ADD CONSTRAINT `fk_prof_esp_profesional` FOREIGN KEY (`id_profesional`) REFERENCES `profesionales` (`id_profesional`);

--
-- Filtros para la tabla `profesionales_sedes`
--
ALTER TABLE `profesionales_sedes`
  ADD CONSTRAINT `fk_prof_sede_profesional` FOREIGN KEY (`id_profesional`) REFERENCES `profesionales` (`id_profesional`),
  ADD CONSTRAINT `fk_prof_sede_sede` FOREIGN KEY (`id_sede`) REFERENCES `sedes` (`id_sede`);

--
-- Filtros para la tabla `sedes`
--
ALTER TABLE `sedes`
  ADD CONSTRAINT `fk_sedes_ciudad` FOREIGN KEY (`id_ciudad`) REFERENCES `ciudades` (`id_ciudad`);

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `fk_usuarios_rol` FOREIGN KEY (`id_rol`) REFERENCES `roles` (`id_rol`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
