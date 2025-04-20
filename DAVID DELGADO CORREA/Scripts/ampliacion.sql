USE car_rental;
# AÑADIMOS UNA COLUMNA KILOMETROS A LA TABLA VEHICULOS
ALTER TABLE vehiculos
ADD COLUMN kilometraje INT UNSIGNED DEFAULT 0 AFTER estadoVehiculo;

UPDATE vehiculos SET kilometraje = 15000 WHERE idVehiculo = 1; 
UPDATE vehiculos SET kilometraje = 42000 WHERE idVehiculo = 2; 
UPDATE vehiculos SET kilometraje = 67000 WHERE idVehiculo = 3; 
UPDATE vehiculos SET kilometraje = 33000 WHERE idVehiculo = 4; 
UPDATE vehiculos SET kilometraje = 92000 WHERE idVehiculo = 5; 
UPDATE vehiculos SET kilometraje = 28000 WHERE idVehiculo = 6;

## AÑADIMOS UNA COLUMNA FECHAREGISTRO A LA TABLA CLIENTE
ALTER TABLE clientes
ADD COLUMN fechaRegistro DATETIME;

UPDATE clientes c
JOIN (
  SELECT idCliente, MIN(DATE(fechaInicio)) AS primeraReserva
  FROM reservas
  GROUP BY idCliente
) r ON c.idCliente = r.idCliente
SET c.fechaRegistro = r.primeraReserva;

## CREAMOS UNA NUEVA TABLA MANTENIMIENTOS
CREATE TABLE IF NOT EXISTS mantenimientos (
  idMantenimiento INT AUTO_INCREMENT PRIMARY KEY,
  idVehiculo INT NOT NULL,
  fechaMantenimiento DATE NOT NULL,
  tipoMantenimiento VARCHAR(80) NOT NULL,
  descripcion TEXT,
  costo DECIMAL(10,2),
  FOREIGN KEY (idVehiculo) REFERENCES vehiculos(idVehiculo)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

## Inserto 2 vehículos nuevos en mantenimiento para tener más vehiculos en la tabla mantenimiento
INSERT INTO vehiculos (marcaVehiculo, modeloVehiculo, añoVehiculo, matricula, tipoCombustible, estadoVehiculo, kilometraje) VALUES
('Ford', 'Focus', 2021, '5509HJK', 'Gasolina', 'Mantenimiento', 78500),
('Peugeot', '308', 2019, '6937PLT', 'Diésel', 'Mantenimiento', 98200);

## AÑADIMOS DATOS A LA TABLA MANTENIMIENTOS
INSERT INTO mantenimientos (idVehiculo, fechaMantenimiento, tipoMantenimiento, descripcion, costo)VALUES
(2, '2025-04-15', 'Cambio de frenos', 'Sustitución de pastillas de freno delanteras y traseras', 160.00),
(7, '2025-04-18', 'Revisión general', 'Revisión completa de 80.000 km, cambio de aceite y filtros', 220.00),
(8, '2025-04-19', 'Cambio de neumáticos', 'Reemplazo de los cuatro neumáticos por desgaste', 300.00);
