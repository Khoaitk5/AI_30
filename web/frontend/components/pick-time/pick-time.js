// Biến toàn cục để lưu instance
let rentalFormInstance = null;
// Biến toàn cục cho lịch
let currentCalendarDate = new Date(); // Dùng cho state của calendar
let year1 = currentCalendarDate.getFullYear();
let month1 = currentCalendarDate.getMonth();
let year2 = month1 === 11 ? year1 + 1 : year1;
let month2 = (month1 + 1) % 12;

class RentalForm {
    constructor() {
        this.currentTab = 'day';
        this.monthDuration = 1;
        this.currentPickerType = null; // 'pickup-date', 'return-date', 'pickup-time', 'return-time'

        this.currentDate = new Date(); // Ngày hiện tại thực tế

        // Ngày giờ đã chọn (lưu trữ dưới dạng đối tượng Date / string)
        this.selectedStartDate = null;
        this.selectedEndDate = null;
        this.selectedPickupTime = "10:00"; // Giờ mặc định
        this.selectedReturnTime = "10:00"; // Giờ mặc định

        // --- STATE CHO TIME PICKER MODAL ---
        this.modalSelectedHour = '10';
        this.modalSelectedMinute = '00';
        this.modalHoursScrollY = 25;
        this.modalMinutesScrollY = 25;
        this.modalItemHeight = 50;
        this.modalContainerHeight = 300;
        this.modalSelectionZoneTop = (this.modalContainerHeight / 2) - (this.modalItemHeight / 2);
        this.modalSelectionZoneBottom = (this.modalContainerHeight / 2) + (this.modalItemHeight / 2);
        // --- END STATE CHO TIME PICKER MODAL ---

        this.init();
    }

    init() {
        this.initializeDates();
        this.setActiveTab('day'); // Đặt tab mặc định là 'day'
        this.bindEvents();
        renderCalendars(); // Render lịch lần đầu sau khi init xong
    }

    initializeDates() {
        // Set default pickup date to today
        this.selectedStartDate = new Date(Date.UTC(this.currentDate.getFullYear(), this.currentDate.getMonth(), this.currentDate.getDate()));
        // Set default return date to tomorrow
        this.selectedEndDate = new Date(Date.UTC(this.currentDate.getFullYear(), this.currentDate.getMonth(), this.currentDate.getDate() + 1));

        // Update display spans
        document.getElementById('pickup-date').textContent = this.formatDate(this.selectedStartDate);
        document.getElementById('return-date').textContent = this.formatDate(this.selectedEndDate);

        // Set default times (lấy từ thuộc tính)
        document.getElementById('pickup-time').textContent = this.selectedPickupTime;
        document.getElementById('return-time').textContent = this.selectedReturnTime;
    }

    setActiveTab(tab) {
        if (this.currentTab === 'month') {
            this.monthDuration = parseInt(document.getElementById('duration-input').value) || 1;
        }

        this.currentTab = tab;

        document.querySelectorAll('.tab-btn').forEach(btn => {
            btn.classList.toggle('active', btn.dataset.tab === tab);
        });

        const durationInput = document.querySelector('.duration-input');
        const durationInputField = document.getElementById('duration-input');

        if (tab === 'month') {
            durationInput.classList.remove('hidden');
            durationInput.classList.add('show');
            durationInputField.value = this.monthDuration;
            this.updateReturnDate(); // Cập nhật ngày trả theo tháng
        } else { // 'day' tab
            durationInput.classList.add('hidden');
            durationInput.classList.remove('show');
             if (!this.selectedEndDate || this.selectedEndDate <= this.selectedStartDate) {
                this.selectedEndDate = getNextDay(this.selectedStartDate);
             }
             document.getElementById('return-date').textContent = this.formatDate(this.selectedEndDate);
             this.validateDateRange(); // Kiểm tra lại khoảng ngày
        }
        this.updateReturnControls(); // Cập nhật trạng thái disable/enable
        renderCalendars(); // Render lại lịch khi đổi tab
    }

