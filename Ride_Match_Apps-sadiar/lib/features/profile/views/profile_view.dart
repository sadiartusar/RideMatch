import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../main_nav/widgets/app_mode_bottom_nav.dart';
import '../controllers/profile_controller.dart';
import '../widgets/profile_body.dart';
import '../widgets/profile_theme_colors.dart';

/// Standalone profile route.
class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = controller.isDark;
    final colors = ProfileThemeColors(isDark: isDark);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: (isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark)
          .copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: colors.navBar,
        systemNavigationBarIconBrightness:
            isDark ? Brightness.light : Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: colors.scaffold,
        body: const SafeArea(
          bottom: false,
          child: ProfileBody(),
        ),
        bottomNavigationBar: Obx(
          () => AppModeBottomNav(
            selectedIndex: controller.selectedNavIndex.value,
            onTap: controller.onNavTap,
            isDark: isDark,
          ),
        ),
      ),
    );
  }
}
