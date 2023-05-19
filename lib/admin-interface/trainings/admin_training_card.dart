// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:octo_image/octo_image.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:elearning_provider/utils/mycolors.dart';
// import 'package:provider/provider.dart';
// import 'package:elearning_provider/models/training_model.dart';
// import 'package:elearning_provider/providers/training_crud_model.dart';
// import 'package:elearning_provider/UI/Pages/TrainingDetails/training_deails_page.dart';
// import 'package:elearning_provider/UI/Pages/trainings/modify_training.dart';

// import '../TrainingDetails/admin_training_details_widget.dart';
// // for web view
// import 'package:flutter/foundation.dart' show kIsWeb;

// import 'edit_training_widget.dart';


// class AdminTrainingCard extends StatelessWidget {
//   final Training training;

//   const AdminTrainingCard({Key? key, required this.training}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final trainingProvider = Provider.of<TrainingCRUDModel>(context);

//     return Padding(
//         padding: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),

//         child: Container(
//             decoration: BoxDecoration(
//               color: MyColors.secondaryBackground,
//               boxShadow: const [
//                 BoxShadow(
//                   blurRadius: 3,
//                   color: Color(0x411D2429),
//                   offset: Offset(0, 1),
//                 )
//               ],
//               borderRadius: BorderRadius.circular(8),
//             ),

//             child: Column(
//               children: [
//                 Row(
//                   mainAxisSize: MainAxisSize.max,
//                   children: [

//                     Padding(
//                       padding: const EdgeInsetsDirectional.fromSTEB(5, 1, 1, 1),
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(6),
//                         child: OctoImage(
//                           placeholderBuilder: OctoPlaceholder.blurHash(
//                             'LKN^h]x^^lxHxGWVX5Rj~qMx9Fba',
//                           ),
//                           image: NetworkImage(training.image),
//                           width: MediaQuery.of(context).size.width < 600 ? 80 : 339,
//                           height: MediaQuery.of(context).size.width < 600 ? 80 : 378,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),

//  /*
//  // TEST 2 ( Didn't Work )

//  Padding(
//               padding:  EdgeInsetsDirectional.fromSTEB(5, 1, 1, 1),
//                     child: LayoutBuilder(

//             builder: (BuildContext context, BoxConstraints constraints) {
//               if (constraints.maxWidth < 500) {
//                 return ClipRRect(
//                   borderRadius: BorderRadius.circular(6),
//                   child: OctoImage(
//                     placeholderBuilder: OctoPlaceholder.blurHash(
//                       'LKN^h]x^^lxHxGWVX5Rj~qMx9Fba',
//                     ),
//                     image: NetworkImage(training.image),
//                     width: 339,
//                     height: 378,
//                     fit: BoxFit.cover,
//                   ),
//                 );
//               } else {
//                 return ClipRRect(
//                   borderRadius: BorderRadius.circular(6),
//                   child: OctoImage(
//                     placeholderBuilder: OctoPlaceholder.blurHash(
//                       'LKN^h]x^^lxHxGWVX5Rj~qMx9Fba',
//                     ),
//                     image: NetworkImage(training.image),
//                     width: 100,
//                     height: 100,

//                     *//* width: 339,
//                     height: 378,*//*

//                     fit: BoxFit.cover,
//                   ),
//                 );
//               }
//             },
//           ),
//         ),
// */


//         /*
//                         TEST 1 :     // THIS DIDN'T WORK

//                           Padding(
//                           padding: const EdgeInsetsDirectional.fromSTEB(5, 1, 1, 1),
//                           child: ClipRRect(
//                           borderRadius: BorderRadius.circular(6),
//                           child: OctoImage(
//                             placeholderBuilder: OctoPlaceholder.blurHash(
//                               'LKN^h]x^^lxHxGWVX5Rj~qMx9Fba',
//                             ),
//                             image: NetworkImage(training.image),
//                             width: kIsWeb ? 339 : 80,
//                             height: kIsWeb ? 378 : 80,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),*/


//                   /*  Visibility(
//                       visible: MediaQuery.of(context).size.width > 600,

//                        child:
//                       */
//                       Expanded(
//                         child: Padding(
//                           padding: const EdgeInsetsDirectional.fromSTEB(8, 8, 4, 0),

//                           child: Column(
//                             mainAxisSize: MainAxisSize.max,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(//Training title:
//                                 '${training.title}',
//                                 style: const TextStyle(
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.bold,
//                                   fontFamily: 'Roboto', // Change to your preferred font family
//                                   color: Colors.black87, // Change to your preferred color
//                                 ),
//                                 textAlign: TextAlign.center,
//                                 overflow: TextOverflow.ellipsis,
//                                 maxLines: 2,
//                                 softWrap: true,
//                                 // Add some padding to the text
//                                 //padding:   EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
//                               ),

//                               const SizedBox(height: 5),

//                               Padding(
//                                 padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 8, 0),
//                                 child: AutoSizeText(
//                                   'Author: ${training.author}'
//                                    ?? 'Training Author',
//                                   textAlign: TextAlign.start,
//                                   style: TextStyle(
//                                     fontSize: 13,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.grey[700],
//                                     fontStyle: FontStyle.italic,
//                                   ),
//                                 ),
//                               ),

