import 'package:flutter/material.dart';

class ActiveProjectCard extends StatelessWidget {
  const ActiveProjectCard({
    required this.child,
    required this.onPressedSeeAll,
    Key? key,
  }) : super(key: key);

  final Widget child;
  final Function() onPressedSeeAll;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        // const kBorderRadius = 20.0;
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        // const kSpacing = 20.0;
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _title("My Active Project"),
                _seeAllButton(onPressed: onPressedSeeAll),
              ],
            ),
            const Divider(
              thickness: 1,
              height: 20.0,
            ),
            const SizedBox(height: 20.0),
            child,
          ],
        ),
      ),
    );
  }

  Widget _title(String value) {
    return Text(
      value,
      style: const TextStyle(fontWeight: FontWeight.bold),
    );
  }

  Widget _seeAllButton({required Function() onPressed}) {
    return TextButton(
      onPressed: onPressed,

      // const kFontColorPallets = [
      //   Color.fromRGBO(255, 255, 255, 1),
      //   Color.fromRGBO(210, 210, 210, 1),
      //   Color.fromRGBO(170, 170, 170, 1),
      // ];
      style:
          TextButton.styleFrom(primary: const Color.fromRGBO(210, 210, 210, 1)),
      child: const Text("See All"),
    );
  }
}
