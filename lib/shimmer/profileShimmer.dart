import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:you_got_world/themes/colors.dart';
import 'package:you_got_world/utils/responsive.dart';
import 'package:you_got_world/utils/valueConstants.dart';

class ProfileHeaderShimmer extends StatelessWidget {
  final String? subtitle;
  ProfileHeaderShimmer({super.key, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Shimmer for background cover image
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            height: context.deviceHeight * .22,
            color: Colors.grey.shade300,
          ),
        ),

        Padding(
          padding: EdgeInsets.only(top: context.deviceHeight * .18,left: 40),
          child: Column(
            children: [
              // Shimmer for profile picture
              Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.shade300,
                  ),
                ),
              ),
              SizedBox(height: 10),

              // Shimmer for profile name
              Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(
                  width: context.deviceWidth * .2,
                  height: 20,
                  color: Colors.grey.shade300,
                ),
              ),
              SizedBox(height: 10),

              // Shimmer for subtitle (email)
              Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(
                  width: context.deviceWidth * .6,
                  height: 8,
                  color: Colors.grey.shade300,
                ),
              ),
              SizedBox(height: 20),

              // Shimmer for Edit Profile button
              subtitle == null
                  ? Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        width: context.deviceWidth * .8,
                        height: 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.shade300,
                        ),
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ],
    );
  }
}
