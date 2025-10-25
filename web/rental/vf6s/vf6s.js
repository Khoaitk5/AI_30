// Nếu cần JS cho gallery hoặc các nút, thêm code tại đây
// Ví dụ: chuyển ảnh khi click vào thumb

const thumbs = document.querySelectorAll('.thumb');
const mainImg = document.querySelector('.gallery-img');
const prevBtn = document.querySelector('.embla__button--prev');
const nextBtn = document.querySelector('.embla__button--next');
let currentIndex = 0;

// Tạo thêm 1 img để slide đồng thời
let slideImg = null;
if (mainImg) {
    slideImg = mainImg.cloneNode();
    slideImg.style.position = 'absolute';
    slideImg.style.top = '0';
    slideImg.style.left = '0';
    slideImg.style.width = mainImg.width + 'px';
    slideImg.style.height = mainImg.height + 'px';
    slideImg.style.pointerEvents = 'none';
    slideImg.style.zIndex = '2';
    slideImg.style.opacity = '0';
    slideImg.style.borderRadius = '8px'; // Đảm bảo luôn bo tròn viền khi kéo/slide
    slideImg.style.overflow = 'hidden';
    mainImg.parentNode.appendChild(slideImg);
}

function slideMainImage(newSrc, direction) {
    if (!mainImg || !slideImg) return;
    const distance = 622; // px slide đúng bằng chiều rộng ảnh
    const duration = 220; // ms
    // Chuẩn bị slideImg
    slideImg.src = newSrc;
    slideImg.style.transition = 'none';
    slideImg.style.opacity = '1';
    slideImg.style.transform = `translateX(${direction * distance}px)`;
    slideImg.style.zIndex = '2';
    mainImg.style.zIndex = '1';
    // Slide đồng thời
    setTimeout(() => {
        mainImg.style.transition = `transform ${duration}ms cubic-bezier(0.4,0,0.2,1)`;
        slideImg.style.transition = `transform ${duration}ms cubic-bezier(0.4,0,0.2,1)`;
        mainImg.style.transform = `translateX(${-direction * distance}px)`;
        slideImg.style.transform = 'translateX(0)';
        setTimeout(() => {
            mainImg.src = newSrc;
            mainImg.style.transition = 'none';
            mainImg.style.transform = 'translateX(0)';
            slideImg.style.transition = 'none';
            slideImg.style.opacity = '0';
        }, duration);
    }, 10);
}

// Đồng bộ lại kích thước slideImg khi resize
window.addEventListener('resize', () => {
    if (mainImg && slideImg) {
        slideImg.style.width = mainImg.offsetWidth + 'px';
        slideImg.style.height = mainImg.offsetHeight + 'px';
        slideImg.style.borderRadius = '8px'; // Đảm bảo resize vẫn giữ bo tròn
    }
});

let isSliding = false;
// Đảm bảo mọi ảnh đều đúng kích thước, không bị co giãn khi đổi ảnh
function setImgFixedSize(img) {
    img.style.width = mainImg.offsetWidth + 'px';
    img.style.height = mainImg.offsetHeight + 'px';
    img.style.objectFit = 'cover';
    img.style.borderRadius = '8px';
}
if (mainImg && slideImg) {
    setImgFixedSize(mainImg);
    setImgFixedSize(slideImg);
}

