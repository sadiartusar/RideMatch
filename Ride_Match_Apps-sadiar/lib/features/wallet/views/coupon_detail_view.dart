import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_assets.dart';
import '../../main_nav/widgets/app_mode_bottom_nav.dart';
import '../controllers/coupon_detail_controller.dart';

class CouponDetailView extends GetView<CouponDetailController> {
  const CouponDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final partner = controller.partner;
    const greenAccent = Color(0xFF32E116);
    const redAccent = Color(0xFFEF4444);
    const bgDark = Color(0xFF0F1114);
    const cardBg = Color(0xFF16181B);
    const borderCol = Color(0xFF262B32);

    final imageAsset = partner.imageAsset ?? AppAssets.shellStation;

    return Scaffold(
      backgroundColor: bgDark,
      appBar: AppBar(
        backgroundColor: bgDark,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.white, size: 22),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Redeem Detail',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: false,
        titleSpacing: 0,
        actions: [
          // Notification Bell with Red Badge Dot
          Container(
            width: 38,
            height: 38,
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: cardBg,
              shape: BoxShape.circle,
              border: Border.all(color: borderCol),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.notifications_none_rounded, color: Colors.white, size: 19),
                  onPressed: controller.openNotifications,
                ),
                Positioned(
                  top: 8,
                  right: 9,
                  child: Container(
                    width: 7,
                    height: 7,
                    decoration: const BoxDecoration(
                      color: redAccent,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Hamburger Menu
          Container(
            width: 38,
            height: 38,
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              color: cardBg,
              shape: BoxShape.circle,
              border: Border.all(color: borderCol),
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: const Icon(Icons.menu_rounded, color: Colors.white, size: 19),
              onPressed: controller.openMenu,
            ),
          ),
        ],
      ),
      bottomNavigationBar: Obx(
        () => AppModeBottomNav(
          selectedIndex: controller.selectedNavIndex.value,
          onTap: controller.onNavTap,
          isDark: true,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Hero Photo Banner
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: cardBg,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: borderCol),
              ),
              clipBehavior: Clip.antiAlias,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    imageAsset,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: const Color(0xFF101215),
                      child: const Center(
                        child: Icon(Icons.local_gas_station_rounded, size: 64, color: Colors.white24),
                      ),
                    ),
                  ),
                  // Dark bottom gradient
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withValues(alpha: 0.1),
                            Colors.black.withValues(alpha: 0.4),
                            Colors.black.withValues(alpha: 0.85),
                          ],
                          stops: const [0.0, 0.5, 1.0],
                        ),
                      ),
                    ),
                  ),
                  // Bottom content on hero image
                  Positioned(
                    left: 14,
                    right: 14,
                    bottom: 12,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (partner.isVerified)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            margin: const EdgeInsets.only(bottom: 6),
                            decoration: BoxDecoration(
                              color: greenAccent,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.verified_rounded, size: 12, color: Colors.black),
                                SizedBox(width: 4),
                                Text(
                                  'VERIFIED',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 9.5,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        Text(
                          partner.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16.5,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),

            // 2. Cost & Time Remaining Sub-boxes Row
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                    decoration: BoxDecoration(
                      color: cardBg,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: borderCol),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'COST',
                          style: TextStyle(
                            color: Color(0xFF9CA3AF),
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '${partner.couponCost}',
                              style: const TextStyle(
                                color: greenAccent,
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                height: 1.0,
                              ),
                            ),
                            const SizedBox(width: 4),
                            const Padding(
                              padding: EdgeInsets.only(bottom: 1),
                              child: Text(
                                'Coupon',
                                style: TextStyle(
                                  color: Color(0xFF9CA3AF),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                    decoration: BoxDecoration(
                      color: cardBg,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: borderCol),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'TIME REMAINING',
                          style: TextStyle(
                            color: Color(0xFF9CA3AF),
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.access_time_rounded, color: Color(0xFFFBBF24), size: 14),
                            const SizedBox(width: 4),
                            Text(
                              partner.validityEnds,
                              style: const TextStyle(
                                color: Color(0xFFFBBF24),
                                fontSize: 13,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // 3. WHERE / Location Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: cardBg,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: borderCol),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined, color: Color(0xFF9CA3AF), size: 14),
                      SizedBox(width: 4),
                      Text(
                        'WHERE',
                        style: TextStyle(
                          color: Color(0xFF9CA3AF),
                          fontSize: 9.5,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Nationwide',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.5,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // 4. Voucher Overview Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: cardBg,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: borderCol),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Voucher Overview',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.5,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    partner.overviewText,
                    style: const TextStyle(
                      color: Color(0xFF9CA3AF),
                      fontSize: 12.5,
                      height: 1.55,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // 5. Redeem Now Button
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
                  onPressed: controller.redeemNow,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: greenAccent,
                    foregroundColor: Colors.black,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Redeem Now',
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
    );
  }
}
