--Rezolvare tema finala

-- Exercitii recapitulative III – Interogari, functii de grup, CASE, DECODE

-- In aceste exercitii utilizati tabelele My_emp, My_dept si My_jobs create pe baza tabelelor Employees, Departmens si  Jobs din schema (user-ul) HR. Utilizati comenzilede mai jos pentru a crea aceste tabele:
DROP TABLE MY_EMP;
DROP TABLE MY_DEPT;
DROP TABLE MY_JOBS;
CREATE TABLE MY_EMP AS SELECT * FROM HR.EMPLOYEES;
CREATE TABLE MY_DEPT AS SELECT * FROM HR.DEPARTMENTS;
CREATE TABLE MY_JOBS AS SELECT * FROM HR.JOBS;

-- Exercitii:

-- 1.	Sa se calculeze pe fiecare departament (department_name) suma totala corespunzatoare salariilor angajatilor, denuminind coloana respectiva total_salarii.
select a.denumire_departament as Nume_dep, c.nume||' '||c.prenume as Nume_angajat, sum(c.salariul) as Total_salarii
from departamente a join angajati c 
on a.id_departament = c.id_departament
group by a.denumire_departament, c.nume, c.prenume;
-- 2.	Sa se calculeze urmatoarele statistici pe fiecare tip de functie (job_title): salariul minim, salariul mediu si salariul maxim corespunzator fiecarei functii. 
select * from angajati;
select * from DEPARTAMENTE; 

select 
    id_functie as Denumire_functie,
    min(salariul) as Salariul_min,
    avg(salariul) as Salariul_mediu,
    max(salariul) as Salariul_max
from angajati 
group by id_functie;

-- 3.	Modificati conditia de sus astfel incat sa se afiseze si numarul total de angajati care detin o anumit functie.

select 
    id_functie as Denumire_functie,
    count(id_angajat) as Nr_ang,
    min(salariul) as Salariul_min,
    avg(salariul) as Salariul_mediu,
    max(salariul) as Salariul_max
from angajati 
group by id_functie;

-- 4.	Sa se calculeze numarul de angajati pe fiecare departament.
select d.denumire_departament as Nume_departament, d.id_departament, count(a.id_angajat) as Numar_angajati_dep
from 
departamente d 
join 
angajati a 
on d.id_departament = a.id_departament
group by d.denumire_departament, d.id_departament
order by d.id_departament;
-- 5.	Sa se calculeze numarul de angajati din departamentele: Purchasing, Shipping, IT.
select d.denumire_departament as Nume_dep, d.id_departament, count(a.id_angajat) as Numar_angajati_dep 
from departamente d
join angajati a 
on d.id_departament = a.id_departament
where d.denumire_departament in ('Purchasing', 'Shipping', 'IT')
group by d.denumire_departament, d.ID_DEPARTAMENT
order by d.id_departament;
-- 6.	Sa se calculeze numarul de salariati angajati inainte de 15 august 2000 (hire_date). 
select * from angajati;
select * from salariati;
select 
 count(id_angajat) as Numar_angajati, data_angajare as Data_angajare
from salariati
where data_angajare < to_date('15/08/2000', 'DD/MM/YYYY')
group by data_angajare;
-- 7.	Sa se afiseze doar departamentele care au un numar de angajati >5. Sa se calculeze pentru aceste departamente suma total de plata referitoare la salarii.
select d.denumire_departament, sum(a.salariul) as Suma_total_plata_salarii
from departamente d 
join 
angajati a 
on d.id_departament = a.id_departament
where (select count(a.id_angajat) as Numar_angajati 
from angajati a join departamente d 
on a.id_departament = d.id_departament) > 5
group by d.denumire_departament;
-- 8.	Sa se afiseze numai departamentele care platesc salarii totale cu valoarea mai mare de 20000. Sa se calculeze pentru acestea salariul mediu pe department.
select d.denumire_departament as Nume_dep, round(avg(a.salariul), 2) as Medie_salarii
from departamente d 
join 
angajati a 
on d.id_departament = a.id_departament
where (select sum(a.salariul) as total_salarii 
from angajati a join departamente d 
on a.id_departament = d.id_departament) > 20000
group by d.denumire_departament;
-- 9.	Sa se calculeze pe fiecare functie in parte suma totala incasata formata din salariu * (1+comisionul) aferent. Sa  se afiseze doar functiile cu valori peste 25000.
select * from salariati;
select * from angajati;
select id_functie as Nume_functie, salariul * (1+nvl(comision, 0))as Suma_totala_incasata from angajati
where salariul * (1+nvl(comision,0)) > 25000 ;
-- 10.	Realizati o statistica pe fiecare department (department_id) si pe fiecare functie din departamente (job_id) referitoare la salariul minim, salariul mediu, salariul maxim si numarul total de angajati.
select * from departamente;
-- 11.	Sa se afiseze numele angajatilor si sa se mareasca salariile in functie de departament astfel:
-- -	Daca department_id= 20 atunci cresterea sa fie de 10%
-- -	Daca department_id= 40 atunci cresterea sa fie de 15%
-- -	Daca department_id= 60 atunci cresterea sa fie de 20%
-- -	In rest sa nu se aplice cresteri salariale.
select nume||' '||prenume as Nume_angajat, id_departament, salariul as salariu_vechi,
case 
    when id_departament = 20 then salariul*1.1
    when id_departament = 40 then salariul*1.15
    when id_departament = 60 then salariul*1.2