    validateDateRange() {
        if (this.currentTab === 'day' && this.selectedStartDate && this.selectedEndDate) {
            const daysDiff = Math.ceil((this.selectedEndDate - this.selectedStartDate) / (1000 * 60 * 60 * 24));

            if (daysDiff <= 0) {
                 console.warn("Validation: Return date <= Pickup date. Resetting return date.");
                 this.selectedEndDate = getNextDay(this.selectedStartDate);
                 document.getElementById('return-date').textContent = this.formatDate(this.selectedEndDate);
                 renderCalendars();
            } else if (daysDiff > 30) {
                 const maxReturnDate = new Date(this.selectedStartDate);
                 maxReturnDate.setDate(maxReturnDate.getDate() + 30);
                 this.selectedEndDate = maxReturnDate;
                 document.getElementById('return-date').textContent = this.formatDate(this.selectedEndDate);
                 alert("Thuê ngày chỉ hỗ trợ tối đa 30 ngày.");
                 renderCalendars();
            }
        }
    }

    parseDate(dateStr) {
        const parts = dateStr.split('/');
        if (parts.length === 3) {
            const dt = new Date(parseInt(parts[2]), parseInt(parts[1]) - 1, parseInt(parts[0]));
            if (!isNaN(dt.getTime())) {
                dt.setHours(0, 0, 0, 0);
                return dt;
            }
        }
        console.error("Could not parse date:", dateStr);
        return null;
    }


    bindEvents() {
        // Tab switching
        document.querySelectorAll('.tab-btn').forEach(btn => {
            btn.addEventListener('click', (e) => this.setActiveTab(e.target.dataset.tab));
        });

        // Date pickers
        document.querySelectorAll('.date-picker').forEach(picker => {
            picker.addEventListener('click', (e) => {
                 if (!e.currentTarget.classList.contains('disabled')) {
                     this.openDatePicker(e.currentTarget.dataset.picker);
                 }
            });
        });

         // Time pickers
        document.querySelectorAll('.time-picker').forEach(picker => {
            picker.addEventListener('click', (e) => {
                 if (!e.currentTarget.classList.contains('disabled')) {
                    this.openTimePicker(e.currentTarget.dataset.picker);
                 }
            });
        });

        // Lịch: đóng khi click ra ngoài modal
        document.getElementById('calendar-modal').addEventListener('click', (e) => {
            if (e.target === e.currentTarget) this.closeDatePicker();
        });

         // Lịch: nút chuyển tháng
         document.getElementById("prev-month-btn").addEventListener("click", () => this.changeMonth(-1));
         document.getElementById("next-month-btn").addEventListener("click", () => this.changeMonth(1));

         // Lịch: Click vào ngày (delegated)
         document.getElementById('calendar-body-1').addEventListener('click', handleDayClick);
         document.getElementById('calendar-body-2').addEventListener('click', handleDayClick);

        // Form submission
        document.getElementById('rental-booking-form').addEventListener('submit', (e) => {
            e.preventDefault();
            this.handleSubmit();
        });

        // Nút Hủy (Form chính)
        document.getElementById('cancel-pick-time').addEventListener('click', () => this.handleCancel());

        // Đóng Form chính khi click ra ngoài wrapper
        document.getElementById('pick-time-wrapper').addEventListener('click', () => this.handleCancel());

        // Duration input
        document.getElementById('duration-input').addEventListener('input', (e) => {
            this.validateDurationInput(e.target);
            this.updateReturnDate();
        });
        document.getElementById('duration-input').addEventListener('keydown', (e) => {
            if (!((e.keyCode >= 48 && e.keyCode <= 57) ||
                  (e.keyCode >= 96 && e.keyCode <= 105) ||
                  [8, 9, 13, 27, 37, 39, 46].includes(e.keyCode) ||
                  (e.ctrlKey === true && [65, 67, 86, 88].includes(e.keyCode))
                 )) {
                e.preventDefault();
            }
        });

        // --- BIND EVENTS CHO TIME PICKER MODAL ---
        const hoursColumnModal = document.getElementById('hours-column-modal');
        const minutesColumnModal = document.getElementById('minutes-column-modal');

        // Click vào giờ/phút trong modal
        hoursColumnModal.addEventListener('click', (e) => this.handleTimeModalClick(e, 'hour'));
        minutesColumnModal.addEventListener('click', (e) => this.handleTimeModalClick(e, 'minute'));

        // Scroll giờ/phút trong modal
        hoursColumnModal.addEventListener('wheel', (e) => this.handleTimeModalScroll(e, 'hour'));
        minutesColumnModal.addEventListener('wheel', (e) => this.handleTimeModalScroll(e, 'minute'));

        // Nút trong time picker modal
        document.querySelector('.timepicker-confirm-btn').addEventListener('click', () => this.confirmTimePicker());
        document.querySelector('.timepicker-cancel-btn').addEventListener('click', () => this.closeTimePicker());
        // --- KẾT THÚC BIND EVENTS CHO TIME PICKER MODAL ---
    }


