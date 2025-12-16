--CERINTE PROIECT ORACLE

--1. 	Definirea schemei bazei de date – tabele, restrictii de integritate. Se utilizează comenzile CREATE, ALTER, DROP.
--2. 	Exemple cu operatiile de actualizare a datelor (comenzile DML – INSERT, UPDATE, DELETE, MERGE (optional) pentru inregistrari).
--3. 	Exemple de interogari variate (SELECT):
--	Utilizarea operatorilor de comparatie 
--	Join-uri
--	Utilizarea functiilor de grup si conditii asupra acestora
--	Utilizarea functiilor numerice, de tip caracter, pentru data si timp
--	Construirea de expresii cu DECODE si CASE
--	Utilizarea operatorilor UNION, MINUS, INTERSECT 
--	Subcereri (cereri imbricate)
--4. Gestiunea altor obiecte ale bazei de date: vederi, indecsi, sinonime, secvente etc.

--Fila Oracle Sql destinata modificarii tabelelor din proiect
--Utilizarea unor comenzi pentru a gestiona structura corecta a proiectului

--1. Modificarea tabelelor pentru a elimina redundantele
alter table vanzari drop column pret_vanzare_lei;
describe vanzari;
alter table departament_dealer drop column numar_angajati;
describe departament_dealer;

select * from marca;
select * from angajati_dealer;
--Introducerea inregistrarilor
--1.Marca
INSERT INTO marca (id_marca, nume_marca, tara_marca) VALUES (1, 'Volkswagen', 'Germania');
INSERT INTO marca (id_marca, nume_marca, tara_marca) VALUES (2, 'Renault', 'Franta');
INSERT INTO marca (id_marca, nume_marca, tara_marca) VALUES (3, 'Tesla', 'SUA');
INSERT INTO marca (id_marca, nume_marca, tara_marca) VALUES (4, 'Toyota', 'Japonia');
INSERT INTO marca (id_marca, nume_marca, tara_marca) VALUES (5, 'BMW', 'Germania');
INSERT INTO marca (id_marca, nume_marca, tara_marca) VALUES (6, 'Dacia', 'Romania');
INSERT INTO marca (id_marca, nume_marca, tara_marca) VALUES (7, 'Hyundai', 'Coreea de Sud');
INSERT INTO marca (id_marca, nume_marca, tara_marca) VALUES (8, 'Ford', 'SUA');
INSERT INTO marca (id_marca, nume_marca, tara_marca) VALUES (9, 'Volvo', 'Suedia');
INSERT INTO marca (id_marca, nume_marca, tara_marca) VALUES (10, 'Mercedes', 'Germania');
--2.Clienti
INSERT INTO clienti_dealer (id_client, nume, prenume, email, telefon) VALUES (101, 'Popescu', 'Andrei', 'andrei.p@mail.com', '0722123456');
INSERT INTO clienti_dealer (id_client, nume, prenume, email, telefon) VALUES (102, 'Ionescu', 'Maria', 'maria.ionescu@mail.com', '0744987654');
INSERT INTO clienti_dealer (id_client, nume, prenume, email, telefon) VALUES (103, 'Diaconu', 'Gabriel', 'gabriel.d@mail.com', '0766112233');
INSERT INTO clienti_dealer (id_client, nume, prenume, email, telefon) VALUES (104, 'Stanciu', 'Alina', 'alina.s@mail.com', '0755443322');
INSERT INTO clienti_dealer (id_client, nume, prenume, email, telefon) VALUES (105, 'Radu', 'Victor', 'victor.r@mail.com', '0733556677');
INSERT INTO clienti_dealer (id_client, nume, prenume, email, telefon) VALUES (106, 'Preda', 'Ioana', 'ioana.p@mail.com', '0788119900');
INSERT INTO clienti_dealer (id_client, nume, prenume, email, telefon) VALUES (107, 'Ciobanu', 'Alexandru', 'alex.c@mail.com', '0700228844');
INSERT INTO clienti_dealer (id_client, nume, prenume, email, telefon) VALUES (108, 'Luca', 'Elena', 'elena.l@mail.com', '0711776655');
INSERT INTO clienti_dealer (id_client, nume, prenume, email, telefon) VALUES (109, 'Mirea', 'Cosmin', 'cosmin.m@mail.com', '0777334455');
INSERT INTO clienti_dealer (id_client, nume, prenume, email, telefon) VALUES (110, 'Zamfir', 'Cristina', 'cristina.z@mail.com', '0799887766');

