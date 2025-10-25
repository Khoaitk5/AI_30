<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/login/login.css">
    </head>
    <body>
        <!-- Login Modal -->
        <div class="login-overlay" id="loginOverlay">
            <div class="login-container">
                <!-- Form Section -->
                <div class="form-section">
                    <!-- Mobile Close Button -->
                    <button class="close-btn close-btn--mobile" aria-label="Đóng" onclick="closeLogin()">
                        <svg class="close-icon" viewBox="0 0 24 24">
                        <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                              d="M6 18 17.94 6M18 18 6.06 6" />
                        </svg>
                    </button>

                    <!-- Logo -->
                    <div class="logo-container">
                        <img src="${pageContext.request.contextPath}/asset/images/logo_gf_black.svg" alt="TVT Future" class="logo">
                    </div>

                    <!-- Title -->
                    <h2 class="form-title">Đăng nhập</h2>

                    <!-- Thông báo lỗi/thành công -->
                    <c:if test="${not empty errorMessage}">
                        <div class="error-message show" style="color:#dc2626;text-align:center;margin-bottom:8px;">
                            ${errorMessage}
                        </div>
                    </c:if>
                    <c:if test="${param.message eq 'logout'}">
                        <div class="error-message show" style="color:#059669;text-align:center;margin-bottom:8px;">
                            Đăng xuất thành công!
                        </div>
                    </c:if>

                    <!-- Login Form -->
                    <form class="login-form" novalidate id="loginForm" method="post" action="${pageContext.request.contextPath}/login">
                        <input type="hidden" name="action" value="login">
                        <!-- Loại đăng nhập (ẩn) -->
                        <input type="hidden" id="loginType" name="loginType" value="customer">
                        <!-- Redirect URL (trang hiện tại) -->
                        <input type="hidden" name="redirectUrl" value="<%= request.getRequestURL() + (request.getQueryString() != null ? ("?" + request.getQueryString()) : "") %>">
                        <!-- Username/Email/Phone Field -->
                        <div class="form-group">
                            <label class="form-label" for="loginIdentifier">Tên đăng nhập / Email / Số điện thoại</label>
                            <input class="form-input" id="loginIdentifier" name="loginIdentifier"
                                   placeholder="Tên đăng nhập (Admin) hoặc Email/SĐT (Khách hàng)" type="text"
                                   value="${loginIdentifier != null ? loginIdentifier : ''}" required>
                        </div>
                        <!-- Password Field -->
                        <div class="form-group">
                            <label class="form-label" for="passwordLogin">Mật khẩu</label>
                            <div class="password-field">
                                <input class="form-input" id="passwordLogin" placeholder="Mật khẩu" type="password"
                                       name="password" required>
                                <button type="button" class="password-toggle" id="togglePasswordLogin"
                                        aria-label="Hiện mật khẩu">
                                    <svg class="eye-icon" viewBox="0 0 640 512">
                                    <path fill="currentColor"
                                          d="M38.8 5.1C28.4-3.1 13.3-1.2 5.1 9.2S-1.2 34.7 9.2 42.9l592 464c10.4 8.2 25.5 6.3 33.7-4.1s6.3-25.5-4.1-33.7L525.6 386.7c39.6-40.6 66.4-86.1 79.9-118.4c3.3-7.9 3.3-16.7 0-24.6c-14.9-35.7-46.2-87.7-93-131.1C465.5 68.8 400.8 32 320 32c-68.2 0-125 26.3-169.3 60.8L38.8 5.1zM223.1 149.5C248.6 126.2 282.7 112 320 112c79.5 0 144 64.5 144 144c0 24.9-6.3 48.3-17.4 68.7L408 294.5c8.4-19.3 10.6-41.4 4.8-63.3c-11.1-41.5-47.8-69.4-88.6-71.1c-5.8-.2-9.2 6.1-7.4 11.7c2.1 6.4 3.3 13.2 3.3 20.3c0 10.2-2.4 19.8-6.6 28.3l-90.3-70.8zM373 389.9c-16.4 6.5-34.3 10.1-53 10.1c-79.5 0-144-64.5-144-144c0-6.9 .5-13.6 1.4-20.2L83.1 161.5C60.3 191.2 44 220.8 34.5 243.7c-3.3 7.9-3.3 16.7 0 24.6c14.9 35.7 46.2 87.7 93 131.1C174.5 443.2 239.2 480 320 480c47.8 0 89.9-12.9 126.2-32.5L373 389.9z">
                                    </path>
                                    </svg>
                                </button>
                            </div>
                        </div>

                        <!-- Submit Button -->
                        <button class="btn-primary" type="submit">Đăng nhập</button>

                        <!-- Forgot Password -->
                        <p class="forgot-password">
                            <a href="#" class="link-cyan" id="goToForgotPassword">Quên mật khẩu</a>
                        </p>

                        <!-- Divider -->
                        <div class="divider">
                            <hr>
                            <span>Hoặc</span>
                        </div>

                        <!-- Google Login -->
                        <button class="btn-google" type="button" onclick="window.location.href='${pageContext.request.contextPath}/GoogleAuthController?action=google-login'">
                            <img src="${pageContext.request.contextPath}/asset/images/social-google-icon.svg" alt="Google Icon" class="google-icon">
                            Đăng nhập bằng Google
                        </button>
                    </form>

                    <!-- Register Link -->
                    <p class="auth-link">
                        Bạn chưa có tài khoản?
                        <a href="#" class="link-cyan" id="goToRegister">Đăng ký tài khoản</a>
                    </p>
                </div>

                <!-- Image Section -->
                <div class="image-section">
                    <img src="${pageContext.request.contextPath}/asset/images/new_login.png" alt="Car" class="login-image">
                    <!-- Desktop Close Button -->
                    <button class="close-btn close-btn--desktop" aria-label="Đóng" onclick="closeLogin()">
                        <svg class="close-icon" viewBox="0 0 24 24">
                        <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                              d="M6 18 17.94 6M18 18 6.06 6" />
                        </svg>
                    </button>
                </div>
            </div>
        </div>
    </body>
    <script>
                        // Tự động focus vào trường nhập đầu tiên khi mở modal
                        document.addEventListener('DOMContentLoaded', function () {
                            var input = document.getElementById('loginIdentifier');
                            if (input)
                                input.focus();
                        });

                        // Xác định loại đăng nhập dựa trên input (admin: username, customer: email/sdt)

                        // ...existing code...

                        // Tự động bật modal nếu có showLoginModal, chỉ bật nếu không có flag "hideLoginModal"


        <% if (request.getAttribute("showLoginModal") != null && Boolean.parseBoolean(request.getAttribute("showLoginModal").toString())) { %>
        <script>
            if (!sessionStorage.getItem('hideLoginModal')) {
                document.addEventListener('DOMContentLoaded', function () {
                    openLogin();
                });
            }
        </script>
        <% } %>

                        // Khi đóng modal login, set flag để không tự bật lại khi reload
                        document.addEventListener('DOMContentLoaded', function () {
                            var loginOverlay = document.getElementById('loginOverlay');
                            if (loginOverlay) {
                                loginOverlay.addEventListener('transitionend', function (e) {
                                    if (!loginOverlay.classList.contains('active')) {
                                        sessionStorage.setItem('hideLoginModal', '1');
                                    }
                                });
                            }
                            // Nếu mở lại modal thì xóa flag
                            if (typeof openLogin === 'function') {
                                var origOpenLogin = openLogin;
                                window.openLogin = function () {
                                    sessionStorage.removeItem('hideLoginModal');
                                    origOpenLogin();
                                };
                            }
                        });
    </script>
</body>
</html>
