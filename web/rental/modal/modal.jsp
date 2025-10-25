<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký thuê xe</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/rental/modal/modal.css">
    <link href="https://fonts.googleapis.com/css2?family=Mulish:ital,wght@0,200..1000;1,200..1000&display=swap" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <div class="modal-content">
        <div class="modal-header header-row">
            <h1 class="modal-title">Đăng ký thuê xe</h1>
            <button class="btn-close" aria-label="Close" data-bs-dismiss="modal" type="button" id="modalCloseBtn"></button>
        </div>
        <div class="register-rent-box">
            <div class="car-info">
                <div class="car-info-top">
                    <div class="car-card">
                        <div class="car-card-title">${carModel.model}</div>
                        <div class="car-card-img">
                            <!-- Placeholder for car image -->
                        </div>
                    </div>
                </div>
                <div class="car-info-bottom">
                    <div class="car-info-table">
                        <div class="table-row table-title-row">
                            <h2 class="table-title">Bảng kê chi tiết</h2>
                        </div>
                        <div class="table-row">
                            <label>Cước phí niêm yết</label>
                            <span id="rentalPrice"><fmt:formatNumber value="${carModel.rentalPricePerDay}" pattern="#,###"/>đ</span>
                        </div>
                        <div class="table-row" id="rentalDaysRow">
                            <label>Số ngày thuê</label>
                            <span id="rentalDays">1</span>
                        </div>
                        <hr>
                        <div class="table-row">
                            <label>Tổng tiền</label>
                            <span class="car-info-total-black" id="totalRentalPrice"><fmt:formatNumber value="${carModel.rentalPricePerDay}" pattern="#,###"/>đ</span>
                        </div>
                        <div class="table-row">
                            <label>Tiền đặt cọc</label>
                            <span class="car-info-total-black"><fmt:formatNumber value="${carModel.depositPerDay}" pattern="#,###"/>đ</span>
                        </div>
                        <hr>
                        <div class="table-row">
                            <label>Thanh toán*</label>
                            <span class="car-info-total" id="totalPayment"><fmt:formatNumber value="${carModel.rentalPricePerDay + carModel.depositPerDay}" pattern="#,###"/>đ</span>
                        </div>
                        <div class="table-row">
                            <span class="car-info-note">*Giá thuê xe đã bao gồm VAT.</span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="register-rent-box-left">
                <form id="rentalForm" action="${pageContext.request.contextPath}/payment" method="POST">
                    <div class="register-rent-form">
                        <div class="renter-info-row">
                            <div class="form-col">
                                <label class="form-label">Tên người thuê<span class="required">*</span></label>
                                <input class="form-control" placeholder="Họ và tên" required type="text" name="name" id="nameInput" value="${not empty sessionScope.currentCustomer ? sessionScope.currentCustomer.fullName : ''}">
                            </div>
                            <div class="form-col">
                                <label class="form-label">Số điện thoại<span class="required">*</span></label>
                                <input class="form-control phone-input" type="tel" name="phone" id="phoneInput" value="${not empty sessionScope.currentCustomer ? sessionScope.currentCustomer.phone : ''}" ${not empty sessionScope.currentCustomer ? 'readonly' : ''} required>
                            </div>
                            <div class="form-col">
                                <label class="form-label">Email<span class="required">*</span></label>
                                <input class="form-control email-input" type="email" name="email" id="emailInput" value="${not empty sessionScope.currentCustomer ? sessionScope.currentCustomer.email : ''}" ${not empty sessionScope.currentCustomer ? 'readonly' : ''} required>
                            </div>
                        </div>
                        <div class="form-row" style="display:flex; flex-direction:row; gap:16px; align-items:flex-end;">
                            <div class="form-col" style="flex:1 1 0; min-width:0;">
                                <label class="form-label">Nơi nhận xe<span class="required">*</span></label>
                                <div class="input-with-icon">
                                    <svg class="input-icon" width="24" height="24" fill="none">
                                        <path d="M13.3337 17.5V13.3333M1.66699 17.5H18.3337M2.50033 17.5V4.16667C2.50033 3.24619 3.24652 2.5 4.16699 2.5H12.5003C13.4208 2.5 14.167 3.24619 14.167 4.16667V7.91667M9.16699 17.5V10L13.3337 7.5L17.5003 10V17.5M5.83366 5.83333H5.84199M5.83366 9.16667H5.84199M5.83366 12.5H5.84199" stroke="#4B5563" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"></path>
                                    </svg>
                                    <select class="form-control input-with-svg" name="pickupLocation" id="pickupLocationInput" required>
                                        <option value="" disabled selected>Chọn địa điểm nhận xe</option>
                                        <option value="Showroom VinFast Đà Nẵng - Vincom Ngô Quyền">Showroom VinFast Đà Nẵng - Vincom Ngô Quyền</option>
                                        <option value="Showroom VinFast Đà Nẵng - Hòa Xuân">Showroom VinFast Đà Nẵng - Hòa Xuân</option>
                                        <option value="Showroom VinFast Đà Nẵng - Hải Châu">Showroom VinFast Đà Nẵng - Hải Châu</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="form-row" id="rental-date-row" style="display:flex;">
                            <div class="form-col" style="flex-direction:column;">
                                <label class="form-label">Ngày nhận xe<span class="required">*</span></label>
                                <div class="date-time-group">
                                    <input class="form-control" type="date" name="pickupDate" id="pickupDate" required min="${java.time.LocalDate.now().plusDays(1)}">
                                    <input class="form-control" type="time" name="pickupTime" id="pickupTime" required>
                                </div>
                            </div>
                            <div class="form-col" id="return-date-col" style="flex-direction:column;">
                                <label class="form-label">Ngày trả xe<span class="required">*</span></label>
                                <div class="date-time-group">
                                    <input class="form-control" type="date" name="returnDate" id="returnDate" required min="${java.time.LocalDate.now().plusDays(2)}">
                                    <input class="form-control" type="time" name="returnTime" id="returnTime" required>
                                </div>
                            </div>
                        </div>
                        <div class="form-row" id="confirm-rental-row" style="display:flex;">
                            <div class="form-col" style="flex:1 1 0;">
                                <button class="btn btn-primary btn-confirm" id="confirmRentalDateBtn" type="button" onclick="confirmRentalDate()">Xác nhận</button>
                            </div>
                        </div>
                        <div class="terms-row">
                            <input id="terms" class="custom-checkbox" type="checkbox">
                            <label for="terms">Đã đọc và đồng ý với <a class="terms-link">Điều khoản thanh toán</a> của Green Future</label>
                        </div>
                        <input type="hidden" name="amount" id="paymentAmount">
                        <input type="hidden" name="modelId" value="${param.modelId}">
                        <input type="hidden" name="carId" value="${carId}">
                        <input type="hidden" name="rentalType" value="ngay">
                        <button class="btn btn-primary btn-lg btn-block payment-btn" type="submit" disabled>Thanh toán <span id="paymentButtonAmount"><fmt:formatNumber value="${carModel.rentalPricePerDay + carModel.depositPerDay}" pattern="#,###"/>đ</span></button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const terms = document.getElementById('terms');
            const payBtn = document.querySelector('.payment-btn');
            const pickupDateInput = document.getElementById('pickupDate');
            const returnDateInput = document.getElementById('returnDate');
            const rentalDaysSpan = document.getElementById('rentalDays');
            const totalRentalPriceSpan = document.getElementById('totalRentalPrice');
            const totalPaymentSpan = document.getElementById('totalPayment');
            const paymentButtonAmount = document.getElementById('paymentButtonAmount');
            const nameInput = document.getElementById('nameInput');
            const phoneInput = document.getElementById('phoneInput');
            const emailInput = document.getElementById('emailInput');
            const pickupLocationInput = document.getElementById('pickupLocationInput');
            const pickupTime = document.getElementById('pickupTime');
            const returnTime = document.getElementById('returnTime');
            const paymentAmount = document.getElementById('paymentAmount');
            let isPriceConfirmed = false;

            function updateBtn() {
                const isFormValid = validateForm();
                payBtn.disabled = !terms.checked || !isFormValid || !isPriceConfirmed;
            }

            function validateForm() {
                const isNameFilled = nameInput.value.trim() !== '';
                const isPhoneFilled = phoneInput.value.trim() !== '';
                const isEmailFilled = emailInput.value.trim() !== '';
                const isPickupLocationFilled = pickupLocationInput.value !== '';
                const isDateValid = pickupDateInput.value && returnDateInput.value && pickupTime.value && returnTime.value;

                return isNameFilled && isPhoneFilled && isEmailFilled && isPickupLocationFilled && isDateValid;
            }

            function formatDate(date) {
                const yyyy = date.getFullYear();
                const mm = String(date.getMonth() + 1).padStart(2, '0');
                const dd = String(date.getDate()).padStart(2, '0');
                return yyyy + '-' + mm + '-' + dd;
            }

            function setDefaultDates() {
                const tomorrow = new Date();
                tomorrow.setDate(tomorrow.getDate() + 1);
                const dayAfterTomorrow = new Date(tomorrow);
                dayAfterTomorrow.setDate(tomorrow.getDate() + 1);

                pickupDateInput.value = formatDate(tomorrow);
                pickupTime.value = '09:00';
                returnDateInput.value = formatDate(dayAfterTomorrow);
                returnTime.value = '09:00';
                pickupDateInput.min = formatDate(tomorrow);
                returnDateInput.min = formatDate(dayAfterTomorrow);
            }

            function updateReturnDateMin() {
                const pickupDate = pickupDateInput.value;
                if (pickupDate) {
                    const nextDay = new Date(pickupDate);
                    nextDay.setDate(nextDay.getDate() + 1);
                    returnDateInput.min = formatDate(nextDay);
                    if (returnDateInput.value < returnDateInput.min) {
                        returnDateInput.value = returnDateInput.min;
                        returnTime.value = pickupTime.value || '09:00';
                    }
                }
            }

            function validateDates() {
                if (!pickupDateInput.value || !returnDateInput.value || !pickupTime.value || !returnTime.value) {
                    alert('Vui lòng chọn ngày và giờ nhận/trả xe.');
                    return false;
                }
                const pickupDate = new Date(pickupDateInput.value);
                const returnDate = new Date(returnDateInput.value);
                if (returnDate <= pickupDate) {
                    alert('Ngày trả xe phải sau ngày nhận xe.');
                    return false;
                }
                return true;
            }

            window.confirmRentalDate = function () {
                if (!validateDates()) {
                    return;
                }

                const modelId = new URLSearchParams(window.location.search).get('modelId');
                const carId = '${carId}';
                const pickupDate = pickupDateInput.value;
                const returnDate = returnDateInput.value;

                $.ajax({
                    url: '${pageContext.request.contextPath}/rental/calculate',
                    type: 'POST',
                    data: {
                        modelId: modelId,
                        carId: carId,
                        rentalType: 'ngay',
                        pickupDate: pickupDate,
                        returnDate: returnDate
                    },
                    success: function (response) {
                        if (response.error) {
                            alert(response.error);
                            return;
                        }
                        rentalDaysSpan.textContent = response.rentalDays + ' ngày';
                        totalRentalPriceSpan.textContent = new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(response.totalRentalPrice);
                        totalPaymentSpan.textContent = new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(response.totalPayment);
                        paymentButtonAmount.textContent = new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(response.totalPayment);
                        paymentAmount.value = response.totalPayment;
                        document.getElementById('rentalDaysRow').style.display = 'flex';
                        isPriceConfirmed = true;
                        updateBtn();
                    },
                    error: function () {
                        alert('Có lỗi xảy ra khi tính toán giá. Vui lòng thử lại.');
                    }
                });
            };

            setDefaultDates();
            document.getElementById('rental-date-row').style.display = 'flex';
            document.getElementById('confirm-rental-row').style.display = 'flex';
            document.getElementById('confirmRentalDateBtn').style.display = 'inline-block';

            pickupDateInput.addEventListener('change', updateReturnDateMin);
            terms.addEventListener('change', updateBtn);
            nameInput.addEventListener('input', updateBtn);
            phoneInput.addEventListener('input', updateBtn);
            emailInput.addEventListener('input', updateBtn);
            pickupLocationInput.addEventListener('change', updateBtn);
            pickupDateInput.addEventListener('input', updateBtn);
            returnDateInput.addEventListener('input', updateBtn);
            pickupTime.addEventListener('input', updateBtn);
            returnTime.addEventListener('input', updateBtn);

            const closeBtn = document.getElementById('modalCloseBtn');
            const modalContent = document.querySelector('.modal-content');
            if (closeBtn && modalContent) {
                closeBtn.addEventListener('click', function () {
                    modalContent.parentElement.style.display = 'none';
                });
            }
        });
    </script>
</body>
</html>