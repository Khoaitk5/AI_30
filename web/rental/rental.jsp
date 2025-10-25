<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dịch Vụ Cho Thuê Xe Ô TÔ Điện Tự Lái - TVT Future</title>
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Mulish:ital,wght@0,200..1000;1,200..1000&display=swap" rel="stylesheet">
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/rental/rental.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/footer/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/header/header.css">
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/asset/images/logo_gf_black.svg">
</head>
<body>
    <%@include file="../login/login.jsp" %>
    <%@include file="../register/register.jsp" %>
    <%@include file="../password/password.jsp" %>
    <%@include file="../header/header.jsp" %>
    <div class="main-wrapper">
        <main class="main-content">
            <!-- Search Section -->
            <div class="rental-body">
                <!-- Car List -->
                <div class="rental-list">
                    <!-- VF 3 -->
                    <a class="car-item" href="${pageContext.request.contextPath}/rental/vf3/vf3.jsp">
                        <div class="relative car-image">
                            <div class="absolute top-1 left-1 z-2 w-full flex justify-between">
                                <div class="flex gap-1">
                                    <div class="badge badge-free">Miễn phí sạc</div>
                                </div>
                                <c:if test="${availableVF3 == 0}">
                                    <div class="bg-[#facfcf] text-red px-2 py-1 text-xs font-semibold rounded ml-auto transform -translate-x-2">
                                        Hết xe
                                    </div>
                                </c:if>
                            </div>
                            <img alt="VinFast VF 3" src="https://upload-static.fgf.vn/car/vf301.jpg" width="350" height="200" />
                        </div>
                        <div class="relative car-info">
                            <div class="price-badge">
                                <span class="price-day">
                                    <span class="price-text">Chỉ từ</span>
                                    <span class="price-amount">
                                        <fmt:formatNumber value="${priceVF3}" type="number" groupingUsed="true" />
                                    </span>
                                    <span class="price-unit">VNĐ/Ngày</span>
                                </span>
                            </div>
                            <div class="car-details">
                                <div class="car-name">VinFast VF 3</div>
                                <div class="car-specs">
                                    <div class="spec-item"><img src="${pageContext.request.contextPath}/asset/images/car_model.svg"><span class="spec-text">Minicar</span></div>
                                    <div class="spec-item"><img src="${pageContext.request.contextPath}/asset/images/battery_footer_dk.svg"><span class="spec-text">210km (NEDC)</span></div>
                                    <div class="spec-item"><img src="${pageContext.request.contextPath}/asset/images/no_of_seat.svg"><span class="spec-text">4 chỗ</span></div>
                                    <div class="spec-item"><img src="${pageContext.request.contextPath}/asset/images/trunk_capacity.svg"><span class="spec-text">Dung tích cốp 285L</span></div>
                                </div>
                            </div>
                        </div>
                    </a>
                    <!-- VF 6S -->
                    <a class="car-item" href="${pageContext.request.contextPath}/rental/vf6s/vf6s.jsp">
                        <div class="relative car-image">
                            <div class="absolute top-1 left-1 z-2 w-full flex justify-between">
                                <div class="flex gap-1">
                                    <div class="badge badge-free">Miễn phí sạc</div>
                                </div>
                                <c:if test="${availableVF6S == 0}">
                                    <div class="bg-[#facfcf] text-red px-2 py-1 text-xs font-semibold rounded ml-auto transform -translate-x-2">
                                        Hết xe
                                    </div>
                                </c:if>
                            </div>
                            <img alt="VinFast VF 6S" src="https://upload-static.fgf.vn/car/vf6s001.png" width="350" height="200" />
                        </div>
                        <div class="relative car-info">
                            <div class="price-badge">
                                <span class="price-day">
                                    <span class="price-text">Chỉ từ</span>
                                    <span class="price-amount">
                                        <fmt:formatNumber value="${priceVF6S}" type="number" groupingUsed="true" />
                                    </span>
                                    <span class="price-unit">VNĐ/Ngày</span>
                                </span>
                            </div>
                            <div class="car-details">
                                <div class="car-name">VinFast VF 6S</div>
                                <div class="car-specs">
                                    <div class="spec-item"><img src="${pageContext.request.contextPath}/asset/images/car_model.svg"><span class="spec-text">B-SUV</span></div>
                                    <div class="spec-item"><img src="${pageContext.request.contextPath}/asset/images/battery_footer_dk.svg"><span class="spec-text">480km (NEDC)</span></div>
                                    <div class="spec-item"><img src="${pageContext.request.contextPath}/asset/images/no_of_seat.svg"><span class="spec-text">5 chỗ</span></div>
                                    <div class="spec-item"><img src="${pageContext.request.contextPath}/asset/images/trunk_capacity.svg"><span class="spec-text">Dung tích cốp 423L</span></div>
                                </div>
                            </div>
                        </div>
                    </a>
                    <!-- VF 6 Plus -->
                    <a class="car-item" href="${pageContext.request.contextPath}/rental/vf6p/vf6p.jsp">
                        <div class="relative car-image">
                            <div class="absolute top-1 left-1 z-2 w-full flex justify-between">
                                <div class="flex gap-1">
                                    <div class="badge badge-free">Miễn phí sạc</div>
                                </div>
                                <c:if test="${availableVF6Plus == 0}">
                                    <div class="bg-[#facfcf] text-red px-2 py-1 text-xs font-semibold rounded ml-auto transform -translate-x-2">
                                        Hết xe
                                    </div>
                                </c:if>
                            </div>
                            <img alt="VinFast VF 6 Plus" src="https://upload-static.fgf.vn/car/vf6plus001.png" width="350" height="200" />
                        </div>
                        <div class="relative car-info">
                            <div class="price-badge">
                                <span class="price-day">
                                    <span class="price-text">Chỉ từ</span>
                                    <span class="price-amount">
                                        <fmt:formatNumber value="${priceVF6Plus}" type="number" groupingUsed="true" />
                                    </span>
                                    <span class="price-unit">VNĐ/Ngày</span>
                                </span>
                            </div>
                            <div class="car-details">
                                <div class="car-name">VinFast VF 6 Plus</div>
                                <div class="car-specs">
                                    <div class="spec-item"><img src="${pageContext.request.contextPath}/asset/images/car_model.svg"><span class="spec-text">B-SUV</span></div>
                                    <div class="spec-item"><img src="${pageContext.request.contextPath}/asset/images/battery_footer_dk.svg"><span class="spec-text">460km (NEDC)</span></div>
                                    <div class="spec-item"><img src="${pageContext.request.contextPath}/asset/images/no_of_seat.svg"><span class="spec-text">5 chỗ</span></div>
                                    <div class="spec-item"><img src="${pageContext.request.contextPath}/asset/images/trunk_capacity.svg"><span class="spec-text">Dung tích cốp 423L</span></div>
                                </div>
                            </div>
                        </div>
                    </a>
                    <!-- VF 7S -->
                    <a class="car-item" href="${pageContext.request.contextPath}/rental/vf7s/vf7s.jsp">
                        <div class="relative car-image">
                            <div class="absolute top-1 left-1 z-2 w-full flex justify-between">
                                <div class="flex gap-1">
                                    <div class="badge badge-free">Miễn phí sạc</div>
                                </div>
                                <c:if test="${availableVF7S == 0}">
                                    <div class="bg-[#facfcf] text-red px-2 py-1 text-xs font-semibold rounded ml-auto transform -translate-x-2">
                                        Hết xe
                                    </div>
                                </c:if>
                            </div>
                            <img alt="VinFast VF 7S" src="https://upload-static.fgf.vn/car/vf7s001.png" width="350" height="200" />
                        </div>
                        <div class="relative car-info">
                            <div class="price-badge">
                                <span class="price-day">
                                    <span class="price-text">Chỉ từ</span>
                                    <span class="price-amount">
                                        <fmt:formatNumber value="${priceVF7S}" type="number" groupingUsed="true" />
                                    </span>
                                    <span class="price-unit">VNĐ/Ngày</span>
                                </span>
                            </div>
                            <div class="car-details">
                                <div class="car-name">VinFast VF 7S</div>
                                <div class="car-specs">
                                    <div class="spec-item"><img src="${pageContext.request.contextPath}/asset/images/car_model.svg"><span class="spec-text">C-SUV</span></div>
                                    <div class="spec-item"><img src="${pageContext.request.contextPath}/asset/images/battery_footer_dk.svg"><span class="spec-text">430km (NEDC)</span></div>
                                    <div class="spec-item"><img src="${pageContext.request.contextPath}/asset/images/no_of_seat.svg"><span class="spec-text">5 chỗ</span></div>
                                    <div class="spec-item"><img src="${pageContext.request.contextPath}/asset/images/trunk_capacity.svg"><span class="spec-text">Dung tích cốp 537L</span></div>
                                </div>
                            </div>
                        </div>
                    </a>
                    <!-- VF 7 Plus -->
                    <a class="car-item" href="${pageContext.request.contextPath}/rental/vf7p/vf7p.jsp">
                        <div class="relative car-image">
                            <div class="absolute top-1 left-1 z-2 w-full flex justify-between">
                                <div class="flex gap-1">
                                    <div class="badge badge-free">Miễn phí sạc</div>
                                </div>
                                <c:if test="${availableVF7Plus == 0}">
                                    <div class="bg-[#facfcf] text-red px-2 py-1 text-xs font-semibold rounded ml-auto transform -translate-x-2">
                                        Hết xe
                                    </div>
                                </c:if>
                            </div>
                            <img alt="VinFast VF 7 Plus" src="https://upload-static.fgf.vn/car/vf7plus001.png" width="350" height="200" />
                        </div>
                        <div class="relative car-info">
                            <div class="price-badge">
                                <span class="price-day">
                                    <span class="price-text">Chỉ từ</span>
                                    <span class="price-amount">
                                        <fmt:formatNumber value="${priceVF7Plus}" type="number" groupingUsed="true" />
                                    </span>
                                    <span class="price-unit">VNĐ/Ngày</span>
                                </span>
                            </div>
                            <div class="car-details">
                                <div class="car-name">VinFast VF 7 Plus</div>
                                <div class="car-specs">
                                    <div class="spec-item"><img src="${pageContext.request.contextPath}/asset/images/car_model.svg"><span class="spec-text">C-SUV</span></div>
                                    <div class="spec-item"><img src="${pageContext.request.contextPath}/asset/images/battery_footer_dk.svg"><span class="spec-text">496km (NEDC)</span></div>
                                    <div class="spec-item"><img src="${pageContext.request.contextPath}/asset/images/no_of_seat.svg"><span class="spec-text">5 chỗ</span></div>
                                    <div class="spec-item"><img src="${pageContext.request.contextPath}/asset/images/trunk_capacity.svg"><span class="spec-text">Dung tích cốp 537L</span></div>
                                </div>
                            </div>
                        </div>
                    </a>
                    <!-- VF 8 Eco -->
                    <a class="car-item" href="${pageContext.request.contextPath}/rental/vf8e/vf8e.jsp">
                        <div class="relative car-image">
                            <div class="absolute top-1 left-1 z-2 w-full flex justify-between">
                                <div class="flex gap-1">
                                    <div class="badge badge-free">Miễn phí sạc</div>
                                </div>
                                <c:if test="${availableVF8Eco == 0}">
                                    <div class="bg-[#facfcf] text-red px-2 py-1 text-xs font-semibold rounded ml-auto transform -translate-x-2">
                                        Hết xe
                                    </div>
                                </c:if>
                            </div>
                            <img alt="VinFast VF 8 Eco" src="https://upload-static.fgf.vn/car/vf8eco01.jpg" width="350" height="200" />
                        </div>
                        <div class="relative car-info">
                            <div class="price-badge">
                                <span class="price-day">
                                    <span class="price-text">Chỉ từ</span>
                                    <span class="price-amount">
                                        <fmt:formatNumber value="${priceVF8Eco}" type="number" groupingUsed="true" />
                                    </span>
                                    <span class="price-unit">VNĐ/Ngày</span>
                                </span>
                            </div>
                            <div class="car-details">
                                <div class="car-name">VinFast VF 8 Eco</div>
                                <div class="car-specs">
                                    <div class="spec-item"><img src="${pageContext.request.contextPath}/asset/images/car_model.svg"><span class="spec-text">D-SUV</span></div>
                                    <div class="spec-item"><img src="${pageContext.request.contextPath}/asset/images/battery_footer_dk.svg"><span class="spec-text">471km (WLTP)</span></div>
                                    <div class="spec-item"><img src="${pageContext.request.contextPath}/asset/images/no_of_seat.svg"><span class="spec-text">5 chỗ</span></div>
                                    <div class="spec-item"><img src="${pageContext.request.contextPath}/asset/images/trunk_capacity.svg"><span class="spec-text">Dung tích cốp 350L</span></div>
                                </div>
                            </div>
                        </div>
                    </a>
                    <!-- VF 8 Plus -->
                    <a class="car-item" href="${pageContext.request.contextPath}/rental/vf8p/vf8p.jsp">
                        <div class="relative car-image">
                            <div class="absolute top-1 left-1 z-2 w-full flex justify-between">
                                <div class="flex gap-1">
                                    <div class="badge badge-free">Miễn phí sạc</div>
                                </div>
                                <c:if test="${availableVF8Plus == 0}">
                                    <div class="bg-[#facfcf] text-red px-2 py-1 text-xs font-semibold rounded ml-auto transform -translate-x-2">
                                        Hết xe
                                    </div>
                                </c:if>
                            </div>
                            <img alt="VinFast VF 8 Plus" src="https://upload-static.fgf.vn/car/vf8plus01.jpg" width="350" height="200" />
                        </div>
                        <div class="relative car-info">
                            <div class="price-badge">
                                <span class="price-day">
                                    <span class="price-text">Chỉ từ</span>
                                    <span class="price-amount">
                                        <fmt:formatNumber value="${priceVF8Plus}" type="number" groupingUsed="true" />
                                    </span>
                                    <span class="price-unit">VNĐ/Ngày</span>
                                </span>
                            </div>
                            <div class="car-details">
                                <div class="car-name">VinFast VF 8 Plus</div>
                                <div class="car-specs">
                                    <div class="spec-item"><img src="${pageContext.request.contextPath}/asset/images/car_model.svg"><span class="spec-text">D-SUV</span></div>
                                    <div class="spec-item"><img src="${pageContext.request.contextPath}/asset/images/battery_footer_dk.svg"><span class="spec-text">471km (WLTP)</span></div>
                                    <div class="spec-item"><img src="${pageContext.request.contextPath}/asset/images/no_of_seat.svg"><span class="spec-text">5 chỗ</span></div>
                                    <div class="spec-item"><img src="${pageContext.request.contextPath}/asset/images/trunk_capacity.svg"><span class="spec-text">Dung tích cốp 350L</span></div>
                                </div>
                            </div>
                        </div>
                    </a>
                    <!-- VF 9 Eco -->
                    <a class="car-item" href="${pageContext.request.contextPath}/rental/vf9e/vf9e.jsp">
                        <div class="relative car-image">
                            <div class="absolute top-1 left-1 z-2 w-full flex justify-between">
                                <div class="flex gap-1">
                                    <div class="badge badge-free">Miễn phí sạc</div>
                                </div>
                                <c:if test="${availableVF9Eco == 0}">
                                    <div class="bg-[#facfcf] text-red px-2 py-1 text-xs font-semibold rounded ml-auto transform -translate-x-2">
                                        Hết xe
                                    </div>
                                </c:if>
                            </div>
                            <img alt="VinFast VF 9 Eco" src="https://upload-static.fgf.vn/car/vf9-eco-09.jpg" width="350" height="200" />
                        </div>
                        <div class="relative car-info">
                            <div class="price-badge">
                                <span class="price-day">
                                    <span class="price-text">Chỉ từ</span>
                                    <span class="price-amount">
                                        <fmt:formatNumber value="${priceVF9Eco}" type="number" groupingUsed="true" />
                                    </span>
                                    <span class="price-unit">VNĐ/Ngày</span>
                                </span>
                            </div>
                            <div class="car-details">
                                <div class="car-name">VinFast VF 9 Eco</div>
                                <div class="car-specs">
                                    <div class="spec-item"><img src="${pageContext.request.contextPath}/asset/images/car_model.svg"><span class="spec-text">E-SUV</span></div>
                                    <div class="spec-item"><img src="${pageContext.request.contextPath}/asset/images/battery_footer_dk.svg"><span class="spec-text">437km (WLTP)</span></div>
                                    <div class="spec-item"><img src="${pageContext.request.contextPath}/asset/images/no_of_seat.svg"><span class="spec-text">7 chỗ</span></div>
                                    <div class="spec-item"><img src="${pageContext.request.contextPath}/asset/images/trunk_capacity.svg"><span class="spec-text">Dung tích cốp 212L</span></div>
                                </div>
                            </div>
                        </div>
                    </a>
                    <!-- VF 9 Plus -->
                    <a class="car-item" href="${pageContext.request.contextPath}/rental/vf9p/vf9p.jsp">
                        <div class="relative car-image">
                            <div class="absolute top-1 left-1 z-2 w-full flex justify-between">
                                <div class="flex gap-1">
                                    <div class="badge badge-free">Miễn phí sạc</div>
                                </div>
                                <c:if test="${availableVF9Plus == 0}">
                                    <div class="bg-[#facfcf] text-red px-2 py-1 text-xs font-semibold rounded ml-auto transform -translate-x-2">
                                        Hết xe
                                    </div>
                                </c:if>
                            </div>
                            <img alt="VinFast VF 9 Plus" src="https://upload-static.fgf.vn/car/vf9-plus-10.jpg" width="350" height="200" />
                        </div>
                        <div class="relative car-info">
                            <div class="price-badge">
                                <span class="price-day">
                                    <span class="price-text">Chỉ từ</span>
                                    <span class="price-amount">
                                        <fmt:formatNumber value="${priceVF9Plus}" type="number" groupingUsed="true" />
                                    </span>
                                    <span class="price-unit">VNĐ/Ngày</span>
                                </span>
                            </div>
                            <div class="car-details">
                                <div class="car-name">VinFast VF 9 Plus</div>
                                <div class="car-specs">
                                    <div class="spec-item"><img src="${pageContext.request.contextPath}/asset/images/car_model.svg"><span class="spec-text">E-SUV</span></div>
                                    <div class="spec-item"><img src="${pageContext.request.contextPath}/asset/images/battery_footer_dk.svg"><span class="spec-text">602km (WLTP)</span></div>
                                    <div class="spec-item"><img src="${pageContext.request.contextPath}/asset/images/no_of_seat.svg"><span class="spec-text">6 chỗ</span></div>
                                    <div class="spec-item"><img src="${pageContext.request.contextPath}/asset/images/trunk_capacity.svg"><span class="spec-text">Dung tích cốp 212L</span></div>
                                </div>
                            </div>
                        </div>
                    </a>
                </div>
            </div>
        </main>
    </div>
    <%@include file="../footer/footer.jsp" %>
    <script src="${pageContext.request.contextPath}/header/header.js"></script>
    <script src="${pageContext.request.contextPath}/login/login.js"></script>
    <script src="${pageContext.request.contextPath}/register/register.js"></script>
    <script src="${pageContext.request.contextPath}/password/password.js"></script>
    <script>
        // Set date and time inputs, preserving query parameters if present
        window.addEventListener('DOMContentLoaded', function () {
            const now = new Date();
            const pad = n => n.toString().padStart(2, '0');
            const tomorrow = new Date(now.getFullYear(), now.getMonth(), now.getDate() + 1);
            const tomorrowStr = tomorrow.getFullYear() + '-' + pad(tomorrow.getMonth() + 1) + '-' + pad(tomorrow.getDate());
            const dayAfterTomorrow = new Date(now.getFullYear(), now.getMonth(), now.getDate() + 2);
            const dayAfterTomorrowStr = dayAfterTomorrow.getFullYear() + '-' + pad(dayAfterTomorrow.getMonth() + 1) + '-' + pad(dayAfterTomorrow.getDate());
            const defaultTime = '07:00';

            // Get query parameters
            const urlParams = new URLSearchParams(window.location.search);
            const pickupDateParam = urlParams.get('pickupDate');
            const pickupTimeParam = urlParams.get('pickupTime');
            const returnDateParam = urlParams.get('returnDate');
            const returnTimeParam = urlParams.get('returnTime');

            // Day form
            const pickupDate = document.getElementById('pickup-date');
            const pickupTime = document.getElementById('pickup-time');
            const returnDate = document.getElementById('return-date');
            const returnTime = document.getElementById('return-time');

            // Set pickup date and time
            if (pickupDate) {
                pickupDate.value = pickupDateParam || tomorrowStr;
                pickupDate.min = tomorrowStr;
            }
            if (pickupTime) {
                pickupTime.value = pickupTimeParam || defaultTime;
                pickupTime.min = '07:00';
                pickupTime.max = '21:00';
            }

            // Set return date and time
            if (returnDate) {
                if (returnDateParam) {
                    returnDate.value = returnDateParam;
                    returnDate.min = pickupDateParam || tomorrowStr;
                } else {
                    // Calculate default return date as one day after pickup date
                    const pickupVal = pickupDateParam || tomorrowStr;
                    const parts = pickupVal.split('-');
                    const y = parseInt(parts[0], 10);
                    const m = parseInt(parts[1], 10) - 1;
                    const d = parseInt(parts[2], 10);
                    const pickupObj = new Date(y, m, d);
                    const returnObj = new Date(pickupObj.getFullYear(), pickupObj.getMonth(), pickupObj.getDate() + 1);
                    const returnStr = returnObj.getFullYear() + '-' + pad(returnObj.getMonth() + 1) + '-' + pad(returnObj.getDate());
                    returnDate.value = returnStr;
                    returnDate.min = returnStr;
                }
            }
            if (returnTime) {
                returnTime.value = returnTimeParam || defaultTime;
                returnTime.min = '07:00';
                returnTime.max = '21:00';
            }

            // Update return date when pickup date changes
            function updateReturnDate() {
                const pickupVal = pickupDate.value;
                if (!pickupVal) return;
                const parts = pickupVal.split('-');
                const y = parseInt(parts[0], 10);
                const m = parseInt(parts[1], 10) - 1;
                const d = parseInt(parts[2], 10);
                const pickupObj = new Date(y, m, d);
                const returnObj = new Date(pickupObj.getFullYear(), pickupObj.getMonth(), pickupObj.getDate() + 1);
                const returnStr = returnObj.getFullYear() + '-' + pad(returnObj.getMonth() + 1) + '-' + pad(returnObj.getDate());
                if (returnDate) {
                    returnDate.value = returnStr;
                    returnDate.min = returnStr;
                }
            }

            if (pickupDate) {
                pickupDate.addEventListener('change', updateReturnDate);
            }

            // Clamp time inputs to 07:00-21:00
            function clampTime(input) {
                if (!input) return;
                if (input.value < '07:00') input.value = '07:00';
                if (input.value > '21:00') input.value = '21:00';
            }

            if (pickupTime) pickupTime.addEventListener('change', function () { clampTime(pickupTime); });
            if (returnTime) returnTime.addEventListener('change', function () { clampTime(returnTime); });
        });

        window.addEventListener('DOMContentLoaded', function () {
            if (typeof initLoginFunctionality === 'function') {
                initLoginFunctionality();
            }
        });
    </script>
</body>
</html>