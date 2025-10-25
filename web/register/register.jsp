<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/register/register.css">
    </head>
    <body>
        <!-- Register Modal -->
        <div class="register-overlay" id="registerOverlay">
            <div class="register-modal">
                <!-- Form Section -->
                <div class="register-form-wrap">
                    <!-- Close button for mobile -->
                    <button class="register-close-mobile" aria-label="Đóng" onclick="closeRegister()">
                        <svg class="close-icon" viewBox="0 0 24 24">
                            <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                  d="M6 18 17.94 6M18 18 6.06 6" />
                        </svg>
                    </button>

                    <!-- Logo -->
                    <div class="register-logo-wrap">
                        <img src="${pageContext.request.contextPath}/asset/images/logo_gf_black.svg" alt="Logo" class="register-logo">
                    </div>

                    <!-- Title -->
                    <h2 class="register-title">Đăng ký</h2>

                    <!-- Thông báo lỗi/thành công -->
                    <c:if test="${not empty registerError}">
                        <div class="error-message show" style="color:#dc2626;text-align:center;margin-bottom:8px;">
                            ${registerError}
                        </div>
                    </c:if>
                    <c:if test="${not empty registerSuccess}">
                        <div class="error-message show" style="color:#059669;text-align:center;margin-bottom:8px;">
                            ${registerSuccess}
                        </div>
                    </c:if>

                    <!-- Register Form -->
                    <form class="register-form" id="registerForm" method="post" action="register" novalidate>
                        <!-- Redirect URL (trang hiện tại) -->
                        <input type="hidden" name="redirectUrl" value="<%= request.getRequestURL() + (request.getQueryString() != null ? ("?" + request.getQueryString()) : "") %>">
                        <!-- Full Name Field -->
                        <div class="field-group">
                            <label class="field-label" for="fullName">Tên <span class="required">*</span></label>
                            <input class="field-input" type="text" id="fullName" name="fullName" required
                                   value="${registerFullName != null ? registerFullName : ''}">
                            <span class="error-msg" id="fullNameError"></span>
                        </div>

                        <!-- Email Field -->
                        <div class="field-group">
                            <label class="field-label" for="emailSignup">Email <span class="required">*</span></label>
                            <input class="field-input" type="email" id="emailSignup" name="email" required
                                   value="${registerEmail != null ? registerEmail : ''}">
                            <span class="error-msg" id="emailSignupError"></span>
                        </div>

                        <!-- Phone Field -->
                        <div class="field-group">
                            <label class="field-label" for="phone">Số điện thoại <span class="required">*</span></label>
                            <input class="field-input" type="tel" id="phone" name="phone" required
                                   value="${registerPhone != null ? registerPhone : ''}">
                            <span class="error-msg" id="phoneError"></span>
                        </div>

                        <!-- Password Field -->
                        <div class="field-group">
                            <label class="field-label" for="passwordSignup">Mật khẩu <span class="required">*</span></label>
                            <div class="password-field">
                                <input class="field-input" type="password" id="passwordSignup" name="password" required>
                                <button type="button" class="password-toggle" id="togglePasswordSignup"
                                        aria-label="Hiện/Ẩn mật khẩu">
                                    <svg class="eye-icon" viewBox="0 0 640 512">
                                        <path fill="currentColor"
                                              d="M38.8 5.1C28.4-3.1 13.3-1.2 5.1 9.2S-1.2 34.7 9.2 42.9l592 464c10.4 8.2 25.5 6.3 33.7-4.1s6.3-25.5-4.1-33.7L525.6 386.7c39.6-40.6 66.4-86.1 79.9-118.4c3.3-7.9 3.3-16.7 0-24.6c-14.9-35.7-46.2-87.7-93-131.1C465.5 68.8 400.8 32 320 32c-68.2 0-125 26.3-169.3 60.8L38.8 5.1zM223.1 149.5C248.6 126.2 282.7 112 320 112c79.5 0 144 64.5 144 144c0 24.9-6.3 48.3-17.4 68.7L408 294.5c8.4-19.3 10.6-41.4 4.8-63.3c-11.1-41.5-47.8-69.4-88.6-71.1c-5.8-.2-9.2 6.1-7.4 11.7c2.1 6.4 3.3 13.2 3.3 20.3c0 10.2-2.4 19.8-6.6 28.3l-90.3-70.8zM373 389.9c-16.4 6.5-34.3 10.1-53 10.1c-79.5 0-144-64.5-144-144c0-6.9 .5-13.6 1.4-20.2L83.1 161.5C60.3 191.2 44 220.8 34.5 243.7c-3.3 7.9-3.3 16.7 0 24.6c14.9 35.7 46.2 87.7 93 131.1C174.5 443.2 239.2 480 320 480c47.8 0 89.9-12.9 126.2-32.5L373 389.9z" />
                                    </svg>
                                </button>
                            </div>
                            <span class="error-msg" id="passwordSignupError"></span>
                        </div>

                        <!-- Confirm Password Field -->
                        <div class="field-group">
                            <label class="field-label" for="confirmPassword">Nhập lại mật khẩu <span class="required">*</span></label>
                            <div class="password-field">
                                <input class="field-input" type="password" id="confirmPassword" name="confirmPassword" required>
                                <button type="button" class="password-toggle" id="toggleConfirmPassword"
                                        aria-label="Hiện/Ẩn mật khẩu">
                                    <svg class="eye-icon" viewBox="0 0 640 512">
                                        <path fill="currentColor"
                                              d="M38.8 5.1C28.4-3.1 13.3-1.2 5.1 9.2S-1.2 34.7 9.2 42.9l592 464c10.4 8.2 25.5 6.3 33.7-4.1s6.3-25.5-4.1-33.7L525.6 386.7c39.6-40.6 66.4-86.1 79.9-118.4c3.3-7.9 3.3-16.7 0-24.6c-14.9-35.7-46.2-87.7-93-131.1C465.5 68.8 400.8 32 320 32c-68.2 0-125 26.3-169.3 60.8L38.8 5.1zM223.1 149.5C248.6 126.2 282.7 112 320 112c79.5 0 144 64.5 144 144c0 24.9-6.3 48.3-17.4 68.7L408 294.5c8.4-19.3 10.6-41.4 4.8-63.3c-11.1-41.5-47.8-69.4-88.6-71.1c-5.8-.2-9.2 6.1-7.4 11.7c2.1 6.4 3.3 13.2 3.3 20.3c0 10.2-2.4 19.8-6.6 28.3l-90.3-70.8zM373 389.9c-16.4 6.5-34.3 10.1-53 10.1c-79.5 0-144-64.5-144-144c0-6.9 .5-13.6 1.4-20.2L83.1 161.5C60.3 191.2 44 220.8 34.5 243.7c-3.3 7.9-3.3 16.7 0 24.6c14.9 35.7 46.2 87.7 93 131.1C174.5 443.2 239.2 480 320 480c47.8 0 89.9-12.9 126.2-32.5L373 389.9z" />
                                    </svg>
                                </button>
                            </div>
                            <span class="error-msg" id="confirmPasswordError"></span>
                        </div>

                        <!-- Terms Agreement -->
                        <div class="terms-group">
                            <input id="terms" class="terms-checkbox" type="checkbox" name="terms" required>
                            <label for="terms" class="terms-label">
                                Tôi đã đọc và đồng ý với
                                <a class="terms-link" target="_blank" rel="noopener noreferrer" href="/policy">Chính sách & quy định</a>
                                và
                                <a class="terms-link" target="_blank" rel="noopener noreferrer" href="/personal-data-policy">Chính sách bảo vệ dữ liệu cá nhân của Green Future</a>
                            </label>
                            <span class="error-msg" id="termsError"></span>
                        </div>

                        <!-- Submit Button -->
                        <button class="submit-btn" type="submit">Đăng ký</button>

                        <!-- Divider -->
                        <div class="divider">
                            <hr>
                            <span>Hoặc</span>
                        </div>

                        <!-- Google Register -->
                        <button class="btn-google" type="button" onclick="window.location.href='${pageContext.request.contextPath}/GoogleAuthController?action=google-login'">
                            <img src="${pageContext.request.contextPath}/asset/images/social-google-icon.svg" alt="Google Icon" class="google-icon">
                            Đăng nhập bằng Google
                        </button>
                    </form>

                    <!-- Login Link -->
                    <p class="login-link">
                        Bạn đã có tài khoản?
                        <button class="link-btn" type="button" id="goToLogin">Đăng nhập ngay</button>
                    </p>
                </div>

                <!-- Image Section -->
                <div class="register-image-wrap">
                    <img src="${pageContext.request.contextPath}/asset/images/new_login.png" alt="Car" class="register-image">
                    <!-- Close button for desktop -->
                    <button class="register-close-desktop" aria-label="Đóng" onclick="closeRegister()">
                        <svg class="close-icon" viewBox="0 0 24 24">
                            <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                  d="M6 18 17.94 6M18 18 6.06 6" />
                        </svg>
                    </button>
                </div>
            </div>
        </div>
        <script>
            // Tự động bật modal nếu có lỗi đăng ký
            <% if (request.getAttribute("registerError") != null || request.getAttribute("registerSuccess") != null) { %>
            document.addEventListener('DOMContentLoaded', function () {
                openRegister();
            });
            <% }%>
            // Đảm bảo chuyển modal đúng khi bấm link
            document.addEventListener('DOMContentLoaded', function () {
                var goToLoginBtn = document.getElementById('goToLogin');
                if (goToLoginBtn) {
                    goToLoginBtn.addEventListener('click', function(e) {
                        e.preventDefault();
                        closeRegister();
                        if (typeof openLogin === 'function') openLogin();
                    });
                }
            });
        </script>
    </body>
</html>