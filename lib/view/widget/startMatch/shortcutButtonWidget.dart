import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:you_got_world/themes/colors.dart';
import 'package:you_got_world/utils/responsive.dart';
import 'package:you_got_world/view/selectSquadScreen.dart';
import 'package:you_got_world/view/widget/titletextWidget.dart';

class ShortcutBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.back(), // Close the bottom sheet on tap
      child: Container(
        height: MediaQuery.of(context).size.height * 0.5,
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
            buildTitleText('Select a shortcut', context.deviceHeight * .17,
                context.deviceHeight * .019, context),
            SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                itemCount: 12,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemBuilder: (context, index) {
                  return ShortcutTile(
                    icon: _getIcon(index),
                    label: _getLabel(index),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIcon(int index) {
    List<IconData> icons = [
      Icons.sports,
      Icons.settings,
      Icons.local_drink,
      Icons.sports_tennis,
      Icons.lightbulb,
      Icons.score,
      Icons.local_drink,
      Icons.sports_tennis,
      Icons.sports,
      Icons.settings,
      Icons.local_drink,
      Icons.sports_tennis,
    ];
    return icons[index];
  }

  String _getLabel(int index) {
    List<String> labels = [
      "Umpire",
      "Scores",
      "Drinking Water",
      "Practice Net",
      "Flood Lights",
      "Scores",
      "Drinking Water",
      "Practice Net",
      "Umpire",
      "Scores",
      "Drinking Water",
      "Practice Net",
    ];
    return labels[index];
  }
}

class ShortcutTile extends StatelessWidget {
  final IconData icon;
  final String label;

  ShortcutTile({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 2, right: 2),
      decoration: BoxDecoration(
        border: Border.all(color: colorLight2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 26,
            color: primaryColor,
          ),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(fontSize: context.deviceHeight * .011),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// To display the bottom sheet
void showShortcutBottomSheet() {
  Get.bottomSheet(
    ShortcutBottomSheet(),
    isScrollControlled: true,
  );
}
