package com.cyclicsoft.bagani_backend.mapper;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.factory.Mappers;

import com.cyclicsoft.bagani_backend.dto.UserLoginResponseDTO;
import com.cyclicsoft.bagani_backend.dto.UserRegistrationRequestDTO;
import com.cyclicsoft.bagani_backend.dto.UserRegistrationResponseDTO;
import com.cyclicsoft.bagani_backend.dto.UserResponseDTO;
import com.cyclicsoft.bagani_backend.dto.UserStatusResponseDTO;
import com.cyclicsoft.bagani_backend.dto.UserUpdateRequestDTO;
import com.cyclicsoft.bagani_backend.entity.User;

@Mapper(componentModel = "spring")
public interface IUserMapper {

  IUserMapper INSTANCE = Mappers.getMapper(IUserMapper.class);

  // Mapping from Entity to UserResponseDTO (for User details)
  @Mapping(source = "id", target = "id")
  @Mapping(source = "name", target = "name")
  @Mapping(source = "email", target = "email")
  @Mapping(source = "mobile", target = "mobile")
  @Mapping(source = "emailVerified", target = "isEmailVerified")
  @Mapping(source = "mobileVerified", target = "isMobileVerified")
  @Mapping(source = "profilePicture", target = "profilePicture")
  @Mapping(source = "address", target = "address")
  @Mapping(source = "role", target = "role")
  @Mapping(source = "activeStatus", target = "activeStatus")
  UserResponseDTO toUserResponseDTO(User user);

  // Mapping from UserRegistrationRequestDTO to User entity for registration
  @Mapping(source = "name", target = "name")
  @Mapping(source = "email", target = "email")
  @Mapping(source = "mobile", target = "mobile")
  @Mapping(target = "password", expression = "java(userRegistrationRequestDTO.getPassword())")
  @Mapping(target = "isEmailVerified", constant = "false") // Default as false for new users
  @Mapping(target = "isMobileVerified", constant = "false") // Default as false for new users
  @Mapping(target = "role", constant = "USER") // Default role
  @Mapping(target = "activeStatus", constant = "true") // Account is active by default
  @Mapping(target = "createdAt", expression = "java(java.time.LocalDateTime.now())") // Set current date and time
  @Mapping(target = "updatedAt", expression = "java(java.time.LocalDateTime.now())") // Set current date and time
  User toUser(UserRegistrationRequestDTO userRegistrationRequestDTO);

  // Mapping from DTO to Entity (for updating user details)
  @Mapping(source = "name", target = "name")
  @Mapping(source = "email", target = "email")
  @Mapping(source = "profilePicture", target = "profilePicture")
  @Mapping(source = "address", target = "address")
  User toUser(UserUpdateRequestDTO updateUserRequestDTO);

  // Mapping from User Entity to UserStatusResponseDTO
  @Mapping(source = "id", target = "id")
  @Mapping(source = "activeStatus", target = "activeStatus")
  @Mapping(source = "emailVerified", target = "isEmailVerified")
  @Mapping(source = "mobileVerified", target = "isMobileVerified")
  UserStatusResponseDTO toUserStatusResponseDTO(User user);

  // Mapping from Entity to UserRegistrationResponseDTO
  @Mapping(source = "id", target = "id")
  @Mapping(source = "name", target = "name")
  @Mapping(source = "email", target = "email")
  @Mapping(source = "mobile", target = "mobile")
  UserRegistrationResponseDTO toUserRegistrationResponseDTO(User user);

  // Mapping from Entity to UserLoginResponseDTO (includes JWT Token)
  @Mapping(source = "user.id", target = "userId")
  @Mapping(source = "user.role", target = "role")
  @Mapping(source = "user.activeStatus", target = "activeStatus")
  @Mapping(target = "token", source = "token") // Token is passed as a separate parameter
  UserLoginResponseDTO toUserLoginResponseDTO(User user, String token);
}
