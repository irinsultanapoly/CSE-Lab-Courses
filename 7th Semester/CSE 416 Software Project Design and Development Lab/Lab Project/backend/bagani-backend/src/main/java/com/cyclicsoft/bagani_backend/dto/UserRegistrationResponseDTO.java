package com.cyclicsoft.bagani_backend.dto;

import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserRegistrationResponseDTO {

  private Long id;
  private String name;
  private String email;
  private String mobile;
  private boolean isEmailVerified;
  private boolean isMobileVerified;
  private String role;
  private boolean activeStatus;
}
