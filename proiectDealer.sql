-- PASUL 1: Tabelul pentru clienți
-- Aici stocăm datele clienților dealership-ului
CREATE TABLE clienti_dealer(
    id_client NUMBER(10) PRIMARY KEY,
    nume VARCHAR2(100),
    prenume VARCHAR2(100),
    email VARCHAR2(100) NOT NULL,
    telefon VARCHAR2(20),
    data_inregistrare DATE DEFAULT SYSDATE
);

-- PASUL 2: Tabelul pentru mărci auto
-- Ex: Volkswagen, BMW, Audi etc.
CREATE TABLE marca(
    id_marca NUMBER(10) PRIMARY KEY,
    nume_marca VARCHAR2(50) NOT NULL,
    tara_marca VARCHAR2(50)
);

-- PASUL 3: Tabelul pentru modele auto
-- Ex: Golf, Passat, A4 etc.
-- TREBUIE creat după "marca" pentru că face referință la id_marca
CREATE TABLE modele(
    id_model NUMBER(10) PRIMARY KEY,
    id_marca NUMBER(10) NOT NULL,
    nume_model VARCHAR2(100),
    an_fabricatie NUMBER(4),
    tip_caroserie VARCHAR2(50),
    CONSTRAINT fk_marca FOREIGN KEY (id_marca) REFERENCES marca(id_marca)
);

-- PASUL 4: Tabelul pentru departamente
-- NU includemFK către angajați încă (rezolvăm referința circulară)
CREATE TABLE departament_dealer(
    id_departament NUMBER(10) PRIMARY KEY,
    id_manager NUMBER(10),  -- Deocamdată fără FK
    nume_manager VARCHAR2(100),
    prenume_manager VARCHAR2(100),
    nume_departament VARCHAR2(50) NOT NULL,
    numar_angajati NUMBER(2,0) CHECK (numar_angajati > 0)
);

-- PASUL 5: Tabelul pentru angajați
-- Acum putem face referință la departament_dealer (care deja există)
-- id_manager face referință la același tabel (self-reference)
CREATE TABLE angajati_dealer(
    id_angajat NUMBER(10) PRIMARY KEY,
    nume_angajat VARCHAR2(100),
    prenume_angajat VARCHAR2(100),
    departament VARCHAR2(100),
    email_angajat VARCHAR2(100) NOT NULL,
    telefon_angajat VARCHAR2(15) UNIQUE,
    data_angajare DATE DEFAULT SYSDATE,
    id_manager NUMBER(10),  -- Managerul direct (alt angajat)
    id_departament NUMBER(10),
    -- Self-reference: un angajat poate avea ca manager alt angajat
    CONSTRAINT fk_manager FOREIGN KEY (id_manager) REFERENCES angajati_dealer(id_angajat),
    CONSTRAINT fk_departament FOREIGN KEY (id_departament) REFERENCES departament_dealer(id_departament)
);

-- PASUL 6: Tabelul pentru vânzări
-- Leagă împreună: client + model + angajat
CREATE TABLE vanzari(
    id_vanzare NUMBER(10) PRIMARY KEY,
    id_client NUMBER(10),
    id_model NUMBER(10),
    id_angajat NUMBER(10),
    data_vanzare DATE DEFAULT SYSDATE,
    pret_vanzare_lei NUMBER(8,2),
    pret_vanzare_euro NUMBER(6,2),
    CONSTRAINT fk_vanzare_client FOREIGN KEY (id_client) REFERENCES clienti_dealer(id_client),
    CONSTRAINT fk_vanzare_model FOREIGN KEY (id_model) REFERENCES modele(id_model),
    CONSTRAINT fk_vanzare_angajat FOREIGN KEY (id_angajat) REFERENCES angajati_dealer(id_angajat)
);

-- PASUL 7: Tabelul pentru service
-- Înregistrează reparațiile și reviziile
CREATE TABLE service(
    id_service NUMBER(10) PRIMARY KEY,
    id_marca NUMBER(10),
    id_model NUMBER(10),
    id_client NUMBER(10),
    data_intrarii_service DATE DEFAULT SYSDATE,
    data_iesire_service DATE,
    cost_reparatii NUMBER(8,2),
    revizie VARCHAR2(3) CHECK (revizie IN ('DA', 'NU')),
    descriere_problema VARCHAR2(500),
    CONSTRAINT fk_service_marca FOREIGN KEY (id_marca) REFERENCES marca(id_marca),
    CONSTRAINT fk_service_model FOREIGN KEY (id_model) REFERENCES modele(id_model),
    CONSTRAINT fk_service_client FOREIGN KEY (id_client) REFERENCES clienti_dealer(id_client)
);