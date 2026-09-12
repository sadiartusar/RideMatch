import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../profile/widgets/profile_body.dart';
import '../../ride_verification/widgets/rate_trip_body.dart';
import '../../ride_verification/widgets/ride_impact_body.dart';
import '../../ride_verification/widgets/ride_verified_body.dart';
import '../../ride_verification/widgets/ride_verify_body.dart';
import '../controllers/driver_set_route_controller.dart';
import '../models/rider_match_model.dart';
import 'driver_chat_body.dart';
import 'driver_live_ride_body.dart';
import 'driver_match_confirm_body.dart';
import 'driver_match_list_body.dart';
import 'driver_pickup_drop_card.dart';
import 'driver_pre_match_chat_body.dart';
import 'driver_route_summary_card.dart';
import 'driver_top_bar.dart';
import 'driver_trip_type_selector.dart';

/// Embedded route setup and flow body for the Driver Home Shell.
class DriverSetRouteBody extends StatelessWidget {
  const DriverSetRouteBody({super.key});

  DriverSetRouteController get _controller {
    if (Get.isRegistered<DriverSetRouteController>()) {
      return Get.find<DriverSetRouteController>();
    }
    return Get.put(DriverSetRouteController());
  }

  @override
  Widget build(BuildContext context) {
    final controller = _controller;

    return Obx(() {
      final step = controller.currentStep.value;
      final activeMatch = controller.activeMatch.value ??
          RiderMatchModel.defaultMatches.first;
      final activeRideData = controller.activeRideData.value ??
          controller.createRideDataFromMatch(activeMatch);

      Widget child;
      switch (step) {
        case DriverSetRouteStep.previewMatches:
          child = DriverMatchListBody(
            key: const ValueKey('previewMatches'),
            onBack: controller.backToSetup,
          );
          break;
        case DriverSetRouteStep.matchConfirm:
          child = DriverMatchConfirmBody(
            key: const ValueKey('matchConfirm'),
            match: activeMatch,
            onBack: controller.backToPreviewMatches,
            onChatNow: () => controller.openChat(activeMatch),
            onLiveRoute: () => controller.openLiveRide(activeMatch),
            onViewProfile: () => controller.openProfile(activeMatch),
          );
          break;
        case DriverSetRouteStep.preMatchChat:
          child = DriverPreMatchChatBody(
            key: const ValueKey('preMatchChat'),
            match: activeMatch,
            onBack: controller.backToPreviewMatches,
          );
          break;
        case DriverSetRouteStep.chat:
          child = DriverChatBody(
            key: const ValueKey('chat'),
            match: activeMatch,
            onBack: controller.backToMatchConfirm,
          );
          break;
        case DriverSetRouteStep.liveRide:
          child = DriverLiveRideBody(
            key: const ValueKey('liveRide'),
            match: activeMatch,
            onBack: controller.backToMatchConfirm,
          );
          break;
        case DriverSetRouteStep.profile:
          child = ProfileBody(
            key: const ValueKey('profile'),
            onBack: controller.backFromProfile,
          );
          break;
        case DriverSetRouteStep.rideVerify:
          child = RideVerifyBody(
            key: const ValueKey('rideVerify'),
            rideData: activeRideData,
            onBack: controller.backToLiveRide,
          );
          break;
        case DriverSetRouteStep.rideVerified:
          child = RideVerifiedBody(
            key: const ValueKey('rideVerified'),
            rideData: activeRideData,
            onBack: controller.backToLiveRide,
          );
          break;
        case DriverSetRouteStep.rideImpact:
          child = RideImpactBody(
            key: const ValueKey('rideImpact'),
            rideData: activeRideData,
            onBack: controller.backToRideVerified,
          );
          break;
        case DriverSetRouteStep.rateTrip:
          child = RateTripBody(
            key: const ValueKey('rateTrip'),
            rideData: activeRideData,
            onBack: controller.backToRideVerified,
          );
          break;
        case DriverSetRouteStep.setup:
        default:
          child = _DriverSetRouteContent(
            key: const ValueKey('setupContent'),
            controller: controller,
          );
          break;
      }

      return AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        switchInCurve: Curves.easeInOut,
        switchOutCurve: Curves.easeInOut,
        transitionBuilder: (child, animation) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        child: child,
      );
    });
  }
}

class _DriverSetRouteContent extends StatelessWidget {
  const _DriverSetRouteContent({
    super.key,
    required this.controller,
  });

  final DriverSetRouteController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final name = controller.displayName;
      final isOneWay = controller.isOneWay.value;
      final depart = controller.departFrom.value;
      final dest = controller.destination.value;
      final depTime = controller.departureTime.value;
      final depPeriod = controller.departurePeriod.value;
      final arrTime = controller.arrivalTime.value;
      final arrPeriod = controller.arrivalPeriod.value;
      final riders = controller.sharedRidersCount.value;
      final sharePercent = controller.sharedPercentage.value;
      final detour = controller.detour.value;
      final rewards = controller.rewards.value;
      final co2 = controller.co2Save.value;

      return SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DriverTopBar(
              name: name,
              verificationStatus: 'VERIFIED MEMBER',
              onNotificationTap: controller.openNotifications,
              onMenuTap: controller.openMenu,
            ),
            const SizedBox(height: 20),
            DriverTripTypeSelector(
              isOneWay: isOneWay,
              onChanged: controller.setTripType,
            ),
            const SizedBox(height: 22),
            const Text(
              'Quick Destination',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.2,
              ),
            ),
            const SizedBox(height: 12),
            // Quick destination search input
            Container(
              height: 52,
              decoration: BoxDecoration(
                color: const Color(0xFF171A1D),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: const Color(0xFF262B32),
                  width: 1,
                ),
              ),
              child: TextField(
                controller: controller.quickDestinationController,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
                cursorColor: const Color(0xFF32E116),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 16),
                  prefixIcon: Icon(
                    Icons.search_rounded,
                    color: Color(0xFF32E116),
                    size: 22,
                  ),
                  hintText: 'Where are you heading?',
                  hintStyle: TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 22),
            const Text(
              'Set Pickup & Drop',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.2,
              ),
            ),
            const SizedBox(height: 12),
            DriverPickupDropCard(
              departFrom: depart,
              destination: dest,
              departureTime: depTime,
              departurePeriod: depPeriod,
              arrivalTime: arrTime,
              arrivalPeriod: arrPeriod,
              onEditDepart: controller.editDepartFrom,
              onEditDestination: controller.editDestination,
              onPickDepartureTime: () =>
                  controller.pickDepartureTime(context),
              onPickArrivalTime: () =>
                  controller.pickArrivalTime(context),
            ),
            const SizedBox(height: 16),
            DriverRouteSummaryCard(
              ridersCount: riders,
              sharePercentage: sharePercent,
              detour: detour,
              rewards: rewards,
              co2Save: co2,
            ),
            const SizedBox(height: 24),
            // Primary "SET ROUTE" CTA
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: controller.setRoute,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.button,
                  foregroundColor: AppColors.buttonForeground,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  'SET ROUTE',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            // Secondary "PREVIEW MATCHES" button
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: controller.previewMatches,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF171A1D),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  side: const BorderSide(
                    color: Color(0xFF262B32),
                    width: 1,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  'PREVIEW MATCHES',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // "SAVE AS DRAFT" text button
            Center(
              child: TextButton(
                onPressed: controller.saveAsDraft,
                child: const Text(
                  'SAVE AS DRAFT',
                  style: TextStyle(
                    color: Color(0xFF9CA3AF),
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      );
    });
  }
}
