package com.cyclicsoft.bagani_backend.util;

import java.time.LocalDateTime;

import org.springframework.http.ResponseEntity;

import com.cyclicsoft.bagani_backend.dto.GenericResponse;

public class GenericResponseUtil {

  // Private constructor to prevent instantiation
  private GenericResponseUtil() {
  }

  /**
   * Builds a custom response with dynamic status, message, path, and data.
   *
   * @param <T>        The type of data included in the response.
   * @param isSuccess  Indicator of success or failure.
   * @param statusCode HTTP status code.
   * @param message    Custom error or success message.
   * @param path       The API endpoint path.
   * @param data       Additional data or response details to include.
   * @return ResponseEntity with the specified status and GenericResponse body.
   */
  public static <T> ResponseEntity<GenericResponse<T>> buildResponse(
      boolean isSuccess,
      int statusCode,
      String message,
      String path,
      T data) {
    return ResponseEntity.status(statusCode)
        .body(GenericResponse.<T>builder()
            .isSuccess(isSuccess)
            .statusCode(statusCode)
            .message(message)
            .data(data)
            .path(path)
            .timestamp(LocalDateTime.now())
            .build());
  }

}
