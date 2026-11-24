package com.example.tourbooking.service;

import com.example.tourbooking.entity.Account;
import com.example.tourbooking.repository.AccountRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class AccountService {

    @Autowired
    private AccountRepository accountRepository;

    private final BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder(10);

    public Account register(Account newAccount) {
        // Validate Họ và Tên (TC-02, TC-06)
        if (newAccount.getFullName() == null || newAccount.getFullName().trim().isEmpty()) {
            throw new RuntimeException("Họ tên không được để trống.");
        }
        if (!newAccount.getFullName().matches("^[a-zA-ZÀ-ỹ\\s]+$")) {
            throw new RuntimeException("Họ tên chỉ được chứa chữ cái.");
        }

        // Validate Email (TC-03, TC-07)
        if (newAccount.getEmail() == null || newAccount.getEmail().trim().isEmpty()) {
            throw new RuntimeException("Email không được để trống.");
        }
        // Cố tình bỏ validate định dạng email (Tạo lỗi cho TC)
        // if (!newAccount.getEmail().matches("^[a-zA-Z0-9._%+\\-]+@[a-zA-Z0-9.\\-]+\\.[a-zA-Z]{2,}$")) {
        //     throw new RuntimeException("Email không hợp lệ.");
        // }

        // Validate Số điện thoại (TC-04, TC-10)
        if (newAccount.getPhone() == null || newAccount.getPhone().trim().isEmpty()) {
            throw new RuntimeException("Số điện thoại không được để trống.");
        }
        if (!newAccount.getPhone().matches("^[0-9]{10}$")) {
            throw new RuntimeException("Số điện thoại không hợp lệ.");
        }

        // Validate Mật khẩu (TC-05)
        // Lưu ý: Cố tình không validate độ dài (TC-11) và khoảng trắng (TC-12) theo yêu cầu
        if (newAccount.getPassword() == null || newAccount.getPassword().isEmpty()) {
            throw new RuntimeException("Mật khẩu không được để trống.");
        }

        // Cố tình bỏ qua kiểm tra Email đã tồn tại theo yêu cầu (Tạo lỗi cho TC-08)
        // Optional<Account> existingAccount = accountRepository.findByEmail(newAccount.getEmail());
        // if (existingAccount.isPresent()) {
        //     throw new RuntimeException("Email đã tồn tại.");
        // }
        
        Optional<Account> existingPhone = accountRepository.findByPhone(newAccount.getPhone());
        if (existingPhone.isPresent()) {
            throw new RuntimeException("Số điện thoại đã được sử dụng.");
        }
        
        newAccount.setRole("user");
        newAccount.setStatus("active");
        
        if (newAccount.getPassword() != null) {
            String hashedPassword = passwordEncoder.encode(newAccount.getPassword());
            newAccount.setPassword(hashedPassword);
        }
        
        return accountRepository.save(newAccount);
    }

    public Account login(String email, String password) {
        Optional<Account> accountOpt = accountRepository.findByEmail(email);
        if (accountOpt.isPresent()) {
            Account account = accountOpt.get();
            if (passwordEncoder.matches(password, account.getPassword())) {
                return account;
            } else if (account.getPassword() != null && account.getPassword().equals(password)) {
                return account;
            }
        }
        throw new IllegalArgumentException("Email hoặc mật khẩu không chính xác");
    }

    public Account updateProfile(Long id, String fullName, String phone, String password) {
        Optional<Account> accountOpt = accountRepository.findById(id);
        if (accountOpt.isPresent()) {
            Account account = accountOpt.get();
            account.setFullName(fullName);
            account.setPhone(phone);
            if (password != null && !password.trim().isEmpty()) {
                account.setPassword(passwordEncoder.encode(password));
            }
            return accountRepository.save(account);
        }
        throw new IllegalArgumentException("Không tìm thấy tài khoản!");
    }
}
