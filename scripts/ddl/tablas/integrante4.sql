-- =============================================================
-- Módulo: Abastecimiento
-- Versión Final
-- =============================================================

-- 0) Preparación
DROP SCHEMA IF EXISTS MODULO_ABASTECIMIENTO CASCADE;
CREATE SCHEMA MODULO_ABASTECIMIENTO;

-- =============================================================
-- 1) Tablas de Entidades (Padres)
-- =============================================================

-- AREA
CREATE TABLE MODULO_ABASTECIMIENTO.AREA (
    cod_area SERIAL PRIMARY KEY,
    nombre_area VARCHAR(50) NOT NULL UNIQUE,
    CONSTRAINT chk_area_nombre CHECK (btrim(nombre_area) <> '')
);

-- ROL
CREATE TABLE MODULO_ABASTECIMIENTO.ROL (
    cod_rol SERIAL PRIMARY KEY,
    nombre_rol VARCHAR(50) NOT NULL UNIQUE,
    tipo_rol VARCHAR(30) NOT NULL,
    descripcion_rol VARCHAR(200) NOT NULL,
    CONSTRAINT chk_rol_nombre CHECK (btrim(nombre_rol) <> ''),
    CONSTRAINT chk_rol_tipo CHECK (tipo_rol IN ('Estrategico', 'Administrativo', 'Operativo')),
    CONSTRAINT chk_rol_desc CHECK (btrim(descripcion_rol) <> '')
);

-- CATEGORIA
CREATE TABLE MODULO_ABASTECIMIENTO.CATEGORIA (
    cod_categoria SERIAL PRIMARY KEY,
    rubro VARCHAR(50) NOT NULL,
    familia VARCHAR(50) NOT NULL,
    clase VARCHAR(50) NOT NULL,
    UNIQUE (rubro, familia, clase),
    CONSTRAINT chk_cat_rubro CHECK (btrim(rubro) <> ''),
    CONSTRAINT chk_cat_familia CHECK (btrim(familia) <> ''),
    CONSTRAINT chk_cat_clase CHECK (btrim(clase) <> '')
);

-- ALMACEN
CREATE TABLE MODULO_ABASTECIMIENTO.ALMACEN (
    cod_almacen SERIAL PRIMARY KEY,
    nro_almacen VARCHAR(50) NOT NULL UNIQUE,
    ubicacion VARCHAR(150) NOT NULL,
    CONSTRAINT chk_alm_nro CHECK (btrim(nro_almacen) <> ''),
    CONSTRAINT chk_alm_ubic CHECK (btrim(ubicacion) <> '')
);

-- PROVEEDOR
CREATE TABLE MODULO_ABASTECIMIENTO.PROVEEDOR (
    cod_proveedor SERIAL PRIMARY KEY,
    nombre_comercial VARCHAR(100) NOT NULL,
    razon_social VARCHAR(150) NOT NULL,
    RUC VARCHAR(11) NOT NULL UNIQUE,
    CONSTRAINT chk_prov_nomcom CHECK (btrim(nombre_comercial) <> ''),
    CONSTRAINT chk_prov_razon CHECK (btrim(razon_social) <> ''),
    CONSTRAINT chk_prov_ruc CHECK (RUC ~ '^[0-9]{11}$')
);

-- RECLAMO
CREATE TABLE MODULO_ABASTECIMIENTO.RECLAMO (
    cod_reclamo SERIAL PRIMARY KEY,
    fecha_reclamo DATE NOT NULL DEFAULT CURRENT_DATE,
    hora_reclamo TIME NOT NULL DEFAULT CURRENT_TIME,
    estado_reclamo VARCHAR(20) NOT NULL DEFAULT 'Pendiente',
    observacion_reclamo VARCHAR(255) NULL,
    accion_correctiva VARCHAR(30) NOT NULL,
    CONSTRAINT chk_reclamo_estado CHECK (estado_reclamo IN ('Pendiente', 'En Gestión', 'Resuelto', 'Rechazado')),
    CONSTRAINT chk_reclamo_accion CHECK (accion_correctiva IN ('Nota de Crédito', 'Reemplazo de Producto', 'Otro'))
);

-- -----------------------------------------------------
-- 2) Tablas de Entidades (Hijas Nivel 1)
-- -----------------------------------------------------

