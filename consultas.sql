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
