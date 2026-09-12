import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../controllers/rate_trip_controller.dart';
import '../models/ride_verification_model.dart';

/// Embedded Rate Trip body for the Driver Home Shell.
class RateTripBody extends StatelessWidget {
  const RateTripBody({
    super.key,
    required this.rideData,
    required this.onBack,
  });

  final RideVerificationModel rideData;
  final VoidCallback onBack;

  RateTripController get _controller {
    if (Get.isRegistered<RateTripController>()) {
      final ctrl = Get.find<RateTripController>();
      ctrl.updateRideData(rideData);
      return ctrl;
    }
    final ctrl = Get.put(RateTripController());
    ctrl.updateRideData(rideData);
    return ctrl;
  }

  @override
  Widget build(BuildContext context) {
    final controller = _controller;
    final isDark = rideData.isDark;
    final textColor = isDark ? Colors.white : const Color(0xFF111827);
    final cardBg = isDark ? const Color(0xFF16191D) : Colors.white;
    final borderCol =
        isDark ? const Color(0xFF262B32) : const Color(0xFFE5E7EB);
    const greenAccent = Color(0xFF32E116);

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        onBack();
      },
      child: Column(
        children: [
          // Top App Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_rounded,
                    color: textColor,
                    size: 22,
                  ),
                  onPressed: onBack,
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      'Rate Trip',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 16.5,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 48), // Balance leading back button
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // 1. Header Title & Subtitle
                  Text(
                    'Rate your trip',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Your feedback helps improve match, safety, and matching quality.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: isDark
                          ? const Color(0xFF9CA3AF)
                          : const Color(0xFF6B7280),
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Ride Verified Pill
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: greenAccent.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: greenAccent.withValues(alpha: 0.35),
                      ),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.check_circle_rounded,
                            color: greenAccent, size: 14),
                        SizedBox(width: 5),
                        Text(
                          'RIDE VERIFIED',
                          style: TextStyle(
                            color: greenAccent,
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),

                  // 2. Rider Partner Card
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: cardBg,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: borderCol),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const CircleAvatar(
                              radius: 24,
                              backgroundImage:
                                  AssetImage(AppAssets.profileHero),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    rideData.riderName,
                                    style: TextStyle(
                                      color: textColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    'Professional Co-traveler',
                                    style: TextStyle(
                                      color: isDark
                                          ? const Color(0xFF9CA3AF)
                                          : const Color(0xFF6B7280),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 8),
                          decoration: BoxDecoration(
                            color: isDark
                                ? const Color(0xFF101215)
                                : const Color(0xFFF3F4F6),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              _buildStatColumn(
                                  'Time', '12 min', textColor, isDark),
                              _buildStatDivider(borderCol),
                              _buildStatColumn(
                                  'Distance',
                                  '${rideData.sharedKm.toStringAsFixed(1)} km',
                                  textColor,
                                  isDark),
                              _buildStatDivider(borderCol),
                              _buildStatColumn(
                                  'Match', '94%', greenAccent, isDark),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // 3. How was your experience & Star Rating
                  Text(
                    'HOW WAS YOUR EXPERIENCE?',
                    style: TextStyle(
                      color: isDark
                          ? const Color(0xFF9CA3AF)
                          : const Color(0xFF6B7280),
                      fontSize: 10.5,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.8,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Obx(() {
                    final rating = controller.starRating.value;
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        final starNum = index + 1;
                        final isSelected = starNum <= rating;
                        return GestureDetector(
                          onTap: () => controller.setRating(starNum),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: Icon(
                              isSelected
                                  ? Icons.star_rounded
                                  : Icons.star_outline_rounded,
                              color: isSelected
                                  ? const Color(0xFFFBBF24)
                                  : (isDark
                                      ? const Color(0xFF4B5563)
                                      : const Color(0xFFD1D5DB)),
                              size: 38,
                            ),
                          ),
                        );
                      }),
                    );
                  }),
                  const SizedBox(height: 18),

                  // 4. Feedback Tags (Chips)
                  Obx(() {
                    final selected = controller.selectedTags;
                    return Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      alignment: WrapAlignment.center,
                      children: controller.availableTags.map((tag) {
                        final isTagSelected = selected.contains(tag);
                        return FilterChip(
                          label: Text(tag),
                          selected: isTagSelected,
                          onSelected: (_) => controller.toggleTag(tag),
                          labelStyle: TextStyle(
                            color: isTagSelected
                                ? (isDark ? Colors.white : Colors.black)
                                : (isDark
                                    ? const Color(0xFF9CA3AF)
                                    : const Color(0xFF4B5563)),
                            fontSize: 12,
                            fontWeight: isTagSelected
                                ? FontWeight.w700
                                : FontWeight.w500,
                          ),
                          backgroundColor: cardBg,
                          selectedColor: greenAccent.withValues(alpha: 0.2),
                          checkmarkColor: greenAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: BorderSide(
                              color: isTagSelected ? greenAccent : borderCol,
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  }),
                  const SizedBox(height: 16),

                  // 5. Short Note Input Field
                  TextField(
                    controller: controller.feedbackController,
                    maxLines: 3,
                    style: TextStyle(color: textColor, fontSize: 13.5),
                    decoration: InputDecoration(
                      hintText: 'Add a short note about the trip...',
                      hintStyle: TextStyle(
                        color: isDark
                            ? const Color(0xFF6B7280)
                            : const Color(0xFF9CA3AF),
                        fontSize: 13,
                      ),
                      filled: true,
                      fillColor: cardBg,
                      contentPadding: const EdgeInsets.all(14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide(color: borderCol),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide(color: borderCol),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide:
                            const BorderSide(color: greenAccent, width: 1.5),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // 6. Submit Button
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: Obx(
                      () => ElevatedButton(
                        onPressed: controller.isSubmitting.value
                            ? null
                            : controller.submitRating,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.button,
                          foregroundColor: AppColors.buttonForeground,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: controller.isSubmitting.value
                            ? const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                  color: Colors.black,
                                ),
                              )
                            : const Text(
                                'Submit Rating',
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
        ],
      ),
    );
  }

  Widget _buildStatColumn(
      String label, String value, Color valueColor, bool isDark) {
    return Expanded(
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              color:
                  isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280),
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: TextStyle(
              color: valueColor,
              fontSize: 13,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatDivider(Color borderCol) {
    return Container(
      width: 1,
      height: 24,
      color: borderCol,
    );
  }
}
