import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/routes/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../auth/controllers/auth_controller.dart';
import '../../auth/models/user_model.dart';
import '../../drawer/controllers/app_drawer_controller.dart';
import '../../drawer/models/drawer_nav_item.dart';
import '../../main_nav/main_tab_nav.dart';
import '../models/rider_match_model.dart';
import 'driver_chat_controller.dart';
import 'driver_live_ride_controller.dart';
import 'driver_match_confirm_controller.dart';
import 'driver_match_list_controller.dart';
import 'driver_pre_match_chat_controller.dart';

import '../../ride_verification/controllers/rate_trip_controller.dart';
import '../../ride_verification/controllers/ride_impact_controller.dart';
import '../../ride_verification/controllers/ride_verified_controller.dart';
import '../../ride_verification/controllers/ride_verify_controller.dart';
import '../../ride_verification/models/ride_verification_model.dart';

enum DriverSetRouteStep {
  setup,
  previewMatches,
  matchConfirm,
  preMatchChat,
  chat,
  liveRide,
  profile,
  rideVerify,
  rideVerified,
  rideImpact,
  rateTrip,
}

class DriverSetRouteController extends GetxController {
  final Rx<DriverSetRouteStep> currentStep = DriverSetRouteStep.setup.obs;
  DriverSetRouteStep previousStepBeforeProfile = DriverSetRouteStep.previewMatches;
  final Rxn<RiderMatchModel> activeMatch = Rxn<RiderMatchModel>();
  final Rxn<RideVerificationModel> activeRideData = Rxn<RideVerificationModel>();

  final RxBool isOneWay = true.obs;

  final TextEditingController quickDestinationController =
      TextEditingController();

  final RxString departFrom = 'Mission District, SF'.obs;
  final RxString destination = 'Palo Alto Tech Park'.obs;

  final RxString departureTime = '08:30'.obs;
  final RxString departurePeriod = 'AM'.obs;

  final RxString arrivalTime = '09:15'.obs;
  final RxString arrivalPeriod = 'AM'.obs;

  final RxInt sharedRidersCount = 3.obs;
  final RxInt sharedPercentage = 82.obs;
  final RxString detour = '6 min'.obs;
  final RxString rewards = '3 Act.'.obs;
  final RxString co2Save = '4.2kg'.obs;

  final RxInt selectedNavIndex = 1.obs;

  UserModel? get user {
    if (Get.isRegistered<AuthController>()) {
      return Get.find<AuthController>().currentUser.value;
    }
    return null;
  }

  String get displayName {
    final name = user?.name.trim();
    if (name != null && name.isNotEmpty) {
      return name;
    }
    return 'Jeremy M. Ralston';
  }

  @override
  void onClose() {
    quickDestinationController.dispose();
    super.onClose();
  }

  void setTripType(bool oneWay) {
    isOneWay.value = oneWay;
  }

  void editDepartFrom() {
    _showEditLocationSheet(
      title: 'Depart From',
      currentValue: departFrom.value,
      onSave: (val) => departFrom.value = val,
    );
  }

  void editDestination() {
    _showEditLocationSheet(
      title: 'Destination',
      currentValue: destination.value,
      onSave: (val) => destination.value = val,
    );
  }

