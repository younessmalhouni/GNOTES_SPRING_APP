<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liste des Éléments</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.css" rel="stylesheet">

    <style>
        :root {
            --primary-color: #4e73df;
            --secondary-color: #858796;
            --success-color: #1cc88a;
        }

        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #e4e8f1 100%);
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

        .card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 4px;
            background: linear-gradient(90deg, var(--primary-color), var(--success-color));
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

        .form-floating .form-control,
        .form-floating .form-select {
            border-radius: 10px;
            border: 1px solid rgba(0, 0, 0, 0.1);
        }

        .coefficient-badge {
            position: absolute;
            top: 15px;
            right: 15px;
            background: linear-gradient(45deg, var(--primary-color), var(--success-color));
            border-radius: 20px;
            padding: 5px 15px;
            font-weight: 500;
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

        .modal-content {
            border-radius: 15px;
            border: none;
        }

        .modal-header {
            background: linear-gradient(45deg, var(--primary-color), var(--success-color));
            color: white;
            border-radius: 15px 15px 0 0;
        }

        .btn-close {
            filter: brightness(0) invert(1);
        }
    </style>
    <jsp:include page="header.jsp"/>
</head>
<body>
<div class="container py-5">
    <!-- Header -->
    <div class="d-flex justify-content-between align-items-center mb-5" data-aos="fade-down">
        <h2 class="page-title">Liste des Éléments</h2>
        <a href="${pageContext.request.contextPath}/elements/add" class="btn add-btn text-white">
            <i class="fas fa-plus-circle me-2"></i>Nouvel Élément
        </a>
    </div>

    <!-- Filtres -->
    <div class="filter-card card p-4" data-aos="fade-up">
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
                            <div class="coefficient-badge text-white">
                                Coefficient: ${element.coefficient}
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

    // Confirmation de suppression
    function confirmDelete(elementId) {
        const modal = new bootstrap.Modal(document.getElementById('deleteModal'));
        const deleteButton = document.getElementById('confirmDeleteButton');
        deleteButton.href = '${pageContext.request.contextPath}/elements/delete/' + elementId;
        modal.show();
    }
</script>
</body>
</html>
