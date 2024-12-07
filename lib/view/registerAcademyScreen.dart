import 'package:flutter/material.dart';
import 'package:you_got_world/utils/responsive.dart';
import 'package:you_got_world/utils/valueConstants.dart';

import '../themes/colors.dart';
import 'widget/redButton.dart';
import 'widget/textFormFields.dart';
import 'widget/uploadAcdemyImageWudget.dart';

class RegisterAcademyScreen extends StatelessWidget {
  const RegisterAcademyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorLightWhite,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: .5,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        iconTheme: IconThemeData(color: colorLightWhite),
        title: Text(
          "REGISTER YOUR ACADEMY",
          style: TextStyle(
              fontSize: context.deviceHeight * .014,
              fontWeight: FontWeight.w500,
              color: colorLightWhite),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
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
                        child: Stack(
                          children: [
                            Container(
                              decoration:
                                  BoxDecoration(color: primaryColor.withOpacity(.6)),
                            ),
                            Positioned(
                              bottom: 20,
                              right: 30,
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.white.withOpacity(.40),
                                child: Icon(
                                  Icons.edit,
                                  size: 18,
                                  color: Colors.white.withOpacity(.70),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: context.deviceHeight * .18,
                            left: 16), // Adjust as needed
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: CircleAvatar(
                                    radius: 50,
                                    backgroundColor: Color(0xffE8F2FE),
                                    child: Icon(
                                      Icons.sports_cricket_rounded,
                                      size: 40,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 5,
                                  right: 0,
                                  child: CircleAvatar(
                                    radius: 20,
                                    backgroundColor: primaryColor,
                                    child: Icon(
                                      Icons.mode_edit_outline_outlined,
                                      size: 20,
                                      color: colorLightWhite,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 14, right: 14, top: verticalSpaceSmall),
                    child: TextFormFieldBig(
                      // controller: emailController,
                      height: 50,
                      hintText: 'Academy Name',
                      maxLines: 1,
                      enabled: true,
                      fillColor: colorLight2,
                      isFill: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 14, right: 14, top: verticalSpaceSmall),
                    child: TextFormFieldBig(
                      // controller: emailController,
                      height: 50,
                      hintText: 'Academy Owner Name',
                      maxLines: 1,
                      enabled: true,
                      fillColor: colorLight2,
                      isFill: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 14, right: 14, top: verticalSpaceSmall),
                    child: TextFormFieldBig(
                      // controller: emailController,
                      height: 50,
                      hintText: 'Contact Number',
                      maxLines: 1,
                      enabled: true,
                      fillColor: colorLight2,
                      isFill: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 14, right: 14, top: verticalSpaceSmall),
                    child: TextFormFieldBig(
                      // controller: emailController,
                      height: 50,
                      hintText: 'Coach Name',
                      maxLines: 1,
                      enabled: true,
                      fillColor: colorLight2,
                      isFill: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 14, right: 14, top: verticalSpaceSmall),
                    child: TextFormFieldBig(
                      // controller: emailController,
                      height: 50,
                      hintText: 'Coach information',
                      maxLines: 1,
                      enabled: true,
                      fillColor: colorLight2,
                      isFill: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 14, right: 14, top: verticalSpaceSmall),
                    child: TextFormFieldBig(
                      // controller: emailController,
                      height: 50,
                      hintText: 'Email ID',
                      maxLines: 1,
                      enabled: true,
                      fillColor: colorLight2,
                      isFill: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 14, right: 14, top: verticalSpaceSmall),
                    child: TextFormFieldBig(
                      // controller: emailController,
                      height: 50,
                      hintText: 'Academy Address',
                      maxLines: 1,
                      enabled: true,
                      fillColor: colorLight2,
                      isFill: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 14, right: 14, top: verticalSpaceSmall),
                    child: TextFormFieldBig(
                      // controller: emailController,
                      height: 50,
                      hintText: 'Academy Location',
                      maxLines: 1,
                      enabled: true,
                      fillColor: colorLight2,
                      isFill: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 14, right: 14, top: verticalSpaceSmall),
                    child: TextFormFieldBig(
                      // controller: emailController,
                      height: 50,
                      hintText: 'YouTube Link',
                      maxLines: 1,
                      enabled: true,
                      fillColor: colorLight2,
                      isFill: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 14, right: 14, top: verticalSpaceSmall),
                    child: TextFormFieldBig(
                      // controller: emailController,
                      height: 50,
                      hintText: 'Facebook Link',
                      maxLines: 1,
                      enabled: true,
                      fillColor: colorLight2,
                      isFill: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 14, right: 14, top: verticalSpaceSmall),
                    child: TextFormFieldBig(
                      // controller: emailController,
                      height: 50,
                      hintText: 'Academy Name',
                      maxLines: 1,
                      enabled: true,
                      fillColor: colorLight2,
                      isFill: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 14, right: 14, top: verticalSpaceSmall),
                    child: TextFormFieldBig(
                      // controller: emailController,
                      height: 50,
                      hintText: 'Instagram Link',
                      maxLines: 1,
                      enabled: true,
                      fillColor: colorLight2,
                      isFill: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 14,
                        right: 14,
                        top: verticalSpaceSmall,
                        bottom: verticalSpaceMedium),
                    child: TextFormFieldBig(
                      // controller: emailController,
                      height: 50,
                      hintText:
                          'Type your academy achievements and type academy facilities.',
                      maxLines: 6,
                      enabled: true,
                      fillColor: colorLight2,
                      isFill: true,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Obx(
            //   () {
            // return
            SizedBox(
              width: context.deviceWidth * .9,
              child: RedButton(
                // isLoading: authController.loginLoad.value,
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) => UploadBottomSheet(),
                  );
                },
                text: 'Next',
              ),
            )
            //   },
            // ),
          ],
        ), 
        ],
      ),
     
    );
  }
}
