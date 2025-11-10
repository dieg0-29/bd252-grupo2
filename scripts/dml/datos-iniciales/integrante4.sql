-- =============================================================
-- VACIADO DE TABLAS (CON REINICIO DE SERIALES)
-- =============================================================
TRUNCATE TABLE
  MODULO_ABASTECIMIENTO.PEDIDO_TRANSPORTE,
  MODULO_ABASTECIMIENTO.CAMBIO_PRODUCTO,
  MODULO_ABASTECIMIENTO.NOTA_CREDITO,
  MODULO_ABASTECIMIENTO.INCIDENCIA,
  MODULO_ABASTECIMIENTO.RECLAMO,
  MODULO_ABASTECIMIENTO.DETALLE_GUIA_EXTERNA,
  MODULO_ABASTECIMIENTO.GUIA_REMISION_EXTERNA,
  MODULO_ABASTECIMIENTO.DETALLE_RECEPCION,
  MODULO_ABASTECIMIENTO.RECEPCION,
  MODULO_ABASTECIMIENTO.MONITOREO_COMPRA,
  MODULO_ABASTECIMIENTO.DETALLE_OC,
  MODULO_ABASTECIMIENTO.ORDEN_COMPRA,
  MODULO_ABASTECIMIENTO.DETALLE_COTIZACION,
  MODULO_ABASTECIMIENTO.COTIZACION,
  MODULO_ABASTECIMIENTO.DETALLE_SOLICITUD,
  MODULO_ABASTECIMIENTO.SOLICITUD_COTIZACION,
  MODULO_ABASTECIMIENTO.DETALLE_PEDIDO,
  MODULO_ABASTECIMIENTO.PEDIDO_ABASTECIMIENTO,
  MODULO_ABASTECIMIENTO.PROVEEDOR_CONTACTO,
  MODULO_ABASTECIMIENTO.PRODUCTO_PROVEEDOR,
  MODULO_ABASTECIMIENTO.PRODUCTO,
  MODULO_ABASTECIMIENTO.CATEGORIA,
  MODULO_ABASTECIMIENTO.PROVEEDOR,
  MODULO_ABASTECIMIENTO.INSTALACION,
  MODULO_ABASTECIMIENTO.USUARIO,
  MODULO_ABASTECIMIENTO.ROL,
  MODULO_ABASTECIMIENTO.AREA,
  MODULO_ABASTECIMIENTO.TIPO_CONTACTO,
  MODULO_ABASTECIMIENTO.ESTADO_PEDIDO_TR
RESTART IDENTITY CASCADE;

-- =============================================================
-- 1) LOOKUPS
-- =============================================================

INSERT INTO MODULO_ABASTECIMIENTO.AREA (valor_area_usuario) VALUES
('ALMACEN'),
('ABASTECIMIENTO'),
('VENTAS'),
('TRANSPORTE'),
('MANTENIMIENTO');

INSERT INTO MODULO_ABASTECIMIENTO.ROL (valor_rol_usuario) VALUES
('JEFE DE ABASTECIMIENTO'),
('ANALISTA DE COMPRAS'),
('JEFE DE ALMACEN'),
('ALMACENERO'),
('JEFE DE TRANSPORTE'),
('CHOFER'),
('JEFE DE MANTENIMIENTO'),
('TECNICO DE MANTENIMIENTO'),
('JEFE DE VENTAS'),
('INSPECTOR CALIDAD');

INSERT INTO MODULO_ABASTECIMIENTO.TIPO_CONTACTO (valor_tipo_contacto) VALUES
('Correo'),
('Telefono'),
('WhatsApp'),
('Direccion');

INSERT INTO MODULO_ABASTECIMIENTO.ESTADO_PEDIDO_TR (descp_estado_pedido_tr) VALUES
('En Proceso'),
('En Ruta'),
('Entregado');

INSERT INTO MODULO_ABASTECIMIENTO.CATEGORIA (rubro, familia, clase) VALUES
('CONSTRUCCION', 'CEMENTOS', 'TIPO I'),
('CONSTRUCCION', 'ACEROS', 'CORRUGADO'),
('CONSTRUCCION', 'LADRILLOS', 'KING KONG'),
('ACABADOS', 'PINTURAS', 'LATEX'),
('ACABADOS', 'SOLVENTES', 'THINNER'),
('FERRETERIA', 'FIJACIONES', 'CLAVOS'),
('FERRETERIA', 'HERRAMIENTAS MANUALES', 'MEDICION'),
('FERRETERIA', 'HERRAMIENTAS ELECTRICAS', 'TALADROS'),
('GASFITERIA', 'TUBERIAS', 'PVC PRESION'),
('GASFITERIA', 'HERRAMIENTAS GASFITERIA', 'LLAVES'),
('FERRETERIA', 'ADHESIVOS', 'SILICONAS'),
('SEGURIDAD', 'EPP', 'GUANTES'),
('FERRETERIA', 'ABRASIVOS', 'DISCOS DE CORTE'),
('CONSTRUCCION', 'ACEROS', 'MALLAS'),
('ACABADOS', 'CONSTRUCCION EN SECO', 'YESO'),
('ACABADOS', 'PINTURAS', 'BROCHAS'),
('ACABADOS', 'PINTURAS', 'RODILLOS'),
('GASFITERIA', 'TUBERIAS', 'PPR'),
('FERRETERIA', 'FIJACIONES', 'TORNILLOS DRYWALL'),
('ACABADOS', 'PINTURAS', 'LACAS');

