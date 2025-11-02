create extension if not exists "uuid-ossp";
--=============================================================
-- Módulo: CLIENTES (POBLACION DE TABLAS con datos iniciales)
-- =============================================================
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

--TIPO_PERSONA
INSERT INTO MODULO_CLIENTES.TIPO_PERSONA (valor_tipo_persona)
VALUES 
('NATURAL'),
('JURÍDICA'),
('GUBERNAMENTAL');
SELECT * FROM MODULO_CLIENTES.TIPO_PERSONA TP ;

--PERSONA
INSERT INTO MODULO_CLIENTES.PERSONA (nombre_persona, cod_tipo_persona)
VALUES 
('Pedro Carlos Vilchez Cardenas',1),
('Gabriel Jose Martinez Arista',1),
('Pedro Sebastian Nuñez Castillo',1),
('Juan Carlos Flores Sánchez',1),
('Ana María García Rodríguez',1),
('José Luis Torres Huamán',1),
('Rosa Elena Rojas Vásquez',1),
('Miguel Ángel Quispe Mamani',1),
('Carmen Victoria López Ramos',1),
('Jorge Luis Pérez Díaz',1),
('Sofía Alejandra Gonzáles Chávez',1),
('Marco Antonio Ramírez Mendoza',1),
('María Fernanda Espinoza Castillo',1),
('David Ricardo Fernández Vargas',1),
('Lucía Patricia Gutiérrez Cruz',1),
('Raúl Ernesto Ruíz Romero',1),
('Elena Soledad Gómez Silva',1),
('Luis Alberto Condori Martínez',1),
('Claudia Jimena Reyes Rivera',1),
('Diego Andrés Salazar Medina',1),
('Andrea Celeste Aguilar Morales',1),
('Julio César Paredes Castro',1),
('Valeria Isabel Córdova Acuña',1),
('Credicorp',2),
('Alicorp',2),
('Intercorp',2),
('Southern Peru Copper Corporation',2);
SELECT * FROM MODULO_CLIENTES.PERSONA;

--CLIENTE
INSERT INTO MODULO_CLIENTES.CLIENTE (cod_persona)
VALUES 
(1),
(3),
(2),
(12),
(13),
(14),
(15),
(16),
(17),
(18),
(19),
(20),
(21),
(22),
(23),
(24),
(25),
(26),
(27);
SELECT * FROM MODULO_CLIENTES.CLIENTE;

--TIPO_CONTACTO
INSERT INTO MODULO_CLIENTES.TIPO_CONTACTO (valor_tipo_contacto)
VALUES 
('CORREO'),
('TELEFONO CELULAR'),
('WHATSAPP');
SELECT * FROM MODULO_CLIENTES.TIPO_CONTACTO;

--CONTACTO
INSERT INTO MODULO_CLIENTES.CONTACTO (valor_contacto, cod_tipo_contacto)
VALUES 
('904 321 098',2),
('gabriel.a@uno.pe',1),
('123 456 789',2),
('987 654 322',2),
('987 654 321',2),
('999 888 777',2),
('912 345 678',2),
('954 321 098',2),
('960 001 112',2),
('945 612 378',2),
('933 221 100',2),
('971 721 731',2),
('920 806 402',2),
('982 555 111',2),
('913 707 923',2),
('955 888 222',2),
('967 400 300',2),
('932 605 981',2),
('948 765 432',2),
('977 111 222',2),
('914 567 890',2),
('980 706 504',2),
('993 444 888',2),
('929 191 292',2),
('juan.flores@ejemplocorreo.com',1),
('anagrcia.rdgz@contactoempresa.pe',1),
('jtorresh@miproyecto.net',1),
('rrojvazquez@perumail.com',1),
('miguel.quispe@correoandino.pe',1),
('carmenlopez.r@ejemplosol.com',1),
('jorgeperez@servicio.com.pe',1),
('sofia.gonzalez.c@negociosperu.pe',1),
('marcoramirez.m@dominio.net',1),
('maria.castillo.e@correo.com',1),
('davidricardo.f@mailcorporativo.pe',1),
('luti.gutierrez@emailpersonal.com',1),
('raul.ruiz.r@elcorreo.pe',1),
('esole.gomez@miservicios.net',1),
('lualbertocondori@datacorp.com.pe',1),
('claudia.reyes@contacto.pe',1),
('diego.salazar.m@miemprendimiento.com',1),
('andreaceleste.a@mail.pe',1),
('juliocesar.p@servicioperu.com',1),
('valeria.cordova@ejemplo.pe',1);
SELECT * FROM MODULO_CLIENTES.CONTACTO;

