class CategoryModel {
  String? id;
  String name;
  String description;

  CategoryModel({this.id, required this.name, required this.description});

  factory CategoryModel.fromJson(Map<String, dynamic> map, String id) {
    return CategoryModel(
        id: id, name: map['name'] ?? '', description: map['description'] ?? '');
  }

  toJson() {
    return {"name": name, "description": description};
  }
}
