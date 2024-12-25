package com.cyclicsoft.bagani_backend.repository;

import com.cyclicsoft.bagani_backend.entity.User;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {

  Optional<User> findByMobile(String mobile);

  Optional<User> findByRole(User.UserRole role);

  boolean existsByMobile(String mobile);

  List<User> findByNameOrMobile(String name, String mobile);
}
