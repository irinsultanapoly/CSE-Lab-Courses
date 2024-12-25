package com.cyclicsoft.bagani_backend.repository;

import com.cyclicsoft.bagani_backend.entity.Plant;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PlantRepository extends JpaRepository<Plant, Long> {

  // Find all plants by a specific user
  List<Plant> findAllByUser_Id(Long userId);

  // Find plants with names containing a specific substring
  List<Plant> findByNameContainingIgnoreCase(String name);

  // Find plants with species containing a specific substring
  List<Plant> findBySpeciesContainingIgnoreCase(String species);

  // Find plants with both name and species containing specific substrings
  List<Plant> findByNameContainingIgnoreCaseAndSpeciesContainingIgnoreCase(String name, String species);

  // Find plants by their status
  List<Plant> findByStatus(Plant.PlantStatus status);

  // Find plants by user and status
  List<Plant> findByUser_IdAndStatus(Long userId, Plant.PlantStatus status);
}
