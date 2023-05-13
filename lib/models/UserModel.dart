class UserModel {
  late String firstname,
      lastname,
      email,
      address,
      phoneNumber,
      profilePicture,
      bio,
      company,
      role,
      birthDate,
      password;
  String? userId;
  final double? totalPrice;
  final List<dynamic>? trainings;

  UserModel({
    this.userId,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.address,
    required this.phoneNumber,
    required this.profilePicture,
    required this.bio,
    required this.company,
    required this.role,
    required this.birthDate,
    required this.password,
    this.totalPrice,
    this.trainings,
  });

  toJson() {
    return {
      "firstName": firstname,
      "lastName": lastname,
      "email": email,
      "password": password,
      "address": address,
      "phonenumber": phoneNumber,
      "profile_picture": profilePicture,
      "bio": bio,
      "company": company,
      "role": role,
      "birth_date": birthDate
    };
  }

  factory UserModel.fromMap(Map<dynamic, dynamic> map, String id) {
    return UserModel(
        userId: id,
        firstname: map['firstName'] ?? '',
        lastname: map['lastName'] ?? '',
        email: map['email'] ?? '',
        address: map['address'] ?? '',
        bio: map['bio'] ?? '',
        birthDate: map['birth_date'] ?? '',
        password: map['password'] ?? '',
        phoneNumber: map['phone_number'] ?? '',
        profilePicture: map['profile_picture'] ?? '',
        company: map['company'] ?? '',
        role: map['role'] ?? '');
  }
}

UserModel userModel = UserModel(
    userId: "",
    firstname: " ",
    lastname: " ",
    password: "",
    email: " ",
    address: " ",
    phoneNumber: " ",
    profilePicture: "",
    bio: " ",
    company: " ",
    role: " ",
    birthDate: "");
