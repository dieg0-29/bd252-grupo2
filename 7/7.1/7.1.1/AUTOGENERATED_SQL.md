CREATE TABLE TIPO_PERSONA
(
  cod_tipo_persona INT NOT NULL,
  valor_tipo_persona INT NOT NULL,
  PRIMARY KEY (cod_tipo_persona)
);

CREATE TABLE PERSONA
(
  cod_persona INT NOT NULL,
  fecha_registro_persona INT NOT NULL,
  nombre_persona INT NOT NULL,
  cod_tipo_persona INT NOT NULL,
  PRIMARY KEY (cod_persona),
  FOREIGN KEY (cod_tipo_persona) REFERENCES TIPO_PERSONA(cod_tipo_persona)
);

CREATE TABLE CLIENTE
(
  cod_cliente INT NOT NULL,
  fecha_registro_cliente INT NOT NULL,
  cod_persona INT NOT NULL,
  PRIMARY KEY (cod_cliente, cod_persona),
  FOREIGN KEY (cod_persona) REFERENCES PERSONA(cod_persona),
  UNIQUE (cod_cliente),
  UNIQUE (fk_PERSONA)
);

CREATE TABLE TIPO_CONTACTO
(
  cod_tipo_contacto INT NOT NULL,
  valor_tipo_contacto INT NOT NULL,
  descripcion_tipo_contacto INT NOT NULL,
  PRIMARY KEY (cod_tipo_contacto)
);

CREATE TABLE CONTACTO
(
  cod_contacto INT NOT NULL,
  valor_contacto INT NOT NULL,
  cod_tipo_contacto INT NOT NULL,
  PRIMARY KEY (cod_contacto),
  FOREIGN KEY (cod_tipo_contacto) REFERENCES TIPO_CONTACTO(cod_tipo_contacto)
);

CREATE TABLE DIRECCION
(
  cod_direccion INT NOT NULL,
  ciudad INT NOT NULL,
  distrito INT NOT NULL,
  via INT NOT NULL,
  numero INT NOT NULL,
  PRIMARY KEY (cod_direccion)
);

CREATE TABLE TIPO_DOCUMENTO
(
  cod_tipo_documento INT NOT NULL,
  valor_tipo_documento INT NOT NULL,
  PRIMARY KEY (cod_tipo_documento)
);

CREATE TABLE DOCUMENTO_PERSONA
(
  valor_documento INT NOT NULL,
  cod_persona INT NOT NULL,
  cod_tipo_documento INT NOT NULL,
  PRIMARY KEY (cod_persona, cod_tipo_documento),
  FOREIGN KEY (cod_persona) REFERENCES PERSONA(cod_persona),
  FOREIGN KEY (cod_tipo_documento) REFERENCES TIPO_DOCUMENTO(cod_tipo_documento)
);

CREATE TABLE DIRECCION_PERSONA
(
  cod_direccion INT NOT NULL,
  cod_persona INT NOT NULL,
  PRIMARY KEY (cod_direccion, cod_persona),
  FOREIGN KEY (cod_direccion) REFERENCES DIRECCION(cod_direccion),
  FOREIGN KEY (cod_persona) REFERENCES PERSONA(cod_persona)
);

CREATE TABLE CONTACTO_PERSONA
(
  cod_contacto INT NOT NULL,
  cod_persona INT NOT NULL,
  PRIMARY KEY (cod_contacto, cod_persona),
  FOREIGN KEY (cod_contacto) REFERENCES CONTACTO(cod_contacto),
  FOREIGN KEY (cod_persona) REFERENCES PERSONA(cod_persona)
);

CREATE TABLE ESPECIALIDADES
(
  cod_especialidad VARCHAR NOT NULL,
  valor_especialidad VARCHAR NOT NULL,
  PRIMARY KEY (cod_especialidad)
);

CREATE TABLE MAESTRO
(
  cod_maestro INT NOT NULL,
  ruc INT NOT NULL,
  puntos_maestro INT NOT NULL,
  fecha_registro_maestro INT NOT NULL,
  cod_cliente INT NOT NULL,
  cod_persona INT NOT NULL,
  cod_especialidad VARCHAR NOT NULL,
  PRIMARY KEY (cod_maestro, cod_cliente, cod_persona),
  FOREIGN KEY (cod_cliente, cod_persona) REFERENCES CLIENTE(cod_cliente, cod_persona),
  FOREIGN KEY (cod_especialidad) REFERENCES ESPECIALIDADES(cod_especialidad)
);

CREATE TABLE TIPO_USUARIO
(
  cod_tipo_usuario INT NOT NULL,
  valor_tipo_usuario INT NOT NULL,
  PRIMARY KEY (cod_tipo_usuario)
);

CREATE TABLE USUARIO
(
  cod_usuario INT NOT NULL,
  fecha_registro_usuario INT NOT NULL,
  cod_tipo_usuario INT NOT NULL,
  cod_persona INT NOT NULL,
  PRIMARY KEY (cod_usuario, cod_persona),
  FOREIGN KEY (cod_tipo_usuario) REFERENCES TIPO_USUARIO(cod_tipo_usuario),
  FOREIGN KEY (cod_persona) REFERENCES PERSONA(cod_persona),
  UNIQUE (cod_usuario),
  UNIQUE (fk_PERSONA)
);

