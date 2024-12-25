package com.cyclicsoft.bagani_backend.entity;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "plants")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Plant {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;

  @Column(nullable = false)
  private String name;

  @Column(nullable = false)
  private String species;

  @Column(length = 1000)
  private String description;

  private String imageUrl;

  @ManyToOne(fetch = FetchType.LAZY)
  @JoinColumn(name = "user_id", nullable = false)
  private User user; // Every plant belongs to a user

  @Enumerated(EnumType.STRING)
  @Column(nullable = false)
  private PlantStatus status = PlantStatus.AVAILABLE; // Plant status (e.g., Available, Sold)

  @Column(nullable = false)
  private LocalDateTime createdAt;

  @Column(nullable = false)
  private LocalDateTime updatedAt;

  // Timestamp for when the plant was last updated or modified
  @PrePersist
  public void onCreate() {
    this.createdAt = LocalDateTime.now();
    this.updatedAt = LocalDateTime.now();
  }

  @PreUpdate
  public void onUpdate() {
    this.updatedAt = LocalDateTime.now();
  }

  // Enum for plant status
  public enum PlantStatus {
    AVAILABLE,
    SOLD,
    EXPIRED,
    RESERVED
  }
}
