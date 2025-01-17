<!-- reset-password.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <title>GNotes - Réinitialisation du mot de passe</title>
  <!-- Include your existing CSS -->
</head>
<body>
<div class="login-container d-flex justify-content-center align-items-center p-4">
  <div class="card p-4 p-md-5" style="width: 450px;">
    <div class="text-center mb-4">
      <i class="fas fa-lock-open logo-icon mb-3"></i>
      <h2 class="login-header mb-2">Nouveau mot de passe</h2>
      <p class="welcome-text">Choisissez votre nouveau mot de passe</p>
    </div>
    <form action="${pageContext.request.contextPath}/password/reset" method="post">
      <input type="hidden" name="token" value="${token}">
      <div class="mb-4">
        <div class="input-group">
                    <span class="input-group-text">
                        <i class="fas fa-lock text-primary"></i>
                    </span>
          <input type="password" class="form-control" name="password" required
                 placeholder="Nouveau mot de passe">
        </div>
      </div>
      <div class="mb-4">
        <div class="input-group">
                    <span class="input-group-text">
                        <i class="fas fa-lock text-primary"></i>
                    </span>
          <input type="password" class="form-control" name="confirmPassword" required
                 placeholder="Confirmer le mot de passe">
        </div>
      </div>
      <button type="submit" class="btn btn-login btn-primary w-100 mb-3">
        <i class="fas fa-save me-2"></i> Enregistrer
      </button>
    </form>
  </div>
</div>
</body>
</html>