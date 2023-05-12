import 'package:elearning_provider/UI/Pages/ShoppingCart/components/search_field.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // const TodayText(),
        const SizedBox(width: 20.0),
        Expanded(child: SearchField()),
      ],
    );
  }
}
