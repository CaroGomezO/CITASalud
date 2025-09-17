-- Extensiones
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- ========================
-- ESQUEMA
-- ========================
CREATE SCHEMA IF NOT EXISTS eps_app;
SET search_path TO eps_app;

-- =====================================================
-- CREACIÓN DE TABLAS
-- =====================================================

-- Roles del sistema
CREATE TABLE roles (
    id_rol SERIAL PRIMARY KEY,
    nombre VARCHAR(50) UNIQUE NOT NULL
);

-- Usuarios (login)
CREATE TABLE usuarios (
    id_usuario SERIAL PRIMARY KEY,
    correo VARCHAR(150) UNIQUE NOT NULL,
    contrasena VARCHAR(200) NOT NULL, -- encriptada
    id_rol INT NOT NULL REFERENCES roles(id_rol),
    activo BOOLEAN DEFAULT TRUE
);

-- Tipos de documento
CREATE TABLE tipos_documento (
    id_tipo SERIAL PRIMARY KEY,
    nombre_tipo VARCHAR(50) UNIQUE NOT NULL
);

-- Ciudades
CREATE TABLE ciudades (
    id_ciudad SERIAL PRIMARY KEY,
    nombre_ciudad VARCHAR(100) UNIQUE NOT NULL,
    departamento VARCHAR(50) NOT NULL
);

-- Sedes médicas
CREATE TABLE sedes (
    id_sede SERIAL PRIMARY KEY,
    nombre_sede VARCHAR(100) NOT NULL,
    direccion VARCHAR(150) NOT NULL,
    id_ciudad INT NOT NULL REFERENCES ciudades(id_ciudad)
);

-- Especialidades médicas
CREATE TABLE especialidades (
    id_especialidad SERIAL PRIMARY KEY,
    nombre_especialidad VARCHAR(100) UNIQUE NOT NULL,
    descripcion TEXT
);

-- Estados de profesionales
CREATE TABLE estados_profesional (
    id_estado SERIAL PRIMARY KEY,
    nombre_estado VARCHAR(50) UNIQUE NOT NULL
);

-- Profesionales
CREATE TABLE profesionales (
    id_profesional SERIAL PRIMARY KEY,
    id_usuario INT UNIQUE REFERENCES usuarios(id_usuario),
    id_tipo_doc INT NOT NULL REFERENCES tipos_documento(id_tipo),
    numero_documento VARCHAR(20) UNIQUE NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    titulo_profesional VARCHAR(100) NOT NULL,
    anos_experiencia INT,
    id_estado INT NOT NULL REFERENCES estados_profesional(id_estado)
);

-- Profesionales ↔ Especialidades
CREATE TABLE profesionales_especialidades (
    id_profesional INT NOT NULL REFERENCES profesionales(id_profesional),
    id_especialidad INT NOT NULL REFERENCES especialidades(id_especialidad),
    PRIMARY KEY (id_profesional, id_especialidad)
);

-- Profesionales ↔ Sedes
CREATE TABLE profesionales_sedes (
    id_profesional INT NOT NULL REFERENCES profesionales(id_profesional),
    id_sede INT NOT NULL REFERENCES sedes(id_sede),
    PRIMARY KEY (id_profesional, id_sede)
);

-- Pacientes
CREATE TABLE pacientes (
    id_paciente SERIAL PRIMARY KEY,
    id_usuario INT UNIQUE REFERENCES usuarios(id_usuario),
    id_tipo_doc INT NOT NULL REFERENCES tipos_documento(id_tipo),
    numero_documento VARCHAR(20) UNIQUE NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    correo VARCHAR(150),
    telefono VARCHAR(20)
);

-- Estados de citas
CREATE TABLE estados_cita (
    id_estado SERIAL PRIMARY KEY,
    nombre_estado VARCHAR(50) UNIQUE NOT NULL
);

-- Tipos de ausencia
CREATE TABLE tipos_ausencia (
    id_tipo SERIAL PRIMARY KEY,
    nombre_tipo VARCHAR(50) UNIQUE NOT NULL
);

-- Ausencias de profesionales
CREATE TABLE ausencias_profesionales (
    id_ausencia SERIAL PRIMARY KEY,
    id_profesional INT NOT NULL REFERENCES profesionales(id_profesional),
    id_tipo INT NOT NULL REFERENCES tipos_ausencia(id_tipo),
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL
);

-- Horarios de profesionales
CREATE TABLE horarios_profesionales (
    id_horario SERIAL PRIMARY KEY,
    id_profesional INT NOT NULL REFERENCES profesionales(id_profesional),
    fecha DATE NOT NULL,
    hora TIME NOT NULL,
    disponible BOOLEAN DEFAULT TRUE,
    UNIQUE (id_profesional, fecha, hora)
);

-- Citas médicas
CREATE TABLE citas (
    id_cita SERIAL PRIMARY KEY,
    id_paciente INT NOT NULL REFERENCES pacientes(id_paciente),
    id_profesional INT NOT NULL REFERENCES profesionales(id_profesional),
    id_sede INT NOT NULL REFERENCES sedes(id_sede),
    id_especialidad INT NOT NULL REFERENCES especialidades(id_especialidad),
    id_horario INT NOT NULL REFERENCES horarios_profesionales(id_horario),
    id_estado INT NOT NULL REFERENCES estados_cita(id_estado),
    recordatorio_enviado BOOLEAN DEFAULT FALSE
);

-- Historial de cambios de cita
CREATE TABLE historiales_cita (
    id_historial SERIAL PRIMARY KEY,
    id_cita INT NOT NULL REFERENCES citas(id_cita),
    id_estado INT NOT NULL REFERENCES estados_cita(id_estado),
    fecha_cambio TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    observacion TEXT
);

-- Notificaciones
CREATE TABLE notificaciones (
    id_notificacion SERIAL PRIMARY KEY,
    id_cita INT REFERENCES citas(id_cita),
    tipo_notificacion VARCHAR(50) NOT NULL,
    destinatario VARCHAR(200) NOT NULL,
    asunto VARCHAR(200),
    mensaje TEXT NOT NULL,
    enviado BOOLEAN DEFAULT FALSE,
    fecha_programada TIMESTAMP,
    fecha_enviado TIMESTAMP,
    intentos_envio INTEGER DEFAULT 0,
    error_envio TEXT
);

-- =====================================================
-- INSERCIÓN DE DATOS INICIALES
-- =====================================================

-- Inserción en 'roles' DEBE ser la primera
INSERT INTO roles (nombre) VALUES 
('Profesional'),
('Paciente');

-- El resto de los INSERT se ejecutan de manera consecutiva.
-- Inserción de tipos de documento
INSERT INTO tipos_documento (nombre_tipo) VALUES 
('Cédula de Ciudadanía'),
('Tarjeta de Identidad'),
('Cédula de Extranjería'),
('Pasaporte'),
('Registro Civil');

