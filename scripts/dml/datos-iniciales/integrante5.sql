BEGIN;

-- Métodos de pago (1..4)
INSERT INTO Ventas.metodo_pago (nombre_metodo_pago) VALUES
('Efectivo'),('Tarjeta débito/crédito'),('Transferencia bancaria'),('Yape/Plin');

-- Tipo de venta (1=Credito, 2=Contado)
INSERT INTO Ventas.tipo_venta (descp_tipo_venta) VALUES ('Credito'),('Contado');

-- Estado de venta (1=Cancelada, 2=Por pagar, 3=Anulada)
INSERT INTO Ventas.estado_venta (descp_estado_venta) VALUES ('Cancelada'),('Por pagar'),('Anulada');

-- Tipo de comprobante (1..4)
INSERT INTO Ventas.tipo_comprobante (descp_tipo_comprobante) VALUES
('Boleta'),('Factura'),('Nota de venta'),('Nota de crédito');

-- Estado de pago (1=Por pagar, 2=Pagado)
INSERT INTO Ventas.estado_pago (nombre_estado_pago) VALUES ('Pendiente'),('Pagado');

-- Vendedores (1..8)
INSERT INTO Ventas.vendedor (fecha_ingreso_vendedor, total_ventas_vendedor) VALUES
('2022-01-05',0),('2022-03-12',0),('2023-09-01',0),('2023-10-10',0),
('2024-07-20',0),('2024-11-15',0),('2025-06-01',0),('2025-10-01',0);

-- Horarios
INSERT INTO ventas.horario (hora_ingreso, hora_salida, hora_receso_inicio, hora_receso_fin, dia) VALUES
('08:00','16:00','13:00','14:00','Lunes'),
('08:00','16:00','13:00','14:00','Martes'),
('08:00','16:00','13:00','14:00','Miércoles'),
('08:00','16:00','13:00','14:00','Jueves'),
('08:00','16:00','13:00','14:00','Viernes'),
('09:00','14:00',NULL, NULL,'Sábado');

-- Relación Vendedores y Horarios
INSERT INTO ventas.vendedor_horario VALUES
(1,1),(1,2),(1,3),(1,4),(1,5),(1,6),
(2,1),(2,2),(2,3),(2,4),(2,5),
(3,1),(3,2),(3,3),(3,4),(3,5),(3,6),
(4,1),(4,3),(4,5),
(5,2),(5,4),(5,6),
(6,1),(6,2),(6,3),(6,4),(6,5),(6,6),
(7,1),(7,2),(7,3),(7,4),(7,5),(7,6),
(8,1),(8,2),(8,3),(8,4),(8,5);

-- Clientes (1..16)
INSERT INTO Ventas.cliente (nombre_cliente) VALUES
('Constructora Andina SAC'),('Ferretero San Martín'),('María López'),('José Pérez'),
('Inversiones Rivera SAC'),('Hotel Sol y Arena'),('Taller Mecanico El Torque'),('Ana García'),
('Carlos Rojas'),('Juanita Paredes'),('Colegio San Ignacio'),('Municipalidad de Parcona'),
('Consorcio Vial Ica'),('Electrosur S.A.'),('Agroexportadora Parcona SAC'),('Taller Los Pinos EIRL');

-- Productos (1..25)
INSERT INTO Ventas.producto (nombre_producto) VALUES
('Cemento Portland 42.5kg'),('Fierro corrugado 1/2"'),('Martillo carpintero 16oz'),
('Taladro percutor 750W'),('Pintura látex blanco 4L'),('Tornillo drywall #6 x 1" (100u)'),
('Lija de agua #220'),('Clavo 3" (100u)'),('Varilla lisa 3/8"'),('Broca para concreto 8mm'),
('Sierra circular 1400W'),('Llave ajustable 10"'),('Cinta métrica 5m'),('Silicona acética 280ml'),
('Pegamento de contacto 1L'),('Guantes de cuero'),('Lentes de seguridad'),('Mascarilla N95 (10u)'),
('Cable THHN 12 AWG (100m)'),('Interruptor termomagnético 20A'),('Tubería PVC 1"'),
('Te PVC 1"'),('Codo PVC 1"'),('Brocha 3"'),('Arena fina (m3)');

