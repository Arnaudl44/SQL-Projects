-- =============================================================================
-- Fichier : Marketing_Analysis.sql
-- Objectif : Analyser et optimiser les canaux marketing, les tendances du trafic 
-- et les taux de conversion pour améliorer les performances et la prise de décision.
-- =============================================================================

-- 1. Tendances mensuelles des sessions et commandes GSearch
-- Objectif : Identifier les tendances de croissance des sessions et des commandes issues de GSearch.

SELECT
    YEAR(website_sessions.created_at) AS annee,
    MONTH(website_sessions.created_at) AS mois,
    COUNT(DISTINCT website_sessions.website_session_id) AS sessions,
    COUNT(DISTINCT orders.order_id) AS commandes,
    COUNT(DISTINCT orders.order_id) / COUNT(DISTINCT website_sessions.website_session_id) AS taux_conversion
FROM website_sessions
LEFT JOIN orders 
    ON orders.website_session_id = website_sessions.website_session_id
WHERE website_sessions.utm_source = 'gsearch' -- Filtrer uniquement les données GSearch
GROUP BY 1, 2;

-- 2. Analyse des campagnes GSearch : marque (brand) vs non-marque (nonbrand)
-- Objectif : Comparer les performances des campagnes marque et non-marque.

SELECT
    YEAR(website_sessions.created_at) AS annee,
    MONTH(website_sessions.created_at) AS mois,
    COUNT(DISTINCT CASE WHEN utm_campaign = 'nonbrand' THEN website_sessions.website_session_id ELSE NULL END) AS sessions_nonbrand,
    COUNT(DISTINCT CASE WHEN utm_campaign = 'nonbrand' THEN orders.order_id ELSE NULL END) AS commandes_nonbrand,
    COUNT(DISTINCT CASE WHEN utm_campaign = 'brand' THEN website_sessions.website_session_id ELSE NULL END) AS sessions_brand,
    COUNT(DISTINCT CASE WHEN utm_campaign = 'brand' THEN orders.order_id ELSE NULL END) AS commandes_brand
FROM website_sessions
LEFT JOIN orders 
    ON orders.website_session_id = website_sessions.website_session_id
WHERE website_sessions.utm_source = 'gsearch'
GROUP BY 1, 2;

-- 3. Analyse des campagnes Nonbrand GSearch par type d'appareil
-- Objectif : Analyser les sessions et commandes des campagnes Nonbrand en les segmentant par appareils (desktop vs mobile).

SELECT
    YEAR(website_sessions.created_at) AS annee,
    MONTH(website_sessions.created_at) AS mois,
    COUNT(DISTINCT CASE WHEN device_type = 'desktop' THEN website_sessions.website_session_id ELSE NULL END) AS sessions_desktop,
    COUNT(DISTINCT CASE WHEN device_type = 'desktop' THEN orders.order_id ELSE NULL END) AS commandes_desktop,
    COUNT(DISTINCT CASE WHEN device_type = 'mobile' THEN website_sessions.website_session_id ELSE NULL END) AS sessions_mobile,
    COUNT(DISTINCT CASE WHEN device_type = 'mobile' THEN orders.order_id ELSE NULL END) AS commandes_mobile
FROM website_sessions
LEFT JOIN orders 
    ON orders.website_session_id = website_sessions.website_session_id
WHERE website_sessions.utm_source = 'gsearch'
  AND website_sessions.utm_campaign = 'nonbrand'
GROUP BY 1, 2;

-- 4. Comparaison des tendances mensuelles entre différents canaux
-- Objectif : Surveiller le trafic provenant de GSearch, BSearch, recherche organique et visites directes.

SELECT
    YEAR(website_sessions.created_at) AS annee,
    MONTH(website_sessions.created_at) AS mois,
    COUNT(DISTINCT CASE WHEN utm_source = 'gsearch' THEN website_sessions.website_session_id ELSE NULL END) AS sessions_gsearch,
    COUNT(DISTINCT CASE WHEN utm_source = 'bsearch' THEN website_sessions.website_session_id ELSE NULL END) AS sessions_bsearch,
    COUNT(DISTINCT CASE WHEN utm_source IS NULL AND http_referer IS NOT NULL THEN website_sessions.website_session_id ELSE NULL END) AS sessions_recherche_organique,
    COUNT(DISTINCT CASE WHEN utm_source IS NULL AND http_referer IS NULL THEN website_sessions.website_session_id ELSE NULL END) AS sessions_directes