-- Inserción de ciudades
INSERT INTO ciudades (nombre_ciudad, departamento) VALUES
('Bogotá', 'Cundinamarca'),
('Medellín', 'Antioquia'),
('Cali', 'Valle del Cauca'),
('Barranquilla', 'Atlántico'),
('Cartagena', 'Bolívar'),
('Bucaramanga', 'Santander'),
('Pereira', 'Risaralda'),
('Manizales', 'Caldas'),
('Cúcuta', 'Norte de Santander'),
('Bello', 'Antioquia'),
('Itagüí', 'Antioquia'),
('Envigado', 'Antioquia'),
('Floridablanca', 'Santander'),
('Girón', 'Santander'),
('Soledad', 'Atlántico'),
('Malambo', 'Atlántico'),
('Soacha', 'Cundinamarca'),
('Madrid', 'Cundinamarca'),
('Zipaquirá', 'Cundinamarca'),
('Palmira', 'Valle del Cauca'),
('Tuluá', 'Valle del Cauca'),
('Dosquebradas', 'Risaralda'),
('Santa Rosa de Cabal', 'Risaralda'),
('Villavicencio', 'Meta'),
('Ibagué', 'Tolima'),
('Popayán', 'Cauca'),
('Tunja', 'Boyacá'),
('Pasto', 'Nariño'),
('Montería', 'Córdoba');

-- Inserción de sedes
INSERT INTO sedes (nombre_sede, direccion, id_ciudad) VALUES
('Clínica de la 80', 'Calle 80 # 35-12', (SELECT id_ciudad FROM ciudades WHERE nombre_ciudad = 'Medellín')),
('Centro Médico Galerías', 'Avenida Caracas # 53-90', (SELECT id_ciudad FROM ciudades WHERE nombre_ciudad = 'Bogotá')),
('IPS de la Loma', 'Carrera 56 # 15-30', (SELECT id_ciudad FROM ciudades WHERE nombre_ciudad = 'Cali')),
('Hospital del Norte', 'Calle 50 # 8C-22', (SELECT id_ciudad FROM ciudades WHERE nombre_ciudad = 'Barranquilla')),
('Unidad de Urgencias', 'Carrera 5 # 71-45', (SELECT id_ciudad FROM ciudades WHERE nombre_ciudad = 'Cartagena')),
('Clínica de Especialidades', 'Avenida Quebrada Seca # 30-10', (SELECT id_ciudad FROM ciudades WHERE nombre_ciudad = 'Bucaramanga')),
('Sede Médica de la 20', 'Calle 20 # 25-15', (SELECT id_ciudad FROM ciudades WHERE nombre_ciudad = 'Manizales')),
('Hospital de la Pradera', 'Carrera 7 # 28-56', (SELECT id_ciudad FROM ciudades WHERE nombre_ciudad = 'Pereira')),
('IPS Cúcuta Centro', 'Avenida 0 # 13-05', (SELECT id_ciudad FROM ciudades WHERE nombre_ciudad = 'Cúcuta')),
('Centro de Salud Bello', 'Carrera 50 # 45-67', (SELECT id_ciudad FROM ciudades WHERE nombre_ciudad = 'Bello')),
('Sede Itagüí', 'Calle 70 # 50-89', (SELECT id_ciudad FROM ciudades WHERE nombre_ciudad = 'Itagüí')),
('Clínica Envigado', 'Carrera 43A # 36 Sur-12', (SELECT id_ciudad FROM ciudades WHERE nombre_ciudad = 'Envigado')),
('IPS Floridablanca', 'Calle 20 # 22-34', (SELECT id_ciudad FROM ciudades WHERE nombre_ciudad = 'Floridablanca')),
('Hospital Girón', 'Carrera 28 # 31-50', (SELECT id_ciudad FROM ciudades WHERE nombre_ciudad = 'Girón')),
('Clínica Soledad', 'Avenida Murillo # 15-40', (SELECT id_ciudad FROM ciudades WHERE nombre_ciudad = 'Soledad')),
('Centro Médico Malambo', 'Calle 10 # 5-10', (SELECT id_ciudad FROM ciudades WHERE nombre_ciudad = 'Malambo')),
('Sede Soacha', 'Calle 22 # 11-20', (SELECT id_ciudad FROM ciudades WHERE nombre_ciudad = 'Soacha')),
('IPS Madrid', 'Carrera 3 # 4-50', (SELECT id_ciudad FROM ciudades WHERE nombre_ciudad = 'Madrid')),
('Clínica Zipaquirá', 'Calle 8 # 9-10', (SELECT id_ciudad FROM ciudades WHERE nombre_ciudad = 'Zipaquirá')),
('Hospital Palmira', 'Carrera 28 # 42-12', (SELECT id_ciudad FROM ciudades WHERE nombre_ciudad = 'Palmira')),
('Centro de Salud Tuluá', 'Calle 25 # 25-50', (SELECT id_ciudad FROM ciudades WHERE nombre_ciudad = 'Tuluá')),
('IPS Dosquebradas', 'Avenida Simones # 4-30', (SELECT id_ciudad FROM ciudades WHERE nombre_ciudad = 'Dosquebradas')),
('Clínica Santa Rosa', 'Carrera 14 # 19-25', (SELECT id_ciudad FROM ciudades WHERE nombre_ciudad = 'Santa Rosa de Cabal')),
('Hospital Villavicencio', 'Calle 40 # 25-15', (SELECT id_ciudad FROM ciudades WHERE nombre_ciudad = 'Villavicencio')),
('Sede Ibagué', 'Carrera 5 # 32-05', (SELECT id_ciudad FROM ciudades WHERE nombre_ciudad = 'Ibagué')),
('IPS Popayán', 'Calle 5 # 10-20', (SELECT id_ciudad FROM ciudades WHERE nombre_ciudad = 'Popayán')),
('Clínica Tunja', 'Avenida Norte # 20-30', (SELECT id_ciudad FROM ciudades WHERE nombre_ciudad = 'Tunja')),
('Hospital Pasto', 'Carrera 27 # 16-55', (SELECT id_ciudad FROM ciudades WHERE nombre_ciudad = 'Pasto')),
('Centro Médico Montería', 'Calle 29 # 10-15', (SELECT id_ciudad FROM ciudades WHERE nombre_ciudad = 'Montería'));