--DIRECCION
INSERT INTO MODULO_CLIENTES.DIRECCION (ciudad, distrito, via, numero)
VALUES 
('Lima', 'Barranco', 'Jirón 28 de Julio', '123'),
('Lima', 'Ate', 'Avenida Hermes', '256'), 
('Lima', 'Barranco', 'Jiron 28 de julio', '123'), 
('Lima', 'Santa Anita', 'Avenida Moro solar', '455'),
('Lima', 'Miraflores', 'Av. Larco', '1010'), 
('Lima', 'Santiago de Surco', 'Jr. Monte Rosa', '250 - Of. 301'), 
('Lima', 'San Isidro', 'Calle Las Camelias', '790'), 
('Lima', 'La Molina', 'Av. Raúl Ferrero', '1200'), 
('Lima', 'Barranco', 'Pje. Sáenz Peña', '190'), 
('Arequipa', 'Cercado', 'Calle San Agustín', '305'), 
('Arequipa', 'Yanahuara', 'Av. Ejército', '810'), 
('Cusco', 'Cusco', 'Av. El Sol', '920'), 
('Cusco', 'Wanchaq', 'Calle Túpac Amaru', 'Lote 15'), 
('Trujillo', 'Trujillo', 'Av. España', '2405'), 
('Trujillo', 'Víctor Larco Herrera', 'Jr. Ayacucho', '580'), 
('Piura', 'Piura', 'Calle Lima', '555'), 
('Piura', 'Castilla', 'Av. Ramón Castilla', 'Mz. G, Lt. 2'), 
('Chiclayo', 'Chiclayo', 'Calle Lora y Lora', '412'), 
('Chiclayo', 'La Victoria', 'Av. Los Incas', '1850'), 
('Iquitos', 'Iquitos', 'Av. Mariscal Cáceres', '110'), 
('Iquitos', 'San Juan Bautista', 'Jr. Putumayo', 'S/N (Km 4.5)'), 
('Huancayo', 'El Tambo', 'Jr. Puno', '701'), 
('Huancayo', 'Huancayo', 'Av. Giráldez', '330'), 
('Puno', 'Puno', 'Jr. Lima', '445'), 
('Puno', 'Juliaca', 'Jr. Mariano Melgar', '120 - Urb. Pumas'), 
('Tacna', 'Tacna', 'Calle Blondell', '150'), 
('Tacna', 'Gregorio Albarracín', 'Av. La Cultura', '902'), 
('Cajamarca', 'Cajamarca', 'Jr. Amalia Puga', '670'), 
('Cajamarca', 'Baños del Inca', 'Vía Los Baños', 'Parcela 8'), 
('Ica', 'Ica', 'Av. Cutervo', '205'), 
('Ica', 'Parcona', 'Calle Los Tulipanes', 'Mz. T, Lt. 10'), 
('Chimbote', 'Nuevo Chimbote', 'Av. Pacífico', '540'), 
('Chimbote', 'Chimbote', 'Pje. José Balta', '215'), 
('Lima', 'Pueblo Libre', 'Av. Bolívar', '1978');
SELECT * FROM MODULO_CLIENTES.DIRECCION;

--TIPO_DOCUMENTO
INSERT INTO MODULO_CLIENTES.TIPO_DOCUMENTO (valor_tipo_documento)
VALUES 
('DNI'),
('CARNET EXTRANJERIA'),
('RUC');
SELECT * FROM MODULO_CLIENTES.TIPO_DOCUMENTO;

--DOCUMENTO_PERSONA
INSERT INTO MODULO_CLIENTES.DOCUMENTO_PERSONA (valor_documento, cod_persona, cod_tipo_documento, principal_documento)
VALUES 
('10 12345678 8',1,3,true),
('7899 4567',2,1,true),
('40876543',4,1,true),
('78901234',5,1,true),
('8123456',6,1,true),
('60987654',7,1,true),
('45678901',8,1,true),
('11223344',9,1,true),
('55667788',10,1,true),
('32109876',11,1,true),
('80706050',12,1,true),
('19283746',13,1,true),
('1234 5678',3,1,true),
('10456789012',14,3,true),
('10987654321',15,3,true),
('10112233445',16,3,true),
('10765432109',17,3,true),
('10010010019',18,3,true),
('10334455667',19,3,true),
('10998877665',20,3,true),
('10223344556',21,3,true),
('10405060708',22,3,true),
('10302040608',23,3,true),
('20567890123',24,3,true),
('20123456789',25,3,true),
('20001002003',26,3,true),
('20998877665',27,3,true);
SELECT * FROM MODULO_CLIENTES.DOCUMENTO_PERSONA;

