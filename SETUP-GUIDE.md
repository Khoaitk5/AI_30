# Hướng dẫn Setup môi trường phát triển TVT Future

## Bước 1: Cài đặt JDK 17

### Windows:
1. Tải JDK 17 từ: https://www.oracle.com/java/technologies/javase/jdk17-archive-downloads.html
2. Chạy file cài đặt và làm theo hướng dẫn
3. Thiết lập biến môi trường:
   - Mở System Properties → Environment Variables
   - Thêm `JAVA_HOME`: `C:\Program Files\Java\jdk-17`
   - Thêm vào Path: `%JAVA_HOME%\bin`
4. Kiểm tra: Mở PowerShell/CMD và chạy:
   ```bash
   java -version
   javac -version
   ```

## Bước 2: Cài đặt Apache Tomcat 10.1.x

1. Tải Tomcat 10.1.x từ: https://tomcat.apache.org/download-10.cgi
2. Giải nén vào thư mục (ví dụ: `C:\Program Files\Apache\Tomcat 10.1`)
3. Cấu hình (tùy chọn):
   - Mở `conf/tomcat-users.xml`
   - Thêm user admin:
     ```xml
     <role rolename="manager-gui"/>
     <role rolename="admin-gui"/>
     <user username="admin" password="admin" roles="manager-gui,admin-gui"/>
     ```
4. Khởi động Tomcat:
   - Windows: Chạy `bin\startup.bat`
   - Kiểm tra: http://localhost:8080

## Bước 3: Cài đặt Microsoft SQL Server

### SQL Server Express (Free):
1. Tải từ: https://www.microsoft.com/en-us/sql-server/sql-server-downloads
2. Chọn "Download now" cho Express edition
3. Chạy installer và chọn "Basic" installation
4. Cài đặt SQL Server Management Studio (SSMS):
   - Tải từ: https://docs.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms
5. Cấu hình SQL Server:
   - Mở SQL Server Configuration Manager
   - Enable TCP/IP protocol
   - Restart SQL Server service
   - Enable SQL Server Authentication:
     - Mở SSMS, connect to server
     - Right-click server → Properties → Security
     - Chọn "SQL Server and Windows Authentication mode"
     - Restart SQL Server

### Tạo Database:
1. Mở SSMS
2. Connect to localhost (hoặc server của bạn)
3. New Query và chạy:
   ```sql
   CREATE DATABASE TVT_Future;
   ```
   Hoặc chạy file: `database-setup.sql`

## Bước 4: Cài đặt NetBeans IDE

1. Tải NetBeans 17+ từ: https://netbeans.apache.org/download/
2. Chọn version "Java EE"
3. Chạy installer
4. Cấu hình NetBeans:
   - Tools → Servers → Add Server
   - Chọn Apache Tomcat
   - Browse đến thư mục Tomcat đã cài

## Bước 5: Import Project vào NetBeans

1. Mở NetBeans
2. File → Open Project
3. Browse đến thư mục `tvtfuture`
4. Click "Open Project"
5. Đợi NetBeans load project

## Bước 6: Cấu hình Database trong Project

1. Mở file `src/conf/persistence.xml`
2. Cập nhật thông tin database:
   ```xml
   <property name="jakarta.persistence.jdbc.url" 
             value="jdbc:sqlserver://localhost:1433;databaseName=TVT_Future;encrypt=false;trustServerCertificate=true;"/>
   <property name="jakarta.persistence.jdbc.user" value="sa"/>
   <property name="jakarta.persistence.jdbc.password" value="YOUR_PASSWORD"/>
   ```
3. Thay `YOUR_PASSWORD` bằng password của SQL Server

## Bước 7: Build và Run Project

### Trong NetBeans:
1. Right-click vào project `tvtfuture`
2. Chọn "Clean and Build"
3. Đợi build xong (check Output window)
4. Right-click project → "Run"
5. Browser sẽ tự động mở: http://localhost:8080/tvtfuture/

### Sử dụng Ant (Command Line):
```powershell
# Clean project
ant clean

# Build project
ant build

# Clean and build
ant clean build

# Deploy (copy WAR file to Tomcat)
Copy-Item dist\tvtfuture.war "C:\Program Files\Apache\Tomcat 10.1\webapps\"
```

## Bước 8: Kiểm tra ứng dụng

1. Truy cập: http://localhost:8080/tvtfuture/
2. Các URL test khác:
   - Login: http://localhost:8080/tvtfuture/login
   - Dashboard: http://localhost:8080/tvtfuture/dashboard
   - Chatbot: http://localhost:8080/tvtfuture/chatbot/ui

## Bước 9: Cấu hình thêm (Tùy chọn)

### VNPay Integration:
1. Đăng ký tài khoản VNPay Sandbox
2. Lấy TMN Code và Hash Secret
3. Cập nhật trong `src/java/utils/VNPayConfig.java`

### Google OAuth:
1. Tạo project trên Google Cloud Console
2. Enable Google+ API
3. Tạo OAuth 2.0 credentials
4. Cập nhật trong `src/java/controller/GoogleAuthController.java`

### Email Configuration:
1. Tạo App Password cho Gmail (nếu dùng Gmail)
2. Cập nhật trong `src/java/utils/MailUtils.java`

## Troubleshooting

### Lỗi: "Cannot connect to database"
**Giải pháp:**
- Kiểm tra SQL Server đang chạy
- Kiểm tra username/password trong persistence.xml
- Test connection bằng SSMS
- Kiểm tra firewall cho phép port 1433

### Lỗi: "HTTP Status 404 – Not Found"
**Giải pháp:**
- Kiểm tra Tomcat đã start
- Kiểm tra context path: http://localhost:8080/tvtfuture/
- Check Tomcat logs: `logs/catalina.out` hoặc `logs/localhost.log`
- Redeploy application

### Lỗi: "ClassNotFoundException"
**Giải pháp:**
- Kiểm tra tất cả JAR files trong `web/WEB-INF/lib`
- Clean and rebuild project
- Check libraries trong project.properties

### Lỗi: "Port 8080 already in use"
**Giải pháp:**
- Tìm process đang dùng port 8080:
  ```powershell
  netstat -ano | findstr :8080
  ```
- Kill process hoặc đổi port Tomcat trong `conf/server.xml`

### Lỗi: JDK version mismatch
**Giải pháp:**
- Kiểm tra JDK version: `java -version`
- Trong NetBeans: Tools → Java Platforms
- Trong project: Right-click → Properties → Sources → Source/Binary Format = 17

## Các lệnh hữu ích

### SQL Server:
```sql
-- Kiểm tra database
SELECT name FROM sys.databases;

-- Kiểm tra tables
SELECT * FROM INFORMATION_SCHEMA.TABLES;

-- Backup database
BACKUP DATABASE TVT_Future TO DISK = 'C:\Backup\TVT_Future.bak';
```

### Tomcat:
```powershell
# Start Tomcat
.\bin\startup.bat

# Stop Tomcat
.\bin\shutdown.bat

# View logs
Get-Content logs\catalina.out -Tail 50 -Wait
```

### NetBeans:
- Clean Project: Shift + F11
- Build Project: F11
- Run Project: F6
- Debug Project: Ctrl + F5

## Tài liệu tham khảo

- Jakarta EE: https://jakarta.ee/
- Tomcat: https://tomcat.apache.org/
- SQL Server: https://docs.microsoft.com/en-us/sql/
- NetBeans: https://netbeans.apache.org/kb/

## Support

Nếu gặp vấn đề, check:
1. NetBeans Output window
2. Tomcat logs folder
3. Browser Console (F12)
4. SQL Server logs
