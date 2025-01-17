<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Tableau de bord - Professeur</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
  <style>
    :root {
      --primary-color: #2980b9;
      --secondary-color: #2c3e50;
      --background-color: #f8f9fa;
      --card-background: #ffffff;
      --text-primary: #2c3e50;
      --text-secondary: #666;
      --transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
      --spacing-unit: 1rem;
    }

    body {
      background-color: var(--background-color);
      padding-top: 100px;
      font-family: 'Segoe UI', system-ui, -apple-system, sans-serif;
    }

    .dashboard-container {
      max-width: 1400px;
      margin: 0 auto;
      padding: 0 var(--spacing-unit);
    }

    /* Welcome Section Styling */
    .welcome-section {
      background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
      border-radius: 20px;
      padding: 2rem;
      margin-bottom: 2.5rem;
      color: white;
      box-shadow: 0 10px 20px rgba(41, 128, 185, 0.15);
    }

    .welcome-text {
      font-size: 2rem;
      font-weight: 700;
      margin-bottom: 0.5rem;
    }

    /* Stats Cards Styling */
    .stats-container {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
      gap: 1.5rem;
      margin-bottom: 2.5rem;
    }

    .stats-card {
      background: var(--card-background);
      border-radius: 16px;
      padding: 1.5rem;
      box-shadow: 0 8px 16px rgba(0, 0, 0, 0.08);
      transition: var(--transition);
      border: 1px solid rgba(0, 0, 0, 0.05);
    }

    .stats-card:hover {
      transform: translateY(-5px);
      box-shadow: 0 12px 24px rgba(41, 128, 185, 0.12);
    }

    .stats-number {
      font-size: 2.5rem;
      font-weight: 700;
      background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
      line-height: 1.2;
    }

    .stats-label {
      color: var(--text-secondary);
      font-size: 1rem;
      margin-top: 0.5rem;
      font-weight: 500;
    }

    /* Main Dashboard Cards */
    .dashboard-cards-container {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
      gap: 2rem;
      margin-bottom: 2.5rem;
    }

    .dashboard-card {
      background: var(--card-background);
      border-radius: 20px;
      border: 1px solid rgba(0, 0, 0, 0.05);
      box-shadow: 0 10px 20px rgba(0, 0, 0, 0.08);
      transition: var(--transition);
      height: 100%;
      min-height: 300px;
      overflow: hidden;
    }

    .dashboard-card:hover {
      transform: translateY(-5px);
      box-shadow: 0 15px 30px rgba(41, 128, 185, 0.15);
    }

    .card-body {
      padding: 2rem;
      display: flex;
      flex-direction: column;
      justify-content: space-between;
      height: 100%;
    }

    .dashboard-icon {
      font-size: 3rem;
      margin-bottom: 1.5rem;
      color: var(--primary-color);
      transition: var(--transition);
    }

    .dashboard-card:hover .dashboard-icon {
      transform: scale(1.1) rotate(-5deg);
    }

    .card-title {
      font-size: 1.5rem;
      font-weight: 600;
      color: var(--text-primary);
      margin-bottom: 1rem;
    }

    .card-text {
      color: var(--text-secondary);
      font-size: 1.1rem;
      line-height: 1.6;
      margin-bottom: 1.5rem;
    }

    .dashboard-btn {
      background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
      border: none;
      padding: 1rem 2rem;
      border-radius: 12px;
      color: white;
      font-weight: 500;
      text-decoration: none;
      transition: var(--transition);
      display: inline-flex;
      align-items: center;
      justify-content: center;
      gap: 0.5rem;
    }

    .dashboard-btn:hover {
      transform: translateY(-2px);
      box-shadow: 0 5px 15px rgba(41, 128, 185, 0.3);
      color: white;
    }

    @media (max-width: 768px) {
      .stats-container {
        grid-template-columns: repeat(2, 1fr);
      }

      .dashboard-cards-container {
        grid-template-columns: 1fr;
      }

      .welcome-section {
        padding: 1.5rem;
      }

      .welcome-text {
        font-size: 1.5rem;
      }
    }

    @media (max-width: 480px) {
      .stats-container {
        grid-template-columns: 1fr;
      }
    }
  </style>
</head>
<body>
<jsp:include page="headerprof.jsp" />

<div class="dashboard-container">
  <div class="welcome-section">
    <h2 class="welcome-text">Bienvenue, ${nomUtilisateur}</h2>
    <p>Voici un aperçu de votre espace professeur</p>
  </div>

  <div class="stats-container">
    <div class="stats-card text-center">
      <div class="stats-number">24</div>
      <div class="stats-label">Étudiants Actifs</div>
    </div>
    <div class="stats-card text-center">
      <div class="stats-number">3</div>
      <div class="stats-label">Modules Enseignés</div>
    </div>
    <div class="stats-card text-center">
      <div class="stats-number">6</div>
      <div class="stats-label">Éléments de Module</div>
    </div>
    <div class="stats-card text-center">
      <div class="stats-number">85%</div>
      <div class="stats-label">Notes Saisies</div>
    </div>
  </div>

  <div class="dashboard-cards-container">
    <div class="dashboard-card">
      <div class="card-body text-center">
        <div>
          <i class="fas fa-users dashboard-icon"></i>
          <h5 class="card-title">Mes Étudiants</h5>
          <p class="card-text">Gérer la liste de vos étudiants par classe et filière</p>
        </div>
        <a href="${pageContext.request.contextPath}/professeur/etudiants" class="dashboard-btn">
          Accéder <i class="fas fa-arrow-right"></i>
        </a>
      </div>
    </div>

    <div class="dashboard-card">
      <div class="card-body text-center">
        <div>
          <i class="fas fa-book dashboard-icon"></i>
          <h5 class="card-title">Mes Éléments</h5>
          <p class="card-text">Consulter et gérer vos modules et éléments de module</p>
        </div>
        <a href="${pageContext.request.contextPath}/professeur/elements" class="dashboard-btn">
          Accéder <i class="fas fa-arrow-right"></i>
        </a>
      </div>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>