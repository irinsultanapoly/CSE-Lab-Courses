package com.cyclicsoft.bagani_backend.entity;

import lombok.*;
import java.time.LocalDateTime;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;

@Entity
@Table(name = "users")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class User {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  @Column(name = "id")
  private Long id; // Unique ID

  @NotNull(message = "Name cannot be null")
  @Size(min = 2, max = 50, message = "Name must be between 2 and 50 characters")
  @Column(name = "name", nullable = false)
  private String name;

  @Email(message = "Email should be valid")
  @Column(name = "email", nullable = true, unique = false, length = 100) // Email optional
  private String email;

  @Pattern(regexp = "^(01[0-9]{9})$", message = "Invalid mobile number")
  @Column(name = "mobile", length = 11, nullable = false, unique = true)
  private String mobile;

  @Column(name = "is_email_verified", nullable = false)
  private boolean isEmailVerified;

  @Column(name = "is_mobile_verified", nullable = false)
  private boolean isMobileVerified;

  @NotNull(message = "Password cannot be null")
  @Size(min = 6, max = 100, message = "Password must be between 6 and 100 characters")
  @Column(name = "password", nullable = false)
  private String password;

  @Column(name = "profile_picture")
  private String profilePicture;

  @Column(name = "address")
  private String address;

  @NotNull(message = "Creation date cannot be null")
  @Column(name = "created_at", nullable = false)
  private LocalDateTime createdAt;

  @NotNull(message = "Update date cannot be null")
  @Column(name = "updated_at", nullable = false)
  private LocalDateTime updatedAt;

  @Enumerated(EnumType.STRING)
  @Column(name = "role", nullable = false)
  private UserRole role; // "USER" or "ADMIN"

  @Column(name = "active_status", nullable = false)
  private boolean activeStatus; // Active or deactivated status of the account

  // Enum for User Roles
  public enum UserRole {
    USER,
    ADMIN
  }
}
