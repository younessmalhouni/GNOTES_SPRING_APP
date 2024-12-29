<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Professors List</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<jsp:include page="header.jsp" />
<div class="container mt-5">
    <h1 class="text-center mb-4">Professors List</h1>

    <div class="row mb-4">
        <div class="col-md-4">
            <div class="input-group">
                <input type="text" id="searchInput" class="form-control" placeholder="Search by name or surname">
            </div>
        </div>
        <div class="col-md-4">
            <select id="specialitySelect" class="form-select">
                <option value="">Tous Les specialites</option>
                <c:forEach var="specialite" items="${specialites}">
                    <option value="${specialite}">${specialite}</option>
                </c:forEach>
            </select>
        </div>
        <div class="col-md-4 text-end">
            <a href="${pageContext.request.contextPath}/professeurs/add" class="btn btn-success">Add Professor</a>
        </div>
    </div>

    <div class="table-responsive">
        <table class="table table-bordered table-hover">
            <thead class="table-dark">
            <tr>
                <th>Image</th>
                <th>Code</th>
                <th>Nom</th>
                <th>Prénom</th>
                <th>Specialité</th>

                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="professeur" items="${professeurs}">
                <tr>
                    <td>
                        <c:if test="${professeur.image != null}">
                            <img src="${professeur.image}" alt="Image" width="50" height="50">
                        </c:if>
                    </td>
                    <td>${professeur.code}</td>
                    <td>${professeur.nom}</td>
                    <td>${professeur.prenom}</td>
                    <td>${professeur.specialite}</td>

                    <td>
                        <a href="${pageContext.request.contextPath}/professeurs/edit/${professeur.code}"
                           class="btn btn-primary btn-sm">Edit</a>
                        <a href="${pageContext.request.contextPath}/professeurs/delete/${professeur.code}"
                           class="btn btn-danger btn-sm"
                           onclick="return confirm('Are you sure you want to delete this professor?')">Delete</a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<script>
    $(document).ready(function() {
        let searchTimeout;

        function updateTable(data) {
            const tableBody = $('tbody');
            tableBody.empty();

            if (data.length === 0) {
                tableBody.append(
                    <tr>
                        <td colspan="6" class="text-center">No professors found</td>
                    </tr>
                );
                return;
            }

            data.forEach(function(professeur) {
                const row =
                    <tr>
                        <td>
                            \${professeur.image ? '<img src="' + professeur.image + '" alt="Image" width="50" height="50">' : ''}
                        </td>
                        <td>\${professeur.code || ''}</td>
                        <td>\${professeur.nom || ''}</td>
                        <td>\${professeur.prenom || ''}</td>
                        <td>\${professeur.specialite || ''}</td>

                        <td>
                            <a href="${pageContext.request.contextPath}/professeurs/edit/\${professeur.code}"
                               class="btn btn-primary btn-sm">Edit</a>
                            <a href="${pageContext.request.contextPath}/professeurs/delete/\${professeur.code}"
                               class="btn btn-danger btn-sm"
                               onclick="return confirm('Are you sure you want to delete this professor?')">Delete</a>
                        </td>
                    </tr>
                ;
                tableBody.append(row);
            });
        }

        function performSearch() {
            const searchTerm = $('#searchInput').val().trim();
            const specialite = $('#specialitySelect').val();

            clearTimeout(searchTimeout);

            searchTimeout = setTimeout(function() {
                $.ajax({
                    url: `${pageContext.request.contextPath}/professeurs/search`,
                    type: 'GET',
                    data: {
                        searchTerm: searchTerm,
                        specialite: specialite
                    },
                    beforeSend: function() {
                        $('tbody').addClass('opacity-50');
                    },
                    success: function(data) {
                        updateTable(data);
                    },
                    error: function(xhr, status, error) {
                        console.error('Error during search:', error);
                        $('tbody').html(
                            <tr>
                                <td colspan="6" class="text-center text-danger">
                                    An error occurred while searching. Please try again.
                                </td>
                            </tr>
                        );
                    },
                    complete: function() {
                        $('tbody').removeClass('opacity-50');
                    }
                });
            }, 300);
        }

        // Event listeners for search input and speciality select
        $('#searchInput').on('input', performSearch);
        $('#specialitySelect').on('change', performSearch);

        // Initial search to load all professors
        performSearch();
    });
</script>
</body>
</html>