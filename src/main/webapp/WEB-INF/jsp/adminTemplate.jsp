<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>GNotes - Tableau de Bord Administrateur</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
  <style>
    :root {
      --primary-gradient: linear-gradient(45deg, #2980b9, #2c3e50);
      --secondary-gradient: linear-gradient(45deg, #3498db, #2980b9);
      --card-shadow: 0 8px 25px rgba(52, 152, 219, 0.4);
      --transition: all 0.3s ease;
    }

    body {
      background-color: #f5f7fa;
      min-height: 100vh;
      font-family: 'Segoe UI', sans-serif;
    }

    .dashboard-container {
      padding: 2rem;
      max-width: 1400px;
      margin: 0 auto;
    }

    .welcome-section {
      background: var(--primary-gradient);
      border-radius: 20px;
      padding: 3.5rem 2rem;
      margin-bottom: 3rem;
      position: relative;
      overflow: hidden;
      box-shadow: var(--card-shadow);
    }

    .welcome-section::after {
      content: '';
      position: absolute;
      top: 0;
      right: 0;
      bottom: 0;
      width: 40%;
      background: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 100 100'%3E%3Cpath fill='%23ffffff' fill-opacity='0.1' d='M10 10h10v10H10zM30 10h10v10H30zM50 10h10v10H50zM70 10h10v10H70zM90 10h10v10H90zM0 30h10v10H0zM20 30h10v10H20zM40 30h10v10H40zM60 30h10v10H60zM80 30h10v10H80z'/%3E%3C/svg%3E");
      opacity: 0.1;
      transform: rotate(-15deg) scale(3);
    }

    .welcome-text {
      color: white;
      font-size: 2.8rem;
      font-weight: 700;
      text-shadow: 0 2px 10px rgba(0,0,0,0.2);
    }

    .welcome-subtext {
      color: rgba(255,255,255,0.9);
      font-size: 1.2rem;
      font-weight: 500;
    }

    .stats-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
      gap: 1.5rem;
      margin-bottom: 3rem;
    }

    .stat-card {
      background: white;
      border-radius: 16px;
      padding: 1.5rem;
      display: flex;
      align-items: center;
      transition: var(--transition);
      box-shadow: 0 4px 15px rgba(0,0,0,0.05);
    }

    .stat-card:hover {
      transform: translateY(-5px);
      box-shadow: var(--card-shadow);
    }

    .stat-icon {
      width: 60px;
      height: 60px;
      border-radius: 12px;
      background: var(--secondary-gradient);
      display: flex;
      align-items: center;
      justify-content: center;
      margin-right: 1rem;
    }

    .stat-icon i {
      font-size: 1.8rem;
      color: white;
    }

    .stat-info h3 {
      font-size: 1.8rem;
      font-weight: 700;
      margin: 0;
      background: var(--primary-gradient);
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
    }

    .stat-info p {
      color: #64748b;
      margin: 0;
      font-weight: 500;
    }

    .features-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
      gap: 1.5rem;
    }

    .feature-card {
      background: white;
      border-radius: 16px;
      padding: 2rem;
      transition: var(--transition);
      border: 1px solid rgba(52, 152, 219, 0.1);
      position: relative;
      overflow: hidden;
    }

    .feature-card::before {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      height: 4px;
      background: var(--primary-gradient);
      transform: scaleX(0);
      transition: var(--transition);
    }

    .feature-card:hover {
      transform: translateY(-8px);
      box-shadow: var(--card-shadow);
    }

    .feature-card:hover::before {
      transform: scaleX(1);
    }

    .feature-icon {
      font-size: 2.5rem;
      margin-bottom: 1.5rem;
      background: var(--primary-gradient);
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
      display: inline-block;
    }

    .feature-title {
      font-size: 1.4rem;
      font-weight: 600;
      color: #1e293b;
      margin-bottom: 1rem;
    }

    .feature-text {
      color: #64748b;
      margin-bottom: 1.5rem;
      line-height: 1.6;
    }

    .btn-feature {
      background: var(--primary-gradient);
      color: white;
      border: none;
      border-radius: 12px;
      padding: 0.8rem 1.5rem;
      font-weight: 500;
      transition: var(--transition);
      width: 100%;
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 0.5rem;
    }

    .btn-feature:hover {
      transform: translateY(-2px);
      box-shadow: 0 8px 25px rgba(52, 152, 219, 0.4);
      color: white;
    }

    @media (max-width: 768px) {
      .dashboard-container {
        padding: 1rem;
      }

      .welcome-text {
        font-size: 2rem;
      }

      .stat-card {
        flex-direction: column;
        text-align: center;
      }

      .stat-icon {
        margin: 0 0 1rem 0;
      }
    }
  </style>
