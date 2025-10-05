create extension if not exists "uuid-ossp";

TRUNCATE TABLE
    MODULO_CLIENTES.canje,
    MODULO_CLIENTES.canje_consultado,
    MODULO_CLIENTES.categoria,
    MODULO_CLIENTES.categorias_premio,
    MODULO_CLIENTES.cliente,
    MODULO_CLIENTES.cliente_consultado,
    MODULO_CLIENTES.contacto,
    MODULO_CLIENTES.contacto_persona,
    MODULO_CLIENTES.detalle_canje,
    MODULO_CLIENTES.direccion,
    MODULO_CLIENTES.direccion_persona,
    MODULO_CLIENTES.documento_persona,
    MODULO_CLIENTES.especialidades,
    MODULO_CLIENTES.estado_canje,
    MODULO_CLIENTES.maestro,
    MODULO_CLIENTES.maestro_consultado,
    MODULO_CLIENTES.persona,
    MODULO_CLIENTES.premios,
    MODULO_CLIENTES.reporte,
    MODULO_CLIENTES.tipo_contacto,
    MODULO_CLIENTES.tipo_documento,
    MODULO_CLIENTES.tipo_persona,
    MODULO_CLIENTES.rol,
    MODULO_CLIENTES.area,
    MODULO_CLIENTES.usuario,
    MODULO_CLIENTES.venta
RESTART IDENTITY CASCADE;


INSERT INTO MODULO_CLIENTES.TIPO_PERSONA (valor_tipo_persona)
VALUES 
('NATURAL'),
('JURÍDICA'),
('GUBERNAMENTAL');
SELECT * FROM MODULO_CLIENTES.TIPO_PERSONA;

INSERT INTO MODULO_CLIENTES.PERSONA (nombre_persona, cod_tipo_persona)
VALUES 
('Pedro Vilchez Cardenas', (SELECT cod_tipo_persona FROM MODULO_CLIENTES.TIPO_PERSONA WHERE valor_tipo_persona = 'NATURAL')),
('Gabriel Martinez Arista', (SELECT cod_tipo_persona FROM MODULO_CLIENTES.TIPO_PERSONA WHERE valor_tipo_persona = 'NATURAL')),
('Pedro Nuñez Castillo', (SELECT cod_tipo_persona FROM MODULO_CLIENTES.TIPO_PERSONA WHERE valor_tipo_persona = 'NATURAL'));
SELECT * FROM MODULO_CLIENTES.PERSONA;

INSERT INTO MODULO_CLIENTES.CLIENTE (cod_persona)
VALUES 
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Pedro Vilchez Cardenas')),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Pedro Nuñez Castillo')),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Gabriel Martinez Arista'));
SELECT * FROM MODULO_CLIENTES.CLIENTE;

INSERT INTO MODULO_CLIENTES.TIPO_CONTACTO (valor_tipo_contacto)
VALUES 
('CORREO'),
('TELEFONO CELULAR'),
('WHATSAPP');
SELECT * FROM MODULO_CLIENTES.TIPO_CONTACTO;

INSERT INTO MODULO_CLIENTES.CONTACTO (valor_contacto, cod_tipo_contacto)
VALUES 
('904 321 098',(SELECT cod_tipo_contacto FROM MODULO_CLIENTES.TIPO_CONTACTO WHERE valor_tipo_contacto = 'TELEFONO CELULAR')),
('gabriel.a@uno.pe',(SELECT cod_tipo_contacto FROM MODULO_CLIENTES.TIPO_CONTACTO WHERE valor_tipo_contacto = 'CORREO')),
('123 456 789',(SELECT cod_tipo_contacto FROM MODULO_CLIENTES.TIPO_CONTACTO WHERE valor_tipo_contacto = 'TELEFONO CELULAR')),
('987 654 321',(SELECT cod_tipo_contacto FROM MODULO_CLIENTES.TIPO_CONTACTO WHERE valor_tipo_contacto = 'TELEFONO CELULAR'));
SELECT * FROM MODULO_CLIENTES.CONTACTO;

