DROP TABLE TRANSPORTURI_ISTORIC CASCADE CONSTRAINTS;
DROP TABLE DETALII_TRANSPORT CASCADE CONSTRAINTS;
DROP TABLE TRANSPORTURI CASCADE CONSTRAINTS;
DROP TABLE LIVRARI CASCADE CONSTRAINTS;
DROP TABLE PRODUSE CASCADE CONSTRAINTS;
DROP TABLE CATEGORII CASCADE CONSTRAINTS;
DROP TABLE COMERCIANTI CASCADE CONSTRAINTS;
DROP TABLE DISTRIBUITORI CASCADE CONSTRAINTS;
DROP TABLE PRODUCATORI CASCADE CONSTRAINTS;


CREATE TABLE CATEGORII (
    ID_CATEGORIE NUMBER(6) CONSTRAINT PK_CATEGORII PRIMARY KEY,
    NUME_CATEGORIE VARCHAR2(50) NOT NULL
);


CREATE TABLE PRODUCATORI (
    ID_PRODUCATOR NUMBER(6) CONSTRAINT PK_PRODUCATORI PRIMARY KEY,
    NUME          VARCHAR2(100) NOT NULL,
    LOCALITATE    VARCHAR2(100) DEFAULT 'Matca',
    TIP_SERA      VARCHAR2(50) CONSTRAINT CK_TIP_SERA CHECK (TIP_SERA IN ('Incalzita', 'Solariu', 'Camp')),
    CONTACT       VARCHAR2(100)
);


CREATE TABLE PRODUSE (
    ID_PRODUS       NUMBER(6) CONSTRAINT PK_PRODUSE PRIMARY KEY,
    DENUMIRE_PRODUS VARCHAR2(100) NOT NULL,
    ID_CATEGORIE    NUMBER(6) CONSTRAINT FK_PROD_CAT REFERENCES CATEGORII(ID_CATEGORIE),
    PRET_LISTA      NUMBER(8,2) CONSTRAINT CK_PRET_POZ CHECK (PRET_LISTA > 0),
    DESCRIERE       VARCHAR2(2000)
);


CREATE TABLE DISTRIBUITORI (
    ID_DISTRIBUITOR NUMBER(6) CONSTRAINT PK_DISTRIBUITORI PRIMARY KEY,
    NUME            VARCHAR2(100) NOT NULL,
    REGIUNE         VARCHAR2(50),
    ID_MANAGER      NUMBER(6), 
    CONTACT         VARCHAR2(100)
);


CREATE TABLE COMERCIANTI (
    ID_COMERCIANT NUMBER(6) CONSTRAINT PK_COMERCIANTI PRIMARY KEY,
    NUME          VARCHAR2(100) NOT NULL,
    LOCALITATE    VARCHAR2(100),
    TIP_MAGAZIN   VARCHAR2(50)
);


CREATE TABLE LIVRARI (
    ID_LIVRARE      NUMBER(6) CONSTRAINT PK_LIVRARI PRIMARY KEY,
    ID_PRODUCATOR   NUMBER(6) CONSTRAINT FK_LIV_PROD REFERENCES PRODUCATORI(ID_PRODUCATOR),
    ID_PRODUS       NUMBER(6) CONSTRAINT FK_LIV_ITEM REFERENCES PRODUSE(ID_PRODUS),
    DATA_LIVRARE    DATE DEFAULT SYSDATE,
    CANTITATE_KG    NUMBER(10,2) NOT NULL,
    PRET_NEGOCIAT   NUMBER(8,2)
);


CREATE TABLE TRANSPORTURI (
    ID_TRANSPORT    NUMBER(6) CONSTRAINT PK_TRANSPORT PRIMARY KEY,
    ID_DISTRIBUITOR NUMBER(6) CONSTRAINT FK_TRANS_DISTR REFERENCES DISTRIBUITORI(ID_DISTRIBUITOR),
    DATA_PLECARE    DATE,
    COST_CURSA      NUMBER(8,2),
    STATUS          VARCHAR2(20) CONSTRAINT CK_ST_TRANS CHECK (STATUS IN ('Incarcare', 'Pe drum', 'Livrat'))
);


CREATE TABLE DETALII_TRANSPORT (
    ID_DETALIU    NUMBER(6) CONSTRAINT PK_DETALII PRIMARY KEY,
    ID_TRANSPORT  NUMBER(6) CONSTRAINT FK_DET_TR REFERENCES TRANSPORTURI(ID_TRANSPORT),
    ID_PRODUS     NUMBER(6) CONSTRAINT FK_DET_PR REFERENCES PRODUSE(ID_PRODUS),
    ID_COMERCIANT NUMBER(6) CONSTRAINT FK_DET_COM REFERENCES COMERCIANTI(ID_COMERCIANT),
    CANTITATE_LIV NUMBER(10,2)
);


CREATE TABLE TRANSPORTURI_ISTORIC AS 
SELECT * FROM TRANSPORTURI WHERE 1=0;

ALTER TABLE PRODUCATORI ADD (CAPACITATE_STOCARE_KG NUMBER(10));


ALTER TABLE DISTRIBUITORI MODIFY (CONTACT VARCHAR2(150) NOT NULL);


INSERT INTO CATEGORII VALUES (1, 'Legume Verzi');
INSERT INTO CATEGORII VALUES (2, 'Radacinoase');
INSERT INTO CATEGORII VALUES (3, 'Solanacee'); 
INSERT INTO CATEGORII VALUES (4, 'Cucurbitacee'); 
INSERT INTO CATEGORII VALUES (5, 'Verdeturi');
INSERT INTO CATEGORII VALUES (6, 'Leguminoase');
INSERT INTO CATEGORII VALUES (7, 'Fructe de livada');
INSERT INTO CATEGORII VALUES (8, 'Seminte');
INSERT INTO CATEGORII VALUES (9, 'Ingrasaminte Bio');
INSERT INTO CATEGORII VALUES (10, 'Ambalaje si Navete');


INSERT INTO PRODUCATORI VALUES (1, 'PRICOPE ALIN', 'Matca', 'Incalzita', 'alin.pricope@stud.ase.ro', 5000);
INSERT INTO PRODUCATORI VALUES (2, 'Ionescu Marin', 'Matca', 'Solariu', 'ionescu@ferma.ro', 3000);
INSERT INTO PRODUCATORI VALUES (3, 'Popescu Vasile', 'Matca', 'Camp', 'popescu@agro.ro', 10000);
INSERT INTO PRODUCATORI VALUES (4, 'Ferma Verda SRL', 'Tecuci', 'Incalzita', 'office@verda.ro', 15000);
INSERT INTO PRODUCATORI VALUES (5, 'BioPlante Matca', 'Matca', 'Solariu', 'contact@bioplante.ro', 4000);
INSERT INTO PRODUCATORI VALUES (6, 'Grădina Bunicii', 'Corod', 'Camp', 'bunica@traditii.ro', 2000);
INSERT INTO PRODUCATORI VALUES (7, 'Legume de Aur', 'Cudalbi', 'Solariu', 'aur@legume.ro', 6000);
INSERT INTO PRODUCATORI VALUES (8, 'HortiGal', 'Galati', 'Incalzita', 'info@hortigal.ro', 25000);
INSERT INTO PRODUCATORI VALUES (9, 'Sera Noastra', 'Matca', 'Incalzita', 'sera@matca.ro', 8000);
INSERT INTO PRODUCATORI VALUES (10, 'EcoFerm', 'Munteni', 'Camp', 'eco@ferm.ro', 12000);

-- 3. PRODUSE (Minim 10)
INSERT INTO PRODUSE VALUES (101, 'Rosii Prekos', 3, 12.50, 'Soi timpuriu rezistent');
INSERT INTO PRODUSE VALUES (102, 'Castraveti Cornichon', 4, 8.50, 'Pentru muraturi');
INSERT INTO PRODUSE VALUES (103, 'Ardei Capia', 3, 10.00, 'Ardei rosu de dimensiuni mari');
INSERT INTO PRODUSE VALUES (104, 'Vinete Aragon', 3, 7.50, 'Vinete fara seminte multe');
INSERT INTO PRODUSE VALUES (105, 'Varza Timpurie', 1, 3.00, 'Varza alba dulce');
INSERT INTO PRODUSE VALUES (106, 'Morcovi Matca', 2, 4.00, 'Morcovi dulci portocalii');
INSERT INTO PRODUSE VALUES (107, 'Ceapa Rosie', 2, 5.50, 'Ceapa de apa');
INSERT INTO PRODUSE VALUES (108, 'Patrunjel Legatura', 5, 1.50, 'Patrunjel proaspat cret');
INSERT INTO PRODUSE VALUES (109, 'Mere Idared', 7, 4.50, 'Mere rosii de iarna');
INSERT INTO PRODUSE VALUES (110, 'Ardei Iute', 3, 15.00, 'Soi foarte iute');

-- 4. DISTRIBUITORI (Minim 10)
-- ID_MANAGER este folosit pentru cererile ierarhice de la punctul 5
INSERT INTO DISTRIBUITORI VALUES (201, 'AgroTrans Central', 'Galați', 210, 'office@agrotrans.ro');
INSERT INTO DISTRIBUITORI VALUES (202, 'FrigoExpres', 'București', 201, 'contact@frigo.ro');
INSERT INTO DISTRIBUITORI VALUES (203, 'EcoLogistica', 'Brașov', 201, 'eco@logistica.ro');
INSERT INTO DISTRIBUITORI VALUES (204, 'Transport Matca', 'Galați', 201, 'transport@matca.ro');
INSERT INTO DISTRIBUITORI VALUES (205, 'MegaDist', 'Cluj', 210, 'mega@dist.ro');
INSERT INTO DISTRIBUITORI VALUES (206, 'Rapid Agro', 'Iași', 205, 'rapid@agro.ro');
INSERT INTO DISTRIBUITORI VALUES (207, 'BioCurier', 'Constanța', 205, 'bio@curier.ro');
INSERT INTO DISTRIBUITORI VALUES (208, 'Producatori Unite', 'Galați', 201, 'unite@matca.ro');
INSERT INTO DISTRIBUITORI VALUES (209, 'FreshWay', 'Timișoara', 210, 'fresh@way.ro');
INSERT INTO DISTRIBUITORI VALUES (210, 'Director General Logistica', 'București', NULL, 'boss@logistica.ro');

