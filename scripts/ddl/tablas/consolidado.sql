DROP SCHEMA IF EXISTS "FERRETERIA" CASCADE;
CREATE SCHEMA "FERRETERIA";
SET search_path TO "FERRETERIA";


-- -------------------------------------------------------------
-- 1) LOOKUPS del módulo (nuevos y sin colisiones)
-- -------------------------------------------------------------
-- Categoria de productos (evita choque con CATEGORIA existente)
CREATE TABLE IF NOT EXISTS categoria_producto (
  cod_categoria_producto SERIAL PRIMARY KEY,
  rubro   VARCHAR(50) NOT NULL,
  familia VARCHAR(50) NOT NULL,
  clase   VARCHAR(50) NOT NULL,
  UNIQUE (rubro, familia, clase),
  CONSTRAINT chk_catp_rubro   CHECK (btrim(rubro) <> ''),
  CONSTRAINT chk_catp_familia CHECK (btrim(familia) <> ''),
  CONSTRAINT chk_catp_clase   CHECK (btrim(clase) <> '')
);

-- Estado del pedido de transporte
CREATE TABLE IF NOT EXISTS estado_pedido_tr (
  cod_estado_pedido_tr SERIAL PRIMARY KEY,
  descp_estado_pedido_tr VARCHAR(50) NOT NULL UNIQUE
);



--TIPO_PERSONA
CREATE TABLE TIPO_PERSONA
(
  cod_tipo_persona SERIAL NOT NULL,
  valor_tipo_persona VARCHAR(30) NOT NULL UNIQUE,
  PRIMARY KEY (cod_tipo_persona),
  CONSTRAINT chk_valor_tipo_persona CHECK (btrim(valor_tipo_persona) <> '')
);

--PERSONA
CREATE TABLE PERSONA
(
  cod_persona SERIAL NOT NULL,
  fecha_registro_persona TIMESTAMP NOT NULL DEFAULT NOW(),
  nombre_persona VARCHAR(50) NOT NULL,
  cod_tipo_persona SERIAL NOT NULL,
  PRIMARY KEY (cod_persona),
  FOREIGN KEY (cod_tipo_persona) REFERENCES TIPO_PERSONA(cod_tipo_persona),
  CONSTRAINT chk_nombre_persona CHECK (btrim(nombre_persona) <> '')
);

--CLIENTE
CREATE TABLE CLIENTE
(
  cod_cliente SERIAL NOT NULL,
  fecha_registro_cliente TIMESTAMP NOT NULL DEFAULT NOW(),
  ultima_actividad_cliente TIMESTAMP NOT NULL DEFAULT NOW(),
  cod_persona SERIAL NOT NULL,
  PRIMARY KEY (cod_cliente),
  FOREIGN KEY (cod_persona) REFERENCES PERSONA(cod_persona),
  UNIQUE (cod_persona)
);

--TIPO_CONTACTO
CREATE TABLE TIPO_CONTACTO
(
  cod_tipo_contacto SERIAL NOT NULL,
  valor_tipo_contacto VARCHAR(30) NOT NULL UNIQUE,
  PRIMARY KEY (cod_tipo_contacto),
  CONSTRAINT chk_valor_tipo_contacto CHECK (btrim(valor_tipo_contacto) <> '')
);

--CONTACTO
CREATE TABLE CONTACTO
(
  cod_contacto SERIAL NOT NULL,
  valor_contacto VARCHAR(50) NOT NULL,
  cod_tipo_contacto SERIAL NOT NULL,
  PRIMARY KEY (cod_contacto),
  FOREIGN KEY (cod_tipo_contacto) REFERENCES TIPO_CONTACTO(cod_tipo_contacto),
  CONSTRAINT chk_valor_contacto CHECK (btrim(valor_contacto) <> '')
);

--DIRECCION
CREATE TABLE DIRECCION
(
  cod_direccion SERIAL NOT NULL,
  ciudad VARCHAR(50) NOT NULL,
  distrito VARCHAR(50) NOT NULL,
  via VARCHAR(50) NOT NULL,
  numero VARCHAR(50) NOT NULL,
  PRIMARY KEY (cod_direccion),
  CONSTRAINT chk_ciudad CHECK (btrim(ciudad) <> ''),
  CONSTRAINT chk_distrito CHECK (btrim(distrito) <> ''),
  CONSTRAINT chk_via CHECK (btrim(via) <> ''),
  CONSTRAINT chk_numero CHECK (btrim(numero) <> '')
);

