import 'package:flutter/material.dart';
import 'package:you_got_world/themes/colors.dart';

class TeamCardWidget extends StatelessWidget {
  final String teamName;
  final String location;
  final String imageUrl;
  final VoidCallback onTap;
  final bool isOpponent;
  final bool isSelected;
  final int myteamIndex;
  final int index;

  const TeamCardWidget({
    required this.teamName,
    required this.location,
    required this.imageUrl,
    required this.onTap,
    required this.isOpponent,
    required this.isSelected,
    required this.myteamIndex,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color:myteamIndex == index
                  ? colorDark1
                  : Colors.transparent, // Change border if selected
              width: 1, // Make the border more visible
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              imageUrl.isEmpty
                  ? CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('assets/img/demoImages.png'),
                      child: myteamIndex == index
                          ? Icon(
                              Icons.check,
                              color: colorLightWhite,
                              size: 30,
                            )
                          : SizedBox(),
                    )
                  : CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(imageUrl),
                      child: myteamIndex == index
                          ? Icon(
                              Icons.check,
                              color: colorLightWhite,
                              size: 30,
                            )
                          : SizedBox(),
                    ),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    teamName,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    location,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.red.withOpacity(.6),
                    ),
                  ),
                ],
              ),
              Spacer(),
              isOpponent ? SizedBox() : Icon(Icons.qr_code, size: 30),
            ],
          ),
        ),
      ),
    );
  }
}
