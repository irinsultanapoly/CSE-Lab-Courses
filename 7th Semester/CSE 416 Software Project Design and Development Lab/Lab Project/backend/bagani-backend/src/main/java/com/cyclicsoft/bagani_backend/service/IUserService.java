package com.cyclicsoft.bagani_backend.service;

import java.util.List;

import com.cyclicsoft.bagani_backend.dto.*;

public interface IUserService {

  // Register a new user
  UserResponseDTO registerUser(UserRegistrationRequestDTO userRegistrationRequestDTO);

  // User login
  UserLoginResponseDTO loginUser(UserLoginRequestDTO userLoginRequestDTO);

  // Get user by ID
  UserResponseDTO getUserById(Long id);

  // Get all users
  List<UserResponseDTO> getAllUsers();

  // Update user details
  UserResponseDTO updateUser(Long id, UserUpdateRequestDTO userUpdateRequestDTO);

  // Delete user by ID
  void deleteUser(Long id);

  // Activate user account
  UserStatusResponseDTO activateUser(Long id);

  // Deactivate user account
  UserStatusResponseDTO deactivateUser(Long id);

  // Verify user email
  UserStatusResponseDTO verifyEmail(Long id);

  // Verify user mobile
  UserStatusResponseDTO verifyMobile(Long id);

  // Search users by name or email
  List<UserResponseDTO> searchUsers(String name, String mobile);
}
