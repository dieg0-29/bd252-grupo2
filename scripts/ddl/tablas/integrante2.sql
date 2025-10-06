
DROP SCHEMA IF EXISTS modulo_transporte CASCADE;
CREATE SCHEMA modulo_transporte;

SET search_path = modulo_transporte;

CREATE TABLE tipo_vehiculo (
  cod_tipo_vehiculo INTEGER NOT NULL,
  nombre_estado VARCHAR(100) NOT NULL,
  PRIMARY KEY (cod_tipo_vehiculo)
);

CREATE TABLE estado_despacho (
  cod_estado_despacho INTEGER NOT NULL,
  nombre_estado_despacho VARCHAR(100) NOT NULL,
  PRIMARY KEY (cod_estado_despacho)
);

CREATE TABLE categoria_brevete (
  cod_categoria_brevete INTEGER NOT NULL,
  nombre_categoria_brevete VARCHAR(100) NOT NULL,
  PRIMARY KEY (cod_categoria_brevete)
);

CREATE TABLE estado_vehiculo (
  cod_estado_vehiculo INTEGER NOT NULL,
  nombre_estado VARCHAR(100) NOT NULL,
  PRIMARY KEY (cod_estado_vehiculo)
);

CREATE TABLE vehiculo (
  cod_vehiculo VARCHAR(100) NOT NULL,
  placa_vehiculo VARCHAR(10) NOT NULL,
  capacidad_maxima_peso DECIMAL(10,2) NOT NULL,
  capacidad_maxima_volumen DECIMAL(10,2) NOT NULL,
  cod_categoria_brevete INTEGER NOT NULL,
  cod_tipo_vehiculo INTEGER NOT NULL,
  cod_estado_vehiculo INTEGER NOT NULL,
  PRIMARY KEY (cod_vehiculo),
  FOREIGN KEY (cod_estado_vehiculo) REFERENCES estado_vehiculo(cod_estado_vehiculo),
  FOREIGN KEY (cod_tipo_vehiculo) REFERENCES tipo_vehiculo(cod_tipo_vehiculo),
  FOREIGN KEY (cod_categoria_brevete) REFERENCES categoria_brevete(cod_categoria_brevete)
);

CREATE TABLE chofer (
  cod_chofer VARCHAR(100) NOT NULL,
  nombre_chofer VARCHAR(100) NOT NULL,
  correo_contacto VARCHAR(100) NOT NULL,
  numero_contacto VARCHAR(9) NOT NULL,
  fecha_registro DATE NOT NULL DEFAULT NOW(),
  cod_categoria_brevete INTEGER NOT NULL,
  vencimiento_brevete DATE NOT NULL DEFAULT NOW(),
  PRIMARY KEY (cod_chofer),
  FOREIGN KEY (cod_categoria_brevete) REFERENCES categoria_brevete(cod_categoria_brevete)
);

CREATE TABLE despacho (
  cod_despacho VARCHAR(100) NOT NULL,
  fecha_despacho DATE NOT NULL DEFAULT NOW(),
  hora_salida_despacho TIME NOT NULL DEFAULT NOW(),
  hora_regreso_despacho TIME NOT NULL DEFAULT NOW(),
  cod_estado_despacho INTEGER NOT NULL,
  cod_chofer VARCHAR(100) NOT NULL,
  cod_vehiculo VARCHAR(100) NOT NULL,
  PRIMARY KEY (cod_despacho),
  FOREIGN KEY (cod_estado_despacho) REFERENCES estado_despacho(cod_estado_despacho),
  FOREIGN KEY (cod_vehiculo) REFERENCES vehiculo(cod_vehiculo),
  FOREIGN KEY (cod_chofer) REFERENCES chofer(cod_chofer)
);

CREATE TABLE estado_operador_vehiculo (
  cod_estado_asignacion INTEGER NOT NULL,
  nombre_estado_asignacion VARCHAR(100) NOT NULL,
  PRIMARY KEY (cod_estado_asignacion)
);

