BEGIN;
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

TRUNCATE TABLE
    Ventas.producto,
	Ventas.cliente,
	Ventas.metodo_pago,
	Ventas.vendedor,
	Ventas.horario,
	Ventas.vendedor_horario,
	Ventas.tipo_venta,
	Ventas.estado_venta,
	Ventas.tipo_comprobante,
	Ventas.estado_pago,
	Ventas.venta,
	Ventas.producto_venta,
	Ventas.comprobante,
	Ventas.caja,
	Ventas.pago,
	Ventas.reclamo,
	Ventas.nota_credito,
	Ventas.motivo_anulacion,
	Ventas.anulacion,
	Ventas.motivo_devolucion,
	Ventas.devolucion,
	Ventas.motivo_cambio_prod,
	Ventas.cambio_producto,
	Ventas.tipo_grafico,
	Ventas.reporte
RESTART IDENTITY CASCADE;

-- Evita ambigüedades con fechas
SET datestyle TO ISO, YMD;

-- Asegura la extensión para UUID v4 (si usas uuid_generate_v4)
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- =========================================================
-- 1) Catálogos
-- =========================================================
INSERT INTO Ventas.metodo_pago (nombre_metodo_pago) VALUES
('Efectivo'),('Tarjeta débito/crédito'),('Transferencia bancaria'),('Yape/Plin')
ON CONFLICT (nombre_metodo_pago) DO NOTHING;

INSERT INTO Ventas.tipo_venta (descp_tipo_venta) VALUES
('Credito'),('Contado')
ON CONFLICT (descp_tipo_venta) DO NOTHING;

INSERT INTO Ventas.estado_venta (descp_estado_venta) VALUES
('Cancelada'),('Por pagar'),('Anulada')
ON CONFLICT (descp_estado_venta) DO NOTHING;

INSERT INTO Ventas.tipo_comprobante (descp_tipo_comprobante) VALUES
('Boleta'),('Factura'),('Nota de venta'),('Nota de crédito')
ON CONFLICT (descp_tipo_comprobante) DO NOTHING;

INSERT INTO Ventas.estado_pago (nombre_estado_pago) VALUES
('Pendiente'),('Pagado')
ON CONFLICT (nombre_estado_pago) DO NOTHING;

INSERT INTO Ventas.tipo_grafico (descp_grafico) VALUES
('Gráfico de barras'),('Gráfico circular'),('Histograma'),('Grafico de bastón')
ON CONFLICT (descp_grafico) DO NOTHING;

-- =========================================================
-- 2) Vendedores, horarios y relación
-- =========================================================
INSERT INTO Ventas.vendedor (fecha_ingreso_vendedor, total_ventas_vendedor) VALUES
(DATE '2022-01-05',0),(DATE '2022-03-12',0),(DATE '2023-09-01',0),(DATE '2023-10-10',0),
(DATE '2024-07-20',0),(DATE '2024-11-15',0),(DATE '2025-06-01',0),(DATE '2025-10-01',0)
ON CONFLICT DO NOTHING;

INSERT INTO Ventas.horario (hora_ingreso, hora_salida, hora_receso_inicio, hora_receso_fin, dia) VALUES
(TIME '08:00', TIME '16:00', TIME '13:00', TIME '14:00', 'Lunes'),
(TIME '08:00', TIME '16:00', TIME '13:00', TIME '14:00', 'Martes'),
(TIME '08:00', TIME '16:00', TIME '13:00', TIME '14:00', 'Miércoles'),
(TIME '08:00', TIME '16:00', TIME '13:00', TIME '14:00', 'Jueves'),
(TIME '08:00', TIME '16:00', TIME '13:00', TIME '14:00', 'Viernes'),
(TIME '09:00', TIME '14:00', NULL, NULL, 'Sábado')
ON CONFLICT DO NOTHING;

