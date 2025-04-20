USE car_rental;
## Vista 1: vista_historial_completo_clientes
CREATE VIEW vista_historial_completo_clientes AS
SELECT c.idCliente, c.nombreCliente, c.emailCliente,
COUNT(r.idReserva) AS totalReservas,
SUM(r.costoTotal) AS gastoTotal,
MIN(r.fechaInicio) AS primeraReserva,
MAX(r.fechaFin) AS ultimaReserva
FROM clientes c
LEFT JOIN reservas r ON c.idCliente = r.idCliente
GROUP BY c.idCliente, c.nombreCliente, c.emailCliente
ORDER BY gastoTotal DESC;

SELECT * FROM vista_historial_completo_clientes;

## Vista 2: vista_mantenimientos_recientes
CREATE VIEW vista_mantenimientos_recientes AS
SELECT m.idMantenimiento, v.marcaVehiculo, v.modeloVehiculo, m.tipoMantenimiento, m.fechaMantenimiento, m.costo, m.descripcion
FROM mantenimientos m
JOIN vehiculos v ON m.idVehiculo = v.idVehiculo
ORDER BY m.fechaMantenimiento DESC;

SELECT * FROM vista_mantenimientos_recientes;

## Vista 3: vista_ingresos_mensuales_sucursal
CREATE VIEW vista_ingresos_mensuales_sucursal AS
SELECT s.nombreSucursal,
DATE_FORMAT(r.fechaFin, '%Y-%m') AS mes,
SUM(r.costoTotal) AS ingresos_mensuales
FROM reservas r
JOIN empleados e ON r.idEmpleado = e.idEmpleado
JOIN sucursales s ON e.idSucursal = s.idSucursal
WHERE r.estadoReserva = 'Finalizada'
GROUP BY s.nombreSucursal, mes
ORDER BY mes, s.nombreSucursal;

SELECT * FROM vista_ingresos_mensuales_sucursal;

## Trigger 1: trg_after_insert_actualizar_estado_vehiculo
DELIMITER $$

CREATE TRIGGER trg_after_insert_actualizar_estado_vehiculo
AFTER INSERT ON reservas
FOR EACH ROW
BEGIN
  IF NEW.estadoReserva = 'Activa' THEN
    UPDATE vehiculos
    SET estadoVehiculo = 'Reservado'
    WHERE idVehiculo = NEW.idVehiculo
      AND estadoVehiculo NOT IN ('Mantenimiento', 'Baja');
  END IF;
END $$

DELIMITER ;

## Prueba y validación del trigger
SELECT * FROM vehiculos WHERE idVehiculo = 9;

INSERT INTO reservas (fechaInicio, fechaFin, costoTotal, estadoReserva, idCliente, idEmpleado, idVehiculo)
VALUES ('2025-04-17 12:00:00', '2025-04-18 16:00:00', 140.00, 'Activa', 6, 9, 9);

SELECT * FROM vehiculos WHERE idVehiculo = 9;

## Trigger 2: 
## Creamos la tabla aud_mantenimientos
CREATE TABLE aud_mantenimientos (
    idLog INT AUTO_INCREMENT PRIMARY KEY,
    idVehiculo INT NOT NULL,
    fechaMantenimiento DATETIME NOT NULL,
    descripcion TEXT,
    fechaRegistro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

## Creamos el trigger
DELIMITER //

CREATE TRIGGER trg_after_insert_aud_mantenimiento
AFTER INSERT ON mantenimientos
FOR EACH ROW
BEGIN
    INSERT INTO aud_mantenimientos (idVehiculo, fechaMantenimiento, descripcion)
    VALUES (NEW.idVehiculo, NEW.fechaMantenimiento, NEW.descripcion);
END;
//

DELIMITER ;

## Prueba y validación del trigger
INSERT INTO mantenimientos (idVehiculo, fechaMantenimiento, tipoMantenimiento, descripcion, costo)
VALUES (1, '2025-04-25 10:00:00', 'Mantenimiento preventivo', 'Revisión general', 100.00);

SELECT * FROM aud_mantenimientos;

## Trigger 3: Evitar reservar vehículos que no están disponibles

DELIMITER $$

CREATE TRIGGER before_insert_reserva
BEFORE INSERT ON reservas
FOR EACH ROW
BEGIN
    DECLARE estado_actual ENUM('Disponible', 'Reservado', 'Mantenimiento', 'Baja');

    SELECT estadoVehiculo INTO estado_actual
    FROM vehiculos
    WHERE idVehiculo = NEW.idVehiculo;

    IF estado_actual != 'Disponible' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: El vehículo no está disponible para reservas.';
    END IF;
END $$

DELIMITER ;

## Prueba y validación del trigger
INSERT INTO reservas (fechaInicio, fechaFin, costoTotal, estadoReserva, idCliente, idEmpleado, idVehiculo)
VALUES ('2025-05-01 10:00:00', '2025-05-03 12:00:00', 150.00, 'Activa', 1, 2, 2);








