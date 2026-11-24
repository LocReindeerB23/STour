package com.example.tourbooking.service;

import org.springframework.stereotype.Service;

@Service
public class EmailService {
    public void sendBookingConfirmation(String toEmail, String orderCode, String tourName) {
        // Giả lập gửi email
        System.out.println("==========================================");
        System.out.println("GỬI EMAIL XÁC NHẬN ĐẶT TOUR");
        System.out.println("Tới: " + toEmail);
        System.out.println("Mã đơn hàng: " + orderCode);
        System.out.println("Tour: " + tourName);
        System.out.println("Cảm ơn quý khách đã tin tưởng và đặt tour tại Tuấn Vi Vu!");
        System.out.println("==========================================");
    }
}
