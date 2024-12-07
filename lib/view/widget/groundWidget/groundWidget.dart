import 'package:flutter/material.dart';
import 'package:you_got_world/utils/responsive.dart';

import '../../../themes/colors.dart';

class GroundWidget extends StatelessWidget {
  VoidCallback onTap;
   GroundWidget({super.key,required this.onTap});

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
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(16)),
                              child: Image.network(
                                'https://fancyodds.com/wp-content/uploads/2021/12/Neerja-Modi-School.jpg',
                                height: context.deviceHeight * .2,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const Positioned(
                              top: 8,
                              right: 8,
                              child: CircleAvatar(
                                  radius: 26,
                                  backgroundColor: Colors.white,
                                  child: Icon(
                                    Icons.qr_code,
                                    size: 27,
                                    color: colorDark1,
                                  )
                                  // SvgPicture.asset(
                                  //   'assets/qr_code.svg',
                                  //   height: 24,
                                  //   width: 24,
                                  // ),
                                  ),
                            ),
                            Positioned(
                              top: 18,
                              left: 8,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 14),
                                decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(.45),
                                    borderRadius: BorderRadius.circular(12)),
                                child: Text(
                                  '02:40 PM',
                                  style: TextStyle(
                                      color: colorLightWhite,
                                      fontWeight: FontWeight.w600,
                                      fontSize: context.deviceHeight * .017),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Silver Cricket ground',
                                style: TextStyle(
                                    fontSize: context.deviceHeight * .0195,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(height: 4),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '24.5 KM | Confirmation 100%',
                                    style: TextStyle(
                                        color: Colors.redAccent,
                                        fontSize: context.deviceHeight * .017,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Spacer(),
                                  Icon(Icons.star, color: Colors.amber),
                                  Text(
                                    '  5.0',
                                    style: TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Divider(
                                color: colorLight2,
                              ),
                              SizedBox(height: 8),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '\$200.7',
                                      style: TextStyle(
                                          color: primaryColor,
                                          fontSize: context.deviceHeight * .0216,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    TextSpan(
                                      text: ' /night',
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
                                '*Price are half for slot booking*',
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