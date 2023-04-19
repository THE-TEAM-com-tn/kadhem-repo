import 'package:flutter/cupertino.dart';

enum UserRole {
  admin,
  trainer,
  contentManager,
  normalUser
}

class UserModel {
  String? _id;
  String? firstname;
  String? lastname;
  String? profilePicture;
  String? company;
  UserRole? role;
  String? email;

  UserModel({
    String? id,
    required this.firstname,
    required this.lastname,
    required this.profilePicture,
    required this.company,
    required this.role,
    required this.email,

  });

  // Define the getter method for id
  String? get id => _id;

  // Define the setter method for id
  set id(String? value) => _id = value;

  String get fullName => "$firstname $lastname";

  String get userEmail => email!;

  String get userId => id!;

  // Define the fromJson method
  factory UserModel.fromJson(Map<String, dynamic> json, String id) {
    var roleValue = json['role'];
    if (roleValue == null) {
      throw FormatException('Invalid value for UserRole: $roleValue');
    }
    if (roleValue is String) {
      roleValue = int.tryParse(roleValue);
      if (roleValue == null) {
        throw FormatException('Invalid value for UserRole: $roleValue');
      }
    }
    var user = UserModel(
      firstname: json['firstname'],
      lastname: json['lastname'],
      profilePicture: json['profilePicture'],
      company: json['company'],
      role: UserRole.values[roleValue],
      email: json['email'],
    );
    user.id = id;
    return user;
  }


  // Define the toJson method
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstname': firstname,
      'lastname': lastname,
      'profilePicture': profilePicture,
      'company': company,
      'role': role!.index,
      'email': email,
    };
  }
}
