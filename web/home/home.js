// Cars Carousel functionality
class CarsCarousel {
    constructor() {
        this.carousel = document.querySelector('.cars-carousel');
        this.slides = document.querySelectorAll('.cars-slide');
        this.dots = document.querySelectorAll('.cars-dot');
        this.currentIndex = 0;
        this.isDragging = false;
        this.wasDragging = false;
        this.startX = 0;
        this.currentX = 0;
        this.dragThreshold = 50;
        
        this.arrangements = [
            { center: 0, left: 4, right: 1 }, // VF3 center, VF9 left, VF6 right
            { center: 1, left: 0, right: 2 }, // VF6 center, VF3 left, VF7 right
            { center: 2, left: 1, right: 3 }, // VF7 center, VF6 left, VF8 right
            { center: 3, left: 2, right: 4 }, // VF8 center, VF7 left, VF9 right
            { center: 4, left: 3, right: 0 }  // VF9 center, VF8 left, VF3 right
        ];
        
        this.init();
    }
    
    init() {
        this.updateCarousel();
        this.addEventListeners();
    }
    
    addEventListeners() {
        // Mouse events
        this.carousel.addEventListener('mousedown', this.handleStart.bind(this));
        this.carousel.addEventListener('mousemove', this.handleMove.bind(this));
        this.carousel.addEventListener('mouseup', this.handleEnd.bind(this));
        this.carousel.addEventListener('mouseleave', this.handleEnd.bind(this));
        
        // Touch events
        this.carousel.addEventListener('touchstart', this.handleStart.bind(this));
        this.carousel.addEventListener('touchmove', this.handleMove.bind(this));
        this.carousel.addEventListener('touchend', this.handleEnd.bind(this));
        
        // Dot clicks
        this.dots.forEach((dot, index) => {
            dot.addEventListener('click', () => {
                this.goToSlide(index);
            });
        });
        
        // Prevent card links from being clicked during drag
        const cardLinks = this.carousel.querySelectorAll('.cars-card-link');
        cardLinks.forEach(link => {
            link.addEventListener('click', (e) => {
                if (this.isDragging || this.wasDragging) {
                    e.preventDefault();
                    e.stopPropagation();
                }
            });
        });
        
        // Prevent context menu on drag
        this.carousel.addEventListener('contextmenu', (e) => {
            if (this.isDragging) {
                e.preventDefault();
            }
        });
    }
    
    handleStart(e) {
        this.isDragging = true;
        this.wasDragging = false;
        this.startX = e.type === 'mousedown' ? e.clientX : e.touches[0].clientX;
        this.carousel.style.cursor = 'grabbing';
        e.preventDefault();
    }
    
    handleMove(e) {
        if (!this.isDragging) return;
        
        this.currentX = e.type === 'mousemove' ? e.clientX : e.touches[0].clientX;
        const diffX = this.currentX - this.startX;
        
        // Mark as dragging if moved more than a few pixels
        if (Math.abs(diffX) > 5) {
            this.wasDragging = true;
        }
        
        // Visual feedback during drag
        this.carousel.style.transform = `translateX(${diffX * 0.3}px)`;
    }
    
    handleEnd(e) {
        if (!this.isDragging) return;
        
        this.isDragging = false;
        this.carousel.style.cursor = 'grab';
        this.carousel.style.transform = '';
        
        const diffX = this.currentX - this.startX;
        
        // Only change slide if user actually dragged
        if (this.wasDragging && Math.abs(diffX) > this.dragThreshold) {
            if (diffX > 0) {
                // Dragged right - go to previous
                this.previousSlide();
            } else {
                // Dragged left - go to next
                this.nextSlide();
            }
        }
        
        // Reset drag state after a short delay to prevent accidental clicks
        setTimeout(() => {
            this.wasDragging = false;
        }, 100);
    }
    
    updateCarousel() {
        const arrangement = this.arrangements[this.currentIndex];
        
        // Reset all slides
        this.slides.forEach((slide, index) => {
            slide.className = 'cars-slide';
            
            if (index === arrangement.center) {
                slide.classList.add('center');
            } else if (index === arrangement.left) {
                slide.classList.add('left');
            } else if (index === arrangement.right) {
                slide.classList.add('right');
            } else {
                slide.classList.add('hidden');
            }
        });
        
        // Update dots
        this.dots.forEach((dot, index) => {
            dot.classList.toggle('cars-dot--active', index === this.currentIndex);
        });
    }
    
    goToSlide(targetIndex) {
        if (targetIndex === this.currentIndex) return;
        
        // Calculate the shortest path (considering circular nature)
        const totalSlides = this.arrangements.length;
        const forward = (targetIndex - this.currentIndex + totalSlides) % totalSlides;
        const backward = (this.currentIndex - targetIndex + totalSlides) % totalSlides;
        
        // Choose the shorter path
        const useForward = forward <= backward;
        const steps = useForward ? forward : backward;
        
        // Animate through each step
        let currentStep = 0;
        const animateStep = () => {
            if (currentStep >= steps) return;
            
            if (useForward) {
                this.nextSlide();
            } else {
                this.previousSlide();
            }
            
            currentStep++;
            if (currentStep < steps) {
                setTimeout(animateStep, 300); // 300ms delay between each step
            }
        };
        
        animateStep();
    }
    
    nextSlide() {
        this.currentIndex = (this.currentIndex + 1) % this.arrangements.length;
        this.updateCarousel();
    }
    
    previousSlide() {
        this.currentIndex = (this.currentIndex - 1 + this.arrangements.length) % this.arrangements.length;
        this.updateCarousel();
    }
}

// Initialize carousel when DOM is loaded
document.addEventListener('DOMContentLoaded', () => {
    new CarsCarousel();
});

// MAIN INITIALIZATION
document.addEventListener('DOMContentLoaded', function() {
    console.log('DOM loaded, initializing...');

    // ESC key to close modals (only if no specific modal handler takes precedence)
    document.addEventListener('keydown', function(e) {
        if (e.key === 'Escape') {
            const passwordOverlay = document.getElementById('passwordOverlay');
            const loginOverlay = document.getElementById('loginOverlay');
            const registerOverlay = document.getElementById('registerOverlay');
            
            if (passwordOverlay && passwordOverlay.classList.contains('active')) {
                // Defer to password.js handler
                return;
            } else if (loginOverlay && loginOverlay.classList.contains('active')) {
                // Defer to login.js handler
                return;
            } else if (registerOverlay && registerOverlay.classList.contains('active')) {
                // Defer to register.js handler
                return;
            }
        }
    });

    // Close mobile menu when clicking outside
    document.addEventListener('click', function(e) {
        const mobileMenu = document.getElementById('mobile-menu');
        const menuButton = e.target.closest('button[onclick="toggleMenu()"]');
        
        if (!mobileMenu) return;
        
        if (!mobileMenu.contains(e.target) && !menuButton && mobileMenu.classList.contains('active')) {
            mobileMenu.classList.remove('active');
        }
    });
});

// HEADER SCROLL EFFECT
window.addEventListener('scroll', function() {
    const header = document.querySelector('.main-header');
    if (header) {
        header.classList.toggle('scrolled', window.scrollY > 100);
    }
});