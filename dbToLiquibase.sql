-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema libraryMB_DB
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema libraryMB_DB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `libraryMB_DB` ;
USE `libraryMB_DB` ;

-- -----------------------------------------------------
-- Table `libraryMB_DB`.`enumerations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `libraryMB_DB`.`enumerations` (
  `id_enumerations` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `code` INT NOT NULL,
  `value` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id_enumerations`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `libraryMB_DB`.`type_book`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `libraryMB_DB`.`type_book` (
  `id_type_book` INT NOT NULL AUTO_INCREMENT,
  `fk_id_enumeration` INT NOT NULL,
  PRIMARY KEY (`id_type_book`),
  INDEX `fk_idEnumeration_enumeration_idEnumeration_idx` (`fk_id_enumeration` ASC),
  CONSTRAINT `fk_idEnumeration_enumeration_idEnumeration0`
    FOREIGN KEY (`fk_id_enumeration`)
    REFERENCES `libraryMB_DB`.`enumerations` (`id_enumerations`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `libraryMB_DB`.`authors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `libraryMB_DB`.`authors` (
  `idAuthor` INT NOT NULL AUTO_INCREMENT,
  `author_name` VARCHAR(60) NOT NULL,
  `author_lastName` VARCHAR(60) NOT NULL,
  `birth` YEAR NULL,
  `passed_way` YEAR NULL,
  PRIMARY KEY (`idAuthor`));


-- -----------------------------------------------------
-- Table `libraryMB_DB`.`countries`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `libraryMB_DB`.`countries` (
  `id_country` INT NOT NULL,
  `fk_id_enumeration_country` INT NOT NULL,
  PRIMARY KEY (`id_country`),
  INDEX `fkIdEnumerationCity_enumetations_idEnumerations_idx` (`fk_id_enumeration_country` ASC),
  CONSTRAINT `fkIdEnumerationCountry_enumetations_idEnumerations00`
    FOREIGN KEY (`fk_id_enumeration_country`)
    REFERENCES `libraryMB_DB`.`enumerations` (`id_enumerations`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `libraryMB_DB`.`states`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `libraryMB_DB`.`states` (
  `id_state` INT NOT NULL,
  `fk_id_enumeration_state` INT NOT NULL,
  `fk_id_country` INT NOT NULL,
  PRIMARY KEY (`id_state`),
  INDEX `fkIdEnumerationCity_enumetations_idEnumerations_idx` (`fk_id_enumeration_state` ASC),
  INDEX `fkIdCountry_countries_idCountry_idx` (`fk_id_country` ASC),
  CONSTRAINT `fkIdEnumerationState_enumetations_idEnumerations0`
    FOREIGN KEY (`fk_id_enumeration_state`)
    REFERENCES `libraryMB_DB`.`enumerations` (`id_enumerations`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fkIdCountry_countries_idCountry`
    FOREIGN KEY (`fk_id_country`)
    REFERENCES `libraryMB_DB`.`countries` (`id_country`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `libraryMB_DB`.`cities`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `libraryMB_DB`.`cities` (
  `id_city` INT NOT NULL,
  `fk_id_enumeration_city` INT NOT NULL,
  `fk_id_state` INT NOT NULL,
  PRIMARY KEY (`id_city`),
  INDEX `fkIdEnumerationCity_enumetations_idEnumerations_idx` (`fk_id_enumeration_city` ASC),
  INDEX `fkIdState_states_idState_idx` (`fk_id_state` ASC),
  CONSTRAINT `fkIdEnumerationCity_enumetations_idEnumerations`
    FOREIGN KEY (`fk_id_enumeration_city`)
    REFERENCES `libraryMB_DB`.`enumerations` (`id_enumerations`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fkIdState_states_idState`
    FOREIGN KEY (`fk_id_state`)
    REFERENCES `libraryMB_DB`.`states` (`id_state`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `libraryMB_DB`.`editors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `libraryMB_DB`.`editors` (
  `id_editor` INT(13) NOT NULL,
  `editor_name` VARCHAR(60) NOT NULL,
  `fk_id_city` INT NOT NULL,
  PRIMARY KEY (`id_editor`),
  INDEX `fkIdCity_cities_id_city_idx` (`fk_id_city` ASC),
  CONSTRAINT `fkIdCity_cities_id_city`
    FOREIGN KEY (`fk_id_city`)
    REFERENCES `libraryMB_DB`.`cities` (`id_city`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `libraryMB_DB`.`images_books`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `libraryMB_DB`.`images_books` (
  `id_image` INT NOT NULL AUTO_INCREMENT,
  `image` BLOB NOT NULL,
  PRIMARY KEY (`id_image`));


-- -----------------------------------------------------
-- Table `libraryMB_DB`.`books_editions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `libraryMB_DB`.`books_editions` (
  `id_edition_book` INT NOT NULL AUTO_INCREMENT,
  `isbn` INT(13) NOT NULL,
  `fk_id_author1` INT NOT NULL,
  `fk_id_author2` INT NULL,
  `fk_id_author3` INT NULL,
  `fk_id_editor` INT NOT NULL,
  `publication_year` YEAR NOT NULL,
  `pages_number` INT NOT NULL,
  `edition_number` INT NOT NULL,
  `fk_id_image_book` INT NULL,
  PRIMARY KEY (`id_edition_book`),
  UNIQUE INDEX `isbn_UNIQUE` (`isbn` ASC),
  UNIQUE INDEX `fk_id_author1_UNIQUE` (`fk_id_author1` ASC),
  UNIQUE INDEX `fk_id_author2_UNIQUE` (`fk_id_author2` ASC),
  UNIQUE INDEX `fk_id_author3_UNIQUE` (`fk_id_author3` ASC),
  INDEX `fk_idEditor_editors_idEditor_idx` (`fk_id_editor` ASC),
  INDEX `fk_idImageBook_imagesBooks_idImage_idx` (`fk_id_image_book` ASC),
  CONSTRAINT `fk_idAuthor1_authors_idAuthor`
    FOREIGN KEY (`fk_id_author1`)
    REFERENCES `libraryMB_DB`.`authors` (`idAuthor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_idAuthor2_authors_idAuthor`
    FOREIGN KEY (`fk_id_author2`)
    REFERENCES `libraryMB_DB`.`authors` (`idAuthor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_idAuthor3_authors_idAuthor`
    FOREIGN KEY (`fk_id_author3`)
    REFERENCES `libraryMB_DB`.`authors` (`idAuthor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_idEditor_editors_idEditor`
    FOREIGN KEY (`fk_id_editor`)
    REFERENCES `libraryMB_DB`.`editors` (`id_editor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_idImageBook_imagesBooks_idImage`
    FOREIGN KEY (`fk_id_image_book`)
    REFERENCES `libraryMB_DB`.`images_books` (`id_image`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `libraryMB_DB`.`books`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `libraryMB_DB`.`books` (
  `id_book` INT NOT NULL AUTO_INCREMENT,
  `UDC` VARCHAR(25) NOT NULL,
  `title` VARCHAR(100) NOT NULL,
  `fk_id_edition_book` INT NOT NULL,
  `fk_id_type_book` INT NOT NULL,
  `date_registry` DATE NOT NULL,
  `price` DOUBLE(10,2) NOT NULL,
  PRIMARY KEY (`id_book`),
  UNIQUE INDEX `cdu_unique` (`UDC` ASC),
  INDEX `fk_idTypeBook_typeBook_idTypeBook_idx` (`fk_id_type_book` ASC),
  INDEX `fk_idEditionBook_bookEdition_idEditionBook_idx` (`fk_id_edition_book` ASC),
  CONSTRAINT `fk_idTypeBook_typeBook_idTypeBook`
    FOREIGN KEY (`fk_id_type_book`)
    REFERENCES `libraryMB_DB`.`type_book` (`id_type_book`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_idEditionBook_bookEdition_idEditionBook`
    FOREIGN KEY (`fk_id_edition_book`)
    REFERENCES `libraryMB_DB`.`books_editions` (`id_edition_book`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `libraryMB_DB`.`status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `libraryMB_DB`.`status` (
  `id_status` INT NOT NULL AUTO_INCREMENT,
  `fk_id_enumeration` INT NOT NULL,
  PRIMARY KEY (`id_status`),
  INDEX `fk_idEnumeration_enumeration_idEnumeration_idx` (`fk_id_enumeration` ASC),
  CONSTRAINT `fk_idEnumeration_enumeration_idEnumeration`
    FOREIGN KEY (`fk_id_enumeration`)
    REFERENCES `libraryMB_DB`.`enumerations` (`id_enumerations`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `libraryMB_DB`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `libraryMB_DB`.`user` (
  `id_user` INT NOT NULL AUTO_INCREMENT,
  `user_name` VARCHAR(45) NOT NULL,
  `user_password` BINARY(64) NOT NULL,
  `user_avatar` BLOB NULL,
  `fk_user_status` INT NOT NULL,
  PRIMARY KEY (`id_user`),
  INDEX `fk_userStatus_idx` (`fk_user_status` ASC),
  CONSTRAINT `fk_userStatus`
    FOREIGN KEY (`fk_user_status`)
    REFERENCES `libraryMB_DB`.`status` (`id_status`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `libraryMB_DB`.`address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `libraryMB_DB`.`address` (
  `id_address` INT NOT NULL AUTO_INCREMENT,
  `number` VARCHAR(20) NOT NULL,
  `address_name` VARCHAR(60) NOT NULL,
  `zip_code` VARCHAR(7) NOT NULL,
  `fk_id_city` INT NOT NULL,
  PRIMARY KEY (`id_address`),
  INDEX `fkIdCity_cities_idCity_idx` (`fk_id_city` ASC),
  CONSTRAINT `fkIdCity_cities_idCity`
    FOREIGN KEY (`fk_id_city`)
    REFERENCES `libraryMB_DB`.`cities` (`id_city`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `libraryMB_DB`.`person`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `libraryMB_DB`.`person` (
  `id_person` INT NOT NULL AUTO_INCREMENT,
  `fk_id_user` INT NOT NULL,
  `lastName` VARCHAR(45) NOT NULL,
  `firstName` VARCHAR(45) NOT NULL,
  `birthDay` DATE NOT NULL,
  `fk_id_address` INT NOT NULL,
  `phone` CHAR(10) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `dateRegistry` DATE NOT NULL,
  PRIMARY KEY (`id_person`),
  UNIQUE INDEX `phoneNumber_unique` (`phone` ASC),
  UNIQUE INDEX `email_unique` (`email` ASC),
  UNIQUE INDEX `user_unique` (`fk_id_user` ASC),
  INDEX `fk_idAddress_address_idAddress_idx` (`fk_id_address` ASC),
  CONSTRAINT `fk_idUser_user_idUser`
    FOREIGN KEY (`fk_id_user`)
    REFERENCES `libraryMB_DB`.`user` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_idAddress_address_idAddress`
    FOREIGN KEY (`fk_id_address`)
    REFERENCES `libraryMB_DB`.`address` (`id_address`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `libraryMB_DB`.`type_metting`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `libraryMB_DB`.`type_metting` (
  `id_type_metting` INT NOT NULL,
  `fk_id_enumeration` INT NOT NULL,
  PRIMARY KEY (`id_type_metting`),
  INDEX `fkIdEnumeration_enumeration_idEnumeration_idx` (`fk_id_enumeration` ASC),
  CONSTRAINT `fkIdEnumeration_enumeration_idEnumeration`
    FOREIGN KEY (`fk_id_enumeration`)
    REFERENCES `libraryMB_DB`.`enumerations` (`id_enumerations`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `libraryMB_DB`.`metting_book_person`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `libraryMB_DB`.`metting_book_person` (
  `id_book_person` INT NOT NULL AUTO_INCREMENT,
  `fk_id_book` INT NOT NULL,
  `fk_id_person` INT NOT NULL,
  `date_metting` DATE NOT NULL,
  `fk_id_type_metting` INT NOT NULL,
  `fk_status_metting` INT NOT NULL,
  PRIMARY KEY (`id_book_person`),
  INDEX `idUserRV_Users_idUser` (`fk_id_person` ASC),
  INDEX `idBookRV_Books_idBook` (`fk_id_book` ASC),
  INDEX `fkIdTypeMetting_typeMetting_idTypeMetting_idx` (`fk_id_type_metting` ASC),
  INDEX `fkIdStatusMetting_statusMetting_idStatusMetting_idx` (`fk_status_metting` ASC),
  CONSTRAINT `idUserRV_Users_idUser`
    FOREIGN KEY (`fk_id_person`)
    REFERENCES `libraryMB_DB`.`person` (`id_person`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idBookRV_Books_idBook`
    FOREIGN KEY (`fk_id_book`)
    REFERENCES `libraryMB_DB`.`books` (`id_book`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fkIdTypeMetting_typeMetting_idTypeMetting`
    FOREIGN KEY (`fk_id_type_metting`)
    REFERENCES `libraryMB_DB`.`type_metting` (`id_type_metting`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fkIdStatusMetting_statusMetting_idStatusMetting`
    FOREIGN KEY (`fk_status_metting`)
    REFERENCES `libraryMB_DB`.`status` (`id_status`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `libraryMB_DB`.`borrow`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `libraryMB_DB`.`borrow` (
  `id_borrow` INT NOT NULL AUTO_INCREMENT,
  `id_book` INT NOT NULL,
  `id_person` INT NOT NULL,
  `date_borrow` DATE NOT NULL,
  `date_return` DATE NOT NULL,
  `fk_status_borrow` INT NOT NULL,
  PRIMARY KEY (`id_borrow`),
  INDEX `idBookBor_Books_idBook` (`id_book` ASC),
  INDEX `idUserEm_Users_idUser` (`id_person` ASC),
  INDEX `fkStatusBorrow_statusBorrow_idStatusBorrow_idx` (`fk_status_borrow` ASC),
  CONSTRAINT `idBookBor_Books_idBook`
    FOREIGN KEY (`id_book`)
    REFERENCES `libraryMB_DB`.`books` (`id_book`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idUserEm_Users_idUser`
    FOREIGN KEY (`id_person`)
    REFERENCES `libraryMB_DB`.`person` (`id_person`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fkStatusBorrow_statusBorrow_idStatusBorrow`
    FOREIGN KEY (`fk_status_borrow`)
    REFERENCES `libraryMB_DB`.`status` (`id_status`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `libraryMB_DB`.`reservations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `libraryMB_DB`.`reservations` (
  `id_reservation` INT NOT NULL AUTO_INCREMENT,
  `id_book` INT NOT NULL,
  `id_person` INT NOT NULL,
  `date_reservation` DATE NOT NULL,
  `fk_status_reservation` INT NOT NULL,
  PRIMARY KEY (`id_reservation`),
  INDEX `idUserRes_Users_idUser` (`id_person` ASC),
  INDEX `idBookRes_Books_idBook` (`id_book` ASC),
  INDEX `fkStatusReservation_status_idStatus_idx` (`fk_status_reservation` ASC),
  CONSTRAINT `idUserRes_Users_idUser`
    FOREIGN KEY (`id_person`)
    REFERENCES `libraryMB_DB`.`person` (`id_person`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idBookRes_Books_idBook`
    FOREIGN KEY (`id_book`)
    REFERENCES `libraryMB_DB`.`books` (`id_book`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fkStatusReservation_status_idStatus`
    FOREIGN KEY (`fk_status_reservation`)
    REFERENCES `libraryMB_DB`.`status` (`id_status`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `libraryMB_DB`.`penalties`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `libraryMB_DB`.`penalties` (
  `id_penalty` INT NOT NULL AUTO_INCREMENT,
  `id_person` INT NOT NULL,
  `id_borrow` INT NOT NULL,
  `penalty_date` DATE NOT NULL,
  `value` DOUBLE(10,2) NOT NULL,
  `pay_date` DATE NULL DEFAULT NULL,
  `fk_status_penalty` INT NOT NULL,
  PRIMARY KEY (`id_penalty`),
  INDEX `idUserPenalty_Users_idUser` (`id_person` ASC),
  INDEX `idBorrowAme_Borrow_idBorrow` (`id_borrow` ASC),
  INDEX `fkIdStatusPenalty_statusPenaties_idStatusPenalty_idx` (`fk_status_penalty` ASC),
  CONSTRAINT `idUserPenalty_Users_idUser`
    FOREIGN KEY (`id_person`)
    REFERENCES `libraryMB_DB`.`person` (`id_person`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idBorrowAme_Borrow_idBorrow`
    FOREIGN KEY (`id_borrow`)
    REFERENCES `libraryMB_DB`.`borrow` (`id_borrow`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fkIdStatusPenalty_statusPenaties_idStatusPenalty`
    FOREIGN KEY (`fk_status_penalty`)
    REFERENCES `libraryMB_DB`.`status` (`id_status`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `libraryMB_DB`.`history_books`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `libraryMB_DB`.`history_books` (
  `id_history_books` INT NOT NULL AUTO_INCREMENT,
  `fk_id_book` INT NOT NULL,
  `fk_id_status_book` INT NOT NULL,
  `date_change_status` DATE NOT NULL,
  INDEX `idBook_Books_idBook` (`fk_id_book` ASC),
  PRIMARY KEY (`id_history_books`),
  INDEX `fk_statusBook_statusBook_idStatusBook_idx` (`fk_id_status_book` ASC),
  CONSTRAINT `idBook_Books_idBook`
    FOREIGN KEY (`fk_id_book`)
    REFERENCES `libraryMB_DB`.`books` (`id_book`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_statusBook_statusBook_idStatusBook`
    FOREIGN KEY (`fk_id_status_book`)
    REFERENCES `libraryMB_DB`.`status` (`id_status`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
