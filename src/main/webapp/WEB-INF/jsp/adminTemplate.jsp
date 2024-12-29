<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>GNotes - Admin Dashboard</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
  <style>
    :root {
      --primary-gradient: linear-gradient(135deg, #2196F3 0%, #1976D2 100%);
    }
    .navbar {
      background: var(--primary-gradient) !important;
    }
    .feature-card {
      transition: transform 0.3s ease, box-shadow 0.3s ease;
      border: none;
      border-radius: 1rem;
      overflow: hidden;
    }
    .feature-card:hover {
      transform: translateY(-5px);
      box-shadow: 0 10px 20px rgba(0,0,0,0.1);
    }
    .card-icon {
      font-size: 2.5rem;
      margin-bottom: 1rem;
      background: var(--primary-gradient);
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
    }
    .stat-card {
      border-radius: 1rem;
      border: none;
      background: white;
    }
    .profile-button {
      border-radius: 2rem;
      padding: 0.5rem 1.5rem;
      background: rgba(255,255,255,0.1);
      border: 1px solid rgba(255,255,255,0.2);
    }
    .profile-button:hover {
      background: rgba(255,255,255,0.2);
    }
    .welcome-section {
      background: var(--primary-gradient);
      color: white;
      border-radius: 1rem;
      padding: 2rem;
      margin-bottom: 2rem;
    }
    .btn-primary {
      background: var(--primary-gradient);
      border: none;
    }
    .btn-primary:hover {
      background: linear-gradient(135deg, #1E88E5 0%, #1565C0 100%);
    }
  </style>
</head>
<body class="bg-light">
<jsp:include page="header.jsp" />

<div class="container py-5">
  <div class="welcome-section text-center shadow">
    <h1 class="display-4 mb-3">Welcome, ${nomUtilisateur}</h1>
    <p class="lead mb-0">Manage your academic institution with ease</p>
  </div>

  <div class="row g-4">
    <div class="col-md-6 col-lg-3">
      <div class="feature-card card h-100 shadow-sm">
        <div class="card-body text-center p-4">
          <i class="fas fa-chalkboard-teacher card-icon"></i>
          <h5 class="card-title">Professeurs</h5>
          <p class="card-text text-muted">Manage faculty members and their assignments</p>
          <button class="btn btn-primary w-100"
                  onclick="location.href='${pageContext.request.contextPath}/professeurs'">
            <i class="fas fa-arrow-right me-2"></i>Access
          </button>
        </div>
      </div>
    </div>

    <div class="col-md-6 col-lg-3">
      <div class="feature-card card h-100 shadow-sm">
        <div class="card-body text-center p-4">
          <i class="fas fa-book card-icon"></i>
          <h5 class="card-title">Modules</h5>
          <p class="card-text text-muted">Organize and update course modules</p>
          <button class="btn btn-primary w-100"
                  onclick="location.href='${pageContext.request.contextPath}/modules'">
            <i class="fas fa-arrow-right me-2"></i>Access
          </button>
        </div>
      </div>
    </div>

    <div class="col-md-6 col-lg-3">
      <div class="feature-card card h-100 shadow-sm">
        <div class="card-body text-center p-4">
          <i class="fas fa-stream card-icon"></i>
          <h5 class="card-title">Filières</h5>
          <p class="card-text text-muted">Manage academic departments and streams</p>
          <button class="btn btn-primary w-100"
                  onclick="location.href='${pageContext.request.contextPath}/fillieres'">
            <i class="fas fa-arrow-right me-2"></i>Access
          </button>
        </div>
      </div>
    </div>

    <div class="col-md-6 col-lg-3">
      <div class="feature-card card h-100 shadow-sm">
        <div class="card-body text-center p-4">
          <i class="fas fa-user-graduate card-icon"></i>
          <h5 class="card-title">Étudiants</h5>
          <p class="card-text text-muted">Monitor student progress and records</p>
          <button class="btn btn-primary w-100"
                  onclick="location.href='${pageContext.request.contextPath}/etudiants'">
            <i class="fas fa-arrow-right me-2"></i>Access
          </button>
        </div>
      </div>
    </div>
    <div class="col-md-6 col-lg-3">
      <div class="feature-card card h-100 shadow-sm">
        <div class="card-body text-center p-4">
          <i class="fas fa-user-graduate card-icon"></i>
          <h5 class="card-title">Elements</h5>
          <p class="card-text text-muted">Monitor Elements</p>
          <button class="btn btn-primary w-100"
                  onclick="location.href='${pageContext.request.contextPath}/elements'">
            <i class="fas fa-arrow-right me-2"></i>Access
          </button>
        </div>
      </div>
    </div>
  </div>
</div>




<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>