</head>
<body>
<jsp:include page="header.jsp" />

<div class="dashboard-container">
  <div class="welcome-section text-center">
    <h1 class="welcome-text mb-2">Bienvenue, ${nomUtilisateur}</h1>
    <p class="welcome-subtext mb-0">Votre centre de gestion académique</p>
  </div>

  <div class="stats-grid">
    <div class="stat-card">
      <div class="stat-icon">
        <i class="fas fa-chalkboard-teacher"></i>
      </div>
      <div class="stat-info">
        <h3><c:out value="${totalProfesseurs}" default="0"/></h3>
        <p>Professeurs</p>
      </div>
    </div>

    <div class="stat-card">
      <div class="stat-icon">
        <i class="fas fa-user-graduate"></i>
      </div>
      <div class="stat-info">
        <h3><c:out value="${totalEtudiants}" default="0"/></h3>
        <p>Étudiants</p>
      </div>
    </div>

    <div class="stat-card">
      <div class="stat-icon">
        <i class="fas fa-book"></i>
      </div>
      <div class="stat-info">
        <h3><c:out value="${totalModules}" default="0"/></h3>
        <p>Modules</p>
      </div>
    </div>

    <div class="stat-card">
      <div class="stat-icon">
        <i class="fas fa-stream"></i>
      </div>
      <div class="stat-info">
        <h3><c:out value="${totalFillieres}" default="0"/></h3>
        <p>Filières</p>
      </div>
    </div>
  </div>

  <div class="features-grid">
    <div class="feature-card">
      <i class="fas fa-chalkboard-teacher feature-icon"></i>
      <h5 class="feature-title">Gestion des Professeurs</h5>
      <p class="feature-text">Gérez efficacement les enseignants et leurs attributions de cours</p>
      <button class="btn btn-feature" onclick="location.href='${pageContext.request.contextPath}/professeurs'">
        Accéder <i class="fas fa-arrow-right"></i>
      </button>
    </div>

    <div class="feature-card">
      <i class="fas fa-book feature-icon"></i>
      <h5 class="feature-title">Gestion des Modules</h5>
      <p class="feature-text">Organisez et mettez à jour les modules de cours</p>
      <button class="btn btn-feature" onclick="location.href='${pageContext.request.contextPath}/modules'">
        Accéder <i class="fas fa-arrow-right"></i>
      </button>
    </div>

    <div class="feature-card">
      <i class="fas fa-stream feature-icon"></i>
      <h5 class="feature-title">Gestion des Filières</h5>
      <p class="feature-text">Gérez les départements et les parcours académiques</p>
      <button class="btn btn-feature" onclick="location.href='${pageContext.request.contextPath}/fillieres'">
        Accéder <i class="fas fa-arrow-right"></i>
      </button>
    </div>

    <div class="feature-card">
      <i class="fas fa-user-graduate feature-icon"></i>
      <h5 class="feature-title">Gestion des Étudiants</h5>
      <p class="feature-text">Suivez les progrès et les dossiers des étudiants</p>
      <button class="btn btn-feature" onclick="location.href='${pageContext.request.contextPath}/etudiants'">
        Accéder <i class="fas fa-arrow-right"></i>
      </button>
    </div>

    <div class="feature-card">
      <i class="fas fa-cube feature-icon"></i>
      <h5 class="feature-title">Gestion des Éléments</h5>
      <p class="feature-text">Gérez les éléments constitutifs des modules</p>
      <button class="btn btn-feature" onclick="location.href='${pageContext.request.contextPath}/elements'">
        Accéder <i class="fas fa-arrow-right"></i>
      </button>
    </div>


  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>