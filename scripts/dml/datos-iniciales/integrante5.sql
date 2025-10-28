BEGIN;

SET search_path TO Ventas;

TRUNCATE TABLE
    producto,
    cliente,
    metodo_pago,
    vendedor,
    horario,
    vendedor_horario,
    tipo_venta,
    estado_venta,
    tipo_comprobante,
    estado_pago,
    venta,
    producto_venta,
    comprobante,
    caja,
    pago,
    reclamo,
    nota_credito,
    motivo_anulacion,
    anulacion,
    motivo_devolucion,
    devolucion,
    motivo_cambio_prod,
    cambio_producto,
    tipo_grafico,
    reporte
RESTART IDENTITY CASCADE;

-- Evita ambigüedades con fechas
SET datestyle TO ISO, YMD;

-- =========================================================
-- 1) Catálogos
-- =========================================================
INSERT INTO metodo_pago (nombre_metodo_pago) VALUES
('Efectivo'),('Tarjeta débito/crédito'),('Transferencia bancaria'),('Yape/Plin')
ON CONFLICT (nombre_metodo_pago) DO NOTHING;

INSERT INTO tipo_venta (descp_tipo_venta) VALUES
('Credito'),('Contado')
ON CONFLICT (descp_tipo_venta) DO NOTHING;

INSERT INTO estado_venta (descp_estado_venta) VALUES
('Cancelada'),('Por pagar'),('Anulada')
ON CONFLICT (descp_estado_venta) DO NOTHING;

INSERT INTO tipo_comprobante (descp_tipo_comprobante) VALUES
('Boleta'),('Factura'),('Nota de venta'),('Nota de crédito')
ON CONFLICT (descp_tipo_comprobante) DO NOTHING;

INSERT INTO estado_pago (nombre_estado_pago) VALUES
('Pendiente'),('Pagado')
ON CONFLICT (nombre_estado_pago) DO NOTHING;

INSERT INTO tipo_grafico (descp_grafico) VALUES
('Gráfico de barras'),('Gráfico circular'),('Histograma'),('Grafico de bastón')
ON CONFLICT (descp_grafico) DO NOTHING;

-- =========================================================
-- 2) Vendedores, horarios y relación
--    (ahora con nombre_vendedor UNIQUE)
-- =========================================================
INSERT INTO vendedor (nombre_vendedor,fecha_ingreso_vendedor,total_ventas_vendedor) VALUES
('Julián Alvarado',DATE '2022-01-05',0),
('María Cáceres',DATE '2022-03-12',0),
('René Olivares',DATE '2023-09-01',0),
('Mónica Pereira',DATE '2023-10-10',0),
('Patricia Lozano',DATE '2024-07-20',0),
('Diego Paredes',DATE '2024-11-15',0),
('Lucía Quispe',DATE '2025-06-01',0),
('Sofía Márquez',DATE '2025-10-01',0)
ON CONFLICT DO NOTHING;

INSERT INTO horario (hora_ingreso, hora_salida, hora_receso_inicio, hora_receso_fin, dia) VALUES
(TIME '08:00', TIME '16:00', TIME '13:00', TIME '14:00', 'Lunes'),
(TIME '08:00', TIME '16:00', TIME '13:00', TIME '14:00', 'Martes'),
(TIME '08:00', TIME '16:00', TIME '13:00', TIME '14:00', 'Miércoles'),
(TIME '08:00', TIME '16:00', TIME '13:00', TIME '14:00', 'Jueves'),
(TIME '08:00', TIME '16:00', TIME '13:00', TIME '14:00', 'Viernes'),
(TIME '09:00', TIME '14:00', NULL, NULL, 'Sábado')
ON CONFLICT DO NOTHING;

