package com.cyclicsoft.bagani_backend.mapper;

import com.cyclicsoft.bagani_backend.dto.UserLoginResponseDTO;
import com.cyclicsoft.bagani_backend.dto.UserRegistrationRequestDTO;
import com.cyclicsoft.bagani_backend.dto.UserRegistrationResponseDTO;
import com.cyclicsoft.bagani_backend.dto.UserResponseDTO;
import com.cyclicsoft.bagani_backend.dto.UserStatusResponseDTO;
import com.cyclicsoft.bagani_backend.dto.UserUpdateRequestDTO;
import com.cyclicsoft.bagani_backend.entity.User;
import javax.annotation.processing.Generated;
import org.springframework.stereotype.Component;

@Generated(
    value = "org.mapstruct.ap.MappingProcessor",
    date = "2024-12-24T08:34:22+0600",
    comments = "version: 1.5.2.Final, compiler: Eclipse JDT (IDE) 3.41.0.v20241217-1506, environment: Java 17.0.13 (Eclipse Adoptium)"
)
@Component
public class IUserMapperImpl implements IUserMapper {

    @Override
    public UserResponseDTO toUserResponseDTO(User user) {
        if ( user == null ) {
            return null;
        }

        UserResponseDTO.UserResponseDTOBuilder userResponseDTO = UserResponseDTO.builder();

        userResponseDTO.id( user.getId() );
        userResponseDTO.name( user.getName() );
        userResponseDTO.email( user.getEmail() );
        userResponseDTO.mobile( user.getMobile() );
        userResponseDTO.isEmailVerified( user.isEmailVerified() );
        userResponseDTO.isMobileVerified( user.isMobileVerified() );
        userResponseDTO.profilePicture( user.getProfilePicture() );
        userResponseDTO.address( user.getAddress() );
        if ( user.getRole() != null ) {
            userResponseDTO.role( user.getRole().name() );
        }
        userResponseDTO.activeStatus( user.isActiveStatus() );

        return userResponseDTO.build();
    }

    @Override
    public User toUser(UserRegistrationRequestDTO userRegistrationRequestDTO) {
        if ( userRegistrationRequestDTO == null ) {
            return null;
        }

        User.UserBuilder user = User.builder();

        user.name( userRegistrationRequestDTO.getName() );
        user.email( userRegistrationRequestDTO.getEmail() );
        user.mobile( userRegistrationRequestDTO.getMobile() );

        user.password( userRegistrationRequestDTO.getPassword() );
        user.isEmailVerified( false );
        user.isMobileVerified( false );
        user.role( User.UserRole.USER );
        user.activeStatus( true );
        user.createdAt( java.time.LocalDateTime.now() );
        user.updatedAt( java.time.LocalDateTime.now() );

        return user.build();
    }

    @Override
    public User toUser(UserUpdateRequestDTO updateUserRequestDTO) {
        if ( updateUserRequestDTO == null ) {
            return null;
        }

        User.UserBuilder user = User.builder();

        user.name( updateUserRequestDTO.getName() );
        user.email( updateUserRequestDTO.getEmail() );
        user.profilePicture( updateUserRequestDTO.getProfilePicture() );
        user.address( updateUserRequestDTO.getAddress() );

        return user.build();
    }

    @Override
    public UserStatusResponseDTO toUserStatusResponseDTO(User user) {
        if ( user == null ) {
            return null;
        }

        UserStatusResponseDTO.UserStatusResponseDTOBuilder userStatusResponseDTO = UserStatusResponseDTO.builder();

        userStatusResponseDTO.id( user.getId() );
        userStatusResponseDTO.activeStatus( user.isActiveStatus() );
        userStatusResponseDTO.isEmailVerified( user.isEmailVerified() );
        userStatusResponseDTO.isMobileVerified( user.isMobileVerified() );

        return userStatusResponseDTO.build();
    }

    @Override
    public UserRegistrationResponseDTO toUserRegistrationResponseDTO(User user) {
        if ( user == null ) {
            return null;
        }

        UserRegistrationResponseDTO.UserRegistrationResponseDTOBuilder userRegistrationResponseDTO = UserRegistrationResponseDTO.builder();

        userRegistrationResponseDTO.id( user.getId() );
        userRegistrationResponseDTO.name( user.getName() );
        userRegistrationResponseDTO.email( user.getEmail() );
        userRegistrationResponseDTO.mobile( user.getMobile() );
        userRegistrationResponseDTO.activeStatus( user.isActiveStatus() );
        if ( user.getRole() != null ) {
            userRegistrationResponseDTO.role( user.getRole().name() );
        }

        return userRegistrationResponseDTO.build();
    }

    @Override
    public UserLoginResponseDTO toUserLoginResponseDTO(User user, String token) {
        if ( user == null && token == null ) {
            return null;
        }

        UserLoginResponseDTO.UserLoginResponseDTOBuilder userLoginResponseDTO = UserLoginResponseDTO.builder();

        if ( user != null ) {
            userLoginResponseDTO.userId( user.getId() );
            if ( user.getRole() != null ) {
                userLoginResponseDTO.role( user.getRole().name() );
            }
            userLoginResponseDTO.activeStatus( user.isActiveStatus() );
        }
        userLoginResponseDTO.token( token );

        return userLoginResponseDTO.build();
    }
}
