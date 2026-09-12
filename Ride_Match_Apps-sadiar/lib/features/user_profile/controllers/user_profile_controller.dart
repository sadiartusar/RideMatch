import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/routes/app_routes.dart';
import '../../match_list/models/driver_match_model.dart';
import '../models/user_profile_model.dart';

class UserProfileController extends GetxController {
  late final UserProfileModel profile;
  DriverMatchModel? match;
  String? offeredRewardId;
  int? voucherDollars;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args is Map) {
      offeredRewardId = args['rewardId'] as String?;
      voucherDollars = args['voucherDollars'] as int?;
      final rawMatch = args['match'];
      if (rawMatch is DriverMatchModel) {
        match = rawMatch;
        profile = UserProfileModel.fromMatch(rawMatch);
        return;
      }
    } else if (args is DriverMatchModel) {
      match = args;
      profile = UserProfileModel.fromMatch(args);
      return;
    }
    profile = UserProfileModel.demo;
  }

  void goBack() => Get.back();

  void callDriver() {
    Get.snackbar(
      'Call Driver',
      'Calling ${profile.name}...',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF1F2937),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }

  void openMessage() {
    Get.toNamed(
      AppRoutes.preMatchChat,
      arguments: {
        'match': match,
        'rewardId': offeredRewardId,
        'voucherDollars': voucherDollars,
      },
    );
  }

  void requestMatch() {
    Get.toNamed(
      AppRoutes.matchConfirm,
      arguments: {
        'match': match ??
            DriverMatchModel(
              id: profile.id,
              name: profile.name,
              avatarAsset: profile.avatarAsset,
              matchPercentage: profile.matchPercentage,
              isVerified: profile.isVerified,
              rating: profile.rating,
              bio: profile.headline,
              detourMinutes: 9,
              vehicle: profile.vehicleName,
              sharedKm: 5.2,
              tags: profile.interests,
            ),
        'rewardId': offeredRewardId,
        'voucherDollars': voucherDollars,
      },
    );
  }

  void openSocial(UserProfileSocialLink link) {
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

  void openCircle(UserProfileCircle circle) {
    Get.toNamed(AppRoutes.communityCircles);
  }

  void viewAllReviews() {
    Get.snackbar(
      'Reviews',
      'All reviews for ${profile.name} are coming soon.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF1F2937),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }
}
