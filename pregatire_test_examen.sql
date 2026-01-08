--Pregatire lucrare/examen
--Curs Oracle

--Conversii de date
--Conversie de data -> caracter
describe angajati_dealer;
describe angajati;
select to_char(data_angajare, 'Month ddth - YYYY') from angajati_dealer;
select to_char(data_angajare, 'ddth Mon, YYYY') as Format_data_angajare from angajati;

--Conversie de la numar la caracter
describe salariati;
select to_char(salariul, '$9999.99') as Salariu from salariati;
select to_char(85000, '999,999.99') from dual;

--Conversie de la caracter la numar

select * from salariati;
select to_number('42,320', '99,999')as Numar from dual;
select nume ||''|| prenume as Nume_angajat, nvl2(telefon, 1, 0) as Numar_de_telefon from salariati;
select nume ||''|| prenume as Nume_angajat, nvl(telefon, 'unknown') as Numar_de_telefon from salariati;


--Conversie de la caracter la data

select to_date('October 28, 2005', 'Month, dd, YYYY') as Birthday from dual;
--to_date cu ajutorul corectorului fx:
select to_date('28October2005', 'fxddMonthYYYY') as Birthday from dual;


--Case/Decode

describe angajati;
select * from angajati;
select nume || ' ' || prenume as Nume_angajat,
case id_departament
    when 100 then 'FI_ACCOUNT'
    when 101 then 'PR_REP'
    when 50 then 'ST_CLERK'
    else 'OTHER DEPT.'
    end as Departament
from angajati;


select to_date('01-Jun-2004') - to_date('01-Oct-2004') from dual;

select next_day(hire_date) + 5 from dual;
select sysdate - 6 as DIferenta_de_data from dual;
select sysdate+30/24 from dual;

select prenume, 
decode(id_manager, 100, 'King', 'A N Other') "Works for?"
from angajati;

select 121/null from dual;

select avg(salariul), max(salariul), min(salariul), sum(salariul) from angajati;
select * from salariati;
select id_departament, id_manager, id_functie, sum(salariul)
from salariati
group by rollup(id_departament, id_manager);

select id_functie, count(*)
from angajati
group by id_functie;

--Join-uri -> Oracle 

select nume, prenume, id_functie, id_departament, id_manager from angajati natural join salariati where id_departament>80;
select * from departamente;
select nume, prenume, id_departament, denumire_departament
from angajati join DEPARTAMENTE using (id_departament) where id_departament<100;

select rpad('SQL', 8, '*') from dual;
--rpad
select lpad('sql', 8, '-') from dual;
--lpad

select add_years('11-Jan-1994', 6) from dual;

select max(salariul), min(salariul), avg(salariul) from salariati;

select * from angajati;
--dml statements -> comenzi de manipulare a datelor
update angajati set nume = 'Vasile' where id_angajat = 198;

delete from angajati where id_angajat = 182;
rollback;
select * from angajati;

delete  from angajati_dealer;

grant select on masini_1400 to rudi;

alter table profesori set unused (specializare);

create table date(date_id number(9));

create index angajati_nume_index on angajati (nume, prenume);

create index angajati_nume_index on angajati_dealer(nume_angajat, prenume_angajat);
select * from user_indexes;
alter sequence po_sequence increment by 2;
describe angajati_dealer;

--rezolvare modele de test
--Model 3
--1.
select * from produse;
select * from comenzi;
select * from comenzi where id_comanda = 2357;
select * from angajati;
select * from departamente;

--includ si produsele care nu au fost comandate niciodata -> left join intre produse si comenzi
--pentru numar de comenzi -> de cate ori apare id-ul comenzii?
--pentru cantitate totala -> numar de comenzi ori stare_comanda?
--pentru produsele necomandate -> nvl(numar_comenzi, 0) -> nvl(cantitate_totala, "Nicio vanzare")?
select a.denumire_produs, a.categorie, nvl(c.stare_comanda, 0) as Numar_comenzi
from produse a left join comenzi c 
on a.id_produs = c.id_comanda;

select a.denumire_produs, a.categorie,a.id_produs, c.stare_comanda, c.id_comanda
from produse a join comenzi c 
on a.id_produs = c.id_comanda;