// Sửa hiệu ứng slide mượt hơn, không bị lỗi khi bấm nhanh, giữ đúng kích thước
function slideMainImageStep(newIndex) {
    if (!mainImg || !slideImg) return;
    if (isSliding || newIndex === currentIndex) return;
    isSliding = true;
    const distance = mainImg.offsetWidth;
    const duration = 220;
    const easing = 'cubic-bezier(0.4,0,0.2,1)';
    let step = newIndex > currentIndex ? 1 : -1;
    let idx = currentIndex;
    const thumbsContainer = document.querySelector('.gallery-thumbs');
    async function doSlide(fromIdx, toIdx) {
        const fromThumb = thumbs[fromIdx];
        const toThumb = thumbs[toIdx];
        if (!toThumb) return;
        const nextSrc = toThumb.src;
        const dir = toIdx > fromIdx ? 1 : -1;
        setImgFixedSize(slideImg);
        slideImg.style.transition = 'none';
        slideImg.style.opacity = '0';
        slideImg.style.zIndex = '10';
        mainImg.style.zIndex = '1';
        slideImg.style.transform = `translateX(${dir * distance}px)`;
        // Chờ ảnh load xong mới thực hiện hiệu ứng
        await new Promise((resolve) => {
            slideImg.onload = () => resolve();
            slideImg.src = nextSrc;
            if (slideImg.complete) setTimeout(resolve, 10);
        });
        slideImg.style.opacity = '1';
        await new Promise(requestAnimationFrame);
        mainImg.style.transition = `transform ${duration}ms ${easing}`;
        slideImg.style.transition = `transform ${duration}ms ${easing}`;
        mainImg.style.transform = `translateX(${-dir * distance}px)`;
        slideImg.style.transform = 'translateX(0)';
        // Scroll thumb vào giữa nếu bị khuất (scroll song song với hiệu ứng)
        if (thumbsContainer && toThumb) {
            const containerRect = thumbsContainer.getBoundingClientRect();
            const thumbRect = toThumb.getBoundingClientRect();
            if (thumbRect.left < containerRect.left || thumbRect.right > containerRect.right) {
                thumbsContainer.scrollTo({
                    left: toThumb.offsetLeft - thumbsContainer.offsetWidth / 2 + toThumb.offsetWidth / 2,
                    behavior: 'smooth'
                });
            }
        }
        await new Promise(r => setTimeout(r, duration));
        // Đổi src cho mainImg sau khi hiệu ứng xong và ảnh đã load xong
        mainImg.src = nextSrc;
        setImgFixedSize(mainImg);
        mainImg.style.transition = 'none';
        mainImg.style.transform = 'translateX(0)';
        slideImg.style.transition = 'opacity 120ms linear';
        slideImg.style.opacity = '0';
        setTimeout(() => {
            slideImg.style.transition = 'none';
            slideImg.style.zIndex = '2';
        }, 120);
    }
    async function runSlides() {
        while (idx !== newIndex) {
            const nextIdx = idx + step;
            await doSlide(idx, nextIdx);
            idx = nextIdx;
        }
        thumbs.forEach((t, i) => t.classList.toggle('selected', i === newIndex));
        currentIndex = newIndex;
        isSliding = false;
    }
    runSlides();
}

window.addEventListener('resize', () => {
    if (mainImg && slideImg) {
        setImgFixedSize(mainImg);
        setImgFixedSize(slideImg);
    }
});

thumbs.forEach((thumb, idx) => {
    thumb.addEventListener('click', function () {
        slideMainImageStep(idx);
    });
// Gallery navigation button logic
function updateNavButtons() {
    if (!prevBtn || !nextBtn) return;
    prevBtn.disabled = currentIndex === 0;
    nextBtn.disabled = currentIndex === thumbs.length - 1;
}

if (prevBtn && nextBtn) {
    prevBtn.addEventListener('click', function () {
        if (currentIndex > 0) {
            slideMainImageStep(currentIndex - 1);
        }
    });
    nextBtn.addEventListener('click', function () {
        if (currentIndex < thumbs.length - 1) {
            slideMainImageStep(currentIndex + 1);
        }
    });
}

// Cập nhật trạng thái nút khi chuyển ảnh
const oldSlideMainImageStep = slideMainImageStep;
slideMainImageStep = function(newIndex) {
    oldSlideMainImageStep(newIndex);
    setTimeout(updateNavButtons, 0);
};

// Khởi tạo trạng thái nút
updateNavButtons();
});

