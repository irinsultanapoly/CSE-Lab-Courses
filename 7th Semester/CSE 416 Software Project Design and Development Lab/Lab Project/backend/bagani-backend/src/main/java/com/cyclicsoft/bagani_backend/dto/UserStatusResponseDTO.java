package com.cyclicsoft.bagani_backend.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserStatusResponseDTO {

  private Long id; // User ID
  private boolean activeStatus; // Account active or deactivated status
  private boolean isEmailVerified; // Email verification status
  private boolean isMobileVerified;// Mobile verification status
}
