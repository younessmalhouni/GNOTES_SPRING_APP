<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liste des Étudiants</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-color: #4895ef;
            --secondary-color: #4895ef;
            --accent-color: #4895ef;
            --success-color: #4cc9f0;
            --warning-color: #f72585;
        }

        body {
            background-color: #f8f9fa;
        }

        .custom-container {
            background-color: white;
            border-radius: 15px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            padding: 2rem;
            margin-top: 2rem;
        }

        .filter-card {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            border-radius: 12px;
            padding: 1.5rem;
            margin-bottom: 2rem;
        }

        .filter-card input, .filter-card select {
            border: none;
            border-radius: 8px;
            padding: 0.8rem;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
        }

        .filter-card input:focus, .filter-card select:focus {
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
        }

        .filter-label {
            color: white;
            margin-bottom: 0.5rem;
            font-weight: 500;
        }

        .table-wrapper {
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
        }

        .custom-table {
            margin-bottom: 0;
        }

        .custom-table thead {
            background: linear-gradient(135deg, var(--accent-color), var(--success-color));
        }

        .custom-table thead th {
            color: white;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.9rem;
            padding: 1.2rem 1rem;
            border: none;
        }

        .custom-table tbody tr {
            transition: all 0.3s ease;
        }

        .custom-table tbody tr:hover {
            background-color: #f8f9fa;
            transform: scale(1.01);
        }

        .student-img {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            object-fit: cover;
            border: 3px solid white;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
        }

        .btn-add {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            border: none;
            padding: 0.8rem 1.5rem;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
        }

        .btn-add:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.2);
        }

        .action-btn {
            padding: 0.5rem 1rem;
            border-radius: 6px;
            transition: all 0.3s ease;
            margin: 0 0.2rem;
        }

        .btn-edit {
            background-color: var(--accent-color);
            border: none;
            color: white;
        }

        .btn-delete {
            background-color: var(--warning-color);
            border: none;
            color: white;
        }

        .page-title {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            font-weight: bold;
            font-size: 2.2rem;
        }

        .badge-custom {
            padding: 0.5rem 1rem;
            border-radius: 6px;
            font-weight: 500;
        }

        .no-data-message {
            text-align: center;
            padding: 2rem;
            color: #6c757d;
            font-style: italic;
        }

        /* Animation pour le chargement */
        .loading {
            opacity: 0.6;
            pointer-events: none;
        }

        @keyframes shimmer {
            0% { background-position: -1000px 0; }
            100% { background-position: 1000px 0; }
        }
        .search-button {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            border: none;
            padding: 0.8rem 1.5rem;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
        }

        .search-button:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.2);
        }

        .loading-spinner {
            display: none;
            margin-right: 8px;
        }

        .search-form {
            margin-bottom: 1rem;
        }
    </style>
    <jsp:include page="header.jsp"/>