-- =============================================================
-- 2) ACTORES BÁSICOS
-- =============================================================

INSERT INTO MODULO_ABASTECIMIENTO.USUARIO (cod_area_usuario, cod_rol_usuario, fecha_registro_usuario) VALUES
(2, 1, '2025-01-05'),  -- (Genera cod_usuario 1) JEFE DE ABASTECIMIENTO
(2, 2, '2025-01-06'),  -- (Genera cod_usuario 2) ANALISTA DE COMPRAS
(2, 2, '2025-01-10'),  -- (Genera cod_usuario 3) ANALISTA DE COMPRAS
(2, 10, '2025-01-12'), -- (Genera cod_usuario 4) INSPECTOR CALIDAD
(1, 3, '2025-01-07'),  -- (Genera cod_usuario 5) JEFE DE ALMACEN
(1, 4, '2025-01-08'),  -- (Genera cod_usuario 6) ALMACENERO
(1, 4, '2025-01-15'),  -- (Genera cod_usuario 7) ALMACENERO
(4, 5, '2025-01-09'),  -- (Genera cod_usuario 8) JEFE DE TRANSPORTE
(4, 6, '2025-01-20'),  -- (Genera cod_usuario 9) CHOFER
(5, 7, '2025-01-11'), -- (Genera cod_usuario 10) JEFE DE MANTENIMIENTO
(5, 8, '2025-01-22'), -- (Genera cod_usuario 11) TECNICO DE MANTENIMIENTO
(5, 8, '2025-01-25'), -- (Genera cod_usuario 12) TECNICO DE MANTENIMIENTO
(3, 9, '2025-01-18'), -- (Genera cod_usuario 13) JEFE DE VENTAS
(3, 9, '2025-01-19'), -- (Genera cod_usuario 14) JEFE DE VENTAS
(3, 9, '2025-01-21'), -- (Genera cod_usuario 15) JEFE DE VENTAS
(4, 6, '2025-02-01'), -- (Genera cod_usuario 16) CHOFER
(2, 2, '2025-02-03'), -- (Genera cod_usuario 17) ANALISTA DE COMPRAS
(1, 4, '2025-02-05'), -- (Genera cod_usuario 18) ALMACENERO
(2, 2, '2025-02-06'), -- (Genera cod_usuario 19) ANALISTA DE COMPRAS
(4, 6, '2025-02-07'); -- (Genera cod_usuario 20) CHOFER

INSERT INTO MODULO_ABASTECIMIENTO.PROVEEDOR (nombre_comercial, razon_social, ruc) VALUES
('CEM-PERU', 'CEMENTOS PERU S.A.C.', '20123456789'),             -- (Genera cod_proveedor 1)
('ACERMAX', 'ACEROS MAXIMOS S.A.', '20567891234'),              -- (Genera cod_proveedor 2)
('LADRIPERU', 'LADRILLOS ANDINOS S.A.C.', '20987654321'),       -- (Genera cod_proveedor 3)
('PINTULAC', 'PINTURAS DEL PACIFICO S.A.', '20654321987'),      -- (Genera cod_proveedor 4)
('SOLVIN', 'SOLVENTES INDUSTRIALES S.A.C.', '20456789123'),    -- (Genera cod_proveedor 5)
('FERREFIX', 'FIJACIONES Y CLAVOS S.A.', '20876543219'),        -- (Genera cod_proveedor 6)
('HERRAPRIME', 'HERRAMIENTAS PRIME S.A.C.', '20765432198'),    -- (Genera cod_proveedor 7)
('PVC-PERU', 'TUBERIAS PVC DEL PERU S.A.C.', '20345678912'),    -- (Genera cod_proveedor 8)
('PROTEC', 'EPP Y SEGURIDAD S.A.C.', '20111222334'),           -- (Genera cod_proveedor 9)
('MEGA-TOOLS', 'MEGA TOOLS S.R.L.', '20555123456'),            -- (Genera cod_proveedor 10)
('PPR-LINE', 'SOLUCIONES PPR S.A.C.', '20999111222'),           -- (Genera cod_proveedor 11)
('PINTURARTE', 'PINTURAS Y DECORACIONES S.A.C.', '20122334455'),-- (Genera cod_proveedor 12)
('MADERERA SUR', 'MADERERA DEL SUR S.A.C.', '20666123456'),    -- (Genera cod_proveedor 13)
('LUBRISOL', 'LUBRICANTES Y SOLVENTES S.A.C.', '20777123456'),  -- (Genera cod_proveedor 14)
('ANDES STEEL', 'ACEROS DE LOS ANDES S.A.', '20888123456');    -- (Genera cod_proveedor 15)

