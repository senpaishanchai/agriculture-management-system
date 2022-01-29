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
-- Table `agriculturedb`.`userRoles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `agriculturedb`.`userRoles` (
  `userRoleId` INT NOT NULL AUTO_INCREMENT,
  `roleName` VARCHAR(45) NULL,
  PRIMARY KEY (`userRoleId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `agriculturedb`.`userInfo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `agriculturedb`.`userInfo` (
  `userInfoId` INT NOT NULL AUTO_INCREMENT,
  `firstName` VARCHAR(45) NULL,
  `middleName` VARCHAR(45) NULL,
  `lastName` VARCHAR(45) NULL,
  `address` VARCHAR(45) NULL,
  `birthDate` DATETIME NULL,
  `age` INT NULL,
  `gender` VARCHAR(45) NULL,
  `createdAt` DATETIME NULL,
  `updatedAt` DATETIME NULL,
  `userRoleId` INT NOT NULL,
  PRIMARY KEY (`userInfoId`, `userRoleId`),
  INDEX `fk_user_info_role1_idx` (`userRoleId` ASC) VISIBLE,
  CONSTRAINT `fk_user_info_role1`
    FOREIGN KEY (`userRoleId`)
    REFERENCES `agriculturedb`.`userRoles` (`userRoleId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `agriculturedb`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `agriculturedb`.`user` (
  `userId` INT NOT NULL AUTO_INCREMENT,
  `userName` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `mobileNumber` INT(11) NOT NULL,
  `userInfoId` INT NOT NULL,
  PRIMARY KEY (`userId`),
  INDEX `fk_user_user_info_idx` (`userInfoId` ASC) VISIBLE,
  CONSTRAINT `fk_user_user_info`
    FOREIGN KEY (`userInfoId`)
    REFERENCES `agriculturedb`.`userInfo` (`userInfoId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `agriculturedb`.`userPermissions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `agriculturedb`.`userPermissions` (
  `userPermissionId` INT NOT NULL AUTO_INCREMENT,
  `permissionName` VARCHAR(100) NULL,
  `userRoles_userRoleId` INT NOT NULL,
  PRIMARY KEY (`userPermissionId`),
  INDEX `fk_userPermissions_userRoles1_idx` (`userRoles_userRoleId` ASC) VISIBLE,
  CONSTRAINT `fk_userPermissions_userRoles1`
    FOREIGN KEY (`userRoles_userRoleId`)
    REFERENCES `agriculturedb`.`userRoles` (`userRoleId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
