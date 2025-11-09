DROP SCHEMA IF EXISTS "Ventas" CASCADE;
CREATE SCHEMA "Ventas";
SET search_path TO "Ventas";

-- ===========================
--        LOOKUPS
-- ===========================
CREATE TABLE IF NOT EXISTS estado_venta (
  cod_estado_venta   SERIAL PRIMARY KEY,
  descp_estado_venta VARCHAR(80) NOT NULL UNIQUE
);


CREATE TABLE IF NOT EXISTS metodo_pago (
  cod_metodo_pago   SERIAL PRIMARY KEY,
  descp_metodo_pago VARCHAR(60) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS condicion_pago (
  cod_cond_pago   SERIAL PRIMARY KEY,
  descp_cond_pago VARCHAR(80) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS estado_pago (
  cod_estado_pago     SERIAL PRIMARY KEY,
  nombre_estado_pago  VARCHAR(40) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS tipo_comprobante (
  cod_tipo_comprobante  SERIAL PRIMARY KEY,
  descp_tipo_comprobante VARCHAR(40) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS estado_producto_venta (
  cod_estado_prodv   SERIAL PRIMARY KEY,
  descp_estado_prodv VARCHAR(60) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS estado_reclamo (
  cod_estado_reclamo   SERIAL PRIMARY KEY,
  descp_estado_reclamo VARCHAR(60) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS motivo_anulacion (
  cod_motivo_anulacion   SERIAL PRIMARY KEY,
  descp_motivo_anulacion VARCHAR(120) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS motivo_devolucion (
  cod_motivo_devolucion   SERIAL PRIMARY KEY,
  descp_motivo_devolucion VARCHAR(120) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS motivo_cambio_prod (
  cod_motivo_cambio_prod   SERIAL PRIMARY KEY,
  descp_motivo_cambio_prod VARCHAR(120) NOT NULL UNIQUE
);

-- ===========================
--         CLIENTES
-- ===========================
CREATE TABLE IF NOT EXISTS cliente (
  cod_cliente               SERIAL PRIMARY KEY,
  fecha_registro_cliente    TIMESTAMP NOT NULL DEFAULT now(),
  ultima_actividad_cliente  TIMESTAMP
);

CREATE TABLE IF NOT EXISTS maestro (
  cod_maestro               SERIAL PRIMARY KEY,
  cod_cliente               INTEGER NOT NULL REFERENCES cliente(cod_cliente),
  fecha_registro_maestro    TIMESTAMP NOT NULL DEFAULT now(),
  ultima_actividad_maestro  TIMESTAMP
);

CREATE TABLE IF NOT EXISTS usuario (
  cod_usuario              SERIAL PRIMARY KEY,
  fecha_registro_usuario   TIMESTAMP NOT NULL DEFAULT now()
);

-- ===========================
--           VENTAS
-- ===========================
CREATE TABLE IF NOT EXISTS vendedor (
  cod_vendedor            SERIAL PRIMARY KEY,
  nombre_vendedor         VARCHAR(200) NOT NULL UNIQUE,
  fecha_ingreso_vendedor  DATE NOT NULL,
  total_ventas_vendedor   INT NOT NULL DEFAULT 0
);

CREATE TABLE IF NOT EXISTS caja (
  cod_caja             SERIAL PRIMARY KEY,
  fecha_hora_apertura  TIMESTAMP NOT NULL,
  fecha_hora_cierre    TIMESTAMP,
  vendedor_apertura    INTEGER REFERENCES vendedor(cod_vendedor),
  vendedor_cierre      INTEGER REFERENCES vendedor(cod_vendedor),
  monto_apertura       NUMERIC(12,2) NOT NULL DEFAULT 0,
  monto_cierre         NUMERIC(12,2),
  monto_total_ingresos NUMERIC(12,2) NOT NULL DEFAULT 0
);

CREATE TABLE IF NOT EXISTS comprobante (
  cod_comprobante      SERIAL PRIMARY KEY,
  cod_tipo_comprobante INTEGER NOT NULL REFERENCES tipo_comprobante(cod_tipo_comprobante),
  nro_comprobante      VARCHAR(40),
  fecha_emision        TIMESTAMP NOT NULL DEFAULT now(),
  CONSTRAINT uq_tipo_nro UNIQUE (cod_tipo_comprobante, nro_comprobante)
);

CREATE TABLE IF NOT EXISTS producto (
  cod_producto     SERIAL PRIMARY KEY,
  nombre_producto  VARCHAR(200) NOT NULL UNIQUE,
  unidad_medida    VARCHAR(30)  NOT NULL,
  puntos_producto  INTEGER NOT NULL CHECK (puntos_producto >= 0),
  precio_venta     NUMERIC(12,2) NOT NULL CHECK (precio_venta  >= 0)
);

CREATE TABLE IF NOT EXISTS venta (
  cod_venta         SERIAL PRIMARY KEY,
  fecha_hora_venta  TIMESTAMP NOT NULL DEFAULT now(),
  monto_venta       NUMERIC(12,2) NOT NULL DEFAULT 0 CHECK (monto_venta >= 0),
  descuento         NUMERIC(12,2) NOT NULL DEFAULT 0 CHECK (descuento >= 0),
  igv               NUMERIC(12,2) NOT NULL DEFAULT 0 CHECK (igv >= 0),
  cod_estado_venta  INTEGER NOT NULL REFERENCES estado_venta(cod_estado_venta),
  cod_cond_pago    INTEGER NOT NULL REFERENCES condicion_pago(cod_cond_pago),
  nro_cuotas        INTEGER NOT NULL DEFAULT 1 CHECK (nro_cuotas >=1),
  cod_cliente       INTEGER NOT NULL REFERENCES cliente(cod_cliente),
  cod_vendedor      INTEGER NOT NULL REFERENCES vendedor(cod_vendedor)
);

CREATE TABLE IF NOT EXISTS producto_venta (
  cod_venta          INTEGER NOT NULL REFERENCES venta(cod_venta),
  cod_producto       INTEGER NOT NULL REFERENCES producto(cod_producto),
  cantidad_producto  INTEGER NOT NULL CHECK (cantidad_producto > 0),
  precio_unitario    NUMERIC(14,2) NOT NULL CHECK (precio_unitario >= 0),
  descuento_unitario NUMERIC(14,2) NOT NULL DEFAULT 0 CHECK (descuento_unitario >= 0),
  monto_unitario     NUMERIC(14,2) NOT NULL CHECK (monto_unitario = cantidad_producto*precio_unitario - descuento_unitario),
  cod_estado_prodv   INTEGER REFERENCES estado_producto_venta(cod_estado_prodv),
  direccion_entrega  VARCHAR(200),
  fecha_entrega		 DATE,
  CONSTRAINT uq_item UNIQUE (cod_venta, cod_producto)
);

CREATE TABLE IF NOT EXISTS pago (
  cod_venta              INTEGER NOT NULL REFERENCES venta(cod_venta),
  nro_cuota              INTEGER NOT NULL,
  monto_pago             NUMERIC(14,2) NOT NULL CHECK (monto_pago >= 0),
  fecha_vencimiento_pago DATE,
  fecha_pago             TIMESTAMP,
  nombre_pagador         VARCHAR(200),
  nro_telf_pagador       VARCHAR(20),
  cod_caja               INTEGER REFERENCES caja(cod_caja),
  cod_comprobante        INTEGER NOT NULL REFERENCES comprobante(cod_comprobante),
  cod_estado_pago        INTEGER NOT NULL REFERENCES estado_pago(cod_estado_pago),
  cod_metodo_pago        INTEGER NOT NULL REFERENCES metodo_pago(cod_metodo_pago),
  PRIMARY KEY (cod_venta, nro_cuota)
);

-- ===========================
--   RECLAMOS / POSTVENTA
-- ===========================
CREATE TABLE IF NOT EXISTS reclamo (
  cod_reclamo         SERIAL PRIMARY KEY,
  cod_venta           INTEGER NOT NULL REFERENCES venta(cod_venta),
  cod_cliente         INTEGER NOT NULL REFERENCES cliente(cod_cliente),
  cod_estado_reclamo  INTEGER NOT NULL REFERENCES estado_reclamo(cod_estado_reclamo),
  fecha_hora_reclamo  TIMESTAMP NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS anulacion (
  cod_anulacion         SERIAL PRIMARY KEY,
  cod_reclamo           INTEGER NOT NULL REFERENCES reclamo(cod_reclamo),
  fecha_hora_anulacion  TIMESTAMP NOT NULL DEFAULT now(),
  cod_motivo_anulacion  INTEGER NOT NULL REFERENCES motivo_anulacion(cod_motivo_anulacion),
  descp_anulacion       VARCHAR(50)	
);

CREATE TABLE IF NOT EXISTS devolucion (
  cod_devolucion         SERIAL PRIMARY KEY,
  cod_reclamo            INTEGER NOT NULL REFERENCES reclamo(cod_reclamo),
  fecha_hora_devolucion  TIMESTAMP NOT NULL DEFAULT now(),
  monto_devolucion       NUMERIC(14,2) NOT NULL DEFAULT 0 CHECK (monto_devolucion >= 0),
  cod_motivo_devolucion  INTEGER NOT NULL REFERENCES motivo_devolucion(cod_motivo_devolucion),
  cod_caja               INTEGER REFERENCES caja(cod_caja),
  producto_devuelto      INTEGER REFERENCES producto(cod_producto),
  descp_devolucion       VARCHAR(50)		
);

CREATE TABLE IF NOT EXISTS cambio_producto (
  cod_cambio_prod        SERIAL PRIMARY KEY,
  cod_reclamo            INTEGER NOT NULL REFERENCES reclamo(cod_reclamo),
  producto_retorna       INTEGER NOT NULL REFERENCES producto(cod_producto),
  producto_entrega       INTEGER NOT NULL REFERENCES producto(cod_producto),
  diferencia_cambio      NUMERIC(14,2) NOT NULL DEFAULT 0,
  cod_motivo_cambio_prod INTEGER NOT NULL REFERENCES motivo_cambio_prod(cod_motivo_cambio_prod),
  cod_caja               INTEGER REFERENCES caja(cod_caja),
  descp_cambio           VARCHAR(50)
);

