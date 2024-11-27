-- ==============================================================
-- Fichier : objective_1_track_popularity.sql
-- Objectif : Contient les requêtes SQL utilisées pour analyser les changements de popularité des prénoms aux États-Unis.
-- ==============================================================

-- ==============================================================
-- OBJECTIF 1 : SUIVRE LES CHANGEMENTS DE POPULARITÉ
-- ==============================================================

-- 1. Trouver le prénom féminin et masculin les plus populaires et observer comment leur popularité a évolué au fil des années.

-- Étape 1 : Examiner l'ensemble des données pour les agréger.
SELECT * FROM names;

-- Trouver le prénom masculin le plus populaire.
SELECT 
    Name,
    SUM(Births) AS num_babies
FROM names
WHERE Gender = "M"
GROUP BY Name
ORDER BY num_babies DESC
LIMIT 1; -- Résultat : Michael

-- Trouver le prénom féminin le plus populaire.
SELECT 
    Name,
    SUM(Births) AS num_babies
FROM names
WHERE Gender = "F"
GROUP BY Name
ORDER BY num_babies DESC
LIMIT 1; -- Résultat : Jessica

-- Suivre l'évolution annuelle de la popularité du prénom "Jessica".
WITH FemaleNames AS (
    SELECT
        Year,
        Name AS most_popular_female_name,
        SUM(Births) AS female_births,
        ROW_NUMBER() OVER (PARTITION BY Year ORDER BY SUM(Births) DESC) AS row_num
    FROM names
    WHERE Gender = 'F' 
    GROUP BY Year, Name
)
SELECT
    Year,
    most_popular_female_name,
    female_births,
    row_num
FROM FemaleNames 
WHERE most_popular_female_name = 'Jessica';

-- Suivre l'évolution annuelle de la popularité du prénom "Michael".
WITH MaleNames AS (
    SELECT
        Year,
        Name AS most_popular_male_name,
        SUM(Births) AS male_births,
        ROW_NUMBER() OVER (PARTITION BY Year ORDER BY SUM(Births) DESC) AS row_num
    FROM names
    WHERE Gender = 'M' 
    GROUP BY Year, Name
)
SELECT
    Year,
    most_popular_male_name,
    male_births,
    row_num
FROM MaleNames 
WHERE most_popular_male_name = 'Michael';

-- 2. Trouver les prénoms ayant connu la plus forte progression en popularité entre la première et la dernière année du dataset.

WITH Names_1980 AS (
    SELECT
        Year,
        Name,
        SUM(Births) AS num_babies,
        ROW_NUMBER() OVER (PARTITION BY Year ORDER BY SUM(Births) DESC) AS popularity
    FROM names
    WHERE Year = 1980
    GROUP BY Year, Name
),
Names_2009 AS (
    SELECT 
        Year,
        Name,
        SUM(Births) AS num_babies,
        ROW_NUMBER() OVER (PARTITION BY Year ORDER BY SUM(Births) DESC) AS popularity
    FROM names
    WHERE Year = 2009
    GROUP BY Year, Name
)
SELECT
    t1.Year AS year_1980,
    t1.Name,
    t1.popularity AS popularity_1980,
    t2.Year AS year_2009,
    t2.popularity AS popularity_2009,
    CAST(t2.popularity AS SIGNED) - CAST(t1.popularity AS SIGNED) AS popularity_change
FROM Names_1980 t1
INNER JOIN Names_2009 t2
    ON t1.Name = t2.Name
ORDER BY popularity_change;