INSERT INTO Ventas.vendedor_horario (cod_vendedor, cod_horario)
SELECT v.cod_vendedor, h.cod_horario FROM (
  VALUES
  (DATE '2022-01-05','Lunes'),(DATE '2022-01-05','Martes'),(DATE '2022-01-05','Miércoles'),
  (DATE '2022-01-05','Jueves'),(DATE '2022-01-05','Viernes'),(DATE '2022-01-05','Sábado'),
  (DATE '2022-03-12','Lunes'),(DATE '2022-03-12','Martes'),(DATE '2022-03-12','Miércoles'),
  (DATE '2022-03-12','Jueves'),(DATE '2022-03-12','Viernes'),
  (DATE '2023-09-01','Lunes'),(DATE '2023-09-01','Martes'),(DATE '2023-09-01','Miércoles'),
  (DATE '2023-09-01','Jueves'),(DATE '2023-09-01','Viernes'),(DATE '2023-09-01','Sábado'),
  (DATE '2023-10-10','Lunes'),(DATE '2023-10-10','Miércoles'),(DATE '2023-10-10','Viernes'),
  (DATE '2024-07-20','Martes'),(DATE '2024-07-20','Jueves'),(DATE '2024-07-20','Sábado'),
  (DATE '2024-11-15','Lunes'),(DATE '2024-11-15','Martes'),(DATE '2024-11-15','Miércoles'),
  (DATE '2024-11-15','Jueves'),(DATE '2024-11-15','Viernes'),(DATE '2024-11-15','Sábado'),
  (DATE '2025-06-01','Lunes'),(DATE '2025-06-01','Martes'),(DATE '2025-06-01','Miércoles'),
  (DATE '2025-06-01','Jueves'),(DATE '2025-06-01','Viernes'),(DATE '2025-06-01','Sábado'),
  (DATE '2025-10-01','Lunes'),(DATE '2025-10-01','Martes'),(DATE '2025-10-01','Miércoles'),
  (DATE '2025-10-01','Jueves'),(DATE '2025-10-01','Viernes')
) x(fecha_ing, dia)
JOIN Ventas.vendedor v ON v.fecha_ingreso_vendedor = x.fecha_ing
JOIN Ventas.horario  h ON h.dia = x.dia
ON CONFLICT DO NOTHING;

-- =========================================================
-- 3) Clientes y productos
-- =========================================================
INSERT INTO Ventas.cliente (nombre_cliente) VALUES
('Constructora Andina SAC'),('Ferretero San Martín'),('María López'),('José Pérez'),
('Inversiones Rivera SAC'),('Hotel Sol y Arena'),('Taller Mecanico El Torque'),('Ana García'),
('Carlos Rojas'),('Juanita Paredes'),('Colegio San Ignacio'),('Municipalidad de Parcona'),
('Consorcio Vial Ica'),('Electrosur S.A.'),('Agroexportadora Parcona SAC'),('Taller Los Pinos EIRL')
ON CONFLICT (nombre_cliente) DO NOTHING;

INSERT INTO Ventas.producto (nombre_producto) VALUES
('Cemento Portland 42.5kg'),('Fierro corrugado 1/2"'),('Martillo carpintero 16oz'),
('Taladro percutor 750W'),('Pintura látex blanco 4L'),('Tornillo drywall #6 x 1" (100u)'),
('Lija de agua #220'),('Clavo 3" (100u)'),('Varilla lisa 3/8"'),('Broca para concreto 8mm'),
('Sierra circular 1400W'),('Llave ajustable 10"'),('Cinta métrica 5m'),('Silicona acética 280ml'),
('Pegamento de contacto 1L'),('Guantes de cuero'),('Lentes de seguridad'),('Mascarilla N95 (10u)'),
('Cable THHN 12 AWG (100m)'),('Interruptor termomagnético 20A'),('Tubería PVC 1"'),
('Te PVC 1"'),('Codo PVC 1"'),('Brocha 3"'),('Arena fina (m3)')
ON CONFLICT (nombre_producto) DO NOTHING;

-- =========================================================
-- 4) Cajas
-- =========================================================
INSERT INTO Ventas.caja (fecha_hora_apertura, fecha_hora_cierre, vendedor_apertura, vendedor_cierre,
                         monto_apertura, monto_cierre, monto_total_ventas, cantidad_ventas)
SELECT * FROM (
  VALUES
  (TIMESTAMP '2025-10-03 08:30', TIMESTAMP '2025-10-03 21:00',
     (SELECT cod_vendedor FROM Ventas.vendedor WHERE fecha_ingreso_vendedor=DATE '2025-10-01'),
     (SELECT cod_vendedor FROM Ventas.vendedor WHERE fecha_ingreso_vendedor=DATE '2025-10-01'),
     800.00, 800.00, 800.00, 3),
  (TIMESTAMP '2025-10-04 08:30', TIMESTAMP '2025-10-03 21:00',
     (SELECT cod_vendedor FROM Ventas.vendedor WHERE fecha_ingreso_vendedor=DATE '2024-11-15'),
     (SELECT cod_vendedor FROM Ventas.vendedor WHERE fecha_ingreso_vendedor=DATE '2024-11-15'),
     800.00, 1500.00, 700.00, 4),
  (TIMESTAMP '2025-10-05 08:30', TIMESTAMP '2025-10-03 21:00',
     (SELECT cod_vendedor FROM Ventas.vendedor WHERE fecha_ingreso_vendedor=DATE '2024-07-20'),
     (SELECT cod_vendedor FROM Ventas.vendedor WHERE fecha_ingreso_vendedor=DATE '2024-07-20'),
     1500.00, 2400.00, 900.00, 2)
) AS t(fe_ap,fe_ci,v_ap,v_ci,m_ap,m_ci,m_tot,cant)
ON CONFLICT DO NOTHING;

