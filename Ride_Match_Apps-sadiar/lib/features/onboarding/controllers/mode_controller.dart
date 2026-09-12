import 'package:get/get.dart';

import '../../../core/routes/app_routes.dart';
import '../../../core/utils/logger.dart';
import '../../auth/controllers/auth_controller.dart';
import '../../main_nav/mode_theme.dart';
import '../models/mode_option.dart';
import '../models/user_mode.dart';
import '../services/mode_service.dart';

class ModeController extends GetxController {
  ModeController({required ModeService modeService})
    : _modeService = modeService;

  final ModeService _modeService;

  final RxBool isSaving = false.obs;
  final Rxn<UserMode> selectedMode = Rxn<UserMode>();

  List<ModeOption> get options => ModeOption.all;

  @override
  void onInit() {
    super.onInit();
    selectedMode.value = _modeService.currentMode;
  }

  Future<void> chooseMode(UserMode mode) async {
    if (isSaving.value) return;
    isSaving.value = true;
    selectedMode.value = mode;
    try {
      ModeTheme.resetScopedControllers();
      await _modeService.setMode(mode);
      if (Get.isRegistered<AuthController>() &&
          Get.find<AuthController>().isAuthenticated) {
        Get.offAllNamed(_modeService.homeRouteFor(mode));
      } else {
        Get.offAllNamed(AppRoutes.authWelcome);
      }
    } catch (e) {
      AppLogger.e('Failed to save mode', e, 'ModeController');
      Get.snackbar('Error', 'Could not save your mode. Please try again.');
    } finally {
      isSaving.value = false;
    }
  }

  void openChooseMode() => Get.toNamed(AppRoutes.chooseMode);
}
