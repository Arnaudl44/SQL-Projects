# Marketing & Conversion Optimization Analysis

Ce projet analyse les performances marketing, le trafic sur le site web et les taux de conversion afin de fournir des insights exploitables pour améliorer les performances et identifier les opportunités de croissance.

## 🛠️ Outils utilisés
- **Base de données** : MySQL  
- **Environnement de travail** : MySQL Workbench  
- **Adaptations techniques** :  
  En raison des multiples tables de données, une approche structurée a été nécessaire pour relier et nettoyer les données afin d’assurer des résultats fiables.

## 📋 Objectifs principaux
Le projet est organisé autour de 8 sections principales, chacune abordant une question spécifique de l’analyse marketing :

1. **Tendances mensuelles des sessions et commandes GSearch**  
   Analyse des sessions et commandes issues de GSearch pour observer leur évolution dans le temps.

2. **Analyse des campagnes Brand et Nonbrand**  
   Comparaison des performances des campagnes "Brand" et "Nonbrand" sur GSearch.

3. **Analyse par type d'appareil pour les campagnes GSearch Nonbrand**  
   Évaluation des sessions et commandes de campagnes Nonbrand selon les types d'appareils (desktop et mobile).

4. **Comparaison des tendances mensuelles sur les canaux de trafic**  
   Analyse des canaux de trafic : GSearch, BSearch, recherche organique, et visites directes.

5. **Analyse des taux de conversion mensuels**  
   Examen des taux de conversion session-commande pour tous les canaux de trafic.

6. **Impact du test de la page de destination GSearch sur le revenu**  
   Évaluation des revenus supplémentaires générés par un test de page de destination sur GSearch.

7. **Analyse complète du tunnel de conversion pour les pages de destination GSearch**  
   Suivi du tunnel de conversion complet pour deux pages de destination différentes.

8. **Impact du test de page de facturation sur le revenu**  
   Quantification de l'augmentation des revenus suite à un test de modification de la page de facturation.

## 📊 Insights clés
- **Canaux de trafic** :
  - GSearch est la principale source de sessions et de commandes, avec des performances croissantes.
  - Les campagnes "Brand" montrent une tendance à la hausse, indiquant une forte reconnaissance de marque.
- **Taux de conversion** :
  - Le test de la nouvelle page de destination GSearch a amélioré le taux de conversion de 8,7 %, générant 202 commandes supplémentaires sur 4 mois.
  - La nouvelle page de facturation a augmenté les revenus de 8,51 $ par session de facturation, représentant un gain mensuel de 10 160 $.
- **Performance par appareil** :
  - Les campagnes Nonbrand GSearch sur mobile affichent des taux de conversion légèrement inférieurs à ceux des appareils desktop, bien que les volumes soient en croissance rapide.

## 📁 Structure des fichiers
Le projet est centralisé dans un seul fichier SQL :

- **`Marketing_Analysis.sql`** :  
  Ce fichier regroupe les 8 sections du projet, correspondant à chaque question clé. Il est structuré avec des commentaires détaillés expliquant les étapes des requêtes SQL utilisées.

## 🗂️ Données
- **Tables principales** :  
  - `website_sessions` : Informations sur les sessions utilisateur (source, type d'appareil, etc.).  
  - `orders` : Commandes et revenus associés.  
  - `website_pageviews` : Données sur les pages visitées par les utilisateurs.  
  - `order_items` : Détails des produits commandés (prix, marge, etc.).

- **Période couverte** : De 2012 à 2015  
- **Attributs principaux** : Sources de trafic, type d’appareil, commandes, sessions, campagnes marketing.

---

Ce projet met en œuvre des techniques avancées d'analyse SQL pour tirer parti des données marketing et fournir des recommandations exploitables basées sur les résultats obtenus.
