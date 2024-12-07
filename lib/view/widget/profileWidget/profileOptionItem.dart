import 'package:flutter/material.dart';
import 'package:you_got_world/themes/colors.dart';

class ProfileOptionItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function onTap;

  ProfileOptionItem(
      {required this.icon, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          decoration: BoxDecoration(
              color: Color(0xffF6F6F6),
              borderRadius: BorderRadius.circular(32)),
          child: Row(
            children: [
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: colorLightWhite),
                  child: Icon(
                    icon,
                    color: primaryColor,
                    size: 30,
                  )),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: primaryColor, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}
