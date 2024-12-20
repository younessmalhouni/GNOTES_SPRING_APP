<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${professeur.code == null ? "Add Professor" : "Edit Professor"}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h1 class="text-center">${professeur.code == null ? "Add Professor" : "Edit Professor"}</h1>
    <form action="${pageContext.request.contextPath}/professeurs/save" method="post">
        <input type="hidden" name="code" value="${professeur.code}">
        <div class="mb-3">
            <label for="nom" class="form-label">Nom</label>
            <input type="text" class="form-control" id="nom" name="nom" value="${professeur.nom}" required>
        </div>
        <div class="mb-3">
            <label for="prenom" class="form-label">Prénom</label>
            <input type="text" class="form-control" id="prenom" name="prenom" value="${professeur.prenom}" required>
        </div>
        <div class="mb-3">
            <label for="specialite" class="form-label">Spécialité</label>
            <input type="text" class="form-control" id="specialite" name="specialite" value="${professeur.specialite}" required>
        </div>
        <button type="submit" class="btn btn-primary">Save</button>
        <a href="${pageContext.request.contextPath}/professeurs" class="btn btn-secondary">Cancel</a>
    </form>
</div>
</body>
</html>
