create extension if not exists "uuid-ossp";
=============================================================
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
SELECT * FROM MODULO_CLIENTES.TIPO_PERSONA;

--PERSONA
INSERT INTO MODULO_CLIENTES.PERSONA (nombre_persona, cod_tipo_persona)
VALUES 
('Pedro Carlos Vilchez Cardenas', (SELECT cod_tipo_persona FROM MODULO_CLIENTES.TIPO_PERSONA WHERE valor_tipo_persona = 'NATURAL')),
('Gabriel Jose Martinez Arista', (SELECT cod_tipo_persona FROM MODULO_CLIENTES.TIPO_PERSONA WHERE valor_tipo_persona = 'NATURAL')),
('Pedro Sebastian Nuñez Castillo', (SELECT cod_tipo_persona FROM MODULO_CLIENTES.TIPO_PERSONA WHERE valor_tipo_persona = 'NATURAL')),
('Juan Carlos Flores Sánchez', (SELECT cod_tipo_persona FROM MODULO_CLIENTES.TIPO_PERSONA WHERE valor_tipo_persona = 'NATURAL')),
('Ana María García Rodríguez', (SELECT cod_tipo_persona FROM MODULO_CLIENTES.TIPO_PERSONA WHERE valor_tipo_persona = 'NATURAL')),
('José Luis Torres Huamán', (SELECT cod_tipo_persona FROM MODULO_CLIENTES.TIPO_PERSONA WHERE valor_tipo_persona = 'NATURAL')),
('Rosa Elena Rojas Vásquez', (SELECT cod_tipo_persona FROM MODULO_CLIENTES.TIPO_PERSONA WHERE valor_tipo_persona = 'NATURAL')),
('Miguel Ángel Quispe Mamani', (SELECT cod_tipo_persona FROM MODULO_CLIENTES.TIPO_PERSONA WHERE valor_tipo_persona = 'NATURAL')),
('Carmen Victoria López Ramos', (SELECT cod_tipo_persona FROM MODULO_CLIENTES.TIPO_PERSONA WHERE valor_tipo_persona = 'NATURAL')),
('Jorge Luis Pérez Díaz', (SELECT cod_tipo_persona FROM MODULO_CLIENTES.TIPO_PERSONA WHERE valor_tipo_persona = 'NATURAL')),
('Sofía Alejandra Gonzáles Chávez', (SELECT cod_tipo_persona FROM MODULO_CLIENTES.TIPO_PERSONA WHERE valor_tipo_persona = 'NATURAL')),
('Marco Antonio Ramírez Mendoza', (SELECT cod_tipo_persona FROM MODULO_CLIENTES.TIPO_PERSONA WHERE valor_tipo_persona = 'NATURAL')),
('María Fernanda Espinoza Castillo', (SELECT cod_tipo_persona FROM MODULO_CLIENTES.TIPO_PERSONA WHERE valor_tipo_persona = 'NATURAL')),
('David Ricardo Fernández Vargas', (SELECT cod_tipo_persona FROM MODULO_CLIENTES.TIPO_PERSONA WHERE valor_tipo_persona = 'NATURAL')),
('Lucía Patricia Gutiérrez Cruz', (SELECT cod_tipo_persona FROM MODULO_CLIENTES.TIPO_PERSONA WHERE valor_tipo_persona = 'NATURAL')),
('Raúl Ernesto Ruíz Romero', (SELECT cod_tipo_persona FROM MODULO_CLIENTES.TIPO_PERSONA WHERE valor_tipo_persona = 'NATURAL')),
('Elena Soledad Gómez Silva', (SELECT cod_tipo_persona FROM MODULO_CLIENTES.TIPO_PERSONA WHERE valor_tipo_persona = 'NATURAL')),
('Luis Alberto Condori Martínez', (SELECT cod_tipo_persona FROM MODULO_CLIENTES.TIPO_PERSONA WHERE valor_tipo_persona = 'NATURAL')),
('Claudia Jimena Reyes Rivera', (SELECT cod_tipo_persona FROM MODULO_CLIENTES.TIPO_PERSONA WHERE valor_tipo_persona = 'NATURAL')),
('Diego Andrés Salazar Medina', (SELECT cod_tipo_persona FROM MODULO_CLIENTES.TIPO_PERSONA WHERE valor_tipo_persona = 'NATURAL')),
('Andrea Celeste Aguilar Morales', (SELECT cod_tipo_persona FROM MODULO_CLIENTES.TIPO_PERSONA WHERE valor_tipo_persona = 'NATURAL')),
('Julio César Paredes Castro', (SELECT cod_tipo_persona FROM MODULO_CLIENTES.TIPO_PERSONA WHERE valor_tipo_persona = 'NATURAL')),
('Valeria Isabel Córdova Acuña', (SELECT cod_tipo_persona FROM MODULO_CLIENTES.TIPO_PERSONA WHERE valor_tipo_persona = 'NATURAL')),
('Credicorp', (SELECT cod_tipo_persona FROM MODULO_CLIENTES.TIPO_PERSONA WHERE valor_tipo_persona = 'JURÍDICA')),
('Alicorp', (SELECT cod_tipo_persona FROM MODULO_CLIENTES.TIPO_PERSONA WHERE valor_tipo_persona = 'JURÍDICA')),
('Intercorp', (SELECT cod_tipo_persona FROM MODULO_CLIENTES.TIPO_PERSONA WHERE valor_tipo_persona = 'JURÍDICA')),
('Southern Peru Copper Corporation', (SELECT cod_tipo_persona FROM MODULO_CLIENTES.TIPO_PERSONA WHERE valor_tipo_persona = 'JURÍDICA'));
SELECT * FROM MODULO_CLIENTES.PERSONA;

