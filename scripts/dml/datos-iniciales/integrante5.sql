SET search_path TO "Ventas";

-- Limpieza total
TRUNCATE TABLE
  cambio_producto,
  devolucion,
  anulacion,
  reclamo,
  pago,
  producto_venta,
  venta,
  comprobante,
  caja,
  vendedor,
  usuario,
  maestro,
  cliente,
  -- lookups:
  estado_venta,
  metodo_pago,
  condicion_pago,
  estado_pago,
  tipo_comprobante,
  estado_producto_venta,
  estado_reclamo,
  motivo_anulacion,
  motivo_devolucion,
  motivo_cambio_prod,
  producto
RESTART IDENTITY CASCADE;

-- ----------------------------------------------------------------
-- Índices únicos (case-insensitive) para evitar duplicados lookups
-- ----------------------------------------------------------------
CREATE UNIQUE INDEX IF NOT EXISTS ux_estado_venta_desc
  ON estado_venta (lower(descp_estado_venta));
CREATE UNIQUE INDEX IF NOT EXISTS ux_condicion_pago_desc
  ON condicion_pago (lower(descp_cond_pago));
CREATE UNIQUE INDEX IF NOT EXISTS ux_metodo_pago_desc
  ON metodo_pago (lower(descp_metodo_pago));
CREATE UNIQUE INDEX IF NOT EXISTS ux_estado_pago_nombre
  ON estado_pago (lower(nombre_estado_pago));
CREATE UNIQUE INDEX IF NOT EXISTS ux_tipo_comprobante_desc
  ON tipo_comprobante (lower(descp_tipo_comprobante));
CREATE UNIQUE INDEX IF NOT EXISTS ux_estado_prodv_desc
  ON estado_producto_venta (lower(descp_estado_prodv));
CREATE UNIQUE INDEX IF NOT EXISTS ux_estado_reclamo_desc
  ON estado_reclamo (lower(descp_estado_reclamo));
CREATE UNIQUE INDEX IF NOT EXISTS ux_motivo_anulacion_desc
  ON motivo_anulacion (lower(descp_motivo_anulacion));
CREATE UNIQUE INDEX IF NOT EXISTS ux_motivo_devolucion_desc
  ON motivo_devolucion (lower(descp_motivo_devolucion));
CREATE UNIQUE INDEX IF NOT EXISTS ux_motivo_cambio_prod_desc
  ON motivo_cambio_prod (lower(descp_motivo_cambio_prod));
CREATE UNIQUE INDEX IF NOT EXISTS ux_producto_nombre
  ON producto (lower(nombre_producto));

-- ---------------------------
-- 1) LOOKUPS / CATÁLOGOS
-- ---------------------------
INSERT INTO estado_venta (descp_estado_venta) VALUES
  ('Por pagar'), ('Pagada'), ('Anulada')
ON CONFLICT DO NOTHING;

INSERT INTO condicion_pago (descp_cond_pago) VALUES
  ('Contado'), ('Crédito')
ON CONFLICT DO NOTHING;

INSERT INTO metodo_pago (descp_metodo_pago) VALUES
  ('Efectivo'), ('Tarjeta'), ('Transferencia'), ('Yape'), ('Plin')
ON CONFLICT DO NOTHING;

INSERT INTO estado_pago (nombre_estado_pago) VALUES
  ('pendiente'), ('pagado'), ('vencido'), ('anulado')
ON CONFLICT DO NOTHING;

INSERT INTO tipo_comprobante (descp_tipo_comprobante) VALUES
  ('boleta'), ('factura'), ('nota de venta')
ON CONFLICT DO NOTHING;

INSERT INTO estado_producto_venta (descp_estado_prodv) VALUES
  ('entregado'), ('pendiente'), ('devuelto'), ('cambiado')
ON CONFLICT DO NOTHING;

INSERT INTO estado_reclamo (descp_estado_reclamo) VALUES
  ('abierto'), ('en proceso'), ('resuelto'), ('cerrado sin acción')
