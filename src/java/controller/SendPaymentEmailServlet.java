package controller;

import dao.BookingsJpaController;
import dao.PaymentsJpaController;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Bookings;
import model.Payments;
import utils.MailUtils;
import com.google.gson.Gson;
import jakarta.mail.MessagingException;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet(name = "SendPaymentEmailServlet", urlPatterns = {"/payment/send-email"})
public class SendPaymentEmailServlet extends HttpServlet {

    private final EntityManagerFactory emf = Persistence.createEntityManagerFactory("tvtfuturePU");
    private BookingsJpaController bookingController;
    private PaymentsJpaController paymentController;

    @Override
    public void init() throws ServletException {
        bookingController = new BookingsJpaController(emf);
        paymentController = new PaymentsJpaController(emf);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        Gson gson = new Gson();

        String bookingId = request.getParameter("bookingId");
        String vnp_Amount = request.getParameter("vnp_Amount");
        String vnp_TxnRef = request.getParameter("vnp_TxnRef");

        // Log parameters for debugging
        System.out.println("SendPaymentEmailServlet: bookingId=" + bookingId + ", vnp_Amount=" + vnp_Amount + ", vnp_TxnRef=" + vnp_TxnRef);

        // Validate parameters
        if (bookingId == null || bookingId.trim().isEmpty() || vnp_Amount == null || vnp_Amount.trim().isEmpty() || vnp_TxnRef == null || vnp_TxnRef.trim().isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write(gson.toJson(new ErrorResponse("Thiếu tham số bắt buộc")));
            return;
        }

        try {
            // Find booking
            Bookings booking = bookingController.findBookings(bookingId);
            if (booking == null) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write(gson.toJson(new ErrorResponse("Đơn hàng không tồn tại")));
                return;
            }

            // Find payment
            List<Payments> payments = paymentController.findPaymentsByBookingId(bookingId);
            if (payments.isEmpty()) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write(gson.toJson(new ErrorResponse("Không tìm thấy thông tin thanh toán cho đơn hàng")));
                return;
            }

            // Send email
            try {
                String subject = "Xác nhận thanh toán thành công - Green Future";
                String messageContent = String.format(
                    "Kính gửi %s,\n\n" +
                    "Cảm ơn bạn đã sử dụng dịch vụ thuê xe của Green Future!\n" +
                    "Đơn hàng của bạn với mã %s đã được thanh toán thành công.\n\n" +
                    "Thông tin thanh toán:\n" +
                    "- Mã đơn hàng: %s\n" +
                    "- Mã giao dịch: %s\n" +
                    "- Mẫu xe: %s\n" +
                    "- Số tiền thanh toán: %s VND\n" +
                    "- Ngày thanh toán: %s\n\n" +
                    "Nếu bạn có bất kỳ câu hỏi nào, vui lòng liên hệ với chúng tôi qua email %s hoặc số điện thoại 0123-456-789.\n\n" +
                    "Trân trọng,\nGreen Future",
                    booking.getCustomerId().getFullName(),
                    bookingId,
                    bookingId,
                    vnp_TxnRef,
                    booking.getCarId().getVehicleModelId().getModel(),
                    new java.math.BigDecimal(vnp_Amount).divide(new java.math.BigDecimal(100)).toString(),
                    new SimpleDateFormat("dd/MM/yyyy HH:mm:ss").format(new Date()),
                    "support@greenfuture.com"
                );
                MailUtils.sendEmail(booking.getCustomerId().getEmail(), subject, messageContent);
                System.out.println("Email sent successfully to: " + booking.getCustomerId().getEmail());
                response.getWriter().write(gson.toJson(new SuccessResponse("Gửi email xác nhận thanh toán thành công")));
            } catch (MessagingException e) {
                System.out.println("Failed to send email: " + e.getMessage());
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().write(gson.toJson(new ErrorResponse("Lỗi khi gửi email xác nhận: " + e.getMessage())));
            }
        } catch (Exception e) {
            System.out.println("Error processing email request: " + e.getMessage());
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write(gson.toJson(new ErrorResponse("Lỗi xử lý yêu cầu gửi email: " + e.getMessage())));
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
        public SuccessResponse(String message) {
            this.message = message;
        }
        public String getMessage() {
            return message;
        }
    }
}