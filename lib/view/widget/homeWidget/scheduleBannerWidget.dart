import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:you_got_world/themes/colors.dart';
import 'package:you_got_world/utils/responsive.dart';
import 'package:you_got_world/view/homeScreen.dart';

class ScheduleBannerWidget extends StatelessWidget {
  final String image;
  // final String title;

  const ScheduleBannerWidget({
    required this.image,
    // required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          // padding: EdgeInsets.only(left: 12, bottom: 6),
          width: context.deviceWidth,
          height: context.deviceHeight * .24,
          margin: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: NetworkImage(image),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: context.deviceWidth,
                padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                  gradient: LinearGradient(colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(.9)
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                ),
                child: RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: 'Cricket',
                        style: TextStyle(
                            color: errorColor, fontWeight: FontWeight.w300),
                      ),
                      const TextSpan(
                        text: ' . Wed 12/6',
                        style: TextStyle(
                          color: colorLight2,
                        ),
                      ),
                      const TextSpan(
                        text: ' . 8:20 PM ',
                        style: TextStyle(
                            color: colorLight2, fontWeight: FontWeight.w300),
                      ),
                      WidgetSpan(
                          child: Container(
                        margin: EdgeInsets.only(left: 4),
                        padding:
                            EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(.4),
                            borderRadius: BorderRadius.circular(50)),
                        child: Text(
                          '🔥 Top',
                          style: TextStyle(
                              color: colorLightWhite,
                              fontWeight: FontWeight.w300,
                              fontSize: 8),
                        ),
                      ))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        // Container(
        //   width: context.deviceWidth,
        //   height: context.deviceHeight * .24,
        //   decoration: BoxDecoration(
        //     gradient:
        //         LinearGradient(colors: [Colors.transparent, Colors.black]),
        //   ),
        // )
      ],
    );
  }
}
