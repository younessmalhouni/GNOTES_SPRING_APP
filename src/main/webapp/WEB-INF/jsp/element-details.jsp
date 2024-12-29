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
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

  <style>
    :root {
      --primary-color: #4e73df;
      --secondary-color: #858796;
      --success-color: #1cc88a;
    }

    body {
      background: linear-gradient(135deg, #f5f7fa 0%, #e4e8f1 100%);
    }

    .element-card {
      background: rgba(255, 255, 255, 0.9);
      border-radius: 15px;
      border: none;
      box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
      backdrop-filter: blur(10px);
      margin-bottom: 2rem;
    }

    .element-card::before {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 4px;
      background: linear-gradient(90deg, var(--primary-color), var(--success-color));
      border-radius: 15px 15px 0 0;
    }

    .info-card {
      height: 100%;
      transition: transform 0.3s ease;
    }

    .info-card:hover {
      transform: translateY(-5px);
    }

    .icon-circle {
      width: 48px;
      height: 48px;
      background: linear-gradient(45deg, var(--primary-color), var(--success-color));
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      margin-bottom: 1rem;
    }

    .chart-container {
      position: relative;
      max-width: 400px;
      margin: 0 auto;
    }

    .page-title {
      color: var(--primary-color);
      font-weight: 700;
      text-transform: uppercase;
      letter-spacing: 2px;
      position: relative;
      padding-bottom: 10px;
    }

    .page-title::after {
      content: '';
      position: absolute;
      bottom: 0;
      left: 0;
      width: 50px;
      height: 3px;
      background: var(--primary-color);
    }

    .back-btn {
      background: linear-gradient(45deg, var(--primary-color), var(--success-color));
      border: none;
      padding: 12px 25px;
      border-radius: 25px;
      transition: all 0.3s ease;
      color: white;
      text-decoration: none;
    }

    .back-btn:hover {
      transform: translateY(-2px);
      box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
      color: white;
    }
  </style>
  <jsp:include page="header.jsp"/>
</head>
<body>
<div class="container py-5">
  <!-- Header -->
  <div class="d-flex justify-content-between align-items-center mb-5">
    <h2 class="page-title">Détails de l'Élément: ${element.nomElement}</h2>
    <a href="${pageContext.request.contextPath}/elements" class="back-btn">
      <i class="fas fa-arrow-left me-2"></i>Retour à la liste
    </a>
  </div>

  <!-- Information Cards -->
  <div class="row g-4 mb-5">
    <!-- Module Info -->
    <div class="col-md-4">
      <a href="${pageContext.request.contextPath}/modules/Details/${element.module.codeModule}" class="text-decoration-none">
        <div class="card element-card info-card">
          <div class="card-body text-center p-4">
            <div class="icon-circle mx-auto">
              <i class="fas fa-book fa-2x text-white"></i>
            </div>
            <h5 class="card-title">Module</h5>
            <p class="card-text fw-bold">${element.module.nomModule}</p>
            <p class="text-muted mb-0">Code: ${element.module.codeModule}</p>
          </div>
        </div>
      </a>
    </div>

    <!-- Professor Info -->
    <div class="col-md-4">
      <a href="${pageContext.request.contextPath}/professeurs/Details/${element.professeur.code}" class="text-decoration-none">
        <div class="card element-card info-card">
          <div class="card-body text-center p-4">
            <div class="icon-circle mx-auto">
              <i class="fas fa-user-tie fa-2x text-white"></i>
            </div>
            <h5 class="card-title">Professeur</h5>
            <p class="card-text fw-bold">${element.professeur.nom} ${element.professeur.prenom}</p>
            <p class="text-muted mb-0">Code: ${element.professeur.code}</p>
          </div>
        </div>
      </a>
    </div>

    <!-- Coefficient Info -->
    <div class="col-md-4">
      <div class="card element-card info-card">
        <div class="card-body text-center p-4">
          <div class="icon-circle mx-auto">
            <i class="fas fa-percentage fa-2x text-white"></i>
          </div>
          <h5 class="card-title">Coefficient</h5>
          <p class="card-text fw-bold">${element.coefficient}</p>
          <p class="text-muted mb-0">Coefficient de l'élément</p>
        </div>
      </div>
    </div>
  </div>

  <!-- Modalités d'évaluation -->
  <div class="card element-card">
    <div class="card-body p-4">
      <h4 class="card-title mb-4">Modalités d'Évaluation</h4>
      <div class="row">
        <div class="col-md-6">
          <div class="table-responsive">
            <table class="table">
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

<script>
  document.addEventListener('DOMContentLoaded', function () {
    const modalites = [];
    const coefficients = [];

    // Définir manuellement les couleurs pour chaque modalité
    const predefinedColors = [
      '#003f88', // Bleu foncé
      '#0056b3', // Bleu moyen
      '#007bff', // Bleu ciel
      '#008000', // Vert foncé
      '#00cc00', // Vert clair
      '#ff0000', // Rouge vif
      '#ff6347', // Rouge tomate
    ];

    // Collecter les données des modalités
    <c:forEach var="modalite" items="${element.modalites}">
    modalites.push("${modalite.type_Modalite}");
    coefficients.push(${modalite.coeffecient});
    </c:forEach>

    // Associer les couleurs aux modalités (en boucle si plus de modalités que de couleurs)
    const colors = modalites.map((_, index) => predefinedColors[index % predefinedColors.length]);

    // Créer le graphique avec Chart.js
    new Chart(document.getElementById('modalitesChart'), {
      type: 'pie',
      data: {
        labels: modalites,
        datasets: [{
          data: coefficients,
          backgroundColor: colors, // Appliquer les couleurs définies
          borderWidth: 1,
          borderColor: '#ffffff', // Bordure blanche pour séparation
        }]
      },
      options: {
        responsive: true,
        plugins: {
          legend: {
            position: 'bottom',
          },
          title: {
            display: true,
            text: 'Répartition des coefficients',
          },
        },
      },
    });
  });
</script>
</body>
</html>
```