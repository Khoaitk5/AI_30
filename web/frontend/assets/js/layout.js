document.addEventListener("DOMContentLoaded", () => {
    // Tự động gọi hàm tải footer
    // LƯU Ý: Thay đổi đường dẫn "/pages/footer/footer.html" 
    // cho đúng với cấu trúc thư mục từ GỐC website của bạn.
    loadHTMLComponent("../../components/footer/footer.html", "#footer-placeholder");

    // Bạn cũng có thể dùng cách này để thay thế iframe header
    // loadHTMLComponent("/pages/header/header.html", "#header-placeholder");
});

/**
 * Hàm tải nội dung từ một file HTML và chèn vào một placeholder
 * @param {string} url - Đường dẫn TỪ GỐC website đến file .html (ví dụ: "/pages/footer/footer.html")
 * @param {string} placeholderSelector - Selector CSS của div chứa (ví dụ: "#footer-placeholder")
 */
async function loadHTMLComponent(url, placeholderSelector) {
  const placeholder = document.querySelector(placeholderSelector);
  if (!placeholder) {
    return; // Nếu trang không có placeholder này, thì bỏ qua
  }

  try {
    const response = await fetch(url);
    if (!response.ok) {
      throw new Error(`Failed to fetch ${url}: ${response.statusText}`);
    }
    const htmlText = await response.text();
    const parser = new DOMParser();
    const doc = parser.parseFromString(htmlText, "text/html");
    
    // Lấy toàn bộ nội dung bên trong <body> của file component
    const content = doc.body.innerHTML;

    // Chèn nội dung vào placeholder
    placeholder.innerHTML = content;
    
  } catch (error) {
    console.error(`Error loading component from ${url}:`, error);
  }
}