-- Inserción de especialidades
INSERT INTO especialidades (nombre_especialidad, descripcion) VALUES
('Cardiología', 'Especialidad médica que se ocupa del diagnóstico y tratamiento de las enfermedades del corazón y del sistema circulatorio.'),
('Pediatría', 'Especialidad médica que se encarga del estudio del crecimiento y desarrollo de los niños hasta la adolescencia, así como del diagnóstico y tratamiento de sus enfermedades.'),
('Dermatología', 'Rama de la medicina que se especializa en el estudio, diagnóstico y tratamiento de las enfermedades de la piel, cabello y uñas.'),
('Ginecología', 'Especialidad médica y quirúrgica que se encarga de la salud integral de la mujer, especialmente en el diagnóstico y tratamiento de las enfermedades del sistema reproductor femenino.'),
('Neurología', 'Especialidad de la medicina que estudia el sistema nervioso y las enfermedades relacionadas con el cerebro, la médula espinal y los nervios periféricos.'),
('Odontología', 'Ciencia de la salud que se encarga del diagnóstico, tratamiento y prevención de las enfermedades de los dientes, encías y la cavidad oral en general.'),
('Ortopedia', 'Especialidad que se dedica al diagnóstico, corrección y prevención de deformidades o trastornos del sistema musculoesquelético.'),
('Oftalmología', 'Especialidad médica que estudia y trata las enfermedades relacionadas con los ojos, la visión y las estructuras oculares.'),
('Urología', 'Especialidad médico-quirúrgica que se ocupa del diagnóstico y tratamiento de las enfermedades del sistema urinario en hombres y mujeres, y del sistema reproductor masculino.'),
('Psiquiatría', 'Rama de la medicina que se dedica al estudio, diagnóstico y tratamiento de los trastornos mentales, emocionales y del comportamiento.'),
('Medicina Interna', 'Especialidad clínica que aborda de manera integral las enfermedades que afectan a los órganos internos de los adultos, sin procedimientos quirúrgicos.'),
('Nutrición', 'Especialidad que estudia la relación entre la alimentación y la salud humana, enfocada en la prevención y tratamiento de enfermedades a través de la dieta.'),
('Fisioterapia', 'Especialidad de la salud que utiliza medios físicos para prevenir, tratar y rehabilitar a personas con dolencias o discapacidades físicas.'),
('Oncología', 'Especialidad de la medicina que se dedica al diagnóstico y tratamiento del cáncer.'),
('Radiología', 'Especialidad médica que utiliza imágenes (rayos X, resonancia, etc.) para diagnosticar y, en algunos casos, tratar enfermedades y lesiones.'),
('Anestesiología', 'Especialidad que se encarga de la atención y cuidado del paciente antes, durante y después de un procedimiento quirúrgico, controlando la anestesia y las funciones vitales.'),
('Cirugía General', 'Especialidad quirúrgica que se ocupa del diagnóstico y tratamiento de enfermedades a través de procedimientos operatorios, principalmente en el abdomen.'),
('Endocrinología', 'Especialidad que estudia las glándulas endocrinas, sus hormonas y las enfermedades asociadas, como la diabetes y los trastornos de la tiroides.'),
('Gastroenterología', 'Especialidad médica que se enfoca en el estudio y tratamiento de las enfermedades del sistema digestivo, incluyendo el esófago, estómago, intestinos, hígado y páncreas.'),
('Hematología', 'Rama de la medicina que estudia la sangre, los órganos hematopoyéticos y el tratamiento de sus enfermedades.'),
('Nefrología', 'Especialidad que se dedica al estudio de la estructura y función de los riñones, y al diagnóstico y tratamiento de sus enfermedades.'),
('Neumología', 'Especialidad médica que se encarga del estudio y tratamiento de las enfermedades del sistema respiratorio, incluyendo los pulmones y las vías aéreas.'),
('Reumatología', 'Especialidad que se ocupa de las enfermedades del tejido conectivo, articulaciones, músculos y huesos.'),
('Inmunología', 'Ciencia que estudia el sistema inmunitario y las enfermedades relacionadas con sus funciones, como las alergias y las enfermedades autoinmunes.'),
('Genética Médica', 'Especialidad que diagnostica, previene y gestiona trastornos genéticos o hereditarios en individuos y sus familias.'),
('Toxicología', 'Disciplina que estudia los efectos adversos de sustancias químicas sobre los organismos vivos.'),
('Geriatría', 'Especialidad médica que se encarga de la salud y el bienestar de los adultos mayores, abordando sus enfermedades y necesidades específicas.'),
('Medicina Familiar', 'Especialidad que proporciona atención integral y continua a los individuos y sus familias, considerando su contexto biológico, psicológico y social.'),
('Patología', 'Especialidad médica que diagnostica enfermedades mediante el análisis de tejidos, fluidos corporales y órganos.'),
('Alergología', 'Especialidad que diagnostica y trata las enfermedades alérgicas, incluyendo asma, rinitis y reacciones a alimentos o medicamentos.'),
('Otorrinolaringología', 'Especialidad médico-quirúrgica que se enfoca en el oído, la nariz, la garganta y las estructuras relacionadas en la cabeza y el cuello.'),
('Terapia Respiratoria', 'Profesión de la salud que se encarga de la prevención, diagnóstico, tratamiento y rehabilitación de enfermedades que afectan el sistema respiratorio.'),
('Medicina Nuclear', 'Especialidad que utiliza sustancias radioactivas para diagnosticar y tratar enfermedades.'),
('Dermopatología', 'Subespecialidad que combina la dermatología y la patología, enfocándose en el diagnóstico de enfermedades de la piel a nivel microscópico.'),
('Oftalmología Pediátrica', 'Subespecialidad de la oftalmología que se enfoca en el cuidado de los ojos y la visión en niños.'),
('Cardiología Intervencionista', 'Subespecialidad de la cardiología que utiliza cateterismo para diagnosticar y tratar enfermedades cardíacas.'),
('Cirugía Plástica', 'Especialidad quirúrgica que se dedica a la restauración, reconstrucción o alteración de la forma del cuerpo humano.'),
('Medicina Estética', 'Rama de la medicina que se enfoca en mejorar la apariencia física de las personas a través de procedimientos no invasivos o mínimamente invasivos.'),
('Acupuntura', 'Práctica de la medicina tradicional china que utiliza agujas finas para estimular puntos específicos del cuerpo con fines terapéuticos.'),
('Homeopatía', 'Sistema de medicina alternativa que utiliza dosis mínimas de sustancias naturales para estimular la capacidad de autocuración del cuerpo.'),
('Quiropráctica', 'Disciplina de la salud que se centra en el diagnóstico, tratamiento y prevención de trastornos del sistema musculoesquelético, especialmente de la columna vertebral.'),
('Osteopatía', 'Sistema de medicina alternativa que se basa en la idea de que el cuerpo tiene la capacidad de curarse a sí mismo, a través de la manipulación del sistema musculoesquelético.'),
('Podología', 'Especialidad que se dedica al estudio, diagnóstico y tratamiento de las enfermedades y afecciones del pie.'),
('Medicina del Deporte', 'Especialidad que se enfoca en el cuidado médico de atletas y personas activas, incluyendo la prevención y tratamiento de lesiones deportivas.'),
('Sexología', 'Disciplina que estudia la sexualidad humana y sus trastornos.'),
('Epidemiología', 'Rama de la medicina que estudia la distribución, frecuencia y determinantes de las enfermedades en las poblaciones.'),
('Medicina Forense', 'Especialidad médica que se encarga de investigar las causas y circunstancias de la muerte para propósitos legales.'),
('Infectología', 'Especialidad que se dedica al diagnóstico y tratamiento de enfermedades causadas por agentes infecciosos como bacterias, virus y hongos.'),
('Nefrología Pediátrica', 'Subespecialidad de la nefrología que se enfoca en el diagnóstico y tratamiento de enfermedades renales en niños.'),
('Medicina Crítica', 'Especialidad médica que se encarga del cuidado de pacientes con enfermedades graves y potencialmente mortales.'),
('Endoscopia', 'Procedimiento médico que utiliza un endoscopio para examinar el interior del cuerpo, especialmente el sistema digestivo o respiratorio.');