    updateReturnControls() {
        const returnDatePicker = document.getElementById('return-date-picker');
        const returnTimePicker = document.getElementById('return-time-picker');
        const isDisabled = (this.currentTab === 'month');

        returnDatePicker.classList.toggle('disabled', isDisabled);
        returnTimePicker.classList.toggle('disabled', isDisabled);
    }

    // --- MỞ TIME PICKER MODAL ---
    openTimePicker(pickerType) {
        this.currentPickerType = pickerType; // Lưu loại picker đang mở
        const currentSpanId = pickerType.replace('-picker', ''); // pickup-time or return-time
        const currentTime = document.getElementById(currentSpanId).textContent;
        const [hour, minute] = currentTime.split(':');

        // Set state ban đầu cho modal dựa trên giá trị hiện tại
        this.modalSelectedHour = hour;
        this.modalSelectedMinute = minute;

        // Render lại UI của modal time picker
        this.initializeTimePickerUI();

        // Hiển thị modal
        document.getElementById('time-picker-modal').classList.remove('hidden');
    }

    // --- ĐÓNG TIME PICKER MODAL ---
    closeTimePicker() {
        document.getElementById('time-picker-modal').classList.add('hidden');
        this.currentPickerType = null; // Reset loại picker
    }

    // --- XÁC NHẬN TIME PICKER MODAL ---
    confirmTimePicker() {
        const newTime = `${this.modalSelectedHour}:${this.modalSelectedMinute}`;
        const targetSpanId = this.currentPickerType.replace('-picker', ''); // pickup-time or return-time

        // Cập nhật giá trị hiển thị trên form chính
        document.getElementById(targetSpanId).textContent = newTime;

        // Cập nhật giá trị nội bộ của RentalForm instance
        if (this.currentPickerType === 'pickup-time') {
            this.selectedPickupTime = newTime;
        } else if (this.currentPickerType === 'return-time') {
            this.selectedReturnTime = newTime;
        }

        this.closeTimePicker(); // Đóng modal sau khi xác nhận
    }
    // --- KẾT THÚC HÀM XỬ LÝ TIME PICKER MODAL ---

    openDatePicker(pickerType) {
        this.currentPickerType = pickerType;
        document.getElementById('calendar-modal').classList.remove('hidden');
    }

    closeDatePicker() {
        document.getElementById('calendar-modal').classList.add('hidden');
        this.currentPickerType = null;
    }

    changeMonth(direction) {
        const now = new Date();
        now.setHours(0,0,0,0);
        const currentFirstMonth = new Date(year1, month1, 1);

        if (direction === -1 && currentFirstMonth <= now) {
            console.log("Cannot go to previous month.");
            return;
        }

        month1 += direction;
        if (month1 < 0) {
            month1 = 11;
            year1--;
        } else if (month1 > 11) {
            month1 = 0;
            year1++;
        }

        year2 = month1 === 11 ? year1 + 1 : year1;
        month2 = (month1 + 1) % 12;

        console.log("Changing month to:", year1, month1, "|", year2, month2);
        renderCalendars();
    }

