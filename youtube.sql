-- MySQL Script generated by MySQL Workbench
-- Thu Nov 28 11:21:03 2024
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
-- Table `mydb`.`users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`users` ;

CREATE TABLE IF NOT EXISTS `mydb`.`users` (
  `users_id` INT NOT NULL AUTO_INCREMENT,
  `users_email` VARCHAR(100) NULL,
  `users_password` VARCHAR(45) NULL,
  `users_username` VARCHAR(45) NULL,
  `users_birthdate` DATE NULL,
  `users_sex` INT NULL,
  `users_country` VARCHAR(45) NULL,
  `users_zipcode` INT(5) NULL,
  PRIMARY KEY (`users_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`videos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`videos` ;

CREATE TABLE IF NOT EXISTS `mydb`.`videos` (
  `videos_id` INT NOT NULL AUTO_INCREMENT,
  `videos_title` VARCHAR(90) NULL,
  `videos_description` TEXT NULL,
  `videos_size` FLOAT NULL,
  `videos_length` INT NULL,
  `videos_thumbnail` BLOB NULL,
  `videos_nviews` INT NULL,
  `videos_nlikes` INT NULL,
  `videos_ndislikes` INT NULL,
  `videos_privacy` ENUM("public", "hidden", "private") NULL,
  `videos_creator` INT NULL,
  `videos_posted_date` DATE NULL,
  PRIMARY KEY (`videos_id`),
  INDEX `fk_user_idx` (`videos_creator` ASC) VISIBLE,
  CONSTRAINT `fk_user`
    FOREIGN KEY (`videos_creator`)
    REFERENCES `mydb`.`users` (`users_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tags`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`tags` ;

CREATE TABLE IF NOT EXISTS `mydb`.`tags` (
  `tags_id` INT NOT NULL,
  `tags_name` VARCHAR(90) NULL,
  PRIMARY KEY (`tags_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`videos_tags`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`videos_tags` ;

CREATE TABLE IF NOT EXISTS `mydb`.`videos_tags` (
  `video_id` INT NULL,
  `tag_id` INT NULL,
  INDEX `fk_tags_idx` (`tag_id` ASC) VISIBLE,
  INDEX `fk_videos_idx` (`video_id` ASC) VISIBLE,
  CONSTRAINT `fk_tags`
    FOREIGN KEY (`tag_id`)
    REFERENCES `mydb`.`tags` (`tags_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_videos`
    FOREIGN KEY (`video_id`)
    REFERENCES `mydb`.`videos` (`videos_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`channels`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`channels` ;

CREATE TABLE IF NOT EXISTS `mydb`.`channels` (
  `channels_id` INT NOT NULL AUTO_INCREMENT,
  `channels_name` VARCHAR(100) NULL,
  `channels_description` TEXT NULL,
  `channels_creation_date` DATE NULL,
  `channels_creator` INT NULL,
  PRIMARY KEY (`channels_id`),
  INDEX `fk_user_idx` (`channels_creator` ASC) VISIBLE,
  CONSTRAINT `fk_creator`
    FOREIGN KEY (`channels_creator`)
    REFERENCES `mydb`.`users` (`users_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`subscriptions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`subscriptions` ;

CREATE TABLE IF NOT EXISTS `mydb`.`subscriptions` (
  `user_id` INT NULL,
  `channel_id` INT NULL,
  INDEX `fk_user_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_channel_idx` (`channel_id` ASC) VISIBLE,
  CONSTRAINT `fk_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `mydb`.`users` (`users_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_channel`
    FOREIGN KEY (`channel_id`)
    REFERENCES `mydb`.`channels` (`channels_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`assessment_video`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`assessment_video` ;

CREATE TABLE IF NOT EXISTS `mydb`.`assessment_video` (
  `video_id` INT NULL,
  `user_id` INT NULL,
  `assessment_date` DATE NULL,
  `assessment_binary` ENUM("like", "dislike") NULL,
  INDEX `fk_user_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_video_idx` (`video_id` ASC) VISIBLE,
  CONSTRAINT `fk_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `mydb`.`users` (`users_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_video`
    FOREIGN KEY (`video_id`)
    REFERENCES `mydb`.`videos` (`videos_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`playlists`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`playlists` ;

CREATE TABLE IF NOT EXISTS `mydb`.`playlists` (
  `playlists_id` INT NOT NULL AUTO_INCREMENT,
  `playlists_name` VARCHAR(100) NULL,
  `playlists_creation_date` DATE NULL,
  `playlists_privacy` ENUM("public", "private") NULL,
  `playlists_creator` INT NULL,
  PRIMARY KEY (`playlists_id`),
  INDEX `fk_user_idx` (`playlists_creator` ASC) VISIBLE,
  CONSTRAINT `fk_creator`
    FOREIGN KEY (`playlists_creator`)
    REFERENCES `mydb`.`users` (`users_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`videos_playlists`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`videos_playlists` ;

CREATE TABLE IF NOT EXISTS `mydb`.`videos_playlists` (
  `video_id` INT NULL,
  `playlist_id` INT NULL,
  INDEX `fk_video_idx` (`video_id` ASC) VISIBLE,
  INDEX `fk_playlist_idx` (`playlist_id` ASC) VISIBLE,
  CONSTRAINT `fk_video`
    FOREIGN KEY (`video_id`)
    REFERENCES `mydb`.`videos` (`videos_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_playlist`
    FOREIGN KEY (`playlist_id`)
    REFERENCES `mydb`.`playlists` (`playlists_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`comments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`comments` ;

CREATE TABLE IF NOT EXISTS `mydb`.`comments` (
  `comments_id` INT NOT NULL AUTO_INCREMENT,
  `comments_text` TEXT NULL,
  `comments_date` DATE NULL,
  `comments_creator` INT NULL,
  PRIMARY KEY (`comments_id`),
  INDEX `fk_creator_idx` (`comments_creator` ASC) VISIBLE,
  CONSTRAINT `fk_creator`
    FOREIGN KEY (`comments_creator`)
    REFERENCES `mydb`.`users` (`users_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`assessment_comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`assessment_comment` ;

CREATE TABLE IF NOT EXISTS `mydb`.`assessment_comment` (
  `comment_id` INT NULL,
  `user_id` INT NULL,
  `assessment_date` DATE NULL,
  `assessment_binary` ENUM("like", "dislike") NULL,
  INDEX `fk_user_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_comment_idx` (`comment_id` ASC) VISIBLE,
  CONSTRAINT `fk_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `mydb`.`users` (`users_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_comment`
    FOREIGN KEY (`comment_id`)
    REFERENCES `mydb`.`comments` (`comments_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
