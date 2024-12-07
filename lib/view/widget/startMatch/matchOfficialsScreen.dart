import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:you_got_world/utils/responsive.dart';
import 'package:you_got_world/view/widget/redButton.dart';

import '../../../themes/colors.dart';

class MatchOfficialsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorLightWhite,
      appBar: AppBar(
        backgroundColor: colorLightWhite,
        surfaceTintColor: colorLightWhite,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: .5,
        shadowColor: colorDark3.withOpacity(.4),
        title: Text(
          'MATCH OFFICIALS',
          style: TextStyle(
            fontSize: context.deviceHeight * .016,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Select Umpires Section
                    buildSectionTitle('Select Umpires'),
                    buildGridSection([
                      {'label': '1st Umpire', 'icon': Icons.gavel},
                      {'label': '2st Umpire', 'icon': Icons.gavel},
                      {'label': '3st Umpire', 'icon': Icons.gavel},
                    ]),
                    // Select Scores Section
                    buildSectionTitle('Select Scores'),
                    buildGridSection([
                      {'label': '1st Scorer', 'icon': Icons.calendar_today},
                      {'label': '2nd Scorer', 'icon': Icons.calendar_today},
                    ]),
                    // Others Section
                    buildSectionTitle('Others'),
                    buildGridSection([
                      {'label': 'Commentators', 'icon': Icons.mic},
                      {'label': 'Match Referee', 'icon': Icons.person},
                      {'label': 'Live Streamers', 'icon': Icons.live_tv},
                    ]),

                    // Done Button
                  ],
                ),
              ),
            ),
          ),
          Center(
              child: SizedBox(
            width: context.deviceWidth * .95,
            child: RedButton(
                onPressed: () {
                  Get.back();
                  // Get.to(ScoringScreen());
                },
                text: 'Done'),
          )),
          SizedBox(
            height: 6,
          )
        ],
      ),
    );
  }

  // Function to create section titles
  Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }

  // Function to create grid sections with icons and labels
  Widget buildGridSection(List<Map<String, dynamic>> items) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        childAspectRatio: .8,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey),
              ),
              child: Icon(
                items[index]['icon'],
                size: 36,
              ),
            ),
            SizedBox(height: 8),
            Text(
              items[index]['label'],
              style: TextStyle(
                fontSize: context.deviceHeight * .013,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        );
      },
    );
  }
}
