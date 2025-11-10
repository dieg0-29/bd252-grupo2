drop schema if exists MODULO_CLIENTES cascade;
--=============================================================
-- Módulo: CLIENTES (CREACIÓN DE TABLAS con restricciones esenciales)
-- =============================================================
CREATE SCHEMA MODULO_CLIENTES;

--TIPO_PERSONA
CREATE TABLE MODULO_CLIENTES.TIPO_PERSONA
(
  cod_tipo_persona SERIAL NOT NULL,
  valor_tipo_persona VARCHAR(30) NOT NULL UNIQUE,
  PRIMARY KEY (cod_tipo_persona),
  CONSTRAINT chk_valor_tipo_persona CHECK (btrim(valor_tipo_persona) <> '')
);

--PERSONA
CREATE TABLE MODULO_CLIENTES.PERSONA
(
  cod_persona SERIAL NOT NULL,
  fecha_registro_persona TIMESTAMP NOT NULL DEFAULT NOW(),
  nombre_persona VARCHAR(50) NOT NULL,
  cod_tipo_persona SERIAL NOT NULL,
  PRIMARY KEY (cod_persona),
  FOREIGN KEY (cod_tipo_persona) REFERENCES MODULO_CLIENTES.TIPO_PERSONA(cod_tipo_persona),
  CONSTRAINT chk_nombre_persona CHECK (btrim(nombre_persona) <> '')
);

--CLIENTE
CREATE TABLE MODULO_CLIENTES.CLIENTE
(
  cod_cliente SERIAL NOT NULL,
  fecha_registro_cliente TIMESTAMP NOT NULL DEFAULT NOW(),
  ultima_actividad_cliente TIMESTAMP NOT NULL DEFAULT NOW(),
  cod_persona SERIAL NOT NULL,
  PRIMARY KEY (cod_cliente),
  FOREIGN KEY (cod_persona) REFERENCES MODULO_CLIENTES.PERSONA(cod_persona),
  UNIQUE (cod_persona)
);

--TIPO_CONTACTO
CREATE TABLE MODULO_CLIENTES.TIPO_CONTACTO
(
  cod_tipo_contacto SERIAL NOT NULL,
  valor_tipo_contacto VARCHAR(30) NOT NULL UNIQUE,
  PRIMARY KEY (cod_tipo_contacto),
  CONSTRAINT chk_valor_tipo_contacto CHECK (btrim(valor_tipo_contacto) <> '')
);

--CONTACTO
CREATE TABLE MODULO_CLIENTES.CONTACTO
(
  cod_contacto SERIAL NOT NULL,
  valor_contacto VARCHAR(50) NOT NULL,
  cod_tipo_contacto SERIAL NOT NULL,
  PRIMARY KEY (cod_contacto),
  FOREIGN KEY (cod_tipo_contacto) REFERENCES MODULO_CLIENTES.TIPO_CONTACTO(cod_tipo_contacto),
  CONSTRAINT chk_valor_contacto CHECK (btrim(valor_contacto) <> '')
);

