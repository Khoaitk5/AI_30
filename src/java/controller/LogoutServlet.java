package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "LogoutServlet", urlPatterns = {"/logout"})
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Xoá session và redirect về trang chủ
        request.getSession().invalidate();
        String redirectUrl = request.getParameter("redirectUrl");
        if (redirectUrl != null && !redirectUrl.isEmpty()) {
            // Nếu là admin thì vẫn về home
            Object userObj = request.getSession(false) != null ? request.getSession(false).getAttribute("user") : null;
            boolean isAdmin = false;
            if (userObj != null && userObj instanceof model.Users) {
                String role = ((model.Users) userObj).getRole();
                isAdmin = role != null && (role.equalsIgnoreCase("Admin") || role.equalsIgnoreCase("Staff"));
            }
            if (!isAdmin) {
                response.sendRedirect(redirectUrl);
                return;
            }
        }
        response.sendRedirect(request.getContextPath() + "/");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
