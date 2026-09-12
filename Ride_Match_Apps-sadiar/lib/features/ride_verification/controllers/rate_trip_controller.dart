import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../main_nav/main_tab_nav.dart';
import '../models/ride_verification_model.dart';

class RateTripController extends GetxController {
  late final RideVerificationModel rideData;
  late final TextEditingController feedbackController;

  final RxInt starRating = 5.obs;
  final RxList<String> selectedTags = <String>['Polite', 'Safe driving'].obs;
  final RxBool isSubmitting = false.obs;
  final RxInt selectedNavIndex = 1.obs;

  final List<String> availableTags = [
    'Late',
    'Polite',
    'Safe driving',
    'Good music',
    'Clean car',
    'Friendly',
    'Great route',
  ];

  bool get isDark => rideData.isDark;

  @override
  void onInit() {
    super.onInit();
    feedbackController = TextEditingController();

    final args = Get.arguments;
    if (args is Map && args['rideData'] is RideVerificationModel) {
      rideData = args['rideData'] as RideVerificationModel;
    } else {
      rideData = RideVerificationModel.defaultRide;
    }
  }

  void updateRideData(RideVerificationModel newRideData) {
    rideData = newRideData;
    update();
  }

  void setRating(int stars) {
    starRating.value = stars;
  }

  void toggleTag(String tag) {
    if (selectedTags.contains(tag)) {
      selectedTags.remove(tag);
    } else {
      selectedTags.add(tag);
    }
  }

  void submitRating() {
    isSubmitting.value = true;
    Future.delayed(const Duration(milliseconds: 500), () {
      isSubmitting.value = false;
      Get.dialog(
        Dialog(
          backgroundColor: isDark ? const Color(0xFF16191D) : Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                    color: Color(0xFF16381D),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_circle_rounded,
                    color: Color(0xFF32E116),
                    size: 36,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Feedback Submitted!',
                  style: TextStyle(
                    color: isDark ? Colors.white : const Color(0xFF111827),
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Thank you for rating your trip. Your feedback keeps the community safe and trusted.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280),
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.back(); // close dialog
                      MainTabNav.showHome();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.button,
                      foregroundColor: AppColors.buttonForeground,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Back to Home',
                      style: TextStyle(fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  void onNavTap(int index) {
    if (index == 0) {
      MainTabNav.showHome();
      return;
    }
    if (index == 1) {
      MainTabNav.showRoute();
      return;
    }
    if (index == MainTabNav.chatIndex) {
      MainTabNav.showChat(isDark: isDark);
      return;
    }
    if (index == 3) {
      MainTabNav.showWallet(isDark: isDark);
      return;
    }
    if (index == MainTabNav.profileIndex) {
      MainTabNav.showProfile(isDark: isDark);
      return;
    }
    selectedNavIndex.value = index;
  }

  @override
  void onClose() {
    feedbackController.dispose();
    super.onClose();
  }
}
