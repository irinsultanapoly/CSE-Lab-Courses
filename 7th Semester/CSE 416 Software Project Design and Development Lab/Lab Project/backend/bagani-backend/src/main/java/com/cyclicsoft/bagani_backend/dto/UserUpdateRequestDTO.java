package com.cyclicsoft.bagani_backend.dto;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.Size;
import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserUpdateRequestDTO {

  @Size(min = 1, max = 50, message = "Name must be between 1 and 50 characters.")
  private String name;

  @Email(message = "Invalid email format.")
  private String email;

  private String address;
  private String profilePicture; // URL or Base64 encoded image
}
