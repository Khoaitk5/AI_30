/**
 * rental-modal-handler.js
 * Script chung để xử lý mở modal thuê xe mới (từ ai_for_se)
 * Thay thế cho việc chuyển trang, modal sẽ hiển thị dạng popup
 */

(function() {
    'use strict';
    
    // Tạo container cho modal nếu chưa có
    function createModalContainer() {
        let container = document.getElementById('rental-modal-container');
        if (!container) {
            container = document.createElement('div');
            container.id = 'rental-modal-container';
            container.style.position = 'fixed';
            container.style.top = '0';
            container.style.left = '0';
            container.style.width = '100%';
            container.style.height = '100%';
            container.style.zIndex = '9999';
            container.style.display = 'none';
            document.body.appendChild(container);
        }
        return container;
    }

    // Hàm mở modal
    window.openRentalModal = function(modelId, carId) {
        console.log('Opening modal for modelId:', modelId, 'carId:', carId);
        const container = createModalContainer();
        
        // Hiển thị loading
        container.innerHTML = '<div style="display: flex; align-items: center; justify-content: center; height: 100%; background: rgba(0,0,0,0.5);"><div style="color: white; font-size: 20px;">Đang tải...</div></div>';
        container.style.display = 'block';
        console.log('Loading overlay displayed');
        
        // Load modal từ server
        const url = `${window.contextPath || ''}/rental/modal?modelId=${modelId}${carId ? '&carId=' + carId : ''}`;
        console.log('Fetching modal from URL:', url);
        
        fetch(url)
            .then(response => {
                console.log('Modal response status:', response.status);
                if (!response.ok) {
                    throw new Error('Không thể tải modal');
                }
                return response.text();
            })
            .then(html => {
                console.log('Modal HTML received, length:', html.length);
                container.innerHTML = html;
                container.style.display = 'block';
                
                // Thêm sự kiện đóng modal
                setupModalCloseEvents(container);
                
                // Disable scroll của body khi modal mở
                document.body.style.overflow = 'hidden';
                console.log('Modal displayed successfully');
            })
            .catch(error => {
                console.error('Error loading modal:', error);
                container.innerHTML = '';
                container.style.display = 'none';
                document.body.style.overflow = '';
                alert('Không thể mở form đặt xe. Vui lòng thử lại!');
            });
    };

    // Hàm đóng modal
    window.closeRentalModal = function() {
        const container = document.getElementById('rental-modal-container');
        if (container) {
            container.innerHTML = '';
            container.style.display = 'none';
        }
        // Enable lại scroll của body
        document.body.style.overflow = '';
    };

    // Setup sự kiện đóng modal
    function setupModalCloseEvents(container) {
        // Lắng nghe message từ iframe hoặc modal content
        window.addEventListener('message', function(event) {
            if (event.data && event.data.action === 'closeModal') {
                window.closeRentalModal();
            }
        });

        // Đóng modal khi nhấn ESC
        document.addEventListener('keydown', function(e) {
            if (e.key === 'Escape' && container.style.display !== 'none') {
                window.closeRentalModal();
            }
        });
    }

    // Tự động bind cho tất cả các nút "Đặt xe" có sẵn
    document.addEventListener('DOMContentLoaded', function() {
        console.log('rental-modal-handler.js loaded!');
        
        // Lấy tất cả nút có id btnBookCar
        const bookButtons = document.querySelectorAll('#btnBookCar, .btn-book, [data-action="book-car"]');
        console.log('Found buttons:', bookButtons.length);
        
        bookButtons.forEach(function(button) {
            // Lấy modelId từ data attribute hoặc từ context
            const modelId = button.getAttribute('data-model-id');
            const carId = button.getAttribute('data-car-id');
            
            console.log('Button:', button, 'ModelId:', modelId, 'CarId:', carId);
            
            if (modelId) {
                button.addEventListener('click', function(e) {
                    e.preventDefault();
                    console.log('Button clicked! ModelId:', modelId);
                    
                    // Kiểm tra trạng thái xe trước
                    checkCarStatusAndOpenModal(modelId, carId);
                });
            }
        });
    });

    // Hàm kiểm tra trạng thái xe trước khi mở modal
    function checkCarStatusAndOpenModal(modelId, carId) {
        console.log('Checking car status for modelId:', modelId);
        const checkUrl = `${window.contextPath || ''}/rental/checkStatus?modelId=${modelId}`;
        console.log('Check URL:', checkUrl);
        
        fetch(checkUrl)
            .then(response => {
                console.log('Response status:', response.status);
                return response.json();
            })
            .then(data => {
                console.log('Status data:', data);
                console.log('Checking status:', data.status, 'Type:', typeof data.status);
                if (data.status === 'MAINTENANCE') {
                    console.log('Status is MAINTENANCE');
                    alert('Xe đang trong quá trình bảo trì. Vui lòng chọn xe khác!');
                } else if (data.status === 'AVAILABLE') {
                    console.log('Status is AVAILABLE, calling openRentalModal');
                    console.log('window.openRentalModal exists?', typeof window.openRentalModal);
                    if (typeof window.openRentalModal === 'function') {
                        try {
                            console.log('About to call openRentalModal with:', modelId, carId);
                            window.openRentalModal(modelId, carId);
                            console.log('openRentalModal called successfully');
                        } catch (err) {
                            console.error('Error calling openRentalModal:', err);
                        }
                    } else {
                        console.error('openRentalModal is not a function!');
                    }
                } else {
                    console.log('Status is neither MAINTENANCE nor AVAILABLE:', data.status);
                    alert('Hiện tại không có xe khả dụng cho mẫu xe này.');
                }
            })
            .catch(error => {
                console.error('Error checking car status:', error);
                // Nếu API lỗi, vẫn cho phép mở modal
                window.openRentalModal(modelId, carId);
            });
    }

})();
