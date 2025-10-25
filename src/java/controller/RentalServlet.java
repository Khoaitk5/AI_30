package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import java.io.IOException;
import java.math.BigDecimal;

@WebServlet(name = "RentalServlet", urlPatterns = {"/rental"})
public class RentalServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("tvtfuturePU");
        EntityManager em = emf.createEntityManager();
        try {
            // Lấy thông tin ngày/giờ nhận và trả từ request (nếu có)
            String pickupDateStr = request.getParameter("pickupDate");
            String pickupTimeStr = request.getParameter("pickupTime");
            String returnDateStr = request.getParameter("returnDate");
            String returnTimeStr = request.getParameter("returnTime");
            java.util.Date pickupDateTime = null;
            java.util.Date returnDateTime = null;
            if (pickupDateStr != null && pickupTimeStr != null && returnDateStr != null && returnTimeStr != null) {
                try {
                    String pickupDateTimeStr = pickupDateStr + " " + pickupTimeStr;
                    String returnDateTimeStr = returnDateStr + " " + returnTimeStr;
                    java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");
                    pickupDateTime = sdf.parse(pickupDateTimeStr);
                    returnDateTime = sdf.parse(returnDateTimeStr);
                } catch (Exception e) {
                    pickupDateTime = null;
                    returnDateTime = null;
                }
            }

            // Giá thuê ngày/tháng
            request.setAttribute("priceVF3", getPrice(em, "VinFast VF 3", false));
            request.setAttribute("priceVF6S", getPrice(em, "VinFast VF 6S", false));
            request.setAttribute("priceVF6Plus", getPrice(em, "VinFast VF 6 Plus", false));
            request.setAttribute("priceVF7S", getPrice(em, "VinFast VF 7S", false));
            request.setAttribute("priceVF7Plus", getPrice(em, "VinFast VF 7 Plus", false));
            request.setAttribute("priceVF8Eco", getPrice(em, "VinFast VF 8 Eco", false));
            request.setAttribute("priceVF8Plus", getPrice(em, "VinFast VF 8 Plus", false));
            request.setAttribute("priceVF9Eco", getPrice(em, "VinFast VF 9 Eco", false));
            request.setAttribute("priceVF9Plus", getPrice(em, "VinFast VF 9 Plus", false));
            request.setAttribute("priceVF3Month", getPrice(em, "VinFast VF 3", true));
            request.setAttribute("priceVF6SMonth", getPrice(em, "VinFast VF 6S", true));
            request.setAttribute("priceVF6PlusMonth", getPrice(em, "VinFast VF 6 Plus", true));
            request.setAttribute("priceVF7SMonth", getPrice(em, "VinFast VF 7S", true));
            request.setAttribute("priceVF7PlusMonth", getPrice(em, "VinFast VF 7 Plus", true));
            request.setAttribute("priceVF8EcoMonth", getPrice(em, "VinFast VF 8 Eco", true));
            request.setAttribute("priceVF8PlusMonth", getPrice(em, "VinFast VF 8 Plus", true));
            request.setAttribute("priceVF9EcoMonth", getPrice(em, "VinFast VF 9 Eco", true));
            request.setAttribute("priceVF9PlusMonth", getPrice(em, "VinFast VF 9 Plus", true));

            // Số lượng xe khả dụng cho từng mẫu xe (status = 'available' và không bị trùng lịch đặt)
            request.setAttribute("availableVF3", getAvailableCarCountInTime(em, "VinFast VF 3", pickupDateTime, returnDateTime));
            request.setAttribute("availableVF6S", getAvailableCarCountInTime(em, "VinFast VF 6S", pickupDateTime, returnDateTime));
            request.setAttribute("availableVF6Plus", getAvailableCarCountInTime(em, "VinFast VF 6 Plus", pickupDateTime, returnDateTime));
            request.setAttribute("availableVF7S", getAvailableCarCountInTime(em, "VinFast VF 7S", pickupDateTime, returnDateTime));
            request.setAttribute("availableVF7Plus", getAvailableCarCountInTime(em, "VinFast VF 7 Plus", pickupDateTime, returnDateTime));
            request.setAttribute("availableVF8Eco", getAvailableCarCountInTime(em, "VinFast VF 8 Eco", pickupDateTime, returnDateTime));
            request.setAttribute("availableVF8Plus", getAvailableCarCountInTime(em, "VinFast VF 8 Plus", pickupDateTime, returnDateTime));
            request.setAttribute("availableVF9Eco", getAvailableCarCountInTime(em, "VinFast VF 9 Eco", pickupDateTime, returnDateTime));
            request.setAttribute("availableVF9Plus", getAvailableCarCountInTime(em, "VinFast VF 9 Plus", pickupDateTime, returnDateTime));
        } finally {
            em.close();
            emf.close();
        }
        request.getRequestDispatcher("/rental/rental.jsp").forward(request, response);
    }

    private BigDecimal getPrice(EntityManager em, String modelName, boolean isMonth) {
        try {
            String field = isMonth ? "rentalPricePerMonth" : "rentalPricePerDay";
            return (BigDecimal) em.createQuery("SELECT m." + field + " FROM Models m WHERE m.model = :model")
                    .setParameter("model", modelName)
                    .getSingleResult();
        } catch (Exception e) {
            return null;
        }
    }

    // Đếm số lượng xe khả dụng cho từng mẫu xe trong khoảng thời gian (không bị trùng lịch đặt)
    private Long getAvailableCarCountInTime(EntityManager em, String modelName, java.util.Date pickup, java.util.Date dropoff) {
    try {
        // Nếu chưa chọn thời gian, trả về số xe không có trạng thái maintenance
        if (pickup == null || dropoff == null) {
            return (Long) em.createQuery(
                "SELECT COUNT(c) FROM Cars c WHERE c.vehicleModelId.model = :model AND c.status != 'maintenance'")
                .setParameter("model", modelName)
                .getSingleResult();
        }
        // Đếm số xe khả dụng không bị trùng lịch đặt và không ở trạng thái maintenance
        return (Long) em.createQuery(
            "SELECT COUNT(c) FROM Cars c WHERE c.vehicleModelId.model = :model AND c.status != 'maintenance' AND c.id NOT IN (" +
            "SELECT b.carId.id FROM Bookings b WHERE (b.status IS NULL OR b.status <> 'cancelled') AND (" +
            "(:pickup < b.endDate AND :dropoff > b.startDate)" +
            ") )")
            .setParameter("model", modelName)
            .setParameter("pickup", pickup)
            .setParameter("dropoff", dropoff)
            .getSingleResult();
    } catch (Exception e) {
        return 0L;
    }
}
}
