import 'package:elearning_provider/models/profile_model.dart';
import 'package:flutter/material.dart';
import '../../../../models/profile_model.dart';
import 'package:badges/badges.dart' as badges;

class ProfilTile extends StatelessWidget {
  const ProfilTile({required this.data, Key? key, required this.onPressed})
      : super(key: key);

  final ProfileModel? data;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      leading: const CircleAvatar(
          backgroundImage: NetworkImage(
              "https://www.google.com/url?sa=i&url=https%3A%2F%2Fpixabay.com%2Fvectors%2Favatar-icon-placeholder-facebook-1577909%2F&psig=AOvVaw0KHPTH45j0LF1qtQk-Zhp7&ust=1684005195455000&source=images&cd=vfe&ved=0CBEQjRxqFwoTCJiH066-8P4CFQAAAAAdAAAAABAE") /*AssetImage(ImageRasterPath.avatar1)*/),
      title: Text(
        data!.name,

        // const kFontColorPallets = [
        //   Color.fromRGBO(255, 255, 255, 1),
        //   Color.fromRGBO(210, 210, 210, 1),
        //   Color.fromRGBO(170, 170, 170, 1),
        // ];
        style: const TextStyle(
            fontSize: 14, color: Color.fromRGBO(255, 255, 255, 1)),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        data!.email,
        style: const TextStyle(
            fontSize: 12, color: Color.fromRGBO(170, 170, 170, 1)),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: badges.Badge(
        badgeContent: Text(data!.trainings!.length.toString()),
        child: IconButton(
          onPressed: onPressed,
          icon: const Icon(Icons.shopping_cart),
        ),
      ),
    );
  }
}