-- 5. COMERCIANTI (Minim 10)
INSERT INTO COMERCIANTI VALUES (301, 'Lidl România', 'București', 'Supermarket');
INSERT INTO COMERCIANTI VALUES (302, 'Kaufland', 'Galați', 'Hypermarket');
INSERT INTO COMERCIANTI VALUES (303, 'Aprozarul din Colt', 'Matca', 'Magazin Mic');
INSERT INTO COMERCIANTI VALUES (304, 'Mega Image', 'București', 'Supermarket');
INSERT INTO COMERCIANTI VALUES (305, 'Carrefour', 'Iași', 'Hypermarket');
INSERT INTO COMERCIANTI VALUES (306, 'Piața Centrală', 'Galați', 'Piață Agroalimentară');
INSERT INTO COMERCIANTI VALUES (307, 'Profi City', 'București', 'Supermarket');
INSERT INTO COMERCIANTI VALUES (308, 'Penny Market', 'Tecuci', 'Discouter');
INSERT INTO COMERCIANTI VALUES (309, 'Auchan', 'Cluj', 'Hypermarket');
INSERT INTO COMERCIANTI VALUES (310, 'Horeca Food', 'Brașov', 'Distribuitor Restaurante');

-- 6. LIVRARI (Minim 10)
INSERT INTO LIVRARI VALUES (501, 1, 101, SYSDATE, 1500, 11.00);
INSERT INTO LIVRARI VALUES (502, 2, 102, SYSDATE-1, 800, 7.50);
INSERT INTO LIVRARI VALUES (503, 1, 103, SYSDATE-2, 500, 9.00);
INSERT INTO LIVRARI VALUES (504, 3, 105, SYSDATE, 2000, 2.50);
INSERT INTO LIVRARI VALUES (505, 5, 101, SYSDATE-3, 1200, 10.50);
INSERT INTO LIVRARI VALUES (506, 9, 104, SYSDATE, 600, 6.80);
INSERT INTO LIVRARI VALUES (507, 1, 102, SYSDATE-5, 300, 8.00);
INSERT INTO LIVRARI VALUES (508, 4, 110, SYSDATE-1, 50, 14.00);
INSERT INTO LIVRARI VALUES (509, 8, 106, SYSDATE, 900, 3.80);
INSERT INTO LIVRARI VALUES (510, 10, 107, SYSDATE-4, 1100, 5.00);

-- 7. TRANSPORTURI (Minim 10)
INSERT INTO TRANSPORTURI VALUES (701, 201, SYSDATE, 120.00, 'Pe drum');
INSERT INTO TRANSPORTURI VALUES (702, 202, SYSDATE-1, 450.00, 'Livrat');
INSERT INTO TRANSPORTURI VALUES (703, 201, SYSDATE, 80.00, 'Incarcare');
INSERT INTO TRANSPORTURI VALUES (704, 204, SYSDATE-2, 50.00, 'Livrat');
INSERT INTO TRANSPORTURI VALUES (705, 203, SYSDATE, 300.00, 'Pe drum');
INSERT INTO TRANSPORTURI VALUES (706, 205, SYSDATE-3, 600.00, 'Livrat');
INSERT INTO TRANSPORTURI VALUES (707, 201, SYSDATE-1, 150.00, 'Livrat');
INSERT INTO TRANSPORTURI VALUES (708, 208, SYSDATE, 40.00, 'Incarcare');
INSERT INTO TRANSPORTURI VALUES (709, 209, SYSDATE-4, 850.00, 'Livrat');
INSERT INTO TRANSPORTURI VALUES (710, 206, SYSDATE, 200.00, 'Pe drum');

-- 8. DETALII_TRANSPORT (Minim 10)
INSERT INTO DETALII_TRANSPORT VALUES (1, 701, 101, 301, 500);
INSERT INTO DETALII_TRANSPORT VALUES (2, 701, 102, 301, 300);
INSERT INTO DETALII_TRANSPORT VALUES (3, 702, 103, 304, 200);
INSERT INTO DETALII_TRANSPORT VALUES (4, 704, 105, 303, 1000);
INSERT INTO DETALII_TRANSPORT VALUES (5, 705, 106, 310, 400);
INSERT INTO DETALII_TRANSPORT VALUES (6, 706, 101, 309, 600);
INSERT INTO DETALII_TRANSPORT VALUES (7, 707, 107, 302, 500);
INSERT INTO DETALII_TRANSPORT VALUES (8, 709, 104, 305, 300);
INSERT INTO DETALII_TRANSPORT VALUES (9, 710, 109, 307, 450);
INSERT INTO DETALII_TRANSPORT VALUES (10, 702, 110, 304, 20);


UPDATE PRODUSE 
SET PRET_LISTA = PRET_LISTA * 1.10 
WHERE ID_CATEGORIE = 3;


UPDATE TRANSPORTURI 
SET STATUS = 'Livrat' 
WHERE DATA_PLECARE <= SYSDATE;


UPDATE PRODUCATORI 
SET CAPACITATE_STOCARE_KG = 7000 
WHERE NUME = 'PRICOPE ALIN';

DELETE FROM DETALII_TRANSPORT WHERE ID_PRODUS = 110;
DELETE FROM LIVRARI WHERE ID_PRODUS = 110;
DELETE FROM PRODUSE WHERE ID_PRODUS = 110;


DROP TABLE CATEGORII CASCADE CONSTRAINTS;


FLASHBACK TABLE CATEGORII TO BEFORE DROP;


DROP TABLE CATEGORII CASCADE CONSTRAINTS;

FLASHBACK TABLE CATEGORII TO BEFORE DROP;


SELECT USER AS SCHEMA_STUDENT, ID_PRODUCATOR, NUME, LOCALITATE, TIP_SERA
FROM PRODUCATORI
WHERE NUME = 'PRICOPE ALIN';



SELECT DENUMIRE_PRODUS, PRET_LISTA FROM PRODUSE 
WHERE DENUMIRE_PRODUS LIKE 'Rosii%' AND PRET_LISTA BETWEEN 5 AND 15; 

SELECT ID_LIVRARE, TO_CHAR(DATA_LIVRARE, 'DD-MON-YYYY') AS DATA_LIVRARE 
FROM LIVRARI WHERE TO_CHAR(DATA_LIVRARE, 'MM-YYYY') = TO_CHAR(SYSDATE, 'MM-YYYY'); 

SELECT DENUMIRE_PRODUS, NVL(SUBSTR(DESCRIERE, 1, 15), 'Fara detalii') AS DESC_SCURTA 
FROM PRODUSE;

SELECT NUME, CASE WHEN TIP_SERA = 'Incalzita' THEN 'Productie Iarna' 
WHEN TIP_SERA = 'Solariu' THEN 'Productie Primavara' ELSE 'Productie Vara' END AS SEZONALITATE
FROM PRODUCATORI; 

SELECT ID_TRANSPORT, DECODE(STATUS, 'Livrat', 'Finalizat', 'Pe drum', 'In curs', 'Incarcare', 'Depozit') AS STARE_ACTUALA
FROM TRANSPORTURI; 

SELECT * FROM LIVRARI WHERE EXTRACT(YEAR FROM DATA_LIVRARE) >= 2025; 

SELECT P.NUME, PR.DENUMIRE_PRODUS FROM PRODUCATORI P 
JOIN LIVRARI L ON P.ID_PRODUCATOR = L.ID_PRODUCATOR 
JOIN PRODUSE PR ON L.ID_PRODUS = PR.ID_PRODUS; 


SELECT C.NUME, DT.ID_PRODUS FROM COMERCIANTI C 
LEFT JOIN DETALII_TRANSPORT DT ON C.ID_COMERCIANT = DT.ID_COMERCIANT; 


SELECT ID_PRODUCATOR, SUM(CANTITATE_KG) AS TOTAL_KG FROM LIVRARI 
GROUP BY ID_PRODUCATOR; 

SELECT ID_PRODUCATOR, AVG(CANTITATE_KG) FROM LIVRARI 
GROUP BY ID_PRODUCATOR HAVING AVG(CANTITATE_KG) > 500; 

SELECT LOCALITATE FROM PRODUCATORI UNION SELECT LOCALITATE FROM COMERCIANTI; 

SELECT ID_PRODUCATOR FROM PRODUCATORI MINUS SELECT ID_PRODUCATOR FROM LIVRARI; 

SELECT DENUMIRE_PRODUS FROM PRODUSE WHERE PRET_LISTA > (SELECT AVG(PRET_LISTA) FROM PRODUSE); 

SELECT NUME FROM PRODUCATORI P WHERE EXISTS (SELECT 1 FROM LIVRARI L WHERE L.ID_PRODUCATOR = P.ID_PRODUCATOR AND L.CANTITATE_KG > 1000); 

SELECT LEVEL, NUME, SYS_CONNECT_BY_PATH(NUME, '/') AS CALE FROM DISTRIBUITORI 
START WITH ID_MANAGER IS NULL CONNECT BY PRIOR ID_DISTRIBUITOR = ID_MANAGER;


INSERT INTO TRANSPORTURI_ISTORIC 
SELECT * FROM TRANSPORTURI WHERE STATUS = 'Livrat';


COMMIT;

UPDATE PRODUSE SET PRET_LISTA = PRET_LISTA + 1 WHERE PRET_LISTA = (SELECT MIN(PRET_LISTA) FROM PRODUSE); 