--CLIENTE
INSERT INTO MODULO_CLIENTES.CLIENTE (cod_persona)
VALUES 
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Pedro Carlos Vilchez Cardenas')),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Pedro Sebastian Nuñez Castillo')),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Gabriel Jose Martinez Arista')),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Marco Antonio Ramírez Mendoza')),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'María Fernanda Espinoza Castillo')),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'David Ricardo Fernández Vargas')),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Lucía Patricia Gutiérrez Cruz')),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Raúl Ernesto Ruíz Romero')),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Elena Soledad Gómez Silva')),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Luis Alberto Condori Martínez')),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Claudia Jimena Reyes Rivera')),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Diego Andrés Salazar Medina')),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Andrea Celeste Aguilar Morales')),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Julio César Paredes Castro')),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Valeria Isabel Córdova Acuña')),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Credicorp')),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Alicorp')),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Intercorp')),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Southern Peru Copper Corporation'));
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
('904 321 098',(SELECT cod_tipo_contacto FROM MODULO_CLIENTES.TIPO_CONTACTO WHERE valor_tipo_contacto = 'TELEFONO CELULAR')),
('gabriel.a@uno.pe',(SELECT cod_tipo_contacto FROM MODULO_CLIENTES.TIPO_CONTACTO WHERE valor_tipo_contacto = 'CORREO')),
('123 456 789',(SELECT cod_tipo_contacto FROM MODULO_CLIENTES.TIPO_CONTACTO WHERE valor_tipo_contacto = 'TELEFONO CELULAR')),
('987 654 322',(SELECT cod_tipo_contacto FROM MODULO_CLIENTES.TIPO_CONTACTO WHERE valor_tipo_contacto = 'TELEFONO CELULAR')),
('987 654 321',(SELECT cod_tipo_contacto FROM MODULO_CLIENTES.TIPO_CONTACTO WHERE valor_tipo_contacto = 'TELEFONO CELULAR')),
('999 888 777',(SELECT cod_tipo_contacto FROM MODULO_CLIENTES.TIPO_CONTACTO WHERE valor_tipo_contacto = 'TELEFONO CELULAR')),
('912 345 678',(SELECT cod_tipo_contacto FROM MODULO_CLIENTES.TIPO_CONTACTO WHERE valor_tipo_contacto = 'TELEFONO CELULAR')),
('954 321 098',(SELECT cod_tipo_contacto FROM MODULO_CLIENTES.TIPO_CONTACTO WHERE valor_tipo_contacto = 'TELEFONO CELULAR')),
('960 001 112',(SELECT cod_tipo_contacto FROM MODULO_CLIENTES.TIPO_CONTACTO WHERE valor_tipo_contacto = 'TELEFONO CELULAR')),
('945 612 378',(SELECT cod_tipo_contacto FROM MODULO_CLIENTES.TIPO_CONTACTO WHERE valor_tipo_contacto = 'TELEFONO CELULAR')),
('933 221 100',(SELECT cod_tipo_contacto FROM MODULO_CLIENTES.TIPO_CONTACTO WHERE valor_tipo_contacto = 'TELEFONO CELULAR')),
('971 721 731',(SELECT cod_tipo_contacto FROM MODULO_CLIENTES.TIPO_CONTACTO WHERE valor_tipo_contacto = 'TELEFONO CELULAR')),
('920 806 402',(SELECT cod_tipo_contacto FROM MODULO_CLIENTES.TIPO_CONTACTO WHERE valor_tipo_contacto = 'TELEFONO CELULAR')),
('982 555 111',(SELECT cod_tipo_contacto FROM MODULO_CLIENTES.TIPO_CONTACTO WHERE valor_tipo_contacto = 'TELEFONO CELULAR')),
('913 707 923',(SELECT cod_tipo_contacto FROM MODULO_CLIENTES.TIPO_CONTACTO WHERE valor_tipo_contacto = 'TELEFONO CELULAR')),
('955 888 222',(SELECT cod_tipo_contacto FROM MODULO_CLIENTES.TIPO_CONTACTO WHERE valor_tipo_contacto = 'TELEFONO CELULAR')),
('967 400 300',(SELECT cod_tipo_contacto FROM MODULO_CLIENTES.TIPO_CONTACTO WHERE valor_tipo_contacto = 'TELEFONO CELULAR')),
('932 605 981',(SELECT cod_tipo_contacto FROM MODULO_CLIENTES.TIPO_CONTACTO WHERE valor_tipo_contacto = 'TELEFONO CELULAR')),
('948 765 432',(SELECT cod_tipo_contacto FROM MODULO_CLIENTES.TIPO_CONTACTO WHERE valor_tipo_contacto = 'TELEFONO CELULAR')),
('977 111 222',(SELECT cod_tipo_contacto FROM MODULO_CLIENTES.TIPO_CONTACTO WHERE valor_tipo_contacto = 'TELEFONO CELULAR')),
('914 567 890',(SELECT cod_tipo_contacto FROM MODULO_CLIENTES.TIPO_CONTACTO WHERE valor_tipo_contacto = 'TELEFONO CELULAR')),
('980 706 504',(SELECT cod_tipo_contacto FROM MODULO_CLIENTES.TIPO_CONTACTO WHERE valor_tipo_contacto = 'TELEFONO CELULAR')),
('993 444 888',(SELECT cod_tipo_contacto FROM MODULO_CLIENTES.TIPO_CONTACTO WHERE valor_tipo_contacto = 'TELEFONO CELULAR')),
('929 191 292',(SELECT cod_tipo_contacto FROM MODULO_CLIENTES.TIPO_CONTACTO WHERE valor_tipo_contacto = 'TELEFONO CELULAR')),
('juan.flores@ejemplocorreo.com',(SELECT cod_tipo_contacto FROM MODULO_CLIENTES.TIPO_CONTACTO WHERE valor_tipo_contacto = 'CORREO')),
('anagrcia.rdgz@contactoempresa.pe',(SELECT cod_tipo_contacto FROM MODULO_CLIENTES.TIPO_CONTACTO WHERE valor_tipo_contacto = 'CORREO')),
('jtorresh@miproyecto.net',(SELECT cod_tipo_contacto FROM MODULO_CLIENTES.TIPO_CONTACTO WHERE valor_tipo_contacto = 'CORREO')),
('rrojvazquez@perumail.com',(SELECT cod_tipo_contacto FROM MODULO_CLIENTES.TIPO_CONTACTO WHERE valor_tipo_contacto = 'CORREO')),
('miguel.quispe@correoandino.pe',(SELECT cod_tipo_contacto FROM MODULO_CLIENTES.TIPO_CONTACTO WHERE valor_tipo_contacto = 'CORREO')),
('carmenlopez.r@ejemplosol.com',(SELECT cod_tipo_contacto FROM MODULO_CLIENTES.TIPO_CONTACTO WHERE valor_tipo_contacto = 'CORREO')),
('jorgeperez@servicio.com.pe',(SELECT cod_tipo_contacto FROM MODULO_CLIENTES.TIPO_CONTACTO WHERE valor_tipo_contacto = 'CORREO')),
('sofia.gonzalez.c@negociosperu.pe',(SELECT cod_tipo_contacto FROM MODULO_CLIENTES.TIPO_CONTACTO WHERE valor_tipo_contacto = 'CORREO')),
('marcoramirez.m@dominio.net',(SELECT cod_tipo_contacto FROM MODULO_CLIENTES.TIPO_CONTACTO WHERE valor_tipo_contacto = 'CORREO')),
('maria.castillo.e@correo.com',(SELECT cod_tipo_contacto FROM MODULO_CLIENTES.TIPO_CONTACTO WHERE valor_tipo_contacto = 'CORREO')),
('davidricardo.f@mailcorporativo.pe',(SELECT cod_tipo_contacto FROM MODULO_CLIENTES.TIPO_CONTACTO WHERE valor_tipo_contacto = 'CORREO')),
('luti.gutierrez@emailpersonal.com',(SELECT cod_tipo_contacto FROM MODULO_CLIENTES.TIPO_CONTACTO WHERE valor_tipo_contacto = 'CORREO')),
('raul.ruiz.r@elcorreo.pe',(SELECT cod_tipo_contacto FROM MODULO_CLIENTES.TIPO_CONTACTO WHERE valor_tipo_contacto = 'CORREO')),
('esole.gomez@miservicios.net',(SELECT cod_tipo_contacto FROM MODULO_CLIENTES.TIPO_CONTACTO WHERE valor_tipo_contacto = 'CORREO')),
('lualbertocondori@datacorp.com.pe',(SELECT cod_tipo_contacto FROM MODULO_CLIENTES.TIPO_CONTACTO WHERE valor_tipo_contacto = 'CORREO')),
('claudia.reyes@contacto.pe',(SELECT cod_tipo_contacto FROM MODULO_CLIENTES.TIPO_CONTACTO WHERE valor_tipo_contacto = 'CORREO')),
('diego.salazar.m@miemprendimiento.com',(SELECT cod_tipo_contacto FROM MODULO_CLIENTES.TIPO_CONTACTO WHERE valor_tipo_contacto = 'CORREO')),
('andreaceleste.a@mail.pe',(SELECT cod_tipo_contacto FROM MODULO_CLIENTES.TIPO_CONTACTO WHERE valor_tipo_contacto = 'CORREO')),
('juliocesar.p@servicioperu.com',(SELECT cod_tipo_contacto FROM MODULO_CLIENTES.TIPO_CONTACTO WHERE valor_tipo_contacto = 'CORREO')),
('valeria.cordova@ejemplo.pe',(SELECT cod_tipo_contacto FROM MODULO_CLIENTES.TIPO_CONTACTO WHERE valor_tipo_contacto = 'CORREO'));
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
INSERT INTO MODULO_CLIENTES.DOCUMENTO_PERSONA (valor_documento, cod_persona, cod_tipo_documento)
VALUES 
('10 12345678 8',(SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Pedro Carlos Vilchez Cardenas'),(SELECT cod_tipo_documento FROM MODULO_CLIENTES.TIPO_DOCUMENTO WHERE valor_tipo_documento = 'RUC')),
('7899 4567',(SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Gabriel Jose Martinez Arista'),(SELECT cod_tipo_documento FROM MODULO_CLIENTES.TIPO_DOCUMENTO WHERE valor_tipo_documento = 'DNI')),
('40876543',(SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Juan Carlos Flores Sánchez'),(SELECT cod_tipo_documento FROM MODULO_CLIENTES.TIPO_DOCUMENTO WHERE valor_tipo_documento = 'DNI')),
('78901234',(SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Ana María García Rodríguez'),(SELECT cod_tipo_documento FROM MODULO_CLIENTES.TIPO_DOCUMENTO WHERE valor_tipo_documento = 'DNI')),
('8123456',(SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'José Luis Torres Huamán'),(SELECT cod_tipo_documento FROM MODULO_CLIENTES.TIPO_DOCUMENTO WHERE valor_tipo_documento = 'DNI')),
('60987654',(SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Rosa Elena Rojas Vásquez'),(SELECT cod_tipo_documento FROM MODULO_CLIENTES.TIPO_DOCUMENTO WHERE valor_tipo_documento = 'DNI')),
('45678901',(SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Miguel Ángel Quispe Mamani'),(SELECT cod_tipo_documento FROM MODULO_CLIENTES.TIPO_DOCUMENTO WHERE valor_tipo_documento = 'DNI')),
('11223344',(SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Carmen Victoria López Ramos'),(SELECT cod_tipo_documento FROM MODULO_CLIENTES.TIPO_DOCUMENTO WHERE valor_tipo_documento = 'DNI')),
('55667788',(SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Jorge Luis Pérez Díaz'),(SELECT cod_tipo_documento FROM MODULO_CLIENTES.TIPO_DOCUMENTO WHERE valor_tipo_documento = 'DNI')),
('32109876',(SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Sofía Alejandra Gonzáles Chávez'),(SELECT cod_tipo_documento FROM MODULO_CLIENTES.TIPO_DOCUMENTO WHERE valor_tipo_documento = 'DNI')),
('80706050',(SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Marco Antonio Ramírez Mendoza'),(SELECT cod_tipo_documento FROM MODULO_CLIENTES.TIPO_DOCUMENTO WHERE valor_tipo_documento = 'DNI')),
('19283746',(SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'María Fernanda Espinoza Castillo'),(SELECT cod_tipo_documento FROM MODULO_CLIENTES.TIPO_DOCUMENTO WHERE valor_tipo_documento = 'DNI')),
('1234 5678',(SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Pedro Sebastian Nuñez Castillo'),(SELECT cod_tipo_documento FROM MODULO_CLIENTES.TIPO_DOCUMENTO WHERE valor_tipo_documento = 'DNI')),
('10456789012',(SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'David Ricardo Fernández Vargas'),(SELECT cod_tipo_documento FROM MODULO_CLIENTES.TIPO_DOCUMENTO WHERE valor_tipo_documento = 'RUC')),
('10987654321',(SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Lucía Patricia Gutiérrez Cruz'),(SELECT cod_tipo_documento FROM MODULO_CLIENTES.TIPO_DOCUMENTO WHERE valor_tipo_documento = 'RUC')),
('10112233445',(SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Raúl Ernesto Ruíz Romero'),(SELECT cod_tipo_documento FROM MODULO_CLIENTES.TIPO_DOCUMENTO WHERE valor_tipo_documento = 'RUC')),
('10765432109',(SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Elena Soledad Gómez Silva'),(SELECT cod_tipo_documento FROM MODULO_CLIENTES.TIPO_DOCUMENTO WHERE valor_tipo_documento = 'RUC')),
('10010010019',(SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Luis Alberto Condori Martínez'),(SELECT cod_tipo_documento FROM MODULO_CLIENTES.TIPO_DOCUMENTO WHERE valor_tipo_documento = 'RUC')),
('10334455667',(SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Claudia Jimena Reyes Rivera'),(SELECT cod_tipo_documento FROM MODULO_CLIENTES.TIPO_DOCUMENTO WHERE valor_tipo_documento = 'RUC')),
('10998877665',(SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Diego Andrés Salazar Medina'),(SELECT cod_tipo_documento FROM MODULO_CLIENTES.TIPO_DOCUMENTO WHERE valor_tipo_documento = 'RUC')),
('10223344556',(SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Andrea Celeste Aguilar Morales'),(SELECT cod_tipo_documento FROM MODULO_CLIENTES.TIPO_DOCUMENTO WHERE valor_tipo_documento = 'RUC')),
('10405060708',(SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Julio César Paredes Castro'),(SELECT cod_tipo_documento FROM MODULO_CLIENTES.TIPO_DOCUMENTO WHERE valor_tipo_documento = 'RUC')),
('10302040608',(SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Valeria Isabel Córdova Acuña'),(SELECT cod_tipo_documento FROM MODULO_CLIENTES.TIPO_DOCUMENTO WHERE valor_tipo_documento = 'RUC')),
('20567890123',(SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Credicorp'),(SELECT cod_tipo_documento FROM MODULO_CLIENTES.TIPO_DOCUMENTO WHERE valor_tipo_documento = 'RUC')),
('20123456789',(SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Alicorp'),(SELECT cod_tipo_documento FROM MODULO_CLIENTES.TIPO_DOCUMENTO WHERE valor_tipo_documento = 'RUC')),
('20001002003',(SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Intercorp'),(SELECT cod_tipo_documento FROM MODULO_CLIENTES.TIPO_DOCUMENTO WHERE valor_tipo_documento = 'RUC')),
('20998877665',(SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Southern Peru Copper Corporation'),(SELECT cod_tipo_documento FROM MODULO_CLIENTES.TIPO_DOCUMENTO WHERE valor_tipo_documento = 'RUC'));
SELECT * FROM MODULO_CLIENTES.DOCUMENTO_PERSONA;

--DIRECCION_PERSONA
INSERT INTO MODULO_CLIENTES.DIRECCION_PERSONA (cod_persona, cod_direccion)
VALUES 
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Pedro Carlos Vilchez Cardenas'),(SELECT cod_direccion FROM MODULO_CLIENTES.DIRECCION D WHERE (ciudad, distrito, via, numero) = ('Lima', 'Barranco', 'Jirón 28 de Julio', '123'))),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Gabriel Jose Martinez Arista'),(SELECT cod_direccion FROM MODULO_CLIENTES.DIRECCION D WHERE (ciudad, distrito, via, numero) = ('Lima', 'Barranco', 'Jiron 28 de julio', '123'))),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Juan Carlos Flores Sánchez'),(SELECT cod_direccion FROM MODULO_CLIENTES.DIRECCION D WHERE (ciudad, distrito, via, numero) =('Lima', 'Santa Anita', 'Avenida Moro solar', '455') )),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Ana María García Rodríguez'),(SELECT cod_direccion FROM MODULO_CLIENTES.DIRECCION D WHERE (ciudad, distrito, via, numero) =('Lima', 'Miraflores', 'Av. Larco', '1010') )),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'José Luis Torres Huamán'),(SELECT cod_direccion FROM MODULO_CLIENTES.DIRECCION D WHERE (ciudad, distrito, via, numero) =('Lima', 'Santiago de Surco', 'Jr. Monte Rosa', '250 - Of. 301') )),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Rosa Elena Rojas Vásquez'),(SELECT cod_direccion FROM MODULO_CLIENTES.DIRECCION D WHERE (ciudad, distrito, via, numero) =('Lima', 'San Isidro', 'Calle Las Camelias', '790') )),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Miguel Ángel Quispe Mamani'),(SELECT cod_direccion FROM MODULO_CLIENTES.DIRECCION D WHERE (ciudad, distrito, via, numero) =('Lima', 'La Molina', 'Av. Raúl Ferrero', '1200') )),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Carmen Victoria López Ramos'),(SELECT cod_direccion FROM MODULO_CLIENTES.DIRECCION D WHERE (ciudad, distrito, via, numero) =('Lima', 'Barranco', 'Pje. Sáenz Peña', '190') )),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Jorge Luis Pérez Díaz'),(SELECT cod_direccion FROM MODULO_CLIENTES.DIRECCION D WHERE (ciudad, distrito, via, numero) =('Arequipa', 'Cercado', 'Calle San Agustín', '305') )),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Sofía Alejandra Gonzáles Chávez'),(SELECT cod_direccion FROM MODULO_CLIENTES.DIRECCION D WHERE (ciudad, distrito, via, numero) =('Arequipa', 'Yanahuara', 'Av. Ejército', '810') )),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Marco Antonio Ramírez Mendoza'),(SELECT cod_direccion FROM MODULO_CLIENTES.DIRECCION D WHERE (ciudad, distrito, via, numero) =('Cusco', 'Cusco', 'Av. El Sol', '920') )),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'María Fernanda Espinoza Castillo'),(SELECT cod_direccion FROM MODULO_CLIENTES.DIRECCION D WHERE (ciudad, distrito, via, numero) =('Cusco', 'Wanchaq', 'Calle Túpac Amaru', 'Lote 15') )),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'David Ricardo Fernández Vargas'),(SELECT cod_direccion FROM MODULO_CLIENTES.DIRECCION D WHERE (ciudad, distrito, via, numero) =('Trujillo', 'Trujillo', 'Av. España', '2405') )),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Lucía Patricia Gutiérrez Cruz'),(SELECT cod_direccion FROM MODULO_CLIENTES.DIRECCION D WHERE (ciudad, distrito, via, numero) =('Trujillo', 'Víctor Larco Herrera', 'Jr. Ayacucho', '580') )),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Raúl Ernesto Ruíz Romero'),(SELECT cod_direccion FROM MODULO_CLIENTES.DIRECCION D WHERE (ciudad, distrito, via, numero) =('Piura', 'Piura', 'Calle Lima', '555') )),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Elena Soledad Gómez Silva'),(SELECT cod_direccion FROM MODULO_CLIENTES.DIRECCION D WHERE (ciudad, distrito, via, numero) =('Piura', 'Castilla', 'Av. Ramón Castilla', 'Mz. G, Lt. 2') )),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Luis Alberto Condori Martínez'),(SELECT cod_direccion FROM MODULO_CLIENTES.DIRECCION D WHERE (ciudad, distrito, via, numero) =('Chiclayo', 'Chiclayo', 'Calle Lora y Lora', '412') )),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Claudia Jimena Reyes Rivera'),(SELECT cod_direccion FROM MODULO_CLIENTES.DIRECCION D WHERE (ciudad, distrito, via, numero) =('Chiclayo', 'La Victoria', 'Av. Los Incas', '1850') )),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Diego Andrés Salazar Medina'),(SELECT cod_direccion FROM MODULO_CLIENTES.DIRECCION D WHERE (ciudad, distrito, via, numero) =('Iquitos', 'Iquitos', 'Av. Mariscal Cáceres', '110') )),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Andrea Celeste Aguilar Morales'),(SELECT cod_direccion FROM MODULO_CLIENTES.DIRECCION D WHERE (ciudad, distrito, via, numero) =('Iquitos', 'San Juan Bautista', 'Jr. Putumayo', 'S/N (Km 4.5)') )),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Julio César Paredes Castro'),(SELECT cod_direccion FROM MODULO_CLIENTES.DIRECCION D WHERE (ciudad, distrito, via, numero) =('Huancayo', 'El Tambo', 'Jr. Puno', '701') )),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Valeria Isabel Córdova Acuña'),(SELECT cod_direccion FROM MODULO_CLIENTES.DIRECCION D WHERE (ciudad, distrito, via, numero) =('Huancayo', 'Huancayo', 'Av. Giráldez', '330') )),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Credicorp'),(SELECT cod_direccion FROM MODULO_CLIENTES.DIRECCION D WHERE (ciudad, distrito, via, numero) =('Puno', 'Puno', 'Jr. Lima', '445') )),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Alicorp'),(SELECT cod_direccion FROM MODULO_CLIENTES.DIRECCION D WHERE (ciudad, distrito, via, numero) =('Puno', 'Juliaca', 'Jr. Mariano Melgar', '120 - Urb. Pumas') )),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Intercorp'),(SELECT cod_direccion FROM MODULO_CLIENTES.DIRECCION D WHERE (ciudad, distrito, via, numero) =('Tacna', 'Tacna', 'Calle Blondell', '150') )),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Southern Peru Copper Corporation'),(SELECT cod_direccion FROM MODULO_CLIENTES.DIRECCION D WHERE (ciudad, distrito, via, numero) =('Tacna', 'Gregorio Albarracín', 'Av. La Cultura', '902') )),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Pedro Sebastian Nuñez Castillo'),(SELECT cod_direccion FROM MODULO_CLIENTES.DIRECCION D WHERE (ciudad, distrito, via, numero) = ('Lima', 'Ate', 'Avenida Hermes', '256')));
SELECT * FROM MODULO_CLIENTES.DIRECCION_PERSONA;

--CONTACTO_PERSONA
INSERT INTO MODULO_CLIENTES.CONTACTO_PERSONA (cod_persona, cod_contacto)
VALUES 
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Gabriel Jose Martinez Arista'),(SELECT cod_contacto FROM MODULO_CLIENTES.CONTACTO C WHERE C.VALOR_CONTACTO = 'gabriel.a@uno.pe')),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Gabriel Jose Martinez Arista'),(SELECT cod_contacto FROM MODULO_CLIENTES.CONTACTO C WHERE C.VALOR_CONTACTO = '123 456 789')),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Pedro Sebastian Nuñez Castillo'),(SELECT cod_contacto FROM MODULO_CLIENTES.CONTACTO C WHERE C.VALOR_CONTACTO = '987 654 321')),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Pedro Carlos Vilchez Cardenas'),(SELECT cod_contacto FROM MODULO_CLIENTES.CONTACTO C WHERE C.VALOR_CONTACTO = '904 321 098')),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Juan Carlos Flores Sánchez'),(SELECT cod_contacto FROM MODULO_CLIENTES.CONTACTO C WHERE C.VALOR_CONTACTO = '987 654 321')),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Ana María García Rodríguez'),(SELECT cod_contacto FROM MODULO_CLIENTES.CONTACTO C WHERE C.VALOR_CONTACTO = '999 888 777')),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'José Luis Torres Huamán'),(SELECT cod_contacto FROM MODULO_CLIENTES.CONTACTO C WHERE C.VALOR_CONTACTO = '912 345 678')),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Rosa Elena Rojas Vásquez'),(SELECT cod_contacto FROM MODULO_CLIENTES.CONTACTO C WHERE C.VALOR_CONTACTO = '954 321 098')),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Miguel Ángel Quispe Mamani'),(SELECT cod_contacto FROM MODULO_CLIENTES.CONTACTO C WHERE C.VALOR_CONTACTO = '960 001 112')),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Carmen Victoria López Ramos'),(SELECT cod_contacto FROM MODULO_CLIENTES.CONTACTO C WHERE C.VALOR_CONTACTO = '945 612 378')),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Jorge Luis Pérez Díaz'),(SELECT cod_contacto FROM MODULO_CLIENTES.CONTACTO C WHERE C.VALOR_CONTACTO = '933 221 100')),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Sofía Alejandra Gonzáles Chávez'),(SELECT cod_contacto FROM MODULO_CLIENTES.CONTACTO C WHERE C.VALOR_CONTACTO = '971 721 731')),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Marco Antonio Ramírez Mendoza'),(SELECT cod_contacto FROM MODULO_CLIENTES.CONTACTO C WHERE C.VALOR_CONTACTO = '920 806 402')),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'María Fernanda Espinoza Castillo'),(SELECT cod_contacto FROM MODULO_CLIENTES.CONTACTO C WHERE C.VALOR_CONTACTO = '982 555 111')),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'David Ricardo Fernández Vargas'),(SELECT cod_contacto FROM MODULO_CLIENTES.CONTACTO C WHERE C.VALOR_CONTACTO = '913 707 923')),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Lucía Patricia Gutiérrez Cruz'),(SELECT cod_contacto FROM MODULO_CLIENTES.CONTACTO C WHERE C.VALOR_CONTACTO = '955 888 222')),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Raúl Ernesto Ruíz Romero'),(SELECT cod_contacto FROM MODULO_CLIENTES.CONTACTO C WHERE C.VALOR_CONTACTO = '967 400 300')),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Elena Soledad Gómez Silva'),(SELECT cod_contacto FROM MODULO_CLIENTES.CONTACTO C WHERE C.VALOR_CONTACTO = '932 605 981')),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Luis Alberto Condori Martínez'),(SELECT cod_contacto FROM MODULO_CLIENTES.CONTACTO C WHERE C.VALOR_CONTACTO = '948 765 432')),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Claudia Jimena Reyes Rivera'),(SELECT cod_contacto FROM MODULO_CLIENTES.CONTACTO C WHERE C.VALOR_CONTACTO = '977 111 222')),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Diego Andrés Salazar Medina'),(SELECT cod_contacto FROM MODULO_CLIENTES.CONTACTO C WHERE C.VALOR_CONTACTO = '914 567 890')),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Andrea Celeste Aguilar Morales'),(SELECT cod_contacto FROM MODULO_CLIENTES.CONTACTO C WHERE C.VALOR_CONTACTO = '980 706 504')),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Julio César Paredes Castro'),(SELECT cod_contacto FROM MODULO_CLIENTES.CONTACTO C WHERE C.VALOR_CONTACTO = '993 444 888')),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Valeria Isabel Córdova Acuña'),(SELECT cod_contacto FROM MODULO_CLIENTES.CONTACTO C WHERE C.VALOR_CONTACTO = '929 191 292')),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Juan Carlos Flores Sánchez'),(SELECT cod_contacto FROM MODULO_CLIENTES.CONTACTO C WHERE C.VALOR_CONTACTO = 'juan.flores@ejemplocorreo.com')),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Juan Carlos Flores Sánchez'),(SELECT cod_contacto FROM MODULO_CLIENTES.CONTACTO C WHERE C.VALOR_CONTACTO = 'anagrcia.rdgz@contactoempresa.pe')),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Juan Carlos Flores Sánchez'),(SELECT cod_contacto FROM MODULO_CLIENTES.CONTACTO C WHERE C.VALOR_CONTACTO = 'jtorresh@miproyecto.net')),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Juan Carlos Flores Sánchez'),(SELECT cod_contacto FROM MODULO_CLIENTES.CONTACTO C WHERE C.VALOR_CONTACTO = 'rrojvazquez@perumail.com')),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Juan Carlos Flores Sánchez'),(SELECT cod_contacto FROM MODULO_CLIENTES.CONTACTO C WHERE C.VALOR_CONTACTO = 'miguel.quispe@correoandino.pe')),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Juan Carlos Flores Sánchez'),(SELECT cod_contacto FROM MODULO_CLIENTES.CONTACTO C WHERE C.VALOR_CONTACTO = 'carmenlopez.r@ejemplosol.com')),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Juan Carlos Flores Sánchez'),(SELECT cod_contacto FROM MODULO_CLIENTES.CONTACTO C WHERE C.VALOR_CONTACTO = 'jorgeperez@servicio.com.pe')),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Juan Carlos Flores Sánchez'),(SELECT cod_contacto FROM MODULO_CLIENTES.CONTACTO C WHERE C.VALOR_CONTACTO = 'sofia.gonzalez.c@negociosperu.pe')),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Juan Carlos Flores Sánchez'),(SELECT cod_contacto FROM MODULO_CLIENTES.CONTACTO C WHERE C.VALOR_CONTACTO = 'marcoramirez.m@dominio.net')),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Juan Carlos Flores Sánchez'),(SELECT cod_contacto FROM MODULO_CLIENTES.CONTACTO C WHERE C.VALOR_CONTACTO = 'maria.castillo.e@correo.com')),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Juan Carlos Flores Sánchez'),(SELECT cod_contacto FROM MODULO_CLIENTES.CONTACTO C WHERE C.VALOR_CONTACTO = 'davidricardo.f@mailcorporativo.pe')),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Juan Carlos Flores Sánchez'),(SELECT cod_contacto FROM MODULO_CLIENTES.CONTACTO C WHERE C.VALOR_CONTACTO = 'luti.gutierrez@emailpersonal.com')),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Juan Carlos Flores Sánchez'),(SELECT cod_contacto FROM MODULO_CLIENTES.CONTACTO C WHERE C.VALOR_CONTACTO = 'raul.ruiz.r@elcorreo.pe')),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Juan Carlos Flores Sánchez'),(SELECT cod_contacto FROM MODULO_CLIENTES.CONTACTO C WHERE C.VALOR_CONTACTO = 'esole.gomez@miservicios.net')),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Juan Carlos Flores Sánchez'),(SELECT cod_contacto FROM MODULO_CLIENTES.CONTACTO C WHERE C.VALOR_CONTACTO = 'lualbertocondori@datacorp.com.pe')),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Juan Carlos Flores Sánchez'),(SELECT cod_contacto FROM MODULO_CLIENTES.CONTACTO C WHERE C.VALOR_CONTACTO = 'claudia.reyes@contacto.pe')),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Juan Carlos Flores Sánchez'),(SELECT cod_contacto FROM MODULO_CLIENTES.CONTACTO C WHERE C.VALOR_CONTACTO = 'diego.salazar.m@miemprendimiento.com')),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Juan Carlos Flores Sánchez'),(SELECT cod_contacto FROM MODULO_CLIENTES.CONTACTO C WHERE C.VALOR_CONTACTO = 'andreaceleste.a@mail.pe')),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Juan Carlos Flores Sánchez'),(SELECT cod_contacto FROM MODULO_CLIENTES.CONTACTO C WHERE C.VALOR_CONTACTO = 'juliocesar.p@servicioperu.com')),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Juan Carlos Flores Sánchez'),(SELECT cod_contacto FROM MODULO_CLIENTES.CONTACTO C WHERE C.VALOR_CONTACTO = 'valeria.cordova@ejemplo.pe'));
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
('10456789012', (SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'David Ricardo Fernández Vargas'), (SELECT cod_cliente FROM MODULO_CLIENTES.CLIENTE C  WHERE cod_persona = (SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'David Ricardo Fernández Vargas')), 
(SELECT cod_especialidad FROM MODULO_CLIENTES.ESPECIALIDADES E  WHERE valor_especialidad = 'Cimentación')),
('10987654321', (SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Lucía Patricia Gutiérrez Cruz'), (SELECT cod_cliente FROM MODULO_CLIENTES.CLIENTE C  WHERE cod_persona = (SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Lucía Patricia Gutiérrez Cruz')), 
(SELECT cod_especialidad FROM MODULO_CLIENTES.ESPECIALIDADES E  WHERE valor_especialidad = 'Plomería')),
('10112233445', (SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Raúl Ernesto Ruíz Romero'), (SELECT cod_cliente FROM MODULO_CLIENTES.CLIENTE C  WHERE cod_persona = (SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Raúl Ernesto Ruíz Romero')), 
(SELECT cod_especialidad FROM MODULO_CLIENTES.ESPECIALIDADES E  WHERE valor_especialidad = 'Drywall')),
('10765432109', (SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Elena Soledad Gómez Silva'), (SELECT cod_cliente FROM MODULO_CLIENTES.CLIENTE C  WHERE cod_persona = (SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Elena Soledad Gómez Silva')), 
(SELECT cod_especialidad FROM MODULO_CLIENTES.ESPECIALIDADES E  WHERE valor_especialidad = 'Pintura')),
('10010010019', (SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Luis Alberto Condori Martínez'), (SELECT cod_cliente FROM MODULO_CLIENTES.CLIENTE C  WHERE cod_persona = (SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Luis Alberto Condori Martínez')), 
(SELECT cod_especialidad FROM MODULO_CLIENTES.ESPECIALIDADES E  WHERE valor_especialidad = 'Demolición')),
('10 12345678 8', 
(SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Pedro Carlos Vilchez Cardenas'), 
(SELECT cod_cliente FROM MODULO_CLIENTES.CLIENTE C  WHERE cod_persona = (SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Pedro Carlos Vilchez Cardenas')), 
(SELECT cod_especialidad FROM MODULO_CLIENTES.ESPECIALIDADES E  WHERE valor_especialidad = 'Gasfiteria'));
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
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA P  WHERE nombre_persona = 'Juan Carlos Flores Sánchez'),(SELECT cod_rol FROM MODULO_CLIENTES.ROL TU  WHERE valor_rol = 'Almacen'),(SELECT cod_area FROM MODULO_CLIENTES.AREA A  WHERE valor_area = 'Almacen')),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA P  WHERE nombre_persona = 'Ana María García Rodríguez'),(SELECT cod_rol FROM MODULO_CLIENTES.ROL TU  WHERE valor_rol = 'Vendedor'),(SELECT cod_area FROM MODULO_CLIENTES.AREA A  WHERE valor_area = 'Ventas')),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA P  WHERE nombre_persona = 'José Luis Torres Huamán'),(SELECT cod_rol FROM MODULO_CLIENTES.ROL TU  WHERE valor_rol = 'CRM'),(SELECT cod_area FROM MODULO_CLIENTES.AREA A  WHERE valor_area = 'Marketing')),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA P  WHERE nombre_persona = 'Rosa Elena Rojas Vásquez'),(SELECT cod_rol FROM MODULO_CLIENTES.ROL TU  WHERE valor_rol = 'Transportista'),(SELECT cod_area FROM MODULO_CLIENTES.AREA A  WHERE valor_area = 'Abastecimiento')),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA P  WHERE nombre_persona = 'Miguel Ángel Quispe Mamani'),(SELECT cod_rol FROM MODULO_CLIENTES.ROL TU  WHERE valor_rol = 'Transportista'),(SELECT cod_area FROM MODULO_CLIENTES.AREA A  WHERE valor_area = 'Almacen')),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA P  WHERE nombre_persona = 'Carmen Victoria López Ramos'),(SELECT cod_rol FROM MODULO_CLIENTES.ROL TU  WHERE valor_rol = 'Vendedor'),(SELECT cod_area FROM MODULO_CLIENTES.AREA A  WHERE valor_area = 'Ventas')),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA P  WHERE nombre_persona = 'Jorge Luis Pérez Díaz'),(SELECT cod_rol FROM MODULO_CLIENTES.ROL TU  WHERE valor_rol = 'Gerente'),(SELECT cod_area FROM MODULO_CLIENTES.AREA A  WHERE valor_area = 'Marketing')),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA P  WHERE nombre_persona = 'Sofía Alejandra Gonzáles Chávez'),(SELECT cod_rol FROM MODULO_CLIENTES.ROL TU  WHERE valor_rol = 'Transportista'),(SELECT cod_area FROM MODULO_CLIENTES.AREA A  WHERE valor_area = 'Abastecimiento')),
((SELECT cod_persona FROM MODULO_CLIENTES.PERSONA P  WHERE nombre_persona = 'Gabriel Jose Martinez Arista'),(SELECT cod_rol FROM MODULO_CLIENTES.ROL TU  WHERE valor_rol = 'ADMIN (⌐■_■)'),(SELECT cod_area FROM MODULO_CLIENTES.AREA A  WHERE valor_area = 'SISTEMAS (⌐■_■)'));
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
(30,
(SELECT cod_usuario FROM MODULO_CLIENTES.USUARIO WHERE cod_persona = (SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Gabriel Jose Martinez Arista')),
(SELECT cod_estado_canje FROM MODULO_CLIENTES.ESTADO_CANJE WHERE valor_estado_canje = 'Pendiente'),
(SELECT cod_maestro FROM MODULO_CLIENTES.MAESTRO  WHERE cod_persona = (SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Pedro Carlos Vilchez Cardenas'))
);
SELECT * FROM MODULO_CLIENTES.CANJE;

--PREMIOS
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
),
('Audífonos Inalámbricos Bluetooth JBL Tune 510BT', 
    $$ Descripción: Audífonos inalámbricos con tecnología JBL Pure Bass. conexión Bluetooth 5.0. hasta 40 horas de batería y carga rápida. Color Negro. Incluye cable USB-C de carga. Ideal para uso diario y deporte. $$,
    15.50, 
    120 
),
('Set de Cuchillos de Chef 5 Piezas Acero Inoxidable', 
    $$ Set de 5 cuchillos profesionales para cocina con base de madera. Material de la hoja: Acero inoxidable de alta calidad. Incluye cuchillo de chef. santoku. pan. utilitario y pelador. Mango ergonómico. $$,
    8.90, 
    200 
),
('Power Bank Xiaomi 10000mAh Carga Rápida', 
    $$ Batería externa portátil de 10000 mAh. Conexión dual USB (Tipo A y Tipo C). Soporta carga rápida de 18W. Diseño compacto y ligero. ideal para viajes. Color: Blanco. $$,
    12.00, 
    80 
),
('Licuadora Oster Xpert Series con Motor Reversible', 
    $$ Electrodoméstico: Licuadora de alto rendimiento. Motor de 2 caballos de fuerza con tecnología reversible para mezclar y procesar. Vaso de vidrio refractario Boroclass de 2 Litros. 3 programas automáticos. $$,
    45.99, 
    35 
),
('Google Chromecast con Google TV (HD)', 
    $$ Dispositivo de streaming multimedia. Transforma cualquier TV con puerto HDMI en Smart TV. Incluye control remoto por voz. Resolución máxima: HD 1080p. Conectividad Wi-Fi dual band. $$,
    18.50, 
    95 
),
('Mochila Antirrobo para Laptop 15.6" con Puerto USB', 
    $$ Accesorio de viaje y seguridad. Material resistente al corte y al agua. Capacidad de 20 Litros. Compartimento acolchado para laptop de 15.6 pulgadas. Puerto de carga USB externo (requiere power bank no incluido). $$,
    10.50, 
    150
),
('Reloj Inteligente (Smartwatch) Deportivo con GPS', 
    $$ Tecnología wearable. Funciones: Medición de ritmo cardíaco + monitor de sueño + contador de pasos + GPS integrado para seguimiento de rutas. Compatible con Android e iOS. Resistencia al agua IP68. $$,
    28.00, 
    60 
),
('Cafetera Eléctrica de Goteo para 12 Tazas', 
    $$ Electrodoméstico básico. Capacidad para 1.5 litros (12 tazas). Sistema anti-goteo. Filtro permanente lavable. Placa calefactora que mantiene el café caliente. Color: Negro. $$,
    7.50, 
    180 
),
('Kit de Limpieza para PC y Electrónicos 6 en 1', 
    $$ Kit que incluye: cepillo antiestático + paños de microfibra + soplador de aire + líquido limpiador + hisopos y extractor de teclas. Ideal para teclados + pantallas y lentes. $$,
    4.00, 
    250 
),
('Disco Duro Externo Portátil 1TB USB 3.0', 
    $$ Almacenamiento digital. Capacidad: 1 Terabyte. Interfaz: USB 3.0 (compatible con 2.0). Velocidad de transferencia rápida. Compatible con Windows y Mac. Carcasa resistente a golpes leves. $$,
    35.00, 
    40 
);
SELECT * FROM MODULO_CLIENTES.PREMIOS;

--DETALLE_CANJE
INSERT INTO MODULO_CLIENTES.DETALLE_CANJE (cantidad_premio, cod_canje, cod_premio)
VALUES 
(1,
(SELECT cod_canje FROM MODULO_CLIENTES.CANJE WHERE cod_maestro = (SELECT cod_maestro FROM MODULO_CLIENTES.MAESTRO  WHERE cod_persona = (SELECT cod_persona FROM MODULO_CLIENTES.PERSONA WHERE nombre_persona = 'Pedro Carlos Vilchez Cardenas'))),
(SELECT cod_premio FROM MODULO_CLIENTES.PREMIOS WHERE nombre_premio = 'Taladro Inalámbrico 12V + Batería SCD121S1-B2 + Set 27 pz')
);
SELECT * FROM MODULO_CLIENTES.DETALLE_CANJE;

--CATEGORIAS_PREMIO
INSERT INTO MODULO_CLIENTES.CATEGORIAS_PREMIO (cod_categoria, cod_premio)
VALUES 
((SELECT cod_categoria FROM MODULO_CLIENTES.CATEGORIA WHERE valor_categoria = 'Herramienta'),(SELECT cod_premio FROM MODULO_CLIENTES.PREMIOS WHERE nombre_premio = 'Taladro Inalámbrico 12V + Batería SCD121S1-B2 + Set 27 pz'));
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




