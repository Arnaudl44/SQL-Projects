# 📊 Marketing & Conversion Optimization Analysis

Ce projet analyse les performances marketing, le trafic sur le site web et les taux de conversion pour fournir des insights exploitables, améliorer les performances et identifier des opportunités de croissance.

---

## 🛠️ Outils utilisés
- **Base de données** : MySQL  
- **Environnement de travail** : MySQL Workbench  
- **Adaptations techniques** :  
  En raison des multiples tables de données, une approche structurée a été nécessaire pour relier et nettoyer les données afin d’assurer des résultats fiables.

---

## 📋 Objectifs principaux
Le projet est organisé autour de **8 sections principales**, chacune abordant une question spécifique :

1. **Tendances mensuelles des sessions et commandes GSearch**  
   - Analyse des sessions et commandes issues de GSearch pour observer leur évolution dans le temps.

2. **Analyse des campagnes Brand et Nonbrand**  
   - Comparaison des performances des campagnes "Brand" et "Nonbrand" sur GSearch.

3. **Analyse par type d'appareil pour les campagnes GSearch Nonbrand**  
   - Évaluation des sessions et commandes de campagnes Nonbrand selon les types d'appareils (desktop et mobile).

4. **Comparaison des tendances mensuelles sur les canaux de trafic**  
   - Analyse des canaux de trafic : GSearch, BSearch, recherche organique, et visites directes.

5. **Analyse des taux de conversion mensuels**  
   - Examen des taux de conversion session-commande pour tous les canaux de trafic.

6. **Impact du test de la page de destination GSearch sur le revenu**  
   - Évaluation des revenus supplémentaires générés par un test de page de destination sur GSearch.

7. **Analyse complète du tunnel de conversion pour les pages de destination GSearch**  
   - Suivi du tunnel de conversion complet pour deux pages de destination différentes.

8. **Impact du test de page de facturation sur le revenu**  
   - Quantification de l'augmentation des revenus suite à un test de modification de la page de facturation.

---

## 📊 Insights clés

1. **Renforcer les campagnes Brand**  
   - Les campagnes "Brand" montrent une forte croissance, indiquant une bonne reconnaissance de la marque. Continuer à investir dans ce segment pour maximiser les retombées.

2. **Améliorer l'expérience utilisateur sur mobile**  
   - Les conversions sur mobile restent légèrement inférieures à celles sur desktop. Optimiser les pages pour mobile pourrait augmenter le taux de conversion.

3. **Exploiter les tests réussis des pages de destination et de facturation**  
   - Étendre les modifications réussies (ex. : page de facturation et landing page) à d'autres sections pour accroître les revenus.

4. **Capitaliser sur les produits à fort potentiel**  
   - Les nouveaux produits montrent de bonnes synergies (cross-sell). Développer des offres groupées ou recommandations personnalisées.

5. **Anticiper les périodes de forte demande**  
   - Les données montrent des pics saisonniers. Lancer des campagnes ciblées pendant ces périodes pour maximiser les ventes.

---

## 📁 Structure des fichiers

- **`Marketing_Analysis.sql`** :  
  Ce fichier regroupe les 8 sections du projet, correspondant à chaque question clé.  
  - Structuré avec des commentaires détaillés expliquant chaque étape des requêtes SQL utilisées.

---

## 🗂️ Données

### **Tables principales**
- `website_sessions` : Informations sur les sessions utilisateur (source, type d'appareil, etc.).  
- `orders` : Commandes et revenus associés.  
- `website_pageviews` : Données sur les pages visitées par les utilisateurs.  
- `order_items` : Détails des produits commandés (prix, marge, etc.).

### **Période couverte**  
De **2012 à 2015**  

### **Attributs principaux**  
Sources de trafic, type d’appareil, commandes, sessions, campagnes marketing.

---
