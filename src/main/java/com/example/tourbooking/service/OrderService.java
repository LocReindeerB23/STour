package com.example.tourbooking.service;

import com.example.tourbooking.entity.Order;
import com.example.tourbooking.entity.Tour;
import com.example.tourbooking.repository.OrderRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
import java.util.HashMap;

@Service
public class OrderService {
    @Autowired
    private OrderRepository orderRepository;

    public static final Map<String, Double> PROMOS = new HashMap<>();
    static {
        PROMOS.put("SUMMER20", 0.20);
        PROMOS.put("SALE10", 0.10);
        PROMOS.put("TEST50", 0.50);
        PROMOS.put("TET2020", 0.15); // Đã hết hạn nhưng chưa validate logic thời gian
    }

    public List<Order> getAllOrders() {
        return orderRepository.findAll();
    }

    public Order saveOrder(Order order, Tour tour) {
        // Tính toán đúng giá tiền (Không còn bug)
        double subTotal = (tour.getPriceAdult() * order.getAdultTickets()) + (tour.getPriceChildren() * order.getChildrenTickets());
        order.setSubTotal(subTotal);

        // Điều kiện giảm giá đúng: Yêu cầu Tổng số vé >= 5 thì giảm 10%
        double discount = 0;
        int totalTickets = order.getAdultTickets() + order.getChildrenTickets();
        if (totalTickets >= 5) {
            discount = subTotal * 0.1;
        }

        if (order.getPromoCode() != null && !order.getPromoCode().trim().isEmpty()) {
            String code = order.getPromoCode().trim().toUpperCase();
            if (PROMOS.containsKey(code)) {
                discount += subTotal * PROMOS.get(code);
            }
        }

        if (discount > subTotal) discount = subTotal;
        order.setDiscountAmount(discount);

        double finalTotal = subTotal - discount; 
        order.setTotal(finalTotal);

        return orderRepository.save(order);
    }

    public Order getOrderById(Long id) {
        return orderRepository.findById(id).orElse(null);
    }

    public void updateOrderStatus(Long orderId, String status) {
        Order order = orderRepository.findById(orderId).orElse(null);
        if (order != null) {
            order.setStatus(status);
            orderRepository.save(order);
        }
    }

    public List<Order> getOrdersByAccountId(Long accountId) {
        return orderRepository.findByAccountIdOrderByIdDesc(accountId);
    }

    public boolean cancelOrder(Long orderId, Long accountId) {
        Order order = orderRepository.findById(orderId).orElse(null);
        if (order != null && order.getAccount() != null 
            && order.getAccount().getId().equals(accountId) 
            && "PENDING".equals(order.getStatus())) {
            order.setStatus("CANCELED");
            orderRepository.save(order);
            return true;
        }
        return false;
    }
}