--DIRECCION_PERSONA
INSERT INTO MODULO_CLIENTES.DIRECCION_PERSONA (cod_persona, cod_direccion, principal_direccion)
VALUES 
(1,1,true),
(3,2,true),
(4,4,true),
(5,5,true),
(6,6,true),
(7,7,true),
(8,8,true),
(9,9,true),
(10,10,true),
(11,11,true),
(12,12,true),
(13,13,true),
(14,14,true),
(15,15,true),
(16,16,true),
(17,17,true),
(18,18,true),
(19,19,true),
(20,20,true),
(21,21,true),
(22,22,true),
(23,23,true),
(24,24,true),
(25,25,true),
(26,26,true),
(27,27,true),
(2,3,true);
SELECT * FROM MODULO_CLIENTES.DIRECCION_PERSONA;

--CONTACTO_PERSONA
INSERT INTO MODULO_CLIENTES.CONTACTO_PERSONA (cod_persona, cod_contacto , principal_contacto)
VALUES 
(2,2,1),
(3,2,2),
(5,3,2),
(1,1,2),
(5,4,2),
(6,5,2),
(7,6,2),
(8,7,2),
(9,8,2),
(10,9,2),
(11,10,2),
(12,11,2),
(13,12,2),
(14,13,2),
(15,14,2),
(16,15,2),
(17,16,2),
(18,17,2),
(19,18,2),
(20,19,2),
(21,20,2),
(22,21,2),
(23,22,2),
(24,23,2),
(25,4,1),
(26,5,),
(27,6,1),
(28,7,1),
(29,8,1),
(30,9,1),
(31,10,1),
(32,11,1),
(33,12,1),
(34,13,1),
(35,14,1),
(36,15,1),
(37,16,1),
(38,17,1),
(39,18,1),
(40,19,1),
(41,20,1),
(42,21,1),
(43,22,1),
(44,23,1);
SELECT * FROM MODULO_CLIENTES.CONTACTO_PERSONA;

--ESPECIALIDADES
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

--MAESTRO
INSERT INTO MODULO_CLIENTES.MAESTRO (ruc, cod_persona, cod_cliente, cod_especialidad)
VALUES
('10456789012',6,14,4),
('10987654321',7,15,7),
('10112233445',8,16,9),
('10765432109',9,17,12),
('10010010019',10,18,15),
('10 12345678 8',1,1,5);
SELECT * FROM MODULO_CLIENTES.MAESTRO;

--ROL
INSERT INTO MODULO_CLIENTES.ROL (valor_rol)
VALUES 
('Gerente'),
('Vendedor'),
('Transportista'),
('Almacen'),
('CRM'),
('ADMIN (⌐■_■)');
SELECT * FROM MODULO_CLIENTES.ROL;

--AREA
INSERT INTO MODULO_CLIENTES.AREA (valor_area)
VALUES 
('Almacen'),
('Ventas'),
('Marketing'),
('Abastecimiento'),
('SISTEMAS (⌐■_■)');
SELECT * FROM MODULO_CLIENTES.AREA;

--USUARIO
INSERT INTO MODULO_CLIENTES.USUARIO (cod_persona, cod_rol, cod_area)
VALUES
(4,1,4),
(2,2,5),
(5,3,6),
(3,4,7),
(3,1,8),
(2,2,9),
(1,3,10),
(3,4,11),
(6,5,2);
SELECT * FROM MODULO_CLIENTES.USUARIO;

