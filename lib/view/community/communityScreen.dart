import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:you_got_world/themes/colors.dart';
import 'package:you_got_world/utils/responsive.dart';
import 'package:you_got_world/utils/shimmerContainer.dart';
import 'package:you_got_world/view/community/communityGroundScreen.dart';
import 'package:you_got_world/view/community/communityScorersScreen.dart';
import 'package:you_got_world/view/community/groundRegistrationScreen.dart';

class CricketCommunityScreen extends StatelessWidget {
  final List<Map<String, dynamic>> menuItems = [
    {
      'title': 'Scorers',
      'icon': Icons.scoreboard_outlined,
    },
    {
      'title': 'Umpires',
      'icon': Icons.sports_outlined,
    },
    {
      'title': 'Commentators',
      'icon': Icons.mic_none_outlined,
    },
    {
      'title': 'Streamers',
      'icon': Icons.play_circle_outline,
    },
    {
      'title': 'Organisers',
      'icon': Icons.people_outline,
    },
    {
      'title': 'Academies',
      'icon': Icons.school_outlined,
    },
    {
      'title': 'Grounds',
      'icon': Icons.stadium_outlined,
    },
    {
      'title': 'Shops',
      'icon': Icons.store_outlined,
    },
    {
      'title': 'T-shirt Vendors',
      'icon': Icons.checkroom_outlined,
    },
    {
      'title': 'Trophy Vendors',
      'icon': Icons.emoji_events_outlined,
    },
    {
      'title': 'Bat Manufacturers',
      'icon': Icons.sports_cricket_outlined,
    },
    {
      'title': 'Physio and Fitness Trainer',
      'icon': Icons.fitness_center_outlined,
    },
    {
      'title': 'Personal Coaching',
      'icon': Icons.person_outline,
    },
    {
      'title': 'Box Cricket & Nets',
      'icon': Icons.grid_on_outlined,
    },
  ];

  CricketCommunityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: primaryColor,
        iconTheme: IconThemeData(color: colorLightWhite),
        title: Text(
          'Community',
          style: TextStyle(
              color: colorLightWhite, fontSize: context.deviceHeight * .024),
        ),
        actions: [
          IconButton(
            icon: Icon(CupertinoIcons.search, color: Colors.white),
            onPressed: () {},
          ),
          // Stack(
          //   alignment: Alignment.topRight,
          //   children: [
          //     IconButton(
          //       icon: Icon(Icons.filter_alt_outlined, color: Colors.white),
          //       onPressed: () {},
          //     ),
          //     Positioned(
          //       right: 8,
          //       top: 8,
          //       child: Container(
          //         padding: EdgeInsets.all(2),
          //         decoration: BoxDecoration(
          //           color: Colors.amber,
          //           borderRadius: BorderRadius.circular(10),
          //         ),
          //         constraints: BoxConstraints(
          //           minWidth: 16,
          //           minHeight: 16,
          //         ),
          //         child: Text(
          //           '1',
          //           style: TextStyle(
          //             color: Colors.black,
          //             fontSize: 10,
          //             fontWeight: FontWeight.bold,
          //           ),
          //           textAlign: TextAlign.center,
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Cricket Community in ',
                      style: TextStyle(
                        fontSize: context.deviceHeight * .016,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    TextSpan(
                      text: 'Delhi',
                      style: TextStyle(
                        fontSize: context.deviceHeight * .016,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final crossAxisCount = constraints.maxWidth > 600 ? 4 : 3;
                  return GridView.builder(
                    padding: EdgeInsets.only(
                        left: 16, right: 16, top: 8, bottom: 16),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 1,
                    ),
                    itemCount: menuItems.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 1,
                        color: colorLightWhite,
                        surfaceTintColor: colorLightWhite,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: InkWell(
                          onTap: () {
                            if (menuItems[index]['title'] == 'Scorers') {
                              Get.to(CommunityScorersScreen(),
                                  transition: Transition.rightToLeft);
                            } else if (menuItems[index]['title'] == 'Grounds') {
                          
                              Get.to(CommunityGroundScreen(),
                                  transition: Transition.rightToLeft);
                            }
                          },
                          borderRadius: BorderRadius.circular(12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                menuItems[index]['icon'],
                                size: 38,
                                color: primaryColor,
                              ),
                              SizedBox(height: 12),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: Text(
                                  menuItems[index]['title'],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: colorDark1,
                                    fontSize: context.deviceHeight * .012,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
