import 'dart:io';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:you_got_world/themes/colors.dart';
import 'package:you_got_world/utils/responsive.dart';
import 'package:you_got_world/utils/valueConstants.dart';
import 'package:you_got_world/view/timeSlotScreen.dart';
import 'package:you_got_world/view/widget/groundWidget/aboutGroundWidget.dart';
import 'package:you_got_world/view/widget/groundWidget/customeReviewScreen.dart';
import 'package:you_got_world/view/widget/groundWidget/groundPhotosWidget.dart';
import 'package:you_got_world/view/widget/groundWidget/matchesWidget.dart';
import 'package:you_got_world/view/widget/groundWidget/tournamentWidget.dart';
import 'package:you_got_world/view/widget/redButton.dart';
import 'package:photo_view/photo_view.dart';

class GroundDetailScreen extends StatefulWidget {
  @override
  _GroundDetailScreenState createState() => _GroundDetailScreenState();
}

class _GroundDetailScreenState extends State<GroundDetailScreen> {
  int _currentImageIndex = 0;
  int currentTab = 0;

  final List<String> imgList = [
    'https://fancyodds.com/wp-content/uploads/2021/12/Neerja-Modi-School.jpg',
    'https://fancyodds.com/wp-content/uploads/2021/12/Neerja-Modi-School.jpg',
    'https://fancyodds.com/wp-content/uploads/2021/12/Neerja-Modi-School.jpg',
  ];

  final List<String> tabButtons = [
    'About',
    'Photo',
    'Reviews',
    'Matches',
    'Tournaments'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.deviceWidth,
      height: context.deviceHeight,
      decoration: BoxDecoration(
          image: DecorationImage(image: NetworkImage(imgList[0]))),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                backgroundColor: colorLightWhite,
                surfaceTintColor: Colors.transparent,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_rounded,
                      color: primaryColor),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                expandedHeight: context.deviceHeight * .47, // Made image larger
                floating: false,
                pinned: true,