ON CONFLICT DO NOTHING;

INSERT INTO motivo_anulacion (descp_motivo_anulacion) VALUES
  ('error de facturación'), ('cliente desistió'), ('duplicado'), ('fraude detectado')
ON CONFLICT DO NOTHING;

INSERT INTO motivo_devolucion (descp_motivo_devolucion) VALUES
  ('producto defectuoso'), ('arrepentimiento'), ('error en producto enviado'), ('demora en entrega')
ON CONFLICT DO NOTHING;

INSERT INTO motivo_cambio_prod (descp_motivo_cambio_prod) VALUES
  ('talla/color incorrecto'), ('upgrade de producto'), ('defecto menor'), ('otro')
ON CONFLICT DO NOTHING;

-- ---------------------------
-- 2) CLIENTES / USUARIOS
-- ---------------------------
INSERT INTO cliente (fecha_registro_cliente, ultima_actividad_cliente)
SELECT
  now() - (gs * interval '1 day'),
  now() - (floor(random()*gs)::int * interval '1 hour')
FROM generate_series(1,200) gs;

INSERT INTO maestro (cod_cliente, fecha_registro_maestro, ultima_actividad_maestro)
SELECT c.cod_cliente,
       c.fecha_registro_cliente + interval '1 hour',
       c.ultima_actividad_cliente
FROM cliente c
WHERE c.cod_cliente <= 60;

INSERT INTO usuario (fecha_registro_usuario)
SELECT now() - (gs * interval '6 hours')
FROM generate_series(1,120) gs;

-- ---------------------------
-- 3) VENDEDORES
-- ---------------------------
INSERT INTO vendedor (nombre_vendedor, fecha_ingreso_vendedor, total_ventas_vendedor) VALUES
  ('Ana Quispe',      '2023-02-01', 0),
  ('Bruno Salazar',   '2023-05-15', 0),
  ('Carla Mendoza',   '2024-01-10', 0),
  ('Diego Paredes',   '2024-06-20', 0),
  ('Elena Rivas',     '2024-09-01', 0),
  ('Fabio Tello',     '2025-01-05', 0),
  ('Gina Córdova',    '2025-03-01', 0),
  ('Hugo Villanueva', '2025-05-12', 0)
ON CONFLICT (nombre_vendedor) DO NOTHING;

-- ---------------------------
-- 4) CAJAS (aperturas/cierres)
-- ---------------------------
WITH cnt AS (SELECT count(*) c FROM vendedor),
g AS (
  SELECT gs AS n,
         (SELECT cod_vendedor FROM vendedor ORDER BY cod_vendedor LIMIT 1
            OFFSET ((gs    ) % (SELECT c FROM cnt))) AS vend_open,
         (SELECT cod_vendedor FROM vendedor ORDER BY cod_vendedor LIMIT 1
            OFFSET ((gs + 1) % (SELECT c FROM cnt))) AS vend_close
  FROM generate_series(0,19) gs
)
INSERT INTO caja (fecha_hora_apertura, fecha_hora_cierre, vendedor_apertura, vendedor_cierre, monto_apertura, monto_cierre, monto_total_ingresos)
SELECT
  now() - ((20 - g.n) * interval '3 days') + time '09:00',
  now() - ((20 - g.n) * interval '3 days') + time '18:00',
  g.vend_open,
  g.vend_close,
  round((500 + (random()*500))::numeric, 2),
  0,
  0
FROM g;

