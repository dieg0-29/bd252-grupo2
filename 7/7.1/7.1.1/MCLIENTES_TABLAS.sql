create extension if not exists "uuid-ossp"; 

drop schema if exists MODULO_CLIENTES cascade;

CREATE SCHEMA MODULO_CLIENTES;

CREATE TABLE MODULO_CLIENTES.TIPO_PERSONA
(
  cod_tipo_persona UUID NOT NULL DEFAULT uuid_generate_v4(),
  valor_tipo_persona VARCHAR(30) NOT NULL UNIQUE,
  PRIMARY KEY (cod_tipo_persona),
  CONSTRAINT chk_valor_tipo_persona CHECK (btrim(valor_tipo_persona) <> '')
);

CREATE TABLE MODULO_CLIENTES.PERSONA
(
  cod_persona UUID NOT NULL DEFAULT uuid_generate_v4(),
  fecha_registro_persona TIMESTAMP NOT NULL DEFAULT NOW(),
  nombre_persona VARCHAR(50) NOT NULL,
  cod_tipo_persona UUID NOT NULL,
  PRIMARY KEY (cod_persona),
  FOREIGN KEY (cod_tipo_persona) REFERENCES MODULO_CLIENTES.TIPO_PERSONA(cod_tipo_persona),
  CONSTRAINT chk_nombre_persona CHECK (btrim(nombre_persona) <> '')
);

CREATE TABLE MODULO_CLIENTES.CLIENTE
(
  cod_cliente UUID NOT NULL DEFAULT uuid_generate_v4(),
  fecha_registro_cliente TIMESTAMP NOT NULL DEFAULT NOW(),
  ultima_actividad_cliente TIMESTAMP NOT NULL DEFAULT NOW(),
  cod_persona UUID NOT NULL,
  PRIMARY KEY (cod_cliente),
  FOREIGN KEY (cod_persona) REFERENCES MODULO_CLIENTES.PERSONA(cod_persona),
  UNIQUE (cod_persona)
);

CREATE TABLE MODULO_CLIENTES.TIPO_CONTACTO
(
  cod_tipo_contacto UUID NOT NULL DEFAULT uuid_generate_v4(),
  valor_tipo_contacto VARCHAR(30) NOT NULL UNIQUE,
  PRIMARY KEY (cod_tipo_contacto),
  CONSTRAINT chk_valor_tipo_contacto CHECK (btrim(valor_tipo_contacto) <> '')
);

CREATE TABLE MODULO_CLIENTES.CONTACTO
(
  cod_contacto UUID NOT NULL DEFAULT uuid_generate_v4(),
  valor_contacto VARCHAR(50) NOT NULL,
  cod_tipo_contacto UUID NOT NULL,
  PRIMARY KEY (cod_contacto),
  FOREIGN KEY (cod_tipo_contacto) REFERENCES MODULO_CLIENTES.TIPO_CONTACTO(cod_tipo_contacto),
  CONSTRAINT chk_valor_contacto CHECK (btrim(valor_contacto) <> '')
);

CREATE TABLE MODULO_CLIENTES.DIRECCION
(
  cod_direccion UUID NOT NULL DEFAULT uuid_generate_v4(),
  ciudad VARCHAR(50) NOT NULL,
  distrito VARCHAR(50) NOT NULL,
  via VARCHAR(50) NOT NULL,
  numero VARCHAR(50) NOT NULL,
  PRIMARY KEY (cod_direccion),
  CONSTRAINT chk_ciudad CHECK (btrim(ciudad) <> ''),
  CONSTRAINT chk_distrito CHECK (btrim(distrito) <> ''),
  CONSTRAINT chk_via CHECK (btrim(via) <> ''),
  CONSTRAINT chk_numero CHECK (btrim(numero) <> '')
);

