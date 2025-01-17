<!-- forgot-password.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <title>GNotes - Mot de passe oublié</title>
  <!-- Include your existing CSS -->
</head>
<body>
<div class="login-container d-flex justify-content-center align-items-center p-4">
  <div class="card p-4 p-md-5" style="width: 450px;">
    <div class="text-center mb-4">
      <i class="fas fa-key logo-icon mb-3"></i>
      <h2 class="login-header mb-2">Mot de passe oublié</h2>
      <p class="welcome-text">Entrez votre email pour réinitialiser votre mot de passe</p>
    </div>
    <form action="${pageContext.request.contextPath}/utilisateur/forgot" method="post">
      <div class="mb-4">
        <div class="input-group">
                    <span class="input-group-text">
                        <i class="fas fa-envelope text-primary"></i>
                    </span>
          <input type="email" class="form-control" name="email" required
                 placeholder="Entrez votre email">
        </div>
      </div>
      <button type="submit" class="btn btn-login btn-primary w-100 mb-3">
        <i class="fas fa-paper-plane me-2"></i> Envoyer le lien
      </button>
      <a href="${pageContext.request.contextPath}/login" class="btn btn-link w-100">
        Retour à la connexion
      </a>
    </form>
  </div>
</div>
</body>
</html>