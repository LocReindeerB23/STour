package com.example.tourbooking.repository;

import com.example.tourbooking.entity.Account;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface AccountRepository extends JpaRepository<Account, Long> {
    java.util.Optional<Account> findByEmail(String email);
    java.util.Optional<Account> findByPhone(String phone);
}