-- ---------------------------
-- 5) PRODUCTOS (FERRETERÍA) con puntos
-- ---------------------------
INSERT INTO producto (nombre_producto, unidad_medida, puntos_producto, precio_venta) VALUES
  ('Cemento Tipo I 42.5kg',        'saco',   80, 36.90),
  ('Yeso construcción 25kg',       'saco',   45, 22.50),
  ('Arena fina m3',                'm3',    120, 69.00),
  ('Piedra chancada m3',           'm3',    120, 74.00),
  ('Ladrillo King Kong',           'unidad',  1,  0.85),
  ('Ladrillo Pandereta',           'unidad',  1,  0.75),
  ('Fierro corrugado 1/2" x 9m',   'barra',  55, 63.00),
  ('Fierro corrugado 3/8" x 9m',   'barra',  40, 39.50),
  ('Clavos 2" 1kg',                'kg',     10,  8.90),
  ('Alambre recocido 1kg',         'kg',     10, 10.50),
  ('Madera tornillo 2x4x3m',       'pieza',  25, 39.90),
  ('Plancha triplay 15mm',         'pieza',  40, 95.00),
  ('Drywall placa 1.22x2.44m',     'pieza',  35, 48.00),
  ('Perfil galvanizado T',         'pieza',  12, 14.90),
  ('Pintura látex 1gal',           'galón',  40, 69.90),
  ('Pintura esmalte 1gal',         'galón',  45, 79.90),
  ('Sellador acrílico 1gal',       'galón',  30, 49.90),
  ('Thinner 1gal',                 'galón',  20, 42.00),
  ('Brocha 3"',                    'unidad',  6,  8.50),
  ('Rodillo 9" con marco',         'unidad',  8, 14.90),
  ('Silicona neutra 280ml',        'unidad',  6, 12.50),
  ('Cinta masking 48mm x 40m',     'rollo',   4,  6.90),
  ('Pega azulejo 25kg',            'saco',   35, 28.90),
  ('Fragüe 5kg',                   'bolsa',   8, 13.90),
  ('Cerámica piso 60x60 (caja)',   'caja',   90, 72.00),
  ('Pegamento PVC 118ml',          'unidad',  4,  9.90),
  ('Tubo PVC 1/2" x 3m',           'pieza',   6,  7.50),
  ('Codo PVC 1/2"',                'unidad',  2,  0.90),
  ('Válvula esfera 1/2"',          'unidad', 10, 12.90),
  ('Cable THW 12 AWG 100m',        'rollo', 120, 239.00),
  ('Cable THW 14 AWG 100m',        'rollo', 100, 199.00),
  ('Toma corriente simple',        'unidad',  6, 11.90),
  ('Interruptor simple',           'unidad',  6, 10.90),
  ('Foco LED 12W',                 'unidad',  4,  7.90),
  ('Tablero térmico 2 polos',      'unidad', 30, 59.00),
  ('Taladro percutor 13mm',        'unidad',180, 269.00),
  ('Amoladora 4-1/2"',             'unidad',160, 219.00),
  ('Escalera aluminio 6 peldaños', 'unidad',140, 319.00),
  ('Guantes de nitrilo',           'par',     3,  5.90),
  ('Casco de seguridad',           'unidad', 12, 24.90),
  ('Lentes de seguridad',          'unidad',  5,  9.50),
  ('Botas punta acero',            'par',    40, 79.00),
  ('Arnés de seguridad',           'unidad', 60, 149.00)
ON CONFLICT (nombre_producto) DO NOTHING;

-- ---------------------------
-- 6) COMPROBANTES (muchos)
-- ---------------------------
WITH tipos AS (
  SELECT cod_tipo_comprobante, descp_tipo_comprobante,
         CASE lower(descp_tipo_comprobante)
           WHEN 'boleta'  THEN 'BOL'
           WHEN 'factura' THEN 'FAC'
           ELSE 'NV'
         END AS pref
  FROM tipo_comprobante
),
gen AS (
  SELECT gs AS n FROM generate_series(1,800) gs
)
INSERT INTO comprobante (cod_tipo_comprobante, nro_comprobante, fecha_emision)
SELECT
  t.cod_tipo_comprobante,
  t.pref || '-' || lpad((g.n)::text, 8, '0'),
  now() - ((800 - g.n) * interval '1 hour')
FROM gen g
CROSS JOIN tipos t
ON CONFLICT (cod_tipo_comprobante, nro_comprobante) DO NOTHING;

