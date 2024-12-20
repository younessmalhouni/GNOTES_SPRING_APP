<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <div class="card shadow">
        <div class="card-body text-center">
            <img src="jetbrains://idea/navigate/reference?project=GNotesAPP12&path=static%2Fprofile.jpeg" alt="Profile" class="rounded-circle mb-3" width="100" height="100">
            <h3>${utilisateur.nom} ${utilisateur.prenom}</h3>
            <p class="text-muted">${utilisateur.nomUtilisateur}</p>
            <p><strong>Role:</strong> ${role}</p>
            <p><strong>Specialité:</strong> ${specialite}</p>
        </div>
    </div>
</div>
</body>
</html>