    updateReturnDate() {
        if (this.currentTab !== 'month' || !this.selectedStartDate) return;

        const duration = parseInt(document.getElementById('duration-input').value) || 1;
        let returnDate = new Date(this.selectedStartDate);

        returnDate.setUTCMonth(returnDate.getUTCMonth() + duration);
        if (returnDate.getUTCDate() < this.selectedStartDate.getUTCDate()) {
             returnDate.setUTCDate(0);
        }

        this.selectedEndDate = returnDate;
        document.getElementById('return-date').textContent = this.formatDate(returnDate);
        renderCalendars();
    }

    formatDate(date) {
        if (!date || isNaN(date.getTime())) return "Invalid Date";
        try {
            const day = String(date.getUTCDate()).padStart(2, '0');
            const month = String(date.getUTCMonth() + 1).padStart(2, '0');
            const year = date.getUTCFullYear();
            return `${day}/${month}/${year}`;
        } catch (e) {
            console.error("Error formatting date:", date, e);
            return "Error";
        }
    }

    validateDurationInput(input) {
        let value = parseInt(input.value);
        const max = parseInt(input.max) || 12;
        const min = parseInt(input.min) || 1;

        if (input.value === "") {
             if (this.currentTab === 'month') this.monthDuration = min;
             return;
        }

        if (isNaN(value)) {
             value = min;
        } else if (value < min) {
            value = min;
        } else if (value > max) {
            value = max;
        }

        if (parseInt(input.value) !== value || isNaN(parseInt(input.value)) ) {
            input.value = value;
        }

        if (this.currentTab === 'month') {
            this.monthDuration = value;
        }
    }

    handleCancel() {
        window.parent.postMessage({ type: 'closePickTime' }, '*');
    }

    handleSubmit() {
         this.validateDurationInput(document.getElementById('duration-input'));

        const formData = {
            rentalType: this.currentTab,
            pickupDate: this.formatDate(this.selectedStartDate),
            pickupTime: this.selectedPickupTime,
            returnDate: this.formatDate(this.selectedEndDate),
            returnTime: this.selectedReturnTime
        };

        if (this.currentTab === 'month') {
            formData.duration = this.monthDuration;
        }

        if(formData.pickupDate === "Invalid Date" || formData.returnDate === "Invalid Date") {
             alert("Ngày chọn không hợp lệ. Vui lòng kiểm tra lại.");
             return;
        }

        console.log("Submitting data:", formData);
        window.parent.postMessage({
            type: 'updateRentalTime',
            data: formData
        }, '*');
    }

    // --- CÁC HÀM TỪ time.js ĐÃ ĐƯỢC CHUYỂN THÀNH METHOD ---

    initializeTimePickerUI() {
        // Render giờ và phút cho modal
        this.generateTimeOptionsModal();
    }

    generateTimeOptionsModal() {
        const hoursColumnModal = document.getElementById('hours-column-modal');
        const hoursHTML = [];
        for (let hour = 7; hour <= 21; hour++) {
            const hourStr = hour.toString().padStart(2, '0');
            const isSelected = hourStr === this.modalSelectedHour;
            const className = isSelected ? 'cursor-pointer text-brand-primary font-bold' : 'cursor-pointer text-heading-secondary';
            hoursHTML.push(`
                <div style="height: ${this.modalItemHeight}px; display: flex; justify-content: center; align-items: center;">
                    <div class="${className}" data-value="${hourStr}">${hourStr}</div>
                </div>
            `);
        }
        hoursColumnModal.innerHTML = hoursHTML.join('');

        // Set initial scroll position for hours column in modal
        const hourIndex = parseInt(this.modalSelectedHour) - 7;
        this.modalHoursScrollY = 25 - (hourIndex - 2) * this.modalItemHeight;
        hoursColumnModal.style.transform = `translate3d(0px, ${this.modalHoursScrollY}px, 0px)`;

        // Generate minutes based on selected hour
        this.generateMinutesModal();
    }

