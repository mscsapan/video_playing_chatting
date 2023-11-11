import 'package:flutter/material.dart';

import 'custom_text.dart';

class FetchErrorText extends StatelessWidget {
  const FetchErrorText({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomText(
        text: text,
        color: Colors.red,
        fontSize: 14.0,
      ),
    );
  }
}