-- Relación vendedor-horario (por fecha de ingreso)
INSERT INTO vendedor_horario (cod_vendedor, cod_horario)
SELECT v.cod_vendedor, h.cod_horario
FROM (
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
JOIN vendedor v ON v.fecha_ingreso_vendedor = x.fecha_ing
JOIN horario  h ON h.dia = x.dia
WHERE NOT EXISTS (
  SELECT 1 FROM vendedor_horario vh
  WHERE vh.cod_vendedor = v.cod_vendedor AND vh.cod_horario = h.cod_horario
);

-- =========================================================
-- 3) Clientes y productos (ahora con precio_producto)
-- =========================================================
INSERT INTO cliente (nombre_cliente) VALUES
('Constructora Andina SAC'),('Ferretero San Martín'),('María López'),('José Pérez'),
('Inversiones Rivera SAC'),('Hotel Sol y Arena'),('Taller Mecanico El Torque'),('Ana García'),
('Carlos Rojas'),('Juanita Paredes'),('Colegio San Ignacio'),('Municipalidad de Parcona'),
('Consorcio Vial Ica'),('Electrosur S.A.'),('Agroexportadora Parcona SAC'),('Taller Los Pinos EIRL')
ON CONFLICT (nombre_cliente) DO NOTHING;

INSERT INTO producto (nombre_producto,precio_producto) VALUES
('Cemento Portland 42.5kg',32.50),('Fierro corrugado 1/2"',12.90),('Martillo carpintero 16oz',24.90),('Taladro percutor 750W',289.00),('Pintura látex blanco 4L',69.90),
('Tornillo drywall #6 x 1" (100u)',18.50),('Lija de agua #220',2.50),('Clavo 3" (100u)',9.90),('Varilla lisa 3/8"',10.50),('Broca para concreto 8mm',14.90),
('Sierra circular 1400W',349.00),('Llave ajustable 10"',29.90),('Cinta métrica 5m',12.90),('Silicona acética 280ml',11.50),('Pegamento de contacto 1L',27.90),
('Guantes de cuero',19.90),('Lentes de seguridad',9.90),('Mascarilla N95 (10u)',24.90),('Cable THHN 12 AWG (100m)',289.00),('Interruptor termomagnético 20A',39.90),
('Tubería PVC 1"',19.50),('Te PVC 1"',6.50),('Codo PVC 1"',5.90),('Brocha 3"',8.90),('Arena fina (m3)',65.00)
ON CONFLICT (nombre_producto) DO UPDATE SET precio_producto=EXCLUDED.precio_producto;

-- =========================================================
-- 4) Cajas
-- =========================================================
INSERT INTO caja (fecha_hora_apertura, fecha_hora_cierre, vendedor_apertura, vendedor_cierre,
                  monto_apertura, monto_cierre, monto_total_ventas, cantidad_ventas)
SELECT * FROM (
  VALUES
  (TIMESTAMP '2025-10-03 08:30', TIMESTAMP '2025-10-03 21:00',
     (SELECT cod_vendedor FROM vendedor WHERE fecha_ingreso_vendedor=DATE '2025-10-01'),
     (SELECT cod_vendedor FROM vendedor WHERE fecha_ingreso_vendedor=DATE '2025-10-01'),
     800.00, 800.00, 800.00, 3),
  (TIMESTAMP '2025-10-04 08:30', TIMESTAMP '2025-10-03 21:00',
     (SELECT cod_vendedor FROM vendedor WHERE fecha_ingreso_vendedor=DATE '2024-11-15'),
     (SELECT cod_vendedor FROM vendedor WHERE fecha_ingreso_vendedor=DATE '2024-11-15'),
     800.00, 1500.00, 700.00, 4),
  (TIMESTAMP '2025-10-05 08:30', TIMESTAMP '2025-10-03 21:00',
     (SELECT cod_vendedor FROM vendedor WHERE fecha_ingreso_vendedor=DATE '2024-07-20'),
     (SELECT cod_vendedor FROM vendedor WHERE fecha_ingreso_vendedor=DATE '2024-07-20'),
     1500.00, 2400.00, 900.00, 2)
) AS t(fe_ap,fe_ci,v_ap,v_ci,m_ap,m_ci,m_tot,cant)
ON CONFLICT DO NOTHING;

