<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Notes du Module</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet"/>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.29/jspdf.plugin.autotable.min.js"></script>
    <style>
        :root {
            --primary-gradient: linear-gradient(45deg, #3498db, #2980b9);
        }

        body {
            background-color: #f8f9fa;
        }

        .page-header {
            background: var(--primary-gradient);
            color: white;
            padding: 2rem 0;
            margin-bottom: 2rem;
            border-radius: 0 0 0.75rem 0.75rem;
            box-shadow: 0 4px 15px rgba(52, 152, 219, 0.3);
        }

        .filter-section {
            background: white;
            border-radius: 0.75rem;
            padding: 0.75rem;
            margin-bottom: 2rem;
            box-shadow: 0 4px 15px rgba(52, 152, 219, 0.1);
        }

        .table-container {
            background: white;
            border-radius: 0.75rem;
            padding: 0.75rem;
            box-shadow: 0 4px 15px rgba(52, 152, 219, 0.1);
        }

        .table th {
            background: var(--primary-gradient);
            color: white;
            border: none;
            font-weight: 600;
            letter-spacing: 0.5px;
            padding: 0.75rem;
        }

        .grade-badge {
            padding: 0.75rem;
            border-radius: 0.75rem;
            font-weight: 600;
            letter-spacing: 0.5px;
        }

        .search-input, .filter-select {
            padding: 0.75rem;
            border-radius: 0.75rem;
            border: 1px solid #dee2e6;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .search-input:focus, .filter-select:focus {
            border-color: #3498db;
            box-shadow: 0 0 0 0.2rem rgba(52, 152, 219, 0.25);
        }

        .btn-custom {
            background: var(--primary-gradient);
            color: white;
            padding: 0.75rem;
            border-radius: 0.75rem;
            font-weight: 600;
            letter-spacing: 0.5px;
            box-shadow: 0 4px 15px rgba(52, 152, 219, 0.3);
            transition: all 0.3s ease;
            border: none;
        }

        .btn-custom:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(52, 152, 219, 0.4);
        }

        .loading-spinner {
            display: none;
            margin-left: 1rem;
        }
        .btn-export {
            background: linear-gradient(45deg, #27ae60, #2ecc71);
            color: white;
            padding: 0.75rem 1.5rem;
            border-radius: 0.75rem;
            font-weight: 600;
            letter-spacing: 0.5px;
            box-shadow: 0 4px 15px rgba(39, 174, 96, 0.3);
            transition: all 0.3s ease;
            border: none;
            margin-left: 1rem;
        }

        .btn-export:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(39, 174, 96, 0.4);
            color: white;
        }

        .header-actions {
            display: flex;
            align-items: center;
        }
    </style>
    <jsp:include page="header.jsp" />
</head>
<body>
<div class="page-header">
    <div class="container">
        <div class="d-flex justify-content-between align-items-center">
            <div>
                <h1 class="mb-2">Notes du Module</h1>
                <h4 class="mb-0">${module.nomModule} (${module.codeModule})</h4>
            </div>
            <div class="header-actions">
                <button onclick="exportToPDF()" class="btn-export">
                    <i class="fas fa-file-pdf me-2"></i>Exporter PDF
                </button>
                <a href="${pageContext.request.contextPath}/modules" class="btn-custom ms-3">
                    <i class="fas fa-arrow-left me-2"></i>Retour aux Modules
                </a>
            </div>
        </div>
    </div>
</div>