-- Inserción de estados de profesionales
INSERT INTO estados_profesional (nombre_estado) VALUES 
('Activo'),
('Vacaciones'),
('Licencia Médica'),
('Inactivo');

-- Inserción de estados de citas
INSERT INTO estados_cita (nombre_estado) VALUES 
('Agendada'),
('Modificada'),
('Cancelada'),
('Asistida'),
('Sin asistencia');

-- Inserción de tipos de ausencia
INSERT INTO tipos_ausencia (nombre_tipo) VALUES 
('Vacaciones'),
('Licencia Médica'),
('Capacitación'),
('Licencia de Maternidad'),
('Licencia de Paternidad'),
('Comisión de Servicios'),
('Permiso Personal');

-- Ahora se pueden insertar los datos de usuarios, profesionales, pacientes y sus relaciones.

-- Inserción de usuarios para 25 profesionales
INSERT INTO usuarios (correo, contrasena, id_rol) VALUES
('dra.sara.martinez@eps.co', crypt('pass123', gen_salt('bf')), (SELECT id_rol FROM roles WHERE nombre = 'Profesional')),
('dr.andres.gomez@eps.co', crypt('pass123', gen_salt('bf')), (SELECT id_rol FROM roles WHERE nombre = 'Profesional')),
('dra.laura.perez@eps.co', crypt('pass123', gen_salt('bf')), (SELECT id_rol FROM roles WHERE nombre = 'Profesional')),
('dr.carlos.rojas@eps.co', crypt('pass123', gen_salt('bf')), (SELECT id_rol FROM roles WHERE nombre = 'Profesional')),
('dr.mario.sanchez@eps.co', crypt('pass123', gen_salt('bf')), (SELECT id_rol FROM roles WHERE nombre = 'Profesional')),
('dra.ana.lopez@eps.co', crypt('pass123', gen_salt('bf')), (SELECT id_rol FROM roles WHERE nombre = 'Profesional')),
('dr.juan.ramirez@eps.co', crypt('pass123', gen_salt('bf')), (SELECT id_rol FROM roles WHERE nombre = 'Profesional')),
('dra.paula.castro@eps.co', crypt('pass123', gen_salt('bf')), (SELECT id_rol FROM roles WHERE nombre = 'Profesional')),
('dr.daniel.jimenez@eps.co', crypt('pass123', gen_salt('bf')), (SELECT id_rol FROM roles WHERE nombre = 'Profesional')),
('dra.sofia.ruiz@eps.co', crypt('pass123', gen_salt('bf')), (SELECT id_rol FROM roles WHERE nombre = 'Profesional')),
('dr.luis.fernandez@eps.co', crypt('pass123', gen_salt('bf')), (SELECT id_rol FROM roles WHERE nombre = 'Profesional')),
('dra.camila.guzman@eps.co', crypt('pass123', gen_salt('bf')), (SELECT id_rol FROM roles WHERE nombre = 'Profesional')),
('dr.david.mora@eps.co', crypt('pass123', gen_salt('bf')), (SELECT id_rol FROM roles WHERE nombre = 'Profesional')),
('dra.valentina.vargas@eps.co', crypt('pass123', gen_salt('bf')), (SELECT id_rol FROM roles WHERE nombre = 'Profesional')),
('dr.felipe.herrera@eps.co', crypt('pass123', gen_salt('bf')), (SELECT id_rol FROM roles WHERE nombre = 'Profesional')),
('dra.isabella.munoz@eps.co', crypt('pass123', gen_salt('bf')), (SELECT id_rol FROM roles WHERE nombre = 'Profesional')),
('dr.jorge.ortiz@eps.co', crypt('pass123', gen_salt('bf')), (SELECT id_rol FROM roles WHERE nombre = 'Profesional')),
('dra.claudia.garcia@eps.co', crypt('pass123', gen_salt('bf')), (SELECT id_rol FROM roles WHERE nombre = 'Profesional')),
('dr.hugo.diaz@eps.co', crypt('pass123', gen_salt('bf')), (SELECT id_rol FROM roles WHERE nombre = 'Profesional')),
('dra.patricia.silva@eps.co', crypt('pass123', gen_salt('bf')), (SELECT id_rol FROM roles WHERE nombre = 'Profesional')),
('dr.esteban.castaneda@eps.co', crypt('pass123', gen_salt('bf')), (SELECT id_rol FROM roles WHERE nombre = 'Profesional')),
('dra.elena.pardo@eps.co', crypt('pass123', gen_salt('bf')), (SELECT id_rol FROM roles WHERE nombre = 'Profesional')),
('dr.ricardo.pineda@eps.co', crypt('pass123', gen_salt('bf')), (SELECT id_rol FROM roles WHERE nombre = 'Profesional')),
('dra.liliana.cortes@eps.co', crypt('pass123', gen_salt('bf')), (SELECT id_rol FROM roles WHERE nombre = 'Profesional')),
('dr.gustavo.quiroga@eps.co', crypt('pass123', gen_salt('bf')), (SELECT id_rol FROM roles WHERE nombre = 'Profesional'));

-- Inserción de usuarios para 10 pacientes
INSERT INTO usuarios (correo, contrasena, id_rol) VALUES
('paciente1@eps.co', crypt('pass123', gen_salt('bf')), (SELECT id_rol FROM roles WHERE nombre = 'Paciente')),
('paciente2@eps.co', crypt('pass123', gen_salt('bf')), (SELECT id_rol FROM roles WHERE nombre = 'Paciente')),
('paciente3@eps.co', crypt('pass123', gen_salt('bf')), (SELECT id_rol FROM roles WHERE nombre = 'Paciente')),
('paciente4@eps.co', crypt('pass123', gen_salt('bf')), (SELECT id_rol FROM roles WHERE nombre = 'Paciente')),
('paciente5@eps.co', crypt('pass123', gen_salt('bf')), (SELECT id_rol FROM roles WHERE nombre = 'Paciente')),
('paciente6@eps.co', crypt('pass123', gen_salt('bf')), (SELECT id_rol FROM roles WHERE nombre = 'Paciente')),
('paciente7@eps.co', crypt('pass123', gen_salt('bf')), (SELECT id_rol FROM roles WHERE nombre = 'Paciente')),
('paciente8@eps.co', crypt('pass123', gen_salt('bf')), (SELECT id_rol FROM roles WHERE nombre = 'Paciente')),
('paciente9@eps.co', crypt('pass123', gen_salt('bf')), (SELECT id_rol FROM roles WHERE nombre = 'Paciente')),
('paciente10@eps.co', crypt('pass123', gen_salt('bf')), (SELECT id_rol FROM roles WHERE nombre = 'Paciente'));

