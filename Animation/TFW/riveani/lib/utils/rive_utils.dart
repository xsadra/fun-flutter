import 'package:rive/rive.dart';

class RiveUtils {
  RiveUtils._();

  static StateMachineController getController(Artboard artboard,
      {stateMachineName = 'State Machine 1'}) {
    StateMachineController? controller =
        StateMachineController.fromArtboard(artboard, stateMachineName);
    if (controller == null) {
      throw Exception('State Machine not found');
    }
    artboard.addController(controller);
    return controller;
  }
}
