package com.example.tourbooking.controller;

import com.example.tourbooking.entity.Order;
import com.example.tourbooking.entity.Tour;
import com.example.tourbooking.service.OrderService;
import com.example.tourbooking.service.CloudinaryService;
import com.example.tourbooking.service.TourService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private OrderService orderService;

    @Autowired
    private TourService tourService;

    @Autowired
    private CloudinaryService cloudinaryService;

    @GetMapping
    public String dashboard(Model model) {
        List<Order> orders = orderService.getAllOrders();
        
        long totalOrders = orders.size();
        long pendingOrders = orders.stream().filter(o -> "PENDING".equals(o.getStatus())).count();
        double totalRevenue = orders.stream()
            .filter(o -> "CONFIRMED".equals(o.getStatus()) || "PAID".equals(o.getStatus()))
            .mapToDouble(Order::getTotal)
            .sum();
            
        java.util.Map<String, Double> revenueByTour = orders.stream()
            .filter(o -> "CONFIRMED".equals(o.getStatus()) || "PAID".equals(o.getStatus()))
            .collect(Collectors.groupingBy(
                o -> o.getTour() != null ? o.getTour().getName() : "Khác",
                Collectors.summingDouble(o -> o.getTotal() != null ? o.getTotal() : 0.0)
            ));

        model.addAttribute("totalOrders", totalOrders);
        model.addAttribute("pendingOrders", pendingOrders);
        model.addAttribute("totalRevenue", totalRevenue);
        model.addAttribute("totalTours", tourService.getAllTours().size());
        model.addAttribute("revenueByTour", revenueByTour);
        
        List<Order> sortedOrders = orders.stream()
            .sorted((o1, o2) -> o2.getId().compareTo(o1.getId()))
            .collect(Collectors.toList());
            
        List<Order> recentOrders = sortedOrders.size() > 5 ? sortedOrders.subList(0, 5) : sortedOrders;
        model.addAttribute("recentOrders", recentOrders);
        
        return "admin/dashboard";
    }

    @GetMapping("/orders")
    public String listOrders(Model model) {
        List<Order> orders = orderService.getAllOrders();
        List<Order> sortedOrders = orders.stream()
            .sorted((o1, o2) -> o2.getId().compareTo(o1.getId()))
            .collect(Collectors.toList());
            
        model.addAttribute("orders", sortedOrders);
        return "admin/orders";
    }

    @PostMapping("/orders/{id}/status")
    public String updateOrderStatus(@PathVariable("id") Long id, @RequestParam("status") String status) {
        orderService.updateOrderStatus(id, status);
        return "redirect:/admin/orders";
    }

    // --- Tour Management CRUD ---

    @GetMapping("/tours")
    public String listTours(Model model) {
        List<Tour> tours = tourService.getAllTours();
        model.addAttribute("tours", tours);
        return "admin/tours";
    }

    @GetMapping("/tours/new")
    public String showCreateTourForm(Model model) {
        Tour tour = new Tour();
        tour.setStatus("Active"); // default status
        model.addAttribute("tour", tour);
        return "admin/tour-form";
    }

    @PostMapping("/tours")
    public String saveTour(@ModelAttribute("tour") Tour tour,
                           @RequestParam(value = "imageFile", required = false) MultipartFile imageFile) throws IOException {
        if (imageFile != null && !imageFile.isEmpty()) {
            String imageUrl = cloudinaryService.upload(imageFile);
            tour.setImageUrl(imageUrl);
        }
        tourService.saveTour(tour);
        return "redirect:/admin/tours";
    }

    @GetMapping("/tours/edit/{id}")
    public String showEditTourForm(@PathVariable("id") Long id, Model model) {
        Tour tour = tourService.getTourById(id).orElseThrow(() -> new IllegalArgumentException("Invalid tour Id:" + id));
        model.addAttribute("tour", tour);
        return "admin/tour-form";
    }

    @PostMapping("/tours/edit/{id}")
    public String updateTour(@PathVariable("id") Long id,
                             @ModelAttribute("tour") Tour tourDetails,
                             @RequestParam(value = "imageFile", required = false) MultipartFile imageFile) throws IOException {
        Tour tour = tourService.getTourById(id).orElseThrow(() -> new IllegalArgumentException("Invalid tour Id:" + id));
        
        tour.setName(tourDetails.getName());
        tour.setCategory(tourDetails.getCategory());
        tour.setStatus(tourDetails.getStatus());
        tour.setDestination(tourDetails.getDestination());
        tour.setItinerary(tourDetails.getItinerary());
        tour.setIncludedServices(tourDetails.getIncludedServices());
        tour.setExcludedServices(tourDetails.getExcludedServices());
        tour.setCancellationPolicy(tourDetails.getCancellationPolicy());
        tour.setPriceAdult(tourDetails.getPriceAdult());
        tour.setPriceChildren(tourDetails.getPriceChildren());
        tour.setStockAdult(tourDetails.getStockAdult());
        tour.setStockChildren(tourDetails.getStockChildren());
        tour.setDepartureDate(tourDetails.getDepartureDate());

        // Upload new image if provided, otherwise keep the existing one
        if (imageFile != null && !imageFile.isEmpty()) {
            String imageUrl = cloudinaryService.upload(imageFile);
            tour.setImageUrl(imageUrl);
        }
        // If no new file is uploaded, the existing imageUrl in the tour entity remains unchanged

        tourService.saveTour(tour);
        return "redirect:/admin/tours";
    }

    @PostMapping("/tours/delete/{id}")
    public String deleteTour(@PathVariable("id") Long id) {
        tourService.deleteTour(id);
        return "redirect:/admin/tours";
    }
}
