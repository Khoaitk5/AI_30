// --- BẮT ĐẦU SỬA: Hàm sendHeaderHeight ĐÃ VIẾT LẠI ---
function sendHeaderHeight() {
  const headerBar = document.querySelector("header");
  if (!headerBar) return;

  let newHeight = headerBar.offsetHeight; // Bắt đầu bằng chiều cao của thanh header

  // 1. Kiểm tra menu user (dropdown bên trong header)
  const userMenuDropdown = document.getElementById("user-menu-dropdown");
  if (userMenuDropdown && !userMenuDropdown.classList.contains("hidden")) {
    // Nếu menu user mở, tính chiều cao từ đỉnh trang đến đáy menu
    const dropdownRect = userMenuDropdown.getBoundingClientRect();
    // dropdownRect.bottom là khoảng cách từ đỉnh viewport (cũng là đỉnh iframe)
    // đến đáy của dropdown.
    newHeight = dropdownRect.bottom + 5; // Thêm 5px đệm
  }

  // 2. Kiểm tra menu mobile (cũng bên trong header)
  const mobileMenuContainer = document.querySelector(".xls\\:hidden");
  const mobileMenuDropdown = mobileMenuContainer
    ? mobileMenuContainer.querySelector(".fixed")
    : null;
  if (
    mobileMenuContainer &&
    mobileMenuContainer.classList.contains("menu-active") &&
    mobileMenuDropdown
  ) {
    // Nếu menu mobile mở, chiều cao là chiều cao của menu đó
    newHeight = mobileMenuDropdown.scrollHeight;
  }

  // Thêm 1px buffer cuối cùng để tránh lỗi làm tròn
  newHeight += 1;

  if (window.parent) {
    window.parent.postMessage(
      {
        type: "headerHeight",
        height: newHeight,
      },
      "*"
    );
  }
}
// --- KẾT THÚC SỬA ---

// Function to get cookie value
function getCookie(name) {
  const value = `; ${document.cookie}`;
  const parts = value.split(`; ${name}=`);
  if (parts.length === 2) return parts.pop().split(';').shift();
  return null;
}

// Function to decode JWT payload
function decodeJWT(token) {
  try {
    const payload = token.split('.')[1];
    const decoded = JSON.parse(atob(payload));
    return decoded;
  } catch (e) {
    return null;
  }
}

document.addEventListener("DOMContentLoaded", function () {
  // Check if user is logged in by calling /me endpoint
  console.log('Header loaded, checking authentication...');
  console.log('Current cookies:', document.cookie);
  
  fetch('http://localhost:3000/api/auth/me', {
    method: 'GET',
    credentials: 'include' // Include cookies
  })
  .then(response => {
    console.log('Response status:', response.status);
    if (response.ok) {
      return response.json();
    } else {
      throw new Error('Not logged in');
    }
  })
  .then(data => {
    console.log('User is logged in:', data.user);
    const userName = data.user.name || data.user.username || data.user.email || 'User';
    updateLoginSection(userName);
  })
  .catch(error => {
    console.log('User not logged in:', error.message);
    // User not logged in, keep default login button
  });

  // Gửi chiều cao khi tải và resize
  setTimeout(sendHeaderHeight, 100);
  window.addEventListener("resize", sendHeaderHeight); 

  // Listen for login success
  window.addEventListener("message", function (event) {
    console.log("Header received message:", event.data);
    if (event.data && event.data.type === "loginSuccess") {
      console.log("Updating header for user:", event.data.userName);
      const userName = event.data.userName || "User";
      updateLoginSection(userName);

      // Gửi chiều cao sau khi login thành công
      setTimeout(sendHeaderHeight, 50);
    }

    // Logic cho nút "Dịch vụ"
    const serviceButton = document.getElementById("service-menu-button");
    if (event.data && event.data.type === "dropdownShown") {
      if(serviceButton) serviceButton.classList.add("active");
    }
    if (event.data && event.data.type === "dropdownHidden") {
      if(serviceButton) serviceButton.classList.remove("active");
    }
  });

  // Sự kiện mở login từ header
  document.querySelectorAll("button").forEach((btn) => {
    if (btn.textContent.includes("Đăng nhập")) {
      btn.addEventListener("click", function (e) {
        if (window.parent && window.parent !== window) {
          window.parent.postMessage({ type: "openLoginModal" }, "*");
          e.preventDefault();
          return;
        }
      });
    }
  });

  // Thêm listener cho nút Dịch vụ
  const serviceButton = document.getElementById("service-menu-button");
  if (serviceButton) {
    serviceButton.addEventListener("click", function () {
      if (window.parent) {
        window.parent.postMessage({ type: "toggleMegaDropdown" }, "*");
      }
    });
  }

  // Mobile menu toggle functionality
  const mobileMenuButton = document.querySelector(".xls\\:hidden .lucide-menu");
  const mobileMenuContainer = document.querySelector(".xls\\:hidden");
  const mobileMenuClose = document.querySelector(".xls\\:hidden .lucide-x");

  if (mobileMenuButton && mobileMenuContainer) {
    mobileMenuButton.addEventListener("click", function () {
      mobileMenuContainer.classList.add("menu-active");
      // Gửi chiều cao khi mở mobile menu
      setTimeout(sendHeaderHeight, 50);
    });
  }

  if (mobileMenuClose && mobileMenuContainer) {
    mobileMenuClose.addEventListener("click", function () {
      mobileMenuContainer.classList.remove("menu-active");
      // Gửi chiều cao khi đóng mobile menu
      setTimeout(sendHeaderHeight, 50);
    });
  }

  // Close menus when clicking outside
  document.addEventListener("click", function (e) {
    let heightChanged = false; // Biến cờ để kiểm tra
    
    // Logic đóng Mobile Menu
    if (
      mobileMenuContainer &&
      mobileMenuContainer.classList.contains("menu-active")
    ) {
      const menuDropdown = mobileMenuContainer.querySelector(".fixed");
      if (
        menuDropdown &&
        !menuDropdown.contains(e.target) &&
        !mobileMenuButton.contains(e.target)
      ) {
        mobileMenuContainer.classList.remove("menu-active");
        heightChanged = true;
      }
    }

    // Logic đóng User Dropdown
    const userMenuDropdown = document.getElementById("user-menu-dropdown");
    const userMenuButton = document.getElementById("user-menu-button");

    if (userMenuDropdown && !userMenuDropdown.classList.contains("hidden")) {
      if (
        userMenuButton &&
        !userMenuButton.contains(e.target) &&
        !userMenuDropdown.contains(e.target)
      ) {
        userMenuDropdown.classList.add("hidden"); 
        heightChanged = true;
      }
    }
    
    // Gửi chiều cao nếu có thay đổi
    if (heightChanged) {
      setTimeout(sendHeaderHeight, 50);
    }
  });

  // Close mobile menu on escape key
  document.addEventListener("keydown", function (e) {
    let heightChanged = false; 

    if (e.key === "Escape") {
      if (
        mobileMenuContainer &&
        mobileMenuContainer.classList.contains("menu-active")
      ) {
        mobileMenuContainer.classList.remove("menu-active");
        heightChanged = true;
      }

      const userMenuDropdown = document.getElementById("user-menu-dropdown");
      if (userMenuDropdown && !userMenuDropdown.classList.contains("hidden")) {
        userMenuDropdown.classList.add("hidden");
        heightChanged = true;
      }
      
      if (heightChanged) {
        setTimeout(sendHeaderHeight, 50);
      }
    }
  });
});