--3.Departament dealer
INSERT INTO departament_dealer (id_departament, nume_departament) VALUES (1, 'Vanzari Auto Noi');
INSERT INTO departament_dealer (id_departament, nume_departament) VALUES (2, 'Service & Reparatii');
insert into departament_dealer(id_departament, nume_departament) values (2, 'Service/Reparatii');
INSERT INTO departament_dealer (id_departament, nume_departament) VALUES (3, 'Administrativ');
INSERT INTO departament_dealer (id_departament, nume_departament) VALUES (4, 'Vanzari Auto Rulate');
INSERT INTO departament_dealer (id_departament, nume_departament) VALUES (5, 'Piese si Accesorii');
INSERT INTO departament_dealer (id_departament, nume_departament) VALUES (6, 'Marketing');
INSERT INTO departament_dealer (id_departament, nume_departament) VALUES (7, 'Contabilitate');
INSERT INTO departament_dealer (id_departament, nume_departament) VALUES (8, 'Resurse Umane');
INSERT INTO departament_dealer (id_departament, nume_departament) VALUES (9, 'IT Suport');
INSERT INTO departament_dealer (id_departament, nume_departament) VALUES (10, 'Logistica');

--4.Angajati dealer
-- Manager Vanzari Noi (Dept 1)
INSERT INTO angajati_dealer (id_angajat, nume_angajat, prenume_angajat, email_angajat, telefon_angajat, id_departament, id_manager) VALUES (201, 'Vasilescu', 'Mihai', 'mihai.v@dealer.ro', '0700111222', 1, NULL); 
-- Manager Service (Dept 2)
INSERT INTO angajati_dealer (id_angajat, nume_angajat, prenume_angajat, email_angajat, telefon_angajat, id_departament, id_manager) VALUES (202, 'Georgescu', 'Elena', 'elena.g@dealer.ro', '0700333444', 2, null); 
-- Manager Vanzari Rulate (Dept 4)
INSERT INTO angajati_dealer (id_angajat, nume_angajat, prenume_angajat, email_angajat, telefon_angajat, id_departament, id_manager) VALUES (203, 'Popa', 'Adrian', 'adrian.p@dealer.ro', '0700555666', 4, NULL); 
-- Manager Piese (Dept 5)
INSERT INTO angajati_dealer (id_angajat, nume_angajat, prenume_angajat, email_angajat, telefon_angajat, id_departament, id_manager) VALUES (204, 'Dragos', 'Simona', 'simona.d@dealer.ro', '0700777888', 5, NULL); 
-- Angajat Vanzari Noi (Raporteaza catre 201)
INSERT INTO angajati_dealer (id_angajat, nume_angajat, prenume_angajat, email_angajat, telefon_angajat, id_departament, id_manager) VALUES (205, 'Dumitru', 'Ciprian', 'ciprian.d@dealer.ro', '0700990011', 1, 201); 
-- Angajat Service (Raporteaza catre 202)
INSERT INTO angajati_dealer (id_angajat, nume_angajat, prenume_angajat, email_angajat, telefon_angajat, id_departament, id_manager) VALUES (206, 'Marinescu', 'Florin', 'florin.m@dealer.ro', '0700224466', 2, 202); 
-- Angajat Vanzari Rulate (Raporteaza catre 203)
INSERT INTO angajati_dealer (id_angajat, nume_angajat, prenume_angajat, email_angajat, telefon_angajat, id_departament, id_manager) VALUES (207, 'Oprea', 'Daniel', 'daniel.o@dealer.ro', '0700881133', 4, 203); 
-- Angajat Administrativ (Raporteaza catre 201)
INSERT INTO angajati_dealer (id_angajat, nume_angajat, prenume_angajat, email_angajat, telefon_angajat, id_departament, id_manager) VALUES (208, 'Voicu', 'Ana', 'ana.v@dealer.ro', '0700445566', 3, 201); 
-- Angajat Service (Raporteaza catre 202)
INSERT INTO angajati_dealer (id_angajat, nume_angajat, prenume_angajat, email_angajat, telefon_angajat, id_departament, id_manager) VALUES (209, 'Barbu', 'Adrian', 'adrian.b@dealer.ro', '0700102030', 2, 202); 
-- Angajat Marketing (Raporteaza catre 201)
INSERT INTO angajati_dealer (id_angajat, nume_angajat, prenume_angajat, email_angajat, telefon_angajat, id_departament, id_manager) VALUES (210, 'Nedelcu', 'Laura', 'laura.n@dealer.ro', '0700908070', 6, 201);