-- =========================================================
-- 5) Ventas
-- =========================================================
WITH nuevas_ventas AS (
  INSERT INTO venta
  (fecha_hora_venta, igv, monto_venta, dscto_venta, fecha_venta, fecha_entrega,
   cod_tipo_venta, cod_estado_venta, cod_vendedor, cod_cliente)
  VALUES
  (TIMESTAMP '2025-10-03 09:10',21.60,120.00,0,DATE '2025-10-03',DATE '2025-10-03',
     (SELECT cod_tipo_venta   FROM tipo_venta   WHERE descp_tipo_venta='Contado'),
     (SELECT cod_estado_venta FROM estado_venta WHERE descp_estado_venta='Cancelada'),
     (SELECT cod_vendedor FROM vendedor WHERE fecha_ingreso_vendedor=DATE '2023-10-10'),
     (SELECT cod_cliente  FROM cliente  WHERE nombre_cliente='Ana García')),
  (TIMESTAMP '2025-10-03 09:45',122.40,680.00,0,DATE '2025-10-03',DATE '2025-10-03',
     (SELECT cod_tipo_venta   FROM tipo_venta   WHERE descp_tipo_venta='Contado'),
     (SELECT cod_estado_venta FROM estado_venta WHERE descp_estado_venta='Cancelada'),
     (SELECT cod_vendedor FROM vendedor WHERE fecha_ingreso_vendedor=DATE '2024-07-20'),
     (SELECT cod_cliente  FROM cliente  WHERE nombre_cliente='Inversiones Rivera SAC')),
  (TIMESTAMP '2025-10-03 10:20',171.00,950.00,0,DATE '2025-10-03',DATE '2025-10-04',
     (SELECT cod_tipo_venta   FROM tipo_venta   WHERE descp_tipo_venta='Credito'),
     (SELECT cod_estado_venta FROM estado_venta WHERE descp_estado_venta='Por pagar'),
     (SELECT cod_vendedor FROM vendedor WHERE fecha_ingreso_vendedor=DATE '2025-06-01'),
     (SELECT cod_cliente  FROM cliente  WHERE nombre_cliente='Taller Mecanico El Torque')),
  (TIMESTAMP '2025-10-03 11:05',15.30,85.00,0,DATE '2025-10-03',DATE '2025-10-03',
     (SELECT cod_tipo_venta   FROM tipo_venta   WHERE descp_tipo_venta='Contado'),
     (SELECT cod_estado_venta FROM estado_venta WHERE descp_estado_venta='Cancelada'),
     (SELECT cod_vendedor FROM vendedor WHERE fecha_ingreso_vendedor=DATE '2024-11-15'),
     (SELECT cod_cliente  FROM cliente  WHERE nombre_cliente='Carlos Rojas')),
  (TIMESTAMP '2025-10-03 12:15',255.60,1420.00,0,DATE '2025-10-03',DATE '2025-10-05',
     (SELECT cod_tipo_venta   FROM tipo_venta   WHERE descp_tipo_venta='Credito'),
     (SELECT cod_estado_venta FROM estado_venta WHERE descp_estado_venta='Por pagar'),
     (SELECT cod_vendedor FROM vendedor WHERE fecha_ingreso_vendedor=DATE '2025-10-01'),
     (SELECT cod_cliente  FROM cliente  WHERE nombre_cliente='Hotel Sol y Arena')),
  (TIMESTAMP '2025-10-04 09:00',64.80,360.00,0,DATE '2025-10-04',DATE '2025-10-04',
     (SELECT cod_tipo_venta   FROM tipo_venta   WHERE descp_tipo_venta='Contado'),
     (SELECT cod_estado_venta FROM estado_venta WHERE descp_estado_venta='Cancelada'),
     (SELECT cod_vendedor FROM vendedor WHERE fecha_ingreso_vendedor=DATE '2022-01-05'),
     (SELECT cod_cliente  FROM cliente  WHERE nombre_cliente='María López')),
  (TIMESTAMP '2025-10-04 09:40',225.00,1250.00,0,DATE '2025-10-04',DATE '2025-10-04',
     (SELECT cod_tipo_venta   FROM tipo_venta   WHERE descp_tipo_venta='Contado'),
     (SELECT cod_estado_venta FROM estado_venta WHERE descp_estado_venta='Cancelada'),
     (SELECT cod_vendedor FROM vendedor WHERE fecha_ingreso_vendedor=DATE '2024-07-20'),
     (SELECT cod_cliente  FROM cliente  WHERE nombre_cliente='Ferretero San Martín')),
  (TIMESTAMP '2025-10-04 13:00',176.40,980.00,0,DATE '2025-10-04',DATE '2025-10-05',
     (SELECT cod_tipo_venta   FROM tipo_venta   WHERE descp_tipo_venta='Credito'),
     (SELECT cod_estado_venta FROM estado_venta WHERE descp_estado_venta='Por pagar'),
     (SELECT cod_vendedor FROM vendedor WHERE fecha_ingreso_vendedor=DATE '2025-06-01'),
     (SELECT cod_cliente  FROM cliente  WHERE nombre_cliente='Colegio San Ignacio')),
  (TIMESTAMP '2025-10-04 16:45',37.80,210.00,0,DATE '2025-10-04',DATE '2025-10-04',
     (SELECT cod_tipo_venta   FROM tipo_venta   WHERE descp_tipo_venta='Contado'),
     (SELECT cod_estado_venta FROM estado_venta WHERE descp_estado_venta='Cancelada'),
     (SELECT cod_vendedor FROM vendedor WHERE fecha_ingreso_vendedor=DATE '2024-11-15'),
     (SELECT cod_cliente  FROM cliente  WHERE nombre_cliente='José Pérez')),
  (TIMESTAMP '2025-10-04 18:20',441.00,2450.00,0,DATE '2025-10-04',DATE '2025-10-04',
     (SELECT cod_tipo_venta   FROM tipo_venta   WHERE descp_tipo_venta='Contado'),
     (SELECT cod_estado_venta FROM estado_venta WHERE descp_estado_venta='Cancelada'),
     (SELECT cod_vendedor FROM vendedor WHERE fecha_ingreso_vendedor=DATE '2025-06-01'),
     (SELECT cod_cliente  FROM cliente  WHERE nombre_cliente='Electrosur S.A.')),
  (TIMESTAMP '2025-10-05 08:50',129.60,720.00,0,DATE '2025-10-05',DATE '2025-10-05',
     (SELECT cod_tipo_venta   FROM tipo_venta   WHERE descp_tipo_venta='Contado'),
     (SELECT cod_estado_venta FROM estado_venta WHERE descp_estado_venta='Cancelada'),
     (SELECT cod_vendedor FROM vendedor WHERE fecha_ingreso_vendedor=DATE '2024-07-20'),
     (SELECT cod_cliente  FROM cliente  WHERE nombre_cliente='Agroexportadora Parcona SAC')),
  (TIMESTAMP '2025-10-05 10:10',324.00,1800.00,0,DATE '2025-10-05',DATE '2025-10-07',
     (SELECT cod_tipo_venta   FROM tipo_venta   WHERE descp_tipo_venta='Credito'),
     (SELECT cod_estado_venta FROM estado_venta WHERE descp_estado_venta='Por pagar'),
     (SELECT cod_vendedor FROM vendedor WHERE fecha_ingreso_vendedor=DATE '2025-10-01'),
     (SELECT cod_cliente  FROM cliente  WHERE nombre_cliente='Municipalidad de Parcona')),
  (TIMESTAMP '2025-10-05 11:20',28.80,160.00,0,DATE '2025-10-05',DATE '2025-10-05',
     (SELECT cod_tipo_venta   FROM tipo_venta   WHERE descp_tipo_venta='Contado'),
     (SELECT cod_estado_venta FROM estado_venta WHERE descp_estado_venta='Cancelada'),
     (SELECT cod_vendedor FROM vendedor WHERE fecha_ingreso_vendedor=DATE '2023-10-10'),
     (SELECT cod_cliente  FROM cliente  WHERE nombre_cliente='Juanita Paredes')),
  (TIMESTAMP '2025-10-05 12:40',198.00,1100.00,0,DATE '2025-10-05',DATE '2025-10-08',
     (SELECT cod_tipo_venta   FROM tipo_venta   WHERE descp_tipo_venta='Credito'),
     (SELECT cod_estado_venta FROM estado_venta WHERE descp_estado_venta='Por pagar'),
     (SELECT cod_vendedor FROM vendedor WHERE fecha_ingreso_vendedor=DATE '2025-06-01'),
     (SELECT cod_cliente  FROM cliente  WHERE nombre_cliente='Consorcio Vial Ica')),
  (TIMESTAMP '2025-10-05 15:30',77.40,430.00,0,DATE '2025-10-05',DATE '2025-10-06',
     (SELECT cod_tipo_venta   FROM tipo_venta   WHERE descp_tipo_venta='Credito'),
     (SELECT cod_estado_venta FROM estado_venta WHERE descp_estado_venta='Anulada'),
     (SELECT cod_vendedor FROM vendedor WHERE fecha_ingreso_vendedor=DATE '2024-11-15'),
     (SELECT cod_cliente  FROM cliente  WHERE nombre_cliente='Taller Los Pinos EIRL'))
  RETURNING cod_venta, fecha_hora_venta
)
SELECT 1;

