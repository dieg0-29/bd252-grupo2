SET search_path = modulo_transporte;

BEGIN;

-- Catálogos ajustados a tu pedido
INSERT INTO tipo_vehiculo (cod_tipo_vehiculo, nombre_estado) VALUES
  (1, 'Camioneta'), (2, 'Volquete'), (3, 'Trailer');

INSERT INTO categoria_brevete (cod_categoria_brevete, nombre_categoria_brevete) VALUES
  (1, 'A-I'), (2, 'A-IIa'), (3, 'A-IIb'),
  (4, 'A-IIIa'), (5, 'A-IIIb'), (6, 'A-IIIc');

INSERT INTO estado_vehiculo (cod_estado_vehiculo, nombre_estado) VALUES
  (1, 'operativo'), (2, 'en_mantenimiento');

INSERT INTO estado_despacho (cod_estado_despacho, nombre_estado_despacho) VALUES
  (1, 'programado'), (2, 'en_ruta'), (3, 'completado');

INSERT INTO estado_operador_vehiculo (cod_estado_asignacion, nombre_estado_asignacion) VALUES
  (1, 'accionado'), (2, 'suspendido');

INSERT INTO estado_despacho_parada (cod_estado_despacho_parada, nombre_estado) VALUES
  (1, 'pendiente'), (2, 'en_camino'), (3, 'completado');

INSERT INTO tipo_parada (cod_tipo_parada, nombre_tipo_parada) VALUES
  (1, 'recojo'), (2, 'entrega');

INSERT INTO turno_detalle (cod_turno_detalle, nombre_turno_detalle) VALUES
  (1, 'mañana'), (2, 'tarde'), (3, 'noche');

INSERT INTO estado_pedido_transporte (cod_estado_pedido_transporte, nombre_estado) VALUES
  (1, 'recibido'), (2, 'programado'), (3, 'completado');

INSERT INTO estado_pedido_despacho (cod_estado_asignacion, nombre_estado) VALUES
  (1, 'programado'), (2, 'reprogramado'), (3, 'anulado');

-- Núcleo: vehículos, choferes, empleados
INSERT INTO vehiculo (
  cod_vehiculo, placa_vehiculo, capacidad_maxima_peso, capacidad_maxima_volumen,
  cod_categoria_brevete, cod_tipo_vehiculo, cod_estado_vehiculo
) VALUES
  ('VH-001', 'BHZ-912', 3500.00, 12.50, 4, 2, 1), -- Volquete (A-IIIa)
  ('VH-002', 'AWK-345', 1000.00, 4.00,  1, 1, 1); -- Camioneta (A-I)

INSERT INTO chofer (
  cod_chofer, nombre_chofer, correo_contacto, numero_contacto, fecha_registro,
  cod_categoria_brevete, vencimiento_brevete
) VALUES
  ('CH-ALV', 'Álvaro Medina', 'alvaro.medina@migal.pe', '987654321', DATE '2025-09-10', 4, DATE '2027-05-01'),
  ('CH-LUZ', 'Luz Ramos',     'luz.ramos@migal.pe',     '986000111', DATE '2025-09-12', 1, DATE '2026-11-15');

INSERT INTO empleado (cod_empleado, numero_contacto, nombre_empleado, correo_contacto, fecha_registro) VALUES
  ('EMP-VENT', '955111222', 'Rocío Valdez (Ventas)',         'rocio.valdez@migal.pe', TIMESTAMP '2025-09-01 09:00:00'),
  ('EMP-ABAS', '955333444', 'Marco Quispe (Abastecimiento)', 'marco.quispe@migal.pe', TIMESTAMP '2025-09-01 09:05:00');

INSERT INTO operador_vehiculo (cod_operador, cod_vehiculo, cod_estado_asignacion, motivo_estado_asignacion, fecha_ultimo_cambio) VALUES
  ('CH-ALV', 'VH-001', 1, 'Asignación operativa', DATE '2025-10-05');

