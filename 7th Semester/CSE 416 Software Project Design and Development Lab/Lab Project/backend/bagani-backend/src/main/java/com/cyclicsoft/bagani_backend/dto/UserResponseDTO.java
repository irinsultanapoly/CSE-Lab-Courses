package com.cyclicsoft.bagani_backend.dto;

import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserResponseDTO {

  private Long id;
  private String name;
  private String email;
  private String mobile;
  private boolean activeStatus;
  private String profilePicture;
  private String address;
  private boolean isEmailVerified;
  private boolean isMobileVerified;
  private String role;
}
