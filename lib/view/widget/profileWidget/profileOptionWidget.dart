import 'package:flutter/material.dart';
import 'package:you_got_world/view/widget/profileWidget/profileOptionItem.dart';


class ProfileOptions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileOptionItem(
          icon: Icons.person,
          text: 'My Cricket Profile',
          onTap: () {},
        ),
        ProfileOptionItem(
          icon: Icons.notifications,
          text: 'Push Notifications',
          onTap: () {},
        ),
        ProfileOptionItem(
          icon: Icons.history,
          text: 'Purchase History',
          onTap: () {},
        ),
      ],
    );
  }
}