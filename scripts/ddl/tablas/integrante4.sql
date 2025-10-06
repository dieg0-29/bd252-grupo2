-- =============================================================
-- Módulo: Abastecimiento
-- =============================================================

-- 0) Preparación
DROP SCHEMA IF EXISTS MODULO_ABASTECIMIENTO CASCADE;
CREATE SCHEMA MODULO_ABASTECIMIENTO;

-- =============================================================
-- 1) Tablas
-- =============================================================

-- AREA
CREATE TABLE MODULO_ABASTECIMIENTO.AREA (
  id_area        varchar(15) PRIMARY KEY,
  nombre_area    varchar(30) NOT NULL UNIQUE,
  CONSTRAINT chk_area_id        CHECK (id_area ~ '^[A-Z0-9-]{1,15}$'),
  CONSTRAINT chk_area_nombre    CHECK (btrim(nombre_area) <> '')
);

-- EMPLEADO
CREATE TABLE MODULO_ABASTECIMIENTO.EMPLEADO (
  id_empleado       varchar(15) PRIMARY KEY,
  id_area           varchar(15) NOT NULL,
  numero_contacto   varchar(20) NOT NULL,
  correo_contacto   varchar(50) NOT NULL UNIQUE,
  fecha_registro    date NOT NULL,
  CONSTRAINT fk_empleado_area
    FOREIGN KEY (id_area) REFERENCES MODULO_ABASTECIMIENTO.AREA(id_area)
    ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT chk_empleado_id      CHECK (id_empleado ~ '^[A-Z0-9-]{1,15}$'),
  CONSTRAINT chk_empleado_num CHECK (numero_contacto ~ '^[0-9]{9}$'),
  CONSTRAINT chk_empleado_correo  CHECK (correo_contacto ~* '^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$')
);

-- ROL
CREATE TABLE MODULO_ABASTECIMIENTO.ROL (
  id_rol            varchar(15) PRIMARY KEY,
  nombre_rol        varchar(30) NOT NULL UNIQUE,
  tipo_rol          varchar(30) NOT NULL,
  descripcion_rol   varchar(50) NOT NULL,
  CONSTRAINT chk_rol_id       CHECK (id_rol ~ '^[A-Z0-9-]{1,15}$'),
  CONSTRAINT chk_rol_nombre   CHECK (btrim(nombre_rol) <> ''),
  CONSTRAINT chk_rol_tipo     CHECK (btrim(tipo_rol) <> ''),
  CONSTRAINT chk_rol_desc     CHECK (btrim(descripcion_rol) <> '')
);

-- ROL_EMPLEADO (N:M)
CREATE TABLE MODULO_ABASTECIMIENTO.ROL_EMPLEADO (
  id_empleado       varchar(15) NOT NULL,
  id_rol            varchar(15) NOT NULL,
  fecha_asignacion  date NOT NULL,
  PRIMARY KEY (id_empleado, id_rol),
  CONSTRAINT fk_re_emp
    FOREIGN KEY (id_empleado) REFERENCES MODULO_ABASTECIMIENTO.EMPLEADO(id_empleado)
    ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_re_rol
    FOREIGN KEY (id_rol) REFERENCES MODULO_ABASTECIMIENTO.ROL(id_rol)
    ON UPDATE CASCADE ON DELETE CASCADE
);

-- PRODUCTO
CREATE TABLE MODULO_ABASTECIMIENTO.PRODUCTO (
  id_producto      varchar(15) PRIMARY KEY,
  nombre_producto  varchar(30) NOT NULL,
  unidad_medida    varchar(10) NOT NULL,
  precio_base      decimal(12,2) NOT NULL,
  CONSTRAINT chk_prod_id        CHECK (id_producto ~ '^[A-Z0-9-]{1,15}$'),
  CONSTRAINT chk_prod_nombre    CHECK (btrim(nombre_producto) <> ''),
  CONSTRAINT chk_prod_um        CHECK (
    btrim(unidad_medida) <> '' AND length(unidad_medida) <= 10
    AND unidad_medida IN ('UNIDAD','PIEZA','PAQUETE','BOLSA','SACO','ROLLO','CAJA','LATA','BOTELLA','TUBO','PLIEGO','KG','g','L','mL','m','cm','mm','m²','m³','TONELADA')
  ),
  CONSTRAINT chk_prod_precio_pos CHECK (precio_base >= 0)
);

