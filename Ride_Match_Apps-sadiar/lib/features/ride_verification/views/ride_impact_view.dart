import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../main_nav/widgets/app_mode_bottom_nav.dart';
import '../controllers/ride_impact_controller.dart';

class RideImpactView extends GetView<RideImpactController> {
  const RideImpactView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = controller.isDark;
    final scaffoldBg = isDark ? const Color(0xFF0D0F11) : const Color(0xFFF9FAFB);
    final textColor = isDark ? Colors.white : const Color(0xFF111827);
    final cardBg = isDark ? const Color(0xFF16191D) : Colors.white;
    final borderCol = isDark ? const Color(0xFF262B32) : const Color(0xFFE5E7EB);
    const greenAccent = Color(0xFF32E116);

    final data = controller.rideData;

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
            'Ride Impact',
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // 1. Hero CO2 Savings Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: cardBg,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: borderCol),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "You've made a difference today.",
                        style: TextStyle(
                          color: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280),
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        '${data.co2SavedKg.toStringAsFixed(1)} kg',
                        style: TextStyle(
                          color: textColor,
                          fontSize: 38,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -1,
                        ),
                      ),
                      const Text(
                        'CO2 saved',
                        style: TextStyle(
                          color: greenAccent,
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Because you shared the ride instead of driving alone.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),

                // 2. 4-Box Metrics Grid
                Row(
                  children: [
                    _buildMetricBox(
                      value: '${data.fuelSavedPercent}%',
                      label: 'FUEL EQUIVALENT',
                      cardBg: cardBg,
                      borderCol: borderCol,
                      textColor: textColor,
                      isDark: isDark,
                    ),
                    const SizedBox(width: 10),
                    _buildMetricBox(
                      value: '${data.sharedKm.toStringAsFixed(1)} km',
                      label: 'SHARED DISTANCE',
                      cardBg: cardBg,
                      borderCol: borderCol,
                      textColor: textColor,
                      isDark: isDark,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    _buildMetricBox(
                      value: '${data.rewardPoints}',
                      label: 'REWARDS EARNED',
                      cardBg: cardBg,
                      borderCol: borderCol,
                      textColor: textColor,
                      isDark: isDark,
                    ),
                    const SizedBox(width: 10),
                    _buildMetricBox(
                      value: '1 Ride',
                      label: 'VERIFIED',
                      cardBg: cardBg,
                      borderCol: borderCol,
                      textColor: textColor,
                      isDark: isDark,
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // 3. Environmental Equivalency Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF112316) : const Color(0xFFECFDF3),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isDark ? const Color(0xFF1E4826) : const Color(0xFFA7F3D0),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.park_rounded, color: greenAccent, size: 20),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Equivalent to planting 1 tree',
                              style: TextStyle(
                                color: isDark ? Colors.white : const Color(0xFF065F46),
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.directions_car_rounded, color: greenAccent, size: 20),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Equivalent to skipping one solo car trip',
                              style: TextStyle(
                                color: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF047857),
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),

                // 4. Social Share Section
                Text(
                  'SHARE IMPACT',
                  style: TextStyle(
                    color: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280),
                    fontSize: 10.5,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.8,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildShareIcon(Icons.share_rounded, () => controller.shareImpact('General'), cardBg, borderCol, textColor),
                    const SizedBox(width: 12),
                    _buildShareIcon(Icons.camera_alt_outlined, () => controller.shareImpact('Instagram'), cardBg, borderCol, textColor),
                    const SizedBox(width: 12),
                    _buildShareIcon(Icons.facebook_rounded, () => controller.shareImpact('Facebook'), cardBg, borderCol, textColor),
                  ],
                ),
                const SizedBox(height: 24),

                // 5. Primary CTA Button: Rate Your Trip
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: controller.rateYourTrip,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.button,
                      foregroundColor: AppColors.buttonForeground,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text(
                      'Rate your trip',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // 6. Secondary Row: View Wallet | New Ride
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: controller.viewWallet,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: textColor,
                          backgroundColor: cardBg,
                          side: BorderSide(color: borderCol),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text('View Wallet', style: TextStyle(fontWeight: FontWeight.w700)),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: controller.newRide,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: textColor,
                          backgroundColor: cardBg,
                          side: BorderSide(color: borderCol),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text('New Ride', style: TextStyle(fontWeight: FontWeight.w700)),
                      ),
                    ),
                  ],
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

  Widget _buildMetricBox({
    required String value,
    required String label,
    required Color cardBg,
    required Color borderCol,
    required Color textColor,
    required bool isDark,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: borderCol),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                color: textColor,
                fontSize: 18,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280),
                fontSize: 9.5,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShareIcon(
    IconData icon,
    VoidCallback onTap,
    Color cardBg,
    Color borderCol,
    Color iconColor,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        width: 46,
        height: 46,
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: borderCol),
        ),
        child: Icon(icon, color: iconColor, size: 20),
      ),
    );
  }
}
