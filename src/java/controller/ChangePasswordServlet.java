package controller;

import dao.UsersJpaController;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Users;
import java.io.IOException;
import java.io.PrintWriter;
import java.security.MessageDigest;
import java.util.Date;

@WebServlet(name = "ChangePasswordServlet", urlPatterns = {"/change-password"})
public class ChangePasswordServlet extends HttpServlet {

    private final EntityManagerFactory emf = Persistence.createEntityManagerFactory("tvtfuturePU");

    private String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hash = md.digest(password.getBytes());
            StringBuilder sb = new StringBuilder();
            for (byte b : hash) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (Exception e) {
            return password;
        }
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            Users currentUser = (Users) request.getSession().getAttribute("currentUser");
            if (currentUser == null) {
                out.print("{\"errorMessage\": \"Bạn cần đăng nhập để thay đổi mật khẩu!\"}");
                return;
            }

            String oldPassword = request.getParameter("oldPassword");
            String newPassword = request.getParameter("newPassword");
            String confirmPassword = request.getParameter("confirmPassword");

            // Server-side validation
            if (oldPassword == null || newPassword == null || confirmPassword == null ||
                oldPassword.isEmpty() || newPassword.isEmpty() || confirmPassword.isEmpty()) {
                out.print("{\"errorMessage\": \"Vui lòng nhập đầy đủ các trường!\"}");
                return;
            }

            if (!newPassword.equals(confirmPassword)) {
                out.print("{\"errorMessage\": \"Mật khẩu mới và xác nhận mật khẩu không khớp!\"}");
                return;
            }

            // Kiểm tra mật khẩu hiện tại
            UsersJpaController usersController = new UsersJpaController(emf);
            String hashedOldPassword = hashPassword(oldPassword);
            if (!currentUser.getPassword().equals(hashedOldPassword)) {
                out.print("{\"errorMessage\": \"Mật khẩu hiện tại không đúng!\"}");
                return;
            }

            // Cập nhật mật khẩu mới
            currentUser.setPassword(hashPassword(newPassword));
            currentUser.setUpdatedAt(new Date());
            usersController.edit(currentUser);

            out.print("{\"successMessage\": \"Thay đổi mật khẩu thành công!\"}");
        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"errorMessage\": \"Đã xảy ra lỗi hệ thống. Vui lòng thử lại sau!\"}");
        } finally {
            out.close();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Change Password Servlet for TVT Future";
    }

    @Override
    public void destroy() {
        if (emf != null) {
            emf.close();
        }
    }
}