-- EMPLEADO
CREATE TABLE MODULO_ABASTECIMIENTO.EMPLEADO (
    cod_empleado SERIAL PRIMARY KEY,
    fecha_registro DATE NOT NULL DEFAULT CURRENT_DATE,
    numero_contacto VARCHAR(20) NOT NULL,
    correo_contacto VARCHAR(100) NOT NULL UNIQUE,
    cod_area INTEGER NOT NULL,
    CONSTRAINT fk_empleado_area
        FOREIGN KEY (cod_area) REFERENCES MODULO_ABASTECIMIENTO.AREA(cod_area)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT chk_empleado_num CHECK (numero_contacto ~ '^[0-9]{9,15}$'),
    CONSTRAINT chk_empleado_correo CHECK (correo_contacto ~* '^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$')
);

-- PRODUCTO
CREATE TABLE MODULO_ABASTECIMIENTO.PRODUCTO (
    cod_producto SERIAL PRIMARY KEY,
    nombre_producto VARCHAR(100) NOT NULL,
    marca_producto VARCHAR(50) NULL,
    unidad_medida VARCHAR(20) NOT NULL,
    precio_base DECIMAL(12,2) NOT NULL,
    cod_categoria INTEGER NOT NULL,
    CONSTRAINT fk_producto_categoria
        FOREIGN KEY (cod_categoria) REFERENCES MODULO_ABASTECIMIENTO.CATEGORIA(cod_categoria)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT chk_prod_nombre CHECK (btrim(nombre_producto) <> ''),
    CONSTRAINT chk_prod_um CHECK (unidad_medida IN ('UNIDAD', 'PAQUETE', 'SACO', 'CAJA', 'ROLLO', 'LATA', 'BOTELLA', 'm', 'KG', 'L', 'm²')),
    CONSTRAINT chk_prod_precio_pos CHECK (precio_base >= 0)
);

-- NOTA_CREDITO
CREATE TABLE MODULO_ABASTECIMIENTO.NOTA_CREDITO (
    cod_nota_credito SERIAL PRIMARY KEY,
    fecha_nc DATE NOT NULL,
    motivo_nc VARCHAR(50) NOT NULL,
    monto_nc DECIMAL(12,2) NOT NULL,
    descripcion_nc VARCHAR(255) NOT NULL,
    cod_reclamo INTEGER NOT NULL UNIQUE,
    CONSTRAINT fk_nc_reclamo
        FOREIGN KEY (cod_reclamo) REFERENCES MODULO_ABASTECIMIENTO.RECLAMO(cod_reclamo)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT chk_nc_monto_pos CHECK (monto_nc > 0)
);

-- CAMBIO_PRODUCTO
CREATE TABLE MODULO_ABASTECIMIENTO.CAMBIO_PRODUCTO (
    cod_cambio_producto SERIAL PRIMARY KEY,
    fecha_cambio DATE NOT NULL DEFAULT CURRENT_DATE,
    hora_cambio TIME NOT NULL DEFAULT CURRENT_TIME,
    motivo_cambio VARCHAR(50) NOT NULL,
    descripcion_cambio VARCHAR(255) NOT NULL,
    cod_reclamo INTEGER NOT NULL,
    CONSTRAINT fk_cp_reclamo
        FOREIGN KEY (cod_reclamo) REFERENCES MODULO_ABASTECIMIENTO.RECLAMO(cod_reclamo)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

-- -----------------------------------------------------
-- 3) Tablas de Entidades (Hijas Nivel 2)
-- -----------------------------------------------------

-- PEDIDO_ABASTECIMIENTO
CREATE TABLE MODULO_ABASTECIMIENTO.PEDIDO_ABASTECIMIENTO (
    cod_pedido SERIAL PRIMARY KEY,
    fecha_pedido DATE NOT NULL DEFAULT CURRENT_DATE,
    hora_pedido TIME NOT NULL DEFAULT CURRENT_TIME,
    estado_pedido VARCHAR(20) NOT NULL DEFAULT 'Pendiente',
    cod_empleado INTEGER NOT NULL,
    CONSTRAINT fk_ped_empleado
        FOREIGN KEY (cod_empleado) REFERENCES MODULO_ABASTECIMIENTO.EMPLEADO(cod_empleado)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT chk_ped_estado CHECK (estado_pedido IN ('Pendiente', 'Revisado', 'En Proceso', 'Atendido', 'Cancelado'))
);

