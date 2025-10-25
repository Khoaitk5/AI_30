function openRentalModal() {
    var modalRoot = document.getElementById('modal-root');
    if (!modalRoot) return;
    fetch(window.contextPath + '/rental/modal/modal.jsp')
        .then(res => res.text())
        .then(html => {
            var tempDiv = document.createElement('div');
            tempDiv.innerHTML = html;
            var modalContent = tempDiv.querySelector('.modal-content');
            if (!modalContent) {
                modalRoot.innerHTML = '<div style="background:#fff;padding:2rem;border-radius:8px;max-width:500px;margin:2rem auto;color:red;font-weight:bold;">Không thể tải modal đăng ký thuê xe.<br>Kiểm tra lại đường dẫn hoặc lỗi server.</div>';
                modalRoot.style.display = 'block';
                return;
            }
            modalRoot.innerHTML = '';
            var backdrop = document.createElement('div');
            backdrop.className = 'modal-backdrop';
            backdrop.style.position = 'fixed';
            backdrop.style.top = 0;
            backdrop.style.left = 0;
            backdrop.style.width = '100vw';
            backdrop.style.height = '100vh';
            backdrop.style.background = 'rgba(0,0,0,0.35)';
            backdrop.style.zIndex = 1000;
            backdrop.style.cursor = 'pointer';
            backdrop.onclick = function() {
                closeRentalModal();
            };
            modalRoot.appendChild(backdrop);
            modalContent.style.zIndex = 1001;
            modalContent.style.margin = '0 auto';
            modalRoot.appendChild(modalContent);
            modalRoot.style.display = 'block';
            var rentalTypeSelect = modalContent.querySelector('#rentalTypeSelect');
            if (rentalTypeSelect) {
                rentalTypeSelect.selectedIndex = 0;
            }
            toggleRentalDateRow();
            var closeBtn = modalContent.querySelector('#modalCloseBtn');
            if (closeBtn) {
                closeBtn.addEventListener('click', function () {
                    closeRentalModal();
                });
            }
            backdrop.addEventListener('click', closeRentalModal);
            document.addEventListener('keydown', escCloseRentalModal);
            document.body.classList.add('modal-open');
        })
        .catch(function(err) {
            var modalRoot = document.getElementById('modal-root');
            if (modalRoot) {
                modalRoot.innerHTML = '<div style="background:#fff;padding:2rem;border-radius:8px;max-width:500px;margin:2rem auto;color:red;font-weight:bold;">Không thể tải modal đăng ký thuê xe.<br>Lỗi: ' + err + '</div>';
                modalRoot.style.display = 'block';
            }
        });
}

function closeRentalModal() {
    var modalRoot = document.getElementById('modal-root');
    if (modalRoot) {
        modalRoot.innerHTML = '';
        modalRoot.style.display = 'none';
    }
    document.body.classList.remove('modal-open');
    document.removeEventListener('keydown', escCloseRentalModal);
}

function escCloseRentalModal(e) {
    if (e.key === 'Escape') {
        closeRentalModal();
    }
}

function confirmRentalDate() {
    var rentalTypeSelect = document.getElementById('rentalTypeSelect');
    var pickupDateInput = document.querySelector('input[name="pickupDate"]');
    var pickupTimeInput = document.querySelector('input[name="pickupTime"]');
    var returnDateInput = document.querySelector('input[name="returnDate"]');
    var returnTimeInput = document.querySelector('input[name="returnTime"]');
    var rentalMonthsInput = document.querySelector('input[name="rentalMonths"]');
    var isDate = rentalTypeSelect.value === 'ngay';
    var isMonth = rentalTypeSelect.value === 'thang';

    if (!rentalTypeSelect.value) {
        alert('Vui lòng chọn hình thức thuê.');
        return;
    }

    if (isDate) {
        if (!pickupDateInput.value || !pickupTimeInput.value || !returnDateInput.value || !returnTimeInput.value) {
            alert('Vui lòng điền đầy đủ ngày và giờ nhận/trả xe.');
            return;
        }
        var pickupDate = new Date(pickupDateInput.value + 'T' + pickupTimeInput.value);
        var returnDate = new Date(returnDateInput.value + 'T' + returnTimeInput.value);
        if (pickupDate >= returnDate) {
            alert('Ngày trả xe phải sau ngày nhận xe.');
            return;
        }
    } else if (isMonth) {
        if (!pickupDateInput.value || !pickupTimeInput.value || !rentalMonthsInput.value) {
            alert('Vui lòng điền đầy đủ ngày nhận xe, giờ nhận xe và số tháng thuê.');
            return;
        }
        var months = parseInt(rentalMonthsInput.value, 10);
        if (isNaN(months) || months < 1 || months > 36) {
            alert('Số tháng thuê phải từ 1 đến 36.');
            return;
        }
    }

    // Gửi yêu cầu AJAX để tính giá
    $.ajax({
        url: '${pageContext.request.contextPath}/rental/calculate',
        type: 'POST',
        data: {
            modelId: '${carModel.id}',
            rentalType: rentalTypeSelect.value,
            pickupDate: pickupDateInput.value,
            returnDate: returnDateInput.value,
            rentalMonths: rentalMonthsInput.value
        },
        dataType: 'json',
        success: function (response) {
            if (response.error) {
                alert(response.error);
                return;
            }
            document.getElementById('rentalDays').textContent = response.rentalDays;
            document.getElementById('rentalDaysRow').style.display = response.rentalDays > 1 ? 'flex' : 'none';
            document.getElementById('totalRentalPrice').textContent = Number(response.totalRentalPrice).toLocaleString('vi-VN') + 'đ';
            document.getElementById('totalPayment').textContent = Number(response.totalPayment).toLocaleString('vi-VN') + 'đ';
            document.getElementById('paymentButtonAmount').textContent = Number(response.totalPayment).toLocaleString('vi-VN') + 'đ';
        },
        error: function () {
            alert('Lỗi khi tính toán giá. Vui lòng thử lại.');
        }
    });
}