-- =========================================================
-- 5) Ventas
-- =========================================================
WITH nuevas_ventas AS (
  INSERT INTO Ventas.venta
  (fecha_hora_venta, igv, monto_venta, dscto_venta, fecha_venta, fecha_entrega,
   cod_tipo_venta, cod_estado_venta, cod_vendedor, cod_cliente)
  VALUES
  (TIMESTAMP '2025-10-03 09:10',21.60,120.00,0,DATE '2025-10-03',DATE '2025-10-03',
     (SELECT cod_tipo_venta   FROM Ventas.tipo_venta   WHERE descp_tipo_venta='Contado'),
     (SELECT cod_estado_venta FROM Ventas.estado_venta WHERE descp_estado_venta='Cancelada'),
     (SELECT cod_vendedor FROM Ventas.vendedor WHERE fecha_ingreso_vendedor=DATE '2023-10-10'),
     (SELECT cod_cliente  FROM Ventas.cliente  WHERE nombre_cliente='Ana García')),
  (TIMESTAMP '2025-10-03 09:45',122.40,680.00,0,DATE '2025-10-03',DATE '2025-10-03',
     (SELECT cod_tipo_venta   FROM Ventas.tipo_venta   WHERE descp_tipo_venta='Contado'),
     (SELECT cod_estado_venta FROM Ventas.estado_venta WHERE descp_estado_venta='Cancelada'),
     (SELECT cod_vendedor FROM Ventas.vendedor WHERE fecha_ingreso_vendedor=DATE '2024-07-20'),
     (SELECT cod_cliente  FROM Ventas.cliente  WHERE nombre_cliente='Inversiones Rivera SAC')),
  (TIMESTAMP '2025-10-03 10:20',171.00,950.00,0,DATE '2025-10-03',DATE '2025-10-04',
     (SELECT cod_tipo_venta   FROM Ventas.tipo_venta   WHERE descp_tipo_venta='Credito'),
     (SELECT cod_estado_venta FROM Ventas.estado_venta WHERE descp_estado_venta='Por pagar'),
     (SELECT cod_vendedor FROM Ventas.vendedor WHERE fecha_ingreso_vendedor=DATE '2025-06-01'),
     (SELECT cod_cliente  FROM Ventas.cliente  WHERE nombre_cliente='Taller Mecanico El Torque')),
  (TIMESTAMP '2025-10-03 11:05',15.30,85.00,0,DATE '2025-10-03',DATE '2025-10-03',
     (SELECT cod_tipo_venta   FROM Ventas.tipo_venta   WHERE descp_tipo_venta='Contado'),
     (SELECT cod_estado_venta FROM Ventas.estado_venta WHERE descp_estado_venta='Cancelada'),
     (SELECT cod_vendedor FROM Ventas.vendedor WHERE fecha_ingreso_vendedor=DATE '2024-11-15'),
     (SELECT cod_cliente  FROM Ventas.cliente  WHERE nombre_cliente='Carlos Rojas')),
  (TIMESTAMP '2025-10-03 12:15',255.60,1420.00,0,DATE '2025-10-03',DATE '2025-10-05',
     (SELECT cod_tipo_venta   FROM Ventas.tipo_venta   WHERE descp_tipo_venta='Credito'),
     (SELECT cod_estado_venta FROM Ventas.estado_venta WHERE descp_estado_venta='Por pagar'),
     (SELECT cod_vendedor FROM Ventas.vendedor WHERE fecha_ingreso_vendedor=DATE '2025-10-01'),
     (SELECT cod_cliente  FROM Ventas.cliente  WHERE nombre_cliente='Hotel Sol y Arena')),
  (TIMESTAMP '2025-10-04 09:00',64.80,360.00,0,DATE '2025-10-04',DATE '2025-10-04',
     (SELECT cod_tipo_venta   FROM Ventas.tipo_venta   WHERE descp_tipo_venta='Contado'),
     (SELECT cod_estado_venta FROM Ventas.estado_venta WHERE descp_estado_venta='Cancelada'),
     (SELECT cod_vendedor FROM Ventas.vendedor WHERE fecha_ingreso_vendedor=DATE '2022-01-05'),
     (SELECT cod_cliente  FROM Ventas.cliente  WHERE nombre_cliente='María López')),
  (TIMESTAMP '2025-10-04 09:40',225.00,1250.00,0,DATE '2025-10-04',DATE '2025-10-04',
     (SELECT cod_tipo_venta   FROM Ventas.tipo_venta   WHERE descp_tipo_venta='Contado'),
     (SELECT cod_estado_venta FROM Ventas.estado_venta WHERE descp_estado_venta='Cancelada'),
     (SELECT cod_vendedor FROM Ventas.vendedor WHERE fecha_ingreso_vendedor=DATE '2024-07-20'),
     (SELECT cod_cliente  FROM Ventas.cliente  WHERE nombre_cliente='Ferretero San Martín')),
  (TIMESTAMP '2025-10-04 13:00',176.40,980.00,0,DATE '2025-10-04',DATE '2025-10-05',
     (SELECT cod_tipo_venta   FROM Ventas.tipo_venta   WHERE descp_tipo_venta='Credito'),
     (SELECT cod_estado_venta FROM Ventas.estado_venta WHERE descp_estado_venta='Por pagar'),
     (SELECT cod_vendedor FROM Ventas.vendedor WHERE fecha_ingreso_vendedor=DATE '2025-06-01'),
     (SELECT cod_cliente  FROM Ventas.cliente  WHERE nombre_cliente='Colegio San Ignacio')),
  (TIMESTAMP '2025-10-04 16:45',37.80,210.00,0,DATE '2025-10-04',DATE '2025-10-04',
     (SELECT cod_tipo_venta   FROM Ventas.tipo_venta   WHERE descp_tipo_venta='Contado'),
     (SELECT cod_estado_venta FROM Ventas.estado_venta WHERE descp_estado_venta='Cancelada'),
     (SELECT cod_vendedor FROM Ventas.vendedor WHERE fecha_ingreso_vendedor=DATE '2024-11-15'),
     (SELECT cod_cliente  FROM Ventas.cliente  WHERE nombre_cliente='José Pérez')),
  (TIMESTAMP '2025-10-04 18:20',441.00,2450.00,0,DATE '2025-10-04',DATE '2025-10-04',
     (SELECT cod_tipo_venta   FROM Ventas.tipo_venta   WHERE descp_tipo_venta='Contado'),
     (SELECT cod_estado_venta FROM Ventas.estado_venta WHERE descp_estado_venta='Cancelada'),
     (SELECT cod_vendedor FROM Ventas.vendedor WHERE fecha_ingreso_vendedor=DATE '2025-06-01'),
     (SELECT cod_cliente  FROM Ventas.cliente  WHERE nombre_cliente='Electrosur S.A.')),
  (TIMESTAMP '2025-10-05 08:50',129.60,720.00,0,DATE '2025-10-05',DATE '2025-10-05',
     (SELECT cod_tipo_venta   FROM Ventas.tipo_venta   WHERE descp_tipo_venta='Contado'),
     (SELECT cod_estado_venta FROM Ventas.estado_venta WHERE descp_estado_venta='Cancelada'),
     (SELECT cod_vendedor FROM Ventas.vendedor WHERE fecha_ingreso_vendedor=DATE '2024-07-20'),
     (SELECT cod_cliente  FROM Ventas.cliente  WHERE nombre_cliente='Agroexportadora Parcona SAC')),
  (TIMESTAMP '2025-10-05 10:10',324.00,1800.00,0,DATE '2025-10-05',DATE '2025-10-07',
     (SELECT cod_tipo_venta   FROM Ventas.tipo_venta   WHERE descp_tipo_venta='Credito'),
     (SELECT cod_estado_venta FROM Ventas.estado_venta WHERE descp_estado_venta='Por pagar'),
     (SELECT cod_vendedor FROM Ventas.vendedor WHERE fecha_ingreso_vendedor=DATE '2025-10-01'),
     (SELECT cod_cliente  FROM Ventas.cliente  WHERE nombre_cliente='Municipalidad de Parcona')),
  (TIMESTAMP '2025-10-05 11:20',28.80,160.00,0,DATE '2025-10-05',DATE '2025-10-05',
     (SELECT cod_tipo_venta   FROM Ventas.tipo_venta   WHERE descp_tipo_venta='Contado'),
     (SELECT cod_estado_venta FROM Ventas.estado_venta WHERE descp_estado_venta='Cancelada'),
     (SELECT cod_vendedor FROM Ventas.vendedor WHERE fecha_ingreso_vendedor=DATE '2023-10-10'),
     (SELECT cod_cliente  FROM Ventas.cliente  WHERE nombre_cliente='Juanita Paredes')),
  (TIMESTAMP '2025-10-05 12:40',198.00,1100.00,0,DATE '2025-10-05',DATE '2025-10-08',
     (SELECT cod_tipo_venta   FROM Ventas.tipo_venta   WHERE descp_tipo_venta='Credito'),
     (SELECT cod_estado_venta FROM Ventas.estado_venta WHERE descp_estado_venta='Por pagar'),
     (SELECT cod_vendedor FROM Ventas.vendedor WHERE fecha_ingreso_vendedor=DATE '2025-06-01'),
     (SELECT cod_cliente  FROM Ventas.cliente  WHERE nombre_cliente='Consorcio Vial Ica')),
  (TIMESTAMP '2025-10-05 15:30',77.40,430.00,0,DATE '2025-10-05',DATE '2025-10-06',
     (SELECT cod_tipo_venta   FROM Ventas.tipo_venta   WHERE descp_tipo_venta='Credito'),
     (SELECT cod_estado_venta FROM Ventas.estado_venta WHERE descp_estado_venta='Anulada'),
     (SELECT cod_vendedor FROM Ventas.vendedor WHERE fecha_ingreso_vendedor=DATE '2024-11-15'),
     (SELECT cod_cliente  FROM Ventas.cliente  WHERE nombre_cliente='Taller Los Pinos EIRL'))
  RETURNING cod_venta, fecha_hora_venta
)
SELECT 1;

