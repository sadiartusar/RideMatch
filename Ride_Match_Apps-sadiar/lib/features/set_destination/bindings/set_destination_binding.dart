import 'package:get/get.dart';

import '../controllers/set_destination_controller.dart';

class SetDestinationBinding extends Bindings {
  @override
  void dependencies() {
    SetDestinationController.ensureController();
  }
}
