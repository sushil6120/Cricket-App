import 'package:flutter/material.dart';
import 'package:you_got_world/themes/colors.dart';
import 'package:you_got_world/utils/responsive.dart';

class GroundAppBarWidget extends StatelessWidget {
  const GroundAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTopBar(context),
        const SizedBox(height: 16),
        _buildTabBar(context),
        const SizedBox(height: 16),
        Container(
          width: context.deviceWidth,
          height: 1,
          color: colorDark3.withOpacity(.2),
        )
      ],
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'MY GROUND',
            style: TextStyle(
                fontSize: context.deviceHeight * .018,
                fontWeight: FontWeight.w600),
          ),
          Row(
            children: [
              Text(
                'New Delhi',
                style: TextStyle(
                    fontSize: context.deviceHeight * .016,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
              Container(
                margin: EdgeInsets.only(left: 6),
                padding: EdgeInsets.symmetric(horizontal: 7, vertical: 7),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: primaryColor.withOpacity(.2)),
                child: Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: context.deviceHeight * .018,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(String label, bool selected, BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: selected ? Colors.black : Colors.transparent,
        borderRadius: BorderRadius.circular(96),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: context.deviceHeight * .014,
          color: selected ? Colors.white : Colors.black,
          fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
        ),
      ),
    );
  }

  Widget _buildTabBar(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildTabButton('MORNING', true, context),
          _buildTabButton('EVENING', false, context),
          _buildTabButton('NIGHT', false, context),
          _buildTabButton('RS1000', false, context),
          _buildTabButton('RS2000', false, context),
        ],
      ),
    );
  }
}
