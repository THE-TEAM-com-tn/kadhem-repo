// import 'package:elearning_provider/UI/Pages/UsersListPage/users_list_model.dart';
// import 'package:elearning_provider/UI/Widgets/user_card.dart';
// import 'package:elearning_provider/providers/users_list_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../../../providers/tag_crud_model.dart';
// import '../../Widgets/InputWidget.dart';
// import '../../Widgets/nav_bar.dart';

// class UsersList extends StatefulWidget {
//   const UsersList({super.key});

//   @override
//   State<UsersList> createState() => UsersListState();
// }

// class UsersListState extends State<UsersList> {
//   late UsersListModel _model;
//   @override
//   void initState() {
//     super.initState();
//     _model = UsersListModel();
//     _model.searchController = TextEditingController();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {},
//         backgroundColor: const Color(0xFF17282E),
//         hoverColor: const Color(0x4D4B986C),
//         child: const Icon(Icons.add),
//       ),
//       body: Consumer<UsersListProvider>(
//         builder: (context, value, child) {
//           var size = MediaQuery.of(context).size;
//           final double itemHeight = (size.height - kToolbarHeight - 24) / 4;
//           final double itemWidth = size.width / 2;
//           if (value.loading) {
//             value.getUsers();
//           }
//           return !value.loading
//               ? Column(
//                   children: [
//                     const SizedBox(
//                       height: 30,
//                     ),
//                     SizedBox(
//                       height: 100,
//                       width: MediaQuery.of(context).size.width / 2,
//                       child: InputWidget(
//                         obcure: false,
//                         validator: _model.SearchValidator,
//                         model: _model.searchController,
//                         text: 'Search for users by name',
//                         initialValue: '',
//                         enabled: true,
//                         maxLines: 1,
//                         onChanged: (query) {
//                           value.filterData(query);
//                         },
//                       ),
//                     ),
//                     Expanded(
//                       child: MediaQuery.of(context).size.width < 1000 ||
//                               MediaQuery.of(context).size.height < 550
//                           ? ListView.builder(
//                               itemCount: value.searchedUsers.length,
//                               itemBuilder: (buildContext, index) => UserCard(
//                                   userModel: value.searchedUsers[index],
//                                   provider: value),
//                             )
//                           : GridView.builder(
//                               gridDelegate:
//                                   SliverGridDelegateWithFixedCrossAxisCount(
//                                       childAspectRatio: itemWidth / itemHeight,
//                                       crossAxisCount: 2),
//                               itemCount: value.searchedUsers.length,
//                               itemBuilder: (buildContext, index) => UserCard(
//                                   userModel: value.searchedUsers[index],
//                                   provider: value),
//                             ),
//                     ),
//                   ],
//                 )
//               : const CircularProgressIndicator();
//         },
//       ),
//     );
//   }
// }
