<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Créer un Compte</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .custom-card {
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            border-radius: 15px;
            border: none;
        }
        .custom-card .card-header {
            background-color: #f8f9fa;
            border-bottom: 1px solid #eee;
            border-radius: 15px 15px 0 0;
            padding: 1.5rem;
        }
        .custom-card .card-body {
            padding: 2rem;
        }
        .form-label {
            font-weight: 500;
            margin-bottom: 0.5rem;
        }
        .form-control {
            border-radius: 8px;
            padding: 0.75rem 1rem;
        }
        .form-control:focus {
            box-shadow: 0 0 0 0.25rem rgba(13,110,253,0.15);
        }
        .btn {
            padding: 0.75rem 1.5rem;
            border-radius: 8px;
            font-weight: 500;
        }
        .radio-group {
            background-color: #f8f9fa;
            padding: 1rem;
            border-radius: 8px;
            margin-bottom: 1rem;
        }
        .radio-group .form-check {
            margin: 0.5rem 0;
        }
    </style>
</head>
<body class="bg-light">
<jsp:include page="header.jsp" />
<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card custom-card">
                <div class="card-header">
                    <h3 class="text-center mb-0">Créer un Compte pour ${professeur.nom} ${professeur.prenom}</h3>
                </div>
                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/utilisateur/saveCompte/${professeur.code}" method="post">
                        <input type="hidden" name="utilisateurCode" value="${professeur.code}" />

                        <div class="mb-4">
                            <label for="nomUtilisateur" class="form-label">Nom d'utilisateur</label>
                            <input type="text" id="nomUtilisateur" name="nomUtilisateur" class="form-control" required />
                            <c:if test="${not empty errors.nomUtilisateur}">
                                <div class="text-danger mt-1">${errors.nomUtilisateur}</div>
                            </c:if>
                        </div>

                        <div class="mb-4">
                            <label for="motDePasse" class="form-label">Mot de passe</label>
                            <input type="password" id="motDePasse" name="motDePasse" class="form-control" required />
                            <c:if test="${not empty errors.motDePasse}">
                                <div class="text-danger mt-1">${errors.motDePasse}</div>
                            </c:if>
                        </div>

                        <div class="mb-4">
                            <label for="confirmPassword" class="form-label">Confirmer le mot de passe</label>
                            <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" required />
                        </div>

                        <div class="mb-4">
                            <div class="radio-group">
                                <label class="form-label mb-2">Type de compte</label>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="accountType" id="professeurRadio" value="professeur" checked>
                                    <label class="form-check-label" for="professeurRadio">
                                        Compte Professeur
                                    </label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="accountType" id="adminRadio" value="admin">
                                    <label class="form-check-label" for="adminRadio">
                                        Compte Admin
                                    </label>
                                </div>
                            </div>
                        </div>

                        <div class="d-grid gap-3">
                            <button type="submit" class="btn btn-primary">Créer le compte</button>
                            <a href="${pageContext.request.contextPath}/professeurs" class="btn btn-secondary">Annuler</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    document.querySelector('form').addEventListener('submit', function(e) {
        const password = document.querySelector('#motDePasse').value;
        const confirmPassword = document.querySelector('#confirmPassword').value;

        if (password !== confirmPassword) {
            e.preventDefault();
            alert('Les mots de passe ne correspondent pas.');
        }
    });
</script>
</body>
</html>