-- Inserción de profesionales
INSERT INTO profesionales (id_usuario, id_tipo_doc, numero_documento, nombre, apellido, titulo_profesional, anos_experiencia, id_estado) VALUES
((SELECT id_usuario FROM usuarios WHERE correo = 'dra.sara.martinez@eps.co'), (SELECT id_tipo FROM tipos_documento WHERE nombre_tipo = 'Cédula de Ciudadanía'), '1234567890', 'Sara', 'Martínez', 'Médica Pediatra', 10, (SELECT id_estado FROM estados_profesional WHERE nombre_estado = 'Activo')),
((SELECT id_usuario FROM usuarios WHERE correo = 'dr.andres.gomez@eps.co'), (SELECT id_tipo FROM tipos_documento WHERE nombre_tipo = 'Cédula de Ciudadanía'), '1234567891', 'Andrés', 'Gómez', 'Médico Cardiólogo', 15, (SELECT id_estado FROM estados_profesional WHERE nombre_estado = 'Activo')),
((SELECT id_usuario FROM usuarios WHERE correo = 'dra.laura.perez@eps.co'), (SELECT id_tipo FROM tipos_documento WHERE nombre_tipo = 'Cédula de Ciudadanía'), '1234567892', 'Laura', 'Pérez', 'Médica Dermatóloga', 8, (SELECT id_estado FROM estados_profesional WHERE nombre_estado = 'Activo')),
((SELECT id_usuario FROM usuarios WHERE correo = 'dr.carlos.rojas@eps.co'), (SELECT id_tipo FROM tipos_documento WHERE nombre_tipo = 'Cédula de Ciudadanía'), '1234567893', 'Carlos', 'Rojas', 'Médico Ginecólogo', 18, (SELECT id_estado FROM estados_profesional WHERE nombre_estado = 'Activo')),
((SELECT id_usuario FROM usuarios WHERE correo = 'dr.mario.sanchez@eps.co'), (SELECT id_tipo FROM tipos_documento WHERE nombre_tipo = 'Cédula de Ciudadanía'), '1234567894', 'Mario', 'Sánchez', 'Médico Neurólogo', 12, (SELECT id_estado FROM estados_profesional WHERE nombre_estado = 'Activo')),
((SELECT id_usuario FROM usuarios WHERE correo = 'dra.ana.lopez@eps.co'), (SELECT id_tipo FROM tipos_documento WHERE nombre_tipo = 'Cédula de Ciudadanía'), '1234567895', 'Ana', 'López', 'Odontóloga', 9, (SELECT id_estado FROM estados_profesional WHERE nombre_estado = 'Activo')),
((SELECT id_usuario FROM usuarios WHERE correo = 'dr.juan.ramirez@eps.co'), (SELECT id_tipo FROM tipos_documento WHERE nombre_tipo = 'Cédula de Ciudadanía'), '1234567896', 'Juan', 'Ramírez', 'Ortopedista', 22, (SELECT id_estado FROM estados_profesional WHERE nombre_estado = 'Activo')),
((SELECT id_usuario FROM usuarios WHERE correo = 'dra.paula.castro@eps.co'), (SELECT id_tipo FROM tipos_documento WHERE nombre_tipo = 'Cédula de Ciudadanía'), '1234567897', 'Paula', 'Castro', 'Médica Oftalmóloga', 14, (SELECT id_estado FROM estados_profesional WHERE nombre_estado = 'Activo')),
((SELECT id_usuario FROM usuarios WHERE correo = 'dr.daniel.jimenez@eps.co'), (SELECT id_tipo FROM tipos_documento WHERE nombre_tipo = 'Cédula de Ciudadanía'), '1234567898', 'Daniel', 'Jiménez', 'Médico Urólogo', 11, (SELECT id_estado FROM estados_profesional WHERE nombre_estado = 'Activo')),
((SELECT id_usuario FROM usuarios WHERE correo = 'dra.sofia.ruiz@eps.co'), (SELECT id_tipo FROM tipos_documento WHERE nombre_tipo = 'Cédula de Ciudadanía'), '1234567899', 'Sofía', 'Ruiz', 'Psicóloga', 7, (SELECT id_estado FROM estados_profesional WHERE nombre_estado = 'Activo')),
((SELECT id_usuario FROM usuarios WHERE correo = 'dr.luis.fernandez@eps.co'), (SELECT id_tipo FROM tipos_documento WHERE nombre_tipo = 'Cédula de Ciudadanía'), '1234567900', 'Luis', 'Fernández', 'Médico Internista', 19, (SELECT id_estado FROM estados_profesional WHERE nombre_estado = 'Activo')),
((SELECT id_usuario FROM usuarios WHERE correo = 'dra.camila.guzman@eps.co'), (SELECT id_tipo FROM tipos_documento WHERE nombre_tipo = 'Cédula de Ciudadanía'), '1234567901', 'Camila', 'Guzmán', 'Nutricionista', 6, (SELECT id_estado FROM estados_profesional WHERE nombre_estado = 'Activo')),
((SELECT id_usuario FROM usuarios WHERE correo = 'dr.david.mora@eps.co'), (SELECT id_tipo FROM tipos_documento WHERE nombre_tipo = 'Cédula de Ciudadanía'), '1234567902', 'David', 'Mora', 'Fisioterapeuta', 13, (SELECT id_estado FROM estados_profesional WHERE nombre_estado = 'Activo')),
((SELECT id_usuario FROM usuarios WHERE correo = 'dra.valentina.vargas@eps.co'), (SELECT id_tipo FROM tipos_documento WHERE nombre_tipo = 'Cédula de Ciudadanía'), '1234567903', 'Valentina', 'Vargas', 'Médica Oncólogo', 17, (SELECT id_estado FROM estados_profesional WHERE nombre_estado = 'Activo')),
((SELECT id_usuario FROM usuarios WHERE correo = 'dr.felipe.herrera@eps.co'), (SELECT id_tipo FROM tipos_documento WHERE nombre_tipo = 'Cédula de Ciudadanía'), '1234567904', 'Felipe', 'Herrera', 'Médico Radiólogo', 20, (SELECT id_estado FROM estados_profesional WHERE nombre_estado = 'Activo')),
((SELECT id_usuario FROM usuarios WHERE correo = 'dra.isabella.munoz@eps.co'), (SELECT id_tipo FROM tipos_documento WHERE nombre_tipo = 'Cédula de Ciudadanía'), '1234567905', 'Isabella', 'Muñoz', 'Anestesióloga', 16, (SELECT id_estado FROM estados_profesional WHERE nombre_estado = 'Activo')),
((SELECT id_usuario FROM usuarios WHERE correo = 'dr.jorge.ortiz@eps.co'), (SELECT id_tipo FROM tipos_documento WHERE nombre_tipo = 'Cédula de Ciudadanía'), '1234567906', 'Jorge', 'Ortiz', 'Cirujano General', 25, (SELECT id_estado FROM estados_profesional WHERE nombre_estado = 'Activo')),
((SELECT id_usuario FROM usuarios WHERE correo = 'dra.claudia.garcia@eps.co'), (SELECT id_tipo FROM tipos_documento WHERE nombre_tipo = 'Cédula de Ciudadanía'), '1234567907', 'Claudia', 'García', 'Endocrinóloga', 10, (SELECT id_estado FROM estados_profesional WHERE nombre_estado = 'Activo')),
((SELECT id_usuario FROM usuarios WHERE correo = 'dr.hugo.diaz@eps.co'), (SELECT id_tipo FROM tipos_documento WHERE nombre_tipo = 'Cédula de Ciudadanía'), '1234567908', 'Hugo', 'Díaz', 'Gastroenterólogo', 14, (SELECT id_estado FROM estados_profesional WHERE nombre_estado = 'Activo')),
((SELECT id_usuario FROM usuarios WHERE correo = 'dra.patricia.silva@eps.co'), (SELECT id_tipo FROM tipos_documento WHERE nombre_tipo = 'Cédula de Ciudadanía'), '1234567909', 'Patricia', 'Silva', 'Médica Familiar', 9, (SELECT id_estado FROM estados_profesional WHERE nombre_estado = 'Activo')),
((SELECT id_usuario FROM usuarios WHERE correo = 'dr.esteban.castaneda@eps.co'), (SELECT id_tipo FROM tipos_documento WHERE nombre_tipo = 'Cédula de Ciudadanía'), '1234567910', 'Esteban', 'Castañeda', 'Alergólogo', 11, (SELECT id_estado FROM estados_profesional WHERE nombre_estado = 'Activo')),
((SELECT id_usuario FROM usuarios WHERE correo = 'dra.elena.pardo@eps.co'), (SELECT id_tipo FROM tipos_documento WHERE nombre_tipo = 'Cédula de Ciudadanía'), '1234567911', 'Elena', 'Pardo', 'Otorrinolaringóloga', 15, (SELECT id_estado FROM estados_profesional WHERE nombre_estado = 'Activo')),
((SELECT id_usuario FROM usuarios WHERE correo = 'dr.ricardo.pineda@eps.co'), (SELECT id_tipo FROM tipos_documento WHERE nombre_tipo = 'Cédula de Ciudadanía'), '1234567912', 'Ricardo', 'Pineda', 'Médico Neurólogo', 13, (SELECT id_estado FROM estados_profesional WHERE nombre_estado = 'Activo')),
((SELECT id_usuario FROM usuarios WHERE correo = 'dra.liliana.cortes@eps.co'), (SELECT id_tipo FROM tipos_documento WHERE nombre_tipo = 'Cédula de Ciudadanía'), '1234567913', 'Liliana', 'Cortés', 'Cardióloga', 18, (SELECT id_estado FROM estados_profesional WHERE nombre_estado = 'Activo')),
((SELECT id_usuario FROM usuarios WHERE correo = 'dr.gustavo.quiroga@eps.co'), (SELECT id_tipo FROM tipos_documento WHERE nombre_tipo = 'Cédula de Ciudadanía'), '1234567914', 'Gustavo', 'Quiroga', 'Cirujano Plástico', 21, (SELECT id_estado FROM estados_profesional WHERE nombre_estado = 'Activo'));

