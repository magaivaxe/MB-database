
-- -----------------------------------------------------
-- Schema libraryMB_DB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `libraryMB_DB`;
USE `libraryMB_DB`;

-- -----------------------------------------------------
-- Table `libraryMB_DB`.`Books`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `libraryMB_DB`.`Books` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `cdu` VARCHAR(15) NOT NULL,
  `title` VARCHAR(60) NOT NULL,
  `dateRegistry` DATE NOT NULL,
  `typeBook` ENUM('regular', 'rare') NULL DEFAULT 'regular',
  PRIMARY KEY (`id`),
  UNIQUE KEY `cdu_unique` (`cdu`)
);


-- -----------------------------------------------------
-- Table `libraryMB_DB`.`User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `libraryMB_DB`.`User` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT,
  `user` VARCHAR(30) NOT NULL,
  `lastName` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `birthDay` DATE NOT NULL,
  `address` VARCHAR(60) NOT NULL,
  `phone` CHAR(10) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `dateRegistry` DATE NOT NULL,
  `status` ENUM('open', 'bloqued', 'cancelled') NULL DEFAULT 'open',
  PRIMARY KEY (`id`),
  UNIQUE KEY `phoneNumber_unique` (`phone`),
  UNIQUE KEY `email_unique` (`email`),
  UNIQUE KEY `user_unique` (`user`)
);


-- -----------------------------------------------------
-- Table `libraryMB_DB`.`Metting`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `libraryMB_DB`.`Metting` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `idBook` INT NOT NULL,
  `idUser` INT NOT NULL,
  `dateMetting` DATE NOT NULL,
  `typeMetting` ENUM('day', 'morning', 'afternoon') NOT NULL,
  `statusMetting` ENUM('finished', 'cancelled', 'waiting') NULL DEFAULT 'waiting',
  PRIMARY KEY (`id`),
  CONSTRAINT `idUserRV_Users_idUser`
    FOREIGN KEY (`idUser`)
    REFERENCES `libraryMB_DB`.`User` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idBookRV_Books_idBook`
    FOREIGN KEY (`idBook`)
    REFERENCES `libraryMB_DB`.`Books` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);


-- -----------------------------------------------------
-- Table `libraryMB_DB`.`Borrow`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `libraryMB_DB`.`Borrow` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `idBook` INT NOT NULL,
  `idUser` INT NOT NULL,
  `dateBorrow` DATE NOT NULL,
  `dateReturn` DATE NOT NULL,
  `statusBorrow` ENUM('open', 'closed', 'delay') NULL DEFAULT 'open',
  PRIMARY KEY (`id`),
  CONSTRAINT `idBookBor_Books_idBook`
    FOREIGN KEY (`idBook`)
    REFERENCES `libraryMB_DB`.`Books` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idUserEm_Users_idUser`
    FOREIGN KEY (`idUser`)
    REFERENCES `libraryMB_DB`.`User` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);


-- -----------------------------------------------------
-- Table `libraryMB_DB`.`Reservations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `libraryMB_DB`.`Reservations` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `idBook` INT NOT NULL,
  `idUser` INT NOT NULL,
  `dateReservation` DATE NOT NULL,
  `statusReservation` ENUM('finished', 'cancelled', 'waiting') NULL DEFAULT 'waiting',
  PRIMARY KEY (`id`),
  CONSTRAINT `idUserRes_Users_idUser`
    FOREIGN KEY (`idUser`)
    REFERENCES `libraryMB_DB`.`User` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idBookRes_Books_idBook`
    FOREIGN KEY (`idBook`)
    REFERENCES `libraryMB_DB`.`Books` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);


-- -----------------------------------------------------
-- Table `libraryMB_DB`.`UsersPassword`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `libraryMB_DB`.`UsersPassword` (
  `idUser` INT NOT NULL,
  `EncryptedPW` BLOB NOT NULL,
  PRIMARY KEY (`idUser`),
  CONSTRAINT `idUserPW_Users_idUser`
    FOREIGN KEY (`idUser`)
    REFERENCES `libraryMB_DB`.`User` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);


-- -----------------------------------------------------
-- Table `libraryMB_DB`.`Editions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `libraryMB_DB`.`Editions` (
  `isbn` INT(13) NOT NULL,
  `editor` VARCHAR(45) NULL,
  `edition` INT NULL DEFAULT 1,
  `city` VARCHAR(30) NULL,
  `yearPub` YEAR NULL,
  `pages` INT NOT NULL,
  `price` DOUBLE(10,2) NULL DEFAULT 0.00,
  PRIMARY KEY (`isbn`)
);


