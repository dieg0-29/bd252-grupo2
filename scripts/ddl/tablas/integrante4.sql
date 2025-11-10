-- =============================================================
--  MÓDULO HIJO: MODULO_ABASTECIMIENTO
--  (derivado y coherente con el schema general)
-- =============================================================
DROP SCHEMA IF EXISTS MODULO_ABASTECIMIENTO CASCADE;
CREATE SCHEMA MODULO_ABASTECIMIENTO;
SET search_path TO MODULO_ABASTECIMIENTO;

-- =============================================================
-- 1) LOOKUPS
-- =============================================================
CREATE TABLE IF NOT EXISTS ROL (
  cod_rol_usuario   SERIAL PRIMARY KEY,
  valor_rol_usuario VARCHAR(30) NOT NULL UNIQUE,
  CONSTRAINT chk_valor_rol_usuario CHECK (btrim(valor_rol_usuario) <> '')
);

CREATE TABLE IF NOT EXISTS AREA (
  cod_area_usuario   SERIAL PRIMARY KEY,
  valor_area_usuario VARCHAR(30) NOT NULL UNIQUE,
  CONSTRAINT chk_valor_area_usuario CHECK (btrim(valor_area_usuario) <> '')
);

CREATE TABLE IF NOT EXISTS TIPO_CONTACTO (
  cod_tipo_contacto   SERIAL PRIMARY KEY,
  valor_tipo_contacto VARCHAR(30) NOT NULL UNIQUE,
  CONSTRAINT chk_valor_tipo_contacto CHECK (btrim(valor_tipo_contacto) <> '')
);

CREATE TABLE IF NOT EXISTS ESTADO_PEDIDO_TR (
  cod_estado_pedido_tr    SERIAL PRIMARY KEY,
  descp_estado_pedido_tr  VARCHAR(50) NOT NULL UNIQUE,
  CONSTRAINT chk_descp_estado_pedido_tr CHECK (btrim(descp_estado_pedido_tr) <> '')
);

CREATE TABLE IF NOT EXISTS CATEGORIA (
  cod_categoria   SERIAL PRIMARY KEY,
  rubro           VARCHAR(50) NOT NULL,
  familia         VARCHAR(50) NOT NULL,
  clase           VARCHAR(50) NOT NULL,
  UNIQUE (rubro, familia, clase),
  CONSTRAINT chk_cat_rubro   CHECK (btrim(rubro) <> ''),
  CONSTRAINT chk_cat_familia CHECK (btrim(familia) <> ''),
  CONSTRAINT chk_cat_clase   CHECK (btrim(clase) <> '')
);

-- =============================================================
-- 2) ACTORES BÁSICOS
-- =============================================================
CREATE TABLE IF NOT EXISTS USUARIO (
  cod_usuario             SERIAL PRIMARY KEY,
  fecha_registro_usuario  TIMESTAMP NOT NULL DEFAULT NOW(),
  cod_area_usuario        INTEGER NOT NULL,
  cod_rol_usuario         INTEGER NOT NULL,
  CONSTRAINT FK_USUARIO_cod_rol_usuario
    FOREIGN KEY (cod_rol_usuario) REFERENCES ROL(cod_rol_usuario),
  CONSTRAINT FK_USUARIO_cod_area_usuario
    FOREIGN KEY (cod_area_usuario) REFERENCES AREA(cod_area_usuario)
);

CREATE TABLE IF NOT EXISTS PROVEEDOR (
  cod_proveedor    SERIAL PRIMARY KEY,
  nombre_comercial VARCHAR(100) NOT NULL,
  razon_social     VARCHAR(150) NOT NULL,
  ruc              VARCHAR(11)  NOT NULL UNIQUE,
  CONSTRAINT chk_prov_nomcom CHECK (btrim(nombre_comercial) <> ''),
  CONSTRAINT chk_prov_razon  CHECK (btrim(razon_social) <> ''),
  CONSTRAINT chk_prov_ruc    CHECK (ruc ~ '^[0-9]{11}$')
);

