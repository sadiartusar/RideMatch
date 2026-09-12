import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../core/routes/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../onboarding/models/user_mode.dart';
import '../../onboarding/services/mode_service.dart';
import '../controllers/auth_controller.dart';

class AuthWelcomeView extends StatefulWidget {
  const AuthWelcomeView({super.key});

  @override
  State<AuthWelcomeView> createState() => _AuthWelcomeViewState();
}

class _AuthWelcomeViewState extends State<AuthWelcomeView> {
  final _emailController = TextEditingController(text: 'carlton.johnson@email.com');
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

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _onEmailContinue() async {
    await _authController.continueWithEmail(_emailController.text);
  }

  @override
  Widget build(BuildContext context) {
    // React to active user mode from ModeService
    return Obx(() {
      final mode = _modeService?.rxCurrentMode.value;
      // Driver mode always displays dark UI. Flex and Rider display white UI.
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
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),

                  // Brand Tag
                  Text(
                    'RIDEMATCH',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.4,
                      color: isDark ? const Color(0xFF22C55E) : const Color(0xFF15803D),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Headline
                  Text(
                    'Welcome Back',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.6,
                      color: isDark ? Colors.white : const Color(0xFF111827),
                    ),
                  ),
                  const SizedBox(height: 6),

                  // Subtitle
                  Text(
                    'Sign in or create an account to start matching',
                    style: TextStyle(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w400,
                      color: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280),
                    ),
                  ),
                  const SizedBox(height: 28),

                  // Social Auth Buttons
                  _SocialButton(
                    isDark: isDark,
                    isApple: true,
                    label: 'Continue with Apple',
                    leading: const Text('🍎', style: TextStyle(fontSize: 18)),
                    onTap: () => Get.toNamed(AppRoutes.appleSignIn),
                  ),
                  const SizedBox(height: 12),

                  _SocialButton(
                    isDark: isDark,
                    label: 'Continue with Google',
                    leading: Text(
                      'G',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: isDark ? Colors.white : const Color(0xFF111827),
                        fontFamily: 'sans-serif',
                      ),
                    ),
                    onTap: () => Get.toNamed(AppRoutes.googleSignIn),
                  ),
                  const SizedBox(height: 12),

                  _SocialButton(
                    isDark: isDark,
                    label: 'Continue with Phone',
                    leading: Icon(
                      Icons.phone_outlined,
                      size: 20,
                      color: isDark ? Colors.white : const Color(0xFF111827),
                    ),
                    onTap: () => Get.toNamed(AppRoutes.phoneEntry),
                  ),
                  const SizedBox(height: 28),

                  // "or" Divider
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 1,
                          color: isDark ? const Color(0xFF22262B) : const Color(0xFFE5E7EB),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        child: Text(
                          'or',
                          style: TextStyle(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w500,
                            color: isDark ? const Color(0xFF6B7280) : const Color(0xFF9CA3AF),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 1,
                          color: isDark ? const Color(0xFF22262B) : const Color(0xFFE5E7EB),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),

                  // Email Input Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF111316) : Colors.white,
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(
                        color: isDark ? const Color(0xFF22262B) : const Color(0xFFE5E7EB),
                        width: 1.2,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'EMAIL',
                          style: TextStyle(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.8,
                            color: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280),
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Email TextField
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (_) => _onEmailContinue(),
                          style: TextStyle(
                            fontSize: 14.5,
                            fontWeight: FontWeight.w500,
                            color: isDark ? Colors.white : const Color(0xFF111827),
                          ),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: isDark ? const Color(0xFF1B1E23) : const Color(0xFFF3F4F6),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 14,
                            ),
                            hintText: 'carlton.johnson@email.com',
                            hintStyle: TextStyle(
                              fontSize: 14.5,
                              color: isDark ? const Color(0xFF6B7280) : const Color(0xFF9CA3AF),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: isDark ? const Color(0xFF3DF416) : const Color(0xFF15803D),
                                width: 1.2,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Error message if any
                        Obx(() {
                          final error = _authController.errorMessage.value;
                          if (error.isEmpty) return const SizedBox.shrink();
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Text(
                              error,
                              style: const TextStyle(
                                fontSize: 13,
                                color: AppColors.error,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }),

                        // Continue Button
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: Obx(() {
                            final isLoading = _authController.isLoading.value;
                            return Material(
                              color: const Color(0xFF3DF416),
                              borderRadius: BorderRadius.circular(16),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(16),
                                onTap: isLoading ? null : _onEmailContinue,
                                child: Center(
                                  child: isLoading
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
                                          'Continue',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w800,
                                            color: Color(0xFF0F172A),
                                            letterSpacing: 0.2,
                                          ),
                                        ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Legal Links Footer
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 18,
                    runSpacing: 8,
                    children: [
                      _FooterLink(
                        label: 'TERMS OF SERVICE',
                        isDark: isDark,
                        onTap: () {},
                      ),
                      _FooterLink(
                        label: 'PRIVACY POLICY',
                        isDark: isDark,
                        onTap: () {},
                      ),
                      _FooterLink(
                        label: 'SAFETY GUIDELINES',
                        isDark: isDark,
                        onTap: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Agreement Text
                  Center(
                    child: Text(
                      'BY CONTINUE, YOU AGREE TO OUR TERMS OF SERVICE AND\nPRIVACY POLICY. MUST BE 18+ TO RIDE.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.4,
                        height: 1.45,
                        color: isDark ? const Color(0xFFE5E7EB) : const Color(0xFF15803D),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({
    required this.isDark,
    required this.label,
    required this.leading,
    required this.onTap,
    this.isApple = false,
  });

  final bool isDark;
  final String label;
  final Widget leading;
  final VoidCallback onTap;
  final bool isApple;

  @override
  Widget build(BuildContext context) {
    Color bg;
    Border? border;
    Color textColor;
    Color chevronColor;

    if (isApple) {
      if (isDark) {
        bg = const Color(0xFF181A1D);
        border = Border.all(color: const Color(0xFF262A2E), width: 1.2);
        textColor = Colors.white;
        chevronColor = const Color(0xFF4B5563);
      } else {
        bg = const Color(0xFF111214);
        border = null;
        textColor = Colors.white;
        chevronColor = const Color(0xFF6B7280);
      }
    } else {
      if (isDark) {
        bg = const Color(0xFF181A1D);
        border = Border.all(color: const Color(0xFF262A2E), width: 1.2);
        textColor = Colors.white;
        chevronColor = const Color(0xFF4B5563);
      } else {
        bg = Colors.white;
        border = Border.all(color: const Color(0xFFE5E7EB), width: 1.2);
        textColor = const Color(0xFF111827);
        chevronColor = const Color(0xFF9CA3AF);
      }
    }

    return Container(
      height: 54,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(16),
        border: border,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Row(
              children: [
                SizedBox(
                  width: 24,
                  height: 24,
                  child: Center(child: leading),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                  ),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  size: 20,
                  color: chevronColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FooterLink extends StatelessWidget {
  const _FooterLink({
    required this.label,
    required this.isDark,
    required this.onTap,
  });

  final String label;
  final bool isDark;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10.5,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
          color: isDark ? const Color(0xFF16A34A) : const Color(0xFF9CA3AF),
        ),
      ),
    );
  }
}
