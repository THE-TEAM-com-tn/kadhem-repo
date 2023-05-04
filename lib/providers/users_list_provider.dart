import 'package:elearning_provider/models/UserModel.dart';
import 'package:elearning_provider/services/UsersListService.dart';
import 'package:flutter/material.dart';

class UsersListProvider with ChangeNotifier {
  List<UserModel> users = [];
  List<UserModel> searchedUsers = [];
  UsersListService _api = UsersListService();
  bool loading = true;

  getUsers() async {
    users = [];
    searchedUsers = [] ;
    users = await _api.getUsers();
    searchedUsers = users;
    loading = false;
    notifyListeners();
    return users;
  }

  updateRole(String role, String doc) {
    _api.updateRole(role, doc);
  }

  filterData(String value) {
    searchedUsers = [];
    searchedUsers = users
        .where((item) =>
            item.firstname.toLowerCase().contains(value.toLowerCase()))
        .toList();
    notifyListeners();
  }

  updateData(UserModel userModel) async {
    await _api.updateData(userModel);
    notifyListeners();
  }

  deleteUser(UserModel userModel) async {
    await _api.deleteUser(userModel);
    loading = true ; 
    notifyListeners();
  }
}
