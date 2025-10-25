// REGISTER FUNCTIONALITY
function openRegister() {
    const registerOverlay = document.getElementById('registerOverlay');
    if (registerOverlay) {
        registerOverlay.classList.add('active');
    }
}

function closeRegister() {
    const registerOverlay = document.getElementById('registerOverlay');
    if (registerOverlay) {
        registerOverlay.classList.remove('active');
        // Reset form về trạng thái ban đầu
        resetRegisterForm();
    }
    // Không redirect, chỉ đóng modal và giữ nguyên trang hiện tại
}

function resetRegisterForm() {
    const registerForm = document.getElementById('registerForm');
    const passwordToggles = {
        password: document.getElementById('togglePasswordSignup'),
        confirmPassword: document.getElementById('toggleConfirmPassword')
    };

    // Reset form
    if (registerForm) {
        registerForm.reset();
    }

    // Clear tất cả errors
    const errorElements = document.querySelectorAll('#registerForm .error-msg');
    const inputElements = document.querySelectorAll('#registerForm .field-input');

    errorElements.forEach(error => {
        error.textContent = '';
        error.classList.remove('show');
    });

    inputElements.forEach(input => {
        input.classList.remove('error', 'success');
    });

    // Reset password fields về trạng thái ban đầu (ẩn password)
    const passwordInput = document.getElementById('passwordSignup');
    const confirmPasswordInput = document.getElementById('confirmPassword');

    if (passwordInput) {
        passwordInput.type = 'password';
    }
    if (confirmPasswordInput) {
        confirmPasswordInput.type = 'password';
    }

    // Reset icons về eye-slash (mắt có gạch)
    const EYE_ICONS = {
        closed: 'M38.8 5.1C28.4-3.1 13.3-1.2 5.1 9.2S-1.2 34.7 9.2 42.9l592 464c10.4 8.2 25.5 6.3 33.7-4.1s6.3-25.5-4.1-33.7L525.6 386.7c39.6-40.6 66.4-86.1 79.9-118.4c3.3-7.9 3.3-16.7 0-24.6c-14.9-35.7-46.2-87.7-93-131.1C465.5 68.8 400.8 32 320 32c-68.2 0-125 26.3-169.3 60.8L38.8 5.1zM223.1 149.5C248.6 126.2 282.7 112 320 112c79.5 0 144 64.5 144 144c0 24.9-6.3 48.3-17.4 68.7L408 294.5c8.4-19.3 10.6-41.4 4.8-63.3c-11.1-41.5-47.8-69.4-88.6-71.1c-5.8-.2-9.2 6.1-7.4 11.7c2.1 6.4 3.3 13.2 3.3 20.3c0 10.2-2.4 19.8-6.6 28.3l-90.3-70.8zM373 389.9c-16.4 6.5-34.3 10.1-53 10.1c-79.5 0-144-64.5-144-144c0-6.9 .5-13.6 1.4-20.2L83.1 161.5C60.3 191.2 44 220.8 34.5 243.7c-3.3 7.9-3.3 16.7 0 24.6c14.9 35.7 46.2 87.7 93 131.1C174.5 443.2 239.2 480 320 480c47.8 0 89.9-12.9 126.2-32.5L373 389.9z'
    };

    Object.values(passwordToggles).forEach(toggle => {
        if (toggle) {
            const icon = toggle.querySelector('.eye-icon path');
            if (icon) {
                icon.setAttribute('d', EYE_ICONS.closed);
            }
            toggle.setAttribute('aria-label', 'Hiện mật khẩu');
        }
    });

    // Reset loading state nếu có
    const submitBtn = registerForm ? registerForm.querySelector('.register-btn') : null;
    if (submitBtn) {
        submitBtn.disabled = false;
        submitBtn.innerHTML = submitBtn.innerHTML.replace(/Loading.../, 'Đăng ký');
    }
}

