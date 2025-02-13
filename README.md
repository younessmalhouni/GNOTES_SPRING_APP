# 📘 GNotes - Application de Gestion des Notes Universitaires

## 📌 Description
GNotes est une application web développée en **Spring Boot** permettant la gestion des notes des étudiants dans un cadre académique. Elle offre une interface intuitive pour les administrateurs et professeurs, permettant la gestion des étudiants, modules, évaluations et résultats.

## 🚀 Fonctionnalités Principales
- 🔐 **Authentification sécurisée** (Spring Security - Administrateurs & Professeurs)
- 🏫 **Gestion des utilisateurs** (CRUD : Ajout, Modification, Suppression)
- 📚 **Gestion des modules et éléments pédagogiques**
- 📝 **Saisie et validation des notes**
- 📊 **Calcul automatique des moyennes et résultats**
- 📄 **Exportation des notes au format PDF**
- 🛡️ **Sécurisation des accès avec Spring Security**

## 🏗️ Architecture
L'application repose sur une architecture MVC bien structurée avec **Spring Boot** :
- **Vue (JSP + Bootstrap)** : Interface utilisateur moderne et responsive.
- **Contrôleur (Spring MVC)** : Gère les requêtes HTTP et la logique métier.
- **Service Layer** : Implémente les règles métiers.
- **Persistance (Spring Data JPA, Hibernate)** : Interaction avec la base de données MySQL.
- **Sécurité (Spring Security)** : Gestion des rôles et authentification.


  ![image](https://github.com/user-attachments/assets/b4d635a2-41fe-4651-853b-0e8b496ef92e)



## 🛠️ Technologies Utilisées
- **Backend** : Java EE, Spring Boot, Spring Security, Hibernate
- **Frontend** : JSP, Bootstrap, JavaScript
- **Base de données** : MySQL
- **Gestion de dépendances** : Maven

  ![image](https://github.com/user-attachments/assets/c1410224-3d3c-479d-a4e5-1b3402ad7746)


## 📂 Structure du Projet
```
📦 GNotes_SPRING_APP
 ┣ 📂 src/main/java/com/example/GNotesAPP12
 ┃ ┣ 📂 Config (Configuration de sécurité, AuthenticationFilter)
 ┃ ┣ 📂 Controller (Gestion des utilisateurs, modules, notes...)
 ┃ ┣ 📂 Service (Logique métier)
 ┃ ┣ 📂 Repository (Accès aux données avec JPA/Hibernate)
 ┃ ┣ 📂 Model (Entités du projet)
 ┣ 📂 src/main/resources (Templates JSP, fichiers de configuration)
 ┣ 📜 pom.xml (Dépendances Maven)
 ┣ 📜 README.md (Documentation)
```

## 📸 Captures d'Écran
_Ajoutez ici des captures d'écran pour illustrer l'interface_

## 🏁 Installation & Exécution
### 1️⃣ Prérequis
- Java 17+
- MySQL
- Maven

### 2️⃣ Cloner le Projet
```bash
git clone https://github.com/votre-repo/GNotes_SPRING_APP.git
cd GNotes_SPRING_APP
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

