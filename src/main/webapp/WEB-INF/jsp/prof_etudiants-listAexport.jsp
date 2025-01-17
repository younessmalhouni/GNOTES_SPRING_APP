<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Liste des Étudiants à Exporter</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
  <style>
    .student-img {
      width: 50px;
      height: 50px;
      object-fit: cover;
      border-radius: 50%;
    }
    .default-img {
      width: 50px;
      height: 50px;
      border-radius: 50%;
      background-color: #e9ecef;
    }
    .filters-section {
      background-color: #f8f9fa;
      padding: 20px;
      border-radius: 8px;
      margin-bottom: 20px;
    }
    .export-btn {
      position: fixed;
      bottom: 20px;
      right: 20px;
      z-index: 1000;
    }
  </style>
</head>
<body>
<div class="container mt-4">
  <div class="d-flex justify-content-between align-items-center mb-4">
    <h2>Liste des Étudiants à Exporter - ${element.nomElement}</h2>
    <button class="btn btn-success" onclick="exportToPDF()">
      <i class="fas fa-file-export me-2"></i>Exporter en PDF
    </button>
  </div>

  <div class="filters-section">
    <div class="row g-3">
      <div class="col-md-4">
        <input type="text" class="form-control" id="searchTerm"
               placeholder="Rechercher par nom ou prénom">
      </div>
      <div class="col-md-3">
        <select class="form-select" id="filliereId">
          <option value="">Toutes les filières</option>
          <c:forEach var="filliere" items="${fillieres}">
            <option value="${filliere.idFilliere}" ${param.filliereId eq filliere.idFilliere ? 'selected' : ''}>
                ${filliere.nomFilliere}
            </option>
          </c:forEach>
        </select>
      </div>
      <div class="col-md-3">
        <select class="form-select" id="semestreId">
          <option value="">Tous les semestres</option>
          <c:forEach var="semestre" items="${semestres}">
            <option value="${semestre.id_Semestre}" ${param.semestreId eq semestre.id_Semestre ? 'selected' : ''}>
                ${semestre.nom_Semestre}
            </option>
          </c:forEach>
        </select>
      </div>
      <div class="col-md-2">
        <select class="form-select" id="codeModule">
          <option value="">Tous les modules</option>
          <c:forEach var="module" items="${modules}">
            <option value="${module.codeModule}" ${param.codeModule eq module.codeModule ? 'selected' : ''}>
                ${module.nomModule}
            </option>
          </c:forEach>
        </select>
      </div>
    </div>
  </div>

  <div class="table-responsive" id="exportTable">
    <table class="table table-striped table-hover">
      <thead class="table-dark">
      <tr>
        <th>Photo</th>
        <th>Code</th>
        <th>Nom</th>
        <th>Prénom</th>
        <th>Email</th>
        <th>Filière</th>
        <th>Semestre</th>
        <th>Element</th>
        <th>Note</th>
      </tr>
      </thead>
      <tbody>
      <c:forEach var="etudiant" items="${etudiants}">
        <tr>
          <td>
            <c:choose>
              <c:when test="${not empty etudiant.image}">
                <img src="${etudiant.image}" alt="Image" class="student-img">
              </c:when>
              <c:otherwise>
                <div class="default-img"></div>
              </c:otherwise>
            </c:choose>
          </td>
          <td>${etudiant.codeEtudiant}</td>
          <td>${etudiant.nomEtudiant}</td>
          <td>${etudiant.prenomEtudiant}</td>
          <td>${etudiant.email}</td>
          <td>${etudiant.filliere.nomFilliere}</td>
          <td>${etudiant.semestre.nom_Semestre}</td>
          <td>${element.nomElement}</td>
          <td>
            <c:choose>
              <c:when test="${not empty etudiant.NoteElementByEtudiant(element)}">
                ${etudiant.NoteElementByEtudiant(element).noteElement}/20
              </c:when>
              <c:otherwise>
                <span class="text-muted">Non saisie</span>
              </c:otherwise>
            </c:choose>
          </td>
        </tr>
      </c:forEach>
      </tbody>
    </table>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js"></script>
<script>
  $(document).ready(function () {
    $('#searchTerm').val(decodeURIComponent('${param.searchTerm}' || ''));

    function filterStudents() {
      const searchTerm = $('#searchTerm').val();
      const filliereId = $('#filliereId').val();
      const semestreId = $('#semestreId').val();
      const codeModule = $('#codeModule').val();

      window.location.href = '${pageContext.request.contextPath}/professeur/etudiants/listAExporter/${element.idElement}?' +
              'searchTerm=' + encodeURIComponent(searchTerm) +
              '&filliereId=' + encodeURIComponent(filliereId) +
              '&semestreId=' + encodeURIComponent(semestreId) +
              '&codeModule=' + encodeURIComponent(codeModule);
    }

    let timeoutId;
    $('#searchTerm').on('input', function () {
      clearTimeout(timeoutId);
      timeoutId = setTimeout(filterStudents, 300);
    });

    $('#filliereId, #semestreId, #codeModule').on('change', filterStudents);
  });

  function exportToPDF() {
    const element = document.getElementById('exportTable');
    const opt = {
      margin: 1,
      filename: 'liste_etudiants.pdf',
      image: { type: 'jpeg', quality: 0.98 },
      html2canvas: { scale: 2 },
      jsPDF: { unit: 'in', format: 'a4', orientation: 'landscape' }
    };

    html2pdf().set(opt).from(element).save();
  }
</script>
</body>
</html>