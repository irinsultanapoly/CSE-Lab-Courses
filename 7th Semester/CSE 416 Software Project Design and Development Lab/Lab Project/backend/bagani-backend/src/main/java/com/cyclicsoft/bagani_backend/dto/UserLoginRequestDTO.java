package com.cyclicsoft.bagani_backend.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserLoginRequestDTO {

  @NotBlank(message = "Mobile number cannot be blank")
  @Pattern(regexp = "^[0-9]{10,15}$", message = "Mobile number must be valid")
  private String mobile;

  @NotBlank(message = "Password is required.")
  private String password;
}
