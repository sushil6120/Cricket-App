// scoring_controller.dart
import 'package:get/get.dart';
import 'package:you_got_world/view/widget/startMatch/byeRunsBottomSheet.dart';
import 'package:you_got_world/view/widget/startMatch/lagByeRunsBottomSheet.dart';
import 'package:you_got_world/view/widget/startMatch/noBallBottomSheet.dart';
import 'package:you_got_world/view/widget/startMatch/shortcutButtonWidget.dart';
import 'package:you_got_world/view/widget/startMatch/wideBallBottomSheet.dart';

class ScoringController extends GetxController {
  // Basic scoring variables
  RxInt score = 0.obs;
  RxInt wickets = 0.obs;
  RxInt balls = 0.obs;
  RxInt maxBalls = 10.obs;

  // Batsmen variables
  RxString striker = 'Abhishek Sharma'.obs;
  RxString nonStriker = 'Amar Sharma'.obs;
  RxList<int> currentBatsmanBalls = <int>[].obs;

  // Shot direction
  RxString selectedDirection = 'over'.obs;

  // Ball history for undo
  RxList<Map<String, dynamic>> ballHistory = <Map<String, dynamic>>[].obs;

  // Add normal runs
  void addScore(int runs) {
    if (balls.value < maxBalls.value) {
      // Store current state for undo
      ballHistory.add({
        'type': 'normal',
        'runs': runs,
        'score': score.value,
        'balls': balls.value,
        'wickets': wickets.value
      });

      // Update score and balls
      score.value += runs;
      balls.value++;
      currentBatsmanBalls.add(runs);

      // Keep only last 4 balls
      if (currentBatsmanBalls.length > 4) {
        currentBatsmanBalls.removeAt(0);
      }

      // Rotate strike for odd runs or at end of over
      if (runs % 2 == 1 || balls.value % 6 == 0) {
        rotateStrike();
      }
    }
  }

  // Add wide ball
  void addWide() {
    // ballHistory.add({
    //   'type': 'wide',
    //   'score': score.value,
    // });
    // score.value += 1;
    showWideBallBottomSheet();
  }

  // Add no ball
  void addNoBall() {
    // ballHistory.add({
    //   'type': 'no_ball',
    //   'score': score.value,
    // });
    // score.value += 1;
    showNoBallBottomSheet();
  }

  // Add bye
  void addBye() {
    // if (balls.value < maxBalls.value) {
    //   ballHistory
    //       .add({'type': 'bye', 'score': score.value, 'balls': balls.value});
    //   balls.value++;
    //   currentBatsmanBalls.add(0);
    // }

    showByeRunsBottomSheet();
  }

  // Add leg bye
  void addLegBye() {
    // if (balls.value < maxBalls.value) {
    //   ballHistory
    //       .add({'type': 'leg_bye', 'score': score.value, 'balls': balls.value});
    //   balls.value++;
    //   currentBatsmanBalls.add(0);
    // }
    showLegByeRunsBottomSheet();
  }

  // Add wicket
  void addWicket() {
    if (balls.value < maxBalls.value && wickets.value < 10) {
      ballHistory.add({
        'type': 'wicket',
        'score': score.value,
        'balls': balls.value,
        'wickets': wickets.value
      });

      wickets.value++;
      balls.value++;
      currentBatsmanBalls.add(0);

      // Keep only last 4 balls
      if (currentBatsmanBalls.length > 4) {
        currentBatsmanBalls.removeAt(0);
      }
    }
  }

  // Rotate strike between batsmen
  void rotateStrike() {
    final temp = striker.value;
    striker.value = nonStriker.value;
    nonStriker.value = temp;
  }

  // Replace batsman
  void replaceBatsman(String currentBatsman, String newBatsman) {
    if (striker.value == currentBatsman) {
      striker.value = newBatsman;
    } else if (nonStriker.value == currentBatsman) {
      nonStriker.value = newBatsman;
    }
    // Reset balls for new batsman
    currentBatsmanBalls.clear();
  }

  // Change shot direction
  void setDirection(String direction) {
    selectedDirection.value = direction;
  }

  // Undo last action
  void undoLastAction() {
    if (ballHistory.isNotEmpty) {
      final lastAction = ballHistory.last;

      switch (lastAction['type']) {
        case 'normal':
          score.value = lastAction['score'];
          balls.value = lastAction['balls'];
          if (currentBatsmanBalls.isNotEmpty) {
            currentBatsmanBalls.removeLast();
          }
          break;
        case 'wide':
        case 'no_ball':
          score.value = lastAction['score'];
          break;
        case 'bye':
        case 'leg_bye':
          score.value = lastAction['score'];
          balls.value = lastAction['balls'];
          if (currentBatsmanBalls.isNotEmpty) {
            currentBatsmanBalls.removeLast();
          }
          break;
        case 'wicket':
          score.value = lastAction['score'];
          balls.value = lastAction['balls'];
          wickets.value = lastAction['wickets'];
          if (currentBatsmanBalls.isNotEmpty) {
            currentBatsmanBalls.removeLast();
          }
          break;
      }

      ballHistory.removeLast();
    }
  }

  // Get current score display
  String get currentOver =>
      '${score.value}/${wickets.value} (${balls.value}/${maxBalls.value})';

  // Get current batsman's last 4 balls
  List<int> get lastFourBalls {
    if (currentBatsmanBalls.isEmpty) return [0, 0, 0, 0];
    if (currentBatsmanBalls.length < 4) {
      return [
        ...List.filled(4 - currentBatsmanBalls.length, 0),
        ...currentBatsmanBalls
      ];
    }
    return currentBatsmanBalls.toList();
  }
}
