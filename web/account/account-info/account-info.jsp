<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thông tin tài khoản - TVT Future</title>
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Tektur:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Mulish:ital,wght@0,200..1000;1,200..1000&display=swap" rel="stylesheet">
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
            background: #fff;
            border-left: 4px solid #00d287;
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
    </style>
</head>
<body>
    <c:if test="${sessionScope.currentUser == null}">
        <c:redirect url="/login/login.jsp"/>
    </c:if>

    <!-- Header -->
    <div id="header-container"></div>

    <!-- Main Content -->
    <main class="main-content">
        <div class="flex-col gap-4 w-[300px] max-w-[20%] md:block hidden left-tabbar">
            <div class="left-tabbar-item px-4 py-3 text-base font-bold cursor-pointer left-tabbar-item-selected">
                <div class="left-tabbar-item-div-selected"></div>Tài khoản của tôi
            </div>
            <div class="left-tabbar-item px-4 py-3 text-base font-bold cursor-pointer"><a href="${pageContext.request.contextPath}/my-orders">Đơn hàng của tôi</a></div>
            <div class="left-tabbar-item px-4 py-3 text-base font-bold cursor-pointer"><a href="${pageContext.request.contextPath}/account/privacies-policy/privacies-policy.jsp">Điều khoản và pháp lý</a></div>
            <div class="left-tabbar-item px-4 py-3 text-base font-bold cursor-pointer"><a href="${pageContext.request.contextPath}/account/change-password/change-password.jsp">Đổi mật khẩu</a></div>
            <div style="height: 1px; background-color: rgb(221, 221, 221);"></div>
        </div>
        <div class="content-area">
            <div class="flex-1 bg-white py-8 px-8">
                <h1 class="text-2xl font-bold mb-4">Thông tin tài khoản</h1>
                <div id="message" class="hidden mt-4 p-4 rounded text-white"></div>
                <form id="accountForm" method="POST">
                    <div class="mt-10">
                        <div class="flex flex-1 flex-col sm:flex-col md:flex-row sm:justify-center md:justify-between items-center">
                            <div class="flex flex-col sm:flex-col lg:flex-row lg:flex items-center">
                                <div class="flex flex-col items-center">
                                    <input accept="image/*" class="hidden" id="file-input-avatar" type="file">
                                    <label for="file-input-avatar" class="cursor-pointer object-cover mr-4 w-30 h-30 flex justify-center items-center">
                                        <div class="relative w-full h-full">
                                            <img src="/asset/images/avatardefault_92824.png" alt="Image Preview" class="w-full h-full rounded-full object-cover">
                                            <button type="button" class="absolute bottom-4 right-0 mr-1 p-1 bg-white rounded-full shadow focus:outline-none">
                                                <svg class="w-6 h-6 text-gray-800 dark:text-white" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" viewBox="0 0 24 24">
                                                    <path stroke="currentColor" stroke-linejoin="round" stroke-width="1" d="M4 18V8a1 1 0 0 1 1-1h1.5l1.707-1.707A1 1 0 0 1 8.914 5h6.172a1 1 0 0 1 .707.293L17.5 7H19a1 1 0 0 1 1 1v10a1 1 0 0 1-1 1H5a1 1 0 0 1-1-1Z"></path>
                                                    <path stroke="currentColor" stroke-linejoin="round" stroke-width="1" d="M15 12a3 3 0 1 1-6 0 3 3 0 0 1 6 0Z"></path>
                                                </svg>
                                            </button>
                                        </div>
                                    </label>
                                </div>
                                <div class="text-center">
                                    <p class="mb-0 text-fullname text-center text-[24px]">
                                        <input name="fullName" class="text-center border-[1px] border-[#D1D5DB] py-2 px-4" 
                                               value="${sessionScope.currentCustomer.fullName != null ? sessionScope.currentCustomer.fullName : ''}" 
                                               placeholder="Nhập họ và tên">
                                    </p>
                                    <p class="mb-0 text-sm sm:text-start md:text-start text-text-specs italic">
                                        Tham gia: 
                                        <fmt:formatDate value="${sessionScope.currentUser.createdAt}" pattern="dd/MM/yyyy" />
                                    </p>
                                </div>
                            </div>
                            <div class="flex mt-5 md:mt-0 md:flex-row flex-col">
                                <button type="submit" class="flex px-3 py-2 border-brand-primary border-[1px] mr-3 cursor-pointer">
                                    <p class="mb-0 text-cyan-background">Lưu thông tin</p>
                                </button>
                                <div class="btn-delete flex mt-5 md:mt-0 px-3 py-2 border-brand-primary border-[1px] mr-3 cursor-pointer item-center">
                                    <p class="mb-0 text-red">Xoá tài khoản</p>
                                </div>
                                <div class="flex mt-5 md:mt-0 px-3 py-2 border-brand-primary border-[1px] mr-3 cursor-pointer sm:hidden block">
                                    <p class="mb-0 text-cyan-background">Đổi mật khẩu</p>
                                </div>
                            </div>
                        </div>
                        <div class="mt-8 flex gap-4 flex-col sm:flex-col md:flex-row w-full">
                            <div class="flex flex-1 flex-col w-full">
                                <p class="text-sm text-text-specs text-start font-medium mb-2">Ngày sinh</p>
                                <div class="flex items-center justify-between min-w-[140px] h-11 border-[1px] border-[#D1D5DB] px-3 py-2.5 text-base bg-white cursor-pointer">
                                    <input type="date" name="dateOfBirth" 
                                           value="${sessionScope.currentCustomer.dateOfBirth != null ? sessionScope.currentCustomer.dateOfBirth : ''}"
                                           class="w-full">
                                </div>
                            </div>
                        </div>
                        <div class="flex md:flex-row gap-4 mt-5 flex-col">
                            <div class="flex-1 relative">
                                <p class="text-sm text-text-specs text-start font-medium mb-2">Số điện thoại</p>
                                <div class="input-wrapper relative">
                                    <input name="phone" placeholder="Số điện thoại" class="py-3 px-1 border-[1px] bg-background w-full pl-4 border-[#D1D5DB]" 
                                           value="${sessionScope.currentCustomer.phone != null ? sessionScope.currentCustomer.phone : ''}">
                                    <c:if test="${sessionScope.currentCustomer.phone != null}">
                                        <img alt="tick" loading="lazy" width="20" height="20" decoding="async" data-nimg="1" class="absolute right-[11px] top-1/2 transform -translate-y-1/2" src="/asset/images/tick.svg" style="color: transparent;">
                                    </c:if>
                                </div>
                            </div>
                            <div class="flex-1 relative">
                                <p class="text-sm text-text-specs text-start font-medium mb-2">Email</p>
                                <div class="input-wrapper relative">
                                    <input name="email" placeholder="Email" class="py-3 px-1 border-[1px] bg-background w-full pl-4 border-[#D1D5DB]" 
                                           value="${sessionScope.currentCustomer.email != null ? sessionScope.currentCustomer.email : ''}">
                                    <c:if test="${sessionScope.currentCustomer.email != null}">
                                        <img alt="tick" loading="lazy" width="20" height="20" decoding="async" data-nimg="1" class="absolute right-[11px] top-1/2 transform -translate-y-1/2" src="/asset/images/tick.svg" style="color: transparent;">
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </main>

    <!-- Footer -->
    <div id="footer-container"></div>

    <!-- JavaScript -->
    <script src="${pageContext.request.contextPath}/home/home.js"></script>
    <script src="${pageContext.request.contextPath}/login/login.js"></script>
    <script src="${pageContext.request.contextPath}/password/password.js"></script>
    <script src="${pageContext.request.contextPath}/register/register.js"></script>
    <script>
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

        // Xử lý form cập nhật thông tin tài khoản
        document.getElementById('accountForm').addEventListener('submit', function(event) {
            event.preventDefault();
            const formData = new FormData(this);
            const messageDiv = document.getElementById('message');

            fetch('${pageContext.request.contextPath}/update-account', {
                method: 'POST',
                body: formData
            })
            .then(response => response.json())
            .then(data => {
                messageDiv.classList.remove('hidden');
                if (data.errorMessage) {
                    messageDiv.classList.remove('bg-green-500');
                    messageDiv.classList.add('bg-red-500');
                    messageDiv.textContent = data.errorMessage;
                } else {
                    messageDiv.classList.remove('bg-red-500');
                    messageDiv.classList.add('bg-green-500');
                    messageDiv.textContent = data.message;
                    // Cập nhật giao diện với dữ liệu mới
                    document.querySelector('input[name="fullName"]').value = data.customer.fullName || '';
                    document.querySelector('input[name="dateOfBirth"]').value = data.customer.dateOfBirth || '';
                    document.querySelector('input[name="phone"]').value = data.customer.phone || '';
                    document.querySelector('input[name="email"]').value = data.customer.email || '';
                    // Cập nhật biểu tượng tick
                    const phoneTick = document.querySelector('input[name="phone"] + img');
                    const emailTick = document.querySelector('input[name="email"] + img');
                    if (data.customer.phone) {
                        phoneTick.classList.remove('hidden');
                    } else {
                        phoneTick.classList.add('hidden');
                    }
                    if (data.customer.email) {
                        emailTick.classList.remove('hidden');
                    } else {
                        emailTick.classList.add('hidden');
                    }
                }
                // Ẩn thông báo sau 3 giây
                setTimeout(() => {
                    messageDiv.classList.add('hidden');
                }, 3000);
            })
            .catch(error => {
                messageDiv.classList.remove('hidden');
                messageDiv.classList.remove('bg-green-500');
                messageDiv.classList.add('bg-red-500');
                messageDiv.textContent = 'Lỗi hệ thống. Vui lòng thử lại!';
                setTimeout(() => {
                    messageDiv.classList.add('hidden');
                }, 3000);
            });
        });

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