DROP SCHEMA IF EXISTS almacen CASCADE;

CREATE SCHEMA almacen;

-- =============================================
-- Script de Creación de Base de Datos
-- Módulo: Almacén
-- Proyecto: Ferretería
-- =============================================

-- ---------
-- Tablas Principales / Maestras
-- ---------

CREATE TABLE almacen.instalacion (
  cod_instalacion VARCHAR(10) PRIMARY KEY,
  nombre_instalacion VARCHAR(100) UNIQUE NOT NULL,
  direccion TEXT
);

CREATE TABLE almacen.producto (
  cod_producto VARCHAR(50) PRIMARY KEY,
  nombre_producto VARCHAR(255) NOT NULL,
  unidad VARCHAR(50) NOT NULL,
  peso DECIMAL(10, 2),
  precio_base DECIMAL(10, 2),
  cod_instalacion VARCHAR(10) NOT NULL,
  FOREIGN KEY (cod_instalacion) REFERENCES almacen.instalacion(cod_instalacion)
);

CREATE TABLE almacen.operador (
  cod_operador VARCHAR(20) PRIMARY KEY,
  numero VARCHAR(20),
  nombre VARCHAR(255) NOT NULL,
  dni VARCHAR(8) UNIQUE NOT NULL,
  cargo VARCHAR(50)
);

CREATE TABLE almacen.turno (
  cod_turno VARCHAR(20) PRIMARY KEY,
  hora_inicio TIME NOT NULL,
  hora_fin TIME NOT NULL,
  capacidad INT NOT NULL CHECK (capacidad > 0)
);

-- ---------
-- Jerarquía de Ubicaciones (Herencia)
-- ---------

CREATE TABLE almacen.ubicacion (
  cod_ubicacion VARCHAR(20) PRIMARY KEY,
  cod_ubicacion_calculado VARCHAR(100) UNIQUE,
  cod_instalacion VARCHAR(10) NOT NULL,
  FOREIGN KEY (cod_instalacion) REFERENCES almacen.instalacion(cod_instalacion)
);

CREATE TABLE almacen.ubicacion_almacen (
  cod_ubicacion VARCHAR(20) PRIMARY KEY,
  zona VARCHAR(50) NOT NULL,
  espacio VARCHAR(50) NOT NULL,
  FOREIGN KEY (cod_ubicacion) REFERENCES almacen.ubicacion(cod_ubicacion)
);

CREATE TABLE almacen.ubicacion_tienda (
  cod_ubicacion VARCHAR(20) PRIMARY KEY,
  pasillo VARCHAR(50) NOT NULL,
  estante VARCHAR(50) NOT NULL,
  nivel VARCHAR(50) NOT NULL,
  FOREIGN KEY (cod_ubicacion) REFERENCES almacen.ubicacion(cod_ubicacion)
);

-- ---------
-- Gestión de Stock
-- ---------

CREATE TABLE almacen.inventario (
  cod_inventario SERIAL PRIMARY KEY,
  stock_fisico INT NOT NULL DEFAULT 0,
  stock_comprometido INT NOT NULL DEFAULT 0,
  stock_minimo INT NOT NULL,
  cod_producto VARCHAR(50) NOT NULL UNIQUE,
  cod_ubicacion VARCHAR(20) NOT NULL UNIQUE,
  FOREIGN KEY (cod_producto) REFERENCES almacen.producto(cod_producto),
  FOREIGN KEY (cod_ubicacion) REFERENCES almacen.ubicacion(cod_ubicacion)
);

-- ---------
-- Entidades de Tareas y Eventos
-- ---------

CREATE TABLE almacen.recepcion (
  cod_recepcion VARCHAR(50) PRIMARY KEY,
  nombre_conductor_entrega VARCHAR(255),
  placa_vehiculo_entrega VARCHAR(10),
  estado VARCHAR(50) NOT NULL DEFAULT 'Pendiente'
);

CREATE TABLE almacen.despacho (
  cod_despacho VARCHAR(50) PRIMARY KEY,
  fecha_planificada DATE NOT NULL,
  estado VARCHAR(50) NOT NULL DEFAULT 'Pendiente'
);

CREATE TABLE almacen.conteo (
  cod_conteo VARCHAR(50) PRIMARY KEY,
  fecha_conteo DATE NOT NULL,
  hora_conteo TIME,
  estado VARCHAR(50) NOT NULL DEFAULT 'Pendiente'
);