-- Productos de ferretería
INSERT INTO producto (cod_producto, nombre_producto, unidad_medida, peso_producto, precio_base) VALUES
  ('PR-CEM-42', 'Cemento Portland Tipo I 42.5kg', 'saco',  42.50, 32.50),
  ('PR-CLV-2',  'Clavo 2"',                      'caja',   2.00,  18.90),
  ('PR-PIN-L',  'Pintura Látex 1 galón',         'galon',  4.00,  45.00);

-- ================================
-- 6 PEDIDOS (estados y detalles)
-- ================================
-- estado_pedido_transporte: 1=recibido, 2=programado, 3=completado

-- COMPLETADOS
INSERT INTO pedido_transporte VALUES
 ('PT-3001', TIMESTAMP '2025-10-07 08:05:00', DATE '2025-10-07', 3, 'EMP-VENT'),
 ('PT-3002', TIMESTAMP '2025-10-07 08:10:00', DATE '2025-10-07', 3, 'EMP-VENT');

-- PROGRAMADOS
INSERT INTO pedido_transporte VALUES
 ('PT-3003', TIMESTAMP '2025-10-08 08:00:00', DATE '2025-10-08', 2, 'EMP-VENT'), -- totalmente programado
 ('PT-3004', TIMESTAMP '2025-10-08 08:15:00', DATE '2025-10-08', 2, 'EMP-VENT'); -- parcialmente programado

-- RECIBIDOS
INSERT INTO pedido_transporte VALUES
 ('PT-3005', TIMESTAMP '2025-10-08 08:30:00', DATE '2025-10-08', 1, 'EMP-VENT'),
 ('PT-3006', TIMESTAMP '2025-10-08 08:35:00', DATE '2025-10-08', 1, 'EMP-VENT');

-- DETALLES
INSERT INTO detalle_pedido VALUES
 -- PT-3001 (completado)
 ('PT-3001','PR-CEM-42',1,10,DATE '2025-10-07',1,'Almacén Central MIGAL','Obra Los Cedros 101'),
 ('PT-3001','PR-CLV-2', 2, 5, DATE '2025-10-07',1,'Almacén Central MIGAL','Obra Los Cedros 101'),
 -- PT-3002 (completado)
 ('PT-3002','PR-PIN-L', 1, 6, DATE '2025-10-07',1,'Almacén Central MIGAL','Av. Industrial 500 - La Molina'),
 ('PT-3002','PR-CEM-42',2,12,DATE '2025-10-07',1,'Almacén Central MIGAL','Av. Industrial 500 - La Molina'),
 -- PT-3003 (programado total)
 ('PT-3003','PR-CEM-42',1,15,DATE '2025-10-08',1,'Almacén Central MIGAL','Calle Las Violetas 220'),
 ('PT-3003','PR-CLV-2', 2, 8, DATE '2025-10-08',1,'Almacén Central MIGAL','Calle Las Violetas 220'),
 ('PT-3003','PR-PIN-L', 3, 4, DATE '2025-10-08',1,'Almacén Central MIGAL','Calle Las Violetas 220'),
 -- PT-3004 (programado parcial: 2 programados + 2 recibidos)
 ('PT-3004','PR-CEM-42',1,10,DATE '2025-10-08',1,'Almacén Central MIGAL','Psje. Las Dalias 330'),   -- PROGRAMADO
 ('PT-3004','PR-CLV-2', 2,20,DATE '2025-10-08',1,'Almacén Central MIGAL','Psje. Las Dalias 330'),   -- PROGRAMADO
 ('PT-3004','PR-PIN-L', 3, 6, DATE '2025-10-08',1,'Almacén Central MIGAL','Jr. El Bosque 450'),     -- RECIBIDO (no programado)
 ('PT-3004','PR-CLV-2', 4,12,DATE '2025-10-08',1,'Almacén Central MIGAL','Jr. El Bosque 450'),      -- RECIBIDO (no programado)
 -- PT-3005 (recibido)
 ('PT-3005','PR-PIN-L', 1, 3, DATE '2025-10-08',2,'Almacén Central MIGAL','Av. Huaylas 1200'),
 ('PT-3005','PR-CLV-2', 2, 5, DATE '2025-10-08',2,'Almacén Central MIGAL','Av. Huaylas 1200'),
 -- PT-3006 (recibido)
 ('PT-3006','PR-CEM-42',1,18,DATE '2025-10-08',2,'Almacén Central MIGAL','Condominio Santa Rosa - Lote 12');

