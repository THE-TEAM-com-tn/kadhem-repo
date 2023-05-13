import 'package:elearning_provider/models/profile_model.dart';
import 'package:flutter/material.dart';
import '../../../../models/profile_model.dart';
import 'package:badges/badges.dart' as badges;

class ProfilTile extends StatelessWidget {
  const ProfilTile({required this.data, Key? key, required this.onPressCart})
      : super(key: key);

  final ProfileModel? data;
  final void Function() onPressCart;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      leading: CircleAvatar(backgroundImage: NetworkImage(data!.photo)),
      title: Text(
        data!.name,

        // const kFontColorPallets = [
        //   Color.fromRGBO(255, 255, 255, 1),
        //   Color.fromRGBO(210, 210, 210, 1),
        //   Color.fromRGBO(170, 170, 170, 1),
        // ];
        style:
            const TextStyle(fontSize: 14, color: Color.fromARGB(255, 0, 0, 0)),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        data!.email,
        style: const TextStyle(
            fontSize: 12, color: Color.fromARGB(255, 66, 66, 66)),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: badges.Badge(
        badgeContent: Text(data!.trainings!.length.toString()),
        child: IconButton(
          onPressed: onPressCart,
          icon: const Icon(Icons.shopping_cart),
        ),
      ),
    );
  }
}