--TIPO_DOCUMENTO
CREATE TABLE TIPO_DOCUMENTO
(
  cod_tipo_documento SERIAL NOT NULL,
  valor_tipo_documento VARCHAR(30) NOT NULL UNIQUE,	
  PRIMARY KEY (cod_tipo_documento),
  CONSTRAINT chk_valor_tipo_documento CHECK (btrim(valor_tipo_documento) <> '')
);

--DOCUMENTO_PERSONA
CREATE TABLE DOCUMENTO_PERSONA
(
  valor_documento VARCHAR(50) NOT NULL,
  cod_persona INTEGER NOT NULL,
  cod_tipo_documento INTEGER NOT NULL,
  principal_documento BOOLEAN,
  PRIMARY KEY (cod_persona, cod_tipo_documento),
  UNIQUE (principal_documento, cod_persona),
  FOREIGN KEY (cod_persona) REFERENCES PERSONA(cod_persona),
  FOREIGN KEY (cod_tipo_documento) REFERENCES TIPO_DOCUMENTO(cod_tipo_documento),
  CONSTRAINT chk_valor_documento CHECK (btrim(valor_documento) <> '')
);

--DIRECCION_PERSONA
CREATE TABLE DIRECCION_PERSONA
(
  cod_direccion INTEGER NOT NULL,
  cod_persona INTEGER NOT NULL,
  principal_direccion BOOLEAN,
  PRIMARY KEY (cod_direccion, cod_persona),
  UNIQUE (principal_direccion, cod_persona),
  FOREIGN KEY (cod_direccion) REFERENCES DIRECCION(cod_direccion),
  FOREIGN KEY (cod_persona) REFERENCES PERSONA(cod_persona)
);

--CONTACTO_PERSONA
CREATE TABLE CONTACTO_PERSONA
(
  cod_contacto INTEGER NOT NULL,
  cod_persona INTEGER NOT NULL,
  principal_contacto INTEGER,
  PRIMARY KEY (cod_contacto, cod_persona),
  UNIQUE (principal_contacto, cod_persona),
  FOREIGN KEY (cod_contacto) REFERENCES CONTACTO(cod_contacto),
  FOREIGN KEY (cod_persona) REFERENCES PERSONA(cod_persona),
  FOREIGN KEY (principal_contacto) REFERENCES TIPO_CONTACTO (cod_tipo_contacto)
);


--ESPECIALIDADES
CREATE TABLE ESPECIALIDADES
(
  cod_especialidad SERIAL NOT NULL,
  valor_especialidad VARCHAR NOT NULL UNIQUE,
  PRIMARY KEY (cod_especialidad),
  CONSTRAINT chk_valor_especialidad CHECK (btrim(valor_especialidad) <> '')
);

--MAESTRO
CREATE TABLE MAESTRO
(
  cod_maestro SERIAL NOT NULL,
  ruc VARCHAR(15) NOT NULL UNIQUE ,
  puntos_maestro NUMERIC(10,2) NOT NULL DEFAULT 0,
  fecha_registro_maestro TIMESTAMP NOT NULL DEFAULT NOW(),
  ultima_actividad_maestro TIMESTAMP NOT NULL DEFAULT NOW(),
  cod_cliente INTEGER NOT NULL,
  cod_persona INTEGER NOT NULL,
  cod_especialidad INTEGER NOT NULL,
  PRIMARY KEY (cod_maestro),
  FOREIGN KEY (cod_cliente) REFERENCES CLIENTE(cod_cliente),
  FOREIGN KEY (cod_persona) REFERENCES CLIENTE(cod_persona),
  FOREIGN KEY (cod_especialidad) REFERENCES ESPECIALIDADES(cod_especialidad),
  UNIQUE (cod_cliente),
  UNIQUE (cod_persona)
);

--ROL
CREATE TABLE ROL
(
  cod_rol SERIAL NOT NULL,
  valor_rol VARCHAR(30) NOT NULL UNIQUE ,
  PRIMARY KEY (cod_rol),
  CONSTRAINT chk_valor_rol CHECK (btrim(valor_rol) <> '')
);

--AREA
CREATE TABLE AREA
(
  cod_area SERIAL NOT NULL,
  valor_area VARCHAR(30) NOT NULL UNIQUE,
  PRIMARY KEY (cod_area),
  CONSTRAINT chk_valor_area CHECK (btrim(valor_area) <> '')
);

