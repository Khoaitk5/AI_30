/**
 * Script để mở modal thuê xe từ trang car detail hoặc home page
 * Tích hợp với giao diện modal mới từ ai_for_se
 */

function openRentalModal(carData) {
    // Tạo modal container nếu chưa có
    let modalContainer = document.getElementById('rental-modal-container');
    if (!modalContainer) {
        modalContainer = document.createElement('div');
        modalContainer.id = 'rental-modal-container';
        modalContainer.style.position = 'fixed';
        modalContainer.style.top = '0';
        modalContainer.style.left = '0';
        modalContainer.style.width = '100%';
        modalContainer.style.height = '100%';
        modalContainer.style.zIndex = '9998';
        document.body.appendChild(modalContainer);
    }

    // Load modal JSP vào container
    const modalUrl = `${contextPath}/rental/modal?modelId=${carData.modelId}${carData.carId ? '&carId=' + carData.carId : ''}`;
    
    fetch(modalUrl)
        .then(response => response.text())
        .then(html => {
            modalContainer.innerHTML = html;
            
            // Gửi data xe vào modal
            const modalIframe = document.getElementById('modal-container-iframe');
            if (modalIframe && modalIframe.contentWindow) {
                modalIframe.contentWindow.postMessage({
                    action: 'openRentalModal',
                    carData: carData
                }, '*');
            }
            
            // Lắng nghe message từ modal để đóng
            window.addEventListener('message', function closeModalHandler(event) {
                if (event.data.action === 'closeModal') {
                    modalContainer.innerHTML = '';
                    modalContainer.style.display = 'none';
                    window.removeEventListener('message', closeModalHandler);
                }
            });
        })
        .catch(error => {
            console.error('Error loading modal:', error);
            alert('Không thể mở modal. Vui lòng thử lại!');
        });
}

// Export function để dùng từ các trang khác
if (typeof module !== 'undefined' && module.exports) {
    module.exports = { openRentalModal };
}
