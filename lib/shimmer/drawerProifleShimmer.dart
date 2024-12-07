import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:you_got_world/themes/colors.dart';
import 'package:you_got_world/utils/responsive.dart';

class DrawerProfileHeaderShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade400,
      child: Padding(
        padding: EdgeInsets.only(
           left: 0, bottom:0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Shimmer for profile picture
            Container(
              width: 66,
              height: 66,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.shade300,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Shimmer for name
                  Container(
                    width: context.deviceWidth * 0.3,
                    height: 18,
                    color: Colors.grey.shade300,
                  ),
                  const SizedBox(height: 10),
      
                  // Shimmer for phone number row
                  Row(
                    children: [
                      Container(
                        width: 18,
                        height: 18,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.shade300,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        width: context.deviceWidth * 0.2,
                        height: 16,
                        color: Colors.grey.shade300,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
      
                  // Shimmer for 'View Profile' row
                  Row(
                    children: [
                      Container(
                        width: 18,
                        height: 18,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.shade300,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        width: context.deviceWidth * 0.3,
                        height: 16,
                        color: Colors.grey.shade300,
                      ),
                    ],
                  ),
                ],
              ),
            ),
           
          ],
        ),
      ),
    );
  }
}
