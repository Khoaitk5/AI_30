<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cho thuê xe điện</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/rental/vf8e/vf8e.css">
    <link href="https://fonts.googleapis.com/css2?family=Mulish:ital,wght@0,200..1000;1,200..1000&display=swap" rel="stylesheet" charset="UTF-8">
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/footer/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/header/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/rental/modal-new/modal.css">
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/asset/images/logo_gf_black.svg">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="${pageContext.request.contextPath}/rental/modal-new/rental-modal-handler.js"></script>
</head>
<body>
    <%@include file="../../login/login.jsp" %>
    <%@include file="../../register/register.jsp" %>
    <%@include file="../../password/password.jsp" %>
    <%@include file="../../header/header.jsp" %>
    <main class="main">
        <section class="car-gallery">
            <div class="gallery-main">
                <img src="${pageContext.request.contextPath}/asset/images/vf8eco01.webp" alt="VinFast VF 8 Eco" class="gallery-img">
            </div>
            <div class="embla__buttons">
                <button class="embla__button embla__button--prev" type="button" disabled="">
                    <svg width="32" height="32" viewBox="0 0 32 32" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <rect width="32" height="32" rx="16" fill="#0B0A0A" fill-opacity="0.2"></rect>
                        <path d="M18.3544 21.853C18.1594 22.0486 17.8429 22.0492 17.6472 21.8542L12.1628 16.3893C11.947 16.1743 11.947 15.825 12.1628 15.6101L17.6472 10.1451C17.8429 9.95017 18.1594 9.95074 18.3544 10.1463C18.5493 10.342 18.5487 10.6585 18.3531 10.8535L13.1885 15.9997L18.3531 21.1459C18.5487 21.3408 18.5493 21.6574 18.3544 21.853Z" fill="white"></path>
                    </svg>
                </button>
                <button class="embla__button embla__button--next" type="button">
                    <svg width="32" height="32" viewBox="0 0 32 32" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <rect width="32" height="32" rx="16" transform="matrix(-1 0 0 1 32 0)" fill="#0B0A0A" fill-opacity="0.2"></rect>
                        <path d="M13.6456 21.853C13.8406 22.0486 14.1571 22.0492 14.3528 21.8542L19.8372 16.3893C20.053 16.1743 20.053 15.825 19.8372 15.6101L14.3528 10.1451C14.1571 9.95017 13.8406 9.95074 13.6456 10.1463C13.4507 10.342 13.4513 10.6585 13.6469 10.8535L18.8115 15.9997L13.6469 21.1459C13.4513 21.3408 13.4507 21.6574 13.6456 21.853Z" fill="white"></path>
                    </svg>
                </button>
            </div>
            <div class="gallery-thumbs">
                <img src="${pageContext.request.contextPath}/asset/images/vf8eco01.webp" alt="thumb1" class="thumb">
                <img src="${pageContext.request.contextPath}/asset/images/vf8eco02.webp" alt="thumb2" class="thumb">
                <img src="${pageContext.request.contextPath}/asset/images/vf8eco03.webp" alt="thumb3" class="thumb">
                <img src="${pageContext.request.contextPath}/asset/images/vf8eco04.webp" alt="thumb4" class="thumb">
                <img src="${pageContext.request.contextPath}/asset/images/vf8eco05.webp" alt="thumb5" class="thumb">
                <img src="${pageContext.request.contextPath}/asset/images/vf8eco06.webp" alt="thumb6" class="thumb">
                <img src="${pageContext.request.contextPath}/asset/images/vf8eco07.webp" alt="thumb7" class="thumb">
                <img src="${pageContext.request.contextPath}/asset/images/vf8eco08.webp" alt="thumb8" class="thumb">
            </div>
        </section>
        <section class="car-inf">
            <h1 class="car-title">VinFast VF 8 Eco</h1>
            <div class="car-price">
                <div class="price">1.700.000</div>
                <div class="unit">VNĐ/Ngày</div>
            </div>
            <div class="car-hint">Miễn phí sạc tới 31/12/2027</div>
            <div class="box_row">
                <div class="utilities-box">
                    <div class="main-feature">
                        <div class="item">
                            <div class="icon"><img src="${pageContext.request.contextPath}/asset/images/no_of_seat.svg"></div>
                            <div class="content">5 chỗ</div>
                        </div>
                        <div class="item">
                            <div class="icon"><img src="${pageContext.request.contextPath}/asset/images/range_per_charge.svg"></div>
                            <div class="content">471km (NEDC)</div>
                        </div>
                        <div class="item">
                            <div class="icon"><img src="${pageContext.request.contextPath}/asset/images/transmission.svg"></div>
                            <div class="content">Số tự động</div>
                        </div>
                        <div class="item">
                            <div class="icon"><img src="${pageContext.request.contextPath}/asset/images/airbag.svg"></div>
                            <div class="content">11 túi khí</div>
                        </div>
                        <div class="item">
                            <div class="icon"><img src="${pageContext.request.contextPath}/asset/images/max_power.svg"></div>
                            <div class="content">350 HP</div>
                        </div>
                        <div class="item">
                            <div class="icon"><img src="${pageContext.request.contextPath}/asset/images/wheel_drive.svg"></div>
                            <div class="content">AWD/2 cầu toàn thời gian</div>
                        </div>
                        <div class="item">
                            <div class="icon"><img src="${pageContext.request.contextPath}/asset/images/car_model.svg"></div>
                            <div class="content">D-SUV</div>
                        </div>
                        <div class="item">
                            <div class="icon"><img src="${pageContext.request.contextPath}/asset/images/trunk_capacity.svg"></div>
                            <div class="content">350L</div>
                        </div>
                    </div>
                </div>
            </div>
            <button class="btn-book" id="btnBookCar" data-model-id="md06">Đặt xe</button>
        </section>
        <section class="car-utilities">
            <div class="widget_title">
                <h2 class="widget_title_name1">Các tiện nghi khác</h2>
            </div>
            <div class="widget_content">
                <div class="utilities-box">
                    <div class="another-feature">
                        <div class="item">
                            <div class="icon"><img src="${pageContext.request.contextPath}/asset/images/ai_assistant.svg" alt="ai_assistant"></div>
                            <div class="content">Trợ lý ảo VinFast tiêu chuẩn</div>
                        </div>
                        <div class="item">
                            <div class="icon"><img src="${pageContext.request.contextPath}/asset/images/driver_assistant.svg" alt="driver_assistant"></div>
                            <div class="content">Hệ thống hỗ trợ người lái ADAS</div>
                        </div>
                        <div class="item">
                            <div class="icon"><img src="${pageContext.request.contextPath}/asset/images/hud.svg" alt="hud"></div>
                            <div class="content">HUD tích hợp sẵn</div>
                        </div>
                        <div class="item">
                            <div class="icon"><img src="${pageContext.request.contextPath}/asset/images/360_camera.svg" alt="360_camera"></div>
                            <div class="content">Cảm biến và camera 360 độ</div>
                        </div>
                        <div class="item">
                            <div class="icon"><img src="${pageContext.request.contextPath}/asset/images/seat.svg" alt="seat"></div>
                            <div class="content">Ghế da vegan tích hợp sưởi và thông gió</div>
                        </div>
                        <div class="item">
                            <div class="icon"><img src="${pageContext.request.contextPath}/asset/images/screen_entertainment.svg" alt="screen_entertainment"></div>
                            <div class="content">Màn hình giải trí cảm ứng 15.6 inch</div>
                        </div>
                        <div class="item">
                            <div class="icon"><img src="${pageContext.request.contextPath}/asset/images/la_zang.svg" alt="la_zang"></div>
                            <div class="content">La-zăng hợp kim 19 inch</div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="widget">
                <div class="widget_title">
                    <h2 class="widget_title_name2">Điều kiện thuê xe</h2>
                </div>
                <div class="widget_content">
                    <div class="utilities-box">
                        <div class="information">
                            <div class="label">Thông tin cần có khi nhận xe</div>
                            <div class="content">
                                <li>CCCD hoặc Hộ chiếu còn thời hạn</li>
                            </div>
                            <div class="content">
                                <li>Bằng lái hợp lệ, còn thời hạn</li>
                            </div>
                        </div>
                    </div>
                    <div class="utilities-box">
                        <div class="payment">
                            <div class="label">Hình thức thanh toán</div>
                            <div class="content">
                                <li>Trả trước</li>
                            </div>
                            <div class="content">
                                <li>Thời hạn thanh toán: đặt cọc giữ xe thanh toán 100% khi kí hợp đồng và nhận xe</li>
                            </div>
                        </div>
                    </div>
                    <div class="utilities-box">
                        <div class="deposit">
                            <div class="label">Chính sách đặt cọc (thế chân)</div>
                            <div class="content">
                                <li>Khách hàng phải thanh toán số tiền cọc là 10.000.000đ</li>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <section class="car-similar">
            <h2 class="widget_title_name">Xe tương tự</h2>
            <div class="similar-list">
                <a href="${pageContext.request.contextPath}/thue-xe-tu-lai/vinfast-vf8-plus" class="similar-item">
                    <img src="${pageContext.request.contextPath}/asset/images/vf8plus01.webp" alt="VinFast VF 8 Plus">
                    <div class="similar-title">VinFast VF 8 Plus</div>
                    <div class="similar-price">
                        1.900.000
                        <sub class="vn-price-unit">VNĐ/Ngày</sub>
                    </div>
                </a>
            </div>
        </section>
    </main>
    <%@include file="../../footer/footer.jsp" %>
    <div id="modal-root"></div>
    <script src="${pageContext.request.contextPath}/header/header.js"></script>
    <script src="${pageContext.request.contextPath}/login/login.js"></script>
    <script src="${pageContext.request.contextPath}/register/register.js"></script>
    <script src="${pageContext.request.contextPath}/password/password.js"></script>
    <script src="${pageContext.request.contextPath}/rental/vf8e/vf8e.js"></script>
    <script src="${pageContext.request.contextPath}/rental/modal/modal.js"></script>
</body>
</html>