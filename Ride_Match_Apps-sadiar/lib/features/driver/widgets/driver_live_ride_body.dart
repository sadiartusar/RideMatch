import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/driver_live_ride_controller.dart';
import '../models/rider_match_model.dart';
import 'driver_live_ride_map.dart';
import 'driver_live_ride_sheet.dart';

/// Embedded Live Ride body for the Driver Home Shell.
class DriverLiveRideBody extends StatelessWidget {
  const DriverLiveRideBody({
    super.key,
    required this.match,
    required this.onBack,
  });

  final RiderMatchModel match;
  final VoidCallback onBack;

  DriverLiveRideController get _controller {
    if (Get.isRegistered<DriverLiveRideController>()) {
      final ctrl = Get.find<DriverLiveRideController>();
      ctrl.updateMatch(match);
      return ctrl;
    }
    final ctrl = Get.put(DriverLiveRideController());
    ctrl.updateMatch(match);
    return ctrl;
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
      child: Stack(
        children: [
          // 1. Full Screen Interactive Route Map
          const Positioned.fill(
            child: DriverLiveRideMap(),
          ),

          // 2. Floating Top Navigation / Back button
          Positioned(
            top: 0,
            left: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: InkWell(
                  onTap: onBack,
                  borderRadius: BorderRadius.circular(22),
                  child: Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: const Color(0xFF14171A),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.35),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.arrow_back_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // 3. Draggable Bottom Sheet with Live Ride Info
          DraggableScrollableSheet(
            initialChildSize: 0.56,
            minChildSize: 0.28,
            maxChildSize: 0.88,
            snap: true,
            snapSizes: const [0.28, 0.56, 0.88],
            builder: (context, scrollController) {
              return DriverLiveRideSheet(
                riderName: match.name,
                riderRides: match.rideCount,
                scrollController: scrollController,
                onCallRider: controller.callRider,
                onEmergencySos: controller.emergencySos,
                onMessageRider: controller.messageRider,
                onVerifyCompletion: controller.verifyCompletion,
              );
            },
          ),
        ],
      ),
    );
  }
}
