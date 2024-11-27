# Analyse des prénoms aux États-Unis

Ce projet explore les tendances de popularité des prénoms aux États-Unis sur plusieurs décennies, en s'appuyant sur une base de données volumineuse contenant des informations sur les naissances et les prénoms. L'objectif principal est d'extraire des insights clairs et intéressants sur les préférences en matière de prénoms, tout en mettant en œuvre des requêtes SQL avancées.

---

## 🛠️ **Outils utilisés**
- **Base de données :** MySQL  
- **Environnement de travail :** MySQL Workbench  
- **Adaptations techniques :**
  - En raison de la grande taille du fichier source, des optimisations ont été nécessaires, notamment l'utilisation du terminal pour importer les données avec des commandes MySQL spécifiques.

---

## 📋 **Objectifs principaux**
Le projet est organisé autour de **4 objectifs principaux**, chacun accompagné de ses requêtes SQL correspondantes :
1. **Suivre les changements de popularité des prénoms.**  
   _Exemple : Identifier les prénoms les plus populaires sur plusieurs décennies (Michael et Jessica) et observer leur évolution dans le temps._
2. **Comparer la popularité des prénoms par décennies.**  
   _Exemple : Trouver les prénoms les plus donnés dans les années 1980, 1990 et 2000._
3. **Comparer la popularité par régions.**  
   _Exemple : Identifier les prénoms dominants dans différentes régions géographiques des États-Unis._
4. **Explorer les prénoms uniques.**  
   _Exemple : Identifier les prénoms androgynes (utilisés pour les garçons et les filles) et analyser les tendances des prénoms courts et longs._

---

## 📊 **Insights clés**
- **Prénoms les plus populaires :**
  - Chez les hommes : **Michael** domine largement les classements.
  - Chez les femmes : **Jessica** est restée un prénom phare sur plusieurs années.
- **Tendances androgynes :**
  - Certains prénoms, comme **Jordan** et **Taylor**, sont communs aux deux genres.
- **Prénoms courts et longs :**
  - Les prénoms les plus courts (2 lettres) incluent des noms comme **Jo**.  
  - Les prénoms les plus longs (15 lettres) incluent des prénoms comme **Maximiliano**.
- **Régions :**
  - Les préférences régionales varient énormément, avec des tendances marquées selon les zones géographiques (par exemple, le prénom **Chris** est particulièrement populaire dans certains États spécifiques).

---

## 📁 **Structure des fichiers**
Le projet est organisé en plusieurs fichiers SQL, regroupés par objectif :
- `objective1_track_popularity.sql` : Analyse des changements de popularité des prénoms.
- `objective2_compare_decades.sql` : Comparaison des prénoms populaires par décennies.
- `objective3_compare_regions.sql` : Comparaison des prénoms populaires par région.
- `objective4_explore_unique_names.sql` : Exploration des prénoms uniques.

Chaque fichier contient des requêtes détaillées et documentées pour répondre à l'objectif correspondant.

---

## 🗂️ **Données**
- **Période couverte :** 1980 à 2009  
- **Attributs principaux :** Nom, genre, année, nombre de naissances, État, et région géographique.

---

