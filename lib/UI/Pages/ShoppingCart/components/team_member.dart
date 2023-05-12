import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class _TeamMember extends StatelessWidget {
  const _TeamMember({
    required this.totalMember,
    required this.onPressedAdd,
    Key? key,
  }) : super(key: key);

  final int totalMember;
  final Function() onPressedAdd;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RichText(
          text: TextSpan(
            style: const TextStyle(
              fontWeight: FontWeight.bold,

              // const kFontColorPallets = [
              //   Color.fromRGBO(255, 255, 255, 1),
              //   Color.fromRGBO(210, 210, 210, 1),
              //   Color.fromRGBO(170, 170, 170, 1),
              // ];
              color: Color.fromRGBO(255, 255, 255, 1),
            ),
            children: [
              const TextSpan(text: "Team Member "),
              TextSpan(
                text: "($totalMember)",
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Color.fromRGBO(170, 170, 170, 1),
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        IconButton(
          onPressed: onPressedAdd,
          icon: const Icon(EvaIcons.plus),
          tooltip: "add member",
        )
      ],
    );
  }
}