// Function to update login section
function updateLoginSection(userName) {
  const loginSection = document.getElementById("login-section");
  if (loginSection) {
    loginSection.innerHTML = `
      <div class="flex items-center gap-x-4">
        <div class="relative inline-block text-left py-1 px-3">
          
          <button id="user-menu-button" class="items-center justify-center whitespace-nowrap text-[16px] font-[500] transition-colors focus-visible:outline-none focus-visible:ring-1 focus-visible:ring-ring disabled:pointer-events-none disabled:bg-[#CECECD] px-[40px] py-[12px] flex bg-[#090806] rounded-full border-[#07F668] border-[1px] h-[48px] w-[155px] sm:w-[152px] max-w-[200px] hover:bg-[#07F668]">
            <div class="flex items-center gap-x-2 px-4 pointer-events-none">
              <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-user-round text-white">
                <circle cx="12" cy="8" r="5"></circle>
                <path d="M20 21a8 8 0 0 0-16 0"></path>
              </svg>
              <span class="font-[60px] text-[16px] text-[#FFF] truncate max-w-[90px]" title="${userName}">${userName}</span>
            </div>
          </button>

          <div id="user-menu-dropdown" class="hidden z-50 origin-top-right absolute right-0 mt-2 w-full min-w-[250px] shadow-lg bg-white ring-1 ring-black ring-opacity-5 border-1 border-[#E6E6E6] rounded-[8px]">
            <div class="py-1" role="menu" aria-orientation="vertical" aria-labelledby="user-menu-button">
              
              <a class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 btn w-full" role="menuitem" href="/account/my-orders" style="text-align: left;">
                <div class="flex items-center">
                  <img src="../../assets/images/list-order.png" class="w-6 h-6 mr-2">
                  <span class="text-[16px]">Đơn hàng của tôi</span>
                </div>
              </a>
              <a class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 btn w-full" role="menuitem" href="/account/account-info" style="text-align: left;">
                <div class="flex items-center">
                  <img src="../../assets/images/account.png" class="w-6 h-6 mr-2">
                  <span class="text-[16px]">Tài khoản</span>
                </div>
              </a>
              
              <a id="logout-button" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 btn w-full" role="menuitem" href="../home/home.html" target="_top" style="text-align: left; cursor: pointer;">
                <div class="flex items-center">
                  <img src="../../assets/images/log-out.png" class="w-6 h-6 mr-2">
                  <span class="text-[16px]">Đăng xuất</span>
                </div>
              </a>
            </div>
          </div>
          
        </div>
        
        <div class="xls:hidden block">
          <div>
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-menu cursor-pointer text-white">
              <line x1="4" x2="20" y1="12" y2="12"></line>
              <line x1="4" x2="20" y1="6" y2="6"></line>
              <line x1="4" x2="20" y1="18" y2="18"></line>
            </svg>
          </div>
        </div>
      </div>
    `;
    // Add event listeners for dropdown
    setTimeout(() => {
      const userMenuButton = document.getElementById("user-menu-button");
      const userMenuDropdown = document.getElementById("user-menu-dropdown");
      const logoutButton = document.getElementById("logout-button");

      if (userMenuButton && userMenuDropdown) {
        userMenuButton.addEventListener("click", function () {
          userMenuDropdown.classList.toggle("hidden");
          sendHeaderHeight(); // Update height
        });
      }

      if (logoutButton) {
        logoutButton.addEventListener("click", function (e) {
          e.preventDefault(); // Prevent href navigation
          // Call logout endpoint
          fetch('http://localhost:3000/api/auth/logout', {
            method: 'POST',
            credentials: 'include'
          })
          .then(response => response.json())
          .then(data => {
            console.log('Logged out:', data.message);
            window.top.location.href = '../home/home.html'; // Navigate to home
          })
          .catch(error => {
            console.error('Logout error:', error);
            window.top.location.href = '../home/home.html'; // Navigate to home anyway
          });
        });
      }
    }, 0);
  }
}