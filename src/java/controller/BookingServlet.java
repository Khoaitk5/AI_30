package controller;

import dao.BookingsJpaController;
import dao.CarJpaController;
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
import model.Customers;
import java.io.IOException;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet(name = "BookingServlet", urlPatterns = {"/bookings", "/bookings/add", "/bookings/edit", "/bookings/cancel", "/bookings/complete"})
public class BookingServlet extends HttpServlet {

    private final EntityManagerFactory emf = Persistence.createEntityManagerFactory("tvtfuturePU");
    private BookingsJpaController bookingController;
    private CarJpaController carController;
    private CustomersJpaController customerController;

    @Override
    public void init() throws ServletException {
        bookingController = new BookingsJpaController(emf);
        carController = new CarJpaController(emf);
        customerController = new CustomersJpaController(emf);
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getServletPath();

        try {
            switch (action) {
                case "/bookings":
                    listBookings(request, response);
                    break;
                case "/bookings/add":
                    if ("GET".equalsIgnoreCase(request.getMethod())) {
                        showAddForm(request, response);
                    } else {
                        addBooking(request, response);
                    }
                    break;
                case "/bookings/edit":
                    if ("GET".equalsIgnoreCase(request.getMethod())) {
                        showEditForm(request, response);
                    } else {
                        updateBooking(request, response);
                    }
                    break;
                case "/bookings/cancel":
                    cancelBooking(request, response);
                    break;
                case "/bookings/complete":
                    completeBooking(request, response);
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "Hành động không tồn tại");
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi xử lý yêu cầu đặt xe: " + e.getMessage());
        }
    }

    private void listBookings(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Bookings> bookings = bookingController.findBookingsEntities();
        request.setAttribute("bookings", bookings);
        request.getRequestDispatcher("/bookings/bookingList.jsp").forward(request, response);
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Cars> cars = carController.findCarsEntities();
        List<Customers> customers = customerController.findCustomersEntities();
        request.setAttribute("cars", cars);
        request.setAttribute("customers", customers);
        request.getRequestDispatcher("/bookings/bookingAdd.jsp").forward(request, response);
    }

