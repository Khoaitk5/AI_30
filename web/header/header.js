function initHeaderDropdown() {
    var btn = document.getElementById('login-btn');
    var dropdown = document.getElementById('user-dropdown');
    if (btn && dropdown) {
        dropdown.classList.remove('show', 'hidden');
        dropdown.style.display = '';
        btn.onclick = function (e) {
            e.stopPropagation();
            dropdown.classList.toggle('show');
            e.preventDefault();
            return false;
        };
        // Không tắt dropdown khi click ngoài hoặc scroll nữa
    } else {
        if (btn) {
            btn.onclick = function (e) {
                if (typeof openLogin === 'function') {
                    openLogin();
                }
                e.preventDefault();
                return false;
            };
        }
    }
}

function showLogoutToastIfNeeded() {
    var toast = document.getElementById('logout-toast');
    if (!toast) {
        var header = document.getElementById('header-container');
        if (header) {
            toast = header.querySelector('#logout-toast');
        }
    }
    // Chỉ hiện popup nếu có message=logout trên URL và popup chưa hiển thị, 
    // và chỉ hiện 1 lần rồi xóa param khỏi URL (không hiện lại khi reload)
    var url = new URL(window.location.href);
    var urlHasLogout = url.searchParams.get('message') === 'logout';
    if (urlHasLogout && toast && toast.style.display !== 'flex') {
        toast.style.display = 'flex';
        toast.classList.remove('toast--show-anim');
        void toast.offsetWidth;
        toast.classList.add('toast--show-anim');
        setTimeout(function() {
            toast.style.display = 'none';
            toast.classList.remove('toast--show-anim');
        }, 5000);
        // Xóa param message=logout khỏi URL (không reload lại trang)
        url.searchParams.delete('message');
        window.history.replaceState({}, document.title, url.pathname + url.search);
    }
}

function observeHeader() {
    const targetNode = document.getElementById('header-container') || document.body;
    const observer = new MutationObserver((mutations, observer) => {
        const toast = document.getElementById('logout-toast');
        if (toast) {
            console.log("Toast detected by MutationObserver, calling showLogoutToastIfNeeded...");
            showLogoutToastIfNeeded();
            observer.disconnect(); // Ngừng quan sát sau khi tìm thấy
        }
    });
    observer.observe(targetNode, { childList: true, subtree: true });
}

document.addEventListener('DOMContentLoaded', function () {
    console.log("Header script loaded, initializing...");
    initHeaderDropdown();
    observeHeader();
    showLogoutToastIfNeeded();
    setTimeout(showLogoutToastIfNeeded, 300);
    setTimeout(showLogoutToastIfNeeded, 700);
    setTimeout(showLogoutToastIfNeeded, 1200);
    setTimeout(showLogoutToastIfNeeded, 2000);
});