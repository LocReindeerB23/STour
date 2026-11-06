package com.example.tourbooking;

import com.example.tourbooking.entity.Tour;
import com.example.tourbooking.service.TourService;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.time.LocalDate;

@Configuration
public class DataInitializer {

    @Bean
    public CommandLineRunner loadData(TourService tourService, com.example.tourbooking.repository.AccountRepository accountRepository) {
        return args -> {
            if (accountRepository.count() > 0) return;

            tourService.saveTour(new Tour("Nha Trang Biển Gọi", "Biển", "Active", 5000000.0, 3000000.0, 20, 10, LocalDate.now().plusDays(10), 
                "Khánh Hòa", "https://images.unsplash.com/photo-1582650117409-a17f2ccb2b2b?q=80&w=800",
                "Ngày 1: Đón khách tại sân bay Cam Ranh.\nNgày 2: Tham quan Vinpearl Land.\nNgày 3: Tắm bùn Tháp Bà và tiễn khách.",
                "Vé máy bay khứ hồi\nKhách sạn 4 sao\nĂn sáng Buffet", "Tip cho HDV\nChi phí cá nhân", "Hủy trước 7 ngày miễn phí."));
                
            tourService.saveTour(new Tour("Đà Lạt Mộng Mơ", "Núi", "Active", 4500000.0, 2500000.0, 15, 5, LocalDate.now().plusDays(15), 
                "Lâm Đồng", "https://images.unsplash.com/photo-1596752003889-49c9597792ec?q=80&w=800",
                "Ngày 1: Tham quan Ga Đà Lạt.\nNgày 2: Chinh phục đỉnh Langbiang.\nNgày 3: Mua sắm chợ Đà Lạt.",
                "Xe giường nằm VIP\nKhách sạn trung tâm\nCác bữa ăn theo chương trình", "Thuế VAT\nChi phí giặt ủi", "Hủy trước 5 ngày: Phí 50%"));
                
            tourService.saveTour(new Tour("Hạ Long Bay Nghỉ Dưỡng", "Nghỉ dưỡng", "Active", 6000000.0, 4000000.0, 30, 15, LocalDate.now().plusDays(2), 
                "Quảng Ninh", "https://images.unsplash.com/photo-1528181304800-259b08848526?q=80&w=800",
                "Ngày 1: Nhận phòng Du thuyền 5 sao.\nNgày 2: Khám phá hang Sửng Sốt.\nNgày 3: Chèo thuyền Kayak và về lại bờ.",
                "Phòng Suite trên Du thuyền\nĂn hải sản cao cấp\nHướng dẫn viên nhiệt tình", "Đồ uống có cồn\nChi phí không có trong mục bao gồm", "Hủy trước 10 ngày miễn phí."));
                
            // Create default admin account
            accountRepository.save(new com.example.tourbooking.entity.Account("Admin", "admin@tuanvivu.com", "admin", "0909090909", "ADMIN", "active"));
        };
    }
}
