import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../main_nav/widgets/app_mode_bottom_nav.dart';
import '../controllers/wallet_controller.dart';
import '../widgets/driver_wallet_body.dart';

class WalletView extends GetView<WalletController> {
  const WalletView({super.key});

  @override
  Widget build(BuildContext context) {
    const bgDark = Color(0xFF0F1114);

    return Scaffold(
      backgroundColor: bgDark,
      body: const SafeArea(
        bottom: false,
        child: DriverWalletBody(),
      ),
      bottomNavigationBar: Obx(
        () => AppModeBottomNav(
          selectedIndex: controller.selectedNavIndex.value,
          onTap: controller.onNavTap,
          isDark: true,
        ),
      ),
    );
  }
}
