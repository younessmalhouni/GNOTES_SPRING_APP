<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">

<style>
    :root {
        --primary-gradient: linear-gradient(45deg, #2980b9, #2c3e50);
        --hover-gradient: linear-gradient(45deg, #3498db, #2980b9);
        --card-shadow: 0 8px 25px rgba(52, 152, 219, 0.4);
        --sidebar-width: 280px;
        --header-height: 70px;
        --transition: all 0.3s ease;
    }

    .navbar-custom {
        background: var(--primary-gradient);
        height: var(--header-height);
        padding: 0 25px;
        box-shadow: var(--card-shadow);
        position: fixed;
        width: 100%;
        top: 0;
        z-index: 1000;
    }

    .navbar-brand {
        color: white !important;
        font-size: 1.6rem;
        font-weight: 700;
        letter-spacing: 1px;
        display: flex;
        align-items: center;
        gap: 12px;
    }

    .navbar-brand i {
        font-size: 2rem;
    }

    .sidebar {
        position: fixed;
        top: var(--header-height);
        left: calc(-1 * var(--sidebar-width));
        height: calc(100% - var(--header-height));
        width: var(--sidebar-width);
        background: white;
        transition: var(--transition);
        box-shadow: var(--card-shadow);
        z-index: 1000;
        opacity: 0;
        overflow-y: auto;
        border-radius: 0 20px 20px 0;
    }

    .sidebar.show {
        left: 0;
        opacity: 1;
    }

    .sidebar-header {
        text-align: center;
        padding: 25px 0;
        font-size: 1.4rem;
        font-weight: 600;
        color: #2c3e50;
        border-bottom: 2px solid rgba(0, 0, 0, 0.05);
        margin-bottom: 15px;
        background: var(--primary-gradient);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
    }

    .sidebar .nav-link {
        color: #2c3e50;
        padding: 15px 25px;
        display: flex;
        align-items: center;
        border-radius: 12px;
        margin: 8px 15px;
        transition: var(--transition);
        font-weight: 500;
    }

    .sidebar .nav-link i {
        margin-right: 15px;
        width: 24px;
        text-align: center;
        font-size: 1.2rem;
        background: var(--primary-gradient);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
    }

    .sidebar .nav-link:hover {
        background: var(--primary-gradient);
        color: white;
        transform: translateX(5px);
    }

    .sidebar .nav-link:hover i {
        background: none;
        -webkit-text-fill-color: white;
    }

    .toggle-button {
        background: rgba(255, 255, 255, 0.1);
        border: none;
        color: white;
        font-size: 1.2rem;
        cursor: pointer;
        padding: 10px;
        border-radius: 12px;
        transition: var(--transition);
        position: fixed;
        top: 15px;
        left: 25px;
        z-index: 1001;
    }

    .toggle-button:hover {
        background: rgba(255, 255, 255, 0.2);
        transform: scale(1.05);
    }

    #hideSidebarBtn {
        display: none;
    }

    .profile-button {
        background: rgba(255, 255, 255, 0.1);
        border-radius: 15px;
        padding: 8px 20px;
        transition: var(--transition);
        display: flex;
        align-items: center;
        gap: 12px;
    }

    .profile-button:hover {
        background: rgba(255, 255, 255, 0.2);
        transform: translateY(-2px);
    }

    .profile-image {
        border: 3px solid rgba(255, 255, 255, 0.8);
        transition: var(--transition);
    }

    .profile-button:hover .profile-image {
        transform: scale(1.05);
    }

    .profile-button span {
        color: white;
        font-weight: 500;
    }

    .logout-btn {
        background-color: white;
        color: #2c3e50;
        border-radius: 12px;
        padding: 8px 25px;
        font-weight: 600;
        transition: var(--transition);
    }

    .logout-btn:hover {
        transform: translateY(-2px);
        box-shadow: var(--card-shadow);
    }

    @media (max-width: 768px) {
        .sidebar {
            width: 100%;
            left: -100%;
            border-radius: 0;
        }

        .navbar-custom {
            padding: 0 15px;
        }

        .toggle-button {
            left: 15px;
        }

        .profile-button span {
            display: none;
        }

        .profile-button {
            padding: 5px;
        }

        .logout-btn {
            padding: 8px 15px;
        }
    }
</style>

<nav class="navbar navbar-expand-lg navbar-custom">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/professeur/dashboard">
            <i class="fas fa-graduation-cap"></i>
            GNotes - Espace Professeur
        </a>
        <div class="d-flex align-items-center gap-3">
            <button class="profile-button btn d-flex align-items-center gap-2"
                    onclick="window.location.href='${pageContext.request.contextPath}/utilisateur/profile'">
                <svg xmlns="http://www.w3.org/2000/svg" width="42" height="42" fill="currentColor" class="bi bi-person-circle" viewBox="0 0 16 16">
                    <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0"/>
                    <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8m8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1"/>
                </svg>
                <span>${nomUtilisateur}</span>
            </button>
            <button class="logout-btn btn" onclick="window.location.href='${pageContext.request.contextPath}/utilisateur/logout'">
                <i class="fas fa-sign-out-alt me-2"></i>Déconnexion
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
    <div class="sidebar-header">Menu Principal</div>
    <nav class="nav flex-column">
        <a class="nav-link" href="${pageContext.request.contextPath}/professeur/dashboard">
            <i class="fas fa-home"></i>Tableau de Bord
        </a>
        <a class="nav-link" href="${pageContext.request.contextPath}/professeur/etudiants">
            <i class="fas fa-users"></i>Mes Étudiants
        </a>
        <a class="nav-link" href="${pageContext.request.contextPath}/professeur/elements">
            <i class="fas fa-book"></i>Mes Éléments
        </a>
        <a class="nav-link" href="${pageContext.request.contextPath}/professeur/notes">
            <i class="fas fa-graduation-cap"></i>Gestion des Notes
        </a>
    </nav>
</div>

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