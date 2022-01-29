-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema agriculturedb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema agriculturedb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `agriculturedb` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `agriculturedb` ;

-- -----------------------------------------------------
-- Table `agriculturedb`.`role`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `agriculturedb`.`role` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `admin` TEXT(10) NOT NULL,
  `personnel` INT NOT NULL,
  `farmer` TEXT(10) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `agriculturedb`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `agriculturedb`.`user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `middle_name` VARCHAR(45) NOT NULL,
  `address` VARCHAR(255) NOT NULL,
  `mobile_number` BIGINT(11) NOT NULL,
  `role` ENUM('personnel', 'admin', 'farmer') NOT NULL,
  `age` INT(5) NOT NULL,
  `sex` ENUM('male', 'female') NOT NULL,
  `birth_date` DATETIME NOT NULL,
  `date_created` DATETIME NOT NULL,
  `role_id` INT NOT NULL,
  `is_verified` TINYINT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_user_role_idx` (`role_id` ASC) VISIBLE,
  CONSTRAINT `fk_user_role`
    FOREIGN KEY (`role_id`)
    REFERENCES `agriculturedb`.`role` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `agriculturedb`.`personnel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `agriculturedb`.`personnel` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `role_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_personnel_role1_idx` (`role_id` ASC) VISIBLE,
  CONSTRAINT `fk_personnel_role1`
    FOREIGN KEY (`role_id`)
    REFERENCES `agriculturedb`.`role` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `agriculturedb`.`admin`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `agriculturedb`.`admin` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `role_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_admin_role1_idx` (`role_id` ASC) VISIBLE,
  CONSTRAINT `fk_admin_role1`
    FOREIGN KEY (`role_id`)
    REFERENCES `agriculturedb`.`role` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `agriculturedb`.`farmer_guardian`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `agriculturedb`.`farmer_guardian` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `mobile_number` BIGINT(11) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `agriculturedb`.`farmer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `agriculturedb`.`farmer` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `role_id` INT NOT NULL,
  `farmer_guardian_id` INT NOT NULL,
  `farmercol` VARCHAR(45) NULL,
  `farmercol1` VARCHAR(45) NULL,
  `farmercol2` VARCHAR(45) NULL,
  `farmercol3` VARCHAR(45) NULL,
  PRIMARY KEY (`id`, `farmer_guardian_id`),
  INDEX `fk_farmer_role1_idx` (`role_id` ASC) VISIBLE,
  INDEX `fk_farmer_farmer_guardian1_idx` (`farmer_guardian_id` ASC) VISIBLE,
  CONSTRAINT `fk_farmer_role1`
    FOREIGN KEY (`role_id`)
    REFERENCES `agriculturedb`.`role` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_farmer_farmer_guardian1`
    FOREIGN KEY (`farmer_guardian_id`)
    REFERENCES `agriculturedb`.`farmer_guardian` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `agriculturedb`.`program`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `agriculturedb`.`program` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(255) NOT NULL,
  `personnel_id` INT NOT NULL,
  `admin_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_program_personnel1_idx` (`personnel_id` ASC) VISIBLE,
  INDEX `fk_program_admin1_idx` (`admin_id` ASC) VISIBLE,
  CONSTRAINT `fk_program_personnel1`
    FOREIGN KEY (`personnel_id`)
    REFERENCES `agriculturedb`.`personnel` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_program_admin1`
    FOREIGN KEY (`admin_id`)
    REFERENCES `agriculturedb`.`admin` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `agriculturedb`.`farmer_request`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `agriculturedb`.`farmer_request` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `crop` VARCHAR(45) NOT NULL,
  `kilo` VARCHAR(45) NOT NULL,
  `service_type` VARCHAR(255) NOT NULL,
  `purpose` VARCHAR(255) NOT NULL,
  `is_approved` TINYINT NOT NULL,
  `date_issued` DATETIME NOT NULL,
  `farmer_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_farmer_request_farmer1_idx` (`farmer_id` ASC) VISIBLE,
  CONSTRAINT `fk_farmer_request_farmer1`
    FOREIGN KEY (`farmer_id`)
    REFERENCES `agriculturedb`.`farmer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `agriculturedb`.`approved_farmer_request`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `agriculturedb`.`approved_farmer_request` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `personnel_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_approved_request_personnel1_idx` (`personnel_id` ASC) VISIBLE,
  CONSTRAINT `fk_approved_request_personnel1`
    FOREIGN KEY (`personnel_id`)
    REFERENCES `agriculturedb`.`personnel` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `agriculturedb`.`approved_farmer_request_has_farmer_request`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `agriculturedb`.`approved_farmer_request_has_farmer_request` (
  `approved_farmer_request_id` INT NOT NULL,
  `farmer_request_id` INT NOT NULL,
  PRIMARY KEY (`approved_farmer_request_id`, `farmer_request_id`),
  INDEX `fk_approved_farmer_request_has_farmer_request_farmer_reques_idx` (`farmer_request_id` ASC) VISIBLE,
  INDEX `fk_approved_farmer_request_has_farmer_request_approved_farm_idx` (`approved_farmer_request_id` ASC) VISIBLE,
  CONSTRAINT `fk_approved_farmer_request_has_farmer_request_approved_farmer1`
    FOREIGN KEY (`approved_farmer_request_id`)
    REFERENCES `agriculturedb`.`approved_farmer_request` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_approved_farmer_request_has_farmer_request_farmer_request1`
    FOREIGN KEY (`farmer_request_id`)
    REFERENCES `agriculturedb`.`farmer_request` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `agriculturedb`.`demograph`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `agriculturedb`.`demograph` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `civil_status` VARCHAR(45) NOT NULL,
  `street` VARCHAR(255) NOT NULL,
  `province` VARCHAR(100) NOT NULL,
  `zip_code` INT(10) NOT NULL,
  `religion` VARCHAR(45) NOT NULL,
  `birth_place` VARCHAR(45) NOT NULL,
  `birth_date` VARCHAR(45) NOT NULL,
  `farmer_id` INT NOT NULL,
  `farmer_farmer_guardian_id` INT NOT NULL,
  PRIMARY KEY (`id`, `farmer_id`, `farmer_farmer_guardian_id`),
  INDEX `fk_demograph_farmer1_idx` (`farmer_id` ASC, `farmer_farmer_guardian_id` ASC) VISIBLE,
  CONSTRAINT `fk_demograph_farmer1`
    FOREIGN KEY (`farmer_id` , `farmer_farmer_guardian_id`)
    REFERENCES `agriculturedb`.`farmer` (`id` , `farmer_guardian_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