CREATE OR REPLACE VIEW V_PRODUSE_ALIN AS 
SELECT * FROM PRODUSE WHERE ID_PRODUS IN (SELECT ID_PRODUS FROM LIVRARI WHERE ID_PRODUCATOR = 1); 

CREATE INDEX IDX_NUME_PRODUS ON PRODUSE(DENUMIRE_PRODUS); 


DROP SEQUENCE SEQ_PRODUSE_NOI;
CREATE SEQUENCE SEQ_PRODUSE_NOI START WITH 200 INCREMENT BY 1; 


DROP SYNONYM DT;
CREATE SYNONYM DT FOR DETALII_TRANSPORT; 


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- =============================================================================
-- PROIECT SEMESTRUL 2 - PL/SQL
-- Student: PRICOPE ALIN
-- Domeniu: Gestiunea distributiei produselor agricole (Matca - Galati)
-- =============================================================================

-----------------------------------------------------
-- D1. Afisati numele, tipul serei si clasificarea fiecarui producator
--     in functie de capacitatea de stocare astfel:
--     sub 3000 kg => 'Producator Mic'
--     intre 3000 si 9999 kg => 'Producator Mediu'
--     10000 kg sau mai mult => 'Producator Mare'
--     NULL => 'Necunoscut'
--     Folositi structura IF-ELSIF-ELSE.
-- -------------------------------------------------------
DECLARE
    v_clasificare VARCHAR2(30);
BEGIN
    FOR rec IN (SELECT NUME, TIP_SERA, CAPACITATE_STOCARE_KG FROM PRODUCATORI ORDER BY ID_PRODUCATOR) LOOP
        IF rec.CAPACITATE_STOCARE_KG IS NULL THEN
            v_clasificare := 'Necunoscut';
        ELSIF rec.CAPACITATE_STOCARE_KG < 3000 THEN
            v_clasificare := 'Producator Mic';
        ELSIF rec.CAPACITATE_STOCARE_KG < 10000 THEN
            v_clasificare := 'Producator Mediu';
        ELSE
            v_clasificare := 'Producator Mare';
        END IF;

        DBMS_OUTPUT.PUT_LINE(rec.NUME ||
                             ' | Sera: ' || NVL(rec.TIP_SERA, 'N/A') ||
                             ' | Capacitate: ' || NVL(TO_CHAR(rec.CAPACITATE_STOCARE_KG), 'N/A') ||
                             ' kg => ' || v_clasificare);
    END LOOP;
END;
/


-- -------------------------------------------------------
-- D2. Afisati pentru fiecare producator sezonalitatea productiei,
--     determinata pe baza tipului de sera, folosind structura CASE:
--     'Incalzita' => 'Productie tot anul'
--     'Solariu'   => 'Productie primavara - toamna'
--     'Camp'      => 'Productie vara'
--     altceva     => 'Nespecificat'
-- -------------------------------------------------------
DECLARE
    v_sezon VARCHAR2(40);
BEGIN
    FOR rec IN (SELECT NUME, TIP_SERA FROM PRODUCATORI ORDER BY ID_PRODUCATOR) LOOP
        v_sezon := CASE rec.TIP_SERA
                       WHEN 'Incalzita' THEN 'Productie tot anul'
                       WHEN 'Solariu'   THEN 'Productie primavara - toamna'
                       WHEN 'Camp'      THEN 'Productie vara'
                       ELSE                  'Nespecificat'
                   END;
        DBMS_OUTPUT.PUT_LINE(rec.NUME || ' (' || NVL(rec.TIP_SERA,'?') || ') => ' || v_sezon);
    END LOOP;
END;
/


-- -------------------------------------------------------
-- D3. Afisati statusul tradus al fiecarui transport folosind DECODE,
--     apoi afisati un sumar: cate transporturi sunt in fiecare stare.
--     Folositi o bucla FOR si structura IF pentru sumar.
-- -------------------------------------------------------
DECLARE
    v_incarcare NUMBER := 0;
    v_pe_drum   NUMBER := 0;
    v_livrat    NUMBER := 0;
    v_stare     VARCHAR2(30);
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== Lista transporturi ===');
    FOR rec IN (SELECT ID_TRANSPORT, STATUS, COST_CURSA FROM TRANSPORTURI ORDER BY ID_TRANSPORT) LOOP
        v_stare := DECODE(rec.STATUS,
                          'Incarcare', 'In depozit',
                          'Pe drum',   'In tranzit',
                          'Livrat',    'Finalizat',
                                       'Necunoscut');

        IF rec.STATUS = 'Incarcare' THEN v_incarcare := v_incarcare + 1;
        ELSIF rec.STATUS = 'Pe drum' THEN v_pe_drum := v_pe_drum + 1;
        ELSIF rec.STATUS = 'Livrat'  THEN v_livrat  := v_livrat  + 1;
        END IF;

        DBMS_OUTPUT.PUT_LINE('Transport #' || rec.ID_TRANSPORT ||
                             ' | Cost: ' || NVL(TO_CHAR(rec.COST_CURSA),'0') ||
                             ' RON | Stare: ' || v_stare);
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('--- Sumar ---');
    DBMS_OUTPUT.PUT_LINE('In depozit : ' || v_incarcare);
    DBMS_OUTPUT.PUT_LINE('In tranzit : ' || v_pe_drum);
    DBMS_OUTPUT.PUT_LINE('Finalizate : ' || v_livrat);
END;
/


-- -------------------------------------------------------
-- D4. Calculati, folosind o bucla WHILE, valoarea cumulata a livrarilor
--     pentru producatorul cu ID 1 (PRICOPE ALIN), livrare cu livrare,
--     si opriti-va cand valoarea cumulata depaseste 10.000 RON
--     sau cand nu mai sunt livrari de procesat.
--     Afisati fiecare pas si concluzia finala.
-- -------------------------------------------------------
DECLARE
    CURSOR c_liv IS
        SELECT L.ID_LIVRARE, P.DENUMIRE_PRODUS,
               L.CANTITATE_KG, NVL(L.PRET_NEGOCIAT, 0) AS PRET,
               L.CANTITATE_KG * NVL(L.PRET_NEGOCIAT, 0) AS VALOARE
        FROM   LIVRARI L
        JOIN   PRODUSE P ON L.ID_PRODUS = P.ID_PRODUS
        WHERE  L.ID_PRODUCATOR = 1
        ORDER BY L.ID_LIVRARE;

    r_liv     c_liv%ROWTYPE;
    v_total   NUMBER := 0;
    v_prag    NUMBER := 10000;
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== Livrari cumulate PRICOPE ALIN (prag: ' || v_prag || ' RON) ===');
    OPEN c_liv;
    FETCH c_liv INTO r_liv;

    WHILE c_liv%FOUND AND v_total <= v_prag LOOP
        v_total := v_total + r_liv.VALOARE;
        DBMS_OUTPUT.PUT_LINE('Livrare #' || r_liv.ID_LIVRARE ||
                             ' | ' || r_liv.DENUMIRE_PRODUS ||
                             ' | ' || r_liv.CANTITATE_KG || ' kg x ' ||
                             r_liv.PRET || ' RON = ' || r_liv.VALOARE ||
                             ' RON | Total cumulat: ' || v_total || ' RON');
        FETCH c_liv INTO r_liv;
    END LOOP;
    CLOSE c_liv;

    IF v_total > v_prag THEN
        DBMS_OUTPUT.PUT_LINE('>> Pragul de ' || v_prag || ' RON a fost depasit!');
    ELSE
        DBMS_OUTPUT.PUT_LINE('>> Livrari epuizate. Total final: ' || v_total || ' RON (sub prag).');
    END IF;
END;
/


-- -------------------------------------------------------
-- D5. Afisati un raport de simulare a preturilor: pornind de la pretul
--     minim din tabela PRODUSE, aplicati succesiv o crestere de 5%
--     folosind o bucla LOOP simpla cu EXIT WHEN, pana cand pretul
--     simulat depaseste pretul maxim existent in tabela.
--     Afisati fiecare iteratie.
-- -------------------------------------------------------
DECLARE
    v_pret_min  NUMBER;
    v_pret_max  NUMBER;
    v_pret_curent NUMBER;
    v_iteratie  NUMBER := 0;
BEGIN
    SELECT MIN(PRET_LISTA), MAX(PRET_LISTA)
    INTO   v_pret_min, v_pret_max
    FROM   PRODUSE;

    v_pret_curent := v_pret_min;
    DBMS_OUTPUT.PUT_LINE('=== Simulare crestere pret (start: ' || v_pret_min ||
                         ' RON, tinta: ' || v_pret_max || ' RON) ===');
    LOOP
        v_iteratie    := v_iteratie + 1;
        v_pret_curent := ROUND(v_pret_curent * 1.05, 2);
        DBMS_OUTPUT.PUT_LINE('Iteratia ' || v_iteratie || ': Pret simulat = ' || v_pret_curent || ' RON');
        EXIT WHEN v_pret_curent >= v_pret_max;
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('>> Pretul maxim de ' || v_pret_max ||
                         ' RON a fost atins/depasit dupa ' || v_iteratie || ' iteratii.');
END;
/


-- =============================================================================
-- E. TRATAREA EXCEPTIILOR
-- =============================================================================

-- -------------------------------------------------------
-- E1. (Exceptie IMPLICITA - NO_DATA_FOUND)
--     Afisati denumirea si pretul unui produs dat dupa ID.
--     Tratati cazul in care produsul nu exista in baza de date.
-- -------------------------------------------------------
DECLARE
    v_id_produs    NUMBER := 9999; -- ID inexistent intentionat
    v_denumire     PRODUSE.DENUMIRE_PRODUS%TYPE;
    v_pret         PRODUSE.PRET_LISTA%TYPE;
