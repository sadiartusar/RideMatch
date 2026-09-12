import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../main_nav/widgets/app_mode_bottom_nav.dart';
import '../controllers/redeem_confirm_controller.dart';

class RedeemConfirmView extends GetView<RedeemConfirmController> {
  const RedeemConfirmView({super.key});

  @override
  Widget build(BuildContext context) {
    final partner = controller.partner;
    const greenAccent = Color(0xFF32E116);
    const redAccent = Color(0xFFEF4444);
    const bgDark = Color(0xFF0F1114);
    const cardBg = Color(0xFF16181B);
    const borderCol = Color(0xFF262B32);

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
          'Redeem Confirm',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: false,
        titleSpacing: 0,
        actions: [
          // Notification Bell
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
            const Text(
              'Confirm Redemption',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Review your reward before continuing',
              style: TextStyle(
                color: Color(0xFF9CA3AF),
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 16),

            // Selected Partner Box
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: cardBg,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: borderCol),
              ),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: greenAccent,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(
                      Icons.local_gas_station_rounded,
                      color: Colors.black,
                      size: 26,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          partner.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14.5,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          '${partner.couponCost} Coupon',
                          style: const TextStyle(
                            color: Color(0xFF9CA3AF),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),

            // VALUE BREAKDOWN Box
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: cardBg,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: borderCol),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'VALUE BREAKDOWN',
                    style: TextStyle(
                      color: Color(0xFF9CA3AF),
                      fontSize: 10.5,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.8,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildBreakdownRow(
                    label: 'Current Coupon',
                    value: '${controller.currentCouponBalance}',
                    valueColor: Colors.white,
                  ),
                  const SizedBox(height: 14),
                  _buildBreakdownRow(
                    label: 'Service Fee',
                    value: controller.serviceFee,
                    valueColor: greenAccent,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    child: Divider(color: borderCol, height: 1),
                  ),
                  _buildBreakdownRow(
                    label: 'Driver Net Benefit',
                    value: controller.driverNetBenefit,
                    valueColor: greenAccent,
                    isBold: true,
                    valueSize: 16,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Disclaimer Note
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.error_outline_rounded,
                  color: Color(0xFFFBBF24),
                  size: 16,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'By confirming, you agree to the terms of the ${partner.title.split(' ').first} rewards program. Points will be deducted immediately from your account.',
                    style: const TextStyle(
                      color: Color(0xFF9CA3AF),
                      fontSize: 11,
                      height: 1.45,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 28),

            // Actions: Confirm Redemption & Cancel
            Obx(() {
              final loading = controller.isRedeeming.value;
              return Column(
                children: [
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
                        onPressed: loading ? null : controller.confirmRedemption,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: greenAccent,
                          disabledBackgroundColor: greenAccent.withValues(alpha: 0.5),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: loading
                            ? const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                                ),
                              )
                            : const Text(
                                'Confirm Redemption',
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
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    height: 44,
                    child: TextButton(
                      onPressed: loading ? null : controller.cancel,
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          color: Color(0xFF9CA3AF),
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildBreakdownRow({
    required String label,
    required String value,
    required Color valueColor,
    bool isBold = false,
    double valueSize = 14,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: isBold ? Colors.white : const Color(0xFF9CA3AF),
            fontSize: isBold ? 14 : 13,
            fontWeight: isBold ? FontWeight.w800 : FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: valueColor,
            fontSize: valueSize,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }
}
