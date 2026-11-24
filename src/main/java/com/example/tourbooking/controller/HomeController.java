package com.example.tourbooking.controller;

import com.example.tourbooking.service.TourService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    @Autowired
    private TourService tourService;

    @GetMapping("/")
    public String index(Model model) {
        java.util.List<com.example.tourbooking.entity.Tour> allTours = tourService.getAllActiveTours();
        // Lấy 6 tour mới nhất (đảo ngược list và limit)
        java.util.Collections.reverse(allTours);
        java.util.List<com.example.tourbooking.entity.Tour> hotTours = allTours.stream().limit(6).collect(java.util.stream.Collectors.toList());
        model.addAttribute("hotTours", hotTours);
        return "index";
    }
}
