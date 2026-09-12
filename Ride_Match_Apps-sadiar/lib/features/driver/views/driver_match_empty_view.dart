import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../core/routes/app_routes.dart';
import '../../main_nav/widgets/app_mode_bottom_nav.dart';
import '../controllers/driver_match_list_controller.dart';

class DriverMatchEmptyView extends StatelessWidget {
  const DriverMatchEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    const darkBackground = Color(0xFF0D0F11);
    final controller = Get.isRegistered<DriverMatchListController>()
        ? Get.find<DriverMatchListController>()
        : Get.put(DriverMatchListController());

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: const Color(0xFF0B0D0F),
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: darkBackground,
        appBar: AppBar(
          backgroundColor: darkBackground,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
              size: 24,
            ),
            onPressed: () => Get.back(),
          ),
          centerTitle: true,
          title: const Text(
            'Match List',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.2,
            ),
          ),
        ),
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'If you swipe to the left side, the rider card will automatically disappear.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      height: 1.45,
                    ),
                  ),
                  const SizedBox(height: 28),
                  SizedBox(
                    height: 48,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        controller.resetMatches();
                        Get.offNamed(AppRoutes.driverMatchList);
                      },
                      icon: const Icon(Icons.refresh_rounded, size: 20),
                      label: const Text(
                        'Reload Matches',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 14,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E2227),
                        foregroundColor: const Color(0xFF32E116),
                        side: const BorderSide(
                          color: Color(0xFF2C333A),
                          width: 1,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