CREATE TABLE operador_vehiculo (
  cod_operador VARCHAR(100) NOT NULL,
  cod_vehiculo VARCHAR(100) NOT NULL,
  cod_estado_asignacion INTEGER NOT NULL,
  motivo_estado_asignacion VARCHAR(100) NOT NULL,
  fecha_ultimo_cambio DATE NOT NULL DEFAULT NOW(),
  FOREIGN KEY (cod_estado_asignacion) REFERENCES estado_operador_vehiculo(cod_estado_asignacion),
  FOREIGN KEY (cod_operador) REFERENCES chofer(cod_chofer),
  FOREIGN KEY (cod_vehiculo) REFERENCES vehiculo(cod_vehiculo)
);

CREATE TABLE estado_despacho_parada (
  cod_estado_despacho_parada INTEGER NOT NULL,
  nombre_estado VARCHAR(100) NOT NULL,
  PRIMARY KEY (cod_estado_despacho_parada)
);

CREATE TABLE tipo_parada (
  cod_tipo_parada INTEGER NOT NULL,
  nombre_tipo_parada VARCHAR(100) NOT NULL,
  PRIMARY KEY (cod_tipo_parada)
);

CREATE TABLE parada (
  cod_parada VARCHAR(100) NOT NULL,
  ubicacion_parada VARCHAR(100) NOT NULL,
  referencia_parada VARCHAR(100) NOT NULL,
  numero_guia VARCHAR(100) NOT NULL,
  PRIMARY KEY (cod_parada)
);

CREATE TABLE detalle_despacho_parada (
  cod_despacho VARCHAR(100) NOT NULL,
  cod_parada VARCHAR(100) NOT NULL,
  secuencia INTEGER NOT NULL,
  hora_salida TIME NOT NULL DEFAULT NOW(),
  hora_llegada TIME NOT NULL DEFAULT NOW(),
  cod_tipo_parada INTEGER NOT NULL,
  cod_estado_despacho_parada INTEGER NOT NULL,
  PRIMARY KEY (cod_despacho, cod_parada, secuencia),
  FOREIGN KEY (cod_estado_despacho_parada) REFERENCES estado_despacho_parada(cod_estado_despacho_parada),
  FOREIGN KEY (cod_tipo_parada) REFERENCES tipo_parada(cod_tipo_parada),
  FOREIGN KEY (cod_despacho) REFERENCES despacho(cod_despacho),
  FOREIGN KEY (cod_parada) REFERENCES parada(cod_parada)
);

CREATE TABLE empleado (
  cod_empleado VARCHAR(100) NOT NULL,
  numero_contacto VARCHAR(9) NOT NULL,
  nombre_empleado VARCHAR(100) NOT NULL,
  correo_contacto VARCHAR(100) NOT NULL,
  fecha_registro TIMESTAMP NOT NULL DEFAULT NOW(),
  PRIMARY KEY (cod_empleado)
);

CREATE TABLE estado_pedido_transporte (
  cod_estado_pedido_transporte INTEGER NOT NULL,
  nombre_estado VARCHAR(100) NOT NULL,
  PRIMARY KEY (cod_estado_pedido_transporte)
);

CREATE TABLE pedido_transporte (
  cod_pedido_transporte VARCHAR(100) NOT NULL,
  hora_pedido_transporte TIMESTAMP NOT NULL DEFAULT NOW(),
  fecha_pedido_transporte DATE NOT NULL DEFAULT NOW(),
  cod_estado_pedido_transporte INTEGER NOT NULL,
  cod_empleado VARCHAR(100) NOT NULL,
  PRIMARY KEY (cod_pedido_transporte),
  FOREIGN KEY (cod_empleado) REFERENCES empleado(cod_empleado),
  FOREIGN KEY (cod_estado_pedido_transporte) REFERENCES estado_pedido_transporte(cod_estado_pedido_transporte)
);

