import 'package:flutter/material.dart';
import 'package:theteam_gyp/user-interface/components/search_field.dart';
import 'package:theteam_gyp/user-interface/components/today_text.dart';
import 'package:theteam_gyp/user-interface/constans/app_constants.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const TodayText(),
        const SizedBox(width: kSpacing),
        Expanded(child: SearchField()),
      ],
    );
  }
}
