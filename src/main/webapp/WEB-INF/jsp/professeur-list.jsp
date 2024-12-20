<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Professors List</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h1 class="text-center">Professors List</h1>
    <a href="${pageContext.request.contextPath}/professeurs/add" class="btn btn-success mb-3">Add Professor</a>
    <table class="table table-bordered">
        <thead class="table-dark">
        <tr>
            <th>Code</th>
            <th>Nom</th>
            <th>Prénom</th>
            <th>Specialité</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="professeur" items="${professeurs}">
            <tr>
                <td>${professeur.code}</td>
                <td>${professeur.nom}</td>
                <td>${professeur.prenom}</td>
                <td>${professeur.specialite}</td>
                <td>
                    <a href="${pageContext.request.contextPath}/professeurs/edit/${professeur.code}" class="btn btn-primary btn-sm">Edit</a>
                    <a href="${pageContext.request.contextPath}/professeurs/delete/${professeur.code}" class="btn btn-danger btn-sm">Delete</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
</body>
</html>
