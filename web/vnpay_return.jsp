<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kết quả thanh toán - TVT Future</title>
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Mulish:ital,wght@0,200..1000;1,200..1000&display=swap" rel="stylesheet">
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        body {
            font-family: 'Mulish', sans-serif;
            background: #f7fafc;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
        }
        .container {
            background: #fff;
            padding: 2rem;
            border-radius: 8px;
            max-width: 400px;
            width: 90%;
            text-align: center;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
        .success {
            border-top: 4px solid #2f855a;
        }
        .error {
            border-top: 4px solid #c53030;
        }
        .container h2 {
            font-size: 1.5rem;
            font-weight: 700;
            margin-bottom: 1rem;
        }
        .container p {
            font-size: 1rem;
            color: #4a5568;
            margin-bottom: 1.5rem;
        }
        .back-btn {
            background: #2b6cb0;
            color: #fff;
            padding: 0.5rem 1rem;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 1rem;
        }
        .back-btn:hover {
            background: #2c5282;
        }
    </style>
</head>
<body>
    <div class="container <%= "00".equals(request.getParameter("vnp_ResponseCode")) ? "success" : "error" %>">
        <%
            String responseCode = request.getParameter("vnp_ResponseCode");
            String vnpOrderInfo = request.getParameter("vnp_OrderInfo");
            String bookingId = null;
            String status = "00".equals(responseCode) ? "success" : "failed";

            // Trích xuất bookingId từ vnp_OrderInfo
            if (vnpOrderInfo != null && vnpOrderInfo.contains("Booking: ")) {
                try {
                    bookingId = vnpOrderInfo.split("Booking: ")[1].trim();
                } catch (Exception e) {
                    bookingId = null;
                }
            }
        %>
        <c:choose>
            <c:when test='<%= "00".equals(responseCode) %>'>
                <h2>Thanh toán thành công!</h2>
                <p>Đơn hàng <%= bookingId != null ? bookingId : "không xác định" %> đã được thanh toán thành công. Cảm ơn bạn đã sử dụng dịch vụ!</p>
            </c:when>
            <c:otherwise>
                <h2>Thanh toán thất bại</h2>
                <p>Thanh toán cho đơn hàng <%= bookingId != null ? bookingId : "không xác định" %> không thành công. Mã lỗi: <%= responseCode %>. Vui lòng thử lại hoặc liên hệ hỗ trợ.</p>
            </c:otherwise>
        </c:choose>
        <button class="back-btn" onclick="handleBack('<%= status %>', '<%= bookingId != null ? bookingId : "" %>', '<%= responseCode %>')">Quay lại đơn hàng</button>
    </div>
    <script>
        function handleBack(status, bookingId, responseCode) {
            console.log('Handling back button:', { status, bookingId, responseCode });
            if (responseCode === '00' && bookingId) {
                // Gửi yêu cầu tạo bản ghi thanh toán
                fetch('${pageContext.request.contextPath}/payment/create', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded'
                    },
                    body: 'bookingId=' + encodeURIComponent(bookingId) + 
                          '&vnp_TxnRef=' + encodeURIComponent('<%= request.getParameter("vnp_TxnRef") %>') +
                          '&vnp_Amount=' + encodeURIComponent('<%= request.getParameter("vnp_Amount") %>')
                })
                .then(response => {
                    console.log('Create payment response:', response);
                    if (!response.ok) {
                        return response.json().then(err => { throw new Error(err.message || 'Lỗi khi tạo bản ghi thanh toán'); });
                    }
                    return response.json();
                })
                .then(data => {
                    console.log('Create payment data:', data);
                    // Gửi yêu cầu gửi email xác nhận
                    return fetch('${pageContext.request.contextPath}/payment/send-email', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/x-www-form-urlencoded'
                        },
                        body: 'bookingId=' + encodeURIComponent(bookingId) + 
                              '&vnp_TxnRef=' + encodeURIComponent('<%= request.getParameter("vnp_TxnRef") %>') +
                              '&vnp_Amount=' + encodeURIComponent('<%= request.getParameter("vnp_Amount") %>')
                    });
                })
                .then(response => {
                    console.log('Send email response:', response);
                    if (!response.ok) {
                        return response.json().then(err => { throw new Error(err.message || 'Lỗi khi gửi email xác nhận'); });
                    }
                    return response.json();
                })
                .then(data => {
                    console.log('Send email data:', data);
                    // Gửi yêu cầu cập nhật trạng thái Booking
                    const completeUrl = '${pageContext.request.contextPath}/bookings/complete';
                    return fetch(completeUrl, {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/x-www-form-urlencoded'
                        },
                        body: 'id=' + encodeURIComponent(bookingId)
                    });
                })
                .then(response => {
                    console.log('Complete booking response:', response);
                    if (!response.ok) {
                        return response.text().then(text => { throw new Error(text || 'Lỗi khi cập nhật trạng thái'); });
                    }
                    // Chuyển hướng về my-orders.jsp
                    const redirectUrl = '${pageContext.request.contextPath}/my-orders?status=success&bookingId=' + bookingId;
                    console.log('Redirecting to:', redirectUrl);
                    window.location.href = redirectUrl;
                })
                .catch(error => {
                    console.error('Error processing payment, email, or completing booking:', error);
                    alert('Lỗi khi xử lý thanh toán, gửi email, hoặc cập nhật trạng thái đơn hàng: ' + error.message + '. Vui lòng liên hệ hỗ trợ.');
                    // Vẫn chuyển hướng để không làm gián đoạn trải nghiệm người dùng
                    const redirectUrl = '${pageContext.request.contextPath}/my-orders?status=success&bookingId=' + bookingId;
                    window.location.href = redirectUrl;
                });
            } else {
                // Thanh toán thất bại hoặc không có bookingId, chuyển hướng trực tiếp
                const redirectUrl = '${pageContext.request.contextPath}/my-orders?status=failed' + (bookingId ? '&bookingId=' + bookingId : '');
                console.log('Redirecting to:', redirectUrl);
                window.location.href = redirectUrl;
            }
        }
    </script>
</body>
</html>