INSERT INTO MODULO_CLIENTES.DIRECCION (ciudad, distrito, via, numero)
VALUES 
('Lima', 'Barranco', 'Jirón 28 de Julio', '123'),
('Lima', 'Ate', 'Avenida Hermes', '256'), 
('Lima', 'Barranco', 'Jiron 28 de julio', '123'), 
('Lima', 'Santa Anita', 'Avenida Moro solar', '455');
SELECT * FROM MODULO_CLIENTES.DIRECCION;

INSERT INTO MODULO_CLIENTES.TIPO_DOCUMENTO (valor_tipo_documento)
VALUES 
('DNI'),
('CARNET EXTRANJERIA'),
('RUC');
SELECT * FROM MODULO_CLIENTES.TIPO_DOCUMENTO;

INSERT INTO MODULO_CLIENTES.DOCUMENTO_PERSONA (valor_documento, cod_persona, cod_tipo_documento)
VALUES 
('10 12345678 8',(SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Pedro Vilchez Cardenas'),(SELECT cod_tipo_documento FROM MODULO_CLIENTES.TIPO_DOCUMENTO WHERE valor_tipo_documento = 'RUC')),
('7899 4567',(SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Gabriel Martinez Arista'),(SELECT cod_tipo_documento FROM MODULO_CLIENTES.TIPO_DOCUMENTO WHERE valor_tipo_documento = 'DNI')),
('1234 5678',(SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Pedro Nuñez Castillo'),(SELECT cod_tipo_documento FROM MODULO_CLIENTES.TIPO_DOCUMENTO WHERE valor_tipo_documento = 'DNI'));
SELECT * FROM MODULO_CLIENTES.DOCUMENTO_PERSONA;

INSERT INTO MODULO_CLIENTES.DIRECCION_PERSONA (cod_persona, cod_direccion)
VALUES 
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Pedro Vilchez Cardenas'),(SELECT cod_direccion FROM MODULO_CLIENTES.DIRECCION D WHERE (ciudad, distrito, via, numero) = ('Lima', 'Barranco', 'Jirón 28 de Julio', '123'))),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Gabriel Martinez Arista'),(SELECT cod_direccion FROM MODULO_CLIENTES.DIRECCION D WHERE (ciudad, distrito, via, numero) = ('Lima', 'Barranco', 'Jiron 28 de julio', '123'))),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Pedro Nuñez Castillo'),(SELECT cod_direccion FROM MODULO_CLIENTES.DIRECCION D WHERE (ciudad, distrito, via, numero) = ('Lima', 'Ate', 'Avenida Hermes', '256')));
SELECT * FROM MODULO_CLIENTES.DIRECCION_PERSONA;

INSERT INTO MODULO_CLIENTES.CONTACTO_PERSONA (cod_persona, cod_contacto)
VALUES 
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Gabriel Martinez Arista'),(SELECT cod_contacto FROM MODULO_CLIENTES.CONTACTO C WHERE C.VALOR_CONTACTO = 'gabriel.a@uno.pe')),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Gabriel Martinez Arista'),(SELECT cod_contacto FROM MODULO_CLIENTES.CONTACTO C WHERE C.VALOR_CONTACTO = '123 456 789')),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Pedro Nuñez Castillo'),(SELECT cod_contacto FROM MODULO_CLIENTES.CONTACTO C WHERE C.VALOR_CONTACTO = '987 654 321')),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Pedro Vilchez Cardenas'),(SELECT cod_contacto FROM MODULO_CLIENTES.CONTACTO C WHERE C.VALOR_CONTACTO = '904 321 098'));
SELECT * FROM MODULO_CLIENTES.CONTACTO_PERSONA;

INSERT INTO MODULO_CLIENTES.ESPECIALIDADES (valor_especialidad)
VALUES 
('Albañilería'), 
('Estructuras'), 
('Hormigón'), 
('Cimentación'),
('Gasfiteria'),
('Acero'), 
('Plomería'), 
('Electricidad'), 
('Drywall'), 
('Carpintería'), 
('Pisos'), 
('Pintura'), 
('Impermeab'), 
('Remodelación'), 
('Demolición'), 
('Acabados'), 
('Aislamiento'), 
('Topografía'), 
('Supervisión'), 
('Seguridad'), 
('Viales');
SELECT * FROM MODULO_CLIENTES.ESPECIALIDADES;

