package com.example.tourbooking.controller;

import com.example.tourbooking.dto.OrderDTO;
import com.example.tourbooking.entity.Order;
import com.example.tourbooking.entity.Tour;
import com.example.tourbooking.service.EmailService;
import com.example.tourbooking.service.OrderService;
import com.example.tourbooking.service.TourService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import jakarta.validation.Valid;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.UUID;

@Controller
@RequestMapping("/orders")
public class OrderController {

    @Autowired
    private OrderService orderService;

    @Autowired
    private TourService tourService;

    @Autowired
    private EmailService emailService;

    @GetMapping("/new")
    public String showOrderForm(@RequestParam("tourId") Long tourId, Model model) {
        Tour tour = tourService.getTourById(tourId).orElseThrow(() -> new IllegalArgumentException("Invalid tour Id:" + tourId));
        
        OrderDTO orderDTO = new OrderDTO();
        orderDTO.setTourId(tourId);
        orderDTO.setAdultTickets(1);
        orderDTO.setChildrenTickets(0);
        
        model.addAttribute("tour", tour);
        model.addAttribute("orderDTO", orderDTO);
        return "order-form";
    }

    @PostMapping
    public String submitOrder(
            @Valid @ModelAttribute("orderDTO") OrderDTO orderDTO,
            BindingResult bindingResult,
            jakarta.servlet.http.HttpSession session,
            Model model) {

        Tour tour = tourService.getTourById(orderDTO.getTourId())
            .orElseThrow(() -> new IllegalArgumentException("Invalid tour Id:" + orderDTO.getTourId()));

        if (bindingResult.hasErrors()) {
            model.addAttribute("tour", tour);
            return "order-form";
        }

        if (orderDTO.getAdultTickets() <= 0 && orderDTO.getChildrenTickets() <= 0) {
            model.addAttribute("error", "Vui lòng chọn ít nhất 1 vé để đặt tour.");
            model.addAttribute("tour", tour);
            return "order-form";
        }

        // BVA 1: Ngày khởi hành phải cách ngày đặt ít nhất 2 ngày (Sửa bug: từ <= thành < 2)
        long daysBetween = ChronoUnit.DAYS.between(LocalDate.now(), tour.getDepartureDate());
        if (daysBetween < 2) {
            model.addAttribute("error", "Chỉ được đặt tour trước ít nhất 2 ngày khởi hành.");
            model.addAttribute("tour", tour);
            return "order-form";
        }

        // BVA 2: Số vé không vượt quá stock (Sửa bug: từ >= thành >)
        // if (orderDTO.getAdultTickets() > tour.getStockAdult()) {
        //     model.addAttribute("error", "Số lượng vé người lớn yêu cầu vượt quá số chỗ trống.");
        //     model.addAttribute("tour", tour);
        //     return "order-form";
        // }
        
        // if (orderDTO.getChildrenTickets() > tour.getStockChildren()) {
        //     model.addAttribute("error", "Số lượng vé trẻ em yêu cầu vượt quá số chỗ trống.");
        //     model.addAttribute("tour", tour);
        //     return "order-form";
        // }

        if (orderDTO.getPromoCode() != null && !orderDTO.getPromoCode().trim().isEmpty()) {
            String code = orderDTO.getPromoCode().trim().toUpperCase();
            if (!OrderService.PROMOS.containsKey(code)) {
                model.addAttribute("error", "Mã giảm giá không hợp lệ hoặc đã hết hạn.");
                model.addAttribute("tour", tour);
                return "order-form";
            }
        }

        Order order = new Order();
        order.setOrderCode("ORD-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase());
        order.setFullName(orderDTO.getFullName());
        order.setEmail(orderDTO.getEmail());
        order.setPhone(orderDTO.getPhone());
        order.setPaymentMethod(orderDTO.getPaymentMethod());
        order.setSpecialRequest(orderDTO.getSpecialRequest());
        if (orderDTO.getPromoCode() != null) {
            order.setPromoCode(orderDTO.getPromoCode().trim().toUpperCase());
        }
        order.setTour(tour);
        order.setAdultTickets(orderDTO.getAdultTickets());
        order.setChildrenTickets(orderDTO.getChildrenTickets());
        order.setStatus("PENDING");

        com.example.tourbooking.entity.Account user = (com.example.tourbooking.entity.Account) session.getAttribute("user");
        if (user != null) {
            order.setAccount(user);
        }

        orderService.saveOrder(order, tour);
        emailService.sendBookingConfirmation(order.getEmail(), order.getOrderCode(), tour.getName());

        model.addAttribute("order", order);
        
        if ("Thanh toán qua Stripe (Visa/MasterCard)".equals(order.getPaymentMethod())) {
            return "redirect:/api/payment/create-checkout-session?orderCode=" + order.getOrderCode();
        }

        return "success";
    }
}
