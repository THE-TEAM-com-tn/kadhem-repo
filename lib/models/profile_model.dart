class ProfileModel {
  // final ImageProvider photo;
  final String name;
  final String email;
  final String photo;
  final double? totalPrice;
  final List<dynamic>? trainings;

  const ProfileModel({
    // required this.photo,
    required this.name,
    required this.email,
    required this.photo,
    this.totalPrice,
    this.trainings,
  });
}
