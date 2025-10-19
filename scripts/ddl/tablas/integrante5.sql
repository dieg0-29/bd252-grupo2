DROP SCHEMA IF EXISTS Ventas CASCADE;
CREATE SCHEMA Ventas;
SET search_path TO Ventas;

--Tablas auxiliares--
CREATE TABLE Ventas.producto (
  cod_producto  INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  nombre_producto VARCHAR(120) NOT NULL UNIQUE
);

CREATE TABLE Ventas.cliente (
  cod_cliente  INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  nombre_cliente VARCHAR(120) NOT NULL UNIQUE
);


--Tablas del módulo de ventas--
CREATE TABLE Ventas.metodo_pago (
  cod_metodo_pago INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  nombre_metodo_pago VARCHAR(60) NOT NULL UNIQUE
);

CREATE TABLE Ventas.vendedor (
  cod_vendedor INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  fecha_ingreso_vendedor DATE NOT NULL DEFAULT NOW(),
  total_ventas_vendedor INT DEFAULT 0
);

CREATE TABLE Ventas.horario (
  cod_horario INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  hora_ingreso TIME NOT NULL,
  hora_salida TIME NOT NULL 
  CHECK(hora_salida > hora_ingreso),
  hora_receso_inicio TIME
  CHECK(hora_receso_inicio BETWEEN hora_ingreso AND hora_salida),
  hora_receso_fin TIME
  CHECK(hora_receso_fin BETWEEN hora_receso_inicio AND hora_salida),
  dia VARCHAR(10) NOT NULL 
  CHECK (dia IN ('Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado', 'Domingo'))
);

CREATE TABLE Ventas.vendedor_horario (
	cod_vendedor INT NOT NULL REFERENCES Ventas.vendedor(cod_vendedor),	
	cod_horario INT NOT NULL REFERENCES Ventas.horario(cod_horario)
);

