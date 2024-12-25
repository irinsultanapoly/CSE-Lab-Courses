package com.cyclicsoft.bagani_backend.dto;

import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserLoginResponseDTO {

  private String token; // JWT or session token
  private Long userId;
  private String role;
  private boolean activeStatus;
}
