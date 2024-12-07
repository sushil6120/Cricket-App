import 'package:flutter/material.dart';
import 'package:you_got_world/utils/responsive.dart';

import '../../../themes/colors.dart';

class AcademyCardWidget extends StatelessWidget {
  VoidCallback onTap;
  String ?title , image, price,location;
  AcademyCardWidget({super.key, required this.onTap,this.image, this.location,this.price,this.title });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          elevation: 5,
          shadowColor: colorDark3.withOpacity(.4),
          color: colorLightWhite,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          margin: const EdgeInsets.only(bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.network(
                  image!,
                  height: context.deviceHeight * .2,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                         title!,
                          style: TextStyle(
                              fontSize: context.deviceHeight * .0195,
                              fontWeight: FontWeight.w500),
                        ),
                        Spacer(),
                        Icon(Icons.star, color: Colors.amber),
                        Text(
                          '  5.0',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      location!,
                      style: TextStyle(
                          fontSize: context.deviceHeight * .015,
                          color: colorDark3,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(height: 8),
                    Divider(
                      color: colorLight2,
                    ),
                    SizedBox(height: 4),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '\$$price',
                            style: TextStyle(
                                color: Color(0xffFF0000),
                                fontSize: context.deviceHeight * .0216,
                                fontWeight: FontWeight.w700),
                          ),
                          TextSpan(
                            text: ' /1m',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: context.deviceHeight * .016),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: colorLight2,
                    ),
                    Text(
                      '24 Reviews',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: context.deviceHeight * .016),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
