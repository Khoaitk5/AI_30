package controller;

import dao.CustomersJpaController;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Customers;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.regex.Pattern;

@WebServlet(name = "CustomerServlet", urlPatterns = {"/customers", "/customers/add", "/customers/edit", "/customers/delete"})
public class CustomerServlet extends HttpServlet {
    private final EntityManagerFactory emf = Persistence.createEntityManagerFactory("tvtfuturePU");
    private static final Pattern NAME_PATTERN = Pattern.compile("^[a-zA-ZÀ-ỹ\\s]+$");
    private static final Pattern EMAIL_PATTERN = Pattern.compile("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$");
    private static final Pattern PHONE_PATTERN = Pattern.compile("^\\d{10,11}$");
    private static final Pattern IDCARD_PATTERN = Pattern.compile("^\\d{9}$|^\\d{12}$");

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getServletPath();

        try {
            CustomersJpaController customersController = new CustomersJpaController(emf);

            switch (action) {
                case "/customers":
                    // Display list of customers
                    List<Customers> customersList = customersController.findCustomersEntities();
                    request.setAttribute("customersList", customersList);
                    request.getRequestDispatcher("/customers/customerList.jsp").forward(request, response);
                    break;

                case "/customers/add":
                    if (request.getMethod().equalsIgnoreCase("GET")) {
                        // Show add customer form
                        request.getRequestDispatcher("/customers/addCus.jsp").forward(request, response);
                    } else {
                        // Handle add submission
                        String fullName = request.getParameter("fullName");
                        String email = request.getParameter("email");
                        String phone = request.getParameter("phone");
                        String idCardNumber = request.getParameter("idCardNumber");
                        List<String> errors = new ArrayList<>();

                        // Validate fullName
                        if (fullName == null || !NAME_PATTERN.matcher(fullName).matches()) {
                            errors.add("Tên khách hàng không hợp lệ");
                        }

                        // Validate email
                        if (email == null || !EMAIL_PATTERN.matcher(email).matches()) {
                            errors.add("Email không đúng định dạng");
                        }

                        // Validate phone
                        if (phone != null && !phone.isEmpty() && !PHONE_PATTERN.matcher(phone).matches()) {
                            errors.add("Số điện thoại phải có 10 hoặc 11 số");
                        }

                        // Validate idCardNumber
                        if (idCardNumber != null && !idCardNumber.isEmpty() && !IDCARD_PATTERN.matcher(idCardNumber).matches()) {
                            errors.add("Số CMND/CCCD phải có 9 hoặc 12 số");
                        }

                        // If there are errors, return to form with errors and input data
                        if (!errors.isEmpty()) {
                            request.setAttribute("errors", errors);
                            request.getRequestDispatcher("/customers/addCus.jsp").forward(request, response);
                            return;
                        }

                        // Generate auto-increment ID (custXX)
                        int customerCount = customersController.getCustomersCount();
                        String newId;
                        do {
                            customerCount++;
                            newId = String.format("cust%02d", customerCount);
                        } while (customersController.findCustomers(newId) != null);

                        Customers customer = new Customers();
                        customer.setId(newId);
                        customer.setFullName(fullName);
                        customer.setEmail(email);
                        customer.setPhone(phone);
                        customer.setAddress(request.getParameter("address"));
                        customer.setLicenseNumber(request.getParameter("licenseNumber"));
                        
                        String licenseExpiryStr = request.getParameter("licenseExpiry");
                        if (licenseExpiryStr != null && !licenseExpiryStr.isEmpty()) {
                            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                            customer.setLicenseExpiry(sdf.parse(licenseExpiryStr));
                        }

                        customer.setIdCardNumber(idCardNumber);
                        
                        String dobStr = request.getParameter("dateOfBirth");
                        if (dobStr != null && !dobStr.isEmpty()) {
                            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                            customer.setDateOfBirth(sdf.parse(dobStr));
                        }

                        customer.setMembershipLevel(request.getParameter("membershipLevel"));
                        customer.setStatus(request.getParameter("status"));
                        customer.setCreatedAt(new Date());
                        customer.setUpdatedAt(new Date());

                        customersController.create(customer);
                        response.sendRedirect(request.getContextPath() + "/customers");
                    }
                    break;

                case "/customers/edit":
                    if (request.getMethod().equalsIgnoreCase("GET")) {
                        // Show edit form
                        String id = request.getParameter("id");
                        if (id != null && !id.isEmpty()) {
                            Customers customer = customersController.findCustomers(id);
                            request.setAttribute("customer", customer);
                        }
                        request.getRequestDispatcher("/customers/editCus.jsp").forward(request, response);
                    } else {
                        // Handle edit submission
                        String id = request.getParameter("id");
                        String fullName = request.getParameter("fullName");
                        String email = request.getParameter("email");
                        String phone = request.getParameter("phone");
                        String idCardNumber = request.getParameter("idCardNumber");
                        List<String> errors = new ArrayList<>();

                        // Validate fullName
                        if (fullName == null || !NAME_PATTERN.matcher(fullName).matches()) {
                            errors.add("Tên khách hàng không hợp lệ");
                        }

                        // Validate email
                        if (email == null || !EMAIL_PATTERN.matcher(email).matches()) {
                            errors.add("Email không đúng định dạng");
                        }

                        // Validate phone
                        if (phone != null && !phone.isEmpty() && !PHONE_PATTERN.matcher(phone).matches()) {
                            errors.add("Số điện thoại phải có 10 hoặc 11 số");
                        }

                        // Validate idCardNumber
                        if (idCardNumber != null && !idCardNumber.isEmpty() && !IDCARD_PATTERN.matcher(idCardNumber).matches()) {
                            errors.add("Số CMND/CCCD phải có 9 hoặc 12 số");
                        }

                        // If there are errors, return to form with errors and customer data
                        if (!errors.isEmpty()) {
                            request.setAttribute("errors", errors);
                            request.setAttribute("customer", customersController.findCustomers(id));
                            request.getRequestDispatcher("/customers/editCus.jsp").forward(request, response);
                            return;
                        }

                        Customers customer = customersController.findCustomers(id);
                        if (customer != null) {
                            customer.setFullName(fullName);
                            customer.setEmail(email);
                            customer.setPhone(phone);
                            customer.setAddress(request.getParameter("address"));
                            customer.setLicenseNumber(request.getParameter("licenseNumber"));
                            
                            String licenseExpiryStr = request.getParameter("licenseExpiry");
                            if (licenseExpiryStr != null && !licenseExpiryStr.isEmpty()) {
                                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                                customer.setLicenseExpiry(sdf.parse(licenseExpiryStr));
                            } else {
                                customer.setLicenseExpiry(null);
                            }

                            customer.setIdCardNumber(idCardNumber);
                            
                            String dobStr = request.getParameter("dateOfBirth");
                            if (dobStr != null && !dobStr.isEmpty()) {
                                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                                customer.setDateOfBirth(sdf.parse(dobStr));
                            } else {
                                customer.setDateOfBirth(null);
                            }

                            customer.setMembershipLevel(request.getParameter("membershipLevel"));
                            customer.setStatus(request.getParameter("status"));
                            customer.setUpdatedAt(new Date());

                            customersController.edit(customer);
                        }
                        
                        response.sendRedirect(request.getContextPath() + "/customers");
                    }
                    break;

                case "/customers/delete":
                    String id = request.getParameter("id");
                    if (id != null && !id.isEmpty()) {
                        Customers customer = customersController.findCustomers(id);
                        if (customer != null) {
                            customer.setStatus("unvalid");
                            customer.setUpdatedAt(new Date());
                            customersController.edit(customer);
                        }
                    }
                    response.sendRedirect(request.getContextPath() + "/customers");
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi khi xử lý yêu cầu khách hàng: " + e.getMessage());
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
        return "Customer Management Servlet for TVT Future";
    }

    @Override
    public void destroy() {
        if (emf != null) {
            emf.close();
        }
    }
}