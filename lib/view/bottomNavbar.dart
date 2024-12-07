import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:you_got_world/themes/colors.dart';
import 'package:you_got_world/utils/responsive.dart';
import 'package:you_got_world/view/MySportsScreen.dart';
import 'package:you_got_world/view/bookgroundScreen.dart';
import 'package:you_got_world/view/homeScreen.dart';
import 'package:you_got_world/view/liveScreen.dart';
import 'package:you_got_world/view/moviesScreen.dart';
import 'package:you_got_world/view/splash_screen.dart';
import 'package:you_got_world/view/widget/customeDrawer.dart';
import 'package:you_got_world/view/widget/customeNavBarWidget.dart';

import '../controllers/navbarController.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late List<Widget> _pages;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pages = [
      HomeScreen(
        scaffoldKey: _scaffoldKey,
      ),
      BookGroundScreen(),
      MySportsScreen(),
      MoviesScreen(),
      LiveScreen(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final NavController navController = Get.put(NavController());
    return Obx(
      () => Scaffold(
        key: _scaffoldKey,
        drawer: CustomDrawer(),
        backgroundColor:
            navController.currentIndex == 1 ? Colors.white : primaryColor,
        body: WillPopScope(
          onWillPop: () async {
            final didPop = await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                backgroundColor: primaryColor,
                title: const Text(
                  'Are you sure?',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Inter'),
                ),
                content: Text(
                  'Do You Want To Exit The App',
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Inter'),
                ),
                actions: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pop(false);
                          },
                          child: Container(
                            width: context.deviceWidth * 0.25,
                            height: context.deviceHeight * 0.05,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white,
                            ),
                            child: const Center(
                                child: Text(
                              'No',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            )),
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        InkWell(
                          onTap: () {
                            exit(0);
                          },
                          child: Container(
                            width: context.deviceWidth * 0.25,
                            height: context.deviceHeight * 0.05,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white,
                            ),
                            child: const Center(
                                child: Text(
                              'Yes',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
            return didPop ?? false;
          },
          child: _pages[navController.currentIndex.toInt()],
        ),
        bottomNavigationBar: CustomBottomNavBar(),
      ),
    );
  }
}
