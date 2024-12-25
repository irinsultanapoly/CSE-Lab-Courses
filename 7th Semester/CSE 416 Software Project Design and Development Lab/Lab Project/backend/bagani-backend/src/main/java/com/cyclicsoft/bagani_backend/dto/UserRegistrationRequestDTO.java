package com.cyclicsoft.bagani_backend.dto;

import jakarta.annotation.Nullable;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserRegistrationRequestDTO {

  @NotBlank(message = "Name is required.")
  private String name;

  @NotBlank(message = "Mobile number cannot be null")
  @Pattern(regexp = "^(01[0-9]{9})$", message = "Invalid mobile number")
  private String mobile;

  @Email(message = "Valid email is required!")
  @Nullable
  private String email; // Optional

  @Size(min = 8, message = "Password must be at least 8 characters long.")
  @NotBlank(message = "Password is required.")
  private String password;

}
