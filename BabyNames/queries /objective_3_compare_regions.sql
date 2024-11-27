-- ==============================================================
-- Fichier : objective3_compare_regions.sql
-- Objectif : Contient les requêtes SQL utilisées pour comparer 
--            la popularité des prénoms par région.
-- ==============================================================

-- ==============================================================
-- OBJECTIF 3 : COMPARER LA POPULARITÉ PAR RÉGION
-- ==============================================================

-- 1. Retourner le nombre de naissances par région 
-- (NOTE : l'État "MI" doit être dans la région Midwest).

-- Étape 1 : Vérifier les données initiales des régions.
SELECT * FROM regions;

-- Étape 2 : Identifier les régions uniques dans le dataset.
SELECT DISTINCT Region FROM Regions;

-- Méthode 1 : Nettoyage des données avec UPDATE et INSERT INTO.
SET SQL_SAFE_UPDATES = 0; -- Permet de désactiver les restrictions de mise à jour
UPDATE regions
SET Region = 'New_England'
WHERE Region = 'New England'; -- Correction du format de la région

-- Ajout manuel de l'État "MI" dans la région "Midwest".
INSERT INTO regions (State, Region)
VALUES ('MI', 'Midwest');

-- Méthode 2 : Nettoyage des données avec CASE WHEN dans une CTE.
WITH Clean_regions AS (
    SELECT
        State,
        CASE
            WHEN Region = 'New England' THEN 'New_England'
            ELSE Region
        END AS Clean_region
    FROM regions
    UNION ALL
    SELECT 'MI' AS State, 'Midwest' AS Region
)
SELECT 
    clean_region,
    SUM(Births) AS num_babies
FROM names n
LEFT JOIN Clean_regions cr
    ON n.State = cr.State
GROUP BY clean_region;

-- Méthode 3 : Nettoyage des données avec CASE WHEN dans une vue.
CREATE VIEW Clean_regions AS
SELECT
    State,
    CASE
        WHEN Region = 'New England' THEN 'New_England'
        WHEN State = 'MI' THEN 'Midwest'
        ELSE Region
    END AS Adjusted_Region
FROM regions;

-- 2. Retourner le nombre de naissances par région 
-- (NOTE : l'État "MI" doit être dans la région Midwest).

WITH Clean_regions AS (
    SELECT
        State,
        CASE
            WHEN Region = 'New England' THEN 'New_England'
            ELSE Region
        END AS clean_region
    FROM regions
    UNION ALL
    SELECT
        'MI' AS State, 'Midwest' AS Region
),
babies_by_year AS (
    SELECT
        cr.clean_region AS Region,
        n.Gender,
        n.Name,
        SUM(n.Births) AS num_babies
    FROM clean_regions cr
    LEFT JOIN names n
        ON cr.State = n.State
    GROUP BY cr.clean_region, n.Gender, n.Name
),
ranked_names AS (
    SELECT 
        Region,
        Gender,
        Name,
        num_babies,
        ROW_NUMBER() OVER (PARTITION BY Region, Gender ORDER BY num_babies DESC) AS popularity
    FROM babies_by_year
)
SELECT 
    Region,
    Gender,
    Name,
    popularity
FROM ranked_names
WHERE popularity < 4;
