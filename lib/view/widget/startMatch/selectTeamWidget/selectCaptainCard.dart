import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:you_got_world/themes/colors.dart';
import 'package:you_got_world/utils/responsive.dart';
import '../../../../controllers/squadController.dart';

class SelectCaptainCardWidget extends StatelessWidget {
  final int index;
  String image, name;
  final String playerId;
  final SquadController squadController = Get.put(SquadController());

  SelectCaptainCardWidget({
    required this.index,
    required this.image,
    required this.name,
    required this.playerId,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        squadController.togglePlayerSelection(index, playerId);
      },
      child: Obx(() {
        bool isSelected =
            (squadController.selectedPosition.value == 'Captain' &&
                    squadController.selectedCaptainId.value == playerId) ||
                (squadController.selectedPosition.value == 'Wicket Keeper' &&
                    squadController.selectedWicketKeeperId.value == playerId);

        return Container(
          margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isSelected ? colorDark1 : Colors.white,
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
              Stack(
                children: [
                  CircleAvatar(
                    backgroundColor: colorLight2,
                    backgroundImage: image.isNotEmpty
                        ? NetworkImage(image)
                        : AssetImage('assets/img/demoImages.png'),
                    radius: 25,
                  ),
                  if (isSelected)
                    Positioned(
                      bottom: 8,left: 2,
                      child: Container(
                        width: context.deviceWidth * .12,
                        height: context.deviceHeight * .053,
                        decoration: BoxDecoration(
                          color: primaryColor.withOpacity(.6),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Icon(Icons.check, color: colorLightWhite),
                        ),
                      ),
                    ),
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
