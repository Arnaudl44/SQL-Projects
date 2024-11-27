-- ==============================================================
-- Fichier : objective_4_explore_unique_names.sql
-- Objectif : Contient les requêtes SQL utilisées pour explorer les prénoms uniques dans le dataset.
-- ==============================================================

-- ==============================================================
-- OBJECTIF 4 : EXPLORER LES PRÉNOMS UNIQUES
-- ==============================================================

-- 1. Identifier les 10 prénoms les plus populaires et androgynes (attribués à la fois aux garçons et aux filles).

-- Méthode 1 : Requête simple.
SELECT 
    Name, 
    COUNT(DISTINCT Gender) AS num_genders, -- Vérifie si un prénom existe pour les deux genres
    SUM(Births) AS num_babies
FROM names
GROUP BY Name
HAVING num_genders = 2 -- Prise en compte des prénoms attribués aux deux genres
ORDER BY num_babies DESC
LIMIT 10;

-- Méthode 2 : Avec CTE pour des analyses intermédiaires.
WITH female_name AS (
    SELECT 
        Name,
        SUM(Births) AS num_babies_female
    FROM names
    WHERE Gender = 'F'
    GROUP BY Name
),
male_name AS (
    SELECT 
        Name,
        SUM(Births) AS num_babies_male
    FROM names
    WHERE Gender = 'M'
    GROUP BY Name
)
SELECT 
    f.Name AS Androgynous_Name,
    f.num_babies_female AS Female_Births,
    m.num_babies_male AS Male_Births,
    (f.num_babies_female + m.num_babies_male) AS Total_Births
FROM female_name f
INNER JOIN male_name m
    ON f.Name = m.Name
ORDER BY Total_Births DESC
LIMIT 10;

-- ==============================================================
-- 2. Identifier la longueur des prénoms les plus courts et les plus longs, ainsi que leur popularité.
-- ==============================================================

-- Étape 1 : Identifier les prénoms les plus courts.
SELECT
    Name,
    LENGTH(Name) AS shortest_name,
    SUM(Births) AS num_babies
FROM names
GROUP BY Name
ORDER BY 2, 3 DESC; -- Tri par longueur croissante, puis par popularité décroissante

-- Étape 2 : Identifier les prénoms les plus longs.
SELECT
    Name,
    LENGTH(Name) AS longest_name,
    SUM(Births) AS num_babies
FROM names
GROUP BY Name
ORDER BY 2 DESC, 3 DESC; -- Tri par longueur décroissante, puis par popularité décroissante

-- Étape 3 : Trouver les prénoms ayant la longueur minimale ou maximale.
SELECT
    Name,
    SUM(Births) AS num_babies
FROM names
WHERE LENGTH(Name) IN (2, 15) -- Longueurs extrêmes
GROUP BY Name
ORDER BY num_babies DESC;

-- ==============================================================
-- 3. Identifier l'État ayant le pourcentage le plus élevé de bébés nommés "Chris".
-- ==============================================================

WITH total_chris AS (
    SELECT
        State,
        Name,
        SUM(Births) AS num_babies_chris
    FROM names
    WHERE Name = 'Chris'
    GROUP BY State, Name
),
total_state AS (
    SELECT
        State,
        SUM(Births) AS total_births
    FROM names
    GROUP BY State
)
SELECT
    tc.State,
    tc.num_babies_chris,
    ts.total_births,
    (tc.num_babies_chris / ts.total_births * 100) AS percentage_chris
FROM total_chris tc
INNER JOIN total_state ts
    ON tc.State = ts.State
ORDER BY percentage_chris DESC;
