<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Détails de l'Élément</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

  <style>
    :root {
      --primary-color: #377aae;
      --secondary-color: #858796;
      --success-color: #1cc88a;
    }

    body {
      background: linear-gradient(135deg, #f5f7fa 0%, #e4e8f1 100%);
      padding-top: 0 !important;
      margin: 0;
    }

    .navbar-custom {
      background: white;
      box-shadow: 0 2px 15px rgba(0, 0, 0, 0.1);
    }

    .navbar-brand {
      font-weight: 700;
      color: var(--primary-color);
    }

    .element-card {
      background: rgba(255, 255, 255, 0.9);
      border-radius: 15px;
      border: none;
      box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
      backdrop-filter: blur(10px);
      margin-bottom: 2rem;
      transition: all 0.3s ease;
    }

    .element-card:hover {
      transform: translateY(-5px);
      box-shadow: 0 15px 30px rgba(0, 0, 0, 0.15);
    }

    .info-card {
      height: 100%;
      overflow: hidden;
      position: relative;
    }

    .info-card::before {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 4px;
      background: linear-gradient(90deg, var(--primary-color), var(--success-color));
      border-radius: 15px 15px 0 0;
    }

    .icon-circle {
      width: 64px;
      height: 64px;
      background: linear-gradient(45deg, var(--primary-color), var(--success-color));
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      margin: 0 auto 1.5rem;
      transition: all 0.3s ease;
      box-shadow: 0 5px 15px rgba(0, 0, 0, 0.15);
    }

    .info-card:hover .icon-circle {
      transform: scale(1.1) rotate(10deg);
    }

    .chart-container {
      position: relative;
      max-width: 500px;
      margin: 0 auto;
      padding: 1rem;
    }

    .page-title {
      color: var(--primary-color);
      font-weight: 700;
      text-transform: uppercase;
      letter-spacing: 2px;
      position: relative;
      padding-bottom: 15px;
      margin-bottom: 30px;
    }

    .page-title::after {
      content: '';
      position: absolute;
      bottom: 0;
      left: 0;
      width: 50px;
      height: 3px;
      background: linear-gradient(90deg, var(--primary-color), var(--success-color));
    }

    .back-btn {
      background: linear-gradient(45deg, var(--primary-color), var(--success-color));
      border: none;
      padding: 12px 25px;
      border-radius: 25px;
      transition: all 0.3s ease;
      color: white;
      text-decoration: none;
      font-weight: 500;
    }

    .back-btn:hover {
      transform: translateY(-2px);
      box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
      color: white;
    }

    .table {
      border-radius: 10px;
      overflow: hidden;
    }

    .table thead th {
      background: linear-gradient(45deg, var(--primary-color), var(--success-color));
      color: white;
      border: none;
      padding: 1rem;
    }

    .table tbody td {
      padding: 1rem;
      vertical-align: middle;
    }

    .table tbody tr:hover {
      background-color: rgba(0, 0, 0, 0.02);
    }

    .stats-value {
      font-size: 1.5rem;
      font-weight: bold;
      color: var(--primary-color);
      margin-bottom: 0.5rem;
    }

    .stats-label {
      color: var(--secondary-color);
      font-size: 0.9rem;
      margin-bottom: 0;
    }
  </style>
  <jsp:include page="header.jsp"/>
</head>
<body>
<!-- Navbar autonome -->
<nav class="navbar navbar-expand-lg navbar-custom mb-4">
  <div class="container">
    <a class="navbar-brand" href="#">
      <i class="fas fa-graduation-cap me-2"></i>
      Gestion des Éléments
    </a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav ms-auto">
        <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath}/elements">
            <i class="fas fa-list me-1"></i> Liste
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath}/elements/add">
            <i class="fas fa-plus-circle me-1"></i> Nouveau
          </a>
        </li>
      </ul>
    </div>
  </div>
</nav>

