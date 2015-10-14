-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema universityMySQL
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema universityMySQL
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `universityMySQL` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `universityMySQL` ;

-- -----------------------------------------------------
-- Table `universityMySQL`.`Faculties`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `universityMySQL`.`Faculties` (
  `Id` INT NOT NULL AUTO_INCREMENT COMMENT '',
  `Name` VARCHAR(45) NOT NULL COMMENT '',
  PRIMARY KEY (`Id`)  COMMENT '')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `universityMySQL`.`Departments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `universityMySQL`.`Departments` (
  `Id` INT NOT NULL AUTO_INCREMENT COMMENT '',
  `name` NVARCHAR(45) NOT NULL COMMENT '',
  `Faculties_Id` INT NOT NULL COMMENT '',
  PRIMARY KEY (`Id`)  COMMENT '',
  INDEX `fk_Departments_Faculties_idx` (`Faculties_Id` ASC)  COMMENT '',
  CONSTRAINT `fk_Departments_Faculties`
    FOREIGN KEY (`Faculties_Id`)
    REFERENCES `universityMySQL`.`Faculties` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `universityMySQL`.`Courses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `universityMySQL`.`Courses` (
  `Id` INT NOT NULL AUTO_INCREMENT COMMENT '',
  `Name` NVARCHAR(45) NOT NULL COMMENT '',
  `Departments_Id` INT NOT NULL COMMENT '',
  PRIMARY KEY (`Id`)  COMMENT '',
  INDEX `fk_Courses_Departments1_idx` (`Departments_Id` ASC)  COMMENT '',
  CONSTRAINT `fk_Courses_Departments1`
    FOREIGN KEY (`Departments_Id`)
    REFERENCES `universityMySQL`.`Departments` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `universityMySQL`.`Students`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `universityMySQL`.`Students` (
  `Id` INT NOT NULL AUTO_INCREMENT COMMENT '',
  `Name` NVARCHAR(100) NOT NULL COMMENT '',
  `Faculties_Id` INT NOT NULL COMMENT '',
  PRIMARY KEY (`Id`)  COMMENT '',
  INDEX `fk_Students_Faculties1_idx` (`Faculties_Id` ASC)  COMMENT '',
  CONSTRAINT `fk_Students_Faculties1`
    FOREIGN KEY (`Faculties_Id`)
    REFERENCES `universityMySQL`.`Faculties` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `universityMySQL`.`StudentCourses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `universityMySQL`.`StudentCourses` (
  `Students_Id` INT NOT NULL COMMENT '',
  `Courses_Id` INT NOT NULL COMMENT '',
  PRIMARY KEY (`Students_Id`, `Courses_Id`)  COMMENT '',
  INDEX `fk_StudentCourses_Students1_idx` (`Students_Id` ASC)  COMMENT '',
  INDEX `fk_StudentCourses_Courses1_idx` (`Courses_Id` ASC)  COMMENT '',
  CONSTRAINT `fk_StudentCourses_Students1`
    FOREIGN KEY (`Students_Id`)
    REFERENCES `universityMySQL`.`Students` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_StudentCourses_Courses1`
    FOREIGN KEY (`Courses_Id`)
    REFERENCES `universityMySQL`.`Courses` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `universityMySQL`.`Professors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `universityMySQL`.`Professors` (
  `Id` INT NOT NULL AUTO_INCREMENT COMMENT '',
  `Name` NVARCHAR(45) NOT NULL COMMENT '',
  `Departments_Id` INT NOT NULL COMMENT '',
  PRIMARY KEY (`Id`)  COMMENT '',
  INDEX `fk_Professors_Departments1_idx` (`Departments_Id` ASC)  COMMENT '',
  CONSTRAINT `fk_Professors_Departments1`
    FOREIGN KEY (`Departments_Id`)
    REFERENCES `universityMySQL`.`Departments` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `universityMySQL`.`ProfessorCourses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `universityMySQL`.`ProfessorCourses` (
  `Professors_Id` INT NOT NULL COMMENT '',
  `Courses_Id` INT NOT NULL COMMENT '',
  PRIMARY KEY (`Professors_Id`, `Courses_Id`)  COMMENT '',
  INDEX `fk_ProfessorCourses_Professors1_idx` (`Professors_Id` ASC)  COMMENT '',
  INDEX `fk_ProfessorCourses_Courses1_idx` (`Courses_Id` ASC)  COMMENT '',
  CONSTRAINT `fk_ProfessorCourses_Professors1`
    FOREIGN KEY (`Professors_Id`)
    REFERENCES `universityMySQL`.`Professors` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ProfessorCourses_Courses1`
    FOREIGN KEY (`Courses_Id`)
    REFERENCES `universityMySQL`.`Courses` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `universityMySQL`.`Titles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `universityMySQL`.`Titles` (
  `Id` INT NOT NULL COMMENT '',
  `Name` NVARCHAR(45) NOT NULL COMMENT '',
  PRIMARY KEY (`Id`)  COMMENT '')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `universityMySQL`.`ProfessorTitle`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `universityMySQL`.`ProfessorTitle` (
  `ProfessorId` INT NOT NULL COMMENT '',
  `TitleId` INT NOT NULL COMMENT '',
  `Professors_Id` INT NOT NULL COMMENT '',
  `Titles_Id` INT NOT NULL COMMENT '',
  PRIMARY KEY (`ProfessorId`, `TitleId`)  COMMENT '',
  INDEX `fk_ProfessorTitle_Professors1_idx` (`Professors_Id` ASC)  COMMENT '',
  INDEX `fk_ProfessorTitle_Titles1_idx` (`Titles_Id` ASC)  COMMENT '',
  CONSTRAINT `fk_ProfessorTitle_Professors1`
    FOREIGN KEY (`Professors_Id`)
    REFERENCES `universityMySQL`.`Professors` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ProfessorTitle_Titles1`
    FOREIGN KEY (`Titles_Id`)
    REFERENCES `universityMySQL`.`Titles` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
