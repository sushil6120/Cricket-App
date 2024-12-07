import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:you_got_world/controllers/tabController.dart';
import 'package:you_got_world/themes/colors.dart';
import 'package:you_got_world/utils/responsive.dart';
import 'package:you_got_world/view/widget/startMatch/selectTeamWidget/opponentsScreen.dart';

import 'addTeamScreen.dart';
import 'widget/startMatch/selectTeamWidget/myTeamBar.dart';

class TeamSelectionScreen extends StatefulWidget {
  final String title;
  String screenName;

  TeamSelectionScreen(
      {super.key, required this.title, required this.screenName});

  @override
  State<TeamSelectionScreen> createState() => _TeamSelectionScreenState();
}

class _TeamSelectionScreenState extends State<TeamSelectionScreen>
    with SingleTickerProviderStateMixin {
  // Controller for managing tab index
  final _tabController = Get.put(TabSwitchController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController.tabController = TabController(length: 3, vsync: this);
    _tabController.tabController.addListener(() {
      _tabController.currentIndex.value = _tabController.tabController.index;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.screenName == 'opponent') {
        _tabController.changeTab(1, 'OpponentsScreen');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: colorLightWhite,
        appBar: AppBar(
          shadowColor: colorLight2,
          title: Text(
            widget.title,
            style: TextStyle(
              fontSize: context.deviceHeight * 0.018,
              fontWeight: FontWeight.w600,
            ),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: .5,
        ),
        body: Column(
          children: [
            // Custom Tab Buttons
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildTabButton('My Team', 0, context),
                  _buildTabButton('Opponents', 1, context),
                  _buildTabButton('Add', 2, context),
                ],
              ),
            ),
            Expanded(
              // Use TabBarView without Obx, as TabController handles the updates
              child: TabBarView(
                controller: _tabController.tabController,
                children: [
                  MyTeamTab(),
                  OpponentsScreen(),
                  AddTeamScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build custom tab buttons
  Widget _buildTabButton(String text, int index, BuildContext context) {
    return Obx(() {
      bool isSelected = _tabController.currentIndex.value == index;
      return GestureDetector(
        onTap: () => _tabController.changeTab(index, ''),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Text(
                text,
                style: TextStyle(
                  color: isSelected ? primaryColor : Colors.grey,
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                width: context.deviceWidth * .24,
                height: 3,
                decoration: BoxDecoration(
                  color: isSelected ? primaryColor : Colors.transparent,
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