-- DESPACHOS (3: dos completados, dos programados)
INSERT INTO despacho VALUES
 ('DSP-20251007-01', DATE '2025-10-07', TIME '09:00', TIME '12:00', 3, 'CH-ALV', 'VH-001'),
 ('DSP-20251007-02', DATE '2025-10-07', TIME '09:30', TIME '13:10', 3, 'CH-LUZ', 'VH-002'),
 ('DSP-20251008-01', DATE '2025-10-08', TIME '09:00', TIME '15:00', 1, 'CH-ALV', 'VH-001'),
 ('DSP-20251008-02', DATE '2025-10-08', TIME '10:00', TIME '16:00', 1, 'CH-LUZ', 'VH-002');

-- PARADAS (completadas y programadas)
INSERT INTO parada VALUES
 ('PA-PT3001-01','Obra Los Cedros 101','Parque Las Gardenias','G-030001'),
 ('PA-PT3002-01','Av. Industrial 500 - La Molina','Mercado Incamay','G-030002'),
 ('PA-PT3003-01','Calle Las Violetas 220','Hospital Negrero','G-030003'),
 ('PA-PT3004-01','Psje. Las Dalias 330','Mercado Incamay','G-030004');

-- detalle_despacho_parada (estado_despacho_parada: 1=pendiente, 2=en_camino, 3=completado)
INSERT INTO detalle_despacho_parada VALUES
 ('DSP-20251007-01','PA-PT3001-01',1,TIME '10:20',TIME '10:00',2,3), -- entrega completada
 ('DSP-20251007-02','PA-PT3002-01',1,TIME '11:25',TIME '11:00',2,3), -- entrega completada
 ('DSP-20251008-01','PA-PT3003-01',1,TIME '10:30',TIME '10:10',2,1), -- pendiente
 ('DSP-20251008-02','PA-PT3004-01',1,TIME '11:15',TIME '11:00',2,1); -- pendiente

-- Asociación pedido–despacho (estado_pedido_despacho: 1=programado)
INSERT INTO pedido_despacho VALUES
 ('PT-3001','DSP-20251007-01',1),
 ('PT-3002','DSP-20251007-02',1),
 ('PT-3003','DSP-20251008-01',1),  -- total
 ('PT-3004','DSP-20251008-02',1);  -- parcial

-- Productos por parada (programado vs. entregado)
INSERT INTO producto_parada VALUES
 -- Completados
 ('PR-CEM-42','PA-PT3001-01',10,10,''),
 ('PR-CLV-2', 'PA-PT3001-01', 5, 5,''),
 ('PR-PIN-L', 'PA-PT3002-01', 6, 6,''),
 ('PR-CEM-42','PA-PT3002-01',12,12,''),
 -- Programado total PT-3003 (pendiente)
 ('PR-CEM-42','PA-PT3003-01',15,0,'pendiente'),
 ('PR-CLV-2', 'PA-PT3003-01', 8,0,'pendiente'),
 ('PR-PIN-L', 'PA-PT3003-01', 4,0,'pendiente'),
 -- Programado parcial PT-3004 (solo Las Dalias)
 ('PR-CEM-42','PA-PT3004-01',10,0,'pendiente'),
 ('PR-CLV-2', 'PA-PT3004-01',20,0,'pendiente');

COMMIT;


