package com.cyclicsoft.bagani_backend.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PlantUpdateRequestDTO {

  @NotBlank(message = "Name is required.")
  private String name;

  @NotBlank(message = "Species is required.")
  private String species;

  @NotBlank(message = "Description is required.")
  @Size(max = 500, message = "Description should not exceed 500 characters.")
  private String description;

  @NotBlank(message = "Image URL is required.")
  private String imageUrl;
}