INSERT INTO MODULO_CLIENTES.MAESTRO (ruc, cod_persona, cod_cliente, cod_especialidad)
VALUES 
('10 12345678 8', 
(SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Pedro Vilchez Cardenas'), 
(SELECT cod_cliente FROM MODULO_CLIENTES.CLIENTE C  WHERE cod_persona = (SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Pedro Vilchez Cardenas')), 
(SELECT cod_especialidad FROM MODULO_CLIENTES.ESPECIALIDADES E  WHERE valor_especialidad = 'Gasfiteria'));
SELECT * FROM MODULO_CLIENTES.MAESTRO;

INSERT INTO MODULO_CLIENTES.ROL (valor_rol)
VALUES 
('Gerente'),
('Vendedor'),
('Transportista'),
('Almacen'),
('CRM'),
('ADMIN (⌐■_■)');
SELECT * FROM MODULO_CLIENTES.ROL;

INSERT INTO MODULO_CLIENTES.AREA (valor_area)
VALUES 
('Almacen'),
('Ventas'),
('Marketing'),
('Abastecimiento'),
('SISTEMAS (⌐■_■)');
SELECT * FROM MODULO_CLIENTES.AREA;

INSERT INTO MODULO_CLIENTES.USUARIO (cod_persona, cod_rol, cod_area)
VALUES 
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA P  WHERE nombre_persona = 'Gabriel Martinez Arista'),(SELECT cod_rol FROM MODULO_CLIENTES.ROL TU  WHERE valor_rol = 'ADMIN (⌐■_■)'),(SELECT cod_area FROM MODULO_CLIENTES.AREA A  WHERE valor_area = 'SISTEMAS (⌐■_■)'));
SELECT * FROM MODULO_CLIENTES.USUARIO;

INSERT INTO MODULO_CLIENTES.VENTA (monto_venta, puntos_venta, tipo_venta, estado_venta, fecha_entrega, cod_cliente, cod_usuario, cod_maestro)
VALUES 
(500.00, 50.00, 'CONTADO', 'Pendiente', (NOW()+'7 DAY'),
(SELECT cod_cliente FROM MODULO_CLIENTES.CLIENTE C  WHERE cod_persona = (SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Pedro Nuñez Castillo')),
(SELECT cod_usuario FROM MODULO_CLIENTES.USUARIO WHERE cod_persona = (SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Gabriel Martinez Arista')),
(SELECT cod_maestro FROM MODULO_CLIENTES.MAESTRO  WHERE cod_persona = (SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Pedro Vilchez Cardenas'))
);
SELECT * FROM MODULO_CLIENTES.VENTA;

INSERT INTO MODULO_CLIENTES.CATEGORIA (valor_categoria)
VALUES 
('Herramienta'), 
('Fijación'), 
('Adhesivo'), 
('Pintura'), 
('Eléctrico'), 
('Fontanería'), 
('Medición'), 
('Seguridad'), 
('Maquinaria');
SELECT * FROM MODULO_CLIENTES.CATEGORIA;

INSERT INTO MODULO_CLIENTES.ESTADO_CANJE (valor_estado_canje)
VALUES 
('Pendiente'), 
('Aprobado'), 
('En Preparación'), 
('En Tránsito'), 
('En Reparto'), 
('Entregado'), 
('Cancelado'), 
('Devuelto'), 
('Extraviado');
SELECT * FROM MODULO_CLIENTES.ESTADO_CANJE;

INSERT INTO MODULO_CLIENTES.CANJE (monto_canje, cod_usuario, cod_estado_canje, cod_maestro)
VALUES 
(30,
(SELECT cod_usuario FROM MODULO_CLIENTES.USUARIO WHERE cod_persona = (SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Gabriel Martinez Arista')),
(SELECT cod_estado_canje FROM MODULO_CLIENTES.ESTADO_CANJE WHERE valor_estado_canje = 'Pendiente'),
(SELECT cod_maestro FROM MODULO_CLIENTES.MAESTRO  WHERE cod_persona = (SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Pedro Vilchez Cardenas'))
);
SELECT * FROM MODULO_CLIENTES.CANJE;


INSERT INTO MODULO_CLIENTES.PREMIOS (nombre_premio, descp_premio, puntos_premio, disponibilidad_premio)
VALUES 
('Taladro Inalámbrico 12V + Batería SCD121S1-B2 + Set 27 pz', 
$$ Detalle de la garantía:	Garantía del vendedor: 2 años
Condicion del producto:	Nuevo
Modelo:	SCD121S1-B2
Potencia:	12V
Voltaje:	-
Conectividad/conexión:	Inalámbrico
Uso de la herramienta:	Profesional
Alto:	19.5
Tipo de taladro:	Taladro inalámbrico
Garantía:	1 año
Ancho:	7
Largo:	35 cm
Velocidad:	400 - 1500 RPM
Tamaño del mandril:	10 mm
Inalámbrico:	Sí $$,
30.00, 50 
);
SELECT * FROM MODULO_CLIENTES.PREMIOS;

INSERT INTO MODULO_CLIENTES.DETALLE_CANJE (cantidad_premio, cod_canje, cod_premio)
VALUES 
(1,
(SELECT cod_canje FROM MODULO_CLIENTES.CANJE WHERE cod_maestro = (SELECT cod_maestro FROM MODULO_CLIENTES.MAESTRO  WHERE cod_persona = (SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Pedro Vilchez Cardenas'))),
(SELECT cod_premio FROM MODULO_CLIENTES.PREMIOS WHERE nombre_premio = 'Taladro Inalámbrico 12V + Batería SCD121S1-B2 + Set 27 pz')
);
SELECT * FROM MODULO_CLIENTES.DETALLE_CANJE;

INSERT INTO MODULO_CLIENTES.CATEGORIAS_PREMIO (cod_categoria, cod_premio)
VALUES 
((SELECT cod_categoria FROM MODULO_CLIENTES.CATEGORIA WHERE valor_categoria = 'Herramienta'),
(SELECT cod_premio FROM MODULO_CLIENTES.PREMIOS WHERE nombre_premio = 'Taladro Inalámbrico 12V + Batería SCD121S1-B2 + Set 27 pz')
);
SELECT * FROM MODULO_CLIENTES.CATEGORIAS_PREMIO;

INSERT INTO MODULO_CLIENTES.REPORTE (periodo_reporte)
VALUES 
('1 YEAR');
SELECT * FROM MODULO_CLIENTES.REPORTE;

INSERT INTO MODULO_CLIENTES.CANJE_CONSULTADO (cod_reporte, cod_canje)
SELECT
    (   SELECT cod_reporte 
        FROM MODULO_CLIENTES.REPORTE 
        WHERE fecha_fin_periodo::DATE = NOW()::DATE 
        AND periodo_reporte = '1 YEAR'
    ),
    C.cod_canje
FROM 
    MODULO_CLIENTES.CANJE AS C
WHERE
    C.fecha_hora_canje BETWEEN (NOW() - INTERVAL '1 YEAR') AND NOW();
SELECT * FROM MODULO_CLIENTES.CANJE_CONSULTADO;

INSERT INTO MODULO_CLIENTES.CLIENTE_CONSULTADO (cod_reporte, cod_cliente)
SELECT
    (   SELECT cod_reporte 
        FROM MODULO_CLIENTES.REPORTE 
        WHERE fecha_fin_periodo::DATE = NOW()::DATE 
        AND periodo_reporte = '1 YEAR'
    ),
    C.cod_cliente
FROM 
    MODULO_CLIENTES.CLIENTE AS C
WHERE
    C.ultima_actividad_cliente BETWEEN (NOW() - INTERVAL '1 YEAR') AND NOW();
SELECT * FROM MODULO_CLIENTES.CLIENTE_CONSULTADO;

INSERT INTO MODULO_CLIENTES.MAESTRO_CONSULTADO (cod_reporte, cod_maestro)
SELECT
    (   SELECT cod_reporte 
        FROM MODULO_CLIENTES.REPORTE 
        WHERE fecha_fin_periodo::DATE = NOW()::DATE 
        AND periodo_reporte = '1 YEAR'
    ),
    M.cod_maestro
FROM 
    MODULO_CLIENTES.MAESTRO AS M
WHERE
    M.ultima_actividad_maestro BETWEEN (NOW() - INTERVAL '1 YEAR') AND NOW();
SELECT * FROM MODULO_CLIENTES.MAESTRO_CONSULTADO;
