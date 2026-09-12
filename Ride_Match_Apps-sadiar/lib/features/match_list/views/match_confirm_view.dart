import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../main_nav/widgets/app_mode_bottom_nav.dart';
import '../controllers/match_confirm_controller.dart';
import '../widgets/match_ai_rationale_grid.dart';
import '../widgets/match_trust_section.dart';

class MatchConfirmView extends GetView<MatchConfirmController> {
  const MatchConfirmView({super.key});

  static const double _phoneMaxWidth = 430;

  @override
  Widget build(BuildContext context) {
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
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final compact = constraints.maxHeight < 640;
                        return SingleChildScrollView(
                          padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                          child: Column(
                            children: [
                              _HeroBanner(compact: compact),
                              SizedBox(height: compact ? 14 : 18),
                              const _RequestSentStatus(),
                              SizedBox(height: compact ? 14 : 18),
                              const MatchAiRationaleGrid(),
                              SizedBox(height: compact ? 12 : 16),
                              const MatchTrustSection(),
                              SizedBox(height: compact ? 14 : 18),
                              SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton.icon(
                                  onPressed: controller.openPreMatchChat,
                                  icon: const Icon(
                                    Icons.chat_bubble_rounded,
                                    size: 18,
                                  ),
                                  label: const Text(
                                    'Pre-Match Chat',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.button,
                                    foregroundColor: const Color(0xFF111827),
                                    elevation: 0,
                                    shadowColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: controller.viewFullProfile,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFEEF0F3),
                                    foregroundColor: const Color(0xFF111827),
                                    elevation: 0,
                                    shadowColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                  ),
                                  child: const Text(
                                    'View Full Profile',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              TextButton(
                                onPressed: controller.continueFlow,
                                child: const Text(
                                  'Continue',
                                  style: TextStyle(
                                    color: Color(0xFF6B7280),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Obx(
          () => AppModeBottomNav(
            selectedIndex: controller.selectedNavIndex.value,
            onTap: controller.onNavTap,
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
      padding: const EdgeInsets.fromLTRB(4, 2, 4, 0),
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
                'Match Confirm',
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

class _HeroBanner extends StatelessWidget {
  const _HeroBanner({required this.compact});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    final height = compact ? 148.0 : 168.0;

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            AppAssets.profileVehicle,
            width: double.infinity,
            height: height,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                height: height,
                color: const Color(0xFFE5E7EB),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.directions_car_rounded,
                  size: 56,
                  color: Color(0xFF9CA3AF),
                ),
              );
            },
          ),
        ),
        Positioned(
          bottom: 14,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.button,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.18),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.favorite_rounded,
                  color: Color(0xFF111827),
                  size: 16,
                ),
                SizedBox(width: 6),
                Text(
                  'Great Match!',
                  style: TextStyle(
                    color: Color(0xFF111827),
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _RequestSentStatus extends StatelessWidget {
  const _RequestSentStatus();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: Color(0xFF22C55E),
                borderRadius: BorderRadius.all(Radius.circular(3)),
              ),
              child: SizedBox(width: 8, height: 8),
            ),
            SizedBox(width: 8),
            Text(
              'REQUEST SENT',
              style: TextStyle(
                color: Color(0xFF16A34A),
                fontSize: 13,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.8,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          'Waiting for Driver Confirmation',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF111827),
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: 6),
        Text(
          'Driver Notified for Review. You\'ll be accepted as soon as they confirm.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF6B7280),
            fontSize: 13,
            fontWeight: FontWeight.w500,
            height: 1.4,
          ),
        ),
      ],
    );
  }
}
