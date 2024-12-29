<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Header</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .sidebar {
            position: fixed;
            top: 0;
            left: -250px;
            height: 100%;
            width: 250px;
            background: linear-gradient(135deg, #2196F3 0%, #1976D2 100%);
            padding-top: 20px;
            transition: left 0.3s ease, opacity 0.3s ease;
            color: white;
            opacity: 0;
        }
        .sidebar.show {
            left: 0;
            opacity: 1;
        }
        .sidebar-header {
            text-align: center;
            padding: 10px 0;
            font-size: 1.5rem;
            font-weight: bold;
            border-bottom: 1px solid rgba(255, 255, 255, 0.2);
        }
        .sidebar .nav-link {
            color: white;
            padding: 10px 20px;
            display: flex;
            align-items: center;
        }
        .sidebar .nav-link i {
            margin-right: 10px;
        }
        .sidebar .nav-link:hover {
            background-color: rgba(255, 255, 255, 0.1);
        }
        .content {
            margin-left: 250px;
            padding: 20px;
        }
        .toggle-button {
            position: fixed;
            top: 10px;
            left: 10px;
            background: none;
            border: none;
            color: white;
            font-size: 1.5rem;
            z-index: 1000;
        }
        #hideSidebarBtn {
            display: none;
        }
        .navbar-custom {
            background: linear-gradient(135deg, #2196F3 0%, #1976D2 100%);
            color: white;
        }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-custom">
    <div class="container">
        <a class="navbar-brand d-flex align-items-center" href="#">
            <i class="fas fa-graduation-cap me-2"></i>
            GNotes
        </a>
        <div class="d-flex align-items-center">
            <button class="profile-button btn text-white d-flex align-items-center me-3"
                    onclick="window.location.href='${pageContext.request.contextPath}/utilisateur/profile'">
                <img src="${pageContext.request.contextPath}/resources/static/profile.jpeg"
                     alt="Profile" class="rounded-circle me-2" width="40" height="40">
                <span>${nomUtilisateur}</span>
            </button>
            <button class="btn btn-light" onclick="window.location.href='${pageContext.request.contextPath}/logout'">
                <i class="fas fa-sign-out-alt me-2"></i>Logout
            </button>
        </div>
    </div>
</nav>

<button class="toggle-button" id="showSidebarBtn">
    <i class="fas fa-bars"></i>
</button>
<button class="toggle-button" id="hideSidebarBtn">
    <i class="fas fa-times"></i>
</button>

<div class="sidebar" id="sidebar">
    <div class="sidebar-header">Navigation</div>
    <nav class="nav flex-column">

        <a class="nav-link" href="${pageContext.request.contextPath}/utilisateur/loginUser">
            <i class="fas fa-home"></i>Acceuil
        </a>

        <a class="nav-link" href="${pageContext.request.contextPath}/professeurs">
            <i class="fas fa-chalkboard-teacher"></i>Professeurs
        </a>
        <a class="nav-link" href="${pageContext.request.contextPath}/modules">
            <i class="fas fa-book"></i>Modules
        </a>
        <a class="nav-link" href="${pageContext.request.contextPath}/fillieres">
            <i class="fas fa-stream"></i>Filières
        </a>
        <a class="nav-link" href="${pageContext.request.contextPath}/etudiants">
            <i class="fas fa-user-graduate"></i>Étudiants
        </a>
        <a class="nav-link" href="${pageContext.request.contextPath}/elements">
            <i class="fas fa-user-graduate"></i>Elements
        </a>
    </nav>
</div>

<div class="content">
    <!-- Main content goes here -->
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.getElementById('showSidebarBtn').addEventListener('click', function() {
        document.getElementById('sidebar').classList.add('show');
        document.getElementById('showSidebarBtn').style.display = 'none';
        document.getElementById('hideSidebarBtn').style.display = 'block';
    });

    document.getElementById('hideSidebarBtn').addEventListener('click', function() {
        document.getElementById('sidebar').classList.remove('show');
        document.getElementById('showSidebarBtn').style.display = 'block';
        document.getElementById('hideSidebarBtn').style.display = 'none';
    });
</script>
</body>
</html>