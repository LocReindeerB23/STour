# Hướng dẫn Cài đặt & Chạy Dự án Tour Booking

Dự án này được viết bằng Java Spring Boot và sử dụng cơ sở dữ liệu MySQL. Để chạy được dự án trên máy tính của bạn, hãy làm theo các bước sau:

## 1. Yêu cầu hệ thống
- Đã cài đặt **Java (JDK) phiên bản 17** trở lên.
- Đã cài đặt **MySQL Server** (Bạn có thể dùng XAMPP, WAMP, hoặc MySQL Workbench).

## 2. Thiết lập Cơ sở dữ liệu (Database)
1. Mở MySQL (hoặc phpMyAdmin nếu bạn dùng XAMPP).
2. Tạo một Database mới có tên là: `tour_booking_db` bằng lệnh SQL sau:
   ```sql
   CREATE DATABASE tour_booking_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
   ```
3. Nhập (Import) dữ liệu mẫu:
   - Trong thư mục gốc của dự án này, có một file tên là `database_backup.sql`.
   - Bạn hãy import file này vào Database `tour_booking_db` vừa tạo để có sẵn các dữ liệu mẫu (danh sách Tour, tài khoản admin, v.v.).

## 3. Cấu hình kết nối Database
1. Mở thư mục dự án, tìm đến file: `src/main/resources/application.properties`
2. Mở file đó lên bằng bất kỳ trình soạn thảo nào (Notepad, VSCode, IntelliJ).
3. Sửa lại Username và Password MySQL cho khớp với máy tính của bạn:
   ```properties
   spring.datasource.username=root   # Điền username MySQL của bạn (thường là root)
   spring.datasource.password=123456 # Điền password MySQL của bạn (nếu không có thì để trống)
   ```

## 4. Chạy Dự án
- **Nếu dùng phần mềm (IDE):**
  Bạn có thể mở toàn bộ thư mục dự án bằng **IntelliJ IDEA** hoặc **Eclipse**. Chờ nó tải thư viện Maven xong, sau đó chạy file `TourBookingApplication.java`.
- **Nếu chạy bằng Terminal / Command Prompt:**
  Mở terminal, trỏ (cd) vào thư mục gốc của dự án và gõ lệnh:
  - Trên Windows: `mvnw.cmd spring-boot:run`
  - Trên Mac/Linux: `./mvnw spring-boot:run`

## 5. Trải nghiệm web
Sau khi server chạy thành công (báo `Started TourBookingApplication`), bạn mở trình duyệt và truy cập:
👉 **http://localhost:8080**
