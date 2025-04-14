# 📘 GNotes - University Grade Management Application

## 📌 Description

GNotes is a web application developed with **Spring Boot** for managing student grades in an academic setting. It provides an intuitive interface for administrators and professors, enabling the management of students, modules, assessments, and results.

## 🚀 Key Features

- 🔐 **Secure Authentication** (Spring Security - Administrators & Professors)
- 🏫 **User Management** (CRUD: Add, Edit, Delete)
- 📚 **Module and Course Management**
- 📝 **Grade Entry and Validation**
- 📊 **Automatic Calculation of Averages and Results**
- 📄 **Export Grades to PDF**
- 🛡️ **Access Security with Spring Security**

## 🏗️ Architecture

The application follows a well-structured **MVC architecture** using **Spring Boot**:

- **View (JSP + Bootstrap)**: Modern and responsive user interface.
- **Controller (Spring MVC)**: Handles HTTP requests and business logic.
- **Service Layer**: Implements business rules.
- **Persistence (Spring Data JPA, Hibernate)**: Interacts with the MySQL database.
- **Security (Spring Security)**: Manages roles and authentication.

![image](https://github.com/user-attachments/assets/b4d635a2-41fe-4651-853b-0e8b496ef92e)



## 🛠️ Technologies Used

- **Backend**: Java EE, Spring Boot, Spring Security, Hibernate
- **Frontend**: JSP, Bootstrap, JavaScript
- **Database**: MySQL
- **Dependency Management**: Maven
  
![image](https://github.com/user-attachments/assets/c1410224-3d3c-479d-a4e5-1b3402ad7746)


## 📂 Project Structure

```
📦 GNotes_SPRING_APP
 ┣ 📂 src/main/java/com/example/GNotesAPP12
 ┃ ┣ 📂 Config (Security configuration, AuthenticationFilter)
 ┃ ┣ 📂 Controller (User, Module, Grade management, etc.)
 ┃ ┣ 📂 Service (Business logic)
 ┃ ┣ 📂 Repository (Data access using JPA/Hibernate)
 ┃ ┣ 📂 Model (Project entities)
 ┣ 📂 src/main/resources (JSP templates, configuration files)
 ┣ 📜 pom.xml (Maven dependencies)
 ┣ 📜 README.md (Documentation)
```

## 📸 Screenshots
![image](https://github.com/user-attachments/assets/995e7fa8-2afe-4810-9830-58e1cc230e4f)

![image](https://github.com/user-attachments/assets/bf0215bd-84ad-4901-a6af-1d8982cacf9c)

![image](https://github.com/user-attachments/assets/79d724c4-75e2-4705-96c0-445a35184dad)

![image](https://github.com/user-attachments/assets/c79ec7d2-1b5d-48d0-82f0-be218790bc12)

![image](https://github.com/user-attachments/assets/909e4369-1659-4b1c-a6e7-4f13aa525036)




## 🏁 Installation & Execution

### 1️⃣ Prerequisites

- Java 17+
- XAMPP (or an equivalent tool)
- phpMyAdmin (or an equivalent database management tool)
- Maven

### 2️⃣ Clone the Project

```bash
git clone https://github.com/younessmalhouni/GNOTES_SPRING_APP.git
cd GNotes_SPRING_APP
```

### 3️⃣ Setting Up the Database

1. **Install and Run XAMPP** (or an equivalent tool) to start the MySQL server.
2. Open **phpMyAdmin** (or an equivalent database management tool).
3. Create a new database:

```sql
CREATE DATABASE gestion_notes;sql
CREATE DATABASE gestion_notes;
```

4. Update `application.properties` with your credentials in the following format:

```properties
spring.application.name=GNotesAPP12
server.port=8082
spring.datasource.url=jdbc:mysql://localhost:3306/gestion_notes
spring.datasource.username=your_username
spring.datasource.password=your_password
spring.jpa.hibernate.ddl-auto=update
```

### 3️⃣ Clone the Project

```bash
git clone https://github.com/your-repo/GNotes_SPRING_APP.git
cd GNotes_SPRING_APP
```

### 4️⃣ Run the Application

```bash
mvn spring-boot:run
```

Access the interface at: `http://localhost:8082`

---

Pour plus de détails sur ce projet, veuillez consulter le rapport complet :

[📘 Rapport_Projet__Application_pour_la_gestion_des_notes.pdf](Rapport_Projet__Application_pour_la_gestion_des_notes.pdf)


👨‍💻 *Developed by:* **[Youness Malhouni](https://www.linkedin.com/in/youness-malhouni/)**\


