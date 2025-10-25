/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import dao.CustomersJpaController;
import dao.UsersJpaController;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Date;
import model.Customers;
import model.Users;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author Admin
 */
@WebServlet(name = "RegisterServlet", urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String method = request.getMethod();
        if (method.equalsIgnoreCase("GET")) {
            // Xử lý check realtime email/phone
            String type = request.getParameter("type");
            String value = request.getParameter("value");
            if (type != null && value != null) {
                EntityManagerFactory emf = (EntityManagerFactory) getServletContext().getAttribute("emf");
                if (emf == null) {
                    emf = Persistence.createEntityManagerFactory("tvtfuturePU");
                    getServletContext().setAttribute("emf", emf);
                }
                CustomersJpaController customerDao = new CustomersJpaController(emf);
                boolean exists = false;
                if (type.equals("email")) {
                    exists = customerDao.findByEmail(value) != null;
                } else if (type.equals("phone")) {
                    exists = customerDao.findByPhone(value) != null;
                }
                response.setContentType("application/json;charset=UTF-8");
                response.getWriter().write("{\"exists\":" + exists + "}");
                return;
            }
            // Nếu không phải check realtime thì show modal register
            request.getRequestDispatcher("/register/register.jsp").forward(request, response);
            return;
        }

        // Xử lý POST (đăng ký)
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String terms = request.getParameter("terms");

        // Để giữ lại giá trị nhập khi có lỗi
        request.setAttribute("registerFullName", fullName);
        request.setAttribute("registerEmail", email);
        request.setAttribute("registerPhone", phone);

        // Validate phía server
        String error = null;
        if (fullName == null || fullName.trim().isEmpty()) {
            error = "Tên không được để trống.";
        } else if (fullName.trim().length() < 2) {
            error = "Tên phải có ít nhất 2 ký tự.";
        } else if (email == null || email.trim().isEmpty()) {
            error = "Email không được để trống.";
        } else if (!email.matches("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$")) {
            error = "Email không đúng định dạng.";
        } else if (phone == null || phone.trim().isEmpty()) {
            error = "Số điện thoại không được để trống.";
        } else if (!phone.matches("^\\d{10,11}$")) {
            error = "Số điện thoại phải có 10-11 chữ số.";
        } else if (password == null || password.isEmpty()) {
            error = "Mật khẩu không được để trống.";
        } else if (password.length() < 6) {
            error = "Mật khẩu phải có ít nhất 6 ký tự.";
        } else if (confirmPassword == null || !password.equals(confirmPassword)) {
            error = "Mật khẩu nhập lại không khớp.";
        } else if (terms == null) {
            error = "Bạn phải đồng ý với điều khoản để tiếp tục.";
        }

        if (error != null) {
            request.setAttribute("registerError", error);
            request.getRequestDispatcher("/register/register.jsp").forward(request, response);
            return;
        }

        // Kiểm tra trùng email/phone
        EntityManagerFactory emf = (EntityManagerFactory) getServletContext().getAttribute("emf");
        if (emf == null) {
            emf = Persistence.createEntityManagerFactory("tvtfuturePU");
            getServletContext().setAttribute("emf", emf);
        }
        CustomersJpaController customerDao = new CustomersJpaController(emf);
        UsersJpaController userDao = new UsersJpaController(emf);

        Customers existedByEmail = customerDao.findByEmail(email);
        if (existedByEmail != null) {
            request.setAttribute("registerError", "Email đã được sử dụng.");
            request.getRequestDispatcher("/register/register.jsp").forward(request, response);
            return;
        }
        Customers existedByPhone = customerDao.findByPhone(phone);
        if (existedByPhone != null) {
            request.setAttribute("registerError", "Số điện thoại đã được sử dụng.");
            request.getRequestDispatcher("/register/register.jsp").forward(request, response);
            return;
        }

        // Sinh id Customer dạng CUS00001
        int customerCount = customerDao.getCustomersCount() + 1;
        String customerId = String.format("cust%02d", customerCount);
        Date now = new Date();
        Customers customer = new Customers();
        customer.setId(customerId);
        customer.setFullName(fullName.trim());
        customer.setEmail(email.trim());
        customer.setPhone(phone.trim());
        customer.setCreatedAt(now);
        customer.setUpdatedAt(now);
        customer.setStatus("active");

        try {
            customerDao.create(customer);
        } catch (Exception ex) {
            request.setAttribute("registerError", "Đã xảy ra lỗi khi tạo tài khoản khách hàng. Vui lòng thử lại.");
            request.getRequestDispatcher("/register/register.jsp").forward(request, response);
            return;
        }

        // Sinh id User dạng USR00001
        int userCount = userDao.getUsersCount() + 1;
        String userId = String.format("usr%02d", userCount);
        Users user = new Users();
        user.setId(userId);
        user.setUsername(null); // Customer không có username, chỉ đăng nhập bằng email/sdt
        user.setPassword(hashPassword(password));
        user.setRole("customer");
        user.setCreatedAt(now);
        user.setUpdatedAt(now);
        user.setCustomerId(customer);

        try {
            userDao.create(user);
        } catch (Exception ex) {
            // Nếu lỗi, rollback customer vừa tạo
            try { customerDao.destroy(customerId); } catch (Exception ignore) {}
            request.setAttribute("registerError", "Đã xảy ra lỗi khi tạo tài khoản người dùng. Vui lòng thử lại.");
            request.getRequestDispatcher("/register/register.jsp").forward(request, response);
            return;
        }

        // Thành công: đặt thông báo và yêu cầu mở modal login, vẫn ở register.jsp
        request.setAttribute("registerSuccess", "Đăng ký thành công, vui lòng đăng nhập!");
        request.setAttribute("showLoginModal", true);
        request.getRequestDispatcher("/register/register.jsp").forward(request, response);
    }

    // Hàm hash password đơn giản SHA-256
    private String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hash = md.digest(password.getBytes());
            StringBuilder sb = new StringBuilder();
            for (byte b : hash) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            return password;
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}