import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:you_got_world/utils/responsive.dart';
import 'package:you_got_world/view/homeScreen.dart';

import '../../../themes/colors.dart';

class Top10Section extends StatelessWidget {
  final List<Map<String, String>> top10Items;

  const Top10Section({required this.top10Items});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              'Top 10 in India Today - Hindi',
              style:
                  TextStyle(fontWeight: FontWeight.w600, color: colorLightWhite),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: context.deviceHeight * .24,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(left: 10),
              itemCount: top10Items.length,
              itemBuilder: (context, index) {
                return Container(
                  width: context.deviceWidth * .4,
                  child: Stack(
                    children: [
                      Positioned(
                        left: context.deviceWidth * .02,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                              top10Items[index]['image'].toString(),
                              width: context.deviceWidth * .35,
                              height: context.deviceHeight * .21,
                              fit: BoxFit.fill),
                        ),
                      ),
                      Positioned(
                        bottom: context.deviceHeight * .001,
                        left: .3,
                        child: Text(
                          top10Items[index]['rank'].toString(),
                          style: GoogleFonts.inter(
                            color: Color(0xffb3b3b3),
                            fontSize: context.deviceHeight * .08,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
