<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Liste des Étudiants</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <style>
    :root {
      --primary-color: #2c3e50;
      --secondary-color: #34495e;
      --accent-color: #3498db;
      --light-bg: #f8f9fa;
      --border-radius: 8px;
    }

    body {
      background-color: #f5f6f8;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    .student-img {
      width: 50px;
      height: 50px;
      object-fit: cover;
      border-radius: 50%;
      box-shadow: 0 2px 4px rgba(0,0,0,0.1);
      border: 2px solid white;
    }

    .default-img {
      width: 50px;
      height: 50px;
      border-radius: 50%;
      background-color: #e9ecef;
      display: flex;
      align-items: center;
      justify-content: center;
      border: 2px solid #dee2e6;
    }

    .filters-section {
      background-color: white;
      padding: 1.5rem;
      border-radius: var(--border-radius);
      box-shadow: 0 2px 10px rgba(0,0,0,0.05);
      margin-bottom: 1.5rem;
    }

    .main-container {
      background-color: white;
      border-radius: var(--border-radius);
      box-shadow: 0 2px 10px rgba(0,0,0,0.05);
      padding: 2rem;
      margin-top: 2rem;
      margin-bottom: 2rem;
    }

    .table {
      border-radius: var(--border-radius);
      overflow: hidden;
    }

    .table thead th {
      background-color: var(--primary-color);
      color: white;
      font-weight: 500;
      border-bottom: none;
    }

    .form-control, .form-select {
      border-radius: 6px;
      border: 1px solid #dee2e6;
      padding: 0.5rem 1rem;
      transition: all 0.3s ease;
    }

    .form-control:focus, .form-select:focus {
      border-color: var(--accent-color);
      box-shadow: 0 0 0 0.2rem rgba(52, 152, 219, 0.25);
    }

    .btn-primary {
      background-color: var(--accent-color);
      border: none;
      padding: 0.5rem 1rem;
      border-radius: 6px;
      transition: all 0.3s ease;
    }

    .btn-primary:hover {
      background-color: #2980b9;
      transform: translateY(-1px);
    }

    .notes-form {
      background-color: var(--light-bg);
      padding: 1.5rem;
      border-radius: var(--border-radius);
      margin: 1rem;
    }

    .input-group {
      border-radius: var(--border-radius);
      overflow: hidden;
    }

    .table-striped tbody tr:nth-of-type(odd) {
      background-color: rgba(0,0,0,.02);
    }

    .table-hover tbody tr:hover {
      background-color: rgba(52, 152, 219, 0.05);
    }

    .page-title {
      color: var(--primary-color);
      font-weight: 600;
      margin-bottom: 1.5rem;
      padding-bottom: 0.5rem;
      border-bottom: 2px solid var(--accent-color);
    }
    .alert-custom {
      background: white;
      box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
      padding: 1.5rem;
      border-radius: 8px;
      max-width: 500px;
      width: 90%;
    }

    .alert-error {
      border-left: 4px solid #dc3545;
    }

    .alert-success {
      border-left: 4px solid #28a745;
    }

    .alert-icon {
      font-size: 24px;
      margin-right: 1rem;
    }

    .alert-overlay {
      position: fixed;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%);
      z-index: 1050;
      display: none;
    }

    .alert-custom.alert-success .alert-icon {
      color: #28a745;
    }

    .alert-backdrop {
      position: fixed;
      top: 0;
      left: 0;
      right: 0;
      bottom: 0;
      background: rgba(0, 0, 0, 0.5);
      z-index: 1040;
      display: none;
    }
  </style>
