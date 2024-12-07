import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:you_got_world/model/userProfileModel.dart';
import 'package:you_got_world/themes/colors.dart';
import 'package:you_got_world/utils/responsive.dart';
import 'package:you_got_world/utils/valueConstants.dart';

import '../../editProfileScreen.dart';

class ProfileHeader extends StatelessWidget {
  UserProfileModel? userProfileModel;
  String? subtitle;
  ProfileHeader({super.key, this.subtitle, this.userProfileModel});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: context.deviceHeight * .24,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7a/Pollock_to_Hussey.jpg/1200px-Pollock_to_Hussey.jpg'), // Replace with your background image URL
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(color: primaryColor.withOpacity(.8)),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: context.deviceHeight * .18), // Adjust as needed
          child: Column(
            children: [
              CircleAvatar(
                  radius: 50,
                  backgroundImage: userProfileModel!.data!.first.profileImage ==
                              null ||
                          userProfileModel!.data!.first.profileImage!.isEmpty
                      ? NetworkImage(
                          'https://media.gettyimages.com/id/166080748/vector/cricket-player-strikes-the-ball-for-six.jpg?s=612x612&w=gi&k=20&c=V-kwBs62Vum3JsjZTDYTsXeyvA1Q0-ECKwuq8m39hTg=')
                      : NetworkImage(
                          userProfileModel!.data!.first.profileImage.toString())

                  // Replace with actual profile image URL
                  ),
              SizedBox(height: 10),
              Text(
                userProfileModel!.data!.first.name.toString(),
                style: TextStyle(
                    fontSize: context.deviceHeight * .020,
                    fontWeight: FontWeight.w600),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    subtitle == null
                        ? userProfileModel!.data!.first.email.toString()
                        : subtitle!,
                    style: TextStyle(
                        fontSize: context.deviceHeight * .016,
                        color: colorDark2),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  subtitle == null
                      ? Icon(
                          Icons.check_circle_outline_outlined,
                          color: greenColor,
                          size: 16,
                        )
                      : SizedBox()
                ],
              ),
              SizedBox(height: verticalSpaceSmall),
              subtitle == null
                  ? GestureDetector(
                      onTap: () {
                        Get.to(ProfileEditScreen(
                          userProfileModel: userProfileModel,
                        ),
                            transition: Transition.rightToLeft);
                      },
                      child: Container(
                        width: context.deviceWidth * .8,
                        padding: EdgeInsets.symmetric(vertical: 6),
                        decoration: BoxDecoration(
                            border: Border.all(color: colorDark3, width: .8),
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text(
                            "Edit Profile",
                            style: TextStyle(
                                fontSize: context.deviceHeight * .014,
                                color: colorDark2),
                          ),
                        ),
                      ),
                    )
                  : SizedBox(),
              SizedBox(height: 10),
            ],
          ),
        ),
      ],
    );
  }
}
