-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`tbVeiculo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tbVeiculo` (
  `placa` VARCHAR(7) NOT NULL,
  `valorAluguel` INT UNSIGNED NOT NULL,
  `arCondicionado` TINYINT UNSIGNED NOT NULL,
  `bebeConforto` TINYINT UNSIGNED NOT NULL,
  `modelo` VARCHAR(45) NOT NULL,
  `chassi` VARCHAR(45) NOT NULL,
  `marca` VARCHAR(45) NOT NULL,
  `ano` YEAR(4) NOT NULL,
  `potencia` INT UNSIGNED NOT NULL,
  `tipoCombustivel` VARCHAR(45) NOT NULL,
  `mecanizacao` VARCHAR(45) NULL,
  `largura` INT UNSIGNED NOT NULL,
  `altura` INT UNSIGNED NOT NULL,
  `profundidade` INT UNSIGNED NOT NULL,
  `classe` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`placa`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tbTelefones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tbTelefones` (
  `idTelefones` INT UNSIGNED NOT NULL,
  `telefone` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`idTelefones`),
  UNIQUE INDEX `idTelefones_UNIQUE` (`idTelefones` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tbEmails`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tbEmails` (
  `idEmails` INT UNSIGNED NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idEmails`),
  UNIQUE INDEX `idEmails_UNIQUE` (`idEmails` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tbJuridico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tbJuridico` (
  `CNPJ` VARCHAR(12) NOT NULL,
  `empresa` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`CNPJ`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tbCliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tbCliente` (
  `CPF` VARCHAR(14) NOT NULL,
  `dataExpiracaoCNH` DATE NOT NULL,
  `numeroCNH` VARCHAR(45) NOT NULL,
  `dataNascimento` DATE NOT NULL,
  `nomeCompleto` VARCHAR(45) NOT NULL,
  `RG` VARCHAR(11) NOT NULL,
  `tbTelefones_id` INT NOT NULL,
  `tbEmails_id` INT NOT NULL,
  `tbJuridico_CNPJ` VARCHAR(12) NOT NULL,
  PRIMARY KEY (`CPF`),
  INDEX `fk_tbCliente_tbTelefones1_idx` (`tbTelefones_id` ASC) VISIBLE,
  INDEX `fk_tbCliente_tbEmails1_idx` (`tbEmails_id` ASC) VISIBLE,
  INDEX `fk_tbCliente_tbJuridico1_idx` (`tbJuridico_CNPJ` ASC) VISIBLE,
  UNIQUE INDEX `tbTelefones_id_UNIQUE` (`tbTelefones_id` ASC) VISIBLE,
  UNIQUE INDEX `tbEmails_id_UNIQUE` (`tbEmails_id` ASC) VISIBLE,
  CONSTRAINT `fk_tbCliente_tbTelefones1`
    FOREIGN KEY (`tbTelefones_id`)
    REFERENCES `mydb`.`tbTelefones` (`idTelefones`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbCliente_tbEmails1`
    FOREIGN KEY (`tbEmails_id`)
    REFERENCES `mydb`.`tbEmails` (`idEmails`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbCliente_tbJuridico1`
    FOREIGN KEY (`tbJuridico_CNPJ`)
    REFERENCES `mydb`.`tbJuridico` (`CNPJ`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tbLocacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tbLocacao` (
  `codigoLocacao` INT UNSIGNED NOT NULL,
  `patioSaida` VARCHAR(45) NOT NULL,
  `patioChegada` VARCHAR(45) NOT NULL,
  `estadoDevolucao` VARCHAR(45) NOT NULL,
  `dataRetiradaRealizada` DATE NULL,
  `dataDevolucaoPrevista` DATE NOT NULL,
  `seguroBasico` VARCHAR(45) NOT NULL,
  `tbVeiculo_placa` VARCHAR(7) NOT NULL,
  `tbCliente_CPF` VARCHAR(14) NOT NULL,
  PRIMARY KEY (`codigoLocacao`),
  INDEX `fk_tbLocacao_tbVeiculo1_idx` (`tbVeiculo_placa` ASC) VISIBLE,
  INDEX `fk_tbLocacao_tbCliente1_idx` (`tbCliente_CPF` ASC) VISIBLE,
  CONSTRAINT `fk_tbLocacao_tbVeiculo1`
    FOREIGN KEY (`tbVeiculo_placa`)
    REFERENCES `mydb`.`tbVeiculo` (`placa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbLocacao_tbCliente1`
    FOREIGN KEY (`tbCliente_CPF`)
    REFERENCES `mydb`.`tbCliente` (`CPF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tbFotos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tbFotos` (
  `idFotos` INT UNSIGNED NOT NULL,
  `arquivoImagem` BLOB NOT NULL,
  PRIMARY KEY (`idFotos`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tbProntuarioVeiculo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tbProntuarioVeiculo` (
  `codigoProntuario` INT UNSIGNED NOT NULL,
  `condicaoGeral` VARCHAR(45) NOT NULL,
  `dataProximaRevisao` DATE NULL,
  `pneuPressao` INT UNSIGNED NOT NULL,
  `estadoConservacao` VARCHAR(45) NOT NULL,
  `rodagem` VARCHAR(45) NOT NULL,
  `nivelOleo` VARCHAR(45) NOT NULL,
  `dataUltimaRevisao` DATE NOT NULL,
  `tbFotos_idFotos` INT NOT NULL,
  `tbVeiculo_placa` VARCHAR(7) NOT NULL,
  PRIMARY KEY (`codigoProntuario`),
  INDEX `fk_tbProntuarioVeiculo_tbFotos1_idx` (`tbFotos_idFotos` ASC) VISIBLE,
  INDEX `fk_tbProntuarioVeiculo_tbVeiculo1_idx` (`tbVeiculo_placa` ASC) VISIBLE,
  CONSTRAINT `fk_tbProntuarioVeiculo_tbFotos1`
    FOREIGN KEY (`tbFotos_idFotos`)
    REFERENCES `mydb`.`tbFotos` (`idFotos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbProntuarioVeiculo_tbVeiculo1`
    FOREIGN KEY (`tbVeiculo_placa`)
    REFERENCES `mydb`.`tbVeiculo` (`placa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tbRequisicao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tbRequisicao` (
  `posicao` INT UNSIGNED NOT NULL,
  `tbVeiculo_placa` VARCHAR(7) NOT NULL,
  `tbCliente_CPF` VARCHAR(14) NOT NULL,
  PRIMARY KEY (`posicao`),
  INDEX `fk_tbRequisicao_tbVeiculo1_idx` (`tbVeiculo_placa` ASC) VISIBLE,
  INDEX `fk_tbRequisicao_tbCliente1_idx` (`tbCliente_CPF` ASC) VISIBLE,
  UNIQUE INDEX `posicao_UNIQUE` (`posicao` ASC) VISIBLE,
  CONSTRAINT `fk_tbRequisicao_tbVeiculo1`
    FOREIGN KEY (`tbVeiculo_placa`)
    REFERENCES `mydb`.`tbVeiculo` (`placa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbRequisicao_tbCliente1`
    FOREIGN KEY (`tbCliente_CPF`)
    REFERENCES `mydb`.`tbCliente` (`CPF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