BEGIN
    SELECT DENUMIRE_PRODUS, PRET_LISTA
    INTO   v_denumire, v_pret
    FROM   PRODUSE
    WHERE  ID_PRODUS = v_id_produs;

    DBMS_OUTPUT.PUT_LINE('Produs: ' || v_denumire || ' | Pret: ' || v_pret || ' RON/kg');

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('[Exceptie implicita] Produsul cu ID ' || v_id_produs ||
                             ' nu exista in baza de date.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('[Eroare neasteptata] ' || SQLERRM);
END;
/


-- -------------------------------------------------------
-- E2. (Exceptie IMPLICITA - TOO_MANY_ROWS)
--     Cititi intr-o singura variabila ID-ul producatorului
--     dintr-o livrare fara a adauga filtru. Tratati cazul
--     in care exista mai multe livrari (deci mai multi producatori).
-- -------------------------------------------------------
DECLARE
    v_id_producator LIVRARI.ID_PRODUCATOR%TYPE;
BEGIN
    -- Fara WHERE => mai multe randuri => TOO_MANY_ROWS
    SELECT ID_PRODUCATOR
    INTO   v_id_producator
    FROM   LIVRARI;

    DBMS_OUTPUT.PUT_LINE('ID Producator: ' || v_id_producator);

EXCEPTION
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('[Exceptie implicita] Interogarea a returnat mai multe randuri. ' ||
                             'Adaugati un filtru WHERE sau folositi un cursor.');
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('[Exceptie implicita] Nu exista nicio livrare inregistrata.');
END;
/


-- -------------------------------------------------------
-- E3. (Exceptie EXPLICITA)
--     La adaugarea unei livrari, verificati ca pretul negociat
--     sa nu depaseasca pretul de lista al produsului.
--     Daca este depasit, declansati o exceptie explicita si afisati
--     un mesaj detaliat.
-- -------------------------------------------------------
DECLARE
    ex_pret_invalid EXCEPTION;

    v_id_produs      NUMBER := 101;   -- Rosii Prekos
    v_pret_negociat  NUMBER := 50.00; -- intentionat prea mare
    v_pret_lista     PRODUSE.PRET_LISTA%TYPE;
    v_denumire       PRODUSE.DENUMIRE_PRODUS%TYPE;
BEGIN
    SELECT PRET_LISTA, DENUMIRE_PRODUS
    INTO   v_pret_lista, v_denumire
    FROM   PRODUSE
    WHERE  ID_PRODUS = v_id_produs;

    IF v_pret_negociat > v_pret_lista THEN
        RAISE ex_pret_invalid;
    END IF;

    DBMS_OUTPUT.PUT_LINE('Livrare acceptata. Pret negociat: ' || v_pret_negociat || ' RON/kg');

EXCEPTION
    WHEN ex_pret_invalid THEN
        DBMS_OUTPUT.PUT_LINE('[Exceptie explicita] Pretul negociat (' || v_pret_negociat ||
                             ' RON) depaseste pretul de lista (' || v_pret_lista ||
                             ' RON) pentru produsul "' || v_denumire || '"!' ||
                             ' Negocierea nu poate fi inregistrata.');
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('[Exceptie implicita] Produsul cu ID ' || v_id_produs || ' nu exista.');
END;
/


-- -------------------------------------------------------
-- E4. (Exceptie EXPLICITA cu RAISE_APPLICATION_ERROR)
--     La inregistrarea unui transport, verificati ca distribuitorul
--     specificat sa existe in baza de date si ca statusul furnizat
--     sa fie unul valid ('Incarcare', 'Pe drum', 'Livrat').
--     Tratati fiecare caz cu erori aplicative distincte.
-- -------------------------------------------------------
DECLARE
    v_id_distribuitor NUMBER  := 999;        -- ID inexistent intentionat
    v_status          VARCHAR2(20) := 'Zbor'; -- status invalid intentionat
    v_cnt             NUMBER;
BEGIN
    -- Verificare distribuitor
    SELECT COUNT(*) INTO v_cnt
    FROM   DISTRIBUITORI
    WHERE  ID_DISTRIBUITOR = v_id_distribuitor;

    IF v_cnt = 0 THEN
        RAISE_APPLICATION_ERROR(-20030,
            'Distribuitorul cu ID ' || v_id_distribuitor ||
            ' nu exista in baza de date. Inregistrarea transportului este imposibila.');
    END IF;

    -- Verificare status valid
    IF v_status NOT IN ('Incarcare', 'Pe drum', 'Livrat') THEN
        RAISE_APPLICATION_ERROR(-20031,
            'Statusul "' || v_status || '" este invalid. ' ||
            'Valori acceptate: Incarcare, Pe drum, Livrat.');
    END IF;

    DBMS_OUTPUT.PUT_LINE('Transport valid. Distribuitor ID: ' || v_id_distribuitor ||
                         ', Status: ' || v_status);

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('[Exceptie explicita] Eroare ' || SQLCODE || ': ' || SQLERRM);
END;
/


-- =============================================================================
-- F. CURSORI
-- =============================================================================

-- -------------------------------------------------------
-- F1. (Cursor IMPLICIT - SQL%ROWCOUNT in UPDATE)
--     Majorati cu 10% pretul tuturor produselor din categoria
--     'Solanacee' (ID 3). Afisati cate produse au fost actualizate
--     folosind atributul SQL%ROWCOUNT al cursorului implicit.
-- -------------------------------------------------------
BEGIN
    UPDATE PRODUSE
    SET    PRET_LISTA = ROUND(PRET_LISTA * 1.10, 2)
    WHERE  ID_CATEGORIE = 3;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('[Cursor implicit] Nu exista produse in categoria Solanacee.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('[Cursor implicit] Au fost actualizate ' || SQL%ROWCOUNT ||
                             ' produse din categoria Solanacee (+10%).');
    END IF;

    ROLLBACK; -- anulam modificarea pentru a pastra datele originale
END;
/


-- -------------------------------------------------------
-- F2. (Cursor IMPLICIT - SQL%NOTFOUND in DELETE)
--     Stergeti detaliile de transport pentru un transport cu un ID
--     specificat. Folositi SQL%NOTFOUND pentru a detecta daca
--     nu a existat nicio inregistrare de sters.
-- -------------------------------------------------------
DECLARE
    v_id_transport NUMBER := 99999; -- ID inexistent intentionat
BEGIN
    DELETE FROM DETALII_TRANSPORT WHERE ID_TRANSPORT = v_id_transport;

    IF SQL%NOTFOUND THEN
        DBMS_OUTPUT.PUT_LINE('[Cursor implicit] Nu exista detalii de transport pentru ID ' ||
                             v_id_transport || '. Nimic de sters.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('[Cursor implicit] Sterse ' || SQL%ROWCOUNT ||
                             ' inregistrari din DETALII_TRANSPORT.');
        ROLLBACK;
    END IF;
END;
/


-- -------------------------------------------------------
-- F3. (Cursor IMPLICIT - FOR LOOP automat)
--     Afisati un raport cu toate livrarile din luna curenta:
--     numele producatorului, denumirea produsului, cantitatea
--     si valoarea livrata. Folositi un cursor implicit in FOR LOOP.
-- -------------------------------------------------------
DECLARE
    v_total_valoare NUMBER := 0;
    v_nr            NUMBER := 0;
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== Livrari din luna: ' || TO_CHAR(SYSDATE,'MM-YYYY') || ' ===');

    FOR rec IN (
        SELECT PR.NUME             AS PRODUCATOR,
               P.DENUMIRE_PRODUS,
               L.CANTITATE_KG,
               NVL(L.PRET_NEGOCIAT, 0)                               AS PRET,
               L.CANTITATE_KG * NVL(L.PRET_NEGOCIAT, 0)             AS VALOARE,
               TO_CHAR(L.DATA_LIVRARE, 'DD-MM-YYYY')                AS DATA_LIV
        FROM   LIVRARI L
        JOIN   PRODUSE P       ON L.ID_PRODUS     = P.ID_PRODUS
        JOIN   PRODUCATORI PR  ON L.ID_PRODUCATOR = PR.ID_PRODUCATOR
        WHERE  TO_CHAR(L.DATA_LIVRARE, 'MM-YYYY') = TO_CHAR(SYSDATE, 'MM-YYYY')
        ORDER BY L.DATA_LIVRARE
    ) LOOP
        v_nr            := v_nr + 1;
        v_total_valoare := v_total_valoare + rec.VALOARE;
        DBMS_OUTPUT.PUT_LINE(v_nr || '. [' || rec.DATA_LIV || '] ' ||
                             rec.PRODUCATOR || ' | ' || rec.DENUMIRE_PRODUS ||
                             ' | ' || rec.CANTITATE_KG || ' kg x ' || rec.PRET ||
                             ' RON = ' || rec.VALOARE || ' RON');
    END LOOP;

    IF v_nr = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Nu exista livrari inregistrate in luna curenta.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('--- Total: ' || v_nr || ' livrari | Valoare totala: ' ||
                             v_total_valoare || ' RON ---');
    END IF;
END;
/


-- -------------------------------------------------------
-- F4. (Cursor EXPLICIT FARA PARAMETRI)
--     Afisati toti producatorii care au livrat cantitati totale
--     mai mari decat media generala a livrarilor, impreuna cu
--     totalul livrat si procentul fata de medie.
-- -------------------------------------------------------
DECLARE
    CURSOR c_producatori_activi IS
        SELECT PR.ID_PRODUCATOR,
               PR.NUME,
               PR.LOCALITATE,
               NVL(SUM(L.CANTITATE_KG), 0)                     AS TOTAL_KG,
               ROUND(NVL(SUM(L.CANTITATE_KG), 0) /
                     (SELECT AVG(total) FROM
                         (SELECT SUM(CANTITATE_KG) AS total
                          FROM   LIVRARI GROUP BY ID_PRODUCATOR)) * 100, 1) AS PROCENT_FATA_DE_MEDIE
        FROM   PRODUCATORI PR
        JOIN   LIVRARI L ON PR.ID_PRODUCATOR = L.ID_PRODUCATOR
        GROUP BY PR.ID_PRODUCATOR, PR.NUME, PR.LOCALITATE
        HAVING SUM(L.CANTITATE_KG) > (
                   SELECT AVG(total) FROM
                       (SELECT SUM(CANTITATE_KG) AS total
                        FROM   LIVRARI GROUP BY ID_PRODUCATOR))
        ORDER BY TOTAL_KG DESC;

    r_prod  c_producatori_activi%ROWTYPE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== Producatori cu livrari peste medie ===');
    OPEN c_producatori_activi;
    LOOP
        FETCH c_producatori_activi INTO r_prod;
        EXIT WHEN c_producatori_activi%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(c_producatori_activi%ROWCOUNT || '. ' ||
                             r_prod.NUME || ' (' || r_prod.LOCALITATE || ')' ||
                             ' | Total: ' || r_prod.TOTAL_KG || ' kg' ||
                             ' | ' || r_prod.PROCENT_FATA_DE_MEDIE || '% fata de medie');
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Total producatori selectati: ' || c_producatori_activi%ROWCOUNT);
    CLOSE c_producatori_activi;
END;
/


-- -------------------------------------------------------
-- F5. (Cursor EXPLICIT FARA PARAMETRI)
--     Afisati toate transporturile active (status 'Pe drum' sau
--     'Incarcare'), cu detalii despre distribuitor, cost si
--     numarul de produse transportate.
--     La final afisati costul total al transporturilor active.
-- -------------------------------------------------------
DECLARE
    CURSOR c_transport_activ IS
        SELECT T.ID_TRANSPORT,
               D.NUME                              AS DISTRIBUITOR,
               D.REGIUNE,
               T.DATA_PLECARE,
               T.STATUS,
               T.COST_CURSA,
               COUNT(DT.ID_DETALIU)               AS NR_LINII,
               NVL(SUM(DT.CANTITATE_LIV), 0)      AS CANT_TOTALA
        FROM   TRANSPORTURI T
        JOIN   DISTRIBUITORI D        ON T.ID_DISTRIBUITOR = D.ID_DISTRIBUITOR
        LEFT JOIN DETALII_TRANSPORT DT ON T.ID_TRANSPORT   = DT.ID_TRANSPORT
        WHERE  T.STATUS IN ('Pe drum', 'Incarcare')
        GROUP BY T.ID_TRANSPORT, D.NUME, D.REGIUNE, T.DATA_PLECARE, T.STATUS, T.COST_CURSA
        ORDER BY T.DATA_PLECARE;

    r_t         c_transport_activ%ROWTYPE;
    v_cost_total NUMBER := 0;
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== Transporturi active ===');
    OPEN c_transport_activ;
    FETCH c_transport_activ INTO r_t;

    IF c_transport_activ%NOTFOUND THEN
        DBMS_OUTPUT.PUT_LINE('Nu exista transporturi active in acest moment.');
    END IF;

    WHILE c_transport_activ%FOUND LOOP
        v_cost_total := v_cost_total + NVL(r_t.COST_CURSA, 0);
        DBMS_OUTPUT.PUT_LINE('Transport #' || r_t.ID_TRANSPORT ||
                             ' | ' || r_t.DISTRIBUITOR || ' (' || NVL(r_t.REGIUNE,'?') || ')' ||
                             ' | ' || TO_CHAR(r_t.DATA_PLECARE,'DD-MM-YYYY') ||
                             ' | Status: ' || r_t.STATUS ||
                             ' | Cost: ' || NVL(TO_CHAR(r_t.COST_CURSA),'0') || ' RON' ||
                             ' | Produse: ' || r_t.NR_LINII ||
                             ' | Cant: ' || r_t.CANT_TOTALA || ' kg');
        FETCH c_transport_activ INTO r_t;
    END LOOP;
    CLOSE c_transport_activ;

    DBMS_OUTPUT.PUT_LINE('--- Cost total transporturi active: ' || v_cost_total || ' RON ---');
END;
/


-- -------------------------------------------------------
-- F6. (Cursor EXPLICIT CU PARAMETRI)
--     Afisati numele, prenumele si telefonul (CONTACT) producatorilor
--     care au efectuat livrari intr-un an specificat (ex: anul curent).
--     Tratati exceptiile in care nu exista producatori in acel an
--     sau exista mai multi.
--     Cursorul primeste anul ca parametru.
-- -------------------------------------------------------
DECLARE
    v_an NUMBER := EXTRACT(YEAR FROM SYSDATE);

    CURSOR c_producatori_an (p_an NUMBER) IS
        SELECT DISTINCT PR.NUME, PR.LOCALITATE, PR.CONTACT
        FROM   PRODUCATORI PR
        JOIN   LIVRARI L ON PR.ID_PRODUCATOR = L.ID_PRODUCATOR
        WHERE  EXTRACT(YEAR FROM L.DATA_LIVRARE) = p_an
        ORDER BY PR.NUME;

    r_prod  c_producatori_an%ROWTYPE;
    v_cnt   NUMBER := 0;
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== Producatori cu livrari in anul ' || v_an || ' ===');
    OPEN c_producatori_an(v_an);
    LOOP
        FETCH c_producatori_an INTO r_prod;
        EXIT WHEN c_producatori_an%NOTFOUND;
        v_cnt := v_cnt + 1;
        DBMS_OUTPUT.PUT_LINE(v_cnt || '. ' || r_prod.NUME ||
                             ' | Localitate: ' || NVL(r_prod.LOCALITATE,'?') ||
                             ' | Contact: ' || NVL(r_prod.CONTACT,'Fara tel'));
    END LOOP;
    CLOSE c_producatori_an;

    IF v_cnt = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Nu exista producatori cu livrari inregistrate in anul ' || v_an || '.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Total producatori activi in ' || v_an || ': ' || v_cnt);
    END IF;
END;
/


-- =============================================================================
-- G. FUNCTII, PROCEDURI SI PACHETE
-- =============================================================================

-- -------------------------------------------------------
-- G1. FUNCTIA fn_valoare_totala_livrari
--     Creati o functie care primeste ID-ul unui producator si
--     returneaza valoarea totala a livrarilor sale
--     (cantitate * pret negociat). Daca producatorul nu exista
--     sau nu are livrari, returnati 0.
-- -------------------------------------------------------
CREATE OR REPLACE FUNCTION fn_valoare_totala_livrari (p_id_producator NUMBER)
RETURN NUMBER IS
    v_total NUMBER;
    v_cnt   NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_cnt FROM PRODUCATORI WHERE ID_PRODUCATOR = p_id_producator;
    IF v_cnt = 0 THEN
        RETURN -1; -- producator inexistent
    END IF;

    SELECT NVL(SUM(CANTITATE_KG * NVL(PRET_NEGOCIAT, 0)), 0)
    INTO   v_total
    FROM   LIVRARI
    WHERE  ID_PRODUCATOR = p_id_producator;

    RETURN v_total;
END fn_valoare_totala_livrari;
/

-- Test G1
BEGIN
    DBMS_OUTPUT.PUT_LINE('Valoare livrari PRICOPE ALIN (ID 1): ' ||
                         fn_valoare_totala_livrari(1) || ' RON');
    DBMS_OUTPUT.PUT_LINE('Valoare livrari producator inexistent (ID 999): ' ||
                         fn_valoare_totala_livrari(999));
END;
/


-- -------------------------------------------------------
-- G2. FUNCTIA fn_clasa_transport
--     Creati o functie care primeste costul unei curse si
--     returneaza clasa acesteia:
--     sub 100 RON     => 'Cursa Locala'
--     100 - 399 RON   => 'Cursa Regionala'
--     400 - 699 RON   => 'Cursa Nationala'
--     700+ RON        => 'Cursa Majora'
--     NULL            => 'Necunoscut'
-- -------------------------------------------------------
CREATE OR REPLACE FUNCTION fn_clasa_transport (p_cost NUMBER)
RETURN VARCHAR2 IS
BEGIN
    RETURN CASE
               WHEN p_cost IS NULL  THEN 'Necunoscut'
               WHEN p_cost < 100    THEN 'Cursa Locala'
               WHEN p_cost < 400    THEN 'Cursa Regionala'
               WHEN p_cost < 700    THEN 'Cursa Nationala'
               ELSE                      'Cursa Majora'
           END;
END fn_clasa_transport;
/

-- Test G2
BEGIN
    FOR rec IN (SELECT ID_TRANSPORT, COST_CURSA, STATUS FROM TRANSPORTURI ORDER BY ID_TRANSPORT) LOOP
        DBMS_OUTPUT.PUT_LINE('Transport #' || rec.ID_TRANSPORT ||
                             ' | Cost: ' || NVL(TO_CHAR(rec.COST_CURSA),'N/A') ||
                             ' RON | Status: ' || rec.STATUS ||
                             ' => ' || fn_clasa_transport(rec.COST_CURSA));
    END LOOP;
END;
/


-- -------------------------------------------------------
-- G3. FUNCTIA fn_zile_de_la_livrare
--     Creati o functie care primeste ID-ul unui producator si
--     returneaza numarul de zile de la ultima sa livrare pana
--     la data de azi. Daca nu are livrari, returnati NULL.
-- -------------------------------------------------------
CREATE OR REPLACE FUNCTION fn_zile_de_la_livrare (p_id_producator NUMBER)
RETURN NUMBER IS
    v_ultima_data DATE;
BEGIN
    SELECT MAX(DATA_LIVRARE)
    INTO   v_ultima_data
    FROM   LIVRARI
    WHERE  ID_PRODUCATOR = p_id_producator;

    IF v_ultima_data IS NULL THEN
        RETURN NULL;
    END IF;

    RETURN TRUNC(SYSDATE - v_ultima_data);
END fn_zile_de_la_livrare;
/

-- Test G3
BEGIN
    FOR rec IN (SELECT ID_PRODUCATOR, NUME FROM PRODUCATORI ORDER BY ID_PRODUCATOR) LOOP
        DBMS_OUTPUT.PUT_LINE(rec.NUME || ': ultima livrare acum ' ||
                             NVL(TO_CHAR(fn_zile_de_la_livrare(rec.ID_PRODUCATOR)),
                                 'fara livrari') ||
                             CASE WHEN fn_zile_de_la_livrare(rec.ID_PRODUCATOR) IS NOT NULL
                                  THEN ' zile' ELSE '' END);
    END LOOP;
END;
/


-- -------------------------------------------------------
-- G4. PROCEDURA pr_actualizeaza_pret
--     Creati o procedura care primeste ID-ul unui produs si un
--     procent de modificare (pozitiv = majorare, negativ = reducere).
--     Returnati (parametru OUT) noul pret.
--     Validati ca procentul sa fie intre -30% si +50%.
--     Afisati pretul vechi si cel nou.
-- -------------------------------------------------------
CREATE OR REPLACE PROCEDURE pr_actualizeaza_pret (
    p_id_produs  IN  NUMBER,
    p_procent    IN  NUMBER,
    p_pret_nou   OUT NUMBER
) IS
    v_pret_vechi  PRODUSE.PRET_LISTA%TYPE;
    v_denumire    PRODUSE.DENUMIRE_PRODUS%TYPE;
    ex_procent_invalid EXCEPTION;
BEGIN
    IF p_procent < -30 OR p_procent > 50 THEN
        RAISE ex_procent_invalid;
    END IF;

    SELECT PRET_LISTA, DENUMIRE_PRODUS
    INTO   v_pret_vechi, v_denumire
    FROM   PRODUSE
    WHERE  ID_PRODUS = p_id_produs;

    p_pret_nou := ROUND(v_pret_vechi * (1 + p_procent / 100), 2);

    UPDATE PRODUSE SET PRET_LISTA = p_pret_nou WHERE ID_PRODUS = p_id_produs;

    DBMS_OUTPUT.PUT_LINE('[Procedura] "' || v_denumire || '": ' ||
                         v_pret_vechi || ' RON -> ' || p_pret_nou || ' RON (' ||
                         CASE WHEN p_procent >= 0 THEN '+' ELSE '' END || p_procent || '%)');
    ROLLBACK;

EXCEPTION
    WHEN ex_procent_invalid THEN
        DBMS_OUTPUT.PUT_LINE('[Eroare] Procentul ' || p_procent ||
                             '% este in afara limitelor permise (-30% .. +50%).');
        p_pret_nou := NULL;
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('[Eroare] Produsul cu ID ' || p_id_produs || ' nu exista.');
        p_pret_nou := NULL;
END pr_actualizeaza_pret;
/

-- Test G4
DECLARE
    v_pret_rezultat NUMBER;
BEGIN
    pr_actualizeaza_pret(101, 10, v_pret_rezultat);
    DBMS_OUTPUT.PUT_LINE('Pret returnat: ' || NVL(TO_CHAR(v_pret_rezultat), 'NULL'));

    pr_actualizeaza_pret(101, -25, v_pret_rezultat);
    DBMS_OUTPUT.PUT_LINE('Pret returnat: ' || NVL(TO_CHAR(v_pret_rezultat), 'NULL'));

    -- procent invalid
    pr_actualizeaza_pret(101, 80, v_pret_rezultat);
END;
/


-- -------------------------------------------------------
-- G5. PROCEDURA pr_arhiveaza_transporturi
--     Creati o procedura fara parametri care copiaza toate
--     transporturile cu statusul 'Livrat' in tabelul
--     TRANSPORTURI_ISTORIC, evitand duplicatele.
--     Afisati cate inregistrari au fost arhivate si faceti COMMIT.
-- -------------------------------------------------------
CREATE OR REPLACE PROCEDURE pr_arhiveaza_transporturi IS
    v_nr NUMBER;
BEGIN
    INSERT INTO TRANSPORTURI_ISTORIC
    SELECT * FROM TRANSPORTURI
    WHERE  STATUS = 'Livrat'
      AND  ID_TRANSPORT NOT IN (SELECT ID_TRANSPORT FROM TRANSPORTURI_ISTORIC);

    v_nr := SQL%ROWCOUNT;

    IF v_nr = 0 THEN
        DBMS_OUTPUT.PUT_LINE('[Arhivare] Nu exista transporturi noi de arhivat.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('[Arhivare] Au fost arhivate ' || v_nr || ' transporturi. COMMIT efectuat.');
        COMMIT;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('[Eroare arhivare] ' || SQLERRM);
END pr_arhiveaza_transporturi;
/

-- Test G5
BEGIN
    pr_arhiveaza_transporturi;
END;
/


-- -------------------------------------------------------
-- G6. PROCEDURA pr_raport_distribuitor
--     Creati o procedura care primeste ID-ul unui distribuitor
--     si afiseaza un raport complet: numele, regiunea, toate
--     cursele efectuate (cu cost si clasa) si comerciantii
--     deserviti. Tratati cazul in care distribuitorul nu exista.
-- -------------------------------------------------------
CREATE OR REPLACE PROCEDURE pr_raport_distribuitor (p_id_distribuitor IN NUMBER) IS
    v_nume    DISTRIBUITORI.NUME%TYPE;
    v_regiune DISTRIBUITORI.REGIUNE%TYPE;

    CURSOR c_curse IS
        SELECT T.ID_TRANSPORT,
               TO_CHAR(T.DATA_PLECARE,'DD-MM-YYYY') AS DATA_P,
               T.STATUS, T.COST_CURSA,
               fn_clasa_transport(T.COST_CURSA)      AS CLASA
        FROM   TRANSPORTURI T
        WHERE  T.ID_DISTRIBUITOR = p_id_distribuitor
        ORDER BY T.DATA_PLECARE DESC;

    CURSOR c_comercianti IS
        SELECT DISTINCT C.NUME AS COM, C.LOCALITATE, C.TIP_MAGAZIN
        FROM   DETALII_TRANSPORT DT
        JOIN   TRANSPORTURI T  ON DT.ID_TRANSPORT  = T.ID_TRANSPORT
        JOIN   COMERCIANTI C   ON DT.ID_COMERCIANT = C.ID_COMERCIANT
        WHERE  T.ID_DISTRIBUITOR = p_id_distribuitor;

    v_cost_total NUMBER := 0;
    v_nr_curse   NUMBER := 0;
BEGIN
    BEGIN
        SELECT NUME, REGIUNE INTO v_nume, v_regiune
        FROM   DISTRIBUITORI WHERE ID_DISTRIBUITOR = p_id_distribuitor;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('[Eroare] Distribuitorul cu ID ' ||
                                  p_id_distribuitor || ' nu exista!');
            RETURN;
    END;

    DBMS_OUTPUT.PUT_LINE('========================================');
    DBMS_OUTPUT.PUT_LINE('RAPORT: ' || v_nume || ' | Regiune: ' || NVL(v_regiune,'?'));
    DBMS_OUTPUT.PUT_LINE('========================================');
    DBMS_OUTPUT.PUT_LINE('--- CURSE ---');

    FOR rec IN c_curse LOOP
        v_nr_curse   := v_nr_curse + 1;
        v_cost_total := v_cost_total + NVL(rec.COST_CURSA, 0);
        DBMS_OUTPUT.PUT_LINE('  #' || rec.ID_TRANSPORT ||
                             ' | ' || rec.DATA_P ||
                             ' | ' || rec.STATUS ||
                             ' | ' || NVL(TO_CHAR(rec.COST_CURSA),'0') ||
                             ' RON | ' || rec.CLASA);
    END LOOP;

    IF v_nr_curse = 0 THEN
        DBMS_OUTPUT.PUT_LINE('  Nicio cursa inregistrata.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('  Total: ' || v_nr_curse || ' curse | Cost total: ' ||
                              v_cost_total || ' RON');
    END IF;

    DBMS_OUTPUT.PUT_LINE('--- COMERCIANTI DESERVITI ---');
    FOR rec IN c_comercianti LOOP
        DBMS_OUTPUT.PUT_LINE('  > ' || rec.COM ||
                             ' (' || NVL(rec.LOCALITATE,'?') || ')' ||
                             ' | Tip: ' || NVL(rec.TIP_MAGAZIN,'?'));
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('========================================');
END pr_raport_distribuitor;
/

-- Test G6
BEGIN
    pr_raport_distribuitor(201); -- AgroTrans Central
    pr_raport_distribuitor(999); -- inexistent
END;
/


-- -------------------------------------------------------
-- G7. PACHETUL PKG_GESTIONARE_PRODUSE
--     Creati un pachet pentru gestionarea produselor care contine:
--     - O constanta: procentul maxim de majorare (50%)
--     - O functie: fn_pret_mediu_categorie(id_cat) - returneaza pretul mediu
--     - O functie: fn_produse_sub_medie(id_cat) - nr. produse sub pretul mediu
--     - O procedura: pr_majoreaza_categorie(id_cat, procent) - majoreaza preturile
--     - O procedura: pr_raport_categorie(id_cat) - afiseaza raport complet
-- -------------------------------------------------------
CREATE OR REPLACE PACKAGE PKG_GESTIONARE_PRODUSE AS
    c_procent_max CONSTANT NUMBER := 50;

    FUNCTION  fn_pret_mediu_categorie  (p_id_categorie NUMBER) RETURN NUMBER;
    FUNCTION  fn_produse_sub_medie     (p_id_categorie NUMBER) RETURN NUMBER;
    PROCEDURE pr_majoreaza_categorie   (p_id_categorie NUMBER, p_procent NUMBER);
    PROCEDURE pr_raport_categorie      (p_id_categorie NUMBER);
END PKG_GESTIONARE_PRODUSE;
/

CREATE OR REPLACE PACKAGE BODY PKG_GESTIONARE_PRODUSE AS

    -- Functie privata: verifica daca categoria exista
    FUNCTION fn_cat_exista (p_id NUMBER) RETURN BOOLEAN IS
        v_cnt NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_cnt FROM CATEGORII WHERE ID_CATEGORIE = p_id;
        RETURN v_cnt > 0;
    END;

    FUNCTION fn_pret_mediu_categorie (p_id_categorie NUMBER) RETURN NUMBER IS
        v_medie NUMBER;
    BEGIN
        IF NOT fn_cat_exista(p_id_categorie) THEN RETURN -1; END IF;
        SELECT NVL(AVG(PRET_LISTA), 0) INTO v_medie
        FROM   PRODUSE WHERE ID_CATEGORIE = p_id_categorie;
        RETURN ROUND(v_medie, 2);
    END fn_pret_mediu_categorie;

    FUNCTION fn_produse_sub_medie (p_id_categorie NUMBER) RETURN NUMBER IS
        v_medie NUMBER;
        v_cnt   NUMBER;
    BEGIN
        v_medie := fn_pret_mediu_categorie(p_id_categorie);
        IF v_medie = -1 THEN RETURN -1; END IF;
        SELECT COUNT(*) INTO v_cnt
        FROM   PRODUSE WHERE ID_CATEGORIE = p_id_categorie AND PRET_LISTA < v_medie;
        RETURN v_cnt;
    END fn_produse_sub_medie;

    PROCEDURE pr_majoreaza_categorie (p_id_categorie NUMBER, p_procent NUMBER) IS
        ex_procent_depasit    EXCEPTION;
        ex_categorie_invalida EXCEPTION;
        v_nr NUMBER;
    BEGIN
        IF NOT fn_cat_exista(p_id_categorie) THEN RAISE ex_categorie_invalida; END IF;
        IF p_procent > c_procent_max OR p_procent <= 0 THEN RAISE ex_procent_depasit; END IF;

        UPDATE PRODUSE
        SET    PRET_LISTA = ROUND(PRET_LISTA * (1 + p_procent / 100), 2)
        WHERE  ID_CATEGORIE = p_id_categorie;

        v_nr := SQL%ROWCOUNT;
        DBMS_OUTPUT.PUT_LINE('[PKG_PROD] Actualizate ' || v_nr ||
                             ' produse din categoria ' || p_id_categorie ||
                             ' cu +' || p_procent || '%.');
        ROLLBACK;
    EXCEPTION
        WHEN ex_procent_depasit THEN
            DBMS_OUTPUT.PUT_LINE('[PKG_PROD][Eroare] Procentul ' || p_procent ||
                                 '% depaseste limita de ' || c_procent_max || '% sau este negativ.');
        WHEN ex_categorie_invalida THEN
            DBMS_OUTPUT.PUT_LINE('[PKG_PROD][Eroare] Categoria cu ID ' ||
                                  p_id_categorie || ' nu exista.');
    END pr_majoreaza_categorie;

    PROCEDURE pr_raport_categorie (p_id_categorie NUMBER) IS
        v_cat   CATEGORII.NUME_CATEGORIE%TYPE;
        v_cnt   NUMBER;
        v_medie NUMBER;
        v_min   NUMBER;
        v_max   NUMBER;
    BEGIN
        IF NOT fn_cat_exista(p_id_categorie) THEN
            DBMS_OUTPUT.PUT_LINE('[PKG_PROD] Categoria ID ' || p_id_categorie || ' nu exista.'); RETURN;
        END IF;

        SELECT NUME_CATEGORIE INTO v_cat FROM CATEGORII WHERE ID_CATEGORIE = p_id_categorie;
        SELECT COUNT(*), NVL(AVG(PRET_LISTA),0), NVL(MIN(PRET_LISTA),0), NVL(MAX(PRET_LISTA),0)
        INTO   v_cnt, v_medie, v_min, v_max
        FROM   PRODUSE WHERE ID_CATEGORIE = p_id_categorie;

        DBMS_OUTPUT.PUT_LINE('=== Raport categorie: ' || v_cat || ' ===');
        DBMS_OUTPUT.PUT_LINE('  Nr. produse  : ' || v_cnt);
        DBMS_OUTPUT.PUT_LINE('  Pret minim   : ' || v_min || ' RON');
        DBMS_OUTPUT.PUT_LINE('  Pret maxim   : ' || v_max || ' RON');
        DBMS_OUTPUT.PUT_LINE('  Pret mediu   : ' || ROUND(v_medie,2) || ' RON');
        DBMS_OUTPUT.PUT_LINE('  Sub medie    : ' || fn_produse_sub_medie(p_id_categorie) || ' produs(e)');

        DBMS_OUTPUT.PUT_LINE('  -- Produse --');
        FOR rec IN (SELECT DENUMIRE_PRODUS, PRET_LISTA FROM PRODUSE
                    WHERE  ID_CATEGORIE = p_id_categorie ORDER BY PRET_LISTA DESC) LOOP
            DBMS_OUTPUT.PUT_LINE('    * ' || rec.DENUMIRE_PRODUS || ' -> ' || rec.PRET_LISTA || ' RON');
        END LOOP;
    END pr_raport_categorie;

END PKG_GESTIONARE_PRODUSE;
/

-- Test G7
BEGIN
    PKG_GESTIONARE_PRODUSE.pr_raport_categorie(3); -- Solanacee
    DBMS_OUTPUT.PUT_LINE('Pret mediu cat 3: ' || PKG_GESTIONARE_PRODUSE.fn_pret_mediu_categorie(3));
    PKG_GESTIONARE_PRODUSE.pr_majoreaza_categorie(3, 10);
    PKG_GESTIONARE_PRODUSE.pr_majoreaza_categorie(3, 80); -- eroare
    PKG_GESTIONARE_PRODUSE.pr_majoreaza_categorie(99, 5); -- categorie invalida
END;
/


-- -------------------------------------------------------
-- G8. PACHETUL PKG_LOGISTICA
--     Creati un pachet pentru gestionarea logisticii care contine:
--     - O variabila globala: ultimul transport procesat
--     - O functie: fn_cost_mediu_distribuitor(id_dist) - cost mediu curse
--     - O functie: fn_distribuitor_top - ID-ul cu cele mai multe livrari
--     - O procedura: pr_schimba_status(id_tr, status_nou) - cu validari
--     - O procedura: pr_raport_ierarhie - afiseaza ierarhia distribuitorilor
-- -------------------------------------------------------
CREATE OR REPLACE PACKAGE PKG_LOGISTICA AS
    g_ultimul_transport NUMBER := NULL;

    FUNCTION  fn_cost_mediu_distribuitor (p_id_dist NUMBER) RETURN NUMBER;
    FUNCTION  fn_distribuitor_top        RETURN NUMBER;
    PROCEDURE pr_schimba_status          (p_id_transport NUMBER, p_status_nou VARCHAR2);
    PROCEDURE pr_raport_ierarhie;
END PKG_LOGISTICA;
/

CREATE OR REPLACE PACKAGE BODY PKG_LOGISTICA AS

    FUNCTION fn_cost_mediu_distribuitor (p_id_dist NUMBER) RETURN NUMBER IS
        v_medie NUMBER;
    BEGIN
        SELECT NVL(AVG(COST_CURSA), 0) INTO v_medie
        FROM   TRANSPORTURI WHERE ID_DISTRIBUITOR = p_id_dist;
        RETURN ROUND(v_medie, 2);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN RETURN 0;
    END fn_cost_mediu_distribuitor;

    FUNCTION fn_distribuitor_top RETURN NUMBER IS
        v_id NUMBER;
    BEGIN
        SELECT ID_DISTRIBUITOR INTO v_id FROM (
            SELECT ID_DISTRIBUITOR, COUNT(*) AS NR
            FROM   TRANSPORTURI WHERE STATUS = 'Livrat'
            GROUP BY ID_DISTRIBUITOR ORDER BY NR DESC
        ) WHERE ROWNUM = 1;
        RETURN v_id;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN RETURN NULL;
    END fn_distribuitor_top;

    PROCEDURE pr_schimba_status (p_id_transport NUMBER, p_status_nou VARCHAR2) IS
        v_status_curent TRANSPORTURI.STATUS%TYPE;
        ex_tranzitie_invalida EXCEPTION;
        ex_status_necunoscut  EXCEPTION;
    BEGIN
        IF p_status_nou NOT IN ('Incarcare', 'Pe drum', 'Livrat') THEN
            RAISE ex_status_necunoscut;
        END IF;

        SELECT STATUS INTO v_status_curent
        FROM   TRANSPORTURI WHERE ID_TRANSPORT = p_id_transport;

        IF v_status_curent = 'Livrat' THEN RAISE ex_tranzitie_invalida; END IF;
        IF v_status_curent = 'Pe drum' AND p_status_nou = 'Incarcare' THEN
            RAISE ex_tranzitie_invalida;
        END IF;

        UPDATE TRANSPORTURI SET STATUS = p_status_nou WHERE ID_TRANSPORT = p_id_transport;
        g_ultimul_transport := p_id_transport;
        DBMS_OUTPUT.PUT_LINE('[PKG_LOG] Transport #' || p_id_transport ||
                             ': ' || v_status_curent || ' -> ' || p_status_nou);
        ROLLBACK;

    EXCEPTION
        WHEN ex_tranzitie_invalida THEN
            DBMS_OUTPUT.PUT_LINE('[PKG_LOG][Eroare] Tranzitie invalida: ' ||
                                  NVL(v_status_curent,'?') || ' -> ' || p_status_nou);
        WHEN ex_status_necunoscut THEN
            DBMS_OUTPUT.PUT_LINE('[PKG_LOG][Eroare] Status necunoscut: "' || p_status_nou || '"');
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('[PKG_LOG][Eroare] Transport #' || p_id_transport || ' nu exista!');
    END pr_schimba_status;

    PROCEDURE pr_raport_ierarhie IS
        CURSOR c_ierarhie IS
            SELECT LEVEL                                      AS NIVEL,
                   LPAD(' ', (LEVEL-1)*4) || NUME            AS AFISARE,
                   SYS_CONNECT_BY_PATH(NUME,' > ')           AS CALE,
                   REGIUNE
            FROM   DISTRIBUITORI
            START WITH ID_MANAGER IS NULL
            CONNECT BY PRIOR ID_DISTRIBUITOR = ID_MANAGER
            ORDER SIBLINGS BY NUME;
    BEGIN
        DBMS_OUTPUT.PUT_LINE('=== Ierarhia Distributiei ===');
        FOR rec IN c_ierarhie LOOP
            DBMS_OUTPUT.PUT_LINE('Nivel ' || rec.NIVEL || ' | ' ||
                                  rec.AFISARE || ' [' || NVL(rec.REGIUNE,'?') || ']');
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('Top distribuitor (livrari finalizate): ID ' ||
                              NVL(TO_CHAR(fn_distribuitor_top), 'N/A'));
    END pr_raport_ierarhie;

END PKG_LOGISTICA;
/

-- Test G8
BEGIN
    DBMS_OUTPUT.PUT_LINE('Cost mediu distribuitor 201: ' ||
                         PKG_LOGISTICA.fn_cost_mediu_distribuitor(201) || ' RON');
    DBMS_OUTPUT.PUT_LINE('Top distribuitor: ID ' ||
                         NVL(TO_CHAR(PKG_LOGISTICA.fn_distribuitor_top),'N/A'));
    PKG_LOGISTICA.pr_schimba_status(701, 'Livrat');     -- valid
    PKG_LOGISTICA.pr_schimba_status(702, 'Incarcare');  -- invalid (deja Livrat)
    PKG_LOGISTICA.pr_schimba_status(701, 'INVALID');    -- status necunoscut
    PKG_LOGISTICA.pr_raport_ierarhie;
END;
/


-- =============================================================================
-- H. DECLANSATORI
-- =============================================================================

-- -------------------------------------------------------
-- H1. Trigger BEFORE INSERT pe LIVRARI
--     Inainte de inserarea unei livrari noi:
--     a) Daca data livrarii nu e completata, setati-o automat la SYSDATE
--     b) Verificati ca pretul negociat sa nu depaseasca pretul de lista
--        al produsului. Daca da, aruncati o eroare aplicativa.
--     c) Verificati ca producatorul sa nu fi depasit capacitatea de stocare.
-- -------------------------------------------------------
CREATE OR REPLACE TRIGGER trg_livrari_before_insert
BEFORE INSERT ON LIVRARI
FOR EACH ROW
DECLARE
    v_pret_lista   PRODUSE.PRET_LISTA%TYPE;
    v_capacitate   PRODUCATORI.CAPACITATE_STOCARE_KG%TYPE;
    v_total_livrat NUMBER;
