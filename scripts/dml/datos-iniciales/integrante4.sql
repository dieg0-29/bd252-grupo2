TRUNCATE TABLE
  MODULO_ABASTECIMIENTO.CAMBIO_DE_PRODUCTO,
  MODULO_ABASTECIMIENTO.NOTA_DE_CREDITO,
  MODULO_ABASTECIMIENTO.RECLAMO,
  MODULO_ABASTECIMIENTO.PEDIDO_DE_TRANSPORTE,
  MODULO_ABASTECIMIENTO.RECEPCION_ALMACEN,
  MODULO_ABASTECIMIENTO.GUIA_DE_REMISION,
  MODULO_ABASTECIMIENTO.DETALLE_RECEPCION,
  MODULO_ABASTECIMIENTO.RECEPCION,
  MODULO_ABASTECIMIENTO.MONITOREO_DE_COMPRA,
  MODULO_ABASTECIMIENTO.DETALLE_OC,
  MODULO_ABASTECIMIENTO.ORDEN_DE_COMPRA,
  MODULO_ABASTECIMIENTO.DETALLE_PEDIDO,
  MODULO_ABASTECIMIENTO.PEDIDO_DE_ABASTECIMIENTO,
  MODULO_ABASTECIMIENTO.DETALLE_COTIZACION,
  MODULO_ABASTECIMIENTO.COTIZACION,
  MODULO_ABASTECIMIENTO.DETALLE_SOLICITUD,
  MODULO_ABASTECIMIENTO.SOLICITUD_DE_COTIZACION,
  MODULO_ABASTECIMIENTO.PROVEEDOR_CONTACTO,
  MODULO_ABASTECIMIENTO.PRODUCTO_PROVEEDOR,
  MODULO_ABASTECIMIENTO.PRODUCTO_TIPO,
  MODULO_ABASTECIMIENTO.TIPO,
  MODULO_ABASTECIMIENTO.PROVEEDOR,
  MODULO_ABASTECIMIENTO.ALMACEN,
  MODULO_ABASTECIMIENTO.ROL_EMPLEADO,
  MODULO_ABASTECIMIENTO.ROL,
  MODULO_ABASTECIMIENTO.EMPLEADO,
  MODULO_ABASTECIMIENTO.PRODUCTO,
  MODULO_ABASTECIMIENTO.AREA
CASCADE;

-- =============================================================
-- ÁREAS (según tu lista)
-- =============================================================
INSERT INTO MODULO_ABASTECIMIENTO.AREA (id_area, nombre_area) VALUES
('AREA-0001','ALMACEN'),
('AREA-0002','ABASTECIMIENTO'),
('AREA-0003','VENTAS'),
('AREA-0004','TRANSPORTE'),
('AREA-0005','MANTENIMIENTO');

-- =============================================================
-- ROLES
-- =============================================================
INSERT INTO MODULO_ABASTECIMIENTO.ROL (id_rol,nombre_rol,tipo_rol,descripcion_rol) VALUES
('ROL-0001','JEFE DE ABASTECIMIENTO','ADMIN','Planifica y aprueba compras'),
('ROL-0002','ANALISTA DE COMPRAS','OPERATIVO','Gestiona solicitudes y cotizaciones'),
('ROL-0003','JEFE DE ALMACEN','ADMIN','Administra inventarios y recepciones'),
('ROL-0004','ALMACENERO','OPERATIVO','Recepción y control físico'),
('ROL-0005','JEFE DE TRANSPORTE','ADMIN','Coordina despacho y reparto'),
('ROL-0006','CHOFER','OPERATIVO','Entrega de mercancía'),
('ROL-0007','JEFE DE MANTENIMIENTO','ADMIN','Gestiona mantenimiento de equipos'),
('ROL-0008','TECNICO DE MANTENIMIENTO','OPERATIVO','Solicita insumos y ejecuta reparaciones'),
('ROL-0009','JEFE DE VENTAS','ADMIN','Gestiona ventas y requerimientos a compras'),
('ROL-0010','INSPECTOR CALIDAD','OPERATIVO','Verificación de conformidad');

