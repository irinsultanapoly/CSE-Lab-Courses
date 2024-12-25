package com.cyclicsoft.bagani_backend.mapper;

import com.cyclicsoft.bagani_backend.dto.PlantRequestDTO;
import com.cyclicsoft.bagani_backend.dto.PlantResponseDTO;
import com.cyclicsoft.bagani_backend.dto.PlantUpdateRequestDTO;
import com.cyclicsoft.bagani_backend.entity.Plant;
import com.cyclicsoft.bagani_backend.entity.User;
import javax.annotation.processing.Generated;
import org.springframework.stereotype.Component;

@Generated(
    value = "org.mapstruct.ap.MappingProcessor",
    date = "2024-12-24T08:34:22+0600",
    comments = "version: 1.5.2.Final, compiler: Eclipse JDT (IDE) 3.41.0.v20241217-1506, environment: Java 17.0.13 (Eclipse Adoptium)"
)
@Component
public class IPlantMapperImpl implements IPlantMapper {

    @Override
    public PlantResponseDTO toPlantResponseDTO(Plant plant) {
        if ( plant == null ) {
            return null;
        }

        PlantResponseDTO.PlantResponseDTOBuilder plantResponseDTO = PlantResponseDTO.builder();

        plantResponseDTO.id( plant.getId() );
        plantResponseDTO.name( plant.getName() );
        plantResponseDTO.species( plant.getSpecies() );
        plantResponseDTO.description( plant.getDescription() );
        plantResponseDTO.imageUrl( plant.getImageUrl() );
        if ( plant.getStatus() != null ) {
            plantResponseDTO.status( plant.getStatus().name() );
        }
        plantResponseDTO.userId( plantUserId( plant ) );
        plantResponseDTO.createdAt( plant.getCreatedAt() );
        plantResponseDTO.updatedAt( plant.getUpdatedAt() );

        return plantResponseDTO.build();
    }

    @Override
    public Plant toPlant(PlantRequestDTO plantRequestDTO, Long userId) {
        if ( plantRequestDTO == null && userId == null ) {
            return null;
        }

        Plant.PlantBuilder plant = Plant.builder();

        if ( plantRequestDTO != null ) {
            plant.name( plantRequestDTO.getName() );
            plant.species( plantRequestDTO.getSpecies() );
            plant.description( plantRequestDTO.getDescription() );
            plant.imageUrl( plantRequestDTO.getImageUrl() );
        }
        plant.createdAt( java.time.LocalDateTime.now() );
        plant.updatedAt( java.time.LocalDateTime.now() );

        return plant.build();
    }

    @Override
    public Plant toPlant(PlantUpdateRequestDTO plantUpdateDTO) {
        if ( plantUpdateDTO == null ) {
            return null;
        }

        Plant.PlantBuilder plant = Plant.builder();

        plant.name( plantUpdateDTO.getName() );
        plant.species( plantUpdateDTO.getSpecies() );
        plant.description( plantUpdateDTO.getDescription() );
        plant.imageUrl( plantUpdateDTO.getImageUrl() );

        plant.updatedAt( java.time.LocalDateTime.now() );

        return plant.build();
    }

    private Long plantUserId(Plant plant) {
        if ( plant == null ) {
            return null;
        }
        User user = plant.getUser();
        if ( user == null ) {
            return null;
        }
        Long id = user.getId();
        if ( id == null ) {
            return null;
        }
        return id;
    }
}