CREATE TABLE MODULO_CLIENTES.TIPO_DOCUMENTO
(
  cod_tipo_documento UUID NOT NULL DEFAULT uuid_generate_v4(),
  valor_tipo_documento VARCHAR(30) NOT NULL UNIQUE,	
  PRIMARY KEY (cod_tipo_documento),
  CONSTRAINT chk_valor_tipo_documento CHECK (btrim(valor_tipo_documento) <> '')
);

CREATE TABLE MODULO_CLIENTES.DOCUMENTO_PERSONA
(
  valor_documento VARCHAR(50) NOT NULL,
  cod_persona UUID NOT NULL,
  cod_tipo_documento UUID NOT NULL,
  PRIMARY KEY (cod_persona, cod_tipo_documento),
  FOREIGN KEY (cod_persona) REFERENCES MODULO_CLIENTES.PERSONA(cod_persona),
  FOREIGN KEY (cod_tipo_documento) REFERENCES MODULO_CLIENTES.TIPO_DOCUMENTO(cod_tipo_documento),
  CONSTRAINT chk_valor_documento CHECK (btrim(valor_documento) <> '')
);

CREATE TABLE MODULO_CLIENTES.DIRECCION_PERSONA
(
  cod_direccion UUID NOT NULL,
  cod_persona UUID NOT NULL,
  PRIMARY KEY (cod_direccion, cod_persona),
  FOREIGN KEY (cod_direccion) REFERENCES MODULO_CLIENTES.DIRECCION(cod_direccion),
  FOREIGN KEY (cod_persona) REFERENCES MODULO_CLIENTES.PERSONA(cod_persona)
);

CREATE TABLE MODULO_CLIENTES.CONTACTO_PERSONA
(
  cod_contacto UUID NOT NULL,
  cod_persona UUID NOT NULL,
  PRIMARY KEY (cod_contacto, cod_persona),
  FOREIGN KEY (cod_contacto) REFERENCES MODULO_CLIENTES.CONTACTO(cod_contacto),
  FOREIGN KEY (cod_persona) REFERENCES MODULO_CLIENTES.PERSONA(cod_persona)
);

CREATE TABLE MODULO_CLIENTES.ESPECIALIDADES
(
  cod_especialidad UUID NOT NULL DEFAULT uuid_generate_v4(),
  valor_especialidad VARCHAR NOT NULL UNIQUE,
  PRIMARY KEY (cod_especialidad),
  CONSTRAINT chk_valor_especialidad CHECK (btrim(valor_especialidad) <> '')
);

CREATE TABLE MODULO_CLIENTES.MAESTRO
(
  cod_maestro UUID NOT NULL DEFAULT uuid_generate_v4(),
  ruc VARCHAR(15) NOT NULL UNIQUE ,
  puntos_maestro NUMERIC(10,2) NOT NULL DEFAULT 0,
  fecha_registro_maestro TIMESTAMP NOT NULL DEFAULT NOW(),
  ultima_actividad_maestro TIMESTAMP NOT NULL DEFAULT NOW(),
  cod_cliente UUID NOT NULL,
  cod_persona UUID NOT NULL,
  cod_especialidad UUID NOT NULL,
  PRIMARY KEY (cod_maestro),
  FOREIGN KEY (cod_cliente) REFERENCES MODULO_CLIENTES.CLIENTE(cod_cliente),
  FOREIGN KEY (cod_persona) REFERENCES MODULO_CLIENTES.CLIENTE(cod_persona),
  FOREIGN KEY (cod_especialidad) REFERENCES MODULO_CLIENTES.ESPECIALIDADES(cod_especialidad),
  UNIQUE (cod_cliente),
  UNIQUE (cod_persona)
);

CREATE TABLE MODULO_CLIENTES.ROL
(
  cod_rol UUID NOT NULL DEFAULT uuid_generate_v4(),
  valor_rol VARCHAR(30) NOT NULL UNIQUE ,
  PRIMARY KEY (cod_rol),
  CONSTRAINT chk_valor_rol CHECK (btrim(valor_rol) <> '')
);

