import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../main_nav/widgets/app_mode_bottom_nav.dart';
import '../controllers/driver_match_confirm_controller.dart';
import '../widgets/driver_match_confirm_body.dart';

class DriverMatchConfirmView extends GetView<DriverMatchConfirmController> {
  const DriverMatchConfirmView({super.key});

  @override
  Widget build(BuildContext context) {
    const darkBackground = Color(0xFF0D0F11);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: const Color(0xFF0B0D0F),
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: darkBackground,
        body: SafeArea(
          child: DriverMatchConfirmBody(
            match: controller.match,
            onBack: () => Get.back(),
            onChatNow: controller.chatNow,
            onLiveRoute: controller.openLiveRoute,
          ),
        ),
        bottomNavigationBar: Obx(
          () => AppModeBottomNav(
            selectedIndex: controller.selectedNavIndex.value,
            onTap: controller.onNavTap,
            isDark: true,
          ),
        ),
      ),
    );
  }
}
