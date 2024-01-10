-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema pizzeria
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema pizzeria
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pizzeria` DEFAULT CHARACTER SET utf8 ;
USE `pizzeria` ;

-- -----------------------------------------------------
-- Table `pizzeria`.`provincia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`provincia` (
  `provincia_id` INT NOT NULL AUTO_INCREMENT,
  `provincia_nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`provincia_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`localidad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`localidad` (
  `localidad_id` INT NOT NULL,
  `localidad_nombre` VARCHAR(255) NOT NULL,
  `provincia_provincia_id` INT NOT NULL,
  PRIMARY KEY (`localidad_id`),
  INDEX `fk_localidad_provincia1_idx` (`provincia_provincia_id` ASC),
  CONSTRAINT `fk_localidad_provincia1`
    FOREIGN KEY (`provincia_provincia_id`)
    REFERENCES `pizzeria`.`provincia` (`provincia_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`cliente` (
  `cliente_id` INT NOT NULL AUTO_INCREMENT,
  `cliente_nombre` VARCHAR(45) NOT NULL,
  `cliente_apellido1` VARCHAR(45) NOT NULL,
  `cliente_apellido2` VARCHAR(45) NULL DEFAULT NULL,
  `cliente_direccion` VARCHAR(255) NOT NULL,
  `cliente_cp` VARCHAR(45) NOT NULL,
  `cliente_telefono` VARCHAR(45) NOT NULL,
  `localidad_localidad_id` INT NOT NULL,
  PRIMARY KEY (`cliente_id`),
  INDEX `fk_cliente_localidad1_idx` (`localidad_localidad_id` ASC),
  CONSTRAINT `fk_cliente_localidad1`
    FOREIGN KEY (`localidad_localidad_id`)
    REFERENCES `pizzeria`.`localidad` (`localidad_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`tienda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`tienda` (
  `tienda_id` INT NOT NULL AUTO_INCREMENT,
  `tienda_nombre` VARCHAR(45) NOT NULL,
  `tienda_direccion` VARCHAR(255) NOT NULL,
  `tienda_cp` VARCHAR(45) NOT NULL,
  `localidad_localidad_id` INT NOT NULL,
  PRIMARY KEY (`tienda_id`),
  INDEX `fk_tienda_localidad1_idx` (`localidad_localidad_id` ASC),
  CONSTRAINT `fk_tienda_localidad1`
    FOREIGN KEY (`localidad_localidad_id`)
    REFERENCES `pizzeria`.`localidad` (`localidad_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`empleados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`empleados` (
  `empleados_id` INT NOT NULL,
  `tienda_tienda_id` INT NOT NULL,
  `empleados_nombre` VARCHAR(45) NOT NULL,
  `empleados_apellido1` VARCHAR(45) NOT NULL,
  `empleados_apellido2` VARCHAR(45) NOT NULL,
  `empleados_nif` VARCHAR(45) NOT NULL,
  `empleados_funcion` INT NOT NULL COMMENT 'FUNCION\n0=Cocinero\n1=Repartidor',
  PRIMARY KEY (`empleados_id`),
  INDEX `fk_empleados_tienda1_idx` (`tienda_tienda_id` ASC),
  CONSTRAINT `fk_empleados_tienda1`
    FOREIGN KEY (`tienda_tienda_id`)
    REFERENCES `pizzeria`.`tienda` (`tienda_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`pedidos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`pedidos` (
  `pedidos_id` INT NOT NULL AUTO_INCREMENT,
  `cliente_cliente_id` INT NOT NULL,
  `tienda_tienda_id` INT NOT NULL,
  `empleados_empleados_id` INT NOT NULL,
  `pedidos_fechaHora` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `pedidos_recogida` INT NOT NULL COMMENT 'ENTREGA\n0=Tienda\n1=Repartidor',
  PRIMARY KEY (`pedidos_id`),
  INDEX `fk_pedidos_cliente1_idx` (`cliente_cliente_id` ASC),
  INDEX `fk_pedidos_tienda1_idx` (`tienda_tienda_id` ASC),
  INDEX `fk_pedidos_empleados1_idx` (`empleados_empleados_id` ASC),
  CONSTRAINT `fk_pedidos_cliente1`
    FOREIGN KEY (`cliente_cliente_id`)
    REFERENCES `pizzeria`.`cliente` (`cliente_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedidos_tienda1`
    FOREIGN KEY (`tienda_tienda_id`)
    REFERENCES `pizzeria`.`tienda` (`tienda_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedidos_empleados1`
    FOREIGN KEY (`empleados_empleados_id`)
    REFERENCES `pizzeria`.`empleados` (`empleados_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`tipoPizzas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`tipoPizzas` (
  `tipoPizzas_id` INT NOT NULL AUTO_INCREMENT,
  `tipoPizzas_nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`tipoPizzas_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`hamburguesas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`hamburguesas` (
  `hamburguesas_id` INT NOT NULL AUTO_INCREMENT,
  `hamburguesas_nombre` VARCHAR(45) NOT NULL,
  `hamburguesas_descripcion` VARCHAR(45) NOT NULL,
  `hamburguesas_precio` DECIMAL(5,2) NOT NULL,
  `hamburguesas_imagen` BLOB NOT NULL,
  PRIMARY KEY (`hamburguesas_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`bebidas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`bebidas` (
  `bebidas_id` INT NOT NULL AUTO_INCREMENT,
  `bebidas_nombre` VARCHAR(45) NOT NULL,
  `bebidas_descripcion` VARCHAR(45) NOT NULL,
  `bebidas_precio` DECIMAL(5,2) NOT NULL,
  `bebidas_imagen` BLOB NOT NULL,
  PRIMARY KEY (`bebidas_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`pizzas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`pizzas` (
  `pizzas_id` INT NOT NULL AUTO_INCREMENT,
  `tipoPizzas_tipoPizzas_id` INT NOT NULL,
  `pizzas_nombre` VARCHAR(45) NOT NULL,
  `pizzas_descripcion` VARCHAR(45) NOT NULL,
  `pizzas_precio` VARCHAR(45) NOT NULL,
  `pizzas_imagen` BLOB NOT NULL,
  INDEX `fk_pizzas_tipoPizzas1_idx` (`tipoPizzas_tipoPizzas_id` ASC),
  PRIMARY KEY (`pizzas_id`),
  CONSTRAINT `fk_pizzas_tipoPizzas1`
    FOREIGN KEY (`tipoPizzas_tipoPizzas_id`)
    REFERENCES `pizzeria`.`tipoPizzas` (`tipoPizzas_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`pedidos_has_pizzas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`pedidos_has_pizzas` (
  `pedidos_pedidos_id` INT NOT NULL,
  `pizzas_pizzas_id` INT NOT NULL,
  `pedidos_has_pizzas_cantidad` INT NOT NULL,
  PRIMARY KEY (`pedidos_pedidos_id`, `pizzas_pizzas_id`),
  INDEX `fk_pedidos_has_pizzas_pizzas1_idx` (`pizzas_pizzas_id` ASC),
  INDEX `fk_pedidos_has_pizzas_pedidos1_idx` (`pedidos_pedidos_id` ASC),
  CONSTRAINT `fk_pedidos_has_pizzas_pedidos1`
    FOREIGN KEY (`pedidos_pedidos_id`)
    REFERENCES `pizzeria`.`pedidos` (`pedidos_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedidos_has_pizzas_pizzas1`
    FOREIGN KEY (`pizzas_pizzas_id`)
    REFERENCES `pizzeria`.`pizzas` (`pizzas_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`pedidos_has_hamburguesas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`pedidos_has_hamburguesas` (
  `pedidos_pedidos_id` INT NOT NULL,
  `hamburguesas_hamburguesas_id` INT NOT NULL,
  `pedidos_has_hamburguesas_cantidad` INT NOT NULL,
  PRIMARY KEY (`pedidos_pedidos_id`, `hamburguesas_hamburguesas_id`),
  INDEX `fk_pedidos_has_hamburguesas_hamburguesas1_idx` (`hamburguesas_hamburguesas_id` ASC),
  INDEX `fk_pedidos_has_hamburguesas_pedidos1_idx` (`pedidos_pedidos_id` ASC),
  CONSTRAINT `fk_pedidos_has_hamburguesas_pedidos1`
    FOREIGN KEY (`pedidos_pedidos_id`)
    REFERENCES `pizzeria`.`pedidos` (`pedidos_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedidos_has_hamburguesas_hamburguesas1`
    FOREIGN KEY (`hamburguesas_hamburguesas_id`)
    REFERENCES `pizzeria`.`hamburguesas` (`hamburguesas_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`pedidos_has_bebidas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`pedidos_has_bebidas` (
  `pedidos_pedidos_id` INT NOT NULL,
  `bebidas_bebidas_id` INT NOT NULL,
  `pedidos_has_bebidas_cantidad` INT NOT NULL,
  PRIMARY KEY (`pedidos_pedidos_id`, `bebidas_bebidas_id`),
  INDEX `fk_pedidos_has_bebidas_bebidas1_idx` (`bebidas_bebidas_id` ASC),
  INDEX `fk_pedidos_has_bebidas_pedidos1_idx` (`pedidos_pedidos_id` ASC),
  CONSTRAINT `fk_pedidos_has_bebidas_pedidos1`
    FOREIGN KEY (`pedidos_pedidos_id`)
    REFERENCES `pizzeria`.`pedidos` (`pedidos_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedidos_has_bebidas_bebidas1`
    FOREIGN KEY (`bebidas_bebidas_id`)
    REFERENCES `pizzeria`.`bebidas` (`bebidas_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