// Hàm kiểm tra realtime email/sdt với server (gọi về servlet để check DB)
function checkExistsRealtime(type, value, callback) {
    // Sử dụng đúng context path của ứng dụng
    var contextPath = window.location.pathname.split('/')[1];
    var url = '';
    if (contextPath && contextPath !== 'register') {
        url = '/' + contextPath + '/register?type=' + encodeURIComponent(type) + '&value=' + encodeURIComponent(value);
    } else {
        url = '/register?type=' + encodeURIComponent(type) + '&value=' + encodeURIComponent(value);
    }

    // DEBUG: log url để kiểm tra request
    // console.log('Check exists URL:', url);

    fetch(url, {
        method: 'GET',
        headers: {
            'Accept': 'application/json'
        },
        cache: 'no-store'
    })
    .then(res => {
        // DEBUG: log status
        // console.log('Check exists status:', res.status);
        if (!res.ok) throw new Error('Network response was not ok');
        return res.json();
    })
    .then(data => {
        // DEBUG: log response
        // console.log('Check exists data:', data);
        callback(data.exists);
    })
    .catch((err) => {
        // DEBUG: log error
        // console.error('Check exists error:', err);
        callback(false);
    });
}

function submitRegisterForm(e) {
    const form = document.getElementById('registerForm');
    const fullName = document.getElementById('fullName').value.trim();
    const email = document.getElementById('emailSignup').value.trim();
    const phone = document.getElementById('phone').value.trim();
    const password = document.getElementById('passwordSignup').value;
    const confirmPassword = document.getElementById('confirmPassword').value;
    const terms = document.getElementById('terms').checked;

    // Simple validation
    let valid = true;
    // Validate full name
    if (!fullName) {
        document.getElementById('fullNameError').textContent = 'Vui lòng nhập tên';
        valid = false;
    } else {
        document.getElementById('fullNameError').textContent = '';
    }
    // Validate email
    if (!email || !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
        document.getElementById('emailSignupError').textContent = 'Email không hợp lệ';
        valid = false;
    } else {
        document.getElementById('emailSignupError').textContent = '';
    }
    // Validate phone
    if (!phone || !/^\d{10,11}$/.test(phone)) {
        document.getElementById('phoneError').textContent = 'Số điện thoại không hợp lệ';
        valid = false;
    } else {
        document.getElementById('phoneError').textContent = '';
    }
    // Validate password
    if (!password || password.length < 6) {
        document.getElementById('passwordSignupError').textContent = 'Mật khẩu tối thiểu 6 ký tự';
        valid = false;
    } else {
        document.getElementById('passwordSignupError').textContent = '';
    }
    // Validate confirm password
    if (password !== confirmPassword) {
        document.getElementById('confirmPasswordError').textContent = 'Mật khẩu không khớp';
        valid = false;
    } else {
        document.getElementById('confirmPasswordError').textContent = '';
    }
    // Validate terms
    if (!terms) {
        document.getElementById('termsError').textContent = 'Bạn phải đồng ý với điều khoản';
        valid = false;
    } else {
        document.getElementById('termsError').textContent = '';
    }

    // Luôn ngăn submit mặc định
    e.preventDefault();

    // Để tránh lặp vô hạn khi gọi form.submit() bằng JS
    if (form._submitting) return;

    // Nếu không hợp lệ định dạng thì không kiểm tra realtime
    if (!valid) {
        return;
    }

    // Kiểm tra realtime email/sdt trước khi submit
    let pending = 2;
    let emailExists = false;
    let phoneExists = false;

    function finishCheck() {
        if (pending === 0) {
            if (emailExists) {
                document.getElementById('emailSignupError').textContent = 'Email đã tồn tại, vui lòng dùng email khác';
                return;
            }
            if (phoneExists) {
                document.getElementById('phoneError').textContent = 'Số điện thoại đã tồn tại, vui lòng dùng số khác';
                return;
            }
            // Nếu hợp lệ, submit form bằng JS (và đặt flag để không lặp)
            form._submitting = true;
            form.submit();
        }
    }

    checkExistsRealtime('email', email, function(exists) {
        emailExists = exists;
        pending--;
        finishCheck();
    });
    checkExistsRealtime('phone', phone, function(exists) {
        phoneExists = exists;
        pending--;
        finishCheck();
    });
}

