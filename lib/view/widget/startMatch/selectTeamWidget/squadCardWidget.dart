import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:you_got_world/themes/colors.dart';
import 'package:you_got_world/utils/responsive.dart';
import '../../../../controllers/squadController.dart';

class SquadCard extends StatelessWidget {
  final int index;
  String image, name, id;

  final SquadController squadController = Get.put(SquadController());

  SquadCard({required this.index, required this.image, required this.name,required this.id});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        squadController.toggleSelection(index);
        print(squadController.members.value[index].name);
      },
      child: Obx(() {
        var member = squadController.selectedPlayerIds.contains(id);

        return Container(
          margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: member ? colorDark1 : Colors.white,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 0,
                blurRadius: 51,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              // Squad image
              Stack(
                children: [
                  image.isEmpty
                      ? CircleAvatar(
                          backgroundColor: colorLight2,
                          backgroundImage: AssetImage(
                              'assets/img/demoImages.png'), // Replace with your image
                          radius: 25,
                        )
                      : CircleAvatar(
                          backgroundColor: colorLight2,
                          backgroundImage:
                              NetworkImage(image), // Replace with your image
                          radius: 25,
                        ),
                  Positioned(
                    left: 4,
                    bottom: 8,
                    child: Container(
                      width: context.deviceWidth * .12,
                      height: context.deviceHeight * .053,
                      decoration: BoxDecoration(
                          color: member
                              ? primaryColor.withOpacity(.6)
                              : Colors.transparent,
                          shape: BoxShape.circle),
                      child: Center(
                        child: member
                            ? Icon(
                                Icons.check,
                                color: colorLightWhite,
                              )
                            : SizedBox(),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(width: 16.0),
              Text(
                name,
                style: TextStyle(
                  fontSize: context.deviceHeight * .018,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
