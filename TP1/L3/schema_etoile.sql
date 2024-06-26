/* Oracle DDL Generated by BIM 1.0 */

CREATE TABLE "D_CLIENT"
(
	"ID_CLIENT" CHAR(10) NOT NULL,
	"NOM" CHAR(16) NOT NULL,
	"AGE" NUMBER(3) NOT NULL,
	"FONCTION" CHAR,
	"CONTACT_PRINCIPAL" NUMBER(7),
	"SOCIETE" CHAR
)
;

CREATE UNIQUE INDEX "PK_D_CLIENT" ON "D_CLIENT"("ID_CLIENT")
;


ALTER TABLE "D_CLIENT" ADD CONSTRAINT "PK_D_CLIENT"  PRIMARY KEY ("ID_CLIENT")
USING INDEX
;

CREATE TABLE "D_COMMERCIAUX"
(
	"ID_COMMERCIAUX" NUMERIC NOT NULL,
	"NOM_C" CHAR(16) NOT NULL,
	"AGE" NUMBER(2) NOT NULL,
	"Tranche_d_age" NUMBER(2)
)
;

CREATE UNIQUE INDEX "PK_D_COMMERCIAUX" ON "D_COMMERCIAUX"("ID_COMMERCIAUX")
;


ALTER TABLE "D_COMMERCIAUX" ADD CONSTRAINT "PK_D_COMMERCIAUX"  PRIMARY KEY ("ID_COMMERCIAUX")
USING INDEX
;

ALTER TABLE "D_CONTINENTS" ADD CONSTRAINT "PK_D_CONTINENTS"  PRIMARY KEY ("ID_CONTINENTS")
USING INDEX
;

CREATE TABLE "D_PRODUIT"
(
	"ID_PRODUIT" NUMERIC NOT NULL,
	"NOM_P" CHAR(16) NOT NULL,
	"CATEGORIES" CHAR
)
;

CREATE UNIQUE INDEX "PK_D_PRODUIT" ON "D_PRODUIT"("ID_PRODUIT")
;


ALTER TABLE "D_PRODUIT" ADD CONSTRAINT "PK_D_PRODUIT"  PRIMARY KEY ("ID_PRODUIT")
USING INDEX
;

CREATE TABLE "D_TEMPS"
(
	"ID_TEMPS" NUMERIC NOT NULL,
	"MOIS" NUMBER(2) NOT NULL,
	"TRIMESTRE" NUMBER(1) NOT NULL,
	"SEMESTRE" NUMBER(1) NOT NULL,
	"ANS" NUMBER(4) NOT NULL,
	"Saison" CHAR
)
;

CREATE UNIQUE INDEX "PK_D_TEMPS" ON "D_TEMPS"("ID_TEMPS")
;


ALTER TABLE "D_TEMPS" ADD CONSTRAINT "PK_D_TEMPS"  PRIMARY KEY ("ID_TEMPS")
USING INDEX
;

CREATE TABLE "D_ZONEGEO"
(
	"ID_ZONEGEO" NUMERIC NOT NULL,
	"PAYS" CHAR(16) NOT NULL,
	"CONTINENTS" CHAR(16) NOT NULL,
	"NOM_ZONEGEO" CHAR
)
;

CREATE UNIQUE INDEX "PK_D_ZONEGEO" ON "D_ZONEGEO"("ID_ZONEGEO")
;


ALTER TABLE "D_ZONEGEO" ADD CONSTRAINT "PK_D_ZONEGEO"  PRIMARY KEY ("ID_ZONEGEO")
USING INDEX
;

CREATE TABLE "F_VENTES"
(
	"ID_CLIENT" NUMERIC NOT NULL,
	"ID_TEMPS" NUMERIC NOT NULL,
	"ID_ZONEGEO" NUMERIC NOT NULL,
	"ID_PRODUIT" NUMERIC NOT NULL,
	"ID_COMMERCIAUX" NUMERIC NOT NULL,
	"Chiffre d'affaire" NUMBER(9)
)
;

CREATE UNIQUE INDEX "PK_F_VENTES" ON "F_VENTES"("ID_CLIENT", "ID_TEMPS", "ID_ZONEGEO", "ID_PRODUIT", "ID_COMMERCIAUX")
;


ALTER TABLE "F_VENTES" ADD CONSTRAINT "PK_F_VENTES"  PRIMARY KEY ("ID_CLIENT", "ID_TEMPS", "ID_ZONEGEO", "ID_PRODUIT", "ID_COMMERCIAUX")
USING INDEX
;

ALTER TABLE "F_VENTES" ADD CONSTRAINT "FK_VENTES_CLIENT" FOREIGN KEY ("ID_CLIENT")
REFERENCES "D_CLIENT" ("ID_CLIENT")
;

ALTER TABLE "F_VENTES" ADD CONSTRAINT "FK_VENTES_TEMPS" FOREIGN KEY ("ID_TEMPS")
REFERENCES "D_TEMPS" ("ID_TEMPS")
;

ALTER TABLE "F_VENTES" ADD CONSTRAINT "FK_VENTES_ZONEGEO" FOREIGN KEY ("ID_ZONEGEO")
REFERENCES "D_ZONEGEO" ("ID_ZONEGEO")
;

ALTER TABLE "F_VENTES" ADD CONSTRAINT "FK_VENTES_PRODUIT" FOREIGN KEY ("ID_PRODUIT")
REFERENCES "D_PRODUIT" ("ID_PRODUIT")
;

ALTER TABLE "F_VENTES" ADD CONSTRAINT "FK_VENTES_COMMERCIAUX" FOREIGN KEY ("ID_COMMERCIAUX")
REFERENCES "D_COMMERCIAUX" ("ID_COMMERCIAUX")
;


-- Créer une séquence pour la table ZONEGEO
CREATE SEQUENCE SEQ_ZONEGEO;

-- Créer un déclencheur pour la séquence de la table ZONEGEO
CREATE OR REPLACE TRIGGER TRIG_SEQ_ZONEGEO
BEFORE INSERT ON D_ZONEGEO FOR EACH ROW
BEGIN
    SELECT SEQ_ZONEGEO.NEXTVAL INTO :NEW.ID_ZONEGEO FROM DUAL;
END;
/

-- Créer une séquence pour la table COMMERCIAUX
CREATE SEQUENCE SEQ_COMMERCIAUX;

-- Créer un déclencheur pour la séquence de la table COMMERCIAUX
CREATE OR REPLACE TRIGGER TRIG_SEQ_COMMERCIAUX
BEFORE INSERT ON D_COMMERCIAUX FOR EACH ROW
BEGIN
    SELECT SEQ_COMMERCIAUX.NEXTVAL INTO :NEW.ID_COMMERCIAUX FROM DUAL;
END;
/

-- Créer une séquence pour la table TEMPS
CREATE SEQUENCE SEQ_TEMPS;

-- Créer un déclencheur pour la séquence de la table TEMPS
CREATE OR REPLACE TRIGGER TRIG_SEQ_TEMPS
BEFORE INSERT ON D_TEMPS FOR EACH ROW
BEGIN
    SELECT SEQ_TEMPS.NEXTVAL INTO :NEW.ID_TEMPS FROM DUAL;
END;
/

UPDATE D_COMMERCIAUX
SET "Tranche_d_age" =
    CASE
        WHEN age BETWEEN 20 AND 29 THEN '20-29'
        WHEN age BETWEEN 30 AND 39 THEN '30-39'
        WHEN age BETWEEN 40 AND 49 THEN '40-49'
        -- Ajoutez d'autres tranches d'âge selon vos besoins
        ELSE '50+'
    END;

