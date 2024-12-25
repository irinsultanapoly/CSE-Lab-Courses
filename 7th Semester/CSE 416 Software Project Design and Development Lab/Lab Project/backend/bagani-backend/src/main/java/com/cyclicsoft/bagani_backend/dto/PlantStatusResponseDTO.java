package com.cyclicsoft.bagani_backend.dto;

import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PlantStatusResponseDTO {

  private Long id;
  private String status; // Active, Sold, etc.
  private String message; // Message to show about the status change (e.g., "Plant sold successfully")
}
