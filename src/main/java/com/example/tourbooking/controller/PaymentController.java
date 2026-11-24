package com.example.tourbooking.controller;

import com.example.tourbooking.entity.Order;
import com.example.tourbooking.repository.OrderRepository;
import com.example.tourbooking.service.PaymentService;
import com.stripe.exception.SignatureVerificationException;
import com.stripe.model.Event;
import com.stripe.model.checkout.Session;
import com.stripe.net.Webhook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.view.RedirectView;

import java.util.Optional;

@Controller
@RequestMapping("/api/payment")
public class PaymentController {

    @Autowired
    private PaymentService paymentService;

    @Autowired
    private OrderRepository orderRepository;

    @Value("${stripe.webhook.secret}")
    private String endpointSecret;

    @GetMapping("/create-checkout-session")
    public RedirectView createCheckoutSession(@RequestParam String orderCode) {
        try {
            Optional<Order> orderOpt = orderRepository.findByOrderCode(orderCode);
            if (orderOpt.isEmpty()) {
                return new RedirectView("/payment/error");
            }

            Order order = orderOpt.get();
            String checkoutUrl = paymentService.createCheckoutSession(order);
            return new RedirectView(checkoutUrl);
        } catch (Exception e) {
            e.printStackTrace();
            return new RedirectView("/payment/error");
        }
    }

    @PostMapping("/webhook")
    public ResponseEntity<String> handleStripeWebhook(@RequestBody String payload, @RequestHeader("Stripe-Signature") String sigHeader) {
        Event event = null;

        try {
            event = Webhook.constructEvent(payload, sigHeader, endpointSecret);
        } catch (SignatureVerificationException e) {
            System.err.println("Webhook signature verification failed.");
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("");
        } catch (Exception e) {
            System.err.println("Webhook processing failed.");
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("");
        }

        // Handle the checkout.session.completed event
        if ("checkout.session.completed".equals(event.getType())) {
            Session session = (Session) event.getDataObjectDeserializer().getObject().orElse(null);
            
            if (session != null) {
                String orderCode = session.getClientReferenceId();
                if (orderCode != null) {
                    Optional<Order> orderOpt = orderRepository.findByOrderCode(orderCode);
                    if (orderOpt.isPresent()) {
                        Order order = orderOpt.get();
                        // Update order status to PAID
                        order.setStatus("PAID");
                        orderRepository.save(order);
                        System.out.println("Order " + orderCode + " successfully marked as PAID");
                    }
                }
            }
        }

        return ResponseEntity.ok("");
    }
}