-- =============================================================
-- EMPLEADOS (20)  — correos únicos y teléfonos válidos
-- =============================================================
INSERT INTO MODULO_ABASTECIMIENTO.EMPLEADO
(id_empleado,id_area,numero_contacto,correo_contacto,fecha_registro) VALUES
('EMP-0001','AREA-0002','987654321','carlos.ruiz@ferremig.pe','2025-01-05'),
('EMP-0002','AREA-0002','987654322','laura.soto@ferremig.pe','2025-01-06'),
('EMP-0003','AREA-0002','912345678','andrea.paz@ferremig.pe','2025-01-10'),
('EMP-0004','AREA-0002','912345679','javier.quispe@ferremig.pe','2025-01-12'),
('EMP-0005','AREA-0001','934567890','miguel.vera@ferremig.pe','2025-01-07'),
('EMP-0006','AREA-0001','945678901','lucia.moran@ferremig.pe','2025-01-08'),
('EMP-0007','AREA-0001','956789012','ronald.perez@ferremig.pe','2025-01-15'),
('EMP-0008','AREA-0004','967890123','raul.castro@ferremig.pe','2025-01-09'),
('EMP-0009','AREA-0004','978901234','jose.salas@ferremig.pe','2025-01-20'),
('EMP-0010','AREA-0005','989012345','mariana.torres@ferremig.pe','2025-01-11'),
('EMP-0011','AREA-0005','900123456','juan.espinoza@ferremig.pe','2025-01-22'),
('EMP-0012','AREA-0005','901234567','karla.matos@ferremig.pe','2025-01-25'),
('EMP-0013','AREA-0003','902345678','ana.valdez@ferremig.pe','2025-01-18'),
('EMP-0014','AREA-0003','903456789','diego.bravo@ferremig.pe','2025-01-19'),
('EMP-0015','AREA-0003','904567890','melissa.huaman@ferremig.pe','2025-01-21'),
('EMP-0016','AREA-0004','905678901','sandro.palomino@ferremig.pe','2025-02-01'),
('EMP-0017','AREA-0002','906789012','camila.vera@ferremig.pe','2025-02-03'),
('EMP-0018','AREA-0001','907890123','ricardo.leyva@ferremig.pe','2025-02-05'),
('EMP-0019','AREA-0002','908901234','ines.rivera@ferremig.pe','2025-02-06'),
('EMP-0020','AREA-0004','909012345','edgar.lopez@ferremig.pe','2025-02-07');

-- =============================================================
-- ROL_EMPLEADO (asignaciones coherentes)
-- =============================================================
INSERT INTO MODULO_ABASTECIMIENTO.ROL_EMPLEADO (id_empleado,id_rol,fecha_asignacion) VALUES
('EMP-0001','ROL-0001','2025-01-05'),
('EMP-0002','ROL-0002','2025-01-06'),
('EMP-0003','ROL-0002','2025-01-10'),
('EMP-0004','ROL-0010','2025-01-12'),
('EMP-0005','ROL-0003','2025-01-07'),
('EMP-0006','ROL-0004','2025-01-08'),
('EMP-0007','ROL-0004','2025-01-15'),
('EMP-0008','ROL-0005','2025-01-09'),
('EMP-0009','ROL-0006','2025-01-20'),
('EMP-0010','ROL-0007','2025-01-11'),
('EMP-0011','ROL-0008','2025-01-22'),
('EMP-0012','ROL-0008','2025-01-25'),
('EMP-0013','ROL-0009','2025-01-18'),
('EMP-0014','ROL-0009','2025-01-19'),
('EMP-0015','ROL-0009','2025-01-21'),
('EMP-0016','ROL-0006','2025-02-01'),
('EMP-0017','ROL-0002','2025-02-03'),
('EMP-0018','ROL-0004','2025-02-05'),
('EMP-0019','ROL-0002','2025-02-06'),
('EMP-0020','ROL-0006','2025-02-07');

-- =============================================================
-- PRODUCTOS (20) — unidades del catálogo permitido, precios referenciales
-- =============================================================
INSERT INTO MODULO_ABASTECIMIENTO.PRODUCTO (id_producto,nombre_producto,unidad_medida,precio_base) VALUES
('PROD-0001','Cemento Portland Tipo I 42.5kg','SACO',28.90),
('PROD-0002','Fierro Corrugado 3/8"','m',8.50),
('PROD-0003','Ladrillo King Kong 18 huecos','UNIDAD',1.00),
('PROD-0004','Pintura Latex Interior 1 galón','L',35.90),
('PROD-0005','Thinner Industrial 1L','L',12.50),
('PROD-0006','Clavo de Acero 3" x 1kg','KG',9.80),
('PROD-0007','Cinta Métrica 5m','UNIDAD',16.90),
('PROD-0008','Taladro Percutor 750W','UNIDAD',259.00),
('PROD-0009','Tubo PVC 1" presión','m',4.20),
('PROD-0010','Llave Stillson 14"','UNIDAD',49.00),
('PROD-0011','Silicona Neutra 300ml','TUBO',11.50),
('PROD-0012','Guantes de Nitrilo Par','UNIDAD',4.80),
('PROD-0013','Disco Corte Metal 4.5"','UNIDAD',3.50),
('PROD-0014','Malla Acma 6mm','m²',16.00),
('PROD-0015','Yeso en Polvo 25kg','SACO',18.90),
('PROD-0016','Brocha 2" Profesional','UNIDAD',8.90),
('PROD-0017','Rodillo Pintura 9"','UNIDAD',14.90),
('PROD-0018','Tubo PPR 3/4"','m',6.80),
('PROD-0019','Tornillo Drywall 1" x 1kg','KG',12.60),
('PROD-0020','Laca Transparente 1L','L',22.40);

-- =============================================================
-- TIPO (10) y PRODUCTO_TIPO (clasificación realista)
-- =============================================================
INSERT INTO MODULO_ABASTECIMIENTO.TIPO (codigo_tipo,nombre_tipo) VALUES
('TIPO-0001','CEMENTO'),
('TIPO-0002','ACERO'),
('TIPO-0003','LADRILLO'),
('TIPO-0004','PINTURA'),
('TIPO-0005','SOLVENTE'),
('TIPO-0006','FIJACION'),
('TIPO-0007','HERRAMIENTA'),
('TIPO-0008','PVC/PPR'),
('TIPO-0009','PLOMERIA'),
('TIPO-0010','EPP/ACCESORIO');