</head>
<body>
<jsp:include page="headerprof.jsp"/>
<div class="container mt-4">
  <h2 class="mb-4" >Liste de mes Étudiants</h2>

  <div class="filters-section">
    <div class="row g-3">
      <div class="col-md-4">
        <input type="text" class="form-control" id="searchTerm"
               placeholder="Rechercher par nom ou prénom">
      </div>
      <div class="col-md-2">
        <select class="form-select" id="filliereId">
          <option value="">Toutes les filières</option>
          <c:forEach var="filliere" items="${fillieres}">
            <option value="${filliere.idFilliere}" ${param.filliereId eq filliere.idFilliere ? 'selected' : ''}>
                ${filliere.nomFilliere}
            </option>
          </c:forEach>
        </select>
      </div>
      <div class="col-md-2">
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
      <div class="col-md-2">
        <select class="form-select" id="elementId">
          <option value="">Tous les elements</option>
          <c:forEach var="element" items="${elements}">
            <option value="${element.idElement}" ${param.elementId eq element.idElement ? 'selected' : ''}>
                ${element.nomElement}
            </option>
          </c:forEach>
        </select>
      </div>
    </div>
  </div>

  <div class="table-responsive">
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
        <th>Actions</th>
        <th>Saisir Note</th>
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
          <td>
            <button class="btn btn-primary btn-sm" onclick="redirectToNotes('${etudiant.codeEtudiant}')">Voir Notes</button>
          </td>
          <td>
            <button class="btn btn-success btn-sm" type="button" data-bs-toggle="collapse"
                    data-bs-target="#notesForm${etudiant.codeEtudiant}" aria-expanded="false">
              Saisir Note
            </button>
          </td>
        </tr>
        <tr>
          <td colspan="9" class="p-0">
            <div class="collapse" id="notesForm${etudiant.codeEtudiant}">
              <div class="notes-form">
                <h5>Saisie des notes - ${etudiant.nomEtudiant} ${etudiant.prenomEtudiant}</h5>
                <form class="needs-validation" novalidate action="/professeur/etudiants/notes/${etudiant.codeEtudiant}/${element.idElement}/save" method="post">
                  <div class="row g-3">
                    <div class="col-md-4">
                      <label class="form-label">Élément</label>
                      <select class="form-select" required>
                        <c:forEach var="element" items="${elements}">
                          <option value="${element.idElement}">${element.nomElement}</option>
                        </c:forEach>
                      </select>
                    </div>
                  </div>

                  <div class="table-responsive mt-3">
                    <table class="table">
                      <thead>
                      <tr>
                        <th>Modalité</th>
                        <th>Coefficient</th>
                        <th>Note actuelle</th>
                        <th>Nouvelle note</th>
                        <th>Absent</th>
                      </tr>
                      </thead>
                      <tbody>
                      <c:forEach var="modalite" items="${modalites}" varStatus="status">
                        <tr>
                          <td>${modalite.type_Modalite}</td>
                          <td>${modalite.coeffecient}%</td>
                          <td>
                            <c:set var="noteFound" value="false"/>
                            <c:set var="currentNote" value=""/>
                            <c:set var="isCurrentlyAbsent" value="false"/>
                            <c:forEach var="note" items="${etudiant.noteModalites}">
                              <c:if test="${note.modaliteEvaluation.id_Modalite eq modalite.id_Modalite}">
                                <c:set var="noteFound" value="true"/>
                                <c:set var="currentNote" value="${note.noteModalite}"/>
                                <c:set var="isCurrentlyAbsent" value="${note.absent}"/>
                                <c:choose>
                                  <c:when test="${note.absent}">
                                    <span class="text-danger">Absent</span>
                                  </c:when>
                                  <c:otherwise>
                                    ${note.noteModalite}/20
                                  </c:otherwise>
                                </c:choose>
                              </c:if>
                            </c:forEach>
                            <c:if test="${!noteFound}">
                              <span class="text-muted">Non saisie</span>
                            </c:if>
                          </td>
                          <td>
                            <div class="input-group">
                              <input type="number"
                                     class="form-control note-input"
                                     name="note_${modalite.id_Modalite}"
                                     min="0"
                                     max="20"
                                     step="0.25"
                                     value="${currentNote}"
                                     required>
                              <span class="input-group-text">/20</span>
                              <div class="invalid-feedback">
                                La note doit être comprise entre 0 et 20
                              </div>
                            </div>
                          </td>
                          <td>
                            <div class="form-check">
                              <input class="form-check-input absent-checkbox"
                                     type="checkbox"
                                     name="absent_${modalite.id_Modalite}"
                                     id="absent_${modalite.id_Modalite}"
                                ${isCurrentlyAbsent ? 'checked' : ''}>
                              <label class="form-check-label" for="absent_${modalite.id_Modalite}">
                                Absent
                              </label>
                            </div>
                          </td>
                        </tr>
                      </c:forEach>
                      </tbody>
                    </table>
                  </div>

                  <div class="mt-3">
                    <button type="button" class="btn btn-secondary" data-bs-toggle="collapse"
                            data-bs-target="#notesForm${etudiant.codeEtudiant}">
                      Annuler
                    </button>
                    <button type="submit" class="btn btn-primary ms-2">
                      Enregistrer les notes
                    </button>
                  </div>
                </form>
              </div>
            </div>
          </td>
        </tr>
      </c:forEach>
      </tbody>
    </table>
  </div>
