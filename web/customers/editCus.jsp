<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chỉnh sửa khách hàng - TVT Future</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
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
            font-size: 0.9em;
            display: none;
        }
        .is-invalid {
            border-color: red;
        }
    </style>
</head>
<body>
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

    <main class="main-content">
        <h1>Chỉnh sửa khách hàng</h1>
        <c:if test="${not empty errors}">
            <div class="alert alert-danger">
                Vui lòng sửa các lỗi sau:
                <ul>
                    <c:forEach var="error" items="${errors}">
                        <li>${error}</li>
                    </c:forEach>
                </ul>
            </div>
        </c:if>
        <div class="card">
            <div class="card-body">
                <form action="${pageContext.request.contextPath}/customers/edit" method="post" id="customerForm">
                    <input type="hidden" name="id" value="${customer.id}">
                    <div class="mb-3">
                        <label for="fullName" class="form-label">Họ tên</label>
                        <input type="text" class="form-control ${errors != null && errors.contains('Tên khách hàng không hợp lệ') ? 'is-invalid' : ''}" 
                               id="fullName" name="fullName" value="${param.fullName != null ? param.fullName : customer.fullName}" required>
                        <span id="fullNameError" class="error-message">Tên chỉ được chứa chữ cái, ký tự tiếng Việt có dấu và dấu cách.</span>
                    </div>
                    <div class="mb-3">
                        <label for="email" class="form-label">Email</label>
                        <input type="email" class="form-control ${errors != null && errors.contains('Email không đúng định dạng') ? 'is-invalid' : ''}" 
                               id="email" name="email" value="${param.email != null ? param.email : customer.email}" required>
                        <span id="emailError" class="error-message">Email không đúng định dạng.</span>
                    </div>
                    <div class="mb-3">
                        <label for="phone" class="form-label">Số điện thoại</label>
                        <input type="text" class="form-control ${errors != null && errors.contains('Số điện thoại phải có 10 hoặc 11 số') ? 'is-invalid' : ''}" 
                               id="phone" name="phone" value="${param.phone != null ? param.phone : customer.phone}">
                        <span id="phoneError" class="error-message">Số điện thoại phải có 10 hoặc 11 số.</span>
                    </div>
                    <div class="mb-3">
                        <label for="address" class="form-label">Địa chỉ</label>
                        <input type="text" class="form-control" id="address" name="address" value="${param.address != null ? param.address : customer.address}">
                    </div>
                    <div class="mb-3">
                        <label for="licenseNumber" class="form-label">Số bằng lái</label>
                        <input type="text" class="form-control" id="licenseNumber" name="licenseNumber" value="${param.licenseNumber != null ? param.licenseNumber : customer.licenseNumber}">
                    </div>
                    <div class="mb-3">
                        <label for="licenseExpiry" class="form-label">Ngày hết hạn bằng lái</label>
                        <input type="date" class="form-control" id="licenseExpiry" name="licenseExpiry" value="${param.licenseExpiry != null ? param.licenseExpiry : customer.licenseExpiry}">
                    </div>
                    <div class="mb-3">
                        <label for="idCardNumber" class="form-label">Số CMND/CCCD</label>
                        <input type="text" class="form-control ${errors != null && errors.contains('Số CMND/CCCD phải có 9 hoặc 12 số') ? 'is-invalid' : ''}" 
                               id="idCardNumber" name="idCardNumber" value="${param.idCardNumber != null ? param.idCardNumber : customer.idCardNumber}">
                        <span id="idCardNumberError" class="error-message">Số CMND/CCCD phải có 9 hoặc 12 số.</span>
                    </div>
                    <div class="mb-3">
                        <label for="dateOfBirth" class="form-label">Ngày sinh</label>
                        <input type="date" class="form-control" id="dateOfBirth" name="dateOfBirth" value="${param.dateOfBirth != null ? param.dateOfBirth : customer.dateOfBirth}">
                    </div>
                    <div class="mb-3">
                        <label for="membershipLevel" class="form-label">Cấp thành viên</label>
                        <select class="form-select" id="membershipLevel" name="membershipLevel">
                            <option value="Bronze" ${param.membershipLevel == 'Bronze' || (param.membershipLevel == null && customer.membershipLevel == 'Bronze') ? 'selected' : ''}>Bronze</option>
                            <option value="Silver" ${param.membershipLevel == 'Silver' || (param.membershipLevel == null && customer.membershipLevel == 'Silver') ? 'selected' : ''}>Silver</option>
                            <option value="Gold" ${param.membershipLevel == 'Gold' || (param.membershipLevel == null && customer.membershipLevel == 'Gold') ? 'selected' : ''}>Gold</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="status" class="form-label">Trạng thái</label>
                        <select class="form-select" id="status" name="status">
                            <option value="valid" ${param.status == 'valid' || (param.status == null && customer.status == 'valid') ? 'selected' : ''}>Valid</option>
                            <option value="unvalid" ${param.status == 'unvalid' || (param.status == null && customer.status == 'unvalid') ? 'selected' : ''}>UnValid</option>
                        </select>
                    </div>
                    <button type="submit" class="btn btn-primary">Lưu</button>
                    <a href="${pageContext.request.contextPath}/customers" class="btn btn-secondary">Hủy</a>
                </form>
            </div>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.getElementById('customerForm').addEventListener('submit', function(event) {
            let isValid = true;
            const nameRegex = /^[a-zA-ZÀ-ỹ\s]+$/;
            const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
            const phoneRegex = /^\d{10,11}$/;
            const idCardNumberRegex = /^\d{9}$|^\d{12}$/;

            // Validate fullName
            const fullName = document.getElementById('fullName');
            const fullNameError = document.getElementById('fullNameError');
            if (!nameRegex.test(fullName.value)) {
                fullNameError.style.display = 'block';
                fullName.classList.add('is-invalid');
                isValid = false;
            } else {
                fullNameError.style.display = 'none';
                fullName.classList.remove('is-invalid');
            }

            // Validate email
            const email = document.getElementById('email');
            const emailError = document.getElementById('emailError');
            if (!emailRegex.test(email.value)) {
                emailError.style.display = 'block';
                email.classList.add('is-invalid');
                isValid = false;
            } else {
                emailError.style.display = 'none';
                email.classList.remove('is-invalid');
            }

            // Validate phone
            const phone = document.getElementById('phone');
            const phoneError = document.getElementById('phoneError');
            if (phone.value && !phoneRegex.test(phone.value)) {
                phoneError.style.display = 'block';
                phone.classList.add('is-invalid');
                isValid = false;
            } else {
                phoneError.style.display = 'none';
                phone.classList.remove('is-invalid');
            }

            // Validate idCardNumber
            const idCardNumber = document.getElementById('idCardNumber');
            const idCardNumberError = document.getElementById('idCardNumberError');
            if (idCardNumber.value && !idCardNumberRegex.test(idCardNumber.value)) {
                idCardNumberError.style.display = 'block';
                idCardNumber.classList.add('is-invalid');
                isValid = false;
            } else {
                idCardNumberError.style.display = 'none';
                idCardNumber.classList.remove('is-invalid');
            }

            // Scroll to first invalid field
            if (!isValid) {
                event.preventDefault();
                const firstInvalid = document.querySelector('.is-invalid');
                if (firstInvalid) {
                    firstInvalid.scrollIntoView({ behavior: 'smooth', block: 'center' });
                    firstInvalid.focus();
                }
            }
        });
    </script>
</body>
</html>