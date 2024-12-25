package com.cyclicsoft.bagani_backend.mapper;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.factory.Mappers;

import com.cyclicsoft.bagani_backend.dto.*;
import com.cyclicsoft.bagani_backend.entity.Plant;

@Mapper(componentModel = "spring")
public interface IPlantMapper {

  IPlantMapper INSTANCE = Mappers.getMapper(IPlantMapper.class);

  // Mapping from Plant Entity to PlantResponseDTO (for listing plant details)
  @Mapping(source = "id", target = "id")
  @Mapping(source = "name", target = "name")
  @Mapping(source = "species", target = "species")
  @Mapping(source = "description", target = "description")
  @Mapping(source = "imageUrl", target = "imageUrl")
  @Mapping(source = "status", target = "status")
  @Mapping(source = "user.id", target = "userId") // Mapping the user ID
  @Mapping(source = "createdAt", target = "createdAt")
  @Mapping(source = "updatedAt", target = "updatedAt")
  PlantResponseDTO toPlantResponseDTO(Plant plant);

  // Mapping from PlantRequestDTO to Plant Entity (for plant creation)
  @Mapping(source = "plantRequestDTO.name", target = "name")
  @Mapping(source = "plantRequestDTO.species", target = "species")
  @Mapping(source = "plantRequestDTO.description", target = "description")
  @Mapping(source = "plantRequestDTO.imageUrl", target = "imageUrl")
  @Mapping(target = "createdAt", expression = "java(java.time.LocalDateTime.now())") // Set current date for createdAt
  @Mapping(target = "updatedAt", expression = "java(java.time.LocalDateTime.now())") // Set current date for updatedAt
  Plant toPlant(PlantRequestDTO plantRequestDTO, Long userId);

  // Mapping from PlantUpdateDTO to Plant Entity (for updating plant details)
  @Mapping(source = "name", target = "name")
  @Mapping(source = "species", target = "species")
  @Mapping(source = "description", target = "description")
  @Mapping(source = "imageUrl", target = "imageUrl")
  @Mapping(target = "updatedAt", expression = "java(java.time.LocalDateTime.now())") // Update timestamp
  Plant toPlant(PlantUpdateRequestDTO plantUpdateDTO);
}
