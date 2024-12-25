package com.cyclicsoft.bagani_backend.dto;

import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PlantSearchDTO {

  private String name;
  private String species;
  private Long userId; // Optional: Search by user (owner) ID
}