--USUARIO
CREATE TABLE USUARIO
(
  cod_usuario SERIAL NOT NULL,
  fecha_registro_usuario TIMESTAMP NOT NULL DEFAULT NOW(),
  cod_rol INTEGER NOT NULL,
  cod_area INTEGER NOT NULL,
  cod_persona INTEGER NOT NULL,
  PRIMARY KEY (cod_usuario),
  FOREIGN KEY (cod_rol) REFERENCES ROL(cod_rol),
  FOREIGN KEY (cod_area) REFERENCES AREA(cod_area),
  FOREIGN KEY (cod_persona) REFERENCES PERSONA(cod_persona)
);

--CATEGORIA
CREATE TABLE CATEGORIA
(
  cod_categoria SERIAL NOT NULL,
  valor_categoria VARCHAR(50) NOT NULL,
  PRIMARY KEY (cod_categoria),
  CONSTRAINT chk_valor_categoria CHECK (btrim(valor_categoria) <> '')
);



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
--           VENTAS
-- ===========================
CREATE TABLE IF NOT EXISTS vendedor (
  cod_vendedor            SERIAL PRIMARY KEY,
  cod_usuario             INTEGER NOT NULL REFERENCES usuario(cod_usuario),
  fecha_ingreso_vendedor  DATE NOT NULL DEFAULT NOW(),
  total_ventas_vendedor   INT NOT NULL DEFAULT 0
);

CREATE TABLE IF NOT EXISTS caja (
  cod_caja             SERIAL PRIMARY KEY,
  fecha_hora_apertura  TIMESTAMP NOT NULL,
  fecha_hora_cierre    TIMESTAMP,
  vendedor_apertura    INTEGER REFERENCES vendedor(cod_vendedor),
  vendedor_cierre      INTEGER REFERENCES vendedor(cod_vendedor),
  monto_apertura       NUMERIC(14,2) NOT NULL DEFAULT 0,
  monto_cierre         NUMERIC(14,2),
  monto_total_ingresos NUMERIC(14,2) NOT NULL DEFAULT 0
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
  precio_venta     NUMERIC(14,2) NOT NULL CHECK (precio_venta  >= 0),
  cod_categoria_producto INTEGER NOT NULL ,
  marca VARCHAR(50),
  precio_base NUMERIC(14,2) NOT NULL,
  peso_producto NUMERIC(12,3) NOT NULL,
  FOREIGN KEY (cod_categoria_producto) REFERENCES categoria_producto(cod_categoria_producto)
);

