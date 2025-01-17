<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liste des Éléments</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.css" rel="stylesheet">

    <style>
        :root {
            --primary-color: #5f98da;
            --secondary-color: #858796;
            --success-color: #1cc88a;
        }

        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #e4e8f1 100%);
            padding-top: 0 !important; /* Empêche le décalage par d'autres headers */
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

        .card {
            border: none;
            border-radius: 15px;
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(10px);
            transition: all 0.4s ease;
            overflow: hidden;
        }

        .card:hover {
            transform: translateY(-10px) scale(1.02);
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
        }

        .progress-circle {
            position: absolute;
            top: 15px;
            right: 15px;
            width: 60px;
            height: 60px;
            background: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            color: var(--primary-color);
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.1);
        }

        .progress-circle::before {
            content: '';
            position: absolute;
            width: 54px;
            height: 54px;
            border-radius: 50%;
            border: 3px solid #e9ecef;
            border-top: 3px solid var(--primary-color);
            animation: rotate 1s linear infinite;
            opacity: 0;
            transition: opacity 0.3s;
        }

        .card:hover .progress-circle::before {
            opacity: 1;
        }

        @keyframes rotate {
            100% {
                transform: rotate(360deg);
            }
        }

        .page-title {
            color: var(--primary-color);
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 2px;
            position: relative;
            padding-bottom: 10px;
        }

        .add-btn {
            background: linear-gradient(45deg, var(--primary-color), var(--success-color));
            border: none;
            padding: 12px 25px;
            border-radius: 25px;
            transition: all 0.3s ease;
        }

        .add-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }

        .filter-card {
            border: none;
            border-radius: 15px;
            background: rgba(255, 255, 255, 0.95);
            margin-bottom: 2rem;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
        }

        .form-control, .form-select {
            border-radius: 10px;
            border: 1px solid rgba(0, 0, 0, 0.1);
            padding: 0.75rem 1rem;
        }

        .btn-custom {
            border-radius: 20px;
            padding: 8px 20px;
            font-weight: 500;
            letter-spacing: 1px;
            transition: all 0.3s ease;
        }

        .btn-custom:hover {
            transform: translateY(-2px);
        }

        .card-actions {
            opacity: 0;
            transform: translateY(20px);
            transition: all 0.3s ease;
        }

        .card:hover .card-actions {
            opacity: 1;
            transform: translateY(0);
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
                    <a class="nav-link active" href="${pageContext.request.contextPath}/elements">
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
        <h2 class="page-title">Liste des Éléments</h2>
        <a href="${pageContext.request.contextPath}/elements/add" class="btn add-btn text-white">
            <i class="fas fa-plus-circle me-2"></i>Nouvel Élément
        </a>
    </div>

    <!-- Filtres -->
    <div class="filter-card card p-4 mb-4" data-aos="fade-up">
        <div class="row g-3">
            <div class="col-md-4">
                <div class="form-floating">
                    <input type="text" id="searchInput" class="form-control" placeholder="Rechercher..." value="${searchTerm}">
                    <label for="searchInput">Rechercher un élément</label>
                </div>
            </div>
            <div class="col-md-4">
                <div class="form-floating">
                    <select id="moduleFilter" class="form-select">
                        <option value="">Tous les modules</option>
                        <c:forEach var="module" items="${modules}">
                            <option value="${module.codeModule}" ${module.codeModule eq selectedModule ? 'selected' : ''}>
                                    ${module.nomModule}
                            </option>
                        </c:forEach>
                    </select>
                    <label for="moduleFilter">Filtrer par module</label>
                </div>
            </div>
            <div class="col-md-4">
                <div class="form-floating">
                    <select id="professeurFilter" class="form-select">
                        <option value="">Tous les professeurs</option>
                        <c:forEach var="prof" items="${professeurs}">
                            <option value="${prof.code}" ${prof.code eq selectedProf ? 'selected' : ''}>
                                    ${prof.nom} ${prof.prenom}
                            </option>
                        </c:forEach>
                    </select>
                    <label for="professeurFilter">Filtrer par professeur</label>
                </div>
            </div>
        </div>
    </div>

    <!-- Liste des éléments -->
    <div class="row g-4">
        <c:choose>
            <c:when test="${not empty elements}">
                <c:forEach var="element" items="${elements}" varStatus="status">
                    <div class="col-md-4" data-aos="fade-up" data-aos-delay="${status.index * 100}">
                        <div class="card h-100">
                            <!-- Nouveau design pour le coefficient -->
                            <div class="progress-circle">
                                    ${element.coefficient}
                            </div>
                            <div class="card-body p-4">
                                <h5 class="card-title fw-bold mb-3">
                                    <i class="fas fa-book me-2 text-primary"></i>
                                        ${element.nomElement}
                                </h5>
                                <div class="mb-2">
                                    <i class="fas fa-layer-group text-primary me-2"></i>
                                    <strong>Module:</strong> ${element.module.nomModule}
                                </div>
                                <div class="mb-2">
                                    <i class="fas fa-user-tie text-primary me-2"></i>
                                    <strong>Professeur:</strong> ${element.professeur.nom} ${element.professeur.prenom}
                                </div>
                                <div class="mb-2">
                                    <i class="fas fa-hashtag text-primary me-2"></i>
                                    <strong>Code:</strong> ${element.idElement}
                                </div>
                                <div class="card-actions mt-4">
                                    <div class="d-flex justify-content-between gap-2">
                                        <a href="${pageContext.request.contextPath}/elements/edit/${element.idElement}"
                                           class="btn btn-custom btn-warning flex-grow-1">
                                            <i class="fas fa-edit me-2"></i>Modifier
                                        </a>
                                        <a href="${pageContext.request.contextPath}/elements/Details/${element.idElement}"
                                           class="btn btn-custom btn-info flex-grow-1 text-white">
                                            <i class="fas fa-eye me-2"></i>Voir Détails
                                        </a>
                                        <button onclick="confirmDelete('${element.idElement}')"
                                                class="btn btn-custom btn-danger flex-grow-1">
                                            <i class="fas fa-trash-alt me-2"></i>Supprimer
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="col-12">
                    <div class="alert alert-info text-center" role="alert">
                        <i class="fas fa-info-circle me-2"></i>
                        Aucun élément trouvé
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<!-- Modal de confirmation -->
<div class="modal fade" id="deleteModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Confirmation de suppression</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                Êtes-vous sûr de vouloir supprimer cet élément ?
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary rounded-pill" data-bs-dismiss="modal">Annuler</button>
                <a href="#" id="confirmDeleteButton" class="btn btn-danger rounded-pill">Supprimer</a>
            </div>
        </div>
    </div>
</div>

<!-- Scripts -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.js"></script>
<script>
    // Initialisation AOS
    AOS.init({
        duration: 800,
        once: true
    });

    // Filtrage
    $(document).ready(function() {
        function filterElements() {
            const moduleId = $('#moduleFilter').val();
            const profId = $('#professeurFilter').val();
            const searchTerm = $('#searchInput').val();

            window.location.href = '${pageContext.request.contextPath}/elements?' +
                'moduleId=' + encodeURIComponent(moduleId) +
                '&profId=' + encodeURIComponent(profId) +
                '&searchTerm=' + encodeURIComponent(searchTerm);
        }

        let timeoutId;
        $('#searchInput').on('input', function() {
            clearTimeout(timeoutId);
            timeoutId = setTimeout(filterElements, 300);
        });

        $('#moduleFilter, #professeurFilter').on('change', filterElements);
    });

    function confirmDelete(elementId) {
        const modal = new bootstrap.Modal(document.getElementById('deleteModal'));
        const deleteButton = document.getElementById('confirmDeleteButton');
        deleteButton.setAttribute('href', '${pageContext.request.contextPath}/elements/delete/' + elementId);
        modal.show();
    }
</script>
</body>
</html>