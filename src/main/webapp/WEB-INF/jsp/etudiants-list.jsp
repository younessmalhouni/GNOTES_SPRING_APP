<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liste des Étudiants</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
    <jsp:include page="header.jsp"/>
</head>
<body>
<div class="container mt-5">
    <div class="row mb-3">
        <div class="col-md-4">
            <div class="input-group">
                <input type="text" id="searchInput" class="form-control" placeholder="Rechercher par nom ou prénom">
            </div>
        </div>
        <div class="col-md-4">
            <select id="filliereFilter" class="form-select">
                <option value="">Toutes les filières</option>
                <c:forEach var="filliere" items="${fillieres}">
                    <option value="${filliere.idFilliere}">${filliere.nomFilliere}</option>
                </c:forEach>
            </select>
        </div>
        <div class="col-md-4">
            <select id="semestreFilter" class="form-select">
                <option value="">Tous les semestres</option>
                <c:forEach var="semestre" items="${semestres}">
                    <option value="${semestre.id_Semestre}">${semestre.nom_Semestre}</option>
                </c:forEach>
            </select>
        </div>
    </div>
    <h2 class="mb-4">Liste des Étudiants</h2>
    <a href="${pageContext.request.contextPath}/etudiants/add" class="btn btn-primary mb-3">Ajouter un Nouvel Étudiant</a>
    <table class="table table-bordered">
        <thead>
        <tr>
            <th>Image</th>
            <th>ID</th>
            <th>Nom</th>
            <th>Prénom</th>
            <th>Email</th>
            <th>Filière</th>
            <th>Semestre</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="etudiant" items="${etudiants}">
            <tr>
                <td><img src="${etudiant.image}" alt="Image" width="50" height="50"></td>
                <td>${etudiant.codeEtudiant}</td>
                <td>${etudiant.nomEtudiant}</td>
                <td>${etudiant.prenomEtudiant}</td>
                <td>${etudiant.email}</td>
                <td>${etudiant.filliere.nomFilliere}</td>
                <td>${etudiant.semestre.nom_Semestre}</td>
                <td>
                    <a href="${pageContext.request.contextPath}/etudiants/edit/${etudiant.codeEtudiant}" class="btn btn-warning btn-sm">Modifier</a>
                    <a href="${pageContext.request.contextPath}/etudiants/delete/${etudiant.codeEtudiant}" class="btn btn-danger btn-sm">Supprimer</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(document).ready(function() {
        let searchTimeout;

        function updateTable(data) {
            const tableBody = $('tbody');
            tableBody.empty();

            data.forEach(function(etudiant) {
                const row = `
                <tr>
                    <td><img src="\${etudiant.image || ''}" alt="Image" width="50" height="50"></td>
                    <td>\${etudiant.codeEtudiant || ''}</td>
                    <td>\${etudiant.nomEtudiant || ''}</td>
                    <td>\${etudiant.prenomEtudiant || ''}</td>
                    <td>\${etudiant.email || ''}</td>
                    <td>\${etudiant.filliere ? etudiant.filliere.nomFilliere : ''}</td>
                    <td>\${etudiant.semestre ? etudiant.semestre.nom_Semestre : ''}</td>
                    <td>
                        <a href="${pageContext.request.contextPath}/etudiants/edit/\${etudiant.codeEtudiant}"
                           class="btn btn-warning btn-sm">Modifier</a>
                        <a href="${pageContext.request.contextPath}/etudiants/delete/\${etudiant.codeEtudiant}"
                           class="btn btn-danger btn-sm">Supprimer</a>
                    </td>
                </tr>
            `;
                tableBody.append(row);
            });
        }

        function performSearch() {
            const searchTerm = $('#searchInput').val().trim();
            const filliereId = $('#filliereFilter').val();
            const semestreId = $('#semestreFilter').val();

            clearTimeout(searchTimeout);

            searchTimeout = setTimeout(function() {
                $.ajax({
                    url: `${pageContext.request.contextPath}/etudiants/search`,
                    type: 'GET',
                    data: {
                        search: searchTerm,
                        filliereId: filliereId,
                        semestreId: semestreId
                    },
                    beforeSend: function() {
                        $('tbody').addClass('opacity-50');
                    },
                    success: function(data) {
                        updateTable(data);
                    },
                    error: function(xhr, status, error) {
                        console.error('Erreur lors de la recherche:', error);
                    },
                    complete: function() {
                        $('tbody').removeClass('opacity-50');
                    }
                });
            }, 300);
        }

        // Écouteurs d'événements pour tous les filtres
        $('#searchInput').on('input', performSearch);
        $('#filliereFilter').on('change', performSearch);
        $('#semestreFilter').on('change', performSearch);
    });
</script>
</body>
</html>