<div class="container">
    <div class="filter-section">
        <form id="searchForm" class="row g-3">
            <div class="col-md-3">
                <input type="text" name="searchTerm" class="form-control search-input"
                       placeholder="Rechercher un étudiant..." value="${param.searchTerm}"/>
            </div>
            <div class="col-md-3">
                <select name="filliereId" class="form-select filter-select">
                    <option value="">Toutes les Filières</option>
                    <c:forEach var="filliere" items="${fillieres}">
                        <option value="${filliere.idFilliere}" ${param.filliereId == filliere.idFilliere ? 'selected' : ''}>
                                ${filliere.nomFilliere}
                        </option>
                    </c:forEach>
                </select>
            </div>
            <div class="col-md-3">
                <select name="semestreId" class="form-select filter-select">
                    <option value="">Tous les Semestres</option>
                    <c:forEach var="semestre" items="${semestres}">
                        <option value="${semestre.id_Semestre}" ${param.semestreId == semestre.id_Semestre ? 'selected' : ''}>
                                ${semestre.nom_Semestre}
                        </option>
                    </c:forEach>
                </select>
            </div>
            <div class="col-md-3 d-flex align-items-center">
                <div class="loading-spinner">
                    <div class="spinner-border text-primary" role="status">
                        <span class="visually-hidden">Chargement...</span>
                    </div>
                </div>
            </div>
        </form>
    </div>

    <div class="table-container">
        <table class="table table-hover">
            <thead>
            <tr>
                <th>Code Étudiant</th>
                <th>Nom Complet</th>
                <th>Filière</th>
                <th>Éléments</th>
                <th>Note Finale</th>
            </tr>
            </thead>
            <tbody id="studentsTableBody">
            <c:forEach var="etudiant" items="${etudiants}">
                <tr>
                    <td>${etudiant.codeEtudiant}</td>
                    <td>${etudiant.nomEtudiant} ${etudiant.prenomEtudiant}</td>
                    <td>${etudiant.filliere.nomFilliere}</td>
                    <td>
                        <c:forEach var="element" items="${elements}">
                            <div class="mb-1">
                                <strong>${element.nomElement}:</strong>
                                <span class="ms-2">
                                        ${noteElementService.getNoteElementByElementAndEtudiant(element.idElement, etudiant.codeEtudiant) != null ? noteElementService.getNoteElementByElementAndEtudiant(element.idElement, etudiant.codeEtudiant).noteElement : 'N/A'}
                                </span>
                            </div>
                        </c:forEach>
                    </td>
                    <td>
                        <c:set var="moduleNote" value="${moduleService.CalculerNoteModule(module.codeModule, etudiant.codeEtudiant)}"/>
                        <span class="grade-badge ${moduleNote >= 12 ? 'bg-success' : moduleNote >= 10 ? 'bg-warning' : 'bg-danger'}">
                                ${moduleNote != null ? moduleNote : 'N/A'}
                        </span>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        const form = document.getElementById('searchForm');
        const loadingSpinner = document.querySelector('.loading-spinner');
        let timeout = null;

        function updateResults() {
            loadingSpinner.style.display = 'block';

            const formData = new FormData(form);
            const params = new URLSearchParams(formData);

            fetch(window.location.pathname + '?' + params.toString())
                .then(response => response.text())
                .then(html => {
                    const parser = new DOMParser();
                    const doc = parser.parseFromString(html, 'text/html');
                    document.getElementById('studentsTableBody').innerHTML =
                        doc.getElementById('studentsTableBody').innerHTML;
                    loadingSpinner.style.display = 'none';
                })
                .catch(error => {
                    console.error('Erreur:', error);
                    loadingSpinner.style.display = 'none';
                });
        }

        // Add event listeners for all inputs and selects
        form.querySelectorAll('input, select').forEach(element => {
            element.addEventListener('input', () => {
                clearTimeout(timeout);
                timeout = setTimeout(updateResults, 300);
            });

            element.addEventListener('change', () => {
                clearTimeout(timeout);
                timeout = setTimeout(updateResults, 300);
            });
        });
    });


    function exportToPDF() {
        const { jsPDF } = window.jspdf;
        const doc = new jsPDF();

        // Add header
        doc.setFontSize(20);
        doc.text('Notes du Module', 14, 15);

        doc.setFontSize(12);
        doc.text(`Module: \${document.querySelector('h4').textContent}`, 14, 25);

        // Prepare table data
        const table = document.querySelector('table');
        const rows = Array.from(table.querySelectorAll('tbody tr'));

        const tableData = rows.map(row => [
            row.cells[0].textContent.trim(),
            row.cells[1].textContent.trim(),
            row.cells[2].textContent.trim(),
            row.cells[4].textContent.trim() // Final grade
        ]);

        // Add the table
        doc.autoTable({
            head: [['Code Étudiant', 'Nom Complet', 'Filière', 'Note Finale']],
            body: tableData,
            startY: 35,
            styles: {
                fontSize: 10,
                cellPadding: 3,
                lineColor: [44, 62, 80],
                lineWidth: 0.1
            },
            headStyles: {
                fillColor: [52, 152, 219],
                textColor: 255,
                fontStyle: 'bold'
            },
            alternateRowStyles: {
                fillColor: [241, 245, 249]
            },
            margin: { top: 35 }
        });

        // Add footer
        const pageCount = doc.internal.getNumberOfPages();
        for (let i = 1; i <= pageCount; i++) {
            doc.setPage(i);
            doc.setFontSize(10);
            doc.text(
                `Page \${i} sur \${pageCount}`,
                doc.internal.pageSize.width / 2,
                doc.internal.pageSize.height - 10,
                { align: 'center' }
            );
        }

        // Get current date for filename
        const date = new Date().toISOString().split('T')[0];
        const moduleCode = document.querySelector('h4').textContent.match(/\((.*?)\)/)[1];
        const moduleName = document.querySelector('h4').textContent.split(' ')[0];

        // Save the PDF
        doc.save(`Notes_\${document.querySelector('h4').textContent}_\${date}.pdf`);
    }
</script>
</body>
</html>