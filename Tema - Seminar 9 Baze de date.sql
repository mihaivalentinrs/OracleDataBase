--Lucru cu queries
--Tipuri de join-uri
--Recapitulare comenzi

select * from salariati;
select salariul as salariu from salariati;
describe angajati;
select nume || ' ' || prenume as "Nume Angajat" from angajati;
--16.   Sa se afiseze numele, denumirea departamentului unde lucreaza si nivelul ierarhic 
--pentru toti angajatii care au subordonati si care au aceeasi functie ca angajatul Russell.
--17.	Sa se afiseze numele angajatilor care nu au subalterni si care au aceeasi 
--functie ca angajatul Rogers, nivelul ierarhic si denumirea departamentului unde acestia lucreaza.
describe departamente;
select id_functie from angajati where nume = 'Russell';

--Rezolvare problema 16
select 
    a.nume as Nume_angajati, c.denumire_departament as Denumire_Departament, level as Nivel_Ierarhic 
from 
    angajati a join departamente c on a.id_departament = c.id_departament
where
    a.id_functie =(select id_functie from angajati where nume = 'Russell')
and 
    a.id_angajat in (select id_manager from angajati where id_manager is not null)
start with a.id_manager is null
connect by prior a.id_angajat = a.id_manager;

select * from angajati;

--Rezolvare subiect 17
select a.nume as Nume_Angajati, d.denumire_departament as Denumire_Departament, level as Nivel_Ierarhic, sys_connect_by_path(nume, '/') as Path_nume
from 
    angajati a join departamente d on a.id_departament = d.id_departament
where
    a.id_functie = (select id_functie from angajati where nume = 'Rogers')
and 
    a.id_angajat  not in (select id_manager from angajati where id_manager is not null)
start with a.id_manager is null 
connect by prior a.id_angajat = a.id_manager
group by a.nume, d.denumire_departament, level;

select a.nume as Nume_Angajati, d.denumire_departament as Denumire_Departament, level as Nivel_Ierarhic, sys_connect_by_path(nume, '/') as Path_nume
from 
    angajati a join departamente d on a.id_departament = d.id_departament
where
    a.id_functie = (select id_functie from angajati where nume = 'Rogers')
and 
    a.id_angajat  not in (select id_manager from angajati where id_manager is not null)
start with a.id_manager is null 
connect by prior a.id_angajat = a.id_manager;
