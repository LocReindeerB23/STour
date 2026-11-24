package com.example.tourbooking.entity;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "tours")
public class Tour {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;
    private String category;
    private String status;
    private String destination;
    private String imageUrl;
    
    @Column(columnDefinition = "TEXT")
    private String itinerary;
    
    @Column(columnDefinition = "TEXT")
    private String includedServices;
    
    @Column(columnDefinition = "TEXT")
    private String excludedServices;
    
    @Column(columnDefinition = "TEXT")
    private String cancellationPolicy;

    private Double priceAdult;
    private Double priceChildren;
    
    private Integer stockAdult;
    private Integer stockChildren;
    
    private LocalDate departureDate;

    public Tour() {}

    public Tour(String name, String category, String status, Double priceAdult, Double priceChildren, Integer stockAdult, Integer stockChildren, LocalDate departureDate, String destination, String imageUrl, String itinerary, String includedServices, String excludedServices, String cancellationPolicy) {
        this.name = name;
        this.category = category;
        this.status = status;
        this.priceAdult = priceAdult;
        this.priceChildren = priceChildren;
        this.stockAdult = stockAdult;
        this.stockChildren = stockChildren;
        this.departureDate = departureDate;
        this.destination = destination;
        this.imageUrl = imageUrl;
        this.itinerary = itinerary;
        this.includedServices = includedServices;
        this.excludedServices = excludedServices;
        this.cancellationPolicy = cancellationPolicy;
    }
    
    public Tour(String name, String category, String status, Double priceAdult, Double priceChildren, Integer stockAdult, Integer stockChildren, LocalDate departureDate) {
        this(name, category, status, priceAdult, priceChildren, stockAdult, stockChildren, departureDate, null, null, null, null, null, null);
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getDestination() { return destination; }
    public void setDestination(String destination) { this.destination = destination; }

    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }

    public String getItinerary() { return itinerary; }
    public void setItinerary(String itinerary) { this.itinerary = itinerary; }

    public String getIncludedServices() { return includedServices; }
    public void setIncludedServices(String includedServices) { this.includedServices = includedServices; }

    public String getExcludedServices() { return excludedServices; }
    public void setExcludedServices(String excludedServices) { this.excludedServices = excludedServices; }

    public String getCancellationPolicy() { return cancellationPolicy; }
    public void setCancellationPolicy(String cancellationPolicy) { this.cancellationPolicy = cancellationPolicy; }

    public Double getPriceAdult() { return priceAdult; }
    public void setPriceAdult(Double priceAdult) { this.priceAdult = priceAdult; }

    public Double getPriceChildren() { return priceChildren; }
    public void setPriceChildren(Double priceChildren) { this.priceChildren = priceChildren; }

    public Integer getStockAdult() { return stockAdult; }
    public void setStockAdult(Integer stockAdult) { this.stockAdult = stockAdult; }

    public Integer getStockChildren() { return stockChildren; }
    public void setStockChildren(Integer stockChildren) { this.stockChildren = stockChildren; }

    public LocalDate getDepartureDate() { return departureDate; }
    public void setDepartureDate(LocalDate departureDate) { this.departureDate = departureDate; }
}
