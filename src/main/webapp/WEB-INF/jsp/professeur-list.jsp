<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Professors List</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .professor-card {
            transition: transform 0.2s, box-shadow 0.2s;
            height: 100%;
        }

        .professor-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }

        .profile-image {
            width: 120px;
            height: 120px;
            object-fit: cover;
            border-radius: 50%;
            border: 3px solid #fff;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .status-indicator {
            width: 15px;
            height: 15px;
            border-radius: 50%;
            display: inline-block;
            margin-right: 5px;
        }

        .card-header {
            background-color: #f8f9fa;
            border-bottom: none;
        }

        .search-section {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }

        .professor-info {
            font-size: 0.9rem;
        }

        .professor-info i {
            width: 20px;
            color: #6c757d;
        }

        .actions-buttons {
            border-top: 1px solid rgba(0,0,0,0.1);
            padding-top: 1rem;
        }
    </style>
</head>
<body class="bg-light">
<jsp:include page="header.jsp" />
<div class="container py-5">
    <h1 class="text-center mb-5">Liste des Professeurs</h1>

    <div class="search-section mb-5">
        <div class="row g-3">
            <div class="col-md-4">
                <div class="input-group">
                    <span class="input-group-text"><i class="fas fa-search"></i></span>
                    <input type="text" id="searchInput" class="form-control" placeholder="Rechercher par nom ou prénom">
                </div>
            </div>
            <div class="col-md-4">
                <select id="specialitySelect" class="form-select">
                    <option value="">Tous Les specialites</option>
                    <c:forEach var="specialite" items="${specialites}">
                        <option value="${specialite}">${specialite}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="col-md-4 text-end">
                <a href="${pageContext.request.contextPath}/professeurs/add" class="btn btn-success">
                    <i class="fas fa-plus-circle me-2"></i>Ajouter un Professeur
                </a>
            </div>
        </div>
    </div>

    <div class="row g-4" id="professorsContainer">
        <c:forEach var="professeur" items="${professeurs}">
            <div class="col-md-6 col-lg-4">
                <div class="card professor-card">
                    <div class="card-header text-center pt-4">
                        <c:choose>
                            <c:when test="${professeur.image != null}">
                                <img src="${professeur.image}" alt="Profile" class="profile-image mb-3">
                            </c:when>
                            <c:otherwise>
                                <div class="profile-image mb-3 bg-secondary d-flex align-items-center justify-content-center">
                                    <i class="fas fa-user fa-3x text-white"></i>
                                </div>
                            </c:otherwise>
                        </c:choose>
                        <h5 class="card-title mb-0">${professeur.prenom} ${professeur.nom}</h5>
                        <p class="text-muted small mb-0">${professeur.specialite}</p>
                    </div>
                    <div class="card-body">
                        <div class="professor-info">
                            <p class="mb-2">
                                <i class="fas fa-id-card"></i>
                                <span class="ms-2">Code: ${professeur.code}</span>
                            </p>
                            <p class="mb-3">
                                <i class="fas fa-user-circle"></i>
                                <span class="ms-2">
                                    Statut du compte:
                                    <span class="status-indicator ${not empty professeur.comptes ? 'bg-success' : 'bg-danger'}"></span>
                                    ${not empty professeur.comptes ? 'Actif' : 'Inactif'}
                                </span>
                            </p>
                        </div>
                        <div class="actions-buttons pt-2">
                            <div class="d-flex justify-content-between">
                                <div>
                                    <a href="${pageContext.request.contextPath}/professeurs/edit/${professeur.code}"
                                       class="btn btn-outline-primary btn-sm">
                                        <i class="fas fa-edit me-1"></i>Modifier
                                    </a>
                                    <a href="${pageContext.request.contextPath}/professeurs/delete/${professeur.code}"
                                       class="btn btn-outline-danger btn-sm ms-2"
                                       onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce professeur ?')">
                                        <i class="fas fa-trash-alt me-1"></i>Supprimer
                                    </a>
                                </div>
                                <a href="${pageContext.request.contextPath}/utilisateur/CreerCompte/${professeur.code}"
                                   class="btn btn-outline-success btn-sm">
                                    <i class="fas fa-user-plus me-1"></i>Créer Compte
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<script>
    $(document).ready(function() {
        let searchTimeout;

        function updateCards(data) {
            const container = $('#professorsContainer');
            container.empty();

            if (data.length === 0) {
                container.append(`
                    <div class="col-12 text-center">
                        <div class="alert alert-info">
                            Aucun professeur trouvé
                        </div>
                    </div>
                `);
                return;
            }

            data.forEach(function(professeur) {
                const hasAccount = professeur.comptes && professeur.comptes.length > 0;
                const card = `
<div class="col-md-6 col-lg-4">
    <div class="card professor-card">
        <div class="card-header text-center pt-4">
            ${professeur.image}
            <h5 class="card-title mb-0">\${professeur.prenom} \${professeur.nom}</h5>
            <p class="text-muted small mb-0">\${professeur.specialite}</p>
        </div>
        <div class="card-body">
            <div class="professor-info">
                <p class="mb-2">
                    <i class="fas fa-id-card"></i>
                    <span class="ms-2">Code: \${professeur.code}</span>
                </p>
                <p class="mb-3">
                    <i class="fas fa-user-circle"></i>
                    <span class="ms-2">
                        Statut du compte:
                        <span class="status-indicator \${hasAccount ? 'bg-success' : 'bg-danger'}"></span>
                        \${hasAccount ? 'Actif' : 'Inactif'}
                    </span>
                </p>
            </div>
            <div class="actions-buttons pt-2">
                <div class="d-flex justify-content-between">
                    <div>
                        <a href="${pageContext.request.contextPath}/professeurs/edit/\${professeur.code}"
                           class="btn btn-outline-primary btn-sm">
                            <i class="fas fa-edit me-1"></i>Modifier
                        </a>
                        <a href="${pageContext.request.contextPath}/professeurs/delete/\${professeur.code}"
                           class="btn btn-outline-danger btn-sm ms-2"
                           onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce professeur ?')">
                            <i class="fas fa-trash-alt me-1"></i>Supprimer
                        </a>
                    </div>
                    <a href="${pageContext.request.contextPath}/utilisateur/CreerCompte/\${professeur.code}"
                       class="btn btn-outline-success btn-sm">
                        <i class="fas fa-user-plus me-1"></i>Créer Compte
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>
`;
                container.append(card);
            });
        }

        function performSearch() {
            const searchTerm = $('#searchInput').val().trim();
            const specialite = $('#specialitySelect').val();

            clearTimeout(searchTimeout);

            searchTimeout = setTimeout(function() {
                $.ajax({
                    url: `${pageContext.request.contextPath}/professeurs/search`,
                    type: 'GET',
                    data: {
                        searchTerm: searchTerm,
                        specialite: specialite
                    },
                    beforeSend: function() {
                        $('#professorsContainer').addClass('opacity-50');
                    },
                    success: function(data) {
                        updateCards(data);
                    },
                    error: function(xhr, status, error) {
                        console.error('Error during search:', error);
                        $('#professorsContainer').html(`
                            <div class="col-12 text-center">
                                <div class="alert alert-danger">
                                    Une erreur est survenue lors de la recherche. Veuillez réessayer.
                                </div>
                            </div>
                        `);
                    },
                    complete: function() {
                        $('#professorsContainer').removeClass('opacity-50');
                    }
                });
            }, 300);
        }

        $('#searchInput').on('input', performSearch);
        $('#specialitySelect').on('change', performSearch);
    });
</script>
</body>
</html>