<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm Thanh toán - TVT Future</title>
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
            <h1>Thêm Thanh toán</h1>
            <a href="${pageContext.request.contextPath}/payments" class="btn btn-secondary"><i class="fas fa-arrow-left"></i> Quay lại</a>
        </div>

        <!-- Add Payment Form -->
        <div class="card">
            <div class="card-header">
                <h5><i class="fas fa-plus"></i> Thêm Thanh toán mới</h5>
            </div>
            <div class="card-body">
                <form action="${pageContext.request.contextPath}/payments/paymentAdd" method="post">
                    <div class="mb-3">
                        <label for="bookingId" class="form-label">Booking ID</label>
                        <select class="form-select" id="bookingId" name="bookingId" required>
                            <option value="">Chọn Booking</option>
                            <c:forEach var="booking" items="${requestScope.bookingList}">
                                <option value="${booking.id}">${booking.id}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="amount" class="form-label">Số tiền</label>
                        <input type="number" class="form-control" id="amount" name="amount" step="0.01" required>
                    </div>
                    <div class="mb-3">
                        <label for="deposit" class="form-label">Tiền cọc</label>
                        <input type="number" class="form-control" id="deposit" name="deposit" step="0.01" required>
                    </div>
                    <div class="mb-3">
                        <label for="otherCosts" class="form-label">Chi phí khác</label>
                        <input type="number" class="form-control" id="otherCosts" name="otherCosts" step="0.01" value="0.00">
                    </div>
                    <div class="mb-3">
                        <label for="status" class="form-label">Trạng thái</label>
                        <select class="form-select" id="status" name="status" required>
                            <option value="PENDING">PENDING</option>
                            <option value="COMPLETED">COMPLETED</option>
                            <option value="FAILED">FAILED</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="paymentMethod" class="form-label">Phương thức thanh toán</label>
                        <select class="form-select" id="paymentMethod" name="paymentMethod" required>
                            <option value="VNPAY">VNPAY</option>
                            <option value="CASH">Tiền mặt</option>
                            <option value="BANK_TRANSFER">Chuyển khoản</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="latePaymentPenalty" class="form-label">Phạt trễ</label>
                        <input type="number" class="form-control" id="latePaymentPenalty" name="latePaymentPenalty" step="0.01" value="0.00">
                    </div>
                    <button type="submit" class="btn btn-primary"><i class="fas fa-save"></i> Lưu</button>
                </form>
            </div>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>