// modal-updated.js - Tích hợp modal từ ai_for_se vào tvtfuture (Java backend)

document.addEventListener('DOMContentLoaded', function() {
    // --- LOGIC CHECKBOX VÀ NÚT THANH TOÁN ---
    const checkbox1 = document.getElementById('terms');
    const checkbox2 = document.getElementById('term-data');
    const payBtn = document.getElementById('pay-btn');

    function updatePayBtn() {
        if (checkbox1.checked && checkbox2.checked) {
            payBtn.disabled = false;
            payBtn.classList.remove('bg-gray-300', 'text-gray-500', 'cursor-not-allowed');
            payBtn.classList.add('bg-green-500', 'text-white', 'cursor-pointer', 'hover:bg-green-600');
        } else {
            payBtn.disabled = true;
            payBtn.classList.add('bg-gray-300', 'text-gray-500', 'cursor-not-allowed');
            payBtn.classList.remove('bg-green-500', 'text-white', 'cursor-pointer', 'hover:bg-green-600');
        }
    }
    
    if (checkbox1) checkbox1.addEventListener('change', updatePayBtn);
    if (checkbox2) checkbox2.addEventListener('change', updatePayBtn);
    updatePayBtn(); // Initialize button state

    // Populate user info from session (JSP sẽ inject data)
    populateUserInfo();

    // --- POPULATE USER INFO ---
    function populateUserInfo() {
        // Lấy thông tin từ session attribute (được set bởi Java backend)
        const currentUser = window.currentUserData; // Will be injected by JSP
        
        if (currentUser) {
            const nameField = document.getElementById('fullname');
            const phoneField = document.getElementById('phone');
            const emailField = document.getElementById('email');
            const addressField = document.getElementById('address');
            
            if (nameField && currentUser.name) nameField.value = currentUser.name;
            if (phoneField && currentUser.phone) phoneField.value = currentUser.phone;
            if (emailField && currentUser.email) emailField.value = currentUser.email;
            if (addressField && currentUser.address) addressField.value = currentUser.address;
        }
    }

    // --- LOGIC DROPDOWN ĐỊA CHỈ ---
    const pickupTrigger = document.getElementById('pickup-trigger');
    const pickupDropdown = document.getElementById('pickup-dropdown');
    const pickupSelected = document.getElementById('pickup-selected');
    const pickupInput = document.getElementById('pickup-location-input');
    const pickupOptions = pickupDropdown.querySelectorAll('.pickup-option');

    if (pickupTrigger && pickupDropdown && pickupSelected && pickupOptions) {
        pickupTrigger.addEventListener('click', function (e) {
            e.stopPropagation();
            pickupDropdown.classList.toggle('hidden');
        });
        
        pickupOptions.forEach(function(option) {
            option.addEventListener('click', function() {
                const value = this.getAttribute('data-value');
                pickupSelected.textContent = value;
                pickupSelected.classList.remove('text-gray-500');
                pickupSelected.classList.add('text-gray-900');
                pickupInput.value = value;
                pickupDropdown.classList.add('hidden');
            });
        });
        
        document.addEventListener('click', function (e) {
            if (!pickupTrigger.contains(e.target) && !pickupDropdown.contains(e.target)) {
                pickupDropdown.classList.add('hidden');
            }
        });
    }

    /* --- SCRIPT ĐIỀU KHIỂN MODAL --- */

    // Lấy iframe của modal con (pick-time)
    const pickTimeIframe = document.getElementById('pick-time-iframe');

    // Biến lưu giá gốc và cọc của xe hiện tại
    let currentCarBasePrice = 0;
    let currentRentalPricePerMonth = 0;
    let currentDepositPerDay = 0;
    let currentDepositPerMonth = 0;
    let currentRentalDuration = 1; // Mặc định là 1 ngày/tháng
    let currentRentalUnit = 'day'; // 'day' or 'month'

    // Hàm tiện ích để định dạng tiền
    function formatCurrency(num) {
        if (isNaN(num)) return '0đ';
        return new Intl.NumberFormat('vi-VN').format(num) + 'đ';
    }

    // Hàm tiện ích để parse ngày DD/MM/YYYY
    function parseDate(dateStr) {
        const parts = dateStr.split('/');
        if (parts.length === 3) {
            const day = parseInt(parts[0], 10);
            const month = parseInt(parts[1], 10) - 1;
            const year = parseInt(parts[2], 10);
            return new Date(year, month, day);
        }
        return null;
    }

    // Hàm tính số ngày giữa 2 date string (DD/MM/YYYY)
    function calculateDaysDifference(startDateStr, endDateStr) {
        const startDate = parseDate(startDateStr);
        const endDate = parseDate(endDateStr);
        if (!startDate || !endDate || endDate <= startDate) {
            return 1; // Ít nhất 1 ngày
        }
        const diffTime = Math.abs(endDate - startDate);
        const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));
        return diffDays;
    }

    // Hàm cập nhật bảng giá
    function updatePriceTable(duration, unit, basePricePerUnit, deposit) {
        const totalBasePrice = basePricePerUnit * duration;
        const voucher = 0; // Tạm thời
        const finalPayment = totalBasePrice + deposit - voucher;

        document.getElementById('modal-base-price').textContent = formatCurrency(basePricePerUnit);
        document.getElementById('modal-total-price').textContent = formatCurrency(totalBasePrice);
        document.getElementById('modal-deposit-price').textContent = formatCurrency(deposit);
        document.getElementById('modal-voucher-price').textContent = formatCurrency(voucher);
        document.getElementById('modal-final-payment').textContent = formatCurrency(finalPayment);
        document.getElementById('modal-payment-amount').textContent = formatCurrency(finalPayment);
        
        // Cập nhật hidden input để gửi về backend
        document.getElementById('total-price').value = finalPayment;
        document.getElementById('rental-duration').value = duration;
        document.getElementById('rental-type').value = unit;
    }

    // Hàm đóng modal CHÍNH
    function closeModal() {
        const modalBg = document.querySelector('.modal-bg');
        if (modalBg) {
            modalBg.style.display = 'none';
        }
        // Gửi message về parent window nếu modal được mở trong iframe
        if (window.parent !== window) {
            window.parent.postMessage({ action: 'closeModal' }, '*');
        }
    }

    // 1. Bấm nút "X" để đóng modal CHÍNH
    const closeBtn = document.getElementById('close-modal-btn');
    if (closeBtn) {
        closeBtn.addEventListener('click', closeModal);
    }

    // 2. Bấm vào nền mờ để đóng modal CHÍNH
    const modalBg = document.querySelector('.modal-bg');
    if (modalBg) {
        modalBg.addEventListener('click', function(e) {
            if (e.target === modalBg) {
                closeModal();
            }
        });
    }

    // 3. Bấm vào box SỬA THÔNG TIN THUÊ
    const editTimeTrigger = document.getElementById('edit-time-trigger');
    if (editTimeTrigger && pickTimeIframe) {
        editTimeTrigger.addEventListener('click', () => {
            pickTimeIframe.style.display = 'block';
        });
    }

    // 4. Lắng nghe data từ IFRAME pick-time
    window.addEventListener('message', (event) => {
        const data = event.data;

        // Nhận data từ car-detail (thông tin xe)
        if (data.action === 'openRentalModal' && data.carData) {
            const car = data.carData;
            
            // Cập nhật thông tin xe
            document.getElementById('modal-car-name').textContent = car.name || 'Tên xe';
            document.getElementById('modal-car-type').textContent = car.type || 'Loại xe';
            
            const carImage = document.getElementById('modal-car-image');
            if (carImage && car.image) {
                carImage.src = car.image;
            }
            
            // Lưu giá xe
            currentCarBasePrice = parseFloat(car.pricePerDay) || 0;
            currentRentalPricePerMonth = parseFloat(car.pricePerMonth) || 0;
            currentDepositPerDay = parseFloat(car.depositPerDay) || 0;
            currentDepositPerMonth = parseFloat(car.depositPerMonth) || 0;
            
            // Hiển thị modal
            if (modalBg) {
                modalBg.style.display = 'flex';
            }
            
            // Khởi tạo giá mặc định (1 ngày)
            updatePriceTable(1, 'day', currentCarBasePrice, currentDepositPerDay);
        }

        // Nhận data từ pick-time iframe (đã chọn thời gian)
        if (data.action === 'confirmRental' && data.rentalData) {
            const rental = data.rentalData;
            
            // Cập nhật hiển thị ngày
            const displayText = rental.rentalType === 'day' 
                ? `${rental.startDate} ${rental.startTime} - ${rental.endDate} ${rental.endTime}`
                : `${rental.startDate} (${rental.duration} tháng)`;
            
            document.getElementById('rental-date-display').textContent = displayText;
            
            // Cập nhật hidden inputs
            document.getElementById('pickup-date').value = rental.startDate;
            document.getElementById('return-date').value = rental.endDate;
            document.getElementById('pickup-time').value = rental.startTime;
            document.getElementById('return-time').value = rental.returnTime;
            document.getElementById('rental-type').value = rental.rentalType;
            
            // Tính giá
            let duration, unit, basePrice, deposit;
            
            if (rental.rentalType === 'day') {
                duration = calculateDaysDifference(rental.startDate, rental.endDate);
                unit = 'day';
                basePrice = currentCarBasePrice;
                deposit = currentDepositPerDay;
            } else {
                duration = parseInt(rental.duration) || 1;
                unit = 'month';
                basePrice = currentRentalPricePerMonth;
                deposit = currentDepositPerMonth;
            }
            
            currentRentalDuration = duration;
            currentRentalUnit = unit;
            
            // Cập nhật bảng giá
            updatePriceTable(duration, unit, basePrice, deposit);
            
            // Đóng iframe pick-time
            if (pickTimeIframe) {
                pickTimeIframe.style.display = 'none';
            }
        }

        // Nhận message đóng pick-time modal
        if (data.action === 'closePickTime') {
            if (pickTimeIframe) {
                pickTimeIframe.style.display = 'none';
            }
        }
    });

    // Xử lý submit form
    const rentalForm = document.getElementById('rental-form');
    if (rentalForm) {
        rentalForm.addEventListener('submit', function(e) {
            // Validate form trước khi submit
            const pickupDate = document.getElementById('pickup-date').value;
            const returnDate = document.getElementById('return-date').value;
            
            if (!pickupDate || !returnDate) {
                e.preventDefault();
                alert('Vui lòng chọn thời gian thuê xe!');
                return false;
            }
            
            if (!pickupInput.value) {
                e.preventDefault();
                alert('Vui lòng chọn địa điểm nhận xe!');
                return false;
            }
            
            // Form sẽ được submit về Java backend
            console.log('Submitting rental form to backend...');
        });
    }
});
