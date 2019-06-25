/* Este codigo crea las tablas */

CREATE TABLE Cliente (
  ID_cliente int IDENTITY NOT NULL,
  dni_cliente varchar(8) UNIQUE,
  primer_nombre varchar(100) NOT NULL,
  primer_apellido varchar(100) NOT NULL,
  email varchar(100) UNIQUE,
  celular varchar(9) UNIQUE);

CREATE TABLE Solicitud (
  ID_solicitud int IDENTITY NOT NULL,
  fecha_y_hora_de_solicitud datetime NOT NULL DEFAULT GETDATE(),
  ID_cliente int NOT NULL);

CREATE TABLE Servicio (
  ID_servicio int IDENTITY NOT NULL,
  fecha_del_servicio date NOT NULL,
  --CONSTRAINT fecha_de_servicio_valida CHECK (fecha_del_servicio > GETDATE()),
  numero_de_horas int NOT NULL,
  hora_de_inicio time NOT NULL,
  hora_de_fin AS dateadd(HOUR, numero_de_horas, hora_de_inicio), -- La hora de fin se obtiene de sumar el numero de horas a la hora de inicio
  comision_empresa float NOT NULL,
  pago_a_trabajador as 5 + 9 * numero_de_horas, -- El pago al trabajador consiste en un monto fijo que cubre pasajes más un variable que depende de las horas
  precio_de_servicio AS comision_empresa + 5 + 9 * numero_de_horas, -- El precio total es un campo calculado
  ID_solicitud int NOT NULL,
  ID_direccion int NOT NULL,
  ID_trabajador int NOT NULL);

CREATE TABLE Calificacion_de_servicio(
  ID_calificacion int IDENTITY NOT NULL,
  nivel_de_calificacion tinyint NOT NULL,
  CONSTRAINT rango_de_calificacion CHECK (nivel_de_calificacion <= 5),-- El nivel de calificación es un numero entero entre 1 y 5
  comentario varchar(250), -- El comentario es opcional
  ID_servicio int NOT NULL);

CREATE TABLE Trabajador (
  ID_trabajador int IDENTITY NOT NULL,
  dni_trabajador varchar(8) NOT NULL UNIQUE,
  primer_nombre varchar(100) NOT NULL,
  primer_apellido varchar(100) NOT NULL,
  celular varchar(9) UNIQUE,
  contacto_de_emergencia varchar(250) NOT NULL,
  disponible bit NOT NULL DEFAULT 1); -- Bit se usa como boolean, si el trabajador esta disponible tiene valor de 1; caso contrario, valor 0.

CREATE TABLE Proveedor (
  ID_proveedor int IDENTITY NOT NULL,
  RUC varchar(11) NOT NULL UNIQUE,
  razon_social varchar(100) UNIQUE,
  email varchar(100) UNIQUE,
  celular varchar(9) UNIQUE);

CREATE TABLE Distrito (
  ID_distrito int IDENTITY NOT NULL,
  nombre varchar(50) NOT NULL,
  provincia varchar(50) NOT NULL,
  region varchar(50) NOT NULL,
  disponible bit NOT NULL); --La variable disponible toma el valor de 1 cuando en el distrito sí se presta servicio; caso contrario es 0

CREATE TABLE Direccion (
  ID_direccion int IDENTITY NOT NULL,
  direccion varchar(250) NOT NULL,
  referencias varchar(250) NOT NULL,
  ID_distrito int NOT NULL,
  ID_cliente int NOT NULL);

CREATE TABLE Producto (
  ID_producto int IDENTITY NOT NULL,
  nombre varchar(250) NOT NULL,
  presentacion varchar(100) NOT NULL);

CREATE TABLE Producto_por_servicio (
  ID_producto_por_servicio int IDENTITY NOT NULL,
  cantidad int NOT NULL,
  ID_producto int NOT NULL,
  ID_servicio int NOT NULL);

CREATE TABLE Proveedor_por_producto(
  ID_proveedor_por_producto int IDENTITY NOT NULL,
  ID_proveedor int NOT NULL,
  ID_producto int NOT NULL);

CREATE TABLE Compra (
  ID_compra int IDENTITY NOT NULL,
  fecha_de_compra date NOT NULL,
  ID_proveedor int NOT NULL);

CREATE TABLE Producto_por_compra(
  ID_producto_por_compra int IDENTITY NOT NULL,
  cantidad int NOT NULL,
  precio float NOT NULL,
  ID_producto int NOT NULL,
  ID_compra int NOT NULL);
