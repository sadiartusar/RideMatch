import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/routes/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../main_nav/main_tab_nav.dart';
import '../../rider/controllers/rider_home_controller.dart';
import '../models/driver_match_model.dart';
import '../models/match_filter_model.dart';
import '../widgets/match_list_filter_sheet.dart';

class MatchListController extends GetxController {
  final RxList<DriverMatchModel> matches =
      RxList<DriverMatchModel>(DriverMatchModel.defaultMatches);

  final RxInt selectedNavIndex = MainTabNav.findIndex.obs;
  final RxInt totalInitialCount = 3.obs;
  final Rx<MatchFilterModel> activeFilter = MatchFilterModel().obs;

  String? offeredRewardId;
  int? voucherDollars;

  bool get isEmpty => matches.isEmpty;

  int get remainingCount => matches.length;

  int get displayCurrentNumber {
    if (matches.isEmpty) return 0;
    final processed = totalInitialCount.value - matches.length + 1;
    return processed.clamp(1, totalInitialCount.value);
  }

  String get nearbyLabel {
    final count = totalInitialCount.value;
    final noun = count == 1 ? 'Driver' : 'Drivers';
    return '$count $noun nearby';
  }

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args is Map) {
      offeredRewardId = args['rewardId'] as String?;
      voucherDollars = args['voucherDollars'] as int?;
    }
    resetMatches();
  }

  void goBack() => Get.back();

  void swipeLeft() {
    if (matches.isEmpty) return;
    matches.removeAt(0);
  }

  void swipeRight() {
    if (matches.isEmpty) return;
    requestRide(matches.first);
  }

  void passCurrent() => swipeLeft();

  void requestRide(DriverMatchModel match) {
    Get.toNamed(
      AppRoutes.matchConfirm,
      arguments: {
        'match': match,
        'rewardId': offeredRewardId,
        'voucherDollars': voucherDollars,
      },
    );
  }

  void viewProfile(DriverMatchModel match) {
    Get.toNamed(
      AppRoutes.userProfile,
      arguments: {
        'match': match,
        'rewardId': offeredRewardId,
        'voucherDollars': voucherDollars,
      },
    );
  }

  void openSocial(DriverSocialLink link) {
    Get.snackbar(
      link.label,
      '${link.label} profile is linked to this driver.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF1F2937),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }

  void openFilter() {
    Get.bottomSheet(
      MatchListFilterSheet(
        initialFilter: activeFilter.value,
        onApply: applyFilter,
      ),
      isScrollControlled: true,
    );
  }

  void applyFilter(MatchFilterModel filter) {
    activeFilter.value = filter;
    final source = DriverMatchModel.defaultMatches;
    final gender = filter.genderPreference;
    final filtered = source.where((match) {
      if (gender == 'Male only' && match.gender != 'Male') return false;
      if (gender == 'Female only' && match.gender != 'Female') return false;
      if (gender == 'Non-binary' && match.gender != 'Non-binary') return false;
      if (filter.verifiedProfilesOnly && !match.isVerified) return false;
      return true;
    }).toList();

    matches.assignAll(filtered);
    totalInitialCount.value = filtered.length;

    Get.snackbar(
      'Filters Applied',
      'Showing matches within ${filter.distanceRadiusKm.round()} km radius.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF166534),
      colorText: AppColors.button,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }

  void resetMatches() {
    matches.assignAll(DriverMatchModel.defaultMatches);
    totalInitialCount.value = matches.length;
  }

  void onNavTap(int index) {
    selectedNavIndex.value = index;
    switch (index) {
      case MainTabNav.homeIndex:
        MainTabNav.showHome();
        break;
      case MainTabNav.findIndex:
        break;
      case MainTabNav.chatIndex:
        MainTabNav.showChat();
        break;
      case 3:
        if (Get.isRegistered<RiderHomeController>()) {
          Get.find<RiderHomeController>().openWallet();
        } else {
          Get.toNamed(AppRoutes.wallet);
        }
        break;
      case MainTabNav.profileIndex:
        MainTabNav.showProfile();
        break;
    }
  }
}
