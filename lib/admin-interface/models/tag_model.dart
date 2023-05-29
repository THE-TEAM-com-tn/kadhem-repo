class TagModel {
  String? id;
  String label;
  String color;

  TagModel({this.id, required this.label, required this.color});

  factory TagModel.fromJson(Map<String, dynamic> map, String id) {
    return TagModel(
        id: id, label: map['label'] ?? '', color: map['color'] ?? '');
  }

  toJson() {
    return {"label": label, "color": color};
  }
}
