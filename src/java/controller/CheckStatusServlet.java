package controller;

import dao.CarJpaController;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Cars;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "CheckStatusServlet", urlPatterns = {"/rental/checkStatus"})
public class CheckStatusServlet extends HttpServlet {

    private final EntityManagerFactory emf = Persistence.createEntityManagerFactory("tvtfuturePU");
    private CarJpaController carController;

    @Override
    public void init() throws ServletException {
        carController = new CarJpaController(emf);
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String modelId = request.getParameter("modelId");
        if (modelId == null || modelId.isEmpty()) {
            response.getWriter().write("{\"error\": \"Thiếu tham số modelId\"}");
            return;
        }

        // Kiểm tra xe khả dụng
        List<Cars> availableCars = carController.findCarsByModelAndStatus(modelId, "AVAILABLE");
        if (!availableCars.isEmpty()) {
            response.getWriter().write("{\"status\": \"AVAILABLE\"}");
            return;
        }

        // Kiểm tra xe đang bảo trì
        List<Cars> maintenanceCars = carController.findCarsByModelAndStatus(modelId, "MAINTENANCE");
        if (!maintenanceCars.isEmpty()) {
            response.getWriter().write("{\"status\": \"MAINTENANCE\"}");
            return;
        }

        // Nếu không có xe khả dụng hoặc đang bảo trì
        response.getWriter().write("{\"error\": \"Hiện tại không có xe khả dụng cho mẫu xe này.\"}");
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
        return "Check Status Servlet for TVT Future";
    }

    @Override
    public void destroy() {
        if (emf != null) {
            emf.close();
        }
    }
}