import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../core/routes/app_routes.dart';
import '../../onboarding/models/user_mode.dart';
import '../../onboarding/services/mode_service.dart';
import '../controllers/verification_controller.dart';

class BackgroundCheckView extends StatefulWidget {
  const BackgroundCheckView({super.key});

  @override
  State<BackgroundCheckView> createState() => _BackgroundCheckViewState();
}

class _BackgroundCheckViewState extends State<BackgroundCheckView> {
  ModeService? _modeService;

  @override
  void initState() {
    super.initState();
    if (Get.isRegistered<ModeService>()) {
      _modeService = Get.find<ModeService>();
    }
  }

  Future<void> _continue() async {
    if (Get.isRegistered<VerificationController>()) {
      await Get.find<VerificationController>().finishBackgroundCheck();
    } else {
      Get.offAllNamed(AppRoutes.chooseMode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final mode = _modeService?.rxCurrentMode.value;
      final isDark = mode == UserMode.driver;
      final isDriver = mode == UserMode.driver;
      final buttonLabel = isDriver ? 'GO TO DASHBOARD' : 'CONTINUE';

      final backgroundColor = isDark ? const Color(0xFF0B0D0F) : Colors.white;
      final overlayStyle = isDark
          ? SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent)
          : SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent);

      final titleColor = isDark ? Colors.white : const Color(0xFF111827);
      final subtitleColor =
          isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280);

      return AnnotatedRegion<SystemUiOverlayStyle>(
        value: overlayStyle,
        child: Scaffold(
          backgroundColor: backgroundColor,
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(22, 28, 22, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Background check in progress',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.5,
                            height: 1.15,
                            color: titleColor,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "We're reviewing your profile for safety and trust. This helps keep the community secure.",
                          style: TextStyle(
                            fontSize: 14.5,
                            height: 1.4,
                            color: subtitleColor,
                          ),
                        ),
                        const SizedBox(height: 28),
                        _VerifiedStep(
                          isDark: isDark,
                          label: 'Email verified',
                        ),
                        const SizedBox(height: 12),
                        _VerifiedStep(
                          isDark: isDark,
                          label: 'Phone verified',
                        ),
                        const SizedBox(height: 12),
                        _VerifiedStep(
                          isDark: isDark,
                          label: 'ID submitted',
                        ),
                        const SizedBox(height: 12),
                        _PendingStep(isDark: isDark),
                        const SizedBox(height: 22),
                        const _SecurityPolicyBanner(),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(22, 8, 22, 20),
                  child: SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: Material(
                      color: const Color(0xFF3DF416),
                      borderRadius: BorderRadius.circular(28),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(28),
                        onTap: _continue,
                        child: Center(
                          child: Text(
                            buttonLabel,
                            style: const TextStyle(
                              fontSize: 14.5,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.6,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                        ),
                      ),
                    ),
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

class _VerifiedStep extends StatelessWidget {
  const _VerifiedStep({
    required this.isDark,
    required this.label,
  });

  final bool isDark;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF14171A) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.06),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: const BoxDecoration(
              color: Color(0xFF3DF416),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check_rounded,
              size: 20,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 15.5,
                fontWeight: FontWeight.w700,
                color: isDark ? Colors.white : const Color(0xFF111827),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PendingStep extends StatelessWidget {
  const _PendingStep({required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF14171A) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFF59E0B).withValues(alpha: 0.28),
            blurRadius: 18,
            spreadRadius: 1,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: const BoxDecoration(
              color: Color(0xFFF59E0B),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.more_horiz_rounded,
              size: 22,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Background check',
                  style: TextStyle(
                    fontSize: 15.5,
                    fontWeight: FontWeight.w800,
                    color: isDark ? Colors.white : const Color(0xFF111827),
                  ),
                ),
                const SizedBox(height: 3),
                const Text(
                  'CURRENTLY PENDING',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.6,
                    color: Color(0xFFB45309),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 56,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: const LinearProgressIndicator(
                value: 0.72,
                minHeight: 6,
                backgroundColor: Color(0xFFE5E7EB),
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFF59E0B)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SecurityPolicyBanner extends StatelessWidget {
  const _SecurityPolicyBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1D21),
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 1),
            child: Icon(
              Icons.gavel_rounded,
              size: 18,
              color: Color(0xFF3DF416),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Security Policy: ',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      height: 1.4,
                      color: Color(0xFF3DF416),
                    ),
                  ),
                  TextSpan(
                    text:
                        'Users with violent criminal records are not allowed on the platform.',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      height: 1.4,
                      color: Colors.white,
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