-- =========================================================
-- 6) Detalle por venta
-- =========================================================
INSERT INTO producto_venta (cod_venta, cod_producto, cantidad_producto)
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
JOIN venta v    ON v.fecha_hora_venta = q.ts
JOIN producto p ON p.nombre_producto = q.prod
ON CONFLICT DO NOTHING;

-- =========================================================
-- 7) Comprobantes (los 9 primeros)
-- =========================================================
INSERT INTO comprobante (cod_tipo_comprobante, fecha_emision)
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
JOIN tipo_comprobante tc ON tc.descp_tipo_comprobante = d.tipo
ON CONFLICT DO NOTHING;

-- =========================================================
-- 8) Pagos
-- =========================================================
INSERT INTO pago
(cod_venta, fecha_vencimiento_pago, fecha_pago, monto_pago, cod_caja, nro_comprobante, cod_metodo_pago, cod_estado_pago)
SELECT v.cod_venta, d.f_venc, d.f_pago, d.monto,
       c.cod_caja, NULL,
       (SELECT cod_metodo_pago FROM metodo_pago WHERE nombre_metodo_pago = d.metodo),
       (SELECT cod_estado_pago FROM estado_pago WHERE nombre_estado_pago = 'Pagado')
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
JOIN venta v ON v.fecha_hora_venta = d.ts
JOIN caja  c ON c.fecha_hora_apertura = d.caja_ap;