  Future<void> pickDepartureTime(BuildContext context) async {
    final time = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 8, minute: 30),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF32E116),
              onPrimary: Colors.black,
              surface: Color(0xFF1E2125),
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (time != null) {
      final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
      final minute = time.minute.toString().padLeft(2, '0');
      departureTime.value = '${hour.toString().padLeft(2, '0')}:$minute';
      departurePeriod.value = time.period == DayPeriod.am ? 'AM' : 'PM';
    }
  }

  Future<void> pickArrivalTime(BuildContext context) async {
    final time = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 9, minute: 15),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF32E116),
              onPrimary: Colors.black,
              surface: Color(0xFF1E2125),
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (time != null) {
      final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
      final minute = time.minute.toString().padLeft(2, '0');
      arrivalTime.value = '${hour.toString().padLeft(2, '0')}:$minute';
      arrivalPeriod.value = time.period == DayPeriod.am ? 'AM' : 'PM';
    }
  }

  void setRoute() {
    Get.snackbar(
      'Route Confirmed',
      'Driving route active: ${departFrom.value} → ${destination.value}',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF16381D),
      colorText: const Color(0xFF32E116),
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }

  void previewMatches() {
    if (!Get.isRegistered<DriverMatchListController>()) {
      Get.put(DriverMatchListController());
    }
    currentStep.value = DriverSetRouteStep.previewMatches;
  }

  void backToSetup() {
    currentStep.value = DriverSetRouteStep.setup;
  }

  void backToPreviewMatches() {
    currentStep.value = DriverSetRouteStep.previewMatches;
  }

  void backToMatchConfirm() {
    currentStep.value = DriverSetRouteStep.matchConfirm;
  }

  void openProfile(RiderMatchModel match) {
    previousStepBeforeProfile = currentStep.value;
    activeMatch.value = match;
    currentStep.value = DriverSetRouteStep.profile;
  }

  void backFromProfile() {
    currentStep.value = previousStepBeforeProfile;
  }

  void openMatchConfirm(RiderMatchModel match) {
    activeMatch.value = match;
    if (!Get.isRegistered<DriverMatchConfirmController>()) {
      Get.put(DriverMatchConfirmController());
    }
    final ctrl = Get.find<DriverMatchConfirmController>();
    ctrl.updateMatch(match);
    currentStep.value = DriverSetRouteStep.matchConfirm;
  }

  void openPreMatchChat(RiderMatchModel match) {
    activeMatch.value = match;
    if (!Get.isRegistered<DriverPreMatchChatController>()) {
      Get.put(DriverPreMatchChatController());
    }
    final ctrl = Get.find<DriverPreMatchChatController>();
    ctrl.updateMatch(match);
    currentStep.value = DriverSetRouteStep.preMatchChat;
  }

  void openChat(RiderMatchModel match) {
    activeMatch.value = match;
    if (!Get.isRegistered<DriverChatController>()) {
      Get.put(DriverChatController());
    }
    final ctrl = Get.find<DriverChatController>();
    ctrl.updateMatch(match);
    currentStep.value = DriverSetRouteStep.chat;
  }

  void openLiveRide(RiderMatchModel match) {
    activeMatch.value = match;
    if (!Get.isRegistered<DriverLiveRideController>()) {
      Get.put(DriverLiveRideController());
    }
    final ctrl = Get.find<DriverLiveRideController>();
    ctrl.updateMatch(match);
    currentStep.value = DriverSetRouteStep.liveRide;
  }

  RideVerificationModel createRideDataFromMatch(RiderMatchModel match) {
    return RideVerificationModel(
      riderName: match.name,
      riderAvatar: match.avatarAsset,
      pinCode: '4821',
      qrPayload: 'RIDEMATCH_VERIFY_${match.id}',
      sharedKm: match.sharedKm > 0 ? match.sharedKm : 4.8,
      couponsTransferred: 1,
      gasVoucherAmount: match.netEarnings > 0 ? match.netEarnings : 9.60,
      co2SavedKg: 2.4,
      fuelSavedPercent: 17,
      rewardPoints: 125,
      isDark: true,
    );
  }

  void openRideVerify([RiderMatchModel? match, RideVerificationModel? rideData]) {
    if (match != null) {
      activeMatch.value = match;
    }
    final data = rideData ??
        (match != null
            ? createRideDataFromMatch(match)
            : (activeMatch.value != null
                ? createRideDataFromMatch(activeMatch.value!)
                : RideVerificationModel.defaultRide));
    activeRideData.value = data;

    if (!Get.isRegistered<RideVerifyController>()) {
      Get.put(RideVerifyController());
    }
    final ctrl = Get.find<RideVerifyController>();
    ctrl.updateRideData(data);
    currentStep.value = DriverSetRouteStep.rideVerify;
  }

  void openRideVerified([RideVerificationModel? rideData]) {
    final data = rideData ?? activeRideData.value ??
        (activeMatch.value != null
            ? createRideDataFromMatch(activeMatch.value!)
            : RideVerificationModel.defaultRide);
    activeRideData.value = data;

    if (!Get.isRegistered<RideVerifiedController>()) {
      Get.put(RideVerifiedController());
    }
    final ctrl = Get.find<RideVerifiedController>();
    ctrl.updateRideData(data);
    currentStep.value = DriverSetRouteStep.rideVerified;
  }

  void openRideImpact([RideVerificationModel? rideData]) {
    final data = rideData ?? activeRideData.value ??
        (activeMatch.value != null
            ? createRideDataFromMatch(activeMatch.value!)
            : RideVerificationModel.defaultRide);
    activeRideData.value = data;

    if (!Get.isRegistered<RideImpactController>()) {
      Get.put(RideImpactController());
    }
    final ctrl = Get.find<RideImpactController>();
    ctrl.updateRideData(data);
    currentStep.value = DriverSetRouteStep.rideImpact;
  }

  void openRateTrip([RideVerificationModel? rideData]) {
    final data = rideData ?? activeRideData.value ??
        (activeMatch.value != null
            ? createRideDataFromMatch(activeMatch.value!)
            : RideVerificationModel.defaultRide);
    activeRideData.value = data;

    if (!Get.isRegistered<RateTripController>()) {
      Get.put(RateTripController());
    }
    final ctrl = Get.find<RateTripController>();
    ctrl.updateRideData(data);
    currentStep.value = DriverSetRouteStep.rateTrip;
  }

  void backToLiveRide() {
    currentStep.value = DriverSetRouteStep.liveRide;
  }

  void backToRideVerify() {
    currentStep.value = DriverSetRouteStep.rideVerify;
  }

  void backToRideVerified() {
    currentStep.value = DriverSetRouteStep.rideVerified;
  }

  void saveAsDraft() {
    Get.snackbar(
      'Draft Saved',
      'Route schedule saved to your drafts successfully.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF1E2125),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }

  void openNotifications() {
    Get.toNamed(AppRoutes.notifications, arguments: {'isDark': true});
  }

  void openMenu() {
    AppDrawerController.open(
      userName: displayName,
      selectedId: DrawerNavId.home,
      isDark: true,
      onOpenNotifications: openNotifications,
      onLogout: () async {
        if (Get.isRegistered<AuthController>()) {
          await Get.find<AuthController>().logout();
        }
      },
    );
  }

  void onNavTap(int index) {
    if (index == 0) {
      MainTabNav.showHome();
      return;
    }
    if (index == 1) {
      // Already on Set Route
      return;
    }
    if (index == MainTabNav.chatIndex) {
      MainTabNav.showChat(isDark: true);
      return;
    }
    if (index == 3) {
      MainTabNav.showWallet(isDark: true);
      return;
    }
    if (index == MainTabNav.profileIndex) {
      MainTabNav.showProfile(isDark: true);
      return;
    }
    selectedNavIndex.value = index;
  }

  void _showEditLocationSheet({
    required String title,
    required String currentValue,
    required ValueChanged<String> onSave,
  }) {
    final textController = TextEditingController(text: currentValue);
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Color(0xFF16181B),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Edit $title',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: textController,
                autofocus: true,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFF1E2125),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFF2C333A)),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    final trimmed = textController.text.trim();
                    if (trimmed.isNotEmpty) {
                      onSave(trimmed);
                    }
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.button,
                    foregroundColor: AppColors.buttonForeground,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Save Location',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