function toggleRentalDateRow() {
    var select = document.getElementById('rentalTypeSelect');
    var dateRow = document.getElementById('rental-date-row');
    var pickupGroupCol = document.getElementById('pickup-group-col');
    var rentalMonthInput = document.getElementById('rental-month-input');
    var rentalMonthLabel = document.getElementById('rental-month-label');
    var rentalMonthCol = document.getElementById('rental-month-col');
    var returnDateCol = document.getElementById('return-date-col');
    var confirmRentalDateBtn = document.getElementById('confirmRentalDateBtn');

    if (!select) return;
    var isDate = select.value === 'ngay';
    var isMonth = select.value === 'thang';

    if (dateRow) dateRow.style.display = (isDate || isMonth) ? 'flex' : 'none';
    if (pickupGroupCol) pickupGroupCol.style.display = (isDate || isMonth) ? 'flex' : 'none';
    if (returnDateCol) returnDateCol.style.display = (isDate || isMonth) ? 'flex' : 'none';
    if (confirmRentalDateBtn) confirmRentalDateBtn.style.display = (isDate || isMonth) ? 'inline-block' : 'none';

    if (isMonth) {
        if (rentalMonthCol) rentalMonthCol.style.display = 'flex';
        if (rentalMonthInput) {
            rentalMonthInput.style.display = 'block';
            rentalMonthInput.required = true;
        }
        if (rentalMonthLabel) rentalMonthLabel.style.display = 'block';
    } else {
        if (rentalMonthCol) rentalMonthCol.style.display = 'none';
        if (rentalMonthInput) {
            rentalMonthInput.style.display = 'none';
            rentalMonthInput.required = false;
        }
        if (rentalMonthLabel) rentalMonthLabel.style.display = 'none';
    }

    var pickupDateInput = document.querySelector('input[name="pickupDate"]');
    var pickupTimeInput = document.querySelector('input[name="pickupTime"]');
    var returnDateInput = document.querySelector('input[name="returnDate"]');
    var returnTimeInput = document.querySelector('input[name="returnTime"]');
    var rentalMonthsInput = document.querySelector('input[name="rentalMonths"]');

    if (pickupTimeInput) {
        pickupTimeInput.min = '07:00';
        pickupTimeInput.max = '21:00';
    }
    if (returnTimeInput) {
        returnTimeInput.min = '07:00';
        returnTimeInput.max = '21:00';
    }

    function clampTime(input) {
        if (!input) return;
        if (input.value < '07:00') input.value = '07:00';
        if (input.value > '21:00') input.value = '21:00';
    }

    function setDefaultTime(input) {
        if (input && (!input.value || input.value < '07:00' || input.value > '21:00')) {
            input.value = '07:00';
        }
    }

    // Hàm định dạng ngày thành chuỗi YYYY-MM-DD
    function formatDate(date) {
        var yyyy = date.getFullYear();
        var mm = String(date.getMonth() + 1).padStart(2, '0');
        var dd = String(date.getDate()).padStart(2, '0');
        return yyyy + '-' + mm + '-' + dd;
    }

    // Hàm lấy ngày mai
    function getTomorrow() {
        var now = new Date();
        var tomorrow = new Date(now.getFullYear(), now.getMonth(), now.getDate() + 1);
        return formatDate(tomorrow);
    }

    // Hàm lấy ngày sau ngày được chọn
    function getNextDay(dateStr) {
        var date = new Date(dateStr);
        date.setDate(date.getDate() + 1);
        return formatDate(date);
    }

    if (isDate) {
        if (pickupDateInput && pickupTimeInput && returnDateInput && returnTimeInput) {
            var tomorrowStr = getTomorrow();
            pickupDateInput.min = tomorrowStr;
            if (!pickupDateInput.value || pickupDateInput.value < tomorrowStr) {
                pickupDateInput.value = tomorrowStr;
            }
            pickupTimeInput.value = '07:00';
            clampTime(pickupTimeInput);

            var returnMin = getNextDay(pickupDateInput.value);
            returnDateInput.min = returnMin;
            if (!returnDateInput.value || returnDateInput.value < returnMin) {
                returnDateInput.value = returnMin;
            }
            returnTimeInput.value = '07:00';
            clampTime(returnTimeInput);

            // Cập nhật min của returnDate khi pickupDate thay đổi
            pickupDateInput.onchange = function() {
                var nextDay = getNextDay(pickupDateInput.value);
                returnDateInput.min = nextDay;
                if (returnDateInput.value < nextDay) {
                    returnDateInput.value = nextDay;
                    returnTimeInput.value = pickupTimeInput.value || '07:00';
                    clampTime(returnTimeInput);
                }
            };

            pickupTimeInput.onchange = function() {
                clampTime(pickupTimeInput);
            };

            returnTimeInput.onchange = function() {
                clampTime(returnTimeInput);
            };
        }
    }

    if (isMonth) {
        if (pickupDateInput && pickupTimeInput && returnDateInput && returnTimeInput && rentalMonthsInput) {
            var tomorrowStr = getTomorrow();
            pickupDateInput.min = tomorrowStr;
            if (!pickupDateInput.value || pickupDateInput.value < tomorrowStr) {
                pickupDateInput.value = tomorrowStr;
            }

            setDefaultTime(pickupTimeInput);

            function updateReturnDateByMonths() {
                var months = parseInt(rentalMonthsInput.value, 10);
                if (isNaN(months) || months < 1) return;
                var pickupDateVal = pickupDateInput.value;
                var pickupTimeVal = pickupTimeInput.value || '07:00';
                if (!pickupDateVal) return;
                var parts = pickupDateVal.split('-');
                var y = parseInt(parts[0], 10);
                var m = parseInt(parts[1], 10) - 1;
                var d = parseInt(parts[2], 10);
                var pickupDateObj = new Date(y, m, d);
                var returnDateObj = new Date(pickupDateObj.getFullYear(), pickupDateObj.getMonth() + months, pickupDateObj.getDate());
                var returnStr = formatDate(returnDateObj);
                returnDateInput.value = returnStr;
                returnTimeInput.value = pickupTimeVal;
                clampTime(returnTimeInput);
                returnDateInput.min = returnStr;
            }

            // Cập nhật min của returnDate khi pickupDate thay đổi
            pickupDateInput.onchange = function() {
                var nextDay = getNextDay(pickupDateInput.value);
                returnDateInput.min = nextDay;
                updateReturnDateByMonths();
            };

            rentalMonthsInput.oninput = updateReturnDateByMonths;
            pickupTimeInput.onchange = function() {
                clampTime(pickupTimeInput);
                updateReturnDateByMonths();
            };

            updateReturnDateByMonths();
        }
    }

    if (isMonth) {
        if (returnDateInput) {
            returnDateInput.readOnly = true;
            returnDateInput.tabIndex = -1;
        }
        if (returnTimeInput) {
            returnTimeInput.readOnly = true;
            returnTimeInput.tabIndex = -1;
        }
    } else {
        if (returnDateInput) {
            returnDateInput.readOnly = false;
            returnDateInput.tabIndex = 0;
        }
        if (returnTimeInput) {
            returnTimeInput.readOnly = false;
            returnTimeInput.tabIndex = 0;
        }
    }

    if (pickupTimeInput) {
        pickupTimeInput.addEventListener('change', function() {
            clampTime(pickupTimeInput);
        });
    }
    if (returnTimeInput) {
        returnTimeInput.addEventListener('change', function() {
            clampTime(returnTimeInput);
        });
    }
}

(function() {
    if (!window.contextPath) {
        var pathArr = window.location.pathname.split('/');
        window.contextPath = pathArr.length > 1 && pathArr[1] ? '/' + pathArr[1] : '';
    }
    document.addEventListener('DOMContentLoaded', function() {
        toggleRentalDateRow();
    });
})();