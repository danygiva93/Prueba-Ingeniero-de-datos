CREATE TABLE `TBL_CLIENTES` (
    `NOMBRE`	VARCHAR(512),
    `IDENTIFICACION`	VARCHAR(512),
    `TIPO_DOCUMENTO`	VARCHAR(512),
    `CLASIFICACION`	VARCHAR(512),
    `TIPO TARJETA`	VARCHAR(512),
    `FEÇHA_APERTURA_TARJETA`	VARCHAR(512),
    `ESTADO_TARJETA`	VARCHAR(512)
);

INSERT INTO `TBL_CLIENTES` (`NOMBRE`, `IDENTIFICACION`, `TIPO_DOCUMENTO`, `CLASIFICACION`, `TIPO TARJETA`, `FEÇHA_APERTURA_TARJETA`, `ESTADO_TARJETA`) VALUES
	('Juan Pérez', '2C3D4E5F6G7H8I9J0', 'DNI', 'Personal', 'Crédito', '1/15/23', 'Activa'),
	('María García', '2M3N4O5P6Q7R8S9T0', 'Pasaporte', 'Empresarial', 'Débito', '11/20/22', 'Activa'),
	('Carlos Rodríguez', '2W3X4Y5Z6A7B8C9D0', 'DNI', 'Personal', 'Crédito', '5/30/21', 'Inactiva'),
	('Ana Martínez', '2G3H4I5J6K7L8M9N0', 'Cédula', 'Empresarial', 'Débito', '8/25/20', 'Activa'),
	('Luis Hernández', '2Q3R4S5T6U7V8W9X0', 'Pasaporte', 'Personal', 'Crédito', '12/10/19', 'Activa'),
	('Laura López', '2A3B4C5D6E7F8G9H0', 'DNI', 'Empresarial', 'Débito', '7/14/18', 'Inactiva'),
	('Pedro González', '2K3L4M5N6O7P8Q9R0', 'Cédula', 'Personal', 'Crédito', '3/22/17', 'Activa'),
	('Sofía Sánchez', '2U3V4W5X6Y7Z8A9B0', 'DNI', 'Empresarial', 'Débito', '9/5/16', 'Activa'),
	('Marta Torres', '2O3P4Q5R6S7T8U9V0', 'Cédula', 'Empresarial', 'Débito', '6/27/14', 'Activa'),
	('Jorge Flores', '2Y3Z4A5B6C7D8E9F0', 'Pasaporte', 'Personal', 'Crédito', '4/9/13', 'Activa'),
	('Elena Ruiz', '2I3J4K5L6M7N8O9P0', 'DNI', 'Empresarial', 'Débito', '10/31/12', 'Inativa'),
	('Andrés Jiménez', '2S3T4U5V6W7X8Y9Z0', 'Cédula', 'Personal', 'Crédito', '2/13/11', 'Activa'),
	('Paula Mendoza', '2C3D4E5F6G7H8I9J0', 'Pasaporte', 'Empresarial', 'Débito', '5/21/10', 'Activa'),
	('Fernando Castro', '2M3N4O5P6Q7R8S9T0', 'DNI', 'Personal', 'Crédito', '8/3/09', 'Inactiva'),
	('Gabriela Ortiz', '2W3X4Y5Z6A7B8C9D0', 'Cédula', 'Empresarial', 'Débito', '12/15/08', 'Activa'),
	('Fernando Castro', '2G3H4I5J6K7L8M9N0', 'Pasaporte', 'Personal', 'Crédito', '3/29/07', 'Açtiva'),
	('Valentina Romero', '2Q3R4S5T6U7V8W9X0', 'DNI', 'Empresarial', 'Débito', '7/11/06', 'Inactiva'),
	('Santiago Vargas', '2A3B4C5D6E7F8G9H0', 'Cédula', 'Personal', 'Crédito', '11/23/05', 'Activa'),
	('Natalia Herrera', '2K3L4M5N6O7P8Q9R0', 'Pasaporte', 'Empresarial', 'Débito', '4/5/04', 'Activa'),
	('Sofía Sánchez', '2E3F4G5H6I7J8K9L0', 'DNI', 'Personal', 'Crédito', '11/18/15', 'Activa');