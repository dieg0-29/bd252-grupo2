-- =============================================
-- Script de Poblamiento de Datos
-- Módulo: Almacén
-- Proyecto: Ferretería
-- =============================================

-- ---------
-- Bloque 0: Limpieza de todas las tablas
-- ---------
TRUNCATE TABLE
    almacen.instalacion,
    almacen.operador,
    almacen.turno,
    almacen.producto,
    almacen.ubicacion,
    almacen.ubicacion_almacen,
    almacen.ubicacion_tienda,
    almacen.inventario,
    almacen.recepcion,
    almacen.despacho,
    almacen.conteo,
    almacen.reserva_almacen,
    almacen.detalle_recepcion,
    almacen.detalle_conteo,
    almacen.operador_recepcion,
    almacen.operador_despacho,
    almacen.operador_conteo,
    almacen.incidencia,
    almacen.movimiento
RESTART IDENTITY CASCADE;

-- =============================================
-- Bloque 1: Inserción de Datos Iniciales
-- =============================================

-- ---------
-- Tablas Maestras
-- ---------

INSERT INTO almacen.instalacion (cod_instalacion, nombre_instalacion, direccion) VALUES
('AC1', 'Almacén Construcción 1', 'Av. Industrial 123, Ate'),
('AC2', 'Almacén Construcción 2', 'Av. Industrial 125, Ate'),
('TDA', 'Tienda Principal', 'Av. Principal 456, La Molina');

INSERT INTO almacen.operador (cod_operador, numero, nombre, dni, cargo) VALUES
('OP-001', '987654321', 'Juan Carlos Pérez Gómez', '76543210', 'Jefe de Almacén'),
('OP-002', '987123456', 'María Fernanda Rojas Solis', '71234567', 'Operador de Montacarga'),
('OP-003', '987789123', 'Luis Alberto Gonzales Cruz', '77891234', 'Operador de Picking'),
('OP-004', '987456789', 'Ana Lucía Méndez Flores', '74567890', 'Operador');

INSERT INTO almacen.turno (cod_turno, hora_inicio, hora_fin, capacidad) VALUES
('TURNO-M1', '08:00:00', '09:00:00', 3),
('TURNO-M2', '09:00:00', '10:00:00', 3),
('TURNO-M3', '10:00:00', '11:00:00', 3),
('TURNO-T1', '14:00:00', '15:00:00', 2);

-- ---------
-- Catálogos y Jerarquía de Ubicaciones
-- ---------

INSERT INTO almacen.producto (cod_producto, nombre_producto, unidad, peso, precio_base, cod_instalacion) VALUES
('CEM-SOL', 'Cemento Sol 42.5kg', 'Bolsa', 42.5, 25.50, 'AC1'),
('CEM-AND', 'Cemento Andino 42.5kg', 'Bolsa', 42.5, 24.80, 'AC1'),
('FIE-C-1/2', 'Fierro Corrugado 1/2 pulg', 'Unidad', 5.3, 35.00, 'AC1'),
('LAD-KK', 'Ladrillo King Kong 18 Huecos', 'Unidad', 2.5, 1.80, 'AC2'),
('ARE-G', 'Arena Gruesa', 'm3', 1600, 50.00, 'AC2'),
('TDA-TAL-01', 'Taladro Percutor 500W Bosch', 'Unidad', 2.1, 199.90, 'TDA'),
('TDA-PIN-01', 'Pintura Blanca Satinada 1GL', 'Galón', 4.5, 45.00, 'TDA');

INSERT INTO almacen.ubicacion (cod_ubicacion, cod_ubicacion_calculado, cod_instalacion) VALUES
('AC1-CEM-A', 'AC1-CEM-A', 'AC1'),
('AC1-FIE-01', 'AC1-FIE-01', 'AC1'),
('AC2-LAD-P1', 'AC2-LAD-P1', 'AC2'),
('AC2-ARE-G', 'AC2-ARE-G', 'AC2'),
('TDA-P03-E02-N04', 'TDA-P03-E02-N04', 'TDA'),
('TDA-P05-E01-N02', 'TDA-P05-E01-N02', 'TDA');

INSERT INTO almacen.ubicacion_almacen (cod_ubicacion, zona, espacio) VALUES
('AC1-CEM-A', 'CEMENTOS', 'A'),
('AC1-FIE-01', 'FIERROS', '01'),
('AC2-LAD-P1', 'LADRILLOS', 'P1'),
('AC2-ARE-G', 'ARENAS', 'GRUESA');

INSERT INTO almacen.ubicacion_tienda (cod_ubicacion, pasillo, estante, nivel) VALUES
('TDA-P03-E02-N04', 'PASILLO 03', 'ESTANTE 02', 'NIVEL 04'),
('TDA-P05-E01-N02', 'PASILLO 05', 'ESTANTE 01', 'NIVEL 02');

