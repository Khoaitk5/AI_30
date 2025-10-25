<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đơn hàng của tôi - TVT Future</title>
    <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css2?family=Tektur:wght@400;500;600;700&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Mulish:ital,wght@0,200..1000;1,200..1000&display=swap"
              rel="stylesheet">
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/my-orders.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/footer/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/login/login.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/password/password.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/register/register.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/header/header.css">
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/asset/images/logo_gf_black.svg">
    <style>
        .left-tabbar {
            width: 300px;
            max-width: 20%;
            padding: 1rem;
        }
        .left-tabbar-item {
            padding: 0.75rem 1rem;
            font-size: 1rem;
            font-weight: bold;
            cursor: pointer;
            color: #2b6cb0;
        }
        .left-tabbar-item a {
            text-decoration: none;
            color: inherit;
        }
        .left-tabbar-item:hover {
            color: #2c5282;
        }
        .left-tabbar-item-selected {
            background: #e2e8f0;
            color: #2b6cb0;
        }
        .left-tabbar-item-selected .left-tabbar-item-div-selected {
            border-left: 4px solid #2b6cb0;
            margin-left: -1rem;
            height: 100%;
        }
        .main-content {
            display: flex;
            gap: 2rem;
            padding-top: 88px; /* Đủ chỗ cho header cố định */
        }
        .content-area {
            flex: 1;
            padding: 1rem;
        }
        .orders-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 1rem;
        }
        .orders-table th, .orders-table td {
            padding: 0.75rem;
            text-align: left;
            border-bottom: 1px solid #e2e8f0;
        }
        .orders-table th {
            font-weight: 600;
            background: #f7fafc;
        }
        .orders-table td {
            font-size: 0.9rem;
        }
        .status-wait {
            background: #fefcbf;
            color: #b7791f;
            padding: 0.25rem 0.5rem;
            border-radius: 4px;
            display: inline-block;
        }
        .status-confirmed {
            background: #c6f6d5;
            color: #2f855a;
            padding: 0.25rem 0.5rem;
            border-radius: 4px;
            display: inline-block;
        }
        .status-cancelled {
            background: #fed7d7;
            color: #c53030;
            padding: 0.25rem 0.5rem;
            border-radius: 4px;
            display: inline-block;
        }
        .filter-section {
            display: flex;
            gap: 1rem;
            margin-bottom: 1.5rem;
            flex-wrap: wrap;
        }
        .filter-section input, .filter-section select {
            padding: 0.5rem;
            border: 1px solid #e2e8f0;
            border-radius: 4px;
            font-size: 0.9rem;
        }
        .filter-section button {
            background: #2b6cb0;
            color: #fff;
            padding: 0.5rem 1rem;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .filter-section button:hover {
            background: #2c5282;
        }
        .no-orders {
            text-align: center;
            font-size: 1rem;
            color: #718096;
            padding: 2rem;
        }
        .action-btn {
            background: #2b6cb0;
            color: #fff;
            padding: 0.5rem 1rem;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .action-btn:hover {
            background: #2c5282;
        }
        .action-btn:disabled {
            background: #a0aec0;
            cursor: not-allowed;
        }
        .cancel-btn {
            background: #c53030;
            color: #fff;
            padding: 0.5rem 1rem;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-left: 0.5rem;
        }
        .cancel-btn:hover {
            background: #9b2c2c;
        }
        /* Modal Styles */
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            z-index: 1000;
            justify-content: center;
            align-items: center;
        }
        .modal-content {
            background: #fff;
            padding: 2rem;
            border-radius: 8px;
            max-width: 400px;
            width: 90%;
            text-align: center;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
        .modal-content.success {
            border-top: 4px solid #2f855a;
        }
        .modal-content.error {
            border-top: 4px solid #c53030;
        }
        .modal-content h2 {
            font-size: 1.5rem;
            margin-bottom: 1rem;
        }
        .modal-content p {
            font-size: 1rem;
            margin-bottom: 1.5rem;
        }
        .modal-content button {
            background: #2b6cb0;
            color: #fff;
            padding: 0.5rem 1rem;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .modal-content button:hover {
            background: #2c5282;
        }
        .left-tabbar-item-selected {
    background-color: #fff;
    border-left: 4px solid #00d287;
}
    </style>
</head>
<body>
    <!-- Header -->
    <div id="header-container"></div>

    <!-- Main Content -->
    <main class="main-content">
        <div class="flex-col gap-4 w-[300px] max-w-[20%] md:block hidden left-tabbar">
            <div class="left-tabbar-item px-4 py-3 text-base font-bold cursor-pointer"><a href="${pageContext.request.contextPath}/account/account-info/account-info.jsp">Tài khoản của tôi</a></div>
            <div class="left-tabbar-item px-4 py-3 text-base font-bold cursor-pointer left-tabbar-item-selected">
                <div class="left-tabbar-item-div-selected"></div>Đơn hàng của tôi
            </div>
            <div class="left-tabbar-item px-4 py-3 text-base font-bold cursor-pointer"><a href="${pageContext.request.contextPath}/account/privacies-policy/privacies-policy.jsp">Điều khoản và pháp lý</a></div>
            <div class="left-tabbar-item px-4 py-3 text-base font-bold cursor-pointer"><a href="${pageContext.request.contextPath}/account/change-password/change-password.jsp">Đổi mật khẩu</a></div>
            <div style="height: 1px; background-color: rgb(221, 221, 221);"></div>
        </div>
        <div class="content-area">
            <div class="flex items-center mb-4">
                <h1 class="text-2xl font-bold ml-2">Đơn hàng của tôi</h1>
            </div>
            <c:choose>
                <c:when test="${empty bookings}">
                    <div class="no-orders">
                        Bạn chưa có đơn hàng nào.
                    </div>
                </c:when>
                <c:otherwise>
                    <div>
                        <h2 class="text-xl font-semibold mb-4">Lịch sử đơn hàng</h2>
                        <div class="filter-section">
                            <input type="text" placeholder="Tìm kiếm đơn hàng" class="w-64">
                            <select>
                                <option>Tất cả</option>
                                <option>Chờ xử lý</option>
                                <option>Đã xác nhận</option>
                                <option>Đã hủy</option>
                            </select>
                            <select>
                                <option>Tất cả</option>
                                <c:forEach var="booking" items="${bookings}">
                                    <c:if test="${booking.carId.vehicleModelId != null}">
                                        <option>${booking.carId.vehicleModelId.model}</option>
                                    </c:if>
                                </c:forEach>
                            </select>
                            <input type="text" placeholder="Chọn ngày nhận - ngày trả" class="w-64">
                            <button>Tìm kiếm</button>
                        </div>
                        <table class="orders-table">
                            <thead>
                                <tr>
                                    <th>Đơn hàng</th>
                                    <th>Dòng xe</th>
                                    <th>Thời gian nhận xe</th>
                                    <th>Thời gian trả xe</th>
                                    <th>Địa chỉ nhận xe</th>
                                    <th>Giá tiền</th>
                                    <th>Trạng thái</th>
                                    <th>Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="booking" items="${bookings}">
                                    <tr id="booking-row-${booking.id}">
                                        <td>${booking.id}</td>
                                        <td>${booking.carId.vehicleModelId != null ? booking.carId.vehicleModelId.model : 'Không xác định'}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${booking.startDate != null && booking.deliveryTime != null}">
                                                    <fmt:formatDate value="${booking.startDate}" pattern="HH:mm dd/MM/yyyy"/>
                                                </c:when>
                                                <c:otherwise>Không xác định</c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${booking.endDate != null && booking.returnTime != null}">
                                                    <fmt:formatDate value="${booking.endDate}" pattern="HH:mm dd/MM/yyyy"/>
                                                </c:when>
                                                <c:otherwise>Không xác định</c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>${booking.pickupLocation != null ? booking.pickupLocation : 'Không xác định'}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${booking.totalAmount != null && booking.deposit != null}">
                                                    <fmt:formatNumber value="${booking.totalAmount.add(booking.deposit)}" pattern="#,###"/>đ
                                                </c:when>
                                                <c:otherwise>Không xác định</c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <span id="status-${booking.id}" class="${booking.status == 'PENDING' ? 'status-wait' : 
                                                          booking.status == 'CONFIRMED' ? 'status-confirmed' : 
                                                          booking.status == 'COMPLETED' ? 'status-confirmed' : 'status-cancelled'}">
                                                ${booking.status == 'PENDING' ? 'Chờ xử lý' : 
                                                  booking.status == 'CONFIRMED' ? 'Đã xác nhận' : 
                                                  booking.status == 'COMPLETED' ? 'Hoàn tất' : 'Đã hủy'}
                                            </span>
                                        </td>
                                        <td id="actions-${booking.id}">
                                            <c:if test="${booking.status == 'PENDING'}">
                                                <c:choose>
                                                    <c:when test="${booking.customerId != null && booking.carId.vehicleModelId != null && booking.carId != null && booking.pickupLocation != null && booking.startDate != null && booking.deliveryTime != null && (booking.billingCycle == 'MONTHLY' || (booking.billingCycle == 'DAILY' && booking.endDate != null && booking.returnTime != null))}">
                                                        <button type="button" class="action-btn" onclick="processPayment('${booking.id}', '${booking.totalAmount != null && booking.deposit != null ? booking.totalAmount.add(booking.deposit) : ''}', '${booking.carId.vehicleModelId != null ? booking.carId.vehicleModelId.id : ''}', '${booking.carId != null ? booking.carId.id : ''}', '${booking.billingCycle == 'DAILY' ? 'ngay' : 'thang'}', '<fmt:formatDate value="${booking.startDate}" pattern="yyyy-MM-dd"/>', '<fmt:formatDate value="${booking.deliveryTime}" pattern="HH:mm"/>', '<fmt:formatDate value="${booking.endDate}" pattern="yyyy-MM-dd"/>', '<fmt:formatDate value="${booking.returnTime}" pattern="HH:mm"/>', '${booking.totalDays != null ? booking.totalDays : ''}', '${booking.customerId != null ? booking.customerId.fullName : ''}', '${booking.customerId != null ? booking.customerId.phone : ''}', '${booking.customerId != null ? booking.customerId.email : ''}', '${booking.pickupLocation != null ? booking.pickupLocation : ''}')">Thanh toán</button>
                                                        <button type="button" class="cancel-btn" onclick="cancelBooking('${booking.id}')">Hủy</button>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <button type="button" class="action-btn" disabled>Thanh toán (Thiếu thông tin)</button>
                                                        <button type="button" class="cancel-btn" onclick="cancelBooking('${booking.id}')">Hủy</button>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:if>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                        <div class="mt-4">
                            <span>Tổng cộng: ${bookings.size()} đơn hàng</span>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </main>

    <!-- Payment Result Modal -->
    <div id="payment-result-modal" class="modal">
        <div id="payment-result-content" class="modal-content">
            <h2 id="payment-result-title"></h2>
            <p id="payment-result-message"></p>
            <button onclick="closePaymentModal()">Đóng</button>
        </div>
    </div>

    <!-- Footer -->
    <div id="footer-container"></div>

    <!-- JavaScript -->
    <script src="${pageContext.request.contextPath}/home/home.js"></script>
    <script src="${pageContext.request.contextPath}/login/login.js"></script>
    <script src="${pageContext.request.contextPath}/password/password.js"></script>
    <script src="${pageContext.request.contextPath}/register/register.js"></script>
    <script>
        // Hàm xử lý thanh toán qua AJAX
        function processPayment(bookingId, amount, modelId, carId, rentalType, pickupDate, pickupTime, returnDate, returnTime, rentalMonths, name, phone, email, pickupLocation) {
            console.log('Processing payment:', { bookingId, amount, modelId, carId, rentalType, pickupDate, pickupTime, returnDate, returnTime, rentalMonths, name, phone, email, pickupLocation });

            // Kiểm tra ngày nhận xe so với ngày hiện tại
            const currentDate = new Date('2025-07-21');
            const pickupDateObj = new Date(pickupDate);
            if (pickupDateObj <= currentDate) {
                showCancelModal('expired', bookingId, 'Đơn hàng đã quá hạn và sẽ được tự động hủy.');
                cancelBooking(bookingId);
                return;
            }

            // Kiểm tra các trường bắt buộc
            if (!bookingId || !amount || !modelId || !carId || !rentalType || !name || !phone || !email || !pickupLocation || !pickupDate || !pickupTime) {
                alert('Thiếu thông tin bắt buộc để thực hiện thanh toán.');
                return;
            }
            if (rentalType === 'ngay' && (!returnDate || !returnTime)) {
                alert('Thiếu ngày/giờ trả xe cho hình thức thuê theo ngày.');
                return;
            }
            if (rentalType === 'thang' && !rentalMonths) {
                alert('Thiếu số tháng thuê cho hình thức thuê theo tháng.');
                return;
            }

            // Validate date and time formats
            const datePattern = /^\d{4}-\d{2}-\d{2}$/;
            const timePattern = /^\d{2}:\d{2}$/;
            if (!datePattern.test(pickupDate)) {
                alert('Ngày nhận xe không hợp lệ, yêu cầu định dạng yyyy-MM-dd');
                return;
            }
            if (!timePattern.test(pickupTime)) {
                alert('Giờ nhận xe không hợp lệ, yêu cầu định dạng HH:mm');
                return;
            }
            if (rentalType === 'ngay' && (!datePattern.test(returnDate) || !timePattern.test(returnTime))) {
                alert('Ngày/giờ trả xe không hợp lệ, yêu cầu định dạng yyyy-MM-dd và HH:mm');
                return;
            }
            if (!amount || isNaN(parseFloat(amount)) || parseFloat(amount) <= 0) {
                alert('Số tiền không hợp lệ hoặc thiếu');
                return;
            }

            fetch('${pageContext.request.contextPath}/payment/update', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    bookingId: bookingId,
                    amount: amount,
                    modelId: modelId,
                    carId: carId,
                    rentalType: rentalType,
                    pickupDate: pickupDate,
                    pickupTime: pickupTime,
                    returnDate: returnDate,
                    returnTime: returnTime,
                    rentalMonths: rentalMonths,
                    name: name,
                    phone: phone,
                    email: email,
                    pickupLocation: pickupLocation
                })
            })
            .then(response => {
                console.log('Payment response:', response);
                if (!response.ok) {
                    return response.json().then(err => { throw new Error(err.message || 'Lỗi khi xử lý thanh toán'); });
                }
                return response.json();
            })
            .then(data => {
                console.log('Payment data:', data);
                if (data && data.message) {
                    window.location.href = data.message;
                } else {
                    throw new Error('Không nhận được URL thanh toán từ server.');
                }
            })
            .catch(error => {
                console.error('Lỗi thanh toán:', error);
                alert('Thanh toán thất bại: ' + error.message);
            });
        }

        // Hàm xử lý hủy đơn hàng qua AJAX
        function cancelBooking(bookingId) {
            fetch('${pageContext.request.contextPath}/my-orders/cancel?id=' + bookingId, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                }
            })
            .then(response => {
                if (!response.ok) {
                    return response.json().then(err => { throw new Error(err.message || 'Lỗi khi hủy đơn hàng'); });
                }
                return response.json();
            })
            .then(data => {
                if (data.success) {
                    // Cập nhật giao diện mà không reload trang
                    const statusCell = document.getElementById('status-' + bookingId);
                    const actionsCell = document.getElementById('actions-' + bookingId);
                    if (statusCell && actionsCell) {
                        statusCell.className = 'status-cancelled';
                        statusCell.textContent = 'Đã hủy';
                        actionsCell.innerHTML = ''; // Xóa các nút thao tác
                    }
                    showCancelModal('success', bookingId);
                } else {
                    throw new Error(data.message || 'Hủy đơn hàng thất bại');
                }
            })
            .catch(error => {
                console.error('Lỗi hủy đơn hàng:', error);
                showCancelModal('failed', bookingId, error.message);
            });
        }

        // Hàm hiển thị modal hủy đơn hàng
        function showCancelModal(status, bookingId, errorMessage) {
            const modal = document.getElementById('payment-result-modal');
            const modalContent = document.getElementById('payment-result-content');
            const title = document.getElementById('payment-result-title');
            const message = document.getElementById('payment-result-message');

            if (status === 'success') {
                modalContent.classList.remove('error');
                modalContent.classList.add('success');
                title.textContent = 'Hủy đơn hàng thành công';
                message.textContent = `Đơn hàng ${bookingId} đã được hủy thành công.`;
            } else if (status === 'expired') {
                modalContent.classList.remove('success');
                modalContent.classList.add('error');
                title.textContent = 'Đơn hàng quá hạn';
                message.textContent = errorMessage || `Đơn hàng ${bookingId} đã quá hạn và đã được tự động hủy.`;
            } else {
                modalContent.classList.remove('success');
                modalContent.classList.add('error');
                title.textContent = 'Hủy đơn hàng thất bại';
                message.textContent = errorMessage || `Hủy đơn hàng ${bookingId} không thành công. Vui lòng thử lại hoặc liên hệ hỗ trợ.`;
            }

            modal.style.display = 'flex';
        }

        // Hàm hiển thị modal thanh toán
        function showPaymentModal(status, bookingId) {
            console.log('Showing payment modal:', { status, bookingId });
            const modal = document.getElementById('payment-result-modal');
            const modalContent = document.getElementById('payment-result-content');
            const title = document.getElementById('payment-result-title');
            const message = document.getElementById('payment-result-message');

            if (status === 'success') {
                modalContent.classList.remove('error');
                modalContent.classList.add('success');
                title.textContent = 'Thanh toán thành công';
                message.textContent = `Đơn hàng ${bookingId} đã được thanh toán thành công. Cảm ơn bạn đã sử dụng dịch vụ!`;
            } else if (status === 'failed') {
                modalContent.classList.remove('success');
                modalContent.classList.add('error');
                title.textContent = 'Thanh toán thất bại';
                message.textContent = `Thanh toán cho đơn hàng ${bookingId} không thành công. Vui lòng thử lại hoặc liên hệ hỗ trợ.`;
            } else {
                console.log('Unknown status:', status);
                return;
            }

            modal.style.display = 'flex';
        }

        // Hàm đóng modal
        function closePaymentModal() {
            console.log('Closing payment modal');
            const modal = document.getElementById('payment-result-modal');
            modal.style.display = 'none';
            // Xóa tham số status và bookingId khỏi URL
            const url = new URL(window.location.href);
            url.searchParams.delete('status');
            url.searchParams.delete('bookingId');
            window.history.replaceState({}, document.title, url.toString());
        }

        // Kiểm tra tham số status trong URL khi trang tải
        document.addEventListener('DOMContentLoaded', function () {
            const urlParams = new URLSearchParams(window.location.search);
            const status = urlParams.get('status');
            const bookingId = urlParams.get('bookingId');
            console.log('URL params:', { status, bookingId });
            if (status && bookingId) {
                showPaymentModal(status, bookingId);
            }

            // Debug lỗi tải header.css
            const headerCss = document.querySelector('link[href$="/header/header.css"]');
            if (!headerCss) {
                console.error('header.css not loaded');
            } else {
                console.log('header.css loaded successfully');
            }
        });

        // Tải footer
        fetch('${pageContext.request.contextPath}/footer/footer.jsp')
            .then(response => {
                if (!response.ok) throw new Error('Failed to load footer.jsp');
                return response.text();
            })
            .then(data => {
                document.getElementById('footer-container').innerHTML = data;
            })
            .catch(error => console.error('Error loading footer:', error));

        // Tải header
        fetch('${pageContext.request.contextPath}/header/header.jsp')
            .then(response => {
                if (!response.ok) throw new Error('Failed to load header.jsp');
                return response.text();
            })
            .then(data => {
                document.getElementById('header-container').innerHTML = data;
                const loginBtn = document.querySelector('.btn-login');
                const userDropdown = document.getElementById('header-user-dropdown');
                if (loginBtn && !userDropdown) {
                    loginBtn.addEventListener('click', function (e) {
                        e.preventDefault();
                        openLogin();
                    });
                }
                var script = document.createElement('script');
                script.src = '${pageContext.request.contextPath}/header/header.js';
                script.onload = function () {
                    if (typeof initHeaderDropdown === 'function') {
                        initHeaderDropdown();
                    }
                    if (typeof showLogoutToastIfNeeded === 'function') {
                        showLogoutToastIfNeeded();
                        setTimeout(showLogoutToastIfNeeded, 300);
                        setTimeout(showLogoutToastIfNeeded, 700);
                        setTimeout(showLogoutToastIfNeeded, 1200);
                        setTimeout(showLogoutToastIfNeeded, 2000);
                    }
                };
                script.onerror = function () {
                    console.error('Failed to load header.js');
                };
                document.body.appendChild(script);
            })
            .catch(error => console.error('Error loading header:', error));

        // Tự động bật modal register nếu có lỗi đăng ký
        <% if (request.getAttribute("showRegisterModal") != null && Boolean.parseBoolean(request.getAttribute("showRegisterModal").toString())) { %>
        document.addEventListener('DOMContentLoaded', function () {
            openRegister();
        });
        <% } %>

        // Tự động bật modal login nếu có lỗi đăng nhập
        <% if (request.getAttribute("showLoginModal") != null && Boolean.parseBoolean(request.getAttribute("showLoginModal").toString())) { %>
        document.addEventListener('DOMContentLoaded', function () {
            openLogin();
        });
        <% } %>
    </script>

    <!-- Login Modal -->
    <jsp:include page="/login/login.jsp" />

    <!-- Password Reset Modal -->
    <div id="password-container"></div>
    <script>
        fetch('${pageContext.request.contextPath}/password/password.jsp')
            .then(response => {
                if (!response.ok) throw new Error('Failed to load password.jsp');
                return response.text();
            })
            .then(data => {
                document.getElementById('password-container').innerHTML = data;
                if (typeof initPasswordFunctionality === 'function') {
                    initPasswordFunctionality();
                }
            })
            .catch(error => console.error('Error loading password modal:', error));
    </script>

    <!-- Register Modal -->
    <div id="register-container"></div>
    <script>
        fetch('${pageContext.request.contextPath}/register/register.jsp')
            .then(response => {
                if (!response.ok) throw new Error('Failed to load register.jsp');
                return response.text();
            })
            .then(data => {
                document.getElementById('register-container').innerHTML = data;
                if (typeof initRegisterFunctionality === 'function') {
                    initRegisterFunctionality();
                }
            })
            .catch(error => console.error('Error loading register modal:', error));
    </script>
</body>
</html>