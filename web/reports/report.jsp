<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta»

 name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Báo cáo - TVT Future</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js@3.7.1/dist/chart.min.js"></script>
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
        .chart-container {
            max-width: 800px;
            margin: 0 auto;
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
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h1>Báo cáo</h1>
            <div>
                <span class="badge bg-primary fs-6">
                    <i class="fas fa-user"></i> 
                    Xin chào, ${sessionScope.currentUser.username}
                </span>
            </div>
        </div>

        <!-- Form chọn tháng -->
        <div class="card mb-4">
            <div class="card-body">
                <form action="reports" method="get">
                    <div class="row">
                        <div class="col-md-4">
                            <label for="monthYear" class="form-label">Chọn tháng:</label>
                            <input type="month" id="monthYear" name="monthYear" class="form-control" value="${monthYear}">
                        </div>
                        <div class="col-md-2 align-self-end">
                            <button type="submit" class="btn btn-primary">Xem báo cáo</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <!-- Tổng doanh thu -->
        <div class="card mb-4">
            <div class="card-header">
                <h5><i class="fas fa-money-bill-wave"></i> Tổng doanh thu tháng ${monthYear}</h5>
            </div>
            <div class="card-body">
                <h3>₫<c:out value="${totalRevenue}"/></h3>
            </div>
        </div>

        <!-- Top 3 xe được thuê nhiều nhất -->
        <div class="card mb-4">
            <div class="card-header">
                <h5><i class="fas fa-car"></i> Top 3 xe được thuê nhiều nhất</h5>
            </div>
            <div class="card-body">
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Mẫu xe</th>
                            <th>Biển số</th>
                            <th>Số lần thuê</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="car" items="${topCars}" varStatus="status">
                            <tr>
                                <td>${status.count}</td>
                                <td>${car.modelName}</td>
                                <td>${car.licensePlate}</td>
                                <td>${car.bookingCount}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Biểu đồ doanh thu -->
        <div class="card">
            <div class="card-header">
                <h5><i class="fas fa-chart-line"></i> Biểu đồ doanh thu tháng ${monthYear}</h5>
            </div>
            <div class="card-body">
                <div class="chart-container">
                    <canvas id="revenueChart"></canvas>
                </div>
            </div>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Vẽ biểu đồ doanh thu
        const ctx = document.getElementById('revenueChart').getContext('2d');
        new Chart(ctx, {
            type: 'line',
            data: {
                labels: [<c:forEach var="label" items="${labels}">'${label}',</c:forEach>],
                datasets: [{
                    label: 'Doanh thu (₫)',
                    data: [<c:forEach var="revenue" items="${dailyRevenue}">${revenue},</c:forEach>],
                    borderColor: 'rgba(75, 192, 192, 1)',
                    backgroundColor: 'rgba(75, 192, 192, 0.2)',
                    fill: true,
                    tension: 0.4
                }]
            },
            options: {
                responsive: true,
                scales: {
                    y: {
                        beginAtZero: true,
                        title: {
                            display: true,
                            text: 'Doanh thu (₫)'
                        }
                    },
                    x: {
                        title: {
                            display: true,
                            text: 'Ngày'
                        }
                    }
                }
            }
        });
    </script>
</body>
</html>