class UserModel {
  late  String firstname , lastname  , email , address,phoneNumber, profilePicture,
      bio,company,role,birthDate, password ;
      String? userId ; 

  UserModel({  this.userId, required this.firstname, required this.lastname,
    required this.email, required this.address, required this.phoneNumber, required this.profilePicture,
    required this.bio, required this.company, required this.role, required this.birthDate,
  required this.password}) ;

  toJson() {
    return {
      "first_name" : firstname,
      "last_name" : lastname,
      "email" : email,
      "password" : password,
      "address" : address,
      "phone_number": phoneNumber,
      "profile_picture": profilePicture,
      "bio" : bio,
      "company" : company,
      "role" : role,
      "birth_date" : birthDate
    } ;
  }


}
UserModel userModel = UserModel(userId: "", firstname: " ", lastname: " ", password : "",
    email: " ", address: " ",
    phoneNumber: " ", profilePicture: "", bio: " ", company: " " , role: " ", birthDate: "") ;