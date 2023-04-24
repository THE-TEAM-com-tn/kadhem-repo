
import 'package:elearning_provider/models/UserModel.dart';
import 'package:elearning_provider/services/UsersListService.dart';
import 'package:flutter/material.dart';

class UsersListProvider with ChangeNotifier {

   List<UserModel> users = [] ; 
  UsersListService _api = UsersListService() ;
  bool loading = true ; 

  getUsers() async {
    users= [] ;
    users = await _api.getUsers() ;
    loading = false ; 
    notifyListeners();
    return users ; 
  }

  updateRole(String role, String doc) {

    _api.updateRole(role, doc) ;
  }


  updateData(UserModel userModel) async {
     await _api.updateData(userModel);
    notifyListeners();
  }

}