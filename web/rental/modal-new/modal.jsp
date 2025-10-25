<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/rental/modal-new/modal.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Mulish:ital,wght@0,200..1000;1,200..1000&display=swap"
        rel="stylesheet">
    <script src="https://cdn.tailwindcss.com"></script>
</head>

<body>
    <div class="modal-bg fixed inset-0 flex items-center justify-center z-50 md:px-1 px-3 h-full overflow-y-scroll bg-black bg-opacity-50">
        <div class="modal-custom modal fade" id="modal-register-rent-car" aria-hidden="true" aria-labelledby="exampleModalLabel">
            <div class="modal-dialog modal-dialog-centered modal-xl modal-fullscreen-md-down relative">
                <div class="modal-content">
                    <div class="modal-header flex">
                        <h1 class="modal-title">Đăng ký thuê xe</h1>
                        <button class="btn-close" aria-label="Close" type="button" id="close-modal-btn"></button>
                    </div>
                    <div class="modal-body">
                        <div class="c-register-rent-box">
                            <!-- Cột bên trái: Form đăng ký -->
                            <div class="c-register-rent-box__left">
                                <form id="rental-form" action="${pageContext.request.contextPath}/payment" method="POST">
                                    <!-- Thông tin khách hàng -->
                                    <div class="row g-3 mb-3">
                                        <div class="col-md-12">
                                            <label class="form-label" for="fullname">Họ và tên <span class="text-red">*</span></label>
                                            <input class="form-control" id="fullname" name="fullname" placeholder="Nhập họ và tên" required="" type="text">
                                        </div>
                                        
                                        <div class="col-md-6">
                                            <label class="form-label" for="phone">Số điện thoại <span class="text-red">*</span></label>
                                            <input class="form-control" id="phone" name="phone" placeholder="Nhập số điện thoại" required="" type="tel">
                                        </div>
                                        
                                        <div class="col-md-6">
                                            <label class="form-label" for="email">Email <span class="text-red">*</span></label>
                                            <input class="form-control" id="email" name="email" placeholder="Nhập email" required="" type="email">
                                        </div>

                                        <div class="col-md-12">
                                            <label class="form-label" for="address">Địa chỉ <span class="text-red">*</span></label>
                                            <input class="form-control" id="address" name="address" placeholder="Nhập địa chỉ" required="" type="text">
                                        </div>
                                        
                                        <!-- Địa điểm nhận xe -->
                                        <div class="col-md-12 relative pickup-location">
                                            <label class="form-label" for="pickup-location">Địa điểm nhận xe <span class="text-red">*</span></label>
                                            <div class="relative">
                                                <div class="form-control flex items-center justify-between cursor-pointer" id="pickup-trigger">
                                                    <span id="pickup-selected" class="text-gray-500">Chọn địa điểm</span>
                                                    <svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                        <path d="M5 7.5L10 12.5L15 7.5" stroke="#9CA3AF" stroke-width="1.67" stroke-linecap="round" stroke-linejoin="round"/>
                                                    </svg>
                                                </div>
                                                <div id="pickup-dropdown" class="absolute top-full left-0 w-full bg-white border border-gray-300 rounded-md shadow-lg mt-1 z-10 hidden">
                                                    <div class="pickup-option p-2 hover:bg-gray-100 cursor-pointer" data-value="Văn phòng HCM">Văn phòng Hồ Chí Minh</div>
                                                    <div class="pickup-option p-2 hover:bg-gray-100 cursor-pointer" data-value="Văn phòng Hà Nội">Văn phòng Hà Nội</div>
                                                    <div class="pickup-option p-2 hover:bg-gray-100 cursor-pointer" data-value="Văn phòng Đà Nẵng">Văn phòng Đà Nẵng</div>
                                                    <div class="pickup-option p-2 hover:bg-gray-100 cursor-pointer" data-value="Giao xe tận nơi">Giao xe tận nơi</div>
                                                </div>
                                                <input type="hidden" id="pickup-location-input" name="pickupLocation" required="">
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Thông tin thuê xe -->
                                    <div class="row g-3 mb-3">
                                        <div class="col-md-12">
                                            <label class="form-label">Thông tin thuê xe <span class="text-red">*</span></label>
                                            <div class="flex items-center justify-between p-3 border border-gray-300 rounded cursor-pointer hover:border-green-500" id="edit-time-trigger">
                                                <div class="flex-1">
                                                    <div class="text-sm text-gray-600">Ngày nhận - Ngày trả</div>
                                                    <div class="font-semibold" id="rental-date-display">Chưa chọn</div>
                                                </div>
                                                <svg width="20" height="20" viewBox="0 0 20 20" fill="none">
                                                    <path d="M2.5 7.5H17.5M13.3333 1.66666V5M6.66667 1.66666V5M6.5 18.3333H13.5C14.9001 18.3333 15.6002 18.3333 16.135 18.0608C16.6054 17.8212 16.9878 17.4387 17.2275 16.9683C17.5 16.4335 17.5 15.7335 17.5 14.3333V7.33332C17.5 5.93319 17.5 5.23313 17.2275 4.69835C16.9878 4.22795 16.6054 3.8455 16.135 3.60581C15.6002 3.33332 14.9001 3.33332 13.5 3.33332H6.5C5.09987 3.33332 4.3998 3.33332 3.86502 3.60581C3.39462 3.8455 3.01217 4.22795 2.77248 4.69835C2.5 5.23313 2.5 5.93319 2.5 7.33332V14.3333C2.5 15.7335 2.5 16.4335 2.77248 16.9683C3.01217 17.4387 3.39462 17.8212 3.86502 18.0608C4.3998 18.3333 5.09987 18.3333 6.5 18.3333Z" stroke="#4B5563" stroke-width="1.67" stroke-linecap="round" stroke-linejoin="round"/>
                                                </svg>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Điều khoản -->
                                    <div class="c-car-info__btn">
                                        <div class="mb-3 flex items-center space-x-2">
                                            <input class="custom-checkbox" id="terms" name="terms" type="checkbox">
                                            <label class="form-label mb-0" for="terms">Tôi đồng ý với <a class="text-green-500" href="#">điều khoản &amp; điều kiện</a></label>
                                        </div>
                                        <div class="mb-3 flex items-center space-x-2">
                                            <input class="custom-checkbox" id="term-data" name="termData" type="checkbox">
                                            <label class="form-label mb-0" for="term-data">Tôi đồng ý cho TVT Future thu thập và xử lý dữ liệu</label>
                                        </div>
                                        <button class="w-full bg-gray-300 text-gray-500 py-3 rounded font-bold text-lg cursor-not-allowed" disabled="" id="pay-btn" type="submit">
                                            Thanh toán <span id="modal-payment-amount">0đ</span>
                                        </button>
                                    </div>

                                    <!-- Hidden inputs cho backend -->
                                    <input type="hidden" name="carId" value="${param.carId}">
                                    <input type="hidden" name="modelId" value="${param.modelId}">
                                    <input type="hidden" id="pickup-date" name="pickupDate">
                                    <input type="hidden" id="return-date" name="returnDate">
                                    <input type="hidden" id="pickup-time" name="pickupTime">
                                    <input type="hidden" id="return-time" name="returnTime">
                                    <input type="hidden" id="rental-type" name="rentalType" value="day">
                                    <input type="hidden" id="rental-duration" name="rentalDuration" value="1">
                                    <input type="hidden" id="total-price" name="totalPrice" value="0">
                                </form>
                            </div>

                            <!-- Cột bên phải: Thông tin xe và giá -->
                            <div class="c-register-rent-box__right">
                                <div class="c-car-info">
                                    <div class="c-car-info__top">
                                        <div class="c-car-card">
                                            <figure>
                                                <img alt="Car image" id="modal-car-image" src="${pageContext.request.contextPath}/asset/img/car-placeholder.png">
                                            </figure>
                                            <div>
                                                <div class="c-car-card__title" id="modal-car-name">Tên xe</div>
                                                <div class="text-sm text-gray-600" id="modal-car-type">Loại xe</div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="c-car-info__bottom">
                                        <div class="c-car-info__table">
                                            <div class="table-header">
                                                <div class="table-title">Chi tiết giá</div>
                                            </div>
                                            <hr>
                                            <div class="table-row">
                                                <label>Đơn giá thuê xe</label>
                                                <span id="modal-base-price">0đ</span>
                                            </div>
                                            <div class="table-row">
                                                <label>Tổng tiền thuê xe</label>
                                                <span id="modal-total-price">0đ</span>
                                            </div>
                                            <div class="table-row">
                                                <label>Phí cọc</label>
                                                <span id="modal-deposit-price">0đ</span>
                                            </div>
                                            <div class="table-row">
                                                <label>Voucher</label>
                                                <span id="modal-voucher-price">0đ</span>
                                            </div>
                                            <hr>
                                            <div class="table-row font-bold text-lg">
                                                <label>Tổng thanh toán</label>
                                                <span class="text-green-500" id="modal-final-payment">0đ</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Iframe chứa pick-time component -->
    <iframe id="pick-time-iframe" src="${pageContext.request.contextPath}/rental/pick-time/pick-time.html" 
            style="position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); z-index: 9999; border: none; display: none; background: transparent;"
            width="400" height="600"></iframe>

    <script src="${pageContext.request.contextPath}/rental/modal-new/modal-updated.js"></script>
</body>

</html>