CREATE TABLE Ventas.tipo_venta (
  cod_tipo_venta INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  descp_tipo_venta VARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE Ventas.estado_venta (
  cod_estado_venta INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  descp_estado_venta VARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE Ventas.tipo_comprobante (
  cod_tipo_comprobante INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  descp_tipo_comprobante VARCHAR(40) NOT NULL UNIQUE
);

CREATE TABLE Ventas.estado_pago (
  cod_estado_pago INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  nombre_estado_pago VARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE Ventas.venta (
  cod_venta			INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  fecha_hora_venta	TIMESTAMP NOT NULL DEFAULT NOW(),
  igv				NUMERIC(12,2) NOT NULL CHECK (igv > 0),
  monto_venta		NUMERIC(12,2) NOT NULL CHECK(monto_venta > 0),
  dscto_venta		NUMERIC(12,2) NOT NULL DEFAULT 0,
  fecha_venta		DATE NOT NULL DEFAULT NOW(),
  fecha_entrega		DATE NOT NULL CHECK (fecha_entrega >= fecha_venta),
  cod_tipo_venta		INT NOT NULL REFERENCES Ventas.tipo_venta(cod_tipo_venta),
  cod_estado_venta	INT NOT NULL REFERENCES Ventas.estado_venta(cod_estado_venta),
  cod_vendedor		INT NOT NULL REFERENCES Ventas.vendedor(cod_vendedor),
  cod_cliente		INT NOT NULL REFERENCES Ventas.cliente(cod_cliente)
);

CREATE TABLE Ventas.producto_venta (
  cod_venta INT NOT NULL REFERENCES Ventas.venta(cod_venta),
  cod_producto INT NOT NULL REFERENCES Ventas.producto(cod_producto),
  cantidad_producto INT NOT NULL CHECK(cantidad_producto > 0),
  PRIMARY KEY (cod_venta, cod_producto)
);

CREATE TABLE Ventas.comprobante (
  nro_comprobante INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  cod_tipo_comprobante INT NOT NULL REFERENCES Ventas.tipo_comprobante(cod_tipo_comprobante),
  fecha_emision DATE NOT NULL
);

CREATE TABLE Ventas.caja (
  cod_caja INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  fecha_hora_apertura TIMESTAMP NOT NULL DEFAULT NOW(),
  fecha_hora_cierre   TIMESTAMP,
  vendedor_apertura   INT NOT NULL REFERENCES Ventas.vendedor(cod_vendedor),
  vendedor_cierre     INT REFERENCES Ventas.vendedor(cod_vendedor),
  monto_apertura      NUMERIC(12,2) DEFAULT 0,
  monto_cierre		NUMERIC(12,2) DEFAULT 0,
  monto_total_ventas  NUMERIC(14,2) DEFAULT 0,
  cantidad_ventas     INT DEFAULT 0
);

CREATE TABLE Ventas.pago (
  nro_pago INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  cod_venta INT NOT NULL REFERENCES Ventas.venta(cod_venta),
  fecha_vencimiento_pago DATE,
  fecha_pago DATE,
  monto_pago NUMERIC(12,2) NOT NULL,
  cod_caja INT REFERENCES caja(cod_caja),
  nro_comprobante INT REFERENCES Ventas.comprobante(nro_comprobante),
  cod_metodo_pago INT REFERENCES Ventas.metodo_pago(cod_metodo_pago),
  cod_estado_pago INT NOT NULL REFERENCES Ventas.estado_pago(cod_estado_pago)
);

CREATE TABLE Ventas.reclamo (
  cod_reclamo INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  cod_venta   INT NOT NULL REFERENCES Ventas.venta(cod_venta),
  fecha_hora_reclamo TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE Ventas.nota_credito (
  nro_comprobante INT PRIMARY KEY REFERENCES Ventas.comprobante(nro_comprobante),
  cod_reclamo INT REFERENCES Ventas.reclamo(cod_reclamo),
  monto_comprobante NUMERIC(12,2) NOT NULL CHECK(monto_comprobante > 0),
  descripcion_nota VARCHAR(200)
);

CREATE TABLE Ventas.motivo_anulacion (
  cod_motivo_anulacion INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  descp_motivo_anulacion VARCHAR(120) NOT NULL UNIQUE
);

CREATE TABLE Ventas.anulacion (
  cod_anulacion INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  cod_reclamo INT NOT NULL REFERENCES Ventas.reclamo(cod_reclamo),
  cod_motivo_anulacion INT NOT NULL REFERENCES Ventas.motivo_anulacion(cod_motivo_anulacion)
);

CREATE TABLE Ventas.motivo_devolucion (
  cod_motivo_devolucion INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  descp_motivo_devolucion VARCHAR(120) NOT NULL UNIQUE
);

CREATE TABLE Ventas.devolucion (
  cod_devolucion INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  cod_reclamo INT NOT NULL REFERENCES Ventas.reclamo(cod_reclamo),
  cod_motivo_devolucion INT NOT NULL REFERENCES Ventas.motivo_devolucion(cod_motivo_devolucion),
  monto_devolucion NUMERIC(12,2) NOT NULL CHECK(monto_devolucion > 0),
  cod_caja INT NOT NULL REFERENCES Ventas.caja(cod_caja),
  producto_devuelto INT NOT NULL REFERENCES Ventas.producto(cod_producto)
);

CREATE TABLE Ventas.motivo_cambio_prod (
  cod_motivo_cambio_prod INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  descp_motivo_cambio_prod VARCHAR(120) NOT NULL UNIQUE
);

CREATE TABLE Ventas.cambio_producto (
	cod_cambio_producto INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	cod_reclamo INT NOT NULL REFERENCES Ventas.reclamo(cod_reclamo),
	cod_motivo_cambio_prod INT NOT NULL REFERENCES Ventas.motivo_cambio_prod(cod_motivo_cambio_prod),
	producto_retornado INT NOT NULL REFERENCES Ventas.producto(cod_producto),
	producto_entregado INT NOT NULL REFERENCES Ventas.producto(cod_producto)
);

CREATE TABLE Ventas.reporte (
	cod_reporte INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	fecha_hora_creacion TIMESTAMP NOT NULL DEFAULT NOW(),
	fecha_inicio_datos DATE NOT NULL,
	fecha_fin_datos DATE NOT NULL
	CHECK(fecha_fin_datos > fecha_inicio_datos),
	descp_reporte VARCHAR(200) NOT NULL,
	tipo_grafico VARCHAR(30) NOT NULL
);