BEGIN
    -- a) Data automata
    IF :NEW.DATA_LIVRARE IS NULL THEN
        :NEW.DATA_LIVRARE := SYSDATE;
    END IF;

    -- b) Validare pret negociat
    SELECT PRET_LISTA INTO v_pret_lista
    FROM   PRODUSE WHERE ID_PRODUS = :NEW.ID_PRODUS;

    IF :NEW.PRET_NEGOCIAT IS NOT NULL AND :NEW.PRET_NEGOCIAT > v_pret_lista THEN
        RAISE_APPLICATION_ERROR(-20010,
            '[Trigger H1] Pretul negociat (' || :NEW.PRET_NEGOCIAT ||
            ' RON) depaseste pretul de lista (' || v_pret_lista ||
            ' RON) pentru produsul ID ' || :NEW.ID_PRODUS || '!');
    END IF;

    -- c) Validare capacitate stocare
    SELECT CAPACITATE_STOCARE_KG INTO v_capacitate
    FROM   PRODUCATORI WHERE ID_PRODUCATOR = :NEW.ID_PRODUCATOR;

    IF v_capacitate IS NOT NULL THEN
        SELECT NVL(SUM(CANTITATE_KG), 0) INTO v_total_livrat
        FROM   LIVRARI WHERE ID_PRODUCATOR = :NEW.ID_PRODUCATOR;

        IF (v_total_livrat + :NEW.CANTITATE_KG) > v_capacitate THEN
            RAISE_APPLICATION_ERROR(-20011,
                '[Trigger H1] Depasire capacitate! Disponibil: ' ||
                (v_capacitate - v_total_livrat) || ' kg. Solicitat: ' ||
                :NEW.CANTITATE_KG || ' kg.');
        END IF;
    END IF;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20012,
            '[Trigger H1] Produsul ID ' || :NEW.ID_PRODUS ||
            ' sau Producatorul ID ' || :NEW.ID_PRODUCATOR || ' nu exista!');
