import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../main_nav/widgets/app_mode_bottom_nav.dart';
import '../controllers/driver_match_list_controller.dart';
import '../widgets/driver_match_list_body.dart';

class DriverMatchListView extends GetView<DriverMatchListController> {
  const DriverMatchListView({super.key});

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
          child: DriverMatchListBody(
            onBack: () => Get.back(),
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

