package com.cyclicsoft.bagani_backend.dto;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserCreateRequestDTO {

  @NotBlank(message = "Name is required.")
  private String name;

  @NotBlank(message = "Email is required.")
  @Email(message = "Invalid email format.")
  private String email;

  @Size(min = 8, message = "Password must be at least 8 characters long.")
  @NotBlank(message = "Password is required.")
  private String password;

  private String role; // USER or ADMIN
  private boolean activeStatus;
}
