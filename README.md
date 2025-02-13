```markdown
# 📘 Application de Gestion des Notes 🎓

## 📌 Description
Cette application est un projet JEE conçu pour gérer les notes des étudiants dans un environnement académique. Elle offre des fonctionnalités avancées pour l'administration, les enseignants et les étudiants.

## 🚀 Fonctionnalités Principales
- 🔐 **Authentification sécurisée** (Administrateurs & Professeurs)
- 🏫 **Gestion des utilisateurs** (Ajout, modification, suppression)
- 📚 **Gestion des modules et éléments pédagogiques**
- 📝 **Saisie et validation des notes**
- 📊 **Calcul automatique des moyennes et résultats**
- 📄 **Exportation des notes au format PDF**
- 🛡️ **Sécurité des accès avec Spring Security**

## 🏗️ Architecture
L’application repose sur une architecture en couches utilisant **Spring Boot** :
- **Vue (JSP + Bootstrap)** : Interface utilisateur moderne et responsive.
- **Contrôleur (Spring MVC)** : Gère les requêtes HTTP et la logique métier.
- **Service (Spring Services)** : Implémente les règles métiers.
- **Persistance (Spring Data JPA)** : Interaction avec la base de données.
- **Sécurité (Spring Security)** : Gestion des rôles et accès.

## 🛠️ Technologies Utilisées
- **Backend** : Java EE, Spring Boot, Spring Data JPA
- **Frontend** : JSP, Bootstrap, JavaScript
- **Base de données** : MySQL avec Hibernate
- **Sécurité** : Spring Security pour la gestion des rôles

## 📂 Structure du Projet
```
📦 GestionNotesApp
 ┣ 📂 src
 ┃ ┣ 📂 main
 ┃ ┃ ┣ 📂 java
 ┃ ┃ ┃ ┣ 📂 controllers
 ┃ ┃ ┃ ┣ 📂 services
 ┃ ┃ ┃ ┣ 📂 repositories
 ┃ ┃ ┣ 📂 resources
 ┃ ┃ ┃ ┣ 📂 templates (JSP)
 ┃ ┃ ┃ ┣ application.properties
 ┣ 📂 database
 ┃ ┣ schema.sql
 ┣ 📜 README.md
 ┣ 📜 pom.xml
```

## 📸 Captures d'Écran
![Dashboard Administrateur](./screenshots/admin_dashboard.png)
![Saisie des Notes](./screenshots/note_entry.png)

## 🏁 Installation & Exécution
### 1️⃣ Prérequis
- Java 17+
- MySQL
- Maven

### 2️⃣ Cloner le Projet
```bash
git clone https://github.com/votre-repo/GestionNotesApp.git
cd GestionNotesApp
```

### 3️⃣ Configurer la Base de Données
Créer une base de données MySQL :
```sql
CREATE DATABASE gestion_notes;
```
Mettre à jour `application.properties` avec vos identifiants MySQL.

### 4️⃣ Lancer l’Application
```bash
mvn spring-boot:run
```
Accéder à l’interface : `http://localhost:8080`

## 📜 Licence
Ce projet est sous licence MIT. 

---
👨‍💻 *Développé par :* **MALHOUNI YOUNESS**  
🎓 *Encadré par :* **Pr. GHERABI Noreddine**  
```

---
