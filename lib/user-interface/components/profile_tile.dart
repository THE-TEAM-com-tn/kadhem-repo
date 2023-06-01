import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:theteam_gyp/core/models/profile_model.dart';
import 'package:theteam_gyp/user-interface/screens/login_screen.dart';
import 'package:badges/badges.dart' as badges;
import 'package:theteam_gyp/user-interface/themes/model_theme.dart';
import '../../admin-interface/register_page.dart';

class ProfilTile extends StatelessWidget {
  const ProfilTile(
      {this.data, Key? key, required this.isLogged, required this.onPressCart})
      : super(key: key);

  final ProfileModel? data;
  final bool isLogged;
  final void Function() onPressCart;

  @override
  Widget build(BuildContext context) {
    return (isLogged)
        ? Consumer<ModelTheme>(
            builder: (context, ModelTheme themeNotifier, child) {
            return Row(
              children: [
                Expanded(
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    leading: CircleAvatar(
                        backgroundImage: NetworkImage(data!.photo)),
                    title: Text(
                      data!.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      data!.email,
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
                  ),
                ),
                IconButton(
                    icon: Icon(themeNotifier.isDark
                        ? Icons.nightlight_round
                        : Icons.wb_sunny),
                    onPressed: () {
                      themeNotifier.isDark
                          ? themeNotifier.isDark = false
                          : themeNotifier.isDark = true;
                    })
              ],
            );
          })
        : Consumer<ModelTheme>(
            builder: (context, ModelTheme themeNotifier, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: const Text('Log In')),
                const SizedBox(
                  width: 10,
                ),
                FilledButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegisterPage(onTap: () {})),
                    );
                  },
                  child: const Text('Join for Free'),
                ),
                IconButton(
                    icon: Icon(themeNotifier.isDark
                        ? Icons.nightlight_round
                        : Icons.wb_sunny),
                    onPressed: () {
                      themeNotifier.isDark
                          ? themeNotifier.isDark = false
                          : themeNotifier.isDark = true;
                    })
              ],
            );
          });
  }
}