-- =========================================================
-- 6) Detalle por venta
-- =========================================================
INSERT INTO Ventas.producto_venta (cod_venta, cod_producto, cantidad_producto)
SELECT v.cod_venta, p.cod_producto, q.cant
FROM (VALUES
 (TIMESTAMP '2025-10-03 09:10','Martillo carpintero 16oz',1),
 (TIMESTAMP '2025-10-03 09:10','Cinta métrica 5m',1),
 (TIMESTAMP '2025-10-03 09:10','Lentes de seguridad',1),

 (TIMESTAMP '2025-10-03 09:45','Cemento Portland 42.5kg',10),
 (TIMESTAMP '2025-10-03 09:45','Fierro corrugado 1/2"',8),

 (TIMESTAMP '2025-10-03 10:20','Llave ajustable 10"',2),
 (TIMESTAMP '2025-10-03 10:20','Tornillo drywall #6 x 1" (100u)',3),
 (TIMESTAMP '2025-10-03 10:20','Silicona acética 280ml',4),

 (TIMESTAMP '2025-10-03 11:05','Pintura látex blanco 4L',1),
 (TIMESTAMP '2025-10-03 11:05','Lija de agua #220',4),
 (TIMESTAMP '2025-10-03 11:05','Brocha 3"',1),

 (TIMESTAMP '2025-10-03 12:15','Taladro percutor 750W',1),
 (TIMESTAMP '2025-10-03 12:15','Broca para concreto 8mm',2),
 (TIMESTAMP '2025-10-03 12:15','Guantes de cuero',2),

 (TIMESTAMP '2025-10-04 09:00','Pintura látex blanco 4L',1),
 (TIMESTAMP '2025-10-04 09:00','Brocha 3"',1),
 (TIMESTAMP '2025-10-04 09:00','Cinta métrica 5m',1),

 (TIMESTAMP '2025-10-04 09:40','Cemento Portland 42.5kg',15),
 (TIMESTAMP '2025-10-04 09:40','Varilla lisa 3/8"',10),

 (TIMESTAMP '2025-10-04 13:00','Interruptor termomagnético 20A',10),
 (TIMESTAMP '2025-10-04 13:00','Cable THHN 12 AWG (100m)',2),
 (TIMESTAMP '2025-10-04 13:00','Tubería PVC 1"',30),
 (TIMESTAMP '2025-10-04 13:00','Te PVC 1"',20),
 (TIMESTAMP '2025-10-04 13:00','Codo PVC 1"',20),

 (TIMESTAMP '2025-10-04 16:45','Taladro percutor 750W',1),
 (TIMESTAMP '2025-10-04 16:45','Martillo carpintero 16oz',1),

 (TIMESTAMP '2025-10-04 18:20','Cable THHN 12 AWG (100m)',4),
 (TIMESTAMP '2025-10-04 18:20','Interruptor termomagnético 20A',30),

 (TIMESTAMP '2025-10-05 08:50','Sierra circular 1400W',1),
 (TIMESTAMP '2025-10-05 08:50','Guantes de cuero',4),
 (TIMESTAMP '2025-10-05 08:50','Lentes de seguridad',4),

 (TIMESTAMP '2025-10-05 10:10','Varilla lisa 3/8"',25),
 (TIMESTAMP '2025-10-05 10:10','Cemento Portland 42.5kg',30),
 (TIMESTAMP '2025-10-05 10:10','Arena fina (m3)',5),

 (TIMESTAMP '2025-10-05 11:20','Clavo 3" (100u)',3),
 (TIMESTAMP '2025-10-05 11:20','Pintura látex blanco 4L',1),

 (TIMESTAMP '2025-10-05 12:40','Fierro corrugado 1/2"',40),
 (TIMESTAMP '2025-10-05 12:40','Cemento Portland 42.5kg',40),

 (TIMESTAMP '2025-10-05 15:30','Pegamento de contacto 1L',5),
 (TIMESTAMP '2025-10-05 15:30','Silicona acética 280ml',10),
 (TIMESTAMP '2025-10-05 15:30','Tornillo drywall #6 x 1" (100u)',4)
) q(ts, prod, cant)
JOIN Ventas.venta v    ON v.fecha_hora_venta = q.ts
JOIN Ventas.producto p ON p.nombre_producto = q.prod
ON CONFLICT DO NOTHING;

