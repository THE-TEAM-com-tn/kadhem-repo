import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:theteam_gyp/core/dashboard_controller.dart';
import 'package:theteam_gyp/user-interface/components/selection_button.dart';
import 'package:theteam_gyp/user-interface/constans/app_constants.dart';

class Sidebar extends StatelessWidget {
  Sidebar({
    Key? key,
    this.indexedIn,
  }) : super(key: key);

  final int? indexedIn;
  DashboardController controller = DashboardController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).cardColor,
      child: SingleChildScrollView(
        controller: ScrollController(),
        child: Column(
          children: [
            const SizedBox(height: kSpacing),
            SelectionButton(
              initialSelected: indexedIn!,
              data: [
                SelectionButtonData(
                  activeIcon: EvaIcons.grid,
                  icon: EvaIcons.gridOutline,
                  label: "Dashboard",
                ),
                SelectionButtonData(
                  activeIcon: EvaIcons.archive,
                  icon: EvaIcons.archiveOutline,
                  label: "Reports",
                ),
                SelectionButtonData(
                  activeIcon: EvaIcons.calendar,
                  icon: EvaIcons.calendarOutline,
                  label: "Calendar",
                ),
                SelectionButtonData(
                  activeIcon: EvaIcons.email,
                  icon: EvaIcons.emailOutline,
                  label: "Email",
                  totalNotif: 20,
                ),
                SelectionButtonData(
                  activeIcon: EvaIcons.person,
                  icon: EvaIcons.personOutline,
                  label: "Profil",
                ),
                SelectionButtonData(
                  activeIcon: EvaIcons.settings,
                  icon: EvaIcons.settingsOutline,
                  label: "Setting",
                ),
              ],
              onSelected: (index, value) {
                if (index == 0) {
                  controller.streamController.add("welcome");
                  print(
                      "##### NAV INDEX ::: $index ${controller.streamController.stream}");
                } else if (index == 1) {
                  controller.streamController.add("cart");
                  print(
                      "##### NAV INDEX ::: $index ${controller.streamController.stream}");
                } else {
                  controller.streamController.add("profil");
                  print(
                      "##### NAV INDEX ::: $index ${controller.streamController.stream}");
                }
                print(
                    "##### LOG ::: sidebar => SelectionButton onSelected() ::: $index ${value.label}");
                var indexx = index;
                switch (indexx) {
                  case 5:
                    return Navigator.pushReplacementNamed(context, '/settings');
                  case 0:
                    return Navigator.pushReplacementNamed(context, '/');
                  default:
                    return null;
                }
              },
            ),
            const Divider(thickness: 1),
            const SizedBox(height: kSpacing * 2),
            // const Divider(thickness: 1),
            // const SizedBox(height: kSpacing * 2),
            // UpgradePremiumCard(
            //   backgroundColor: Theme.of(context).canvasColor.withOpacity(.4),
            //   onPressed: () {},
            // ),
            // const SizedBox(height: kSpacing),
          ],
        ),
      ),
    );
  }
}
