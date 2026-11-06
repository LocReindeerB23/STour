package com.example.tourbooking.repository;

import com.example.tourbooking.entity.Order;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface OrderRepository extends JpaRepository<Order, Long> {
    List<Order> findByAccountIdOrderByIdDesc(Long accountId);
    java.util.Optional<Order> findByOrderCode(String orderCode);
}
