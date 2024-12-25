package com.cyclicsoft.bagani_backend.dto;

import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PlantOwnerDTO {

  private Long plantId;
  private Long userId; // User who owns the plant
  private String ownerName; // Owner's name
}
