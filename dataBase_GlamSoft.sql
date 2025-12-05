DATABASE GlamSoft;

USE GlamSoft;

CREATE TABLE categoria (
  id_categoria int PRIMARY KEY,
  nombre_categoria varchar(50) NOT NULL
);

CREATE TABLE servicio (
  id_servicio int PRIMARY KEY,
  nombre_servicio varchar(100) NOT NULL,
  duracion_minutos int NOT NULL,
  precio decimal(10,2) NOT NULL,
  descripcion text,
  categoria_id int NOT NULL
);

CREATE TABLE estilista_servicio (
  id_estilista int,
  id_servicio int,
  PRIMARY KEY (id_estilista, id_servicio)
);

CREATE TABLE rol (
  id_rol int PRIMARY KEY,
  nombre_rol varchar(50) NOT NULL
);

CREATE TABLE persona (
  id_persona int PRIMARY KEY,
  nombre varchar(100) NOT NULL,
  apellido varchar(100) NOT NULL,
  telefono varchar(20),
  email varchar(100) UNIQUE NOT NULL,
  password varchar(255) NOT NULL,
  rol_id int NOT NULL
);

CREATE TABLE horario (
  id_horario int PRIMARY KEY,
  hora_inicio time NOT NULL,
  hora_final time NOT NULL,
  dia_semana varchar(20) NOT NULL
);

CREATE TABLE cita (
  id_cita int PRIMARY KEY,
  estado_cita varchar(50) NOT NULL,
  locacion varchar(255),
  fecha_hora_cita datetime NOT NULL,
  fecha_solicitud timestamp DEFAULT (now()),
  id_cliente int NOT NULL,
  id_estilista int NOT NULL,
  horario_id int
);

CREATE TABLE cita_servicio (
  cita_id int,
  servicio_id int,
  precio_en_cita decimal(10,2),
  PRIMARY KEY (cita_id, servicio_id)
);

CREATE TABLE valoracion (
  id_valoracion int PRIMARY KEY,
  puntuacion int NOT NULL,
  cita_id int NOT NULL,
  persona_id int NOT NULL
);

CREATE TABLE comentario (
  id_comentario int PRIMARY KEY,
  comentario text NOT NULL,
  fecha_comentario timestamp DEFAULT (now()),
  cita_id int NOT NULL,
  persona_id int NOT NULL
);

ALTER TABLE servicio ADD FOREIGN KEY (categoria_id) REFERENCES categoria (id_categoria);
ALTER TABLE estilista_servicio ADD FOREIGN KEY (id_estilista) REFERENCES persona (id_persona);
ALTER TABLE estilista_servicio ADD FOREIGN KEY (id_servicio) REFERENCES servicio (id_servicio);
ALTER TABLE persona ADD FOREIGN KEY (rol_id) REFERENCES rol (id_rol);
ALTER TABLE cita ADD FOREIGN KEY (id_cliente) REFERENCES persona (id_persona);
ALTER TABLE cita ADD FOREIGN KEY (id_estilista) REFERENCES persona (id_persona);
ALTER TABLE cita ADD FOREIGN KEY (horario_id) REFERENCES horario (id_horario);
ALTER TABLE cita_servicio ADD FOREIGN KEY (cita_id) REFERENCES cita (id_cita);
ALTER TABLE cita_servicio ADD FOREIGN KEY (servicio_id) REFERENCES servicio (id_servicio);
ALTER TABLE valoracion ADD FOREIGN KEY (cita_id) REFERENCES cita (id_cita);
ALTER TABLE valoracion ADD FOREIGN KEY (persona_id) REFERENCES persona (id_persona);
ALTER TABLE comentario ADD FOREIGN KEY (cita_id) REFERENCES cita (id_cita);
ALTER TABLE comentario ADD FOREIGN KEY (persona_id) REFERENCES persona (id_persona);
