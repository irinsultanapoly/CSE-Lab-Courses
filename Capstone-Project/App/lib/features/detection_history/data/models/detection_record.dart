class DetectionRecord {
  final int? id;
  final String plantName;
  final String diseaseName;
  final double confidence;
  final String imagePath;
  final String? aiSuggestion;
  final DateTime detectedAt;
  final bool isHealthy;

  DetectionRecord({
    this.id,
    required this.plantName,
    required this.diseaseName,
    required this.confidence,
    required this.imagePath,
    this.aiSuggestion,
    required this.detectedAt,
    required this.isHealthy,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'plantName': plantName,
      'diseaseName': diseaseName,
      'confidence': confidence,
      'imagePath': imagePath,
      'aiSuggestion': aiSuggestion,
      'detectedAt': detectedAt.millisecondsSinceEpoch,
      'isHealthy': isHealthy ? 1 : 0,
    };
  }

  factory DetectionRecord.fromMap(Map<String, dynamic> map) {
    return DetectionRecord(
      id: map['id'] as int?,
      plantName: map['plantName'] as String,
      diseaseName: map['diseaseName'] as String,
      confidence: map['confidence'] as double,
      imagePath: map['imagePath'] as String,
      aiSuggestion: map['aiSuggestion'] as String?,
      detectedAt: DateTime.fromMillisecondsSinceEpoch(map['detectedAt'] as int),
      isHealthy: (map['isHealthy'] as int) == 1,
    );
  }

  DetectionRecord copyWith({
    int? id,
    String? plantName,
    String? diseaseName,
    double? confidence,
    String? imagePath,
    String? aiSuggestion,
    DateTime? detectedAt,
    bool? isHealthy,
  }) {
    return DetectionRecord(
      id: id ?? this.id,
      plantName: plantName ?? this.plantName,
      diseaseName: diseaseName ?? this.diseaseName,
      confidence: confidence ?? this.confidence,
      imagePath: imagePath ?? this.imagePath,
      aiSuggestion: aiSuggestion ?? this.aiSuggestion,
      detectedAt: detectedAt ?? this.detectedAt,
      isHealthy: isHealthy ?? this.isHealthy,
    );
  }
}