    generateMinutesModal() {
        const minutesColumnModal = document.getElementById('minutes-column-modal');
        const minutesHTML = [];
        const maxMinute = this.modalSelectedHour === '21' ? 0 : 55;

        for (let minute = 0; minute <= maxMinute; minute += 5) {
            const minuteStr = minute.toString().padStart(2, '0');
            const isSelected = minuteStr === this.modalSelectedMinute;
            const className = isSelected ? 'cursor-pointer text-brand-primary font-bold' : 'cursor-pointer text-heading-secondary';
            minutesHTML.push(`
                <div style="height: ${this.modalItemHeight}px; display: flex; justify-content: center; align-items: center;">
                    <div class="${className}" data-value="${minuteStr}">${minuteStr}</div>
                </div>
            `);
        }
        minutesColumnModal.innerHTML = minutesHTML.join('');

        // Handle minute selection based on hour
        if (this.modalSelectedHour === '21') {
            this.modalSelectedMinute = '00';
            this.modalMinutesScrollY = 25 - (0 - 2) * this.modalItemHeight;
        } else {
            const minuteIndex = parseInt(this.modalSelectedMinute) / 5;
            if (minuteIndex * 5 > maxMinute) {
                this.modalSelectedMinute = '00';
                this.modalMinutesScrollY = 25 - (0 - 2) * this.modalItemHeight;
            } else {
                 // Check if index is valid before calculating scroll
                 const numMinuteItems = Math.floor(maxMinute / 5) + 1;
                 if (minuteIndex >= 0 && minuteIndex < numMinuteItems) {
                    this.modalMinutesScrollY = 25 - (minuteIndex - 2) * this.modalItemHeight;
                 } else {
                     // Fallback if index somehow becomes invalid
                     this.modalSelectedMinute = '00';
                     this.modalMinutesScrollY = 25 - (0 - 2) * this.modalItemHeight;
                 }
            }
        }

        minutesColumnModal.style.transform = `translate3d(0px, ${this.modalMinutesScrollY}px, 0px)`;
        // Update the styling for the selected minute
        this.updateSelectionModal('minute', this.modalSelectedMinute);
    }

     handleTimeModalClick(e, type) { // type is 'hour' or 'minute'
        const column = type === 'hour' ? document.getElementById('hours-column-modal') : document.getElementById('minutes-column-modal');
        const itemDiv = e.target.closest('div[style*="height: 50px"]');

        if (itemDiv && itemDiv.firstElementChild) {
            const value = itemDiv.firstElementChild.dataset.value;
            const items = Array.from(column.children);
            const clickedIndex = items.indexOf(itemDiv);

            if (clickedIndex !== -1) {
                const newScrollY = 25 - (clickedIndex - 2) * this.modalItemHeight;
                column.style.transform = `translate3d(0px, ${newScrollY}px, 0px)`;

                if (type === 'hour') {
                    const oldHour = this.modalSelectedHour;
                    this.modalSelectedHour = value;
                    this.modalHoursScrollY = newScrollY;
                    this.updateSelectionModal('hour', value);
                    if (oldHour !== value) {
                        this.generateMinutesModal(); // Regenerate minutes if hour changed
                    }
                } else {
                    this.modalSelectedMinute = value;
                    this.modalMinutesScrollY = newScrollY;
                    this.updateSelectionModal('minute', value);
                }
            }
        }
    }