CREATE TABLE IF NOT EXISTS venta (
  cod_venta         SERIAL PRIMARY KEY,
  fecha_hora_venta  TIMESTAMP NOT NULL DEFAULT now(),
  monto_venta       NUMERIC(14,2) NOT NULL DEFAULT 0 CHECK (monto_venta >= 0),
  descuento         NUMERIC(14,2) NOT NULL DEFAULT 0 CHECK (descuento >= 0),
  igv               NUMERIC(14,2) NOT NULL DEFAULT 0 CHECK (igv >= 0),
  cod_estado_venta  INTEGER NOT NULL REFERENCES estado_venta(cod_estado_venta),
  cod_cond_pago     INTEGER NOT NULL REFERENCES condicion_pago(cod_cond_pago),
  nro_cuotas        INTEGER NOT NULL DEFAULT 1 CHECK (nro_cuotas >=1),
  cod_cliente       INTEGER NOT NULL REFERENCES cliente(cod_cliente),
  cod_vendedor      INTEGER NOT NULL REFERENCES vendedor(cod_vendedor),
  cod_maestro		INTEGER REFERENCES maestro(cod_maestro),
  puntos_venta      NUMERIC(14,2)
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




--ESTADO_CANJE
CREATE TABLE ESTADO_CANJE
(
  cod_estado_canje SERIAL NOT NULL,
  valor_estado_canje VARCHAR(30) NOT NULL,
  PRIMARY KEY (cod_estado_canje),
  CONSTRAINT chk_valor_estado_canje CHECK (btrim(valor_estado_canje) <> '')
);

--CANJE
CREATE TABLE CANJE
(
  cod_canje SERIAL NOT NULL,
  fecha_hora_canje TIMESTAMP NOT NULL DEFAULT NOW(),
  monto_canje NUMERIC(14,2) NOT NULL,
  fecha_entrega TIMESTAMP,
  cod_usuario INTEGER NOT NULL,
  cod_estado_canje INTEGER NOT NULL,
  cod_maestro INTEGER NOT NULL,
  PRIMARY KEY (cod_canje),
  FOREIGN KEY (cod_usuario) REFERENCES USUARIO(cod_usuario),
  FOREIGN KEY (cod_estado_canje) REFERENCES ESTADO_CANJE(cod_estado_canje),
  FOREIGN KEY (cod_maestro) REFERENCES MAESTRO(cod_maestro),
  CONSTRAINT chk_monto_canje_positivo CHECK (monto_canje > 0),
  CONSTRAINT chk_fecha_entrega_valida CHECK (fecha_entrega IS NULL OR fecha_entrega >= fecha_hora_canje)
);

--PREMIOS
CREATE TABLE PREMIOS
(
  cod_premio SERIAL NOT NULL,
  nombre_premio VARCHAR(100) NOT NULL UNIQUE,
  descp_premio VARCHAR(500) NOT NULL,
  puntos_premio NUMERIC(10,2) NOT NULL CHECK (puntos_premio >= 0),
  disponibilidad_premio INT NOT NULL DEFAULT 0 CHECK (disponibilidad_premio >= 0),
  PRIMARY KEY (cod_premio),
  CONSTRAINT chk_nombre_premio CHECK (btrim(nombre_premio) <> '')
);

--DETALLE_CANJE
CREATE TABLE DETALLE_CANJE
(
  cantidad_premio INT NOT NULL CHECK (cantidad_premio >= 0),
  cod_canje INTEGER NOT NULL,
  cod_premio INTEGER NOT NULL,
  PRIMARY KEY (cod_canje, cod_premio),
  FOREIGN KEY (cod_canje) REFERENCES CANJE(cod_canje),
  FOREIGN KEY (cod_premio) REFERENCES PREMIOS(cod_premio)
);

--CATEGORIAS_PREMIO
CREATE TABLE CATEGORIAS_PREMIO
(
  cod_categoria INTEGER NOT NULL,
  cod_premio INTEGER NOT NULL,
  PRIMARY KEY (cod_categoria, cod_premio),
  FOREIGN KEY (cod_categoria) REFERENCES CATEGORIA(cod_categoria),
  FOREIGN KEY (cod_premio) REFERENCES PREMIOS(cod_premio)
);

--REPORTE
CREATE TABLE REPORTE
(
  cod_reporte SERIAL NOT NULL,
  fecha_creacion_reporte TIMESTAMP NOT NULL DEFAULT NOW(),
  fecha_fin_periodo TIMESTAMP NOT NULL DEFAULT NOW(),
  periodo_reporte INTERVAL NOT NULL,
  PRIMARY KEY (cod_reporte)
);

--CANJE_CONSULTADO
CREATE TABLE CANJE_CONSULTADO
(
  cod_reporte INTEGER NOT NULL,
  cod_canje INTEGER NOT NULL,
  PRIMARY KEY (cod_reporte, cod_canje),
  FOREIGN KEY (cod_reporte) REFERENCES REPORTE(cod_reporte),
  FOREIGN KEY (cod_canje) REFERENCES CANJE(cod_canje)
);

--CLIENTE_CONSULTADO
CREATE TABLE CLIENTE_CONSULTADO
(
  cod_reporte INTEGER NOT NULL,
  cod_cliente INTEGER NOT NULL,
  PRIMARY KEY (cod_reporte, cod_cliente),
  FOREIGN KEY (cod_reporte) REFERENCES REPORTE(cod_reporte),
  FOREIGN KEY (cod_cliente) REFERENCES CLIENTE(cod_cliente)
);

--MAESTRO_CONSULTADO
CREATE TABLE MAESTRO_CONSULTADO
(
  cod_reporte INTEGER NOT NULL,
  cod_maestro INTEGER NOT NULL,
  PRIMARY KEY (cod_reporte, cod_maestro),
  FOREIGN KEY (cod_reporte) REFERENCES REPORTE(cod_reporte),
  FOREIGN KEY (cod_maestro) REFERENCES MAESTRO(cod_maestro)
);



-- -------------------------------------------------------------
-- 3) ENTIDADES del módulo (nuevas)
-- -------------------------------------------------------------
-- Instalación (según tu diagrama)
CREATE TABLE IF NOT EXISTS instalacion (
  cod_instalacion VARCHAR(10) PRIMARY KEY,
  nombre_instalacion VARCHAR(100) NOT NULL UNIQUE,
  direccion TEXT
);