--5.Modele
-- ID_MARCA: 1=VW, 2=Renault, 3=Tesla, 4=Toyota, 5=BMW, 6=Dacia, 7=Hyundai, 8=Ford, 9=Volvo, 10=Mercedes
-- Modele Noi
INSERT INTO modele (id_model, id_marca, nume_model, an_fabricatie, tip_caroserie, tip_vehicul, serie_sasiu, numar_kilometri, motorizare, capacitate_cilindrica) 
VALUES (301, 1, 'Golf 8', 2024, 'Hatchback', 'new', 'VWZ_G8_A1234567', 10, 'termic', 1498);
INSERT INTO modele (id_model, id_marca, nume_model, an_fabricatie, tip_caroserie, tip_vehicul, serie_sasiu, numar_kilometri, motorizare, capacitate_cilindrica) 
VALUES (302, 3, 'Model Y', 2025, 'SUV', 'new', 'TES_MY_B9876543', 50, 'electric', 0);
INSERT INTO modele (id_model, id_marca, nume_model, an_fabricatie, tip_caroserie, tip_vehicul, serie_sasiu, numar_kilometri, motorizare, capacitate_cilindrica) 
VALUES (303, 5, 'Seria 3', 2024, 'Sedan', 'new', 'BMW_S3_C1122334', 15, 'termic', 1998);
INSERT INTO modele (id_model, id_marca, nume_model, an_fabricatie, tip_caroserie, tip_vehicul, serie_sasiu, numar_kilometri, motorizare, capacitate_cilindrica) 
VALUES (304, 6, 'Spring', 2025, 'Crossover', 'new', 'DAC_SP_D5566778', 5, 'electric', 0);
INSERT INTO modele (id_model, id_marca, nume_model, an_fabricatie, tip_caroserie, tip_vehicul, serie_sasiu, numar_kilometri, motorizare, capacitate_cilindrica) 
VALUES (305, 10, 'GLE', 2024, 'SUV', 'new', 'MER_GE_E9900112', 200, 'termic', 2999);