function initRegisterFunctionality() {
    const registerForm = document.getElementById('registerForm');
    const inputs = {
        fullName: document.getElementById('fullName'),
        email: document.getElementById('emailSignup'),
        phone: document.getElementById('phone'),
        password: document.getElementById('passwordSignup'),
        confirmPassword: document.getElementById('confirmPassword'),
        terms: document.getElementById('terms')
    };

    const errors = {
        fullName: document.getElementById('fullNameError'),
        email: document.getElementById('emailSignupError'),
        phone: document.getElementById('phoneError'),
        password: document.getElementById('passwordSignupError'),
        confirmPassword: document.getElementById('confirmPasswordError'),
        terms: document.getElementById('termsError')
    };

    const buttons = {
        submit: registerForm ? registerForm.querySelector('button[type="submit"]') : null,
        google: document.querySelector('.register-btn--google'),
        login: document.getElementById('goToLogin')
    };

    const passwordToggles = {
        password: document.getElementById('togglePasswordSignup'),
        confirmPassword: document.getElementById('toggleConfirmPassword')
    };

    if (!registerForm) return;

    // Constants
    const VALIDATION_RULES = {
        fullName: { minLength: 2 },
        email: { pattern: /^[^\s@]+@[^\s@]+\.[^\s@]+$/ },
        phone: { pattern: /^[0-9]{10,11}$/ },
        password: { minLength: 6 }
    };

    const ERROR_MESSAGES = {
        fullName: {
            empty: 'Tên không được để trống',
            invalid: 'Tên phải có ít nhất 2 ký tự'
        },
        email: {
            empty: 'Email không được để trống',
            invalid: 'Email không đúng định dạng'
        },
        phone: {
            empty: 'Số điện thoại không được để trống',
            invalid: 'Số điện thoại phải có 10-11 chữ số'
        },
        password: {
            empty: 'Mật khẩu không được để trống',
            invalid: 'Mật khẩu phải có ít nhất 6 ký tự'
        },
        confirmPassword: {
            empty: 'Vui lòng nhập lại mật khẩu',
            invalid: 'Mật khẩu không khớp'
        },
        terms: 'Bạn phải đồng ý với điều khoản để tiếp tục'
    };

    const EYE_ICONS = {
        closed: 'M38.8 5.1C28.4-3.1 13.3-1.2 5.1 9.2S-1.2 34.7 9.2 42.9l592 464c10.4 8.2 25.5 6.3 33.7-4.1s6.3-25.5-4.1-33.7L525.6 386.7c39.6-40.6 66.4-86.1 79.9-118.4c3.3-7.9 3.3-16.7 0-24.6c-14.9-35.7-46.2-87.7-93-131.1C465.5 68.8 400.8 32 320 32c-68.2 0-125 26.3-169.3 60.8L38.8 5.1zM223.1 149.5C248.6 126.2 282.7 112 320 112c79.5 0 144 64.5 144 144c0 24.9-6.3 48.3-17.4 68.7L408 294.5c8.4-19.3 10.6-41.4 4.8-63.3c-11.1-41.5-47.8-69.4-88.6-71.1c-5.8-.2-9.2 6.1-7.4 11.7c2.1 6.4 3.3 13.2 3.3 20.3c0 10.2-2.4 19.8-6.6 28.3l-90.3-70.8zM373 389.9c-16.4 6.5-34.3 10.1-53 10.1c-79.5 0-144-64.5-144-144c0-6.9 .5-13.6 1.4-20.2L83.1 161.5C60.3 191.2 44 220.8 34.5 243.7c-3.3 7.9-3.3 16.7 0 24.6c14.9 35.7 46.2 87.7 93 131.1C174.5 443.2 239.2 480 320 480c47.8 0 89.9-12.9 126.2-32.5L373 389.9z',
        open: 'M288 32c-80.8 0-145.5 36.8-192.6 80.6C48.6 156 17.3 208 2.5 243.7c-3.3 7.9-3.3 16.7 0 24.6C17.3 304 48.6 356 95.4 399.4C142.5 443.2 207.2 480 288 480s145.5-36.8 192.6-80.6c46.8-43.5 78.1-95.4 93-131.1c3.3-7.9 3.3-16.7 0-24.6c-14.9-35.7-46.2-87.7-93-131.1C433.5 68.8 368.8 32 288 32zM144 256a144 144 0 1 1 288 0 144 144 0 1 1 -288 0zm144-64c0 35.3-28.7 64-64 64c-7.1 0-13.9-1.2-20.3-3.3c-5.5-1.8-11.9 1.6-11.7 7.4c.3 6.9 1.3 13.8 3.2 20.7c13.7 51.2 66.4 81.6 117.6 67.9s81.6-66.4 67.9-117.6c-11.1-41.5-47.8-69.4-88.6-71.1c-5.8-.2-9.2 6.1-7.4 11.7c2.1 6.4 3.3 13.2 3.3 20.3z'
    };

    // Utility Functions
    function showRegisterFieldError(field, errorElement, message) {
        field.classList.add('error');
        field.classList.remove('success');
        errorElement.textContent = message;
        errorElement.classList.add('show');
    }

    function showRegisterFieldSuccess(field, errorElement) {
        field.classList.add('success');
        field.classList.remove('error');
        errorElement.textContent = '';
        errorElement.classList.remove('show');
    }

    function clearRegisterFieldError(field, errorElement) {
        field.classList.remove('error');
        errorElement.textContent = '';
        errorElement.classList.remove('show');
    }

    // Validation Functions
    function validateRegisterField(fieldName, value) {
        const rules = VALIDATION_RULES[fieldName];

        if (!value.trim()) return false;

        if (rules?.minLength && value.length < rules.minLength) return false;
        if (rules?.pattern && !rules.pattern.test(value.replace(/\s/g, ''))) return false;

        return true;
    }

    function validateRegisterConfirmPassword(password, confirmPassword) {
        return password === confirmPassword && confirmPassword.length > 0;
    }

    function performRegisterFieldValidation(fieldName) {
        const field = inputs[fieldName];
        const errorElement = errors[fieldName];
        const value = field.value.trim();
        const messages = ERROR_MESSAGES[fieldName];

        if (!value) {
            showRegisterFieldError(field, errorElement, messages.empty);
            return false;
        }

        if (fieldName === 'confirmPassword') {
            const isValid = validateRegisterConfirmPassword(inputs.password.value, value);
            if (!isValid) {
                showRegisterFieldError(field, errorElement, messages.invalid);
                return false;
            }
        } else {
            const isValid = validateRegisterField(fieldName, value);
            if (!isValid) {
                showRegisterFieldError(field, errorElement, messages.invalid);
                return false;
            }
        }

        showRegisterFieldSuccess(field, errorElement);
        return true;
    }

    function updateRegisterSubmitButton() {
        const isEnabled = inputs.terms.checked;
        if (buttons.submit) {
            buttons.submit.disabled = !isEnabled;
            buttons.submit.classList.toggle('enabled', isEnabled);
        }
    }

    // Password Toggle Functions
    function setupRegisterPasswordToggle(toggleButton, passwordInput) {
        if (!toggleButton || !passwordInput) return;

        toggleButton.addEventListener('click', function () {
            const isPassword = passwordInput.type === 'password';
            passwordInput.type = isPassword ? 'text' : 'password';

            const icon = toggleButton.querySelector('.eye-icon');
            if (icon) {
                // Khi type="password" (ẩn) → hiển thị eye-slash (mắt có gạch)
                // Khi type="text" (hiện) → hiển thị eye (mắt bình thường)
                icon.innerHTML = `<path fill="currentColor" d="${isPassword ? EYE_ICONS.open : EYE_ICONS.closed}"/>`;
            }

            // Cập nhật aria-label
            const label = isPassword ? 'Ẩn mật khẩu' : 'Hiện mật khẩu';
            toggleButton.setAttribute('aria-label', label);
        });
    }

    // Event Listeners Setup
    function setupRegisterEventListeners() {
        // Field validation on blur
        Object.keys(inputs).slice(0, -1).forEach(fieldName => {
            if (inputs[fieldName]) {
                inputs[fieldName].addEventListener('blur', function () {
                    performRegisterFieldValidation(fieldName);
                    updateRegisterSubmitButton();
                });

                inputs[fieldName].addEventListener('input', function () {
                    if (this.classList.contains('error')) {
                        clearRegisterFieldError(this, errors[fieldName]);
                    }
                });
            }
        });

        // Special handling for password field to revalidate confirm password
        if (inputs.password) {
            inputs.password.addEventListener('blur', function () {
                performRegisterFieldValidation('password');
                if (inputs.confirmPassword.value) {
                    performRegisterFieldValidation('confirmPassword');
                }
                updateRegisterSubmitButton();
            });
        }

        // Terms checkbox
        if (inputs.terms) {
            inputs.terms.addEventListener('change', function () {
                if (!this.checked) {
                    errors.terms.textContent = ERROR_MESSAGES.terms;
                    errors.terms.classList.add('show');
                    buttons.submit.classList.remove('enabled');
                } else {
                    errors.terms.textContent = '';
                    errors.terms.classList.remove('show');
                    buttons.submit.classList.add('enabled');
                }
                updateRegisterSubmitButton();
            });
        }

        // Form submission
        registerForm.addEventListener('submit', submitRegisterForm);

        // Realtime check khi blur hoặc input email/phone
        let lastCheckedEmail = '';
        let lastCheckedPhone = '';
        let lastEmailExists = false;
        let lastPhoneExists = false;

        // Đảm bảo luôn gọi checkExistsRealtime khi nhập hoặc blur email/phone
        function checkEmailRealtime() {
            const email = inputs.email.value.trim();
            const errorEl = errors.email;
            if (email && /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
                checkExistsRealtime('email', email, function(exists) {
                    if (exists) {
                        errorEl.textContent = 'Email đã tồn tại, vui lòng dùng email khác';
                        errorEl.classList.add('show');
                        inputs.email.classList.add('error');
                    } else {
                        errorEl.textContent = '';
                        errorEl.classList.remove('show');
                        inputs.email.classList.remove('error');
                    }
                });
            } else {
                errorEl.textContent = '';
                errorEl.classList.remove('show');
                inputs.email.classList.remove('error');
            }
        }

        function checkPhoneRealtime() {
            const phone = inputs.phone.value.trim();
            const errorEl = errors.phone;
            if (phone && /^\d{10,11}$/.test(phone)) {
                checkExistsRealtime('phone', phone, function(exists) {
                    if (exists) {
                        errorEl.textContent = 'Số điện thoại đã tồn tại, vui lòng dùng số khác';
                        errorEl.classList.add('show');
                        inputs.phone.classList.add('error');
                    } else {
                        errorEl.textContent = '';
                        errorEl.classList.remove('show');
                        inputs.phone.classList.remove('error');
                    }
                });
            } else {
                errorEl.textContent = '';
                errorEl.classList.remove('show');
                inputs.phone.classList.remove('error');
            }
        }

        // Gắn realtime check cho cả blur và input (luôn check khi nhập)
        inputs.email.addEventListener('input', checkEmailRealtime);
        inputs.email.addEventListener('blur', checkEmailRealtime);
        inputs.phone.addEventListener('input', checkPhoneRealtime);
        inputs.phone.addEventListener('blur', checkPhoneRealtime);

        // Navigation
        if (buttons.login) {
            buttons.login.addEventListener('click', function (e) {
                e.preventDefault();
                closeRegister();
                openLogin();
            });
        }

        if (buttons.google) {
            buttons.google.addEventListener('click', function () {
                console.log('Google register clicked');
                showSuccess('Đăng ký bằng Google thành công!');
            });
        }
    }

    // Initialize
    function initRegister() {
        setupRegisterPasswordToggle(passwordToggles.password, inputs.password);
        setupRegisterPasswordToggle(passwordToggles.confirmPassword, inputs.confirmPassword);

        // ESC key để đóng modal
        document.addEventListener('keydown', function (e) {
            if (e.key === 'Escape') {
                const registerOverlay = document.getElementById('registerOverlay');
                if (registerOverlay && registerOverlay.classList.contains('active')) {
                    closeRegister();
                }
            }
        });

        // Click overlay để đóng modal
        const registerOverlay = document.getElementById('registerOverlay');
        if (registerOverlay) {
            registerOverlay.addEventListener('click', function (e) {
                if (e.target === registerOverlay) {
                    closeRegister();
                }
            });
        }
    }

    setupRegisterEventListeners();
    initRegister();
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
        z-index: 1001;
        animation: slideIn 0.3s ease-out;
    `;
    notification.textContent = message;
    document.body.appendChild(notification);

    setTimeout(() => {
        notification.remove();
    }, 3000);
}

// Initialize when DOM is loaded
document.addEventListener('DOMContentLoaded', function () {
    initRegisterFunctionality();
});

