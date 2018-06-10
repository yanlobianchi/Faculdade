-- MySQL Script generated by MySQL Workbench
-- Qui 14 Dez 2017 14:37:06 BRST
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Cliente` (
  `CPF` INT(11) UNSIGNED NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `Tipo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`CPF`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Fatura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Fatura` (
  `CodFatura` INT NOT NULL,
  `Cliente_CPF` INT(11) UNSIGNED NOT NULL,
  PRIMARY KEY (`CodFatura`),
  INDEX `fk_Fatura_Cliente_idx` (`Cliente_CPF` ASC),
  CONSTRAINT `fk_Fatura_Cliente`
    FOREIGN KEY (`Cliente_CPF`)
    REFERENCES `mydb`.`Cliente` (`CPF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Modelo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Modelo` (
  `idModelo` VARCHAR(45) NOT NULL,
  `Marca` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idModelo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Categoria` (
  `idCategoria` INT NOT NULL AUTO_INCREMENT,
  `Descricao` VARCHAR(45) NULL,
  `Diaria` DOUBLE NOT NULL,
  PRIMARY KEY (`idCategoria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Automovel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Automovel` (
  `Placa` VARCHAR(8) NOT NULL,
  `Kilometragem` DOUBLE NOT NULL,
  `Modelo_idModelo` VARCHAR(45) NOT NULL,
  `Categoria_idCategoria` INT NOT NULL,
  PRIMARY KEY (`Placa`),
  INDEX `fk_Automovel_Modelo1_idx` (`Modelo_idModelo` ASC),
  INDEX `fk_Automovel_Categoria1_idx` (`Categoria_idCategoria` ASC),
  CONSTRAINT `fk_Automovel_Modelo1`
    FOREIGN KEY (`Modelo_idModelo`)
    REFERENCES `mydb`.`Modelo` (`idModelo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Automovel_Categoria1`
    FOREIGN KEY (`Categoria_idCategoria`)
    REFERENCES `mydb`.`Categoria` (`idCategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Locacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Locacao` (
  `QtdDiarias` INT UNSIGNED NOT NULL,
  `KmRodados` DOUBLE NOT NULL,
  `Fatura_CodFatura` INT NOT NULL,
  `Automovel_Placa` INT NOT NULL,
  PRIMARY KEY (`Fatura_CodFatura`, `Automovel_Placa`),
  INDEX `fk_Locacao_Automovel1_idx` (`Automovel_Placa` ASC),
  CONSTRAINT `fk_Locacao_Fatura1`
    FOREIGN KEY (`Fatura_CodFatura`)
    REFERENCES `mydb`.`Fatura` (`CodFatura`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Locacao_Automovel1`
    FOREIGN KEY (`Automovel_Placa`)
    REFERENCES `mydb`.`Automovel` (`Placa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `mydb`;

DELIMITER $$
USE `mydb`$$
CREATE DEFINER = CURRENT_USER TRIGGER `mydb`.`Locacao_AFTER_INSERT` AFTER INSERT ON `Locacao` FOR EACH ROW
BEGIN
	UPDATE mydb.Locacao L, mydb.Automovel A
    SET A.Kilometragem = A.Kilometragem + L.KmRodados
    WHERE L.Automovel_Placa = A.Placa;
END$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