-- Modele Rulate (Used)
INSERT INTO modele (id_model, id_marca, nume_model, an_fabricatie, tip_caroserie, tip_vehicul, serie_sasiu, numar_kilometri, motorizare, capacitate_cilindrica) 
VALUES (306, 2, 'Clio IV', 2018, 'Hatchback', 'used', 'REN_C4_F3456789', 95000, 'termic', 1500);
INSERT INTO modele (id_model, id_marca, nume_model, an_fabricatie, tip_caroserie, tip_vehicul, serie_sasiu, numar_kilometri, motorizare, capacitate_cilindrica) 
VALUES (307, 4, 'Corolla', 2020, 'Sedan', 'used', 'TOY_CR_G1020304', 55000, 'termic', 1798);
INSERT INTO modele (id_model, id_marca, nume_model, an_fabricatie, tip_caroserie, tip_vehicul, serie_sasiu, numar_kilometri, motorizare, capacitate_cilindrica) 
VALUES (308, 8, 'Focus', 2019, 'Hatchback', 'used', 'FRD_FC_H7788990', 72000, 'termic', 1596);
INSERT INTO modele (id_model, id_marca, nume_model, an_fabricatie, tip_caroserie, tip_vehicul, serie_sasiu, numar_kilometri, motorizare, capacitate_cilindrica) 
VALUES (309, 9, 'XC60', 2021, 'SUV', 'used', 'VOL_X6_I1133557', 35000, 'termic', 1969);
INSERT INTO modele (id_model, id_marca, nume_model, an_fabricatie, tip_caroserie, tip_vehicul, serie_sasiu, numar_kilometri, motorizare, capacitate_cilindrica) 
VALUES (310, 7, 'Kona EV', 2022, 'SUV', 'used', 'HYU_KN_J2244668', 25000, 'electric', 0);


--6.Vanzari

INSERT INTO vanzari (id_vanzare, id_client, id_model, id_angajat, data_vanzare, pret_vanzare_euro) VALUES (401, 101, 301, 205, DATE '2025-03-25', 26262.63);
INSERT INTO vanzari (id_vanzare, id_client, id_model, id_angajat, data_vanzare, pret_vanzare_euro) VALUES (402, 102, 302, 205, DATE '2025-04-01', 50505.05);
INSERT INTO vanzari (id_vanzare, id_client, id_model, id_angajat, data_vanzare, pret_vanzare_euro) VALUES (403, 103, 303, 205, DATE '2025-04-10', 38383.84);
INSERT INTO vanzari (id_vanzare, id_client, id_model, id_angajat, data_vanzare, pret_vanzare_euro) VALUES (404, 104, 304, 205, DATE '2025-04-15', 17171.72);
INSERT INTO vanzari (id_vanzare, id_client, id_model, id_angajat, data_vanzare, pret_vanzare_euro) VALUES (405, 105, 305, 205, DATE '2025-04-20', 70707.07);


INSERT INTO vanzari (id_vanzare, id_client, id_model, id_angajat, data_vanzare, pret_vanzare_euro) VALUES (406, 106, 306, 207, DATE '2025-05-01', 7070.71);
INSERT INTO vanzari (id_vanzare, id_client, id_model, id_angajat, data_vanzare, pret_vanzare_euro) VALUES (407, 107, 307, 207, DATE '2025-05-05', 15151.52);
INSERT INTO vanzari (id_vanzare, id_client, id_model, id_angajat, data_vanzare, pret_vanzare_euro) VALUES (408, 108, 308, 207, DATE '2025-05-10', 10101.01);
INSERT INTO vanzari (id_vanzare, id_client, id_model, id_angajat, data_vanzare, pret_vanzare_euro) VALUES (409, 109, 309, 207, DATE '2025-05-15', 24242.42);
INSERT INTO vanzari (id_vanzare, id_client, id_model, id_angajat, data_vanzare, pret_vanzare_euro) VALUES (410, 110, 310, 207, DATE '2025-05-20', 19191.92);

--7.Service
-- Revizii DA
INSERT INTO service (id_service, id_model, id_client, data_intrarii_service, data_iesire_service, cost_reparatii, revizie, descriere_problema) 
VALUES (501, 306, 106, DATE '2025-06-01', DATE '2025-06-02', 1500.00, 'DA', 'Revizie anuala (Renault Clio).');
INSERT INTO service (id_service, id_model, id_client, data_intrarii_service, data_iesire_service, cost_reparatii, revizie, descriere_problema) 
VALUES (502, 307, 107, DATE '2025-06-05', DATE '2025-06-05', 900.00, 'DA', 'Schimb ulei si filtre (Toyota Corolla).');
INSERT INTO service (id_service, id_model, id_client, data_intrarii_service, data_iesire_service, cost_reparatii, revizie, descriere_problema) 
VALUES (503, 308, 108, DATE '2025-06-10', DATE '2025-06-12', 4500.00, 'DA', 'Revizie majora, schimb distributie (Ford Focus).');

