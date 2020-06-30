-- MySQL Script generated by MySQL Workbench
-- Tue Jun 30 09:29:04 2020
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Profil`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Profil` (
  `idProfil` INT NOT NULL AUTO_INCREMENT,
  `nama_lengkap` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `foto` MEDIUMBLOB NOT NULL,
  `nama_gambar` VARCHAR(255) NOT NULL,
  `tipe_gambar` VARCHAR(255) NOT NULL,
  `ukuran_gambar` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`idProfil`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pertanyaan`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pertanyaan` (
  `idPertanyaan` INT NULL AUTO_INCREMENT,
  `judul` VARCHAR(255) NOT NULL,
  `isi` TEXT NOT NULL,
  `tanggal_dibuat` DATETIME NOT NULL,
  `tanggal_diperbaharui` DATETIME NOT NULL,
  `Profil_idProfil` INT NOT NULL,
  PRIMARY KEY (`idPertanyaan`),
  INDEX `fk_Pertanyaan_Profil1_idx` (`Profil_idProfil` ASC) VISIBLE,
  UNIQUE INDEX `idPertanyaan_UNIQUE` (`idPertanyaan` ASC) VISIBLE,
  CONSTRAINT `fk_Pertanyaan_Profil1`
    FOREIGN KEY (`Profil_idProfil`)
    REFERENCES `mydb`.`Profil` (`idProfil`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Jawaban`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Jawaban` (
  `idJawaban` INT NULL AUTO_INCREMENT,
  `isi` TEXT NOT NULL,
  `tanggal_dibuat` DATETIME NOT NULL,
  `tanggal_diperbaharui` DATETIME NOT NULL,
  `Pertanyaan_idPertanyaan` INT NOT NULL,
  `Profil_idProfil` INT NOT NULL,
  PRIMARY KEY (`idJawaban`),
  INDEX `fk_Jawaban_Pertanyaan1_idx` (`Pertanyaan_idPertanyaan` ASC) VISIBLE,
  INDEX `fk_Jawaban_Profil1_idx` (`Profil_idProfil` ASC) VISIBLE,
  CONSTRAINT `fk_Jawaban_Pertanyaan1`
    FOREIGN KEY (`Pertanyaan_idPertanyaan`)
    REFERENCES `mydb`.`Pertanyaan` (`idPertanyaan`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Jawaban_Profil1`
    FOREIGN KEY (`Profil_idProfil`)
    REFERENCES `mydb`.`Profil` (`idProfil`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Komentar_jawab`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Komentar_jawab` (
  `idKomentar` INT NOT NULL AUTO_INCREMENT,
  `isi` TEXT NOT NULL,
  `tanggal_dibuat` DATE NOT NULL,
  `Profil_idProfil` INT NOT NULL,
  `Jawaban_idJawaban` INT NOT NULL,
  PRIMARY KEY (`idKomentar`),
  INDEX `fk_Komentar_jawab_Profil1_idx` (`Profil_idProfil` ASC) VISIBLE,
  INDEX `fk_Komentar_jawab_Jawaban1_idx` (`Jawaban_idJawaban` ASC) VISIBLE,
  CONSTRAINT `fk_Komentar_jawab_Profil1`
    FOREIGN KEY (`Profil_idProfil`)
    REFERENCES `mydb`.`Profil` (`idProfil`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Komentar_jawab_Jawaban1`
    FOREIGN KEY (`Jawaban_idJawaban`)
    REFERENCES `mydb`.`Jawaban` (`idJawaban`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Komentar_tanya`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Komentar_tanya` (
  `idKomentar` INT NOT NULL AUTO_INCREMENT,
  `isi` TEXT NOT NULL,
  `tanggal_dibuat` DATE NOT NULL,
  `Profil_idProfil` INT NOT NULL,
  `Pertanyaan_idPertanyaan` INT NOT NULL,
  PRIMARY KEY (`idKomentar`),
  INDEX `fk_Komentar_tanya_Profil1_idx` (`Profil_idProfil` ASC) VISIBLE,
  INDEX `fk_Komentar_tanya_Pertanyaan1_idx` (`Pertanyaan_idPertanyaan` ASC) VISIBLE,
  CONSTRAINT `fk_Komentar_tanya_Profil1`
    FOREIGN KEY (`Profil_idProfil`)
    REFERENCES `mydb`.`Profil` (`idProfil`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Komentar_tanya_Pertanyaan1`
    FOREIGN KEY (`Pertanyaan_idPertanyaan`)
    REFERENCES `mydb`.`Pertanyaan` (`idPertanyaan`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Vote_pertanyaan`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Vote_pertanyaan` (
  `idVote_pertanyaan` INT NOT NULL AUTO_INCREMENT,
  `Pertanyaan_idPertanyaan` INT NOT NULL,
  `Profil_idProfil` INT NOT NULL,
  `Vote` SET("like", "dislike") NOT NULL,
  PRIMARY KEY (`idVote_pertanyaan`),
  INDEX `fk_Vote_pertanyaan_Pertanyaan1_idx` (`Pertanyaan_idPertanyaan` ASC) VISIBLE,
  INDEX `fk_Vote_pertanyaan_Profil1_idx` (`Profil_idProfil` ASC) VISIBLE,
  CONSTRAINT `fk_Vote_pertanyaan_Pertanyaan1`
    FOREIGN KEY (`Pertanyaan_idPertanyaan`)
    REFERENCES `mydb`.`Pertanyaan` (`idPertanyaan`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Vote_pertanyaan_Profil1`
    FOREIGN KEY (`Profil_idProfil`)
    REFERENCES `mydb`.`Profil` (`idProfil`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Vote_jawaban`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Vote_jawaban` (
  `idVote_jawaban` INT NOT NULL AUTO_INCREMENT,
  `Jawaban_idJawaban` INT NOT NULL,
  `Profil_idProfil` INT NOT NULL,
  `Vote` SET("like", "dislike") NOT NULL,
  PRIMARY KEY (`idVote_jawaban`),
  INDEX `fk_Vote_jawaban_Jawaban1_idx` (`Jawaban_idJawaban` ASC) VISIBLE,
  INDEX `fk_Vote_jawaban_Profil1_idx` (`Profil_idProfil` ASC) VISIBLE,
  CONSTRAINT `fk_Vote_jawaban_Jawaban1`
    FOREIGN KEY (`Jawaban_idJawaban`)
    REFERENCES `mydb`.`Jawaban` (`idJawaban`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Vote_jawaban_Profil1`
    FOREIGN KEY (`Profil_idProfil`)
    REFERENCES `mydb`.`Profil` (`idProfil`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
