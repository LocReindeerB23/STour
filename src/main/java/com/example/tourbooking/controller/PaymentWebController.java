package com.example.tourbooking.controller;

import com.example.tourbooking.entity.Order;
import com.example.tourbooking.repository.OrderRepository;
import com.stripe.exception.StripeException;
import com.stripe.model.checkout.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Optional;

@Controller
@RequestMapping("/payment")
public class PaymentWebController {

    @Autowired
    private OrderRepository orderRepository;

    @GetMapping("/success")
    public String paymentSuccess(@RequestParam(name = "session_id", required = false) String sessionId, 
                                 @RequestParam(name = "orderCode", required = false) String orderCode,
                                 Model model) {
        if (sessionId != null && !sessionId.isEmpty()) {
            try {
                // Fetch the session from Stripe
                Session session = Session.retrieve(sessionId);
                String clientRefId = session.getClientReferenceId();
                
                if (clientRefId != null) {
                    return processSuccess(clientRefId, model);
                }
            } catch (StripeException e) {
                e.printStackTrace();
                return "payment-error";
            }
        } else if (orderCode != null && !orderCode.isEmpty()) {
            // Mock mode success
            return processSuccess(orderCode, model);
        }
        
        return "payment-error";
    }

    private String processSuccess(String orderCode, Model model) {
        Optional<Order> orderOpt = orderRepository.findByOrderCode(orderCode);
        if (orderOpt.isPresent()) {
            Order order = orderOpt.get();
            // Automatically set status to PAID if it's mock mode or if webhook hasn't processed it yet
            if (!"PAID".equals(order.getStatus())) {
                order.setStatus("PAID");
                orderRepository.save(order);
            }
            model.addAttribute("order", order);
            return "success";
        }
        return "payment-error";
    }

    @GetMapping("/mock")
    public String paymentMock(@RequestParam("orderCode") String orderCode, Model model) {
        model.addAttribute("orderCode", orderCode);
        return "payment-mock";
    }

    @GetMapping("/cancel")
    public String paymentCancel() {
        return "payment-cancel";
    }

    @GetMapping("/error")
    public String paymentError() {
        return "payment-error";
    }
}
