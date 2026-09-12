import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/routes/app_routes.dart';
import '../services/mode_service.dart';

class OnboardingController extends GetxController {
  OnboardingController({required ModeService modeService})
    : _modeService = modeService;

  final ModeService _modeService;

  final PageController pageController = PageController();
  final RxInt currentPage = 0.obs;

  bool get isLastPage => currentPage.value == 2;

  void onPageChanged(int page) {
    currentPage.value = page;
  }

  Future<void> nextPage() async {
    if (isLastPage) {
      await finishOnboarding();
    } else {
      pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> skip() async {
    await finishOnboarding();
  }

  Future<void> finishOnboarding() async {
    await _modeService.setOnboardingCompleted();
    Get.offAllNamed(AppRoutes.chooseMode);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
