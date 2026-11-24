CREATE DATABASE IF NOT EXISTS tour_booking_db;
USE tour_booking_db;

-- Bảng Người dùng (Accounts)
CREATE TABLE IF NOT EXISTS accounts (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    phone VARCHAR(20),
    role VARCHAR(50) DEFAULT 'USER',
    status VARCHAR(50) DEFAULT 'active'
);

-- Bảng Tour
CREATE TABLE IF NOT EXISTS tours (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    category VARCHAR(255),
    status VARCHAR(50) DEFAULT 'Active',
    price_adult DOUBLE,
    price_children DOUBLE,
    stock_adult INT,
    stock_children INT,
    departure_date DATE,
    destination VARCHAR(255),
    image_url VARCHAR(255),
    itinerary TEXT,
    included_services TEXT,
    excluded_services TEXT,
    cancellation_policy TEXT
);

-- Bảng Đơn Hàng (Orders)
CREATE TABLE IF NOT EXISTS orders (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    order_code VARCHAR(50) UNIQUE,
    account_id BIGINT,
    tour_id BIGINT,
    full_name VARCHAR(255),
    email VARCHAR(255),
    phone VARCHAR(20),
    adult_tickets INT,
    children_tickets INT,
    payment_method VARCHAR(50),
    special_request TEXT,
    status VARCHAR(50) DEFAULT 'PENDING',
    sub_total DOUBLE,
    discount_amount DOUBLE,
    total DOUBLE,
    FOREIGN KEY (account_id) REFERENCES accounts(id),
    FOREIGN KEY (tour_id) REFERENCES tours(id)
);

-- Dữ liệu mẫu ban đầu (Giống với dữ liệu cũ)
INSERT INTO accounts (full_name, email, password, phone, role, status)
VALUES ('Admin', 'admin@tuanvivu.com', 'admin', '0909090909', 'ADMIN', 'active');

INSERT INTO tours (name, category, status, price_adult, price_children, stock_adult, stock_children, departure_date, destination, image_url, itinerary, included_services, excluded_services, cancellation_policy)
VALUES 
('Nha Trang Biển Gọi', 'Biển', 'Active', 5000000.0, 3000000.0, 20, 10, DATE_ADD(CURDATE(), INTERVAL 10 DAY), 'Khánh Hòa', 'https://images.unsplash.com/photo-1582650117409-a17f2ccb2b2b?q=80&w=800', 'Ngày 1: Đón khách tại sân bay Cam Ranh.\nNgày 2: Tham quan Vinpearl Land.\nNgày 3: Tắm bùn Tháp Bà và tiễn khách.', 'Vé máy bay khứ hồi\nKhách sạn 4 sao\nĂn sáng Buffet', 'Tip cho HDV\nChi phí cá nhân', 'Hủy trước 7 ngày miễn phí.'),
('Đà Lạt Mộng Mơ', 'Núi', 'Active', 4500000.0, 2500000.0, 15, 5, DATE_ADD(CURDATE(), INTERVAL 15 DAY), 'Lâm Đồng', 'https://images.unsplash.com/photo-1596752003889-49c9597792ec?q=80&w=800', 'Ngày 1: Tham quan Ga Đà Lạt.\nNgày 2: Chinh phục đỉnh Langbiang.\nNgày 3: Mua sắm chợ Đà Lạt.', 'Xe giường nằm VIP\nKhách sạn trung tâm\nCác bữa ăn theo chương trình', 'Thuế VAT\nChi phí giặt ủi', 'Hủy trước 5 ngày: Phí 50%'),
('Hạ Long Bay Nghỉ Dưỡng', 'Nghỉ dưỡng', 'Active', 6000000.0, 4000000.0, 30, 15, DATE_ADD(CURDATE(), INTERVAL 2 DAY), 'Quảng Ninh', 'https://images.unsplash.com/photo-1528181304800-259b08848526?q=80&w=800', 'Ngày 1: Nhận phòng Du thuyền 5 sao.\nNgày 2: Khám phá hang Sửng Sốt.\nNgày 3: Chèo thuyền Kayak và về lại bờ.', 'Phòng Suite trên Du thuyền\nĂn hải sản cao cấp\nHướng dẫn viên nhiệt tình', 'Đồ uống có cồn\nChi phí không có trong mục bao gồm', 'Hủy trước 10 ngày miễn phí.');
