import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:you_got_world/controllers/communityController.dart';
import 'package:you_got_world/model/scorereModel.dart';
import 'package:you_got_world/themes/colors.dart';
import 'package:you_got_world/utils/responsive.dart';
import 'package:you_got_world/utils/shimmerContainer.dart';
import 'package:you_got_world/view/community/addScorerScreen.dart';
import 'package:you_got_world/view/widget/loadingWidget.dart';
import 'package:you_got_world/view/widget/redButton.dart';

class CommunityScorersScreen extends StatelessWidget {
  final controller = Get.put(CommunityController());

  final List<String> tabs = [
    'Limited Overs',
    'Box/Turf Cricket',
    'Test Match',
    'The Hundred',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          backgroundColor: primaryColor,
          surfaceTintColor: primaryColor,
          iconTheme: IconThemeData(color: colorLightWhite),
          title: Text(
            'Scorers',
            style: TextStyle(
                color: colorLightWhite, fontSize: context.deviceHeight * .024),
          ),
          actions: [
            IconButton(
              icon: Icon(CupertinoIcons.search, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.message_outlined, color: colorLightWhite),
              onPressed: () {},
            ),
            // Stack(
            //   alignment: Alignment.topRight,
            //   children: [
            //     IconButton(
            //       icon:
            //           Icon(Icons.filter_alt_outlined, color: colorLightWhite),
            //       onPressed: () {},
            //     ),
            //     Positioned(
            //       right: 8,
            //       top: 8,
            //       child: Container(
            //         padding: EdgeInsets.all(2),
            //         decoration: BoxDecoration(
            //           color: Colors.amber,
            //           borderRadius: BorderRadius.circular(10),
            //         ),
            //         constraints: BoxConstraints(
            //           minWidth: 16,
            //           minHeight: 16,
            //         ),
            //         child: Text(
            //           '4',
            //           style: TextStyle(
            //             color: Colors.black,
            //             fontSize: 10,
            //             fontWeight: FontWeight.bold,
            //           ),
            //           textAlign: TextAlign.center,
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            SizedBox(width: 8),
          ],
        ),
        body: Obx(
          () {
            if (controller.isLoading.value == true) {
              return LoadingWidget();
            } else {
              return Column(
                children: [
                  _buildHeader(context),
                  _buildTabs(),
                  controller.scorerData.isEmpty
                      ? Center(
                          child: Text("No Scorer Found"),
                        )
                      : Expanded(
                          child: _buildScorersList(controller.scorerData),
                        ),
                  Container(
                    color: colorLightWhite,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 4, right: 4, top: 14, bottom: 22),
                      child: Row(
                        children: [
                          Expanded(
                              child: ElevatedButton(
                            onPressed: () {
                              Get.to(AddScorerScreen(),
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
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                            child: Text(
                              'Add Scorrer',
                              style: TextStyle(
                                  fontSize: context.deviceHeight * .016,
                                  fontWeight: FontWeight.w500),
                            ),
                          )),
                          SizedBox(
                            width: 4,
                          ),
                          Expanded(
                              child: ElevatedButton(
                            onPressed: () {
                              Get.to(AddScorerScreen(),
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
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                            child: Text(
                              'Find Tournament',
                              style: TextStyle(
                                  fontSize: context.deviceHeight * .016,
                                  fontWeight: FontWeight.w500),
                            ),
                          ))
                        ],
                      ),
                    ),
                  )
                ],
              );
            }
          },
        ));
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 6, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Top Scorers of ',
                    style: TextStyle(
                      fontSize: context.deviceHeight * .016,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  TextSpan(
                    text: 'New Delhi - November',
                    style: TextStyle(
                      fontSize: context.deviceHeight * .016,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      height: 40,
      margin: EdgeInsets.only(left: 16, right: 16, bottom: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tabs.length,
        itemBuilder: (context, index) {
          return Obx(() {
            final isSelected = controller.selectedTabIndex.value == index;
            return GestureDetector(
              onTap: () => controller.changeTab(index),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                margin: EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  color: isSelected ? primaryColor : Colors.grey[200],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    tabs[index],
                    style: TextStyle(
                      color: isSelected ? colorLightWhite : Colors.black87,
                      fontSize: context.deviceHeight * .014,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            );
          });
        },
      ),
    );
  }

  Widget _buildScorersList(List<Scorer>? scorer) {
    return Obx(() {
      return NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (!controller.isLoading.value &&
              scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
            controller.scorersApi(name: '');
            return true;
          }
          return false;
        },
        child: ListView.builder(
          padding: EdgeInsets.all(16),
          itemCount: controller.scorerData.length +
              (controller.hasMoreData.value ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == controller.scorerData.length) {
              return Center(child: SizedBox.shrink());
            }

            final scorer = controller.scorerData[index];

            return Card(
              margin: EdgeInsets.only(bottom: 16),
              color: colorLightWhite,
              surfaceTintColor: colorLightWhite,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child:
                              scorer.profile == null || scorer.profile!.isEmpty
                                  ? Image.network(
                                      'https://img.freepik.com/free-photo/colorful-design-with-spiral-design_188544-9588.jpg',
                                      width: context.deviceWidth * .2,
                                      height: context.deviceHeight * .09,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.network(
                                      scorer.profile.toString(),
                                      width: context.deviceWidth * .2,
                                      height: context.deviceHeight * .09,
                                      fit: BoxFit.cover,
                                    ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    scorer.name.toString(),
                                    style: TextStyle(
                                      fontSize: context.deviceHeight * .018,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  if (scorer.isVerified == 'YES')
                                    Icon(Icons.verified,
                                        color: primaryColor, size: 20),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Matches Scored: ${scorer.totalMatch}',
                                      style: TextStyle(
                                          fontSize: context.deviceHeight * .014,
                                          color: Colors.grey[800],
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 14),
                                    child: Text(
                                      '${scorer.ranking}',
                                      style: TextStyle(
                                        fontSize: context.deviceHeight * .036,
                                        color: Colors.amber,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              if (scorer.ratting != null) ...[
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.amber),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        '${scorer.ratting}/5',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize:
                                                context.deviceHeight * .012,
                                            color: Colors.amber),
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      '${scorer.totalReview}',
                                      style: TextStyle(
                                          fontSize:
                                              context.deviceHeight * .012),
                                    ),
                                  ],
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: context.deviceWidth,
                    padding: EdgeInsets.only(
                        left: 16, right: 16, top: 12, bottom: 12),
                    decoration: BoxDecoration(
                        color: Colors.amber.shade100.withOpacity(.3)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "₹ ${scorer.perDayMatchFee}  ₹ ${scorer.perMatchFee} ",
                          style: TextStyle(
                            color: colorDark3,
                            fontSize: context.deviceHeight * .016,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Icon(Icons.message_outlined, color: primaryColor),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    });
  }
}
