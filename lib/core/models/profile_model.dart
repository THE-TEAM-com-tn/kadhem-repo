class ProfileModel {
  final String? id;
  final String name;
  final String email;
  final String photo;
  final String? phone;
  final String? company;
  final String? address;
  final String? bio;
  final double? totalPrice;
  final List<dynamic>? trainings;

  const ProfileModel(
      {this.id,
      required this.name,
      required this.email,
      required this.photo,
      this.phone,
      this.company,
      this.address,
      this.bio,
      this.totalPrice,
      this.trainings});

  Map<String, dynamic> toJson() {
    return {
      "id": id ?? '',
      "name": name,
      "email": email,
      "photo": photo,
      "phone": phone ?? '',
      "company": company ?? '',
      "address": address ?? '',
      "bio": bio ?? '',
      "totalPrice": totalPrice ?? 0,
      "trainings": trainings ?? [],
    };
  }
}
