import 'package:get/get.dart';

import '../../../core/routes/app_routes.dart';
import '../../onboarding/models/user_mode.dart';
import '../../onboarding/services/mode_service.dart';
import '../widgets/identity_verification_popup.dart';

class VerificationController extends GetxController {
  VerificationController({required ModeService modeService})
    : _modeService = modeService;

  final ModeService _modeService;

  final RxInt bannerIndex = 0.obs;
  static const int bannerCount = 7;

  void onBannerChanged(int index) {
    bannerIndex.value = index;
  }

  void continueAfterVerification() {
    Get.toNamed(AppRoutes.profilePhotos);
  }

  void finishProfilePhotos() {
    Get.toNamed(AppRoutes.completeProfile);
  }

  void finishCompleteProfile() {
    Get.toNamed(AppRoutes.connectModeFilter);
  }

  void finishConnectModeFilter() {
    Get.toNamed(AppRoutes.tellUsMore);
  }

  void finishTellUsMore() {
    Get.toNamed(AppRoutes.socialConnect);
  }

  void finishSocialConnect() {
    Get.toNamed(AppRoutes.backgroundCheck);
  }

  Future<void> finishBackgroundCheck() async {
    final mode = _modeService.currentMode;
    if (mode == UserMode.driver) {
      final route = await _modeService.resolvePostAuthRoute();
      Get.offAllNamed(route);
      return;
    }
    Get.toNamed(AppRoutes.starterRewards);
  }

  Future<void> finishStarterRewards() async {
    final route = await _modeService.resolvePostAuthRoute();
    Get.offAllNamed(route);
  }

  void openEmailVerification() {
    Get.snackbar('Email Verification', 'Coming soon');
  }

  void openPhoneVerification() {
    Get.snackbar('Phone Verification', 'Coming soon');
  }

  void openIdentityVerification() {
    final isDark = _modeService.currentMode == UserMode.driver;
    IdentityVerificationPopup.show(isDark: isDark);
  }

  void uploadDocument(String name) {
    Get.snackbar(name, 'Upload coming soon');
  }
}