-- -----------------------------------------------------
-- Table `libraryMB_DB`.`ImagesBooks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `libraryMB_DB`.`ImagesBooks` (
  `isbn` INT(13) NOT NULL,
  `image` BLOB NULL,
  PRIMARY KEY (`isbn`),
  CONSTRAINT `isbn_Edition_isbn`
    FOREIGN KEY (`isbn`)
    REFERENCES `libraryMB_DB`.`Editions` (`isbn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);


-- -----------------------------------------------------
-- Table `libraryMB_DB`.`Penalties`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `libraryMB_DB`.`Penalties` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `idUser` INT NOT NULL,
  `idBorrow` INT NOT NULL,
  `datePenalty` DATE NOT NULL,
  `value` DOUBLE(10,2) NOT NULL,
  `datePay` DATE NULL,
  `statusPenalty` ENUM('open', 'payed') NULL DEFAULT 'open',
  PRIMARY KEY (`id`),
  CONSTRAINT `idUserPenalty_Users_idUser`
    FOREIGN KEY (`idUser`)
    REFERENCES `libraryMB_DB`.`User` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idBorrowAme_Borrow_idBorrow`
    FOREIGN KEY (`idBorrow`)
    REFERENCES `libraryMB_DB`.`Borrow` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);


-- -----------------------------------------------------
-- Table `libraryMB_DB`.`Authors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `libraryMB_DB`.`Authors` (
  `idAuthor` INT NOT NULL AUTO_INCREMENT,
  `p_a_name` VARCHAR(45) NOT NULL,
  `p_a_lastName` VARCHAR(45) NOT NULL,
  `birth` YEAR NULL,
  `passAway` YEAR NULL,
  `s_a_name` VARCHAR(45) NULL,
  `s_a_lastName` VARCHAR(45) NULL,
  `t_a_name` VARCHAR(45) NULL,
  `t_a_lastName` VARCHAR(45) NULL,
  PRIMARY KEY (`idAuthor`)
);


-- -----------------------------------------------------
-- Table `libraryMB_DB`.`HistoryBooks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `libraryMB_DB`.`HistoryBooks` (
  `idBook` INT NOT NULL,
  `statusHB` ENUM('dead archive', 'renovation', 'lost') NOT NULL,
  `dateStatus` DATE NOT NULL,
  CONSTRAINT `idBook_Books_idBook`
    FOREIGN KEY (`idBook`)
    REFERENCES `libraryMB_DB`.`Books` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);


-- -----------------------------------------------------
-- Table `libraryMB_DB`.`Books_Editions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `libraryMB_DB`.`Books_Editions` (
  `isbn` INT(13) NOT NULL,
  `idBook` INT NOT NULL,
  `idAuthor` INT NOT NULL,
  CONSTRAINT `isbn`
    FOREIGN KEY (`isbn`)
    REFERENCES `libraryMB_DB`.`Editions` (`isbn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idBook`
    FOREIGN KEY (`idBook`)
    REFERENCES `libraryMB_DB`.`Books` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idAuthor`
    FOREIGN KEY (`idAuthor`)
    REFERENCES `libraryMB_DB`.`Authors` (`idAuthor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);
