package com.cyclicsoft.bagani_backend.controller;

import jakarta.validation.Valid;
import lombok.AllArgsConstructor;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.cyclicsoft.bagani_backend.dto.*;
import com.cyclicsoft.bagani_backend.service.IUserService;
import com.cyclicsoft.bagani_backend.util.GenericResponseUtil;

@RestController
@RequestMapping("/api/v1/users")
@AllArgsConstructor
public class UserController {

  private IUserService userService;

  // API for User Registration
  @PostMapping("/register")
  public ResponseEntity<GenericResponse<UserResponseDTO>> registerUser(
      @Valid @RequestBody UserRegistrationRequestDTO userRegistrationRequestDTO) {
    UserResponseDTO userResponseDTO = userService.registerUser(userRegistrationRequestDTO);
    return GenericResponseUtil.buildResponse(true, HttpStatus.CREATED.value(), "User registered successfully",
        "/api/users/register", userResponseDTO);
  }

  // API for User Login
  @PostMapping("/login")
  public ResponseEntity<GenericResponse<UserLoginResponseDTO>> loginUser(
      @Valid @RequestBody UserLoginRequestDTO userLoginRequestDTO) {
    UserLoginResponseDTO userLoginResponseDTO = userService.loginUser(userLoginRequestDTO);
    return GenericResponseUtil.buildResponse(true, HttpStatus.OK.value(), "User logged in successfully",
        "/api/users/login", userLoginResponseDTO);

  }

  // API for Updating User Details
  @PutMapping("/{id}")
  public ResponseEntity<GenericResponse<UserResponseDTO>> updateUser(@PathVariable Long id,
      @Valid @RequestBody UserUpdateRequestDTO userUpdateRequestDTO) {
    UserResponseDTO userResponseDTO = userService.updateUser(id, userUpdateRequestDTO);
    return GenericResponseUtil.buildResponse(true, HttpStatus.OK.value(), "User updated successfully",
        "/api/users/update/" + id, userResponseDTO);
  }

  // API for Deleting a User
  @DeleteMapping("/{id}")
  public ResponseEntity<GenericResponse<Void>> deleteUser(@PathVariable Long id) {
    userService.deleteUser(id);
    return GenericResponseUtil.buildResponse(true, HttpStatus.NO_CONTENT.value(), "User deleted successfully",
        "/api/users/delete/" + id, null);
  }

  // API for Getting User Details by ID
  @GetMapping("/{id}")
  public ResponseEntity<GenericResponse<UserResponseDTO>> getUserById(@PathVariable Long id) {
    UserResponseDTO userResponseDTO = userService.getUserById(id);
    return GenericResponseUtil.buildResponse(true, HttpStatus.OK.value(), "User deleted successfully",
        "/api/users/" + id, userResponseDTO);
  }

  // API for Getting All Users
  @GetMapping("/all")
  public ResponseEntity<GenericResponse<List<UserResponseDTO>>> getAllUsers() {
    return GenericResponseUtil.buildResponse(true, HttpStatus.OK.value(),
        "Users fetched successfully", "/api/users/all", userService.getAllUsers());
  }

  // API for Activating User
  @PutMapping("/activate/{id}")
  public ResponseEntity<GenericResponse<Void>> activateUser(@PathVariable Long id) {
    userService.activateUser(id);
    return GenericResponseUtil.buildResponse(true, HttpStatus.OK.value(),
        "User activated successfully", "/api/users/activate/" + id, null);
  }

  // API for Deactivating User
  @PutMapping("/deactivate/{id}")
  public ResponseEntity<GenericResponse<Void>> deactivateUser(@PathVariable Long id) {
    userService.deactivateUser(id);
    return GenericResponseUtil.buildResponse(true, HttpStatus.OK.value(),
        "User deactivated successfully", "/api/users/deactivate/" + id, null);
  }

  // API for Verifying User Email
  @PutMapping("/verify-email/{id}")
  public ResponseEntity<GenericResponse<Void>> verifyEmail(@PathVariable Long id) {
    userService.verifyEmail(id);
    return GenericResponseUtil.buildResponse(true, HttpStatus.OK.value(),
        "Email verified successfully", "/api/users/verify-email/" + id, null);
  }

  // API for Verifying User Mobile
  @PutMapping("/verify-mobile/{id}")
  public ResponseEntity<GenericResponse<Void>> verifyMobile(@PathVariable Long id) {
    userService.verifyMobile(id);
    return GenericResponseUtil.buildResponse(true, HttpStatus.OK.value(),
        "Mobile verified successfully", "/api/users/verify-mobile/" + id, null);
  }

  // API for Searching Users by Criteria (e.g., name, email)
  @GetMapping("/search")
  public ResponseEntity<GenericResponse<List<UserResponseDTO>>> searchUsers(@RequestParam(required = false) String name,
      @RequestParam(required = false) String mobile) {
    return GenericResponseUtil.buildResponse(true, HttpStatus.OK.value(),
        "Search Completed", "/api/users/search", userService.searchUsers(name, mobile));
  }
}
