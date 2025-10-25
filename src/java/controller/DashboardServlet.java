package controller;

import dao.BookingsJpaController;
import dao.CarJpaController;
import dao.CustomersJpaController;
import dao.PaymentsJpaController;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.persistence.Query;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.Calendar;

@WebServlet(name = "DashboardServlet", urlPatterns = {"/dashboard"})
public class DashboardServlet extends HttpServlet {

    private final EntityManagerFactory emf = Persistence.createEntityManagerFactory("tvtfuturePU");

    @Override
    public void init() throws ServletException {
        // Không cần khởi tạo ở đây
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Khởi tạo các controller
            CustomersJpaController customersController = new CustomersJpaController(emf);
            CarJpaController carController = new CarJpaController(emf);
            BookingsJpaController bookingsController = new BookingsJpaController(emf);
            PaymentsJpaController paymentsController = new PaymentsJpaController(emf);

            EntityManager em = emf.createEntityManager();

            // Lấy tổng số khách hàng
            int totalCustomers = customersController.getCustomersCount();
            System.out.println("Total customers: " + totalCustomers);

            // Lấy tổng số xe
            int totalCars = carController.getCarsCount();
            System.out.println("Total cars: " + totalCars);

            // Lấy số lượng đặt xe hôm nay
            Calendar today = Calendar.getInstance();
            int year = today.get(Calendar.YEAR);
            int month = today.get(Calendar.MONTH) + 1;
            int day = today.get(Calendar.DAY_OF_MONTH);
            Query todayBookingsQuery = em.createNativeQuery(
                "SELECT COUNT(*) FROM Bookings WHERE YEAR(startDate) = ?1 AND MONTH(startDate) = ?2 AND DAY(startDate) = ?3"
            );
            todayBookingsQuery.setParameter(1, year);
            todayBookingsQuery.setParameter(2, month);
            todayBookingsQuery.setParameter(3, day);
            Long todayBookings = ((Number) todayBookingsQuery.getSingleResult()).longValue();

            // Lấy doanh thu tháng hiện tại
            Query monthlyRevenueQuery = em.createNativeQuery(
                "SELECT SUM(amount) FROM Payments WHERE YEAR(timestamp) = ?1 AND MONTH(timestamp) = ?2"
            );
            monthlyRevenueQuery.setParameter(1, year);
            monthlyRevenueQuery.setParameter(2, month);
            BigDecimal monthlyRevenue = (BigDecimal) monthlyRevenueQuery.getSingleResult();
            if (monthlyRevenue == null) monthlyRevenue = BigDecimal.ZERO;

            // Cảnh báo: Xe cần bảo trì trong tuần này
            Calendar weekEnd = Calendar.getInstance();
            weekEnd.add(Calendar.DAY_OF_MONTH, 7);
            Query maintenanceQuery = em.createNativeQuery(
                "SELECT COUNT(*) FROM Cars WHERE status = 'maintenance'"
            );
            Long carsNeedingMaintenance = ((Number) maintenanceQuery.getSingleResult()).longValue();

            // Cảnh báo: Hợp đồng sắp hết hạn (trong 7 ngày tới)
            Query expiringBookingsQuery = em.createNativeQuery(
                "SELECT COUNT(*) FROM Bookings WHERE endDate BETWEEN ?1 AND ?2 AND status NOT IN ('COMPLETED', 'CANCELLED')"
            );
            expiringBookingsQuery.setParameter(1, today.getTime());
            expiringBookingsQuery.setParameter(2, weekEnd.getTime());
            Long expiringBookings = ((Number) expiringBookingsQuery.getSingleResult()).longValue();

            // Cảnh báo: Thanh toán quá hạn
            Query overduePaymentsQuery = em.createNativeQuery(
                "SELECT COUNT(*) FROM Payments WHERE status = 'OVERDUE'"
            );
            Long overduePayments = ((Number) overduePaymentsQuery.getSingleResult()).longValue();

            // Thống kê nhanh: Xe đang thuê
            Query rentedCarsQuery = em.createNativeQuery(
                "SELECT COUNT(DISTINCT carId) FROM Bookings WHERE status = 'CONFIRMED' AND endDate >= ?1"
            );
            rentedCarsQuery.setParameter(1, today.getTime());
            Long rentedCars = ((Number) rentedCarsQuery.getSingleResult()).longValue();

            // Thống kê nhanh: Xe có sẵn
            Query availableCarsQuery = em.createNativeQuery(
                "SELECT COUNT(*) FROM Cars WHERE status = 'available'"
            );
            Long availableCars = ((Number) availableCarsQuery.getSingleResult()).longValue();

            // Thống kê nhanh: Xe bảo trì
            Long maintenanceCars = carsNeedingMaintenance; // Đã tính ở trên

            // Đóng EntityManager
            em.close();

            // Đặt các thuộc tính vào request
            request.setAttribute("totalCustomers", totalCustomers);
            request.setAttribute("totalCars", totalCars);
            request.setAttribute("todayBookings", todayBookings);
            request.setAttribute("monthlyRevenue", monthlyRevenue);
            request.setAttribute("carsNeedingMaintenance", carsNeedingMaintenance);
            request.setAttribute("expiringBookings", expiringBookings);
            request.setAttribute("overduePayments", overduePayments);
            request.setAttribute("rentedCars", rentedCars);
            request.setAttribute("availableCars", availableCars);
            request.setAttribute("maintenanceCars", maintenanceCars);

            // Chuyển hướng đến dashboard.jsp
            request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi khi tải dữ liệu dashboard: " + e.getMessage());
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
        return "Dashboard Servlet cho TVT Future";
    }

    @Override
    public void destroy() {
        if (emf != null) {
            emf.close();
        }
    }
}