-- (PK no es SERIAL, se debe insertar)
INSERT INTO MODULO_ABASTECIMIENTO.INSTALACION (cod_instalacion, nombre_instalacion, direccion) VALUES
('ALM-CEN', 'ALMACEN CENTRAL', 'Av. Paramonga Mz. A Lote 3, Programa de Viviendas Las Palmas I'),
('ALM-SEC', 'ALMACEN SECUNDARIO', 'Av. Paramonga Mz. A Lote 4, Programa de Viviendas Las Palmas I'),
('TIENDA', 'TIENDA PRINCIPAL', 'Av. Paramonga Mz. A Lote 2, Programa de Viviendas Las Palmas I');

-- =============================================================
-- 3) MAESTROS DE PRODUCTO
-- =============================================================

INSERT INTO MODULO_ABASTECIMIENTO.PRODUCTO (nombre_producto, cod_categoria, marca, unidad_medida, precio_base, precio_venta, peso_producto) VALUES
('Cemento Portland Tipo I 42.5kg', 1, 'SOL', 'SACO', 28.90, 32.50, 42.5),         -- (Genera cod_producto 1)
('Fierro Corrugado 3/8"', 2, 'ACEROS AREQUIPA', 'VARILLA', 8.50, 9.80, 5.04),    -- (Genera cod_producto 2)
('Ladrillo King Kong 18 huecos', 3, 'PIRAMIDE', 'UNIDAD', 1.00, 1.20, 2.5),      -- (Genera cod_producto 3)
('Pintura Latex Interior 1 galón', 4, 'CPP', 'GALON', 35.90, 42.00, 4.0),       -- (Genera cod_producto 4)
('Thinner Industrial 1L', 5, 'SOLVIN', 'LITRO', 12.50, 15.00, 0.9),           -- (Genera cod_producto 5)
('Clavo de Acero 3" x 1kg', 6, 'INDECO', 'KG', 9.80, 11.50, 1.0),              -- (Genera cod_producto 6)
('Cinta Métrica 5m', 7, 'STANLEY', 'UNIDAD', 16.90, 20.00, 0.3),                 -- (Genera cod_producto 7)
('Taladro Percutor 750W', 8, 'BOSCH', 'UNIDAD', 259.00, 299.00, 2.2),           -- (Genera cod_producto 8)
('Tubo PVC 1" presión', 9, 'NICOLL', 'METRO', 4.20, 5.00, 0.4),                -- (Genera cod_producto 9)
('Llave Stillson 14"', 10, 'TRAMONTINA', 'UNIDAD', 49.00, 58.00, 1.5),          -- (Genera cod_producto 10)
('Silicona Neutra 300ml', 11, 'SIKA', 'TUBO', 11.50, 14.00, 0.35),             -- (Genera cod_producto 11)
('Guantes de Nitrilo Par', 12, '3M', 'UNIDAD', 4.80, 6.00, 0.1),                -- (Genera cod_producto 12)
('Disco Corte Metal 4.5"', 13, 'DEWALT', 'UNIDAD', 3.50, 4.50, 0.1),             -- (Genera cod_producto 13)
('Malla Acma 6mm', 14, 'ACEROS AREQUIPA', 'M2', 16.00, 18.50, 3.0),            -- (Genera cod_producto 14)
('Yeso en Polvo 25kg', 15, 'REY', 'SACO', 18.90, 22.00, 25.0),                  -- (Genera cod_producto 15)
('Brocha 2" Profesional', 16, 'VENCEDOR', 'UNIDAD', 8.90, 10.50, 0.2),          -- (Genera cod_producto 16)
('Rodillo Pintura 9"', 17, 'VENCEDOR', 'UNIDAD', 14.90, 18.00, 0.4),           -- (Genera cod_producto 17)
('Tubo PPR 3/4"', 18, 'NICOLL', 'METRO', 6.80, 8.00, 0.3),                       -- (Genera cod_producto 18)
('Tornillo Drywall 1" x 1kg', 19, 'INDECO', 'KG', 12.60, 15.00, 1.0),           -- (Genera cod_producto 19)
('Laca Transparente 1L', 20, 'TEKNO', 'LITRO', 22.40, 26.00, 0.9);            -- (Genera cod_producto 20)

-- (PK es compuesta, no es SERIAL)
INSERT INTO MODULO_ABASTECIMIENTO.PRODUCTO_PROVEEDOR (cod_producto, cod_proveedor, precio_unitario_ref) VALUES
(1, 1, 27.80), (1, 15, 28.50),
(2, 2, 7.90), (2, 15, 8.20),
(3, 3, 0.95),
(4, 4, 33.50), (4, 12, 34.00),
(5, 5, 11.80), (5, 14, 12.10),
(6, 6, 9.20), (6, 7, 9.60),
(7, 7, 15.90),
(8, 7, 249.00), (8, 10, 252.00),
(9, 8, 3.90),
(10, 7, 46.00),
(11, 6, 10.90),
(12, 9, 4.50),
(13, 6, 3.20), (13, 10, 3.40),
(14, 2, 15.50),
(15, 1, 18.20),
(16, 7, 8.50), (16, 12, 8.70),
(17, 7, 14.20), (17, 12, 14.50),
(18, 11, 6.40),
(19, 6, 12.10),
(20, 12, 21.90), (20, 4, 22.10);

