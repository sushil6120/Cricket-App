import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:you_got_world/themes/colors.dart';
import 'package:you_got_world/utils/responsive.dart';
import 'package:you_got_world/utils/valueConstants.dart';

import 'widget/redButton.dart';

class ReviewBookingDetailsScreen extends StatefulWidget {
  @override
  _ReviewBookingDetailsScreenState createState() =>
      _ReviewBookingDetailsScreenState();
}

class _ReviewBookingDetailsScreenState
    extends State<ReviewBookingDetailsScreen> {
  bool _payForBothTeams = false;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.height;

    return Scaffold(
      backgroundColor: colorLightWhite,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'REVIEW BOOKING DETAILS',
          style: TextStyle(
            color: Colors.black,
            fontSize: screenWidth * 0.016,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Silver Cricket ground',
                  style: TextStyle(
                    fontSize: screenWidth * 0.019,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: SvgPicture.asset('assets/img/edit.svg'),
                  label: Text(
                    'Edit',
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: screenWidth * 0.015,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Friday | 23-08-2024 | 12:00 PM',
              style: TextStyle(
                fontSize: screenWidth * 0.017,
                color: Colors.grey,
              ),
            ),
          ),
          SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Amar Sharma | 1234567890 | Leather Ball',
              style: TextStyle(
                fontSize: screenWidth * 0.016,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(height: 16),
          Divider(
            thickness: 10,
            color: Colors.grey.withOpacity(.2),
          ),
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Bill Info',
              style: TextStyle(
                fontSize: screenWidth * 0.018,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _buildBillInfoRow('Single Team Fee', 'Rs 2000', screenWidth),
          ),
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      'Token Amount ',
                      style: TextStyle(
                        fontSize: screenWidth * 0.016,
                      ),
                    ),
                    Icon(
                      Icons.info_outline,
                      size: screenWidth * 0.016,
                      color: Colors.grey.shade800,
                    ),
                  ],
                ),
                Text(
                  'Rs 400',
                  style: TextStyle(
                    fontSize: screenWidth * 0.016,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Checkbox(
                activeColor: primaryColor,
                value: _payForBothTeams,
                onChanged: (bool? value) {
                  setState(() {
                    _payForBothTeams = value ?? false;
                  });
                },
              ),
              Text(
                'Pay for both the teams',
                style: TextStyle(
                  fontSize: screenWidth * 0.016,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Divider(thickness: 1),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Term & conditions',
              style: TextStyle(
                fontSize: screenWidth * 0.018,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _buildTermsAndConditions(screenWidth),
          ),
          SizedBox(height: 16),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        height: context.deviceHeight * .15,
        elevation: 0,
        color: colorLightWhite,
        child: Column(
          children: [
            SizedBox(
              width: context.deviceWidth * .9,
              child: RedButton(
                  onPressed: () {
                    // Get.to(SignUpScreen(), transition:Transition.rightToLeft);
                  },
                  text: 'Pay Single Team Fee Rs 2000'),
            ),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              width: context.deviceWidth * .9,
              child: ElevatedButton(
                onPressed: () {
                  // Get.to(LoginScreen(), transition:Transition.rightToLeft);
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,

                  foregroundColor: Colors.white,
                  backgroundColor:
                      colorLightWhite, // Set the text color to white
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  side: const BorderSide(color: primaryColor),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                child: Text(
                  'Pay Token Fee Rs 400',
                  style: TextStyle(
                      color: primaryColor,
                      fontSize: screenWidth * 0.019,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBillInfoRow(String title, String value, double screenWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: screenWidth * 0.016,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: screenWidth * 0.016,
          ),
        ),
      ],
    );
  }

  Widget _buildTermsAndConditions(double screenWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '1. Your Use Constitutes Acceptance Of These Terms And Conditions As At The Date Of Your First Use Of The Site.',
          style: TextStyle(fontSize: screenWidth * 0.015, color: Colors.grey),
        ),
        SizedBox(height: 4),
        Text(
          '2. Demos Reserves The Rights To Change These Terms And Conditions At Any Time By Posting Changes Online...',
          style: TextStyle(fontSize: screenWidth * 0.015, color: Colors.grey),
        ),
        SizedBox(height: 4),
        Text(
          '3. You Agree To Use This Site Only For Lawful Purposes, And In A Manner Which Does Not Infringe The Rights, Or Restrict...',
          style: TextStyle(fontSize: screenWidth * 0.015, color: Colors.grey),
        ),
        SizedBox(height: 4),
        Text(
          '4. This Site And The Information, Names, Images, Pictures, Logos Regarding Or Relating To Demos...',
          style: TextStyle(fontSize: screenWidth * 0.015, color: Colors.grey),
        ),
      ],
    );
  }
}
