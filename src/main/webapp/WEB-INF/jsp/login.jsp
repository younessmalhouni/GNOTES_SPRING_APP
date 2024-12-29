<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GNotes - Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .login-container {
            background: linear-gradient(135deg, #2196F3 0%, #1976D2 100%);
            min-height: 100vh;
        }
        .card {
            backdrop-filter: blur(10px);
            background: rgba(255, 255, 255, 0.95);
            border-radius: 1rem;
            border: 1px solid rgba(255, 255, 255, 0.3);
        }
        .login-header {
            color: #1976D2;
            font-weight: 700;
        }
        .form-control {
            border-radius: 0.5rem;
            padding: 0.75rem 1rem;
        }
        .form-control:focus {
            border-color: #2196F3;
            box-shadow: 0 0 0 0.2rem rgba(33, 150, 243, 0.25);
        }
        .btn-login {
            background: linear-gradient(135deg, #2196F3 0%, #1976D2 100%);
            border: none;
            padding: 0.75rem;
            border-radius: 0.5rem;
            font-weight: 600;
            transition: transform 0.2s;
        }
        .btn-login:hover {
            transform: translateY(-2px);
            background: linear-gradient(135deg, #1E88E5 0%, #1565C0 100%);
        }
        .input-group-text {
            background: transparent;
            border-right: none;
        }
        .form-control {
            border-left: none;
        }
    </style>
</head>
<body>
<div class="login-container d-flex justify-content-center align-items-center p-4">
    <div class="card shadow-lg p-4 p-md-5" style="width: 450px;">
        <div class="text-center mb-4">
            <i class="fas fa-graduation-cap fa-3x mb-3 text-primary"></i>
            <h2 class="login-header">GNotes Login</h2>
            <p class="text-muted">Access your academic dashboard</p>
        </div>
        <form action="${pageContext.request.contextPath}/utilisateur/loginUser" method="post" class="needs-validation" novalidate>
            <div class="mb-4">
                <div class="input-group">
                    <span class="input-group-text">
                        <i class="fas fa-user text-muted"></i>
                    </span>
                    <input type="text" class="form-control" id="nomUtilisateur" name="nomUtilisateur"
                           placeholder="Enter your username" required>
                </div>
            </div>
            <div class="mb-4">
                <div class="input-group">
                    <span class="input-group-text">
                        <i class="fas fa-lock text-muted"></i>
                    </span>
                    <input type="password" class="form-control" id="motDePasse" name="motDePasse"
                           placeholder="Enter your password" required>
                </div>
            </div>
            <button type="submit" class="btn btn-login btn-primary w-100 mb-3">
                <i class="fas fa-sign-in-alt me-2"></i> Login
            </button>
            <c:if test="${not empty msg}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="fas fa-exclamation-circle me-2"></i>${msg}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>
        </form>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>