INSERT INTO MODULO_ABASTECIMIENTO.PRODUCTO_TIPO (codigo_tipo,id_producto) VALUES
('TIPO-0001','PROD-0001'),
('TIPO-0002','PROD-0002'),
('TIPO-0003','PROD-0003'),
('TIPO-0004','PROD-0004'),
('TIPO-0005','PROD-0005'),
('TIPO-0006','PROD-0006'),
('TIPO-0007','PROD-0007'),
('TIPO-0007','PROD-0008'),
('TIPO-0008','PROD-0009'),
('TIPO-0009','PROD-0010'),
('TIPO-0006','PROD-0011'),
('TIPO-0010','PROD-0012'),
('TIPO-0006','PROD-0013'),
('TIPO-0002','PROD-0014'),
('TIPO-0001','PROD-0015'),
('TIPO-0007','PROD-0016'),
('TIPO-0007','PROD-0017'),
('TIPO-0008','PROD-0018'),
('TIPO-0006','PROD-0019'),
('TIPO-0004','PROD-0020');

-- =============================================================
-- PROVEEDORES (15)  — RUC válidos y únicos
-- =============================================================
INSERT INTO MODULO_ABASTECIMIENTO.PROVEEDOR
(id_proveedor,nombre_comercial,razon_social,ruc) VALUES
('PROV-0001','CEM-PERU','CEMENTOS PERU S.A.C.','20123456789'),
('PROV-0002','ACERMAX','ACEROS MAXIMOS S.A.','20567891234'),
('PROV-0003','LADRIPERU','LADRILLOS ANDINOS S.A.C.','20987654321'),
('PROV-0004','PINTULAC','PINTURAS DEL PACIFICO S.A.','20654321987'),
('PROV-0005','SOLVIN','SOLVENTES INDUSTRIALES S.A.C.','20456789123'),
('PROV-0006','FERREFIX','FIJACIONES Y CLAVOS S.A.','20876543219'),
('PROV-0007','HERRAPRIME','HERRAMIENTAS PRIME S.A.C.','20765432198'),
('PROV-0008','PVC-PERU','TUBERIAS PVC DEL PERU S.A.C.','20345678912'),
('PROV-0009','PROTEC','EPP Y SEGURIDAD S.A.C.','20111222334'),
('PROV-0010','MEGA-TOOLS','MEGA TOOLS S.R.L.','20555123456'),
('PROV-0011','PPR-LINE','SOLUCIONES PPR S.A.C.','20999111222'),
('PROV-0012','PINTURARTE','PINTURAS Y DECORACIONES S.A.C.','20122334455'),
('PROV-0013','MADERERA SUR','MADERERA DEL SUR S.A.C.','20666123456'),
('PROV-0014','LUBRISOL','LUBRICANTES Y SOLVENTES S.A.C.','20777123456'),
('PROV-0015','ANDES STEEL','ACEROS DE LOS ANDES S.A.','20888123456');

-- PROVEEDOR_CONTACTO (al menos CORREO por proveedor)
INSERT INTO MODULO_ABASTECIMIENTO.PROVEEDOR_CONTACTO (id_proveedor,tipo_contacto,valor_contacto) VALUES
('PROV-0001','CORREO','ventas@cem-peru.com'),
('PROV-0001','TELEFONO','014567890'),
('PROV-0002','CORREO','contacto@acermax.com'),
('PROV-0003','CORREO','comercial@ladriperu.pe'),
('PROV-0004','CORREO','pedidos@pintulac.pe'),
('PROV-0005','CORREO','ventas@solvin.pe'),
('PROV-0006','CORREO','ventas@ferrefix.com'),
('PROV-0007','CORREO','ventas@herraprime.com'),
('PROV-0008','CORREO','ventas@pvcp.com'),
('PROV-0009','CORREO','ventas@protec-epp.pe'),
('PROV-0010','CORREO','ventas@mega-tools.pe'),
('PROV-0011','CORREO','ventas@ppr-line.pe'),
('PROV-0012','CORREO','contacto@pinturarte.pe'),
('PROV-0013','CORREO','ventas@madererasur.pe'),
('PROV-0014','CORREO','ventas@lubrisol.pe'),
('PROV-0015','CORREO','contacto@andessteel.com');

