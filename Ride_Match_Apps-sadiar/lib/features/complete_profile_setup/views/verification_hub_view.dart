import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../onboarding/models/user_mode.dart';
import '../../onboarding/services/mode_service.dart';
import '../controllers/verification_controller.dart';
import '../widgets/driver_document_row.dart';
import '../widgets/safety_banner_carousel.dart';
import '../widgets/verification_step_card.dart';

class VerificationHubView extends StatefulWidget {
  const VerificationHubView({super.key});

  @override
  State<VerificationHubView> createState() => _VerificationHubViewState();
}

class _VerificationHubViewState extends State<VerificationHubView> {
  late final PageController _bannerController;
  ModeService? _modeService;

  @override
  void initState() {
    super.initState();
    _bannerController = PageController();
    if (Get.isRegistered<ModeService>()) {
      _modeService = Get.find<ModeService>();
    }
  }

  @override
  void dispose() {
    _bannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<VerificationController>();

    return Obx(() {
      final mode = _modeService?.rxCurrentMode.value;
      final isDark = mode == UserMode.driver;

      final backgroundColor = isDark ? const Color(0xFF0B0D0F) : Colors.white;
      final overlayStyle = isDark
          ? SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent)
          : SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent);

      return AnnotatedRegion<SystemUiOverlayStyle>(
        value: overlayStyle,
        child: Scaffold(
          backgroundColor: backgroundColor,
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(22, 20, 22, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Verify your account',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.5,
                            color: isDark ? Colors.white : const Color(0xFF111827),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'We verify every member to build a safer and more trusted community.',
                          style: TextStyle(
                            fontSize: 14.5,
                            height: 1.4,
                            color: isDark
                                ? const Color(0xFF9CA3AF)
                                : const Color(0xFF6B7280),
                          ),
                        ),
                        const SizedBox(height: 22),
                        VerificationStepCard(
                          stepLabel: 'STEP 01',
                          title: 'Email Verification',
                          subtitle: 'Check your inbox for a security code.',
                          icon: Icons.mail_outline_rounded,
                          status: VerificationStepStatus.verify,
                          isDark: isDark,
                          onTap: controller.openEmailVerification,
                        ),
                        const SizedBox(height: 12),
                        VerificationStepCard(
                          stepLabel: 'STEP 02',
                          title: 'Phone Verification',
                          subtitle: 'Verify via SMS code.',
                          icon: Icons.smartphone_rounded,
                          status: VerificationStepStatus.verify,
                          isDark: isDark,
                          onTap: controller.openPhoneVerification,
                        ),
                        const SizedBox(height: 12),
                        VerificationStepCard(
                          stepLabel: 'STEP 03',
                          title: 'Identity Verification',
                          subtitle: 'Official government ID required.',
                          icon: Icons.badge_outlined,
                          status: VerificationStepStatus.pending,
                          isDark: isDark,
                          onTap: controller.openIdentityVerification,
                        ),
                        const SizedBox(height: 28),
                        Text(
                          'Driver Documents',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: isDark
                                ? Colors.white
                                : const Color(0xFF111827),
                          ),
                        ),
                        const SizedBox(height: 12),
                        DriverDocumentRow(
                          label: 'Driving License',
                          icon: Icons.badge_outlined,
                          isDark: isDark,
                          isUploaded: true,
                        ),
                        const SizedBox(height: 10),
                        DriverDocumentRow(
                          label: 'Commercial Insurance',
                          icon: Icons.shield_outlined,
                          isDark: isDark,
                          isUploaded: false,
                          onUpload: () =>
                              controller.uploadDocument('Commercial Insurance'),
                        ),
                        const SizedBox(height: 10),
                        DriverDocumentRow(
                          label: 'Vehicle Registration',
                          icon: Icons.grid_view_rounded,
                          isDark: isDark,
                          isUploaded: false,
                          onUpload: () =>
                              controller.uploadDocument('Vehicle Registration'),
                        ),
                        const SizedBox(height: 24),
                        Obx(
                          () => SafetyBannerCarousel(
                            pageController: _bannerController,
                            currentIndex: controller.bannerIndex.value,
                            pageCount: VerificationController.bannerCount,
                            onPageChanged: controller.onBannerChanged,
                            isDark: isDark,
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(22, 8, 22, 16),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 54,
                        child: Material(
                          color: const Color(0xFF3DF416),
                          borderRadius: BorderRadius.circular(28),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(28),
                            onTap: controller.continueAfterVerification,
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'VERIFY & CONTINUE',
                                  style: TextStyle(
                                    fontSize: 14.5,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 0.6,
                                    color: Color(0xFF0F172A),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Icon(
                                  Icons.arrow_forward,
                                  size: 18,
                                  color: Color(0xFF0F172A),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'YOU MUST BE 18 OR OLDER TO JOIN RIDEMATCH.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 10.5,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.4,
                          color: isDark
                              ? const Color(0xFF3DF416)
                              : const Color(0xFF15803D),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
