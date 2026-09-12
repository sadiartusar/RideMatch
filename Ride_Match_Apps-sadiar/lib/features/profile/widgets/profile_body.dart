import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../controllers/profile_controller.dart';
import 'profile_bio_card.dart';
import 'profile_hero_card.dart';
import 'profile_info_row.dart';
import 'profile_menu_list.dart';
import 'profile_photo_gallery.dart';
import 'profile_ride_preferences.dart';
import 'profile_social_links.dart';
import 'profile_stats_grid.dart';
import 'profile_theme_colors.dart';
import 'profile_top_bar.dart';
import 'profile_wallet_card.dart';

/// Profile content only — intended to sit inside the home shell (shared nav).
class ProfileBody extends StatelessWidget {
  const ProfileBody({
    super.key,
    this.onBack,
  });

  final VoidCallback? onBack;

  ProfileController get _controller {
    if (Get.isRegistered<ProfileController>()) {
      return Get.find<ProfileController>();
    }
    return Get.put(ProfileController());
  }

  @override
  Widget build(BuildContext context) {
    final controller = _controller;
    final profile = controller.profile;
    final isDark = controller.isDark;
    final colors = ProfileThemeColors(isDark: isDark);
    final backCallback = onBack ?? controller.goBack;

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        backCallback();
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 16, 8),
            child: ProfileTopBar(
              onBack: backCallback,
              onNotificationTap: controller.openNotifications,
              onMenuTap: controller.openMenu,
              isDark: isDark,
            ),
          ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileHeroCard(
                  name: controller.displayName,
                  headline: profile.headline,
                  badgeLabel: profile.badgeLabel,
                  imageAsset: AppAssets.profileHero,
                ),
                const SizedBox(height: 12),
                const ProfilePhotoGallery(
                  photoAssets: AppAssets.profileGallery,
                ),
                const SizedBox(height: 18),
                ProfileStatsGrid(
                  trustScore: profile.trustScore,
                  rides: profile.rides,
                  kmShared: profile.kmShared,
                  isIdVerified: profile.isIdVerified,
                  isDark: isDark,
                ),
                const SizedBox(height: 20),
                ProfileBioCard(
                  bio: profile.bio,
                  interests: profile.interests,
                  isDark: isDark,
                ),
                const SizedBox(height: 10),
                ProfileInfoRow(
                  icon: Icons.work_outline_rounded,
                  label: 'PROFESSION',
                  value: profile.profession,
                  isDark: isDark,
                ),
                const SizedBox(height: 10),
                ProfileInfoRow(
                  icon: Icons.translate_rounded,
                  label: 'LANGUAGES',
                  value: profile.languages,
                  isDark: isDark,
                ),
                const SizedBox(height: 10),
                ProfileInfoRow(
                  icon: Icons.psychology_outlined,
                  label: 'RIDE PERSONALITY',
                  value: profile.ridePersonality,
                  isDark: isDark,
                ),
                const SizedBox(height: 16),
                ProfileWalletCard(
                  totalCoupons: profile.totalCoupons,
                  travelCoupons: profile.travelCoupons,
                  earnedCoupons: profile.earnedCoupons,
                  expiringCoupons: profile.expiringCoupons,
                  onOpenWallet: controller.openWallet,
                  isDark: isDark,
                ),
                const SizedBox(height: 16),
                Obx(
                  () => ProfileRidePreferences(
                    genderPreference: profile.genderPreference,
                    ageRange: profile.ageRange,
                    carType: profile.carType,
                    verifiedOnly: controller.verifiedOnly.value,
                    onVerifiedOnlyChanged: controller.toggleVerifiedOnly,
                    isDark: isDark,
                  ),
                ),
                const SizedBox(height: 18),
                ProfileSocialLinks(
                  links: profile.socialLinks,
                  onTap: controller.onSocialTap,
                  isDark: isDark,
                ),
                const SizedBox(height: 8),
                ProfileMenuList(
                  activeMissions: profile.activeMissions,
                  sharedRides: profile.sharedRides,
                  onRideIdentity: controller.openRideIdentity,
                  onMissions: controller.openMissions,
                  onRideHistory: controller.openRideHistory,
                  onSettings: controller.openSettings,
                  isDark: isDark,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.lock_outline_rounded,
                      size: 14,
                      color: colors.label,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'PROFILE VISIBLE TO VERIFIED MEMBERS',
                      style: TextStyle(
                        color: colors.label,
                        fontSize: 10.5,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    onPressed: controller.editProfile,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.button,
                      foregroundColor: AppColors.buttonForeground,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'Edit Profile',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Center(
                  child: TextButton.icon(
                    onPressed: controller.logout,
                    icon: const Icon(
                      Icons.logout_rounded,
                      color: AppColors.error,
                      size: 18,
                    ),
                    label: const Text(
                      'Sign Out',
                      style: TextStyle(
                        color: AppColors.error,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
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
}
