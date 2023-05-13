class ProfileModel {
  final String? id;
  final String name;
  final String email;
  final String photo;
  final double? totalPrice;
  final List<dynamic>? trainings;

  const ProfileModel({
    this.id,
    required this.name,
    required this.email,
    required this.photo,
    this.totalPrice,
    this.trainings,
  });
}
