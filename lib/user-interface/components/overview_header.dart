import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:theteam_gyp/user-interface/constans/app_constants.dart';

class OverviewHeader extends StatelessWidget {
  const OverviewHeader({
    required this.onSelected,
    this.axis = Axis.horizontal,
    Key? key,
  }) : super(key: key);

  final Function(String trainingCategory) onSelected;
  final Axis axis;
  @override
  Widget build(BuildContext context) {
    // String trainingCategory = "all";
    final Rx<String> trainingCategory = Rx("");

    return Obx(
      () => (axis == Axis.horizontal)
          ? Row(
              children: [
                const Text(
                  "Available Trainings",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const Spacer(),
                ..._listButton(
                    trainingCategory: trainingCategory.value,
                    onSelected: (value) {
                      trainingCategory.value = value;
                      onSelected(value);
                    },
                    context: context)
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Available Trainings",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Row(
                    children: _listButton(
                        trainingCategory: trainingCategory.value,
                        onSelected: (value) {
                          trainingCategory.value = value;
                          onSelected(value);
                        },
                        context: context),
                  ),
                ),
              ],
            ),
    );
  }

  List<Widget> _listButton(
      {required String trainingCategory,
      required Function(String value) onSelected,
      required BuildContext context}) {
    return [
      _button(
          selected: trainingCategory == "",
          label: "All",
          onPressed: () {
            trainingCategory = "";
            onSelected("");
            print("#### $trainingCategory");
          },
          context: context),
      _button(
          selected: trainingCategory == "agile",
          label: "Agile",
          onPressed: () {
            trainingCategory = "agile";
            onSelected("agile");
            print("#### $trainingCategory");
          },
          context: context),
      _button(
          selected: trainingCategory == "devops",
          label: "Dev. OPS",
          onPressed: () {
            trainingCategory = "devops";
            onSelected("devops");
            print("#### $trainingCategory");
          },
          context: context),
      _button(
          selected: trainingCategory == "business",
          label: "Business",
          onPressed: () {
            trainingCategory = "business";
            onSelected("business");
            print("#### $trainingCategory");
          },
          context: context),
    ];
  }

  Widget _button(
      {required bool selected,
      required String label,
      required Function() onPressed,
      required BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: selected
              ? Theme.of(context).cardColor
              : Theme.of(context).canvasColor,
          onPrimary: selected ? kFontColorPallets[0] : kFontColorPallets[2],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(
          label,
        ),
      ),
    );
  }
}
