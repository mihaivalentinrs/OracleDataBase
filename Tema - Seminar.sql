--Rezolvare exercitii baze de date--Tema Seminar SQL
create table DEP(
    id number(7) primary key,
    denumire varchar2(25)
);

insert into DEP select id_departament, denumire_departament from departamente;
select id_departament, denumire_departament from departamente;

select id, denumire from dep;

create table ang(
    id number(7) primary key,
    nume varchar2(25) NOT NULL,
    prenume varchar2(25) NOT NULL,
    dep_id number(7) constraint fk_dep references dep
);

alter table ang add 
(
    varsta number(2) not null
);
select varsta from ang;
alter table ang 
add constraint check_varsta check (varsta>=18 and varsta<=65);
alter table ang disable constraint check_varsta;
alter table ang modify (varsta number(30));
alter table ang rename to angajati2;
select * from angajati2;
select id_functie from ANGAJATI;
select * from SALARIATI;
create table salariati_tema(
    id_angajat number(7) primary key,
    nume_angajat VARCHAR2(25) NOT NULL,
    prenume_angajat VARCHAR2(25) NOT NULL,
    email VARCHAR2(50) UNIQUE,
    telefon VARCHAR2(15) UNIQUE,
    data_angajare date default sysdate,
    salariul number(15),
    comision number(7),
    id_departament number(7),
    id_functie number(7),
    constraint fk_departament foreign key (id) references dep,
    constraint fk_functie foreign key (id_functie) references angajati,
    constraint check_salariu check (salariul>0),
    constraint check_comision check (comision>=0)

);