-- Inserción de pacientes
INSERT INTO pacientes (id_usuario, id_tipo_doc, numero_documento, nombre, apellido, correo, telefono) VALUES
((SELECT id_usuario FROM usuarios WHERE correo = 'paciente1@eps.co'), (SELECT id_tipo FROM tipos_documento WHERE nombre_tipo = 'Cédula de Ciudadanía'), '1001001001', 'Juan', 'Pérez', 'paciente1@eps.co', '3001112233'),
((SELECT id_usuario FROM usuarios WHERE correo = 'paciente2@eps.co'), (SELECT id_tipo FROM tipos_documento WHERE nombre_tipo = 'Tarjeta de Identidad'), '1002002002', 'Ana', 'Gómez', 'paciente2@eps.co', '3004445566'),
((SELECT id_usuario FROM usuarios WHERE correo = 'paciente3@eps.co'), (SELECT id_tipo FROM tipos_documento WHERE nombre_tipo = 'Cédula de Ciudadanía'), '1003003003', 'Carlos', 'Rodríguez', 'paciente3@eps.co', '3007778899'),
((SELECT id_usuario FROM usuarios WHERE correo = 'paciente4@eps.co'), (SELECT id_tipo FROM tipos_documento WHERE nombre_tipo = 'Cédula de Extranjería'), '1004004004', 'María', 'López', 'paciente4@eps.co', '3009990011'),
((SELECT id_usuario FROM usuarios WHERE correo = 'paciente5@eps.co'), (SELECT id_tipo FROM tipos_documento WHERE nombre_tipo = 'Cédula de Ciudadanía'), '1005005005', 'Pedro', 'Sánchez', 'paciente5@eps.co', '3002223344'),
((SELECT id_usuario FROM usuarios WHERE correo = 'paciente6@eps.co'), (SELECT id_tipo FROM tipos_documento WHERE nombre_tipo = 'Tarjeta de Identidad'), '1006006006', 'Laura', 'Díaz', 'paciente6@eps.co', '3005556677'),
((SELECT id_usuario FROM usuarios WHERE correo = 'paciente7@eps.co'), (SELECT id_tipo FROM tipos_documento WHERE nombre_tipo = 'Pasaporte'), '1007007007', 'Felipe', 'Muñoz', 'paciente7@eps.co', '3008889900'),
((SELECT id_usuario FROM usuarios WHERE correo = 'paciente8@eps.co'), (SELECT id_tipo FROM tipos_documento WHERE nombre_tipo = 'Cédula de Ciudadanía'), '1008008008', 'Sofía', 'Castro', 'paciente8@eps.co', '3001110022'),
((SELECT id_usuario FROM usuarios WHERE correo = 'paciente9@eps.co'), (SELECT id_tipo FROM tipos_documento WHERE nombre_tipo = 'Cédula de Ciudadanía'), '1009009009', 'Diego', 'Vargas', 'paciente9@eps.co', '3003334455'),
((SELECT id_usuario FROM usuarios WHERE correo = 'paciente10@eps.co'), (SELECT id_tipo FROM tipos_documento WHERE nombre_tipo = 'Registro Civil'), '1010101010', 'Valeria', 'Ruiz', 'paciente10@eps.co', '3006667788');

