import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:you_got_world/themes/colors.dart';
import 'package:you_got_world/utils/responsive.dart';
import 'package:you_got_world/utils/valueConstants.dart';
import 'package:you_got_world/view/widget/continueWatchWidget.dart';
import 'package:you_got_world/view/widget/customeDrawer.dart';
import 'package:you_got_world/view/widget/homeWidget/scheduleBannerWidget.dart';
import 'package:you_got_world/view/widget/homeWidget/topBannerWidget.dart';
import 'package:you_got_world/view/widget/homeWidget/topSponserdBanner.dart';
import 'package:you_got_world/view/widget/homeWidget/topTenSectionWidget.dart';
import 'package:you_got_world/view/widget/latestTrandingWidget.dart';
import 'package:you_got_world/view/widget/homeWidget/upcomingShowBanner.dart';

class HomeScreen extends StatelessWidget {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  HomeScreen({super.key, required this.scaffoldKey});
  @override
  Widget build(BuildContext context) {
    final top10Data = [
      {
        'image':
            'https://m.media-amazon.com/images/M/MV5BOTYxZmYwODYtMGY5Zi00N2YyLWI1NmItMDY1NTMzMDI0YTg2XkEyXkFqcGc@._V1_.jpg',
        'title': 'Taal',
        'rank': '1'
      },
      {
        'image':
            'https://pics.filmaffinity.com/asur_welcome_to_your_dark_side-846011955-large.jpg',
        'title': 'Asur',
        'rank': '2'
      },
      {
        'image':
            'https://mir-s3-cdn-cf.behance.net/project_modules/fs/1e419155801399.5993d5d287bde.jpg',
        'title': 'Kaal',
        'rank': '3'
      },
    ];

    final trendingData = [
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTA5I-J-uxwvj5jCXa4VRpreOsYevCNjIQwuw&s',
      'https://c8.alamy.com/comp/BKBA4T/planet-51-year-2009-director-jorge-blanco-animation-movie-poster-fr-BKBA4T.jpg',
      'https://www.originalfilmart.com/cdn/shop/products/spongebobmoviesponge_out_of_water_2015_original_film_art_a_2000x.jpg?v=1586964361',
    ];
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: primaryColor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(context.deviceHeight * .14),
          child: Stack(
            children: [
              Positioned(
                  right: 0,
                  bottom: 0,
                  child: Image.asset(
                    'assets/img/waves.png',
                    height: context.deviceHeight * .35,
                  )),
              AppBar(
                surfaceTintColor: Colors.transparent,
                backgroundColor: primaryColor.withOpacity(.8),
                elevation: 0,
                leading: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        scaffoldKey.currentState!.openDrawer();
                      },
                      child: SvgPicture.asset(
                        'assets/img/drawer.svg',
                        fit: BoxFit.contain, // Adjust this if needed
                      ),
                    ),
                  ],
                ),
                centerTitle: true,
                title:
                    // Text(
                    //   'YouGot',
                    //   style: GoogleFonts.poppins(
                    //     textStyle: const TextStyle(
                    //       color: colorLightWhite,
                    //       fontSize: 21,
                    //       fontWeight: FontWeight.w600,
                    //     ),
                    //   ),
                    // ),
                    Image.asset(
                  'assets/img/logos.png',
                  height: context.deviceHeight * .09,
                ),
                // toolbarHeight: context.deviceHeight * .1,
                actions: const [
                  Icon(CupertinoIcons.search, color: Colors.white),
                  SizedBox(width: 14),
                  Icon(CupertinoIcons.bell, color: Colors.white),
                  SizedBox(width: 20),
                ],
                bottom: TabBar(
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white54,
                  indicatorColor: Colors.white,
                  labelStyle: TextStyle(
                      color: colorLightWhite,
                      fontSize: context.deviceHeight * .016,
                      fontWeight: FontWeight.w500),
                  unselectedLabelStyle: TextStyle(
                      color: colorLightWhite,
                      fontSize: context.deviceHeight * .016,
                      fontWeight: FontWeight.w500),
                  tabs: const [
                    Tab(
                      text: 'For You',
                    ),
                    Tab(text: 'Live'),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  const TopSponserdBannerWidget(),
                  Positioned(
                    top: 0,
                    child: BlurryContainer(
                      blur: 8,
                      width: context.deviceWidth,
                      height: context.deviceHeight * .06,
                      elevation: 0,
                      color: primaryColor,
                      padding: const EdgeInsets.all(8),
                      borderRadius: BorderRadius.circular(0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'SPONSORED',
                            style: TextStyle(
                                color: colorLightWhite,
                                fontSize: context.deviceHeight * .014),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.only(left: 16),
                child: Text('Continue Watch',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: colorLightWhite)),
              ),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ...List.generate(
                      4,
                      (index) => const Padding(
                        padding: EdgeInsets.only(left: 14),
                        child: ContinueWatchWidget(),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: verticalSpaceMedium,
              ),
              const TopBanner(
                  image:
                      'https://t3.ftcdn.net/jpg/04/28/40/40/360_F_428404007_dlbIe8jNte0Td6fzJ5NIVoLGcAP0drQ6.jpg',
                  title: 'EXPLORE NOW'),
              const SizedBox(
                height: verticalSpaceMedium,
              ),
              Top10Section(top10Items: top10Data),
              const SizedBox(
                height: verticalSpaceSmall,
              ),
              LatestTrendingSection(
                trendingItems: trendingData,
                title: 'Latest & Trending',
              ),
              const SizedBox(
                height: verticalSpaceMedium,
              ),
              const TopBanner(
                  image:
                      'https://t3.ftcdn.net/jpg/04/28/40/40/360_F_428404007_dlbIe8jNte0Td6fzJ5NIVoLGcAP0drQ6.jpg',
                  title: 'EXPLORE NOW'),
              const SizedBox(
                height: verticalSpaceMedium,
              ),
              const UpcommingBannerWidget(
                  image:
                      'https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/e2fd9882892035.5d2c3c960586e.jpg'),
              const SizedBox(
                height: verticalSpaceMedium,
              ),
              const ScheduleBannerWidget(
                  image:
                      'https://pbs.twimg.com/media/GB4WJtFbsAA-rCp.jpg:large'),
              const SizedBox(
                height: verticalSpaceSmall,
              ),
              LatestTrendingSection(
                  title: 'Latest Release', trendingItems: trendingData),
              const SizedBox(
                height: verticalSpaceLarge,
              )
            ],
          ),
        ),
      ),
    );
  }
}