-- TIPO
CREATE TABLE MODULO_ABASTECIMIENTO.TIPO (
  codigo_tipo   varchar(15) PRIMARY KEY,
  nombre_tipo   varchar(30) NOT NULL,
  CONSTRAINT chk_tipo_codigo  CHECK (codigo_tipo ~ '^[A-Z0-9-]{1,15}$'),
  CONSTRAINT chk_tipo_nombre  CHECK (btrim(nombre_tipo) <> '')
);

-- PRODUCTO_TIPO (N:M)
CREATE TABLE MODULO_ABASTECIMIENTO.PRODUCTO_TIPO (
  codigo_tipo   varchar(15) NOT NULL,
  id_producto   varchar(15) NOT NULL,
  PRIMARY KEY (id_producto, codigo_tipo),
  CONSTRAINT fk_pt_tipo
    FOREIGN KEY (codigo_tipo) REFERENCES MODULO_ABASTECIMIENTO.TIPO(codigo_tipo)
    ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_pt_producto
    FOREIGN KEY (id_producto) REFERENCES MODULO_ABASTECIMIENTO.PRODUCTO(id_producto)
    ON UPDATE CASCADE ON DELETE CASCADE
);

-- PROVEEDOR
CREATE TABLE MODULO_ABASTECIMIENTO.PROVEEDOR (
  id_proveedor       varchar(15) PRIMARY KEY,
  nombre_comercial   varchar(30) NOT NULL,
  razon_social       varchar(30) NOT NULL,
  ruc                varchar(11) NOT NULL UNIQUE,
  CONSTRAINT chk_prov_id        CHECK (id_proveedor ~ '^[A-Z0-9-]{1,15}$'),
  CONSTRAINT chk_prov_nomcom    CHECK (btrim(nombre_comercial) <> ''),
  CONSTRAINT chk_prov_razon     CHECK (btrim(razon_social) <> ''),
  CONSTRAINT chk_prov_ruc       CHECK (ruc ~ '^[0-9]{11}$')
);

-- PROVEEDOR_CONTACTO (1:N por tipo_contacto)
CREATE TABLE MODULO_ABASTECIMIENTO.PROVEEDOR_CONTACTO (
  id_proveedor   varchar(15) NOT NULL,
  tipo_contacto  varchar(30) NOT NULL,
  valor_contacto varchar(50) NOT NULL,
  PRIMARY KEY (id_proveedor, tipo_contacto),
  CONSTRAINT fk_pc_proveedor
    FOREIGN KEY (id_proveedor) REFERENCES MODULO_ABASTECIMIENTO.PROVEEDOR(id_proveedor)
    ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT chk_pc_tipo  CHECK (btrim(tipo_contacto) <> ''),
  CONSTRAINT chk_pc_valor CHECK (btrim(valor_contacto) <> '')
);

-- SOLICITUD_DE_COTIZACION
CREATE TABLE MODULO_ABASTECIMIENTO.SOLICITUD_DE_COTIZACION (
  id_solicitud              varchar(15) PRIMARY KEY,
  id_empleado               varchar(15) NOT NULL,
  fecha_emision_solicitud   date NOT NULL,
  estado                    varchar(15) NOT NULL,
  CONSTRAINT fk_sc_empleado
    FOREIGN KEY (id_empleado) REFERENCES MODULO_ABASTECIMIENTO.EMPLEADO(id_empleado)
    ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT chk_sc_id      CHECK (id_solicitud ~ '^[A-Z0-9-]{1,15}$'),
  CONSTRAINT chk_sc_estado  CHECK (estado IN ('CREADA','ENVIADA','COTIZADA'))
);