CREATE TABLE IF NOT EXISTS INSTALACION (
  cod_instalacion    VARCHAR(10) PRIMARY KEY,
  nombre_instalacion VARCHAR(100) NOT NULL UNIQUE,
  direccion          TEXT
);

-- =============================================================
-- 3) MAESTROS DE PRODUCTO
-- =============================================================
CREATE TABLE IF NOT EXISTS PRODUCTO (
  cod_producto       SERIAL PRIMARY KEY,
  nombre_producto    VARCHAR(200) NOT NULL UNIQUE,
  cod_categoria      INTEGER NOT NULL,
  marca              VARCHAR(50),
  unidad_medida      VARCHAR(30) NOT NULL,
  precio_base        NUMERIC(12,2) NOT NULL CHECK (precio_base >= 0),
  precio_venta       NUMERIC(12,2) NOT NULL CHECK (precio_venta >= 0),
  peso_producto      NUMERIC(12,3) NOT NULL CHECK (peso_producto >= 0),
  CONSTRAINT FK_PRODUCTO_cod_categoria
    FOREIGN KEY (cod_categoria) REFERENCES CATEGORIA(cod_categoria)
);

CREATE TABLE IF NOT EXISTS PRODUCTO_PROVEEDOR (
  cod_producto        INTEGER NOT NULL,
  cod_proveedor       INTEGER NOT NULL,
  precio_unitario_ref NUMERIC(12,2) NOT NULL CHECK (precio_unitario_ref >= 0),
  PRIMARY KEY (cod_producto, cod_proveedor),
  CONSTRAINT FK_PRODUCTO_PROVEEDOR_cod_producto
    FOREIGN KEY (cod_producto)  REFERENCES PRODUCTO(cod_producto),
  CONSTRAINT FK_PRODUCTO_PROVEEDOR_cod_proveedor
    FOREIGN KEY (cod_proveedor) REFERENCES PROVEEDOR(cod_proveedor)
);

CREATE TABLE IF NOT EXISTS PROVEEDOR_CONTACTO (
  cod_proveedor       INTEGER NOT NULL,
  cod_tipo_contacto   INTEGER NOT NULL,
  valor_contacto      VARCHAR(100) NOT NULL,
  PRIMARY KEY (cod_proveedor, cod_tipo_contacto),
  CONSTRAINT FK_PROVEEDOR_CONTACTO_cod_proveedor
    FOREIGN KEY (cod_proveedor) REFERENCES PROVEEDOR(cod_proveedor),
  CONSTRAINT fk_pc_tipoc
    FOREIGN KEY (cod_tipo_contacto) REFERENCES TIPO_CONTACTO(cod_tipo_contacto),
  CONSTRAINT chk_pc_valor CHECK (btrim(valor_contacto) <> '')
);

-- =============================================================
-- 4) SOLICITUD → COTIZACIÓN → ORDEN DE COMPRA
-- =============================================================
CREATE TABLE IF NOT EXISTS SOLICITUD_COTIZACION (
  cod_solicitud   SERIAL PRIMARY KEY,
  cod_usuario     INTEGER NOT NULL,
  fecha_emision   DATE NOT NULL DEFAULT CURRENT_DATE,
  estado          VARCHAR(20) NOT NULL DEFAULT 'Pendiente',
  CONSTRAINT FK_SOLICITUD_COTIZACION_cod_usuario
    FOREIGN KEY (cod_usuario) REFERENCES USUARIO(cod_usuario),
  CONSTRAINT chk_sc_estado CHECK (estado IN ('Pendiente','Cotizada','Adjudicada','Cerrada'))
);

CREATE TABLE IF NOT EXISTS DETALLE_SOLICITUD (
  cod_producto        INTEGER NOT NULL,
  cod_solicitud       INTEGER NOT NULL,
  cantidad_solicitada INTEGER NOT NULL CHECK (cantidad_solicitada > 0),
  PRIMARY KEY (cod_solicitud, cod_producto),
  CONSTRAINT FK_DETALLE_SOLICITUD_cod_solicitud
    FOREIGN KEY (cod_solicitud) REFERENCES SOLICITUD_COTIZACION(cod_solicitud) ON DELETE CASCADE,
  CONSTRAINT FK_DETALLE_SOLICITUD_cod_producto
    FOREIGN KEY (cod_producto)  REFERENCES PRODUCTO(cod_producto)
);

