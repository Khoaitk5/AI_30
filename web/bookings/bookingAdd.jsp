<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm đặt xe - TVT Future</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/admin/dashboard-modern.css">
    <style>
        .main-content {
            padding: 36px 18px 18px 18px;
        }
    </style>
</head>
<body>
    <main class="main-content">
        <h1>Thêm đặt xe</h1>
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>
        <div class="card">
            <div class="card-body">
                <form action="${pageContext.request.contextPath}/bookings/add" method="post">
                    <div class="mb-3">
                        <label class="form-label">Khách hàng</label>
                        <select name="customerId" class="form-select" required>
                            <option value="">Chọn khách hàng</option>
                            <c:forEach var="customer" items="${customers}">
                                <option value="${customer.id}">${customer.fullName}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Xe</label>
                        <select name="carId" id="carId" class="form-select" required onchange="updatePriceAndDeposit()">
                            <option value="">Chọn xe</option>
                            <c:forEach var="car" items="${cars}">
                                <option value="${car.id}" data-price="${car.vehicleModelId.rentalPricePerDay}" data-deposit="${car.vehicleModelId.depositPerDay}">
                                    ${car.vehicleModelId.model} - ${car.licensePlate}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Ngày bắt đầu</label>
                        <input type="date" name="startDate" id="startDate" class="form-control" required onchange="restrictEndDate(); calculateTotal()">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Ngày kết thúc</label>
                        <input type="date" name="endDate" id="endDate" class="form-control" required onchange="calculateTotal()">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Giá mỗi ngày (₫)</label>
                        <input type="number" name="pricePerDay" id="pricePerDay" class="form-control" readonly required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Tiền cọc (₫)</label>
                        <input type="number" name="deposit" id="deposit" class="form-control" readonly required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Tổng tiền (₫)</label>
                        <input type="number" id="totalAmount" class="form-control" readonly>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Trạng thái</label>
                        <select name="status" class="form-select" required>
                            <option value="CONFIRMED">Xác nhận</option>
                            <option value="PENDING">Đang chờ</option>
                            <option value="CANCELLED">Hủy</option>
                            <option value="COMPLETED">Hoàn thành</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Địa điểm nhận xe</label>
                        <input type="text" name="pickupLocation" class="form-control">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Địa điểm trả xe</label>
                        <input type="text" name="dropoffLocation" class="form-control">
                    </div>
                    <button type="submit" class="btn btn-primary">Thêm</button>
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
    </script>
</body>
</html>