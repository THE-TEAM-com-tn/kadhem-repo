import 'package:elearning_provider/models/PasswordChangeModel.dart';


import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:emailjs/emailjs.dart';

class ChangePasswordService {
  final _db = FirebaseFirestore.instance;

  updatePassword(PasswordChangeModel passwordChangeModel, String doc) async {
     try {
      if (passwordChangeModel.newPassword == passwordChangeModel.confirmPassword) {
        final user = await FirebaseFirestore.instance
            .collection("Users")
            .doc(doc)
            .get();
        if (user.data()!['password'] == passwordChangeModel.oldPassword) {
          var userDoc = FirebaseFirestore.instance
              .collection('Users')
              .doc(doc);
          userDoc.update({
            'password': passwordChangeModel.newPassword,
          });
        /*  changePasswordMail();*/
          return "Your password has been updated successfully";
        } else {
          return "Your old Password does not match";
        }
      } else {
        return "Your new Passwords do not match";
      }
    } catch (e) {
      return "there was an error updating you password" ;
    }
  }

              /// CONFLICT HERE !!!
  /*
      changePasswordMail(/*String recipient , String subject , String body*/) async {

  try {
    await EmailJS.send(
    'service_0rkl7la',
    'template_flf8y8o',
    {},
    const Options(
      publicKey: 'tSqOiRAa-ZEk1FX7u',
      privateKey: 'MKeGCteSGuS1BB8EP_lCc',
    ),


  );
    } catch (e) {
      print(e.toString()) ;
    }

    }*/

  


}