</head>
<body>
<div class="container custom-container">
    <form id="searchForm" class="search-form" action="${pageContext.request.contextPath}/etudiants/search">
        <div class="filter-card">
            <div class="row g-3">
                <div class="col-md-3">
                    <label class="filter-label">Rechercher</label>
                    <div class="input-group">
                        <span class="input-group-text bg-white">
                            <i class="fas fa-search"></i>
                        </span>
                        <input type="text" name="search" id="searchInput" class="form-control" placeholder="Nom ou prénom...">
                    </div>
                </div>
                <div class="col-md-3">
                    <label class="filter-label">Filière</label>
                    <select name="filliereId" id="filliereFilter" class="form-select">
                        <option value="">Toutes les filières</option>
                        <c:forEach var="filliere" items="${fillieres}">
                            <option value="${filliere.idFilliere}">${filliere.nomFilliere}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-3">
                    <label class="filter-label">Semestre</label>
                    <select name="semestreId" id="semestreFilter" class="form-select">
                        <option value="">Tous les semestres</option>
                        <c:forEach var="semestre" items="${semestres}">
                            <option value="${semestre.id_Semestre}">${semestre.nom_Semestre}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-3 d-flex align-items-end">
                    <button type="submit" class="search-button w-100">
                        <span class="spinner-border spinner-border-sm loading-spinner" role="status" aria-hidden="true"></span>
                        <i class="fas fa-search me-2"></i>Rechercher
                    </button>
                </div>
            </div>
        </div>
    </form>

    <div class="d-flex justify-content-between align-items-center mb-4">
        <h1 class="page-title mb-0">Liste des Étudiants</h1>
        <a href="${pageContext.request.contextPath}/etudiants/add" class="btn btn-add">
            <i class="fas fa-user-plus me-2"></i>Nouvel Étudiant
        </a>
    </div>

    <div class="table-wrapper">
        <table class="table custom-table">
            <thead>
            <tr>
                <th><i class="fas fa-image me-2"></i>Image</th>
                <th><i class="fas fa-id-card me-2"></i>ID</th>
                <th><i class="fas fa-user me-2"></i>CNE</th>
                <th><i class="fas fa-user me-2"></i>Nom</th>
                <th><i class="fas fa-user me-2"></i>Prénom</th>
                <th><i class="fas fa-envelope me-2"></i>Email</th>
                <th><i class="fas fa-graduation-cap me-2"></i>Filière</th>
                <th><i class="fas fa-clock me-2"></i>Semestre</th>
                <th><i class="fas fa-cogs me-2"></i>Actions</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="etudiant" items="${etudiants}">
                <tr>
                    <td>
                        <img src="${empty etudiant.image ? 'https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/assets/img/avatars/profile.jpg' : etudiant.image}"
                             onerror="this.src='data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSI1MCIgaGVpZ2h0PSI1MCIgdmlld0JveD0iMCAwIDUwIDUwIj48Y2lyY2xlIGN4PSIyNSIgY3k9IjE4IiByPSI4IiBmaWxsPSIjNjc3MjgwIi8+PHBhdGggZD0iTTI1IDMwYy04IDAtMTUgNC0xNSA5djNoMzB2LTNjMC01LTctOS0xNS05eiIgZmlsbD0iIzY3NzI4MCIvPjwvc3ZnPg=='"
                             alt="Profile" class="student-img">
                    </td>
                    <td>${etudiant.codeEtudiant}</td>
                    <td>${etudiant.CNE}</td>
                    <td>${etudiant.nomEtudiant}</td>
                    <td>${etudiant.prenomEtudiant}</td>
                    <td>
                        <span class="badge bg-light text-dark">
                            <i class="fas fa-envelope me-1"></i>${etudiant.email}
                        </span>
                    </td>
                    <td>
                        <span class="badge badge-custom bg-info">
                                ${etudiant.filliere.nomFilliere}
                        </span>
                    </td>
                    <td>
                        <span class="badge badge-custom bg-success">
                                ${etudiant.semestre.nom_Semestre}
                        </span>
                    </td>
                    <td>
                        <div class="btn-group">
                            <a href="${pageContext.request.contextPath}/etudiants/edit/${etudiant.codeEtudiant}"
                               class="btn action-btn btn-edit">
                                <i class="fas fa-edit"></i>
                            </a>
                            <a href="${pageContext.request.contextPath}/etudiants/delete/${etudiant.codeEtudiant}"
                               class="btn action-btn btn-delete">
                                <i class="fas fa-trash"></i>
                            </a>
                        </div>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(document).ready(function() {
        function updateTable(data) {
            const tableBody = $('tbody');
            tableBody.empty();

            if (data.length === 0) {
                tableBody.html('<tr><td colspan="9" class="no-data-message">Aucun étudiant trouvé</td></tr>');
                return;
            }

            data.forEach(function(etudiant) {
                const defaultImage = 'data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSI1MCIgaGVpZ2h0PSI1MCIgdmlld0JveD0iMCAwIDUwIDUwIj48Y2lyY2xlIGN4PSIyNSIgY3k9IjE4IiByPSI4IiBmaWxsPSIjNjc3MjgwIi8+PHBhdGggZD0iTTI1IDMwYy04IDAtMTUgNC0xNSA5djNoMzB2LTNjMC01LTctOS0xNS05eiIgZmlsbD0iIzY3NzI4MCIvPjwvc3ZnPg==';
                const row = `
                        <tr>
                            <td>
                                <img src="\${etudiant.image || defaultImage}"
                                     onerror="this.src='\${defaultImage}'"
                                     alt="Profile" class="student-img">
                            </td>
                            <td>\${etudiant.codeEtudiant || ''}</td>
                            <td>\${etudiant.CNE || ''}</td>
                            <td>\${etudiant.nomEtudiant || ''}</td>
                            <td>\${etudiant.prenomEtudiant || ''}</td>
                            <td>
                                <span class="badge bg-light text-dark">
                                    <i class="fas fa-envelope me-1"></i>\${etudiant.email || ''}
                                </span>
                            </td>
                            <td>
                                <span class="badge badge-custom bg-info">
                                    \${etudiant.filliere ? etudiant.filliere.nomFilliere : ''}
                                </span>
                            </td>
                            <td>
                                <span class="badge badge-custom bg-success">
                                    \${etudiant.semestre ? etudiant.semestre.nom_Semestre : ''}
                                </span>
                            </td>
                            <td>
                                <div class="btn-group">
                                    <a href="${pageContext.request.contextPath}/etudiants/edit/\${etudiant.codeEtudiant}"
                                       class="btn action-btn btn-edit">
                                        <i class="fas fa-edit"></i>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/etudiants/delete/\${etudiant.codeEtudiant}"
                                       class="btn action-btn btn-delete">
                                        <i class="fas fa-trash"></i>
                                    </a>
                                </div>
                            </td>
                        </tr>
                    `;
                tableBody.append(row);
            });
        }

        $('#searchForm').on('submit', function(e) {
            e.preventDefault();
            const form = $(this);
            const submitButton = form.find('button[type="submit"]');
            const spinner = submitButton.find('.loading-spinner');

            $.ajax({
                url: '${pageContext.request.contextPath}/etudiants/search',
                type: 'GET',
                data: form.serialize(),
                beforeSend: function() {
                    submitButton.prop('disabled', true);
                    spinner.show();
                    $('tbody').addClass('opacity-50');
                },
                success: function(data) {
                    updateTable(data);
                },
                error: function(xhr, status, error) {
                    console.error('Erreur lors de la recherche:', error);
                    alert('Une erreur est survenue lors de la recherche. Veuillez réessayer.');
                },
                complete: function() {
                    submitButton.prop('disabled', false);
                    spinner.hide();
                    $('tbody').removeClass('opacity-50');
                }
            });
        });
    });
</script>
</body>
</html>