END trg_livrari_before_insert;
/

-- Test H1
BEGIN
    -- Test 1: insert valid
    INSERT INTO LIVRARI VALUES (511, 1, 101, NULL, 100, 10.00);
    DBMS_OUTPUT.PUT_LINE('[H1 Test 1] Insert valid reusit. Data setata automat.');
    ROLLBACK;

    -- Test 2: pret negociat invalid
    BEGIN
        INSERT INTO LIVRARI VALUES (512, 1, 101, SYSDATE, 100, 999.00);
    EXCEPTION
        WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('[H1 Test 2] ' || SQLERRM);
    END;
END;
/


-- -------------------------------------------------------
-- H2. Trigger AFTER UPDATE pe TRANSPORTURI
--     Dupa ce statusul unui transport este schimbat in 'Livrat',
--     copiati automat inregistrarea in tabelul TRANSPORTURI_ISTORIC,
--     evitand duplicatele. Afisati un mesaj de confirmare.
-- -------------------------------------------------------
CREATE OR REPLACE TRIGGER trg_transport_after_update
AFTER UPDATE OF STATUS ON TRANSPORTURI
FOR EACH ROW
WHEN (NEW.STATUS = 'Livrat' AND OLD.STATUS != 'Livrat')
BEGIN
    INSERT INTO TRANSPORTURI_ISTORIC
    SELECT * FROM TRANSPORTURI
    WHERE  ID_TRANSPORT = :NEW.ID_TRANSPORT
      AND  NOT EXISTS (SELECT 1 FROM TRANSPORTURI_ISTORIC
                       WHERE  ID_TRANSPORT = :NEW.ID_TRANSPORT);

    DBMS_OUTPUT.PUT_LINE('[Trigger H2] Transport #' || :NEW.ID_TRANSPORT ||
                         ' arhivat automat in TRANSPORTURI_ISTORIC.');