-- (PK es compuesta, no es SERIAL)
INSERT INTO MODULO_ABASTECIMIENTO.PROVEEDOR_CONTACTO (cod_proveedor, cod_tipo_contacto, valor_contacto) VALUES
-- Proveedor 1 (CEM-PERU) - IDs TipoContacto: 1=Correo, 2=Telefono, 3=WhatsApp, 4=Direccion
(1, 1, 'ventas@cem-peru.com'),
(1, 2, '014567890'),
(1, 3, '987654321'),
(1, 4, 'Av. Industrial 123, Villa El Salvador'),

-- Proveedor 2 (ACERMAX)
(2, 1, 'contacto@acermax.com'),
(2, 2, '015551234'),
(2, 3, '987123456'),
(2, 4, 'Calle Los Hornos 456, Cercado de Lima'),

-- Proveedor 3 (LADRIPERU)
(3, 1, 'comercial@ladriperu.pe'),
(3, 2, '014445678'),
(3, 3, '999888777'),
(3, 4, 'Panamericana Sur Km 30, Lurin'),

-- Proveedor 4 (PINTULAC)
(4, 1, 'pedidos@pintulac.pe'),
(4, 2, '016543210'),
(4, 3, '911222333'),
(4, 4, 'Av. Argentina 789, Callao'),

-- Proveedor 5 (SOLVIN)
(5, 1, 'ventas@solvin.pe'),
(5, 2, '017778899'),
(5, 3, '944555666'),
(5, 4, 'Jr. Los Quimicos 321, Ate'),

-- (El resto de proveedores solo tendrán teléfono)
(6, 2, '999111001'),
(7, 2, '999111002'),
(8, 2, '999111003'),
(9, 2, '999111004'),
(10, 2, '999111005'),
(11, 2, '999111006'),
(12, 2, '999111007'),
(13, 2, '999111008'),
(14, 2, '999111009'),
(15, 2, '999111010');
-- =============================================================
-- 5) PEDIDOS INTERNOS (FLUJO DE COMPRA)
-- =============================================================
INSERT INTO MODULO_ABASTECIMIENTO.PEDIDO_ABASTECIMIENTO (cod_usuario, fecha_pedido, hora_pedido, estado_pedido) VALUES
(11, '2025-02-09', '09:00', 'En Proceso'), -- (Genera cod_pedido 1)
(12, '2025-02-10', '10:15', 'En Proceso'), -- (Genera cod_pedido 2)
(10, '2025-02-11', '11:30', 'En Proceso'), -- (Genera cod_pedido 3)
(13, '2025-02-12', '14:00', 'En Proceso'), -- (Genera cod_pedido 4)
(5, '2025-02-13', '08:45', 'En Proceso'),  -- (Genera cod_pedido 5)
(7, '2025-02-14', '09:20', 'En Proceso'),  -- (Genera cod_pedido 6)
(15, '2025-02-15', '10:05', 'En Proceso'), -- (Genera cod_pedido 7)
(10, '2025-02-16', '16:40', 'En Proceso'), -- (Genera cod_pedido 8)
(11, '2025-02-17', '08:25', 'Revisado'),   -- (Genera cod_pedido 9)
(12, '2025-02-18', '15:10', 'Pendiente'); -- (Genera cod_pedido 10)

-- (PK es compuesta, no es SERIAL)
INSERT INTO MODULO_ABASTECIMIENTO.DETALLE_PEDIDO (cod_pedido, cod_producto, cantidad_requerida, fecha_requerida, tipo_destino, direccion_destino_externo, estado) VALUES
(1, 1, 150, '2025-02-12', 'Interno', NULL, 'Adjudicado'),
(1, 3, 800, '2025-02-12', 'Interno', NULL, 'Adjudicado'),
(2, 2, 900, '2025-02-20', 'Externo', 'Av. Los Ángeles 820, Urb. José Carlos Mariátegui - V.M. de Triunfo', 'Adjudicado'),
(2, 6, 80, '2025-02-20', 'Externo', 'Av. Los Ángeles 820, Urb. José Carlos Mariátegui - V.M. de Triunfo', 'Adjudicado'),
(3, 4, 60, '2025-02-22', 'Interno', NULL, 'Adjudicado'),
(3, 5, 120, '2025-02-22', 'Interno', NULL, 'Adjudicado'),
(3, 8, 8, '2025-02-22', 'Interno', NULL, 'Adjudicado'),
(4, 9, 300, '2025-02-23', 'Externo', 'Av. Perú 2750, Urb. San Germán - San Martín de Porres', 'Adjudicado'),
(4, 11, 80, '2025-02-23', 'Externo', 'Av. Perú 2750, Urb. San Germán - San Martín de Porres', 'Adjudicado'),
(5, 14, 50, '2025-02-25', 'Interno', NULL, 'Adjudicado'),
(5, 15, 100, '2025-02-25', 'Interno', NULL, 'Adjudicado'),
(6, 16, 120, '2025-02-26', 'Interno', NULL, 'Adjudicado'),
(6, 17, 100, '2025-02-26', 'Interno', NULL, 'Adjudicado'),
(7, 18, 250, '2025-02-27', 'Externo', 'Av. Perú 2750, Urb. San Germán - San Martín de Porres', 'Adjudicado'),
(7, 19, 90, '2025-02-27', 'Externo', 'Av. Perú 2750, Urb. San Germán - San Martín de Porres', 'Adjudicado'),
(8, 20, 70, '2025-03-01', 'Interno', NULL, 'Adjudicado'),
(8, 4, 40, '2025-03-01', 'Interno', NULL, 'Adjudicado'),
(9, 12, 250, '2025-02-28', 'Interno', NULL, 'Revisado'),
(10, 10, 25, '2025-03-02', 'Interno', NULL, 'Pendiente');

