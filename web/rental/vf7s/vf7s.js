document.addEventListener('DOMContentLoaded', function () {
    const mainImg = document.querySelector('.gallery-main .gallery-img');
    const thumbs = Array.from(document.querySelectorAll('.gallery-thumbs .thumb'));
    const btnPrev = document.querySelector('.embla__button--prev');
    const btnNext = document.querySelector('.embla__button--next');
    const thumbsContainer = document.querySelector('.gallery-thumbs');

    let currentIndex = 0;

    function updateGallery(index) {
        if (index < 0 || index >= thumbs.length) return;
        currentIndex = index;
        mainImg.src = thumbs[index].src;
        thumbs.forEach((thumb, i) => {
            thumb.classList.toggle('selected', i === index);
        });
        btnPrev.disabled = index === 0;
        btnNext.disabled = index === thumbs.length - 1;
    }

    // --- Drag to scroll for thumbs with click/drag separation ---
    let isDown = false;
    let startX;
    let scrollLeft;
    let dragging = false;

    // --- Physics variables for inertia ---
    let lastX = 0;
    let lastTime = 0;
    let velocity = 0;
    let momentumFrame;

    // Prevent default drag image behavior on thumbs
    thumbs.forEach((thumb) => {
        thumb.addEventListener('dragstart', (e) => e.preventDefault());
    });

    function stopMomentumScroll() {
        if (momentumFrame) {
            cancelAnimationFrame(momentumFrame);
            momentumFrame = null;
        }
        velocity = 0; // reset velocity để không bị cộng dồn
    }

    function momentumScroll() {
        if (Math.abs(velocity) < 0.03) return; // nhỏ hơn để kéo dài hơn
        thumbsContainer.scrollLeft -= velocity;
        velocity *= 0.965; // giảm ma sát, mượt hơn
        momentumFrame = requestAnimationFrame(momentumScroll);
    }

    thumbsContainer.addEventListener('mousedown', (e) => {
        stopMomentumScroll(); // dừng hiệu ứng cũ trước khi kéo mới
        isDown = true;
        dragging = false;
        thumbsContainer.classList.add('dragging');
        startX = e.pageX - thumbsContainer.offsetLeft;
        scrollLeft = thumbsContainer.scrollLeft;
        lastX = e.pageX;
        lastTime = Date.now();
        velocity = 0;
    });

    thumbsContainer.addEventListener('mouseleave', () => {
        isDown = false;
        dragging = false;
        thumbsContainer.classList.remove('dragging');
        stopMomentumScroll();
    });

    thumbsContainer.addEventListener('mouseup', (e) => {
        isDown = false;
        thumbsContainer.classList.remove('dragging');
        // Calculate velocity for inertia
        const now = Date.now();
        const dx = e.pageX - lastX;
        const dt = now - lastTime;
        velocity = dx / (dt || 1) * 18; // tăng hệ số nhân vận tốc
        momentumScroll();
        setTimeout(() => { dragging = false; }, 0);
    });

    thumbsContainer.addEventListener('mousemove', (e) => {
        if (!isDown) return;
        e.preventDefault();
        const x = e.pageX - thumbsContainer.offsetLeft;
        const walk = (x - startX) * 1.5;
        if (Math.abs(walk) > 5) dragging = true;
        thumbsContainer.scrollLeft = scrollLeft - walk;
        // Track for velocity
        const now = Date.now();
        if (now - lastTime > 10) {
            velocity = (e.pageX - lastX) / (now - lastTime) * 10;
            lastX = e.pageX;
            lastTime = now;
        }
    });

    // Touch events
    thumbsContainer.addEventListener('touchstart', (e) => {
        stopMomentumScroll(); // dừng hiệu ứng cũ trước khi kéo mới
        isDown = true;
        dragging = false;
        thumbsContainer.classList.add('dragging');
        startX = e.touches[0].pageX - thumbsContainer.offsetLeft;
        scrollLeft = thumbsContainer.scrollLeft;
        lastX = e.touches[0].pageX;
        lastTime = Date.now();
        velocity = 0;
    });

    thumbsContainer.addEventListener('touchend', (e) => {
        isDown = false;
        thumbsContainer.classList.remove('dragging');
        // Calculate velocity for inertia
        const now = Date.now();
        const touch = (e.changedTouches && e.changedTouches[0]) || { pageX: lastX };
        const dx = touch.pageX - lastX;
        const dt = now - lastTime;
        velocity = dx / (dt || 1) * 18; // tăng hệ số nhân vận tốc
        momentumScroll();
        setTimeout(() => { dragging = false; }, 0);
    });

    thumbsContainer.addEventListener('touchmove', (e) => {
        if (!isDown) return;
        const x = e.touches[0].pageX - thumbsContainer.offsetLeft;
        const walk = (x - startX) * 1.5;
        if (Math.abs(walk) > 5) dragging = true;
        thumbsContainer.scrollLeft = scrollLeft - walk;
        // Track for velocity
        const now = Date.now();
        if (now - lastTime > 10) {
            velocity = (e.touches[0].pageX - lastX) / (now - lastTime) * 10;
            lastX = e.touches[0].pageX;
            lastTime = now;
        }
    });

    // Click thumbnail: chỉ khi không kéo
    thumbs.forEach((thumb, idx) => {
        thumb.addEventListener('click', (e) => {
            if (dragging) {
                e.preventDefault();
                return;
            }
            updateGallery(idx);
        });
    });

    btnPrev.addEventListener('click', () => {
        if (currentIndex > 0) updateGallery(currentIndex - 1);
    });

    btnNext.addEventListener('click', () => {
        if (currentIndex < thumbs.length - 1) updateGallery(currentIndex + 1);
    });

    // Khởi tạo trạng thái ban đầu
    updateGallery(0);
});