DELETE FROM D_ZONEGEO ;

ALTER SEQUENCE SEQ_ZONEGEO RESTART ;


-- Créer une séquence pour la table COMMERCIAUX
CREATE SEQUENCE SEQ_COMMERCIAUX;

-- Créer un déclencheur pour la séquence de la table COMMERCIAUX
CREATE OR REPLACE TRIGGER TRIG_SEQ_COMMERCIAUX
BEFORE INSERT ON D_COMMERCIAUX FOR EACH ROW
BEGIN
    SELECT SEQ_COMMERCIAUX.NEXTVAL INTO :NEW.ID_COMMERCIAUX FROM DUAL;
END;
/

DESCRIBE D_COMMERCIAUX;


UPDATE D_COMMERCIAUX
SET "Tranche_d_age" =
    CASE
        WHEN age BETWEEN 20 AND 29 THEN '20-29'
        WHEN age BETWEEN 30 AND 39 THEN '30-39'
        WHEN age BETWEEN 40 AND 49 THEN '40-49'
        -- Ajoutez d'autres tranches d'âge selon vos besoins
        ELSE '50+'
    END;

INSERT INTO F_VENTES (ID_CLIENT,ID_ZONEGEO,ID_COMMERCIAUX,ID_PRODUIT,ID_TEMPS)
SELECT d1.id, d2.id, d3.id, f.mesure1, f.mesure2
FROM table_dimension1 d1
JOIN table_dimension2 d2 ON f.dimension2_value = d2.dimension2_value
JOIN table_dimension3 d3 ON f.dimension3_value = d3.dimension3_value
JOIN table_faits f ON f.dimension1_value = d1.dimension1_value;



-- Créer une séquence pour la table TEMPS
CREATE SEQUENCE SEQ_TEMPS;

-- Créer un déclencheur pour la séquence de la table TEMPS
CREATE OR REPLACE TRIGGER TRIG_SEQ_TEMPS
BEFORE INSERT ON D_TEMPS FOR EACH ROW
BEGIN
    SELECT SEQ_TEMPS.NEXTVAL INTO :NEW.ID_TEMPS FROM DUAL;
END;
/