-- ---------------------------
-- 7) VENTAS (300: ~60% contado, ~40% crédito) - sin subselects ambiguos
-- ---------------------------
WITH lk_ev AS (
  SELECT min(cod_estado_venta) AS cod, lower(descp_estado_venta) AS name
  FROM estado_venta GROUP BY lower(descp_estado_venta)
),
lk_cp AS (
  SELECT min(cod_cond_pago) AS cod, lower(descp_cond_pago) AS name
  FROM condicion_pago GROUP BY lower(descp_cond_pago)
),
series AS (
  SELECT gs AS n FROM generate_series(1,300) gs
),
pick AS (
  SELECT
    s.n,
    (now() - ((120 - (s.n % 120)) * interval '1 day') + ((s.n % 8) * interval '2 hour')) AS fventa,
    1 + (random()*199)::int AS cli,
    (SELECT cod_vendedor FROM vendedor ORDER BY cod_vendedor
       LIMIT 1 OFFSET ((s.n + (random()*100)::int) % (SELECT count(*) FROM vendedor))) AS vend,
    CASE WHEN random() < 0.60
         THEN (SELECT cod FROM lk_cp WHERE name='contado')
         ELSE (SELECT cod FROM lk_cp WHERE name='crédito')
    END AS tipo_v,
    CASE
      WHEN random() < 0.05 THEN (SELECT cod FROM lk_ev WHERE name='anulada')
      WHEN random() < 0.70 THEN (SELECT cod FROM lk_ev WHERE name='pagada')
      ELSE (SELECT cod FROM lk_ev WHERE name='por pagar')
    END AS est_v,
    CASE WHEN random() < 0.60 THEN 1 ELSE (CASE WHEN random() < 0.5 THEN 3 ELSE 6 END) END AS cuotas
  FROM series s
)
INSERT INTO venta (fecha_hora_venta, monto_venta, descuento, igv, cod_estado_venta, cod_cond_pago, nro_cuotas, cod_cliente, cod_vendedor)
SELECT p.fventa, 0, 0, 0, p.est_v, p.tipo_v, p.cuotas, p.cli, p.vend
FROM pick p
ORDER BY p.n;

-- ---------------------------
-- ÍTEMS DE VENTA (1-4 productos, SIN REPETIR por venta)
-- ---------------------------
WITH ventas AS (
  SELECT v.cod_venta, v.fecha_hora_venta::date AS f_venta
  FROM venta v
),
item_counts AS (
  SELECT v.cod_venta,
         1 + (random()*3)::int AS items_count
  FROM ventas v
),
ranked AS (
  SELECT
    v.cod_venta,
    v.f_venta,
    p.cod_producto,
    p.precio_venta,
    row_number() OVER (PARTITION BY v.cod_venta ORDER BY random()) AS rn
  FROM ventas v
  CROSS JOIN producto p
),
to_take AS (
  SELECT r.cod_venta, r.f_venta, r.cod_producto, r.precio_venta
  FROM ranked r
  JOIN item_counts ic ON ic.cod_venta = r.cod_venta
  WHERE r.rn <= ic.items_count
),
final_rows AS (
  SELECT
    t.cod_venta,
    t.cod_producto,
    1 + (random()*2)::int                         AS qty,          -- 1 a 3 unidades
    t.precio_venta                                AS precio_unit,
    -- Descuento total de la línea (no por unidad) máx ~5% del precio unitario
    round( (t.precio_venta * (random()*0.05))::numeric, 2 ) AS desc_total,
    -- Fecha de entrega: entre 1 y 7 días después de la venta
    (t.f_venta + ((1 + (random()*6)::int))::int)  AS fecha_entrega,
    -- Dirección simple (50% tienda / 50% domicilio)
    CASE WHEN random() < 0.5
         THEN 'Entrega en tienda'
         ELSE 'Entrega a domicilio'
    END AS direccion_entrega
  FROM to_take t
),
calc AS (
  SELECT
    f.cod_venta,
    f.cod_producto,
    f.qty                                         AS cantidad_producto,
    f.precio_unit                                 AS precio_unitario,
    f.desc_total                                  AS descuento_unitario,
    -- Debe cumplir: monto_unitario = cantidad * precio_unitario - descuento_unitario
    round( (f.qty * f.precio_unit - f.desc_total)::numeric, 2 ) AS monto_unitario,
    f.fecha_entrega,
    f.direccion_entrega
  FROM final_rows f
)
INSERT INTO producto_venta
  (cod_venta, cod_producto, cantidad_producto, precio_unitario,
   descuento_unitario, monto_unitario, cod_estado_prodv, direccion_entrega, fecha_entrega)
