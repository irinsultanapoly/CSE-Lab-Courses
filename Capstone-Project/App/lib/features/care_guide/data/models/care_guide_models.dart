class CareGuideCategory {
  final String id;
  final String name;
  final String icon;
  final String description;
  final List<CareGuide> guides;

  CareGuideCategory({
    required this.id,
    required this.name,
    required this.icon,
    required this.description,
    required this.guides,
  });

  factory CareGuideCategory.fromJson(Map<String, dynamic> json) {
    return CareGuideCategory(
      id: json['id'] as String,
      name: json['name'] as String,
      icon: json['icon'] as String,
      description: json['description'] as String,
      guides: (json['guides'] as List<dynamic>)
          .map((guide) => CareGuide.fromJson(guide))
          .toList(),
    );
  }
}

class CareGuide {
  final String id;
  final String title;
  final String image;
  final String difficulty;
  final String light;
  final String water;
  final String temperature;
  final String humidity;
  final String soil;
  final String fertilizer;
  final List<String> careTips;
  final List<String> commonIssues;

  CareGuide({
    required this.id,
    required this.title,
    required this.image,
    required this.difficulty,
    required this.light,
    required this.water,
    required this.temperature,
    required this.humidity,
    required this.soil,
    required this.fertilizer,
    required this.careTips,
    required this.commonIssues,
  });

  factory CareGuide.fromJson(Map<String, dynamic> json) {
    return CareGuide(
      id: json['id'] as String,
      title: json['title'] as String,
      image: json['image'] as String,
      difficulty: json['difficulty'] as String,
      light: json['light'] as String,
      water: json['water'] as String,
      temperature: json['temperature'] as String,
      humidity: json['humidity'] as String,
      soil: json['soil'] as String,
      fertilizer: json['fertilizer'] as String,
      careTips: (json['care_tips'] as List<dynamic>)
          .map((tip) => tip as String)
          .toList(),
      commonIssues: (json['common_issues'] as List<dynamic>)
          .map((issue) => issue as String)
          .toList(),
    );
  }
}

class CareGuidesData {
  final List<CareGuideCategory> categories;

  CareGuidesData({required this.categories});

  factory CareGuidesData.fromJson(Map<String, dynamic> json) {
    return CareGuidesData(
      categories: (json['categories'] as List<dynamic>)
          .map((category) => CareGuideCategory.fromJson(category))
          .toList(),
    );
  }
}