-- COTIZACION
CREATE TABLE MODULO_ABASTECIMIENTO.COTIZACION (
  id_cotizacion              varchar(15) PRIMARY KEY,
  id_solicitud               varchar(15) NOT NULL,
  id_proveedor               varchar(15) NOT NULL,
  fecha_emision_cotizacion   date NOT NULL,
  fecha_garantia             date NOT NULL,
  monto_total                decimal(12,2) NOT NULL,
  plazo_entrega              int NOT NULL,
  CONSTRAINT fk_cot_sc
    FOREIGN KEY (id_solicitud) REFERENCES MODULO_ABASTECIMIENTO.SOLICITUD_DE_COTIZACION(id_solicitud)
    ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT fk_cot_prov
    FOREIGN KEY (id_proveedor) REFERENCES MODULO_ABASTECIMIENTO.PROVEEDOR(id_proveedor)
    ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT chk_cot_id       CHECK (id_cotizacion ~ '^[A-Z0-9-]{1,15}$'),
  CONSTRAINT chk_cot_monto    CHECK (monto_total >= 0)
);

-- DETALLE_SOLICITUD (N:M)
CREATE TABLE MODULO_ABASTECIMIENTO.DETALLE_SOLICITUD (
  id_producto           varchar(15) NOT NULL,
  id_solicitud          varchar(15) NOT NULL,
  cantidad_solicitada   int NOT NULL,
  PRIMARY KEY (id_solicitud, id_producto),
  CONSTRAINT fk_ds_prod
    FOREIGN KEY (id_producto) REFERENCES MODULO_ABASTECIMIENTO.PRODUCTO(id_producto)
    ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_ds_sc
    FOREIGN KEY (id_solicitud) REFERENCES MODULO_ABASTECIMIENTO.SOLICITUD_DE_COTIZACION(id_solicitud)
    ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT chk_ds_cant_pos  CHECK (cantidad_solicitada > 0)
);

-- DETALLE_COTIZACION (N:M)
CREATE TABLE MODULO_ABASTECIMIENTO.DETALLE_COTIZACION (
  id_cotizacion     varchar(15) NOT NULL,
  id_producto       varchar(15) NOT NULL,
  costo_total       decimal(12,2) NOT NULL,
  modalidad_pago    varchar(10) NOT NULL,
  PRIMARY KEY (id_cotizacion, id_producto),
  CONSTRAINT fk_dc_cot
    FOREIGN KEY (id_cotizacion) REFERENCES MODULO_ABASTECIMIENTO.COTIZACION(id_cotizacion)
    ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_dc_prod
    FOREIGN KEY (id_producto) REFERENCES MODULO_ABASTECIMIENTO.PRODUCTO(id_producto)
    ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT chk_dc_monto_pos   CHECK (costo_total >= 0),
  CONSTRAINT chk_dc_modalidad   CHECK (modalidad_pago IN ('CONTADO','CREDITO'))
);

-- PRODUCTO_PROVEEDOR (N:M)
CREATE TABLE MODULO_ABASTECIMIENTO.PRODUCTO_PROVEEDOR (
  id_producto         varchar(15) NOT NULL,
  id_proveedor        varchar(15) NOT NULL,
  precio_unitario_ref decimal(12,2) NOT NULL,
  PRIMARY KEY (id_proveedor, id_producto),
  CONSTRAINT fk_pp_prod
    FOREIGN KEY (id_producto) REFERENCES MODULO_ABASTECIMIENTO.PRODUCTO(id_producto)
    ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_pp_prov
    FOREIGN KEY (id_proveedor) REFERENCES MODULO_ABASTECIMIENTO.PROVEEDOR(id_proveedor)
    ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT chk_pp_precio_pos CHECK (precio_unitario_ref >= 0)
);