-- Revizii NU (Reparații)
INSERT INTO service (id_service, id_model, id_client, data_intrarii_service, data_iesire_service, cost_reparatii, revizie, descriere_problema) 
VALUES (504, 301, 101, DATE '2025-06-15', DATE '2025-06-17', 250.00, 'NU', 'Probleme software la navigatie (VW Golf).');
INSERT INTO service (id_service, id_model, id_client, data_intrarii_service, data_iesire_service, cost_reparatii, revizie, descriere_problema) 
VALUES (505, 309, 109, DATE '2025-06-20', DATE '2025-06-25', 7800.00, 'NU', 'Reparatie majora la sistemul de franare (Volvo XC60).');
INSERT INTO service (id_service, id_model, id_client, data_intrarii_service, data_iesire_service, cost_reparatii, revizie, descriere_problema) 
VALUES (506, 310, 110, DATE '2025-07-01', DATE '2025-07-01', 0.00, 'NU', 'Verificare baterie in garantie (Hyundai Kona).');
INSERT INTO service (id_service, id_model, id_client, data_intrarii_service, data_iesire_service, cost_reparatii, revizie, descriere_problema) 
VALUES (507, 303, 103, DATE '2025-07-05', DATE '2025-07-06', 150.00, 'NU', 'Schimb bec far (BMW Seria 3).');

-- Intrări în Service (data_iesire_service IS NULL)
INSERT INTO service (id_service, id_model, id_client, data_intrarii_service, data_iesire_service, cost_reparatii, revizie, descriere_problema) 
VALUES (508, 302, 102, DATE '2025-07-10', NULL, 0.00, 'DA', 'Revizie programata 1 an (Tesla Model Y).');
INSERT INTO service (id_service, id_model, id_client, data_intrarii_service, data_iesire_service, cost_reparatii, revizie, descriere_problema) 
VALUES (509, 304, 104, DATE '2025-07-15', NULL, 0.00, 'NU', 'Asteptare piesa pentru incarcator (Dacia Spring).');
INSERT INTO service (id_service, id_model, id_client, data_intrarii_service, data_iesire_service, cost_reparatii, revizie, descriere_problema) 
VALUES (510, 305, 105, DATE '2025-07-20', NULL, 0.00, 'DA', 'Revizie mare, inca in lucru (Mercedes GLE).');

--Update tabela modele:
UPDATE modele SET putere = 
    CASE id_model
        WHEN 301 THEN 150  -- VW Golf 8
        WHEN 302 THEN 350  -- Tesla Model Y (estimare electric)
        WHEN 303 THEN 190  -- BMW Seria 3
        WHEN 304 THEN 45   -- Dacia Spring (electric)
        WHEN 305 THEN 330  -- Mercedes GLE
        WHEN 306 THEN 90   -- Renault Clio IV
        WHEN 307 THEN 120  -- Toyota Corolla
        WHEN 308 THEN 125  -- Ford Focus
        WHEN 309 THEN 190  -- Volvo XC60
        WHEN 310 THEN 204  -- Hyundai Kona EV (electric)
        ELSE NULL
    END
WHERE id_model IN (301, 302, 303, 304, 305, 306, 307, 308, 309, 310);

alter table vanzari modify pret_vanzare_euro number(7,2);

select * from clienti_dealer;
select * from marca;
select * from departament_dealer; --de verificat
select * from angajati_dealer; --de verificat 
select * from service; 
select * from vanzari;
select * from modele;
select * from departament_dealer order by id_departament asc;


--Exemple de interogari variate (SELECT)