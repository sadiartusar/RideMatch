import 'package:get/get.dart';

import '../../auth/controllers/auth_controller.dart';
import '../../auth/models/user_model.dart';
import '../../trip/models/trip_status.dart';

class HomeController extends GetxController {
  final Rx<TripStatus> tripStatus = TripStatus.idle.obs;

  UserModel? get user {
    if (Get.isRegistered<AuthController>()) {
      return Get.find<AuthController>().currentUser.value;
    }
    return null;
  }

  Future<void> logout() async {
    if (Get.isRegistered<AuthController>()) {
      await Get.find<AuthController>().logout();
    }
  }
}
