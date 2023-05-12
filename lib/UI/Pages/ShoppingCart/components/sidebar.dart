import 'package:elearning_provider/UI/Pages/ShoppingCart/components/project_card.dart';
import 'package:elearning_provider/UI/Pages/ShoppingCart/components/selection_button.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({
    required this.data,
    Key? key,
  }) : super(key: key);

  final ProjectCardData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).cardColor,
      child: SingleChildScrollView(
        controller: ScrollController(),
        child: Column(
          children: [
            Padding(
              // kSpacing
              padding: const EdgeInsets.all(20.0),
              child: ProjectCard(
                data: data,
              ),
            ),
            const Divider(thickness: 1),
            SelectionButton(
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
                // log("index : $index | label : ${value.label}");
              },
            ),
            const Divider(thickness: 1),
            // kSpacing
            const SizedBox(height: 20.0 * 2),
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