-- Pendientes: 3,5,8,12,14
INSERT INTO pago
(cod_venta, fecha_vencimiento_pago, fecha_pago, monto_pago, cod_caja, nro_comprobante, cod_metodo_pago, cod_estado_pago)
SELECT v.cod_venta, d.f_venc, NULL, d.monto, NULL, NULL, NULL,
       (SELECT cod_estado_pago FROM estado_pago WHERE nombre_estado_pago = 'Pendiente')
FROM (VALUES
 (TIMESTAMP '2025-10-03 10:20', DATE '2025-10-10',  950.00),
 (TIMESTAMP '2025-10-03 12:15', DATE '2025-10-12', 1420.00),
 (TIMESTAMP '2025-10-04 13:00', DATE '2025-10-11',  980.00),
 (TIMESTAMP '2025-10-05 10:10', DATE '2025-10-15', 1800.00),
 (TIMESTAMP '2025-10-05 12:40', DATE '2025-10-14', 1100.00)
) d(ts, f_venc, monto)
JOIN venta v ON v.fecha_hora_venta = d.ts;

-- =========================================================
-- 9) POSVENTA
-- =========================================================
INSERT INTO motivo_devolucion (descp_motivo_devolucion) VALUES
('Producto defectuoso'),('Error de tamaño'),('No conforme')
ON CONFLICT (descp_motivo_devolucion) DO NOTHING;

INSERT INTO motivo_cambio_prod (descp_motivo_cambio_prod) VALUES
('Falla de fábrica'),('Cambio de modelo')
ON CONFLICT (descp_motivo_cambio_prod) DO NOTHING;

INSERT INTO motivo_anulacion (descp_motivo_anulacion) VALUES
('Error en emisión'),('Cliente desistió')
ON CONFLICT (descp_motivo_anulacion) DO NOTHING;

