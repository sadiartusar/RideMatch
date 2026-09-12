import 'package:get/get.dart';

import '../controllers/create_mode_controller.dart';

class CreateModeBinding extends Bindings {
  @override
  void dependencies() {
    CreateModeController.ensureController();
  }
}