</div>
<div class="alert-backdrop" id="alertBackdrop"></div>

<!-- Alerte d'erreur (note déjà validée) -->
<div class="alert-overlay" id="alertValidationError">
  <div class="alert-custom alert-error">
    <div class="d-flex align-items-center">
      <i class="fas fa-exclamation-circle alert-icon text-danger"></i>
      <div>
        <h4 class="alert-heading mb-2">Note déjà validée</h4>
        <p class="mb-0">Les notes pour cet élément ont déjà été validées et ne peuvent pas être modifiées.</p>
      </div>
    </div>
    <div class="text-end mt-3">
      <button type="button" class="btn btn-secondary" onclick="closeAlert('alertValidationError')">Fermer</button>
    </div>
  </div>
</div>

<!-- Alerte de succès -->
<div class="alert-overlay" id="alertSuccess">
  <div class="alert-custom alert-success">
    <div class="d-flex align-items-center">
      <i class="fas fa-check-circle alert-icon text-success"></i>
      <div>
        <h4 class="alert-heading mb-2">Enregistrement réussi</h4>
        <p class="mb-0">Les notes ont été enregistrées avec succès.</p>
      </div>
    </div>
    <div class="text-end mt-3">
      <button type="button" class="btn btn-secondary" onclick="closeAlert('alertSuccess')">Fermer</button>
    </div>
  </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
  $(document).ready(function () {
    // Restaurer la valeur de recherche
    $('#searchTerm').val(decodeURIComponent('${param.searchTerm}' || ''));

    function filterStudents() {
      const searchTerm = $('#searchTerm').val();
      const filliereId = $('#filliereId').val();
      const semestreId = $('#semestreId').val();
      const codeModule = $('#codeModule').val();
      const elementId = $('#elementId').val();

      window.location.href = '${pageContext.request.contextPath}/professeur/etudiants?' +
              'searchTerm=' + encodeURIComponent(searchTerm) +
              '&filliereId=' + encodeURIComponent(filliereId) +
              '&semestreId=' + encodeURIComponent(semestreId) +
              '&codeModule=' + encodeURIComponent(codeModule) +
              '&elementId=' + encodeURIComponent(elementId);
    }

    let timeoutId;
    $('#searchTerm').on('input', function () {
      clearTimeout(timeoutId);
      timeoutId = setTimeout(filterStudents, 300);
    });

    $('#filliereId, #semestreId, #codeModule, #elementId').on('change', filterStudents);
  });

  function redirectToNotes(codeEtudiant) {
    window.location.href = `${pageContext.request.contextPath}/professeur/etudiants/notes/\${encodeURIComponent(codeEtudiant)}`;
  }

  document.querySelectorAll('.form-check-input').forEach(checkbox => {
    checkbox.addEventListener('change', function() {
      const noteInput = this.closest('tr').querySelector('input[type="number"]');
      if (this.checked) {
        noteInput.disabled = true;
        noteInput.value = '';
      } else {
        noteInput.disabled = false;
      }
    });
  });
  function showAlert(alertId) {
    document.getElementById('alertBackdrop').style.display = 'block';
    document.getElementById(alertId).style.display = 'block';
  }

  function closeAlert(alertId) {
    document.getElementById('alertBackdrop').style.display = 'none';
    document.getElementById(alertId).style.display = 'none';
  }

  // Mise à jour du gestionnaire de formulaire
  document.querySelectorAll('.needs-validation').forEach(form => {
    form.addEventListener('submit', async function(event) {
      event.preventDefault();

      if (!this.checkValidity()) {
        event.stopPropagation();
        this.classList.add('was-validated');
        return;
      }

      try {
        const formData = new FormData(this);
        const response = await fetch(this.action, {
          method: 'POST',
          body: formData
        });

        if (response.url.endsWith('/etudiants')) {
          // Alerte d'erreur - note déjà validée
          showAlert('alertValidationError');
        } else {
          // Alerte de succès
          showAlert('alertSuccess');

          // Réinitialiser ou fermer le formulaire si nécessaire
          const collapseElement = this.closest('.collapse');
          if (collapseElement) {
            bootstrap.Collapse.getInstance(collapseElement).hide();
          }

          // Optionnel : recharger les données du formulaire
          // Vous pouvez ajouter ici un appel AJAX pour rafraîchir les données si nécessaire
        }
      } catch (error) {
        console.error('Error:', error);
      }
    });
  });

</script>
</body>
</html>