package controller;

import dao.CustomersJpaController;
import model.Customers;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import com.google.gson.Gson;

@WebServlet(name = "UpdateAccountServlet", urlPatterns = {"/update-account"})
public class UpdateAccountServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        try {
            // Lấy thông tin từ session
            Customers currentCustomer = (Customers) request.getSession().getAttribute("currentCustomer");
            if (currentCustomer == null) {
                response.getWriter().print("{\"errorMessage\": \"Vui lòng đăng nhập để cập nhật thông tin!\"}");
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                return;
            }

            // Lấy dữ liệu từ form
            String fullName = request.getParameter("fullName");
            String dateOfBirthStr = request.getParameter("dateOfBirth");
            String phone = request.getParameter("phone");
            String email = request.getParameter("email");

            // Kiểm tra dữ liệu đầu vào
            if (fullName == null || fullName.trim().isEmpty() || email == null || email.trim().isEmpty()) {
                response.getWriter().print("{\"errorMessage\": \"Họ tên và email không được để trống!\"}");
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                return;
            }

            // Chuyển đổi ngày sinh
            Date dateOfBirth = null;
            if (dateOfBirthStr != null && !dateOfBirthStr.isEmpty()) {
                try {
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    dateOfBirth = sdf.parse(dateOfBirthStr);
                } catch (Exception e) {
                    response.getWriter().print("{\"errorMessage\": \"Định dạng ngày sinh không hợp lệ!\"}");
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    return;
                }
            }

            // Lấy EntityManagerFactory từ context
            EntityManagerFactory emf = (EntityManagerFactory) getServletContext().getAttribute("emf");
            if (emf == null) {
                emf = Persistence.createEntityManagerFactory("tvtfuturePU");
                getServletContext().setAttribute("emf", emf);
            }

            // Cập nhật thông tin khách hàng
            CustomersJpaController customerDao = new CustomersJpaController(emf);
            currentCustomer.setFullName(fullName);
            currentCustomer.setDateOfBirth(dateOfBirth);
            currentCustomer.setPhone(phone != null && !phone.isEmpty() ? phone : "");
            currentCustomer.setEmail(email);
            currentCustomer.setUpdatedAt(new Date());

            try {
                customerDao.edit(currentCustomer);
                // Cập nhật session
                request.getSession().setAttribute("currentCustomer", currentCustomer);
                // Chuẩn bị dữ liệu trả về
                Gson gson = new Gson();
                String customerJson = gson.toJson(new CustomerResponse(
                    currentCustomer.getFullName(),
                    currentCustomer.getDateOfBirth() != null ? new SimpleDateFormat("yyyy-MM-dd").format(currentCustomer.getDateOfBirth()) : "",
                    currentCustomer.getPhone(),
                    currentCustomer.getEmail()
                ));
                response.getWriter().print("{\"message\": \"Cập nhật thông tin thành công!\", \"customer\": " + customerJson + "}");
            } catch (Exception ex) {
                Logger.getLogger(UpdateAccountServlet.class.getName()).log(Level.SEVERE, "Failed to update customer", ex);
                response.getWriter().print("{\"errorMessage\": \"Cập nhật thông tin thất bại. Vui lòng thử lại!\"}");
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            }
        } catch (Exception ex) {
            Logger.getLogger(UpdateAccountServlet.class.getName()).log(Level.SEVERE, "Unexpected error", ex);
            response.getWriter().print("{\"errorMessage\": \"Lỗi hệ thống. Vui lòng thử lại!\"}");
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    // Lớp hỗ trợ để trả về dữ liệu khách hàng
    private static class CustomerResponse {
        private String fullName;
        private String dateOfBirth;
        private String phone;
        private String email;

        public CustomerResponse(String fullName, String dateOfBirth, String phone, String email) {
            this.fullName = fullName;
            this.dateOfBirth = dateOfBirth;
            this.phone = phone;
            this.email = email;
        }
    }
}