CREATE TABLE estado_pedido_despacho (
  cod_estado_asignacion INTEGER NOT NULL,
  nombre_estado VARCHAR(100) NOT NULL,
  PRIMARY KEY (cod_estado_asignacion)
);

CREATE TABLE pedido_despacho (
  cod_pedido_transporte VARCHAR(100) NOT NULL,
  cod_despacho VARCHAR(100) NOT NULL,
  cod_estado_asignacion INTEGER NOT NULL,
  FOREIGN KEY (cod_pedido_transporte) REFERENCES pedido_transporte(cod_pedido_transporte),
  FOREIGN KEY (cod_estado_asignacion) REFERENCES estado_pedido_despacho(cod_estado_asignacion),
  FOREIGN KEY (cod_despacho) REFERENCES despacho(cod_despacho)
);

CREATE TABLE turno_detalle (
  cod_turno_detalle INTEGER NOT NULL,
  nombre_turno_detalle VARCHAR(100) NOT NULL,
  PRIMARY KEY (cod_turno_detalle)
);

CREATE TABLE producto (
  cod_producto VARCHAR(100) NOT NULL,
  nombre_producto VARCHAR(100) NOT NULL,
  unidad_medida VARCHAR(100) NOT NULL,
  peso_producto DECIMAL(10,2) NOT NULL,
  precio_base DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (cod_producto)
);

CREATE TABLE detalle_pedido (
  cod_pedido_transporte VARCHAR(100) NOT NULL,
  cod_producto VARCHAR(100) NOT NULL,
  cod_detalle_pedido INTEGER NOT NULL,
  cantidad_detalle INTEGER NOT NULL,
  fecha_detalle DATE NOT NULL DEFAULT NOW(),
  cod_turno_detalle INTEGER NOT NULL,
  ubicacion_origen_detalle VARCHAR(100) NOT NULL,
  ubicacion_destino_detalle VARCHAR(100) NOT NULL,
  FOREIGN KEY (cod_turno_detalle) REFERENCES turno_detalle(cod_turno_detalle),
  FOREIGN KEY (cod_producto) REFERENCES producto(cod_producto),
  FOREIGN KEY (cod_pedido_transporte) REFERENCES pedido_transporte(cod_pedido_transporte)
);

CREATE TABLE producto_parada (
  cod_producto VARCHAR(100) NOT NULL,
  cod_parada VARCHAR(100) NOT NULL,
  cantidad_programada_parada INTEGER NOT NULL,
  cantidad_entregada_parada INTEGER NOT NULL,
  motivo_diferencia VARCHAR(100) NOT NULL,
  FOREIGN KEY (cod_producto) REFERENCES producto(cod_producto),
  FOREIGN KEY (cod_parada) REFERENCES parada(cod_parada)
);

CREATE TABLE pedido_almacen (
  cod_pedido_almacen VARCHAR(100) NOT NULL,
  ubicacion_almacen VARCHAR(100) NOT NULL,
  nro_almacen INTEGER NOT NULL,
  hora_inicio TIME NOT NULL DEFAULT NOW(),
  hora_fin TIME NOT NULL DEFAULT NOW(),
  cod_despacho VARCHAR(100) NOT NULL,
  PRIMARY KEY (cod_pedido_almacen),
  FOREIGN KEY (cod_despacho) REFERENCES despacho(cod_despacho)
);

CREATE TABLE detalle_producto_almacen (
  cod_pedido_almacen VARCHAR(100) NOT NULL,
  cod_producto VARCHAR(100) NOT NULL,
  cantidad_solicitada INTEGER NOT NULL,
  FOREIGN KEY (cod_pedido_almacen) REFERENCES pedido_almacen(cod_pedido_almacen),
  FOREIGN KEY (cod_producto) REFERENCES producto(cod_producto)
);
