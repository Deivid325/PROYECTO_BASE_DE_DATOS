USE car_rental;
# Consulta 1: Listar todas las reservas activas con datos del cliente y vehículo
SELECT r.idReserva, c.nombreCliente, v.marcaVehiculo, v.modeloVehiculo, r.fechaInicio, r.fechaFin, r.costoTotal
FROM reservas r
JOIN clientes c ON r.idCliente = c.idCliente
JOIN vehiculos v ON r.idVehiculo = v.idVehiculo
WHERE r.estadoReserva = 'Activa';

# Consulta 2: Obtener el número de reservas finalizadas por cliente
SELECT c.nombreCliente, COUNT(r.idReserva) AS reservas_finalizadas
FROM clientes c
JOIN reservas r ON c.idCliente = r.idCliente
WHERE r.estadoReserva = 'Finalizada'
GROUP BY c.nombreCliente
ORDER BY reservas_finalizadas DESC;

## Consulta 3: Ver el estado actual de todos los vehículos y si están asignados a una reserva activa
SELECT v.idVehiculo, v.marcaVehiculo, v.modeloVehiculo, v.estadoVehiculo,
    CASE 
	WHEN v.estadoVehiculo IN ('Mantenimiento', 'Baja') THEN 'No disponible'
	WHEN r.idReserva IS NOT NULL THEN 'Asignado'
	ELSE 'Disponible'
    END AS disponibilidad
FROM vehiculos v
LEFT JOIN reservas r ON v.idVehiculo = r.idVehiculo 
AND r.estadoReserva = 'Activa';

## Consulta 4: Cantidad de reservas gestionadas por cada empleado 
SELECT e.nombreEmpleado, e.cargoEmpleado, COUNT(r.idReserva) AS totalReservas
FROM empleados e
LEFT JOIN reservas r ON e.idEmpleado = r.idEmpleado
GROUP BY e.nombreEmpleado, e.cargoEmpleado
ORDER BY totalReservas DESC;

## Consulta 5: Ingresos generados por mes a partir de las reservas finalizadas
SELECT DATE_FORMAT(fechaFin, '%Y-%m') AS mes,
SUM(costoTotal) AS ingresos_mensuales
FROM reservas
WHERE estadoReserva = 'Finalizada'
GROUP BY mes
ORDER BY mes;

## Consulta 6: Ver el historial completo de reservas de un cliente específico
SELECT r.idReserva, r.fechaInicio, r.fechaFin, r.costoTotal, r.estadoReserva, v.marcaVehiculo, v.modeloVehiculo
FROM reservas r
JOIN vehiculos v ON r.idVehiculo = v.idVehiculo
WHERE r.idCliente = 6  -- Cambiamos el número por el ID del cliente que queramos consultar
ORDER BY r.fechaInicio DESC;