-- =============================================================
-- 4) SOLICITUD -> COTIZACIÓN -> ORDEN DE COMPRA
-- =============================================================

INSERT INTO MODULO_ABASTECIMIENTO.SOLICITUD_COTIZACION (cod_usuario, fecha_emision, estado) VALUES
(2, '2025-02-10', 'Adjudicada'), -- (Genera cod_solicitud 1)
(17, '2025-02-11', 'Adjudicada'), -- (Genera cod_solicitud 2)
(19, '2025-02-12', 'Adjudicada'), -- (Genera cod_solicitud 3)
(3, '2025-02-13', 'Adjudicada'),  -- (Genera cod_solicitud 4)
(2, '2025-02-14', 'Pendiente'),   -- (Genera cod_solicitud 5)
(17, '2025-02-15', 'Adjudicada'), -- (Genera cod_solicitud 6)
(19, '2025-02-16', 'Adjudicada'), -- (Genera cod_solicitud 7)
(3, '2025-02-17', 'Adjudicada'),  -- (Genera cod_solicitud 8)
(2, '2025-02-18', 'Adjudicada'),  -- (Genera cod_solicitud 9)
(17, '2025-02-19', 'Adjudicada'), -- (Genera cod_solicitud 10)
(19, '2025-02-20', 'Cotizada'),   -- (Genera cod_solicitud 11)
(3, '2025-02-21', 'Pendiente');  -- (Genera cod_solicitud 12)

-- (PK es compuesta, no es SERIAL)
INSERT INTO MODULO_ABASTECIMIENTO.DETALLE_SOLICITUD (cod_solicitud, cod_producto, cantidad_solicitada) VALUES
(1, 1, 150), (1, 3, 800),
(2, 2, 900), (2, 6, 80),
(3, 4, 60), (3, 5, 120), (3, 8, 8),
(4, 9, 300), (4, 11, 80),
(5, 10, 20), (5, 12, 200), (5, 13, 100),
(6, 14, 50), (6, 15, 100),
(7, 16, 120), (7, 17, 100),
(8, 18, 250), (8, 19, 90),
(9, 20, 70), (9, 4, 40),
(10, 7, 60), (10, 8, 10),
(11, 5, 150), (11, 11, 90),
(12, 2, 600), (12, 9, 200);

INSERT INTO MODULO_ABASTECIMIENTO.COTIZACION (cod_solicitud, cod_proveedor, fecha_emision_cotizacion, fecha_garantia, monto_total, plazo_entrega) VALUES
(2, 2, '2025-02-13', '2025-04-15', 7880.00, 7),  -- (Genera cod_cotizacion 1) -> Ganadora OC-2
(2, 6, '2025-02-13', '2025-04-20', 8240.00, 10), -- (Genera cod_cotizacion 2)
(3, 4, '2025-02-16', '2025-05-01', 5642.00, 5),  -- (Genera cod_cotizacion 3) -> Ganadora OC-3
(3, 5, '2025-02-16', '2025-05-10', 5760.00, 6),  -- (Genera cod_cotizacion 4)
(1, 1, '2025-02-11', '2025-04-10', 4970.00, 4),  -- (Genera cod_cotizacion 5) -> Ganadora OC-1
(4, 8, '2025-02-19', '2025-04-30', 2042.00, 3),  -- (Genera cod_cotizacion 6) -> Ganadora OC-4
(5, 7, '2025-02-15', '2025-04-20', 2890.00, 5),  -- (Genera cod_cotizacion 7)
(6, 15, '2025-02-16', '2025-04-25', 2600.00, 8), -- (Genera cod_cotizacion 8)
(7, 10, '2025-02-18', '2025-05-20', 2420.00, 6), -- (Genera cod_cotizacion 9)
(8, 11, '2025-02-20', '2025-05-15', 2785.00, 4), -- (Genera cod_cotizacion 10) -> Ganadora OC-7
(9, 12, '2025-02-20', '2025-05-01', 2894.00, 5), -- (Genera cod_cotizacion 11)
(10, 10, '2025-02-21', '2025-04-30', 3474.00, 4),-- (Genera cod_cotizacion 12) -> Ganadora OC-9
(11, 14, '2025-02-22', '2025-05-10', 3290.00, 7),-- (Genera cod_cotizacion 13)
(12, 15, '2025-02-22', '2025-05-05', 7250.00, 9),-- (Genera cod_cotizacion 14) -> Ganadora OC-10
(6, 2, '2025-02-17', '2025-05-01', 2595.00, 9),  -- (Genera cod_cotizacion 15) -> Ganadora OC-5
(7, 7, '2025-02-18', '2025-05-30', 2440.00, 7),  -- (Genera cod_cotizacion 16) -> Ganadora OC-6
(9, 4, '2025-02-21', '2025-05-20', 2884.00, 6),  -- (Genera cod_cotizacion 17) -> Ganadora OC-8
(11, 5, '2025-02-23', '2025-05-25', 3350.00, 8); -- (Genera cod_cotizacion 18)