-- PEDIDO_DE_ABASTECIMIENTO
CREATE TABLE MODULO_ABASTECIMIENTO.PEDIDO_DE_ABASTECIMIENTO (
  id_pedido        varchar(15) PRIMARY KEY,
  id_empleado      varchar(15) NOT NULL,
  fecha_pedido     date NOT NULL,
  hora_pedido      time NOT NULL,
  estado_pedido    varchar(15) NOT NULL,
  CONSTRAINT fk_ped_empleado
    FOREIGN KEY (id_empleado) REFERENCES MODULO_ABASTECIMIENTO.EMPLEADO(id_empleado)
    ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT chk_ped_id        CHECK (id_pedido ~ '^[A-Z0-9-]{1,15}$'),
  CONSTRAINT chk_ped_estado    CHECK (estado_pedido IN ('CREADO','REVISADO','EN PROCESO','ATENDIDO'))
);

-- DETALLE_PEDIDO (N:M)
CREATE TABLE MODULO_ABASTECIMIENTO.DETALLE_PEDIDO (
  id_pedido            varchar(15) NOT NULL,
  id_producto          varchar(15) NOT NULL,
  cantidad_requerida   int NOT NULL,
  fecha_requerida      date NOT NULL,
  ubicacion_envio      varchar(100) NOT NULL,
  PRIMARY KEY (id_pedido, id_producto),
  CONSTRAINT fk_dp_pedido
    FOREIGN KEY (id_pedido) REFERENCES MODULO_ABASTECIMIENTO.PEDIDO_DE_ABASTECIMIENTO(id_pedido)
    ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_dp_prod
    FOREIGN KEY (id_producto) REFERENCES MODULO_ABASTECIMIENTO.PRODUCTO(id_producto)
    ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT chk_dp_cant_pos   CHECK (cantidad_requerida > 0),
  CONSTRAINT chk_dp_ubic       CHECK (btrim(ubicacion_envio) <> '')
);

-- ORDEN_DE_COMPRA
CREATE TABLE MODULO_ABASTECIMIENTO.ORDEN_DE_COMPRA (
  id_orden        varchar(15) PRIMARY KEY,
  id_cotizacion   varchar(15) NOT NULL,
  fecha_emision   date NOT NULL,
  monto           decimal(12,2) NOT NULL,
  estado          varchar(15) NOT NULL,
  CONSTRAINT fk_oc_cot
    FOREIGN KEY (id_cotizacion) REFERENCES MODULO_ABASTECIMIENTO.COTIZACION(id_cotizacion)
    ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT chk_oc_id       CHECK (id_orden ~ '^[A-Z0-9-]{1,15}$'),
  CONSTRAINT chk_oc_monto    CHECK (monto >= 0),
  CONSTRAINT chk_oc_estado   CHECK (estado IN ('EMITIDA','APROBADA','ENVIADA','PARCIAL','COMPLETADA'))
);

-- DETALLE_OC (N:M)
CREATE TABLE MODULO_ABASTECIMIENTO.DETALLE_OC (
  id_orden      varchar(15) NOT NULL,
  id_producto   varchar(15) NOT NULL,
  PRIMARY KEY (id_orden, id_producto),
  CONSTRAINT fk_doc_orden
    FOREIGN KEY (id_orden) REFERENCES MODULO_ABASTECIMIENTO.ORDEN_DE_COMPRA(id_orden)
    ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_doc_prod
    FOREIGN KEY (id_producto) REFERENCES MODULO_ABASTECIMIENTO.PRODUCTO(id_producto)
    ON UPDATE CASCADE ON DELETE CASCADE
);

-- MONITOREO_DE_COMPRA
CREATE TABLE MODULO_ABASTECIMIENTO.MONITOREO_DE_COMPRA (
  id_monitoreo    varchar(15) PRIMARY KEY,
  id_orden        varchar(15) NOT NULL,
  fecha_entrega   date NOT NULL,
  hora_entrega    time,
  estado          varchar(15) NOT NULL,
  CONSTRAINT fk_mon_orden
    FOREIGN KEY (id_orden) REFERENCES MODULO_ABASTECIMIENTO.ORDEN_DE_COMPRA(id_orden)
    ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT chk_mon_id       CHECK (id_monitoreo ~ '^[A-Z0-9-]{1,15}$'),
  CONSTRAINT chk_mon_estado   CHECK (estado IN ('PENDIENTE','ENTREGADO','OBSERVADO'))
);

