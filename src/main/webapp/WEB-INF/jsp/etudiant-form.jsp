<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Etudiant Form</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <jsp:include page="header.jsp"/>
</head>
<body>
<div class="container my-5">
    <h2 class="mb-4">${etudiant.codeEtudiant != null ? "Modifier Etudiant" : "Ajouter un Nouvel Etudiant"}</h2>
    <form action="${pageContext.request.contextPath}/etudiants/save" method="post" enctype="multipart/form-data">
        <input type="hidden" id="codeEtudiant" name="codeEtudiant" value="${etudiant.codeEtudiant}">

        <div class="mb-3">
            <label for="nomEtudiant" class="form-label">Nom</label>
            <input type="text" id="nomEtudiant" name="nomEtudiant" class="form-control"
                   value="${etudiant.nomEtudiant}" placeholder="Entrez le nom" required>
        </div>
        <div class="mb-3">
            <label for="CNE" class="form-label">CNE</label>
            <input type="text" id="CNE" name="CNE" class="form-control"
                   value="${etudiant.CNE}" placeholder="Entrez le CNE" required>
        </div>

        <div class="mb-3">
            <label for="prenomEtudiant" class="form-label">Prénom</label>
            <input type="text" id="prenomEtudiant" name="prenomEtudiant" class="form-control"
                   value="${etudiant.prenomEtudiant}" placeholder="Entrez le prénom" required>
        </div>
        <div class="mb-3">
            <label for="email" class="form-label">Email</label>
            <input type="email" id="email" name="email" class="form-control"
                   value="${etudiant.email}" placeholder="Entrez l'email" required>
        </div>
        <div class="mb-3">
            <label for="imageFile" class="form-label">Image de l'étudiant</label>
            <input type="file" id="imageFile" name="imageFile" class="form-control" accept="image/*" >

            <c:if test="${etudiant.image != null}">
                <div class="mt-2">
                    <img src="${etudiant.image}" alt="Photo actuelle" class="img-thumbnail" style="max-width: 200px">
                    <p class="text-muted small">Image actuelle</p>
                </div>
            </c:if>
        </div>
        <div class="mb-3">
            <label for="filliere" class="form-label">Filière</label>
            <select id="filliere" name="filliere" class="form-control" required>
                <option value="">Sélectionnez une filière</option>
                <c:forEach var="filliere" items="${fillieres}">
                    <option value="${filliere.idFilliere}" ${filliere.idFilliere == etudiant.filliere.idFilliere ? 'selected' : ''}>
                            ${filliere.nomFilliere}
                    </option>
                </c:forEach>
            </select>
        </div>
        <div class="mb-3">
            <label for="semestre" class="form-label">Semestre</label>
            <select id="semestre" name="semestre" class="form-control" required>
                <option value="">Sélectionnez un semestre</option>
                <c:forEach var="semestre" items="${semestres}">
                    <option value="${semestre.id_Semestre}" ${semestre.id_Semestre == etudiant.semestre.id_Semestre ? 'selected' : ''}>
                            ${semestre.nom_Semestre}
                    </option>
                </c:forEach>
            </select>
        </div>
        <div class="d-flex justify-content-between">
            <button type="submit" class="btn btn-success">Enregistrer</button>
            <a href="${pageContext.request.contextPath}/etudiants" class="btn btn-secondary">Annuler</a>
        </div>
    </form>
</div>
<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>