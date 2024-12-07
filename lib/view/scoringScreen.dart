// main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:you_got_world/themes/colors.dart';
import 'package:you_got_world/utils/responsive.dart';
import 'package:you_got_world/view/widget/startMatch/shortcutButtonWidget.dart';

import '../controllers/scoringController.dart';

// scoring_screen.dart
class ScoringScreen extends StatelessWidget {
  const ScoringScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ScoringController());

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Color(0xffE0E0E0).withOpacity(.95),
        surfaceTintColor: Color(0xffE0E0E0).withOpacity(.95),
        iconTheme: IconThemeData(color: colorDark1),
        title: Text(
          'TEAM A',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 14),
            child: const Icon(
              Icons.settings_outlined,
              color: colorDark1,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Score Display
                  _buildScoreDisplay(controller, context),
            
                  // Player Selection
                  _buildPlayerSelection(context),
            
                  // Current Batsman
                  _buildCurrentBatsman(context),
            
                  // Shot Direction
                  _buildShotDirection(controller, context),
            
                  // Scoring Pad
                  _buildScoringPad(controller, context),
                ],
              ),
            ),
          ),
                SizedBox(height: 5,),
          GestureDetector(
          onTap: () {
            showShortcutBottomSheet();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            margin: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color: colorDark1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Scoring Shortcuts',
                    style: TextStyle(
                        fontSize: context.deviceHeight * .018,
                        fontWeight: FontWeight.w500),
                  ),
                  Icon(Icons.keyboard_arrow_up),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 5,)
        ],
      ),
    
    );
  }

  Widget _buildScoreDisplay(
      ScoringController controller, BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .4,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                  'https://cdn.britannica.com/63/211663-050-A674D74C/Jonny-Bairstow-batting-semifinal-match-England-Australia-2019.jpg'))),
      child: Container(
        width: context.deviceWidth,
        height: context.deviceHeight,
        padding: EdgeInsets.only(top: context.deviceHeight * .1),
        color: primaryColor.withOpacity(.7),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Obx(
                () => RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text:
                            '${controller.score.value}/${controller.wickets.value}',
                        style: TextStyle(
                            color: colorLightWhite,
                            fontSize: context.deviceHeight * .051,
                            fontWeight: FontWeight.w600),
                      ),
                      TextSpan(
                        text:
                            ' (${controller.balls.value}/${controller.maxBalls.value})',
                        style: TextStyle(
                          color: Colors.white.withOpacity(.7),
                          fontSize: context.deviceHeight * .03,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 6,
            ),
            Text(
              "Team A won the toss and elected to bat",
              style: TextStyle(
                fontSize: context.deviceHeight * .017,
                color: colorLightWhite,
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPlayerSelection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 16),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              decoration: BoxDecoration(
                color: Color(0xff41D48E).withOpacity(.2),
                border: Border.all(
                  color: Color(0xff41D48E),
                ),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.sports_cricket,
                    color: Color(0xff41D48E),
                    size: 28,
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Amar Sharma',
                        style: TextStyle(
                            fontSize: context.deviceHeight * .016,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff41D48E)),
                      ),
                      Text(
                        'Replace',
                        style: TextStyle(
                            fontSize: context.deviceHeight * .014,
                            color: Color(0xffFFCB00),
                            decoration: TextDecoration.underline,
                            decorationColor: Color(0xffFFCB00)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(color: colorLight3),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.sports_cricket,
                    color: colorDark1,
                    size: 28,
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Amar Sharma',
                        style: TextStyle(
                            fontSize: context.deviceHeight * .016,
                            fontWeight: FontWeight.w600,
                            color: colorDark1),
                      ),
                      Text(
                        'Replace',
                        style: TextStyle(
                            fontSize: context.deviceHeight * .014,
                            color: colorDark3,
                            decoration: TextDecoration.underline,
                            decorationColor: colorDark3),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentBatsman(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 25),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.equalizer_rounded,
            ),
            const SizedBox(width: 8),
            Text(
              'Abhishek Sharma',
              style: TextStyle(
                  fontSize: context.deviceHeight * .016,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(width: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: colorLight2,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(85),
                          color: colorLight3.withOpacity(.6)),
                      child: Text(
                        'Ball...',
                        style: TextStyle(
                          fontSize: context.deviceHeight * .016,
                          fontWeight: FontWeight.w500,
                        ),
                      )),
                  SizedBox(width: 8),
                  CircleAvatar(
                    backgroundColor: Colors.grey.shade400,
                    radius: 12,
                    child: Text('1',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: context.deviceHeight * .015,
                        )),
                  ),
                  SizedBox(width: 4),
                  CircleAvatar(
                    backgroundColor: Colors.grey.shade400,
                    radius: 12,
                    child: Text('1',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                          fontSize: context.deviceHeight * .015,
                        )),
                  ),
                  SizedBox(width: 4),
                  CircleAvatar(
                    backgroundColor: Colors.grey.shade400,
                    radius: 12,
                    child: Text('1',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                          fontSize: context.deviceHeight * .015,
                        )),
                  ),
                  SizedBox(width: 4),
                  CircleAvatar(
                    backgroundColor: Colors.grey.shade400,
                    radius: 12,
                    child: Text('0',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: context.deviceHeight * .015,
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShotDirection(
      ScoringController controller, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildDirectionColumn(
              'Over the wicket',
              () => controller.setDirection('over'),
              'assets/img/Over the wicket.png',
              context),
          _buildDirectionColumn(
              'Between the wicket',
              () => controller.setDirection('between'),
              'assets/img/Between the wicket.png',
              context),
          _buildDirectionColumn(
              'Round the wicket',
              () => controller.setDirection('round'),
              'assets/img/Round the wicket.png',
              context),
        ],
      ),
    );
  }

  Widget _buildDirectionColumn(
      String label, VoidCallback onTap, String icon, BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border.all(color: colorLight3),
              shape: BoxShape.circle,
            ),
            child: Image.asset(
              icon,
              height: context.deviceHeight * .038,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
                fontSize: context.deviceHeight * .013,
                fontWeight: FontWeight.w500,
                color: colorDark3),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildScoringPad(ScoringController controller, BuildContext context) {
    return Container(
      // height: context.deviceHeight*.6,
      margin: EdgeInsets.only(top: context.deviceHeight * .02),
      padding: EdgeInsets.only(
          left: context.deviceHeight * .01, right: context.deviceHeight * .01),
      decoration: BoxDecoration(color: colorLight3.withOpacity(.4)),
      child: GridView.count(
        crossAxisCount: 4,
        mainAxisSpacing: 8,
        physics: NeverScrollableScrollPhysics(),
        crossAxisSpacing: 8,
        padding: EdgeInsets.only(
            top: context.deviceHeight * .01,
            bottom: context.deviceHeight * .01),
        shrinkWrap: true, // Allows GridView to shrink to fit content
        children: [
          _buildScoreButton('0', () => controller.addScore(0), context),
          _buildScoreButton('1', () => controller.addScore(1), context),
          _buildScoreButton('2', () => controller.addScore(2), context),
          _buildScoreButton('UNDO', controller.undoLastAction, context,
              isSpecial: true),
          _buildScoreButton('3', () => controller.addScore(3), context),
          _buildScoreButton('4\nFOUR', () => controller.addScore(4), context),
          _buildScoreButton('6\nSIX', () => controller.addScore(6), context),
          _buildScoreButton('OUT', () => controller.addWicket(), context,
              isSpecial: true),
          _buildScoreButton('WD', () => controller.addWide(), context),
          _buildScoreButton('NB', () => controller.addNoBall(), context),
          _buildScoreButton('BYE', () => controller.addBye(), context),
          _buildScoreButton('LB', () => controller.addLegBye(), context),
        ],
      ),
    );
  }

  Widget _buildScoreButton(
      String label, VoidCallback onPressed, BuildContext context,
      {bool isSpecial = false}) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: Color(0xffEFEFEF),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
      ),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: isSpecial
                ? (label == 'OUT' ? Colors.red : Colors.green)
                : Colors.black,
            fontWeight: isSpecial
                ? (label == 'OUT' ? FontWeight.w700 : FontWeight.w700)
                : FontWeight.w500,
            fontSize: context.deviceHeight * .019),
      ),
    );
  }
}
