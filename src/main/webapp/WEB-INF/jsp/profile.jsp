<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-color: #3498db;
            --secondary-color: #2980b9;
        }

        .profile-img {
            width: 150px;
            height: 150px;
            object-fit: cover;
            border: 4px solid #fff;
            box-shadow: 0 4px 15px rgba(52, 152, 219, 0.3);
            transition: transform 0.3s ease;
        }
        .profile-img:hover {
            transform: scale(1.05);
        }
        .custom-card {
            border-radius: 0.75rem;
            background: white;
            box-shadow: 0 4px 15px rgba(52, 152, 219, 0.3);
            transition: transform 0.3s ease;
        }
        .custom-card:hover {
            transform: translateY(-5px);
        }
        .profile-header {
            background: linear-gradient(45deg, #3498db, #2980b9);
            border-radius: 0.75rem 0.75rem 0 0;
            padding: 3.5rem 0;
            color: white;
            letter-spacing: 0.5px;
        }
        .profile-info {
            padding: 2.5rem;
        }
        .info-item {
            background: #f8f9fa;
            border-radius: 0.75rem;
            padding: 0.75rem;
            margin-bottom: 1rem;
            transition: all 0.3s ease;
            font-weight: 600;
            letter-spacing: 0.5px;
            box-shadow: 0 4px 15px rgba(52, 152, 219, 0.1);
        }
        .info-item:hover {
            background: #f1f5f9;
            transform: translateX(5px);
            box-shadow: 0 4px 15px rgba(52, 152, 219, 0.2);
        }
        .info-icon {
            font-size: 1.5rem;
            color: #3498db;
            margin-right: 10px;
        }
        .badge-role {
            background: linear-gradient(45deg, #3498db, #2980b9);
            padding: 0.75rem 1.5rem;
            border-radius: 0.75rem;
            font-weight: 600;
            letter-spacing: 0.5px;
            box-shadow: 0 4px 15px rgba(52, 152, 219, 0.3);
            transition: all 0.3s ease;
        }
        .badge-role:hover {
            transform: scale(1.05);
            box-shadow: 0 4px 20px rgba(52, 152, 219, 0.4);
        }
        .btn-password {
            background: linear-gradient(45deg, #3498db, #2980b9);
            padding: 0.75rem 1.5rem;
            border-radius: 0.75rem;
            font-weight: 600;
            letter-spacing: 0.5px;
            box-shadow: 0 4px 15px rgba(52, 152, 219, 0.3);
            transition: all 0.3s ease;
            border: none;
            color: white;
        }
        .btn-password:hover {
            transform: scale(1.05);
            box-shadow: 0 4px 20px rgba(52, 152, 219, 0.4);
        }
        .modal-content {
            border-radius: 0.75rem;
            box-shadow: 0 4px 15px rgba(52, 152, 219, 0.3);
        }
        .form-control {
            border-radius: 0.75rem;
            padding: 0.75rem;
            font-weight: 500;
            letter-spacing: 0.5px;
            border: 1px solid rgba(52, 152, 219, 0.2);
        }
        .form-control:focus {
            box-shadow: 0 0 0 0.2rem rgba(52, 152, 219, 0.25);
            border-color: #3498db;
        }
        .btn-modal {
            background: linear-gradient(45deg, #3498db, #2980b9);
            padding: 0.75rem 1.5rem;
            border-radius: 0.75rem;
            font-weight: 600;
            letter-spacing: 0.5px;
            box-shadow: 0 4px 15px rgba(52, 152, 219, 0.3);
            transition: all 0.3s ease;
            border: none;
            color: white;
        }
    </style>
    <jsp:include page="header.jsp"/>
</head>
<body class="bg-light">
<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="custom-card">
                <div class="profile-header text-center">
                    <c:choose>
                        <c:when test="${not empty utilisateur.image}">
                            <img src="${utilisateur.image}" class="profile-img rounded-circle mb-4" alt="Photo de profil">
                        </c:when>
                        <c:otherwise>
                            <div class="bg-light rounded-circle mx-auto mb-4 d-flex align-items-center justify-content-center" style="width: 150px; height: 150px;">
                                <i class="fas fa-user fa-4x text-secondary"></i>
                            </div>
                        </c:otherwise>
                    </c:choose>

                    <div class="info-item mb-3 bg-white">
                        <i class="fas fa-id-card info-icon"></i>
                        <span class="fs-5" style="color:#3498db">Code: USER-${utilisateur.code}</span>
                    </div>

                    <h2 class="mb-2">
                        <i class="fas fa-user-circle me-2"></i>
                        ${utilisateur.nom} ${utilisateur.prenom}
                    </h2>
                    <p class="mb-0 opacity-75">
                        <i class="fas fa-at me-2"></i>
                        ${compte.nomUtilisateur}
                    </p>
                </div>

                <div class="profile-info">
                    <div class="text-center">
                        <div class="mb-4">
                            <span class="badge badge-role">
                                <i class="fas fa-user-shield me-2"></i>${role}
                            </span>
                        </div>

                        <div class="info-item">
                            <i class="fas fa-envelope info-icon"></i>
                            <h5 class="text-muted mb-2">Email</h5>
                            <p class="fs-5 fw-bold text-primary mb-0">${utilisateur.email}</p>
                        </div>

                        <c:if test="${compte.isProfesseur == true}">
                            <div class="info-item">
                                <i class="fas fa-graduation-cap info-icon"></i>
                                <h5 class="text-muted mb-2">Spécialité</h5>
                                <p class="fs-5 fw-bold text-primary mb-0">${utilisateur.specialite}</p>
                            </div>
                        </c:if>

                        <div class="mt-4">
                            <button class="btn btn-password" data-bs-toggle="modal" data-bs-target="#changePasswordModal">
                                <i class="fas fa-key me-2"></i>Changer le mot de passe
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Modal Changement de mot de passe -->
<div class="modal fade" id="changePasswordModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header border-0">
                <h5 class="modal-title">
                    <i class="fas fa-lock text-primary me-2"></i>
                    Changer le mot de passe
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <form>
                    <div class="mb-3">
                        <label class="form-label">
                            <i class="fas fa-key text-primary me-2"></i>
                            Ancien mot de passe
                        </label>
                        <input type="password" class="form-control">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">
                            <i class="fas fa-lock-open text-primary me-2"></i>
                            Nouveau mot de passe
                        </label>
                        <input type="password" class="form-control">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">
                            <i class="fas fa-check-double text-primary me-2"></i>
                            Confirmer le nouveau mot de passe
                        </label>
                        <input type="password" class="form-control">
                    </div>
                </form>
            </div>
            <div class="modal-footer border-0">
                <button type="button" class="btn btn-light" data-bs-dismiss="modal">
                    <i class="fas fa-times me-2"></i>
                    Annuler
                </button>
                <button type="button" class="btn btn-modal">
                    <i class="fas fa-save me-2"></i>
                    Sauvegarder
                </button>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>