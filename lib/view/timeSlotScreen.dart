import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:you_got_world/themes/colors.dart';
import 'package:you_got_world/utils/responsive.dart';
import 'package:you_got_world/utils/valueConstants.dart';
import 'package:you_got_world/view/reciewBookingDetails.dart';

import 'widget/groundWidget/groundTimeWidget.dart';

class TimeSlotScreen extends StatefulWidget {
  const TimeSlotScreen({super.key});

  @override
  State<TimeSlotScreen> createState() => _TimeSlotScreenState();
}

class _TimeSlotScreenState extends State<TimeSlotScreen> {
  String? _selectedTime;

  final List<String> times = [
    "3:00 PM",
    "6:00 PM",
    "9:30 PM",
    "1:00 PM",
    "2:00 PM",
    "7:10 PM",
    "8:10 PM",
    "10:30 PM",
    "11:00 PM",
    "12:00 PM",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorLightWhite,
      appBar: AppBar(
        backgroundColor: colorLightWhite,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(),
          const SizedBox(
            height: verticalSpaceSmall2,
          ),
          const Center(child: GroundTImeWidget()),
          const SizedBox(
            height: verticalSpaceMedium,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Booking Slot',
                    style: TextStyle(
                      fontSize: context.deviceHeight * .020,
                      fontWeight: FontWeight.w600,
                    )),
                Container(
                  margin: const EdgeInsets.only(top: 1),
                  width: context.deviceWidth * .26,
                  height: context.deviceHeight * .006,
                  decoration: const BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20))),
                ),
                const SizedBox(
                  height: verticalSpaceSmall,
                ),
                GridView.builder(
                  shrinkWrap: true,
                  itemCount: times.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4, // Always show 4 items in a row
                    crossAxisSpacing: 8.0, // Spacing between items horizontally
                    mainAxisSpacing: 8.0, // Spacing between items vertically
                    childAspectRatio: 2.1, // Aspect ratio of each item
                  ),
                  itemBuilder: (context, index) {
                    String time = times[index];
                    return GestureDetector(
                      onTap: () {
                        if (time != '3:00 PM' || time != '6:00 PM') {
                          setState(() {
                            _selectedTime = time;
                          });
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: time == '3:00 PM' || time == '6:00 PM'
                              ? Colors.grey.withOpacity(.2)
                              : _selectedTime == time
                                  ? primaryColor
                                  : colorLightWhite,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: time == '3:00 PM' || time == '6:00 PM'
                                ? Colors.grey.withOpacity(.2)
                                : _selectedTime == time
                                    ? primaryColor
                                    : Colors.grey,
                            width: 0.5,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          time,
                          style: TextStyle(
                            fontSize: context.deviceHeight * .014,
                            fontWeight: FontWeight.w600,
                            color: time == '3:00 PM' || time == '6:00 PM'
                                ? Colors.grey
                                : _selectedTime == time
                                    ? Colors.white
                                    : Colors.black,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),

       bottomNavigationBar: Container(
          padding: EdgeInsets.only(
              top: context.deviceHeight * .02,
              bottom: context.deviceHeight * .038,
              left: context.deviceWidth * .02,
              right: context.deviceWidth * .02),
          decoration: BoxDecoration(color: colorLightWhite, boxShadow: [
            BoxShadow(
                color: colorDark3.withOpacity(.5),
                offset: Offset(0, -4),
                blurRadius: 28,
                spreadRadius: 0)
          ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 18, right: 8),
                child: Text('Rs 3500- 6000',
                    style: TextStyle(
                        fontSize: context.deviceHeight * .022,
                        fontWeight: FontWeight.w500)),
              ),
              SizedBox(
                  width: context.deviceWidth * .5,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(ReviewBookingDetailsScreen(),
                          transition: Transition.rightToLeft);
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,

                      foregroundColor: Colors.white,
                      backgroundColor:
                          primaryColor, // Set the text color to white
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    child: Text(
                      'Book Now',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ))
            ],
          ),
        ),
    );
  }
}