-- =============================================================
-- PRODUCTO_PROVEEDOR (catálogo cruzado, coherente con precios base)
-- =============================================================
INSERT INTO MODULO_ABASTECIMIENTO.PRODUCTO_PROVEEDOR (id_producto,id_proveedor,precio_unitario_ref) VALUES
('PROD-0001','PROV-0001',27.80),
('PROD-0001','PROV-0015',28.50),
('PROD-0002','PROV-0002',7.90),
('PROD-0002','PROV-0015',8.20),
('PROD-0003','PROV-0003',0.95),
('PROD-0004','PROV-0004',33.50),
('PROD-0004','PROV-0012',34.00),
('PROD-0005','PROV-0005',11.80),
('PROD-0005','PROV-0014',12.10),
('PROD-0006','PROV-0006',9.20),
('PROD-0006','PROV-0007',9.60),
('PROD-0007','PROV-0007',15.90),
('PROD-0008','PROV-0007',249.00),
('PROD-0008','PROV-0010',252.00),
('PROD-0009','PROV-0008',3.90),
('PROD-0010','PROV-0007',46.00),
('PROD-0011','PROV-0006',10.90),
('PROD-0012','PROV-0009',4.50),
('PROD-0013','PROV-0006',3.20),
('PROD-0014','PROV-0002',15.50),
('PROD-0015','PROV-0001',18.20),
('PROD-0016','PROV-0007',8.50),
('PROD-0017','PROV-0007',14.20),
('PROD-0018','PROV-0011',6.40),
('PROD-0019','PROV-0006',12.10),
('PROD-0020','PROV-0012',21.90);

-- =============================================================
-- ALMACEN (5) y RECEPCION_ALMACEN se llenará luego (1:1 con recepción)
-- =============================================================
INSERT INTO MODULO_ABASTECIMIENTO.ALMACEN (id_almacen,nro_almacen,ubicacion) VALUES
('ALM-0001','ALM-CENTRAL','Av. Paramonga Mz. A Lote 3, Programa de Viviendas Las Palmas I'),
('ALM-0002','ALM-SECUNDARIO','Av. Paramonga Mz. A Lote 4, Programa de Viviendas Las Palmas I'),
('ALM-0003','TIENDA','Av. Paramonga Mz. A Lote 2, Programa de Viviendas Las Palmas I');

-- =============================================================
-- SOLICITUDES DE COTIZACION (12)  — estados válidos
-- =============================================================
INSERT INTO MODULO_ABASTECIMIENTO.SOLICITUD_DE_COTIZACION
(id_solicitud,id_empleado,fecha_emision_solicitud,estado) VALUES
('SC-0001','EMP-0002','2025-02-10','ENVIADA'),
('SC-0002','EMP-0017','2025-02-11','COTIZADA'),
('SC-0003','EMP-0019','2025-02-12','COTIZADA'),
('SC-0004','EMP-0003','2025-02-13','ENVIADA'),
('SC-0005','EMP-0002','2025-02-14','CREADA'),
('SC-0006','EMP-0017','2025-02-15','ENVIADA'),
('SC-0007','EMP-0019','2025-02-16','COTIZADA'),
('SC-0008','EMP-0003','2025-02-17','ENVIADA'),
('SC-0009','EMP-0002','2025-02-18','COTIZADA'),
('SC-0010','EMP-0017','2025-02-19','ENVIADA'),
('SC-0011','EMP-0019','2025-02-20','COTIZADA'),
('SC-0012','EMP-0003','2025-02-21','ENVIADA');

-- DETALLE_SOLICITUD (cada SC con 1–3 productos)
INSERT INTO MODULO_ABASTECIMIENTO.DETALLE_SOLICITUD (id_producto,id_solicitud,cantidad_solicitada) VALUES
('PROD-0001','SC-0001',150), ('PROD-0003','SC-0001',800),
('PROD-0002','SC-0002',900), ('PROD-0006','SC-0002',80),
('PROD-0004','SC-0003',60),  ('PROD-0005','SC-0003',120), ('PROD-0008','SC-0003',8),
('PROD-0009','SC-0004',300), ('PROD-0011','SC-0004',80),
('PROD-0010','SC-0005',20),  ('PROD-0012','SC-0005',200), ('PROD-0013','SC-0005',100),
('PROD-0014','SC-0006',50),  ('PROD-0015','SC-0006',100),
('PROD-0016','SC-0007',120), ('PROD-0017','SC-0007',100),
('PROD-0018','SC-0008',250), ('PROD-0019','SC-0008',90),
('PROD-0020','SC-0009',70),  ('PROD-0004','SC-0009',40),
('PROD-0007','SC-0010',60),  ('PROD-0008','SC-0010',10),
('PROD-0005','SC-0011',150), ('PROD-0011','SC-0011',90),
('PROD-0002','SC-0012',600), ('PROD-0009','SC-0012',200);