-- Proveedor
CREATE TABLE IF NOT EXISTS proveedor (
  cod_proveedor SERIAL PRIMARY KEY,
  nombre_comercial VARCHAR(100) NOT NULL,
  razon_social     VARCHAR(150) NOT NULL,
  ruc              VARCHAR(11)  NOT NULL UNIQUE,
  CONSTRAINT chk_prov_nomcom CHECK (btrim(nombre_comercial) <> ''),
  CONSTRAINT chk_prov_razon  CHECK (btrim(razon_social) <> ''),
  CONSTRAINT chk_prov_ruc    CHECK (ruc ~ '^[0-9]{11}$')
);

-- Producto ofrecido por proveedor (N:M) con precio de referencia
CREATE TABLE IF NOT EXISTS producto_proveedor (
  cod_producto  INTEGER NOT NULL REFERENCES producto(cod_producto) ON UPDATE CASCADE ON DELETE CASCADE,
  cod_proveedor INTEGER NOT NULL REFERENCES proveedor(cod_proveedor) ON UPDATE CASCADE ON DELETE CASCADE,
  precio_unitario_ref NUMERIC(14,2) NOT NULL,
  PRIMARY KEY (cod_producto, cod_proveedor),
  CONSTRAINT chk_pp_precio_pos CHECK (precio_unitario_ref >= 0)
);

-- Solicitud de cotización
CREATE TABLE IF NOT EXISTS solicitud_cotizacion (
  cod_solicitud SERIAL PRIMARY KEY,
  cod_usuario INTEGER NOT NULL REFERENCES usuario(cod_usuario) ON UPDATE CASCADE ON DELETE RESTRICT,
  fecha_emision DATE NOT NULL DEFAULT CURRENT_DATE,
  estado VARCHAR(20) NOT NULL DEFAULT 'Pendiente',
  CONSTRAINT chk_sc_estado CHECK (estado IN ('Pendiente','Cotizada','Adjudicada','Cerrada'))
);

-- Cotización
CREATE TABLE IF NOT EXISTS cotizacion (
  cod_cotizacion SERIAL PRIMARY KEY,
  cod_solicitud  INTEGER NOT NULL REFERENCES solicitud_cotizacion(cod_solicitud) ON UPDATE CASCADE ON DELETE RESTRICT,
  cod_proveedor  INTEGER NOT NULL REFERENCES proveedor(cod_proveedor) ON UPDATE CASCADE ON DELETE RESTRICT,
  fecha_emision_cotizacion DATE NOT NULL,
  fecha_garantia DATE NOT NULL,
  monto_total    NUMERIC(14,2) NOT NULL,
  plazo_entrega  INTEGER NOT NULL,
  CONSTRAINT chk_cot_monto  CHECK (monto_total >= 0),
  CONSTRAINT chk_cot_plazo  CHECK (plazo_entrega >= 0),
  CONSTRAINT chk_cot_fechas CHECK (fecha_garantia >= fecha_emision_cotizacion)
);

-- Orden de compra
CREATE TABLE IF NOT EXISTS orden_compra (
  cod_orden SERIAL PRIMARY KEY,
  cod_cotizacion INTEGER NOT NULL REFERENCES cotizacion(cod_cotizacion) ON UPDATE CASCADE ON DELETE RESTRICT,
  fecha_emision DATE NOT NULL DEFAULT CURRENT_DATE,
  monto NUMERIC(14,2) NOT NULL,
  modalidad_pago VARCHAR(20) NOT NULL,
  estado VARCHAR(20) NOT NULL DEFAULT 'Emitida',
  CONSTRAINT chk_oc_monto CHECK (monto >= 0),
  CONSTRAINT chk_oc_modalidad CHECK (modalidad_pago IN ('Contado','Crédito')),
  CONSTRAINT chk_oc_estado CHECK (estado IN ('Emitida','En Proceso','Programada','Cerrada','Anulada'))
);

-- Monitoreo de compra (1:1 con orden_compra)
CREATE TABLE IF NOT EXISTS monitoreo_compra (
  cod_monitoreo SERIAL PRIMARY KEY,
  cod_orden INTEGER NOT NULL UNIQUE REFERENCES orden_compra(cod_orden) ON UPDATE CASCADE ON DELETE RESTRICT,
  fecha_entrega DATE NOT NULL,
  hora_entrega  TIME,
  estado VARCHAR(20) NOT NULL DEFAULT 'En Proceso',
  CONSTRAINT chk_mon_estado CHECK (estado IN ('En Proceso','En Ruta','Entregado'))
);

