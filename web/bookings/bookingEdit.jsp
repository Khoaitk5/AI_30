<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sửa đặt xe - TVT Future</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/admin/dashboard-modern.css">
    <style>
        .main-content {
            padding: 36px 18px 18px 18px;
        }
        .date-time-group {
            display: flex;
            gap: 10px;
            align-items: center;
        }
    </style>
</head>
<body>
    <main class="main-content">
        <h1>Sửa đặt xe</h1>
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>
        <div class="card">
            <div class="card-body">
                <form action="${pageContext.request.contextPath}/bookings/edit" method="post">
                    <input type="hidden" name="id" value="${booking.id}">
                    <input type="hidden" name="customerId" value="${booking.customerId.id}">
                    <div class="mb-3">
                        <label class="form-label">Khách hàng</label>
                        <input type="text" class="form-control" value="${booking.customerId.fullName}" readonly>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Xe</label>
                        <select name="carId" id="carId" class="form-select" required onchange="updatePriceAndDeposit()">
                            <option value="">Chọn xe</option>
                            <c:forEach var="car" items="${cars}">
                                <option value="${car.id}" data-price="${car.vehicleModelId.rentalPricePerDay}" data-deposit="${car.vehicleModelId.depositPerDay}" <c:if test="${car.id eq booking.carId.id}">selected</c:if>>${car.vehicleModelId.model} - ${car.licensePlate}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Ngày bắt đầu</label>
                        <div class="date-time-group">
                            <input type="date" name="startDate" id="startDate" class="form-control" value="<fmt:formatDate value='${booking.startDate}' pattern='yyyy-MM-dd'/>" required onchange="restrictEndDate(); calculateTotal()">
                            <input type="time" name="deliveryTime" id="deliveryTime" class="form-control" value="<fmt:formatDate value='${booking.deliveryTime}' pattern='HH:mm'/>" required>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Ngày kết thúc</label>
                        <div class="date-time-group">
                            <input type="date" name="endDate" id="endDate" class="form-control" value="<fmt:formatDate value='${booking.endDate}' pattern='yyyy-MM-dd'/>" required onchange="calculateTotal()">
                            <input type="time" name="returnTime" id="returnTime" class="form-control" value="<fmt:formatDate value='${booking.returnTime}' pattern='HH:mm'/>" required>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Giá mỗi ngày (₫)</label>
                        <input type="number" name="pricePerDay" id="pricePerDay" class="form-control" value="${booking.pricePerDay}" readonly required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Tiền cọc (₫)</label>
                        <input type="number" name="deposit" id="deposit" class="form-control" value="${booking.deposit}" readonly required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Tổng tiền (₫)</label>
                        <input type="number" id="totalAmount" class="form-control" value="${booking.totalAmount}" readonly>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Trạng thái</label>
                        <select name="status" class="form-select" required>
                            <option value="CONFIRMED" <c:if test="${booking.status eq 'CONFIRMED'}">selected</c:if>>Xác nhận</option>
                            <option value="PENDING" <c:if test="${booking.status eq 'PENDING'}">selected</c:if>>Đang chờ</option>
                            <option value="CANCELLED" <c:if test="${booking.status eq 'CANCELLED'}">selected</c:if>>Hủy</option>
                            <option value="COMPLETED" <c:if test="${booking.status eq 'COMPLETED'}">selected</c:if>>Hoàn thành</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Địa điểm nhận xe</label>
                        <input type="text" name="pickupLocation" class="form-control" value="${booking.pickupLocation}">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Địa điểm trả xe</label>
                        <input type="text" name="dropoffLocation" class="form-control" value="${booking.dropoffLocation}">
                    </div>
                    <button type="submit" class="btn btn-primary">Cập nhật</button>
                    <a href="${pageContext.request.contextPath}/bookings" class="btn btn-secondary">Hủy</a>
                </form>
            </div>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function updatePriceAndDeposit() {
            const carSelect = document.getElementById('carId');
            const priceInput = document.getElementById('pricePerDay');
            const depositInput = document.getElementById('deposit');
            const selectedOption = carSelect.options[carSelect.selectedIndex];

            if (selectedOption && selectedOption.value) {
                priceInput.value = selectedOption.getAttribute('data-price');
                depositInput.value = selectedOption.getAttribute('data-deposit');
            } else {
                priceInput.value = '';
                depositInput.value = '';
            }
            calculateTotal();
        }

        function restrictEndDate() {
            const startDateInput = document.getElementById('startDate');
            const endDateInput = document.getElementById('endDate');
            const startDate = startDateInput.value;

            if (startDate) {
                // Set minimum date for endDate to be the day after startDate
                const minDate = new Date(startDate);
                minDate.setDate(minDate.getDate() + 1);
                const minDateString = minDate.toISOString().split('T')[0];
                endDateInput.setAttribute('min', minDateString);

                // If endDate is before startDate, clear it
                if (endDateInput.value && new Date(endDateInput.value) <= new Date(startDate)) {
                    endDateInput.value = '';
                }
            } else {
                endDateInput.removeAttribute('min');
            }
            calculateTotal();
        }

        function calculateTotal() {
            const startDate = document.getElementById('startDate').value;
            const endDate = document.getElementById('endDate').value;
            const pricePerDay = document.getElementById('pricePerDay').value;
            const totalAmountInput = document.getElementById('totalAmount');

            // Only calculate if both startDate and endDate are selected
            if (startDate && endDate && pricePerDay) {
                const start = new Date(startDate);
                const end = new Date(endDate);
                const diffTime = end - start;
                const totalDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));

                if (totalDays >= 0) {
                    const totalAmount = (totalDays + 1) * parseFloat(pricePerDay);
                    totalAmountInput.value = Math.round(totalAmount);
                } else {
                    totalAmountInput.value = '';
                }
            } else {
                totalAmountInput.value = '';
            }
        }

        // Initialize price, deposit, and endDate restriction on page load
        window.onload = function() {
            updatePriceAndDeposit();
            restrictEndDate();
        };
    </script>
</body>
</html>