    handleTimeModalScroll(e, type) { // type is 'hour' or 'minute'
        e.preventDefault();
        const column = type === 'hour' ? document.getElementById('hours-column-modal') : document.getElementById('minutes-column-modal');
        let currentScrollY = type === 'hour' ? this.modalHoursScrollY : this.modalMinutesScrollY;
        const items = column.children;
        const direction = e.deltaY > 0 ? 1 : -1; // 1 for down, -1 for up

        const currentIndex = Math.round((25 - currentScrollY) / this.modalItemHeight) + 2;
        let newIndex = currentIndex + direction;
        newIndex = Math.max(0, Math.min(items.length - 1, newIndex)); // Clamp index

        const newScrollY = 25 - (newIndex - 2) * this.modalItemHeight;
        column.style.transform = `translate3d(0px, ${newScrollY}px, 0px)`;

        const selectedItem = items[newIndex];
        if (selectedItem && selectedItem.firstElementChild) {
            const value = selectedItem.firstElementChild.dataset.value;
            if (type === 'hour') {
                const oldHour = this.modalSelectedHour;
                this.modalSelectedHour = value;
                this.modalHoursScrollY = newScrollY;
                this.updateSelectionModal('hour', value);
                 if (oldHour !== value) {
                    this.generateMinutesModal(); // Regenerate minutes if hour changed
                }
            } else {
                this.modalSelectedMinute = value;
                this.modalMinutesScrollY = newScrollY;
                this.updateSelectionModal('minute', value);
            }
        }
    }


    updateSelectionModal(type, value) { // type is 'hour' or 'minute'
        const column = type === 'hour' ? document.getElementById('hours-column-modal') : document.getElementById('minutes-column-modal');
        const items = column.querySelectorAll('div[style*="height: 50px"] > div');

        items.forEach(item => {
            if (item.dataset.value === value) {
                item.className = 'cursor-pointer text-brand-primary font-bold';
            } else {
                item.className = 'cursor-pointer text-heading-secondary';
            }
        });
    }

    // --- KẾT THÚC CÁC METHOD TỪ time.js ---

}

// --- CODE LỊCH (GIỮ NGUYÊN) ---

const MONTHS = [
    "Tháng Một", "Tháng Hai", "Tháng Ba", "Tháng Tư", "Tháng Năm", "Tháng Sáu",
    "Tháng Bảy", "Tháng Tám", "Tháng Chín", "Tháng Mười", "Tháng Mười Một", "Tháng Mười Hai"
];

function getDaysInMonth(year, month) {
    return new Date(year, month + 1, 0).getDate();
}

function getFirstDayOfWeek(year, month) {
    let day = new Date(year, month, 1).getDay();
    return (day === 0) ? 6 : day - 1;
}

