import 'package:elearning_provider/UI/Pages/EditProfilePage/EditProfilePage.dart';
import 'package:elearning_provider/UI/Widgets/confirmation_popup.dart';
import 'package:elearning_provider/providers/EditProfileProvider.dart';
import 'package:elearning_provider/providers/users_list_provider.dart';
import 'package:flutter/material.dart';

import '../../models/UserModel.dart';

class MyPopup extends StatefulWidget {
  final UserModel userModel;
  const MyPopup({Key? key, required this.userModel}) : super(key: key);

  @override
  _MyPopupState createState() => _MyPopupState();
}

class _MyPopupState extends State<MyPopup> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController firstname =
        TextEditingController(text: widget.userModel.firstname);
    final TextEditingController lastname =
        TextEditingController(text: widget.userModel.lastname);
    final TextEditingController email =
        TextEditingController(text: widget.userModel.email);
    final TextEditingController company =
        TextEditingController(text: widget.userModel.company);
    final TextEditingController address =
        TextEditingController(text: widget.userModel.address);
    return AlertDialog(
      title: const Text('Enter Details'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              controller: firstname,
              decoration: const InputDecoration(
                labelText: 'firstname',
              ),
              onChanged: (value) {
                widget.userModel.firstname = value;
              },
            ),
            TextField(
              controller: lastname,
              decoration: const InputDecoration(
                labelText: 'lastname',
              ),
              onChanged: (value) {
                widget.userModel.lastname = value;
              },
            ),
            TextField(
              controller: email,
              decoration: const InputDecoration(
                labelText: 'email',
              ),
              onChanged: (value) {
                widget.userModel.email = value;
              },
            ),
            TextField(
              controller: company,
              decoration: const InputDecoration(
                labelText: 'company',
              ),
              onChanged: (value) {
                widget.userModel.company = value;
              },
            ),
            TextField(
              controller: address,
              decoration: const InputDecoration(
                labelText: 'address',
              ),
              onChanged: (value) {
                widget.userModel.address = value;
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
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            UsersListProvider provider = UsersListProvider();
            provider.updateData(widget.userModel);
            Navigator.of(context).pop();
                  showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          const ConfirmationPopUp(
                            text: "User has been updated succesfuly",
                          ));
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