-- (PK es compuesta, no es SERIAL)
INSERT INTO MODULO_ABASTECIMIENTO.DETALLE_COTIZACION (cod_cotizacion, cod_producto, costo_total, modalidad_pago) VALUES
(1, 2, 7110.00, 'Crédito'), (1, 6, 770.00, 'Crédito'),
(2, 2, 7560.00, 'Contado'), (2, 6, 680.00, 'Contado'),
(3, 4, 2010.00, 'Contado'), (3, 5, 1416.00, 'Contado'), (3, 8, 2216.00, 'Contado'),
(4, 4, 2040.00, 'Contado'), (4, 5, 1440.00, 'Contado'), (4, 8, 2280.00, 'Contado'),
(5, 1, 4170.00, 'Contado'), (5, 3, 800.00, 'Contado'),
(6, 9, 1170.00, 'Contado'), (6, 11, 872.00, 'Contado'),
(7, 10, 920.00, 'Contado'), (7, 12, 900.00, 'Contado'), (7, 13, 320.00, 'Contado'),
(8, 14, 800.00, 'Crédito'), (8, 15, 1800.00, 'Crédito'),
(9, 16, 1020.00, 'Contado'), (9, 17, 1400.00, 'Contado'),
(10, 18, 1600.00, 'Contado'), (10, 19, 1185.00, 'Contado'),
(11, 20, 1533.00, 'Contado'), (11, 4, 1361.00, 'Contado'),
(12, 7, 954.00, 'Contado'), (12, 8, 2520.00, 'Contado'),
(13, 5, 1770.00, 'Crédito'), (13, 11, 981.00, 'Crédito'),
(14, 2, 4920.00, 'Crédito'), (14, 9, 780.00, 'Crédito'),
(15, 14, 775.00, 'Contado'), (15, 15, 1820.00, 'Contado'),
(16, 16, 1020.00, 'Crédito'), (16, 17, 1420.00, 'Crédito'),
(17, 20, 1505.00, 'Contado'), (17, 4, 1379.00, 'Contado'),
(18, 5, 1800.00, 'Contado'), (18, 11, 990.00, 'Contado');

INSERT INTO MODULO_ABASTECIMIENTO.ORDEN_COMPRA (cod_cotizacion, fecha_emision, monto, modalidad_pago, estado) VALUES
(5, '2025-02-12', 4970.00, 'Contado', 'Cerrada'),   -- (Genera cod_orden 1)
(1, '2025-02-14', 7880.00, 'Crédito', 'Cerrada'),   -- (Genera cod_orden 2)
(3, '2025-02-17', 5642.00, 'Contado', 'Cerrada'),   -- (Genera cod_orden 3)
(6, '2025-02-20', 2042.00, 'Contado', 'Programada'),-- (Genera cod_orden 4)
(15, '2025-02-18', 2595.00, 'Contado', 'Cerrada'),  -- (Genera cod_orden 5)
(16, '2025-02-19', 2440.00, 'Crédito', 'Cerrada'),  -- (Genera cod_orden 6)
(10, '2025-02-21', 2785.00, 'Contado', 'Cerrada'),  -- (Genera cod_orden 7)
(17, '2025-02-22', 2884.00, 'Contado', 'Cerrada'),  -- (Genera cod_orden 8)
(12, '2025-02-22', 3474.00, 'Contado', 'Cerrada'),  -- (Genera cod_orden 9)
(14, '2025-02-23', 5700.00, 'Crédito', 'Programada'); -- (Genera cod_orden 10)

-- (PK es compuesta, no es SERIAL)
INSERT INTO MODULO_ABASTECIMIENTO.DETALLE_OC (cod_orden, cod_producto, cantidad_comprada, costo_total) VALUES
(1, 1, 150, 4170.00), (1, 3, 800, 800.00),
(2, 2, 900, 7110.00), (2, 6, 80, 770.00),
(3, 4, 60, 2010.00), (3, 5, 120, 1416.00), (3, 8, 8, 2216.00),
(4, 9, 300, 1170.00), (4, 11, 80, 872.00),
(5, 14, 50, 775.00), (5, 15, 100, 1820.00),
(6, 16, 120, 1020.00), (6, 17, 100, 1420.00),
(7, 18, 250, 1600.00), (7, 19, 90, 1185.00),
(8, 20, 70, 1505.00), (8, 4, 40, 1379.00),
(9, 7, 60, 954.00), (9, 8, 10, 2520.00),
(10, 2, 600, 4920.00), (10, 9, 200, 780.00);

-- =============================================================
-- 6) RECEPCIÓN / LOGÍSTICA INBOUND
-- =============================================================

