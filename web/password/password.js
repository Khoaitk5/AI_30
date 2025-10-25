// PASSWORD RESET FUNCTIONALITY
function openPassword() {
    const loginOverlay = document.getElementById('loginOverlay');
    if (loginOverlay && loginOverlay.classList.contains('active')) {
        window._closeLoginCallback = function() {
            const passwordOverlay = document.getElementById('passwordOverlay');
            if (passwordOverlay) {
                passwordOverlay.classList.add('active');
                passwordOverlay.style.display = 'flex'; // Ensure visibility
            }
        };
        closeLogin();
        return;
    }
    const passwordOverlay = document.getElementById('passwordOverlay');
    if (passwordOverlay && !passwordOverlay.classList.contains('active')) {
        passwordOverlay.classList.add('active');
        passwordOverlay.style.display = 'flex'; // Ensure visibility
    }
}

function closePassword(callback) {
    const passwordOverlay = document.getElementById('passwordOverlay');
    if (passwordOverlay) {
        passwordOverlay.classList.remove('active');
        // Delay hiding to allow CSS transition to complete
        setTimeout(() => {
            passwordOverlay.style.display = 'none';
            resetPasswordForm();
            // Execute callback after animation
            if (typeof callback === 'function') {
                callback();
            } else if (typeof window._closePasswordCallback === 'function') {
                window._closePasswordCallback();
                window._closePasswordCallback = null;
            }
            // Không redirect, chỉ đóng modal và giữ nguyên trang hiện tại
        }, 300); // Match CSS transition duration
    }
}

function resetPasswordForm() {
    // Reset email form
    const passwordForm = document.getElementById('passwordForm');
    if (passwordForm) {
        passwordForm.reset();
    }
    // Reset OTP form
    const otpForm = document.getElementById('otpForm');
    if (otpForm) {
        otpForm.reset();
    }
    // Clear all errors
    const errorElements = document.querySelectorAll('.password-error-message');
    const inputElements = document.querySelectorAll('.password-form-input');
    errorElements.forEach(error => {
        error.textContent = '';
        error.classList.remove('show');
    });
    inputElements.forEach(input => {
        input.classList.remove('error', 'success');
    });
    // Reset button state
    const submitBtn = passwordForm ? passwordForm.querySelector('.password-btn-primary') : null;
    if (submitBtn) {
        submitBtn.disabled = false;
        submitBtn.textContent = 'Nhận OTP';
    }
    // Ẩn OTP, hiện lại email form
    const emailFormSection = document.getElementById('emailFormSection');
    const otpFormSection = document.getElementById('otpFormSection');
    if (emailFormSection && otpFormSection) {
        emailFormSection.style.display = 'block';
        otpFormSection.style.display = 'none';
    }
}