<div class="container py-4">
  <!-- Header -->
  <div class="d-flex justify-content-between align-items-center mb-5" data-aos="fade-down">
    <h2 class="page-title mb-0">
      Détails de l'Élément: ${element.nomElement}
    </h2>
    <a href="${pageContext.request.contextPath}/elements" class="back-btn">
      <i class="fas fa-arrow-left me-2"></i>Retour à la liste
    </a>
  </div>

  <!-- Information Cards -->
  <div class="row g-4 mb-5">
    <!-- Module Info -->
    <div class="col-md-4" data-aos="fade-up" data-aos-delay="100">
      <a href="${pageContext.request.contextPath}/modules/Details/${element.module.codeModule}"
         class="text-decoration-none">
        <div class="card element-card info-card">
          <div class="card-body text-center p-4">
            <div class="icon-circle">
              <i class="fas fa-book fa-2x text-white"></i>
            </div>
            <h5 class="card-title text-dark">Module</h5>
            <p class="stats-value">${element.module.nomModule}</p>
            <p class="stats-label">Code: ${element.module.codeModule}</p>
          </div>
        </div>
      </a>
    </div>

    <!-- Professor Info -->
    <div class="col-md-4" data-aos="fade-up" data-aos-delay="200">
      <a href="${pageContext.request.contextPath}/professeurs/Details/${element.professeur.code}"
         class="text-decoration-none">
        <div class="card element-card info-card">
          <div class="card-body text-center p-4">
            <div class="icon-circle">
              <i class="fas fa-user-tie fa-2x text-white"></i>
            </div>
            <h5 class="card-title text-dark">Professeur</h5>
            <p class="stats-value">${element.professeur.nom} ${element.professeur.prenom}</p>
            <p class="stats-label">Code: ${element.professeur.code}</p>
          </div>
        </div>
      </a>
    </div>

    <!-- Coefficient Info -->
    <div class="col-md-4" data-aos="fade-up" data-aos-delay="300">
      <div class="card element-card info-card">
        <div class="card-body text-center p-4">
          <div class="icon-circle">
            <i class="fas fa-percentage fa-2x text-white"></i>
          </div>
          <h5 class="card-title">Coefficient</h5>
          <p class="stats-value">${element.coefficient}</p>
          <p class="stats-label">Coefficient de l'élément</p>
        </div>
      </div>
    </div>
  </div>

  <!-- Modalités d'évaluation -->
  <div class="card element-card" data-aos="fade-up">
    <div class="card-body p-4">
      <h4 class="card-title mb-4">Modalités d'Évaluation</h4>
      <div class="row">
        <div class="col-md-6">
          <div class="table-responsive">
            <table class="table table-hover">
              <thead>
              <tr>
                <th>Type d'Évaluation</th>
                <th>Coefficient</th>
              </tr>
              </thead>
              <tbody>
              <c:forEach var="modalite" items="${element.modalites}">
                <tr>
                  <td>${modalite.type_Modalite}</td>
                  <td>${modalite.coeffecient}</td>
                </tr>
              </c:forEach>
              </tbody>
            </table>
          </div>
        </div>
        <div class="col-md-6">
          <div class="chart-container">
            <canvas id="modalitesChart"></canvas>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- Scripts -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.js"></script>
<script>
  // Initialisation AOS
  AOS.init({
    duration: 800,
    once: true
  });

  // Configuration du graphique
  document.addEventListener('DOMContentLoaded', function () {
    const modalites = [];
    const coefficients = [];

    const colors = [
      '#2E5BFF', // Bleu principal
      '#6C8AFF', // Bleu clair
      '#FF6B6B', // Rouge corail
      '#4ECB71', // Vert
      '#FFA94D', // Orange
      '#845EF7', // Violet
      '#339AF0', // Bleu ciel
    ];

    <c:forEach var="modalite" items="${element.modalites}">
    modalites.push("${modalite.type_Modalite}");
    coefficients.push(${modalite.coeffecient});
    </c:forEach>

    new Chart(document.getElementById('modalitesChart'), {
      type: 'doughnut',
      data: {
        labels: modalites,
        datasets: [{
          data: coefficients,
          backgroundColor: colors.slice(0, modalites.length),
          borderWidth: 2,
          borderColor: '#ffffff',
          hoverOffset: 4
        }]
      },
      options: {
        responsive: true,
        maintainAspectRatio: true,
        plugins: {
          legend: {
            position: 'bottom',
            labels: {
              padding: 20,
              usePointStyle: true,
              font: {
                size: 12,
                family: "'Helvetica Neue', 'Helvetica', 'Arial', sans-serif"
              }
            }
          },
          title: {
            display: true,
            text: 'Répartition des coefficients',
            font: {
              size: 16,
              weight: 'bold'
            },
            padding: {
              bottom: 30
            }
          }
        },
        cutout: '60%',
        animation: {
          animateScale: true,
          animateRotate: true
        }
      }
    });
  });
</script>
</body>
</html>