INSERT INTO MODULO_ABASTECIMIENTO.MONITOREO_COMPRA (cod_orden, fecha_entrega, hora_entrega, estado) VALUES
(1, '2025-02-15', '15:00', 'Entregado'), -- (Genera cod_monitoreo 1)
(2, '2025-02-21', '11:30', 'Entregado'), -- (Genera cod_monitoreo 2)
(3, '2025-02-22', '16:45', 'Entregado'), -- (Genera cod_monitoreo 3)
(4, '2025-02-24', '10:00', 'En Proceso'),-- (Genera cod_monitoreo 4)
(5, '2025-02-27', '14:15', 'Entregado'), -- (Genera cod_monitoreo 5)
(6, '2025-02-25', '13:20', 'Entregado'), -- (Genera cod_monitoreo 6)
(7, '2025-02-26', '10:30', 'Entregado'), -- (Genera cod_monitoreo 7)
(8, '2025-02-25', '08:55', 'Entregado'), -- (Genera cod_monitoreo 8)
(9, '2025-03-03', '12:10', 'En Proceso'),-- (Genera cod_monitoreo 9)
(10, '2025-03-04', '11:00', 'En Proceso');-- (Genera cod_monitoreo 10)

INSERT INTO MODULO_ABASTECIMIENTO.RECEPCION (cod_orden, cod_instalacion, fecha_recepcion, hora_inicio_recepcion, hora_fin_recepcion, fecha_programada, hora_programada, cod_usuario, observacion, estado_recepcion) VALUES
(1, 'ALM-CEN', '2025-02-15', '14:30', '15:30', '2025-02-15', '14:00', 6, 'Ok', 'Finalizada'), -- (Genera cod_recepcion 1)
(2, 'ALM-CEN', '2025-02-21', '10:30', '12:00', '2025-02-21', '10:00', 7, 'Ok', 'Finalizada'), -- (Genera cod_recepcion 2)
(3, 'ALM-SEC', '2025-02-22', '16:00', '17:30', '2025-02-22', '15:30', 5, 'Falla en Calidad', 'Con Reclamo'), -- (Genera cod_recepcion 3)
(4, 'TIENDA', '2025-02-24', '09:00', '10:00', '2025-02-24', '08:30', 6, 'Programado', 'Programada'), -- (Genera cod_recepcion 4)
(5, 'ALM-CEN', '2025-02-27', '13:40', '14:40', '2025-02-27', '13:00', 6, 'Ok', 'Finalizada'), -- (Genera cod_recepcion 5)
(6, 'ALM-CEN', '2025-02-25', '12:50', '13:40', '2025-02-25', '12:30', 7, 'Ok', 'Finalizada'), -- (Genera cod_recepcion 6)
(7, 'ALM-SEC', '2025-02-26', '10:10', '11:00', '2025-02-26', '09:40', 5, 'Ok', 'Finalizada'), -- (Genera cod_recepcion 7)
(8, 'TIENDA', '2025-02-25', '08:30', '09:15', '2025-02-25', '08:00', 5, 'Ok', 'Finalizada'), -- (Genera cod_recepcion 8)
(9, 'ALM-CEN', '2025-03-03', '11:30', '12:30', '2025-03-03', '11:00', 6, 'Ok', 'Finalizada'), -- (Genera cod_recepcion 9)
(10, 'TIENDA', '2025-03-04', '11:00', '12:00', '2025-03-04', '11:00', 7, 'Programado', 'Programada'); -- (Genera cod_recepcion 10)

INSERT INTO MODULO_ABASTECIMIENTO.DETALLE_RECEPCION (cod_recepcion, cod_producto, cantidad_conforme, cantidad_defectuosa, cantidad_recibida, cantidad_programada) VALUES
(1, 1, 150, 0, 150, 150), (1, 3, 800, 0, 800, 800),   -- (Genera cod_detalle_recepcion 1, 2)
(2, 2, 900, 0, 900, 900), (2, 6, 80, 0, 80, 80),     -- (Genera cod_detalle_recepcion 3, 4)
(3, 4, 60, 0, 60, 60), (3, 5, 120, 0, 120, 120), (3, 8, 7, 1, 8, 8), -- (Genera cod_detalle_recepcion 5, 6, 7)
(4, 9, 300, 0, 300, 300), (4, 11, 80, 0, 80, 80),   -- (Genera cod_detalle_recepcion 8, 9)
(5, 14, 50, 0, 50, 50), (5, 15, 100, 0, 100, 100),  -- (Genera cod_detalle_recepcion 10, 11)
(6, 16, 120, 0, 120, 120), (6, 17, 100, 0, 100, 100),-- (Genera cod_detalle_recepcion 12, 13)
(7, 18, 250, 0, 250, 250), (7, 19, 90, 0, 90, 90),  -- (Genera cod_detalle_recepcion 14, 15)
(8, 20, 70, 0, 70, 70), (8, 4, 40, 0, 40, 40),    -- (Genera cod_detalle_recepcion 16, 17)
(9, 7, 60, 0, 60, 60), (9, 8, 10, 0, 10, 10),    -- (Genera cod_detalle_recepcion 18, 19)
(10, 2, 600, 0, 600, 600), (10, 9, 200, 0, 200, 200); -- (Genera cod_detalle_recepcion 20, 21)

