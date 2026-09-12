import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../controllers/user_profile_controller.dart';
import '../widgets/user_profile_about.dart';
import '../widgets/user_profile_commute_circles.dart';
import '../widgets/user_profile_experience.dart';
import '../widgets/user_profile_hero.dart';
import '../widgets/user_profile_recommendation.dart';
import '../widgets/user_profile_rewards.dart';
import '../widgets/user_profile_social_trust.dart';
import '../widgets/user_profile_vehicle_section.dart';

class UserProfileView extends GetView<UserProfileController> {
  const UserProfileView({super.key});

  static const double _phoneMaxWidth = 430;

  @override
  Widget build(BuildContext context) {
    final profile = controller.profile;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFFF7F8FA),
        body: SafeArea(
          bottom: false,
          child: Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: _phoneMaxWidth),
              child: Column(
                children: [
                  _Header(onBack: controller.goBack),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          UserProfileHero(
                            profile: profile,
                            controller: controller,
                          ),
                          const SizedBox(height: 16),
                          UserProfileRecommendation(profile: profile),
                          const SizedBox(height: 22),
                          UserProfileVehicleSection(profile: profile),
                          const SizedBox(height: 22),
                          UserProfileExperience(profile: profile),
                          const SizedBox(height: 22),
                          UserProfileRewards(rewards: profile.rewards),
                          const SizedBox(height: 16),
                          UserProfileSocialTrust(
                            profile: profile,
                            onSocialTap: controller.openSocial,
                          ),
                          const SizedBox(height: 22),
                          UserProfileCommuteCircles(
                            circles: profile.circles,
                            onCircleTap: controller.openCircle,
                          ),
                          const SizedBox(height: 22),
                          UserProfileAbout(about: profile.about),
                          const SizedBox(height: 22),
                          UserProfileReviews(
                            reviews: profile.reviews,
                            onViewAll: controller.viewAllReviews,
                          ),
                        ],
                      ),
                    ),
                  ),
                  _RequestMatchBar(onPressed: controller.requestMatch),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 2, 4, 4),
      child: SizedBox(
        height: 44,
        child: Row(
          children: [
            IconButton(
              onPressed: onBack,
              visualDensity: VisualDensity.compact,
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 18,
                color: Color(0xFF111827),
              ),
            ),
            const Expanded(
              child: Text(
                'Driver Profile',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF111827),
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.2,
                ),
              ),
            ),
            const SizedBox(width: 48),
          ],
        ),
      ),
    );
  }
}

class _RequestMatchBar extends StatelessWidget {
  const _RequestMatchBar({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return Container(
      width: double.infinity,
      color: const Color(0xFFF7F8FA),
      padding: EdgeInsets.fromLTRB(16, 8, 16, bottomInset + 12),
      child: SizedBox(
        width: double.infinity,
        height: 54,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.button,
            foregroundColor: const Color(0xFF111827),
            elevation: 0,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: const Text(
            'Request Match',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
    );
  }
}