-- RECEPCION
CREATE TABLE MODULO_ABASTECIMIENTO.RECEPCION (
  id_recepcion           varchar(15) PRIMARY KEY,
  id_orden               varchar(15) NOT NULL,
  fecha_recepcion        date NOT NULL,
  hora_inicio_recepcion  time NOT NULL,
  hora_fin_recepcion     time NOT NULL,
  fecha_programada       date NOT NULL,
  hora_programada        time,
  empleado_encargado     varchar(15) NOT NULL,
  observacion            varchar(200),
  CONSTRAINT fk_rec_orden
    FOREIGN KEY (id_orden) REFERENCES MODULO_ABASTECIMIENTO.ORDEN_DE_COMPRA(id_orden)
    ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT fk_rec_empleado
    FOREIGN KEY (empleado_encargado) REFERENCES MODULO_ABASTECIMIENTO.EMPLEADO(id_empleado)
    ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT chk_rec_id         CHECK (id_recepcion ~ '^[A-Z0-9-]{1,15}$'),
  CONSTRAINT chk_rec_emp        CHECK (btrim(empleado_encargado) <> ''),
  CONSTRAINT chk_rec_horas      CHECK (hora_fin_recepcion >= hora_inicio_recepcion)
);

-- GUIA_DE_REMISION (1:1 RECEPCION)
CREATE TABLE MODULO_ABASTECIMIENTO.GUIA_DE_REMISION (
  serie_correlativo     varchar(15) PRIMARY KEY,
  id_recepcion          varchar(15) NOT NULL UNIQUE,
  fecha_emision_guia    date NOT NULL,
  fecha_traslado_guia   date NOT NULL,
  CONSTRAINT fk_guia_recep
    FOREIGN KEY (id_recepcion) REFERENCES MODULO_ABASTECIMIENTO.RECEPCION(id_recepcion)
    ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT chk_guia_serie  CHECK (serie_correlativo ~ '^[0-9]{3}-[0-9]{8}$'),
  CONSTRAINT chk_guia_fechas CHECK (fecha_traslado_guia >= fecha_emision_guia)
);

-- ALMACEN
CREATE TABLE MODULO_ABASTECIMIENTO.ALMACEN (
  id_almacen    varchar(15) PRIMARY KEY,
  nro_almacen   varchar(30) NOT NULL UNIQUE,
  ubicacion     varchar(100) NOT NULL,
  CONSTRAINT chk_alm_id      CHECK (id_almacen ~ '^[A-Z0-9-]{1,15}$'),
  CONSTRAINT chk_alm_nro     CHECK (btrim(nro_almacen) <> ''),
  CONSTRAINT chk_alm_ubic    CHECK (btrim(ubicacion) <> '')
);

-- RECEPCION_ALMACEN (1:1 por recepción)
CREATE TABLE MODULO_ABASTECIMIENTO.RECEPCION_ALMACEN (
  id_recepcion   varchar(15) PRIMARY KEY,
  id_almacen     varchar(15) NOT NULL,
  CONSTRAINT fk_ra_recep
    FOREIGN KEY (id_recepcion) REFERENCES MODULO_ABASTECIMIENTO.RECEPCION(id_recepcion)
    ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_ra_alm
    FOREIGN KEY (id_almacen) REFERENCES MODULO_ABASTECIMIENTO.ALMACEN(id_almacen)
    ON UPDATE CASCADE ON DELETE CASCADE
);

-- PEDIDO_DE_TRANSPORTE (1:1 RECEPCION)
CREATE TABLE MODULO_ABASTECIMIENTO.PEDIDO_DE_TRANSPORTE (
  id_pedido_transporte     varchar(15) PRIMARY KEY,
  id_recepcion             varchar(15) NOT NULL UNIQUE,
  fecha_pedido_transporte  date NOT NULL,
  hora_pedido_transporte   time,
  estado_pedido_transporte varchar(15) NOT NULL,
  CONSTRAINT fk_pt_recep
    FOREIGN KEY (id_recepcion) REFERENCES MODULO_ABASTECIMIENTO.RECEPCION(id_recepcion)
    ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT chk_pt_id      CHECK (id_pedido_transporte ~ '^[A-Z0-9-]{1,15}$'),
  CONSTRAINT chk_pt_estado  CHECK (estado_pedido_transporte IN ('RECIBIDO','EN PROCESO','COMPLETADO'))
);

