import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elearning_provider/UI/Pages/users/add_user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/user_model.dart';
import '../../../providers/user_crud_model.dart';
import '../../Widgets/user_card.dart';

class ListUsers extends StatefulWidget {
  const ListUsers({Key? key}) : super(key: key);

  @override
  _ListUsersState createState() => _ListUsersState();
}

class _ListUsersState extends State<ListUsers> {
  late List<User> users = [];


  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserCRUDModel>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[200], // Set the background color to transparent
        elevation: 0,
        title: const Text("Users Management"),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => const AddUserPage()));
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
      body: StreamBuilder(
          stream: userProvider.fetchUsersAsStream(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              users = snapshot.data!.docs
                  .map((doc) => User.fromJson(
                  doc.data() as Map<String, dynamic>, doc.id)) //
                  .toList();
              return ListView.builder(
                itemCount: users.length,
                itemBuilder: (buildContext, index) =>
                    UserCard(user: users[index]),
              );
            } else {
              return const Text('Fetching...');
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const AddUserPage()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
