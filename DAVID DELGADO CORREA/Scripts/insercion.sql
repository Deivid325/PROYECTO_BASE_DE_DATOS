USE car_rental;
## INSERCIÓN DE DATOS TABLA CLIENTES
INSERT INTO clientes (nombreCliente, DNI, direccionCliente, telefonoCliente, emailCliente) VALUES
('David Delgado Correa', '51153539A', 'Calle Castillo 32, Santa Cruz de Tenerife', '613385668', 'daviddc@outlook.com'),
('Carlos Pérez Pérez', '42654321B', 'Av. de los Majuelos 21, La Laguna', '689112233', 'carlos.perez@gmail.com'),
('Maria Pilar Lucena', '45678912C', 'Carretera El Boquerón, La Laguna', '678910123', 'mariapilar@gmail.com'),
('Miguel Guzmán González', '34901234D', 'Calle La Hoya 22, Adeje', '611223344', 'miguel.guzman@hotmail.com'),
('Elena Sánchez López', '51567890E', 'Calle Doctor Olivera 5, La Laguna', '695887766', 'elena.sanchez@protonmail.com'),
('Francisco Delgado Correa', '51234540F', 'Calle Bethencourt Alfonso 14, Santa Cruz de Tenerife', '922456789', 'fran.delgado@hotmail.com'),
('Isabel Herrera Dorta', '46934955G', 'Avenida El Paso 7, Puerto de la Cruz', '922567890', 'isabel.herrera@gmail.com');

SELECT * FROM clientes;

## INSERCIÓN DE DATOS TABLA SUCURSALES
INSERT INTO sucursales (nombreSucursal, direccionSucursal, telefonoSucursal) VALUES
('Sucursal Santa Cruz', 'Av. Tres de Mayo 8, Santa Cruz de Tenerife', '922138411'),
('Sucursal La Laguna', 'Plaza del Adelantado 3, San Cristóbal de La Laguna', '922226542'),
('Sucursal Costa Adeje', 'Calle Gran Bretaña 1, Costa Adeje', '922381003');

SELECT * FROM sucursales;

## INSERCIÓN DE DATOS TABLA EMPLEADOS
INSERT INTO empleados (nombreEmpleado, cargoEmpleado, idSucursal) VALUES
('Luis Herrera', 'Gerente', 1),             
('María López', 'Atención al cliente', 2), 
('Pedro Díaz', 'Gestor de reservas', 1),   
('Sofía Morales', 'Encargada de flota', 3),
('Javier Martín', 'Técnico de vehículos', 3),
('Andrea Pérez', 'Gerente', 2),
('Raúl Mendoza', 'Atención al cliente', 1),
('Lucía Ramos', 'Gestor de reservas', 3),
('Daniel Ortega', 'Encargado de flota', 2),
('Nuria Navarro', 'Técnico de vehículos', 1);

SELECT * FROM empleados;

## INSERCIÓN DE DATOS TABLA VEHICULOS
INSERT INTO vehiculos (marcaVehiculo, modeloVehiculo, añoVehiculo, matricula, tipoCombustible, estadoVehiculo) VALUES
('Toyota', 'Corolla', 2024, '8234LKM', 'Gasolina', 'Disponible'),
('Volkswagen', 'Golf', 2023, '5678BRN', 'Diésel', 'Mantenimiento'),
('Renault', 'Clio', 2020, '9102DFT', 'Gasolina', 'Reservado'),
('Tesla', 'Model 3', 2022, '3141TES', 'Eléctrico', 'Disponible'),
('Hyundai', 'Tucson', 2018, '7689GHJ', 'Diésel', 'Baja'),
('Opel', 'Corsa', 2022, '3832GKM', 'Diésel', 'Disponible'),
('Opel', 'Astra', 2023, '2164PMM', 'Gasolina', 'Disponible', '30500');

SELECT * FROM vehiculos;

## INSERCIÓN DE DATOS TABLA RESERVAS
INSERT INTO reservas (fechaInicio, fechaFin, costoTotal, estadoReserva, idCliente, idEmpleado, idVehiculo) VALUES
('2025-02-01', '2025-02-07', 210.00, 'Finalizada', 1, 1, 1),
('2025-02-10', '2025-02-15', 180.00, 'Cancelada', 2, 3, 2),
('2025-03-20', '2025-03-25', 250.00, 'Activa', 3, 3, 3),
('2025-03-18', '2025-03-20', 150.00, 'Activa', 4, 4, 4),
('2025-04-01', '2025-04-10', 400.00, 'Activa', 5, 4, 5),
('2024-06-01 10:30:00', '2024-06-05 12:00:00', 220.00, 'Finalizada', 6, 1, 2), 
('2024-07-10 14:15:00', '2024-07-12 16:30:00', 130.00, 'Finalizada', 6, 3, 3),
('2024-05-15 09:00:00', '2024-05-20 11:45:00', 200.00, 'Finalizada', 7, 2, 1),  
('2024-06-20 13:30:00', '2024-06-25 15:00:00', 250.00, 'Finalizada', 7, 4, 4),  
('2025-02-11', '2025-02-13', 120.00, 'Finalizada', 7, 8, 6),
('2024-08-28 12:30:00', '2024-08-29 12:45:00', 85.00, 'Finalizada', 3, 6, 6);

SELECT * FROM reservas;