// /*
//                               const SizedBox(height: 5),

//                               Padding(
//                                 padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 8, 0),
//                                 child: Text(
//                                   '\$${training.price.toStringAsFixed(2)} TND',
//                                   textAlign: TextAlign.start,
//                                   style: const TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
// */

//                               const SizedBox(height: 6),

//                               Wrap(
//                                 spacing: 20.0,
//                                 alignment: WrapAlignment.start,
//                                 children:  [
//                                   ChoiceChip(
//                                     label: Text(
//                                       '${training.price.toStringAsFixed(2)} TND' ?? '??? TND',
//                                       //'Option 1',
//                                       style: const TextStyle(color: Colors.black),
//                                     ),
//                                     avatar: null/* const Icon(Icons.access_alarms_outlined , size: 15)*/,
//                                     selectedColor: MyColors.mygreenMoney,
//                                     labelStyle: const TextStyle(
//                                       color: MyColors.primaryText,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                     backgroundColor: MyColors.accent4,
//                                     selected: true,
//                                   ),
//                                 ],
//                               ),

//                               const SizedBox(height: 6),

//                               Wrap(
//                                 spacing: 20.0,
//                                 alignment: WrapAlignment.start,
//                                 children:  [
//                                   ChoiceChip(
//                                     label: Text(
//                                       training.duration ?? '1 hour',
//                                       //'Option 1',
//                                       style: const TextStyle(color: Colors.black),
//                                     ),
//                                     avatar: const Icon(Icons.access_alarms_outlined , size: 15),
//                                     selectedColor: MyColors.mypurple,
//                                     labelStyle: const TextStyle(
//                                       color: MyColors.primaryText,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                     backgroundColor: MyColors.accent4,
//                                     selected: true,
//                                   ),
//                                 ],
//                               ),

//                               const SizedBox(height: 15),

//                             ],
//                           ),
//                         ),
//                       ),





//                     Column(
//                       mainAxisSize: MainAxisSize.max,
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.end,
//                       children: [

//                         /*  const Padding(
//                           padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
//                           child: Text(
//                             'Click To view Details :',
//                           ),
//                         ),*/
// /*                    IconButton(
//                           icon: const FaIcon(
//                             FontAwesomeIcons.chevronRight,
//                             color: MyColors.primaryText,
//                             size: 30,
//                           ),
//                           onPressed: () {
//                             print('redirect to view training Details ...');
//                           },
//                         ),*/


//                         Row(
//                           mainAxisSize: MainAxisSize.max,
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: [
//                             IconButton(
//                               /* borderColor: Colors.transparent,
//                               borderRadius: 20,
//                               borderWidth: 1,
//                               buttonSize: 40,*/
//                               icon: const FaIcon(
//                                 FontAwesomeIcons.trash,
//                                 color: MyColors.error,
//                                 size: 15,
//                               ),
//                               onPressed: () async {
//                                 final confirmed = await showDialog(
//                                   context: context,
//                                   builder: (BuildContext context) {
//                                     return AlertDialog(
//                                       title: const Text('Confirm Delete'),
//                                       content: const Text('Are you sure you want to delete this training?'),
//                                       actions: [
//                                         TextButton(
//                                           onPressed: () => Navigator.of(context).pop(false),
//                                           child: const Text('CANCEL'),
//                                         ),
//                                         TextButton(
//                                           onPressed: () => Navigator.of(context).pop(true),
//                                           child: const Text('DELETE'),
//                                         ),
//                                       ],
//                                     );
//                                   },
//                                 );

//                                 if (confirmed == true) {
//                                   await trainingProvider.removeTraining(training.id!);
//                                   Navigator.pop(context);
//                                   print('Training deleted successfully');
//                                 }
//                               },
//                             ),



//                             IconButton(
//                               /*  borderColor: Colors.transparent,
//                               borderRadius: 20,
//                               borderWidth: 1,
//                               buttonSize: 40,*/
//                               icon: const FaIcon(
//                                 FontAwesomeIcons.pen,
//                                 color: MyColors.success,
//                                 size: 15,
//                               ),
//                               onPressed: ()  async {
//                                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (_) => AdminEditTrainingWidget(
//                                             training: training)
//                                     ));
//                                 print('Pressed to Edit / Modify Training ...');
//                               },
//                             ),

//                             IconButton(
//                               /*  borderColor: Colors.transparent,
//                               borderRadius: 20,
//                               borderWidth: 1,
//                               buttonSize: 40,*/
//                               icon: const FaIcon(
//                                 FontAwesomeIcons.solidEye,
//                                 color: MyColors.primary,
//                                 size: 15,
//                               ),
//                               onPressed: () async {
//                                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (_) => AdminTrainingDetailsWidget(
//                                             training: training)
//                                     ));
//                                 print('Pressed to View Training Details ...');
//                               },
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ],
//             )
//         )
//     );
//   }
// }