function renderCalendar(year, month, tbodyId, captionId) {
    const daysInMonth = getDaysInMonth(year, month);
    const firstDay = getFirstDayOfWeek(year, month);
    const tbody = document.getElementById(tbodyId);
    const caption = document.getElementById(captionId);

    if (!tbody || !caption) {
        console.error("Calendar elements not found:", tbodyId, captionId);
        return;
    }

    caption.textContent = `${MONTHS[month]} ${year}`;
    tbody.innerHTML = "";

    const today = new Date(Date.UTC(currentCalendarDate.getFullYear(), currentCalendarDate.getMonth(), currentCalendarDate.getDate()));
    const startDate = (rentalFormInstance && rentalFormInstance.selectedStartDate instanceof Date) ? rentalFormInstance.selectedStartDate : null;
    const endDate = (rentalFormInstance && rentalFormInstance.selectedEndDate instanceof Date) ? rentalFormInstance.selectedEndDate : null;

    console.log(`Rendering Calendar ${captionId}:`, { year, month, startDate, endDate });

    let day = 1;
    for (let row = 0; row < 6; row++) {
        const tr = document.createElement("tr");
        tr.className = "flex w-full mt-2 justify-center";
        for (let col = 0; col < 7; col++) {
            const td = document.createElement("td");
            td.className = "size-10 text-center text-sm p-0 relative focus-within:relative focus-within:z-20";
            td.setAttribute("role", "presentation");

            if ((row === 0 && col < firstDay) || day > daysInMonth) {
                td.innerHTML = '<div role="gridcell" class="size-10"></div>';
            } else {
                const currentDate = new Date(Date.UTC(year, month, day));
                const isPast = currentDate < today;

                const btn = document.createElement("button");
                btn.name = "day";
                btn.type = "button";
                btn.setAttribute("role", "gridcell");
                 btn.dataset.date = currentDate.toISOString().split('T')[0]; // YYYY-MM-DD
                btn.tabIndex = -1;
                let btnClasses = [
                    "rdp-button_reset", "rdp-button", "inline-flex", "items-center", "justify-center",
                    "text-center", "font-[Mulish]", "text-[14px]", "leading-[21px]",
                    "transition-colors", "focus-visible:outline-none", "focus-visible:ring-1", "focus-visible:ring-ring",
                    "size-10", "p-0", "font-normal", "rounded-[6px]"
                ];

                if (isPast) {
                    btnClasses.push("disabled:pointer-events-none", "disabled:opacity-50", "text-gray-400", "cursor-not-allowed");
                    btn.disabled = true;
                } else {
                     btnClasses.push("hover:bg-[#E0F5E0]", "hover:text-[#374151]", "text-[#020617]");
                }

                btn.textContent = day;

                let isRangeStart = false;
                let isRangeEnd = false;
                let isInRange = false;
                let isSingleDaySelection = false;

                if (startDate && endDate) {
                     if (startDate.getTime() === endDate.getTime() && currentDate.getTime() === startDate.getTime()) {
                         isSingleDaySelection = true;
                     } else {
                          if (currentDate.getTime() === startDate.getTime()) isRangeStart = true;
                          if (currentDate.getTime() === endDate.getTime()) isRangeEnd = true;
                          if (currentDate > startDate && currentDate < endDate) isInRange = true;
                     }
                } else if (startDate && !endDate) {
                     if (currentDate.getTime() === startDate.getTime()) isRangeStart = true;
                }

                let tdBgClass = "";

                if (isSingleDaySelection || (isRangeStart && isRangeEnd)) {
                    btnClasses = btnClasses.filter(c => !c.startsWith("hover:"));
                    btnClasses.push("bg-[#00d287]", "text-[#f8fafc]", "hover:!bg-[#00a86b]", "hover:!text-white");
                    btn.setAttribute("aria-selected", "true");
                    tdBgClass = "bg-bg-datepicker";
                } else if (isRangeStart) {
                    btnClasses = btnClasses.filter(c => !c.startsWith("hover:") && c !== "rounded-[6px]");
                    btnClasses.push("bg-[#00d287]", "text-[#f8fafc]", "hover:!bg-[#00a86b]", "hover:!text-white", "rounded-l-[6px]", "rounded-r-none");
                    btn.setAttribute("aria-selected", "true");
                    tdBgClass = "bg-bg-datepicker rounded-l-md";
                } else if (isRangeEnd) {
                     btnClasses = btnClasses.filter(c => !c.startsWith("hover:") && c !== "rounded-[6px]");
                     btnClasses.push("bg-[#00d287]", "text-[#f8fafc]", "hover:!bg-[#00a86b]", "hover:!text-white", "rounded-r-[6px]", "rounded-l-none");
                     btn.setAttribute("aria-selected", "true");
                     tdBgClass = "bg-bg-datepicker rounded-r-md";
                } else if (isInRange) {
                    btnClasses = btnClasses.filter(c => !c.startsWith("hover:") && c !== "rounded-[6px]");
                    btnClasses.push("bg-[#E0F5E0]", "text-[#1f2937]");
                    btn.setAttribute("aria-selected", "true");
                    tdBgClass = "bg-bg-datepicker";
                }

                btn.className = btnClasses.join(" ");
                if (tdBgClass) {
                   td.classList.add(...tdBgClass.split(" "));
                }

                td.appendChild(btn);
                day++;
            }
            tr.appendChild(td);
        }
        tbody.appendChild(tr);
        if (day > daysInMonth) break;
    }
}