-- RECLAMO
CREATE TABLE MODULO_ABASTECIMIENTO.RECLAMO (
  id_reclamo      varchar(15) PRIMARY KEY,
  id_recepcion    varchar(15),
  fecha_reclamo   date NOT NULL,
  hora_reclamo    time NOT NULL,
  estado_reclamo  varchar(15) NOT NULL,
  CONSTRAINT fk_reclamo_recep
    FOREIGN KEY (id_recepcion) REFERENCES MODULO_ABASTECIMIENTO.RECEPCION(id_recepcion)
    ON UPDATE CASCADE ON DELETE SET NULL,
  CONSTRAINT chk_reclamo_id      CHECK (id_reclamo ~ '^[A-Z0-9-]{1,15}$'),
  CONSTRAINT chk_reclamo_estado  CHECK (estado_reclamo IN ('ABIERTO','EN_PROCESO','ACEPTADO','RECHAZADO'))
);

-- NOTA_DE_CREDITO (entidad débil de RECLAMO)
CREATE TABLE MODULO_ABASTECIMIENTO.NOTA_DE_CREDITO (
  id_reclamo     varchar(15) NOT NULL,
  nro_nc         smallint NOT NULL,
  fecha_nc       date NOT NULL,
  motivo_nc      varchar(50) NOT NULL,
  monto_nc       decimal(12,2) NOT NULL,
  descripcion_nc varchar(200),
  PRIMARY KEY (id_reclamo, nro_nc),
  CONSTRAINT fk_nc_reclamo
    FOREIGN KEY (id_reclamo) REFERENCES MODULO_ABASTECIMIENTO.RECLAMO(id_reclamo)
    ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT chk_nc_monto_pos CHECK (monto_nc > 0)
);

-- CAMBIO_DE_PRODUCTO (entidad débil de RECLAMO)
CREATE TABLE MODULO_ABASTECIMIENTO.CAMBIO_DE_PRODUCTO (
  id_reclamo         varchar(15) NOT NULL,
  nro_cambio         smallint NOT NULL,
  fecha_cambio       date NOT NULL,
  hora_cambio        time NOT NULL,
  motivo_cambio      varchar(50) NOT NULL,
  descripcion_cambio varchar(200),
  PRIMARY KEY (id_reclamo, nro_cambio),
  CONSTRAINT fk_cp_reclamo
    FOREIGN KEY (id_reclamo) REFERENCES MODULO_ABASTECIMIENTO.RECLAMO(id_reclamo)
    ON UPDATE CASCADE ON DELETE CASCADE
);

-- DETALLE_RECEPCION (N:M)
CREATE TABLE MODULO_ABASTECIMIENTO.DETALLE_RECEPCION (
  id_recepcion         varchar(15) NOT NULL,
  id_producto          varchar(15) NOT NULL,
  cantidad_conforme    int NOT NULL,
  cantidad_defectuosa  int NOT NULL,
  cantidad_recibida    int NOT NULL,
  PRIMARY KEY (id_recepcion, id_producto),
  CONSTRAINT fk_dr_recep
    FOREIGN KEY (id_recepcion) REFERENCES MODULO_ABASTECIMIENTO.RECEPCION(id_recepcion)
    ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_dr_prod
    FOREIGN KEY (id_producto) REFERENCES MODULO_ABASTECIMIENTO.PRODUCTO(id_producto)
    ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT chk_dr_cantidades CHECK (
    cantidad_conforme >= 0 AND
    cantidad_defectuosa >= 0 AND
    cantidad_recibida > 0 AND
    cantidad_recibida = (cantidad_conforme + cantidad_defectuosa)
  )
);
