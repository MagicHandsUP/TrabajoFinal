/* Muestra el número de clientes registrados */
SELECT COUNT(*) FROM Cliente;

/* Muestra el número de distritos en los que sí se presta servicio */
SELECT COUNT(*) FROM Distrito WHERE disponible = 1;

/* Muestra en cuantas regiones únicas están disponibles los servicios */
SELECT COUNT(DISTINCT region) FROM Distrito;

/* Muestra en cuantos distritos se brinda servicios y en cuantos no */
SELECT disponible, COUNT(*) FROM Distrito GROUP BY disponible;

/* Muestra cuantos de los trabajadores estan disponibles y cuantos no */
SELECT disponible, COUNT(*) FROM Trabajador GROUP BY disponible;

/* Muestra los servicios más usados y menos usados */
SELECT numero_de_horas AS 'Paquetes de limpieza por horas', COUNT(ID_servicio) AS 'cantidad de servicios' FROM Servicio GROUP BY numero_de_horas ORDER BY COUNT(ID_servicio) DESC;

/* Cantidad de clientes que utilizaron nuestro servicio el último mes */
SELECT COUNT(DISTINCT Solicitud.ID_cliente) As 'Cantidad de clientes únicos que compraron el mes de Mayo' FROM Solicitud INNER JOIN Cliente ON Solicitud.ID_cliente = Cliente.ID_cliente WHERE MONTH(Solicitud.fecha_y_hora_de_solicitud) = 5

/* Los ingresos que nos generaron los tres tipos de servicio más vendidos */
SELECT TOP 3 numero_de_horas AS 'Paquetes de limpieza por horas', SUM(comision_empresa) AS 'Ingreso total en soles' FROM Servicio GROUP BY numero_de_horas ORDER BY COUNT(ID_servicio) DESC;

/* Trabajadores con mejor desempeño */
SELECT Primer_nombre, Primer_apellido, celular FROM Trabajador UNION SELECT Primer_nombre, Primer_apellido, celular FROM Cliente;

/* Distritos en los que se ofrece servicio pero no se ha realizado ninguno */
SELECT nombre FROM Distrito WHERE disponible = 1 EXCEPT SELECT DISTINCT Distrito.nombre FROM Distrito INNER JOIN Direccion ON Direccion.ID_distrito = Distrito.ID_distrito;

/* Cobertura de servicio por distritos */
SELECT disponible AS 'Disponibilidad', COUNT(*) AS 'Número de distritos' FROM Distrito GROUP BY disponible;

/* Proveedores con quienes se han realizado más de 5 órdenes de compra */
SELECT Proveedor.razon_social AS 'Proveedor', COUNT(*) AS 'Número de compras' FROM Compra INNER JOIN Proveedor ON Compra.ID_proveedor = Proveedor.ID_proveedor GROUP BY Proveedor.razon_social HAVING COUNT(*) > 5

/* Cantidad promedio de solicitudes por cliente */
SELECT AVG(conteo) AS 'Cantidad de promedio de solicitudes por cliente' FROM (SELECT ID_cliente, COUNT(ID_Solicitud) AS conteo FROM solicitud GROUP BY id_cliente) AS Tabla2;

/* Pago mínimo a un trabajador por un servicio */
SELECT MIN (pago_a_trabajador) AS 'Pago mínimo a un trabajador por servicio realizado' FROM (SELECT ID_trabjador, pago_a_trabajador FROM Servicio) AS NombreTabla;

/* Cantidad máxima de servicios en un mismo distrito */
SELECT MAX(Cantidad_de_servicios) AS 'Cantidad máxima de servicios en un mismo distrito' FROM (SELECT distrito.nombre AS Distrito, COUNT(*) AS Cantidad_de_servicios FROM Servicio INNER JOIN Direccion ON Servicio.ID_direccion = Direccion.ID_direccion INNER JOIN Distrito ON Direccion.ID_distrito = Distrito.ID_distrito GROUP BY Distrito.nombre) AS Tabla;
