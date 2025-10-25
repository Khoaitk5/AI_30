function openRegister() {
    const loginOverlay = document.getElementById('loginOverlay');
    if (loginOverlay && loginOverlay.classList.contains('active')) {
        window._closeLoginCallback = function() {
            const registerOverlay = document.getElementById('registerOverlay');
            if (registerOverlay) {
                registerOverlay.classList.add('active');
                registerOverlay.style.display = 'flex'; // Ensure visibility
            }
        };
        closeLogin();
    } else {
        const registerOverlay = document.getElementById('registerOverlay');
        if (registerOverlay) {
            registerOverlay.classList.add('active');
            registerOverlay.style.display = 'flex'; // Ensure visibility
        }
    }
}

function openLogin() {
    const loginOverlay = document.getElementById('loginOverlay');
    if (loginOverlay) {
        loginOverlay.classList.add('active');
        loginOverlay.style.display = 'flex'; // Ensure visibility
        const loginForm = document.getElementById('loginForm');
        if (loginForm) {
            var pathArr = window.location.pathname.split('/');
            var contextPath = '';
            if (pathArr.length > 1 && pathArr[1]) {
                contextPath = '/' + pathArr[1];
            } else {
                contextPath = '';
            }
            // Không thay đổi action của form bằng JS nữa
            if (!loginForm.querySelector('input[name="action"]')) {
                var actionInput = document.createElement('input');
                actionInput.type = 'hidden';
                actionInput.name = 'action';
                actionInput.value = 'login';
                loginForm.appendChild(actionInput);
            }
        }
    }
}

function closeLogin() {
    const loginOverlay = document.getElementById('loginOverlay');
    if (loginOverlay) {
        loginOverlay.classList.remove('active');
        setTimeout(() => {
            loginOverlay.style.display = 'none';
            resetLoginForm();
            if (window.location.pathname.endsWith('/login')) {
                var contextPath = '/' + window.location.pathname.split('/')[1];
                var homeUrl = contextPath + '/home/index.jsp';
                window.history.replaceState({}, '', homeUrl);
            }
            // Execute callback if present
            if (typeof window._closeLoginCallback === 'function') {
                const cb = window._closeLoginCallback;
                window._closeLoginCallback = null;
                cb();
            }
        }, 300); // Match CSS transition duration
    }
}

function closeRegister() {
    const registerOverlay = document.getElementById('registerOverlay');
    if (registerOverlay) {
        registerOverlay.classList.remove('active');
        setTimeout(() => {
            registerOverlay.style.display = 'none';
            if (typeof resetRegisterForm === 'function') resetRegisterForm();
        }, 300); // Match CSS transition duration
    }
}

function resetLoginForm() {
    const loginForm = document.getElementById('loginForm');
    const passwordInput = document.getElementById('passwordLogin');
    const passwordToggle = document.getElementById('togglePasswordLogin');

    if (loginForm) {
        loginForm.reset();
    }

    document.querySelectorAll('#loginForm .error-message').forEach(error => {
        error.textContent = '';
        error.classList.remove('show');
    });

    document.querySelectorAll('#loginForm .form-input, #loginForm .field-input').forEach(input => {
        input.classList.remove('error', 'success');
    });

    if (passwordInput) {
        passwordInput.type = 'password';
    }

    if (passwordToggle) {
        const icon = passwordToggle.querySelector('.eye-icon path');
        if (icon) {
            const eyeSlashPath = 'M38.8 5.1C28.4-3.1 13.3-1.2 5.1 9.2S-1.2 34.7 9.2 42.9l592 464c10.4 8.2 25.5 6.3 33.7-4.1s6.3-25.5-4.1-33.7L525.6 386.7c39.6-40.6 66.4-86.1 79.9-118.4c3.3-7.9 3.3-16.7 0-24.6c-14.9-35.7-46.2-87.7-93-131.1C465.5 68.8 400.8 32 320 32c-68.2 0-125 26.3-169.3 60.8L38.8 5.1zM223.1 149.5C248.6 126.2 282.7 112 320 112c79.5 0 144 64.5 144 144c0 24.9-6.3 48.3-17.4 68.7L408 294.5c8.4-19.3 10.6-41.4 4.8-63.3c-11.1-41.5-47.8-69.4-88.6-71.1c-5.8-.2-9.2 6.1-7.4 11.7c2.1 6.4 3.3 13.2 3.3 20.3c0 10.2-2.4 19.8-6.6 28.3l-90.3-70.8zM373 389.9c-16.4 6.5-34.3 10.1-53 10.1c-79.5 0-144-64.5-144-144c0-6.9 .5-13.6 1.4-20.2L83.1 161.5C60.3 191.2 44 220.8 34.5 243.7c-3.3 7.9-3.3 16.7 0 24.6c14.9 35.7 46.2 87.7 93 131.1C174.5 443.2 239.2 480 320 480c47.8 0 89.9-12.9 126.2-32.5L373 389.9z';
            icon.setAttribute('d', eyeSlashPath);
        }
        passwordToggle.setAttribute('aria-label', 'Hiện mật khẩu');
    }

    setLoading(false);
}