CREATE TABLE VENTA
(
  cod_venta INT NOT NULL,
  fecha_hora_venta INT NOT NULL,
  igv INT NOT NULL,
  monto_venta INT NOT NULL,
  puntos_venta INT NOT NULL,
  cod_tipo_venta_(FK) INT NOT NULL,
  cod_estado_venta_(FK) INT NOT NULL,
  fecha_entrega INT NOT NULL,
  cod_cliente INT NOT NULL,
  cod_persona INT NOT NULL,
  cod_usuario INT NOT NULL,
  cod_persona INT NOT NULL,
  cod_maestro INT NOT NULL,
  cod_cliente INT NOT NULL,
  cod_persona INT NOT NULL,
  PRIMARY KEY (cod_venta),
  FOREIGN KEY (cod_cliente, cod_persona) REFERENCES CLIENTE(cod_cliente, cod_persona),
  FOREIGN KEY (cod_usuario, cod_persona) REFERENCES USUARIO(cod_usuario, cod_persona),
  FOREIGN KEY (cod_maestro, cod_cliente, cod_persona) REFERENCES MAESTRO(cod_maestro, cod_cliente, cod_persona)
);

CREATE TABLE CATEGORIA
(
  cod_categoria INT NOT NULL,
  valor_categoria INT NOT NULL,
  PRIMARY KEY (cod_categoria)
);

CREATE TABLE ESTADO_CANJE
(
  cod_estado_canje INT NOT NULL,
  valor_estado_canje INT NOT NULL,
  PRIMARY KEY (cod_estado_canje)
);

CREATE TABLE CANJE
(
  cod_canje INT NOT NULL,
  fecha_hora_canje INT NOT NULL,
  monto_canje INT NOT NULL,
  fecha_entrega INT NOT NULL,
  cod_usuario INT NOT NULL,
  cod_persona INT NOT NULL,
  cod_estado_canje INT NOT NULL,
  cod_maestro INT NOT NULL,
  cod_cliente INT NOT NULL,
  cod_persona INT NOT NULL,
  PRIMARY KEY (cod_canje),
  FOREIGN KEY (cod_usuario, cod_persona) REFERENCES USUARIO(cod_usuario, cod_persona),
  FOREIGN KEY (cod_estado_canje) REFERENCES ESTADO_CANJE(cod_estado_canje),
  FOREIGN KEY (cod_maestro, cod_cliente, cod_persona) REFERENCES MAESTRO(cod_maestro, cod_cliente, cod_persona)
);

CREATE TABLE PREMIOS
(
  cod_premio INT NOT NULL,
  nombre_premio INT NOT NULL,
  descp_premio INT NOT NULL,
  puntos_premio INT NOT NULL,
  disponibilidad_premio INT NOT NULL,
  PRIMARY KEY (cod_premio)
);

CREATE TABLE DETALLE_CANJE
(
  cantidad_premio INT NOT NULL,
  cod_canje INT NOT NULL,
  cod_premio INT NOT NULL,
  PRIMARY KEY (cod_canje, cod_premio),
  FOREIGN KEY (cod_canje) REFERENCES CANJE(cod_canje),
  FOREIGN KEY (cod_premio) REFERENCES PREMIOS(cod_premio)
);

CREATE TABLE CATEGORIAS_PREMIO
(
  cod_categoria INT NOT NULL,
  cod_premio INT NOT NULL,
  PRIMARY KEY (cod_categoria, cod_premio),
  FOREIGN KEY (cod_categoria) REFERENCES CATEGORIA(cod_categoria),
  FOREIGN KEY (cod_premio) REFERENCES PREMIOS(cod_premio)
);

CREATE TABLE REPORTE
(
  cod_reporte INT NOT NULL,
  fecha_creacion_reporte INT NOT NULL,
  periodo_reporte INT NOT NULL,
  PRIMARY KEY (cod_reporte)
);

CREATE TABLE CANJE_CONSULTADO
(
  cod_reporte INT NOT NULL,
  cod_canje INT NOT NULL,
  PRIMARY KEY (cod_reporte, cod_canje),
  FOREIGN KEY (cod_reporte) REFERENCES REPORTE(cod_reporte),
  FOREIGN KEY (cod_canje) REFERENCES CANJE(cod_canje)
);

CREATE TABLE CLIENTE_CONSULTADO
(
  cod_reporte INT NOT NULL,
  cod_cliente INT NOT NULL,
  cod_persona INT NOT NULL,
  PRIMARY KEY (cod_reporte, cod_cliente, cod_persona),
  FOREIGN KEY (cod_reporte) REFERENCES REPORTE(cod_reporte),
  FOREIGN KEY (cod_cliente, cod_persona) REFERENCES CLIENTE(cod_cliente, cod_persona)
);

CREATE TABLE MAESTRO_CONSULTADO
(
  cod_reporte INT NOT NULL,
  cod_maestro INT NOT NULL,
  cod_cliente INT NOT NULL,
  cod_persona INT NOT NULL,
  PRIMARY KEY (cod_reporte, cod_maestro, cod_cliente, cod_persona),
  FOREIGN KEY (cod_reporte) REFERENCES REPORTE(cod_reporte),
  FOREIGN KEY (cod_maestro, cod_cliente, cod_persona) REFERENCES MAESTRO(cod_maestro, cod_cliente, cod_persona)
);

CREATE TABLE INDICADOR
(
  cod_indicador INT NOT NULL,
  valor_indicador INT NOT NULL,
  PRIMARY KEY (cod_indicador)
);

CREATE TABLE INDICADORES_REPORTE
(
  cod_indicador INT NOT NULL,
  cod_reporte INT NOT NULL,
  PRIMARY KEY (cod_indicador, cod_reporte),
  FOREIGN KEY (cod_indicador) REFERENCES INDICADOR(cod_indicador),
  FOREIGN KEY (cod_reporte) REFERENCES REPORTE(cod_reporte)
);