// Kéo ngang gallery-thumbs bằng chuột (drag to scroll) mượt mà hơn
(function() {
    document.addEventListener('DOMContentLoaded', function() {
        const thumbs = document.querySelector('.gallery-thumbs');
        if (!thumbs) return;
        let isDown = false;
        let isDrag = false;
        let dragDistance = 0;
        let startX;
        let scrollLeft;
        let rafId = null;
        let lastX = 0;
        let lastMoveTime = 0;
        let velocity = 0;
        let lastScroll = 0;
        let inertiaId = null;
        const DRAG_THRESHOLD = 16;
        const DRAG_SENSITIVITY = 0.7;
        let pointerMoved = false;
        let velocityHistory = [0, 0, 0]; // Lưu 3 frame velocity cuối

        thumbs.style.cursor = 'grab';

        function onPointerMove(e) {
            if (!isDown) return;
            let pageX = e.touches ? e.touches[0].pageX : e.pageX;
            lastX = pageX - thumbs.offsetLeft;
            dragDistance = Math.abs(lastX - startX);
            if (dragDistance > DRAG_THRESHOLD) isDrag = true;
            pointerMoved = true;
            if (!rafId) rafId = requestAnimationFrame(updateScroll);
            const now = Date.now();
            let dt = now - lastMoveTime || 1;
            let v = (thumbs.scrollLeft - lastScroll) / dt;
            // Clamp velocity để inertia không quá mạnh
            v = Math.max(-3, Math.min(3, v));
            velocityHistory.shift();
            velocityHistory.push(v);
            velocity = v;
            lastMoveTime = now;
            lastScroll = thumbs.scrollLeft;
        }
        function updateScroll() {
            const walk = (lastX - startX) * DRAG_SENSITIVITY;
            thumbs.scrollLeft = scrollLeft - walk;
            rafId = null;
        }
        function onPointerUp(e) {
            if (!isDown) return;
            isDown = false;
            thumbs.classList.remove('dragging');
            thumbs.style.cursor = 'grab';
            if (isDrag) {
                // inertia
                // Lấy velocity trung bình 3 frame cuối
                let avgVelocity = (velocityHistory[0] + velocityHistory[1] + velocityHistory[2]) / 3;
                if (Math.abs(avgVelocity) > 0.08) {
                    let momentum = avgVelocity * 28;
                    let current = thumbs.scrollLeft;
                    thumbs.style.scrollBehavior = '';
                    function inertia() {
                        if (Math.abs(momentum) < 0.2) {
                            return;
                        }
                        current += momentum;
                        current = Math.max(0, Math.min(current, thumbs.scrollWidth - thumbs.clientWidth));
                        thumbs.scrollLeft = current;
                        momentum *= 0.92;
                        inertiaId = requestAnimationFrame(inertia);
                    }
                    inertia();
                }
            }
            isDrag = false;
            pointerMoved = false;
            velocityHistory = [0, 0, 0];
        }
        thumbs.addEventListener('pointerdown', (e) => {
            isDown = true;
            isDrag = false;
            dragDistance = 0;
            pointerMoved = false;
            thumbs.classList.add('dragging');
            thumbs.style.cursor = 'grabbing';
            startX = (e.touches ? e.touches[0].pageX : e.pageX) - thumbs.offsetLeft;
            scrollLeft = thumbs.scrollLeft;
            lastMoveTime = Date.now();
            lastScroll = thumbs.scrollLeft;
            velocity = 0;
            if (inertiaId) cancelAnimationFrame(inertiaId);
            e.preventDefault();
        });
        document.addEventListener('pointermove', onPointerMove);
        document.addEventListener('pointerup', onPointerUp);

        // Chỉ trigger select bằng click thực sự (pointerup mà không drag)
        document.querySelectorAll('.thumb').forEach((thumb, idx) => {
            thumb.addEventListener('click', function(e) {
                if (isDown || isDrag || pointerMoved) {
                    e.preventDefault();
                    return;
                }
                slideMainImageStep(idx);
            });
        });
    });
})();

// --- Bọc lại event click thumbnail, prev/next để chặn thao tác khi đang sliding ---
thumbs.forEach((thumb, idx) => {
    thumb.addEventListener('click', function (e) {
        if (isSliding) {
            e.preventDefault();
            return;
        }
        slideMainImageStep(idx);
    });
});
if (prevBtn && nextBtn) {
    prevBtn.addEventListener('click', function (e) {
        if (isSliding) {
            e.preventDefault();
            return;
        }
        if (currentIndex > 0) {
            slideMainImageStep(currentIndex - 1);
        }
    });
    nextBtn.addEventListener('click', function (e) {
        if (isSliding) {
            e.preventDefault();
            return;
        }
        if (currentIndex < thumbs.length - 1) {
            slideMainImageStep(currentIndex + 1);
        }
    });
}
