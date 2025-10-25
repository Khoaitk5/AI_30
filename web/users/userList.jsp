<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý người dùng - TVT Future</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard-modern.css?v=1">
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
        <a href="${pageContext.request.contextPath}/users" class="text-warning"><i class="fas fa-users"></i> Người dùng</a>
        <a href="${pageContext.request.contextPath}/customers"><i class="fas fa-user-friends"></i> Khách hàng</a>
        <a href="${pageContext.request.contextPath}/cars"><i class="fas fa-car"></i> Xe</a>
        <a href="${pageContext.request.contextPath}/bookings"><i class="fas fa-calendar-check"></i> Đặt xe</a>
        <a href="${pageContext.request.contextPath}/payments"><i class="fas fa-credit-card"></i> Thanh toán</a>
        <a href="${pageContext.request.contextPath}/reports"><i class="fas fa-chart-bar"></i> Báo cáo</a>
        <a class="logout" href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt"></i> Đăng xuất</a>
    </nav>

    <!-- Main Content -->
    <main class="main-content">
        <!-- Header -->
        <div class="d-flex justify-content-between align-items-center mb-4 p-3 bg-light border rounded">
            <h3><i class="fas fa-users"></i> Quản lý người dùng</h3>
            <div>
                <span class="badge bg-primary fs-6">
                    <i class="fas fa-user"></i> 
                    Xin chào, ${sessionScope.currentUser.username}
                </span>
            </div>
        </div>

        <!-- User List -->
        <div class="card">
            <div class="card-header">
                <h5><i class="fas fa-users"></i> Danh sách người dùng</h5>
                <a href="${pageContext.request.contextPath}/users/add" class="btn btn-success btn-sm float-end">
                    <i class="fas fa-plus"></i> Thêm người dùng
                </a>
            </div>
            <div class="card-body">
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Tên người dùng</th>
                            <th>Vai trò</th>
                            <th>Mật khẩu</th>
                            <th>Trạng thái</th>
                            <th>Ngày Tạo</th>
                            <th>Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="user" items="${requestScope.users}">
                            <tr>
                                <td>${user.id}</td>
                                <td>${user.username != null ? user.username : 'N/A'}</td>
                                <td>${user.role}</td>
                                <td>${user.password != null ? user.password : 'N/A'}</td>
                                <td>${user.customerId != null ? user.customerId.status : 'N/A'}</td>
                                <td>${user.createdAt}</td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/users/edit?id=${user.id}" class="btn btn-primary btn-sm">
                                        <i class="fas fa-edit"></i> Sửa
                                    </a>
                                    <c:if test="${user.customerId != null && user.customerId.status != 'unvalid'}">
                                        <a href="${pageContext.request.contextPath}/users/delete?id=${user.id}" class="btn btn-danger btn-sm" onclick="return confirm(
                                        </a>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>'Bạn có chắc muốn vô hiệu hóa người dùng này?');">
                                            <i class="fas fa-trash"></i> Xóa
                </table>
            </div>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>