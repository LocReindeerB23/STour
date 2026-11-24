package com.example.tourbooking.config;

import com.example.tourbooking.entity.Account;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

@Component
public class AdminInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession();
        Account user = (Account) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect("/login?error=" + java.net.URLEncoder.encode("Yêu cầu đăng nhập", "UTF-8"));
            return false;
        }
        
        if (!"admin".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect("/login?error=" + java.net.URLEncoder.encode("Từ chối truy cập! Yêu cầu tài khoản Admin.", "UTF-8"));
            return false;
        }
        return true;
    }
}
