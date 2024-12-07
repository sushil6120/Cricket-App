import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:you_got_world/themes/colors.dart';
import 'package:you_got_world/utils/responsive.dart';
import 'package:you_got_world/view/selectSquadScreen.dart';
import 'package:you_got_world/view/widget/titletextWidget.dart';

class ByeRunsBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.back(), // Close the bottom sheet on tap
      child: Container(
        height: MediaQuery.of(context).size.height * 0.3,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: Column(
          children: [
            Container(
              width: 50,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 20, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('Buy Runs',
                          style: TextStyle(
                            fontSize: context.deviceHeight * .019,
                            fontWeight: FontWeight.w600,
                          )),
                   
                    ],
                  ),
                  Center(
                    child: Container(
                      width: context.deviceHeight * .12,
                      height: 3,
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10))),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                itemCount: 5,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 1 / .4),
                itemBuilder: (context, index) {
                  return ShortcutTile(
                    label: _getLabel(index),
                  );
                },
              ),
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Amar Sharma",
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500,color: colorDark3),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Change",
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: errorColor)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  String _getLabel(int index) {
    List<String> labels = [
      "1",
      "2",
      "3",
      "4",
      "+",
    ];
    return labels[index];
  }
}

class ShortcutTile extends StatelessWidget {
  final String label;

  ShortcutTile({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 6, right: 6),
      decoration: BoxDecoration(
        border: Border.all(color: colorLight2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(
                fontSize: context.deviceHeight * .013,
                fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// To display the bottom sheet
void showByeRunsBottomSheet() {
  Get.bottomSheet(
    ByeRunsBottomSheet(),
    isScrollControlled: true,
  );
}