CREATE TABLE almacen.reserva_almacen (
  codigo_reserva VARCHAR(50) PRIMARY KEY,
  fecha_reserva DATE NOT NULL,
  tipo_reserva VARCHAR(50) NOT NULL,
  estado VARCHAR(50) NOT NULL,
  cod_turno VARCHAR(20) NOT NULL,
  cod_despacho VARCHAR(50),
  cod_recepcion VARCHAR(50),
  cod_instalacion VARCHAR(10) NOT NULL,
  FOREIGN KEY (cod_turno) REFERENCES almacen.turno(cod_turno),
  FOREIGN KEY (cod_instalacion) REFERENCES almacen.instalacion(cod_instalacion),
  FOREIGN KEY (cod_despacho) REFERENCES almacen.despacho(cod_despacho),
  FOREIGN KEY (cod_recepcion) REFERENCES almacen.recepcion(cod_recepcion)
);

-- ---------
-- Tablas de Detalle y Asignación de Tareas
-- ---------

CREATE TABLE almacen.detalle_recepcion (
  cod_detalle_recepcion SERIAL PRIMARY KEY,
  cantidad_recibida INT NOT NULL,
  cod_recepcion VARCHAR(50) NOT NULL,
  cod_producto VARCHAR(50) NOT NULL,
  FOREIGN KEY (cod_recepcion) REFERENCES almacen.recepcion(cod_recepcion),
  FOREIGN KEY (cod_producto) REFERENCES almacen.producto(cod_producto)
);

CREATE TABLE almacen.detalle_conteo (
  cod_detalle_conteo SERIAL PRIMARY KEY,
  cantidad_contada INT NOT NULL,
  discrepancia INT,
  cod_conteo VARCHAR(50) NOT NULL,
  cod_producto VARCHAR(50) NOT NULL,
  FOREIGN KEY (cod_conteo) REFERENCES almacen.conteo(cod_conteo),
  FOREIGN KEY (cod_producto) REFERENCES almacen.producto(cod_producto)
);

CREATE TABLE almacen.operador_recepcion (
  cod_operador VARCHAR(20) NOT NULL,
  cod_recepcion VARCHAR(50) NOT NULL,
  PRIMARY KEY (cod_operador, cod_recepcion),
  FOREIGN KEY (cod_operador) REFERENCES almacen.operador(cod_operador),
  FOREIGN KEY (cod_recepcion) REFERENCES almacen.recepcion(cod_recepcion)
);

CREATE TABLE almacen.operador_despacho (
  cod_operador VARCHAR(20) NOT NULL,
  cod_despacho VARCHAR(50) NOT NULL,
  PRIMARY KEY (cod_operador, cod_despacho),
  FOREIGN KEY (cod_operador) REFERENCES almacen.operador(cod_operador),
  FOREIGN KEY (cod_despacho) REFERENCES almacen.despacho(cod_despacho)
);

CREATE TABLE almacen.operador_conteo (
  cod_operador VARCHAR(20) NOT NULL,
  cod_conteo VARCHAR(50) NOT NULL,
  PRIMARY KEY (cod_operador, cod_conteo),
  FOREIGN KEY (cod_operador) REFERENCES almacen.operador(cod_operador),
  FOREIGN KEY (cod_conteo) REFERENCES almacen.conteo(cod_conteo)
);

-- ---------
-- Otras Tablas (Movimientos, Incidencias)
-- ---------

CREATE TABLE almacen.incidencia (
  cod_incidencia VARCHAR(50) PRIMARY KEY,
  tipo_incidencia VARCHAR(50) NOT NULL,
  fecha_registro DATE,
  hora_registro TIME,
  cantidad_afectada INT NOT NULL,
  descripcion TEXT,
  cod_detalle_recepcion INT,
  cod_detalle_conteo INT,
  FOREIGN KEY (cod_detalle_recepcion) REFERENCES almacen.detalle_recepcion(cod_detalle_recepcion),
  FOREIGN KEY (cod_detalle_conteo) REFERENCES almacen.detalle_conteo(cod_detalle_conteo)
);

CREATE TABLE almacen.movimiento (
  cod_movimiento SERIAL PRIMARY KEY,
  fecha_movimiento DATE,
  hora_movimiento TIME,
  tipo_movimiento VARCHAR(50) NOT NULL,
  cantidad INT NOT NULL,
  cod_detalle_recepcion INT,
  cod_inventario INT NOT NULL,
  FOREIGN KEY (cod_inventario) REFERENCES almacen.inventario(cod_inventario),
  FOREIGN KEY (cod_detalle_recepcion) REFERENCES almacen.detalle_recepcion(cod_detalle_recepcion)
);
