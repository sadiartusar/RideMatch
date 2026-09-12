import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../core/routes/app_routes.dart';
import '../../onboarding/models/user_mode.dart';
import '../../onboarding/services/mode_service.dart';
import '../models/otp_args.dart';

/// Email login — existing user email + password.
class EmailLoginView extends StatefulWidget {
  const EmailLoginView({super.key});

  @override
  State<EmailLoginView> createState() => _EmailLoginViewState();
}

class _EmailLoginViewState extends State<EmailLoginView> {
  late final TextEditingController _emailController;
  final _passwordController = TextEditingController(text: 'password');
  bool _obscurePassword = true;
  ModeService? _modeService;

  @override
  void initState() {
    super.initState();
    final email = Get.arguments is String ? Get.arguments as String : '';
    _emailController = TextEditingController(
      text: email.isNotEmpty ? email : 'carlton.johnson@email.com',
    );
    if (Get.isRegistered<ModeService>()) {
      _modeService = Get.find<ModeService>();
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _continue() {
    final email = _emailController.text.trim();
    if (email.isEmpty) {
      Get.snackbar('Email Required', 'Please enter your email address.');
      return;
    }
    if (_passwordController.text.isEmpty) {
      Get.snackbar('Password Required', 'Please enter your password.');
      return;
    }
    Get.toNamed(
      AppRoutes.otp,
      arguments: OtpArgs(destination: email, isNewUser: false),
    );
  }

  @override
  Widget build(BuildContext context) {
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
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
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
                    'Login Account',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.6,
                      color: isDark ? Colors.white : const Color(0xFF111827),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Sign in or create an account to start matching',
                    style: TextStyle(
                      fontSize: 14.5,
                      color: isDark
                          ? const Color(0xFF9CA3AF)
                          : const Color(0xFF6B7280),
                    ),
                  ),
                  const SizedBox(height: 28),
                  _LabeledField(
                    isDark: isDark,
                    label: 'EMAIL',
                    child: TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: _fieldStyle(isDark),
                      decoration: _inputDecoration(isDark),
                    ),
                  ),
                  const SizedBox(height: 18),
                  _LabeledField(
                    isDark: isDark,
                    label: 'ENTER PASSWORD',
                    child: TextField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      style: _fieldStyle(isDark),
                      decoration: _inputDecoration(
                        isDark,
                        suffix: IconButton(
                          onPressed: () => setState(
                            () => _obscurePassword = !_obscurePassword,
                          ),
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            size: 20,
                            color: const Color(0xFF9CA3AF),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: Material(
                      color: const Color(0xFF3DF416),
                      borderRadius: BorderRadius.circular(16),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: _continue,
                        child: const Center(
                          child: Text(
                            'Continue',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  _OrDivider(isDark: isDark),
                  const SizedBox(height: 28),
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
                      ),
                    ),
                    onTap: () => Get.toNamed(AppRoutes.googleSignIn),
                  ),
                  const SizedBox(height: 32),
                  const _LegalFooter(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  TextStyle _fieldStyle(bool isDark) {
    return TextStyle(
      fontSize: 14.5,
      fontWeight: FontWeight.w500,
      color: isDark ? Colors.white : const Color(0xFF111827),
    );
  }

  InputDecoration _inputDecoration(bool isDark, {Widget? suffix}) {
    return InputDecoration(
      filled: true,
      fillColor: isDark ? const Color(0xFF1B1E23) : const Color(0xFFF3F4F6),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
      suffixIcon: suffix,
    );
  }
}

class _LabeledField extends StatelessWidget {
  const _LabeledField({
    required this.isDark,
    required this.label,
    required this.child,
  });

  final bool isDark;
  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11.5,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
            color: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280),
          ),
        ),
        const SizedBox(height: 10),
        child,
      ],
    );
  }
}

class _OrDivider extends StatelessWidget {
  const _OrDivider({required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final line = isDark ? const Color(0xFF22262B) : const Color(0xFFE5E7EB);
    return Row(
      children: [
        Expanded(child: Container(height: 1, color: line)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Text(
            'or',
            style: TextStyle(
              fontSize: 13.5,
              color: isDark ? const Color(0xFF6B7280) : const Color(0xFF9CA3AF),
            ),
          ),
        ),
        Expanded(child: Container(height: 1, color: line)),
      ],
    );
  }
}

class _LegalFooter extends StatelessWidget {
  const _LegalFooter();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text.rich(
        TextSpan(
          style: TextStyle(fontSize: 11.5, height: 1.45, color: Color(0xFF6B7280)),
          children: [
            TextSpan(text: 'By continuing, you agree to our '),
            TextSpan(
              text: 'Terms of Service',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            TextSpan(text: ' and '),
            TextSpan(
              text: 'Privacy Policy',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
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
    late final Color bg;
    late final Border? border;
    late final Color textColor;
    late final Color chevronColor;

    if (isApple) {
      bg = isDark ? const Color(0xFF181A1D) : const Color(0xFF111214);
      border = isDark ? Border.all(color: const Color(0xFF262A2E), width: 1.2) : null;
      textColor = Colors.white;
      chevronColor = const Color(0xFF6B7280);
    } else if (isDark) {
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
                SizedBox(width: 24, height: 24, child: Center(child: leading)),
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
                Icon(Icons.chevron_right_rounded, size: 20, color: chevronColor),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
