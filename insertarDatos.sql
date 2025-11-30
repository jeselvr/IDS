USE [EMPRESA_UNI]
GO

-- 1. Insertar datos en centroTrabajo
INSERT INTO centroTrabajo (noCentro, nombreCentro, ciudad) VALUES
('000201', 'Tiendas Ángel Flores Ropa', 'Culiacán'),
('000202', 'Tiendas Ángel Flores Muebles', 'Culiacán'),
('000203', 'Tiendas Ángel Flores Cajas', 'Culiacán'),
('049001', 'La Primavera Ropa', 'Culiacán'),
('049002', 'La Primavera Muebles', 'Culiacán'),
('049003', 'La Primavera Cajas', 'Culiacán');
GO

-- 2. Insertar datos en puestos
INSERT INTO puestos (noPuestos, puesto, descripcion) VALUES
(100, 'Vendedor', 'Atiende al público y gestiona inventario.'),
(200, 'Gerente', 'Supervisa operaciones y personal de la sucursal.'),
(300, 'Líder Técnico', 'Da seguimiento a su célula, verificando que se realicen las actividad y atendiendo dudas.'),
(400, 'UX/UI', 'Realiza las interfaces web y de aplicaciones que verán los usuarios.'),
(500, 'Programador', 'Desarrolla código de los sistemas solicitados o requeridos por la empresa.');
GO

-- 3. Insertar datos en Empleado
INSERT INTO Empleado (nombre, apellidoP, apellidoM, fechaNacimiento, RFC, centroTrabajo, puesto, descripcionPuesto, directivo) VALUES
('Jesus', 'Vega', 'Castro', '1988-03-26', 'VECJ880326XXX', '000201', 'Vendedor', 'Atiende al público', 0),
('Tomás Alonso', 'Contreras', 'Lafarga', '1980-01-01', 'COLT800101XXX', '049003', 'Gerente', 'Supervisa tiendas', 1),
('Carlos Fernando', 'Rico', 'Girón', '1988-03-26', 'RIGC880326XXX', '049003', 'Líder Técnico', 'Da seguimiento', 1),
('Zuli', 'Galindo', 'Estupinan', '1988-03-26', 'GAEZ880326XXX', '049003', 'UX/UI', 'Realiza interfaces', 1),
('Jesel', 'Valle', 'Rivera', '1988-03-26', 'VARJ880326XXX', '049003', 'Programador', 'Desarrolla código', 0);
GO

-- 4. Insertar datos en Directivos

ALTER TABLE Directivos
ALTER COLUMN numeroCentroSupervisa VARCHAR(6) NULL; --- para cambiar el tipo de dato
GO

PRINT 'Columna numeroCentroSupervisa modificada a VARCHAR(6).'
GO

TRUNCATE TABLE Directivos; --- para eliminar datos si ya se habían ingresado
GO

INSERT INTO Directivos (noEmpleado, numeroCentroSupervisa, prestaciones) VALUES
(1, '000201', 1),
(2, '049002', 1),
(3, '049003', 1),
(4, '049001', 1),
(5, '049003', 1);
GO

PRINT 'Datos de catálogo y ejemplo insertados exitosamente.'