    private void addBooking(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String customerId = request.getParameter("customerId");
        String carId = request.getParameter("carId");
        String startDateStr = request.getParameter("startDate");
        String endDateStr = request.getParameter("endDate");
        String pricePerDayStr = request.getParameter("pricePerDay");
        String depositStr = request.getParameter("deposit");
        String status = request.getParameter("status");
        String pickupLocation = request.getParameter("pickupLocation");
        String dropoffLocation = request.getParameter("dropoffLocation");

        // Validate endDate > startDate
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date startDate = null, endDate = null;
        try {
            if (startDateStr != null && !startDateStr.isEmpty()) {
                startDate = sdf.parse(startDateStr);
            }
            if (endDateStr != null && !endDateStr.isEmpty()) {
                endDate = sdf.parse(endDateStr);
            }
            if (startDate != null && endDate != null && !endDate.after(startDate)) {
                request.setAttribute("error", "Ngày kết thúc phải lớn hơn ngày bắt đầu");
                showAddForm(request, response);
                return;
            }
        } catch (Exception e) {
            request.setAttribute("error", "Ngày không hợp lệ");
            showAddForm(request, response);
            return;
        }

        // Generate new booking ID
        String newId = generateNewBookingId();

        Bookings booking = new Bookings(newId);
        booking.setCustomerId(new Customers(customerId));
        booking.setCarId(new Cars(carId));

        try {
            if (startDate != null && endDate != null) {
                booking.setStartDate(startDate);
                booking.setEndDate(endDate);
                long diff = endDate.getTime() - startDate.getTime();
                int totalDays = (int) (diff / (1000 * 60 * 60 * 24)) + 1;
                booking.setTotalDays(totalDays);
            }
            booking.setPricePerDay(new BigDecimal(pricePerDayStr));
            booking.setDeposit(new BigDecimal(depositStr));
            if (booking.getTotalDays() != null) {
                booking.setTotalAmount(booking.getPricePerDay().multiply(new BigDecimal(booking.getTotalDays())));
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Giá hoặc tiền cọc không hợp lệ");
            showAddForm(request, response);
            return;
        }

        booking.setStatus(status);
        booking.setPickupLocation(pickupLocation);
        booking.setDropoffLocation(dropoffLocation);
        booking.setCreatedAt(new Date());
        booking.setUpdatedAt(new Date());

        bookingController.create(booking);
        response.sendRedirect(request.getContextPath() + "/bookings");
    }

    private String generateNewBookingId() {
        List<Bookings> bookings = bookingController.findBookingsEntities();
        int maxId = 0;
        for (Bookings booking : bookings) {
            String id = booking.getId();
            if (id.startsWith("bk")) {
                try {
                    int num = Integer.parseInt(id.substring(2));
                    if (num > maxId) {
                        maxId = num;
                    }
                } catch (NumberFormatException e) {
                    // Ignore invalid IDs
                }
            }
        }
        return String.format("bk%02d", maxId + 1);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        Bookings booking = bookingController.findBookings(id);
        if (booking != null) {
            List<Cars> cars = carController.findCarsEntities();
            List<Customers> customers = customerController.findCustomersEntities();
            request.setAttribute("booking", booking);
            request.setAttribute("cars", cars);
            request.setAttribute("customers", customers);
            request.getRequestDispatcher("/bookings/bookingEdit.jsp").forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Đặt xe không tồn tại");
        }
    }

    private void updateBooking(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        String customerId = request.getParameter("customerId");
        String carId = request.getParameter("carId");
        String startDateStr = request.getParameter("startDate");
        String endDateStr = request.getParameter("endDate");
        String pricePerDayStr = request.getParameter("pricePerDay");
        String depositStr = request.getParameter("deposit");
        String status = request.getParameter("status");
        String pickupLocation = request.getParameter("pickupLocation");
        String dropoffLocation = request.getParameter("dropoffLocation");

        Bookings booking = bookingController.findBookings(id);
        if (booking != null) {
            // Validate endDate > startDate
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date startDate = null, endDate = null;
            try {
                if (startDateStr != null && !startDateStr.isEmpty()) {
                    startDate = sdf.parse(startDateStr);
                }
                if (endDateStr != null && !endDateStr.isEmpty()) {
                    endDate = sdf.parse(endDateStr);
                }
                if (startDate != null && endDate != null && !endDate.after(startDate)) {
                    request.setAttribute("error", "Ngày kết thúc phải lớn hơn ngày bắt đầu");
                    showEditForm(request, response);
                    return;
                }
            } catch (Exception e) {
                request.setAttribute("error", "Ngày không hợp lệ");
                showEditForm(request, response);
                return;
            }

            booking.setCustomerId(new Customers(customerId));
            booking.setCarId(new Cars(carId));

            try {
                if (startDate != null && endDate != null) {
                    booking.setStartDate(startDate);
                    booking.setEndDate(endDate);
                    long diff = endDate.getTime() - startDate.getTime();
                    int totalDays = (int) (diff / (1000 * 60 * 60 * 24)) + 1;
                    booking.setTotalDays(totalDays);
                }
                booking.setPricePerDay(new BigDecimal(pricePerDayStr));
                booking.setDeposit(new BigDecimal(depositStr));
                if (booking.getTotalDays() != null) {
                    booking.setTotalAmount(booking.getPricePerDay().multiply(new BigDecimal(booking.getTotalDays())));
                }
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Giá hoặc tiền cọc không hợp lệ");
                showEditForm(request, response);
                return;
            }

            booking.setStatus(status);
            booking.setPickupLocation(pickupLocation);
            booking.setDropoffLocation(dropoffLocation);
            booking.setUpdatedAt(new Date());

            try {
                bookingController.edit(booking);
            } catch (Exception e) {
                throw new ServletException("Lỗi khi cập nhật đặt xe", e);
            }
            response.sendRedirect(request.getContextPath() + "/bookings");
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Đặt xe không tồn tại");
        }
    }

    private void cancelBooking(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        Bookings booking = bookingController.findBookings(id);
        if (booking != null) {
            try {
                booking.setStatus("CANCELLED");
                booking.setStartDate(null);
                booking.setEndDate(null);
                booking.setTotalDays(null);
                booking.setTotalAmount(null);
                booking.setUpdatedAt(new Date());
                bookingController.edit(booking);
            } catch (Exception e) {
                throw new ServletException("Lỗi khi hủy đặt xe", e);
            }
            response.sendRedirect(request.getContextPath() + "/bookings");
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Đặt xe không tồn tại");
        }
    }

    private void completeBooking(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        Bookings booking = bookingController.findBookings(id);
        if (booking != null) {
            try {
                booking.setStatus("COMPLETED");
                booking.setUpdatedAt(new Date());
                bookingController.edit(booking);
            } catch (Exception e) {
                throw new ServletException("Lỗi khi hoàn tất đặt xe", e);
            }
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Đặt xe không tồn tại");
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
        return "Booking Servlet for TVT Future";
    }

    @Override
    public void destroy() {
        if (emf != null) {
            emf.close();
        }
    }
}