SELECT
  c.cod_venta,
  c.cod_producto,
  c.cantidad_producto,
  c.precio_unitario,
  c.descuento_unitario,
  c.monto_unitario,
  (
    SELECT min(cod_estado_prodv)
    FROM estado_producto_venta
    WHERE lower(descp_estado_prodv) = 'entregado'
  ) AS cod_estado_prodv,
  c.direccion_entrega,
  c.fecha_entrega
FROM calc c
ON CONFLICT (cod_venta, cod_producto) DO NOTHING;


-- ---------------------------
-- 9) CALCULAR TOTALES DE VENTA (monto, descuento, IGV)
-- ---------------------------
WITH sumas AS (
  SELECT
    pv.cod_venta,
    sum((pv.precio_unitario * pv.cantidad_producto) - pv.descuento_unitario) AS subtotal,
    sum(pv.descuento_unitario) AS descu
  FROM producto_venta pv
  GROUP BY pv.cod_venta
)
UPDATE venta v
SET
  descuento   = COALESCE(s.descu,0),
  monto_venta = COALESCE(s.subtotal,0),
  igv         = round(COALESCE(s.subtotal,0) * 0.18, 2)
FROM sumas s
WHERE v.cod_venta = s.cod_venta;

-- ---------------------------
-- 10) PAGOS / CUOTAS (JOINs a lookups)
-- ---------------------------
WITH lk_ev AS (
  SELECT min(cod_estado_venta) AS cod, lower(descp_estado_venta) AS name
  FROM estado_venta GROUP BY lower(descp_estado_venta)
),
lk_ep AS (
  SELECT min(cod_estado_pago) AS cod, lower(nombre_estado_pago) AS name
  FROM estado_pago GROUP BY lower(nombre_estado_pago)
),
base AS (
  SELECT
    v.cod_venta,
    v.fecha_hora_venta::date AS fventa,
    v.nro_cuotas,
    (v.monto_venta + v.igv) AS total_con_igv,
    v.cod_estado_venta,
    (SELECT cod_caja FROM caja ORDER BY cod_caja
       LIMIT 1 OFFSET ((v.cod_venta - 1) % GREATEST(1,(SELECT count(*) FROM caja)))) AS caja_id
  FROM venta v
),
det AS (
  SELECT
    b.cod_venta, b.fventa, b.nro_cuotas, b.total_con_igv, b.cod_estado_venta, b.caja_id,
    gs AS cuota_nro
  FROM base b
  CROSS JOIN LATERAL generate_series(1, b.nro_cuotas) gs
),
montos AS (
  SELECT
    d.*,
    round((d.total_con_igv / d.nro_cuotas)::numeric, 2) AS monto_cuota,
    (d.fventa + (d.cuota_nro * interval '30 days'))::date AS fecha_venc
  FROM det d
),
estado_pago_sel AS (
  SELECT
    m.*,
    CASE
      WHEN ev.name='anulada' THEN (SELECT cod FROM lk_ep WHERE name='anulado')
      WHEN ev.name='pagada'  THEN (CASE WHEN random() < 0.90
                                        THEN (SELECT cod FROM lk_ep WHERE name='pagado')
                                        ELSE (SELECT cod FROM lk_ep WHERE name='pendiente') END)
      ELSE (CASE WHEN random() < 0.15
                 THEN (SELECT cod FROM lk_ep WHERE name='vencido')
                 ELSE (SELECT cod FROM lk_ep WHERE name='pendiente') END)
    END AS estado_pago_id,
    (SELECT cod_metodo_pago FROM metodo_pago ORDER BY random() LIMIT 1) AS metodo_id,
    (SELECT cod_comprobante FROM comprobante ORDER BY cod_comprobante
       LIMIT 1 OFFSET ((m.cod_venta + m.cuota_nro) %
                       GREATEST(1,(SELECT count(*) FROM comprobante)))) AS comp_id,
    CASE
      WHEN (ev.name='pagada' AND random() < 0.90)
      THEN (m.fventa + ((m.cuota_nro * 10) || ' days')::interval + ((random()*10)::int || ' hours')::interval)
      ELSE NULL
    END AS fecha_pago_real,
    ('Cliente ' || lpad(m.cod_venta::text, 4, '0'))::varchar(200) AS pagador,
    ('9' || lpad(((10000000 + (random()*8999999)::int))::text, 8, '0'))::varchar(20) AS telefono
  FROM montos m
  JOIN lk_ev ev ON ev.cod = m.cod_estado_venta
)
INSERT INTO pago (
  cod_venta, nro_cuota, monto_pago, fecha_vencimiento_pago, fecha_pago,
  nombre_pagador, nro_telf_pagador, cod_caja, cod_comprobante,
  cod_estado_pago, cod_metodo_pago
)
SELECT
  e.cod_venta, e.cuota_nro, e.monto_cuota, e.fecha_venc, e.fecha_pago_real,
  e.pagador, e.telefono, e.caja_id, e.comp_id, e.estado_pago_id, e.metodo_id
