import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:theteam_gyp/core/dashboard_controller.dart';
import 'package:theteam_gyp/core/models/UserModel.dart';
import 'package:theteam_gyp/core/models/profile_model.dart';
import 'package:theteam_gyp/user-interface/components/InputWidget.dart';

import 'EditProfilePageModel.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late EditProfilePageModel _model;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  DashboardController controller = DashboardController();

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
    return SizedBox(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: FutureBuilder(
              future: controller.getUserDetails(),
              builder:
                  (BuildContext context, AsyncSnapshot<ProfileModel> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            // Profile Picture
                            Container(
                                width: 90.0,
                                height: 90.0,
                                clipBehavior: Clip.antiAlias,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: Image.network(
                                  snapshot.data!.photo,
                                  fit: BoxFit.fitWidth,
                                )),
                            const SizedBox(height: 16.0),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     // Update Image
                            //     IconButton(
                            //       onPressed: () async {
                            //         final ImagePicker picker = ImagePicker();
                            //         XFile? image = await picker.pickImage(
                            //           source: ImageSource.gallery,
                            //         );
                            //         if (image != null) {
                            //           final bytes = await image.readAsBytes();
                            //           final name = image.path.split('/').last;
                            //           value.updateImage(name, bytes);
                            //         }
                            //       },
                            //       icon: const Icon(
                            //         Icons.edit,
                            //         color: Colors.green,
                            //       ),
                            //     ),
                            //     const SizedBox(
                            //       width: 50,
                            //     ),
                            //     // Delete Image
                            //     IconButton(
                            //       onPressed: () {
                            //         value.defaultImage(userModel.userId);
                            //       },
                            //       icon: const Icon(
                            //         Icons.delete,
                            //         color: Colors.red,
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            const SizedBox(
                              height: 16.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
// First Name Input Field
                                Expanded(
                                  child: InputWidget(
                                    obcure: false,
                                    validator: (value) {
                                      if (_model.yourNameControllerValidator(
                                              value) !=
                                          null) {
                                        return _model
                                            .yourNameControllerValidator(value);
                                      }
                                      return null;
                                    },
                                    model: _model.yourNameController,
                                    text: 'Name',
                                    initialValue: snapshot.data!.name ?? '',
                                    enabled: true,
                                    maxLines: 1,
                                    onChanged: (value) {
                                      userModel.firstname = value;
                                    },
                                  ),
                                ),
                                const SizedBox(width: 8.0),
                              ],
                            ),
                            const SizedBox(height: 16.0),
// Email Input Field
                            InputWidget(
                              obcure: false,
                              validator: (value) {
                                if (_model.emailAddressControllerValidator(
                                        value) !=
                                    null) {
                                  return _model
                                      .emailAddressControllerValidator(value);
                                }
                                return null;
                              },
                              model: _model.emailAddressController,
                              text: 'Email',
                              initialValue: snapshot.data!.email ?? '',
                              enabled: true,
                              maxLines: 1,
                              onChanged: (value) {
                                userModel.email = value;
                              },
                            ),
                            const SizedBox(height: 16.0),
// Phone Number Input Field
                            InputWidget(
                              obcure: false,
                              validator: (value) {
                                if (_model.phoneNumberControllerValidator(
                                        value) !=
                                    null) {
                                  return _model
                                      .phoneNumberControllerValidator(value);
                                }
                                return null;
                              },
                              model: _model.phoneNumberController,
                              text: 'Phone Number',
                              initialValue: snapshot.data!.phone ?? '',
                              enabled: true,
                              maxLines: 1,
                              onChanged: (value) {
                                userModel.phoneNumber = value;
                              },
                            ),
                            const SizedBox(height: 16.0),
// Company Input Field
                            InputWidget(
                              obcure: false,
                              validator: (value) {
                                if (_model.companyControllerValidator(value) !=
                                    null) {
                                  return _model
                                      .companyControllerValidator(value);
                                }
                                return null;
                              },
                              model: _model.companyController,
                              text: 'Company',
                              initialValue: snapshot.data!.company ?? '',
                              enabled: true,
                              maxLines: 1,
                              onChanged: (value) {
                                userModel.company = value;
                              },
                            ),
                            const SizedBox(height: 16.0),
// Address Input Field
                            InputWidget(
                              obcure: false,
                              validator: (value) {
                                if (_model.addressControllerValidator(value) !=
                                    null) {
                                  return _model
                                      .addressControllerValidator(value);
                                }
                                return null;
                              },
                              model: _model.addressController,
                              text: 'Address',
                              initialValue: snapshot.data!.address ?? '',
                              enabled: true,
                              maxLines: 1,
                              onChanged: (value) {
                                userModel.address = value;
                                value;
                              },
                            ),
                            const SizedBox(height: 16.0),
                            // Bio Input Field
                            InputWidget(
                              obcure: false,
                              validator: (value) {
                                if (_model
                                        .birthDateControllerValidator(value) !=
                                    null) {
                                  return _model
                                      .birthDateControllerValidator(value);
                                }
                                return null;
                              },
                              model: _model.myBioController,
                              text: 'Bio',
                              initialValue: snapshot.data!.bio ?? '',
                              enabled: true,
                              maxLines: 3,
                              onChanged: (value) {
                                userModel.bio = value;
                              },
                            ),
                            const SizedBox(height: 16.0),
                            // BirthDate Input Field
                            TextFormField(
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1950),
                                  lastDate: DateTime.now(),
                                );
                                if (pickedDate != null) {
                                  String formattedDate =
                                      DateFormat('yyyy-MM-dd')
                                          .format(pickedDate);
                                  userModel.birthDate = formattedDate;
                                  _model.birthDateController!.text =
                                      formattedDate;
                                }
                              },
                              enabled: true,
                              readOnly: true,
                              decoration: const InputDecoration(
                                labelText: "Birth Date",
                              ),
                              controller: _model.birthDateController,
                              validator: _model.birthDateControllerValidator,
                            ),
                            const SizedBox(height: 16.0),
                            Container(
                                height: 35,
                                width: 120,
                                color: Colors.green,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.green)),
                                  onPressed: () async {
                                    final form = _formKey.currentState;
                                    // if (form!.validate()) {
                                    //   if (await value.updateData(userModel)) {
                                    //     SnackBar snackBar = const SnackBar(
                                    //       content:
                                    //           Text("Your data has been updated!"),
                                    //     );
                                    //     ScaffoldMessenger.of(context)
                                    //         .showSnackBar(snackBar);
                                    //   } else {
                                    //     SnackBar snackBar = const SnackBar(
                                    //       content: Text(
                                    //         "The email you wrote already exists.",
                                    //       ),
                                    //     );
                                    //     ScaffoldMessenger.of(context)
                                    //         .showSnackBar(snackBar);
                                    //   }
                                    // }
                                  },
                                  child: const Text('Save'),
                                )),
                            const SizedBox(height: 16.0),
                            Container(
                                height: 35,
                                width: 120,
                                color: Colors.red,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.red)),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Cancel'),
                                )),
                          ],
                        ),
                      ),
                    );
                  }
                } else {
                  return const CircularProgressIndicator();
                }
              }),
        ),
      ),
    );
  }
}
