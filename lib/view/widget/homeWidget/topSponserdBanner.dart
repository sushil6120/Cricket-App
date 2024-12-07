import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:you_got_world/utils/responsive.dart';

import '../../../themes/colors.dart';

class TopSponserdBannerWidget extends StatelessWidget {
  const TopSponserdBannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
                    width: context.deviceWidth,
                    height: context.deviceHeight * .64,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                'https://i.pinimg.com/736x/5e/2c/7d/5e2c7d29e4d46c96eef112c26c978735.jpg'))),
                    child: Container(
                      width: context.deviceWidth,
                      height: context.deviceHeight * .68,
                      padding:
                          EdgeInsets.only(bottom: context.deviceHeight * .055),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                            Colors.transparent,
                            primaryColor.withOpacity(.5),
                            primaryColor
                          ],
                    
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 0),
                            child: Text(
                              'PAK vs UAE',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: context.deviceHeight * .053,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7)),
                                backgroundColor: primaryColor),
                            child: Text(
                              'HIGHLIGHTS',
                              style: TextStyle(
                                  color: colorLightWhite,
                                  fontSize: context.deviceHeight * .022,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10, top: 4),
                            child: Text(
                              'Asia Cup 2024 • 9m • Cricket',
                              style: GoogleFonts.notoSansAnatolianHieroglyphs(
                                  color: Colors.white,
                                  fontSize: context.deviceHeight * .015),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: context.deviceWidth * .42,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100)),
                                  backgroundColor: Colors.grey.withOpacity(.3)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.play_arrow_rounded,
                                    color: colorLightWhite,
                                  ),
                                  const SizedBox(
                                    width: 2,
                                  ),
                                  Text(
                                    'Watch Now',
                                    style: TextStyle(
                                        color: colorLightWhite,
                                        fontSize: context.deviceHeight * .014,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          DotsIndicator(
                            dotsCount: 6,
                            position: 4,
                            decorator: DotsDecorator(
                              color:
                                  Colors.grey.withOpacity(.5), // Inactive color
                              activeColor: colorLightWhite,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
  }
}