-- =============================================================
-- COTIZACIONES (18) — fechas ≥ solicitud; garantía ≥ emisión
-- =============================================================
INSERT INTO MODULO_ABASTECIMIENTO.COTIZACION
(id_cotizacion,id_solicitud,id_proveedor,fecha_emision_cotizacion,fecha_garantia,monto_total,plazo_entrega) VALUES
('COT-0001','SC-0002','PROV-0002','2025-02-13','2025-04-15', 7450.00,7),
('COT-0002','SC-0002','PROV-0006','2025-02-13','2025-04-20', 6120.00,10),
('COT-0003','SC-0003','PROV-0004','2025-02-16','2025-05-01', 5250.00,5),
('COT-0004','SC-0003','PROV-0005','2025-02-16','2025-05-10', 4980.00,6),
('COT-0005','SC-0001','PROV-0001','2025-02-11','2025-04-10', 4700.00,4),
('COT-0006','SC-0004','PROV-0008','2025-02-19','2025-04-30', 2150.00,3),
('COT-0007','SC-0005','PROV-0007','2025-02-15','2025-04-20', 2890.00,5),
('COT-0008','SC-0006','PROV-0015','2025-02-16','2025-04-25', 3950.00,8),
('COT-0009','SC-0007','PROV-0010','2025-02-18','2025-05-20', 2650.00,6),
('COT-0010','SC-0008','PROV-0011','2025-02-20','2025-05-15', 2390.00,4),
('COT-0011','SC-0009','PROV-0012','2025-02-20','2025-05-01', 1890.00,5),
('COT-0012','SC-0010','PROV-0010','2025-02-21','2025-04-30', 1990.00,4),
('COT-0013','SC-0011','PROV-0014','2025-02-22','2025-05-10', 3290.00,7),
('COT-0014','SC-0012','PROV-0015','2025-02-22','2025-05-05', 7250.00,9),
('COT-0015','SC-0006','PROV-0002','2025-02-17','2025-05-01', 4020.00,9),
('COT-0016','SC-0007','PROV-0007','2025-02-18','2025-05-30', 2750.00,7),
('COT-0017','SC-0009','PROV-0004','2025-02-21','2025-05-20', 1920.00,6),
('COT-0018','SC-0011','PROV-0005','2025-02-23','2025-05-25', 3350.00,8);

-- DETALLE_COTIZACION — productos deben existir en la SC asociada; modalidad CONTADO/CREDITO
INSERT INTO MODULO_ABASTECIMIENTO.DETALLE_COTIZACION (id_cotizacion,id_producto,costo_total,modalidad_pago) VALUES
-- COT-0001 (SC-0002: PROD-0002, PROD-0006)
('COT-0001','PROD-0002',6320.00,'CREDITO'),
('COT-0001','PROD-0006',1130.00,'CREDITO'),
-- COT-0002 alternativa
('COT-0002','PROD-0002',5600.00,'CONTADO'),
('COT-0002','PROD-0006',520.00,'CONTADO'),
-- COT-0003 (SC-0003: 0004,0005,0008)
('COT-0003','PROD-0004',1440.00,'CONTADO'),
('COT-0003','PROD-0005',1180.00,'CONTADO'),
('COT-0003','PROD-0008',2630.00,'CONTADO'),
-- COT-0004 alt
('COT-0004','PROD-0004',1400.00,'CONTADO'),
('COT-0004','PROD-0005',1180.00,'CONTADO'),
('COT-0004','PROD-0008',2400.00,'CONTADO'),
-- COT-0005 (SC-0001: 0001,0003)
('COT-0005','PROD-0001',3300.00,'CONTADO'),
('COT-0005','PROD-0003',1400.00,'CONTADO'),
-- COT-0006 (SC-0004: 0009,0011)
('COT-0006','PROD-0009',1800.00,'CONTADO'),
('COT-0006','PROD-0011',350.00,'CONTADO'),
-- COT-0007 (SC-0005: 0010,0012,0013)
('COT-0007','PROD-0010',900.00,'CONTADO'),
('COT-0007','PROD-0012',700.00,'CONTADO'),
('COT-0007','PROD-0013',1290.00,'CONTADO'),
-- COT-0008 (SC-0006: 0014,0015)
('COT-0008','PROD-0014',2100.00,'CREDITO'),
('COT-0008','PROD-0015',1850.00,'CREDITO'),
-- COT-0009 (SC-0007: 0016,0017)
('COT-0009','PROD-0016',1250.00,'CONTADO'),
('COT-0009','PROD-0017',1400.00,'CONTADO'),
-- COT-0010 (SC-0008: 0018,0019)
('COT-0010','PROD-0018',1700.00,'CONTADO'),
('COT-0010','PROD-0019',690.00,'CONTADO'),
-- COT-0011 (SC-0009: 0020,0004)
('COT-0011','PROD-0020',1200.00,'CONTADO'),
('COT-0011','PROD-0004',690.00,'CONTADO'),
-- COT-0012 (SC-0010: 0007,0008)
('COT-0012','PROD-0007',450.00,'CONTADO'),
('COT-0012','PROD-0008',1540.00,'CONTADO'),
-- COT-0013 (SC-0011: 0005,0011)
('COT-0013','PROD-0005',2100.00,'CREDITO'),
('COT-0013','PROD-0011',1190.00,'CREDITO'),
-- COT-0014 (SC-0012: 0002,0009)
('COT-0014','PROD-0002',5200.00,'CREDITO'),
('COT-0014','PROD-0009',2050.00,'CREDITO'),
-- COT-0015 alt SC-0006
('COT-0015','PROD-0014',2200.00,'CONTADO'),
('COT-0015','PROD-0015',1820.00,'CONTADO'),
-- COT-0016 alt SC-0007
('COT-0016','PROD-0016',1300.00,'CREDITO'),
('COT-0016','PROD-0017',1450.00,'CREDITO'),
-- COT-0017 alt SC-0009
('COT-0017','PROD-0020',1220.00,'CONTADO'),
('COT-0017','PROD-0004',700.00,'CONTADO'),
-- COT-0018 alt SC-0011
('COT-0018','PROD-0005',2150.00,'CONTADO'),
('COT-0018','PROD-0011',1200.00,'CONTADO');