FROM website_sessions
LEFT JOIN orders 
    ON orders.website_session_id = website_sessions.website_session_id
GROUP BY 1, 2;

-- 5. Taux de conversion sessions vers commandes (mensuel)
-- Objectif : Évaluer l'évolution des performances du site au cours des 8 premiers mois.

SELECT
    YEAR(website_sessions.created_at) AS annee,
    MONTH(website_sessions.created_at) AS mois,
    COUNT(DISTINCT website_sessions.website_session_id) AS sessions,
    COUNT(DISTINCT orders.order_id) AS commandes,
    COUNT(DISTINCT orders.order_id) / COUNT(DISTINCT website_sessions.website_session_id) AS taux_conversion
FROM website_sessions
LEFT JOIN orders 
    ON orders.website_session_id = website_sessions.website_session_id
GROUP BY 1, 2;

-- 6. Impact du test GSearch Landing Page sur les revenus
-- Objectif : Évaluer l'impact du test d'une nouvelle page de destination GSearch 
-- (Jun 19 – Jul 28) sur le taux de conversion et les revenus générés.

-- Étape 1 : Trouver l'identifiant du premier test pour la page "/lander-1"
SELECT
    MIN(website_pageview_id) AS premier_test
FROM website_pageviews
WHERE pageview_url = '/lander-1';

-- Étape 2 : Créer une table temporaire pour capturer les sessions de test
CREATE TEMPORARY TABLE first_test_pageviews AS
SELECT
    website_pageviews.website_session_id, 
    MIN(website_pageviews.website_pageview_id) AS id_premiere_page
FROM website_pageviews 
INNER JOIN website_sessions 
    ON website_sessions.website_session_id = website_pageviews.website_session_id
    AND website_sessions.created_at < '2012-07-28'
    AND website_pageviews.website_pageview_id >= 23504 -- ID premier test
    AND utm_source = 'gsearch'
    AND utm_campaign = 'nonbrand'
GROUP BY 
    website_pageviews.website_session_id;

-- Étape 3 : Associer les pages de destination ("/home" ou "/lander-1") pour chaque session
CREATE TEMPORARY TABLE nonbrand_test_sessions_w_landing_pages AS
SELECT 
    first_test_pageviews.website_session_id, 
    website_pageviews.pageview_url AS page_de_destination
FROM first_test_pageviews
LEFT JOIN website_pageviews 
    ON website_pageviews.website_pageview_id = first_test_pageviews.id_premiere_page
WHERE website_pageviews.pageview_url IN ('/home','/lander-1'); 

-- Étape 4 : Associer les commandes aux sessions de test
CREATE TEMPORARY TABLE nonbrand_test_sessions_w_orders AS
SELECT
    nonbrand_test_sessions_w_landing_pages.website_session_id, 
    nonbrand_test_sessions_w_landing_pages.page_de_destination, 
    orders.order_id
FROM nonbrand_test_sessions_w_landing_pages
LEFT JOIN orders 
    ON orders.website_session_id = nonbrand_test_sessions_w_landing_pages.website_session_id;

-- Étape 5 : Calculer les taux de conversion pour chaque page de destination
SELECT
    page_de_destination, 
    COUNT(DISTINCT website_session_id) AS sessions, 
    COUNT(DISTINCT order_id) AS commandes,
    COUNT(DISTINCT order_id)/COUNT(DISTINCT website_session_id) AS taux_conversion
FROM nonbrand_test_sessions_w_orders
GROUP BY 1;

-- Résultat attendu : 
-- Page "/home" : taux de conversion = 3,19 %
-- Page "/lander-1" : taux de conversion = 4,06 %
-- Gain estimé : +0,87 % de conversions par session

-- Étape 6 : Estimer les revenus générés depuis le test
SELECT 
    COUNT(website_session_id) AS sessions_post_test
FROM website_sessions
WHERE created_at < '2012-11-27'
  AND website_session_id > 17145 -- dernière session "/home"
  AND utm_source = 'gsearch'
  AND utm_campaign = 'nonbrand';