-- Pedido de abastecimiento (ahora con usuario)
CREATE TABLE IF NOT EXISTS pedido_abastecimiento (
  cod_pedido SERIAL PRIMARY KEY,
  cod_usuario INTEGER NOT NULL REFERENCES usuario(cod_usuario) ON UPDATE CASCADE ON DELETE RESTRICT,
  fecha_pedido DATE NOT NULL DEFAULT CURRENT_DATE,
  hora_pedido  TIME NOT NULL DEFAULT CURRENT_TIME,
  estado_pedido VARCHAR(20) NOT NULL DEFAULT 'Pendiente',
  CONSTRAINT chk_ped_estado CHECK (estado_pedido IN ('Pendiente','Revisado','En Proceso','Atendido','Cancelado'))
);

-- Recepción (con instalación y usuario)
CREATE TABLE IF NOT EXISTS recepcion (
  cod_recepcion SERIAL PRIMARY KEY,
  cod_orden INTEGER NOT NULL REFERENCES orden_compra(cod_orden) ON UPDATE CASCADE ON DELETE RESTRICT,
  cod_instalacion VARCHAR(10) NOT NULL REFERENCES instalacion(cod_instalacion) ON UPDATE CASCADE ON DELETE RESTRICT,
  fecha_recepcion DATE NOT NULL DEFAULT CURRENT_DATE,
  hora_inicio_recepcion TIME NOT NULL,
  hora_fin_recepcion    TIME NOT NULL,
  fecha_programada DATE NOT NULL,
  hora_programada  TIME NOT NULL,
  cod_usuario INTEGER NOT NULL REFERENCES usuario(cod_usuario) ON UPDATE CASCADE ON DELETE RESTRICT,
  observacion VARCHAR(255),
  estado_recepcion VARCHAR(20) NOT NULL DEFAULT 'Programada',
  CONSTRAINT chk_rec_estado CHECK (estado_recepcion IN ('Programada','En Curso','Finalizada','Con Reclamo')),
  CONSTRAINT chk_rec_horas  CHECK (hora_fin_recepcion >= hora_inicio_recepcion)
);

-- Guía de remisión externa
CREATE TABLE IF NOT EXISTS guia_remision_externa (
  serie_correlativo VARCHAR(20) PRIMARY KEY,
  cod_recepcion INTEGER NOT NULL REFERENCES recepcion(cod_recepcion) ON UPDATE CASCADE ON DELETE RESTRICT,
  fecha_emision_guia   DATE NOT NULL,
  fecha_traslado_guia  DATE NOT NULL,
  CONSTRAINT chk_gre_serie  CHECK (btrim(serie_correlativo) <> ''),
  CONSTRAINT chk_gre_fechas CHECK (fecha_traslado_guia >= fecha_emision_guia)
);

-- Pedido de transporte (según imagen)
CREATE TABLE IF NOT EXISTS pedido_transporte (
  cod_pedido_transporte SERIAL PRIMARY KEY,
  fecha_pedido_transporte DATE NOT NULL DEFAULT CURRENT_DATE,
  cod_recepcion INTEGER NOT NULL REFERENCES recepcion(cod_recepcion) ON UPDATE CASCADE ON DELETE RESTRICT,
  cod_estado_pedido_tr INTEGER NOT NULL DEFAULT 1 REFERENCES estado_pedido_tr(cod_estado_pedido_tr) ON UPDATE CASCADE ON DELETE RESTRICT,
  cod_cliente  INTEGER NOT NULL,    -- cuando definas CLIENTE (en compras), promuévelo a FK
  cod_usuario INTEGER NOT NULL,     -- idem si gestionas empleados internos
  FOREIGN KEY (cod_usuario) REFERENCES USUARIO(cod_usuario)
);

-- -------------------------------------------------------------
-- 4) DETALLES / INTERMEDIAS
-- -------------------------------------------------------------
CREATE TABLE IF NOT EXISTS detalle_solicitud (
  cod_solicitud INTEGER NOT NULL REFERENCES solicitud_cotizacion(cod_solicitud) ON UPDATE CASCADE ON DELETE CASCADE,
  cod_producto  INTEGER NOT NULL REFERENCES producto(cod_producto) ON UPDATE CASCADE ON DELETE RESTRICT,
  cantidad_solicitada INTEGER NOT NULL,
  PRIMARY KEY (cod_solicitud, cod_producto),
  CONSTRAINT chk_ds_cant_pos CHECK (cantidad_solicitada > 0)
);