function renderCalendars() {
     if (!rentalFormInstance) return;
    renderCalendar(year1, month1, "calendar-body-1", "month-caption-1");
    renderCalendar(year2, month2, "calendar-body-2", "month-caption-2");
}

function handleDateSelection(date) {
    if (!rentalFormInstance || rentalFormInstance.currentTab !== 'day') {
        console.error("Cannot select date: Not in 'day' tab or instance not ready.");
        return;
    }

    const pickerType = rentalFormInstance.currentPickerType;
    console.log("handleDateSelection - pickerType:", pickerType, "Selected Date:", date.toLocaleDateString());

    if (pickerType === 'pickup-date') {
        rentalFormInstance.selectedStartDate = date;
        document.getElementById('pickup-date').textContent = rentalFormInstance.formatDate(date);
        if (!rentalFormInstance.selectedEndDate || rentalFormInstance.selectedEndDate <= date) {
            const newReturnDate = getNextDay(date);
            rentalFormInstance.selectedEndDate = newReturnDate;
            document.getElementById('return-date').textContent = rentalFormInstance.formatDate(newReturnDate);
        }
    } else if (pickerType === 'return-date') {
        if (!rentalFormInstance.selectedStartDate) {
             rentalFormInstance.initializeDates();
             alert("Vui lòng chọn ngày nhận trước.");
             rentalFormInstance.currentPickerType = 'pickup-date';
             renderCalendars();
             return;
        }
        else if (date <= rentalFormInstance.selectedStartDate) {
            alert("Ngày trả phải sau ngày nhận.");
            return;
        }
        rentalFormInstance.selectedEndDate = date;
        document.getElementById('return-date').textContent = rentalFormInstance.formatDate(date);
    } else {
        if(!pickerType && rentalFormInstance.currentTab === 'day') {
             rentalFormInstance.selectedStartDate = date;
             document.getElementById('pickup-date').textContent = rentalFormInstance.formatDate(date);
            if (!rentalFormInstance.selectedEndDate || rentalFormInstance.selectedEndDate <= date) {
                const newReturnDate = getNextDay(date);
                rentalFormInstance.selectedEndDate = newReturnDate;
                document.getElementById('return-date').textContent = rentalFormInstance.formatDate(newReturnDate);
            }
             rentalFormInstance.currentPickerType = 'return-date';
             renderCalendars();
             return;
        } else {
          return;
        }
    }

    rentalFormInstance.validateDateRange();
    renderCalendars();

    if (pickerType === 'pickup-date' || pickerType === 'return-date') {
        rentalFormInstance.closeDatePicker();
    } else if (!pickerType && rentalFormInstance.currentTab === 'day') {
        // Don't close
    } else {
         rentalFormInstance.closeDatePicker();
    }
}

function handleDayClick(e) {
     if (e.target && e.target.name === 'day' && !e.target.disabled) {
        const dateString = e.target.dataset.date;
        if (dateString) {
            const parts = dateString.split('-');
            const year = parseInt(parts[0], 10);
            const month = parseInt(parts[1], 10) - 1;
            const day = parseInt(parts[2], 10);

            if (!isNaN(year) && !isNaN(month) && !isNaN(day)) {
                let selectedDate = new Date(Date.UTC(year, month, day));
                 if (selectedDate.getUTCFullYear() === year && selectedDate.getUTCMonth() === month && selectedDate.getUTCDate() === day) {
                      handleDateSelection(selectedDate);
                 } else {
                      console.error("Invalid date created from button data:", dateString);
                 }
            } else {
                 console.error("Could not parse date from button data:", dateString);
            }
        } else {
             console.error("Button clicked has no date data:", e.target);
        }
    }
}

function getNextDay(date) {
    if(!date || isNaN(date.getTime())) return null;
    let next = new Date(date);
    next.setUTCDate(date.getUTCDate() + 1);
    return next;
}

document.addEventListener('DOMContentLoaded', () => {
    if (!rentalFormInstance) {
        rentalFormInstance = new RentalForm();
    } else {
        rentalFormInstance.init();
    }
});