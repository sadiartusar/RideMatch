import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../main_nav/main_tab_nav.dart';
import '../controllers/wallet_controller.dart';
import 'driver_receiving_wallet_card.dart';
import 'wallet_activity_tile.dart';
import 'wallet_offer_card.dart';

/// Embedded wallet content for the Driver Home Shell.
class DriverWalletBody extends StatelessWidget {
  const DriverWalletBody({super.key});

  WalletController get _controller {
    if (Get.isRegistered<WalletController>()) {
      return Get.find<WalletController>();
    }
    return Get.put(WalletController());
  }

  @override
  Widget build(BuildContext context) {
    final controller = _controller;
    const greenAccent = Color(0xFF32E116);

    return Obx(() {
      final wallet = controller.wallet.value;
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Row(
              children: [
                InkWell(
                  // onTap: () => MainTabNav.showHome(),
                  onTap: () {
                    
                    if (Navigator.canPop(Get.context!)) {
                      Get.back();
                    } else {
                      MainTabNav.showHome();
                    }
                  },
                  borderRadius: BorderRadius.circular(22),
                  child: const SizedBox(
                    width: 40,
                    height: 40,
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                const Expanded(
                  child: Text(
                    'Wallet',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.4,
                    ),
                  ),
                ),
                _CircularAction(
                  onTap: controller.openNotifications,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      const Icon(
                        Icons.notifications_none_rounded,
                        color: Colors.white,
                        size: 22,
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Color(0xFFEF4444),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                _CircularAction(
                  onTap: controller.openMenu,
                  child: const Icon(
                    Icons.menu_rounded,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Driver Receiving Wallet Card
                  DriverReceivingWalletCard(wallet: wallet),
                  const SizedBox(height: 20),

                  // 2. Offer Section Header
                  const Text(
                    'Offer',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.2,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Horizontal Offers Row (Free Fuel & Starbucks Coffee)
                  Row(
                    children: [
                      Expanded(
                        child: WalletOfferCard(
                          offer: wallet.offers[0],
                          onTap: () => controller.goToMarketplace(),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: WalletOfferCard(
                          offer: wallet.offers[1],
                          onTap: () => controller.goToMarketplace(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),

                  // 3. Activity Log Section Header
                  const Text(
                    'Activity Log',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.2,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Activity log items
                  ...wallet.activityLogs.map((activity) {
                    return WalletActivityTile(item: activity);
                  }),

                  const SizedBox(height: 16),

                  // 4. View Marketplace Primary Glowing Green Button
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: greenAccent.withValues(alpha: 0.35),
                            blurRadius: 16,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: controller.goToMarketplace,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: greenAccent,
                          foregroundColor: Colors.black,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text(
                          'View Marketplace',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}

class _CircularAction extends StatelessWidget {
  const _CircularAction({required this.child, required this.onTap});

  final Widget child;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22),
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: const Color(0xFF1B1E23),
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFF2C333A)),
        ),
        alignment: Alignment.center,
        child: child,
      ),
    );
  }
}
