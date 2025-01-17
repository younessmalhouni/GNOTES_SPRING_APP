<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Mes Éléments</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        :root {
            --primary-gradient: linear-gradient(45deg, #2980b9, #2c3e50);
            --hover-gradient: linear-gradient(45deg, #3498db, #2980b9);
            --card-shadow: 0 8px 25px rgba(52, 152, 219, 0.4);
            --sidebar-width: 280px;
            --header-height: 70px;
            --transition: all 0.3s ease;
        }

        body {
            padding-top: var(--header-height);
        }

        .main-content {
            transition: var(--transition);
            padding: 20px;
            margin-left: 0;
        }

        .sidebar.show + .main-content {
            margin-left: var(--sidebar-width);
        }

        .element-card {
            transition: all 0.3s ease;
            border: none;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }

        .element-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 15px rgba(0, 0, 0, 0.15);
        }

        .coefficient-badge {
            position: absolute;
            top: 10px;
            right: 10px;
            background: var(--primary-gradient);
            border: none;
            padding: 8px 15px;
        }

        .filters-section {
            background: white;
            padding: 20px;
            border-radius: 15px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
            margin-bottom: 30px;
        }

        .form-control, .form-select {
            border-radius: 10px;
            border: 1px solid #e0e0e0;
            padding: 10px 15px;
        }

        .form-control:focus, .form-select:focus {
            box-shadow: 0 0 0 0.25rem rgba(41, 128, 185, 0.25);
            border-color: #2980b9;
        }

        .card-title {
            color: #2c3e50;
            font-weight: 600;
        }

        .card-subtitle {
            color: #7f8c8d;
        }

        .card-footer {
            background: transparent;
            border-top: 1px solid rgba(0, 0, 0, 0.05);
            padding: 15px;
        }

        .btn-custom-primary {
            background: var(--primary-gradient);
            border: none;
            color: white;
            padding: 8px 20px;
            border-radius: 8px;
            transition: all 0.3s ease;
        }

        .btn-custom-primary:hover {
            background: var(--hover-gradient);
            transform: translateY(-2px);
        }

        .element-stats {
            display: flex;
            gap: 15px;
            margin-top: 15px;
            padding-top: 15px;
            border-top: 1px solid rgba(0, 0, 0, 0.05);
        }

        .stat-item {
            flex: 1;
            text-align: center;
            padding: 10px;
            background: #f8f9fa;
            border-radius: 8px;
        }

        .stat-value {
            font-size: 1.2rem;
            font-weight: 600;
            color: #2980b9;
        }

        .stat-label {
            font-size: 0.8rem;
            color: #7f8c8d;
        }

        @media (max-width: 768px) {
            .sidebar.show + .main-content {
                margin-left: 0;
            }
        }

    </style>
</head>
<body>

<!-- Inclusion du header -->
<jsp:include page="headerprof.jsp" />

<div class="main-content" id="main-content">
    <div class="container">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="mb-0">Mes Éléments d'Enseignement</h2>

        </div>

        <div class="filters-section">
            <div class="row g-3">
                <div class="col-md-3">
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-search"></i></span>
                        <input type="text" class="form-control" id="searchTerm"
                               placeholder="Rechercher un élément"
                               value="${param.searchTerm}">
                    </div>
                </div>
                <div class="col-md-3">
                    <select class="form-select" id="filliereId">
                        <option value="">Toutes les filières</option>
                        <c:forEach var="filliere" items="${fillieres}">
                            <option value="${filliere.idFilliere}"
                                ${param.filliereId eq filliere.idFilliere ? 'selected' : ''}>
                                    ${filliere.nomFilliere}
                            </option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-3">
                    <select class="form-select" id="semestreId">
                        <option value="">Tous les semestres</option>
                        <c:forEach var="semestre" items="${semestres}">
                            <option value="${semestre.id_Semestre}"
                                ${param.semestreId eq semestre.id_Semestre ? 'selected' : ''}>
                                    ${semestre.nom_Semestre}
                            </option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-3">
                    <select class="form-select" id="codeModule">
                        <option value="">Tous les modules</option>
                        <c:forEach var="module" items="${modules}">
                            <option value="${module.codeModule}"
                                ${param.codeModule eq module.codeModule ? 'selected' : ''}>
                                    ${module.nomModule}
                            </option>
                        </c:forEach>
                    </select>
                </div>
            </div>
        </div>

        <c:if test="${empty elements}">
            <div class="alert alert-info">
                <i class="fas fa-info-circle me-2"></i>
                Aucun élément n'est assigné à votre charge.
            </div>
        </c:if>

        <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4">
            <c:forEach var="element" items="${elements}">
                <div class="col">
                    <div class="card h-100 element-card">
                        <div class="card-body">
                            <span class="badge coefficient-badge">Coef: ${element.coefficient}</span>
                            <h5 class="card-title">${element.nomElement}</h5>
                            <h6 class="card-subtitle mb-2 text-muted">
                                <i class="fas fa-book me-2"></i>${element.module.nomModule}
                            </h6>

                            <div class="mt-3">
                                <h6 class="fw-bold"><i class="fas fa-tasks me-2"></i>Modalités d'évaluation:</h6>
                                <ul class="list-unstyled">
                                    <c:forEach var="modalite" items="${element.modalites}">
                                        <li class="mb-2">
                                            <i class="fas fa-check-circle me-2 text-success"></i>
                                            <span class="text-muted">
                                                ${modalite.type_Modalite} (${modalite.coeffecient}%)
                                            </span>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </div>

                            <div class="element-stats">
                                <div class="stat-item">
                                    <div class="stat-value">32</div>
                                    <div class="stat-label">Étudiants</div>
                                </div>
                                <div class="stat-item">
                                    <div class="stat-value">75%</div>
                                    <div class="stat-label">Réussite</div>
                                </div>
                                <div class="stat-item">
                                    <div class="stat-value">16</div>
                                    <div class="stat-label">Moyenne</div>
                                </div>
                            </div>
                        </div>
                        <div class="card-footer">
                            <div class="d-flex gap-2 justify-content-between">
                                <button class="btn btn-custom-primary"
                                        onclick="redirectToNotes('${element.module.codeModule}', '${element.idElement}')">
                                    <i class="fas fa-pen me-2"></i>Gérer les Notes
                                </button>
                                <div class="btn-group">
                                    <button class="btn btn-outline-secondary">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                    <button class="btn btn-outline-primary"
                                            onclick="redirectlistAexporter('${element.module.codeModule}','${element.idElement}')">
                                        <i class="fas fa-file-export"></i>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    $(document).ready(function() {
        $('#searchTerm').val(decodeURIComponent('${param.searchTerm}' || ''));

        function filterElements() {
            const searchTerm = $('#searchTerm').val();
            const filliereId = $('#filliereId').val();
            const semestreId = $('#semestreId').val();
            const codeModule = $('#codeModule').val();

            window.location.href = '${pageContext.request.contextPath}/professeur/elements?' +
                'searchTerm=' + encodeURIComponent(searchTerm) +
                '&filliereId=' + encodeURIComponent(filliereId) +
                '&semestreId=' + encodeURIComponent(semestreId) +
                '&codeModule=' + encodeURIComponent(codeModule);
        }

        let timeoutId;
        $('#searchTerm').on('input', function() {
            clearTimeout(timeoutId);
            timeoutId = setTimeout(filterElements, 300);
        });

        $('#filliereId, #semestreId, #codeModule').on('change', filterElements);

        // Ajuster le contenu principal quand la sidebar change
        const sidebar = document.getElementById('sidebar');
        const mainContent = document.getElementById('main-content');

        const observer = new MutationObserver(function(mutations) {
            mutations.forEach(function(mutation) {
                if (mutation.attributeName === 'class') {
                    if (sidebar.classList.contains('show')) {
                        mainContent.style.marginLeft = 'var(--sidebar-width)';
                    } else {
                        mainContent.style.marginLeft = '0';
                    }
                }
            });
        });

        observer.observe(sidebar, { attributes: true });
    });

    function redirectToNotes(codeModule, idElement) {
        window.location.href = `${pageContext.request.contextPath}/professeur/etudiants?searchTerm=&filliereId=&semestreId=&codeModule=&idElement=\${encodeURIComponent(idElement)}`;
    }

    function redirectlistAexporter(codeModule, idElement) {
        window.location.href = `${pageContext.request.contextPath}/professeur/etudiants/listAExporter/\${idElement}?searchTerm=&filliereId=&semestreId=&codeModule=\${encodeURIComponent(codeModule)}`;
    }
</script>

</body>
</html>