// ignore_for_file: unnecessary_null_comparison
import 'package:elearning_provider/UI/Widgets/InputWidget.dart';
import 'package:elearning_provider/models/UserModel.dart';
import 'package:elearning_provider/providers/EditProfileProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dob_input_field/dob_input_field.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';

import 'EditProfilePageModel.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late EditProfilePageModel _model;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _model = EditProfilePageModel();
    _model.yourNameController ??= TextEditingController();
    _model.emailAddressController ??= TextEditingController();
    _model.myBioController ??= TextEditingController();
    _model.phoneNumberController ??= TextEditingController();
    _model.addressController ??= TextEditingController();
    _model.companyController ??= TextEditingController();
    _model.lastNameController ??= TextEditingController();
    _model.birthDateController ??= TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("EditProfilePage"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Consumer<EditProfileProvider>(
            builder: (context, value, child) {
              if (value.loading == true) {
                value.fetchData('KkaQAl8KEKXQkpacZFWp');
              }
              if (value.documentSnapshot == null) {
                return const CircularProgressIndicator();
              } else {
                _model.birthDateController!.text = userModel.birthDate;
                final Map<String, dynamic> doc =
                    value.documentSnapshot!.data() as Map<String, dynamic>;
                return Form(
                  key: _formKey,
                  child: Column(children: [
                    Container(
                      width: 90.0,
                      height: 90.0,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: !value.imageUpdating
                          ? Image.network(
                              userModel.profilePicture,
                              fit: BoxFit.fitWidth,
                            )
                          : const CircularProgressIndicator(),
                    ),
                    Row(children: [
                      // Update Image
                      IconButton(
                          onPressed: () async {
                            final ImagePicker picker = ImagePicker();
                            XFile? image = await picker.pickImage(
                                source: ImageSource.camera);
                            if (image != null) {
                              final bytes = await image.readAsBytes();
                              final name = image.path.split('/').last;
                              value.updateImage(name, bytes);
                            }
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.green,
                          )),
                      const SizedBox(
                        width: 50,
                      ),
                      // Delete Image
                      IconButton(
                          onPressed: () {
                            value.defaultImage("KkaQAl8KEKXQkpacZFWp");
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          )),
                    ]),
                    // FIrst Name
                    Expanded(
                      child: InputWidget(
                        obcure: false,
                        validator: (value) {
                          if (_model.yourNameControllerValidator(value) != null )
                          {return _model.yourNameControllerValidator(value) ;}
                          return null ;  
                        },
                        model: _model.yourNameController,
                        text: 'First Name',
                        initialValue: doc['first_name'],
                        enabled: true,
                        maxLines: 1,
                        onChanged: (value) {
                          userModel.firstname = value;
                        },
                      ),
                    ),
                    // LastName
                    Expanded(
                      child: InputWidget(
                        obcure: false,
                        validator:  (value) {
                          if (_model.lastNameControllerValidator(value) != null )
                          {return _model.lastNameControllerValidator(value) ;}
                          return null ;  
                        },
                        model: _model.lastNameController,
                        text: 'Last Name',
                        initialValue: doc['last_name'],
                        enabled: true,
                        maxLines: 1,
                        onChanged: (value) {
                          userModel.lastname = value;
                        },
                      ),
                    ),
                    //email
                    Expanded(
                      child: InputWidget(
                        obcure: false,
                        validator: (value) {
                          if (_model.emailAddressControllerValidator(value) != null )
                          {return _model.emailAddressControllerValidator(value) ;}
                          return null ;  
                        },
                        model: _model.emailAddressController,
                        text: 'Email',
                        initialValue: doc['email'],
                        enabled: true,
                        maxLines: 1,
                        onChanged: (value) {
                          userModel.email = value;
                        },
                      ),
                    ),
                    //phone_number
                    Expanded(
                      child: InputWidget(
                          obcure: false,
                          validator: (value) {
                          if (_model.phoneNumberControllerValidator(value) != null )
                          {return _model.phoneNumberControllerValidator(value) ;}
                          return null ;  
                        },
                          model: _model.phoneNumberController,
                          text: 'Phone Number',
                          initialValue: doc['phone_number'],
                          enabled: true,
                          maxLines: 1,
                          onChanged: (value) {
                            userModel.phoneNumber = value;
                          }),
                    ),
                    //company
                    Expanded(
                      child: InputWidget(
                        obcure: false,
                        validator: (value) {
                          if (_model.companyControllerValidator(value) != null )
                          {return _model.companyControllerValidator(value) ;}
                          return null ;  
                        },
                        model: _model.companyController,
                        text: 'Company',
                        initialValue: doc['company'],
                        enabled: true,
                        maxLines: 1,
                        onChanged: (value) {
                          userModel.company = value;
                        },
                      ),
                    ),
                    //address
                    Expanded(
                      child: InputWidget(
                        obcure: false,
                        validator: (value) {
                          if (_model.addressControllerValidator(value) != null )
                          {return _model.addressControllerValidator(value) ;}
                          return null ;  
                        },
                        model: _model.addressController,
                        text: 'Address',
                        initialValue: doc['address'],
                        enabled: true,
                        maxLines: 1,
                        onChanged: (value) {
                          userModel.address = value;
                        },
                      ),
                    ),
                    //bio
                    Expanded(
                      child: InputWidget(
                        obcure: false,
                        validator: (value) {
                          if (_model.birthDateControllerValidator(value) != null )
                          {return _model.birthDateControllerValidator(value) ;}
                          return null ;  
                        },
                        model: _model.myBioController,
                        text: 'bio',
                        initialValue: doc['bio'],
                        enabled: true,
                        maxLines: 3,
                        onChanged: (value) {
                          userModel.bio = value;
                        },
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                          onTap: () async {
                            //  DateTime now = new DateTime.now();
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1950),
                                lastDate: DateTime.now());
                            if (pickedDate != null) {
                              String formattedDate =
                                  DateFormat('yyyy-MM-dd').format(pickedDate);
                              userModel.birthDate = formattedDate;
                              _model.birthDateController!.text = formattedDate;
                            }
                          },
                          enabled: true,
                          readOnly: true,
                          controller: _model.birthDateController,
                          validator: _model.birthDateControllerValidator),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          final form = _formKey.currentState;
                          if (form!.validate()) {
                            value.updateData(userModel);
                          }
                        },
                        child: const Text('save')),
                    ElevatedButton(
                        onPressed: () async {
                          Navigator.pop(context);
                        },
                        child: const Text('cancel'))
                  ]),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
