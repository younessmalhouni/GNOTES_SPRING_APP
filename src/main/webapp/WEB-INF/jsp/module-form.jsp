<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Module Form</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <style>
        .element-item {
            background-color: #f8f9fa;
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 15px;
        }
        .modality-item {
            background-color: #ffffff;
            border: 1px solid #dee2e6;
            border-radius: 6px;
            padding: 10px;
            margin-top: 10px;
        }
        .required-field::after {
            content: " *";
            color: red;
        }
    </style>
</head>
<body>
<div class="container mt-5">
    <h1 class="mb-4">
        <c:choose>
            <c:when test="${module.codeModule == null}">Ajouter un nouveau Module</c:when>
            <c:otherwise>Modifier Module</c:otherwise>
        </c:choose>
    </h1>

    <form action="${pageContext.request.contextPath}/modules/save" method="post" class="needs-validation" novalidate>
        <!-- Module Details Section -->
        <div class="card mb-4">
            <div class="card-header">
                <h4 class="mb-0">Module Information</h4>
            </div>
            <div class="card-body">
                <div class="row">
                    <!-- Module Code -->
                    <div class="col-md-6 mb-3">
                        <label for="codeModule" class="form-label required-field">Module Code</label>
                        <input type="hidden" class="form-control" id="codeModule" name="codeModule"
                               value="${module.codeModule}"
                               <c:if test="${module.codeModule != null}">readonly</c:if>
                        />
                        <div class="invalid-feedback">Please provide a module code.</div>
                    </div>

                    <!-- Module Name -->
                    <div class="col-md-6 mb-3">
                        <label for="nomModule" class="form-label required-field">Module Name</label>
                        <input type="text" class="form-control" id="nomModule" name="nomModule"
                               value="${module.nomModule}" required/>
                        <div class="invalid-feedback">Please provide a module name.</div>
                    </div>

                    <!-- Filliere Selection -->
                    <div class="col-md-6 mb-3">
                        <label for="filliere" class="form-label required-field">Filliere</label>
                        <select class="form-select" id="filliere" name="filliere.idFilliere" required>
                            <option value="">Select a Filliere</option>
                            <c:forEach var="filliere" items="${fillieres}">
                                <option value="${filliere.idFilliere}"
                                        <c:if test="${module.filliere != null && module.filliere.idFilliere == filliere.idFilliere}">selected</c:if>>
                                    <c:out value="${filliere.nomFilliere}"/>
                                </option>
                            </c:forEach>
                        </select>
                        <div class="invalid-feedback">Please select a filliere.</div>
                    </div>

                    <!-- Semestre Selection -->
                    <div class="col-md-6 mb-3">
                        <label for="semestre" class="form-label required-field">Semestre</label>
                        <select class="form-select" id="semestre" name="semestre.id_Semestre" required>
                            <option value="">Select a Semestre</option>
                            <c:forEach var="semestre" items="${semestres}">
                                <option value="${semestre.id_Semestre}"
                                        <c:if test="${module.semestre != null && module.semestre.id_Semestre == semestre.id_Semestre}">selected</c:if>>
                                    <c:out value="${semestre.nom_Semestre}"/>
                                </option>
                            </c:forEach>
                        </select>
                        <div class="invalid-feedback">Please select a semestre.</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Elements Section -->
        <div class="card mb-4">
            <div class="card-header d-flex justify-content-between align-items-center">
                <h4 class="mb-0">Elements</h4>
                <button type="button" id="add-element" class="btn btn-primary btn-sm">
                    <i class="fas fa-plus"></i> Add Element
                </button>
            </div>
            <div class="card-body">
                <div id="elements-container">
                    <c:forEach var="element" items="${module.elements}" varStatus="status">
                        <div class="element-item">
                            <div class="row">
                                <!-- Hidden input for module relationship -->
                                <input type="hidden" name="elements[${status.index}].module.codeModule"
                                       value="${module.codeModule}"/>

                                <!-- Element ID -->
                                <div class="col-md-4 mb-3">
                                    <label class="form-label required-field">Element ID</label>
                                    <input type="hidden" class="form-control"
                                           name="elements[${status.index}].idElement"
                                           value="${element.idElement}" />
                                </div>

                                <!-- Element Name -->
                                <div class="col-md-4 mb-3">
                                    <label class="form-label required-field">Element Name</label>
                                    <input type="text" class="form-control"
                                           name="elements[${status.index}].nomElement"
                                           value="${element.nomElement}" required/>
                                </div>

                                <!-- Element Coefficient -->
                                <div class="col-md-4 mb-3">
                                    <label class="form-label required-field">Coefficient</label>
                                    <input type="number"
                                           step="0.01"
                                           class="form-control"
                                           name="elements[${status.index}].coefficient"
                                           value="<c:out value='${element.coefficient < 1 ? 1 : element.coefficient > 100 ? 100 : element.coefficient}'/>"
                                           min="1"
                                           max="100"
                                           required/>
                                    <div class="invalid-feedback">Coefficient must be between 1 and 100.</div>
                                </div>
                                <!--Professeur-->
                                <div class="col-md-6 mb-3">
                                    <label for="professeur" class="form-label required-field">Professeur</label>
                                    <select class="form-select" id="professeur" name="elements[${status.index}].professeur.code" required>
                                        <option value="">Selectioner un Professeur</option>
                                        <c:forEach var="professeur" items="${professeurs}">
                                            <option value="${professeur.code}"
                                                    <c:if test="${element.professeur != null && element.professeur.code == professeur.code}">selected</c:if>>
                                                <c:out value="${professeur.nom}"/>
                                            </option>
                                        </c:forEach>
                                    </select>
                                    <div class="invalid-feedback">Selectionner un professeur.</div>
                                </div>
                            </div>

                            <!-- Modalities Section -->
                            <div class="modalities-container mt-3">
                                <h6 class="mb-3">Evaluation Modalities</h6>
                                <div class="modalities-list">
                                    <c:forEach var="modalite" items="${element.modalites}" varStatus="modalStatus">
                                        <div class="modality-item">
                                            <div class="row">
                                                <!-- Hidden input for element relationship -->
                                                <input type="hidden"
                                                       name="elements[${status.index}].modalites[${modalStatus.index}].element.idElement"
                                                       value="${element.idElement}"/>

                                                <!-- Modality Type -->
                                                <div class="col-md-6 mb-2">
                                                    <label class="form-label required-field">Type</label>
                                                    <input type="text" class="form-control"
                                                           name="elements[${status.index}].modalites[${modalStatus.index}].type_Modalite"
                                                           value="${modalite.type_Modalite}" required/>
                                                </div>

                                                <!-- Modality Coefficient -->
                                                <div class="col-md-6 mb-2">
                                                    <label class="form-label required-field">Coefficient</label>
                                                    <input type="number"
                                                           step="0.01"
                                                           class="form-control"
                                                           name="elements[${status.index}].modalites[${modalStatus.index}].coeffecient"
                                                           value="<c:out value='${modalite.coeffecient < 1 ? 1 : modalite.coeffecient > 100 ? 100 : modalite.coeffecient}'/>"
                                                           min="1"
                                                           max="100"
                                                           required/>
                                                    <div class="invalid-feedback">Coefficient must be between 1 and 100.</div>
                                                </div>
                                            </div>
                                            <button type="button" class="btn btn-danger btn-sm mt-2 remove-modality">
                                                Remove Modality
                                            </button>
                                        </div>
                                    </c:forEach>
                                </div>
                                <button type="button" class="btn btn-info btn-sm mt-3 add-modality"
                                        data-element-index="${status.index}">
                                    Add Modality
                                </button>
                            </div>
                            <button type="button" class="btn btn-danger btn-sm mt-3 remove-element">
                                Remove Element
                            </button>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>

        <!-- Form Buttons -->
        <div class="d-flex justify-content-between mb-5">
            <a href="${pageContext.request.contextPath}/modules" class="btn btn-secondary">Cancel</a>
            <button type="submit" class="btn btn-success">Save Module</button>
        </div>
    </form>
