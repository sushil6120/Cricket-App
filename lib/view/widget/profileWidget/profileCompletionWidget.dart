import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:you_got_world/themes/colors.dart';
import 'package:you_got_world/utils/responsive.dart';

class ProfileCompletion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Container(
        width: context.deviceWidth,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
         border: Border.all(color: colorLight3,width: .8)
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              CircularPercentIndicator(
                radius: 100.0,
                lineWidth: 30,
                percent: 0.75,
                backgroundColor: Color(0xffECEFED),
                circularStrokeCap: CircularStrokeCap.round,
                center: Container(
                  width: context.deviceWidth * .28,
                  height: context.deviceWidth * .28,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Color(0xffECEFED)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: context.deviceWidth * .2,
                        height: context.deviceHeight * .08,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.green),
                        child: Center(
                          child: Text(
                            '75%',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: colorLightWhite),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                progressColor: Colors.green,
              ),
              SizedBox(height: 16),
              Text(
                'PROFILE INFO',
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
              ),
              Text(
                'Complete Profile',
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: colorLight3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
