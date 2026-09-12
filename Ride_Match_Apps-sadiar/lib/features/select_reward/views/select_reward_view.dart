import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../main_nav/widgets/app_mode_bottom_nav.dart';
import '../controllers/select_reward_controller.dart';
import '../widgets/select_reward_body.dart';

class SelectRewardView extends GetView<SelectRewardController> {
  const SelectRewardView({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FB),
        body: const SafeArea(
          bottom: false,
          child: SelectRewardBody(),
        ),
        bottomNavigationBar: Obx(
          () => AppModeBottomNav(
            selectedIndex: controller.selectedNavIndex.value,
            onTap: controller.onNavTap,
          ),
        ),
      ),
    );
  }
}