function initLoginFunctionality() {
    const loginForm = document.getElementById('loginForm');
    const loginIdentifierInput = document.getElementById('loginIdentifier');
    const passwordInput = document.getElementById('passwordLogin');
    const passwordToggle = document.getElementById('togglePasswordLogin');
    const goToRegisterBtn = document.getElementById('goToRegister');
    const goToForgotPasswordBtn = document.getElementById('goToForgotPassword');
    const loginOverlay = document.getElementById('loginOverlay');

    if (!loginForm || !loginOverlay) return;

    const EYE_ICONS = {
        closed: 'M38.8 5.1C28.4-3.1 13.3-1.2 5.1 9.2S-1.2 34.7 9.2 42.9l592 464c10.4 8.2 25.5 6.3 33.7-4.1s6.3-25.5-4.1-33.7L525.6 386.7c39.6-40.6 66.4-86.1 79.9-118.4c3.3-7.9 3.3-16.7 0-24.6c-14.9-35.7-46.2-87.7-93-131.1C465.5 68.8 400.8 32 320 32c-68.2 0-125 26.3-169.3 60.8L38.8 5.1zM223.1 149.5C248.6 126.2 282.7 112 320 112c79.5 0 144 64.5 144 144c0 24.9-6.3 48.3-17.4 68.7L408 294.5c8.4-19.3 10.6-41.4 4.8-63.3c-11.1-41.5-47.8-69.4-88.6-71.1c-5.8-.2-9.2 6.1-7.4 11.7c2.1 6.4 3.3 13.2 3.3 20.3c0 10.2-2.4 19.8-6.6 28.3l-90.3-70.8zM373 389.9c-16.4 6.5-34.3 10.1-53 10.1c-79.5 0-144-64.5-144-144c0-6.9 .5-13.6 1.4-20.2L83.1 161.5C60.3 191.2 44 220.8 34.5 243.7c-3.3 7.9-3.3 16.7 0 24.6c14.9 35.7 46.2 87.7 93 131.1C174.5 443.2 239.2 480 320 480c47.8 0 89.9-12.9 126.2-32.5L373 389.9z',
        open: 'M288 32c-80.8 0-145.5 36.8-192.6 80.6C48.6 156 17.3 208 2.5 243.7c-3.3 7.9-3.3 16.7 0 24.6C17.3 304 48.6 356 95.4 399.4C142.5 443.2 207.2 480 288 480s145.5-36.8 192.6-80.6c46.8-43.5 78.1-95.4 93-131.1c3.3-7.9 3.3-16.7 0-24.6c-14.9-35.7-46.2-87.7-93-131.1C433.5 68.8 368.8 32 288 32zM144 256a144 144 0 1 1 288 0 144 144 0 1 1 -288 0zm144-64c0 35.3-28.7 64-64 64c-7.1 0-13.9-1.2-20.3-3.3c-5.5-1.8-11.9 1.6-11.7 7.4c.3 6.9 1.3 13.8 3.2 20.7c13.7 51.2 66.4 81.6 117.6 67.9s81.6-66.4 67.9-117.6c-11.1-41.5-47.8-69.4-88.6-71.1c-5.8-.2-9.2 6.1-7.4 11.7c2.1 6.4 3.3 13.2 3.3 20.3z'
    };

    if (passwordToggle && passwordInput) {
        passwordToggle.onclick = function (e) {
            e.preventDefault();
            const isPassword = passwordInput.type === 'password';
            passwordInput.type = isPassword ? 'text' : 'password';
            const icon = passwordToggle.querySelector('.eye-icon path');
            if (icon) {
                icon.setAttribute('d', isPassword ? EYE_ICONS.open : EYE_ICONS.closed);
            }
            passwordToggle.setAttribute('aria-label', isPassword ? 'Ẩn mật khẩu' : 'Hiện mật khẩu');
        };
    }

    if (goToRegisterBtn) {
        goToRegisterBtn.addEventListener('click', function (e) {
            e.preventDefault();
            window._closeLoginCallback = function() {
                if (typeof openRegister === 'function') openRegister();
            };
            closeLogin();
        });
    }

    if (goToForgotPasswordBtn) {
        goToForgotPasswordBtn.addEventListener('click', function (e) {
            e.preventDefault();
            window._closeLoginCallback = function() {
                if (typeof openPassword === 'function') openPassword();
            };
            closeLogin();
        });
    }

    if (loginOverlay) {
        loginOverlay.addEventListener('keydown', function (e) {
            if (e.key === 'Escape' && loginOverlay.classList.contains('active')) {
                closeLogin();
            }
        });

        loginOverlay.addEventListener('click', function (e) {
            if (e.target === loginOverlay) {
                closeLogin();
            }
        });
    }
}