end as Salariul_nou
from angajati;

-- 12.	Sa se afiseze numele, salariul si functia angajatiilor, precum si suma de incasat astfel: 
-- -	daca job_id este SA_REP sau SA_MAN atunci suma_incasat = salary* (1+commission_pct)
-- -	daca job_id este IT atunci  suma_incasat = salary*1.2
-- -	pentru celelalte functii  suma_incasat = salary
select nume||' '||prenume as Nume_angajat, salariul, id_functie, 
case 
    when id_functie in ('SA_REP', 'SA_MAN') then salariul*(1+nvl(comision, 0))
    when id_functie = 'IT' then salariul*1.2
    else salariul 
end as suma_incasat
from angajati;

-- 13.	Sa se acorde prime fiecarui angajat in functie de vechime astfel:
-- -	Pentru cei angajati inainte de 1 ianuarie 1995 prima=30%*salary
-- -	Pentru cei angajati inainte de 1 ianuarie 1997 prima=20%*salary
-- -	Pentru cei angajati inainte de 1 ianuarie 2000 prima=10%*salary
-- -	Pentru ceilalti angajati prima = 5%*salary
SELECT 
    nume, 
    prenume, 
    data_angajare, 
    salariul,
    CASE 
        WHEN data_angajare < TO_DATE('01/01/1995', 'DD/MM/YYYY') THEN salariul * 0.30
        WHEN data_angajare < TO_DATE('01/01/1997', 'DD/MM/YYYY') THEN salariul * 0.20
        WHEN data_angajare < TO_DATE('01/01/2000', 'DD/MM/YYYY') THEN salariul * 0.10
        ELSE salariul * 0.05
    END AS prima
FROM angajati;
-- 14.	 Sa se rezolve punctul de mai sus cu ajutorul operatorului UNION.
SELECT nume, prenume, data_angajare, salariul * 0.30 AS prima FROM angajati 
    WHERE data_angajare < TO_DATE('01/01/1995', 'DD/MM/YYYY')
UNION
SELECT nume, prenume, data_angajare, salariul * 0.20 AS prima FROM angajati 
    WHERE data_angajare >= TO_DATE('01/01/1995', 'DD/MM/YYYY') AND data_angajare < TO_DATE('01/01/1997', 'DD/MM/YYYY')
UNION
SELECT nume, prenume, data_angajare, salariul * 0.10 AS prima FROM angajati 
    WHERE data_angajare >= TO_DATE('01/01/1997', 'DD/MM/YYYY') AND data_angajare < TO_DATE('01/01/2000', 'DD/MM/YYYY')
UNION
SELECT nume, prenume, data_angajare, salariul * 0.05 AS prima FROM angajati 
    WHERE data_angajare >= TO_DATE('01/01/2000', 'DD/MM/YYYY');
-- 15.	Sa se calculeze valoarea comisionului pentru fiecare angajat si folosind operatorul MINUS sa se elimine angajatii care nu au comision (este null).
-- Selectăm toți angajații și calculăm comisionul (presupunând formula salariu * procent_comision)
SELECT id_angajat, nume, prenume, salariul * comision AS valoare_comision
FROM angajati
MINUS
-- Scădem (eliminăm) angajații care au comisionul NULL
SELECT id_angajat, nume, prenume, salariul * comision AS valoare_comision
FROM angajati
WHERE comision IS NULL;