CREATE TABLE MODULO_CLIENTES.AREA
(
  cod_area UUID NOT NULL DEFAULT uuid_generate_v4(),
  valor_area VARCHAR(30) NOT NULL UNIQUE,
  PRIMARY KEY (cod_area),
  CONSTRAINT chk_valor_area CHECK (btrim(valor_area) <> '')
);

CREATE TABLE MODULO_CLIENTES.USUARIO
(
  cod_usuario UUID NOT NULL DEFAULT uuid_generate_v4(),
  fecha_registro_usuario TIMESTAMP NOT NULL DEFAULT NOW(),
  cod_rol UUID NOT NULL,
  cod_area UUID NOT NULL,
  cod_persona UUID NOT NULL,
  PRIMARY KEY (cod_usuario),
  FOREIGN KEY (cod_rol) REFERENCES MODULO_CLIENTES.ROL(cod_rol),
  FOREIGN KEY (cod_area) REFERENCES MODULO_CLIENTES.AREA(cod_area),
  FOREIGN KEY (cod_persona) REFERENCES MODULO_CLIENTES.PERSONA(cod_persona)
);

CREATE TABLE MODULO_CLIENTES.VENTA
(
  cod_venta UUID NOT NULL DEFAULT uuid_generate_v4(),
  fecha_hora_venta TIMESTAMP NOT NULL DEFAULT NOW(),
  igv NUMERIC(5, 5) NOT NULL DEFAULT 0.18000,
  monto_venta NUMERIC(10, 2) NOT NULL,
  puntos_venta NUMERIC(10, 2),
  tipo_venta VARCHAR(30) NOT NULL,
  estado_venta VARCHAR(30) NOT NULL DEFAULT 'Pendiente',
  fecha_entrega TIMESTAMP, 
  cod_cliente UUID NOT NULL,
  cod_usuario UUID NOT NULL,
  cod_maestro UUID,
  PRIMARY KEY (cod_venta),
  FOREIGN KEY (cod_cliente) REFERENCES MODULO_CLIENTES.CLIENTE(cod_cliente),
  FOREIGN KEY (cod_usuario) REFERENCES MODULO_CLIENTES.USUARIO(cod_usuario),
  FOREIGN KEY (cod_maestro) REFERENCES MODULO_CLIENTES.MAESTRO(cod_maestro),
  CONSTRAINT chk_monto_venta_positivo CHECK (monto_venta > 0)
);

CREATE TABLE MODULO_CLIENTES.CATEGORIA
(
  cod_categoria UUID NOT NULL DEFAULT uuid_generate_v4(),
  valor_categoria VARCHAR(50) NOT NULL,
  PRIMARY KEY (cod_categoria),
  CONSTRAINT chk_valor_categoria CHECK (btrim(valor_categoria) <> '')
);

CREATE TABLE MODULO_CLIENTES.ESTADO_CANJE
(
  cod_estado_canje UUID NOT NULL DEFAULT uuid_generate_v4(),
  valor_estado_canje VARCHAR(30) NOT NULL,
  PRIMARY KEY (cod_estado_canje),
  CONSTRAINT chk_valor_estado_canje CHECK (btrim(valor_estado_canje) <> '')
);

CREATE TABLE MODULO_CLIENTES.CANJE
(
  cod_canje UUID NOT NULL DEFAULT uuid_generate_v4(),
  fecha_hora_canje TIMESTAMP NOT NULL DEFAULT NOW(),
  monto_canje NUMERIC(10, 2) NOT NULL,
  fecha_entrega TIMESTAMP,
  cod_usuario UUID NOT NULL,
  cod_estado_canje UUID NOT NULL,
  cod_maestro UUID NOT NULL,
  PRIMARY KEY (cod_canje),
  FOREIGN KEY (cod_usuario) REFERENCES MODULO_CLIENTES.USUARIO(cod_usuario),
  FOREIGN KEY (cod_estado_canje) REFERENCES MODULO_CLIENTES.ESTADO_CANJE(cod_estado_canje),
  FOREIGN KEY (cod_maestro) REFERENCES MODULO_CLIENTES.MAESTRO(cod_maestro),
  CONSTRAINT chk_monto_canje_positivo CHECK (monto_canje > 0),
  CONSTRAINT chk_fecha_entrega_valida CHECK (fecha_entrega IS NULL OR fecha_entrega >= fecha_hora_canje)
);

