package controller;

import dao.BookingsJpaController;
import dao.CarJpaController;
import dao.ModelJpaController;
import dao.PaymentsJpaController;
import dao.CustomersJpaController;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Bookings;
import model.Cars;
import model.Payments;
import model.Models;
import model.Customers;
import utils.VNPayUtil;
import utils.VNPayConfig;

import java.io.IOException;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import com.google.gson.Gson;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import java.net.URLEncoder;
import java.util.List;

@WebServlet(name = "PaymentServlet", urlPatterns = {"/payment", "/payment/update", "/payment/callback", "/payment/create"})
public class PaymentServlet extends HttpServlet {

    private final EntityManagerFactory emf = Persistence.createEntityManagerFactory("tvtfuturePU");
    private BookingsJpaController bookingController;
    private PaymentsJpaController paymentController;
    private ModelJpaController modelController;
    private CarJpaController carController;
    private CustomersJpaController customerController;

    @Override
    public void init() throws ServletException {
        bookingController = new BookingsJpaController(emf);
        paymentController = new PaymentsJpaController(emf);
        modelController = new ModelJpaController(emf);
        carController = new CarJpaController(emf);
        customerController = new CustomersJpaController(emf);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getServletPath();

        if ("/payment/update".equals(action)) {
            processPaymentUpdate(request, response);
        } else if ("/payment/callback".equals(action)) {
            processPaymentCallback(request, response);
        } else if ("/payment/create".equals(action)) {
            processPaymentCreation(request, response);
        } else {
            processPayment(request, response);
        }
    }

    private void processPaymentUpdate(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        Gson gson = new Gson();

        try {
            // Đọc dữ liệu JSON từ request
            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = request.getReader().readLine()) != null) {
                sb.append(line);
            }
            Map<String, String> params = gson.fromJson(sb.toString(), Map.class);

            String bookingId = params.get("bookingId");
            String amount = params.get("amount");
            String modelId = params.get("modelId");
            String carId = params.get("carId");
            String rentalType = params.get("rentalType");
            String pickupDate = params.get("pickupDate");
            String pickupTime = params.get("pickupTime");
            String returnDate = params.get("returnDate");
            String returnTime = params.get("returnTime");
            String rentalMonths = params.get("rentalMonths");
            String name = params.get("name");
            String phone = params.get("phone");
            String email = params.get("email");
            String pickupLocation = params.get("pickupLocation");

            // Log parameters for debugging
            System.out.println("Received parameters: bookingId=" + bookingId + ", amount=" + amount + ", modelId=" + modelId +
                               ", carId=" + carId + ", rentalType=" + rentalType + ", pickupDate=" + pickupDate +
                               ", pickupTime=" + pickupTime + ", returnDate=" + returnDate + ", returnTime=" + returnTime +
                               ", rentalMonths=" + rentalMonths + ", name=" + name + ", phone=" + phone +
                               ", email=" + email + ", pickupLocation=" + pickupLocation);