-- SOLICITUD_COTIZACION
CREATE TABLE MODULO_ABASTECIMIENTO.SOLICITUD_COTIZACION (
    cod_solicitud SERIAL PRIMARY KEY,
    fecha_emision_solicitud DATE NOT NULL DEFAULT CURRENT_DATE,
    estado VARCHAR(20) NOT NULL DEFAULT 'Pendiente',
    cod_empleado INTEGER NOT NULL,
    CONSTRAINT fk_sc_empleado
        FOREIGN KEY (cod_empleado) REFERENCES MODULO_ABASTECIMIENTO.EMPLEADO(cod_empleado)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT chk_sc_estado CHECK (estado IN ('Pendiente', 'Cotizada', 'Adjudicada', 'Cerrada'))
);

-- -----------------------------------------------------
-- 4) Tablas de Entidades (Hijas Nivel 3)
-- -----------------------------------------------------

-- COTIZACION
CREATE TABLE MODULO_ABASTECIMIENTO.COTIZACION (
    cod_cotizacion SERIAL PRIMARY KEY,
    fecha_emision_cotizacion DATE NOT NULL,
    fecha_garantia DATE NOT NULL,
    monto_total DECIMAL(12,2) NOT NULL,
    plazo_entrega INTEGER NOT NULL,
    cod_proveedor INTEGER NOT NULL,
    cod_solicitud INTEGER NOT NULL,
    CONSTRAINT fk_cot_prov
        FOREIGN KEY (cod_proveedor) REFERENCES MODULO_ABASTECIMIENTO.PROVEEDOR(cod_proveedor)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_cot_sc
        FOREIGN KEY (cod_solicitud) REFERENCES MODULO_ABASTECIMIENTO.SOLICITUD_COTIZACION(cod_solicitud)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT chk_cot_monto CHECK (monto_total >= 0),
    CONSTRAINT chk_cot_plazo CHECK (plazo_entrega >= 0),
    CONSTRAINT chk_cot_fechas CHECK (fecha_garantia >= fecha_emision_cotizacion)
);

-- -----------------------------------------------------
-- 5) Tablas de Entidades (Hijas Nivel 4)
-- -----------------------------------------------------

-- ORDEN_COMPRA
CREATE TABLE MODULO_ABASTECIMIENTO.ORDEN_COMPRA (
    cod_orden SERIAL PRIMARY KEY,
    fecha_emision DATE NOT NULL DEFAULT CURRENT_DATE,
    estado VARCHAR(20) NOT NULL DEFAULT 'Emitida',
    monto DECIMAL(12,2) NOT NULL,
    modalidad_pago VARCHAR(20) NOT NULL,
    cod_cotizacion INTEGER NOT NULL,
    CONSTRAINT fk_oc_cot
        FOREIGN KEY (cod_cotizacion) REFERENCES MODULO_ABASTECIMIENTO.COTIZACION(cod_cotizacion)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT chk_oc_monto CHECK (monto >= 0),
    CONSTRAINT chk_oc_estado CHECK (estado IN ('Emitida', 'En Proceso', 'Programada', 'Cerrada', 'Anulada')),
    CONSTRAINT chk_oc_modalidad CHECK (modalidad_pago IN ('Contado', 'Crédito'))
);

-- -----------------------------------------------------
-- 6) Tablas de Entidades (Hijas Nivel 5)
-- -----------------------------------------------------

-- MONITOREO_COMPRA (Relación 1:1)
CREATE TABLE MODULO_ABASTECIMIENTO.MONITOREO_COMPRA (
    cod_monitoreo SERIAL PRIMARY KEY,
    fecha_entrega DATE NOT NULL,
    hora_entrega TIME NULL,
    estado VARCHAR(20) NOT NULL DEFAULT 'En Proceso',
    cod_orden INTEGER NOT NULL UNIQUE,
    CONSTRAINT fk_mon_orden
        FOREIGN KEY (cod_orden) REFERENCES MODULO_ABASTECIMIENTO.ORDEN_COMPRA(cod_orden)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT chk_mon_estado CHECK (estado IN ('En Proceso', 'En Ruta', 'Entregado'))
);

