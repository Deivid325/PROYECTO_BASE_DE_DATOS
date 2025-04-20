-- MySQL Workbench Synchronization
-- Generated: 2025-04-20 00:14
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: David325

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE SCHEMA IF NOT EXISTS `car_rental` DEFAULT CHARACTER SET utf8 ;

CREATE TABLE IF NOT EXISTS `car_rental`.`clientes` (
  `idCliente` INT(11) NOT NULL AUTO_INCREMENT,
  `nombreCliente` VARCHAR(80) NOT NULL,
  `DNI` VARCHAR(11) NOT NULL,
  `direccionCliente` VARCHAR(130) NOT NULL,
  `telefonoCliente` VARCHAR(12) NOT NULL,
  `emailCliente` VARCHAR(80) NOT NULL,
  PRIMARY KEY (`idCliente`),
  UNIQUE INDEX `DNI_UNIQUE` (`DNI` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `car_rental`.`vehiculos` (
  `idVehiculo` INT(11) NOT NULL AUTO_INCREMENT,
  `marcaVehiculo` VARCHAR(50) NOT NULL,
  `modeloVehiculo` VARCHAR(50) NOT NULL,
  `añoVehiculo` YEAR NOT NULL,
  `matricula` VARCHAR(15) NOT NULL,
  `tipoCombustible` ENUM('Gasolina', 'Diésel', 'Eléctrico', 'Híbrido') NOT NULL,
  `estadoVehiculo` ENUM('Disponible', 'Reservado', 'Mantenimiento', 'Baja') NOT NULL,
  PRIMARY KEY (`idVehiculo`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `car_rental`.`reservas` (
  `idReserva` INT(11) NOT NULL AUTO_INCREMENT,
  `fechaInicio` DATETIME NOT NULL,
  `fechaFin` DATETIME NOT NULL,
  `costoTotal` DECIMAL(10,2) NOT NULL,
  `estadoReserva` ENUM('Activa', 'Cancelada', 'Finalizada') NOT NULL,
  `idCliente` INT(11) NOT NULL,
  `idVehiculo` INT(11) NOT NULL,
  `idEmpleado` INT(11) NOT NULL,
  PRIMARY KEY (`idReserva`),
  INDEX `fk_reservas_clientes1_idx` (`idCliente` ASC) VISIBLE,
  INDEX `fk_reservas_vehiculos1_idx` (`idVehiculo` ASC) VISIBLE,
  INDEX `fk_reservas_empleados1_idx` (`idEmpleado` ASC) VISIBLE,
  CONSTRAINT `fk_reservas_clientes1`
    FOREIGN KEY (`idCliente`)
    REFERENCES `car_rental`.`clientes` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reservas_vehiculos1`
    FOREIGN KEY (`idVehiculo`)
    REFERENCES `car_rental`.`vehiculos` (`idVehiculo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reservas_empleados1`
    FOREIGN KEY (`idEmpleado`)
    REFERENCES `car_rental`.`empleados` (`idEmpleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `car_rental`.`sucursales` (
  `idSucursal` INT(11) NOT NULL AUTO_INCREMENT,
  `nombreSucursal` VARCHAR(80) NOT NULL,
  `direccionSucursal` VARCHAR(130) NOT NULL,
  `telefonoSucursal` VARCHAR(12) NOT NULL,
  PRIMARY KEY (`idSucursal`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `car_rental`.`empleados` (
  `idEmpleado` INT(11) NOT NULL AUTO_INCREMENT,
  `nombreEmpleado` VARCHAR(80) NOT NULL,
  `cargoEmpleado` VARCHAR(45) NOT NULL,
  `idSucursal` INT(11) NOT NULL,
  PRIMARY KEY (`idEmpleado`),
  INDEX `fk_empleados_sucursales_idx` (`idSucursal` ASC) VISIBLE,
  CONSTRAINT `fk_empleados_sucursales`
    FOREIGN KEY (`idSucursal`)
    REFERENCES `car_rental`.`sucursales` (`idSucursal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
