import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:you_got_world/themes/colors.dart';
import 'package:you_got_world/utils/responsive.dart';

class ContinueWatchWidget extends StatelessWidget {
  const ContinueWatchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.deviceWidth * .5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: context.deviceWidth * .5,
                  height: context.deviceHeight * .16,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            'https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/e60d59103015959.5f43f7d599ad9.jpg', // Replace with your image URL
                          ))),
                  child: Container(
                    padding: EdgeInsets.only(left: 0),
                    decoration:
                        BoxDecoration(color: Colors.black.withOpacity(.6)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.only(left: 6),
                          child: Text('Peaky Blinders',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: context.deviceHeight * .017,
                                  color: colorLightWhite)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 6),
                          child: Text('2023',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: context.deviceHeight * .014,
                              )),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Container(
                                height: 3,
                                color: errorColor,
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: 3,
                                color: Colors.grey.withOpacity(.6),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: primaryColor, shape: BoxShape.circle),
                    child: Icon(Icons.play_arrow_rounded,
                        color: colorLightWhite, size: 20)),
              ],
            ),
         
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 8,
                  ),
                  Text('S1 E04',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: context.deviceHeight * .017,
                          color: colorLightWhite)),
                  Text('4m Left',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: context.deviceHeight * .012,
                      )),
                ],
              ),
              Icon(
                CupertinoIcons.ellipsis_vertical,
                color: colorLightWhite,
              )
            ],
          )
        ],
      ),
    );
  }
}
