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

  bool signedWithGoogle; // Add a signedWithGoogle field

  UserModel(
      {this.userId,
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
      this.signedWithGoogle = false, // Set the default value of signedWithGoogleAuth Checker !
      //this.password
   });

  toJson() {
    return {
      "firstName" : firstname,
      "lastName" : lastname,
      "email" : email,
      //"password" : password ?? 'admin',
      "address" : address,
      "phone_number": phoneNumber,
      "profile_picture": profilePicture,
      "bio" : bio,
      "company" : company,
      "role" : role,
      "birth_date" : birthDate,
      "signedWithGoogle": signedWithGoogle,
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
       // password: map['password'] ?? '',
        phoneNumber: map['phone_number'] ?? '',
        profilePicture: map['profile_picture'] ?? '',
        company: map['company'] ?? '',
        role: map['role'] ?? '',
        signedWithGoogle: map['signedWithGoogle'] ?? false, // Assign a bool value
    );
  }
}

UserModel userModel = UserModel(
    userId: "",
    firstname: " ",
    lastname: " ",
    //password: null, // making password optional
    email: "",
    address: "",
    phoneNumber: "",
    profilePicture: "",
    bio: "",
    company: "",
    role: "",
    birthDate: "",

);
