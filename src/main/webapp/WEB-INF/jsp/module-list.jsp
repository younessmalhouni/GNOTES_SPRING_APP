<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
    <head>
        <meta charset="UTF-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <title>Module List</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    </head>
    <body>
    <div class="container mt-5">
        <h1 class="mb-4">Modules</h1>
        <a href="modules/add" class="btn btn-primary mb-3">Add New Module</a>
        <table class="table table-striped table-bordered">
            <thead>
            <tr>
                <th>Code</th>
                <th>Name</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="module" items="${modules}">
                <tr>
                    <td><c:out value="${module.codeModule}"/></td>
                    <td><c:out value="${module.nomModule}"/></td>
                    <td>
                        <a href="modules/edit/${module.codeModule}" class="btn btn-warning btn-sm">Edit</a>
                        <a href="modules/delete/${module.codeModule}" class="btn btn-danger btn-sm"
                           onclick="return confirm('Are you sure you want to delete this module?');">Delete</a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>

