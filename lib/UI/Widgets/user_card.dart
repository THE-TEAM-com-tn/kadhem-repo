import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/UserModel.dart';
import '../../models/user_model.dart';
import '../../providers/user_crud_model.dart';
import '../Pages/users/modify_user.dart';
/*import '../Pages/users/modify_user.dart';*/

class UserCard extends StatelessWidget {
  final User user;
  const UserCard({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserCRUDModel>(context);

    return GestureDetector(
      onTap: () {
 /*       Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => ModifyUser(user: user)),
        );*/
      },

      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Card(
          child: ListTile(

            leading: Image.network(
              'https://i.imgur.com/a73xXCl.png',
              height: 200,
            ),

            title: Text("User: ${user.firstname} ${user.lastname}"),

            subtitle: Container(
              child: (Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Email: ${user.userEmail}",
                    style: const TextStyle(fontSize: 14),
                  ),
                  Text(
                    "Role: ${user.role.toString().split('.').last}",
                    style: const TextStyle(fontSize: 14),

                  ),
                ],
              )),
            ),

            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[

                IconButton(
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.blue,
                  ),
                  onPressed: () {

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ModifyUser(user: user),
                      ),
                    );


                    },
                ),

                IconButton(
                  icon: const Icon(
                    Icons.delete_forever,
                    color: Colors.red,
                  ),

                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Confirm'),
                          content: const Text('Are you sure you want to delete this user?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('No'),
                            ),
                          TextButton(
                              onPressed: () async {

                                await userProvider.removeUser(user.userId);
                                Navigator.pop(context);
                              },

                              child: const Text('Yes'),
                            ),
                          ],
                        );
                      },
                    );
                  },

                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