CREATE TABLE IF NOT EXISTS COTIZACION (
  cod_cotizacion           SERIAL PRIMARY KEY,
  cod_solicitud            INTEGER NOT NULL,
  cod_proveedor            INTEGER NOT NULL,
  fecha_emision_cotizacion DATE NOT NULL,
  fecha_garantia           DATE NOT NULL,
  monto_total              NUMERIC(12,2) NOT NULL CHECK (monto_total >= 0),
  plazo_entrega            INTEGER NOT NULL CHECK (plazo_entrega >= 0),
  CONSTRAINT FK_COTIZACION_cod_solicitud
    FOREIGN KEY (cod_solicitud) REFERENCES SOLICITUD_COTIZACION(cod_solicitud),
  CONSTRAINT FK_COTIZACION_cod_proveedor
    FOREIGN KEY (cod_proveedor) REFERENCES PROVEEDOR(cod_proveedor),
  CONSTRAINT chk_cot_fechas CHECK (fecha_garantia >= fecha_emision_cotizacion)
);

CREATE TABLE IF NOT EXISTS DETALLE_COTIZACION (
  cod_cotizacion    INTEGER NOT NULL,
  cod_producto      INTEGER NOT NULL,
  costo_total       NUMERIC(12,2) NOT NULL CHECK (costo_total >= 0),
  modalidad_pago    VARCHAR(20) NOT NULL,
  PRIMARY KEY (cod_cotizacion, cod_producto),
  CONSTRAINT FK_DETALLE_COTIZACION_cod_cotizacion
    FOREIGN KEY (cod_cotizacion) REFERENCES COTIZACION(cod_cotizacion) ON DELETE CASCADE,
  CONSTRAINT FK_DETALLE_COTIZACION_cod_producto
    FOREIGN KEY (cod_producto)   REFERENCES PRODUCTO(cod_producto),
  CONSTRAINT chk_dc_modalidad CHECK (modalidad_pago IN ('Contado','Crédito'))
);

CREATE TABLE IF NOT EXISTS ORDEN_COMPRA (
  cod_orden         SERIAL PRIMARY KEY,
  cod_cotizacion    INTEGER NOT NULL,
  fecha_emision     DATE NOT NULL DEFAULT CURRENT_DATE,
  monto             NUMERIC(12,2) NOT NULL CHECK (monto >= 0),
  modalidad_pago    VARCHAR(20) NOT NULL,
  estado            VARCHAR(20) NOT NULL DEFAULT 'Emitida',
  CONSTRAINT FK_ORDEN_COMPRA_cod_cotizacion
    FOREIGN KEY (cod_cotizacion) REFERENCES COTIZACION(cod_cotizacion),
  CONSTRAINT chk_oc_modalidad CHECK (modalidad_pago IN ('Contado','Crédito')),
  CONSTRAINT chk_oc_estado    CHECK (estado IN ('Emitida','En Proceso','Programada','Cerrada','Anulada'))
);

CREATE TABLE IF NOT EXISTS DETALLE_OC (
  cod_orden           INTEGER NOT NULL,
  cod_producto        INTEGER NOT NULL,
  cantidad_comprada   INTEGER NOT NULL CHECK (cantidad_comprada > 0),
  costo_total         NUMERIC(12,2) NOT NULL CHECK (costo_total >= 0),
  PRIMARY KEY (cod_orden, cod_producto),
  CONSTRAINT FK_DETALLE_OC_cod_orden
    FOREIGN KEY (cod_orden)    REFERENCES ORDEN_COMPRA(cod_orden) ON DELETE CASCADE,
  CONSTRAINT FK_DETALLE_OC_cod_producto
    FOREIGN KEY (cod_producto) REFERENCES PRODUCTO(cod_producto)
);

