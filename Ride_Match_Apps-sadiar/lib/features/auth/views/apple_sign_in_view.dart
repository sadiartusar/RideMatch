import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../onboarding/models/user_mode.dart';
import '../../onboarding/services/mode_service.dart';
import '../controllers/auth_controller.dart';
import '../models/social_account.dart';

class AppleSignInView extends StatefulWidget {
  const AppleSignInView({super.key});

  @override
  State<AppleSignInView> createState() => _AppleSignInViewState();
}

class _AppleSignInViewState extends State<AppleSignInView> {
  late final AuthController _authController;
  ModeService? _modeService;

  @override
  void initState() {
    super.initState();
    _authController = Get.find<AuthController>();
    if (Get.isRegistered<ModeService>()) {
      _modeService = Get.find<ModeService>();
    }
  }

  Future<void> _continue() async {
    await _authController.completeSocialSignIn(
      SocialDemoAccounts.appleAccount.email,
    );
  }

  @override
  Widget build(BuildContext context) {
    final account = SocialDemoAccounts.appleAccount;

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
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(22, 20, 22, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'RIDEMATCH',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.4,
                            color: isDark
                                ? const Color(0xFF3DF416)
                                : const Color(0xFF15803D),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Sign in with Apple',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.4,
                            color: isDark ? Colors.white : const Color(0xFF111827),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Use your Apple ID to sign in to RideMatch.',
                          style: TextStyle(
                            fontSize: 14.5,
                            color: isDark
                                ? const Color(0xFF9CA3AF)
                                : const Color(0xFF6B7280),
                          ),
                        ),
                        const SizedBox(height: 28),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 14,
                          ),
                          decoration: BoxDecoration(
                            color: isDark
                                ? const Color(0xFF14171A)
                                : const Color(0xFFF3F4F6),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 24,
                                backgroundColor: Color(account.avatarColor),
                                child: Text(
                                  account.initials,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      account.name,
                                      style: TextStyle(
                                        fontSize: 15.5,
                                        fontWeight: FontWeight.w800,
                                        color: isDark
                                            ? Colors.white
                                            : const Color(0xFF111827),
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      account.email,
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: isDark
                                            ? const Color(0xFF9CA3AF)
                                            : const Color(0xFF6B7280),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.chevron_right_rounded,
                                color: isDark
                                    ? const Color(0xFF6B7280)
                                    : const Color(0xFF9CA3AF),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Center(
                          child: Column(
                            children: [
                              Icon(
                                Icons.face_retouching_natural_rounded,
                                size: 64,
                                color: isDark
                                    ? const Color(0xFF3DF416)
                                    : const Color(0xFF22C55E),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'FACE ID',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 1.2,
                                  color: isDark
                                      ? const Color(0xFF3DF416)
                                      : const Color(0xFF16A34A),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(22, 8, 22, 16),
                  child: SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: Obx(() {
                      final loading = _authController.isLoading.value;
                      return Material(
                        color: const Color(0xFF3DF416),
                        borderRadius: BorderRadius.circular(16),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(16),
                          onTap: loading ? null : _continue,
                          child: Center(
                            child: loading
                                ? const SizedBox(
                                    width: 22,
                                    height: 22,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.5,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Color(0xFF0F172A),
                                      ),
                                    ),
                                  )
                                : const Text(
                                    'CONTINUE',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: 0.6,
                                      color: Color(0xFF0F172A),
                                    ),
                                  ),
                          ),
                        ),
                      );
                    }),
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
