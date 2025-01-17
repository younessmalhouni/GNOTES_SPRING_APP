<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Modification des notes - ${element.nomElement}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">
    <div class="row mb-4">
        <div class="col">
            <h2>Modification des notes - ${element.nomElement}</h2>
            <div class="card mb-4">
                <div class="card-body">
                    <h5 class="card-title">${etudiant.nomEtudiant} ${etudiant.prenomEtudiant}</h5>
                    <p class="card-text">
                        Code: ${etudiant.codeEtudiant}<br>
                        Filière: ${etudiant.filliere.nomFilliere}<br>
                        Semestre: ${etudiant.semestre.nom_Semestre}
                    </p>
                </div>
            </div>

            <form action="/professeur/etudiants/notes/${etudiant.codeEtudiant}/${element.idElement}/save"
                  method="POST"
                  class="needs-validation"
                  novalidate
                  id="notesForm">
                <div class="table-responsive">
                    <table class="table table-striped">
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
                        <c:forEach var="modalite" items="${element.modalites}" varStatus="status">
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

                <div class="row mt-4">
                    <div class="col">
                        <a href="/professeur/etudiants/notes/${etudiant.codeEtudiant}" class="btn btn-secondary">
                            Annuler
                        </a>
                        <button type="submit" class="btn btn-primary ms-2">
                            Enregistrer les notes
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    (function() {
        'use strict'

        const forms = document.querySelectorAll('.needs-validation')
        const form = document.getElementById('notesForm')

        // Initialize the form state based on existing absences
        document.querySelectorAll('.absent-checkbox').forEach(checkbox => {
            const noteInput = document.querySelector(`input[name="note_${checkbox.name.split('_')[1]}"]`)
            if (checkbox.checked) {
                noteInput.disabled = true
                noteInput.value = ''
                noteInput.removeAttribute('required')
            }
        })

        // Handle absent checkbox changes
        document.querySelectorAll('.absent-checkbox').forEach(checkbox => {
            const noteInput = document.querySelector(`input[name="note_${checkbox.name.split('_')[1]}"]`)

            checkbox.addEventListener('change', function() {
                if (this.checked) {
                    noteInput.disabled = true
                    noteInput.value = ''
                    noteInput.removeAttribute('required')
                } else {
                    noteInput.disabled = false
                    noteInput.setAttribute('required', '')
                }
            })
        })

        // Validate notes before submission
        form.addEventListener('submit', event => {
            const noteInputs = form.querySelectorAll('.note-input:not(:disabled)')
            let isValid = true

            noteInputs.forEach(input => {
                const value = parseFloat(input.value)
                if (isNaN(value) || value < 0 || value > 20) {
                    isValid = false
                    input.classList.add('is-invalid')
                } else {
                    input.classList.remove('is-invalid')
                }
            })

            if (!isValid) {
                event.preventDefault()
                event.stopPropagation()
            }

            form.classList.add('was-validated')
        })

        // Validate note input on change
        document.querySelectorAll('.note-input').forEach(input => {
            input.addEventListener('input', function() {
                const value = parseFloat(this.value)
                if (isNaN(value) || value < 0 || value > 20) {
                    this.classList.add('is-invalid')
                } else {
                    this.classList.remove('is-invalid')
                }
            })
        })
    })()
</script>
</body>
</html>