-- RECEPCION
CREATE TABLE MODULO_ABASTECIMIENTO.RECEPCION (
    cod_recepcion SERIAL PRIMARY KEY,
    fecha_recepcion DATE NOT NULL DEFAULT CURRENT_DATE,
    hora_inicio_recepcion TIME NOT NULL,
    hora_fin_recepcion TIME NOT NULL,
    fecha_programada DATE NOT NULL,
    hora_programada TIME NOT NULL,
    estado_recepcion VARCHAR(20) NOT NULL DEFAULT 'Programada',
    cod_empleado_encargado INTEGER NOT NULL,
    observacion VARCHAR(255) NULL,
    cod_orden INTEGER NOT NULL,
    cod_almacen INTEGER NULL,
    CONSTRAINT fk_rec_orden
        FOREIGN KEY (cod_orden) REFERENCES MODULO_ABASTECIMIENTO.ORDEN_COMPRA(cod_orden)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_rec_almacen
        FOREIGN KEY (cod_almacen) REFERENCES MODULO_ABASTECIMIENTO.ALMACEN(cod_almacen)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_rec_empleado
        FOREIGN KEY (cod_empleado_encargado) REFERENCES MODULO_ABASTECIMIENTO.EMPLEADO(cod_empleado)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT chk_rec_estado CHECK (estado_recepcion IN ('Programada', 'En Curso', 'Finalizada', 'Con Reclamo')),
    CONSTRAINT chk_rec_horas CHECK (hora_fin_recepcion >= hora_inicio_recepcion)
);

-- -----------------------------------------------------
-- 7) Tablas de Entidades (Hijas Nivel 6)
-- -----------------------------------------------------

-- GUIA_REMISION
CREATE TABLE MODULO_ABASTECIMIENTO.GUIA_REMISION (
    serie_correlativo VARCHAR(20) PRIMARY KEY,
    fecha_emision_guia DATE NOT NULL,
    fecha_traslado_guia DATE NOT NULL,
    cod_recepcion INTEGER NOT NULL,
    CONSTRAINT fk_guia_recep
        FOREIGN KEY (cod_recepcion) REFERENCES MODULO_ABASTECIMIENTO.RECEPCION(cod_recepcion)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT chk_guia_serie CHECK (btrim(serie_correlativo) <> ''),
    CONSTRAINT chk_guia_fechas CHECK (fecha_traslado_guia >= fecha_emision_guia)
);

-- PEDIDO_TRANSPORTE (Relación 1:1)
CREATE TABLE MODULO_ABASTECIMIENTO.PEDIDO_TRANSPORTE (
    cod_pedido_transporte SERIAL PRIMARY KEY,
    fecha_pedido_transporte DATE NOT NULL,
    hora_pedido_transporte TIME NOT NULL,
    estado_pedido_transporte VARCHAR(20) NOT NULL DEFAULT 'Pendiente',
    cod_recepcion INTEGER NOT NULL UNIQUE,
    CONSTRAINT fk_pt_recep
        FOREIGN KEY (cod_recepcion) REFERENCES MODULO_ABASTECIMIENTO.RECEPCION(cod_recepcion)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT chk_pt_estado CHECK (estado_pedido_transporte IN ('Pendiente', 'Programado', 'Picking', 'En Ruta', 'En Camino ', 'Completado', 'Cancelado'))
);

-- -----------------------------------------------------
-- 8) Tablas Intermedias (N:M) y Asociativas
-- -----------------------------------------------------

-- PROVEEDOR_CONTACTO
CREATE TABLE MODULO_ABASTECIMIENTO.PROVEEDOR_CONTACTO (
    cod_proveedor INTEGER NOT NULL,
    tipo_contacto VARCHAR(30) NOT NULL,
    valor_contacto VARCHAR(100) NOT NULL,
    PRIMARY KEY (cod_proveedor, tipo_contacto),
    CONSTRAINT fk_pc_proveedor
        FOREIGN KEY (cod_proveedor) REFERENCES MODULO_ABASTECIMIENTO.PROVEEDOR(cod_proveedor)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT chk_pc_tipo CHECK (btrim(tipo_contacto) <> ''),
    CONSTRAINT chk_pc_valor CHECK (btrim(valor_contacto) <> '')
);

