<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Filliere Form</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

</head>
<body>

<jsp:include page="header.jsp" />
<div class="container my-5">
    <h2 class="mb-4">${filliere.idFilliere != null ? "Modifier Filliere" : "Ajouter Nouvelle Filliere"}</h2>
    <form action="${pageContext.request.contextPath}/fillieres/save" method="post">
        <input type="hidden" id="idFilliere" name="idFilliere" value="${filliere.idFilliere}">

        <div class="mb-3">
            <label for="nomFilliere" class="form-label">Filliere Name</label>
            <input type="text" id="nomFilliere" name="nomFilliere" class="form-control"
                   value="${filliere.nomFilliere}" placeholder="Enter Filliere Name" required>
        </div>
        <div class="mb-3">
            <label for="description" class="form-label">Description</label>
            <textarea id="description" name="description" class="form-control"
                      placeholder="Enter Description">${filliere.description}</textarea>
        </div>
        <div class="mb-3">
            <label for="dateCreation" class="form-label">Date of Creation</label>
            <input type="date" id="dateCreation" name="dateCreation" class="form-control"
                   value="${filliere.dateCreation}" required>
        </div>
        <div class="d-flex justify-content-between">
            <button type="submit" class="btn btn-success">Save</button>
            <a href="${pageContext.request.contextPath}/fillieres" class="btn btn-secondary">Cancel</a>
        </div>
    </form>
</div>
<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