-- Seguimiento 1:1 a la OC
CREATE TABLE IF NOT EXISTS MONITOREO_COMPRA (
  cod_monitoreo  SERIAL PRIMARY KEY,
  cod_orden      INTEGER NOT NULL UNIQUE,
  fecha_entrega  DATE NOT NULL,
  hora_entrega   TIME,
  estado         VARCHAR(20) NOT NULL DEFAULT 'En Proceso',
  CONSTRAINT fk_mon_oc FOREIGN KEY (cod_orden) REFERENCES ORDEN_COMPRA(cod_orden),
  CONSTRAINT chk_mon_estado CHECK (estado IN ('En Proceso','En Ruta','Entregado'))
);

-- =============================================================
-- 5) PEDIDOS INTERNOS
-- =============================================================
CREATE TABLE IF NOT EXISTS PEDIDO_ABASTECIMIENTO (
  cod_pedido      SERIAL PRIMARY KEY,
  cod_usuario     INTEGER NOT NULL,
  fecha_pedido    DATE NOT NULL DEFAULT CURRENT_DATE,
  hora_pedido     TIME NOT NULL DEFAULT CURRENT_TIME,
  estado_pedido   VARCHAR(20) NOT NULL DEFAULT 'Pendiente',
  CONSTRAINT FK_PEDIDO_ABASTECIMIENTO_cod_usuario
    FOREIGN KEY (cod_usuario) REFERENCES USUARIO(cod_usuario),
  CONSTRAINT chk_ped_estado CHECK (estado_pedido IN ('Pendiente','Revisado','En Proceso','Atendido','Cancelado'))
);

CREATE TABLE IF NOT EXISTS DETALLE_PEDIDO (
  cod_pedido        INTEGER NOT NULL,
  cod_producto      INTEGER NOT NULL,
  cantidad_requerida INTEGER NOT NULL CHECK (cantidad_requerida > 0),
  fecha_requerida   DATE NOT NULL,
  tipo_destino      VARCHAR(10) NOT NULL,
  direccion_destino_externo VARCHAR(150),
  estado            VARCHAR(20) NOT NULL DEFAULT 'Pendiente',
  PRIMARY KEY (cod_pedido, cod_producto),
  CONSTRAINT FK_DETALLE_PEDIDO_cod_pedido
    FOREIGN KEY (cod_pedido)   REFERENCES PEDIDO_ABASTECIMIENTO(cod_pedido) ON DELETE CASCADE,
  CONSTRAINT FK_DETALLE_PEDIDO_cod_producto
    FOREIGN KEY (cod_producto) REFERENCES PRODUCTO(cod_producto),
  CONSTRAINT chk_dp_tipo_dest  CHECK (tipo_destino IN ('Interno','Externo')),
  CONSTRAINT chk_dp_estado     CHECK (estado IN ('Pendiente','Revisado','En Cotización','Adjudicado','En Camino','Recibido Parcial','Recibido Total','Cancelado'))
);

-- =============================================================
-- 6) RECEPCIÓN / LOGÍSTICA INBOUND
-- =============================================================
CREATE TABLE IF NOT EXISTS RECEPCION (
  cod_recepcion          SERIAL PRIMARY KEY,
  cod_orden              INTEGER NOT NULL,
  cod_instalacion        VARCHAR(10) NOT NULL,
  fecha_recepcion        DATE NOT NULL DEFAULT CURRENT_DATE,
  hora_inicio_recepcion  TIME NOT NULL,
  hora_fin_recepcion     TIME NOT NULL,
  fecha_programada       DATE NOT NULL,
  hora_programada        TIME NOT NULL,
  cod_usuario            INTEGER NOT NULL,
  observacion            VARCHAR(255),
  estado_recepcion       VARCHAR(20) NOT NULL DEFAULT 'Programada',
  CONSTRAINT FK_RECEPCION_cod_orden
    FOREIGN KEY (cod_orden)       REFERENCES ORDEN_COMPRA(cod_orden),
  CONSTRAINT fk_rec_instalacion
    FOREIGN KEY (cod_instalacion) REFERENCES INSTALACION(cod_instalacion),
  CONSTRAINT FK_RECEPCION_cod_usuario
    FOREIGN KEY (cod_usuario)     REFERENCES USUARIO(cod_usuario),
  CONSTRAINT chk_rec_estado CHECK (estado_recepcion IN ('Programada','En Curso','Finalizada','Con Reclamo')),
  CONSTRAINT chk_rec_horas  CHECK (hora_fin_recepcion >= hora_inicio_recepcion)
);

