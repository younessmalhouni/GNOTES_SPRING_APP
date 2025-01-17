<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Formulaire Élément</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
<div class="container py-5">
    <h2 class="mb-4">${element.idElement == null ? 'Ajouter' : 'Modifier'} Élément</h2>

    <!-- Error message display -->
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger" role="alert">
                ${errorMessage}
        </div>
    </c:if>

    <form action="${pageContext.request.contextPath}/elements/save" method="post">
        <input type="hidden" name="idElement" value="${element.idElement}"/>
        <div class="mb-3">
            <label for="nomElement" class="form-label">Nom de l'Élément</label>
            <input type="text" class="form-control" id="nomElement" name="nomElement" value="${element.nomElement}" required>
        </div>
        <div class="mb-3">
            <label for="coefficient" class="form-label">Coefficient</label>
            <input type="number" step="0.01" class="form-control" id="coefficient" name="coefficient" value="${element.coefficient}"  min="0" max="${sommeCoefModule}" required>
        </div>
        <div class="mb-3">
            <label for="module" class="form-label">Module</label>
            <select class="form-select" id="module" name="module.codeModule" required>
                <option value="">Sélectionner un Module</option>
                <c:forEach var="module" items="${modules}">
                    <option value="${module.codeModule}" ${module.codeModule == element.module.codeModule ? 'selected' : ''}>${module.nomModule}</option>
                </c:forEach>
            </select>
        </div>
        <div class="mb-3">
            <label for="professeur" class="form-label">Professeur</label>
            <select class="form-select" id="professeur" name="professeur.code" required>
                <option value="">Sélectionner un Professeur</option>
                <c:forEach var="professeur" items="${professeurs}">
                    <option value="${professeur.code}" ${professeur.code == element.professeur.code ? 'selected' : ''}>${professeur.nom} ${professeur.prenom}</option>
                </c:forEach>
            </select>
        </div>
        <div class="mb-3">
            <label class="form-label">Modalités d'Évaluation</label>
            <div id="modalitesContainer">
                <c:forEach var="modalite" items="${element.modalites}" varStatus="status">
                    <div class="input-group mb-2">
                        <input type="text" class="form-control" name="modalites[${status.index}].type_Modalite" value="${modalite.type_Modalite}" placeholder="Type d'Évaluation" required>
                        <input type="number" step="0.01" class="form-control" name="modalites[${status.index}].coeffecient" value="${modalite.coeffecient}" placeholder="Coefficient" min="1" max="100" required>
                        <button type="button" class="btn btn-danger" onclick="removeModalite(this)">Supprimer</button>
                    </div>
                </c:forEach>
            </div>
            <button type="button" class="btn btn-primary" onclick="addModalite()">Ajouter Modalité</button>
        </div>
        <button type="submit" class="btn btn-success">Enregistrer</button>
        <a href="${pageContext.request.contextPath}/elements" class="btn btn-secondary">Annuler</a>
    </form>
</div>

<script>
    function addModalite() {
        const container = document.getElementById('modalitesContainer');
        const index = container.children.length;
        const div = document.createElement('div');
        div.className = 'input-group mb-2';
        div.innerHTML = `
            <input type="text" class="form-control" name="modalites[\${index}].type_Modalite" placeholder="Type d'Évaluation" required>
            <input type="number" step="0.01" class="form-control" name="modalites[\${index}].coeffecient" placeholder="Coefficient" min="1" max="100" required>
            <button type="button" class="btn btn-danger" onclick="removeModalite(this)">Supprimer</button>
        `;
        container.appendChild(div);
    }

    function removeModalite(button) {
        button.parentElement.remove();
    }
</script>
</body>
</html>