-- =============================================================
-- PEDIDOS DE ABASTECIMIENTO (10) + DETALLE_PEDIDO (coherente)
-- estados: CREADO/REVISADO/EN PROCESO/ATENDIDO
-- =============================================================
INSERT INTO MODULO_ABASTECIMIENTO.PEDIDO_DE_ABASTECIMIENTO
(id_pedido,id_empleado,fecha_pedido,hora_pedido,estado_pedido) VALUES
('PED-0001','EMP-0011','2025-02-09','09:00','CREADO'),
('PED-0002','EMP-0012','2025-02-10','10:15','REVISADO'),
('PED-0003','EMP-0010','2025-02-11','11:30','EN PROCESO'),
('PED-0004','EMP-0013','2025-02-12','14:00','CREADO'),
('PED-0005','EMP-0005','2025-02-13','08:45','REVISADO'),
('PED-0006','EMP-0007','2025-02-14','09:20','EN PROCESO'),
('PED-0007','EMP-0015','2025-02-15','10:05','CREADO'),
('PED-0008','EMP-0010','2025-02-16','16:40','EN PROCESO'),
('PED-0009','EMP-0011','2025-02-17','08:25','REVISADO'),
('PED-0010','EMP-0012','2025-02-18','15:10','CREADO');

INSERT INTO MODULO_ABASTECIMIENTO.DETALLE_PEDIDO
(id_pedido,id_producto,cantidad_requerida,fecha_requerida,ubicacion_envio) VALUES
('PED-0001','PROD-0001',100,'2025-02-12','ALMACEN CENTRAL'),
('PED-0001','PROD-0003',400,'2025-02-12','ALMACEN CENTRAL'),
('PED-0002','PROD-0002',700,'2025-02-20','Av. Los Ángeles 820, Urb. José Carlos Mariátegui - V.M. de Triunfo'),
('PED-0002','PROD-0006',50,'2025-02-20','Av. Los Ángeles 820, Urb. José Carlos Mariátegui - V.M. de Triunfo'),
('PED-0003','PROD-0004',30,'2025-02-22','TIENDA'),
('PED-0003','PROD-0005',80,'2025-02-22','TIENDA'),
('PED-0004','PROD-0009',200,'2025-02-23','Av. Perú 2750, Urb. San Germán - San Martín de Porres'),
('PED-0004','PROD-0011',60,'2025-02-23','Av. Perú 2750, Urb. San Germán - San Martín de Porres'),
('PED-0005','PROD-0014',40,'2025-02-25','ALMACEN CENTRAL'),
('PED-0006','PROD-0016',100,'2025-02-26','TIENDA'),
('PED-0006','PROD-0017',80,'2025-02-26','TIENDA'),
('PED-0007','PROD-0018',180,'2025-02-27','Av. Perú 2750, Urb. San Germán - San Martín de Porres'),
('PED-0007','PROD-0019',90,'2025-02-27','Av. Perú 2750, Urb. San Germán - San Martín de Porres'),
('PED-0008','PROD-0020',70,'2025-03-01','ALMACEN CENTRAL'),
('PED-0009','PROD-0012',250,'2025-02-28','ALMACEN CENTRAL'),
('PED-0010','PROD-0010',25,'2025-03-02','TIENDA');

-- =============================================================
-- ORDENES DE COMPRA (10) — elegimos cotizaciones “ganadoras”
-- estados: EMITIDA/APROBADA/ENVIADA/PARCIAL/COMPLETADA
-- =============================================================
INSERT INTO MODULO_ABASTECIMIENTO.ORDEN_DE_COMPRA
(id_orden,id_cotizacion,fecha_emision,monto,estado) VALUES
('OC-0001','COT-0005','2025-02-12',4700.00,'EMITIDA'),
('OC-0002','COT-0002','2025-02-14',6120.00,'APROBADA'),
('OC-0003','COT-0003','2025-02-17',5250.00,'ENVIADA'),
('OC-0004','COT-0006','2025-02-20',2150.00,'EMITIDA'),
('OC-0005','COT-0007','2025-02-16',2890.00,'APROBADA'),
('OC-0006','COT-0008','2025-02-18',3950.00,'ENVIADA'),
('OC-0007','COT-0010','2025-02-21',2390.00,'APROBADA'),
('OC-0008','COT-0011','2025-02-22',1890.00,'APROBADA'),
('OC-0009','COT-0014','2025-02-23',7250.00,'ENVIADA'),
('OC-0010','COT-0012','2025-02-22',1990.00,'EMITIDA');

