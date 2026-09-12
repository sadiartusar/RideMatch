import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/routes/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../auth/controllers/auth_controller.dart';
import '../../auth/models/user_model.dart';
import '../../create_mode/controllers/create_mode_controller.dart';
import '../../drawer/controllers/app_drawer_controller.dart';
import '../../drawer/models/drawer_nav_item.dart';
import '../../flex/controllers/flex_home_controller.dart';
import '../../main_nav/main_tab_nav.dart';
import '../../onboarding/models/user_mode.dart';
import '../../onboarding/services/mode_service.dart';
import '../../rider/controllers/rider_home_controller.dart';
import '../models/quick_route_model.dart';
import '../models/vibe_preferences_model.dart';

/// Steps inside the Find tab for Flex / Rider only.
/// Home "Set Destination" opens vibe first, then Continue → location.
/// Flex Route Preview → choose Ride Request vs Offer Seats.
enum SetDestinationStep { vibe, destination, createMode }

class SetDestinationController extends GetxController {
  final TextEditingController pickupController = TextEditingController(
    text: 'San Francisco Modern Art Museum',
  );
  final TextEditingController destinationController = TextEditingController(
    text: 'Chinatown',
  );

  final Rx<SetDestinationStep> step = SetDestinationStep.vibe.obs;

  final RxList<QuickRouteModel> quickRoutes =
      RxList<QuickRouteModel>(QuickRouteModel.defaults);

  final Rx<VibeMood> selectedMood = VibeMood.openToConversation.obs;
  final Rx<VibeMusic> selectedMusic = VibeMusic.on.obs;
  final Rx<VibeIntent> selectedIntent = VibeIntent.socializing.obs;
  final RxnString selectedCircleId = RxnString('foodies_unites');

  final RxList<VibeCircleOption> commuteCircles =
      RxList<VibeCircleOption>(VibeCircleOption.defaults);

  UserModel? get user {
    if (Get.isRegistered<AuthController>()) {
      return Get.find<AuthController>().currentUser.value;
    }
    return null;
  }

  String get displayName {
    final name = user?.name.trim();
    if (name != null && name.isNotEmpty) return name;
    return 'Jeremy M. Ralston';
  }

  bool get isAllowedMode {
    if (!Get.isRegistered<ModeService>()) return true;
    final mode = Get.find<ModeService>().currentMode;
    return mode == UserMode.flex || mode == UserMode.rider;
  }

  @override
  void onClose() {
    pickupController.dispose();
    destinationController.dispose();
    super.onClose();
  }

  void resetToVibeStep() {
    step.value = SetDestinationStep.vibe;
  }

  void useCurrentLocation() {
    pickupController.text = 'Current Location';
    Get.snackbar(
      'Pickup Updated',
      'Using your current location as pickup.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF1F2937),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }

  void selectQuickRoute(QuickRouteModel route) {
    if (route.pickup != null && route.pickup!.isNotEmpty) {
      pickupController.text = route.pickup!;
    }
    if (route.destination != null && route.destination!.isNotEmpty) {
      destinationController.text = route.destination!;
    }
  }

  /// Continues from Set your vibe → pickup / destination screen.
  void continueFromVibe() {
    step.value = SetDestinationStep.destination;
  }

  void previewRoute() {
    final pickup = pickupController.text.trim();
    final destination = destinationController.text.trim();

    if (pickup.isEmpty || destination.isEmpty) {
      Get.snackbar(
        'Set Destination',
        'Please enter both pickup and destination to continue.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF1F2937),
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
      );
      return;
    }

    // Rider goes straight to Select Reward; Flex chooses Ride Request vs Offer Seats
    // inside the home Find shell (shared main bottom nav).
    if (Get.isRegistered<ModeService>()) {
      final mode = Get.find<ModeService>().currentMode;
      if (mode == UserMode.rider) {
        Get.toNamed(AppRoutes.selectReward);
        return;
      }
    }

    CreateModeController.ensureController();
    step.value = SetDestinationStep.createMode;
  }

  void selectMood(VibeMood mood) => selectedMood.value = mood;

  void selectMusic(VibeMusic music) => selectedMusic.value = music;

  void selectIntent(VibeIntent intent) => selectedIntent.value = intent;

  void selectCircle(VibeCircleOption circle) {
    if (selectedCircleId.value == circle.id) {
      selectedCircleId.value = null;
    } else {
      selectedCircleId.value = circle.id;
    }
  }

  void showAllCircles() {
    Get.toNamed(AppRoutes.communityCircles);
  }

  void openSafetyDetails() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE5E7EB),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const Row(
                children: [
                  Icon(Icons.crisis_alert_rounded, color: Color(0xFFEF4444), size: 24),
                  SizedBox(width: 10),
                  Text(
                    'Safety First Guarantee',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF111827),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Text(
                '• Real-time GPS sharing with trusted contacts.\n'
                '• Audio trip monitoring with automated collision detection.\n'
                '• Emergency recording shared with emergency responders if needed.\n'
                '• All trip data is encrypted and auto-purged after 48 hours.',
                style: TextStyle(fontSize: 14, height: 1.5, color: Color(0xFF4B5563)),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () => Get.back(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.button,
                    foregroundColor: AppColors.buttonForeground,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text('Understood'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  void openNotifications() {
    Get.toNamed(AppRoutes.notifications);
  }

  void openMenu() {
    AppDrawerController.open(
      userName: displayName,
      selectedId: DrawerNavId.home,
      onOpenNotifications: openNotifications,
      onChangeMode: () => Get.toNamed(AppRoutes.chooseMode),
    );
  }

  /// Opens Find tab on Set your vibe (home "Set Destination" CTA).
  static void openFromHome({String? destinationQuery}) {
    if (Get.isRegistered<ModeService>()) {
      final mode = Get.find<ModeService>().currentMode;
      if (mode != UserMode.flex && mode != UserMode.rider) return;
    }

    ensureController();
    final controller = Get.find<SetDestinationController>();
    controller.resetToVibeStep();
    if (destinationQuery != null && destinationQuery.trim().isNotEmpty) {
      controller.destinationController.text = destinationQuery.trim();
    }

    if (Get.isRegistered<RiderHomeController>()) {
      Get.find<RiderHomeController>().selectedNavIndex.value =
          MainTabNav.findIndex;
    }
    if (Get.isRegistered<FlexHomeController>()) {
      Get.find<FlexHomeController>().selectedNavIndex.value =
          MainTabNav.findIndex;
    }
  }

  static void ensureController() {
    if (!Get.isRegistered<SetDestinationController>()) {
      Get.put(SetDestinationController(), permanent: false);
    }
  }
}
