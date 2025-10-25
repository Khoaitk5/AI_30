package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.persistence.*;
import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.List;
import model.Cars;
import org.json.JSONObject;


@WebServlet(name = "ChatbotServlet", urlPatterns = {"/chatbot", "/chatbot/ui"})
public class ChatbotServlet extends HttpServlet {

    private EntityManagerFactory emf;

    @Override
    public void init() throws ServletException {
        emf = Persistence.createEntityManagerFactory("tvtfuturePU");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processChat(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();
        if ("/chatbot/ui".equals(path)) {
            request.getRequestDispatcher("/chatbot/chatbot.jsp").forward(request, response);
            return;
        }
        processChat(request, response);
    }

    private void processChat(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String question = request.getParameter("question");
        HttpSession session = request.getSession();
        response.setContentType("application/json;charset=UTF-8");

        if (question == null || question.trim().isEmpty()) {
            response.getWriter().write("{\"answer\": \"Bạn vui lòng nhập câu hỏi.\"}");
            return;
        }

        String lowerQ = question.trim().toLowerCase();

        // Nếu đã đăng nhập (session có user), tự xác định customerId
        String customerId = (String) session.getAttribute("customerId");
        if (customerId == null) {
            // Nếu có user đã đăng nhập (ví dụ lưu trong session là "user" hoặc "userId")
            Object userObj = session.getAttribute("user");
            if (userObj instanceof model.Users) {
                model.Users user = (model.Users) userObj;
                if ("Customer".equalsIgnoreCase(user.getRole()) && user.getCustomerId() != null) {
                    customerId = user.getCustomerId().getId();
                    session.setAttribute("customerId", customerId);
                }
            }
        }

        // Đặt xe: bắt đầu bằng yêu cầu đặt xe
        if (isBookingRequest(lowerQ)) {
            // Nếu chưa xác thực số điện thoại (chưa có customerId trong session)
            if (customerId == null) {
                response.getWriter().write("{\"answer\": \"Vui lòng nhập số điện thoại để xác minh danh tính trước khi đặt xe.\"}");
                session.setAttribute("bookingStep", "awaitingPhone");
                return;
            }
            // Nếu chưa chọn mẫu xe
            if (session.getAttribute("selectedCarModel") == null) {
                response.getWriter().write("{\"answer\": \"Vui lòng nhập tên mẫu xe bạn muốn đặt.\"}");
                session.setAttribute("bookingStep", "awaitingCarModel");
                return;
            }
            // Nếu chưa nhập ngày nhận
            if (session.getAttribute("startDate") == null) {
                response.getWriter().write("{\"answer\": \"Vui lòng nhập ngày nhận xe (định dạng yyyy-MM-dd).\"}");
                session.setAttribute("bookingStep", "awaitingStartDate");
                return;
            }
            // Nếu chưa nhập ngày trả
            if (session.getAttribute("endDate") == null) {
                response.getWriter().write("{\"answer\": \"Vui lòng nhập ngày trả xe (định dạng yyyy-MM-dd).\"}");
                session.setAttribute("bookingStep", "awaitingEndDate");
                return;
            }
            // Đầy đủ thông tin, tiến hành tạo booking
            try (EntityManager em = emf.createEntityManager()) {
                String carModel = (String) session.getAttribute("selectedCarModel");
                String startDate = (String) session.getAttribute("startDate");
                String endDate = (String) session.getAttribute("endDate");
                String pickupLocation = (String) session.getAttribute("pickupLocation");
                String dropoffLocation = (String) session.getAttribute("dropoffLocation");
                String bookingResult = createBooking(em, customerId, carModel, startDate, endDate, pickupLocation, dropoffLocation);
                // Xóa session bookingStep sau khi tạo booking
                session.removeAttribute("bookingStep");
                session.removeAttribute("selectedCarModel");
                session.removeAttribute("startDate");
                session.removeAttribute("endDate");
                session.removeAttribute("pickupLocation");
                session.removeAttribute("dropoffLocation");
                response.getWriter().write("{\"answer\": " + JSONObject.quote(bookingResult) + "}");
                return;
            }
        }

        // Xử lý các bước nhập thông tin cho đặt xe
        String bookingStep = (String) session.getAttribute("bookingStep");
        if ("awaitingPhone".equals(bookingStep)
            || "awaitingCarModel".equals(bookingStep)
            || "awaitingStartDate".equals(bookingStep)
            || "awaitingEndDate".equals(bookingStep)
            || "awaitingPickupLocation".equals(bookingStep)
            || "awaitingDropoffLocation".equals(bookingStep)) {

            if ("awaitingPhone".equals(bookingStep)) {
                String phone = question.replaceAll("[^0-9]", "");
                if (phone.length() < 9) {
                    response.getWriter().write("{\"answer\": \"Số điện thoại không hợp lệ. Vui lòng nhập lại.\"}");
                    return;
                }
                // Java xác minh danh tính khách hàng
                try (EntityManager em = emf.createEntityManager()) {
                    List<?> customers = em.createQuery("SELECT c FROM Customers c WHERE c.Phone = :phone")
                            .setParameter("phone", phone)
                            .setMaxResults(1)
                            .getResultList();
                    if (customers.isEmpty()) {
                        response.getWriter().write("{\"answer\": \"Không tìm thấy khách hàng với số điện thoại này. Vui lòng nhập lại hoặc đăng ký mới.\"}");
                        return;
                    }
                    String foundCustomerId = ((model.Customers) customers.get(0)).getId();
                    session.setAttribute("customerId", foundCustomerId); // Lưu customerId vào session
                    session.setAttribute("bookingStep", null);
                    response.getWriter().write("{\"answer\": \"Xác thực thành công! Vui lòng nhập tên mẫu xe bạn muốn đặt.\"}");
                    session.setAttribute("bookingStep", "awaitingCarModel");
                    return;
                }
            }
            if ("awaitingCarModel".equals(bookingStep)) {
                String carModel = extractModelName(question);
                if (carModel == null || carModel.isEmpty()) {
                    response.getWriter().write("{\"answer\": \"Tên mẫu xe không hợp lệ. Vui lòng nhập lại.\"}");
                    return;
                }
                session.setAttribute("selectedCarModel", carModel);
                session.setAttribute("bookingStep", null);
                response.getWriter().write("{\"answer\": \"Bạn đã chọn mẫu xe " + carModel + ". Vui lòng nhập ngày nhận xe (yyyy-MM-dd).\"}");
                session.setAttribute("bookingStep", "awaitingStartDate");
                return;
            }
            if ("awaitingStartDate".equals(bookingStep)) {
                String startDate = extractDate(question);
                if (startDate == null) {
                    response.getWriter().write("{\"answer\": \"Ngày nhận xe không hợp lệ. Vui lòng nhập lại (yyyy-MM-dd).\"}");
                    return;
                }
                session.setAttribute("startDate", startDate);
                session.setAttribute("bookingStep", null);
                response.getWriter().write("{\"answer\": \"Bạn đã chọn ngày nhận xe " + startDate + ". Vui lòng nhập ngày trả xe (yyyy-MM-dd).\"}");
                session.setAttribute("bookingStep", "awaitingEndDate");
                return;
            }
            if ("awaitingEndDate".equals(bookingStep)) {
                String endDate = extractDate(question);
                if (endDate == null) {
                    response.getWriter().write("{\"answer\": \"Ngày trả xe không hợp lệ. Vui lòng nhập lại (yyyy-MM-dd).\"}");
                    return;
                }
                session.setAttribute("endDate", endDate);
                // Đảm bảo không xóa bookingStep ở đây, để bước tiếp theo là nhập pickup location
                response.getWriter().write("{\"answer\": \"Bạn đã chọn ngày trả xe " + endDate + ". Vui lòng nhập nơi nhận xe.\"}");
                session.setAttribute("bookingStep", "awaitingPickupLocation");
                return;
            }
            if ("awaitingPickupLocation".equals(bookingStep)) {
                String pickupLocation = question.trim();
                if (pickupLocation.isEmpty()) {
                    response.getWriter().write("{\"answer\": \"Nơi nhận xe không hợp lệ. Vui lòng nhập lại.\"}");
                    return;
                }
                session.setAttribute("pickupLocation", pickupLocation);
                // Tự động lấy điểm trả giống điểm nhận
                session.setAttribute("dropoffLocation", pickupLocation);
                session.setAttribute("bookingStep", null);
                // Đã đủ thông tin, tạo booking
                String carModel = (String) session.getAttribute("selectedCarModel");
                String startDate = (String) session.getAttribute("startDate");
                String endDate = (String) session.getAttribute("endDate");
                String dropoffLocation = pickupLocation;
                try (EntityManager em = emf.createEntityManager()) {
                    String bookingResult = createBooking(em, customerId, carModel, startDate, endDate, pickupLocation, dropoffLocation);
                    session.removeAttribute("bookingStep");
                    session.removeAttribute("selectedCarModel");
                    session.removeAttribute("startDate");
                    session.removeAttribute("endDate");
                    session.removeAttribute("pickupLocation");
                    session.removeAttribute("dropoffLocation");
                    response.getWriter().write("{\"answer\": " + JSONObject.quote(bookingResult) + "}");
                }
                return;
            }
            if ("awaitingDropoffLocation".equals(bookingStep)) {
                String dropoffLocation = question.trim();
                if (dropoffLocation.isEmpty()) {
                    response.getWriter().write("{\"answer\": \"Nơi trả xe không hợp lệ. Vui lòng nhập lại.\"}");
                    return;
                }
                session.setAttribute("dropoffLocation", dropoffLocation);
                session.setAttribute("bookingStep", null);
                // Đã đủ thông tin, tạo booking
                String carModel = (String) session.getAttribute("selectedCarModel");
                String startDate = (String) session.getAttribute("startDate");
                String endDate = (String) session.getAttribute("endDate");
                String pickupLocation = (String) session.getAttribute("pickupLocation");
                try (EntityManager em = emf.createEntityManager()) {
                    String bookingResult = createBooking(em, customerId, carModel, startDate, endDate, pickupLocation, dropoffLocation);
                    session.removeAttribute("bookingStep");
                    session.removeAttribute("selectedCarModel");
                    session.removeAttribute("startDate");
                    session.removeAttribute("endDate");
                    session.removeAttribute("pickupLocation");
                    session.removeAttribute("dropoffLocation");
                    response.getWriter().write("{\"answer\": " + JSONObject.quote(bookingResult) + "}");
                }
                return;
            }
            // Đảm bảo không gọi sang n8n khi đang ở các bước booking
            return;
        }

        // Nếu là kiểm tra xe khả dụng (số lượng xe thực tế), xử lý bằng Java
        if (isCarAvailabilityRequest(lowerQ)) {
            String modelName = extractModelName(question);
            if (modelName == null || modelName.isEmpty()) {
                response.getWriter().write("{\"answer\": \"Bạn vui lòng nhập tên mẫu xe cần kiểm tra.\"}");
                return;
            }
            try (EntityManager em = emf.createEntityManager()) {
                String result = checkCarAvailability(em, modelName, session); // truyền session vào
                response.getWriter().write("{\"answer\": " + JSONObject.quote(result) + "}");
                return;
            }
        }

        // Thêm nhận diện câu hỏi lịch sử đơn hàng
        if (isOrderHistoryRequest(lowerQ)) {
            if (customerId == null) {
                response.getWriter().write("{\"answer\": \"Bạn cần đăng nhập để xem lịch sử đơn hàng.\"}");
                return;
            }
            try (EntityManager em = emf.createEntityManager()) {
                String history = getOrderHistory(em, customerId);
                response.getWriter().write("{\"answer\": " + JSONObject.quote(history) + "}");
                return;
            }
        }

        // Chỉ gọi n8n nếu không phải luồng booking hoặc kiểm tra xe
        try {
            String n8nAnswer = callN8n(question, session.getId());
            response.getWriter().write("{\"answer\": " + JSONObject.quote(n8nAnswer) + "}");
        } catch (Exception e) {
            response.getWriter().write("{\"answer\": \"Xin lỗi, hệ thống đang gặp sự cố. Vui lòng thử lại sau hoặc liên hệ hỗ trợ.\"}");
        }
    }

    // Nhận diện yêu cầu đặt xe
    private boolean isBookingRequest(String q) {
        return q.matches(".*(đặt xe|book xe|tạo đơn|thuê xe|muốn đặt xe|muốn thuê xe|booking|đặt).*");
    }

    // Nhận diện câu hỏi kiểm tra xe khả dụng
    private boolean isCarAvailabilityRequest(String q) {
        return q.matches(".*(kiểm tra xe|xe có sẵn|có xe nào|check car|available|khả dụng|còn xe|còn chiếc|còn mẫu).*");
    }

    // Nhận diện câu hỏi lịch sử đơn hàng
    private boolean isOrderHistoryRequest(String q) {
        return q.matches(".*(lịch sử đơn|lịch sử đặt|đơn đã đặt|đơn hàng của tôi|xem đơn|đặt xe trước đây|history|đơn cũ).*");
    }

    // Trích xuất tên mẫu xe từ câu hỏi
    private String extractModelName(String question) {
        // Đơn giản: lấy từ sau "xe", "mẫu xe", "VinFast", hoặc toàn bộ nếu không có từ khóa
        String[] patterns = {
            "(?:xe|mẫu xe|VinFast)\\s*([\\w\\d\\s\\-\\+]+)",
            "([Vv]inFast\\s+[\\w\\d\\s\\-\\+]+)"
        };
        for (String pat : patterns) {
            java.util.regex.Matcher m = java.util.regex.Pattern.compile(pat).matcher(question);
            if (m.find()) {
                return m.group(1).trim();
            }
        }
        return question.trim();
    }

    // Trích xuất ngày từ chuỗi nhập
    private String extractDate(String text) {
        text = text.trim();
        java.util.regex.Matcher m = java.util.regex.Pattern.compile("(\\d{4}-\\d{2}-\\d{2})").matcher(text);
        if (m.find()) {
            return m.group(1);
        }
        return null;
    }

    // Java-side kiểm tra xe khả dụng thực tế (sửa lại: kiểm tra trùng lịch booking)
    private String checkCarAvailability(EntityManager em, String modelName, HttpSession session) {
        try {
            // Lấy danh sách xe theo mẫu và status 'available'
            List<Cars> cars = em.createQuery(
                "SELECT c FROM Cars c WHERE c.vehicleModelId.model LIKE :model AND LOWER(c.status) = 'available'", Cars.class)
                .setParameter("model", "%" + modelName + "%")
                .getResultList();
            if (cars.isEmpty()) {
                return "Hiện tại không có xe '" + modelName + "' khả dụng.";
            }
            // Nếu người dùng đã nhập ngày nhận/ngày trả thì kiểm tra trùng lịch booking
            // Lấy từ session nếu có
            String startDate = null, endDate = null;
            try {
                startDate = (String) session.getAttribute("startDate");
                endDate = (String) session.getAttribute("endDate");
            } catch (Exception ex) {
                // ignore
            }
            StringBuilder sb = new StringBuilder();
            int availableCount = 0;
            for (Cars car : cars) {
                boolean isAvailable = true;
                if (startDate != null && endDate != null) {
                    List<?> bookings = em.createQuery(
                        "SELECT b FROM Bookings b WHERE b.carId.id = :carId AND " +
                        "((b.startDate <= :endDate AND b.endDate >= :startDate) AND b.status <> 'CANCELLED')")
                        .setParameter("carId", car.getId())
                        .setParameter("startDate", java.sql.Date.valueOf(startDate))
                        .setParameter("endDate", java.sql.Date.valueOf(endDate))
                        .getResultList();
                    if (!bookings.isEmpty()) {
                        isAvailable = false;
                    }
                }
                if (isAvailable) {
                    availableCount++;
                    sb.append("- Biển số: ").append(car.getLicensePlate()).append("\n");
                }
            }
            if (availableCount == 0) {
                return "Không có xe '" + modelName + "' khả dụng trong khoảng thời gian bạn chọn.";
            }
            sb.insert(0, "Có " + availableCount + " xe '" + modelName + "' khả dụng:\n");
            return sb.toString();
        } catch (Exception e) {
            return "Lỗi kiểm tra xe: " + e.getMessage();
        }
    }

    // Tạo booking mới (đã kiểm tra trùng lịch booking)
    private String createBooking(EntityManager em, String customerId, String carModel, String startDate, String endDate, String pickupLocation, String dropoffLocation) {
        try {
            // Tìm xe khả dụng theo mẫu xe và khoảng thời gian (kiểm tra trùng booking)
            List<Cars> cars = em.createQuery(
                "SELECT c FROM Cars c WHERE c.vehicleModelId.model LIKE :model AND LOWER(c.status) = 'available'", Cars.class)
                .setParameter("model", "%" + carModel + "%")
                .getResultList();
            if (cars.isEmpty()) {
                return "Hiện tại không có xe " + carModel + " khả dụng trong hệ thống.";
            }

            // Chỉ lấy xe chưa bị trùng lịch đặt trong khoảng thời gian yêu cầu
            Cars availableCar = null;
            for (Cars car : cars) {
                List<?> bookings = em.createQuery(
                    "SELECT b FROM Bookings b WHERE b.carId.id = :carId AND " +
                    "((b.startDate <= :endDate AND b.endDate >= :startDate) AND b.status <> 'CANCELLED')")
                    .setParameter("carId", car.getId())
                    .setParameter("startDate", java.sql.Date.valueOf(startDate))
                    .setParameter("endDate", java.sql.Date.valueOf(endDate))
                    .getResultList();
                if (bookings.isEmpty()) {
                    availableCar = car;
                    break;
                }
            }
            if (availableCar == null) {
                return "Xe " + carModel + " không khả dụng trong khoảng thời gian bạn chọn.";
            }

            // Lấy giá thuê và tiền cọc từ Models (sửa lại dùng getResultList thay vì getSingleResult)
            List<Object[]> modelInfoList = em.createQuery(
                "SELECT m.rentalPricePerDay, m.depositPerDay FROM Models m WHERE m.model LIKE :model", Object[].class)
                .setParameter("model", "%" + carModel + "%")
                .setMaxResults(1)
                .getResultList();
            if (modelInfoList.isEmpty()) {
                return "Không tìm thấy thông tin giá thuê cho mẫu xe " + carModel + ".";
            }
            Object[] modelInfo = modelInfoList.get(0);
            java.math.BigDecimal pricePerDay = (java.math.BigDecimal) modelInfo[0];
            java.math.BigDecimal depositPerDay = (java.math.BigDecimal) modelInfo[1];

            // Tính số ngày thuê
            java.time.LocalDate d1 = java.time.LocalDate.parse(startDate);
            java.time.LocalDate d2 = java.time.LocalDate.parse(endDate);
            long days = java.time.temporal.ChronoUnit.DAYS.between(d1, d2) + 1;
            if (days <= 0) return "Ngày trả xe phải sau ngày nhận xe.";

            java.math.BigDecimal totalAmount = pricePerDay.multiply(java.math.BigDecimal.valueOf(days));

            // Tạo booking mới
            em.getTransaction().begin();
            model.Bookings booking = new model.Bookings();
            booking.setId("bk" + System.currentTimeMillis());
            booking.setCustomerId(em.find(model.Customers.class, customerId));
            booking.setCarId(availableCar);
            booking.setStartDate(java.sql.Date.valueOf(startDate));
            booking.setEndDate(java.sql.Date.valueOf(endDate));
            booking.setTotalDays((int) days);
            booking.setPricePerDay(pricePerDay);
            booking.setTotalAmount(totalAmount);
            booking.setDeposit(depositPerDay);
            booking.setStatus("PENDING");
            booking.setPickupLocation(pickupLocation);
            booking.setDropoffLocation(dropoffLocation);
            booking.setDeliveryTime(java.sql.Timestamp.valueOf(startDate + " 08:00:00")); 
            booking.setReturnTime(java.sql.Timestamp.valueOf(endDate + " 18:00:00"));
            booking.setBillingCycle("DAILY"); 
            booking.setCreatedAt(new java.util.Date());
            booking.setUpdatedAt(new java.util.Date());
            em.persist(booking);
            em.getTransaction().commit();

            java.math.BigDecimal tongTienHienThi = totalAmount.add(depositPerDay);
            return "Đơn đặt xe đã được tạo thành công!\n"
                + "Mã đơn: " + booking.getId() + "\n"
                + "Khách hàng: " + booking.getCustomerId().getFullName() + "\n"
                + "Xe: " + carModel + " - Biển số: " + availableCar.getLicensePlate() + "\n"
                + "Thời gian thuê: " + startDate + " đến " + endDate + " (" + days + " ngày)\n"
                + "Nơi nhận xe: " + pickupLocation + "\n"
                + "Nơi trả xe: " + dropoffLocation + "\n"
                + "Giá thuê/ngày: " + pricePerDay + " VNĐ\n"
                + "Tiền cọc: " + depositPerDay + " VNĐ\n"
                + "Tổng tiền: " + tongTienHienThi + " VNĐ\n"
                + "Trạng thái: pending";
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            return "Lỗi khi tạo booking: " + e.getMessage();
        }
    }

    // Gửi câu hỏi sang n8n và lấy kết quả trả về
    private String callN8n(String question, String sessionId) {
        try {
            URL url = new URL("http://localhost:5678/webhook/chatbot");
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            conn.setDoOutput(true);

            JSONObject payload = new JSONObject()
                .put("message", question)
                .put("sessionId", sessionId)
                .put("current_date", new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date()))
                .put("phone", JSONObject.NULL)
                .put("modelName", JSONObject.NULL);

            try (OutputStream os = conn.getOutputStream()) {
                byte[] input = payload.toString().getBytes(StandardCharsets.UTF_8);
                os.write(input, 0, input.length);
            }
            int code = conn.getResponseCode();
            InputStream is = (code == 200) ? conn.getInputStream() : conn.getErrorStream();
            BufferedReader br = new BufferedReader(new InputStreamReader(is, StandardCharsets.UTF_8));
            StringBuilder resp = new StringBuilder();
            String line;
            while ((line = br.readLine()) != null) {
                resp.append(line);
            }
            br.close();

            String respStr = resp.toString().trim();
            if (respStr.startsWith("[")) {
                org.json.JSONArray arr = new org.json.JSONArray(respStr);
                if (arr.length() > 0) {
                    JSONObject obj = arr.getJSONObject(0);
                    return obj.optString("output", "Xin lỗi, tôi chưa có câu trả lời.");
                } else {
                    return "Xin lỗi, tôi chưa có câu trả lời.";
                }
            } else if (respStr.startsWith("{")) {
                JSONObject json = new JSONObject(respStr);
                return json.optString("output", "Xin lỗi, tôi chưa có câu trả lời.");
            } else {
                // Nếu trả về là chuỗi thường (plain text), trả về luôn cho người dùng, không báo lỗi
                return respStr;
            }
        } catch (Exception e) {
            return "Lỗi kết nối n8n: " + e.getMessage();
        }
    }