-- DETALLE_OC — productos deben existir en su cotización asociada (trigger lo valida)
INSERT INTO MODULO_ABASTECIMIENTO.DETALLE_OC (id_orden,id_producto) VALUES
('OC-0001','PROD-0001'),('OC-0001','PROD-0003'),
('OC-0002','PROD-0002'),('OC-0002','PROD-0006'),
('OC-0003','PROD-0004'),('OC-0003','PROD-0005'),('OC-0003','PROD-0008'),
('OC-0004','PROD-0009'),('OC-0004','PROD-0011'),
('OC-0005','PROD-0010'),('OC-0005','PROD-0012'),('OC-0005','PROD-0013'),
('OC-0006','PROD-0014'),('OC-0006','PROD-0015'),
('OC-0007','PROD-0018'),('OC-0007','PROD-0019'),
('OC-0008','PROD-0020'),('OC-0008','PROD-0004'),
('OC-0009','PROD-0002'),('OC-0009','PROD-0009'),
('OC-0010','PROD-0007'),('OC-0010','PROD-0008');

-- =============================================================
-- MONITOREO_DE_COMPRA (10) — fecha_entrega ≥ fecha_emision
-- estados: PENDIENTE/ENTREGADO/OBSERVADO
-- =============================================================
INSERT INTO MODULO_ABASTECIMIENTO.MONITOREO_DE_COMPRA
(id_monitoreo,id_orden,fecha_entrega,hora_entrega,estado) VALUES
('MON-0001','OC-0001','2025-02-15','15:00','ENTREGADO'),
('MON-0002','OC-0002','2025-02-21','11:30','ENTREGADO'),
('MON-0003','OC-0003','2025-02-22','16:45','OBSERVADO'),
('MON-0004','OC-0004','2025-02-24','10:00','PENDIENTE'),
('MON-0005','OC-0005','2025-02-20','09:40','ENTREGADO'),
('MON-0006','OC-0006','2025-02-27','14:15','ENTREGADO'),
('MON-0007','OC-0007','2025-02-25','13:20','ENTREGADO'),
('MON-0008','OC-0008','2025-02-26','10:30','ENTREGADO'),
('MON-0009','OC-0009','2025-03-03','12:10','PENDIENTE'),
('MON-0010','OC-0010','2025-02-25','08:55','ENTREGADO');

-- =============================================================
-- RECEPCIONES (10) — fecha_recepcion ≥ fecha_emision OC y horas coherentes
-- =============================================================
INSERT INTO MODULO_ABASTECIMIENTO.RECEPCION
(id_recepcion,id_orden,fecha_recepcion,hora_inicio_recepcion,hora_fin_recepcion,
 fecha_programada,hora_programada,empleado_encargado,observacion) VALUES
('REC-0001','OC-0001','2025-02-15','14:30','15:30','2025-02-15','14:00','EMP-0006','Ok'),
('REC-0002','OC-0002','2025-02-21','10:30','12:00','2025-02-21','10:00','EMP-0007','Ok'),
('REC-0003','OC-0003','2025-02-22','16:00','17:30','2025-02-22','15:30','EMP-0005','Falla en Calidad'),
('REC-0004','OC-0004','2025-02-24','09:00','10:00','2025-02-24','08:30','EMP-0006','Programado'),
('REC-0005','OC-0005','2025-02-20','09:10','10:10','2025-02-20','08:45','EMP-0005','Ok'),
('REC-0006','OC-0006','2025-02-27','13:40','14:40','2025-02-27','13:00','EMP-0006','Ok'),
('REC-0007','OC-0007','2025-02-25','12:50','13:40','2025-02-25','12:30','EMP-0007','Ok'),
('REC-0008','OC-0008','2025-02-26','10:10','11:00','2025-02-26','09:40','EMP-0005','Ok'),
('REC-0009','OC-0009','2025-03-04','11:30','12:30','2025-03-04','11:00','EMP-0006','Entrega parcial'),
('REC-0010','OC-0010','2025-02-25','08:30','09:15','2025-02-25','08:00','EMP-0005','Ok');

-- DETALLE_RECEPCION — cantidad_recibida = conforme + defectuosa (>0)
INSERT INTO MODULO_ABASTECIMIENTO.DETALLE_RECEPCION
(id_recepcion,id_producto,cantidad_conforme,cantidad_defectuosa,cantidad_recibida) VALUES
-- REC-0001 (cemento + ladrillo)
('REC-0001','PROD-0001',100,0,100),
('REC-0001','PROD-0003',400,0,400),
-- REC-0002 (acero + clavos)
('REC-0002','PROD-0002',700,0,700),
('REC-0002','PROD-0006',50,0,50),
-- REC-0003 (pintura + thinner + taladro con observación)
('REC-0003','PROD-0004',30,0,30),
('REC-0003','PROD-0005',80,0,80),
('REC-0003','PROD-0008',5,1,6),
-- REC-0004 (PVC + silicona)
('REC-0004','PROD-0009',200,0,200),
('REC-0004','PROD-0011',60,0,60),
-- REC-0005 (kit herramientas)
('REC-0005','PROD-0010',20,0,20),
('REC-0005','PROD-0012',200,0,200),
('REC-0005','PROD-0013',100,0,100),
-- REC-0006 (malla + yeso)
('REC-0006','PROD-0014',50,0,50),
('REC-0006','PROD-0015',100,0,100),
-- REC-0007 (brochas + rodillos)
('REC-0007','PROD-0016',100,0,100),
('REC-0007','PROD-0017',80,0,80),
-- REC-0008 (PPR + tornillo drywall)
('REC-0008','PROD-0018',180,0,180),
('REC-0008','PROD-0019',90,0,90),
-- REC-0009 (laca + pintura) parcial
('REC-0009','PROD-0020',60,0,60),
('REC-0009','PROD-0004',30,0,30),
-- REC-0010 (cinta + taladro)
('REC-0010','PROD-0007',60,0,60),
('REC-0010','PROD-0008',10,0,10);

