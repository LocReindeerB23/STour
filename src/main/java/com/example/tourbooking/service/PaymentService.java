package com.example.tourbooking.service;

import com.example.tourbooking.entity.Order;
import com.stripe.Stripe;
import com.stripe.exception.StripeException;
import com.stripe.model.checkout.Session;
import com.stripe.param.checkout.SessionCreateParams;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import jakarta.annotation.PostConstruct;

@Service
public class PaymentService {

    @Value("${stripe.api.key}")
    private String stripeApiKey;

    @Value("${app.base.url}")
    private String baseUrl;

    @PostConstruct
    public void init() {
        Stripe.apiKey = stripeApiKey;
    }

    public String createCheckoutSession(Order order) throws StripeException {
        if (stripeApiKey == null || stripeApiKey.contains("...")) {
            // Chế độ giả lập (Mock Mode) khi chưa có API Key thật
            return baseUrl + "/payment/mock?orderCode=" + order.getOrderCode();
        }

        // Stripe VND is a zero-decimal currency, so we use the exact amount without multiplying by 100
        long amountInVnd = Math.round(order.getTotal() != null ? order.getTotal() : 0.0);
        if(amountInVnd == 0) {
            amountInVnd = 100000; // default 100,000 VND if not set
        }

        SessionCreateParams params = SessionCreateParams.builder()
                .setMode(SessionCreateParams.Mode.PAYMENT)
                // Redirect URLs
                .setSuccessUrl(baseUrl + "/payment/success?session_id={CHECKOUT_SESSION_ID}")
                .setCancelUrl(baseUrl + "/payment/cancel")
                // Pass orderCode as clientReferenceId
                .setClientReferenceId(order.getOrderCode())
                .addLineItem(
                        SessionCreateParams.LineItem.builder()
                                .setQuantity(1L)
                                .setPriceData(
                                        SessionCreateParams.LineItem.PriceData.builder()
                                                .setCurrency("vnd")
                                                .setUnitAmount(amountInVnd)
                                                .setProductData(
                                                        SessionCreateParams.LineItem.PriceData.ProductData.builder()
                                                                .setName("Tour Booking: " + (order.getTour() != null ? order.getTour().getName() : order.getOrderCode()))
                                                                .build())
                                                .build())
                                .build())
                .build();

        Session session = Session.create(params);
        return session.getUrl();
    }
}