-- Cajas (1..3)
INSERT INTO Ventas.caja (fecha_hora_apertura, fecha_hora_cierre, vendedor_apertura, vendedor_cierre, monto_apertura, monto_cierre, monto_total_ventas, cantidad_ventas) VALUES
('2025-10-03 08:30', '2025-10-03 21:00', 8, 8, 800.00, 800.00, 800.00, 3),
('2025-10-04 08:30', '2025-10-03 21:00', 6, 6, 800.00, 1500.00, 700.00, 4),
('2025-10-05 08:30', '2025-10-03 21:00', 5, 5, 1500.00, 2400.00, 900.00, 2);

-- 15 VENTAS (1..15)
-- 03-oct
INSERT INTO Ventas.venta VALUES
(DEFAULT,'2025-10-03 09:10',21.60,120.00,0,'2025-10-03','2025-10-03',2,1,4,8),
(DEFAULT,'2025-10-03 09:45',122.40,680.00,0,'2025-10-03','2025-10-03',2,1,5,5),
(DEFAULT,'2025-10-03 10:20',171.00,950.00,0,'2025-10-03','2025-10-04',1,2,7,7),
(DEFAULT,'2025-10-03 11:05',15.30,85.00,0,'2025-10-03','2025-10-03',2,1,6,9),
(DEFAULT,'2025-10-03 12:15',255.60,1420.00,0,'2025-10-03','2025-10-05',1,2,8,6);
-- 04-oct
INSERT INTO Ventas.venta VALUES
(DEFAULT,'2025-10-04 09:00',64.80,360.00,0,'2025-10-04','2025-10-04',2,1,1,3),
(DEFAULT,'2025-10-04 09:40',225.00,1250.00,0,'2025-10-04','2025-10-04',2,1,5,2),
(DEFAULT,'2025-10-04 13:00',176.40,980.00,0,'2025-10-04','2025-10-05',1,2,7,11),
(DEFAULT,'2025-10-04 16:45',37.80,210.00,0,'2025-10-04','2025-10-04',2,1,6,4),
(DEFAULT,'2025-10-04 18:20',441.00,2450.00,0,'2025-10-04','2025-10-04',2,1,7,14);
-- 05-oct
INSERT INTO Ventas.venta VALUES
(DEFAULT,'2025-10-05 08:50',129.60,720.00,0,'2025-10-05','2025-10-05',2,1,5,15),
(DEFAULT,'2025-10-05 10:10',324.00,1800.00,0,'2025-10-05','2025-10-07',1,2,8,12),
(DEFAULT,'2025-10-05 11:20',28.80,160.00,0,'2025-10-05','2025-10-05',2,1,4,10),
(DEFAULT,'2025-10-05 12:40',198.00,1100.00,0,'2025-10-05','2025-10-08',1,2,7,13),
(DEFAULT,'2025-10-05 15:30',77.40,430.00,0,'2025-10-05','2025-10-06',1,3,6,16);

-- Detalle por venta
INSERT INTO Ventas.producto_venta VALUES
(1,3,1),(1,13,1),(1,17,1),
(2,1,10),(2,2,8),
(3,12,2),(3,6,3),(3,14,4),
(4,5,1),(4,7,4),(4,24,1),
(5,4,1),(5,10,2),(5,16,2),
(6,5,1),(6,24,1),(6,13,1),
(7,1,15),(7,9,10),
(8,20,10),(8,19,2),(8,21,30),(8,22,20),(8,23,20),
(9,4,1),(9,3,1),
(10,19,4),(10,20,30),
(11,11,1),(11,16,4),(11,17,4),
(12,9,25),(12,1,30),(12,25,5),
(13,8,3),(13,5,1),
(14,2,40),(14,1,40),
(15,15,5),(15,14,10),(15,6,4);

-- Comprobantes para ventas Canceladas (9 filas → IDs 1..9)
INSERT INTO Ventas.comprobante VALUES
(DEFAULT,1,'2025-10-03'),
(DEFAULT,2,'2025-10-03'),
(DEFAULT,1,'2025-10-03'),
(DEFAULT,1,'2025-10-04'),
(DEFAULT,2,'2025-10-04'),
(DEFAULT,1,'2025-10-04'),
(DEFAULT,2,'2025-10-04'),
(DEFAULT,2,'2025-10-05'),
(DEFAULT,1,'2025-10-05');