-- Résultat attendu : 
-- Nombre de sessions depuis le test : 22 972
-- Gain estimé : 202 commandes incrémentales (~50 par mois)

-- =============================================================================
-- 7. Analyse du Tunnel de Conversion
-- Objectif : Comparer les parcours de conversion entre deux pages de destination.

-- Étape 1 : Identifier les étapes franchies pour chaque session
CREATE TEMPORARY TABLE session_level_made_it_flagged AS
WITH pageview_level AS (
    SELECT
        website_sessions.website_session_id, 
        website_pageviews.pageview_url, 
        MAX(CASE WHEN pageview_url = '/home' THEN 1 ELSE 0 END) AS homepage,
        MAX(CASE WHEN pageview_url = '/lander-1' THEN 1 ELSE 0 END) AS custom_lander,
        MAX(CASE WHEN pageview_url = '/products' THEN 1 ELSE 0 END) AS produits,
        MAX(CASE WHEN pageview_url = '/cart' THEN 1 ELSE 0 END) AS panier,
        MAX(CASE WHEN pageview_url = '/shipping' THEN 1 ELSE 0 END) AS livraison,
        MAX(CASE WHEN pageview_url = '/billing' THEN 1 ELSE 0 END) AS paiement,
        MAX(CASE WHEN pageview_url = '/thank-you-for-your-order' THEN 1 ELSE 0 END) AS confirmation
    FROM website_sessions 
    LEFT JOIN website_pageviews 
        ON website_sessions.website_session_id = website_pageviews.website_session_id
    WHERE website_sessions.utm_source = 'gsearch' 
      AND website_sessions.utm_campaign = 'nonbrand' 
      AND website_sessions.created_at BETWEEN '2012-06-19' AND '2012-07-28'
    GROUP BY 
        website_sessions.website_session_id
)
SELECT * FROM pageview_level;

-- Étape 2 : Analyse du tunnel de conversion complet
SELECT
    CASE 
        WHEN homepage = 1 THEN 'Page d’accueil'
        WHEN custom_lander = 1 THEN 'Page de destination personnalisée'
        ELSE 'Non défini'
    END AS segment, 
    COUNT(DISTINCT website_session_id) AS sessions_total,
    COUNT(DISTINCT CASE WHEN produits = 1 THEN website_session_id ELSE NULL END) AS vers_produits,
    COUNT(DISTINCT CASE WHEN panier = 1 THEN website_session_id ELSE NULL END) AS vers_panier,
    COUNT(DISTINCT CASE WHEN livraison = 1 THEN website_session_id ELSE NULL END) AS vers_livraison,
    COUNT(DISTINCT CASE WHEN paiement = 1 THEN website_session_id ELSE NULL END) AS vers_paiement,
    COUNT(DISTINCT CASE WHEN confirmation = 1 THEN website_session_id ELSE NULL END) AS vers_confirmation
FROM session_level_made_it_flagged
GROUP BY 1;

-- Résultat attendu : Comparaison des étapes franchies par segment

-- =============================================================================
-- 8. Impact du test de page de paiement
-- Objectif : Quantifier l'augmentation des revenus générée par une nouvelle page de paiement.

WITH billing_pageviews_and_order_data AS (
    SELECT 
        website_pageviews.website_session_id, 
        website_pageviews.pageview_url AS version_paiement, 
        orders.order_id, 
        orders.price_usd
    FROM website_pageviews 
    LEFT JOIN orders
        ON orders.website_session_id = website_pageviews.website_session_id
    WHERE website_pageviews.created_at BETWEEN '2012-09-10' AND '2012-11-10'
      AND website_pageviews.pageview_url IN ('/billing', '/billing-2')
)
SELECT
    version_paiement, 
    COUNT(DISTINCT website_session_id) AS sessions, 
    SUM(price_usd) / COUNT(DISTINCT website_session_id) AS revenu_par_session
FROM billing_pageviews_and_order_data
GROUP BY version_paiement;

-- Résultat attendu :
-- Version initiale : 22,83 $/session
-- Nouvelle version : 31,34 $/session
-- Gain estimé : +8,51 $ par session