function showErrorGlobal(message) {
    // Hiển thị lỗi chung ở dưới title
    let formSection = document.querySelector('.form-section');
    if (!formSection) return;
    let globalError = formSection.querySelector('.error-message.global');
    if (!globalError) {
        globalError = document.createElement('div');
        globalError.className = 'error-message show global';
        globalError.style.color = '#dc2626';
        globalError.style.textAlign = 'center';
        globalError.style.marginBottom = '8px';
        // Đặt ngay sau tiêu đề
        let title = formSection.querySelector('.form-title');
        if (title && title.nextSibling) {
            formSection.insertBefore(globalError, title.nextSibling);
        } else {
            formSection.prepend(globalError);
        }
    }
    globalError.textContent = message;
    globalError.style.display = 'block';
}

function clearErrorGlobal() {
    let formSection = document.querySelector('.form-section');
    if (!formSection) return;
    let globalError = formSection.querySelector('.error-message.global');
    if (globalError) {
        globalError.textContent = '';
        globalError.style.display = 'none';
    }
}

function isValidEmail(email) {
    return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
}

function setLoading(isLoading) {
    const form = document.getElementById('loginForm');
    const submitBtn = form?.querySelector('.btn-primary');

    if (submitBtn) {
        if (isLoading) {
            form.classList.add('loading');
            submitBtn.disabled = true;
            submitBtn.innerHTML = '<span class="spinner"></span>Đang đăng nhập...';
        } else {
            form.classList.remove('loading');
            submitBtn.disabled = false;
            submitBtn.innerHTML = 'Đăng nhập';
        }
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
    setTimeout(() => notification.remove(), 3000);
}

document.addEventListener('DOMContentLoaded', function () {
    initLoginFunctionality();
    // AJAX login submit
    const loginForm = document.getElementById('loginForm');
    if (loginForm) {
        loginForm.addEventListener('submit', function (e) {
            e.preventDefault();
            // Clear previous errors
            clearErrorGlobal();

            // Xác định lại loginType trước khi submit
            var identifier = document.getElementById('loginIdentifier').value.trim();
            var loginType = 'customer';
            if (/^[a-zA-Z0-9._-]{3,}$/.test(identifier) && !identifier.includes('@') && !/^\d{10,11}$/.test(identifier)) {
                loginType = 'admin';
            }
            document.getElementById('loginType').value = loginType;

            setLoading(true);
            const formData = new FormData(loginForm);
            // Chuyển FormData sang URLSearchParams để gửi dạng application/x-www-form-urlencoded
            const params = new URLSearchParams();
            for (let [key, value] of formData.entries()) {
                params.append(key, value);
                console.log('FormData:', key, value); // Debug log
            }
            const fetchUrl = loginForm.getAttribute('action');
            console.log('Fetch URL:', fetchUrl);
            fetch(fetchUrl, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
                },
                body: params.toString()
            })
            .then(res => res.json())
            .then(data => {
                setLoading(false);
                if (data.errorMessage) {
                    // Luôn hiển thị lỗi chung ở dưới title
                    showErrorGlobal(data.errorMessage);
                } else if (data.redirectUrl) {
                    window.location.href = data.redirectUrl;
                }
            })
            .catch(() => {
                setLoading(false);
                showErrorGlobal('Đã xảy ra lỗi hệ thống.');
            });
        });
    }
});