--2.
select * from clienti;
select limita_credit, trunc(months_between(sysdate, data_nastere)/12) as Varsta from clienti;
--Rezolvare:
select limita_credit as Limita_veche, trunc(months_between(sysdate, data_nastere)/12) as Varsta,
    case 
    when trunc(months_between(sysdate, data_nastere)/12) > 50 then 5000
    when trunc(months_between(sysdate, data_nastere)/12) >35 and trunc(months_between(sysdate, data_nastere)/12) <=50 then 4000
    when trunc(months_between(sysdate, data_nastere)/12) >25 and trunc(months_between(sysdate, data_nastere)/12) <=35 then 3000
    when trunc(months_between(sysdate, data_nastere)/12) <=25 then 2000
    end as Limita_noua

from clienti;


--Rezolvare nr1
--1.
select d.denumire_departament, count(a.id_departament) as Numar_angajati , 
NVL(TO_CHAR(AVG(a.salariul), '99999.99'), 'Fara angajati') AS Medie_salariu from angajati a 
right join departamente d on a.id_departament = d.id_departament 
group by d.denumire_departament;

select count(a.id_angajat) as Numar_angajati, c.id_departament 
from angajati a join 
departamente c on a.id_departament = c.id_departament
group by  c.id_departament;
--toate coloanele care nu sunt incluse in functia de grup -> se introduce in group by

--2.
select * from salariati;
select salariul as Salariu_vechi, trunc(months_between(sysdate, data_angajare)/12) as Vechime,
case 
    when trunc(months_between(sysdate, data_angajare)/12) >10 then salariul*1.15
    when trunc(months_between(sysdate, data_angajare)/12) >5 then salariul*1.1
    else salariul*1.05
    end as Salariu_nou
from salariati;

--nr2
--1.
select * from clienti;
select * from comenzi;
select * from rand_comenzi;
-- select a.nume_client||' '||a.prenume_client as Nume_complet_client,
-- count(c.id_comanda), nvl(c.valoare_totala, 0)  = (
--     select sum(pret) from rand_comenzi join comenzi on(id_comanda)
-- ) 
-- from clienti a left join comenzi c on (
--     a.id_comanda = c.id_comanda
-- ) group by a.nume_client, a.prenume_client;



SELECT 
    a.nume_client || ' ' || a.prenume_client AS Nume_complet_client,
    COUNT(DISTINCT c.id_comanda) AS Nr_Comenzi,
    NVL(to_char(SUM(rc.pret),'999,999.99'), 'Nicio_comanda') AS Valoare_Totala_Cumulata
FROM clienti a 
LEFT JOIN comenzi c ON a.id_client = c.id_client
LEFT JOIN rand_comenzi rc ON c.id_comanda = rc.id_comanda
GROUP BY a.nume_client, a.prenume_client;

--2.
select * from salariati;
select nume||' '||prenume as Nume_angajat, id_angajat, salariul as Salariu_vechi,
case
when salariul < 5000 then salariul*1.2
when salariul < 10000 then salariul*1.12
when salariul > 10000 then salariul*1.07
end as Salariu_nou
from salariati; 

--tema: sa se selecteze toti subordonatii 
--angajatilor cu functia clerk

--subordonatii angajatilor -> ma duc de la cel mai sus manager, care tot angajat e
--apoi aflu subordonatii fiecaruia, verific sa aiba functia clerk

select * from angajati;
select nume||' '||prenume as Nume_angajat, id_angajat, level as Nivel_ierarhic
from angajati
-- sys_connect_by_path(nume||' '||prenume, '/') as Nume_superiori
connect by prior id_angajat = id_manager
start with upper(id_angajat) like '%CLERK%';

SELECT 
    LEVEL AS Grad_Subordonare,
    LPAD(' ', 2 * (LEVEL - 1)) || nume || ' ' || prenume AS Nume_Complet,
    id_angajat AS Functie,
    SYS_CONNECT_BY_PATH(nume, ' -> ') AS Drum_Ierarhic
FROM angajati
-- Pasul 1: Plecăm de la cei care au funcția de CLERK
START WITH UPPER(id_angajat) LIKE '%CLERK%'
-- Pasul 2: Mergem în jos către subordonați
CONNECT BY PRIOR id_angajat = id_manager;




