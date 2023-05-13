import 'dart:async';
import 'package:flutter/material.dart';
import '../../locator.dart';
import '../models/user_model.dart';
import '../services/user_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserCRUDModel extends ChangeNotifier {
  final UserAPI _api = locator<UserAPI>();

  List<User> users = [];

  Future<void> fetchUsers() async {
    try {
      var result = await _api.getDataCollection();
      users = result.docs
          .map((doc) => User.fromJson({
                ...(doc.data() as Map<String, dynamic>? ?? {}),
                'id': doc.id,
              }, doc.id)) // pass the id as the second argument to UserModel.fromJson
          .toList();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Stream<QuerySnapshot<Object?>> fetchUsersAsStream() {
    return _api.streamDataCollection();
  }

  Future<void> removeUser(String id) async {
    try {
      await _api.removeDocument(id);
    } catch (e) {
      print(e);
    }
  }

  Future<void> addUser(User data) async {
    try {
      await _api.addDocument(data.toJson());
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateUser(User data, String firstname, String lastname,
      String company, UserRole role) async {
    try {
      await _api.updateDocument(
        {
          'firstname': firstname,
          'lastname': lastname,
          'profilePicture': data.profilePicture,
          'company': company,
          'role': role.toString(),
        },
        data.userId,
      );
    } catch (e) {
      print(e);
    }
  }
}
