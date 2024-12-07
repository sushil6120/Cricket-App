import 'package:flutter/material.dart';
import 'package:you_got_world/themes/colors.dart';
import 'package:you_got_world/utils/responsive.dart';
import 'package:you_got_world/utils/valueConstants.dart';

class MatchesWidget extends StatelessWidget {
  const MatchesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildMatchCard(
            'UPCOMING',
            'Silver Cricket Ground',
            'Sri Lanka',
            'India',
            'March scheduled to begin at Sunday',
            '11 Aug, 2024',
            context),
        _buildMatchCard(
            'UPCOMING',
            'Silver Cricket Ground',
            'Sri Lanka',
            'India',
            'March scheduled to begin at Sunday',
            '11 Aug, 2024',
            context),
        _buildMatchResultCard('RESULT', 'Silver Cricket Ground', 'IND', 'SL',
            '132-4', '107-6', 'India won by 72 runs', '11 Aug, 2024', context),
        _buildMatchResultCard('RESULT', 'Silver Cricket Ground', 'IND', 'SL',
            '132-4', '107-6', 'India won by 72 runs', '11 Aug, 2024', context),
      ],
    );
  }

  Widget _buildIconLabel(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, size: 16),
        SizedBox(width: 4),
        Text(label),
      ],
    );
  }

  Widget _buildTabButton(String label, {bool isSelected = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: isSelected ? Colors.white : Colors.black,
          backgroundColor: isSelected ? Colors.blueAccent : Colors.white,
          side: BorderSide(color: isSelected ? Colors.blueAccent : Colors.grey),
          shape: StadiumBorder(),
        ),
        onPressed: () {},
        child: Text(label),
      ),
    );
  }

  Widget _buildMatchCard(String status, String ground, String team1,
      String team2, String matchTime, String date, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Card(
        color: colorLightWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Individual match',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: context.deviceWidth * .038)),
                  Chip(
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(92)),
                    label: Text(status,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: context.deviceWidth * .025)),
                    backgroundColor: Color(0xffF99F0D),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Text(ground,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: context.deviceWidth * .04)),
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Text('Squad',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: context.deviceWidth * .034)),
            ),
            SizedBox(height: 14),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: _buildTeamLogo(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR4sG1IppQi6XAGpcMCQc5ySSfgz7Hsu3-9BA&s',
                  team1,
                  context),
            ),
            SizedBox(height: 10),
            Divider(
              color: colorLight3.withOpacity(.6),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: _buildTeamLogo(
                  'https://upload.wikimedia.org/wikipedia/mai/1/11/India_national_cricket_team.png',
                  team2,
                  context),
            ),
            SizedBox(height: 8),
            Divider(
              color: colorLight3.withOpacity(.6),
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "${matchTime}",
                      style: TextStyle(
                          fontSize: context.deviceWidth * .035,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Container(
                    width: 1.6,
                    height: 40,
                    margin: EdgeInsets.only(right: 48),
                    decoration: BoxDecoration(color: colorDark2),
                  ),
                  Text(
                    date,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: context.deviceWidth * .036),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            Divider(
              color: colorLight3.withOpacity(.6),
            ),
            SizedBox(
              height: verticalSpaceMedium,
            ),
            Divider(
              thickness: 10,
              color: colorLight3.withOpacity(.3),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildMatchResultCard(
      String status,
      String ground,
      String team1,
      String team2,
      String score1,
      String score2,
      String result,
      String date,
      BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 0,
        color: colorLightWhite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Individual match',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: context.deviceWidth * .038)),
                  Chip(
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(92)),
                    label: Text(status,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: context.deviceWidth * .025)),
                    backgroundColor: Colors.black,
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(ground,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: context.deviceWidth * .04)),
                  Text(date,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: context.deviceWidth * .028)),
                ],
              ),
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Divider(
                color: colorLight3.withOpacity(.6),
              ),
            ),
            SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text('At 26.4 Overs',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: context.deviceWidth * .03)),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: _buildResultTeamLogo(
                        'https://upload.wikimedia.org/wikipedia/mai/1/11/India_national_cricket_team.png',
                        team1,
                        context),
                  ),
                  Column(
                    children: [
                      Text(score1,
                          style: TextStyle(
                              fontSize: context.deviceWidth * .058,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Text('-', style: TextStyle(fontSize: 24)),
                  Column(
                    children: [
                      Text(score2,
                          style: TextStyle(
                              fontSize: context.deviceWidth * .058,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: _buildResultTeamLogo(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR4sG1IppQi6XAGpcMCQc5ySSfgz7Hsu3-9BA&s',
                        team2,
                        context),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Divider(
                color: colorLight3.withOpacity(.6),
              ),
            ),
            SizedBox(height: 8),
            Container(
              width: context.deviceWidth,
              height: context.deviceHeight * .05,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(color: Color(0xff3D91F3)),
              child: Center(
                child: Text(result,
                    style: TextStyle(
                        fontSize: context.deviceWidth * .035,
                        fontWeight: FontWeight.w600,
                        color: colorLightWhite)),
              ),
            ),
            SizedBox(height: 8),
            Divider(
              thickness: 10,
              color: colorLight3.withOpacity(.3),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTeamLogo(
      String assetPath, String teamName, BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(90),
          child: Image.network(assetPath, width: 24, height: 24),
        ), // Replace with your actual asset image paths
        SizedBox(width: 8),
        Text(
          teamName,
          style: TextStyle(
              fontSize: context.deviceWidth * .037,
              fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildResultTeamLogo(
      String assetPath, String teamName, BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(90),
          child: Image.network(assetPath, width: 24, height: 24),
        ), // Replace with your actual asset image paths
        SizedBox(width: 8),
        Text(
          teamName,
          style: TextStyle(
              fontSize: context.deviceWidth * .037,
              fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
