import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:you_got_world/themes/colors.dart';

import '../../../../controllers/tabController.dart';

class SearchBarWidget extends StatelessWidget {
  String screen;
  SearchBarWidget({super.key, required this.screen});
  final _tabController = Get.put(TabSwitchController());

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 18),
            decoration: BoxDecoration(
              border: Border.all(color: colorLight3),
              borderRadius: BorderRadius.circular(30),
            ),
            child: TextField(
              decoration: InputDecoration(
                suffix: Icon(
                  CupertinoIcons.search,
                  color: colorDark3,
                  size: 20,
                ),
                hintText: 'Quick search',
                hintStyle: TextStyle(
                    fontSize: 13,
                    color: colorDark3,
                    fontWeight: FontWeight.w500),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
        ),
        SizedBox(width: 10),
        ElevatedButton(
          onPressed: () {
            _tabController.changeTab(2, screen);
          },
          child: Text(
            'Add Team',
            style: TextStyle(
                fontSize: 12,
                color: colorLightWhite,
                fontWeight: FontWeight.w500),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            padding: EdgeInsets.all(14),
          ),
        ),
      ],
    );
  }
}
