package com.cyclicsoft.bagani_backend.exception;

public class BadRequestException extends RuntimeException {

  private static final long serialVersionUID = 1L;

  public BadRequestException(String message) {
    super(message);
  }

  public BadRequestException(String resource, String field, String value) {
    super(String.format("%s with %s %s is invalid.", resource, field, value));
  }
}
