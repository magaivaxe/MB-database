-- MySQL Script generated by MySQL Workbench
-- Sun Aug 26 14:38:02 2018
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema bibliothequeMB_DB
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema bibliothequeMB_DB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `bibliothequeMB_DB` DEFAULT CHARACTER SET utf8mb4 ;
USE `bibliothequeMB_DB` ;

-- -----------------------------------------------------
-- Table `bibliothequeMB_DB`.`Livres`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bibliothequeMB_DB`.`Livres` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `cdu` VARCHAR(15) NOT NULL,
  `titre` VARCHAR(60) NOT NULL,
  `dateRegistre` DATE NOT NULL,
  `typeLivre` ENUM('regulier', 'rare') NULL DEFAULT 'regulier',
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bibliothequeMB_DB`.`Utilisateurs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bibliothequeMB_DB`.`Utilisateurs` (
  `idUtilisateur` VARCHAR(30) NOT NULL COMMENT 'The idUser is the user nickName as: Marcos1234.',
  `nom` VARCHAR(45) NOT NULL,
  `preNom` VARCHAR(45) NOT NULL,
  `dateNe` DATE NOT NULL,
  `adresse` VARCHAR(60) NOT NULL,
  `telephone` CHAR(10) NOT NULL,
  `courriel` VARCHAR(45) NOT NULL UNIQUE,
  `dateRegistre` DATE NOT NULL,
  `role` ENUM('role0', 'role1', 'role2', 'role3') NULL DEFAULT 'role0',
  `statusUT` ENUM('confirme', 'bloque', 'annule') NULL DEFAULT 'bloque',
  PRIMARY KEY (`idUtilisateur`),
  UNIQUE INDEX `phoneNumer_UNIQUE` (`telephone` ASC),
  UNIQUE INDEX `email_UNIQUE` (`courriel` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bibliothequeMB_DB`.`RendezVous`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bibliothequeMB_DB`.`RendezVous` (
  `idRendezVous` INT NOT NULL,
  `idLivre` VARCHAR(20) NOT NULL,
  `idUtilisateur` VARCHAR(30) NOT NULL,
  `datePrevue` DATE NOT NULL,
  `typeRV` ENUM('journee', 'matin', 'apresmidi') NOT NULL,
  `statusRV` ENUM('conclu', 'annule', 'attente') NULL DEFAULT 'attente',
  PRIMARY KEY (`idRendezVous`),
  INDEX `idUser_Users_idUser_idx` (`idUtilisateur` ASC),
  INDEX `idLivreRV_Livres_idLivre_idx` (`idLivre` ASC),
  CONSTRAINT `idUserRV_Users_idUser`
    FOREIGN KEY (`idUtilisateur`)
    REFERENCES `bibliothequeMB_DB`.`Utilisateurs` (`idUtilisateur`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idLivreRV_Livres_idLivre`
    FOREIGN KEY (`idLivre`)
    REFERENCES `bibliothequeMB_DB`.`Livres` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bibliothequeMB_DB`.`Emprunts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bibliothequeMB_DB`.`Emprunts` (
  `idEmprunt` INT NOT NULL,
  `idLivre` VARCHAR(20) NOT NULL,
  `idUtilisateur` VARCHAR(30) NOT NULL,
  `dateEmp` DATE NOT NULL,
  `dateRen` DATE NOT NULL,
  `statusEM` ENUM('cours', 'fini', 'delai') NULL DEFAULT 'cours',
  PRIMARY KEY (`idEmprunt`),
  INDEX `idBookUDC_Books_idBookUDC_idx` (`idLivre` ASC),
  INDEX `idUser_Users_idUser_idx` (`idUtilisateur` ASC),
  CONSTRAINT `idLivreEm_Livres_idLivre`
    FOREIGN KEY (`idLivre`)
    REFERENCES `bibliothequeMB_DB`.`Livres` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idUserEm_Users_idUser`
    FOREIGN KEY (`idUtilisateur`)
    REFERENCES `bibliothequeMB_DB`.`Utilisateurs` (`idUtilisateur`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bibliothequeMB_DB`.`Reservations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bibliothequeMB_DB`.`Reservations` (
  `idReservation` INT NOT NULL,
  `idLivre` VARCHAR(20) NOT NULL,
  `idUtilisateur` VARCHAR(30) NOT NULL,
  `datePrevue` DATE NOT NULL,
  `statusRS` ENUM('fini', 'annule', 'attente') NULL DEFAULT 'attente',
  PRIMARY KEY (`idReservation`),
  INDEX `idUser_Users_idUser_idx` (`idUtilisateur` ASC),
  INDEX `idBookUDC_Books_idBookUDC_idx` (`idLivre` ASC),
  CONSTRAINT `idUserRes_Users_idUser`
    FOREIGN KEY (`idUtilisateur`)
    REFERENCES `bibliothequeMB_DB`.`Utilisateurs` (`idUtilisateur`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idLivreRes_Livres_idLivre`
    FOREIGN KEY (`idLivre`)
    REFERENCES `bibliothequeMB_DB`.`Livres` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bibliothequeMB_DB`.`UsersMotDePasse`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bibliothequeMB_DB`.`UsersMotDePasse` (
  `idUtilisateur` VARCHAR(30) NOT NULL,
  `mdpEncripte` BLOB NOT NULL,
  PRIMARY KEY (`idUtilisateur`),
  CONSTRAINT `idUserMDP_Users_idUser`
    FOREIGN KEY (`idUtilisateur`)
    REFERENCES `bibliothequeMB_DB`.`Utilisateurs` (`idUtilisateur`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bibliothequeMB_DB`.`Editions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bibliothequeMB_DB`.`Editions` (
  `isbn` INT(13) NOT NULL,
  `maisonPub` VARCHAR(45) NULL,
  `edition` INT NULL DEFAULT 1,
  `villePub` VARCHAR(30) NULL,
  `anneePub` YEAR NULL,
  `pages` INT NOT NULL,
  `prix` DOUBLE(10,2) NULL DEFAULT 0.00,
  PRIMARY KEY (`isbn`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bibliothequeMB_DB`.`ImagesLivres`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bibliothequeMB_DB`.`ImagesLivres` (
  `isbn` INT(13) NOT NULL,
  `image` BLOB NULL,
  PRIMARY KEY (`isbn`),
  CONSTRAINT `isbn_Edition_isbn`
    FOREIGN KEY (`isbn`)
    REFERENCES `bibliothequeMB_DB`.`Editions` (`isbn`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bibliothequeMB_DB`.`Amendes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bibliothequeMB_DB`.`Amendes` (
  `idAmende` INT NOT NULL AUTO_INCREMENT,
  `idUtilisateur` VARCHAR(30) NOT NULL,
  `idEmprunts` INT NOT NULL,
  `dateAmende` DATE NOT NULL,
  `valeur` DOUBLE(10,2) NOT NULL,
  `datePaye` DATE NULL,
  `statusAM` ENUM('ouverte', 'paye') NULL DEFAULT 'ouverte',
  PRIMARY KEY (`idAmende`),
  INDEX `idUser_Users_idUser_idx` (`idUtilisateur` ASC),
  INDEX `idBorrow_Borrows_idBorrow_idx` (`idEmprunts` ASC),
  CONSTRAINT `idUserAmen_Users_idUser`
    FOREIGN KEY (`idUtilisateur`)
    REFERENCES `bibliothequeMB_DB`.`Utilisateurs` (`idUtilisateur`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idEmpruntsAme_Emprunts_idEmprunts`
    FOREIGN KEY (`idEmprunts`)
    REFERENCES `bibliothequeMB_DB`.`Emprunts` (`idEmprunt`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bibliothequeMB_DB`.`Auteurs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bibliothequeMB_DB`.`Auteurs` (
  `idAuteur` INT NOT NULL,
  `p_a_PreNom` VARCHAR(45) NOT NULL,
  `p_a_Nom` VARCHAR(45) NOT NULL,
  `anneeNe` YEAR NULL,
  `anneeMort` YEAR NULL,
  `s_a_PreNom` VARCHAR(45) NULL,
  `s_a_Nom` VARCHAR(45) NULL,
  `t_a_PreNom` VARCHAR(45) NULL,
  `t_a_Nom` VARCHAR(45) NULL,
  PRIMARY KEY (`idAuteur`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bibliothequeMB_DB`.`HistoriquesLivres`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bibliothequeMB_DB`.`HistoriquesLivres` (
  `idLivre` VARCHAR(20) NOT NULL,
  `statusHL` ENUM('archive mort', 'renovation', 'perdu') NOT NULL,
  `dateStatus` DATE NOT NULL,
  INDEX `id_livre_Livres_idLivre_idx` (`idLivre` ASC),
  CONSTRAINT `id_livre_Livres_idLivre`
    FOREIGN KEY (`idLivre`)
    REFERENCES `bibliothequeMB_DB`.`Livres` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bibliothequeMB_DB`.`Livres_Editions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bibliothequeMB_DB`.`Livres_Editions` (
  `isbn` INT(13) NOT NULL,
  `idLivre` VARCHAR(20) NOT NULL,
  `idAuteur` INT NOT NULL,
  INDEX `idLivre_idx` (`idLivre` ASC),
  INDEX `idAuteur_idx` (`idAuteur` ASC),
  CONSTRAINT `isbn`
    FOREIGN KEY (`isbn`)
    REFERENCES `bibliothequeMB_DB`.`Editions` (`isbn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idLivre`
    FOREIGN KEY (`idLivre`)
    REFERENCES `bibliothequeMB_DB`.`Livres` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idAuteur`
    FOREIGN KEY (`idAuteur`)
    REFERENCES `bibliothequeMB_DB`.`Auteurs` (`idAuteur`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `bibliothequeMB_DB` ;


CREATE USER 'role0' IDENTIFIED BY 'role0';

CREATE USER 'role1' IDENTIFIED BY 'role1';

CREATE USER 'role2' IDENTIFIED BY 'role2';

CREATE USER 'role3' IDENTIFIED BY 'role3';

GRANT ALL ON TABLE bibliothequeMB_DB.* TO 'role3';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;