-- =========================================================
-- 7) Comprobantes (los 9 primeros)
-- =========================================================
INSERT INTO Ventas.comprobante (cod_tipo_comprobante, fecha_emision)
SELECT tc.cod_tipo_comprobante, d.fecha
FROM (VALUES
 ('Boleta',  DATE '2025-10-03'),
 ('Factura', DATE '2025-10-03'),
 ('Boleta',  DATE '2025-10-03'),
 ('Boleta',  DATE '2025-10-04'),
 ('Factura', DATE '2025-10-04'),
 ('Boleta',  DATE '2025-10-04'),
 ('Factura', DATE '2025-10-04'),
 ('Factura', DATE '2025-10-05'),
 ('Boleta',  DATE '2025-10-05')
) d(tipo, fecha)
JOIN Ventas.tipo_comprobante tc ON tc.descp_tipo_comprobante = d.tipo
ON CONFLICT DO NOTHING;

-- =========================================================
-- 8) Pagos
-- =========================================================
-- Pagados (sin amarrar comprobante para simplificar)
INSERT INTO Ventas.pago
(cod_venta, fecha_vencimiento_pago, fecha_pago, monto_pago, cod_caja, nro_comprobante, cod_metodo_pago, cod_estado_pago)
SELECT v.cod_venta, d.f_venc, d.f_pago, d.monto,
       c.cod_caja, NULL,
       (SELECT cod_metodo_pago FROM Ventas.metodo_pago WHERE nombre_metodo_pago = d.metodo),
       (SELECT cod_estado_pago FROM Ventas.estado_pago WHERE nombre_estado_pago = 'Pagado')
