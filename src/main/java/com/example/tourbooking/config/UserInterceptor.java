package com.example.tourbooking.config;

import com.example.tourbooking.entity.Account;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

@Component
public class UserInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession();
        Account user = (Account) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect("/login?error=" + java.net.URLEncoder.encode("Vui lòng đăng nhập để tiếp tục", "UTF-8"));
            return false;
        }
        return true;
    }
}
