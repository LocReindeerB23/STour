package com.example.tourbooking.controller;

import com.example.tourbooking.entity.Account;
import com.example.tourbooking.entity.Order;
import com.example.tourbooking.service.OrderService;
import com.example.tourbooking.service.AccountService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
public class UserController {

    @Autowired
    private OrderService orderService;

    @Autowired
    private AccountService accountService;

    @GetMapping("/my-bookings")
    public String myBookings(HttpSession session, Model model) {
        Account user = (Account) session.getAttribute("user");
        List<Order> orders = orderService.getOrdersByAccountId(user.getId());
        model.addAttribute("orders", orders);
        model.addAttribute("user", user);
        return "my-bookings";
    }

    @PostMapping("/my-bookings/{id}/cancel")
    public String cancelBooking(@PathVariable("id") Long orderId, HttpSession session) {
        Account user = (Account) session.getAttribute("user");
        orderService.cancelOrder(orderId, user.getId());
        return "redirect:/my-bookings";
    }

    @GetMapping("/profile")
    public String profile(HttpSession session, Model model) {
        Account user = (Account) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        model.addAttribute("user", user);
        return "profile";
    }

    @PostMapping("/profile")
    public String updateProfile(
            @RequestParam("fullName") String fullName,
            @RequestParam("phone") String phone,
            @RequestParam(value = "password", required = false) String password,
            HttpSession session,
            Model model) {
        Account user = (Account) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        try {
            Account updatedAccount = accountService.updateProfile(user.getId(), fullName, phone, password);
            session.setAttribute("user", updatedAccount);
            model.addAttribute("user", updatedAccount);
            model.addAttribute("successMessage", "Cập nhật thông tin thành công!");
        } catch (Exception e) {
            model.addAttribute("errorMessage", "Cập nhật thất bại: " + e.getMessage());
            model.addAttribute("user", user);
        }
        return "profile";
    }
}
