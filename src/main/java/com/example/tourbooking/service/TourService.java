package com.example.tourbooking.service;

import com.example.tourbooking.entity.Tour;
import com.example.tourbooking.repository.TourRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class TourService {
    @Autowired
    private TourRepository tourRepository;

    public List<Tour> getAllTours() {
        return tourRepository.findAll();
    }

    public List<Tour> getAllActiveTours() {
        return tourRepository.findByStatusNot("Inactive");
    }

    public Optional<Tour> getTourById(Long id) {
        return tourRepository.findById(id);
    }

    public Tour saveTour(Tour tour) {
        return tourRepository.save(tour);
    }

    public List<Tour> searchTours(String destination, String category, Double minPrice, Double maxPrice) {
        return tourRepository.searchTours(destination, category, minPrice, maxPrice);
    }

    public void deleteTour(Long id) {
        Optional<Tour> tourOptional = tourRepository.findById(id);
        if (tourOptional.isPresent()) {
            Tour tour = tourOptional.get();
            tour.setStatus("Inactive");
            tourRepository.save(tour);
        }
    }
}
