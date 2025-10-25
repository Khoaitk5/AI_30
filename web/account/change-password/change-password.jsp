<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thay đổi mật khẩu - TVT Future</title>
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Tektur:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Mulish:ital,wght@0,200..1000;1,200..1000&display=swap" rel="stylesheet">
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/my-orders.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/footer/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/login/login.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/password/change-password.css">
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
        .error-message, .success-message {
            display: none;
            padding: 1rem;
            margin-bottom: 1rem;
            border-radius: 4px;
        }
        .error-message {
            background-color: #fee2e2;
            color: #dc2626;
        }
        .success-message {
            background-color: #d1fae5;
            color: #065f46;
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
    <div class="main-content">
        <div class="flex-col gap-4 w-[300px] max-w-[20%] md:block hidden left-tabbar">
            <div class="left-tabbar-item px-4 py-3 text-base font-bold cursor-pointer"><a href="${pageContext.request.contextPath}/account-info">Tài khoản của tôi</a></div>
            <div class="left-tabbar-item px-4 py-3 text-base font-bold cursor-pointer"><a href="${pageContext.request.contextPath}/my-orders">Đơn hàng của tôi</a></div>
            <div class="left-tabbar-item px-4 py-3 text-base font-bold cursor-pointer"><a href="${pageContext.request.contextPath}/privacies-policy">Điều khoản và pháp lý</a></div>
            <div class="left-tabbar-item px-4 py-3 text-base font-bold cursor-pointer left-tabbar-item-selected">
                <div class="left-tabbar-item-div-selected"></div>Đổi mật khẩu
            </div>
            <div style="height: 1px; background-color: rgb(221, 221, 221);"></div>
        </div>
        <main class="content-area">
            <div class="block sm:hidden m-[16px]"></div>
            <div class="flex-1 bg-white py-8 px-8 rounded-lg">
                <p class="text-title text-[24px] font-bold">Thay đổi mật khẩu</p>
                <div id="error-message" class="error-message"></div>
                <div id="success-message" class="success-message"></div>
                <form id="change-password-form" action="${pageContext.request.contextPath}/change-password" method="POST" class="space-y-2 flex-shrink-0 w-full" novalidate="">
                    <div class="space-y-2">
                        <label class="text-sm font-medium leading-none peer-disabled:cursor-not-allowed peer-disabled:opacity-70" for="oldPassword">Mật khẩu hiện tại</label>
                        <div class="relative">
                            <input class="flex h-9 w-full rounded-md border border-input bg-transparent px-3 py-1 text-sm shadow-sm transition-colors file:border-0 file:bg-transparent file:text-sm file:font-medium placeholder:text-muted-foreground focus-visible:outline-none focus-visible:ring-1 focus-visible:ring-ring disabled:cursor-not-allowed disabled:opacity-50"
                                id="oldPassword" placeholder="Nhập mật khẩu hiện tại" aria-describedby=":rs:-form-item-description" aria-invalid="false" type="password" name="oldPassword">
                            <button type="button" class="absolute inset-y-0 right-0 flex items-center px-3 text-gray-400 toggle-password">
                                <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="eye-slash" class="svg-inline--fa fa-eye-slash text-zinc-400" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 512">
                                    <path fill="currentColor" d="M38.8 5.1C28.4-3.1 13.3-1.2 5.1 9.2S-1.2 34.7 9.2 42.9l592 464c10.4 8.2 25.5 6.3 33.7-4.1s6.3-25.5-4.1-33.7L525.6 386.7c39.6-40.6 66.4-86.1 79.9-118.4c3.3-7.9 3.3-16.7 0-24.6c-14.9-35.7-46.2-87.7-93-131.1C465.5 68.8 400.8 32 320 32c-68.2 0-125 26.3-169.3 60.8L38.8 5.1zM223.1 149.5C248.6 126.2 282.7 112 320 112c79.5 0 144 64.5 144 144c0 24.9-6.3 48.3-17.4 68.7L408 294.5c8.4-19.3 10.6-41.4 4.8-63.3c-11.1-41.5-47.8-69.4-88.6-71.1c-5.8-.2-9.2 6.1-7.4 11.7c2.1 6.4 3.3 13.2 3.3 20.3c0 10.2-2.4 19.8-6.6 28.3l-90.3-70.8zM373 389.9c-16.4 6.5-34.3 10.1-53 10.1c-79.5 0-144-64.5-144-144c0-6.9 .5-13.6 1.4-20.2L83.1 161.5C60.3 191.2 44 220.8 34.5 243.7c-3.3 7.9-3.3 16.7 0 24.6c14.9 35.7 46.2 87.7 93 131.1C174.5 443.2 239.2 480 320 480c47.8 0 89.9-12.9 126.2-32.5L373 389.9z"></path>
                                </svg>
                            </button>
                        </div>
                    </div>
                    <div class="space-y-2">
                        <label class="text-sm font-medium leading-none peer-disabled:cursor-not-allowed peer-disabled:opacity-70" for="newPassword">Mật khẩu mới</label>
                        <div class="relative">
                            <input class="flex h-9 w-full rounded-md border border-input bg-transparent px-3 py-1 text-sm shadow-sm transition-colors file:border-0 file:bg-transparent file:text-sm file:font-medium placeholder:text-muted-foreground focus-visible:outline-none focus-visible:ring-1 focus-visible:ring-ring disabled:cursor-not-allowed disabled:opacity-50"
                                id="newPassword" placeholder="Nhập mật khẩu mới" aria-describedby=":rt:-form-item-description" aria-invalid="false" type="password" name="newPassword">
                            <button type="button" class="absolute inset-y-0 right-0 flex items-center px-3 text-gray-400 toggle-password">
                                <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="eye-slash" class="svg-inline--fa fa-eye-slash text-zinc-400" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 512">
                                    <path fill="currentColor" d="M38.8 5.1C28.4-3.1 13.3-1.2 5.1 9.2S-1.2 34.7 9.2 42.9l592 464c10.4 8.2 25.5 6.3 33.7-4.1s6.3-25.5-4.1-33.7L525.6 386.7c39.6-40.6 66.4-86.1 79.9-118.4c3.3-7.9 3.3-16.7 0-24.6c-14.9-35.7-46.2-87.7-93-131.1C465.5 68.8 400.8 32 320 32c-68.2 0-125 26.3-169.3 60.8L38.8 5.1zM223.1 149.5C248.6 126.2 282.7 112 320 112c79.5 0 144 64.5 144 144c0 24.9-6.3 48.3-17.4 68.7L408 294.5c8.4-19.3 10.6-41.4 4.8-63.3c-11.1-41.5-47.8-69.4-88.6-71.1c-5.8-.2-9.2 6.1-7.4 11.7c2.1 6.4 3.3 13.2 3.3 20.3c0 10.2-2.4 19.8-6.6 28.3l-90.3-70.8zM373 389.9c-16.4 6.5-34.3 10.1-53 10.1c-79.5 0-144-64.5-144-144c0-6.9 .5-13.6 1.4-20.2L83.1 161.5C60.3 191.2 44 220.8 34.5 243.7c-3.3 7.9-3.3 16.7 0 24.6c14.9 35.7 46.2 87.7 93 131.1C174.5 443.2 239.2 480 320 480c47.8 0 89.9-12.9 126.2-32.5L373 389.9z"></path>
                                </svg>
                            </button>
                        </div>
                    </div>
                    <div class="space-y-2">
                        <label class="text-sm font-medium leading-none peer-disabled:cursor-not-allowed peer-disabled:opacity-70" for="confirmPassword">Nhập lại mật khẩu</label>
                        <div class="relative">
                            <input class="flex h-9 w-full rounded-md border border-input bg-transparent px-3 py-1 text-sm shadow-sm transition-colors file:border-0 file:bg-transparent file:text-sm file:font-medium placeholder:text-muted-foreground focus-visible:outline-none focus-visible:ring-1 focus-visible:ring-ring disabled:cursor-not-allowed disabled:opacity-50"
                                id="confirmPassword" placeholder="Nhập lại mật khẩu mới" aria-describedby=":ru:-form-item-description" aria-invalid="false" type="password" name="confirmPassword">
                            <button type="button" class="absolute inset-y-0 right-0 flex items-center px-3 text-gray-400 toggle-password">
                                <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="eye-slash" class="svg-inline--fa fa-eye-slash text-zinc-400" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 512">
                                    <path fill="currentColor" d="M38.8 5.1C28.4-3.1 13.3-1.2 5.1 9.2S-1.2 34.7 9.2 42.9l592 464c10.4 8.2 25.5 6.3 33.7-4.1s6.3-25.5-4.1-33.7L525.6 386.7c39.6-40.6 66.4-86.1 79.9-118.4c3.3-7.9 3.3-16.7 0-24.6c-14.9-35.7-46.2-87.7-93-131.1C465.5 68.8 400.8 32 320 32c-68.2 0-125 26.3-169.3 60.8L38.8 5.1zM223.1 149.5C248.6 126.2 282.7 112 320 112c79.5 0 144 64.5 144 144c0 24.9-6.3 48.3-17.4 68.7L408 294.5c8.4-19.3 10.6-41.4 4.8-63.3c-11.1-41.5-47.8-69.4-88.6-71.1c-5.8-.2-9.2 6.1-7.4 11.7c2.1 6.4 3.3 13.2 3.3 20.3c0 10.2-2.4 19.8-6.6 28.3l-90.3-70.8zM373 389.9c-16.4 6.5-34.3 10.1-53 10.1c-79.5 0-144-64.5-144-144c0-6.9 .5-13.6 1.4-20.2L83.1 161.5C60.3 191.2 44 220.8 34.5 243.7c-3.3 7.9-3.3 16.7 0 24.6c14.9 35.7 46.2 87.7 93 131.1C174.5 443.2 239.2 480 320 480c47.8 0 89.9-12.9 126.2-32.5L373 389.9z"></path>
                                </svg>
                            </button>
                        </div>
                    </div>
                    <div class="flex justify-end">
                        <button class="btn-submit inline-flex items-center justify-center whitespace-nowrap rounded-md text-sm font-medium transition-colors focus-visible:outline-none focus-visible:ring-1 focus-visible:ring-ring disabled:pointer-events-none disabled:opacity-50 bg-cyan-background text-white shadow hover:bg-cyan-background/90 h-[40px] px-4 py-2 !mt-3"
                            type="submit">Xác nhận</button>
                    </div>
                </form>
            </div>
        </main>
    </div>

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

        // Xử lý form submit
        document.getElementById('change-password-form').addEventListener('submit', function (e) {
            e.preventDefault();
            const oldPassword = document.getElementById('oldPassword').value;
            const newPassword = document.getElementById('newPassword').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            const errorMessageDiv = document.getElementById('error-message');
            const successMessageDiv = document.getElementById('success-message');

            // Reset messages
            errorMessageDiv.style.display = 'none';
            successMessageDiv.style.display = 'none';
            errorMessageDiv.textContent = '';
            successMessageDiv.textContent = '';

            // Client-side validation
            if (!oldPassword || !newPassword || !confirmPassword) {
                errorMessageDiv.textContent = 'Vui lòng nhập đầy đủ các trường!';
                errorMessageDiv.style.display = 'block';
                return;
            }
            if (newPassword !== confirmPassword) {
                errorMessageDiv.textContent = 'Mật khẩu mới và xác nhận mật khẩu không khớp!';
                errorMessageDiv.style.display = 'block';
                return;
            }

            // Gửi yêu cầu AJAX
            fetch('${pageContext.request.contextPath}/change-password', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: new URLSearchParams({
                    'oldPassword': oldPassword,
                    'newPassword': newPassword,
                    'confirmPassword': confirmPassword
                })
            })
            .then(response => response.json())
            .then(data => {
                if (data.errorMessage) {
                    errorMessageDiv.textContent = data.errorMessage;
                    errorMessageDiv.style.display = 'block';
                } else if (data.successMessage) {
                    successMessageDiv.textContent = data.successMessage;
                    successMessageDiv.style.display = 'block';
                    document.getElementById('change-password-form').reset();
                }
            })
            .catch(error => {
                errorMessageDiv.textContent = 'Đã xảy ra lỗi hệ thống. Vui lòng thử lại sau!';
                errorMessageDiv.style.display = 'block';
                console.error('Error:', error);
            });
        });

        // Toggle password visibility
        document.querySelectorAll('.toggle-password').forEach(button => {
            button.addEventListener('click', function () {
                const input = this.previousElementSibling;
                const isPassword = input.type === 'password';
                input.type = isPassword ? 'text' : 'password';
                const icon = this.querySelector('svg');
                icon.setAttribute('data-icon', isPassword ? 'eye' : 'eye-slash');
                icon.innerHTML = isPassword
                    ? '<path fill="currentColor" d="M320 400c-75.8 0-137.3-58.7-142.3-133.3C172.6 191.9 243.2 128 320 128s147.4 63.9 142.3 138.7C457.3 341.3 395.8 400 320 400zm0-224c-44.1 0-80 35.9-80 80s35.9 80 80 80 80-35.9 80-80-35.9-80-80-80zm0-64C160 112 0 272 0 272s160 160 320 160 320-160 320-160-160-160-320-160z"></path>'
                    : '<path fill="currentColor" d="M38.8 5.1C28.4-3.1 13.3-1.2 5.1 9.2S-1.2 34.7 9.2 42.9l592 464c10.4 8.2 25.5 6.3 33.7-4.1s6.3-25.5-4.1-33.7L525.6 386.7c39.6-40.6 66.4-86.1 79.9-118.4c3.3-7.9 3.3-16.7 0-24.6c-14.9-35.7-46.2-87.7-93-131.1C465.5 68.8 400.8 32 320 32c-68.2 0-125 26.3-169.3 60.8L38.8 5.1zM223.1 149.5C248.6 126.2 282.7 112 320 112c79.5 0 144 64.5 144 144c0 24.9-6.3 48.3-17.4 68.7L408 294.5c8.4-19.3 10.6-41.4 4.8-63.3c-11.1-41.5-47.8-69.4-88.6-71.1c-5.8-.2-9.2 6.1-7.4 11.7c2.1 6.4 3.3 13.2 3.3 20.3c0 10.2-2.4 19.8-6.6 28.3l-90.3-70.8zM373 389.9c-16.4 6.5-34.3 10.1-53 10.1c-79.5 0-144-64.5-144-144c0-6.9 .5-13.6 1.4-20.2L83.1 161.5C60.3 191.2 44 220.8 34.5 243.7c-3.3 7.9-3.3 16.7 0 24.6c14.9 35.7 46.2 87.7 93 131.1C174.5 443.2 239.2 480 320 480c47.8 0 89.9-12.9 126.2-32.5L373 389.9z"></path>';
            });
        });
    </script>

    <!-- Login Modal -->
    <jsp:include page="/login/login.jsp" />

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