import 'package:elearning_provider/UI/Pages/EditProfilePage/EditProfilePage.dart';
import 'package:elearning_provider/providers/EditProfileProvider.dart';
import 'package:elearning_provider/providers/users_list_provider.dart';
import 'package:flutter/material.dart';

import '../../models/UserModel.dart';

class MyPopup extends StatefulWidget {
  final UserModel userModel ;
  const MyPopup({Key? key, required this.userModel}) : super(key: key);

  @override
  _MyPopupState createState() => _MyPopupState();
}

class _MyPopupState extends State<MyPopup> {



  @override
  Widget build(BuildContext context) {
    
  final TextEditingController firstname = TextEditingController(text: widget.userModel.firstname);
  final TextEditingController lastname= TextEditingController(text: widget.userModel.lastname);
  final TextEditingController email = TextEditingController(text: widget.userModel.email);
  final TextEditingController company = TextEditingController(text: widget.userModel.company);
  final TextEditingController address = TextEditingController(text: widget.userModel.address);
    return AlertDialog(
      title: Text('Enter Details'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              controller: firstname,
              decoration: InputDecoration(
                labelText: 'firstname',
              ),
              onChanged: (value) {
                widget.userModel.firstname = value ;
              },
            ),
            TextField(
              controller: lastname,
              decoration: InputDecoration(
                labelText: 'lastname',
              ),
              onChanged: (value) {
                widget.userModel.lastname = value ;
              },
            ),
            TextField(
              controller: email,
              decoration: InputDecoration(
                labelText: 'email',
              ),
              onChanged: (value) {
                widget.userModel.email = value ;
              },
            ),
            TextField(
              controller: company,
              decoration: InputDecoration(
                labelText: 'company',
              ),
              onChanged: (value) {
                widget.userModel.company = value ;
              },
            ),
            TextField(
              controller: address,
              decoration: InputDecoration(
                labelText: 'address',
              ),
              onChanged: (value) {
                widget.userModel.address = value ;
              },
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            UsersListProvider provider = UsersListProvider() ; 
            provider.updateData(widget.userModel);
            Navigator.of(context).pop();
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}
