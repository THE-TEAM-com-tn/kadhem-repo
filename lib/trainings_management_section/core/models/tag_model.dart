class Tag {
  
  String? id;
  String label;
  String color;

  Tag({
    this.id,
    required this.label,
    required this.color
  });

  factory Tag.fromJson(Map<String, dynamic> map, String id) {
    return Tag(
      id: id,
      label: map['label'] ?? '',
      color: map['color'] ?? ''
    );
  }

  toJson() {
    return {
      "label": label,
      "color": color
    };
  }
}