    // Lấy lịch sử đơn hàng cho customerId (rút gọn, trình bày đẹp)
    private String getOrderHistory(EntityManager em, String customerId) {
        try {
            List<model.Bookings> bookings = em.createQuery(
                "SELECT b FROM Bookings b WHERE b.customerId.id = :cid ORDER BY b.createdAt DESC", model.Bookings.class)
                .setParameter("cid", customerId)
                .setMaxResults(10)
                .getResultList();
            if (bookings.isEmpty()) {
                return "Bạn chưa có đơn đặt xe nào.";
            }
            StringBuilder sb = new StringBuilder();
            sb.append("Lịch sử đơn đặt xe:\n");
            for (model.Bookings b : bookings) {
                sb.append("• [").append(b.getId()).append("] ")
                  .append(b.getCarId().getVehicleModelId().getModel())
                  .append(" - ").append(b.getCarId().getLicensePlate())
                  .append(" | ").append(b.getStartDate())
                  .append(" → ").append(b.getEndDate())
                  .append(" | ").append(b.getStatus())
                  .append("\n");
            }
            return sb.toString();
        } catch (Exception e) {
            return "Lỗi lấy lịch sử đơn hàng: " + e.getMessage();
        }
    }

    @Override
    public void destroy() {
        if (emf != null) {
            emf.close();
        }
    }
}