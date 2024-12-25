package com.cyclicsoft.bagani_backend.dto;

import lombok.*;

import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PlantResponseDTO {

  private Long id;

  private String name; // Name of the plant

  private String species; // Species or type of the plant

  private String description; // Description of the plant

  private String imageUrl; // URL to the plant's image

  private Long userId; // Plant owner (user)

  private String status; // Current status of the plant (e.g., available, sold, reserved)

  private LocalDateTime createdAt; // Timestamp of when the plant was added

  private LocalDateTime updatedAt; // Timestamp of when the plant details were last updated
}