END trg_transport_after_update;
/

-- Test H2
DECLARE
    v_cnt NUMBER;
BEGIN
    UPDATE TRANSPORTURI SET STATUS = 'Livrat' WHERE ID_TRANSPORT = 703;
    SELECT COUNT(*) INTO v_cnt FROM TRANSPORTURI_ISTORIC WHERE ID_TRANSPORT = 703;
    DBMS_OUTPUT.PUT_LINE('[H2 Test] Inregistrari in istoric pentru transport 703: ' || v_cnt);
    ROLLBACK;
END;
/


-- -------------------------------------------------------
-- H3. Trigger COMPOUND pe PRODUSE
--     Creati un trigger compus pe tabela PRODUSE care:
--     a) BEFORE EACH ROW: Blocheaza orice modificare de pret
--        mai mare de 30% (in plus sau minus) si afiseaza mesaj de eroare.
--     b) AFTER STATEMENT: Afiseaza un sumar cu cate randuri
--        au fost procesate cu succes in cadrul statement-ului.
-- -------------------------------------------------------
CREATE OR REPLACE TRIGGER trg_produse_compound
FOR UPDATE OF PRET_LISTA ON PRODUSE
COMPOUND TRIGGER

    v_nr_procesate NUMBER := 0;
    v_prag         CONSTANT NUMBER := 30;

    BEFORE EACH ROW IS
        v_procent NUMBER;
    BEGIN
        IF :OLD.PRET_LISTA IS NOT NULL AND :OLD.PRET_LISTA > 0 THEN
            v_procent := ABS((:NEW.PRET_LISTA - :OLD.PRET_LISTA) / :OLD.PRET_LISTA * 100);
            IF v_procent > v_prag THEN
                RAISE_APPLICATION_ERROR(-20020,
                    '[Trigger H3] Modificarea pretului pentru "' || :OLD.DENUMIRE_PRODUS ||
                    '" de ' || ROUND(v_procent,1) || '% depaseste limita de ' ||
                    v_prag || '%! (' || :OLD.PRET_LISTA || ' -> ' || :NEW.PRET_LISTA || ' RON)');
            END IF;
        END IF;
        v_nr_procesate := v_nr_procesate + 1;
    END BEFORE EACH ROW;

    AFTER STATEMENT IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('[Trigger H3] Statement finalizat. Randuri procesate cu succes: ' ||
                              v_nr_procesate);
    END AFTER STATEMENT;

END trg_produse_compound;
/

-- Test H3
BEGIN
 
    BEGIN
        UPDATE PRODUSE SET PRET_LISTA = ROUND(PRET_LISTA * 1.10, 2) WHERE ID_PRODUS = 101;
        DBMS_OUTPUT.PUT_LINE('[H3 Test 1] Update +10% acceptat.');
        ROLLBACK;
    END;

    -- Test 2: modificare invalida (+100%)
    BEGIN
        UPDATE PRODUSE SET PRET_LISTA = PRET_LISTA * 2.00 WHERE ID_PRODUS = 101;
        ROLLBACK;
    EXCEPTION
        WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('[H3 Test 2] ' || SQLERRM);
    END;
END;
/



COMMIT;






