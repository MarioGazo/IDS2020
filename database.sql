-- File: database.sql
-- Authors: Mário Gažo(xgazom00), Matej Otčenáš(xotcen01)
-- Zadanie do IDS 2019/20

DROP TABLE Prihlaseny;
DROP TABLE Lekcia;
DROP TABLE Trener;
DROP TABLE Osoba;
DROP TABLE Miestnost;
DROP TABLE Kurz;

-- Vytvorenie blokov schémy databáze
CREATE TABLE Kurz
(
    Nazov       CHAR(50) NOT NULL PRIMARY KEY,
    Typ         CHAR(20),
    Obtiaznost  INT,
    Trvanie     INT,
    Kapacita    INT,
    Popis       CHAR(100)
);

CREATE TABLE Miestnost
(
    Nazov       CHAR(50) NOT NULL PRIMARY KEY,
    Umiestnenie CHAR(50),
    Kapacita    INT
);

CREATE TABLE Osoba
(
    Rodne_cislo     INT      NOT NULL PRIMARY KEY,
    Meno            CHAR(20) NOT NULL,
    Priezvisko      CHAR(20) NOT NULL,
    Tel_cislo       CHAR(15),
    Ulica           CHAR(20) NOT NULL,
    Popisne_cislo   INT      NOT NULL,
    Mestio          CHAR(20) NOT NULL,
    PSC             INT
);

CREATE TABLE Trener
(
    Rodne_cislo     INT PRIMARY KEY NOT NULL,
    FOREIGN KEY (Rodne_cislo) REFERENCES Osoba(Rodne_cislo),
    Zaciatok        INT,
    Koniec          INT
);

CREATE TABLE Lekcia
(
    Poradie     INT NOT NULL PRIMARY KEY,
    Miesta      INT,
    Den         INT,
    Zahajenie   INT,
    Ukoncenie   INT,
    Cena        INT,
    Miestnost   CHAR(50),
    FOREIGN KEY (Miestnost) REFERENCES Miestnost(Nazov),
    Rodne_cislo INT,
    FOREIGN KEY (Rodne_cislo) REFERENCES Trener(Rodne_cislo),
    Kurz        CHAR(50),
    FOREIGN KEY (Kurz) REFERENCES Kurz(Nazov)
);

/*CREATE TABLE Individualna
(
    Poradove_cislo  INT,
    FOREIGN KEY (Poradove_cislo) REFERENCES Lekcia(Poradie),
    Prihaseny       INT,
    FOREIGN KEY (Prihaseny) REFERENCES Osoba(Rodne_cislo)
);

CREATE TABLE Skupinova
(
    Poradove_cislo  INT,
    FOREIGN KEY (Poradove_cislo) REFERENCES Lekcia(Poradie),
    Prihlaseny      INT,
    FOREIGN KEY (Prihlaseny) REFERENCES Osoba(Rodne_cislo)
);*/
CREATE TABLE Prihlaseny
(
    Poradove_cislo  INT,
    FOREIGN KEY (Poradove_cislo) REFERENCES Lekcia(Poradie),
    Prihlaseny      INT,
    FOREIGN KEY (Prihlaseny) REFERENCES Osoba(Rodne_cislo)
);

/*  Koniec súboru database.sql */