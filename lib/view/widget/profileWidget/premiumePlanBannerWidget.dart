import 'package:flutter/material.dart';
import 'package:you_got_world/themes/colors.dart';

class PremiumPlanBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 2.0),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: colorLight3,
                blurRadius: 10,
                offset: Offset(0, 4),
                spreadRadius: 4)
          ],
          gradient: LinearGradient(colors: [
            Color(0xff4A5969),
            Color(0xff11263A),
          ]),
          borderRadius: BorderRadius.circular(18),
        ),
        child: ListTile(
          leading: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colorLightWhite.withOpacity(.25)),
              child: Icon(Icons.star, color: Colors.white)),
          title: Text(
            'Buy Premium Plan',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16),
          ),
          subtitle: Text(
            'Purchase our new premium plan.',
            style: TextStyle(color: Colors.white70, fontSize: 11),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: Colors.white,
            size: 20,
          ),
          onTap: () {},
        ),
      ),
    );
  }
}
