<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách Thanh toán - TVT Future</title>
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
            <h1>Danh sách Thanh toán</h1>
            <a href="${pageContext.request.contextPath}/payments/add" class="btn btn-primary"><i class="fas fa-plus"></i> Thêm Thanh toán</a>
        </div>

        <!-- Payment List Table -->
        <div class="card">
            <div class="card-header">
                <h5><i class="fas fa-credit-card"></i> Danh sách Thanh toán</h5>
            </div>
            <div class="card-body">
                <table class="table table-striped table-hover">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Booking ID</th>
                            <th>Số tiền</th>
                            <th>Tiền cọc</th>
                            <th>Chi phí khác</th>
                            <th>Trạng thái</th>
                            <th>Phương thức</th>
                            <th>Thời gian</th>
                            <th>Phạt trễ</th>
                            <th>Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="payment" items="${requestScope.paymentList}">
                            <tr>
                                <td>${payment.id}</td>
                                <td>${payment.bookingId.id}</td>
                                <td>₫${payment.amount}</td>
                                <td>₫${payment.deposit}</td>
                                <td>₫${payment.otherCosts}</td>
                                <td>
                                    <span class="badge bg-${payment.status == 'PENDING' ? 'warning' : payment.status == 'COMPLETED' ? 'success' : 'danger'}">
                                        ${payment.status}
                                    </span>
                                </td>
                                <td>${payment.paymentMethod}</td>
                                <td>${payment.timestamp}</td>
                                <td>₫${payment.latePaymentPenalty}</td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/payments/edit?id=${payment.id}" class="btn btn-sm btn-warning"><i class="fas fa-edit"></i> Sửa</a>
                                    <a href="${pageContext.request.contextPath}/payments/delete?id=${payment.id}" class="btn btn-sm btn-danger" onclick="return confirm('Bạn có chắc muốn xóa thanh toán này?')"><i class="fas fa-trash"></i> Xóa</a>
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