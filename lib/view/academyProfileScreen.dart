import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:you_got_world/utils/responsive.dart';
import 'package:you_got_world/utils/valueConstants.dart';

import '../themes/colors.dart';

class AcademyProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.height;
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        backgroundColor: colorLightWhite,
        body: CustomScrollView(
          slivers: [
            // SliverAppBar with image, title, and subtitle
            SliverAppBar(
              iconTheme: IconThemeData(color: primaryColor),
              pinned: true,
              surfaceTintColor: colorLightWhite,
              expandedHeight: context.deviceHeight * .45,
              backgroundColor: colorLightWhite,
              flexibleSpace: FlexibleSpaceBar(
                background: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: context.deviceHeight * .24,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                  'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7a/Pollock_to_Hussey.jpg/1200px-Pollock_to_Hussey.jpg'), // Replace with your background image URL
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: context.deviceHeight * .18,
                              left: 16), // Adjust as needed
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  shape: BoxShape.circle,
                                ),
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundColor: Color(0xffE8F2FE),
                                  backgroundImage: NetworkImage(
                                      'https://marketplace.canva.com/EAF0BoJNksI/1/0/1600w/canva-orange-and-brown-illustrative-cricket-club-sports-logo-UuC0dd2P9Ag.jpg'),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    right: 16, top: context.deviceHeight * .05),
                                child: TextButton.icon(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: SvgPicture.asset('assets/img/edit.svg'),
                                  label: Text(
                                    'Edit',
                                    style: TextStyle(
                                      color: primaryColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: screenWidth * 0.015,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 14, top: 14),
                      child: Text(
                        "Silver Cricket Academy",
                        style: TextStyle(
                            fontSize: context.deviceHeight * .0195,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 14, top: verticalSpaceSmall2),
                      child: Text(
                        "New Delhi",
                        style: TextStyle(
                            fontSize: context.deviceHeight * .017,
                            color: colorDark3,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 14, top: 5),
                      child: Text(
                        "Amar Sharma | 1234567890 | Leather Ball",
                        style: TextStyle(
                            fontSize: context.deviceHeight * .017,
                            color: colorDark1,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                Container(
                  margin: EdgeInsets.only(right: 25),
                  decoration: BoxDecoration(
                      color: colorLightWhite.withOpacity(.3),
                      shape: BoxShape.circle),
                  child: IconButton(
                    icon: Icon(Icons.filter_alt_outlined),
                    onPressed: () {},
                  ),
                ),
              ],
            ),

            // Sliver for tab bar
            SliverPersistentHeader(
              delegate: _SliverAppBarDelegate(
                TabBar(
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: primaryColor,
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: screenWidth * 0.015,
                  ),
                  tabs: [
                    Tab(text: "Tournament"),
                    Tab(text: "Live"),
                    Tab(text: "Upcoming"),
                  ],
                ),
              ),
              pinned: true,
            ),

            // Sliver list for the tournament cards
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Container(
                    width: context.deviceWidth,
                    margin: EdgeInsets.only(
                        bottom: 20, left: 14, right: 14, top: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.17),
                          blurRadius: 35,
                          spreadRadius: 0,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        // Background Image
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            'https://img.freepik.com/premium-vector/cricket-championship-tournament-background-with-vector-illustration_30996-6570.jpg', // Replace with your image URL
                            height: context.deviceHeight * .27,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        // 'PAST' Label
                        Positioned(
                          top: 10,
                          left: 10,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              'PAST',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: context.deviceHeight * .014,
                              ),
                            ),
                          ),
                        ),
                        // Bottom Text Section
                        Positioned(
                          bottom: -2,
                          left: 0,
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  blurRadius: 30,
                                  spreadRadius: 0,
                                  offset: Offset(0, -20),
                                ),
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Pankaj Cricket Club T-25 Series',
                                  style: TextStyle(
                                    fontSize: context.deviceHeight * .018,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'New Delhi',
                                  style: TextStyle(
                                    fontSize: context.deviceHeight * .015,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                childCount: 3, 
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom delegate for SliverPersistentHeader
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _SliverAppBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
