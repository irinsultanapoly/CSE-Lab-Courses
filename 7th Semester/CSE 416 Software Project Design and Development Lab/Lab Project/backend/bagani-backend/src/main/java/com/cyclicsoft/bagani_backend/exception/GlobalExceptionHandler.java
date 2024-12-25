package com.cyclicsoft.bagani_backend.exception;

import java.util.HashMap;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.NoHandlerFoundException;
import org.springframework.web.servlet.resource.NoResourceFoundException;

import com.cyclicsoft.bagani_backend.dto.GenericResponse;
import com.cyclicsoft.bagani_backend.util.GenericResponseUtil;

import jakarta.validation.ConstraintViolation;
import jakarta.validation.ConstraintViolationException;
import lombok.RequiredArgsConstructor;

@ControllerAdvice
@RestController
@RequiredArgsConstructor
public class GlobalExceptionHandler {

  // Handle ResourceNotFoundException
  @ExceptionHandler({ ResourceNotFoundException.class, NoHandlerFoundException.class, NoResourceFoundException.class })
  public ResponseEntity<?> handleResourceNotFound(Exception ex) {
    return GenericResponseUtil.buildResponse(false, HttpStatus.NOT_FOUND.value(),
        ex.getLocalizedMessage(), "", null);
  }

  // Handle BadRequestException
  @ExceptionHandler(BadRequestException.class)
  public ResponseEntity<?> handleBadRequest(BadRequestException ex) {
    return GenericResponseUtil.buildResponse(false, HttpStatus.BAD_REQUEST.value(),
        ex.getLocalizedMessage(), "", null);
  }

  // Handle MethodArgumentNotValidException & ConstraintViolationException
  @ExceptionHandler({ MethodArgumentNotValidException.class, ConstraintViolationException.class })
  public ResponseEntity<GenericResponse<Map<String, String>>> handleValidationExceptions(Exception ex) {
    Map<String, String> errors;

    if (ex instanceof MethodArgumentNotValidException) {
      // Collect DTO validation errors into a map
      errors = ((MethodArgumentNotValidException) ex).getBindingResult().getFieldErrors().stream()
          .collect(Collectors.toMap(
              error -> error.getField(),
              error -> error.getDefaultMessage()));
    } else if (ex instanceof ConstraintViolationException) {
      // Collect entity validation errors into a map
      errors = ((ConstraintViolationException) ex).getConstraintViolations().stream()
          .collect(Collectors.toMap(
              cv -> cv.getPropertyPath().toString(),
              ConstraintViolation::getMessage));
    } else {
      errors = new HashMap<>();
    }

    return GenericResponseUtil.buildResponse(false, HttpStatus.BAD_REQUEST.value(),
        "Validation Error", "", errors);
  }

  // // Handle UnauthorizedException
  // @ExceptionHandler(UnauthorizedException.class)
  // public ResponseEntity<?> handleUnauthorized(UnauthorizedException ex) {
  // return GenericResponseUtil.buildUnauthorizedResponse(ex.getMessage(), "");
  // }

  // // Handle ForbiddenException
  // @ExceptionHandler(ForbiddenException.class)
  // public ResponseEntity<?> handleForbidden(ForbiddenException ex) {
  // return GenericResponseUtil.buildForbiddenResponse(ex.getMessage(), "");
  // }

  // Handle generic exception
  @ExceptionHandler(Exception.class)
  public ResponseEntity<?> handleGenericServerError(Exception ex) {
    return GenericResponseUtil.buildResponse(false,
        HttpStatus.INTERNAL_SERVER_ERROR.value(),
        "Something Went Wrong!", "", ex.getLocalizedMessage());
  }
}
