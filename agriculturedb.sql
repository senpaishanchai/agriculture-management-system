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
-- Table `agriculturedb`.`tokens`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `agriculturedb`.`tokens` (
  `tokenId` INT NOT NULL,
  `accessToken` VARCHAR(45) NULL DEFAULT NULL,
  `refreshToken` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`tokenId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `agriculturedb`.`userroles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `agriculturedb`.`userroles` (
  `userRoleId` INT NOT NULL AUTO_INCREMENT,
  `roleName` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`userRoleId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `agriculturedb`.`userinfo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `agriculturedb`.`userinfo` (
  `userInfoId` INT NOT NULL AUTO_INCREMENT,
  `firstName` VARCHAR(45) NULL DEFAULT NULL,
  `middleName` VARCHAR(45) NULL DEFAULT NULL,
  `lastName` VARCHAR(45) NULL DEFAULT NULL,
  `address` VARCHAR(45) NULL DEFAULT NULL,
  `birthDate` DATETIME NULL DEFAULT NULL,
  `age` INT NULL DEFAULT NULL,
  `gender` VARCHAR(45) NULL DEFAULT NULL,
  `createdAt` DATETIME NULL DEFAULT NULL,
  `updatedAt` DATETIME NULL DEFAULT NULL,
  `userRoleId` INT NOT NULL,
  PRIMARY KEY (`userInfoId`, `userRoleId`),
  INDEX `fk_user_info_role1_idx` (`userRoleId` ASC) VISIBLE,
  CONSTRAINT `fk_user_info_role1`
    FOREIGN KEY (`userRoleId`)
    REFERENCES `agriculturedb`.`userroles` (`userRoleId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `agriculturedb`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `agriculturedb`.`user` (
  `userId` INT NOT NULL AUTO_INCREMENT,
  `userName` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `mobileNumber` VARCHAR(45) NULL DEFAULT NULL,
  `userInfoId` INT NULL DEFAULT NULL,
  PRIMARY KEY (`userId`),
  INDEX `fk_userRegister_userInfo1_idx` (`userInfoId` ASC) VISIBLE,
  CONSTRAINT `fk_userRegister_userInfo1`
    FOREIGN KEY (`userInfoId`)
    REFERENCES `agriculturedb`.`userinfo` (`userInfoId`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `agriculturedb`.`userpermissions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `agriculturedb`.`userpermissions` (
  `userPermissionId` INT NOT NULL AUTO_INCREMENT,
  `permissionName` VARCHAR(100) NULL DEFAULT NULL,
  `userRoles_userRoleId` INT NOT NULL,
  PRIMARY KEY (`userPermissionId`),
  INDEX `fk_userPermissions_userRoles1_idx` (`userRoles_userRoleId` ASC) VISIBLE,
  CONSTRAINT `fk_userPermissions_userRoles1`
    FOREIGN KEY (`userRoles_userRoleId`)
    REFERENCES `agriculturedb`.`userroles` (`userRoleId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
