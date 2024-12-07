import 'package:flutter/material.dart';
import 'package:you_got_world/themes/colors.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: primaryColor,
      ),
    );
  }
}
