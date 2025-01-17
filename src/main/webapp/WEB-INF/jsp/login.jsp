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
            background-image: url('https://images.unsplash.com/photo-1497864149936-d3163f0c0f4b?ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            min-height: 100vh;
            position: relative;
        }

        .login-container::before {
            content: '';
            position: absolute;
            top: 0;
            right: 0;
            bottom: 0;
            left: 0;
            background: rgba(0, 0, 0, 0.5);
        }

        .card {
            backdrop-filter: blur(10px);
            background: rgba(255, 255, 255, 0.95);
            border-radius: 1.5rem;
            border: none;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
            position: relative;
        }

        .login-header {
            color: #2c3e50;
            font-weight: 700;
            letter-spacing: 1px;
        }

        .input-group {
            background: #f8f9fa;
            border-radius: 0.75rem;
            overflow: hidden;
            transition: all 0.3s ease;
        }

        .input-group:focus-within {
            box-shadow: 0 0 0 3px rgba(33, 150, 243, 0.25);
            background: #fff;
        }

        .input-group-text {
            background: transparent;
            border: none;
            padding-left: 1.5rem;
        }

        .form-control {
            border: none;
            padding: 1rem;
            background: transparent;
        }

        .form-control:focus {
            box-shadow: none;
            background: transparent;
        }

        .btn-login {
            background: linear-gradient(45deg, #3498db, #2980b9);
            padding: 0.75rem;
            border-radius: 0.75rem;
            font-weight: 600;
            letter-spacing: 0.5px;
            box-shadow: 0 4px 15px rgba(52, 152, 219, 0.3);
            transition: all 0.3s ease;
        }

        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(52, 152, 219, 0.4);
            background: linear-gradient(45deg, #2980b9, #2c3e50);
        }

        .logo-icon {
            background: linear-gradient(45deg, #3498db, #2980b9);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            font-size: 3.5rem;
        }

        .custom-alert {
            position: fixed;
            top: 20px;
            left: 50%;
            transform: translateX(-50%);
            background: linear-gradient(45deg, #e74c3c, #c0392b);
            color: white;
            padding: 1rem 2rem;
            border-radius: 1rem;
            box-shadow: 0 8px 25px rgba(231, 76, 60, 0.3);
            z-index: 1000;
            animation: slideIn 0.5s ease-out, fadeOut 0.5s ease-out 4.5s;
            min-width: 300px;
            text-align: center;
            font-weight: 500;
        }

        @keyframes slideIn {
            from { transform: translate(-50%, -100%); opacity: 0; }
            to { transform: translate(-50%, 0); opacity: 1; }
        }

        @keyframes fadeOut {
            from { opacity: 1; }
            to { opacity: 0; }
        }

        .welcome-text {
            color: #7f8c8d;
            font-size: 0.95rem;
            margin-bottom: 2rem;
        }
    </style>
</head>
<body>
<% if(request.getParameter("error") != null) { %>
<div class="custom-alert">
    <i class="fas fa-exclamation-circle me-2"></i>
    <%= request.getParameter("error") %>
</div>
<script>
    setTimeout(function() {
        document.querySelector('.custom-alert').remove();
    }, 5000);
</script>
<% } %>
<div class="login-container d-flex justify-content-center align-items-center p-4">
    <div class="card p-4 p-md-5" style="width: 450px;">
        <div class="text-center mb-4">
            <i class="fas fa-graduation-cap logo-icon mb-3"></i>
            <h2 class="login-header mb-2">Welcome to GNotes</h2>
            <p class="welcome-text">Sign in to access your academic dashboard</p>
        </div>
        <form action="${pageContext.request.contextPath}/utilisateur/loginUser" method="post" class="needs-validation" novalidate>
            <div class="mb-4">
                <div class="input-group">
                    <span class="input-group-text">
                        <i class="fas fa-user text-primary"></i>
                    </span>
                    <input type="text" class="form-control" id="nomUtilisateur" name="nomUtilisateur"
                           placeholder="Username" required>
                </div>
            </div>
            <div class="mb-4">
                <div class="input-group">
                    <span class="input-group-text">
                        <i class="fas fa-lock text-primary"></i>
                    </span>
                    <input type="password" class="form-control" id="motDePasse" name="motDePasse"
                           placeholder="Password" required>
                </div>
            </div>
            <button type="submit" class="btn btn-login btn-primary w-100 mb-3">
                <i class="fas fa-sign-in-alt me-2"></i> Se Connecter
            </button>
            <c:if test="${not empty msg}">
                <div class="alert alert-danger alert-dismissible fade show mt-3" role="alert">
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