CREATE TABLE IF NOT EXISTS detalle_cotizacion (
  cod_cotizacion INTEGER NOT NULL REFERENCES cotizacion(cod_cotizacion) ON UPDATE CASCADE ON DELETE CASCADE,
  cod_producto   INTEGER NOT NULL REFERENCES producto(cod_producto) ON UPDATE CASCADE ON DELETE RESTRICT,
  costo_total NUMERIC(14,2) NOT NULL,
  modalidad_pago VARCHAR(20) NOT NULL,
  PRIMARY KEY (cod_cotizacion, cod_producto),
  CONSTRAINT chk_dc_monto_pos CHECK (costo_total >= 0),
  CONSTRAINT chk_dc_modalidad CHECK (modalidad_pago IN ('Contado','Crédito'))
);

CREATE TABLE IF NOT EXISTS detalle_oc (
  cod_orden   INTEGER NOT NULL REFERENCES orden_compra(cod_orden) ON UPDATE CASCADE ON DELETE CASCADE,
  cod_producto INTEGER NOT NULL REFERENCES producto(cod_producto) ON UPDATE CASCADE ON DELETE RESTRICT,
  cantidad_comprada INTEGER NOT NULL,
  costo_total NUMERIC(14,2) NOT NULL,
  PRIMARY KEY (cod_orden, cod_producto),
  CONSTRAINT chk_doc_cant_pos  CHECK (cantidad_comprada > 0),
  CONSTRAINT chk_doc_costo_pos CHECK (costo_total >= 0)
);

CREATE TABLE IF NOT EXISTS detalle_pedido (
  cod_pedido   INTEGER NOT NULL REFERENCES pedido_abastecimiento(cod_pedido) ON UPDATE CASCADE ON DELETE CASCADE,
  cod_producto INTEGER NOT NULL REFERENCES producto(cod_producto) ON UPDATE CASCADE ON DELETE RESTRICT,
  cantidad_requerida INTEGER NOT NULL,
  fecha_requerida DATE NOT NULL,
  tipo_destino VARCHAR(10) NOT NULL,
  direccion_destino_externo VARCHAR(150),
  estado VARCHAR(20) NOT NULL DEFAULT 'Pendiente',
  PRIMARY KEY (cod_pedido, cod_producto),
  CONSTRAINT chk_dp_cant_pos   CHECK (cantidad_requerida > 0),
  CONSTRAINT chk_dp_tipo_dest  CHECK (tipo_destino IN ('Interno','Externo')),
  CONSTRAINT chk_dp_estado     CHECK (estado IN ('Pendiente','Revisado','En Cotización','Adjudicado','En Camino','Recibido Parcial','Recibido Total','Cancelado'))
);

CREATE TABLE IF NOT EXISTS detalle_recepcion (
  cod_detalle_recepcion SERIAL PRIMARY KEY,
  cod_recepcion INTEGER NOT NULL REFERENCES recepcion(cod_recepcion) ON UPDATE CASCADE ON DELETE CASCADE,
  cod_producto  INTEGER NOT NULL REFERENCES producto(cod_producto)  ON UPDATE CASCADE ON DELETE RESTRICT,
  cantidad_programada INTEGER NOT NULL,
  cantidad_recibida   INTEGER NOT NULL,
  cantidad_conforme   INTEGER NOT NULL,
  cantidad_defectuosa INTEGER NOT NULL,
  UNIQUE (cod_recepcion, cod_producto),
  CONSTRAINT chk_dr_prog_pos CHECK (cantidad_programada > 0),
  CONSTRAINT chk_dr_rec_pos  CHECK (cantidad_recibida  >= 0),
  CONSTRAINT chk_dr_conf_pos CHECK (cantidad_conforme  >= 0),
  CONSTRAINT chk_dr_def_pos  CHECK (cantidad_defectuosa >= 0),
  CONSTRAINT chk_dr_suma CHECK (cantidad_recibida = cantidad_conforme + cantidad_defectuosa)
);

