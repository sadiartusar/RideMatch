import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../controllers/driver_match_list_controller.dart';
import 'driver_rider_match_card.dart';

/// Embedded Match List body for the Driver Home Shell.
class DriverMatchListBody extends StatelessWidget {
  const DriverMatchListBody({
    super.key,
    required this.onBack,
  });

  final VoidCallback onBack;

  DriverMatchListController get _controller {
    if (Get.isRegistered<DriverMatchListController>()) {
      return Get.find<DriverMatchListController>();
    }
    return Get.put(DriverMatchListController());
  }

  @override
  Widget build(BuildContext context) {
    final controller = _controller;

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        onBack();
      },
      child: Obx(() {
        final matches = controller.matches;
        final count = matches.length;
        final currentDisplay = controller.displayCurrentNumber;
        final total = controller.totalInitialCount.value;

        return Column(
          children: [
            // Top App Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back_rounded,
                      color: Colors.white,
                      size: 24,
                    ),
                    onPressed: onBack,
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Match List',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.2,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 48), // Balance leading back button
                ],
              ),
            ),
            if (matches.isEmpty)
              Expanded(
                child: _EmptyMatchesBody(controller: controller),
              )
            else ...[
              // Top status row: "3 Riders nearby" | "2/3"
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '$total Riders nearby',
                      style: const TextStyle(
                        color: Color(0xFF32E116),
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      '$currentDisplay/$total',
                      style: const TextStyle(
                        color: Color(0xFF32E116),
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
              // Card stack container with scroll
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      // Background Card 2 (if exists)
                      if (count > 2)
                        Positioned(
                          top: 16,
                          left: 16,
                          right: 16,
                          child: Container(
                            height: 120,
                            decoration: BoxDecoration(
                              color: const Color(0xFF0F1215),
                              borderRadius: BorderRadius.circular(22),
                              border: Border.all(
                                color: const Color(0xFF1E2228),
                              ),
                            ),
                          ),
                        ),
                      // Background Card 1 (if exists)
                      if (count > 1)
                        Positioned(
                          top: 8,
                          left: 8,
                          right: 8,
                          child: Container(
                            height: 120,
                            decoration: BoxDecoration(
                              color: const Color(0xFF14171B),
                              borderRadius: BorderRadius.circular(22),
                              border: Border.all(
                                color: const Color(0xFF232830),
                              ),
                            ),
                          ),
                        ),
                      // Active Foreground Swipeable Card
                      DriverRiderMatchCard(
                        key: ValueKey(matches.first.id),
                        match: matches.first,
                        onSwipeLeft: controller.swipeLeft,
                        onSwipeRight: controller.swipeRight,
                        onOfferRide: () =>
                            controller.offerRide(matches.first),
                        onPass: controller.passCurrent,
                        onViewProfile: () =>
                            controller.viewProfile(matches.first),
                        onReplyPreMatch: () =>
                            controller.replyPreMatch(matches.first),
                      ),
                    ],
                  ),
                ),
              ),
              // Sticky bottom Filter button
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: controller.openFilter,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.button,
                      foregroundColor: AppColors.buttonForeground,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text(
                      'Filter',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ],
        );
      }),
    );
  }
}

class _EmptyMatchesBody extends StatelessWidget {
  const _EmptyMatchesBody({required this.controller});

  final DriverMatchListController controller;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
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
                onPressed: controller.resetMatches,
                icon: const Icon(Icons.refresh_rounded, size: 20),
                label: const Text(
                  'Reload Rider Matches',
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
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
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: controller.openFilter,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.button,
                    foregroundColor: AppColors.buttonForeground,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'Filter',
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
    );
  }
}