                flexibleSpace: FlexibleSpaceBar(
                  background: Column(
                    children: [
                      Stack(
                        children: [
                          CarouselSlider(
                            options: CarouselOptions(
                              viewportFraction: 1,
                              height: Platform.isIOS
                                  ? context.deviceHeight * .5433
                                  : context.deviceHeight *
                                      .502, // Matches the expandedHeight of SliverAppBar
                              autoPlay: false,

                              pauseAutoPlayInFiniteScroll: true,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  _currentImageIndex = index;
                                });
                              },
                            ),
                            items: imgList
                                .map((item) => GestureDetector(
                                      onTap: () {
                                        _showImageViewer(context, item);
                                      },
                                      child: Image.network(
                                        item,
                                        height: context.deviceHeight * .52,
                                        fit: BoxFit.cover,
                                      ),
                                    ))
                                .toList(),
                          ),
                          Positioned(
                            bottom: context.deviceHeight * .01,
                            left: context.deviceWidth * .4,
                            child: DotsIndicator(
                              dotsCount: imgList.length,
                              position: _currentImageIndex,
                              decorator: const DotsDecorator(
                                color: colorDark3, // Inactive color
                                activeColor: colorLightWhite,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // SliverPersistentHeader(
              //   delegate: _SliverAppBarDelegate(

              //     // TabBar(
              //     //   labelColor: Colors.redAccent,
              //     //   unselectedLabelColor: Colors.black,
              //     //   indicatorColor: Colors.redAccent,
              //     //   tabs: [
              //     //     Tab(text: 'About'),
              //     //     Tab(text: 'Photo'),
              //     //     Tab(text: 'Review'),
              //     //     Tab(text: 'Matches'),
              //     //     Tab(text: 'Tournament'),
              //     //   ],
              //     // ),
              //   ),
              //   pinned: true,
              // ),
            ];
          },
          body: Container(
            decoration: const BoxDecoration(
                color: colorLightWhite,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                boxShadow: [BoxShadow()]),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      margin: const EdgeInsets.only(top: 16),
                      width: context.deviceWidth * .15,
                      height: context.deviceHeight * .008,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: primaryColor.withOpacity(.4)),
                    ),
                  ),
                  const SizedBox(
                    height: verticalSpaceSmall,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Text(
                      'Silver Cricket ground',
                      style: TextStyle(
                        fontSize: context.deviceHeight * .024,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Text(
                      '24.5 KM | Confirmation 100%',
                      style: TextStyle(
                          color: primaryColor.withOpacity(.7),
                          fontSize: context.deviceHeight * .015,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 6),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 5),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: primaryColor.withOpacity(.2)),
                          child: Icon(
                            Icons.location_on,
                            color: Colors.red,
                            size: context.deviceHeight * .010,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            'Jai Vihar, Baprola vihar, Delhi, 110043, India',
                            style: TextStyle(
                                fontSize: context.deviceHeight * .015),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: verticalSpaceSmall),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildBenifitWidget(
                            Icon(
                              Icons.wifi,
                              color: Colors.black,
                              size: context.deviceHeight * .02,
                            ),
                            'Free Wifi'),
                        _buildBenifitWidget(
                            Icon(
                              Icons.free_breakfast_outlined,
                              color: Colors.black,
                              size: context.deviceHeight * .02,
                            ),
                            'Free Wifi'),
                        _buildBenifitWidget(
                            Icon(
                              Icons.star_rate_rounded,
                              color: const Color(0xffFFD33C),
                              size: context.deviceHeight * .03,
                            ),
                            'Free Wifi'),
                      ],
                    ),
                  ),
                  const SizedBox(height: verticalSpaceSmall),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              // Handle message button press
                            },
                            icon: Icon(
                              CupertinoIcons.chat_bubble_text_fill,
                              size: context.deviceHeight * .024,
                              color: primaryColor,
                            ),
                            label: Text('Message',
                                style: TextStyle(
                                    fontSize: context.deviceHeight * .018,
                                    fontWeight: FontWeight.w500,
                                    color: primaryColor)),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              elevation: 0,
                              backgroundColor: colorLightWhite,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  side: const BorderSide(color: primaryColor)),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              // Handle message button press
                            },
                            icon: Icon(
                              CupertinoIcons.chart_bar_alt_fill,
                              size: context.deviceHeight * .024,
                              color: primaryColor,
                            ),
                            label: Text('Insight',
                                style: TextStyle(
                                    fontSize: context.deviceHeight * .018,
                                    fontWeight: FontWeight.w500,
                                    color: primaryColor)),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              elevation: 0,
                              backgroundColor: colorLightWhite,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  side: const BorderSide(color: primaryColor)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Divider(color: colorLight2),
                  const SizedBox(
                    height: verticalSpaceExtraSmall,
                  ),
                  SizedBox(
                    height: Platform.isIOS
                        ? context.deviceHeight * .072
                        : context.deviceHeight * .07,
                    child: ListView.builder(
                      itemCount: tabButtons.length,
                      padding: const EdgeInsets.only(left: 10),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              currentTab = index;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(
                                bottom: verticalSpaceSmall, left: 8, right: 8),
                            padding: const EdgeInsets.only(
                                left: 19, right: 19, top: 10, bottom: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                border: Border.all(
                                    color: currentTab == index
                                        ? primaryColor
                                        : colorLight3),
                                color: currentTab == index
                                    ? primaryColor.withOpacity(.15)
                                    : Colors.transparent),
                            child: Text(tabButtons[index],
                                style: TextStyle(
                                    fontSize: context.deviceHeight * .016,
                                    fontWeight: FontWeight.w500,
                                    color: currentTab == index
                                        ? primaryColor
                                        : colorLight3)),
                          ),
                        );
                      },
                    ),
                  ),
                  const Divider(
                    color: colorLight2,
                    thickness: 8,
                  ),
                  currentTab == 0
                      ? AboutGroundWidget()
                      : currentTab == 1
                          ? GroundImagesWidget()
                          : currentTab == 2
                              ? CustomerReviewsScreen()
                              : currentTab == 3
                                  ? MatchesWidget()
                                  : currentTab == 4
                                      ? TournaMentWidget()
                                      : SizedBox(),
                  const SizedBox(
                    height: verticalSpaceLarge,
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.only(
              top: context.deviceHeight * .014,
              bottom: context.deviceHeight * .018,
              left: context.deviceWidth * .02,
              right: context.deviceWidth * .02),
          decoration: BoxDecoration(color: colorLightWhite, boxShadow: [
            BoxShadow(
                color: colorDark3.withOpacity(.5),
                offset: Offset(0, -4),
                blurRadius: 28,
                spreadRadius: 0)
          ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 18, right: 8),
                child: Text('Rs 3500- 6000',
                    style: TextStyle(
                        fontSize: context.deviceHeight * .022,
                        fontWeight: FontWeight.w500)),
              ),
              SizedBox(
                  width: context.deviceWidth * .5,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(TimeSlotScreen(),
                          transition: Transition.rightToLeft);
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,

                      foregroundColor: Colors.white,
                      backgroundColor:
                          primaryColor, // Set the text color to white
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    child: Text(
                      'Book Now',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBenifitWidget(Icon icon, String title) {
    return Container(
      height: context.deviceHeight * .046,
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color(0xffC8C8F4).withOpacity(.3)),
      child: Row(
        children: [
          icon,
          const SizedBox(width: 4),
          Text(
            '$title',
            style: TextStyle(fontSize: context.deviceHeight * .014),
          ),
        ],
      ),
    );
  }

  Widget _buildPitchTypeChip(String label) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Chip(
        label: Text(label),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}

void _showImageViewer(BuildContext context, String imageUrl) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => Scaffold(
        backgroundColor: colorLightWhite,
        appBar: AppBar(),
        body: Center(
          child: PhotoView(
            imageProvider: NetworkImage(imageUrl),
          ),
        ),
      ),
    ),
  );
}

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
