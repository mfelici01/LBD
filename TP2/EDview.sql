CREATE OR REPLACE VIEW VUE_VENTES  AS
  SELECT P.CATEGORIE AS categorie_produit,
       L.PAYS,
       T.TRIMESTRE
FROM VENTE V 
JOIN PRODUIT P ON V.PID = P.PID
JOIN TEMPS T ON V.TID = T.TID
JOIN LOCALISATION L ON L.LID = V.LID
GROUP BY P.CATEGORIE, L.PAYS, T.TRIMESTRE;