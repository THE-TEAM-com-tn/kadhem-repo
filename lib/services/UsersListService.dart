
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elearning_provider/models/UserModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
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

  deleteUser(UserModel userModel) async  {
       try {
        AuthCredential credential = EmailAuthProvider.credential(email: userModel.email, password: userModel.password);
      final result = await FirebaseAuth.instance.signInWithCredential(credential);
      await FirebaseFirestore.instance.collection("Users").doc(userModel.userId).delete();
      await result.user!.delete();
      return true;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

}