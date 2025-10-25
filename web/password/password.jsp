<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/password/password.css">
    </head>
    <body>
        <!-- Password Reset Modal -->
        <div class="password-overlay" id="passwordOverlay">
            <div class="password-container">
                <!-- Form Section -->
                <div class="password-form-section">
                    <!-- Email Section: bọc toàn bộ phần liên quan email vào emailFormSection -->
                    <div id="emailFormSection" style="display:block;position:relative;z-index:2;background:#fff;">
                        <!-- Logo -->
                        <div class="password-logo-container">
                            <img src="${pageContext.request.contextPath}/asset/images/logo_gf_black.svg" alt="Logo" class="password-logo">
                        </div>
                        <!-- Back button and title -->
                        <div class="password-header-section" id="emailHeaderSection">
                            <button type="button" class="password-back-btn" id="backToLogin">
                                <img src="${pageContext.request.contextPath}/asset/images/arrow_left.png" alt="Back" class="password-back-icon">
                            </button>
                            <h1 class="password-form-title">Quên mật khẩu</h1>
                            <div class="password-spacer"></div>
                        </div>
                        <!-- Description -->
                        <p class="password-description" id="emailDescription">
                            Vui lòng nhập email bạn đã đăng ký. Chúng tôi sẽ gửi mã xác nhận tới email của bạn.
                        </p>
                        <!-- Email Form -->
                        <form class="password-form" id="passwordForm" novalidate style="background:#fff;z-index:2;position:relative;">
                            <!-- Email Field -->
                            <div class="password-form-group">
                                <label for="emailReset" class="password-form-label">
                                    Email<span class="password-required">*</span>
                                </label>
                                <input type="email" id="emailReset" name="email" class="password-form-input"
                                       placeholder="Vui lòng nhập email của Bạn" required>
                                <span class="password-error-message" id="emailError"></span>
                            </div>
                            <!-- Submit Button -->
                            <button type="submit" class="password-btn-primary">Nhận OTP</button>
                        </form>
                    </div>

                    <!-- OTP Section: bọc toàn bộ phần liên quan OTP vào otpFormSection -->
                    <div id="otpFormSection" style="display:none;position:relative;z-index:2;background:#fff;">
                        <!-- Logo -->
                        <div class="password-logo-container">
                            <img src="${pageContext.request.contextPath}/asset/images/logo_gf_black.svg" alt="Logo" class="password-logo">
                        </div>
                        <div class="password-header-section">
                            <button type="button" class="password-back-btn" id="backToEmail" tabindex="0">
                                <img src="${pageContext.request.contextPath}/asset/images/arrow_left.png" alt="Back" class="password-back-icon">
                            </button>
                            <h2 class="password-form-title" style="font-size:28px;">Xác thực OTP</h2>
                            <div class="password-spacer"></div>
                        </div>
                        <form class="password-form" id="otpForm" novalidate style="background:#fff;z-index:2;position:relative;">
                            <p class="password-description" style="margin-top:0;margin-bottom:16px;">Chúng tôi đã gửi cho bạn một mã xác minh. Kiểm tra hộp thư đến của bạn để nhận chúng.</p>
                            <div class="password-form-group" style="display:flex;flex-direction:row;justify-content:center;align-items:center;gap:12px;width:100%;margin-bottom:8px;">
                                <input aria-label="Digit 1" autocomplete="off" class="otp-input password-form-input" maxlength="1" type="tel" inputmode="numeric" pattern="[0-9]*" style="width:48px;height:48px;text-align:center;font-size:20px;" required>
                                <input aria-label="Digit 2" autocomplete="off" class="otp-input password-form-input" maxlength="1" type="tel" inputmode="numeric" pattern="[0-9]*" style="width:48px;height:48px;text-align:center;font-size:20px;" required>
                                <input aria-label="Digit 3" autocomplete="off" class="otp-input password-form-input" maxlength="1" type="tel" inputmode="numeric" pattern="[0-9]*" style="width:48px;height:48px;text-align:center;font-size:20px;" required>
                                <input aria-label="Digit 4" autocomplete="off" class="otp-input password-form-input" maxlength="1" type="tel" inputmode="numeric" pattern="[0-9]*" style="width:48px;height:48px;text-align:center;font-size:20px;" required>
                                <input aria-label="Digit 5" autocomplete="off" class="otp-input password-form-input" maxlength="1" type="tel" inputmode="numeric" pattern="[0-9]*" style="width:48px;height:48px;text-align:center;font-size:20px;" required>
                                <input aria-label="Digit 6" autocomplete="off" class="otp-input password-form-input" maxlength="1" type="tel" inputmode="numeric" pattern="[0-9]*" style="width:48px;height:48px;text-align:center;font-size:20px;" required>
                            </div>
                            <span class="password-error-message" id="otpError"></span>
                            <button class="password-btn-primary" type="submit" style="margin-top:24px;">Xác thực</button>
                            <p class="password-description" style="font-size:14px;margin-top:16px;text-align:center;">Chưa nhận được mã? <button type="button" class="password-resend-btn" id="resendOtpBtn" style="color:#2563eb;background:none;border:none;text-decoration:underline;cursor:pointer;padding:0;">Gửi lại</button></p>
                        </form>
                    </div>
                </div>

                <!-- Image Section -->
                <div class="password-image-section">
                    <img src="${pageContext.request.contextPath}/asset/images/new_login.png" alt="Password Reset Illustration" class="password-image">
                    <!-- Close button for desktop -->
                    <button class="password-close-btn password-close-btn--desktop" aria-label="Đóng"
                            onclick="closePassword()">
                        <svg class="password-close-icon" viewBox="0 0 24 24">
                        <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                              d="M6 18 17.94 6M18 18 6.06 6" />
                        </svg>
                    </button>
                </div>
            </div>
        </div>
    </body>
</html>
