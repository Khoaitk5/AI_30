package controller;

import dao.CarJpaController;
import dao.ModelJpaController;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Cars;
import model.Models;
import model.Colors;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "CarServlet", urlPatterns = {"/cars", "/cars/add", "/cars/edit", "/cars/unactive", "/cars/active"})
public class CarServlet extends HttpServlet {

    private final EntityManagerFactory emf = Persistence.createEntityManagerFactory("tvtfuturePU");
    private CarJpaController carController;
    private ModelJpaController modelController;

    @Override
    public void init() throws ServletException {
        carController = new CarJpaController(emf);
        modelController = new ModelJpaController(emf);
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getServletPath();

        try {
            switch (action) {
                case "/cars":
                    listCars(request, response);
                    break;
                case "/cars/add":
                    if ("GET".equalsIgnoreCase(request.getMethod())) {
                        showAddForm(request, response);
                    } else {
                        addCar(request, response);
                    }
                    break;
                case "/cars/edit":
                    if ("GET".equalsIgnoreCase(request.getMethod())) {
                        showEditForm(request, response);
                    } else {
                        updateCar(request, response);
                    }
                    break;
                case "/cars/unactive":
                    unactiveCar(request, response);
                    break;
                case "/cars/active":
                    activeCar(request, response);
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "Action not found");
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error processing request: " + e.getMessage());
        }
    }

    private void listCars(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Cars> cars = carController.findCarsEntities();
        request.setAttribute("cars", cars);
        request.getRequestDispatcher("/cars/carList.jsp").forward(request, response);
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/cars/carAdd.jsp").forward(request, response);
    }

    private void addCar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String vehicleModelId = request.getParameter("vehicleModelId");
        String colorId = request.getParameter("colorId");
        String licensePlate = request.getParameter("licensePlate");
        String chassisNumber = request.getParameter("chassisNumber");
        String status = request.getParameter("status");

        // Validate for duplicates
        if (carController.isLicensePlateDuplicate(licensePlate, null)) {
            request.setAttribute("error", "Biển số đã tồn tại. Vui lòng nhập biển số khác.");
            request.getRequestDispatcher("/cars/carAdd.jsp").forward(request, response);
            return;
        }
        if (carController.isChassisNumberDuplicate(chassisNumber, null)) {
            request.setAttribute("error", "Số khung đã tồn tại. Vui lòng nhập số khung khác.");
            request.getRequestDispatcher("/cars/carAdd.jsp").forward(request, response);
            return;
        }

        String newId = generateNewCarId();

        Cars car = new Cars(newId);
        car.setVehicleModelId(new Models(vehicleModelId));
        car.setColorId(new Colors(colorId));
        car.setLicensePlate(licensePlate);
        car.setChassisNumber(chassisNumber);
        car.setStatus(status);

        carController.create(car);
        response.sendRedirect(request.getContextPath() + "/cars");
    }

    private String generateNewCarId() {
        List<Cars> cars = carController.findCarsEntities();
        int maxId = 0;
        for (Cars car : cars) {
            String id = car.getId();
            if (id.startsWith("car")) {
                try {
                    int num = Integer.parseInt(id.substring(3));
                    if (num > maxId) {
                        maxId = num;
                    }
                } catch (NumberFormatException e) {
                    // Ignore invalid IDs
                }
            }
        }
        return String.format("car%02d", maxId + 1);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        Cars car = carController.findCars(id);
        if (car != null) {
            request.setAttribute("car", car);
            request.getRequestDispatcher("/cars/carEdit.jsp").forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Car not found");
        }
    }

    private void updateCar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        String vehicleModelId = request.getParameter("vehicleModelId");
        String colorId = request.getParameter("colorId");
        String licensePlate = request.getParameter("licensePlate");
        String chassisNumber = request.getParameter("chassisNumber");
        String status = request.getParameter("status");

        // Validate for duplicates
        if (carController.isLicensePlateDuplicate(licensePlate, id)) {
            request.setAttribute("error", "Biển số đã tồn tại. Vui lòng nhập biển số khác.");
            request.setAttribute("car", carController.findCars(id));
            request.getRequestDispatcher("/cars/carEdit.jsp").forward(request, response);
            return;
        }
        if (carController.isChassisNumberDuplicate(chassisNumber, id)) {
            request.setAttribute("error", "Số khung đã tồn tại. Vui lòng nhập số khung khác.");
            request.setAttribute("car", carController.findCars(id));
            request.getRequestDispatcher("/cars/carEdit.jsp").forward(request, response);
            return;
        }

        Cars car = carController.findCars(id);
        if (car != null) {
            car.setVehicleModelId(new Models(vehicleModelId));
            car.setColorId(new Colors(colorId));
            car.setLicensePlate(licensePlate);
            car.setChassisNumber(chassisNumber);
            car.setStatus(status);
            try {
                carController.edit(car);
            } catch (Exception e) {
                throw new ServletException("Error updating car", e);
            }
            response.sendRedirect(request.getContextPath() + "/cars");
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Car not found");
        }
    }

    private void unactiveCar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        Cars car = carController.findCars(id);
        if (car != null) {
            try {
                carController.updateStatusToMaintenance(id);
            } catch (Exception e) {
                throw new ServletException("Error updating car status to maintenance", e);
            }
            response.sendRedirect(request.getContextPath() + "/cars");
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Car not found");
        }
    }

    private void activeCar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        Cars car = carController.findCars(id);
        if (car != null) {
            try {
                carController.updateStatusToAvailable(id);
            } catch (Exception e) {
                throw new ServletException("Error updating car status to available", e);
            }
            response.sendRedirect(request.getContextPath() + "/cars");
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Car not found");
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
        return "Car Servlet for TVT Future";
    }

    @Override
    public void destroy() {
        if (emf != null) {
            emf.close();
        }
    }
}