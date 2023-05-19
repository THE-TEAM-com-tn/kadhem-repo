// import 'package:elearning_provider/UI/Pages/ChangePasswodPage/ChangePasswordPageModel.dart';
// import 'package:elearning_provider/models/PasswordChangeModel.dart';
// import 'package:elearning_provider/models/UserModel.dart';
// import 'package:elearning_provider/providers/PasswordChangeProvider.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:provider/provider.dart';

// import '../../Widgets/InputWidget.dart';
// import '../../Widgets/nav_bar.dart';

// class ChangePasswordPage extends StatefulWidget {
//   const ChangePasswordPage({super.key});

//   @override
//   State<ChangePasswordPage> createState() => _ChangePasswordPageState();
// }

// class _ChangePasswordPageState extends State<ChangePasswordPage> {
//   late ChangePasswordPageModel _model;
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   @override
//   void initState() {
//     _model = ChangePasswordPageModel();
//     _model.oldPasswordController = TextEditingController();
//     _model.newPasswordController = TextEditingController();
//     _model.confirmPasswordController = TextEditingController();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final PasswordChangeProvider passwordChangeProvider =
//         Provider.of<PasswordChangeProvider>(context, listen: true);
//     return Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.deepPurple[200],
//           elevation: 0,
//           title: const Center(
//             child: Text('Change Password Page'),
//           ),
//         ),

//         body: Center(
//           child: SingleChildScrollView(
//               scrollDirection: Axis.vertical,
//               child: SizedBox(child: Consumer<PasswordChangeProvider>(
//                   builder: (context, value, child) {
//                 return SizedBox(
//                   /*width: MediaQuery.of(context).size.width,
//                   height: MediaQuery.of(context).size.height/2,*/
//                   width: MediaQuery.of(context).size.width * 0.8,
//                   height: MediaQuery.of(context).size.height * 0.7,
//                   child: Form(
//                       key: _formKey,
//                       child: Column(children: [
//                         const SizedBox(height: 5),
//                         Image.network(
//                           'https://cdn-icons-png.flaticon.com/512/9710/9710280.png',
//                           height: 80,
//                           width: 80,
//                         ),

//                         const SizedBox(height: 5),

//                         const Text(
//                           'Change your password',
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(height: 8),

//                         // old password
//                         Expanded(
//                           child: InputWidget(
//                             obcure: true,
//                             validator: _model.oldPasswordControllerValidator,
//                             model: _model.oldPasswordController,
//                             text: 'Old Password',
//                             initialValue: '',
//                             enabled: true,
//                             maxLines: 1,
//                             onChanged: (value) {
//                               passwordChangeModel.oldPassword = value;
//                             },
//                           ),
//                         ),

//                         const SizedBox(height: 8),

//                         // new password
//                         Expanded(
//                           child: InputWidget(
//                             obcure: true,
//                             validator: _model.newPasswordControllerValidator,
//                             model: _model.newPasswordController,
//                             text: 'New Password',
//                             initialValue: '',
//                             enabled: true,
//                             maxLines: 1,
//                             onChanged: (v) {
//                               passwordChangeModel.newPassword = v;
//                               value.verifyRequirements(v);
//                             },
//                           ),
//                         ),
//                         // confirm password
                       
//                         const SizedBox(height: 8),
//                         Expanded(
//                           child: InputWidget(
//                             obcure: true,
//                             validator:
//                                 _model.confirmPasswordControllerValidator,
//                             model: _model.confirmPasswordController,
//                             text: 'Confirm Password',
//                             initialValue: '',
//                             enabled: true,
//                             maxLines: 1,
//                             onChanged: (value) {
//                               passwordChangeModel.confirmPassword = value;
//                             },
//                           ),
//                         ),
//                         const SizedBox(height: 8),

//                         /// CONFLICT HERE !!!


//                         // Save Button
//                         ElevatedButton(
//                           onPressed: () async {
//                             if (_formKey.currentState!.validate()) {
//                               final userId = FirebaseAuth.instance.currentUser!.uid;
//                               String result = await passwordChangeProvider.updatePassword(
//                                 passwordChangeModel,
//                                 userId,
//                               );
//                               SnackBar snackBar = SnackBar(content: Text(result));
//                               ScaffoldMessenger.of(context).showSnackBar(snackBar);
//                             }
//                           },
//                           child: const Text('Save'),
//                         ),




//                         /// CONFLICT HERE - end !!!

//                         const SizedBox(height: 15),

//                         // Requirements
//                         Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             const SizedBox(height: 5),
//                             Row(
//                               children: const [
//                                 Text(
//                                   "The new password should have :",
//                                   textAlign: TextAlign.start,
//                                 ),
//                               ],
//                             ),
//                             Row(
//                               children: [
//                                 value.lower
//                                     ? const Icon(
//                                         Icons.verified_user_outlined,
//                                         color: Colors.green,
//                                       )
//                                     : const Text(""),
//                                 Text(
//                                   "At least 1 LowerCase characters",
//                                   style: TextStyle(
//                                       color: value.lower
//                                           ? Colors.green
//                                           : Colors.black),
//                                 ),
//                               ],
//                             ),
//                             Row(
//                               children: [
//                                 value.upper
//                                     ? const Icon(
//                                         Icons.verified_user_outlined,
//                                         color: Colors.green,
//                                       )
//                                     : const Text(""),
//                                 Text(
//                                   "At least 1 UpperCase characters",
//                                   style: TextStyle(
//                                       color: value.upper
//                                           ? Colors.green
//                                           : Colors.black),
//                                 ),
//                               ],
//                             ),
//                             Row(
//                               children: [
//                                 value.symbol
//                                     ? const Icon(
//                                         Icons.verified_user_outlined,
//                                         color: Colors.green,
//                                       )
//                                     : const Text(""),
//                                 Text(
//                                   "At least 1 Symbol characters",
//                                   style: TextStyle(
//                                       color: value.symbol
//                                           ? Colors.green
//                                           : Colors.black),
//                                 ),
//                               ],
//                             ),
//                             Row(
//                               children: [
//                                 value.number
//                                     ? const Icon(
//                                         Icons.verified_user_outlined,
//                                         color: Colors.green,
//                                       )
//                                     : const Text(""),
//                                 Text(
//                                   "At least 1 number characters",
//                                   style: TextStyle(
//                                       color: value.number
//                                           ? Colors.green
//                                           : Colors.black),
//                                 ),
//                               ],
//                             ),
//                             Row(
//                               children: [
//                                 value.length
//                                     ? const Icon(
//                                         Icons.verified_user_outlined,
//                                         color: Colors.green,
//                                       )
//                                     : const Text(""),
//                                 Text(
//                                   "At least 8 characters",
//                                   style: TextStyle(
//                                       color: value.length
//                                           ? Colors.green
//                                           : Colors.black),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ])),
//                 );
//               }))),
//         ));
//   }
// }
