<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sửa xe - TVT Future</title>
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
        .error-message {
            color: red;
            font-weight: bold;
            margin-bottom: 15px;
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
        <a href="${pageContext.request.contextPath}/users"><i class="fas fa-users"></i> Người dùng</a>
        <a href="${pageContext.request.contextPath}/customers"><i class="fas fa-user-friends"></i> Khách hàng</a>
        <a href="${pageContext.request.contextPath}/cars"><i class="fas fa-car"></i> Xe</a>
        <a href="${pageContext.request.contextPath}/bookings"><i class="fas fa-calendar-check"></i> Đặt xe</a>
        <a href="${pageContext.request.contextPath}/payments"><i class="fas fa-credit-card"></i> Thanh toán</a>
        <a href="${pageContext.request.contextPath}/reports"><i class="fas fa-chart-bar"></i> Báo cáo</a>
        <a class="logout" href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt"></i> Đăng xuất</a>
    </nav>

    <!-- Main Content -->
    <main class="main-content">
        <h1>Sửa xe</h1>
        <div class="card">
            <div class="card-body">
                <c:if test="${not empty error}">
                    <div class="error-message">${error}</div>
                </c:if>
                <form action="${pageContext.request.contextPath}/cars/edit" method="post">
                    <input type="hidden" name="id" value="${car.id}">
                    <div class="mb-3">
                        <label for="vehicleModelId" class="form-label">Mẫu xe</label>
                        <select class="form-select" id="vehicleModelId" name="vehicleModelId" required>
                            <option value="md01" ${car.vehicleModelId.id == 'md01' ? 'selected' : ''}>VinFast VF 3</option>
                            <option value="md02" ${car.vehicleModelId.id == 'md02' ? 'selected' : ''}>VinFast VF 6S</option>
                            <option value="md03" ${car.vehicleModelId.id == 'md03' ? 'selected' : ''}>VinFast VF 6 Plus</option>
                            <option value="md04" ${car.vehicleModelId.id == 'md04' ? 'selected' : ''}>VinFast VF 7S</option>
                            <option value="md05" ${car.vehicleModelId.id == 'md05' ? 'selected' : ''}>VinFast VF 7 Plus</option>
                            <option value="md06" ${car.vehicleModelId.id == 'md06' ? 'selected' : ''}>VinFast VF 8 Eco</option>
                            <option value="md07" ${car.vehicleModelId.id == 'md07' ? 'selected' : ''}>VinFast VF 8 Plus</option>
                            <option value="md08" ${car.vehicleModelId.id == 'md08' ? 'selected' : ''}>VinFast VF 9 Eco</option>
                            <option value="md09" ${car.vehicleModelId.id == 'md09' ? 'selected' : ''}>VinFast VF 9 Plus</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="colorId" class="form-label">Màu sắc</label>
                        <select class="form-select" id="colorId" name="colorId" required>
                            <option value="clr01" ${car.colorId.id == 'clr01' ? 'selected' : ''}>Jet Black</option>
                            <option value="clr02" ${car.colorId.id == 'clr02' ? 'selected' : ''}>Pearl White</option>
                            <option value="clr03" ${car.colorId.id == 'clr03' ? 'selected' : ''}>Crimson Red</option>
                            <option value="clr04" ${car.colorId.id == 'clr04' ? 'selected' : ''}>Ocean Blue</option>
                            <option value="clr05" ${car.colorId.id == 'clr05' ? 'selected' : ''}>Silver Metallic</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="licensePlate" class="form-label">Biển số</label>
                        <input type="text" class="form-control" id="licensePlate" name="licensePlate" value="${car.licensePlate}" required>
                    </div>
                    <div class="mb-3">
                        <label for="chassisNumber" class="form-label">Số khung</label>
                        <input type="text" class="form-control" id="chassisNumber" name="chassisNumber" value="${car.chassisNumber}" required>
                    </div>
                    <div class="mb-3">
                        <label for="status" class="form-label">Trạng thái</label>
                        <select class="form-select" id="status" name="status" required>
                            <option value="available" ${car.status == 'available' ? 'selected' : ''}>Có sẵn</option>
                            <option value="rented" ${car.status == 'rented' ? 'selected' : ''}>Đang thuê</option>
                            <option value="maintenance" ${car.status == 'maintenance' ? 'selected' : ''}>Bảo trì</option>
                        </select>
                    </div>
                    <button type="submit" class="btn btn-primary">Cập nhật</button>
                    <a href="${pageContext.request.contextPath}/cars" class="btn btn-secondary">Hủy</a>
                </form>
            </div>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>