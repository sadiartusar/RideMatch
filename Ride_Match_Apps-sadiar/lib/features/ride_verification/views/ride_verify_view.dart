import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../main_nav/widgets/app_mode_bottom_nav.dart';
import '../controllers/ride_verify_controller.dart';
import '../widgets/verify_pin_tab.dart';
import '../widgets/verify_qr_tab.dart';

class RideVerifyView extends GetView<RideVerifyController> {
  const RideVerifyView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = controller.isDark;
    final scaffoldBg = isDark ? const Color(0xFF0D0F11) : const Color(0xFFF9FAFB);
    final textColor = isDark ? Colors.white : const Color(0xFF111827);
    final cardBg = isDark ? const Color(0xFF16191D) : Colors.white;
    final borderCol = isDark ? const Color(0xFF262B32) : const Color(0xFFE5E7EB);
    const greenAccent = Color(0xFF32E116);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: (isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark).copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: isDark ? const Color(0xFF0B0D0F) : Colors.white,
        systemNavigationBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: scaffoldBg,
        appBar: AppBar(
          backgroundColor: scaffoldBg,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_rounded,
              color: textColor,
              size: 22,
            ),
            onPressed: () => Get.back(),
          ),
          centerTitle: true,
          title: Text(
            'Verify Ride Completion',
            style: TextStyle(
              color: textColor,
              fontSize: 16.5,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Location Verified Badge
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: greenAccent.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: greenAccent.withValues(alpha: 0.35),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: greenAccent,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: Text(
                          'Location verified: Both users are in the approved zone.',
                          style: TextStyle(
                            color: greenAccent,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                // 2. Shared Route & Escrow Header Card
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: cardBg,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: borderCol),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'SHARED ROUTE',
                            style: TextStyle(
                              color: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280),
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.6,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '${controller.rideData.sharedKm.toStringAsFixed(1)} km',
                            style: TextStyle(
                              color: textColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEAB308).withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: const Color(0xFFEAB308).withValues(alpha: 0.4),
                          ),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.lock_rounded, color: Color(0xFFEAB308), size: 14),
                            SizedBox(width: 5),
                            Text(
                              'Escrowed',
                              style: TextStyle(
                                color: Color(0xFFEAB308),
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // 3. Tab Switcher: [ Verify by PIN ]  [ Verify by QR Code ]
                Container(
                  height: 46,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: cardBg,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: borderCol),
                  ),
                  child: Obx(() {
                    final selected = controller.selectedTabIndex.value;
                    return Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => controller.switchTab(0),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              decoration: BoxDecoration(
                                color: selected == 0 ? greenAccent : Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                'Verify by PIN',
                                style: TextStyle(
                                  color: selected == 0
                                      ? Colors.black
                                      : (isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280)),
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => controller.switchTab(1),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              decoration: BoxDecoration(
                                color: selected == 1 ? greenAccent : Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                'Verify by QR Code',
                                style: TextStyle(
                                  color: selected == 1
                                      ? Colors.black
                                      : (isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280)),
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                ),
                const SizedBox(height: 20),

                // 4. Tab Body Content
                Obx(() {
                  if (controller.selectedTabIndex.value == 0) {
                    return VerifyPinTab(
                      pinCode: controller.rideData.pinCode,
                      pinController: controller.pinController,
                      onSwitchToQr: () => controller.switchTab(1),
                      onMicTap: controller.onMicTap,
                      isDark: isDark,
                    );
                  }
                  return VerifyQrTab(
                    qrPayload: controller.rideData.qrPayload,
                    onScanQr: controller.scanQrCode,
                    isDark: isDark,
                  );
                }),
                const SizedBox(height: 24),

                // 5. Confirm Completion CTA Button
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: Obx(
                    () => ElevatedButton(
                      onPressed: controller.isVerifying.value
                          ? null
                          : controller.confirmCompletion,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.button,
                        foregroundColor: AppColors.buttonForeground,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: controller.isVerifying.value
                          ? const SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                color: Colors.black,
                              ),
                            )
                          : const Text(
                              'Confirm Completion',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
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