INSERT INTO reclamo (cod_venta, fecha_hora_reclamo) VALUES
((SELECT cod_venta FROM venta WHERE fecha_hora_venta=TIMESTAMP '2025-10-05 08:50'), TIMESTAMP '2025-10-05 13:20'),
((SELECT cod_venta FROM venta WHERE fecha_hora_venta=TIMESTAMP '2025-10-05 15:30'), TIMESTAMP '2025-10-05 16:10'),
((SELECT cod_venta FROM venta WHERE fecha_hora_venta=TIMESTAMP '2025-10-04 09:40'), TIMESTAMP '2025-10-04 10:00'),
((SELECT cod_venta FROM venta WHERE fecha_hora_venta=TIMESTAMP '2025-10-04 13:00'), TIMESTAMP '2025-10-04 13:30'),
((SELECT cod_venta FROM venta WHERE fecha_hora_venta=TIMESTAMP '2025-10-05 10:10'), TIMESTAMP '2025-10-05 10:50');

-- Comprobantes extra para Notas de crédito (3)
INSERT INTO comprobante (cod_tipo_comprobante, fecha_emision)
SELECT (SELECT cod_tipo_comprobante FROM tipo_comprobante WHERE descp_tipo_comprobante='Nota de crédito'),
       d.fecha
FROM (VALUES (DATE '2025-10-05'),(DATE '2025-10-04'),(DATE '2025-10-05')) d(fecha)
ON CONFLICT DO NOTHING;

-- Notas de crédito
INSERT INTO nota_credito (nro_comprobante, cod_reclamo, monto_comprobante, descripcion_nota)
SELECT c.nro_comprobante,
       (SELECT r.cod_reclamo FROM reclamo r JOIN venta v ON v.cod_venta=r.cod_venta
         WHERE v.fecha_hora_venta=TIMESTAMP '2025-10-05 08:50'),
       350.00,'NC por devolución de sierra circular 1400W'
FROM comprobante c JOIN tipo_comprobante tc ON tc.cod_tipo_comprobante=c.cod_tipo_comprobante
WHERE tc.descp_tipo_comprobante='Nota de crédito' AND c.fecha_emision=DATE '2025-10-05'
ORDER BY c.nro_comprobante DESC LIMIT 1;

INSERT INTO nota_credito (nro_comprobante, cod_reclamo, monto_comprobante, descripcion_nota)
SELECT c.nro_comprobante,
       (SELECT r.cod_reclamo FROM reclamo r JOIN venta v ON v.cod_venta=r.cod_venta
         WHERE v.fecha_hora_venta=TIMESTAMP '2025-10-04 09:40'),
       200.00,'NC por varilla con medida errada'
FROM comprobante c JOIN tipo_comprobante tc ON tc.cod_tipo_comprobante=c.cod_tipo_comprobante
WHERE tc.descp_tipo_comprobante='Nota de crédito' AND c.fecha_emision=DATE '2025-10-04'
ORDER BY c.nro_comprobante DESC LIMIT 1;

INSERT INTO nota_credito (nro_comprobante, cod_reclamo, monto_comprobante, descripcion_nota)
SELECT c.nro_comprobante,
       (SELECT r.cod_reclamo FROM reclamo r JOIN venta v ON v.cod_venta=r.cod_venta
         WHERE v.fecha_hora_venta=TIMESTAMP '2025-10-05 10:10'),
       500.00,'NC por arena no conforme'
FROM comprobante c JOIN tipo_comprobante tc ON tc.cod_tipo_comprobante=c.cod_tipo_comprobante
WHERE tc.descp_tipo_comprobante='Nota de crédito' AND c.fecha_emision=DATE '2025-10-05'
ORDER BY c.nro_comprobante ASC LIMIT 1;

-- Devoluciones
INSERT INTO devolucion (cod_reclamo,cod_motivo_devolucion,monto_devolucion,cod_caja,producto_devuelto) VALUES
((SELECT r.cod_reclamo FROM reclamo r JOIN venta v ON v.cod_venta=r.cod_venta WHERE v.fecha_hora_venta=TIMESTAMP '2025-10-05 08:50'),
 (SELECT cod_motivo_devolucion FROM motivo_devolucion WHERE descp_motivo_devolucion='Producto defectuoso'),
 350.00,(SELECT cod_caja FROM caja WHERE fecha_hora_apertura=TIMESTAMP '2025-10-05 08:30'),
 (SELECT cod_producto FROM producto WHERE nombre_producto='Sierra circular 1400W')),
