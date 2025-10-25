package controller;

import dao.BookingsJpaController;
import dao.CarJpaController;
import dao.ModelJpaController;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Models;

import java.io.IOException;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import model.Cars;
import model.Bookings;

@WebServlet(name = "ModalServlet", urlPatterns = {"/rental/modal", "/rental/calculate"})
public class ModalServlet extends HttpServlet {

    private final EntityManagerFactory emf = Persistence.createEntityManagerFactory("tvtfuturePU");
    private ModelJpaController modelController;
    private BookingsJpaController bookingController;
    private CarJpaController carController;

    @Override
    public void init() throws ServletException {
        modelController = new ModelJpaController(emf);
        bookingController = new BookingsJpaController(emf);
        carController = new CarJpaController(emf);
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getServletPath();

        try {
            switch (action) {
                case "/rental/modal":
                    showModal(request, response);
                    break;
                case "/rental/calculate":
                    calculatePrice(request, response);
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "Action not found");
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error processing request: " + e.getMessage());
        }
    }

    private void calculatePrice(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String modelId = request.getParameter("modelId");
        String carId = request.getParameter("carId");
        String rentalType = request.getParameter("rentalType");
        String pickupDateStr = request.getParameter("pickupDate");
        String returnDateStr = request.getParameter("returnDate");
        String rentalMonthsStr = request.getParameter("rentalMonths");

        Models model = modelController.findModels(modelId);
        if (model == null) {
            response.getWriter().write("{\"error\": \"Không tìm thấy mẫu xe\"}");
            return;
        }

        Cars car = carController.findCars(carId);
        if (car == null || !car.getVehicleModelId().getId().equals(modelId)) {
            response.getWriter().write("{\"error\": \"Xe không hợp lệ\"}");
            return;
        }

        BigDecimal rentalPrice, deposit;
        int days = 1;

        if ("ngay".equals(rentalType)) {
            rentalPrice = model.getRentalPricePerDay();
            deposit = model.getDepositPerDay();
            if (pickupDateStr != null && returnDateStr != null) {
                try {
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    Date pickupDate = sdf.parse(pickupDateStr);
                    Date returnDate = sdf.parse(returnDateStr);
                    if (returnDate.before(pickupDate)) {
                        response.getWriter().write("{\"error\": \"Ngày trả xe phải sau ngày nhận xe\"}");
                        return;
                    }

                    // Kiểm tra booking trùng lặp
                    List<Bookings> conflictingBookings = bookingController.findBookingsByCarAndDateRange(carId, pickupDate, returnDate);
                    if (!conflictingBookings.isEmpty()) {
                        SimpleDateFormat sdfDisplay = new SimpleDateFormat("dd/MM/yyyy");
                        String conflictMessage = String.format(
                            "Xe đã được đặt từ %s đến %s. Vui lòng chọn khoảng thời gian khác.",
                            sdfDisplay.format(conflictingBookings.get(0).getStartDate()),
                            sdfDisplay.format(conflictingBookings.get(0).getEndDate())
                        );
                        response.getWriter().write(String.format("{\"error\": \"%s\"}", conflictMessage));
                        return;
                    }

                    long timeDiff = returnDate.getTime() - pickupDate.getTime();
                    days = Math.max(1, (int) Math.ceil(timeDiff / (1000.0 * 60 * 60 * 24)));
                } catch (Exception e) {
                    response.getWriter().write("{\"error\": \"Định dạng ngày không hợp lệ\"}");
                    return;
                }
            }
        
        } else {
            response.getWriter().write("{\"error\": \"Hình thức thuê không hợp lệ\"}");
            return;
        }

        BigDecimal totalRental = rentalPrice.multiply(new BigDecimal(days));
        BigDecimal totalPayment = totalRental.add(deposit);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(String.format(
            "{\"rentalDays\": %d, \"totalRentalPrice\": \"%s\", \"totalPayment\": \"%s\"}",
            days,
            totalRental.toString(),
            totalPayment.toString()
        ));
    }

    private void showModal(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        String modelId = request.getParameter("modelId");
        String carId = request.getParameter("carId");
        
        Models model = modelController.findModels(modelId);
        if (model != null) {
            request.setAttribute("carModel", model);
            
            // Tìm xe khả dụng
            List<Cars> availableCars = carController.findCarsByModelAndStatus(modelId, "AVAILABLE");
            if (!availableCars.isEmpty()) {
                // Nếu có carId cụ thể, dùng xe đó; nếu không thì lấy xe đầu tiên
                Cars selectedCar = null;
                if (carId != null && !carId.isEmpty()) {
                    selectedCar = carController.findCars(carId);
                }
                if (selectedCar == null) {
                    selectedCar = availableCars.get(0);
                }
                request.setAttribute("carId", selectedCar.getId());
                request.setAttribute("selectedCar", selectedCar);
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Hiện tại không có xe khả dụng cho mẫu xe này.");
                return;
            }
            
            // Forward đến modal JSP mới (từ ai_for_se)
            request.getRequestDispatcher("/rental/modal-new/modal.jsp").forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy mẫu xe");
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
        return "Modal Servlet for TVT Future";
    }

    @Override
    public void destroy() {
        if (emf != null) {
            emf.close();
        }
    }
}