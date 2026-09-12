import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../main_nav/widgets/app_mode_bottom_nav.dart';
import '../controllers/driver_live_ride_controller.dart';
import '../widgets/driver_live_ride_body.dart';

class DriverLiveRideView extends GetView<DriverLiveRideController> {
  const DriverLiveRideView({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: const Color(0xFF0B0D0F),
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFFEEF2F5),
        body: DriverLiveRideBody(
          match: controller.match,
          onBack: () => Get.back(),
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