--VENTA
INSERT INTO MODULO_CLIENTES.VENTA (monto_venta, puntos_venta, tipo_venta, estado_venta, fecha_entrega, cod_cliente, cod_usuario, cod_maestro)
VALUES 
(500.00, 50.00, 'CONTADO', 'Pendiente', (NOW()+'7 DAY'),
(SELECT cod_cliente FROM MODULO_CLIENTES.CLIENTE C  WHERE cod_persona = (SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Pedro Sebastian Nuñez Castillo')),
(SELECT cod_usuario FROM MODULO_CLIENTES.USUARIO WHERE cod_persona = (SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Gabriel Jose Martinez Arista')),
(SELECT cod_maestro FROM MODULO_CLIENTES.MAESTRO  WHERE cod_persona = (SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Pedro Carlos Vilchez Cardenas'))
);
SELECT * FROM MODULO_CLIENTES.VENTA;

--CATEGORIA
INSERT INTO MODULO_CLIENTES.CATEGORIA (valor_categoria)
VALUES 
('Herramienta'), 
('Fijación'), 
('Adhesivo'), 
('Pintura'), 
('Eléctrico'), 
('Fontanería'), 
('Seguridad'),
('Construcción'), 
('Iluminación'), 
('Climatización'), 
('Materiales'), 
('Accesorios'),
('Carpinteria'),
('Maquinaria');
SELECT * FROM MODULO_CLIENTES.CATEGORIA;

--ESTADO_CANJE
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

--CANJE
INSERT INTO MODULO_CLIENTES.CANJE (monto_canje, cod_usuario, cod_estado_canje, cod_maestro)
VALUES 
(30,9,1,6);
SELECT * FROM MODULO_CLIENTES.CANJE;

--PREMIOS
INSERT INTO MODULO_CLIENTES.PREMIOS (nombre_premio, descp_premio, puntos_premio, disponibilidad_premio)
VALUES 
('Taladro Inalámbrico 12V + Batería SCD121S1-B2 + Set 27 pz',$$ Detalle de la garantía:	Garantía del vendedor: 2 años
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
Inalámbrico:	Sí $$,30,50),
('Audífonos Inalámbricos Bluetooth JBL Tune 510BT',$$ Descripción: Audífonos inalámbricos con tecnología JBL Pure Bass. conexión Bluetooth 5.0. hasta 40 horas de batería y carga rápida. Color Negro. Incluye cable USB-C de carga. Ideal para uso diario y deporte. $$,15.5,120),
('Set de Cuchillos de Chef 5 Piezas Acero Inoxidable',$$ Set de 5 cuchillos profesionales para cocina con base de madera. Material de la hoja: Acero inoxidable de alta calidad. Incluye cuchillo de chef. santoku. pan. utilitario y pelador. Mango ergonómico. $$,8.9,200),
('Power Bank Xiaomi 10000mAh Carga Rápida',$$ Batería externa portátil de 10000 mAh. Conexión dual USB (Tipo A y Tipo C). Soporta carga rápida de 18W. Diseño compacto y ligero. ideal para viajes. Color: Blanco. $$,12,80),
('Licuadora Oster Xpert Series con Motor Reversible',$$ Electrodoméstico: Licuadora de alto rendimiento. Motor de 2 caballos de fuerza con tecnología reversible para mezclar y procesar. Vaso de vidrio refractario Boroclass de 2 Litros. 3 programas automáticos. $$,45.99,35),
('Google Chromecast con Google TV (HD)',$$ Dispositivo de streaming multimedia. Transforma cualquier TV con puerto HDMI en Smart TV. Incluye control remoto por voz. Resolución máxima: HD 1080p. Conectividad Wi-Fi dual band. $$,18.5,95),
('Mochila Antirrobo para Laptop 15.6" con Puerto USB',$$ Accesorio de viaje y seguridad. Material resistente al corte y al agua. Capacidad de 20 Litros. Compartimento acolchado para laptop de 15.6 pulgadas. Puerto de carga USB externo (requiere power bank no incluido). $$,10.5,150),
('Reloj Inteligente (Smartwatch) Deportivo con GPS',$$ Tecnología wearable. Funciones: Medición de ritmo cardíaco + monitor de sueño + contador de pasos + GPS integrado para seguimiento de rutas. Compatible con Android e iOS. Resistencia al agua IP68. $$,28,60),
('Cafetera Eléctrica de Goteo para 12 Tazas',$$ Electrodoméstico básico. Capacidad para 1.5 litros (12 tazas). Sistema anti-goteo. Filtro permanente lavable. Placa calefactora que mantiene el café caliente. Color: Negro. $$,7.5,180),
('Kit de Limpieza para PC y Electrónicos 6 en 1',$$ Kit que incluye: cepillo antiestático + paños de microfibra + soplador de aire + líquido limpiador + hisopos y extractor de teclas. Ideal para teclados + pantallas y lentes. $$,4,250),
('Disco Duro Externo Portátil 1TB USB 3.0',$$ Almacenamiento digital. Capacidad: 1 Terabyte. Interfaz: USB 3.0 (compatible con 2.0). Velocidad de transferencia rápida. Compatible con Windows y Mac. Carcasa resistente a golpes leves. $$,35,40);
SELECT * FROM MODULO_CLIENTES.PREMIOS;

--DETALLE_CANJE
INSERT INTO MODULO_CLIENTES.DETALLE_CANJE (cantidad_premio, cod_canje, cod_premio)
VALUES 
(1,1,1);
SELECT * FROM MODULO_CLIENTES.DETALLE_CANJE;

--CATEGORIAS_PREMIO
INSERT INTO MODULO_CLIENTES.CATEGORIAS_PREMIO (cod_categoria, cod_premio)
VALUES 
(1,1),
(13,1);
SELECT * FROM MODULO_CLIENTES.CATEGORIAS_PREMIO;

--REPORTE
INSERT INTO MODULO_CLIENTES.REPORTE (periodo_reporte)
VALUES 
('1 YEAR');
SELECT * FROM MODULO_CLIENTES.REPORTE;

--CANJE_CONSULTADO
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

--CLIENTE_CONSULTADO
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

--MAESTRO_CONSULTADO
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



SELECT * FROM
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
    MODULO_CLIENTES.venta;




