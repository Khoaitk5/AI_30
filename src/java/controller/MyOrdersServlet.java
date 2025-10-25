package controller;

import dao.BookingsJpaController;
import dao.CarJpaController;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Bookings;
import model.Customers;

import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import java.io.IOException;
import java.util.Date;
import java.util.List;
import org.json.JSONObject;

@WebServlet(name = "MyOrdersServlet", urlPatterns = {"/my-orders", "/my-orders/cancel"})
public class MyOrdersServlet extends HttpServlet {
    private EntityManagerFactory emf;

    @Override
    public void init() throws ServletException {
        emf = Persistence.createEntityManagerFactory("tvtfuturePU");
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getServletPath();

        switch (action) {
            case "/my-orders":
                listOrders(request, response);
                break;
            case "/my-orders/cancel":
                cancelBooking(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Hành động không tồn tại");
                break;
        }
    }

    private void listOrders(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy thông tin khách hàng từ session
        Customers currentCustomer = (Customers) request.getSession().getAttribute("currentCustomer");
        
        if (currentCustomer == null) {
            // Nếu chưa đăng nhập, chuyển hướng đến trang đăng nhập
            request.setAttribute("showLoginModal", true);
            request.getRequestDispatcher("/home/home.jsp").forward(request, response);
            return;
        }

        // Lấy danh sách booking của khách hàng
        BookingsJpaController bookingsController = new BookingsJpaController(emf);
        List<Bookings> bookings = bookingsController.findBookingsEntities().stream()
                .filter(booking -> booking.getCustomerId().getId().equals(currentCustomer.getId()))
                .toList();

        // Đặt danh sách booking vào request attribute
        request.setAttribute("bookings", bookings);
        
        // Chuyển hướng đến trang my-orders.jsp
        request.getRequestDispatcher("/account/my-oders/my-orders.jsp").forward(request, response);
    }

    private void cancelBooking(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        JSONObject jsonResponse = new JSONObject();

        String id = request.getParameter("id");
        BookingsJpaController bookingsController = new BookingsJpaController(emf);
        CarJpaController carController = new CarJpaController(emf);
        Bookings booking = bookingsController.findBookings(id);

        if (booking == null) {
            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Đặt xe không tồn tại");
            response.getWriter().write(jsonResponse.toString());
            return;
        }

        // Kiểm tra quyền: Chỉ khách hàng sở hữu booking mới được hủy
        Customers currentCustomer = (Customers) request.getSession().getAttribute("currentCustomer");
        if (currentCustomer == null || !booking.getCustomerId().getId().equals(currentCustomer.getId())) {
            response.setStatus(HttpServletResponse.SC_FORBIDDEN);
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Bạn không có quyền hủy đơn hàng này");
            response.getWriter().write(jsonResponse.toString());
            return;
        }

        // Chỉ cho phép hủy nếu trạng thái là PENDING
        if (!"PENDING".equals(booking.getStatus())) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Chỉ có thể hủy đơn hàng ở trạng thái Chờ xử lý");
            response.getWriter().write(jsonResponse.toString());
            return;
        }

        try {
            // Cập nhật trạng thái booking
            booking.setStatus("CANCELLED");
            booking.setStartDate(null);
            booking.setEndDate(null);
            booking.setTotalDays(null);
            booking.setTotalAmount(null);
            booking.setUpdatedAt(new Date());
            bookingsController.edit(booking);

            // Cập nhật trạng thái xe thành available
            String carId = booking.getCarId().getId();
            carController.updateStatusToAvailable(carId);

            jsonResponse.put("success", true);
            jsonResponse.put("message", "Hủy đơn hàng thành công và xe đã được đặt lại trạng thái sẵn sàng");
            response.getWriter().write(jsonResponse.toString());
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Lỗi khi hủy đơn hàng hoặc cập nhật trạng thái xe: " + e.getMessage());
            response.getWriter().write(jsonResponse.toString());
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
    public void destroy() {
        if (emf != null) {
            emf.close();
        }
    }
}