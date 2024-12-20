<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Page</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container vh-100 d-flex justify-content-center align-items-center">
    <div class="card shadow p-4" style="width: 400px;">
        <h2 class="text-center mb-4">Login</h2>
        <form action="${pageContext.request.contextPath}/utilisateur/loginUser" method="post">
            <div class="mb-3">
                <label for="nomUtilisateur" class="form-label">Username</label>
                <input type="text" class="form-control" id="nomUtilisateur" name="nomUtilisateur" required>
            </div>
            <div class="mb-3">
                <label for="motDePasse" class="form-label">Password</label>
                <input type="password" class="form-control" id="motDePasse" name="motDePasse" required>
            </div>
            <button type="submit" class="btn btn-primary w-100">Login</button>
            <p class="text-danger mt-3">${msg}</p> <!-- Error message if any -->
        </form>
    </div>
</div>
</body>
</html>
