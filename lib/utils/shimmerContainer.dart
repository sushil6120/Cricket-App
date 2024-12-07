import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:you_got_world/utils/responsive.dart';

class ShimmerTeamContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        margin: EdgeInsets.only(left: 16, right: 16, top: 16),
        padding: EdgeInsets.only(top: 46, bottom: 46),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9),
          border: Border.all(color: Colors.grey.shade400),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildShimmerTeamCard(context),
            Text(
              'VS',
              style: GoogleFonts.roadRage(
                fontSize: context.deviceHeight * .048,
                fontWeight: FontWeight.w400,
                color: Colors.grey.shade500,
              ),
            ),
            _buildShimmerTeamCard(context),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerTeamCard(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.grey.shade400,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(height: 8),
        Container(
          width: 60,
          height: 10,
          color: Colors.grey.shade400,
        ),
        SizedBox(height: 4),
        Container(
          width: 40,
          height: 10,
          color: Colors.grey.shade400,
        ),
      ],
    );
  }
}
