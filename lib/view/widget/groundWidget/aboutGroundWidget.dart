import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:you_got_world/utils/responsive.dart';
import 'package:you_got_world/utils/valueConstants.dart';

import '../../../themes/colors.dart';

class AboutGroundWidget extends StatelessWidget {
  const AboutGroundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleWidget('Ground Info', context),
        const SizedBox(
          height: verticalSpaceSmall,
        ),
        Row(
          children: [
            Center(
              child: Image.asset(
                'assets/img/ground.png', // Replace with the actual image URL
                fit: BoxFit.cover,
                height: context.deviceHeight * .18,
                width: context.deviceHeight * .18,
              ),
            ),
            const SizedBox(width: 0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Available pitch type',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: context.deviceHeight * .019,
                      )),
                  const SizedBox(height: 4),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildGroundInfoWidget('TURF', context),
                        _buildGroundInfoWidget('CEMENT', context),
                        _buildGroundInfoWidget('ASTROT', context),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text('Boundary length (METERS)',
                        style:
                            TextStyle(fontSize: context.deviceHeight * .012)),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        top: 8, bottom: verticalSpaceSmall, left: 8, right: 8),
                    padding: const EdgeInsets.only(
                        left: 19, right: 19, top: 12, bottom: 12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(color: colorLight3),
                        color: Colors.transparent),
                    child: Text('60-64 (Approx)',
                        style: TextStyle(
                            fontSize: context.deviceHeight * .016,
                            fontWeight: FontWeight.w500,
                            color: colorLight3)),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        const Divider(
          color: colorLight2,
          thickness: 10,
        ),
        const SizedBox(height: verticalSpaceExtraSmall),
        titleWidget('Facilities', context),
        GridView.count(
          shrinkWrap: true,
          crossAxisCount: 4,
          childAspectRatio: 3 / 2.2,
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 25, bottom: 8),
          crossAxisSpacing: 8,
          mainAxisSpacing: 14,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            _buildFacilityItem(Icons.sports_cricket, 'Umpire', context),
            _buildFacilityItem(Icons.score, 'Scores', context),
            _buildFacilityItem(Icons.local_drink, 'Drinking Water', context),
            _buildFacilityItem(Icons.sports_cricket, 'Practice Net', context),
            _buildFacilityItem(Icons.lightbulb, 'Flood Lights', context),
            _buildFacilityItem(Icons.score, 'Scores', context),
            _buildFacilityItem(Icons.score, 'Scores', context),
            _buildFacilityItem(Icons.score, 'Scores', context),
          ],
        ),
        const SizedBox(
          height: 4,
        ),
        const Divider(
          color: colorLight2,
          thickness: 10,
        ),
        const SizedBox(height: 16),
        titleWidget('Others', context),
        const SizedBox(
          height: verticalSpaceSmall,
        ),
        Padding(
          padding: EdgeInsets.only(left: 18, right: 16),
          child: Text(
            '1. Mobile live streaming available T-20 Rs 800/- per match.',
            style: TextStyle(
                fontSize: context.deviceHeight * .017,
                fontWeight: FontWeight.w400),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 18, right: 16),
          child: Text(
              '2. Camera live streaming available T-20 Rs 4000/- per match.',
              style: TextStyle(
                  fontSize: context.deviceHeight * .017,
                  fontWeight: FontWeight.w400)),
        ),
      ],
    );
  }

  Widget titleWidget(String title, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(title,
              style: TextStyle(
                fontSize: context.deviceHeight * .020,
                fontWeight: FontWeight.w600,
              )),
          Container(
            margin: const EdgeInsets.only(top: 1),
            width: context.deviceWidth * .26,
            height: context.deviceHeight * .006,
            decoration: const BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
          )
        ],
      ),
    );
  }

  Widget _buildFacilityItem(IconData icon, String label, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: colorLight3.withOpacity(.5)),
          borderRadius: BorderRadius.circular(8)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: context.deviceHeight * .03,
            color: colorDark2,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: context.deviceHeight * .0118, color: colorDark3),
          ),
        ],
      ),
    );
  }

  Widget _buildGroundInfoWidget(String title, BuildContext context) {
    return Container(
      height: context.deviceHeight * .046,
      margin: const EdgeInsets.only(left: 4),
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color(0xffC8C8F4).withOpacity(.3)),
      child: Center(
        child: Text(
          '$title',
          style: TextStyle(fontSize: context.deviceHeight * .014),
        ),
      ),
    );
  }
}
