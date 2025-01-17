<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Notes de l'étudiant</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <jsp:include page="headerprof.jsp"/>
    <style>
        .student-card {
            border-left: 4px solid #0d6efd;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .validated-element {
            background-color: #f8f9fa;
            border-left: 4px solid #198754;
        }
        .validated-badge {
            background-color: #198754 !important;
        }
        .accordion-button:not(.collapsed) {
            background-color: #f8f9fa;
        }
        .element-header {
            display: flex;
            align-items: center;
            width: 100%;
            justify-content: space-between;
        }
        .element-title {
            margin-right: auto;
        }
        .action-buttons {
            margin-left: 10px;
            display: flex;
            gap: 5px;
        }
    </style>
</head>
<body class="bg-light">
<div class="container mt-4">
    <div class="row mb-4">
        <div class="col">
            <h2 class="mb-4">Notes de l'étudiant</h2>
            <div class="card student-card">
                <div class="card-body">
                    <h5 class="card-title">${etudiant.nomEtudiant} ${etudiant.prenomEtudiant}</h5>
                    <p class="card-text">
                        <i class="fas fa-id-card me-2"></i>Code: ${etudiant.codeEtudiant}<br>
                        <i class="fas fa-graduation-cap me-2"></i>Filière: ${etudiant.filliere.nomFilliere}<br>
                        <i class="fas fa-calendar-alt me-2"></i>Semestre: ${etudiant.semestre.nom_Semestre}
                    </p>
                </div>
            </div>
        </div>
    </div>

    <div class="accordion" id="elementsAccordion">
        <c:forEach var="element" items="${elements}" varStatus="status">
            <div class="accordion-item ${element.getNoteElementByEtudiant(etudiant).isValide ? 'validated-element' : ''}">
                <h2 class="accordion-header">
                    <button class="accordion-button collapsed" type="button"
                            data-bs-toggle="collapse"
                            data-bs-target="#collapse${status.index}">
                        <div class="element-header">
                            <span class="element-title">
                                ${element.nomElement}
                                <c:if test="${element.getNoteElementByEtudiant(etudiant).isValide}">
                                    <i class="fas fa-check-circle text-success ms-2"></i>
                                </c:if>
                            </span>
                            <span class="badge ${element.getNoteElementByEtudiant(etudiant).isValide ? 'validated-badge' : 'bg-primary'} ms-2"
                                  data-element="${element.idElement}"
                                  data-note="${element.getNoteElementByEtudiant(etudiant).noteElement}">
                                    Note: ${element.getNoteElementByEtudiant(etudiant).noteElement != null ? element.getNoteElementByEtudiant(etudiant).noteElement : 'Non saisie'}
                            </span>
                            <div class="action-buttons">
                                <button class="btn btn-sm btn-primary" type="button"
                                        onclick="handleModification('${etudiant.codeEtudiant}', '${element.idElement}', ${element.getNoteElementByEtudiant(etudiant).isValide})">
                                    <i class="fas fa-edit"></i> Modifier
                                </button>
                                <button class="btn btn-sm btn-success" type="button"
                                        onclick="confirmValidation('${etudiant.codeEtudiant}', '${element.idElement}')">
                                    <i class="fas fa-check"></i> Valider
                                </button>
                            </div>
                        </div>
                    </button>
                </h2>
                <div id="collapse${status.index}" class="accordion-collapse collapse"
                     data-bs-parent="#elementsAccordion">
                    <div class="accordion-body">
                        <table class="table table-striped">
                            <thead>
                            <tr>
                                <th>Modalité</th>
                                <th>Coefficient</th>
                                <th>Note</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="modalite" items="${element.modalites}">
                                <tr>
                                    <td>${modalite.type_Modalite}</td>
                                    <td>${modalite.coeffecient}%</td>
                                    <td>
                                        <c:set var="noteFound" value="false"/>
                                        <c:forEach var="note" items="${etudiant.noteModalites}">
                                            <c:if test="${note.modaliteEvaluation.id_Modalite eq modalite.id_Modalite}">
                                                <c:set var="noteFound" value="true"/>
                                                ${note.noteModalite}/20
                                            </c:if>
                                        </c:forEach>
                                        <c:if test="${!noteFound}">
                                            <span class="text-muted">Non saisie</span>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
    function handleModification(codeEtudiant, idElement, isValidated) {
        if (isValidated) {
            Swal.fire({
                title: 'Modification impossible',
                text: 'Vous avez validé cet élément, vous ne pouvez pas le modifier',
                icon: 'warning',
                confirmButtonText: 'OK'
            });
        } else {
            window.location.href = `/professeur/etudiants/notes/\${encodeURIComponent(codeEtudiant)}/\${encodeURIComponent(idElement)}/ModifierNotes`;
        }
    }

    function confirmValidation(codeEtudiant, idElement) {
        const noteElement = document.querySelector(`[data-element="\${idElement}"]`)
            .getAttribute('data-note');

        if (!noteElement || noteElement === 'Non saisie') {
            Swal.fire({
                title: 'Notes manquantes',
                text: 'Veuillez d\'abord saisir les notes avant de valider',
                icon: 'error',
                confirmButtonText: 'OK'
            });
            return;
        }

        Swal.fire({
            title: 'Confirmation',
            text: 'Êtes-vous sûr de vouloir valider cet élément ? Cette action est irréversible.',
            icon: 'question',
            showCancelButton: true,
            confirmButtonText: 'Oui, valider',
            cancelButtonText: 'Annuler',
            confirmButtonColor: '#198754',
            cancelButtonColor: '#dc3545'
        }).then((result) => {
            if (result.isConfirmed) {
                window.location.href = `/professeur/etudiants/notes/\${encodeURIComponent(codeEtudiant)}/\${encodeURIComponent(idElement)}/Valider`;
            }
        });
    }
</script>



</body>
</html>