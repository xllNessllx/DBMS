USE `swepl`;

DROP TABLE IF EXISTS `ist in`;
DROP TABLE IF EXISTS `Gruppe`;
DROP TABLE IF EXISTS `Semester`;
DROP TABLE IF EXISTS `Benutzer`;
DROP TABLE IF EXISTS `Student`;

CREATE TABLE Benutzer(
	ID INT UNSIGNED NOT NULL AUTO_INCREMENT,
	Benutzername VARCHAR(50) NOT NULL UNIQUE,
	Passwort VARCHAR(50) NOT NULL,
	IstDozent BOOL NOT NULL,
	CONSTRAINT Benutzer_primär PRIMARY KEY (ID),
	CONSTRAINT Benutzer_eindeutig UNIQUE (ID)
);

CREATE TABLE Semester(
	Kennung INT UNSIGNED NOT NULL,
	Jahr YEAR NOT NULL DEFAULT YEAR(CURRENT_DATE),
	CONSTRAINT Semester_primär PRIMARY KEY (Kennung),
	CONSTRAINT Semester_eindeutig UNIQUE (Kennung)
);

CREATE TABLE Gruppe(
	Gruppennummer INT UNSIGNED NOT NULL AUTO_INCREMENT,
	Betreuer_1_FK INT UNSIGNED,
	Betreuer_2_FK INT UNSIGNED,
	Semester_FK INT UNSIGNED,
	CONSTRAINT Gruppe_primär PRIMARY KEY (Gruppennummer),
	CONSTRAINT `Gruppe wird betreut` FOREIGN KEY (Betreuer_1_FK) REFERENCES `Benutzer`(ID),
	CONSTRAINT `Gruppe wird betreut 2` FOREIGN KEY (Betreuer_2_FK) REFERENCES `Benutzer`(ID),
	CONSTRAINT `Gruppe ist in Semester` FOREIGN KEY (Semester_FK) REFERENCES `Semester`(Kennung),
	CONSTRAINT Gruppe_eindeutig UNIQUE (Gruppennummer)
);

CREATE TABLE Student(
	Matrikelnummer INT(9) UNSIGNED NOT NULL,
	Vorname VARCHAR(50) NOT NULL,
	Nachname VARCHAR(50) NOT NULL,
	CONSTRAINT Student_primär PRIMARY KEY (Matrikelnummer),
	CONSTRAINT Student_eindeutig UNIQUE (Matrikelnummer)
);

-- N:M Relationen:

CREATE TABLE `ist in`(
	Student_FK INT(9) UNSIGNED,
	Gruppe_FK INT UNSIGNED,
	CONSTRAINT ist_in_primär PRIMARY KEY (Student_FK,Gruppe_FK),
	CONSTRAINT `Student ist in` FOREIGN KEY (Student_FK) REFERENCES `Student`(Matrikelnummer),
	CONSTRAINT `Gruppe enthält` FOREIGN KEY (Gruppe_FK) REFERENCES `Gruppe`(Gruppennummer) 
);
