import 'package:get/get.dart';

class HomeGetXController extends GetxController {

  final panTextController = "".obs;
  final dobTextController = "".obs;

  updatePanNumberTextController(String input) {
    panTextController.value = input;
    return panTextController.value;
  }

  updateDOBTextController(String input) {
    dobTextController.value = input;
    return dobTextController.value;
  }
}