</div>

<!-- Scripts -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://kit.fontawesome.com/your-font-awesome-kit.js"></script>
<!-- Scripts -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://kit.fontawesome.com/your-font-awesome-kit.js"></script>
<script>
    let elementIndex = ${module.elements.size() > 0 ? module.elements.size() : 0};

    // Function to calculate sum of coefficients
    const calculateSum = (inputs) => {
        return Array.from(inputs).reduce((sum, input) => sum + (parseFloat(input.value) || 0), 0);
    };

    // Validate element coefficients
    const validateElementCoefficients = (form) => {
        const elementCoefficients = form.querySelectorAll('input[name$="].coefficient"]');
        const sum = calculateSum(elementCoefficients);
        const isValid = sum <= 100;

        elementCoefficients.forEach(input => {
            if (!isValid) {
                input.setCustomValidity('Total element coefficients must not exceed 100');
            } else {
                input.setCustomValidity('');
            }
        });

        return isValid;
    };

    // Validate modality coefficients for each element
    const validateModalityCoefficients = (form) => {
        const elements = form.querySelectorAll('.element-item');
        let isValid = true;

        elements.forEach(element => {
            const modalityCoefficients = element.querySelectorAll('input[name$="].coeffecient"]');
            const sum = calculateSum(modalityCoefficients);

            modalityCoefficients.forEach(input => {
                if (sum > 100) {
                    input.setCustomValidity('Total modality coefficients for an element must not exceed 100');
                    isValid = false;
                } else {
                    input.setCustomValidity('');
                }
            });
        });

        return isValid;
    };

    // Add input event listeners for real-time validation
    const addInputListeners = (form) => {
        // Listen for changes on element coefficients
        form.querySelectorAll('input[name$="].coefficient"]').forEach(input => {
            input.addEventListener('input', () => {
                validateElementCoefficients(form);
                form.classList.add('was-validated');
            });
        });

        // Listen for changes on modality coefficients
        form.querySelectorAll('input[name$="].coeffecient"]').forEach(input => {
            input.addEventListener('input', () => {
                validateModalityCoefficients(form);
                form.classList.add('was-validated');
            });
        });
    };

    // Add new element
    document.getElementById('add-element').addEventListener('click', () => {
        const container = document.getElementById('elements-container');
        const elementHtml = `
            <div class="element-item">
                <div class="row">
                    <input type="hidden" name="elements[\${elementIndex}].module.codeModule"
                           value="${module.codeModule}"/>

                    <div class="col-md-4 mb-3">
                        <label class="form-label required-field">Element ID</label>
                        <input type="hidden" class="form-control"
                               name="elements[\${elementIndex}].idElement" required/>
                    </div>

                    <div class="col-md-4 mb-3">
                        <label class="form-label required-field">Element Name</label>
                        <input type="text" class="form-control"
                               name="elements[\${elementIndex}].nomElement" required/>
                    </div>

                    <div class="col-md-4 mb-3">
                        <label class="form-label required-field">Coefficient</label>
                        <input type="number"
                               step="0.01"
                               class="form-control"
                               name="elements[\${elementIndex}].coefficient"
                               value="1"
                               min="1"
                               max="100"
                               required/>
                        <div class="invalid-feedback">Le Coefficient doit être entre 1 et 100 et la somme ne doit pas dépasser 100.</div>
                    </div>
                </div>
                <div class="col-md-6 mb-3">
                    <label for="professeur" class="form-label required-field">Professeur</label>
                    <select class="form-select" id="professeur" name="elements[\${elementIndex}].professeur.code" required>
                        <option value="">Sélectionner un Professeur</option>
                        <c:forEach var="professeur" items="${professeurs}">
                            <option value="${professeur.code}">
                                <c:out value="${professeur.nom}"/>
                            </option>
                        </c:forEach>
                    </select>
                    <div class="invalid-feedback">Sélectionner un professeur.</div>
                </div>

                <div class="modalities-container mt-3">
                    <h6 class="mb-3">Evaluation Modalities</h6>
                    <div class="modalities-list">
                        <div class="modality-item">
                            <div class="row">
                                <div class="col-md-6 mb-2">
                                    <label class="form-label required-field">Type</label>
                                    <input type="text" class="form-control"
                                           name="elements[\${elementIndex}].modalites[0].type_Modalite" required/>
                                </div>
                                <div class="col-md-6 mb-2">
                                    <label class="form-label required-field">Coefficient</label>
                                    <input type="number" step="0.01" class="form-control" min="1" max="100" value="1"
                                           name="elements[\${elementIndex}].modalites[0].coeffecient" required/>
                                    <div class="invalid-feedback">Le Coefficient doit être entre 1 et 100 et la somme ne doit pas dépasser 100.</div>
                                </div>
                            </div>
                            <button type="button" class="btn btn-danger btn-sm mt-2 remove-modality">
                                Remove Modality
                            </button>
                        </div>
                    </div>
                    <button type="button" class="btn btn-info btn-sm mt-3 add-modality"
                            data-element-index="\${elementIndex}">
                        Add Modality
                    </button>
                </div>
                <button type="button" class="btn btn-danger btn-sm mt-3 remove-element">
                    Remove Element
                </button>
            </div>`;
        container.insertAdjacentHTML('beforeend', elementHtml);

        // Add validation listeners to the new element
        const form = document.querySelector('.needs-validation');
        if (form) {
            const newElement = form.querySelector('.element-item:last-child');
            if (newElement) {
                const coefficientInput = newElement.querySelector('input[name$="].coefficient"]');
                if (coefficientInput) {
                    coefficientInput.addEventListener('input', () => {
                        validateElementCoefficients(form);
                        form.classList.add('was-validated');
                    });
                }
            }
        }

        elementIndex++;
    });

    // Add new modality
    document.addEventListener('click', (event) => {
        if (event.target.classList.contains('add-modality')) {
            const elementIndex = event.target.dataset.elementIndex;
            const modalitiesContainer = event.target.previousElementSibling;
            const modalityCount = modalitiesContainer.children.length;

            const modalityHtml = `
                <div class="modality-item">
                    <div class="row">
                        <div class="col-md-6 mb-2">
                            <label class="form-label required-field">Type</label>
                            <input type="text" class="form-control"
                                   name="elements[\${elementIndex}].modalites[\${modalityCount}].type_Modalite" required/>
                        </div>
                        <div class="col-md-6 mb-2">
                            <label class="form-label required-field">Coefficient</label>
                            <input type="number"
                                   step="0.01"
                                   class="form-control"
                                   name="elements[\${elementIndex}].modalites[\${modalityCount}].coeffecient"
                                   value="1"
                                   min="1"
                                   max="100"
                                   required/>
                            <div class="invalid-feedback">Le Coefficient doit être entre 1 et 100 et la somme ne doit pas dépasser 100.</div>
                        </div>
                    </div>
                    <button type="button" class="btn btn-danger btn-sm mt-2 remove-modality">
                        Remove Modality
                    </button>
                </div>`;

            modalitiesContainer.insertAdjacentHTML('beforeend', modalityHtml);

            // Add validation listeners to the new modality
            const form = document.querySelector('.needs-validation');
            if (form) {
                const newModality = modalitiesContainer.lastElementChild;
                if (newModality) {
                    const coefficientInput = newModality.querySelector('input[name$="].coeffecient"]');
                    if (coefficientInput) {
                        coefficientInput.addEventListener('input', () => {
                            validateModalityCoefficients(form);
                            form.classList.add('was-validated');
                        });
                    }
                }
            }
        }
    });

    // Remove modality
    document.addEventListener('click', (event) => {
        if (event.target.classList.contains('remove-modality')) {
            const modalityItem = event.target.closest('.modality-item');
            const form = document.querySelector('.needs-validation');
            modalityItem.remove();
            if (form) {
                validateModalityCoefficients(form);
            }
        }
    });

    // Remove element
    document.addEventListener('click', (event) => {
        if (event.target.classList.contains('remove-element')) {
            const elementItem = event.target.closest('.element-item');
            const form = document.querySelector('.needs-validation');
            elementItem.remove();
            if (form) {
                validateElementCoefficients(form);
            }
        }
    });

    // Form validation
    (() => {
        'use strict';
        const forms = document.querySelectorAll('.needs-validation');

        Array.from(forms).forEach(form => {
            // Add input listeners for real-time validation
            addInputListeners(form);

            // Validate on form submission
            form.addEventListener('submit', event => {
                const elementsValid = validateElementCoefficients(form);
                const modalitiesValid = validateModalityCoefficients(form);

                if (!form.checkValidity() || !elementsValid || !modalitiesValid) {
                    event.preventDefault();
                    event.stopPropagation();
                }

                form.classList.add('was-validated');
            }, false);
        });
    })();
</script>
</body>
</html>