-- Pagos “Pagado” (cod_estado_pago=2) → ventas 1,2,4,6,7,9,10,11,13
INSERT INTO Ventas.pago VALUES
(DEFAULT,1,'2025-10-03','2025-10-03',120.00,1,1,1,2),
(DEFAULT,2,'2025-10-03','2025-10-03',680.00,1,2,3,2),
(DEFAULT,4,'2025-10-03','2025-10-03', 85.00,1,3,4,2),
(DEFAULT,6,'2025-10-04','2025-10-04',360.00,2,4,2,2),
(DEFAULT,7,'2025-10-04','2025-10-04',1250.00,2,5,3,2),
(DEFAULT,9,'2025-10-04','2025-10-04',210.00,2,6,1,2),
(DEFAULT,10,'2025-10-04','2025-10-04',2450.00,2,7,3,2),
(DEFAULT,11,'2025-10-05','2025-10-05',720.00,3,8,3,2),
(DEFAULT,13,'2025-10-05','2025-10-05',160.00,3,9,1,2);

-- Pagos “Por pagar” (cod_estado_pago=1) → ventas 3,5,8,12,14 (con campos de pago en NULL)
INSERT INTO Ventas.pago (cod_venta, fecha_vencimiento_pago, fecha_pago, monto_pago, cod_caja, nro_comprobante, cod_metodo_pago, cod_estado_pago) VALUES
(3,'2025-10-10',NULL, 950.00,NULL,NULL,NULL,1),
(5,'2025-10-12',NULL,1420.00,NULL,NULL,NULL,1),
(8,'2025-10-11',NULL, 980.00,NULL,NULL,NULL,1),
(12,'2025-10-15',NULL,1800.00,NULL,NULL,NULL,1),
(14,'2025-10-14',NULL,1100.00,NULL,NULL,NULL,1);

/* ------------------- POSVENTA ------------------- */
-- Motivos
INSERT INTO Ventas.motivo_devolucion (descp_motivo_devolucion) VALUES
('Producto defectuoso'),('Error de tamaño'),('No conforme');

INSERT INTO Ventas.motivo_cambio_prod (descp_motivo_cambio_prod) VALUES
('Falla de fábrica'),('Cambio de modelo');

INSERT INTO Ventas.motivo_anulacion (descp_motivo_anulacion) VALUES
('Error en emisión'),('Cliente desistió');

-- Reclamos (IDs 1..5)
INSERT INTO Ventas.reclamo VALUES
(DEFAULT,11,'2025-10-05 13:20'),  -- R1
(DEFAULT,15,'2025-10-05 16:10'),  -- R2
(DEFAULT,7,'2025-10-04 10:00'),   -- R3
(DEFAULT,8,'2025-10-04 13:30'),   -- R4
(DEFAULT,12,'2025-10-05 10:50');  -- R5

-- Comprobantes para Notas de crédito (IDs 10..12)
INSERT INTO Ventas.comprobante VALUES
(DEFAULT,4,'2025-10-05 13:25'),  -- 10
(DEFAULT,4,'2025-10-04 10:05'),  -- 11
(DEFAULT,4,'2025-10-05 10:55');  -- 12

-- Nota de crédito
INSERT INTO Ventas.nota_credito VALUES
(10,1,350.00,'NC por devolución de sierra circular 1400W'),
(11,3,200.00,'NC por varilla con medida errada'),
(12,5,500.00,'NC por arena no conforme');

-- Devoluciones
INSERT INTO Ventas.devolucion VALUES
(DEFAULT,1,1,350.00,3,11),   -- R1, sierra
(DEFAULT,3,2,200.00,2,9),    -- R3, varilla
(DEFAULT,5,3,500.00,3,25);   -- R5, arena

INSERT INTO Ventas.cambio_producto VALUES
(DEFAULT,1,1,11,11),  -- R1
(DEFAULT,4,2,20,20);  -- R4

-- Anulación por “Cliente desistió” (R2)
INSERT INTO Ventas.anulacion VALUES
(DEFAULT,2,2);

-- Solicitud de reportes
INSERT INTO ventas.reporte (fecha_hora_creacion, fecha_inicio_datos, fecha_fin_datos, descp_reporte, tipo_grafico) VALUES 
(DEFAULT, '01-01-23','31-12-23','Ingresos 2023 por mes','Gráfico de barras'),
(DEFAULT, '01-04-24','31-03-25','Reclamos Abril 2024 - Marzo 2025 por motivo','Gráfico circular'),
(DEFAULT, '01-05-25','31-05-25','Ingresos mensuales marzo 2025 por vendedor','Gráfico de barras');

COMMIT;