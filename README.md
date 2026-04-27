# 🥘 ZeroWaste — Application Mobile d'Assistance Culinaire

> Application mobile proposant des recettes marocaines personnalisées selon les ingrédients disponibles, dans une démarche de réduction du gaspillage alimentaire.

---

## 📌 Objectif du projet

**ZeroWaste** est une application mobile d'assistance culinaire qui aide les utilisateurs à :

- 🥦 Cuisiner avec les ingrédients déjà présents dans leur frigo
- 🍲 Recevoir des suggestions de recettes marocaines personnalisées (Tagine, Couscous, Pastilla...)
- 📋 Suivre des instructions de préparation claires et détaillées
- ♻️ Réduire le gaspillage alimentaire au quotidien


---

## 👥 Membres de l'équipe

| Nom | Rôle |
|-----|------|
| Ziri Aziza | Product Owner — Responsable du backlog et de la valeur métier |
| Khalil Basma | Scrum Master — Garant du respect du cadre agile |
| Zligui Fatima Zahra | Développeuse Full-Stack — Développement et intégration |
| IGHOUMRANE Youssef | Développeure Full-Stack — Développement et intégration

**Encadrante :** Pr. HIBA ASRI  
**Formation :** Master Ingénierie des Systèmes d'Information – S2  
**Université :** Université Cadi Ayyad – Faculté des Sciences Semlalia, Marrakech  
**Année universitaire :** 2025–2026

---

## ⚙️ Stack Technique

| Couche | Technologie |
|--------|-------------|
| Frontend (Mobile) | Flutter |
| Backend | Laravel (PHP) — API REST |
| Base de données | MySQL (ORM Eloquent) |
| CI/CD | GitHub Actions |
| Gestion de projet | Jira (SCRUM) + GitHub |

---

## 🚀 Fonctionnalités principales

### 👤 Utilisateur
- ✅ Création de compte et connexion sécurisée
- ✅ Sélection des ingrédients disponibles (Mon Frigo)
- ✅ Suggestion automatique de recettes marocaines compatibles
- ✅ Filtrage des recettes par niveau de difficulté (Facile / Moyen / Difficile)
- ✅ Indicateur « Ingrédients manquants » par recette
- ✅ Suivi d'une recette étape par étape
- ✅ Consultation des informations nutritionnelles
- ✅ Gestion des recettes favorites
- ✅ Modification du profil (nom, email, mot de passe)
- ✅ Déconnexion sécurisée

### 🔧 Administrateur
- ✅ Ajout et gestion des recettes marocaines
- ✅ Consultation des statistiques de fréquentation

---

## 🏗️ Architecture de l'application

```
ZeroWaste/
├── frontend/          # Application Flutter (mobile)
│   ├── lib/
│   └── ...
├── backend/           # API Laravel (PHP)
│   ├── app/
│   ├── routes/
│   └── ...
├── .github/
│   └── workflows/
│       └── ci.yml     # GitHub Actions CI/CD
└── README.md
```

L'application suit une architecture **Client-Serveur** :
- Le **frontend Flutter** communique avec le backend via des **API REST**
- Le **backend Laravel** gère la logique métier, l'authentification (tokens) et l'accès à la base de données **MySQL**

---

## 📅 Organisation SCRUM

Le projet est organisé en **4 sprints de 2 semaines** (durée totale : 2 mois) :

| Sprint | Objectif | Statut |
|--------|----------|--------|
| Sprint 0 | Initialisation — cahier des charges, UML, maquettes, stack technique | ✅ Done |
| Sprint 1 | MVP — authentification, sélection ingrédients, suggestions de recettes | ✅ Done |
| Sprint 2 | Amélioration — infos nutritionnelles, profil, déconnexion | 🔄 En cours |
| Sprint 3 | Fonctionnalités intelligentes — favoris, notifications, admin | 🔜 À venir |
| Sprint 4 | Finalisation — tests fonctionnels et de sécurité, livraison | 🔜 À venir |

---

## 🔧 Installation et lancement

### Prérequis
- Flutter SDK installé
- PHP >= 8.x et Composer
- MySQL

### Backend (Laravel)
```bash
cd backend
composer install
cp .env.example .env
php artisan key:generate
php artisan migrate --seed
php artisan serve
```

### Frontend (Flutter)
```bash
cd frontend
flutter pub get
flutter run
```

---

## 🌿 Branches Git

| Branche | Description |
|---------|-------------|
| `main` | Branche stable de production |
| `develop` | Branche d'intégration principale |
| `feature/SCRUM-XX-nom-us` | Branche par User Story |

---

