enum UserRole {
admin,
trainer,
contentManager,
Normaluser
}

class UserModel {
late String firstname, lastname, email, address, phoneNumber, profilePicture,
bio, company, birthDate, password;
UserRole role = UserRole.Normaluser;
String? userId;

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
required this.birthDate,
required this.password,
this.role = UserRole.Normaluser,
});

Map<String, dynamic> toJson() {
return {
"email": email,
"first_name": firstname,
"last_name": lastname,
"password": password,
"address": address,
"phone_number": phoneNumber,
"profile_picture": profilePicture,
"bio": bio,
"company": company,
"role": role.toString().split('.').last,
"birth_date": birthDate,
};
}

static UserModel fromJson(Map<String, dynamic> data, String id) {
return UserModel(
userId: id,
firstname: data["first_name"],
lastname: data["last_name"],
email: data["email"],
address: data["address"],
phoneNumber: data["phone_number"],
profilePicture: data["profile_picture"],
bio: data["bio"],
company: data["company"],
birthDate: data["birth_date"],
password: data["password"],
role: UserRole.values.firstWhere((e) => e.toString().split('.').last == data["role"], orElse: () => UserRole.Normaluser),
);
}

String getRole() {
return role.toString().split('.').last;
}
}




--- 


## New : 


--- 



enum UserRole {
admin,
trainer,
contentManager,
Normaluser
}

class UserModel {
late String firstname, lastname, email, address, phoneNumber, profilePicture,
bio, company, birthDate, password;
UserRole role = UserRole.Normaluser;
String? userId;

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
required this.birthDate,
required this.password,
this.role = UserRole.Normaluser,
});

Map<String, dynamic> toJson() {
return {
"email": email,
"first_name": firstname,
"last_name": lastname,
"password": password,
"address": address,
"phone_number": phoneNumber,
"profile_picture": profilePicture,
"bio": bio,
"company": company,
"role": role.toString().split('.').last,
"birth_date": birthDate,
};
}

static UserModel fromJson(Map<String, dynamic> data, String id) {
return UserModel(
userId: id,
firstname: data["first_name"],
lastname: data["last_name"],
email: data["email"],
address: data["address"],
phoneNumber: data["phone_number"],
profilePicture: data["profile_picture"],
bio: data["bio"],
company: data["company"],
birthDate: data["birth_date"],
password: data["password"],
role: UserRole.values.firstWhere((e) => e.toString().split('.').last == data["role"], orElse: () => UserRole.Normaluser),
);
}

String getRole() {
return role.toString().split('.').last;
}
}
