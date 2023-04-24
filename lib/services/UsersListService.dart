
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elearning_provider/models/UserModel.dart';
class UsersListService {

  final _db = FirebaseFirestore.instance;
  List<UserModel> users = [] ;

  getUsers() async {
    users = [] ;
    final data = await _db.collection('Users').get() ;
    data.docs.forEach((element) { 
      users.add(UserModel.fromMap(element.data(), element.id ));
    })  ;
    return users ; 
  }

  updateRole(String role, String doc) async {
      _db.collection('Users').doc(doc).update({'role' : role}) ;
  }


  
  Future<bool> updateData(UserModel userModel) async {
    _db.collection("Users").doc(userModel.userId).update(userModel.toJson());
      return true;
  }

}