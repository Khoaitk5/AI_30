package controller;

import dao.PaymentsJpaController;
import dao.BookingsJpaController;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Payments;
import model.Bookings;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.logging.Logger;

@WebServlet(name = "PaymentListServlet", urlPatterns = {"/payments", "/payments/add", "/payments/edit", "/payments/delete"})
public class PaymentListServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(PaymentListServlet.class.getName());
    private final EntityManagerFactory emf = Persistence.createEntityManagerFactory("tvtfuturePU");
    private PaymentsJpaController paymentController;
    private BookingsJpaController bookingController;

    @Override
    public void init() throws ServletException {
        paymentController = new PaymentsJpaController(emf);
        bookingController = new BookingsJpaController(emf);
        LOGGER.info("PaymentListServlet initialized successfully.");
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getServletPath();
        LOGGER.info("Handling request with action: " + action + ", Method: " + request.getMethod());

        try {
            switch (action) {
                case "/payments":
                    listPayments(request, response);
                    break;
                case "/payments/add":
                    if ("GET".equalsIgnoreCase(request.getMethod())) {
                        showAddForm(request, response);
                    } else {
                        addPayment(request, response);
                    }
                    break;
                case "/payments/edit":
                    if ("GET".equalsIgnoreCase(request.getMethod())) {
                        showEditForm(request, response);
                    } else {
                        updatePayment(request, response);
                    }
                    break;
                case "/payments/delete":
                    deletePayment(request, response);
                    break;
                default:
                    LOGGER.warning("Invalid action: " + action);
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "Hành động không tồn tại");
                    break;
            }
        } catch (Exception e) {
            LOGGER.severe("Error processing request: " + e.getMessage());
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi xử lý yêu cầu thanh toán: " + e.getMessage());
        }
    }

    private void listPayments(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Payments> paymentList = paymentController.findPaymentsEntities();
        request.setAttribute("paymentList", paymentList);
        LOGGER.info("Fetched " + paymentList.size() + " payments.");
        request.getRequestDispatcher("/payments/paymentList.jsp").forward(request, response);
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Bookings> bookingList = bookingController.findBookingsEntities();
        request.setAttribute("bookingList", bookingList);
        request.getRequestDispatcher("/payments/paymentAdd.jsp").forward(request, response);
    }

    private void addPayment(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String bookingId = request.getParameter("bookingId");
        String amountStr = request.getParameter("amount");
        String depositStr = request.getParameter("deposit");
        String otherCostsStr = request.getParameter("otherCosts");
        String status = request.getParameter("status");
        String paymentMethod = request.getParameter("paymentMethod");
        String latePaymentPenaltyStr = request.getParameter("latePaymentPenalty");

        Bookings booking = bookingController.findBookings(bookingId);
        if (booking == null) {
            request.setAttribute("error", "Booking không tồn tại");
            showAddForm(request, response);
            return;
        }

        String newId = generateNewPaymentId();
        Payments payment = new Payments(newId);
        payment.setBookingId(booking);

        try {
            payment.setAmount(new BigDecimal(amountStr));
            payment.setDeposit(new BigDecimal(depositStr));
            payment.setOtherCosts(new BigDecimal(otherCostsStr));
            payment.setLatePaymentPenalty(new BigDecimal(latePaymentPenaltyStr));
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Dữ liệu số không hợp lệ");
            showAddForm(request, response);
            return;
        }

        payment.setStatus(status);
        payment.setPaymentMethod(paymentMethod);
        payment.setTransactionId(String.valueOf(System.currentTimeMillis()));
        payment.setTimestamp(new Date());

        try {
            paymentController.create(payment);
            LOGGER.info("Created payment with ID: " + newId);
        } catch (Exception e) {
            LOGGER.severe("Error creating payment: " + e.getMessage());
            request.setAttribute("error", "Lỗi khi thêm thanh toán: " + e.getMessage());
            showAddForm(request, response);
            return;
        }
        response.sendRedirect(request.getContextPath() + "/payments");
    }

    private String generateNewPaymentId() {
        return String.format("pay%02d", paymentController.getPaymentsCount() + 1);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        Payments payment = paymentController.findPayments(id);
        if (payment != null) {
            List<Bookings> bookingList = bookingController.findBookingsEntities();
            request.setAttribute("payment", payment);
            request.setAttribute("bookingList", bookingList);
            request.getRequestDispatcher("/payments/paymentEdit.jsp").forward(request, response);
        } else {
            LOGGER.warning("Payment not found for ID: " + id);
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Thanh toán không tồn tại");
        }
    }

    private void updatePayment(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        Payments payment = paymentController.findPayments(id);
        if (payment != null) {
            String bookingId = request.getParameter("bookingId");
            String amountStr = request.getParameter("amount");
            String depositStr = request.getParameter("deposit");
            String otherCostsStr = request.getParameter("otherCosts");
            String status = request.getParameter("status");
            String paymentMethod = request.getParameter("paymentMethod");
            String latePaymentPenaltyStr = request.getParameter("latePaymentPenalty");

            Bookings booking = bookingController.findBookings(bookingId);
            if (booking == null) {
                request.setAttribute("error", "Booking không tồn tại");
                showEditForm(request, response);
                return;
            }

            payment.setBookingId(booking);
            try {
                payment.setAmount(new BigDecimal(amountStr));
                payment.setDeposit(new BigDecimal(depositStr));
                payment.setOtherCosts(new BigDecimal(otherCostsStr));
                payment.setLatePaymentPenalty(new BigDecimal(latePaymentPenaltyStr));
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Dữ liệu số không hợp lệ");
                showEditForm(request, response);
                return;
            }

            payment.setStatus(status);
            payment.setPaymentMethod(paymentMethod);

            try {
                paymentController.edit(payment);
                LOGGER.info("Updated payment with ID: " + id);
            } catch (Exception e) {
                LOGGER.severe("Error updating payment: " + e.getMessage());
                request.setAttribute("error", "Lỗi khi cập nhật thanh toán: " + e.getMessage());
                showEditForm(request, response);
                return;
            }
            response.sendRedirect(request.getContextPath() + "/payments");
        } else {
            LOGGER.warning("Payment not found for ID: " + id);
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Thanh toán không tồn tại");
        }
    }

    private void deletePayment(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        Payments payment = paymentController.findPayments(id);
        if (payment != null) {
            try {
                paymentController.destroy(id);
                LOGGER.info("Deleted payment with ID: " + id);
            } catch (Exception e) {
                LOGGER.severe("Error deleting payment: " + e.getMessage());
                throw new ServletException("Lỗi khi xóa thanh toán: " + e.getMessage());
            }
            response.sendRedirect(request.getContextPath() + "/payments");
        } else {
            LOGGER.warning("Payment not found for ID: " + id);
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Thanh toán không tồn tại");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Payment List Servlet for TVT Future";
    }

    @Override
    public void destroy() {
        if (emf != null) {
            emf.close();
            LOGGER.info("EntityManagerFactory closed.");
        }
    }
}