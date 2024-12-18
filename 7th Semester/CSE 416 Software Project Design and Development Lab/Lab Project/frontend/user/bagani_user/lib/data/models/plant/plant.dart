import 'package:bagani/data/models/plant/plant_response.dart';

class Plant {
  final int id;
  final String name;
  final String species;
  final String description;
  final String imageUrl;
  final int userId; // The user who owns the plant

  Plant({
    required this.id,
    required this.name,
    required this.species,
    required this.description,
    required this.imageUrl,
    required this.userId,
  });

  // Factory method to create a Plant object from the raw API response
  factory Plant.fromPlantData(Map<String, dynamic> data) {
    return Plant(
      id: data['id'],
      name: data['name'],
      species: data['species'],
      description: data['description'],
      imageUrl: data['imageUrl'],
      userId: data['userId'],
    );
  }

  factory Plant.fromPlantDataRaw(PlantData plantData) {
    return Plant(
      id: plantData.id,
      name: plantData.name ?? '',
      species: plantData.species ?? '',
      description: plantData.description ?? '',
      imageUrl:
          'https://media-hosting.imagekit.io//05683e9d58da4523/playstore.png?Expires=1734647077&Key-Pair-Id=K2ZIVPTIP2VGHC&Signature=2hGgx-BdfrBsMYCQA2uHUxq3IMK~9cc9PsOh8Ij41yqlV6wDx78H-QJR9NyZUB2dxGH0RTpSTHKCmz7g-MashatP3OV~La657wUIQ0pZzt5ffHQKF1rR6kJeoC9Zu8DsNjzOUkazbeQ-m1OTqY8TeYy72sWruNTaUfUabMu9dd-1sppD1T1m0fCIxrDdfg9jd5mAPS0ugbgtgMZQTc93B80MF3227xPSI~~PHAR-dXMQoY4Q3WB0x7DXdlmkkNbEbtBJt9vjLrbQLvSpH~1uM8qqjsY5FqiK7jywaUc~hcHedx4tcZT4L~M2Dzd7i3Ch~OEYhvHZAdu1Rf2Z5PcJKQ__',
      userId: plantData.id,
    );
  }

  // Method to convert the Plant object to a map for API request payload
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'species': species,
      'description': description,
      'imageUrl': imageUrl,
      'userId': userId,
    };
  }
}