CREATE TABLE IF NOT EXISTS GUIA_REMISION_EXTERNA (
  serie_correlativo   VARCHAR(20) PRIMARY KEY,
  cod_recepcion       INTEGER NOT NULL,
  fecha_emision_guia  DATE NOT NULL,
  fecha_traslado_guia DATE NOT NULL,
  CONSTRAINT FK_GUIA_REMISION_EXTERNA_cod_recepcion
    FOREIGN KEY (cod_recepcion) REFERENCES RECEPCION(cod_recepcion),
  CONSTRAINT chk_gre_serie  CHECK (btrim(serie_correlativo) <> ''),
  CONSTRAINT chk_gre_fechas CHECK (fecha_traslado_guia >= fecha_emision_guia)
);

CREATE TABLE IF NOT EXISTS DETALLE_GUIA_EXTERNA (
  serie_correlativo VARCHAR(20) NOT NULL,
  cod_producto      INTEGER NOT NULL,
  cantidad_guia     INTEGER NOT NULL CHECK (cantidad_guia > 0),
  PRIMARY KEY (serie_correlativo, cod_producto),
  CONSTRAINT FK_DETALLE_GUIA_EXTERNA_serie_correlativo
    FOREIGN KEY (serie_correlativo) REFERENCES GUIA_REMISION_EXTERNA(serie_correlativo) ON DELETE CASCADE,
  CONSTRAINT FK_DETALLE_GUIA_EXTERNA_cod_producto
    FOREIGN KEY (cod_producto)      REFERENCES PRODUCTO(cod_producto)
);

CREATE TABLE IF NOT EXISTS DETALLE_RECEPCION (
  cod_detalle_recepcion SERIAL PRIMARY KEY,
  cod_recepcion         INTEGER NOT NULL,
  cod_producto          INTEGER NOT NULL,
  cantidad_conforme     INTEGER NOT NULL CHECK (cantidad_conforme   >= 0),
  cantidad_defectuosa   INTEGER NOT NULL CHECK (cantidad_defectuosa >= 0),
  cantidad_recibida     INTEGER NOT NULL CHECK (cantidad_recibida   >= 0),
  cantidad_programada   INTEGER NOT NULL CHECK (cantidad_programada > 0),
  UNIQUE (cod_recepcion, cod_producto),
  CONSTRAINT FK_DETALLE_RECEPCION_cod_recepcion
    FOREIGN KEY (cod_recepcion) REFERENCES RECEPCION(cod_recepcion) ON DELETE CASCADE,
  CONSTRAINT FK_DETALLE_RECEPCION_cod_producto
    FOREIGN KEY (cod_producto)  REFERENCES PRODUCTO(cod_producto),
  CONSTRAINT chk_dr_suma CHECK (cantidad_recibida = cantidad_conforme + cantidad_defectuosa)
);

-- =============================================================
-- 7) RECLAMOS / POST-COMPRA (módulo Abastecimiento)
-- =============================================================
CREATE TABLE IF NOT EXISTS RECLAMO (
  cod_reclamo          SERIAL PRIMARY KEY,
  fecha_reclamo        DATE NOT NULL DEFAULT CURRENT_DATE,
  hora_reclamo         TIME NOT NULL DEFAULT CURRENT_TIME,
  observacion_reclamo  VARCHAR(255),
  accion_correctiva    VARCHAR(30) NOT NULL,
  estado_reclamo       VARCHAR(20) NOT NULL DEFAULT 'Pendiente',
  CONSTRAINT chk_rab_accion CHECK (accion_correctiva IN ('Nota de Crédito','Reemplazo de Producto','Otro')),
  CONSTRAINT chk_rab_estado CHECK (estado_reclamo IN ('Pendiente','En Gestión','Resuelto','Rechazado'))
);