-- =============================================================
-- GUIA_DE_REMISION (1:1 con recepción) — formato NNN-NNNNNNNN
-- =============================================================
INSERT INTO MODULO_ABASTECIMIENTO.GUIA_DE_REMISION
(serie_correlativo,id_recepcion,fecha_emision_guia,fecha_traslado_guia) VALUES
('101-00000001','REC-0001','2025-02-15','2025-02-15'),
('101-00000002','REC-0002','2025-02-21','2025-02-21'),
('101-00000003','REC-0003','2025-02-22','2025-02-22'),
('101-00000004','REC-0004','2025-02-24','2025-02-24'),
('101-00000005','REC-0005','2025-02-20','2025-02-20'),
('101-00000006','REC-0006','2025-02-27','2025-02-27'),
('101-00000007','REC-0007','2025-02-25','2025-02-25'),
('101-00000008','REC-0008','2025-02-26','2025-02-26'),
('101-00000009','REC-0009','2025-03-04','2025-03-04'),
('101-00000010','REC-0010','2025-02-25','2025-02-25');

-- =============================================================
-- RECEPCION_ALMACEN (1:1 por recepción)
-- =============================================================
INSERT INTO MODULO_ABASTECIMIENTO.RECEPCION_ALMACEN (id_recepcion,id_almacen) VALUES
('REC-0001','ALM-0001'),
('REC-0002','ALM-0001'),
('REC-0003','ALM-0002'),
('REC-0004','ALM-0003'),
('REC-0005','ALM-0001'),
('REC-0006','ALM-0001'),
('REC-0007','ALM-0001'),
('REC-0008','ALM-0002'),
('REC-0009','ALM-0003'),
('REC-0010','ALM-0001');

-- =============================================================
-- PEDIDO_DE_TRANSPORTE (1:1 con recepción) — estados válidos
-- =============================================================
INSERT INTO MODULO_ABASTECIMIENTO.PEDIDO_DE_TRANSPORTE
(id_pedido_transporte,id_recepcion,fecha_pedido_transporte,hora_pedido_transporte,estado_pedido_transporte) VALUES
('PT-0001','REC-0001','2025-02-15','13:30','COMPLETADO'),
('PT-0002','REC-0002','2025-02-21','09:30','COMPLETADO'),
('PT-0003','REC-0003','2025-02-22','15:00','EN PROCESO'),
('PT-0004','REC-0004','2025-02-24','08:00','RECIBIDO'),
('PT-0005','REC-0005','2025-02-20','08:30','COMPLETADO'),
('PT-0006','REC-0006','2025-02-27','12:30','COMPLETADO'),
('PT-0007','REC-0007','2025-02-25','12:10','COMPLETADO'),
('PT-0008','REC-0008','2025-02-26','09:20','COMPLETADO'),
('PT-0009','REC-0009','2025-03-04','10:45','EN PROCESO'),
('PT-0010','REC-0010','2025-02-25','08:10','COMPLETADO');

-- =============================================================
-- RECLAMOS (3) + NOTAS DE CRÉDITO y CAMBIOS (resolución de incidencias)
-- estados: ABIERTO/EN_PROCESO/ACEPTADO/RECHAZADO
-- =============================================================
INSERT INTO MODULO_ABASTECIMIENTO.RECLAMO
(id_reclamo,id_recepcion,fecha_reclamo,hora_reclamo,estado_reclamo) VALUES
('RECQ-0001','REC-0003','2025-02-23','09:15','ABIERTO'),
('RECQ-0002','REC-0009','2025-03-05','10:00','EN_PROCESO'),
('RECQ-0003','REC-0002','2025-02-22','08:30','ACEPTADO');

INSERT INTO MODULO_ABASTECIMIENTO.NOTA_DE_CREDITO
(id_reclamo,nro_nc,fecha_nc,motivo_nc,monto_nc,descripcion_nc) VALUES
('RECQ-0001',1,'2025-02-24','Producto defectuoso',259.00,'Taladro percutor con falla'),
('RECQ-0002',1,'2025-03-06','Entrega parcial',230.00,'Faltante de 1 unidad de pintura'),
('RECQ-0003',1,'2025-02-23','Demora de entrega',150.00,'Compensación por retraso');

INSERT INTO MODULO_ABASTECIMIENTO.CAMBIO_DE_PRODUCTO
(id_reclamo,nro_cambio,fecha_cambio,hora_cambio,motivo_cambio,descripcion_cambio) VALUES
('RECQ-0001',1,'2025-02-25','11:30','Reposición','Cambio de 1 taladro percutor'),
('RECQ-0002',1,'2025-03-07','15:00','Reposición parcial','Reposición de 1 unidad de pintura');