CREATE TABLE MODULO_CLIENTES.PREMIOS
(
  cod_premio UUID NOT NULL DEFAULT uuid_generate_v4(),
  nombre_premio VARCHAR(100) NOT NULL UNIQUE,
  descp_premio VARCHAR(500) NOT NULL,
  puntos_premio NUMERIC(10,2) NOT NULL CHECK (puntos_premio >= 0),
  disponibilidad_premio INT NOT NULL DEFAULT 0 CHECK (disponibilidad_premio >= 0),
  PRIMARY KEY (cod_premio),
  CONSTRAINT chk_nombre_premio CHECK (btrim(nombre_premio) <> '')
);

CREATE TABLE MODULO_CLIENTES.DETALLE_CANJE
(
  cantidad_premio INT NOT NULL CHECK (cantidad_premio >= 0),
  cod_canje UUID NOT NULL,
  cod_premio UUID NOT NULL,
  PRIMARY KEY (cod_canje, cod_premio),
  FOREIGN KEY (cod_canje) REFERENCES MODULO_CLIENTES.CANJE(cod_canje),
  FOREIGN KEY (cod_premio) REFERENCES MODULO_CLIENTES.PREMIOS(cod_premio)
);

CREATE TABLE MODULO_CLIENTES.CATEGORIAS_PREMIO
(
  cod_categoria UUID NOT NULL,
  cod_premio UUID NOT NULL,
  PRIMARY KEY (cod_categoria, cod_premio),
  FOREIGN KEY (cod_categoria) REFERENCES MODULO_CLIENTES.CATEGORIA(cod_categoria),
  FOREIGN KEY (cod_premio) REFERENCES MODULO_CLIENTES.PREMIOS(cod_premio)
);

CREATE TABLE MODULO_CLIENTES.REPORTE
(
  cod_reporte UUID NOT NULL DEFAULT uuid_generate_v4(),
  fecha_creacion_reporte TIMESTAMP NOT NULL DEFAULT NOW(),
  fecha_fin_periodo TIMESTAMP NOT NULL DEFAULT NOW(),
  periodo_reporte INTERVAL NOT NULL,
  PRIMARY KEY (cod_reporte)
);

CREATE TABLE MODULO_CLIENTES.CANJE_CONSULTADO
(
  cod_reporte UUID NOT NULL,
  cod_canje UUID NOT NULL,
  PRIMARY KEY (cod_reporte, cod_canje),
  FOREIGN KEY (cod_reporte) REFERENCES MODULO_CLIENTES.REPORTE(cod_reporte),
  FOREIGN KEY (cod_canje) REFERENCES MODULO_CLIENTES.CANJE(cod_canje)
);

CREATE TABLE MODULO_CLIENTES.CLIENTE_CONSULTADO
(
  cod_reporte UUID NOT NULL,
  cod_cliente UUID NOT NULL,
  PRIMARY KEY (cod_reporte, cod_cliente),
  FOREIGN KEY (cod_reporte) REFERENCES MODULO_CLIENTES.REPORTE(cod_reporte),
  FOREIGN KEY (cod_cliente) REFERENCES MODULO_CLIENTES.CLIENTE(cod_cliente)
);

CREATE TABLE MODULO_CLIENTES.MAESTRO_CONSULTADO
(
  cod_reporte UUID NOT NULL,
  cod_maestro UUID NOT NULL,
  PRIMARY KEY (cod_reporte, cod_maestro),
  FOREIGN KEY (cod_reporte) REFERENCES MODULO_CLIENTES.REPORTE(cod_reporte),
  FOREIGN KEY (cod_maestro) REFERENCES MODULO_CLIENTES.MAESTRO(cod_maestro)
);