-- Relaciones de Profesionales con Especialidades
INSERT INTO profesionales_especialidades (id_profesional, id_especialidad) VALUES
((SELECT id_profesional FROM profesionales WHERE numero_documento = '1234567890'), (SELECT id_especialidad FROM especialidades WHERE nombre_especialidad = 'Pediatría')),
((SELECT id_profesional FROM profesionales WHERE numero_documento = '1234567890'), (SELECT id_especialidad FROM especialidades WHERE nombre_especialidad = 'Medicina Familiar')),
((SELECT id_profesional FROM profesionales WHERE numero_documento = '1234567891'), (SELECT id_especialidad FROM especialidades WHERE nombre_especialidad = 'Cardiología')),
((SELECT id_profesional FROM profesionales WHERE numero_documento = '1234567891'), (SELECT id_especialidad FROM especialidades WHERE nombre_especialidad = 'Medicina Interna')),
((SELECT id_profesional FROM profesionales WHERE numero_documento = '1234567892'), (SELECT id_especialidad FROM especialidades WHERE nombre_especialidad = 'Dermatología')),
((SELECT id_profesional FROM profesionales WHERE numero_documento = '1234567893'), (SELECT id_especialidad FROM especialidades WHERE nombre_especialidad = 'Ginecología')),
((SELECT id_profesional FROM profesionales WHERE numero_documento = '1234567894'), (SELECT id_especialidad FROM especialidades WHERE nombre_especialidad = 'Neurología')),
((SELECT id_profesional FROM profesionales WHERE numero_documento = '1234567894'), (SELECT id_especialidad FROM especialidades WHERE nombre_especialidad = 'Psiquiatría')),
((SELECT id_profesional FROM profesionales WHERE numero_documento = '1234567895'), (SELECT id_especialidad FROM especialidades WHERE nombre_especialidad = 'Odontología')),
((SELECT id_profesional FROM profesionales WHERE numero_documento = '1234567896'), (SELECT id_especialidad FROM especialidades WHERE nombre_especialidad = 'Ortopedia')),
((SELECT id_profesional FROM profesionales WHERE numero_documento = '1234567897'), (SELECT id_especialidad FROM especialidades WHERE nombre_especialidad = 'Oftalmología')),
((SELECT id_profesional FROM profesionales WHERE numero_documento = '1234567898'), (SELECT id_especialidad FROM especialidades WHERE nombre_especialidad = 'Urología')),
((SELECT id_profesional FROM profesionales WHERE numero_documento = '1234567899'), (SELECT id_especialidad FROM especialidades WHERE nombre_especialidad = 'Psiquiatría')),
((SELECT id_profesional FROM profesionales WHERE numero_documento = '1234567900'), (SELECT id_especialidad FROM especialidades WHERE nombre_especialidad = 'Medicina Interna')),
((SELECT id_profesional FROM profesionales WHERE numero_documento = '1234567900'), (SELECT id_especialidad FROM especialidades WHERE nombre_especialidad = 'Gastroenterología')),
((SELECT id_profesional FROM profesionales WHERE numero_documento = '1234567901'), (SELECT id_especialidad FROM especialidades WHERE nombre_especialidad = 'Nutrición')),
((SELECT id_profesional FROM profesionales WHERE numero_documento = '1234567902'), (SELECT id_especialidad FROM especialidades WHERE nombre_especialidad = 'Fisioterapia')),
((SELECT id_profesional FROM profesionales WHERE numero_documento = '1234567903'), (SELECT id_especialidad FROM especialidades WHERE nombre_especialidad = 'Oncología')),
((SELECT id_profesional FROM profesionales WHERE numero_documento = '1234567904'), (SELECT id_especialidad FROM especialidades WHERE nombre_especialidad = 'Radiología')),
((SELECT id_profesional FROM profesionales WHERE numero_documento = '1234567905'), (SELECT id_especialidad FROM especialidades WHERE nombre_especialidad = 'Anestesiología')),
((SELECT id_profesional FROM profesionales WHERE numero_documento = '1234567906'), (SELECT id_especialidad FROM especialidades WHERE nombre_especialidad = 'Cirugía General')),
((SELECT id_profesional FROM profesionales WHERE numero_documento = '1234567906'), (SELECT id_especialidad FROM especialidades WHERE nombre_especialidad = 'Endoscopia')),
((SELECT id_profesional FROM profesionales WHERE numero_documento = '1234567907'), (SELECT id_especialidad FROM especialidades WHERE nombre_especialidad = 'Endocrinología')),
((SELECT id_profesional FROM profesionales WHERE numero_documento = '1234567908'), (SELECT id_especialidad FROM especialidades WHERE nombre_especialidad = 'Gastroenterología')),
((SELECT id_profesional FROM profesionales WHERE numero_documento = '1234567909'), (SELECT id_especialidad FROM especialidades WHERE nombre_especialidad = 'Medicina Familiar')),
((SELECT id_profesional FROM profesionales WHERE numero_documento = '1234567910'), (SELECT id_especialidad FROM especialidades WHERE nombre_especialidad = 'Alergología')),
((SELECT id_profesional FROM profesionales WHERE numero_documento = '1234567911'), (SELECT id_especialidad FROM especialidades WHERE nombre_especialidad = 'Otorrinolaringología')),
((SELECT id_profesional FROM profesionales WHERE numero_documento = '1234567912'), (SELECT id_especialidad FROM especialidades WHERE nombre_especialidad = 'Neurología')),
((SELECT id_profesional FROM profesionales WHERE numero_documento = '1234567913'), (SELECT id_especialidad FROM especialidades WHERE nombre_especialidad = 'Cardiología')),
((SELECT id_profesional FROM profesionales WHERE numero_documento = '1234567913'), (SELECT id_especialidad FROM especialidades WHERE nombre_especialidad = 'Cardiología Intervencionista')),
((SELECT id_profesional FROM profesionales WHERE numero_documento = '1234567914'), (SELECT id_especialidad FROM especialidades WHERE nombre_especialidad = 'Cirugía Plástica'));

-- Relaciones de Profesionales con Sedes
INSERT INTO profesionales_sedes (id_profesional, id_sede) VALUES
((SELECT id_profesional FROM profesionales WHERE numero_documento = '1234567890'), (SELECT id_sede FROM sedes WHERE nombre_sede = 'Centro Médico Galerías')),
((SELECT id_profesional FROM profesionales WHERE numero_documento = '1234567891'), (SELECT id_sede FROM sedes WHERE nombre_sede = 'Clínica de la 80')),
((SELECT id_profesional FROM profesionales WHERE numero_documento = '1234567892'), (SELECT id_sede FROM sedes WHERE nombre_sede = 'IPS de la Loma')),
((SELECT id_profesional FROM profesionales WHERE numero_documento = '1234567893'), (SELECT id_sede FROM sedes WHERE nombre_sede = 'Hospital del Norte')),
((SELECT id_profesional FROM profesionales WHERE numero_documento = '1234567894'), (SELECT id_sede FROM sedes WHERE nombre_sede = 'Centro Médico Galerías')),
((SELECT id_profesional FROM profesionales WHERE numero_documento = '1234567895'), (SELECT id_sede FROM sedes WHERE nombre_sede = 'Sede Médica de la 20')),
((SELECT id_profesional FROM profesionales WHERE numero_documento = '1234567896'), (SELECT id_sede FROM sedes WHERE nombre_sede = 'Hospital de la Pradera')),
((SELECT id_profesional FROM profesionales WHERE numero_documento = '1234567897'), (SELECT id_sede FROM sedes WHERE nombre_sede = 'IPS Cúcuta Centro')),
((SELECT id_profesional FROM profesionales WHERE numero_documento = '1234567898'), (SELECT id_sede FROM sedes WHERE nombre_sede = 'Centro de Salud Bello')),
((SELECT id_profesional FROM profesionales WHERE numero_documento = '1234567899'), (SELECT id_sede FROM sedes WHERE nombre_sede = 'Sede Itagüí')),
((SELECT id_profesional FROM profesionales WHERE numero_documento = '1234567900'), (SELECT id_sede FROM sedes WHERE nombre_sede = 'Clínica Envigado')),
((SELECT id_profesional FROM profesionales WHERE numero_documento = '1234567901'), (SELECT id_sede FROM sedes WHERE nombre_sede = 'IPS Floridablanca')),
((SELECT id_profesional FROM profesionales WHERE numero_documento = '1234567902'), (SELECT id_sede FROM sedes WHERE nombre_sede = 'Hospital Girón')),
((SELECT id_profesional FROM profesionales WHERE numero_documento = '1234567903'), (SELECT id_sede FROM sedes WHERE nombre_sede = 'Clínica Soledad')),
((SELECT id_profesional FROM profesionales WHERE numero_documento = '1234567904'), (SELECT id_sede FROM sedes WHERE nombre_sede = 'Centro Médico Malambo')),
((SELECT id_profesional FROM profesionales WHERE numero_documento = '1234567905'), (SELECT id_sede FROM sedes WHERE nombre_sede = 'Sede Soacha')),
((SELECT id_profesional FROM profesionales WHERE numero_documento = '1234567906'), (SELECT id_sede FROM sedes WHERE nombre_sede = 'IPS Madrid')),
((SELECT id_profesional FROM profesionales WHERE numero_documento = '1234567907'), (SELECT id_sede FROM sedes WHERE nombre_sede = 'Clínica Zipaquirá')),
((SELECT id_profesional FROM profesionales WHERE numero_documento = '1234567908'), (SELECT id_sede FROM sedes WHERE nombre_sede = 'Hospital Palmira')),
((SELECT id_profesional FROM profesionales WHERE numero_documento = '1234567909'), (SELECT id_sede FROM sedes WHERE nombre_sede = 'Centro de Salud Tuluá')),
((SELECT id_profesional FROM profesionales WHERE numero_documento = '1234567910'), (SELECT id_sede FROM sedes WHERE nombre_sede = 'IPS Dosquebradas')),
((SELECT id_profesional FROM profesionales WHERE numero_documento = '1234567911'), (SELECT id_sede FROM sedes WHERE nombre_sede = 'Clínica Santa Rosa')),
((SELECT id_profesional FROM profesionales WHERE numero_documento = '1234567912'), (SELECT id_sede FROM sedes WHERE nombre_sede = 'Hospital Villavicencio')),
((SELECT id_profesional FROM profesionales WHERE numero_documento = '1234567913'), (SELECT id_sede FROM sedes WHERE nombre_sede = 'Sede Ibagué')),
((SELECT id_profesional FROM profesionales WHERE numero_documento = '1234567914'), (SELECT id_sede FROM sedes WHERE nombre_sede = 'IPS Popayán'));

