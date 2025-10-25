ALTER TABLE CURSANTI ADD CONSTRAINT unique_email UNIQUE (email)

SELECT * FROM CURSANTI;  -- oracle salveaza numele tabelelor cu litere mari oricare ar fi initializarea
select * from user_constraints 
where table_name = 'CURSANTI'

INSERT INTO cursanti (id_student, nume, email) VALUES (10,'george', NULL)

/*Sa se adauge in tabela salariati toti angajatii din tabela angajati care lucreaza in departamentele 20, 30 si 50.
Si sa se finalizeze tranzactia (salvarea modificarii).*/

ALTER TABLE salariati ADD CONSTRAINT PRIMARY_KEY_SALARIATI PRIMARY KEY (id_angajat);
INSERT INTO salariati select * from angajati
where id_departament IN (20,30,50);
/*where id_departament = 30 OR id_departament = 30, OR id_departament = 50*/
/*sau*/

delete from salariati 

insert into salariati (id_angajat, nume, data_angajare, email) values ('&ID_ANGAJAT', '&nume', TO_DATE('&DATA_ANGAJARE', 'mon dd,yyyy'),'&email')
select * from salariati where id_angajat = 500;
select * from salariati where salariul < 3000;

--update
update salariati set salariul = salariul +100 where salariul < 3000;
--sa se selecteze toti angajatii din salariati angajati inainte de 01.10.2025

select * from salariati where data_angajare < TO_DATE('01.10.2025', 'mm.dd.yyyy');

UPDATE salariati set salariul =(select salariul from angajati where id_angajat = 125)  where id_manager = 122
