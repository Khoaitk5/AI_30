<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách xe - TVT Future</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dashboard-modern.css">
    <style>
        .top-navbar {
            display: flex;
            align-items: center;
            background-color: #181818;
            padding: 12px 24px;
            border-bottom: 3px solid #000;
            flex-wrap: wrap;
        }
        .top-navbar a {
            color: #fff;
            text-decoration: none;
            margin-right: 20px;
            font-weight: 600;
            font-size: 15px;
            transition: all 0.2s;
        }
        .top-navbar a:hover {
            color: #ffd700;
        }
        .top-navbar .brand {
            font-size: 20px;
            font-weight: bold;
            margin-right: 40px;
            color: #fff;
        }
        .top-navbar .logout {
            margin-left: auto;
            color: #f66 !important;
        }
        .main-content {
            padding: 36px 18px 18px 18px;
        }
    </style>
</head>
<body>
    <!-- Top Navigation Bar -->
    <nav class="top-navbar">
        <div class="brand">
            <i class="fas fa-car"></i> TVT Future
        </div>
        <a href="${pageContext.request.contextPath}/dashboard"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
        <a href="${pageContext.request.contextPath}/customers"><i class="fas fa-user-friends"></i> Khách hàng</a>
        <a href="${pageContext.request.contextPath}/cars"><i class="fas fa-car"></i> Xe</a>
        <a href="${pageContext.request.contextPath}/bookings"><i class="fas fa-calendar-check"></i> Đặt xe</a>
        <a href="${pageContext.request.contextPath}/payments"><i class="fas fa-credit-card"></i> Thanh toán</a>
        <a href="${pageContext.request.contextPath}/reports"><i class="fas fa-chart-bar"></i> Báo cáo</a>
        <a class="logout" href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt"></i> Đăng xuất</a>
    </nav>

    <!-- Main Content -->
    <main class="main-content">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h1>Danh sách xe</h1>
            <a href="${pageContext.request.contextPath}/cars/add" class="btn btn-primary"><i class="fas fa-plus"></i> Thêm xe</a>
        </div>
        <div class="card">
            <div class="card-body">
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Mẫu xe</th>
                            <th>Màu sắc</th>
                            <th>Biển số</th>
                            <th>Số khung</th>
                            <th>Trạng thái</th>
                            <th>Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="car" items="${cars}">
                            <tr>
                                <td>${car.id}</td>
                                <td>${car.vehicleModelId.model}</td>
                                <td>${car.colorId.name}</td>
                                <td>${car.licensePlate}</td>
                                <td>${car.chassisNumber}</td>
                                <td>${car.status}</td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/cars/edit?id=${car.id}" class="btn btn-sm btn-primary"><i class="fas fa-edit"></i> Sửa</a>
                                    <c:choose>
                                        <c:when test="${car.status == 'maintenance'}">
                                            <a href="${pageContext.request.contextPath}/cars/active?id=${car.id}" class="btn btn-sm btn-success" onclick="return confirm('Bạn có chắc muốn kích hoạt lại xe này?');"><i class="fas fa-check"></i> Active</a>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="${pageContext.request.contextPath}/cars/unactive?id=${car.id}" class="btn btn-sm btn-danger" onclick="return confirm('Bạn có chắc muốn chuyển trạng thái xe này sang bảo trì?');"><i class="fas fa-ban"></i> Unactive</a>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>