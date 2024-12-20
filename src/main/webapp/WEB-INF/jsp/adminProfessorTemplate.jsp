<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Admin & Professor Dashboard</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body class="bg-light">
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
  <div class="container">
    <a class="navbar-brand" href="#">GNotes App</a>
    <div class="d-flex align-items-center">
      <button
              class="btn btn-primary d-flex align-items-center me-3"
              onclick="window.location.href='${pageContext.request.contextPath}/utilisateur/profile'">
        <img src="src/main/resources/static/profile.jpeg" alt="Profile" class="rounded-circle me-2" width="40" height="40">
        <span>${nomUtilisateur}</span>
      </button>
      <button class="btn btn-light" onclick="window.location.href='${pageContext.request.contextPath}/logout'">Logout</button>
    </div>
  </div>
</nav>

<div class="container mt-5">
  <h1 class="text-center mb-4">Welcome Admin & Professor: ${nomUtilisateur}</h1>
  <p class="text-center text-muted">Manage your tasks and admin responsibilities:</p>
  <div class="row row-cols-1 row-cols-md-2 g-4">
    <!-- Professor Functionalities -->
    <div class="col">
      <div class="card shadow h-100">
        <div class="card-body text-center">
          <h5 class="card-title">Saisir les Notes</h5>
          <p class="card-text">Enter grades for your assigned students.</p>
          <button class="btn btn-primary w-100" onclick="location.href='${pageContext.request.contextPath}/notes/input'">
            Access
          </button>
        </div>
      </div>
    </div>
    <div class="col">
      <div class="card shadow h-100">
        <div class="card-body text-center">
          <h5 class="card-title">Modifier les Notes</h5>
          <p class="card-text">Modify grades before validation.</p>
          <button class="btn btn-primary w-100" onclick="location.href='${pageContext.request.contextPath}/notes/edit'">
            Access
          </button>
        </div>
      </div>
    </div>
    <div class="col">
      <div class="card shadow h-100">
        <div class="card-body text-center">
          <h5 class="card-title">Valider les Notes</h5>
          <p class="card-text">Validate grades for a module.</p>
          <button class="btn btn-primary w-100" onclick="location.href='${pageContext.request.contextPath}/notes/validate'">
            Access
          </button>
        </div>
      </div>
    </div>
    <div class="col">
      <div class="card shadow h-100">
        <div class="card-body text-center">
          <h5 class="card-title">Exporter les Notes</h5>
          <p class="card-text">Export validated grades to Excel or PDF.</p>
          <button class="btn btn-primary w-100" onclick="location.href='${pageContext.request.contextPath}/notes/export'">
            Access
          </button>
        </div>
      </div>
    </div>

    <!-- Admin Functionalities -->
    <div class="col">
      <div class="card shadow h-100">
        <div class="card-body text-center">
          <h5 class="card-title">Manage Users</h5>
          <p class="card-text">Add, edit, or remove users in the system.</p>
          <button class="btn btn-primary w-100" onclick="location.href='${pageContext.request.contextPath}/admin/users'">
            Access
          </button>
        </div>
      </div>
    </div>
    <div class="col">
      <div class="card shadow h-100">
        <div class="card-body text-center">
          <h5 class="card-title">View Reports</h5>
          <p class="card-text">Generate and review system reports.</p>
          <button class="btn btn-primary w-100" onclick="location.href='${pageContext.request.contextPath}/admin/reports'">
            Access
          </button>
        </div>
      </div>
    </div>
    <div class="col">
      <div class="card shadow h-100">
        <div class="card-body text-center">
          <h5 class="card-title">Manage Modules</h5>
          <p class="card-text">Add, edit, or remove academic modules.</p>
          <button class="btn btn-primary w-100" onclick="location.href='${pageContext.request.contextPath}/admin/modules'">
            Access
          </button>
        </div>
      </div>
    </div>
    <div class="col">
      <div class="card shadow h-100">
        <div class="card-body text-center">
          <h5 class="card-title">System Settings</h5>
          <p class="card-text">Configure and manage system-wide settings.</p>
          <button class="btn btn-primary w-100" onclick="location.href='${pageContext.request.contextPath}/admin/settings'">
            Access
          </button>
        </div>
      </div>
    </div>
  </div>
</div>
</body>
</html>
