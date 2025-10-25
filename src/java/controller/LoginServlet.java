package controller;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import model.Users;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.security.MessageDigest;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String action = request.getParameter("action");

        if ("google-login".equals(action)) {
            response.sendRedirect(request.getContextPath() + "/GoogleAuthController?action=google-login");
            return;
        }

        try (PrintWriter out = response.getWriter()) {
            out.println("");
            out.println("");
            out.println("");
            out.println("");
            out.println("");
            out.println("");
            out.println("Servlet LoginServlet at " + request.getContextPath() + "");
            out.println("");
            out.println("");
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
        String loginField = request.getParameter("loginIdentifier"); // username, email hoặc sdt
        String password = request.getParameter("password");
        System.out.println("[DEBUG] loginIdentifier: " + loginField);
        System.out.println("[DEBUG] password: " + password);
        String hashedPassword = hashPassword(password);

        try (EntityManagerFactory emf = Persistence.createEntityManagerFactory("tvtfuturePU");
             EntityManager em = emf.createEntityManager()) {
            response.setContentType("application/json;charset=UTF-8");
            PrintWriter out = response.getWriter();

            Users user = null;

            // Truy vấn admin/staff: chỉ so sánh username, không join customerId
            user = em.createQuery(
                "SELECT u FROM Users u WHERE u.username = :loginField AND u.password = :password AND (u.role = 'Admin' OR u.role = 'Staff')",
                Users.class)
                .setParameter("loginField", loginField)
                .setParameter("password", hashedPassword)
                .getResultStream().findFirst().orElse(null);
            System.out.println("[DEBUG] Admin query result: " + (user != null ? user.getId() : "null"));

            // Nếu không phải admin/staff, kiểm tra customer (chỉ email/sdt)
            if (user == null) {
                user = em.createQuery(
                    "SELECT u FROM Users u WHERE (u.customerId.email = :loginField OR u.customerId.phone = :loginField) AND u.password = :password AND u.role = 'Customer'",
                    Users.class)
                    .setParameter("loginField", loginField)
                    .setParameter("password", hashedPassword)
                    .getResultStream().findFirst().orElse(null);
                System.out.println("[DEBUG] Customer query result: " + (user != null ? user.getId() : "null"));
                // Nếu customer nhập username thì báo lỗi
                if (user != null && user.getUsername() != null && user.getUsername().equals(loginField)) {
                    out.print("{\"errorMessage\": \"Khách hàng chỉ được đăng nhập bằng email hoặc số điện thoại!\", \"errorField\": \"loginIdentifier\"}");
                    return;
                }
            }

            if (user != null) {
                String role = user.getRole();
                boolean isAdmin = role != null && (role.equalsIgnoreCase("Admin") || role.equalsIgnoreCase("Staff"));
                request.getSession().setAttribute("user", user);
                if (!isAdmin && user.getCustomerId() != null) {
                    // Nếu là customer, set thêm currentUser và currentCustomer cho header
                    request.getSession().setAttribute("currentUser", user);
                    request.getSession().setAttribute("currentCustomer", user.getCustomerId());
                } else {
                    // Admin/staff chỉ set currentUser
                    request.getSession().setAttribute("currentUser", user);
                    request.getSession().removeAttribute("currentCustomer");
                }
                String redirectUrl = request.getParameter("redirectUrl");
                if (isAdmin) {
                    redirectUrl = request.getContextPath() + "/dashboard"; // Chuyển hướng đến DashboardServlet
                } else if (redirectUrl == null || redirectUrl.isEmpty()) {
                    redirectUrl = request.getContextPath() + "/"; // Trang mặc định cho Customer
                }
                out.print("{\"redirectUrl\": \"" + redirectUrl + "\"}");
                return;
            } else {
                out.print("{\"errorMessage\": \"Sai thông tin đăng nhập!\", \"errorField\": \"loginIdentifier\"}");
            }
        } catch (Exception ex) {
            response.setContentType("application/json;charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.print("{\"errorMessage\": \"Đã xảy ra lỗi hệ thống.\"}");
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

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
}