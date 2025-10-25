# TVT Future - Hệ thống quản lý cho thuê xe

## Mô tả dự án
Đây là một ứng dụng Java Web để quản lý hệ thống cho thuê xe điện VinFast, bao gồm các chức năng:
- Quản lý khách hàng
- Quản lý xe
- Quản lý đặt xe
- Quản lý thanh toán
- Chatbot hỗ trợ
- Tích hợp VNPay
- Đăng nhập với Google OAuth

## Công nghệ sử dụng
- **Java**: JDK 17
- **Jakarta EE**: Jakarta Servlet 6.1, Jakarta Persistence 3.2
- **Database**: Microsoft SQL Server
- **ORM**: EclipseLink 4.0.7, Hibernate
- **Server**: Apache Tomcat 10.x/11.x
- **Build Tool**: Apache Ant (NetBeans)
- **Libraries**: 
  - Gson 2.13.1
  - JSON 20250517
  - OkHttp 5.1.0
  - JavaMail 1.4.7
  - Lombok 1.18.38

## Yêu cầu hệ thống
1. **JDK 17** hoặc cao hơn
2. **Apache Tomcat 10.1.x** hoặc cao hơn (hỗ trợ Jakarta EE)
3. **Microsoft SQL Server** (bất kỳ phiên bản nào)
4. **NetBeans IDE** 17 hoặc cao hơn (khuyến nghị)

## Cấu hình Database
1. Tạo database tên `TVT_Future` trong SQL Server
2. Cập nhật thông tin kết nối trong file `src/conf/persistence.xml`:
   ```xml
   <property name="jakarta.persistence.jdbc.url" value="jdbc:sqlserver://localhost:1433;databaseName=TVT_Future;encrypt=false;trustServerCertificate=true;"/>
   <property name="jakarta.persistence.jdbc.user" value="sa"/>
   <property name="jakarta.persistence.jdbc.password" value="YOUR_PASSWORD"/>
   ```

## Cách chạy dự án

### Với NetBeans IDE:
1. Mở NetBeans IDE
2. Chọn `File` → `Open Project`
3. Chọn thư mục dự án `tvtfuture`
4. Chuột phải vào project → `Properties` → `Run`
5. Chọn server: Apache Tomcat
6. Nhấn `Run Project` (F6) hoặc chuột phải → `Run`

### Với Command Line (Ant):
```bash
# Build project
ant clean build

# Deploy to Tomcat
# Copy file dist/tvtfuture.war vào thư mục webapps của Tomcat
```

## Cấu trúc dự án
```
tvtfuture/
├── build.xml                 # Ant build script
├── nbproject/                # NetBeans project config
├── src/
│   ├── conf/
│   │   ├── MANIFEST.MF
│   │   └── persistence.xml   # JPA configuration
│   └── java/
│       ├── controller/       # Servlets
│       ├── dao/              # JPA Controllers (DAO)
│       ├── model/            # Entity classes
│       ├── service/          # Business logic
│       └── utils/            # Utility classes
├── web/
│   ├── WEB-INF/
│   │   ├── web.xml          # Web app configuration
│   │   └── lib/             # JAR libraries
│   ├── META-INF/
│   │   └── context.xml      # Context configuration
│   ├── admin/               # Admin pages
│   ├── home/                # Home pages
│   ├── login/               # Login pages
│   └── ...                  # Other JSP/HTML pages
└── test/                    # Test files
```

## Các URL chính
- Homepage: `http://localhost:8080/tvtfuture/`
- Login: `http://localhost:8080/tvtfuture/login`
- Dashboard: `http://localhost:8080/tvtfuture/dashboard`
- Chatbot: `http://localhost:8080/tvtfuture/chatbot/ui`
- Rental: `http://localhost:8080/tvtfuture/rental`

## Lưu ý quan trọng
1. Đảm bảo SQL Server đang chạy trước khi start ứng dụng
2. File `persistence.xml` sẽ tự động tạo schema nếu chưa có (xem property `jakarta.persistence.schema-generation.database.action`)
3. Tất cả servlet đã sử dụng annotation `@WebServlet`, không cần khai báo trong `web.xml`
4. Port mặc định của Tomcat là 8080

## Troubleshooting

### Lỗi kết nối Database
- Kiểm tra SQL Server đang chạy
- Kiểm tra username/password trong `persistence.xml`
- Kiểm tra firewall cho phép kết nối port 1433

### Lỗi 404 Not Found
- Kiểm tra context path trong `META-INF/context.xml`
- Kiểm tra Tomcat đã deploy đúng file WAR
- Clear Tomcat work directory

### Lỗi ClassNotFoundException
- Kiểm tra tất cả JAR files trong `web/WEB-INF/lib`
- Clean và rebuild project

## Tác giả
TVT Future Team

## License
Private Project
