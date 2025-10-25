<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - TVT Future</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="dashboard-modern.css">
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
        <a href="dashboard"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
        <a href="customers"><i class="fas fa-user-friends"></i> Khách hàng</a>
        <a href="cars"><i class="fas fa-car"></i> Xe</a>
        <a href="bookings"><i class="fas fa-calendar-check"></i> Đặt xe</a>
        <a href="payments"><i class="fas fa-credit-card"></i> Thanh toán</a>
        <a href="reports"><i class="fas fa-chart-bar"></i> Báo cáo</a>
        <a class="logout" href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt"></i> Đăng xuất</a>
    </nav>

    <!-- Main Content -->
    <main class="main-content">
        <!-- Header -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h1>Dashboard</h1>
            <div>
                <span class="badge bg-primary fs-6">
                    <i class="fas fa-user"></i> 
                    Xin chào, ${sessionScope.currentUser.username}
                </span>
            </div>
        </div>

        <!-- Stats Cards -->
        <div class="row mb-4">
            <div class="col-md-3 mb-3">
                <div class="card stats-card">
                    <div class="card-body text-center">
                        <i class="fas fa-users fa-3x mb-3"></i>
                        <h3>${requestScope.totalCustomers}</h3>
                        <p>Tổng khách hàng</p>
                    </div>
                </div>
            </div>
            <div class="col-md-3 mb-3">
                <div class="card stats-card">
                    <div class="card-body text-center">
                        <i class="fas fa-car fa-3x mb-3"></i>
                        <h3>${requestScope.totalCars}</h3>
                        <p>Tổng số xe</p>
                    </div>
                </div>
            </div>
            <div class="col-md-3 mb-3">
                <div class="card stats-card">
                    <div class="card-body text-center">
                        <i class="fas fa-calendar-check fa-3x mb-3"></i>
                        <h3>${requestScope.todayBookings}</h3>
                        <p>Đặt xe hôm nay</p>
                    </div>
                </div>
            </div>
            <div class="col-md-3 mb-3">
                <div class="card stats-card">
                    <div class="card-body text-center">
                        <i class="fas fa-money-bill-wave fa-3x mb-3"></i>
                        <h3><fmt:formatNumber value="${requestScope.monthlyRevenue}" type="currency" currencySymbol="₫" groupingUsed="true"/></h3>
                        <p>Doanh thu tháng</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Cảnh báo -->
        <div class="row">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header">
                        <h5><i class="fas fa-exclamation-triangle"></i> Cảnh báo</h5>
                    </div>
                    <div class="card-body">
                        <div class="alert alert-warning" role="alert">
                            <strong>${requestScope.carsNeedingMaintenance} xe</strong> cần bảo trì trong tuần này
                        </div>
                        <div class="alert alert-info" role="alert">
                            <strong>${requestScope.expiringBookings} hợp đồng</strong> sắp hết hạn
                        </div>
                        <div class="alert alert-danger" role="alert">
                            <strong>${requestScope.overduePayments} thanh toán</strong> quá hạn
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Thống kê nhanh -->
            <div class="col-md-4">
                <div class="card">
                    <div class="card-header">
                        <h5><i class="fas fa-chart-pie"></i> Thống kê nhanh</h5>
                    </div>
                    <div class="card-body">
                        <div class="mb-3">
                            <div class="d-flex justify-content-between">
                                <span>Xe đang thuê</span>
                                <span class="badge bg-success">${requestScope.rentedCars}</span>
                            </div>
                            <div class="progress mt-1" style="height: 5px;">
                                <div class="progress-bar bg-success" style="width: ${requestScope.rentedCars * 100 / (requestScope.totalCars > 0 ? requestScope.totalCars : 1)}%"></div>
                            </div>
                        </div>
                        <div class="mb-3">
                            <div class="d-flex justify-content-between">
                                <span>Xe có sẵn</span>
                                <span class="badge bg-primary">${requestScope.availableCars}</span>
                            </div>
                            <div class="progress mt-1" style="height: 5px;">
                                <div class="progress-bar bg-primary" style="width: ${requestScope.availableCars * 100 / (requestScope.totalCars > 0 ? requestScope.totalCars : 1)}%"></div>
                            </div>
                        </div>
                        <div>
                            <div class="d-flex justify-content-between">
                                <span>Xe bảo trì</span>
                                <span class="badge bg-warning">${requestScope.maintenanceCars}</span>
                            </div>
                            <div class="progress mt-1" style="height: 5px;">
                                <div class="progress-bar bg-warning" style="width: ${requestScope.maintenanceCars * 100 / (requestScope.totalCars > 0 ? requestScope.totalCars : 1)}%"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>