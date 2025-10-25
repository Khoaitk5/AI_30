<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>TVT Future - Dịch Vụ Cho Thuê Xe Linh Hoạt</title>
        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css2?family=Tektur:wght@400;500;600;700&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Mulish:ital,wght@0,200..1000;1,200..1000&display=swap"
              rel="stylesheet">
        <!-- Tailwind CSS CDN -->
        <script src="https://cdn.tailwindcss.com"></script>
        <!-- Custom CSS -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/home/home.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/footer/footer.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/header/header.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/login/login.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/password/password.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/register/register.css">
        <link rel="shortcut icon" href="${pageContext.request.contextPath}/asset/images/logo_gf_black.svg">
    </head>
    <body>
        <!-- Header -->
        <div id="header-container"></div>

        <!-- Main Content -->
        <main>
            <!-- Hero Banner -->
            <section class="hero-banner" style="background-image: url('${pageContext.request.contextPath}/asset/images/desktop_1920.jpg');">
                <div class="hero-content">
                    <h1 class="hero-title">
                        Đáp ứng mọi nhu cầu<br>thuê xe
                    </h1>
                    <p class="hero-subtitle">
                        Cung cấp dịch vụ thuê xe tự lái, phục vụ mọi nhu cầu di chuyển của bạn tại Đà Nẵng
                    </p>
                </div>
            </section>

            <!-- Rental Cars Section -->
            <section id="rental-cars">
                <div class="cars-container">
                    <div class="cars-header">
                        <p class="cars-title">Thuê xe tự lái</p>
                        <p class="cars-desc">Dịch vụ thuê xe tự lái chuyên nghiệp – linh hoạt theo ngày / tháng, đáp ứng
                            mọi nhu cầu di chuyển cá nhân.</p>
                        <a class="cars-link" href="${pageContext.request.contextPath}/rental/rental.jsp">
                            <button class="cars-detail-btn">Xem chi tiết</button>
                        </a>
                    </div>
                    <div class="cars-carousel-wrap">
                        <div class="cars-carousel">
                            <!-- VF3 Card -->
                            <div class="cars-slide" data-car="vf3">
                                <a class="cars-card-link" href="${pageContext.request.contextPath}/rental/rental.jsp">
                                    <div class="cars-card">
                                        <div class="cars-badge">
                                            <img alt="" loading="lazy" width="17px" height="16px"
                                                 src="${pageContext.request.contextPath}/asset/images/battery_dk.svg">
                                            <p class="cars-badge-text">Miễn phí sạc</p>
                                        </div>
                                        <p class="cars-name">VinFast VF 3</p>
                                        <img alt="VF3" loading="lazy" class="cars-img" src="${pageContext.request.contextPath}/asset/images/vf3_mb.webp">
                                        <div class="cars-specs">
                                            <div class="cars-spec-group1">
                                                <div class="cars-spec-item">
                                                    <img alt="" loading="lazy" width="20px" height="20px"
                                                         src="${pageContext.request.contextPath}/asset/images/car_dk.svg">
                                                    <p class="cars-spec-text">Minicar</p>
                                                </div>
                                                <div class="cars-spec-item">
                                                    <img alt="" loading="lazy" width="20px" height="20px"
                                                         src="${pageContext.request.contextPath}/asset/images/2user_dk.svg">
                                                    <p class="cars-spec-text">4 chỗ</p>
                                                </div>
                                            </div>
                                            <div class="cars-spec-group2">
                                                <div class="cars-spec-item">
                                                    <img alt="" loading="lazy" width="20px" height="20px"
                                                         src="${pageContext.request.contextPath}/asset/images/battery_footer.svg">
                                                    <p class="cars-spec-text">210km (NEDC)</p>
                                                </div>
                                                <div class="cars-spec-item">
                                                    <img alt="" loading="lazy" width="20px" height="20px"
                                                         src="${pageContext.request.contextPath}/asset/images/box_dk.svg">
                                                    <p class="cars-spec-text">Dung tích cốp 285L</p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </div>
                            <!-- VF6 Card -->
                            <div class="cars-slide" data-car="vf6">
                                <a class="cars-card-link" href="${pageContext.request.contextPath}/rental/rental.jsp">
                                    <div class="cars-card">
                                        <div class="cars-badge">
                                            <img alt="" loading="lazy" width="17px" height="16px"
                                                 src="${pageContext.request.contextPath}/asset/images/battery_dk.svg">
                                            <p class="cars-badge-text">Miễn phí sạc</p>
                                        </div>
                                        <p class="cars-name">VinFast VF 6</p>
                                        <img alt="VF6" loading="lazy" class="cars-img" src="${pageContext.request.contextPath}/asset/images/vf6_mb.webp">
                                        <div class="cars-specs">
                                            <div class="cars-spec-group1">
                                                <div class="cars-spec-item">
                                                    <img alt="" loading="lazy" width="20px" height="20px"
                                                         src="${pageContext.request.contextPath}/asset/images/car_dk.svg">
                                                    <p class="cars-spec-text">B-SUV</p>
                                                </div>
                                                <div class="cars-spec-item">
                                                    <img alt="" loading="lazy" width="20px" height="20px"
                                                         src="${pageContext.request.contextPath}/asset/images/2user_dk.svg">
                                                    <p class="cars-spec-text">5 chỗ</p>
                                                </div>
                                            </div>
                                            <div class="cars-spec-group2">
                                                <div class="cars-spec-item">
                                                    <img alt="" loading="lazy" width="20px" height="20px"
                                                         src="${pageContext.request.contextPath}/asset/images/battery_footer.svg">
                                                    <p class="cars-spec-text">~480km (NEDC)</p>
                                                </div>
                                                <div class="cars-spec-item">
                                                    <img alt="" loading="lazy" width="20px" height="20px"
                                                         src="${pageContext.request.contextPath}/asset/images/box_dk.svg">
                                                    <p class="cars-spec-text">Dung tích cốp 423L</p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </div>
                            <!-- VF7 Card -->
                            <div class="cars-slide" data-car="vf7">
                                <a class="cars-card-link" href="${pageContext.request.contextPath}/rental/rental.jsp">
                                    <div class="cars-card">
                                        <div class="cars-badge">
                                            <img alt="" loading="lazy" width="17px" height="16px"
                                                 src="${pageContext.request.contextPath}/asset/images/battery_dk.svg">
                                            <p class="cars-badge-text">Miễn phí sạc</p>
                                        </div>
                                        <p class="cars-name">VinFast VF 7</p>
                                        <img alt="VF7" loading="lazy" class="cars-img" src="${pageContext.request.contextPath}/asset/images/vf7_mb.webp">
                                        <div class="cars-specs">
                                            <div class="cars-spec-group1">
                                                <div class="cars-spec-item">
                                                    <img alt="" loading="lazy" width="20px" height="20px"
                                                         src="${pageContext.request.contextPath}/asset/images/car_dk.svg">
                                                    <p class="cars-spec-text">C-SUV</p>
                                                </div>
                                                <div class="cars-spec-item">
                                                    <img alt="" loading="lazy" width="20px" height="20px"
                                                         src="${pageContext.request.contextPath}/asset/images/2user_dk.svg">
                                                    <p class="cars-spec-text">5 chỗ</p>
                                                </div>
                                            </div>
                                            <div class="cars-spec-group2">
                                                <div class="cars-spec-item">
                                                    <img alt="" loading="lazy" width="20px" height="20px"
                                                         src="${pageContext.request.contextPath}/asset/images/battery_footer.svg">
                                                    <p class="cars-spec-text">~498km (NEDC)</p>
                                                </div>
                                                <div class="cars-spec-item">
                                                    <img alt="" loading="lazy" width="20px" height="20px"
                                                         src="${pageContext.request.contextPath}/asset/images/box_dk.svg">
                                                    <p class="cars-spec-text">Dung tích cốp 537L</p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </div>
                            <!-- VF8 Card -->
                            <div class="cars-slide" data-car="vf8">
                                <a class="cars-card-link" href="${pageContext.request.contextPath}/rental/rental.jsp">
                                    <div class="cars-card">
                                        <div class="cars-badge">
                                            <img alt="" loading="lazy" width="17px" height="16px"
                                                 src="${pageContext.request.contextPath}/asset/images/battery_dk.svg">
                                            <p class="cars-badge-text">Miễn phí sạc</p>
                                        </div>
                                        <p class="cars-name">VinFast VF 8</p>
                                        <img alt="VF8" loading="lazy" class="cars-img" src="${pageContext.request.contextPath}/asset/images/vf8.webp">
                                        <div class="cars-specs">
                                            <div class="cars-spec-group1">
                                                <div class="cars-spec-item">
                                                    <img alt="" loading="lazy" width="20px" height="20px"
                                                         src="${pageContext.request.contextPath}/asset/images/car_dk.svg">
                                                    <p class="cars-spec-text">D-SUV</p>
                                                </div>
                                                <div class="cars-spec-item">
                                                    <img alt="" loading="lazy" width="20px" height="20px"
                                                         src="${pageContext.request.contextPath}/asset/images/2user_dk.svg">
                                                    <p class="cars-spec-text">5 chỗ</p>
                                                </div>
                                            </div>
                                            <div class="cars-spec-group2">
                                                <div class="cars-spec-item">
                                                    <img alt="" loading="lazy" width="20px" height="20px"
                                                         src="${pageContext.request.contextPath}/asset/images/battery_footer.svg">
                                                    <p class="cars-spec-text">~562km (NEDC)</p>
                                                </div>
                                                <div class="cars-spec-item">
                                                    <img alt="" loading="lazy" width="20px" height="20px"
                                                         src="${pageContext.request.contextPath}/asset/images/box_dk.svg">
                                                    <p class="cars-spec-text">Dung tích cốp 350L</p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </div>
                            <!-- VF9 Card -->
                            <div class="cars-slide" data-car="vf9">
                                <a class="cars-card-link" href="${pageContext.request.contextPath}/rental/rental.jsp">
                                    <div class="cars-card">
                                        <div class="cars-badge">
                                            <img alt="" loading="lazy" width="17px" height="16px"
                                                 src="${pageContext.request.contextPath}/asset/images/battery_dk.svg">
                                            <p class="cars-badge-text">Miễn phí sạc</p>
                                        </div>
                                        <p class="cars-name">VinFast VF 9</p>
                                        <img alt="VF9" loading="lazy" class="cars-img" src="${pageContext.request.contextPath}/asset/images/vf9_mb.webp">
                                        <div class="cars-specs">
                                            <div class="cars-spec-group1">
                                                <div class="cars-spec-item">
                                                    <img alt="" loading="lazy" width="20px" height="20px"
                                                         src="${pageContext.request.contextPath}/asset/images/car_dk.svg">
                                                    <p class="cars-spec-text">E-SUV</p>
                                                </div>
                                                <div class="cars-spec-item">
                                                    <img alt="" loading="lazy" width="20px" height="20px"
                                                         src="${pageContext.request.contextPath}/asset/images/2user_dk.svg">
                                                    <p class="cars-spec-text">6-7 chỗ</p>
                                                </div>
                                            </div>
                                            <div class="cars-spec-group2">
                                                <div class="cars-spec-item">
                                                    <img alt="" loading="lazy" width="20px" height="20px"
                                                         src="${pageContext.request.contextPath}/asset/images/battery_footer.svg">
                                                    <p class="cars-spec-text">~626km (WLTP)</p>
                                                </div>
                                                <div class="cars-spec-item">
                                                    <img alt="" loading="lazy" width="20px" height="20px"
                                                         src="${pageContext.request.contextPath}/asset/images/box_dk.svg">
                                                    <p class="cars-spec-text">Dung tích cốp 212L</p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </div>
                        </div>
                        <div class="cars-controls">
                            <div class="cars-dots">
                                <button type="button" class="cars-dot cars-dot--active"></button>
                                <button type="button" class="cars-dot"></button>
                                <button type="button" class="cars-dot"></button>
                                <button type="button" class="cars-dot"></button>
                                <button type="button" class="cars-dot"></button>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Footer -->
            <div id="footer-container"></div>
        </main>

        <!-- JavaScript -->
        <script src="${pageContext.request.contextPath}/home/home.js"></script>
        <script src="${pageContext.request.contextPath}/login/login.js"></script>
        <script src="${pageContext.request.contextPath}/password/password.js"></script>
        <script src="${pageContext.request.contextPath}/register/register.js"></script>
        <script>
            // Tải footer
            fetch('${pageContext.request.contextPath}/footer/footer.jsp')
                    .then(response => response.text())
                    .then(data => {
                        document.getElementById('footer-container').innerHTML = data;
                    });

            // Tải header
            fetch('${pageContext.request.contextPath}/header/header.jsp')
                    .then(response => response.text())
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
                        document.body.appendChild(script);
                    });

            // Xử lý submit form đăng nhập qua AJAX
            // Đã loại bỏ xử lý submit form đăng nhập qua AJAX để form submit mặc định về servlet

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
            <% }%>
        </script>

        <!-- Login Modal -->
        <jsp:include page="/login/login.jsp" />

        <!-- Password Reset Modal -->
        <div id="password-container"></div>
        <script>
            fetch('${pageContext.request.contextPath}/password/password.jsp')
                    .then(response => response.text())
                    .then(data => {
                        document.getElementById('password-container').innerHTML = data;
                        if (typeof initPasswordFunctionality === 'function') {
                            initPasswordFunctionality();
                        }
                    });
        </script>

        <!-- Register Modal -->
        <div id="register-container"></div>
        <script>
            fetch('${pageContext.request.contextPath}/register/register.jsp')
                    .then(response => response.text())
                    .then(data => {
                        document.getElementById('register-container').innerHTML = data;
                        if (typeof initRegisterFunctionality === 'function') {
                            initRegisterFunctionality();
                        }
                    });
        </script>
    </body>
</html>
