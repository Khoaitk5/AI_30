package controller;

import dao.BookingsJpaController;
import dao.PaymentsJpaController;
import dao.CarJpaController;
import dao.ModelJpaController;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.persistence.Query;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Cars;
import model.Models;
import java.io.IOException;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

@WebServlet(name = "ReportServlet", urlPatterns = {"/reports"})
public class ReportServlet extends HttpServlet {

    private final EntityManagerFactory emf = Persistence.createEntityManagerFactory("tvtfuturePU");

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Lấy tháng và năm từ request, mặc định là tháng hiện tại
            String monthYear = request.getParameter("monthYear");
            Calendar cal = Calendar.getInstance();
            if (monthYear != null && !monthYear.isEmpty()) {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
                cal.setTime(sdf.parse(monthYear));
            }
            int year = cal.get(Calendar.YEAR);
            int month = cal.get(Calendar.MONTH) + 1;

            // Khởi tạo các controller
            BookingsJpaController bookingsController = new BookingsJpaController(emf);
            PaymentsJpaController paymentsController = new PaymentsJpaController(emf);
            CarJpaController carController = new CarJpaController(emf);
            ModelJpaController modelController = new ModelJpaController(emf);

            // Tính tổng doanh thu của tháng
            EntityManager em = emf.createEntityManager();
            Query revenueQuery = em.createNativeQuery(
                "SELECT SUM(amount) FROM Payments WHERE YEAR(timestamp) = ?1 AND MONTH(timestamp) = ?2"
            );
            revenueQuery.setParameter(1, year);
            revenueQuery.setParameter(2, month);
            BigDecimal totalRevenue = (BigDecimal) revenueQuery.getSingleResult();
            if (totalRevenue == null) totalRevenue = BigDecimal.ZERO;
            request.setAttribute("totalRevenue", totalRevenue);

            // Lấy top 3 xe được thuê nhiều nhất
            Query topCarsQuery = em.createNativeQuery(
                "SELECT b.CarId, COUNT(b.Id) as bookingCount FROM Bookings b " +
                "WHERE YEAR(b.StartDate) = ?1 AND MONTH(b.StartDate) = ?2 " +
                "GROUP BY b.CarId ORDER BY bookingCount DESC"
            );
            topCarsQuery.setParameter(1, year);
            topCarsQuery.setParameter(2, month);
            topCarsQuery.setMaxResults(3);
            List<Object[]> topCarsResult = topCarsQuery.getResultList();
            List<Map<String, Object>> topCars = new ArrayList<>();
            for (Object[] result : topCarsResult) {
                String carId = (String) result[0];
                Long count = ((Number) result[1]).longValue();
                Cars car = carController.findCars(carId);
                Models model = car.getVehicleModelId();
                Map<String, Object> carInfo = new TreeMap<>();
                carInfo.put("carId", carId);
                carInfo.put("modelName", model != null ? model.getModel() : "Unknown");
                carInfo.put("licensePlate", car.getLicensePlate());
                carInfo.put("bookingCount", count);
                topCars.add(carInfo);
            }
            request.setAttribute("topCars", topCars);

            // Lấy dữ liệu doanh thu theo ngày trong tháng
            int daysInMonth = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
            List<BigDecimal> dailyRevenue = new ArrayList<>();
            List<String> labels = new ArrayList<>();
            SimpleDateFormat dayFormat = new SimpleDateFormat("dd/MM");
            for (int day = 1; day <= daysInMonth; day++) {
                Query dailyRevenueQuery = em.createNativeQuery(
                    "SELECT SUM(amount) FROM Payments WHERE YEAR(timestamp) = ?1 AND MONTH(timestamp) = ?2 AND DAY(timestamp) = ?3"
                );
                dailyRevenueQuery.setParameter(1, year);
                dailyRevenueQuery.setParameter(2, month);
                dailyRevenueQuery.setParameter(3, day);
                BigDecimal dayRevenue = (BigDecimal) dailyRevenueQuery.getSingleResult();
                dailyRevenue.add(dayRevenue != null ? dayRevenue : BigDecimal.ZERO);
                cal.set(Calendar.DAY_OF_MONTH, day);
                labels.add(dayFormat.format(cal.getTime()));
            }
            request.setAttribute("dailyRevenue", dailyRevenue);
            request.setAttribute("labels", labels);
            request.setAttribute("monthYear", String.format("%d-%02d", year, month));

            // Đóng EntityManager
            em.close();

            // Chuyển hướng đến report.jsp
            request.getRequestDispatcher("/reports/report.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi khi tạo báo cáo: " + e.getMessage());
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
        return "Report Servlet cho TVT Future";
    }

    @Override
    public void destroy() {
        if (emf != null) {
            emf.close();
        }
    }
}