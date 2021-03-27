CREATE SCHEMA `movies` ;
 
 CREATE TABLE `movies`.`details` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `MovieName` VARCHAR(45) NOT NULL,
  `ReleaseDate` DATETIME NOT NULL,
  PRIMARY KEY (`ID`));
 
 INSERT INTO `movies`.`details` ( `MovieName`, `ReleaseDate`) VALUES
 ('Onward', '2020-03-06'),
 ('Irresistible', '2020-06-26'),
 ('The New Mutants', '2020-08-26'),
 ('The Wrong Missy', '2020-03-06'),
 ('Spiderman Far From Home', '2019-06-26'),
 ('Dolittle', '2020-01-17');

CREATE TABLE `movies`.`ratings` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `Score` INT,
  `Critic` VARCHAR(45) NULL,
  `MovieName` VARCHAR(45) NULL,
  PRIMARY KEY (`ID`));

INSERT INTO `movies`.`ratings` (`Score`, `Critic`, `MovieName`) VALUES
( 4, 'Melanie', 'Spiderman Far From Home'),
( 4, 'Melanie', 'Dolittle'),
( 2, 'Melanie', 'Irresistible'),
( 3, 'Melanie', 'The New Mutants'),
( 4, 'Melanie', 'Onward'),
( 4, 'Melanie', 'The Wrong Missy');

INSERT INTO `movies`.`ratings` (`Score`, `Critic`, `MovieName`) VALUES
( null, 'Sterling', 'Spiderman Far From Home'),
( 3, 'Sterling', 'Dolittle'),
( null, 'Sterling', 'Irresistible'),
( null, 'Sterling', 'The New Mutants'),
( 5, 'Sterling', 'Onward'),
( 5, 'Sterling', 'The Wrong Missy');

INSERT INTO `movies`.`ratings` (`Score`, `Critic`, `MovieName`) VALUES
( null, 'Dennis', 'Spiderman Far From Home'),
( null, 'Dennis', 'Dolittle'),
( null, 'Dennis', 'Irresistible'),
( null, 'Dennis', 'The New Mutants'),
( null, 'Dennis', 'Onward'),
( 4, 'Dennis', 'The Wrong Missy');

INSERT INTO `movies`.`ratings` (`Score`, `Critic`, `MovieName`) VALUES
( null, 'Kimberly', 'Spiderman Far From Home'),
( 4, 'Kimberly', 'Dolittle'),
( 5, 'Kimberly', 'Irresistible'),
( null, 'Kimberly', 'The New Mutants'),
( 3, 'Kimberly', 'Onward'),
( null, 'Kimberly', 'The Wrong Missy');

INSERT INTO `movies`.`ratings` (`Score`, `Critic`, `MovieName`) VALUES
( 5, 'Richard', 'Spiderman Far From Home'),
( 1, 'Richard', 'Dolittle'),
( 3, 'Richard', 'Irresistible'),
( null, 'Richard', 'The New Mutants'),
( 5, 'Richard', 'Onward'),
( 5, 'Richard', 'The Wrong Missy');