-- (PK no es SERIAL, se debe insertar)
INSERT INTO MODULO_ABASTECIMIENTO.GUIA_REMISION_EXTERNA (serie_correlativo, cod_recepcion, fecha_emision_guia, fecha_traslado_guia) VALUES
('F001-00000001', 1, '2025-02-15', '2025-02-15'),
('F001-00000002', 2, '2025-02-21', '2025-02-21'),
('F001-00000003', 3, '2025-02-22', '2025-02-22'),
('F001-00000004', 4, '2025-02-24', '2025-02-24'),
('F001-00000005', 5, '2025-02-27', '2025-02-27'),
('F001-00000006', 6, '2025-02-25', '2025-02-25'),
('F001-00000007', 7, '2025-02-26', '2025-02-26'),
('F001-00000008', 8, '2025-02-25', '2025-02-25'),
('F001-00000009', 9, '2025-03-03', '2025-03-03'),
('F001-00000010', 10, '2025-03-04', '2025-03-04');

-- (PK es compuesta, no es SERIAL)
INSERT INTO MODULO_ABASTECIMIENTO.DETALLE_GUIA_EXTERNA (serie_correlativo, cod_producto, cantidad_guia) VALUES
('F001-00000001', 1, 150), ('F001-00000001', 3, 800),
('F001-00000002', 2, 900), ('F001-00000002', 6, 80),
('F001-00000003', 4, 60), ('F001-00000003', 5, 120), ('F001-00000003', 8, 8),
('F001-00000004', 9, 300), ('F001-00000004', 11, 80),
('F001-00000005', 14, 50), ('F001-00000005', 15, 100),
('F001-00000006', 16, 120), ('F001-00000006', 17, 100),
('F001-00000007', 18, 250), ('F001-00000007', 19, 90),
('F001-00000008', 20, 70), ('F001-00000008', 4, 40),
('F001-00000009', 7, 60), ('F001-00000009', 8, 10),
('F001-00000010', 2, 600), ('F001-00000010', 9, 200);

-- =============================================================
-- 7) RECLAMOS / POST-COMPRA
-- =============================================================

INSERT INTO MODULO_ABASTECIMIENTO.RECLAMO (fecha_reclamo, hora_reclamo, observacion_reclamo, accion_correctiva, estado_reclamo) VALUES
('2025-02-23', '09:15', 'Taladro con falla de fábrica', 'Reemplazo de Producto', 'Resuelto'); -- (Genera cod_reclamo 1)

INSERT INTO MODULO_ABASTECIMIENTO.INCIDENCIA (cod_detalle_recepcion, cod_reclamo, tipo_incidencia, cantidad_incidencia, descripcion_incidencia) VALUES
(7, 1, 'CALIDAD', 1, 'Taladro percutor con carcasa rota. Se reporta 1 unidad defectuosa de 8 recibidas.'); -- (Genera cod_incidencia 1, apunta a detalle_recepcion 7 y reclamo 1)

INSERT INTO MODULO_ABASTECIMIENTO.CAMBIO_PRODUCTO (cod_reclamo, fecha_cambio, hora_cambio, motivo_cambio, descripcion_cambio) VALUES
(1, '2025-02-25', '11:30', 'Reposición', 'Cambio de 1 taladro percutor BOSCH por unidad nueva.'); -- (Genera cod_cambio_producto 1)

INSERT INTO MODULO_ABASTECIMIENTO.INCIDENCIA (cod_detalle_recepcion, tipo_incidencia, cantidad_incidencia, descripcion_incidencia) VALUES
(
 10, -- (FK a DETALLE_RECEPCION 10: Malla Acma, Recepción 5)
 'CALIDAD', 
 3, 
 '3 mallas (M2) llegaron con puntos de óxido. No pasan control de calidad.'
),
(
 12, -- (FK a DETALLE_RECEPCION 12: Brocha 2", Recepción 6)
 'CANTIDAD_FALTANTE', 
 5, 
 'Llegaron 115 brochas de 120 programadas en la OC-006. Faltan 5 unidades.'
),
(
 18, -- (FK a DETALLE_RECEPCION 18: Cinta Métrica, Recepción 9)
 'PRODUCTO_INCORRECTO', 
 10, 
 'Se pidieron Cintas Métricas STANLEY (Prod 7) y llegaron 10 Huinchas sin marca.'
);

-- =============================================================
-- 8) DESPACHO / TRANSPORTE ASOCIADO A RECEPCIÓN
-- =============================================================

INSERT INTO MODULO_ABASTECIMIENTO.PEDIDO_TRANSPORTE (cod_recepcion, fecha_pedido_transporte, cod_estado_pedido_tr, cod_cliente, cod_usuario) VALUES
(1, '2025-02-15', 3, 1, 9),  -- (Genera cod_pedido_transporte 1)
(2, '2025-02-21', 3, 1, 16), -- (Genera cod_pedido_transporte 2)
(3, '2025-02-22', 1, 1, 20), -- (Genera cod_pedido_transporte 3)
(4, '2025-02-24', 1, 1, 9),  -- (Genera cod_pedido_transporte 4)
(5, '2025-02-27', 3, 1, 16), -- (Genera cod_pedido_transporte 5)
(6, '2025-02-25', 3, 1, 20), -- (Genera cod_pedido_transporte 6)
(7, '2025-02-26', 3, 1, 9),  -- (Genera cod_pedido_transporte 7)
(8, '2025-02-25', 3, 1, 16), -- (Genera cod_pedido_transporte 8)
(9, '2025-03-03', 1, 1, 20), -- (Genera cod_pedido_transporte 9)
(10, '2025-03-04', 1, 1, 9); -- (Genera cod_pedido_transporte 10)