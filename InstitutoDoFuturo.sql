-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema institutodofuturo
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema institutodofuturo
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `institutodofuturo` DEFAULT CHARACTER SET utf8 ;
USE `institutodofuturo` ;

-- -----------------------------------------------------
-- Table `institutodofuturo`.`Pessoa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `institutodofuturo`.`Pessoa` (
  `CPF` INT(11) UNSIGNED NOT NULL,
  `RG` INT(9) UNSIGNED NOT NULL,
  `PIS/PASEP` INT(11) UNSIGNED NOT NULL,
  `NomeCompleto` VARCHAR(45) NOT NULL,
  `DataNascimento` DATE NOT NULL,
  `FuncDoInstituto` TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
  `Profissão` VARCHAR(30) NULL,
  `Empresa` VARCHAR(30) NULL,
  PRIMARY KEY (`CPF`),
  UNIQUE INDEX `RG_UNIQUE` (`RG` ASC) VISIBLE,
  UNIQUE INDEX `PIS/PASEP_UNIQUE` (`PIS/PASEP` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `institutodofuturo`.`PessoaTelefones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `institutodofuturo`.`PessoaTelefones` (
  `CodPessoaTelefone` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Pessoa_CPF` INT(11) UNSIGNED NOT NULL,
  `DDD` INT(2) UNSIGNED NOT NULL,
  `NumTelefone` INT(9) UNSIGNED NOT NULL,
  PRIMARY KEY (`CodPessoaTelefone`, `Pessoa_CPF`),
  INDEX `fk_PessoaTelefones_Pessoa1_idx` (`Pessoa_CPF` ASC) VISIBLE,
  CONSTRAINT `fk_PessoaTelefones_Pessoa1`
    FOREIGN KEY (`Pessoa_CPF`)
    REFERENCES `institutodofuturo`.`Pessoa` (`CPF`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `institutodofuturo`.`PessoaEmails`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `institutodofuturo`.`PessoaEmails` (
  `CodPessoaEmail` INT NOT NULL,
  `Pessoa_CPF` INT(11) UNSIGNED NOT NULL,
  `Email` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`CodPessoaEmail`, `Pessoa_CPF`),
  INDEX `fk_PessoaEmails_Pessoa1_idx` (`Pessoa_CPF` ASC) VISIBLE,
  CONSTRAINT `fk_PessoaEmails_Pessoa1`
    FOREIGN KEY (`Pessoa_CPF`)
    REFERENCES `institutodofuturo`.`Pessoa` (`CPF`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `institutodofuturo`.`Funcoes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `institutodofuturo`.`Funcoes` (
  `CodFuncao` INT NOT NULL AUTO_INCREMENT,
  `NomeFuncao` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`CodFuncao`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `institutodofuturo`.`IntegranteCorpoTecnico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `institutodofuturo`.`IntegranteCorpoTecnico` (
  `CodIntegrante` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `CPF` INT(11) UNSIGNED NOT NULL,
  `Funcao` INT NOT NULL,
  `HorasNoProjeto` SMALLINT(5) UNSIGNED NOT NULL,
  PRIMARY KEY (`CodIntegrante`, `CPF`),
  INDEX `fk_IntegranteCorpoTecnico_Funcoes1_idx` (`Funcao` ASC) VISIBLE,
  INDEX `fk_IntegranteCorpoTecnico_Pessoa1_idx` (`CPF` ASC) VISIBLE,
  CONSTRAINT `fk_IntegranteCorpoTecnico_Funcoes1`
    FOREIGN KEY (`Funcao`)
    REFERENCES `institutodofuturo`.`Funcoes` (`CodFuncao`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_IntegranteCorpoTecnico_Pessoa1`
    FOREIGN KEY (`CPF`)
    REFERENCES `institutodofuturo`.`Pessoa` (`CPF`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `institutodofuturo`.`FuncionarioInstituto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `institutodofuturo`.`FuncionarioInstituto` (
  `CodFuncionario` INT NOT NULL AUTO_INCREMENT,
  `CPF` INT(11) UNSIGNED NOT NULL,
  PRIMARY KEY (`CodFuncionario`, `CPF`),
  INDEX `fk_FuncionarioInstituto_Pessoa1_idx` (`CPF` ASC) VISIBLE,
  CONSTRAINT `fk_FuncionarioInstituto_Pessoa1`
    FOREIGN KEY (`CPF`)
    REFERENCES `institutodofuturo`.`Pessoa` (`CPF`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `institutodofuturo`.`PaginaWeb`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `institutodofuturo`.`PaginaWeb` (
  `Link` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Link`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `institutodofuturo`.`Tema`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `institutodofuturo`.`Tema` (
  `CodTema` INT NOT NULL AUTO_INCREMENT,
  `FuncionarioCoordenador` INT NOT NULL,
  `PaginaWeb_Link` VARCHAR(45) NOT NULL,
  `Título` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`CodTema`),
  INDEX `fk_Tema_FuncionarioInstituto1_idx` (`FuncionarioCoordenador` ASC) VISIBLE,
  INDEX `fk_Tema_PaginaWeb1_idx` (`PaginaWeb_Link` ASC) VISIBLE,
  CONSTRAINT `fk_Tema_FuncionarioInstituto1`
    FOREIGN KEY (`FuncionarioCoordenador`)
    REFERENCES `institutodofuturo`.`FuncionarioInstituto` (`CodFuncionario`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Tema_PaginaWeb1`
    FOREIGN KEY (`PaginaWeb_Link`)
    REFERENCES `institutodofuturo`.`PaginaWeb` (`Link`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `institutodofuturo`.`Comite`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `institutodofuturo`.`Comite` (
  `CodComite` INT NOT NULL AUTO_INCREMENT,
  `Tema_CodTema` INT NOT NULL,
  PRIMARY KEY (`CodComite`),
  INDEX `fk_Comite_Tema1_idx` (`Tema_CodTema` ASC) VISIBLE,
  CONSTRAINT `fk_Comite_Tema1`
    FOREIGN KEY (`Tema_CodTema`)
    REFERENCES `institutodofuturo`.`Tema` (`CodTema`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `institutodofuturo`.`Escalas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `institutodofuturo`.`Escalas` (
  `CodEscala` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `DescricaoEscala` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`CodEscala`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `institutodofuturo`.`Situacoes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `institutodofuturo`.`Situacoes` (
  `CodSituacao` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `DescricaoSituacao` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`CodSituacao`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `institutodofuturo`.`TiposLocal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `institutodofuturo`.`TiposLocal` (
  `IdTiposLocal` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `DescricaoLocal` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`IdTiposLocal`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `institutodofuturo`.`Espaco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `institutodofuturo`.`Espaco` (
  `IdentificacaoEspaco` INT UNSIGNED NOT NULL,
  `TipoLocal` INT UNSIGNED NOT NULL,
  `PaginaWeb_Link` VARCHAR(45) NOT NULL,
  `Capacidade` INT(5) UNSIGNED NOT NULL,
  `CEP` INT(8) UNSIGNED NOT NULL,
  `Estado` CHAR(2) NOT NULL,
  `Bairro` VARCHAR(45) NOT NULL,
  `Rua` VARCHAR(45) NOT NULL,
  `Número` INT(8) UNSIGNED NULL,
  `HorariosFuncionamento` VARCHAR(45) NULL DEFAULT 'Seg - Sex (00:00 - 00:00)',
  PRIMARY KEY (`IdentificacaoEspaco`),
  INDEX `fk_Espaco_TiposLocal1_idx` (`TipoLocal` ASC) VISIBLE,
  INDEX `fk_Espaco_PaginaWeb1_idx` (`PaginaWeb_Link` ASC) VISIBLE,
  CONSTRAINT `fk_Espaco_TiposLocal1`
    FOREIGN KEY (`TipoLocal`)
    REFERENCES `institutodofuturo`.`TiposLocal` (`IdTiposLocal`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Espaco_PaginaWeb1`
    FOREIGN KEY (`PaginaWeb_Link`)
    REFERENCES `institutodofuturo`.`PaginaWeb` (`Link`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `institutodofuturo`.`Projeto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `institutodofuturo`.`Projeto` (
  `CodProjeto` INT NOT NULL AUTO_INCREMENT,
  `CodEscala` INT UNSIGNED NOT NULL,
  `Situacao` INT UNSIGNED NOT NULL,
  `CodComiteSupervisor` INT NOT NULL,
  `Tema` INT NOT NULL,
  `IdentificacaoEspaco` INT UNSIGNED NOT NULL,
  `PaginaWeb_Link` VARCHAR(45) NOT NULL,
  `Titulo` VARCHAR(45) NOT NULL,
  `DataInicio` DATE NOT NULL,
  `DataTermino` DATE NOT NULL COMMENT 'Data de término prevista do projeto.',
  `Orcamento` DECIMAL(9,2) UNSIGNED NOT NULL,
  `DocumentoPropostaGeral` MEDIUMBLOB NOT NULL,
  `DocumentoDetalhado` MEDIUMBLOB NOT NULL,
  PRIMARY KEY (`CodProjeto`),
  INDEX `fk_Projeto_Escalas1_idx` (`CodEscala` ASC) VISIBLE,
  INDEX `fk_Projeto_Situacoes1_idx` (`Situacao` ASC) VISIBLE,
  INDEX `fk_Projeto_Comite1_idx` (`CodComiteSupervisor` ASC) VISIBLE,
  INDEX `fk_Projeto_Tema1_idx` (`Tema` ASC) VISIBLE,
  INDEX `fk_Projeto_Espaco1_idx` (`IdentificacaoEspaco` ASC) VISIBLE,
  INDEX `fk_Projeto_PaginaWeb1_idx` (`PaginaWeb_Link` ASC) VISIBLE,
  CONSTRAINT `fk_Projeto_Escalas1`
    FOREIGN KEY (`CodEscala`)
    REFERENCES `institutodofuturo`.`Escalas` (`CodEscala`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Projeto_Situacoes1`
    FOREIGN KEY (`Situacao`)
    REFERENCES `institutodofuturo`.`Situacoes` (`CodSituacao`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Projeto_Comite1`
    FOREIGN KEY (`CodComiteSupervisor`)
    REFERENCES `institutodofuturo`.`Comite` (`CodComite`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Projeto_Tema1`
    FOREIGN KEY (`Tema`)
    REFERENCES `institutodofuturo`.`Tema` (`CodTema`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Projeto_Espaco1`
    FOREIGN KEY (`IdentificacaoEspaco`)
    REFERENCES `institutodofuturo`.`Espaco` (`IdentificacaoEspaco`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Projeto_PaginaWeb1`
    FOREIGN KEY (`PaginaWeb_Link`)
    REFERENCES `institutodofuturo`.`PaginaWeb` (`Link`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `institutodofuturo`.`Areas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `institutodofuturo`.`Areas` (
  `CodArea` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `NomeArea` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`CodArea`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `institutodofuturo`.`Coordenador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `institutodofuturo`.`Coordenador` (
  `Projeto_CodProjeto` INT NOT NULL,
  `Pessoa_CPF` INT(11) UNSIGNED NOT NULL,
  `DataInicioCoordenacao` DATE NOT NULL,
  `DataFimCoordenacao` DATE NULL,
  PRIMARY KEY (`Projeto_CodProjeto`, `Pessoa_CPF`),
  INDEX `fk_Coordenador_Projeto1_idx` (`Projeto_CodProjeto` ASC) VISIBLE,
  INDEX `fk_Coordenador_Pessoa1_idx` (`Pessoa_CPF` ASC) VISIBLE,
  CONSTRAINT `fk_Pessoa_has_Projeto_Pessoa1`
    FOREIGN KEY (`Pessoa_CPF`)
    REFERENCES `institutodofuturo`.`Pessoa` (`CPF`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Pessoa_has_Projeto_Projeto1`
    FOREIGN KEY (`Projeto_CodProjeto`)
    REFERENCES `institutodofuturo`.`Projeto` (`CodProjeto`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `institutodofuturo`.`ParticipantesComite`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `institutodofuturo`.`ParticipantesComite` (
  `Comite_CodComite` INT NOT NULL,
  `Pessoa_CPF` INT(11) UNSIGNED NOT NULL,
  PRIMARY KEY (`Comite_CodComite`, `Pessoa_CPF`),
  INDEX `fk_ParticipantesComite_Comite1_idx` (`Comite_CodComite` ASC) VISIBLE,
  INDEX `fk_ParticipantesComite_Pessoa1_idx` (`Pessoa_CPF` ASC) VISIBLE,
  CONSTRAINT `fk_Pessoa_has_Comite_Pessoa1`
    FOREIGN KEY (`Pessoa_CPF`)
    REFERENCES `institutodofuturo`.`Pessoa` (`CPF`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Pessoa_has_Comite_Comite1`
    FOREIGN KEY (`Comite_CodComite`)
    REFERENCES `institutodofuturo`.`Comite` (`CodComite`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `institutodofuturo`.`ParticipantesProjeto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `institutodofuturo`.`ParticipantesProjeto` (
  `IntegranteCorpoTecnico_CodIntegrante` INT UNSIGNED NOT NULL,
  `Projeto_CodProjeto` INT NOT NULL,
  `DataInicioParticipacao` DATE NOT NULL,
  `DataFimParticipacao` DATE NULL,
  PRIMARY KEY (`IntegranteCorpoTecnico_CodIntegrante`, `Projeto_CodProjeto`),
  INDEX `fk_ParticipantesProjeto_IntegranteCorpoTecnico_idx` (`IntegranteCorpoTecnico_CodIntegrante` ASC) VISIBLE,
  INDEX `fk_ParticipantesProjeto_Projeto1_idx` (`Projeto_CodProjeto` ASC) VISIBLE,
  CONSTRAINT `fk_Projeto_has_IntegranteCorpoTecnico_Projeto1`
    FOREIGN KEY (`Projeto_CodProjeto`)
    REFERENCES `institutodofuturo`.`Projeto` (`CodProjeto`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Projeto_has_IntegranteCorpoTecnico_IntegranteCorpoTecnico1`
    FOREIGN KEY (`IntegranteCorpoTecnico_CodIntegrante`)
    REFERENCES `institutodofuturo`.`IntegranteCorpoTecnico` (`CodIntegrante`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `institutodofuturo`.`AreasTema`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `institutodofuturo`.`AreasTema` (
  `Tema_CodTema` INT NOT NULL,
  `Areas_CodArea` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`Tema_CodTema`, `Areas_CodArea`),
  INDEX `fk_AreasTema_Tema1_idx` (`Tema_CodTema` ASC) VISIBLE,
  INDEX `fk_AreasTema_Areas1_idx` (`Areas_CodArea` ASC) VISIBLE,
  CONSTRAINT `fk_Areas_has_Tema_Areas1`
    FOREIGN KEY (`Areas_CodArea`)
    REFERENCES `institutodofuturo`.`Areas` (`CodArea`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Areas_has_Tema_Tema1`
    FOREIGN KEY (`Tema_CodTema`)
    REFERENCES `institutodofuturo`.`Tema` (`CodTema`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `institutodofuturo`.`TipoResultado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `institutodofuturo`.`TipoResultado` (
  `CodTipo` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `NomeTipo` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`CodTipo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `institutodofuturo`.`DocumentoResultado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `institutodofuturo`.`DocumentoResultado` (
  `CodDocumento` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `NumeroIndexacao` INT NULL,
  `Titulo` VARCHAR(45) NOT NULL,
  `CorpoTexto` MEDIUMTEXT NOT NULL,
  `PalavrasChave` TEXT NOT NULL,
  PRIMARY KEY (`CodDocumento`),
  UNIQUE INDEX `NumeroIndexacao_UNIQUE` (`NumeroIndexacao` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `institutodofuturo`.`Resultado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `institutodofuturo`.`Resultado` (
  `CodResultado` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `TipoResultado` INT UNSIGNED NOT NULL,
  `PaginaWeb_Link` VARCHAR(45) NOT NULL,
  `DocumentoResultado` INT UNSIGNED NULL,
  `DataPublicacao` DATE NOT NULL,
  `Resumo` MEDIUMTEXT NOT NULL,
  PRIMARY KEY (`CodResultado`),
  INDEX `fk_Resultado_TipoResultado1_idx` (`TipoResultado` ASC) VISIBLE,
  INDEX `fk_Resultado_PaginaWeb1_idx` (`PaginaWeb_Link` ASC) VISIBLE,
  INDEX `fk_Resultado_DocumentoResultado1_idx` (`DocumentoResultado` ASC) VISIBLE,
  CONSTRAINT `fk_Resultado_TipoResultado1`
    FOREIGN KEY (`TipoResultado`)
    REFERENCES `institutodofuturo`.`TipoResultado` (`CodTipo`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Resultado_PaginaWeb1`
    FOREIGN KEY (`PaginaWeb_Link`)
    REFERENCES `institutodofuturo`.`PaginaWeb` (`Link`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Resultado_DocumentoResultado1`
    FOREIGN KEY (`DocumentoResultado`)
    REFERENCES `institutodofuturo`.`DocumentoResultado` (`CodDocumento`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `institutodofuturo`.`Premios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `institutodofuturo`.`Premios` (
  `CodPremio` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `NomePremio` VARCHAR(45) NOT NULL,
  `DataEntrega` DATE NOT NULL,
  PRIMARY KEY (`CodPremio`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `institutodofuturo`.`PremiosResultado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `institutodofuturo`.`PremiosResultado` (
  `Premios_CodPremio` INT UNSIGNED NOT NULL,
  `Resultado_CodResultado` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`Premios_CodPremio`, `Resultado_CodResultado`),
  INDEX `fk_Resultado_has_Premios_Premios1_idx` (`Premios_CodPremio` ASC) VISIBLE,
  INDEX `fk_Resultado_has_Premios_Resultado1_idx` (`Resultado_CodResultado` ASC) VISIBLE,
  CONSTRAINT `fk_Resultado_has_Premios_Resultado1`
    FOREIGN KEY (`Resultado_CodResultado`)
    REFERENCES `institutodofuturo`.`Resultado` (`CodResultado`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Resultado_has_Premios_Premios1`
    FOREIGN KEY (`Premios_CodPremio`)
    REFERENCES `institutodofuturo`.`Premios` (`CodPremio`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `institutodofuturo`.`LocaisPublicacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `institutodofuturo`.`LocaisPublicacao` (
  `CodPublicacao` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `DocumentoResultado` INT UNSIGNED NOT NULL,
  `NomeLocal` VARCHAR(45) NOT NULL,
  `DataPublicacao` DATE NOT NULL,
  PRIMARY KEY (`CodPublicacao`, `DocumentoResultado`),
  INDEX `fk_LocaisPublicacao_DocumentoResultado1_idx` (`DocumentoResultado` ASC) VISIBLE,
  CONSTRAINT `fk_LocaisPublicacao_DocumentoResultado1`
    FOREIGN KEY (`DocumentoResultado`)
    REFERENCES `institutodofuturo`.`DocumentoResultado` (`CodDocumento`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `institutodofuturo`.`Citacoes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `institutodofuturo`.`Citacoes` (
  `CodCitacao` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `DocumentoResultado` INT UNSIGNED NOT NULL,
  `LocalCitacao` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`CodCitacao`, `DocumentoResultado`),
  INDEX `fk_Citacoes_DocumentoResultado1_idx` (`DocumentoResultado` ASC) VISIBLE,
  CONSTRAINT `fk_Citacoes_DocumentoResultado1`
    FOREIGN KEY (`DocumentoResultado`)
    REFERENCES `institutodofuturo`.`DocumentoResultado` (`CodDocumento`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `institutodofuturo`.`EspacoEmails`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `institutodofuturo`.`EspacoEmails` (
  `CodEspacoEmail` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `IdentificacaoEspaco` INT UNSIGNED NOT NULL,
  `Email` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`CodEspacoEmail`, `IdentificacaoEspaco`),
  INDEX `fk_EspacoEmails_Espaco1_idx` (`IdentificacaoEspaco` ASC) VISIBLE,
  CONSTRAINT `fk_EspacoEmails_Espaco1`
    FOREIGN KEY (`IdentificacaoEspaco`)
    REFERENCES `institutodofuturo`.`Espaco` (`IdentificacaoEspaco`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `institutodofuturo`.`EspacoTelefones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `institutodofuturo`.`EspacoTelefones` (
  `CodEspacoTelefone` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `IdentificacaoEspaco` INT UNSIGNED NOT NULL,
  `DDD` INT(2) UNSIGNED NOT NULL,
  `Telefone` INT(9) UNSIGNED NOT NULL,
  PRIMARY KEY (`CodEspacoTelefone`, `IdentificacaoEspaco`),
  INDEX `fk_EspacoTelefones_Espaco1_idx` (`IdentificacaoEspaco` ASC) VISIBLE,
  CONSTRAINT `fk_EspacoTelefones_Espaco1`
    FOREIGN KEY (`IdentificacaoEspaco`)
    REFERENCES `institutodofuturo`.`Espaco` (`IdentificacaoEspaco`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
