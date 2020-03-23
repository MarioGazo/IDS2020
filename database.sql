-- File: database.sql
-- Authors: Mário Gažo(xgazom00), Matej Otčenáš(xotcen01)
-- Zadanie do IDS 2019/20


-- Reset databazy
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
    Typ         CHAR(50),
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
    Mesto           CHAR(20) NOT NULL,
    PSC             INT
);

CREATE TABLE Trener
(
    Rodne_cislo     INT PRIMARY KEY NOT NULL,
    FOREIGN KEY     (Rodne_cislo) REFERENCES Osoba(Rodne_cislo),
    Zaciatok        CHAR(5),
    Koniec          CHAR(5)
);

CREATE TABLE Lekcia
(
    Poradie     INT NOT NULL PRIMARY KEY,
    Miesta      INT,
    Den         CHAR(10),
    Zahajenie   CHAR(5),
    Ukoncenie   CHAR(5),
    Cena        FLOAT,
    Miestnost   CHAR(50),
    Kurz        CHAR(50),
    Rodne_cislo INT,

    CONSTRAINT Miestnost_fk
        FOREIGN KEY (Miestnost) REFERENCES Miestnost(Nazov),

    CONSTRAINT Kurz_fk
        FOREIGN KEY (Kurz) REFERENCES Kurz(Nazov),

    CONSTRAINT  Rodne_cislo_fk
        FOREIGN KEY (Rodne_cislo) REFERENCES Trener(Rodne_cislo)
);

CREATE TABLE Prihlaseny
(
    Poradove_cislo  INT,
    FOREIGN KEY     (Poradove_cislo) REFERENCES Lekcia(Poradie),
    Prihlaseny      INT,
    FOREIGN KEY     (Prihlaseny) REFERENCES Osoba(Rodne_cislo)
);



-- Vlozenie dat

-- Miestnost
INSERT INTO Miestnost(Nazov, Umiestnenie, Kapacita)
VALUES ('Box', 'A00', 30);

INSERT INTO Miestnost(Nazov, Umiestnenie, Kapacita)
VALUES ('Spinning', 'A01', 60);

INSERT INTO Miestnost(Nazov, Umiestnenie, Kapacita)
VALUES ('Bazen', 'B04', 40);

INSERT INTO Miestnost(Nazov, Umiestnenie, Kapacita)
VALUES ('Posilňovňa', 'A05', 100);

--Kurz
INSERT INTO Kurz(Nazov, Typ, Obtiaznost, Trvanie, Kapacita, Popis)
VALUES ('Crossfit', 'Pokročilý/Hybrid', 4, 90, 20, 'Kurz pre pokročilých, zamerané na spodnú časť tela.');

INSERT INTO Kurz(Nazov, Typ, Obtiaznost, Trvanie, Kapacita, Popis)
VALUES ('Body_form', 'Začiatočník/Ženy', 2, 45, 40, 'Základný kurz pre ženy zameraný na precvičenie celého tela.');

INSERT INTO Kurz(Nazov, Typ, Obtiaznost, Trvanie, Kapacita, Popis)
VALUES ('Plávanie', 'Stredne_pokročilý/Muži', 3, 60, 30, 'Kurz pre stredne pokročilých plavcov.');

--Osoba
INSERT INTO Osoba(Rodne_cislo, Meno, Priezvisko, Tel_cislo, Ulica, Popisne_cislo, Mesto, PSC)
VALUES (8904253333, 'Peter', 'Bezbohý', '+421949503611', 'Nekonečná', 42, 'Trnava', 92154);

INSERT INTO Osoba(Rodne_cislo, Meno, Priezvisko, Tel_cislo, Ulica, Popisne_cislo, Mesto, PSC)
VALUES (9804254444, 'Ignác', 'Bezruký', '+420901504411', 'Konečná', 24, 'Šurany', 99301);

INSERT INTO Osoba(Rodne_cislo, Meno, Priezvisko, Tel_cislo, Ulica, Popisne_cislo, Mesto, PSC)
VALUES (9904295555, 'Violeta', 'Beznohá', '+421967999976', 'Začiatočná', 420, 'Piešťany', 92101);

--Vlozenie viacej osob koli vacsej variabilite
INSERT INTO Osoba(Rodne_cislo, Meno, Priezvisko, Tel_cislo, Ulica, Popisne_cislo, Mesto, PSC)
VALUES (7303245432, 'Charlie', 'Sheen', '+300458735298', 'Palms Spring', 420, 'Miami', 100000);

INSERT INTO Osoba(Rodne_cislo, Meno, Priezvisko, Tel_cislo, Ulica, Popisne_cislo, Mesto, PSC)
VALUES (5509306665, 'Arnold', 'Švarceneger', '+100432768467', 'Unknown', 300, 'Pezinok', 97893);

--Trener
INSERT INTO Trener(Rodne_cislo, Zaciatok, Koniec)
VALUES ((SELECT Rodne_cislo FROM Osoba WHERE Osoba.Rodne_cislo=9904295555),'17:25', '19:00');

INSERT INTO Trener(Rodne_cislo, Zaciatok, Koniec)
VALUES ((SELECT Rodne_cislo FROM Osoba WHERE Osoba.Rodne_cislo=9804254444),'08:00', '20:00');

INSERT INTO Trener(Rodne_cislo, Zaciatok, Koniec)
VALUES ((SELECT Rodne_cislo FROM Osoba WHERE Osoba.Rodne_cislo=5509306665),'17:00', '17:30');

--Lekcia
INSERT INTO Lekcia(Poradie, Miesta, Den, Zahajenie, Ukoncenie, Cena, Miestnost, Kurz, Rodne_cislo)
VALUES (3, 20, 'Pondelok', '12:00', '13:30', 17.50, 'Box','Crossfit', (SELECT Rodne_cislo FROM Trener WHERE Trener.Rodne_cislo=9904295555));

INSERT INTO Lekcia(Poradie, Miesta, Den, Zahajenie, Ukoncenie, Cena, Miestnost, Kurz, Rodne_cislo)
VALUES  (1, 2, 'Streda', '12:45', '17:50', 23.99,'Bazen', 'Plávanie', (SELECT Rodne_cislo FROM Trener WHERE Trener.Rodne_cislo=9804254444));

INSERT INTO Lekcia(Poradie, Miesta, Den, Zahajenie, Ukoncenie, Cena, Miestnost, Kurz, Rodne_cislo)
VALUES  (5, 8, 'Streda', '12:45', '17:50', 10, 'Spinning', 'Body_form', (SELECT Rodne_cislo FROM Trener WHERE Trener.Rodne_cislo=9904295555));


--Prihlaseny
INSERT INTO  Prihlaseny(Poradove_cislo, Prihlaseny)
VALUES (1, 5509306665);

INSERT INTO  Prihlaseny(Poradove_cislo, Prihlaseny)
VALUES (5, 5509306665);

INSERT INTO  Prihlaseny(Poradove_cislo, Prihlaseny)
VALUES (1, 8904253333);


/*  Koniec súboru database.sql */