-- ROL_EMPLEADO
CREATE TABLE MODULO_ABASTECIMIENTO.ROL_EMPLEADO (
    cod_empleado INTEGER NOT NULL,
    cod_rol INTEGER NOT NULL,
    fecha_asignacion DATE NOT NULL DEFAULT CURRENT_DATE,
    PRIMARY KEY (cod_empleado, cod_rol),
    CONSTRAINT fk_re_emp
        FOREIGN KEY (cod_empleado) REFERENCES MODULO_ABASTECIMIENTO.EMPLEADO(cod_empleado)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_re_rol
        FOREIGN KEY (cod_rol) REFERENCES MODULO_ABASTECIMIENTO.ROL(cod_rol)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

-- DETALLE_PEDIDO
CREATE TABLE MODULO_ABASTECIMIENTO.DETALLE_PEDIDO (
    cod_pedido INTEGER NOT NULL,
    cod_producto INTEGER NOT NULL,
    cantidad_requerida INTEGER NOT NULL,
    fecha_requerida DATE NOT NULL,
    tipo_destino VARCHAR(10) NOT NULL,
    direccion_destino_externo VARCHAR(150) NULL,
    estado VARCHAR(20) NOT NULL DEFAULT 'Pendiente',
    PRIMARY KEY (cod_pedido, cod_producto),
    CONSTRAINT fk_dp_pedido
        FOREIGN KEY (cod_pedido) REFERENCES MODULO_ABASTECIMIENTO.PEDIDO_ABASTECIMIENTO(cod_pedido)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_dp_prod
        FOREIGN KEY (cod_producto) REFERENCES MODULO_ABASTECIMIENTO.PRODUCTO(cod_producto)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT chk_dp_cant_pos CHECK (cantidad_requerida > 0),
    CONSTRAINT chk_dp_tipo_dest CHECK (tipo_destino IN ('Interno', 'Externo')),
    CONSTRAINT chk_dp_estado CHECK (estado IN ('Pendiente', 'Revisado', 'En Cotización', 'Adjudicado','En Camino', 'Recibido Parcial', 'Recibido Total', 'Cancelado'))
);

-- PRODUCTO_PROVEEDOR
CREATE TABLE MODULO_ABASTECIMIENTO.PRODUCTO_PROVEEDOR (
    cod_proveedor INTEGER NOT NULL,
    cod_producto INTEGER NOT NULL,
    precio_unitario_ref DECIMAL(12,2) NOT NULL,
    PRIMARY KEY (cod_proveedor, cod_producto),
    CONSTRAINT fk_pp_prov
        FOREIGN KEY (cod_proveedor) REFERENCES MODULO_ABASTECIMIENTO.PROVEEDOR(cod_proveedor)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_pp_prod
        FOREIGN KEY (cod_producto) REFERENCES MODULO_ABASTECIMIENTO.PRODUCTO(cod_producto)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT chk_pp_precio_pos CHECK (precio_unitario_ref >= 0)
);

-- DETALLE_SOLICITUD
CREATE TABLE MODULO_ABASTECIMIENTO.DETALLE_SOLICITUD (
    cod_solicitud INTEGER NOT NULL,
    cod_producto INTEGER NOT NULL,
    cantidad_solicitada INTEGER NOT NULL,
    PRIMARY KEY (cod_solicitud, cod_producto),
    CONSTRAINT fk_ds_sc
        FOREIGN KEY (cod_solicitud) REFERENCES MODULO_ABASTECIMIENTO.SOLICITUD_COTIZACION(cod_solicitud)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_ds_prod
        FOREIGN KEY (cod_producto) REFERENCES MODULO_ABASTECIMIENTO.PRODUCTO(cod_producto)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT chk_ds_cant_pos CHECK (cantidad_solicitada > 0)
);

-- DETALLE_OC
CREATE TABLE MODULO_ABASTECIMIENTO.DETALLE_OC (
    cod_orden INTEGER NOT NULL,
    cod_producto INTEGER NOT NULL,
    cantidad_comprada INTEGER NOT NULL,
    costo_total DECIMAL(12,2) NOT NULL,
    PRIMARY KEY (cod_orden, cod_producto),
    CONSTRAINT fk_doc_orden
        FOREIGN KEY (cod_orden) REFERENCES MODULO_ABASTECIMIENTO.ORDEN_COMPRA(cod_orden)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_doc_prod
        FOREIGN KEY (cod_producto) REFERENCES MODULO_ABASTECIMIENTO.PRODUCTO(cod_producto)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT chk_doc_cant_pos CHECK (cantidad_comprada > 0),
    CONSTRAINT chk_doc_costo_pos CHECK (costo_total >= 0)
);

-- DETALLE_COTIZACION
CREATE TABLE MODULO_ABASTECIMIENTO.DETALLE_COTIZACION (
    cod_cotizacion INTEGER NOT NULL,
    cod_producto INTEGER NOT NULL,
    costo_total DECIMAL(12,2) NOT NULL,
    modalidad_pago VARCHAR(20) NOT NULL,
    PRIMARY KEY (cod_cotizacion, cod_producto),
    CONSTRAINT fk_dc_cot
        FOREIGN KEY (cod_cotizacion) REFERENCES MODULO_ABASTECIMIENTO.COTIZACION(cod_cotizacion)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_dc_prod
        FOREIGN KEY (cod_producto) REFERENCES MODULO_ABASTECIMIENTO.PRODUCTO(cod_producto)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT chk_dc_monto_pos CHECK (costo_total >= 0),
    CONSTRAINT chk_dc_modalidad CHECK (modalidad_pago IN ('Contado', 'Crédito'))
);

-- DETALLE_RECEPCION (Entidad Asociativa con PK Sustituta)
CREATE TABLE MODULO_ABASTECIMIENTO.DETALLE_RECEPCION (
    cod_detalle_recepcion SERIAL PRIMARY KEY,
    cod_recepcion INTEGER NOT NULL,
    cod_producto INTEGER NOT NULL,
    cantidad_programada INTEGER NOT NULL,
    cantidad_recibida INTEGER NOT NULL,
    cantidad_conforme INTEGER NOT NULL,
    cantidad_defectuosa INTEGER NOT NULL,
    UNIQUE (cod_recepcion, cod_producto),
    CONSTRAINT fk_dr_recep
        FOREIGN KEY (cod_recepcion) REFERENCES MODULO_ABASTECIMIENTO.RECEPCION(cod_recepcion)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_dr_prod
        FOREIGN KEY (cod_producto) REFERENCES MODULO_ABASTECIMIENTO.PRODUCTO(cod_producto)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT chk_dr_cant_prog_pos CHECK (cantidad_programada > 0),
    CONSTRAINT chk_dr_cant_rec_pos CHECK (cantidad_recibida >= 0),
    CONSTRAINT chk_dr_cant_conf_pos CHECK (cantidad_conforme >= 0),
    CONSTRAINT chk_dr_cant_def_pos CHECK (cantidad_defectuosa >= 0),
    CONSTRAINT chk_dr_cantidades_suma CHECK (cantidad_recibida = (cantidad_conforme + cantidad_defectuosa))
);

-- DETALLE_GUIA
CREATE TABLE MODULO_ABASTECIMIENTO.DETALLE_GUIA (
    serie_correlativo VARCHAR(20) NOT NULL,
    cod_producto INTEGER NOT NULL,
    cantidad_guia INTEGER NOT NULL,
    PRIMARY KEY (serie_correlativo, cod_producto),
    CONSTRAINT fk_dg_guia
        FOREIGN KEY (serie_correlativo) REFERENCES MODULO_ABASTECIMIENTO.GUIA_REMISION(serie_correlativo)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_dg_prod
        FOREIGN KEY (cod_producto) REFERENCES MODULO_ABASTECIMIENTO.PRODUCTO(cod_producto)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT chk_dg_cant_pos CHECK (cantidad_guia > 0)
);

-- INCIDENCIA
CREATE TABLE MODULO_ABASTECIMIENTO.INCIDENCIA (
    cod_incidencia SERIAL PRIMARY KEY,
    tipo_incidencia VARCHAR(20) NOT NULL,
    cantidad_incidencia INTEGER NOT NULL,
    descripcion_incidencia VARCHAR(255) NOT NULL,
    cod_detalle_recepcion INTEGER NOT NULL,
    cod_reclamo INTEGER NULL,
    CONSTRAINT fk_inc_detalle_recepcion
        FOREIGN KEY (cod_detalle_recepcion) REFERENCES MODULO_ABASTECIMIENTO.DETALLE_RECEPCION(cod_detalle_recepcion)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_inc_reclamo
        FOREIGN KEY (cod_reclamo) REFERENCES MODULO_ABASTECIMIENTO.RECLAMO(cod_reclamo)
        ON UPDATE CASCADE ON DELETE SET NULL,
    CONSTRAINT chk_inc_tipo CHECK (tipo_incidencia IN ('CALIDAD', 'CANTIDAD_GUIA', 'CANTIDAD_FALTANTE', 'PRODUCTO_INCORRECTO')),
    CONSTRAINT chk_inc_cant_pos CHECK (cantidad_incidencia > 0)
);
