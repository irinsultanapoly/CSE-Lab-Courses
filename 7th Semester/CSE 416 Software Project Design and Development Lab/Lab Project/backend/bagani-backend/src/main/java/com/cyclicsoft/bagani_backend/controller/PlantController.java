package com.cyclicsoft.bagani_backend.controller;

import com.cyclicsoft.bagani_backend.dto.*;
import com.cyclicsoft.bagani_backend.service.IPlantService;
import com.cyclicsoft.bagani_backend.util.GenericResponseUtil;
import jakarta.validation.Valid;
import lombok.AllArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/plants")
@AllArgsConstructor
public class PlantController {

  private final IPlantService plantService;

  // API for Creating a Plant
  @PostMapping
  public ResponseEntity<GenericResponse<PlantResponseDTO>> createPlant(
      @Valid @RequestBody PlantRequestDTO plantRequestDTO, @RequestParam Long userId) {
    PlantResponseDTO plantResponseDTO = plantService.createPlant(plantRequestDTO, userId);
    return GenericResponseUtil.buildResponse(true, HttpStatus.CREATED.value(), "Plant created successfully",
        "/api/v1/plants", plantResponseDTO);
  }

  // API for Updating Plant Details
  @PutMapping("/{id}")
  public ResponseEntity<GenericResponse<PlantResponseDTO>> updatePlant(
      @PathVariable Long id, @Valid @RequestBody PlantUpdateRequestDTO plantUpdateRequestDTO) {
    PlantResponseDTO plantResponseDTO = plantService.updatePlant(id, plantUpdateRequestDTO);
    return GenericResponseUtil.buildResponse(true, HttpStatus.OK.value(), "Plant updated successfully",
        "/api/v1/plants/" + id, plantResponseDTO);
  }

  // API for Deleting a Plant
  @DeleteMapping("/{id}")
  public ResponseEntity<GenericResponse<Void>> deletePlant(@PathVariable Long id) {
    plantService.deletePlant(id);
    return GenericResponseUtil.buildResponse(true, HttpStatus.NO_CONTENT.value(), "Plant deleted successfully",
        "/api/v1/plants/" + id, null);
  }

  // API for Getting a Plant by ID
  @GetMapping("/{id}")
  public ResponseEntity<GenericResponse<PlantResponseDTO>> getPlantById(@PathVariable Long id) {
    PlantResponseDTO plantResponseDTO = plantService.getPlantById(id);
    return GenericResponseUtil.buildResponse(true, HttpStatus.OK.value(), "Plant details fetched successfully",
        "/api/v1/plants/" + id, plantResponseDTO);
  }

  // API for Getting All Plants (for a specific user)
  @GetMapping("/user/{userId}")
  public ResponseEntity<GenericResponse<List<PlantResponseDTO>>> getAllPlantsByUserId(@PathVariable Long userId) {
    List<PlantResponseDTO> plants = plantService.getAllPlantsByUserId(userId);
    return GenericResponseUtil.buildResponse(true, HttpStatus.OK.value(), "Plants fetched successfully",
        "/api/v1/plants/user/" + userId, plants);
  }

  // API for Searching Plants by Criteria (e.g., name, species)
  @GetMapping("/search")
  public ResponseEntity<GenericResponse<List<PlantResponseDTO>>> searchPlants(
      @RequestParam(required = false) String name, @RequestParam(required = false) String species) {
    List<PlantResponseDTO> plants = plantService.searchPlants(name, species);
    return GenericResponseUtil.buildResponse(true, HttpStatus.OK.value(), "Search completed",
        "/api/v1/plants/search", plants);
  }
}