CREATE TABLE IF NOT EXISTS NOTA_CREDITO (
  cod_nota_credito SERIAL PRIMARY KEY,
  cod_reclamo      INTEGER NOT NULL UNIQUE,
  fecha_nc         DATE NOT NULL,
  motivo_nc        VARCHAR(50) NOT NULL,
  monto_nc         NUMERIC(12,2) NOT NULL CHECK (monto_nc > 0),
  descripcion_nc   VARCHAR(255) NOT NULL,
  CONSTRAINT fk_nc_reclamo FOREIGN KEY (cod_reclamo) REFERENCES RECLAMO(cod_reclamo)
);

CREATE TABLE IF NOT EXISTS CAMBIO_PRODUCTO (
  cod_cambio_producto SERIAL PRIMARY KEY,
  cod_reclamo         INTEGER NOT NULL,
  fecha_cambio        DATE NOT NULL DEFAULT CURRENT_DATE,
  hora_cambio         TIME NOT NULL DEFAULT CURRENT_TIME,
  motivo_cambio       VARCHAR(50) NOT NULL,
  descripcion_cambio  VARCHAR(255) NOT NULL,
  CONSTRAINT FK_CAMBIO_PRODUCTO_cod_reclamo
    FOREIGN KEY (cod_reclamo) REFERENCES RECLAMO(cod_reclamo)
);

CREATE TABLE IF NOT EXISTS INCIDENCIA (
  cod_incidencia            SERIAL PRIMARY KEY,
  cod_detalle_recepcion     INTEGER NOT NULL,
  cod_reclamo               INTEGER,
  tipo_incidencia           VARCHAR(20) NOT NULL,
  cantidad_incidencia       INTEGER NOT NULL CHECK (cantidad_incidencia > 0),
  descripcion_incidencia    VARCHAR(255) NOT NULL,
  CONSTRAINT fk_inc_dr  FOREIGN KEY (cod_detalle_recepcion) REFERENCES DETALLE_RECEPCION(cod_detalle_recepcion),
  CONSTRAINT fk_inc_rec FOREIGN KEY (cod_reclamo)           REFERENCES RECLAMO(cod_reclamo),
  CONSTRAINT chk_iab_tipo CHECK (tipo_incidencia IN ('CALIDAD','CANTIDAD_GUIA','CANTIDAD_FALTANTE','PRODUCTO_INCORRECTO'))
);

-- =============================================================
-- 8) DESPACHO / TRANSPORTE ASOCIADO A RECEPCIÓN
-- =============================================================
CREATE TABLE IF NOT EXISTS PEDIDO_TRANSPORTE (
  cod_pedido_transporte   SERIAL PRIMARY KEY,
  fecha_pedido_transporte DATE NOT NULL DEFAULT CURRENT_DATE,
  cod_recepcion           INTEGER NOT NULL,
  cod_estado_pedido_tr    INTEGER NOT NULL,
  cod_cliente             INTEGER NOT NULL, -- definir FK cuando integres CLIENTE en este módulo
  cod_usuario             INTEGER NOT NULL,
  CONSTRAINT fk_pt_recepcion    FOREIGN KEY (cod_recepcion)         REFERENCES RECEPCION(cod_recepcion),
  CONSTRAINT fk_pt_estado       FOREIGN KEY (cod_estado_pedido_tr)  REFERENCES ESTADO_PEDIDO_TR(cod_estado_pedido_tr),
  CONSTRAINT FK_PEDIDO_TRANSPORTE_cod_usuario
    FOREIGN KEY (cod_usuario)         REFERENCES USUARIO(cod_usuario)
);