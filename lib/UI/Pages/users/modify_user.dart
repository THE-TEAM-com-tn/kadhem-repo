import 'package:elearning_provider/UI/Pages/users/list_users.dart';
import 'package:elearning_provider/providers/user_crud_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/user_model.dart';
import '../../Widgets/G_text_form_field.dart';

class ModifyUser extends StatefulWidget {
  final User user;

  const ModifyUser({required this.user});

  @override
  _ModifyUserState createState() => _ModifyUserState();
}

class _ModifyUserState extends State<ModifyUser> {
  final _formKey = GlobalKey<FormState>();

  late String firstname;
  late String lastname;
  late String email;
  late String profilePicture;
  late String company;
  late String role;

/*  @override
  void initState() {
    super.initState();
    firstname = widget.user.firstname;
    lastname = widget.user.lastname;
    email = widget.user.email;
    profilePicture = widget.user.profilePicture;
    company = widget.user.company;
    role = widget.user.role as String;
  }*/

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserCRUDModel>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[200],
        elevation: 0,
        title: const Center(
          child: Text('Modify User Details'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.all(25.0),
            child: Center(
              child: Column(
                children: <Widget>[
                  GTextFormField(
                    initVal: firstname,
                    ifEmpty: "First Name is required",
                    onSaved: (value) => firstname = value!,
                    hint: "First Name",
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  GTextFormField(
                    initVal: lastname,
                    ifEmpty: "Last Name is required",
                    onSaved: (value) => lastname = value!,
                    hint: "Last Name",
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  GTextFormField(
                    initVal: email,
                    ifEmpty: "Email is required",
                    onSaved: (value) => email = value!,
                    hint: "Email",
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  GTextFormField(
                    initVal: profilePicture,
                    ifEmpty: "Profile Picture URL is required",
                    onSaved: (value) => profilePicture = value!,
                    hint: "Profile Picture URL",
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  GTextFormField(
                    initVal: company,
                    ifEmpty: "Company is required",
                    onSaved: (value) => company = value!,
                    hint: "Company",
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  DropdownButtonFormField(
                    value: role,
                    items: [
                      DropdownMenuItem(
                        value: UserRole.admin.toString(),
                        child: const Text("Admin"),
                      ),
                      DropdownMenuItem(
                        value: UserRole.trainer.toString(),
                        child: const Text("Trainer"),
                      ),
                      DropdownMenuItem(
                        value: UserRole.contentManager.toString(),
                        child: const Text("Content Manager"),
                      ),
                      DropdownMenuItem(
                        value: UserRole.normalUser.toString(),
                        child: const Text("Normal User"),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        role = value.toString();
                      });
                    },
                    onSaved: (value) => role = value.toString(),
                    decoration: InputDecoration(
                      hintText: "Role",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        User updatedUser = User(
                          id: widget.user.id,
                          firstname: firstname,
                          lastname: lastname,
                          email: widget.user.email,
                          profilePicture: profilePicture,
                          company: company,
                          role: role as UserRole,
                        );
                        await userProvider.updateUser(updatedUser, firstname,
                            lastname, company, role as UserRole);
                        Navigator.pop(context);
                      }
                    },
                    child: const Text(
                      'Update User',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