FROM estado_pago_sel e
ON CONFLICT DO NOTHING;

-- Ajuste de montos de caja
WITH mov AS (
  SELECT pa.cod_caja,
         sum(CASE WHEN ep.nombre_estado_pago='pagado' THEN pa.monto_pago ELSE 0 END) AS ingresos
  FROM pago pa
  JOIN estado_pago ep ON ep.cod_estado_pago = pa.cod_estado_pago
  WHERE pa.cod_caja IS NOT NULL
  GROUP BY pa.cod_caja
)
UPDATE caja c
SET monto_total_ingresos = COALESCE(m.ingresos,0),
    monto_cierre        = round((c.monto_apertura + COALESCE(m.ingresos,0))::numeric,2)
FROM mov m
WHERE c.cod_caja = m.cod_caja;

-- Sube contador de ventas por vendedor
WITH cont AS (
  SELECT cod_vendedor, count(*) AS n
  FROM venta
  GROUP BY cod_vendedor
)
UPDATE vendedor v
SET total_ventas_vendedor = c.n
FROM cont c
WHERE v.cod_vendedor = c.cod_vendedor;

-- ---------------------------
-- 11) POST-VENTA (JOINs a lookups)
-- ---------------------------
WITH lk_ev AS (
  SELECT min(cod_estado_venta) AS cod, lower(descp_estado_venta) AS name
  FROM estado_venta GROUP BY lower(descp_estado_venta)
),
v_ok AS (
  SELECT v.cod_venta, v.cod_cliente
  FROM venta v
  JOIN lk_ev ev ON ev.cod = v.cod_estado_venta
  WHERE ev.name <> 'anulada'
  ORDER BY random()
  LIMIT 30
),
rk AS (
  INSERT INTO reclamo (cod_venta, cod_cliente, cod_estado_reclamo, fecha_hora_reclamo)
  SELECT
    q.cod_venta,
    q.cod_cliente,
    (SELECT min(cod_estado_reclamo) FROM estado_reclamo ORDER BY random() LIMIT 1),
    now() - ((random()*20)::int || ' days')::interval
  FROM v_ok q
  RETURNING cod_reclamo, cod_venta
)
INSERT INTO anulacion (cod_reclamo, fecha_hora_anulacion, cod_motivo_anulacion, descp_anulacion)
SELECT
  r.cod_reclamo,
  now() - ((random()*10)::int || ' days')::interval,
  (SELECT min(cod_motivo_anulacion) FROM motivo_anulacion ORDER BY random() LIMIT 1),
  'Anulación gestionada por post-venta'