            // Validate required fields
            if (bookingId == null || bookingId.trim().isEmpty() || amount == null || amount.trim().isEmpty() ||
                modelId == null || modelId.trim().isEmpty() || carId == null || carId.trim().isEmpty() ||
                rentalType == null || rentalType.trim().isEmpty() || name == null || name.trim().isEmpty() ||
                phone == null || phone.trim().isEmpty() || email == null || email.trim().isEmpty() ||
                pickupLocation == null || pickupLocation.trim().isEmpty() ||
                pickupDate == null || pickupDate.trim().isEmpty() || pickupTime == null || pickupTime.trim().isEmpty()) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write(gson.toJson(new ErrorResponse("Thiếu thông tin bắt buộc. Vui lòng kiểm tra lại các trường nhập.")));
                return;
            }
            if (rentalType.equals("ngay") && (returnDate == null || returnDate.trim().isEmpty() || returnTime == null || returnTime.trim().isEmpty())) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write(gson.toJson(new ErrorResponse("Thiếu ngày/giờ trả xe cho hình thức thuê theo ngày")));
                return;
            }
            if (rentalType.equals("thang") && (rentalMonths == null || rentalMonths.trim().isEmpty())) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write(gson.toJson(new ErrorResponse("Thiếu số tháng thuê cho hình thức thuê theo tháng")));
                return;
            }

            // Validate and parse amount
            BigDecimal amountValue;
            try {
                amountValue = new BigDecimal(amount);
                if (amountValue.compareTo(BigDecimal.ZERO) <= 0) {
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    response.getWriter().write(gson.toJson(new ErrorResponse("Số tiền phải lớn hơn 0")));
                    return;
                }
            } catch (NumberFormatException e) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write(gson.toJson(new ErrorResponse("Số tiền không hợp lệ: " + amount)));
                return;
            }

            // Convert amount to long for VNPay
            long amountForVNPay = amountValue.setScale(0, BigDecimal.ROUND_DOWN).longValue();

            // Validate and parse rentalMonths for monthly rental
            int rentalMonthsValue = 0;
            if (rentalType.equals("thang")) {
                try {
                    rentalMonthsValue = Integer.parseInt(rentalMonths);
                    if (rentalMonthsValue <= 0) {
                        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                        response.getWriter().write(gson.toJson(new ErrorResponse("Số tháng thuê phải lớn hơn 0")));
                        return;
                    }
                } catch (NumberFormatException e) {
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    response.getWriter().write(gson.toJson(new ErrorResponse("Số tháng thuê không hợp lệ: " + rentalMonths)));
                    return;
                }
            }

            // Validate email and phone format
            if (!email.matches("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$")) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write(gson.toJson(new ErrorResponse("Email không hợp lệ")));
                return;
            }
            if (!phone.matches("^\\d{10}$")) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write(gson.toJson(new ErrorResponse("Số điện thoại phải có 10 chữ số")));
                return;
            }

            // Validate model and car
            Models model = modelController.findModels(modelId);
            if (model == null) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write(gson.toJson(new ErrorResponse("Mẫu xe không tồn tại")));
                return;
            }
            Cars car = carController.findCars(carId);
            if (car == null || !car.getVehicleModelId().getId().equals(modelId)) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write(gson.toJson(new ErrorResponse("Xe không hợp lệ")));
                return;
            }

            // Validate booking
            Bookings booking = bookingController.findBookings(bookingId);
            if (booking == null) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write(gson.toJson(new ErrorResponse("Đơn hàng không tồn tại")));
                return;
            }
            if (!booking.getStatus().equals("PENDING")) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write(gson.toJson(new ErrorResponse("Đơn hàng không ở trạng thái PENDING")));
                return;
            }

            // Generate temporary transaction ID for VNPay
            String transactionId = String.valueOf(System.currentTimeMillis());

            // Prepare VNPay parameters
            Map<String, String> vnp_Params = new HashMap<>();
            vnp_Params.put("vnp_Version", "2.1.0");
            vnp_Params.put("vnp_Command", "pay");
            vnp_Params.put("vnp_TmnCode", VNPayConfig.vnp_TmnCode);
            vnp_Params.put("vnp_Amount", String.valueOf(amountForVNPay * 100));
            vnp_Params.put("vnp_CurrCode", "VND");
            vnp_Params.put("vnp_TxnRef", transactionId);
            vnp_Params.put("vnp_OrderInfo", String.format("Thanh toan thue xe %s, Booking: %s", modelId, bookingId));
            vnp_Params.put("vnp_OrderType", "other");
            vnp_Params.put("vnp_Locale", "vn");
            vnp_Params.put("vnp_ReturnUrl", VNPayConfig.vnp_ReturnUrl);
            vnp_Params.put("vnp_IpAddr", request.getRemoteAddr());

            String createDate = java.time.LocalDateTime.now().format(java.time.format.DateTimeFormatter.ofPattern("yyyyMMddHHmmss"));
            vnp_Params.put("vnp_CreateDate", createDate);

            String paymentUrl = VNPayUtil.getPaymentUrl(vnp_Params, VNPayConfig.vnp_HashSecret, VNPayConfig.vnp_PayUrl);

            // Trả về URL thanh toán và transactionId
            response.getWriter().write(gson.toJson(new SuccessResponse(paymentUrl, transactionId)));
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write(gson.toJson(new ErrorResponse("Lỗi xử lý yêu cầu thanh toán: " + e.getMessage())));
        }
    }

    private void processPaymentCallback(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        response.setContentType("application/json");
        Gson gson = new Gson();

        EntityManager em = emf.createEntityManager();
        EntityTransaction tx = em.getTransaction();

        try {
            // Lấy tham số từ VNPay
            String vnp_TxnRef = request.getParameter("vnp_TxnRef");
            String vnp_ResponseCode = request.getParameter("vnp_ResponseCode");
            String vnp_SecureHash = request.getParameter("vnp_SecureHash");
            String vnp_Amount = request.getParameter("vnp_Amount");
            String vnp_OrderInfo = request.getParameter("vnp_OrderInfo");

            // Log parameters for debugging
            System.out.println("VNPay Callback: vnp_TxnRef=" + vnp_TxnRef + ", vnp_ResponseCode=" + vnp_ResponseCode +
                               ", vnp_SecureHash=" + vnp_SecureHash + ", vnp_Amount=" + vnp_Amount +
                               ", vnp_OrderInfo=" + vnp_OrderInfo);

            // Validate secure hash
            Map<String, String> vnp_Params = new HashMap<>();
            for (String key : request.getParameterMap().keySet()) {
                if (!key.equals("vnp_SecureHash")) {
                    vnp_Params.put(key, request.getParameter(key));
                }
            }
            String calculatedHash = VNPayUtil.calculateSecureHash(vnp_Params, VNPayConfig.vnp_HashSecret);
            if (!calculatedHash.equals(vnp_SecureHash)) {
                System.out.println("Invalid secure hash: calculated=" + calculatedHash + ", received=" + vnp_SecureHash);
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write(gson.toJson(new ErrorResponse("Chữ ký không hợp lệ")));
                return;
            }

            // Extract bookingId from vnp_OrderInfo
            String bookingId = null;
            if (vnp_OrderInfo != null && vnp_OrderInfo.contains("Booking: ")) {
                try {
                    bookingId = vnp_OrderInfo.split("Booking: ")[1].trim();
                } catch (Exception e) {
                    System.out.println("Error extracting bookingId from vnp_OrderInfo: " + vnp_OrderInfo);
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    response.getWriter().write(gson.toJson(new ErrorResponse("Không thể lấy bookingId từ vnp_OrderInfo")));
                    return;
                }
            }
            if (bookingId == null) {
                System.out.println("bookingId is null or empty");
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write(gson.toJson(new ErrorResponse("Không thể lấy bookingId từ vnp_OrderInfo")));
                return;
            }

            // Find booking
            Bookings booking = bookingController.findBookings(bookingId);
            if (booking == null) {
                System.out.println("Booking not found: " + bookingId);
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write(gson.toJson(new ErrorResponse("Đơn hàng không tồn tại")));
                return;
            }

            // Check payment status
            if ("00".equals(vnp_ResponseCode)) {
                // Thanh toán thành công
                tx.begin();
                try {
                    // Kiểm tra xem bản ghi thanh toán đã tồn tại chưa
                    List<Payments> existingPayments = paymentController.findPaymentsByBookingId(bookingId);
                    if (existingPayments.isEmpty()) {
                        // Tạo bản ghi Payments
                        Payments payment = new Payments();
                        String paymentId;
                        synchronized (this) {
                            paymentId = "pay" + String.format("%02d", paymentController.getPaymentsCount() + 1);
                            payment.setId(paymentId);
                        }
                        payment.setAmount(new BigDecimal(vnp_Amount).divide(new BigDecimal(100)).subtract(booking.getDeposit() != null ? booking.getDeposit() : BigDecimal.ZERO));
                        payment.setDeposit(booking.getDeposit() != null ? booking.getDeposit() : BigDecimal.ZERO);
                        payment.setOtherCosts(BigDecimal.ZERO);
                        payment.setStatus("COMPLETED");
                        payment.setPaymentMethod("VNPAY");
                        payment.setTransactionId(vnp_TxnRef);
                        payment.setTimestamp(new Date());
                        payment.setLatePaymentPenalty(BigDecimal.ZERO);
                        payment.setBookingId(booking);

                        System.out.println("Creating payment: paymentId=" + paymentId + ", bookingId=" + bookingId);
                        paymentController.create(payment);
                    }

                    // Cập nhật trạng thái Booking
                    booking.setStatus("CONFIRMED");
                    bookingController.edit(booking);

                    tx.commit();
                    System.out.println("Payment successful: Booking ID=" + booking.getId());

                    // Chuyển hướng đến vnpay_return.jsp
                    response.sendRedirect(request.getContextPath() + "/payment/vnpay_return?vnp_ResponseCode=" + vnp_ResponseCode + "&vnp_OrderInfo=" + URLEncoder.encode(vnp_OrderInfo, "UTF-8") + "&vnp_TxnRef=" + vnp_TxnRef);
                } catch (Exception e) {
                    if (tx.isActive()) tx.rollback();
                    System.out.println("Error updating booking or creating payment: " + e.getMessage());
                    e.printStackTrace();
                    response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                    response.getWriter().write(gson.toJson(new ErrorResponse("Lỗi khi cập nhật đơn hàng hoặc tạo thanh toán: " + e.getMessage())));
                }
            } else {
                // Thanh toán thất bại
                System.out.println("Payment failed: Booking ID=" + booking.getId() + ", Response Code=" + vnp_ResponseCode);
                response.sendRedirect(request.getContextPath() + "/payment/vnpay_return?vnp_ResponseCode=" + vnp_ResponseCode + "&vnp_OrderInfo=" + URLEncoder.encode(vnp_OrderInfo, "UTF-8") + "&vnp_TxnRef=" + vnp_TxnRef);
            }
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            System.out.println("Error processing callback: " + e.getMessage());
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write(gson.toJson(new ErrorResponse("Lỗi xử lý callback thanh toán: " + e.getMessage())));
        } finally {
            em.close();
        }
    }

    private void processPaymentCreation(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        Gson gson = new Gson();

        String bookingId = request.getParameter("bookingId");
        String vnp_TxnRef = request.getParameter("vnp_TxnRef");
        String vnp_Amount = request.getParameter("vnp_Amount");

        // Log parameters for debugging
        System.out.println("ProcessPaymentCreation: bookingId=" + bookingId + ", vnp_TxnRef=" + vnp_TxnRef + ", vnp_Amount=" + vnp_Amount);

        // Validate parameters
        if (bookingId == null || vnp_TxnRef == null || vnp_Amount == null) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write(gson.toJson(new ErrorResponse("Thiếu tham số bắt buộc")));
            return;
        }

        EntityManager em = emf.createEntityManager();
        EntityTransaction tx = em.getTransaction();

        try {
            // Kiểm tra xem bản ghi thanh toán đã tồn tại chưa
            List<Payments> existingPayments = paymentController.findPaymentsByBookingId(bookingId);
            if (!existingPayments.isEmpty()) {
                response.getWriter().write(gson.toJson(new SuccessResponse("Bản ghi thanh toán đã tồn tại", vnp_TxnRef)));
                return;
            }

            // Tìm booking
            Bookings booking = bookingController.findBookings(bookingId);
            if (booking == null) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write(gson.toJson(new ErrorResponse("Đơn hàng không tồn tại")));
                return;
            }

            // Tạo bản ghi Payments
            tx.begin();
            Payments payment = new Payments();
            String paymentId;
            synchronized (this) {
                paymentId = "pay" + String.format("%02d", paymentController.getPaymentsCount() + 1);
                payment.setId(paymentId);
            }
            payment.setAmount(new BigDecimal(vnp_Amount).divide(new BigDecimal(100)).subtract(booking.getDeposit() != null ? booking.getDeposit() : BigDecimal.ZERO));
            payment.setDeposit(booking.getDeposit() != null ? booking.getDeposit() : BigDecimal.ZERO);
            payment.setOtherCosts(BigDecimal.ZERO);
            payment.setStatus("COMPLETED");
            payment.setPaymentMethod("VNPAY");
            payment.setTransactionId(vnp_TxnRef);
            payment.setTimestamp(new Date());
            payment.setLatePaymentPenalty(BigDecimal.ZERO);
            payment.setBookingId(booking);

            paymentController.create(payment);

            // Cập nhật trạng thái Booking
            booking.setStatus("CONFIRMED");
            bookingController.edit(booking);

            tx.commit();
            response.getWriter().write(gson.toJson(new SuccessResponse("Tạo bản ghi thanh toán thành công", vnp_TxnRef)));
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write(gson.toJson(new ErrorResponse("Lỗi khi tạo bản ghi thanh toán: " + e.getMessage())));
        } finally {
            em.close();
        }
    }

    private void processPayment(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String amount = request.getParameter("amount");
        String modelId = request.getParameter("modelId");
        String carId = request.getParameter("carId");
        String rentalType = request.getParameter("rentalType");
        String pickupDate = request.getParameter("pickupDate");
        String returnDate = request.getParameter("returnDate");
        String rentalMonths = request.getParameter("rentalMonths");
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String pickupLocation = request.getParameter("pickupLocation");
        String pickupTime = request.getParameter("pickupTime");
        String returnTime = request.getParameter("returnTime");

        // Log parameters for debugging
        System.out.println("Received parameters: amount=" + amount + ", modelId=" + modelId + ", carId=" + carId +
                           ", rentalType=" + rentalType + ", pickupDate=" + pickupDate + ", returnDate=" + returnDate +
                           ", rentalMonths=" + rentalMonths + ", name=" + name + ", phone=" + phone +
                           ", email=" + email + ", pickupLocation=" + pickupLocation + ", pickupTime=" + pickupTime +
                           ", returnTime=" + returnTime);

        // Validate required fields
        if (amount == null || amount.trim().isEmpty() || modelId == null || modelId.trim().isEmpty() ||
            carId == null || carId.trim().isEmpty() || rentalType == null || rentalType.trim().isEmpty() ||
            name == null || name.trim().isEmpty() || phone == null || phone.trim().isEmpty() ||
            email == null || email.trim().isEmpty() || pickupLocation == null || pickupLocation.trim().isEmpty() ||
            pickupDate == null || pickupDate.trim().isEmpty() || pickupTime == null || pickupTime.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Thiếu thông tin bắt buộc. Vui lòng kiểm tra lại các trường nhập.");
            return;
        }
        if (rentalType.equals("ngay") && (returnDate == null || returnDate.trim().isEmpty() || returnTime == null || returnTime.trim().isEmpty())) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Thiếu ngày/giờ trả xe cho hình thức thuê theo ngày");
            return;
        }
        if (rentalType.equals("thang") && (rentalMonths == null || rentalMonths.trim().isEmpty())) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Thiếu số tháng thuê cho hình thức thuê theo tháng");
            return;
        }

        try {
            // Validate and parse amount
            BigDecimal amountValue;
            try {
                amountValue = new BigDecimal(amount);
                if (amountValue.compareTo(BigDecimal.ZERO) <= 0) {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Số tiền phải lớn hơn 0");
                    return;
                }
            } catch (NumberFormatException e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Số tiền không hợp lệ: " + amount);
                return;
            }

            // Convert amount to long for VNPay
            long amountForVNPay = amountValue.setScale(0, BigDecimal.ROUND_DOWN).longValue();

            // Validate and parse rentalMonths for monthly rental
            int rentalMonthsValue = 0;
            if (rentalType.equals("thang")) {
                try {
                    rentalMonthsValue = Integer.parseInt(rentalMonths);
                    if (rentalMonthsValue <= 0) {
                        response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Số tháng thuê phải lớn hơn 0");
                        return;
                    }
                } catch (NumberFormatException e) {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Số tháng thuê không hợp lệ: " + rentalMonths);
                    return;
                }
            }

            // Validate email and phone format
            if (!email.matches("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$")) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Email không hợp lệ");
                return;
            }
            if (!phone.matches("^\\d{10}$")) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Số điện thoại phải có 10 chữ số");
                return;
            }

            // Validate model and car
            Models model = modelController.findModels(modelId);
            if (model == null) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Mẫu xe không tồn tại");
                return;
            }
            Cars car = carController.findCars(carId);
            if (car == null || !car.getVehicleModelId().getId().equals(modelId)) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Xe không hợp lệ");
                return;
            }

            // Find or create Customer
            Customers customer = customerController.findByEmail(email);
            if (customer == null) {
                customer = customerController.findByPhone(phone);
            }
            if (customer == null) {
                customer = new Customers();
                customer.setId("cus" + String.format("%02d", customerController.getCustomersCount() + 1));
                customer.setFullName(name);
                customer.setEmail(email);
                customer.setPhone(phone);
                customer.setStatus("ACTIVE");
                customer.setCreatedAt(new Date());
                customer.setUpdatedAt(new Date());
                customerController.create(customer);
            } else {
                // Update customer information if needed
                if (!name.equals(customer.getFullName()) || !phone.equals(customer.getPhone())) {
                    customer.setFullName(name);
                    customer.setPhone(phone);
                    customer.setUpdatedAt(new Date());
                    customerController.edit(customer);
                }
            }

            // Create Booking
            Bookings booking = new Bookings();
            String bookingId;
            synchronized (this) {
                bookingId = "bk" + String.format("%02d", bookingController.getBookingsCount() + 1);
                booking.setId(bookingId);
            }
            booking.setCustomerId(customer);
            booking.setCarId(car);
            booking.setPickupLocation(pickupLocation);
            booking.setDropoffLocation(pickupLocation);
            booking.setStatus("PENDING");
            booking.setCreatedAt(new Date());
            booking.setUpdatedAt(new Date());

            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            SimpleDateFormat timeFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
            try {
                booking.setStartDate(dateFormat.parse(pickupDate));
                booking.setDeliveryTime(timeFormat.parse(pickupDate + " " + pickupTime));
            } catch (Exception e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Ngày/giờ nhận xe không hợp lệ: pickupDate=" + pickupDate + ", pickupTime=" + pickupTime);
                return;
            }

            if (rentalType.equals("ngay")) {
                try {
                    booking.setEndDate(dateFormat.parse(returnDate));
                    booking.setReturnTime(timeFormat.parse(returnDate + " " + returnTime));
                } catch (Exception e) {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Ngày/giờ trả xe không hợp lệ: returnDate=" + returnDate + ", returnTime=" + returnTime);
                    return;
                }
                if (booking.getEndDate() == null || booking.getStartDate() == null) {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Ngày bắt đầu hoặc kết thúc không hợp lệ");
                    return;
                }
                long timeDiff = booking.getEndDate().getTime() - booking.getStartDate().getTime();
                double days = timeDiff / (1000.0 * 60 * 60 * 24);
                booking.setTotalDays(Math.max(1, (int) Math.ceil(days)));
                booking.setPricePerDay(model.getRentalPricePerDay());
                booking.setDeposit(model.getDepositPerDay());
                booking.setBillingCycle("DAILY");
            } else {
                booking.setTotalDays(rentalMonthsValue);
                booking.setPricePerDay(model.getRentalPricePerMonth());
                booking.setDeposit(model.getDepositPerMonth());
                booking.setBillingCycle("MONTHLY");
            }
            booking.setTotalAmount(booking.getPricePerDay().multiply(new BigDecimal(booking.getTotalDays())));
            bookingController.create(booking);

            // Generate temporary transaction ID for VNPay
            String transactionId = String.valueOf(System.currentTimeMillis());

            // Prepare VNPay parameters
            Map<String, String> vnp_Params = new HashMap<>();
            vnp_Params.put("vnp_Version", "2.1.0");
            vnp_Params.put("vnp_Command", "pay");
            vnp_Params.put("vnp_TmnCode", VNPayConfig.vnp_TmnCode);
            vnp_Params.put("vnp_Amount", String.valueOf(amountForVNPay * 100));
            vnp_Params.put("vnp_CurrCode", "VND");
            vnp_Params.put("vnp_TxnRef", transactionId);
            vnp_Params.put("vnp_OrderInfo", String.format("Thanh toan thue xe %s, Booking: %s", modelId, bookingId));
            vnp_Params.put("vnp_OrderType", "other");
            vnp_Params.put("vnp_Locale", "vn");
            vnp_Params.put("vnp_ReturnUrl", VNPayConfig.vnp_ReturnUrl);
            vnp_Params.put("vnp_IpAddr", request.getRemoteAddr());

            String createDate = java.time.LocalDateTime.now().format(java.time.format.DateTimeFormatter.ofPattern("yyyyMMddHHmmss"));
            vnp_Params.put("vnp_CreateDate", createDate);

            String paymentUrl = VNPayUtil.getPaymentUrl(vnp_Params, VNPayConfig.vnp_HashSecret, VNPayConfig.vnp_PayUrl);
            response.sendRedirect(paymentUrl);
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi xử lý yêu cầu thanh toán: " + e.getMessage());
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "Phương thức GET không được hỗ trợ");
    }

    @Override
    public void destroy() {
        if (emf != null) {
            emf.close();
        }
    }

    // Helper classes for JSON response
    private static class ErrorResponse {
        private String message;
        public ErrorResponse(String message) {
            this.message = message;
        }
        public String getMessage() {
            return message;
        }
    }

    private static class SuccessResponse {
        private String message;
        private String transactionId;
        public SuccessResponse(String message, String transactionId) {
            this.message = message;
            this.transactionId = transactionId;
        }
        public String getMessage() {
            return message;
        }
        public String getTransactionId() {
            return transactionId;
        }
    }
}