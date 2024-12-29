<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>List of Fillières</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <!-- AOS Animation Library -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.css" rel="stylesheet">

    <style>
        :root {
            --primary-color: #4e73df;
            --secondary-color: #858796;
            --success-color: #1cc88a;
        }

        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #e4e8f1 100%);
        }

        .card {
            border: none;
            border-radius: 15px;
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(10px);
            transition: all 0.4s ease;
            overflow: hidden;
        }

        .card:hover {
            transform: translateY(-10px) scale(1.02);
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
        }

        .card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 4px;
            background: linear-gradient(90deg, var(--primary-color), var(--success-color));
        }

        .page-title {
            color: var(--primary-color);
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 2px;
            position: relative;
            padding-bottom: 10px;
        }

        .page-title::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 50px;
            height: 3px;
            background: var(--primary-color);
        }

        .add-btn {
            background: linear-gradient(45deg, var(--primary-color), var(--success-color));
            border: none;
            padding: 12px 25px;
            border-radius: 25px;
            transition: all 0.3s ease;
        }

        .add-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }

        .card-actions {
            opacity: 0;
            transform: translateY(20px);
            transition: all 0.3s ease;
        }

        .card:hover .card-actions {
            opacity: 1;
            transform: translateY(0);
        }

        .btn-custom {
            border-radius: 20px;
            padding: 8px 20px;
            font-weight: 500;
            letter-spacing: 1px;
            transition: all 0.3s ease;
        }

        .btn-custom:hover {
            transform: translateY(-2px);
        }

        .card-number {
            position: absolute;
            top: 10px;
            right: 10px;
            background: var(--primary-color);
            color: white;
            width: 30px;
            height: 30px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.9rem;
        }

        .creation-date {
            color: var(--secondary-color);
            font-size: 0.9rem;
            margin-top: 10px;
        }
    </style>
</head>
<body>
<div class="container py-5">
    <div class="d-flex justify-content-between align-items-center mb-5" data-aos="fade-down">
        <h2 class="page-title">List of Fillières</h2>
        <a href="${pageContext.request.contextPath}/fillieres/add" class="btn add-btn text-white">
            <i class="fas fa-plus-circle me-2"></i>Ajouter Filliere
        </a>
    </div>

    <div class="row g-4">
        <c:forEach var="filliere" items="${fillieres}" varStatus="status">
            <div class="col-md-4" data-aos="fade-up" data-aos-delay="${status.index * 100}">
                <div class="card h-100">
                    <div class="card-number">${status.index + 1}</div>
                    <div class="card-body p-4">
                        <h5 class="card-title fw-bold mb-3">
                            <i class="fas fa-graduation-cap me-2 text-primary"></i>
                                ${filliere.nomFilliere}
                        </h5>
                        <div class="creation-date">
                            <i class="far fa-calendar-alt me-2"></i>
                            Created on ${filliere.dateCreation}
                        </div>
                        <div class="card-actions mt-4">
                            <div class="d-flex justify-content-between gap-2">
                                <a href="${pageContext.request.contextPath}/fillieres/edit/${filliere.idFilliere}"
                                   class="btn btn-custom btn-warning flex-grow-1">
                                    <i class="fas fa-edit me-2"></i>Edit
                                </a>
                                <a href="${pageContext.request.contextPath}/fillieres/delete/${filliere.idFilliere}"
                                   class="btn btn-custom btn-danger flex-grow-1"
                                   onclick="return confirm('Are you sure you want to delete this filliere?');">
                                    <i class="fas fa-trash-alt me-2"></i>Delete
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<!-- AOS Animation Library -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.js"></script>
<script>
    AOS.init({
        duration: 800,
        once: true
    });
</script>
</body>
</html>