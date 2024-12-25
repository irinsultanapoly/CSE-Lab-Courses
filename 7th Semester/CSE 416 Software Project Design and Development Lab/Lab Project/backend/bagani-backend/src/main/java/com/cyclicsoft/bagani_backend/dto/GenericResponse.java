package com.cyclicsoft.bagani_backend.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class GenericResponse<T> {

  private boolean isSuccess; // Quick indicator of success or failure
  private int statusCode; // HTTP status code
  private String message; // Descriptive message
  private T data; // Response data (payload)
  private String path; // API endpoint path

  // Initialize timestamp automatically when the object is built
  @Builder.Default
  private LocalDateTime timestamp = LocalDateTime.now();
}