function initPasswordFunctionality() {
    const passwordForm = document.getElementById('passwordForm');
    const emailInput = document.getElementById('emailReset');
    const emailError = document.getElementById('emailError');
    const backBtn = document.getElementById('backToLogin');
    const closeBtn = document.querySelector('#passwordOverlay .password-close-btn');
    const passwordOverlay = document.getElementById('passwordOverlay');
    const emailFormSection = document.getElementById('emailFormSection');
    const otpFormSection = document.getElementById('otpFormSection');
    const otpForm = document.getElementById('otpForm');
    const otpInputs = otpFormSection ? otpFormSection.querySelectorAll('.otp-input') : [];
    const otpError = document.getElementById('otpError');
    const backToEmailBtn = document.getElementById('backToEmail');
    const resendOtpBtn = document.getElementById('resendOtpBtn');

    if (!passwordForm || !passwordOverlay) return;

    // Form validation functions
    function validateEmail(email) {
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        return emailRegex.test(email);
    }

    function showPasswordError(input, errorElement, message) {
        input.classList.add('error');
        input.classList.remove('success');
        errorElement.textContent = message;
        errorElement.classList.add('show');
    }

    function showPasswordSuccess(input, errorElement) {
        input.classList.add('success');
        input.classList.remove('error');  
        errorElement.textContent = '';
        errorElement.classList.remove('show');
    }

    // Real-time validation
    if (emailInput) {
        emailInput.addEventListener('blur', function() {
            const email = this.value.trim();
            if (!email) {
                showPasswordError(this, emailError, 'Email không được để trống');
            } else if (!validateEmail(email)) {
                showPasswordError(this, emailError, 'Email không đúng định dạng');
            } else {
                showPasswordSuccess(this, emailError);
            }
        });

        // Clear errors on input
        emailInput.addEventListener('input', function() {
            if (this.classList.contains('error')) {
                const errorElement = document.getElementById('emailError');
                this.classList.remove('error');
                errorElement.textContent = '';
                errorElement.classList.remove('show');
            }
        });
    }

    // Form submission (Email -> OTP)
    if (passwordForm) {
        passwordForm.addEventListener('submit', function(e) {
            e.preventDefault();
            const email = emailInput.value.trim();
            let isValid = true;
            if (!email) {
                showPasswordError(emailInput, emailError, 'Email không được để trống');
                isValid = false;
            } else if (!validateEmail(email)) {
                showPasswordError(emailInput, emailError, 'Email không đúng định dạng');
                isValid = false;
            } else {
                showPasswordSuccess(emailInput, emailError);
            }
            if (isValid) {
                // Chuyển sang form OTP
                if (emailFormSection && otpFormSection) {
                    emailFormSection.style.display = 'none';
                    otpFormSection.style.display = 'block';
                    // Focus vào ô đầu tiên
                    if (otpInputs && otpInputs.length > 0) {
                        otpInputs[0].focus();
                    }
                }
                showSuccess('Mã OTP đã được gửi đến email của bạn!');
            }
        });
    }

    // Back to email form from OTP
    if (backToEmailBtn) {
        backToEmailBtn.addEventListener('click', function(e) {
            e.preventDefault();
            if (emailFormSection && otpFormSection) {
                otpFormSection.style.display = 'none';
                emailFormSection.style.display = 'block';
            }
        });
    }

    // OTP input: tự động chuyển focus, chỉ nhận số, xóa lùi
    if (otpInputs && otpInputs.length > 0) {
        otpInputs.forEach((input, idx) => {
            input.addEventListener('input', function(e) {
                this.value = this.value.replace(/[^0-9]/g, '');
                if (this.value.length === 1 && idx < otpInputs.length - 1) {
                    otpInputs[idx + 1].focus();
                }
            });
            input.addEventListener('keydown', function(e) {
                if (e.key === 'Backspace' && !this.value && idx > 0) {
                    otpInputs[idx - 1].focus();
                }
            });
        });
    }

    // OTP form submit
    if (otpForm) {
        otpForm.addEventListener('submit', function(e) {
            e.preventDefault();
            let otp = '';
            let valid = true;
            otpInputs.forEach(input => {
                if (!input.value || input.value.length !== 1) {
                    valid = false;
                }
                otp += input.value;
            });
            if (!valid) {
                if (otpError) {
                    otpError.textContent = 'Vui lòng nhập đầy đủ mã OTP';
                    otpError.classList.add('show');
                }
                return;
            }
            if (otpError) {
                otpError.textContent = '';
                otpError.classList.remove('show');
            }
            // Xử lý xác thực OTP ở đây (giả lập thành công)
            showSuccess('Xác thực OTP thành công! Chuyển về trang đổi mật khẩu...');
            setTimeout(() => {
                // Chuyển hướng hoặc mở form đổi mật khẩu
                closePassword(function() {
                    // Có thể mở form đổi mật khẩu ở đây
                });
            }, 2000);
        });
    }

    // Resend OTP
    if (resendOtpBtn) {
        resendOtpBtn.addEventListener('click', function(e) {
            e.preventDefault();
            // Gửi lại OTP (giả lập)
            showSuccess('Đã gửi lại mã OTP!');
        });
    }

    // Back to login functionality
    if (backBtn) {
        backBtn.addEventListener('click', function(e) {
            e.preventDefault();
            closePassword(function() {
                if (typeof openLogin === 'function') {
                    openLogin();
                } else {
                    window.location.href = (window.location.origin + (window.location.pathname.split('/').slice(0,2).join('/') || '')) + '/login';
                }
            });
        });
    }

    // Close button handler
    if (closeBtn) {
        closeBtn.addEventListener('click', function(e) {
            e.preventDefault();
            closePassword();
        });
    }
    
    // ESC key handler (listen on document for reliability)
    document.addEventListener('keydown', function(e) {
        if (e.key === 'Escape') {
            if (passwordOverlay && passwordOverlay.classList.contains('active')) {
                closePassword();
            }
        }
    });
    
    // Overlay click handler
    if (passwordOverlay) {
        passwordOverlay.addEventListener('click', function(e) {
            if (e.target === passwordOverlay) {
                closePassword();
            }
        });
    }
}

function showSuccess(message) {
    const notification = document.createElement('div');
    notification.style.cssText = `
        position: fixed;
        top: 20px;
        right: 20px;
        background: #10b981;
        color: white;
        padding: 1rem 1.5rem;
        border-radius: 0.5rem;
        box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
        z-index: 10001;
        animation: slideIn 0.3s ease-out;
    `;
    notification.textContent = message;
    document.body.appendChild(notification);

    setTimeout(() => {
        notification.remove();
    }, 3000);
}

// Initialize when DOM is loaded
document.addEventListener('DOMContentLoaded', function() {
    initPasswordFunctionality();
});