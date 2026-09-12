import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../core/routes/app_routes.dart';
import '../../main_nav/main_tab_nav.dart';
import '../../main_nav/widgets/app_mode_bottom_nav.dart';
import '../controllers/create_mode_controller.dart';
import '../widgets/create_mode_body.dart';

/// Standalone route fallback. Prefer embedding via [SetDestinationStep.createMode]
/// so Choose Mode shares the Flex / Rider home bottom nav.
class CreateModeView extends GetView<CreateModeController> {
  const CreateModeView({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: const SafeArea(
          bottom: false,
          child: CreateModeBody(),
        ),
        bottomNavigationBar: AppModeBottomNav(
          selectedIndex: MainTabNav.findIndex,
          onTap: (index) {
            switch (index) {
              case MainTabNav.homeIndex:
                MainTabNav.showHome();
                break;
              case MainTabNav.findIndex:
                break;
              case MainTabNav.chatIndex:
                MainTabNav.showChat();
                break;
              case 3:
                Get.toNamed(AppRoutes.wallet);
                break;
              case MainTabNav.profileIndex:
                MainTabNav.showProfile();
                break;
            }
          },
        ),
      ),
    );
  }
}
