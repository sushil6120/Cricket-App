import 'package:flutter/material.dart';
import 'package:you_got_world/themes/colors.dart';
import 'package:you_got_world/utils/responsive.dart';

class LatestTrendingSection extends StatelessWidget {
  final List<String> trendingItems;
  String title;

   LatestTrendingSection({required this.trendingItems, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Padding(
             padding: const EdgeInsets.only(left: 16),
             child: Text(
              title,
              style:
                  const TextStyle(fontWeight: FontWeight.w600, color: colorLightWhite),
                       ),
           ),
          const SizedBox(height: 10),
          SizedBox(
            height: context.deviceHeight * .22,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(left: 20),
              itemCount: trendingItems.length,
              itemBuilder: (context, index) {
                return TrendingItem(image: trendingItems[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TrendingItem extends StatelessWidget {
  final String image;

  const TrendingItem({required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.deviceWidth * .34,
      margin: const EdgeInsets.only(right: 16),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(image, fit: BoxFit.cover)),
    );
  }
}
