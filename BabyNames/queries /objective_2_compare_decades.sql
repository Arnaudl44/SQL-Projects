-- ==============================================================
-- Fichier : objective_2_compare_decades.sql
-- Objectif : Contient les requêtes SQL utilisées pour comparer 
--            la popularité des prénoms par décennies.
-- ==============================================================

-- ==============================================================
-- OBJECTIF 2 : COMPARER LA POPULARITÉ DES PRÉNOMS PAR DÉCENNIE
-- ==============================================================

-- 1. Identifier les 3 prénoms masculins et féminins les plus populaires chaque année.

-- Méthode 1 : Combiner les données des garçons et des filles.
WITH MaleNames AS (
    SELECT
        Year,
        Name AS most_popular_male_name,
        SUM(Births) AS male_births,
        ROW_NUMBER() OVER (PARTITION BY Year ORDER BY SUM(Births) DESC) AS row_num
    FROM names
    WHERE Gender = 'M'
    GROUP BY Year, Name
),
FemaleNames AS (
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
    M.Year,
    M.row_num AS popularity_rank,
    M.most_popular_male_name,
    M.male_births,
    F.most_popular_female_name,
    F.female_births
FROM MaleNames M
INNER JOIN FemaleNames F
    ON M.Year = F.Year AND M.row_num = F.row_num
WHERE M.row_num IN (1,2,3) AND F.row_num IN (1,2,3)
ORDER BY M.Year;

-- Méthode 2 : Regrouper toutes les données dans une seule table avec classement.
WITH babies_by_year AS (
    SELECT 
        Year,
        Gender,
        Name,
        SUM(Births) AS num_babies
    FROM names
    GROUP BY Year, Gender, Name
),
ranked_names AS (
    SELECT 
        Year,
        Gender,
        Name,
        num_babies,
        ROW_NUMBER() OVER (PARTITION BY Year, Gender ORDER BY num_babies DESC) AS popularity
    FROM babies_by_year
)
SELECT 
    Year,
    Gender,
    Name,
    num_babies,
    popularity
FROM ranked_names
WHERE popularity < 4;

-- 2. Identifier les 3 prénoms masculins et féminins les plus populaires pour chaque décennie.

WITH babies_by_decade AS (
    SELECT 
        CASE
            WHEN Year BETWEEN 1980 AND 1989 THEN 'Eighties'
            WHEN Year BETWEEN 1990 AND 1999 THEN 'Nineties'
            ELSE 'Two-thousands'
        END AS Decade,
        Gender,
        Name,
        SUM(Births) AS num_babies
    FROM names
    GROUP BY Decade, Gender, Name
),
ranked_names_by_decade AS (
    SELECT 
        Decade,
        Gender,
        Name,
        num_babies,
        ROW_NUMBER() OVER (PARTITION BY Decade, Gender ORDER BY num_babies DESC) AS popularity
    FROM babies_by_decade
)
SELECT 
    Decade,
    Gender,
    Name,
    num_babies,
    popularity
FROM ranked_names_by_decade
WHERE popularity < 4;