CREATE TABLE IF NOT EXISTS detalle_guia_externa (
  serie_correlativo VARCHAR(20) NOT NULL REFERENCES guia_remision_externa(serie_correlativo) ON UPDATE CASCADE ON DELETE CASCADE,
  cod_producto INTEGER NOT NULL REFERENCES producto(cod_producto) ON UPDATE CASCADE ON DELETE RESTRICT,
  cantidad_guia INTEGER NOT NULL,
  PRIMARY KEY (serie_correlativo, cod_producto),
  CONSTRAINT chk_dge_cant_pos CHECK (cantidad_guia > 0)
);

-- Contacto de proveedor (usa tu lookup TIPO_CONTACTO)
CREATE TABLE IF NOT EXISTS proveedor_contacto (
  cod_proveedor INTEGER NOT NULL REFERENCES proveedor(cod_proveedor) ON UPDATE CASCADE ON DELETE CASCADE,
  cod_tipo_contacto INTEGER NOT NULL REFERENCES tipo_contacto(cod_tipo_contacto) ON UPDATE CASCADE ON DELETE RESTRICT,
  valor_contacto VARCHAR(100) NOT NULL,
  PRIMARY KEY (cod_proveedor, cod_tipo_contacto),
  CONSTRAINT chk_pc_valor CHECK (btrim(valor_contacto) <> '')
);

-- -------------------------------------------------------------
-- 5) ASOCIADAS A RECLAMOS del módulo (sin colisionar con ventas.reclamo)
-- -------------------------------------------------------------
CREATE TABLE IF NOT EXISTS reclamo_abast (
  cod_reclamo SERIAL PRIMARY KEY,
  fecha_reclamo DATE NOT NULL DEFAULT CURRENT_DATE,
  hora_reclamo  TIME NOT NULL DEFAULT CURRENT_TIME,
  observacion_reclamo VARCHAR(255),
  accion_correctiva   VARCHAR(30) NOT NULL,
  estado_reclamo      VARCHAR(20) NOT NULL DEFAULT 'Pendiente',
  CONSTRAINT chk_rab_estado CHECK (estado_reclamo IN ('Pendiente','En Gestión','Resuelto','Rechazado')),
  CONSTRAINT chk_rab_accion CHECK (accion_correctiva IN ('Nota de Crédito','Reemplazo de Producto','Otro'))
);

CREATE TABLE IF NOT EXISTS nota_credito_abast (
  cod_nota_credito SERIAL PRIMARY KEY,
  cod_reclamo INTEGER NOT NULL UNIQUE REFERENCES reclamo_abast(cod_reclamo) ON UPDATE CASCADE ON DELETE RESTRICT,
  fecha_nc DATE NOT NULL,
  motivo_nc VARCHAR(50) NOT NULL,
  monto_nc  NUMERIC(14,2) NOT NULL,
  descripcion_nc VARCHAR(255) NOT NULL,
  CONSTRAINT chk_ncab_monto CHECK (monto_nc > 0)
);

CREATE TABLE IF NOT EXISTS cambio_producto_abast (
  cod_cambio_producto SERIAL PRIMARY KEY,
  cod_reclamo INTEGER NOT NULL REFERENCES reclamo_abast(cod_reclamo) ON UPDATE CASCADE ON DELETE RESTRICT,
  fecha_cambio DATE NOT NULL DEFAULT CURRENT_DATE,
  hora_cambio  TIME NOT NULL DEFAULT CURRENT_TIME,
  motivo_cambio VARCHAR(50) NOT NULL,
  descripcion_cambio VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS incidencia_abast (
  cod_incidencia SERIAL PRIMARY KEY,
  cod_detalle_recepcion INTEGER NOT NULL REFERENCES detalle_recepcion(cod_detalle_recepcion) ON UPDATE CASCADE ON DELETE RESTRICT,
  cod_reclamo INTEGER REFERENCES reclamo_abast(cod_reclamo) ON UPDATE CASCADE ON DELETE SET NULL,
  tipo_incidencia VARCHAR(20) NOT NULL,
  cantidad_incidencia INTEGER NOT NULL,
  descripcion_incidencia VARCHAR(255) NOT NULL,
  CONSTRAINT chk_iab_tipo  CHECK (tipo_incidencia IN ('CALIDAD','CANTIDAD_GUIA','CANTIDAD_FALTANTE','PRODUCTO_INCORRECTO')),
  CONSTRAINT chk_iab_cant  CHECK (cantidad_incidencia > 0)
);