-- ---------
-- Stock Inicial
-- ---------

INSERT INTO almacen.inventario (stock_fisico, stock_comprometido, stock_minimo, cod_producto, cod_ubicacion) VALUES
(500, 50, 100, 'CEM-SOL', 'AC1-CEM-A'),
(300, 0, 80, 'FIE-C-1/2', 'AC1-FIE-01'),
(5000, 1000, 500, 'LAD-KK', 'AC2-LAD-P1'),
(20, 5, 10, 'TDA-TAL-01', 'TDA-P03-E02-N04');

-- ---------
-- Tareas y Eventos
-- ---------

INSERT INTO almacen.recepcion (cod_recepcion, nombre_conductor_entrega, placa_vehiculo_entrega, estado) VALUES
('REC-2025-001', 'Carlos Estrada', 'B2X-852', 'Finalizada'),
('REC-2025-002', 'Jorge Benavides', 'A1C-947', 'Finalizada'),
('REC-2025-003', 'Mario Casas', 'C3V-111', 'Pendiente');

INSERT INTO almacen.despacho (cod_despacho, fecha_planificada, estado) VALUES
('DESP-2025-101', '2025-10-06', 'En Preparación'),
('DESP-2025-102', '2025-10-07', 'Pendiente'),
('DESP-2025-103', '2025-10-07', 'Pendiente');


INSERT INTO almacen.conteo (cod_conteo, fecha_conteo, hora_conteo, estado) VALUES
('CONT-2025-050', '2025-10-06', '10:00:00', 'En Proceso'),
('CONT-2025-051', '2025-10-07', '09:00:00', 'Pendiente');


-- ---------
-- Reservas
-- ---------

INSERT INTO almacen.reserva_almacen (codigo_reserva, fecha_reserva, tipo_reserva, estado, cod_turno, cod_despacho, cod_recepcion, cod_instalacion) VALUES
('RES-001', '2025-10-06', 'Recepción', 'Completada', 'TURNO-M1', NULL, 'REC-2025-001', 'AC1'),
('RES-002', '2025-10-06', 'Despacho', 'Confirmada', 'TURNO-M2', 'DESP-2025-101', NULL, 'AC2'),
('RES-003', '2025-10-07', 'Recepción', 'Confirmada', 'TURNO-M1', NULL, 'REC-2025-002', 'AC2'),
('RES-004', '2025-10-07', 'Despacho', 'Confirmada', 'TURNO-M2', 'DESP-2025-102', NULL, 'AC1');


-- ---------
-- Detalles y Asignaciones
-- ---------

INSERT INTO almacen.detalle_recepcion (cantidad_recibida, cod_recepcion, cod_producto) VALUES
(200, 'REC-2025-001', 'CEM-SOL'),
(1500, 'REC-2025-002', 'LAD-KK'),
(50, 'REC-2025-002', 'CEM-AND');

INSERT INTO almacen.detalle_conteo (cantidad_contada, discrepancia, cod_conteo, cod_producto) VALUES
(498, -2, 'CONT-2025-050', 'CEM-SOL');

INSERT INTO almacen.operador_recepcion (cod_operador, cod_recepcion) VALUES
('OP-002', 'REC-2025-001'),
('OP-004', 'REC-2025-001'),
('OP-002', 'REC-2025-002');

INSERT INTO almacen.operador_despacho (cod_operador, cod_despacho) VALUES
('OP-003', 'DESP-2025-101'),
('OP-004', 'DESP-2025-101');

INSERT INTO almacen.operador_conteo (cod_operador, cod_conteo) VALUES
('OP-004', 'CONT-2025-050');

-- ---------
-- Historial y Excepciones
-- ---------

-- Asumimos que el cod_inventario de 'CEM-SOL' es 1, y 'LAD-KK' es 3
INSERT INTO almacen.movimiento (fecha_movimiento, hora_movimiento, tipo_movimiento, cantidad, cod_detalle_recepcion, cod_inventario) VALUES
('2025-10-06', '08:30:00', 'Entrada por Recepción', 200, 1, 1),
('2025-10-07', '08:45:00', 'Entrada por Recepción', 1500, 2, 3);

-- Asumimos que el cod_detalle_recepcion de la primera recepción es 1
INSERT INTO almacen.incidencia (cod_incidencia, tipo_incidencia, fecha_registro, hora_registro, cantidad_afectada, descripcion, cod_detalle_recepcion, cod_detalle_conteo) VALUES
('INC-001', 'Calidad', '2025-10-06', '08:25:00', 5, 'Se encontraron 5 bolsas de cemento húmedas.', 1, NULL),
('INC-002', 'Cantidad', '2025-10-07', '08:50:00', -10, 'Faltaron 10 ladrillos según guía de proveedor.', 2, NULL);