FROM (VALUES
 (TIMESTAMP '2025-10-03 09:10', DATE '2025-10-03', DATE '2025-10-03', 120.00, TIMESTAMP '2025-10-03 08:30','Efectivo'),
 (TIMESTAMP '2025-10-03 09:45', DATE '2025-10-03', DATE '2025-10-03', 680.00, TIMESTAMP '2025-10-04 08:30','Transferencia bancaria'),
 (TIMESTAMP '2025-10-03 11:05', DATE '2025-10-03', DATE '2025-10-03',  85.00, TIMESTAMP '2025-10-03 08:30','Yape/Plin'),
 (TIMESTAMP '2025-10-04 09:00', DATE '2025-10-04', DATE '2025-10-04', 360.00, TIMESTAMP '2025-10-04 08:30','Tarjeta débito/crédito'),
 (TIMESTAMP '2025-10-04 09:40', DATE '2025-10-04', DATE '2025-10-04',1250.00, TIMESTAMP '2025-10-04 08:30','Transferencia bancaria'),
 (TIMESTAMP '2025-10-04 16:45', DATE '2025-10-04', DATE '2025-10-04', 210.00, TIMESTAMP '2025-10-04 08:30','Efectivo'),
 (TIMESTAMP '2025-10-04 18:20', DATE '2025-10-04', DATE '2025-10-04',2450.00, TIMESTAMP '2025-10-04 08:30','Transferencia bancaria'),
 (TIMESTAMP '2025-10-05 08:50', DATE '2025-10-05', DATE '2025-10-05', 720.00, TIMESTAMP '2025-10-05 08:30','Transferencia bancaria'),
 (TIMESTAMP '2025-10-05 11:20', DATE '2025-10-05', DATE '2025-10-05', 160.00, TIMESTAMP '2025-10-05 08:30','Efectivo')
) d(ts, f_venc, f_pago, monto, caja_ap, metodo)
JOIN Ventas.venta v ON v.fecha_hora_venta = d.ts
JOIN Ventas.caja  c ON c.fecha_hora_apertura = d.caja_ap;

-- Pendientes: 3,5,8,12,14
INSERT INTO Ventas.pago
(cod_venta, fecha_vencimiento_pago, fecha_pago, monto_pago, cod_caja, nro_comprobante, cod_metodo_pago, cod_estado_pago)
SELECT v.cod_venta, d.f_venc, NULL, d.monto, NULL, NULL, NULL,
       (SELECT cod_estado_pago FROM Ventas.estado_pago WHERE nombre_estado_pago = 'Pendiente')
FROM (VALUES
 (TIMESTAMP '2025-10-03 10:20', DATE '2025-10-10',  950.00),
 (TIMESTAMP '2025-10-03 12:15', DATE '2025-10-12', 1420.00),
 (TIMESTAMP '2025-10-04 13:00', DATE '2025-10-11',  980.00),
 (TIMESTAMP '2025-10-05 10:10', DATE '2025-10-15', 1800.00),
 (TIMESTAMP '2025-10-05 12:40', DATE '2025-10-14', 1100.00)
) d(ts, f_venc, monto)
JOIN Ventas.venta v ON v.fecha_hora_venta = d.ts;

-- =========================================================
-- 9) POSVENTA
-- =========================================================
INSERT INTO Ventas.motivo_devolucion (descp_motivo_devolucion) VALUES
('Producto defectuoso'),('Error de tamaño'),('No conforme')
ON CONFLICT (descp_motivo_devolucion) DO NOTHING;

INSERT INTO Ventas.motivo_cambio_prod (descp_motivo_cambio_prod) VALUES
('Falla de fábrica'),('Cambio de modelo')
ON CONFLICT (descp_motivo_cambio_prod) DO NOTHING;

