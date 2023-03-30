class TrainingCategory {
  
  String? id;
  String name;
  String description;

  TrainingCategory({
    this.id,
    required this.name,
    required this.description
  });

  factory TrainingCategory.fromJson(Map<String, dynamic> map, String id) {
    return TrainingCategory(
        id: id,
        name: map['name'] ?? '',
        description: map['description'] ?? '');
  }

  toJson() {
    return {
      "name": name,
      "description": description
    };
  }
}