-- Inserción de horarios para algunos profesionales -- ADDED
INSERT INTO horarios_profesionales (id_profesional, fecha, hora, disponible) VALUES
((SELECT id_profesional FROM profesionales WHERE numero_documento = '1234567891'), '2025-09-17', '08:00:00', TRUE),
((SELECT id_profesional FROM profesionales WHERE numero_documento = '1234567891'), '2025-09-17', '08:30:00', TRUE),
((SELECT id_profesional FROM profesionales WHERE numero_documento = '1234567891'), '2025-09-17', '09:00:00', TRUE),
((SELECT id_profesional FROM profesionales WHERE numero_documento = '1234567893'), '2025-09-17', '10:00:00', TRUE),
((SELECT id_profesional FROM profesionales WHERE numero_documento = '1234567893'), '2025-09-17', '10:30:00', TRUE),
((SELECT id_profesional FROM profesionales WHERE numero_documento = '1234567896'), '2025-09-17', '11:00:00', TRUE),
((SELECT id_profesional FROM profesionales WHERE numero_documento = '1234567896'), '2025-09-17', '11:30:00', TRUE),
((SELECT id_profesional FROM profesionales WHERE numero_documento = '1234567896'), '2025-09-17', '12:00:00', TRUE),
((SELECT id_profesional FROM profesionales WHERE numero_documento = '1234567900'), '2025-09-18', '14:00:00', TRUE),
((SELECT id_profesional FROM profesionales WHERE numero_documento = '1234567900'), '2025-09-18', '14:30:00', TRUE),
((SELECT id_profesional FROM profesionales WHERE numero_documento = '1234567900'), '2025-09-18', '15:00:00', TRUE),
((SELECT id_profesional FROM profesionales WHERE numero_documento = '1234567900'), '2025-09-18', '15:30:00', TRUE);

-- Inserción de citas de prueba -- ADDED
INSERT INTO citas (id_paciente, id_profesional, id_sede, id_especialidad, id_horario, id_estado, recordatorio_enviado) VALUES
((SELECT id_paciente FROM pacientes WHERE numero_documento = '1001001001'), (SELECT id_profesional FROM profesionales WHERE numero_documento = '1234567891'), (SELECT id_sede FROM sedes WHERE nombre_sede = 'Centro Médico Galerías'), (SELECT id_especialidad FROM especialidades WHERE nombre_especialidad = 'Cardiología'), (SELECT id_horario FROM horarios_profesionales WHERE id_profesional = (SELECT id_profesional FROM profesionales WHERE numero_documento = '1234567891') AND fecha = '2025-09-17' AND hora = '08:00:00'), (SELECT id_estado FROM estados_cita WHERE nombre_estado = 'Agendada'), FALSE),
((SELECT id_paciente FROM pacientes WHERE numero_documento = '1002002002'), (SELECT id_profesional FROM profesionales WHERE numero_documento = '1234567893'), (SELECT id_sede FROM sedes WHERE nombre_sede = 'Hospital del Norte'), (SELECT id_especialidad FROM especialidades WHERE nombre_especialidad = 'Ginecología'), (SELECT id_horario FROM horarios_profesionales WHERE id_profesional = (SELECT id_profesional FROM profesionales WHERE numero_documento = '1234567893') AND fecha = '2025-09-17' AND hora = '10:00:00'), (SELECT id_estado FROM estados_cita WHERE nombre_estado = 'Agendada'), FALSE),
((SELECT id_paciente FROM pacientes WHERE numero_documento = '1003003003'), (SELECT id_profesional FROM profesionales WHERE numero_documento = '1234567896'), (SELECT id_sede FROM sedes WHERE nombre_sede = 'Sede Médica de la 20'), (SELECT id_especialidad FROM especialidades WHERE nombre_especialidad = 'Ortopedia'), (SELECT id_horario FROM horarios_profesionales WHERE id_profesional = (SELECT id_profesional FROM profesionales WHERE numero_documento = '1234567896') AND fecha = '2025-09-17' AND hora = '11:00:00'), (SELECT id_estado FROM estados_cita WHERE nombre_estado = 'Agendada'), FALSE);

-- Inserción de un historial para una de las citas -- ADDED
INSERT INTO historiales_cita (id_cita, id_estado, observacion) VALUES
((SELECT id_cita FROM citas WHERE id_paciente = (SELECT id_paciente FROM pacientes WHERE numero_documento = '1001001001')), (SELECT id_estado FROM estados_cita WHERE nombre_estado = 'Agendada'), 'Cita agendada inicialmente.');

-- Inserción de notificaciones de prueba -- ADDED
INSERT INTO notificaciones (id_cita, tipo_notificacion, destinatario, asunto, mensaje, enviado, fecha_programada) VALUES
((SELECT id_cita FROM citas WHERE id_paciente = (SELECT id_paciente FROM pacientes WHERE numero_documento = '1001001001')), 'Correo electrónico', 'paciente1@eps.co', 'Confirmación de cita', 'Su cita con el Dr. Andrés Gómez ha sido confirmada para el 17/09/2025 a las 08:00 AM.', FALSE, '2025-09-16 20:00:00');