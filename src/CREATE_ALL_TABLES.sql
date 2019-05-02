-- MySQL Script generated by MySQL Workbench
-- Wed May  1 14:14:27 2019
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema CS307_Project
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema CS307_Project
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `CS307_Project` DEFAULT CHARACTER SET utf8 ;
USE `CS307_Project` ;

-- -----------------------------------------------------
-- Table `CS307_Project`.`album`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CS307_Project`.`album` ;

CREATE TABLE IF NOT EXISTS `CS307_Project`.`album` (
  `id` INT NOT NULL,
  `artist_band_id` INT NULL,
  `title` VARCHAR(45) NULL,
  `rating` CHAR(1) NULL,
  `hot` INT NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  INDEX `fk_album_artist_band1_idx` (`artist_band_id` ASC) VISIBLE,
  CONSTRAINT `fk_album_artist_band1`
    FOREIGN KEY (`artist_band_id`)
    REFERENCES `CS307_Project`.`artist_band` (`artist_band_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CS307_Project`.`artist`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CS307_Project`.`artist` ;

CREATE TABLE IF NOT EXISTS `CS307_Project`.`artist` (
  `id` INT NOT NULL,
  `first_name` VARCHAR(45) NULL,
  `surname` VARCHAR(45) NOT NULL,
  `hot` INT NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CS307_Project`.`track`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CS307_Project`.`track` ;

CREATE TABLE IF NOT EXISTS `CS307_Project`.`track` (
  `id` INT NOT NULL,
  `title` VARCHAR(100) NOT NULL,
  `album_id` INT NOT NULL,
  `artist_band_id` INT NOT NULL,
  `len` INT NOT NULL COMMENT '歌曲播放时长',
  `rating` CHAR(1) CHARACTER SET 'binary' NULL COMMENT '歌曲评分， 1-5 (5为最高分)',
  `genre` VARCHAR(45) NULL COMMENT '曲风 流派',
  `hot` INT NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_track_album_idx` (`album_id` ASC) VISIBLE,
  INDEX `fk_track_artist_band1_idx` (`artist_band_id` ASC) VISIBLE,
  CONSTRAINT `fk_track_album`
    FOREIGN KEY (`album_id`)
    REFERENCES `CS307_Project`.`album` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_track_artist_band1`
    FOREIGN KEY (`artist_band_id`)
    REFERENCES `CS307_Project`.`artist_band` (`artist_band_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CS307_Project`.`artist_band`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CS307_Project`.`artist_band` ;

CREATE TABLE IF NOT EXISTS `CS307_Project`.`artist_band` (
  `artist_band_id` INT NOT NULL,
  `artist_id` INT NOT NULL,
  `band_id` INT NULL,
  `record_company_id` INT NULL,
  PRIMARY KEY (`artist_band_id`),
  INDEX `fk_artist_in_band_artist1_idx` (`artist_id` ASC) VISIBLE,
  INDEX `fk_artist_in_band_band1_idx` (`band_id` ASC) VISIBLE,
  INDEX `fk_artist_band_record_company1_idx` (`record_company_id` ASC) VISIBLE,
  CONSTRAINT `fk_artist_in_band_artist1`
    FOREIGN KEY (`artist_id`)
    REFERENCES `CS307_Project`.`artist` (`first_name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_artist_in_band_band1`
    FOREIGN KEY (`band_id`)
    REFERENCES `CS307_Project`.`band` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_artist_band_record_company1`
    FOREIGN KEY (`record_company_id`)
    REFERENCES `CS307_Project`.`record_company` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CS307_Project`.`band`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CS307_Project`.`band` ;

CREATE TABLE IF NOT EXISTS `CS307_Project`.`band` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `establish` DATE NOT NULL,
  `dismiss` DATE NULL,
  `hot` INT NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CS307_Project`.`list`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CS307_Project`.`list` ;

CREATE TABLE IF NOT EXISTS `CS307_Project`.`list` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `rate` CHAR(1) NULL,
  `last_play_date` DATETIME NULL,
  `play_count` INT NULL,
  `last_skip_date` DATETIME NULL,
  `skip_count` INT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CS307_Project`.`list_has_song`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CS307_Project`.`list_has_song` ;

CREATE TABLE IF NOT EXISTS `CS307_Project`.`list_has_song` (
  `song_id` INT NOT NULL,
  `list_id` INT NOT NULL,
  `order` INT NOT NULL COMMENT 'The order of one song in a list',
  PRIMARY KEY (`song_id`, `list_id`),
  INDEX `fk_song_has_list_list1_idx` (`list_id` ASC) VISIBLE,
  INDEX `fk_song_has_list_song1_idx` (`song_id` ASC) VISIBLE,
  CONSTRAINT `fk_song_has_list_song1`
    FOREIGN KEY (`song_id`)
    REFERENCES `CS307_Project`.`song` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_song_has_list_list1`
    FOREIGN KEY (`list_id`)
    REFERENCES `CS307_Project`.`list` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CS307_Project`.`record_company`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CS307_Project`.`record_company` ;

CREATE TABLE IF NOT EXISTS `CS307_Project`.`record_company` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CS307_Project`.`song`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CS307_Project`.`song` ;

CREATE TABLE IF NOT EXISTS `CS307_Project`.`song` (
  `id` INT NOT NULL,
  `track_id` VARCHAR(45) NULL,
  `rate` CHAR(1) NULL,
  `add_date` DATETIME(6) NULL,
  `last_play_date` DATETIME(6) NOT NULL DEFAULT '2000-01-01 00:00:00',
  `play_count` INT NOT NULL DEFAULT 0,
  `last_skip_date` DATETIME(6) NOT NULL DEFAULT '2000-01-01 00:00:00',
  `skip_count` INT NOT NULL DEFAULT 0,
  `path` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_song_track1_idx` (`track_id` ASC) VISIBLE,
  CONSTRAINT `fk_song_track1`
    FOREIGN KEY (`track_id`)
    REFERENCES `CS307_Project`.`track` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CS307_Project`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CS307_Project`.`user` ;

CREATE TABLE IF NOT EXISTS `CS307_Project`.`user` (
  `id` INT NOT NULL,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CS307_Project`.`user_create_list`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CS307_Project`.`user_create_list` ;

CREATE TABLE IF NOT EXISTS `CS307_Project`.`user_create_list` (
  `library_id` INT NOT NULL,
  `list_id` INT NOT NULL,
  `rating` CHAR(1) NULL,
  `share` BINARY(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`library_id`, `list_id`),
  INDEX `fk_library_has_list_list1_idx` (`list_id` ASC),
  INDEX `fk_library_has_list_library1_idx` (`library_id` ASC),
  CONSTRAINT `fk_library_has_list_library10`
    FOREIGN KEY (`library_id`)
    REFERENCES `CS307_Project`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_library_has_list_list10`
    FOREIGN KEY (`list_id`)
    REFERENCES `CS307_Project`.`list` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CS307_Project`.`user_has_list`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CS307_Project`.`user_has_list` ;

CREATE TABLE IF NOT EXISTS `CS307_Project`.`user_has_list` (
  `library_id` INT NOT NULL,
  `list_id` INT NOT NULL,
  `rating` CHAR(1) NULL,
  PRIMARY KEY (`library_id`, `list_id`),
  INDEX `fk_library_has_list_list1_idx` (`list_id` ASC),
  INDEX `fk_library_has_list_library1_idx` (`library_id` ASC),
  CONSTRAINT `fk_library_has_list_library1`
    FOREIGN KEY (`library_id`)
    REFERENCES `CS307_Project`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_library_has_list_list1`
    FOREIGN KEY (`list_id`)
    REFERENCES `CS307_Project`.`list` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