INSERT INTO Ventas.motivo_anulacion (descp_motivo_anulacion) VALUES
('Error en emisión'),('Cliente desistió')
ON CONFLICT (descp_motivo_anulacion) DO NOTHING;

-- Reclamos
INSERT INTO Ventas.reclamo (cod_venta, fecha_hora_reclamo) VALUES
((SELECT cod_venta FROM Ventas.venta WHERE fecha_hora_venta=TIMESTAMP '2025-10-05 08:50'), TIMESTAMP '2025-10-05 13:20'),
((SELECT cod_venta FROM Ventas.venta WHERE fecha_hora_venta=TIMESTAMP '2025-10-05 15:30'), TIMESTAMP '2025-10-05 16:10'),
((SELECT cod_venta FROM Ventas.venta WHERE fecha_hora_venta=TIMESTAMP '2025-10-04 09:40'), TIMESTAMP '2025-10-04 10:00'),
((SELECT cod_venta FROM Ventas.venta WHERE fecha_hora_venta=TIMESTAMP '2025-10-04 13:00'), TIMESTAMP '2025-10-04 13:30'),
((SELECT cod_venta FROM Ventas.venta WHERE fecha_hora_venta=TIMESTAMP '2025-10-05 10:10'), TIMESTAMP '2025-10-05 10:50');

-- Comprobantes adicionales para Notas de crédito (3)
INSERT INTO Ventas.comprobante (cod_tipo_comprobante, fecha_emision)
SELECT (SELECT cod_tipo_comprobante FROM Ventas.tipo_comprobante WHERE descp_tipo_comprobante='Nota de crédito'),
       d.fecha
FROM (VALUES (DATE '2025-10-05'),(DATE '2025-10-04'),(DATE '2025-10-05')) d(fecha)
ON CONFLICT DO NOTHING;

-- === Nota de crédito (sin UNION, 3 INSERT separados) ===
-- R1: venta 2025-10-05 08:50 (último comprobante del 2025-10-05)
INSERT INTO Ventas.nota_credito (nro_comprobante, cod_reclamo, monto_comprobante, descripcion_nota)
SELECT c.nro_comprobante,
       (SELECT r.cod_reclamo
          FROM Ventas.reclamo r
          JOIN Ventas.venta v ON v.cod_venta = r.cod_venta
         WHERE v.fecha_hora_venta = TIMESTAMP '2025-10-05 08:50'),
       350.00,
       'NC por devolución de sierra circular 1400W'
FROM Ventas.comprobante c
JOIN Ventas.tipo_comprobante tc ON tc.cod_tipo_comprobante = c.cod_tipo_comprobante
WHERE tc.descp_tipo_comprobante = 'Nota de crédito'
  AND c.fecha_emision = DATE '2025-10-05'
ORDER BY c.nro_comprobante DESC
LIMIT 1;

-- R3: venta 2025-10-04 09:40 (el único del 2025-10-04)
INSERT INTO Ventas.nota_credito (nro_comprobante, cod_reclamo, monto_comprobante, descripcion_nota)
SELECT c.nro_comprobante,
       (SELECT r.cod_reclamo
          FROM Ventas.reclamo r
          JOIN Ventas.venta v ON v.cod_venta = r.cod_venta
         WHERE v.fecha_hora_venta = TIMESTAMP '2025-10-04 09:40'),
       200.00,
       'NC por varilla con medida errada'
FROM Ventas.comprobante c
JOIN Ventas.tipo_comprobante tc ON tc.cod_tipo_comprobante = c.cod_tipo_comprobante
WHERE tc.descp_tipo_comprobante = 'Nota de crédito'
  AND c.fecha_emision = DATE '2025-10-04'
ORDER BY c.nro_comprobante DESC
LIMIT 1;

-- R5: venta 2025-10-05 10:10 (primer comprobante del 2025-10-05)
INSERT INTO Ventas.nota_credito (nro_comprobante, cod_reclamo, monto_comprobante, descripcion_nota)
SELECT c.nro_comprobante,
       (SELECT r.cod_reclamo
          FROM Ventas.reclamo r
          JOIN Ventas.venta v ON v.cod_venta = r.cod_venta
         WHERE v.fecha_hora_venta = TIMESTAMP '2025-10-05 10:10'),
       500.00,
       'NC por arena no conforme'
FROM Ventas.comprobante c
JOIN Ventas.tipo_comprobante tc ON tc.cod_tipo_comprobante = c.cod_tipo_comprobante
WHERE tc.descp_tipo_comprobante = 'Nota de crédito'
  AND c.fecha_emision = DATE '2025-10-05'
ORDER BY c.nro_comprobante ASC
LIMIT 1;

