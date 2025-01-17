<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>List of Fillières</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.css" rel="stylesheet">

    <style>
        :root {
            --primary-gradient: linear-gradient(45deg, #2980b9, #2c3e50);
            --hover-gradient: linear-gradient(45deg, #3498db, #2980b9);
            --card-shadow: 0 8px 25px rgba(52, 152, 219, 0.4);
        }

        body {
            background: #f8f9fa;
            padding-top: 30px;
        }

        .card {
            border: none;
            border-radius: 15px;
            background: white;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            transition: all 0.4s ease;
            overflow: hidden;
        }

        .card:hover {
            transform: translateY(-10px);
            box-shadow: var(--card-shadow);
        }

        .card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 4px;
            background: var(--primary-gradient);
        }

        .page-title {
            color: #2c3e50;
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
            background: var(--primary-gradient);
        }

        .add-btn {
            background: var(--primary-gradient);
            border: none;
            padding: 12px 25px;
            border-radius: 25px;
            transition: all 0.3s ease;
        }

        .add-btn:hover {
            background: var(--hover-gradient);
            transform: translateY(-2px);
            box-shadow: var(--card-shadow);
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
            background: var(--primary-gradient);
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
            color: #6c757d;
            font-size: 0.9rem;
            margin-top: 10px;
        }

        .description-text {
            color: #666;
            font-size: 0.95rem;
            margin: 15px 0;
            line-height: 1.6;
            position: relative;
            padding-left: 20px;
            border-left: 3px solid #2980b9;
            background: #f8f9fa;
            padding: 15px;
            border-radius: 0 10px 10px 0;
            margin-top: 20px;
        }

        .stats-badge {
            display: inline-block;
            padding: 5px 12px;
            border-radius: 15px;
            font-size: 0.8rem;
            margin-right: 10px;
            background: rgba(41, 128, 185, 0.1);
            color: #2980b9;
        }

        .card-title {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .card-title i {
            font-size: 1.4rem;
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
    </style>
    <jsp:include page="header.jsp"/>
</head>
<body>
<div class="container py-5">
    <div class="d-flex justify-content-between align-items-center mb-5" data-aos="fade-down">
        <h2 class="page-title">Liste Des Fillieres</h2>
        <a href="${pageContext.request.contextPath}/fillieres/add" class="btn add-btn text-white">
            <i class="fas fa-plus-circle me-2"></i>Ajouter Filliere
        </a>
    </div>

    <div class="row g-4">
        <c:forEach var="filliere" items="${fillieres}" varStatus="status">
            <div class="col-md-6" data-aos="fade-up" data-aos-delay="${status.index * 100}">
                <div class="card h-100">
                    <div class="card-number">${status.index + 1}</div>
                    <div class="card-body p-4">
                        <h5 class="card-title fw-bold mb-3">
                            <i class="fas fa-graduation-cap"></i>
                                ${filliere.nomFilliere}
                        </h5>

                        <div class="description-text">
                            <i class="fas fa-quote-left me-2 text-primary"></i>
                                ${filliere.description}
                        </div>

                        <div class="mt-3">
                            <span class="stats-badge">
                                <i class="fas fa-users me-1"></i>
                                ${filliere.etudiants.size()} Students
                            </span>
                            <span class="stats-badge">
                                <i class="fas fa-book me-1"></i>
                                ${filliere.modules.size()} Modules
                            </span>
                        </div>

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

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.js"></script>
<script>
    AOS.init({
        duration: 800,
        once: true
    });
</script>
</body>
</html>