FROM (SELECT * FROM rk ORDER BY random() LIMIT 8) r;

WITH r2 AS (
  SELECT * FROM reclamo ORDER BY cod_reclamo DESC LIMIT 30
)
INSERT INTO devolucion (cod_reclamo, fecha_hora_devolucion, monto_devolucion, cod_motivo_devolucion, cod_caja, producto_devuelto, descp_devolucion)
SELECT
  r.cod_reclamo,
  now() - ((random()*7)::int || ' days')::interval,
  round((100 + random()*500)::numeric, 2),
  (SELECT min(cod_motivo_devolucion) FROM motivo_devolucion ORDER BY random() LIMIT 1),
  (SELECT cod_caja FROM caja ORDER BY random() LIMIT 1),
  (SELECT cod_producto FROM producto ORDER BY random() LIMIT 1),
  'Devolución parcial'
FROM (SELECT * FROM r2 ORDER BY random() LIMIT 10) r;

WITH r3 AS (
  SELECT * FROM reclamo ORDER BY cod_reclamo DESC LIMIT 30
),
pp AS (
  SELECT a.cod_producto AS prod_a, b.cod_producto AS prod_b
  FROM (SELECT cod_producto FROM producto ORDER BY random() LIMIT 6) a
  CROSS JOIN LATERAL (SELECT cod_producto FROM producto ORDER BY random() LIMIT 1) b
  LIMIT 6
)
INSERT INTO cambio_producto (cod_reclamo, producto_retorna, producto_entrega, diferencia_cambio, cod_motivo_cambio_prod, cod_caja, descp_cambio)
SELECT
  r.cod_reclamo,
  p.prod_a,
  p.prod_b,
  round((random()*150)::numeric, 2),
  (SELECT min(cod_motivo_cambio_prod) FROM motivo_cambio_prod ORDER BY random() LIMIT 1),
  (SELECT cod_caja FROM caja ORDER BY random() LIMIT 1),
  'Cambio gestionado'
FROM (SELECT * FROM r3 ORDER BY random() LIMIT 6) r
JOIN pp p ON true;

-- ---------------------------
-- 12) CONSISTENCIA FINAL (JOINs)
-- ---------------------------
WITH lk_ev AS (
  SELECT min(cod_estado_venta) AS cod, lower(descp_estado_venta) AS name
  FROM estado_venta GROUP BY lower(descp_estado_venta)
),
lk_ep AS (
  SELECT min(cod_estado_pago) AS cod, lower(nombre_estado_pago) AS name
  FROM estado_pago GROUP BY lower(nombre_estado_pago)
)
UPDATE pago pa
SET cod_estado_pago = (SELECT cod FROM lk_ep WHERE name='anulado')
WHERE pa.cod_venta IN (
  SELECT v.cod_venta
  FROM venta v JOIN lk_ev ev ON ev.cod = v.cod_estado_venta
  WHERE ev.name='anulada'
);

WITH lk_ep2 AS (
  SELECT min(cod_estado_pago) AS cod FROM estado_pago WHERE lower(nombre_estado_pago)='vencido'
),
lk_ep3 AS (
  SELECT min(cod_estado_pago) AS cod FROM estado_pago WHERE lower(nombre_estado_pago)='pendiente'
)
UPDATE pago pa
SET cod_estado_pago = (SELECT cod FROM lk_ep2)
WHERE pa.fecha_vencimiento_pago < current_date
  AND pa.cod_estado_pago = (SELECT cod FROM lk_ep3);

-- =========================================================
-- FIN
-- =========================================================