--union/intersect/minus

--1) sa se afiseze angajatii care au salariul intre 4999 si 6500 fara cei 
--care au salariul intre 5000 si 6000

select * from angajati where salariul between 4999 and 6500
minus 
select * from angajati where salariul between 5000 and 6000;


-- 2) Sa se calculeze diferit discountul (DC) pentru clienti astfel:
-- •	daca clientul a incheiat 1 comanda atunci DC= 10% ;
-- •	daca a incheiat 2 comenzi atunci DC =15%; 
-- •	daca a incheiat mai mult de 3 comenzi atunci DC =20%.
-- Din acestea sa se elimine inregistrarile incheiate de clientii care incep cu litera M. Ordonati descrescator in functie de numele clientilor. 

select * from comenzi;
select * from clienti;
select cl.nume_client, count(co.id_comanda) as numar_comenzi,
(
    case
    when count(co.nr_comanda) = 1 then 0.1
    when count(co.nr_comanda) = 2 then 0.15
    when count(co.nr_comanda) = 3 then 0.2
    else 0
    end
) discount
from clienti cl, comenzi co
where cl.id_client = co.id_client 
group by cl.nume_client
minus
select cl.nume_client, count(co.id_comanda) as numar_comenzi,
(
    case 
    when count(co.nr_comanda) = 1 then 0.1
    when count(co.nr_comanda) = 2 then 0.15
    when count(co.nr_comanda) = 3 then 0.2
    else 0
    end
) discount
from clienti cl, comenzi co
where cl.id_client = co.id_client 
and cl.nume_client like 'M%'
group by cl.nume_client
order by nume_client;


-- Sa se calculeze discountul pentru produse  astfel:
-- •	daca regiunea este Europe atunci CT= 10% din valoarea totala a comenzilor
-- •	daca zona firmei este America atunci CT=15% din valoarea totala a comenzilor
-- •	daca zona firmei este Asia atunci CT=12% din valoarea totala a comenzilor
-- •	daca zona firmei este Orientul mijlociu si Africa atunci CT=18% din valoarea totala a comenzilor

select * from locatii;
select * from regiuni;
select * from tari;
select * from comenzi;
select * from rand_comenzi;
--regiuni->tari->
select r.denumire_regiune, t.denumire_tara, count(co.stare_comanda),
(
    case
    when r.denumire_regiune = 'Europe' then 0.1*count(co.stare_comanda)
    when r.denumire_regiune = 'Americas' then 0.15*count(co.stare_comanda)
    when r.denumire_regiune = 'Asia' then 0.12*count(co.stare_comanda)
    when r.denumire_regiune = 'Middle East and Africa' then 0.18*count(co.stare_comanda)
    else 0
    end
) discount 
from regiuni r
join tara t on r.id_regiune = t.id_regiune 
join locatii l on t.id_tara = l.id_tara
join departamente d on l.id_locatie = d.id_locatie
join angajati a on d.id_departament = a.id_departament
join comenzi co on co.id_angajat = a.id_angajat 
group by r.denumire_regiune, t.denumire_tara;


SELECT 
    r.denumire_regiune, 
    t.denumire_tara, 
    COUNT(DISTINCT co.id_comanda) AS Nr_Comenzi,
    CASE 
        WHEN r.denumire_regiune = 'Europe' THEN 0.10 * COUNT(DISTINCT co.id_comanda)
        WHEN r.denumire_regiune = 'Americas' THEN 0.15 * COUNT(DISTINCT co.id_comanda)
        WHEN r.denumire_regiune = 'Asia' THEN 0.12 * COUNT(DISTINCT co.id_comanda)
        WHEN r.denumire_regiune = 'Middle East and Africa' THEN 0.18 * COUNT(DISTINCT co.id_comanda)
        ELSE 0
    END AS Discount_Regiune
FROM regiuni r
JOIN tari t ON r.id_regiune = t.id_regiune 
JOIN locatii l ON t.id_tara = l.id_tara
JOIN departamente d ON l.id_locatie = d.id_locatie
JOIN angajati a ON d.id_departament = a.id_departament 
JOIN comenzi co ON a.id_angajat = co.id_angajat 
GROUP BY r.denumire_regiune, t.denumire_tara;

