package com.cyclicsoft.bagani_backend.exception;

public class ResourceNotFoundException extends RuntimeException {

  private static final long serialVersionUID = 1L;

  public ResourceNotFoundException(String message) {
    super(message);
  }

  public ResourceNotFoundException(String resource, Long id) {
    super(String.format("%s with ID %d not found.", resource, id));
  }
}
