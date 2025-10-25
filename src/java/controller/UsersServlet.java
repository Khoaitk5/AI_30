package controller;

import dao.UsersJpaController;
import dao.CustomersJpaController;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Users;
import model.Customers;
import java.io.IOException;
import java.util.Date;
import java.util.List;

@WebServlet(name = "UsersServlet", urlPatterns = {"/users", "/users/add", "/users/edit", "/users/delete"})
public class UsersServlet extends HttpServlet {

    private final EntityManagerFactory emf = Persistence.createEntityManagerFactory("tvtfuturePU");

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();
        UsersJpaController usersController = new UsersJpaController(emf);
        CustomersJpaController customersController = new CustomersJpaController(emf);

        try {
            if ("/users".equals(path)) {
                // Hiển thị danh sách người dùng
                List<Users> users = usersController.findUsersEntities();
                List<Customers> customers = customersController.findCustomersEntities();
                request.setAttribute("users", users);
                request.setAttribute("customers", customers);
                request.getRequestDispatcher("/users/userList.jsp").forward(request, response);

            } else if ("/users/add".equals(path)) {
                if ("GET".equalsIgnoreCase(request.getMethod())) {
                    // Hiển thị form thêm người dùng
                    List<Customers> customers = customersController.findCustomersEntities();
                    request.setAttribute("customers", customers);
                    request.getRequestDispatcher("/users/addUser.jsp").forward(request, response);
                } else if ("POST".equalsIgnoreCase(request.getMethod())) {
                    // Xử lý thêm người dùng
                    String id = request.getParameter("id");
                    String username = request.getParameter("username");
                    String password = request.getParameter("password"); // Nên mã hóa mật khẩu trong thực tế
                    String role = request.getParameter("role");
                    String customerId = request.getParameter("customerId");

                    Users user = new Users(id);
                    user.setUsername(username != null && !username.isEmpty() ? username : null);
                    user.setPassword(password); // Nên sử dụng mã hóa mật khẩu (e.g., BCrypt)
                    user.setRole(role);
                    user.setCreatedAt(new Date());
                    user.setUpdatedAt(new Date());
                    if (customerId != null && !customerId.isEmpty()) {
                        Customers customer = customersController.findCustomers(customerId);
                        user.setCustomerId(customer);
                    }

                    usersController.create(user);
                    response.sendRedirect(request.getContextPath() + "/users");
                }

            } else if ("/users/edit".equals(path)) {
                if ("GET".equalsIgnoreCase(request.getMethod())) {
                    // Hiển thị form chỉnh sửa người dùng
                    String id = request.getParameter("id");
                    Users user = usersController.findUsers(id);
                    List<Customers> customers = customersController.findCustomersEntities();
                    request.setAttribute("user", user);
                    request.setAttribute("customers", customers);
                    request.getRequestDispatcher("/users/editUser.jsp").forward(request, response);
                } else if ("POST".equalsIgnoreCase(request.getMethod())) {
                    // Xử lý chỉnh sửa người dùng
                    String id = request.getParameter("id");
                    String username = request.getParameter("username");
                    String password = request.getParameter("password");
                    String role = request.getParameter("role");
                    String customerId = request.getParameter("customerId");

                    Users user = usersController.findUsers(id);
                    if (user != null) {
                        user.setUsername(username != null && !username.isEmpty() ? username : null);
                        if (password != null && !password.isEmpty()) {
                            user.setPassword(password); // Nên sử dụng mã hóa mật khẩu
                        }
                        user.setRole(role);
                        user.setUpdatedAt(new Date());
                        if (customerId != null && !customerId.isEmpty()) {
                            Customers customer = customersController.findCustomers(customerId);
                            user.setCustomerId(customer);
                        } else {
                            user.setCustomerId(null);
                        }

                        usersController.edit(user);
                    }
                    response.sendRedirect(request.getContextPath() + "/users");
                }

            } else if ("/users/delete".equals(path)) {
                // Xử lý cập nhật trạng thái thay vì xóa người dùng
                String id = request.getParameter("id");
                Users user = usersController.findUsers(id);
                if (user != null && user.getCustomerId() != null) {
                    Customers customer = user.getCustomerId();
                    customer.setStatus("unvalid");
                    customer.setUpdatedAt(new Date());
                    customersController.edit(customer);
                }
                response.sendRedirect(request.getContextPath() + "/users");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi khi xử lý yêu cầu: " + e.getMessage());
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
        return "Users Servlet for TVT Future";
    }

    @Override
    public void destroy() {
        if (emf != null) {
            emf.close();
        }
    }
}