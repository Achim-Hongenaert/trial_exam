-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema trial_exam
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema trial_exam
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `trial_exam` ;
USE `trial_exam` ;

-- -----------------------------------------------------
-- Table `trial_exam`.`Specialist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `trial_exam`.`Specialist` (
  `Field_area` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Field_area`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `trial_exam`.`Medical`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `trial_exam`.`Medical` (
  `Overtime_rate` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Overtime_rate`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `trial_exam`.`Doctor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `trial_exam`.`Doctor` (
  `Name` VARCHAR(45) NOT NULL,
  `Date_of_birth` VARCHAR(45) NULL,
  `Address` VARCHAR(45) NULL,
  `Phone_number` VARCHAR(45) NULL,
  `Doctorcol` VARCHAR(45) NULL,
  `Specialist_Field_area` VARCHAR(45) NOT NULL,
  `Medical_Overtime_rate` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Name`),
  INDEX `fk_Doctor_Specialist1_idx` (`Specialist_Field_area` ASC) VISIBLE,
  INDEX `fk_Doctor_Medical1_idx` (`Medical_Overtime_rate` ASC) VISIBLE,
  CONSTRAINT `fk_Doctor_Specialist1`
    FOREIGN KEY (`Specialist_Field_area`)
    REFERENCES `trial_exam`.`Specialist` (`Field_area`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Doctor_Medical1`
    FOREIGN KEY (`Medical_Overtime_rate`)
    REFERENCES `trial_exam`.`Medical` (`Overtime_rate`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `trial_exam`.`Patient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `trial_exam`.`Patient` (
  `Name` VARCHAR(45) NOT NULL,
  `Address` VARCHAR(45) NULL,
  `Phone_number` VARCHAR(45) NULL,
  `Date_of_birth` VARCHAR(45) NULL,
  `Doctor_Name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Name`, `Doctor_Name`),
  INDEX `fk_Patient_Doctor1_idx` (`Doctor_Name` ASC) VISIBLE,
  CONSTRAINT `fk_Patient_Doctor1`
    FOREIGN KEY (`Doctor_Name`)
    REFERENCES `trial_exam`.`Doctor` (`Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `trial_exam`.`Appointment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `trial_exam`.`Appointment` (
  `Date` DATE NOT NULL,
  `Time` VARCHAR(45) NULL,
  `Doctor_Name` VARCHAR(45) NOT NULL,
  `Patient_Name` VARCHAR(45) NOT NULL,
  `Patient_Doctor_Name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Date`),
  INDEX `fk_Appointment_Doctor1_idx` (`Doctor_Name` ASC) VISIBLE,
  INDEX `fk_Appointment_Patient1_idx` (`Patient_Name` ASC, `Patient_Doctor_Name` ASC) VISIBLE,
  CONSTRAINT `fk_Appointment_Doctor1`
    FOREIGN KEY (`Doctor_Name`)
    REFERENCES `trial_exam`.`Doctor` (`Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Appointment_Patient1`
    FOREIGN KEY (`Patient_Name` , `Patient_Doctor_Name`)
    REFERENCES `trial_exam`.`Patient` (`Name` , `Doctor_Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `trial_exam`.`Payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `trial_exam`.`Payment` (
  `Details` VARCHAR(45) NOT NULL,
  `Method` VARCHAR(45) NULL,
  `Appointment_Date` DATE NOT NULL,
  PRIMARY KEY (`Details`),
  INDEX `fk_Payment_Appointment1_idx` (`Appointment_Date` ASC) VISIBLE,
  CONSTRAINT `fk_Payment_Appointment1`
    FOREIGN KEY (`Appointment_Date`)
    REFERENCES `trial_exam`.`Appointment` (`Date`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `trial_exam`.`Bill`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `trial_exam`.`Bill` (
  `Total` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Total`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `trial_exam`.`Payment_has_Bill`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `trial_exam`.`Payment_has_Bill` (
  `Payment_Details` VARCHAR(45) NOT NULL,
  `Bill_Total` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Payment_Details`, `Bill_Total`),
  INDEX `fk_Payment_has_Bill_Bill1_idx` (`Bill_Total` ASC) VISIBLE,
  INDEX `fk_Payment_has_Bill_Payment1_idx` (`Payment_Details` ASC) VISIBLE,
  CONSTRAINT `fk_Payment_has_Bill_Payment1`
    FOREIGN KEY (`Payment_Details`)
    REFERENCES `trial_exam`.`Payment` (`Details`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Payment_has_Bill_Bill1`
    FOREIGN KEY (`Bill_Total`)
    REFERENCES `trial_exam`.`Bill` (`Total`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
