-- MySQL Workbench Synchronization
-- Generated: 2022-01-29 15:33
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: Wardvisuals

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

ALTER TABLE `agriculturedb`.`user` 
DROP FOREIGN KEY `fk_user_role`;

ALTER TABLE `agriculturedb`.`personnel` 
DROP FOREIGN KEY `fk_personnel_role1`;

ALTER TABLE `agriculturedb`.`admin` 
DROP FOREIGN KEY `fk_admin_role1`;

ALTER TABLE `agriculturedb`.`farmer` 
DROP FOREIGN KEY `fk_farmer_farmer_guardian1`;

ALTER TABLE `agriculturedb`.`program` 
DROP FOREIGN KEY `fk_program_admin1`;

ALTER TABLE `agriculturedb`.`farmer_request` 
DROP FOREIGN KEY `fk_farmer_request_farmer1`;

ALTER TABLE `agriculturedb`.`approved_farmer_request` 
DROP FOREIGN KEY `fk_approved_request_personnel1`;

ALTER TABLE `agriculturedb`.`approved_farmer_request_has_farmer_request` 
DROP FOREIGN KEY `fk_approved_farmer_request_has_farmer_request_approved_farmer1`,
DROP FOREIGN KEY `fk_approved_farmer_request_has_farmer_request_farmer_request1`;

ALTER TABLE `agriculturedb`.`demograph` 
DROP FOREIGN KEY `fk_demograph_farmer1`;

ALTER TABLE `agriculturedb`.`user` 
ADD COLUMN `username` VARCHAR(45) NOT NULL AFTER `is_verified`,
ADD COLUMN `password` VARCHAR(45) NOT NULL AFTER `username`,
CHANGE COLUMN `mobile_number` `mobile_number` BIGINT(11) NOT NULL ,
CHANGE COLUMN `age` `age` INT(5) NOT NULL ,
CHANGE COLUMN `is_verified` `is_verified` TINYINT(4) NOT NULL ;

ALTER TABLE `agriculturedb`.`role` 
CHANGE COLUMN `admin` `admin` TEXT(10) NOT NULL ,
CHANGE COLUMN `farmer` `farmer` TEXT(10) NOT NULL ;

ALTER TABLE `agriculturedb`.`farmer_guardian` 
CHANGE COLUMN `mobile_number` `mobile_number` BIGINT(11) NOT NULL ;

ALTER TABLE `agriculturedb`.`demograph` 
CHANGE COLUMN `zip_code` `zip_code` INT(10) NOT NULL ;

ALTER TABLE `agriculturedb`.`user` 
ADD CONSTRAINT `fk_user_role`
  FOREIGN KEY (`role_id`)
  REFERENCES `agriculturedb`.`role` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `agriculturedb`.`personnel` 
ADD CONSTRAINT `fk_personnel_role1`
  FOREIGN KEY (`role_id`)
  REFERENCES `agriculturedb`.`role` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `agriculturedb`.`admin` 
ADD CONSTRAINT `fk_admin_role1`
  FOREIGN KEY (`role_id`)
  REFERENCES `agriculturedb`.`role` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `agriculturedb`.`farmer` 
DROP FOREIGN KEY `fk_farmer_role1`;

ALTER TABLE `agriculturedb`.`farmer` ADD CONSTRAINT `fk_farmer_role1`
  FOREIGN KEY (`role_id`)
  REFERENCES `agriculturedb`.`role` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_farmer_farmer_guardian1`
  FOREIGN KEY (`farmer_guardian_id`)
  REFERENCES `agriculturedb`.`farmer_guardian` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `agriculturedb`.`program` 
DROP FOREIGN KEY `fk_program_personnel1`;

ALTER TABLE `agriculturedb`.`program` ADD CONSTRAINT `fk_program_personnel1`
  FOREIGN KEY (`personnel_id`)
  REFERENCES `agriculturedb`.`personnel` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_program_admin1`
  FOREIGN KEY (`admin_id`)
  REFERENCES `agriculturedb`.`admin` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `agriculturedb`.`farmer_request` 
ADD CONSTRAINT `fk_farmer_request_farmer1`
  FOREIGN KEY (`farmer_id`)
  REFERENCES `agriculturedb`.`farmer` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `agriculturedb`.`approved_farmer_request` 
ADD CONSTRAINT `fk_approved_request_personnel1`
  FOREIGN KEY (`personnel_id`)
  REFERENCES `agriculturedb`.`personnel` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `agriculturedb`.`approved_farmer_request_has_farmer_request` 
ADD CONSTRAINT `fk_approved_farmer_request_has_farmer_request_approved_farmer1`
  FOREIGN KEY (`approved_farmer_request_id`)
  REFERENCES `agriculturedb`.`approved_farmer_request` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_approved_farmer_request_has_farmer_request_farmer_request1`
  FOREIGN KEY (`farmer_request_id`)
  REFERENCES `agriculturedb`.`farmer_request` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `agriculturedb`.`demograph` 
ADD CONSTRAINT `fk_demograph_farmer1`
  FOREIGN KEY (`farmer_id` , `farmer_farmer_guardian_id`)
  REFERENCES `agriculturedb`.`farmer` (`id` , `farmer_guardian_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
