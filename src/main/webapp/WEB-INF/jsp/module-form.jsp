<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE jsp>
    <head>
        <meta charset="UTF-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <title>Module Form</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    </head>
    <body>
    <div class="container mt-5">
        <h1 class="mb-4">
            <c:choose>
                <c:when test="${module.codeModule == null}">Add New Module</c:when>
                <c:otherwise>Edit Module</c:otherwise>
            </c:choose>
        </h1>
        <form action="${pageContext.request.contextPath}/modules/save" method="post">
            <div class="mb-3">
                <label for="codeModule" class="form-label">Module Code</label>
                <input type="text" class="form-control" id="codeModule" name="codeModule"
                       value="${module.codeModule}" <c:if test="${module.codeModule != null}">readonly</c:if> required/>
            </div>
            <div class="mb-3">
                <label for="nomModule" class="form-label">Module Name</label>
                <input type="text" class="form-control" id="nomModule" name="nomModule"
                       value="${module.nomModule}" required/>
            </div>
            <div class="mb-3">
                <label for="filliere" class="form-label">Filliere</label>
                <select class="form-control" id="filliere" name="filliere.idFilliere" required>
                    <option value="" disabled selected>Select a Filliere</option>
                    <c:forEach var="filliere" items="${fillieres}">
                        <option value="${filliere.idFilliere}"
                                <c:if test="${module.filliere != null && module.filliere.idFilliere == filliere.idFilliere}">
                                    selected
                                </c:if>
                        >
                            <c:out value="${filliere.nomFilliere}"/>
                        </option>
                    </c:forEach>
                </select>
            </div>
            <div class="mb-3">
                <label for="semestre" class="form-label">Semestre</label>
                <select class="form-control" id="semestre" name="semestre.id_Semestre" required>
                    <option value="" disabled selected>Select a Semestre</option>
                    <c:forEach var="semestre" items="${semestres}">
                        <option value="${semestre.id_Semestre}"
                                <c:if test="${module.semestre != null && module.semestre.id_Semestre == semestre.id_Semestre}">
                                    selected
                                </c:if>
                        >
                            <c:out value="${semestre.nom_Semestre}"/>
                        </option>
                    </c:forEach>
                </select>
            </div>
            <button type="submit" class="btn btn-success">Save</button>
            <a href="modules" class="btn btn-secondary">Cancel</a>
        </form>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>

