<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>List of Fillieres</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container my-5">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h2>List of Fillières</h2>
        <a href="${pageContext.request.contextPath}/fillieres/add" class="btn btn-primary">Ajouter Filliere</a>
    </div>
    <table class="table table-striped table-hover">
        <thead class="table-dark">
        <tr>
            <th>#</th>
            <th>Filliere Name</th>
            <th>Date of Creation</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="filliere" items="${fillieres}" varStatus="status">
            <tr>
                <td>${status.index + 1}</td>
                <td>${filliere.nomFilliere}</td>
                <td>${filliere.dateCreation}</td>
                <td>
                    <a href="${pageContext.request.contextPath}/fillieres/edit/${filliere.idFilliere}" class="btn btn-warning btn-sm">Edit</a>
                    <a href="${pageContext.request.contextPath}/fillieres/delete/${filliere.idFilliere}" class="btn btn-danger btn-sm"
                       onclick="return confirm('Are you sure you want to delete this filliere?');">Delete</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