--DIRECCION
CREATE TABLE MODULO_CLIENTES.DIRECCION
(
  cod_direccion SERIAL NOT NULL,
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

--TIPO_DOCUMENTO
CREATE TABLE MODULO_CLIENTES.TIPO_DOCUMENTO
(
  cod_tipo_documento SERIAL NOT NULL,
  valor_tipo_documento VARCHAR(30) NOT NULL UNIQUE,	
  PRIMARY KEY (cod_tipo_documento),
  CONSTRAINT chk_valor_tipo_documento CHECK (btrim(valor_tipo_documento) <> '')
);

--DOCUMENTO_PERSONA
CREATE TABLE MODULO_CLIENTES.DOCUMENTO_PERSONA
(
  valor_documento VARCHAR(50) NOT NULL,
  cod_persona INTEGER NOT NULL,
  cod_tipo_documento INTEGER NOT NULL,
  principal_documento BOOLEAN,
  PRIMARY KEY (cod_persona, cod_tipo_documento),
  UNIQUE (principal_documento, cod_persona),
  FOREIGN KEY (cod_persona) REFERENCES MODULO_CLIENTES.PERSONA(cod_persona),
  FOREIGN KEY (cod_tipo_documento) REFERENCES MODULO_CLIENTES.TIPO_DOCUMENTO(cod_tipo_documento),
  CONSTRAINT chk_valor_documento CHECK (btrim(valor_documento) <> '')
);

--DIRECCION_PERSONA
CREATE TABLE MODULO_CLIENTES.DIRECCION_PERSONA
(
  cod_direccion INTEGER NOT NULL,
  cod_persona INTEGER NOT NULL,
  principal_direccion BOOLEAN,
  PRIMARY KEY (cod_direccion, cod_persona),
  UNIQUE (principal_direccion, cod_persona),
  FOREIGN KEY (cod_direccion) REFERENCES MODULO_CLIENTES.DIRECCION(cod_direccion),
  FOREIGN KEY (cod_persona) REFERENCES MODULO_CLIENTES.PERSONA(cod_persona)
);

--CONTACTO_PERSONA
CREATE TABLE MODULO_CLIENTES.CONTACTO_PERSONA
(
  cod_contacto INTEGER NOT NULL,
  cod_persona INTEGER NOT NULL,
  principal_contacto INTEGER,
  PRIMARY KEY (cod_contacto, cod_persona),
  UNIQUE (principal_contacto, cod_persona),
  FOREIGN KEY (cod_contacto) REFERENCES MODULO_CLIENTES.CONTACTO(cod_contacto),
  FOREIGN KEY (cod_persona) REFERENCES MODULO_CLIENTES.PERSONA(cod_persona),
  FOREIGN KEY (principal_contacto) REFERENCES MODULO_CLIENTES.TIPO_CONTACTO (cod_tipo_contacto)
);


--ESPECIALIDADES
CREATE TABLE MODULO_CLIENTES.ESPECIALIDADES
(
  cod_especialidad SERIAL NOT NULL,
  valor_especialidad VARCHAR NOT NULL UNIQUE,
  PRIMARY KEY (cod_especialidad),
  CONSTRAINT chk_valor_especialidad CHECK (btrim(valor_especialidad) <> '')
);

--MAESTRO
CREATE TABLE MODULO_CLIENTES.MAESTRO
(
  cod_maestro SERIAL NOT NULL,
  ruc VARCHAR(15) NOT NULL UNIQUE ,
  puntos_maestro NUMERIC(10,2) NOT NULL DEFAULT 0,
  fecha_registro_maestro TIMESTAMP NOT NULL DEFAULT NOW(),
  ultima_actividad_maestro TIMESTAMP NOT NULL DEFAULT NOW(),
  cod_cliente INTEGER NOT NULL,
  cod_persona INTEGER NOT NULL,
  cod_especialidad INTEGER NOT NULL,
  PRIMARY KEY (cod_maestro),
  FOREIGN KEY (cod_cliente) REFERENCES MODULO_CLIENTES.CLIENTE(cod_cliente),
  FOREIGN KEY (cod_persona) REFERENCES MODULO_CLIENTES.CLIENTE(cod_persona),
  FOREIGN KEY (cod_especialidad) REFERENCES MODULO_CLIENTES.ESPECIALIDADES(cod_especialidad),
  UNIQUE (cod_cliente),
  UNIQUE (cod_persona)
);

--ROL
CREATE TABLE MODULO_CLIENTES.ROL
(
  cod_rol SERIAL NOT NULL,
  valor_rol VARCHAR(30) NOT NULL UNIQUE ,
  PRIMARY KEY (cod_rol),
  CONSTRAINT chk_valor_rol CHECK (btrim(valor_rol) <> '')
);

--AREA
CREATE TABLE MODULO_CLIENTES.AREA
(
  cod_area SERIAL NOT NULL,
  valor_area VARCHAR(30) NOT NULL UNIQUE,
  PRIMARY KEY (cod_area),
  CONSTRAINT chk_valor_area CHECK (btrim(valor_area) <> '')
);

--USUARIO
CREATE TABLE MODULO_CLIENTES.USUARIO
(
  cod_usuario SERIAL NOT NULL,
  fecha_registro_usuario TIMESTAMP NOT NULL DEFAULT NOW(),
  cod_rol INTEGER NOT NULL,
  cod_area INTEGER NOT NULL,
  cod_persona INTEGER NOT NULL,
  PRIMARY KEY (cod_usuario),
  FOREIGN KEY (cod_rol) REFERENCES MODULO_CLIENTES.ROL(cod_rol),
  FOREIGN KEY (cod_area) REFERENCES MODULO_CLIENTES.AREA(cod_area),
  FOREIGN KEY (cod_persona) REFERENCES MODULO_CLIENTES.PERSONA(cod_persona)
);

--VENTA
CREATE TABLE MODULO_CLIENTES.VENTA
(
  cod_venta SERIAL NOT NULL,
  fecha_hora_venta TIMESTAMP NOT NULL DEFAULT NOW(),
  igv NUMERIC(5, 5) NOT NULL DEFAULT 0.18000,
  monto_venta NUMERIC(10, 2) NOT NULL,
  puntos_venta NUMERIC(10, 2),
  tipo_venta VARCHAR(30) NOT NULL,
  estado_venta VARCHAR(30) NOT NULL DEFAULT 'Pendiente',
  fecha_entrega TIMESTAMP, 
  cod_cliente INTEGER NOT NULL,
  cod_usuario INTEGER NOT NULL,
  cod_maestro INTEGER,
  PRIMARY KEY (cod_venta),
  FOREIGN KEY (cod_cliente) REFERENCES MODULO_CLIENTES.CLIENTE(cod_cliente),
  FOREIGN KEY (cod_usuario) REFERENCES MODULO_CLIENTES.USUARIO(cod_usuario),
  FOREIGN KEY (cod_maestro) REFERENCES MODULO_CLIENTES.MAESTRO(cod_maestro),
  CONSTRAINT chk_monto_venta_positivo CHECK (monto_venta > 0)
);

--CATEGORIA
CREATE TABLE MODULO_CLIENTES.CATEGORIA
(
  cod_categoria SERIAL NOT NULL,
  valor_categoria VARCHAR(50) NOT NULL,
  PRIMARY KEY (cod_categoria),
  CONSTRAINT chk_valor_categoria CHECK (btrim(valor_categoria) <> '')
);

--ESTADO_CANJE
CREATE TABLE MODULO_CLIENTES.ESTADO_CANJE
(
  cod_estado_canje SERIAL NOT NULL,
  valor_estado_canje VARCHAR(30) NOT NULL,
  PRIMARY KEY (cod_estado_canje),
  CONSTRAINT chk_valor_estado_canje CHECK (btrim(valor_estado_canje) <> '')
);

--CANJE
CREATE TABLE MODULO_CLIENTES.CANJE
(
  cod_canje SERIAL NOT NULL,
  fecha_hora_canje TIMESTAMP NOT NULL DEFAULT NOW(),
  monto_canje NUMERIC(10, 2) NOT NULL,
  fecha_entrega TIMESTAMP,
  cod_usuario INTEGER NOT NULL,
  cod_estado_canje INTEGER NOT NULL,
  cod_maestro INTEGER NOT NULL,
  PRIMARY KEY (cod_canje),
  FOREIGN KEY (cod_usuario) REFERENCES MODULO_CLIENTES.USUARIO(cod_usuario),
  FOREIGN KEY (cod_estado_canje) REFERENCES MODULO_CLIENTES.ESTADO_CANJE(cod_estado_canje),
  FOREIGN KEY (cod_maestro) REFERENCES MODULO_CLIENTES.MAESTRO(cod_maestro),
  CONSTRAINT chk_monto_canje_positivo CHECK (monto_canje > 0),
  CONSTRAINT chk_fecha_entrega_valida CHECK (fecha_entrega IS NULL OR fecha_entrega >= fecha_hora_canje)
);

--PREMIOS
CREATE TABLE MODULO_CLIENTES.PREMIOS
(
  cod_premio SERIAL NOT NULL,
  nombre_premio VARCHAR(100) NOT NULL UNIQUE,
  descp_premio VARCHAR(500) NOT NULL,
  puntos_premio NUMERIC(10,2) NOT NULL CHECK (puntos_premio >= 0),
  disponibilidad_premio INT NOT NULL DEFAULT 0 CHECK (disponibilidad_premio >= 0),
  PRIMARY KEY (cod_premio),
  CONSTRAINT chk_nombre_premio CHECK (btrim(nombre_premio) <> '')
);

--DETALLE_CANJE
CREATE TABLE MODULO_CLIENTES.DETALLE_CANJE
(
  cantidad_premio INT NOT NULL CHECK (cantidad_premio >= 0),
  cod_canje INTEGER NOT NULL,
  cod_premio INTEGER NOT NULL,
  PRIMARY KEY (cod_canje, cod_premio),
  FOREIGN KEY (cod_canje) REFERENCES MODULO_CLIENTES.CANJE(cod_canje),
  FOREIGN KEY (cod_premio) REFERENCES MODULO_CLIENTES.PREMIOS(cod_premio)
);

--CATEGORIAS_PREMIO
CREATE TABLE MODULO_CLIENTES.CATEGORIAS_PREMIO
(
  cod_categoria INTEGER NOT NULL,
  cod_premio INTEGER NOT NULL,
  PRIMARY KEY (cod_categoria, cod_premio),
  FOREIGN KEY (cod_categoria) REFERENCES MODULO_CLIENTES.CATEGORIA(cod_categoria),
  FOREIGN KEY (cod_premio) REFERENCES MODULO_CLIENTES.PREMIOS(cod_premio)
);

--REPORTE
CREATE TABLE MODULO_CLIENTES.REPORTE
(
  cod_reporte SERIAL NOT NULL,
  fecha_creacion_reporte TIMESTAMP NOT NULL DEFAULT NOW(),
  fecha_fin_periodo TIMESTAMP NOT NULL DEFAULT NOW(),
  periodo_reporte INTERVAL NOT NULL,
  PRIMARY KEY (cod_reporte)
);

--CANJE_CONSULTADO
CREATE TABLE MODULO_CLIENTES.CANJE_CONSULTADO
(
  cod_reporte INTEGER NOT NULL,
  cod_canje INTEGER NOT NULL,
  PRIMARY KEY (cod_reporte, cod_canje),
  FOREIGN KEY (cod_reporte) REFERENCES MODULO_CLIENTES.REPORTE(cod_reporte),
  FOREIGN KEY (cod_canje) REFERENCES MODULO_CLIENTES.CANJE(cod_canje)
);

--CLIENTE_CONSULTADO
CREATE TABLE MODULO_CLIENTES.CLIENTE_CONSULTADO
(
  cod_reporte INTEGER NOT NULL,
  cod_cliente INTEGER NOT NULL,
  PRIMARY KEY (cod_reporte, cod_cliente),
  FOREIGN KEY (cod_reporte) REFERENCES MODULO_CLIENTES.REPORTE(cod_reporte),
  FOREIGN KEY (cod_cliente) REFERENCES MODULO_CLIENTES.CLIENTE(cod_cliente)
);

--MAESTRO_CONSULTADO
CREATE TABLE MODULO_CLIENTES.MAESTRO_CONSULTADO
(
  cod_reporte INTEGER NOT NULL,
  cod_maestro INTEGER NOT NULL,
  PRIMARY KEY (cod_reporte, cod_maestro),
  FOREIGN KEY (cod_reporte) REFERENCES MODULO_CLIENTES.REPORTE(cod_reporte),
  FOREIGN KEY (cod_maestro) REFERENCES MODULO_CLIENTES.MAESTRO(cod_maestro)
);