-- Devoluciones
INSERT INTO Ventas.devolucion
(cod_reclamo, cod_motivo_devolucion, monto_devolucion, cod_caja, producto_devuelto)
VALUES
(
  (SELECT cod_reclamo FROM Ventas.reclamo r JOIN Ventas.venta v ON v.cod_venta=r.cod_venta
   WHERE v.fecha_hora_venta=TIMESTAMP '2025-10-05 08:50'),
  (SELECT cod_motivo_devolucion FROM Ventas.motivo_devolucion WHERE descp_motivo_devolucion='Producto defectuoso'),
  350.00,
  (SELECT cod_caja FROM Ventas.caja WHERE fecha_hora_apertura=TIMESTAMP '2025-10-05 08:30'),
  (SELECT cod_producto FROM Ventas.producto WHERE nombre_producto='Sierra circular 1400W')
),
(
  (SELECT cod_reclamo FROM Ventas.reclamo r JOIN Ventas.venta v ON v.cod_venta=r.cod_venta
   WHERE v.fecha_hora_venta=TIMESTAMP '2025-10-04 09:40'),
  (SELECT cod_motivo_devolucion FROM Ventas.motivo_devolucion WHERE descp_motivo_devolucion='Error de tamaño'),
  200.00,
  (SELECT cod_caja FROM Ventas.caja WHERE fecha_hora_apertura=TIMESTAMP '2025-10-04 08:30'),
  (SELECT cod_producto FROM Ventas.producto WHERE nombre_producto='Varilla lisa 3/8"')
),
(
  (SELECT cod_reclamo FROM Ventas.reclamo r JOIN Ventas.venta v ON v.cod_venta=r.cod_venta
   WHERE v.fecha_hora_venta=TIMESTAMP '2025-10-05 10:10'),
  (SELECT cod_motivo_devolucion FROM Ventas.motivo_devolucion WHERE descp_motivo_devolucion='No conforme'),
  500.00,
  (SELECT cod_caja FROM Ventas.caja WHERE fecha_hora_apertura=TIMESTAMP '2025-10-05 08:30'),
  (SELECT cod_producto FROM Ventas.producto WHERE nombre_producto='Arena fina (m3)')
);

-- Cambios de producto
INSERT INTO Ventas.cambio_producto
(cod_reclamo, cod_motivo_cambio_prod, producto_retornado, producto_entregado)
VALUES
(
  (SELECT cod_reclamo FROM Ventas.reclamo r JOIN Ventas.venta v ON v.cod_venta=r.cod_venta
   WHERE v.fecha_hora_venta=TIMESTAMP '2025-10-05 08:50'),
  (SELECT cod_motivo_cambio_prod FROM Ventas.motivo_cambio_prod WHERE descp_motivo_cambio_prod='Falla de fábrica'),
  (SELECT cod_producto FROM Ventas.producto WHERE nombre_producto='Llave ajustable 10"'),
  (SELECT cod_producto FROM Ventas.producto WHERE nombre_producto='Llave ajustable 10"')
),
(
  (SELECT cod_reclamo FROM Ventas.reclamo r JOIN Ventas.venta v ON v.cod_venta=r.cod_venta
   WHERE v.fecha_hora_venta=TIMESTAMP '2025-10-04 13:00'),
  (SELECT cod_motivo_cambio_prod FROM Ventas.motivo_cambio_prod WHERE descp_motivo_cambio_prod='Cambio de modelo'),
  (SELECT cod_producto FROM Ventas.producto WHERE nombre_producto='Interruptor termomagnético 20A'),
  (SELECT cod_producto FROM Ventas.producto WHERE nombre_producto='Interruptor termomagnético 20A')
);

-- Anulación por “Cliente desistió” (reclamo de la venta 2025-10-05 15:30)
INSERT INTO Ventas.anulacion (cod_reclamo, cod_motivo_anulacion)
VALUES (
  (SELECT cod_reclamo FROM Ventas.reclamo r JOIN Ventas.venta v ON v.cod_venta=r.cod_venta
   WHERE v.fecha_hora_venta=TIMESTAMP '2025-10-05 15:30'),
  (SELECT cod_motivo_anulacion FROM Ventas.motivo_anulacion WHERE descp_motivo_anulacion='Cliente desistió')
);

-- =========================================================
-- 10) Reportes
-- =========================================================
INSERT INTO Ventas.reporte
(fecha_hora_creacion, fecha_inicio_datos, fecha_fin_datos, descp_reporte, cod_tipo_grafico)
VALUES
(DEFAULT, DATE '2023-01-01', DATE '2023-12-31', 'Ingresos 2023 por mes',
 (SELECT cod_tipo_grafico FROM Ventas.tipo_grafico WHERE descp_grafico='Gráfico de barras')),
(DEFAULT, DATE '2024-04-01', DATE '2025-03-31', 'Reclamos Abril 2024 - Marzo 2025 por motivo',
 (SELECT cod_tipo_grafico FROM Ventas.tipo_grafico WHERE descp_grafico='Gráfico circular')),
(DEFAULT, DATE '2025-05-01', DATE '2025-05-31', 'Ingresos mensuales marzo 2025 por vendedor',
 (SELECT cod_tipo_grafico FROM Ventas.tipo_grafico WHERE descp_grafico='Gráfico de barras'));

COMMIT;



