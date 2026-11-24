package com.example.tourbooking.repository;

import com.example.tourbooking.entity.Tour;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import java.util.List;

@Repository
public interface TourRepository extends JpaRepository<Tour, Long> {
    
    @Query("SELECT t FROM Tour t WHERE t.status != 'Inactive' AND " +
           "(:destination IS NULL OR LOWER(t.destination) LIKE LOWER(CONCAT('%', :destination, '%'))) AND " +
           "(:category IS NULL OR :category = '' OR t.category = :category) AND " +
           "(:minPrice IS NULL OR t.priceAdult >= :minPrice) AND " +
           "(:maxPrice IS NULL OR t.priceAdult <= :maxPrice)")
    List<Tour> searchTours(@Param("destination") String destination, 
                           @Param("category") String category, 
                           @Param("minPrice") Double minPrice, 
                           @Param("maxPrice") Double maxPrice);

    List<Tour> findByStatusNot(String status);
}
