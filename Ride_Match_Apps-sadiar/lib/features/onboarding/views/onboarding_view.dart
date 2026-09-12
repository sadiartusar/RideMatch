import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../controllers/onboarding_controller.dart';
import '../widgets/onboarding_journey_art.dart';
import '../widgets/onboarding_rewards_art.dart';
import '../widgets/onboarding_security_art.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 12),
            Expanded(
              child: PageView(
                controller: controller.pageController,
                onPageChanged: controller.onPageChanged,
                children: const [
                  _OnboardingSlide(
                    art: OnboardingJourneyArt(),
                    title: _SlideTitle(
                      prefix: 'Share the ',
                      highlight: 'Journey',
                    ),
                    subtitle:
                        'Discover people through shared routes — for friends, professional networking, or simple commuting.',
                  ),
                  _OnboardingSlide(
                    art: OnboardingSecurityArt(),
                    title: _SlideTitle(
                      prefix: 'Verified and\nprotected',
                    ),
                    subtitle:
                        'Every rider is verified through phone, email, and ID checks. SOS and safety tools stay visible during rides.',
                  ),
                  _OnboardingSlide(
                    art: OnboardingRewardsArt(),
                    title: _SlideTitle(
                      prefix: 'Make Every Journey\nRewarding',
                    ),
                    subtitle:
                        'Drivers and riders are rewarded with vouchers and coupons based on their carbon reduction impact.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Animated indicator
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) {
                  final isActive = controller.currentPage.value == index;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    width: isActive ? 26 : 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: isActive
                          ? AppColors.splashBackground
                          : const Color(0xFF6B7280),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 24),
            // Bottom buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Obx(
                () => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton(
                        onPressed: controller.nextPage,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.splashBackground,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Text(
                          controller.isLastPage ? 'GET STARTED' : 'CONTINUE',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.8,
                            color: Color(0xFF101010),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    SizedBox(
                      height: 44,
                      child: controller.isLastPage
                          ? const SizedBox.shrink()
                          : TextButton(
                              onPressed: controller.skip,
                              style: TextButton.styleFrom(
                                foregroundColor: const Color(0xFF6B7280),
                              ),
                              child: const Text(
                                'Skip',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OnboardingSlide extends StatelessWidget {
  const _OnboardingSlide({
    required this.art,
    required this.title,
    required this.subtitle,
  });

  final Widget art;
  final Widget title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          art,
          const SizedBox(height: 28),
          title,
          const SizedBox(height: 14),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 15,
              color: Color(0xFF6B7280),
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

class _SlideTitle extends StatelessWidget {
  const _SlideTitle({
    required this.prefix,
    this.highlight,
  });

  final String prefix;
  final String? highlight;

  @override
  Widget build(BuildContext context) {
    if (highlight == null) {
      return Text(
        prefix,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w800,
          color: Color(0xFF101010),
          height: 1.25,
          letterSpacing: -0.5,
        ),
      );
    }

    return Text.rich(
      TextSpan(
        text: prefix,
        style: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w800,
          color: Color(0xFF101010),
          letterSpacing: -0.5,
        ),
        children: [
          TextSpan(
            text: highlight,
            style: const TextStyle(
              color: Color(0xFF15803D),
            ),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