((SELECT r.cod_reclamo FROM reclamo r JOIN venta v ON v.cod_venta=r.cod_venta WHERE v.fecha_hora_venta=TIMESTAMP '2025-10-04 09:40'),
 (SELECT cod_motivo_devolucion FROM motivo_devolucion WHERE descp_motivo_devolucion='Error de tamaño'),
 200.00,(SELECT cod_caja FROM caja WHERE fecha_hora_apertura=TIMESTAMP '2025-10-04 08:30'),
 (SELECT cod_producto FROM producto WHERE nombre_producto='Varilla lisa 3/8"')),
((SELECT r.cod_reclamo FROM reclamo r JOIN venta v ON v.cod_venta=r.cod_venta WHERE v.fecha_hora_venta=TIMESTAMP '2025-10-05 10:10'),
 (SELECT cod_motivo_devolucion FROM motivo_devolucion WHERE descp_motivo_devolucion='No conforme'),
 500.00,(SELECT cod_caja FROM caja WHERE fecha_hora_apertura=TIMESTAMP '2025-10-05 08:30'),
 (SELECT cod_producto FROM producto WHERE nombre_producto='Arena fina (m3)'));

-- Cambios de producto
INSERT INTO cambio_producto (cod_reclamo,cod_motivo_cambio_prod,producto_retornado,producto_entregado) VALUES
((SELECT r.cod_reclamo FROM reclamo r JOIN venta v ON v.cod_venta=r.cod_venta WHERE v.fecha_hora_venta=TIMESTAMP '2025-10-05 08:50'),
 (SELECT cod_motivo_cambio_prod FROM motivo_cambio_prod WHERE descp_motivo_cambio_prod='Falla de fábrica'),
 (SELECT cod_producto FROM producto WHERE nombre_producto='Llave ajustable 10"'),
 (SELECT cod_producto FROM producto WHERE nombre_producto='Llave ajustable 10"')),
((SELECT r.cod_reclamo FROM reclamo r JOIN venta v ON v.cod_venta=r.cod_venta WHERE v.fecha_hora_venta=TIMESTAMP '2025-10-04 13:00'),
 (SELECT cod_motivo_cambio_prod FROM motivo_cambio_prod WHERE descp_motivo_cambio_prod='Cambio de modelo'),
 (SELECT cod_producto FROM producto WHERE nombre_producto='Interruptor termomagnético 20A'),
 (SELECT cod_producto FROM producto WHERE nombre_producto='Interruptor termomagnético 20A'));

-- Anulación
INSERT INTO anulacion (cod_reclamo, cod_motivo_anulacion)
VALUES (
  (SELECT cod_reclamo FROM reclamo r JOIN venta v ON v.cod_venta=r.cod_venta
   WHERE v.fecha_hora_venta=TIMESTAMP '2025-10-05 15:30'),
  (SELECT cod_motivo_anulacion FROM motivo_anulacion WHERE descp_motivo_anulacion='Cliente desistió')
);

-- =========================================================
-- 10) Reportes
-- =========================================================
INSERT INTO reporte (fecha_hora_creacion,fecha_inicio_datos,fecha_fin_datos,descp_reporte,cod_tipo_grafico) VALUES
(DEFAULT,DATE '2023-01-01',DATE '2023-12-31','Ingresos 2023 por mes',
 (SELECT cod_tipo_grafico FROM tipo_grafico WHERE descp_grafico='Gráfico de barras')),
(DEFAULT,DATE '2024-04-01',DATE '2025-03-31','Reclamos Abril 2024 - Marzo 2025 por motivo',
 (SELECT cod_tipo_grafico FROM tipo_grafico WHERE descp_grafico='Gráfico circular')),
(DEFAULT,DATE '2025-05-01',DATE '2025-05-31','Ingresos mensuales marzo 2025 por vendedor',
 (SELECT cod_tipo_grafico FROM tipo_grafico WHERE descp_grafico='Gráfico de barras'));

COMMIT;
