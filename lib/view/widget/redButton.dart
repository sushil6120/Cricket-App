import 'package:flutter/material.dart';
import 'package:you_got_world/themes/colors.dart';

class RedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  bool? isLoading;

  RedButton(
      {Key? key, required this.onPressed, required this.text, this.isLoading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 0,

        foregroundColor: Colors.white,
        backgroundColor: primaryColor, // Set the text color to white
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      child: isLoading == true
          ? SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
                color: colorLightWhite,
              ),
          )
          : Text(
              text,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
    );
  }
}
