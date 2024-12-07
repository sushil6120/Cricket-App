import 'package:flutter/material.dart';
import 'package:you_got_world/utils/responsive.dart';

import '../../../themes/colors.dart';

class GroundTImeWidget extends StatelessWidget {
  const GroundTImeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildDateItem('Mon', '01-06-2024', false, context),
          _buildDateItem('Tue', '02-06-2024', true, context),
          _buildDateItem('Wed', '01-06-2024', false, context),
          _buildDateItem('Thu', '01-06-2024', false, context),

        ],
      ),
    );
  }

  Widget _buildDateItem(
      String day, String date, bool selected, BuildContext context) {
    return GestureDetector(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: context.deviceHeight * .016,
                vertical: context.deviceHeight * .016),
            decoration: BoxDecoration(
                color: selected
                    ? primaryColor.withOpacity(0.2)
                    : Colors.grey.withOpacity(.15),
                shape: BoxShape.circle),
            child: Text(
              day,
              style: TextStyle(
                  fontSize: context.deviceHeight * .015,
                  color: selected ? primaryColor : Colors.grey,
                  fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 4),
            child: Column(
              children: [
                Text(
                  date,
                  style: TextStyle(
                    fontSize: context.deviceHeight * .014,
                    color: selected ? primaryColor : Colors.grey,
                    fontWeight: selected ? FontWeight.w500 : FontWeight.w400,
                  ),
                ),
                selected
                    ? Container(
                        margin: const EdgeInsets.only(top: 1),
                        width: context.deviceWidth * .16,
                        height: context.deviceHeight * .004,
                        decoration: const BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20))),
                      )
                    : SizedBox()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
