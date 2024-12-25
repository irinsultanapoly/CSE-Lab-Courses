package com.cyclicsoft.bagani_backend.service.impl;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cyclicsoft.bagani_backend.dto.*;
import com.cyclicsoft.bagani_backend.entity.User;
import com.cyclicsoft.bagani_backend.exception.BadRequestException;
import com.cyclicsoft.bagani_backend.exception.ResourceNotFoundException;
import com.cyclicsoft.bagani_backend.mapper.IUserMapper;
import com.cyclicsoft.bagani_backend.repository.UserRepository;
import com.cyclicsoft.bagani_backend.service.IUserService;
import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Slf4j
@Service
@Transactional
@RequiredArgsConstructor
public class UserServiceImpl implements IUserService {

  private final UserRepository userRepository;
  private final IUserMapper userMapper;
  private final PasswordEncoder passwordEncoder;

  @Override
  public UserResponseDTO registerUser(UserRegistrationRequestDTO userRegistrationRequestDTO) {
    if (userRepository.existsByMobile(userRegistrationRequestDTO.getMobile())) {
      log.error("Mobile already registered: {}", userRegistrationRequestDTO.getEmail());
      throw new BadRequestException("Mobile already registered.");
    }

    User user = userMapper.toUser(userRegistrationRequestDTO);
    user.setPassword(passwordEncoder.encode(user.getPassword()));

    User savedUser = userRepository.save(user);
    log.info("User registered successfully: {}", savedUser.getId());
    return userMapper.toUserResponseDTO(savedUser);
  }

  @Override
  public UserLoginResponseDTO loginUser(UserLoginRequestDTO userLoginRequestDTO) {
    User user = userRepository.findByMobile(userLoginRequestDTO.getMobile())
        .orElseThrow(() -> new BadRequestException("Invalid mobile number or password"));

    if (!passwordEncoder.matches(userLoginRequestDTO.getPassword(), user.getPassword())) {
      log.error("Invalid credentials for mobile: {}", userLoginRequestDTO.getMobile());
      throw new BadRequestException("Invalid mobile number or password");
    }

    String token = "generated-jwt-token"; // Implement JWT token generation logic here

    log.info("User logged in successfully: {}", user.getId());
    return userMapper.toUserLoginResponseDTO(user, token);
  }

  @Override
  public UserResponseDTO getUserById(Long id) {
    User user = userRepository.findById(id)
        .orElseThrow(() -> {
          log.error("User not found with ID: {}", id);
          return new ResourceNotFoundException("User not found with ID: " + id);
        });
    return userMapper.toUserResponseDTO(user);
  }

  @Override
  public List<UserResponseDTO> getAllUsers() {
    List<User> users = userRepository.findAll();
    return users.stream()
        .map(userMapper::toUserResponseDTO)
        .collect(Collectors.toList());
  }

  @Override
  public UserResponseDTO updateUser(Long id, UserUpdateRequestDTO userUpdateRequestDTO) {
    User user = userRepository.findById(id)
        .orElseThrow(() -> {
          log.error("User not found with ID: {}", id);
          return new ResourceNotFoundException("User not found with ID: " + id);
        });

    user.setName(userUpdateRequestDTO.getName());
    user.setAddress(userUpdateRequestDTO.getAddress());
    user.setEmail(userUpdateRequestDTO.getEmail());
    user.setProfilePicture(userUpdateRequestDTO.getProfilePicture());
    user.setUpdatedAt(LocalDateTime.now());

    User updatedUser = userRepository.save(user);
    log.info("User updated successfully: {}", updatedUser.getId());
    return userMapper.toUserResponseDTO(updatedUser);
  }

  @Override
  public void deleteUser(Long id) {
    User user = userRepository.findById(id)
        .orElseThrow(() -> {
          log.error("User not found with ID: {}", id);
          return new ResourceNotFoundException("User not found with ID: " + id);
        });

    userRepository.delete(user);
    log.info("User deleted successfully: {}", id);
  }

  @Override
  public UserStatusResponseDTO activateUser(Long id) {
    User user = userRepository.findById(id)
        .orElseThrow(() -> {
          log.error("User not found with ID: {}", id);
          return new ResourceNotFoundException("User not found with ID: " + id);
        });

    user.setActiveStatus(true);
    user.setUpdatedAt(LocalDateTime.now());
    User savedUser = userRepository.save(user);

    log.info("User activated successfully: {}", id);
    return userMapper.toUserStatusResponseDTO(savedUser);
  }

  @Override
  public UserStatusResponseDTO deactivateUser(Long id) {
    User user = userRepository.findById(id)
        .orElseThrow(() -> {
          log.error("User not found with ID: {}", id);
          return new ResourceNotFoundException("User not found with ID: " + id);
        });

    user.setActiveStatus(false);
    user.setUpdatedAt(LocalDateTime.now());
    User savedUser = userRepository.save(user);

    log.info("User deactivated successfully: {}", id);
    return userMapper.toUserStatusResponseDTO(savedUser);
  }

  @Override
  public UserStatusResponseDTO verifyEmail(Long id) {
    User user = userRepository.findById(id)
        .orElseThrow(() -> {
          log.error("User not found with ID: {}", id);
          return new ResourceNotFoundException("User not found with ID: " + id);
        });

    user.setEmailVerified(true);
    user.setUpdatedAt(LocalDateTime.now());
    User savedUser = userRepository.save(user);

    log.info("Email verified successfully for user: {}", id);
    return userMapper.toUserStatusResponseDTO(savedUser);
  }

  @Override
  public UserStatusResponseDTO verifyMobile(Long id) {
    User user = userRepository.findById(id)
        .orElseThrow(() -> {
          log.error("User not found with ID: {}", id);
          return new ResourceNotFoundException("User not found with ID: " + id);
        });

    user.setMobileVerified(true);
    user.setUpdatedAt(LocalDateTime.now());
    User savedUser = userRepository.save(user);

    log.info("Mobile verified successfully for user: {}", id);
    return userMapper.toUserStatusResponseDTO(savedUser);
  }

  @Override
  public List<UserResponseDTO> searchUsers(String name, String mobile) {
    List<User> users = userRepository.findByNameOrMobile(name, mobile);
    return users.stream()
        .map(userMapper::toUserResponseDTO)
        .collect(Collectors.toList());
  }
}