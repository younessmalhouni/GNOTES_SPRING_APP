<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Module List</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet"/>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" rel="stylesheet"/>
    <style>
        :root {
            --primary-gradient: linear-gradient(135deg, #6e8efb, #4a6cf7);
        }

        body {
            background-color: #f8f9fa;
        }

        .page-header {
            background: var(--primary-gradient);
            color: white;
            padding: 2rem 0;
            margin-bottom: 2rem;
            border-radius: 0 0 25px 25px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        .module-card {
            background: white;
            border-radius: 15px;
            border: none;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            transition: all 0.3s ease;
            margin-bottom: 1.5rem;
        }

        .module-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
        }

        .module-content {
            padding: 1.5rem;
        }

        .module-title {
            color: #2c3e50;
            font-weight: 600;
            margin-bottom: 0.5rem;
        }

        .module-info {
            color: #7f8c8d;
            font-size: 0.9rem;
        }

        .badge-custom {
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-weight: 500;
            font-size: 0.85rem;
        }

        .actions-container {
            background: #f8f9fa;
            padding: 1rem;
            border-top: 1px solid #eee;
            border-radius: 0 0 15px 15px;
        }

        .btn-custom {
            border-radius: 20px;
            padding: 0.5rem 1.5rem;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .btn-custom:hover {
            transform: translateY(-2px);
        }

        .add-module-btn {
            background: var(--primary-gradient);
            color: white;
            border: none;
            padding: 0.8rem 2rem;
            border-radius: 25px;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .add-module-btn:hover {
            box-shadow: 0 5px 15px rgba(110, 142, 251, 0.4);
            transform: translateY(-2px);
        }
    </style>
    <jsp:include page="header.jsp" />
</head>
<body>
<div class="page-header animate__animated animate__fadeIn">
    <div class="container">
        <div class="d-flex justify-content-between align-items-center">
            <h1 class="mb-0">Modules</h1>
            <a href="modules/add" class="add-module-btn">
                <i class="fas fa-plus-circle me-2"></i>Add New Module
            </a>
        </div>
    </div>
</div>

<div class="container">
    <div class="row">
        <c:forEach var="module" items="${modules}">
            <div class="col-12 col-md-6 col-lg-4 animate__animated animate__fadeInUp">
                <div class="module-card">
                    <div class="module-content">
                        <h5 class="module-title">
                            <i class="fas fa-book-open me-2 text-primary"></i>
                            <c:out value="${module.nomModule}"/>
                        </h5>
                        <div class="module-info mb-3">
                            <div class="mb-2">
                                <i class="fas fa-code me-2"></i>
                                Code: <c:out value="${module.codeModule}"/>
                            </div>
                            <div class="mb-2">
                                <i class="fas fa-graduation-cap me-2"></i>
                                Fillière: <span class="badge badge-custom bg-info">
                                        <c:out value="${module.filliere.nomFilliere}"/>
                                    </span>
                            </div>
                            <div>
                                <i class="fas fa-calendar-alt me-2"></i>
                                Semestre: <span class="badge badge-custom bg-success">
                                        <c:out value="${module.semestre.nom_Semestre}"/>
                                    </span>
                            </div>
                        </div>
                    </div>
                    <div class="actions-container d-flex justify-content-end gap-2">
                        <a href="modules/edit/${module.codeModule}" class="btn btn-warning btn-custom">
                            <i class="fas fa-edit me-1"></i> Edit
                        </a>
                        <a href="modules/delete/${module.codeModule}"
                           class="btn btn-danger btn-custom"
                           onclick="return confirm('Are you sure you want to delete this module?');">
                            <i class="fas fa-trash-alt me-1"></i> Delete
                        </a>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>