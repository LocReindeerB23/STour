package com.example.tourbooking.controller;

import com.example.tourbooking.service.TourService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class TourController {

    @Autowired
    private TourService tourService;

    @GetMapping("/tours")
    public String listTours(
            @org.springframework.web.bind.annotation.RequestParam(required = false) String destination,
            @org.springframework.web.bind.annotation.RequestParam(required = false) String category,
            @org.springframework.web.bind.annotation.RequestParam(required = false) Double minPrice,
            @org.springframework.web.bind.annotation.RequestParam(required = false) Double maxPrice,
            Model model) {
        
        model.addAttribute("tours", tourService.searchTours(destination, category, minPrice, maxPrice));
        model.addAttribute("destination", destination);
        model.addAttribute("category", category);
        model.addAttribute("minPrice", minPrice);
        model.addAttribute("maxPrice", maxPrice);
        
        return "tours";
    }

    @GetMapping("/tours/{id}")
    public String tourDetail(@org.springframework.web.bind.annotation.PathVariable Long id, Model model) {
        com.example.tourbooking.entity.Tour tour = tourService.getTourById(id)
            .orElseThrow(() -> new IllegalArgumentException("Invalid tour Id: " + id));
        model.addAttribute("tour", tour);
        return "tour-detail";
    }
}
