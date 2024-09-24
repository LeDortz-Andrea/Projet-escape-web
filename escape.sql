-- MySQL Script generated by MySQL Workbench
-- Mon Oct 16 18:28:02 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema e22104248_db2
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema e22104248_db2
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `e22104248_db2` DEFAULT CHARACTER SET utf8 ;
USE `e22104248_db2` ;

-- -----------------------------------------------------
-- Table `e22104248_db2`.`t_compte_cpt`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `e22104248_db2`.`t_compte_cpt` (
  `cpt_idCompte` INT NOT NULL AUTO_INCREMENT,
  `cpt_MotDePasse` CHAR(64) NOT NULL,
  `cpt_login` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL,
  `cpt_nom` VARCHAR(80) NOT NULL,
  `cpt_prenom` VARCHAR(80) NOT NULL,
  `cpt_role` CHAR(1) NOT NULL,
  `cpt_etat` CHAR(1) NOT NULL,
  PRIMARY KEY (`cpt_idCompte`),
  UNIQUE INDEX `cpt_login_UNIQUE` (`cpt_login` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `e22104248_db2`.`t_actualite_act`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `e22104248_db2`.`t_actualite_act` (
  `act_idActualite` INT NOT NULL AUTO_INCREMENT,
  `act_intitule` VARCHAR(100) NOT NULL,
  `act_description` VARCHAR(200) NOT NULL,
  `act_etat` CHAR(1) NOT NULL,
  `act_date` DATE NOT NULL,
  `cpt_idCompte` INT NOT NULL,
  PRIMARY KEY (`act_idActualite`),
  INDEX `fk_t_actualite_act_t_compte_cpt1_idx` (`cpt_idCompte` ASC) VISIBLE,
  CONSTRAINT `fk_t_actualite_act_t_compte_cpt1`
    FOREIGN KEY (`cpt_idCompte`)
    REFERENCES `e22104248_db2`.`t_compte_cpt` (`cpt_idCompte`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `e22104248_db2`.`t_scenario_sce`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `e22104248_db2`.`t_scenario_sce` (
  `sce_id_scenario` INT NOT NULL AUTO_INCREMENT,
  `sce_intitule` VARCHAR(100) NOT NULL,
  `sce_description` VARCHAR(300) NOT NULL,
  `sce_code` CHAR(15) NOT NULL,
  `sce_etat` CHAR(1) NOT NULL,
  `sce_image` VARCHAR(300) NOT NULL,
  `cpt_idCompte` INT NULL,
  PRIMARY KEY (`sce_id_scenario`),
  INDEX `fk_t_scenario_sce_t_compte_cpt1_idx` (`cpt_idCompte` ASC) VISIBLE,
  CONSTRAINT `fk_t_scenario_sce_t_compte_cpt1`
    FOREIGN KEY (`cpt_idCompte`)
    REFERENCES `e22104248_db2`.`t_compte_cpt` (`cpt_idCompte`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `e22104248_db2`.`t_participant_par`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `e22104248_db2`.`t_participant_par` (
  `par_idParticipant` INT NOT NULL AUTO_INCREMENT,
  `par_mailParticipant` VARCHAR(200) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL,
  PRIMARY KEY (`par_idParticipant`),
  UNIQUE INDEX `par_mailParticipant_UNIQUE` (`par_mailParticipant` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `e22104248_db2`.`t_ressource_res`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `e22104248_db2`.`t_ressource_res` (
  `res_idressource` INT NOT NULL AUTO_INCREMENT,
  `res_chemin` VARCHAR(300) NOT NULL,
  `res_type` CHAR(1) NOT NULL,
  PRIMARY KEY (`res_idressource`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `e22104248_db2`.`t_etape_etp`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `e22104248_db2`.`t_etape_etp` (
  `etp_idEtape` INT NOT NULL AUTO_INCREMENT,
  `etp_ordre` INT NOT NULL,
  `etp_intitule` VARCHAR(100) NOT NULL,
  `etp_descriptif` VARCHAR(200) NOT NULL,
  `etp_code` CHAR(8) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL,
  `etp_question` VARCHAR(200) NOT NULL,
  `etp_reponse` VARCHAR(50) NOT NULL,
  `etp_etat` CHAR(1) NOT NULL,
  `res_idressource` INT NOT NULL,
  `t_scenario_sce_sce_id_scenario` INT NOT NULL,
  PRIMARY KEY (`etp_idEtape`),
  INDEX `fk_t_etape_etp_t_ressource_res1_idx` (`res_idressource` ASC) VISIBLE,
  UNIQUE INDEX `etp_code_UNIQUE` (`etp_code` ASC) VISIBLE,
  INDEX `fk_t_etape_etp_t_scenario_sce1_idx` (`t_scenario_sce_sce_id_scenario` ASC) VISIBLE,
  CONSTRAINT `fk_t_etape_etp_t_ressource_res1`
    FOREIGN KEY (`res_idressource`)
    REFERENCES `e22104248_db2`.`t_ressource_res` (`res_idressource`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_t_etape_etp_t_scenario_sce1`
    FOREIGN KEY (`t_scenario_sce_sce_id_scenario`)
    REFERENCES `e22104248_db2`.`t_scenario_sce` (`sce_id_scenario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `e22104248_db2`.`t_indice_ind`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `e22104248_db2`.`t_indice_ind` (
  `ind_idIndice` INT NOT NULL AUTO_INCREMENT,
  `ind_descriptionIndice` VARCHAR(300) NOT NULL,
  `ind_lienIndice` VARCHAR(300) NOT NULL,
  `ind_niveau` VARCHAR(45) NOT NULL,
  `etp_idEtape` INT NOT NULL,
  PRIMARY KEY (`ind_idIndice`),
  INDEX `fk_t_indice_ind_t_etape_etp1_idx` (`etp_idEtape` ASC) VISIBLE,
  CONSTRAINT `fk_t_indice_ind_t_etape_etp1`
    FOREIGN KEY (`etp_idEtape`)
    REFERENCES `e22104248_db2`.`t_etape_etp` (`etp_idEtape`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `e22104248_db2`.`t_participation_ptc`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `e22104248_db2`.`t_participation_ptc` (
  `par_idParticipant` INT NOT NULL,
  `sce_id_scenario` INT NOT NULL,
  `ptc_datePremiere` DATE NOT NULL,
  `ptc_dateDerniere` DATE NOT NULL,
  `ptc_niveau` INT NOT NULL,
  PRIMARY KEY (`par_idParticipant`, `sce_id_scenario`),
  INDEX `fk_t_participant_par_has_t_scenario_sce_t_scenario_sce1_idx` (`sce_id_scenario` ASC) VISIBLE,
  INDEX `fk_t_participant_par_has_t_scenario_sce_t_participant_par_idx` (`par_idParticipant` ASC) VISIBLE,
  CONSTRAINT `fk_t_participant_par_has_t_scenario_sce_t_participant_par`
    FOREIGN KEY (`par_idParticipant`)
    REFERENCES `e22104248_db2`.`t_participant_par` (`par_idParticipant`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_t_participant_par_has_t_scenario_sce_t_scenario_sce1`
    FOREIGN KEY (`sce_id_scenario`)
    REFERENCES `e22104248_db2`.`t_scenario_sce` (`sce_id_scenario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;