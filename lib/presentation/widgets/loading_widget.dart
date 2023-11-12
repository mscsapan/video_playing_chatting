import 'package:flutter/material.dart';

import '../utils/constraints.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key, this.color = blueColor});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(color: color),
    );
  }
}
