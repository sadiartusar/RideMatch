import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../core/routes/app_routes.dart';
import '../../onboarding/models/user_mode.dart';
import '../../onboarding/services/mode_service.dart';
import '../controllers/auth_controller.dart';
import '../models/otp_args.dart';

class OtpView extends StatefulWidget {
  const OtpView({super.key});

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  static const int _otpLength = 6;
  static const int _resendSeconds = 45;

  final List<String> _digits = List.filled(_otpLength, '');
  late final OtpArgs _args;
  ModeService? _modeService;
  AuthController? _authController;

  int _secondsLeft = _resendSeconds;
  Timer? _timer;

  String get _destination => _args.destination;
  bool get _isNewUser => _args.isNewUser;

  @override
  void initState() {
    super.initState();
    _args = OtpArgs.tryParse(Get.arguments) ??
        const OtpArgs(destination: 'carlton.johnson@email.com', isNewUser: true);
    if (Get.isRegistered<ModeService>()) {
      _modeService = Get.find<ModeService>();
    }
    if (Get.isRegistered<AuthController>()) {
      _authController = Get.find<AuthController>();
    }
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() => _secondsLeft = _resendSeconds);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsLeft <= 1) {
        timer.cancel();
        setState(() => _secondsLeft = 0);
      } else {
        setState(() => _secondsLeft -= 1);
      }
    });
  }

  int get _activeIndex {
    final empty = _digits.indexWhere((d) => d.isEmpty);
    return empty == -1 ? _otpLength - 1 : empty;
  }

  String get _code => _digits.join();

  void _onKey(String value) {
    final index = _digits.indexWhere((d) => d.isEmpty);
    if (index == -1) return;
    setState(() => _digits[index] = value);
  }

  void _onBackspace() {
    final lastFilled = _digits.lastIndexWhere((d) => d.isNotEmpty);
    if (lastFilled == -1) return;
    setState(() => _digits[lastFilled] = '');
  }

  void _resend() {
    if (_secondsLeft > 0) return;
    setState(() {
      for (var i = 0; i < _digits.length; i++) {
        _digits[i] = '';
      }
    });
    _startTimer();
    Get.snackbar('Code Sent', 'A new OTP was sent to $_destination');
  }

  Future<void> _verify() async {
    if (_code.length < _otpLength) {
      Get.snackbar('Incomplete', 'Please enter the 6-digit code.');
      return;
    }

    if (_isNewUser) {
      Get.offNamed(AppRoutes.verificationHub);
      return;
    }

    // Existing user → dashboard / mode home.
    final email = _destination.contains('@')
        ? _destination
        : '$_destination@ridematch.com';
    await _authController?.login(email: email, password: 'otp');
  }

  String get _timerLabel {
    final m = (_secondsLeft ~/ 60).toString().padLeft(2, '0');
    final s = (_secondsLeft % 60).toString().padLeft(2, '0');
    return '($m:$s)';
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
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    child: Column(
                      children: [
                        const SizedBox(height: 36),
                        Text(
                          'Enter OTP',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.4,
                            color: isDark ? Colors.white : const Color(0xFF111827),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text.rich(
                          TextSpan(
                            style: TextStyle(
                              fontSize: 14.5,
                              height: 1.4,
                              color: isDark
                                  ? const Color(0xFF9CA3AF)
                                  : const Color(0xFF6B7280),
                            ),
                            children: [
                              const TextSpan(text: 'We sent a 6-digit code to '),
                              TextSpan(
                                text: _destination,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: isDark
                                      ? Colors.white
                                      : const Color(0xFF111827),
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 32),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(_otpLength, (index) {
                            return _OtpBox(
                              digit: _digits[index],
                              isDark: isDark,
                              isActive: index == _activeIndex,
                            );
                          }),
                        ),
                        const SizedBox(height: 22),
                        GestureDetector(
                          onTap: _resend,
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Resend Code',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: _secondsLeft > 0
                                        ? (isDark
                                            ? const Color(0xFF6B7280)
                                            : const Color(0xFF9CA3AF))
                                        : (isDark
                                            ? const Color(0xFF3DF416)
                                            : const Color(0xFF15803D)),
                                  ),
                                ),
                                if (_secondsLeft > 0)
                                  TextSpan(
                                    text: ' $_timerLabel',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: isDark
                                          ? const Color(0xFF4B5563)
                                          : const Color(0xFFB0B5BD),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 28),
                        _Keypad(
                          isDark: isDark,
                          onDigit: _onKey,
                          onBackspace: _onBackspace,
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(22, 0, 22, 16),
                  child: SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: Obx(() {
                      final loading = _authController?.isLoading.value ?? false;
                      return Material(
                        color: const Color(0xFF3DF416),
                        borderRadius: BorderRadius.circular(28),
                        elevation: isDark ? 0 : 2,
                        shadowColor:
                            const Color(0xFF3DF416).withValues(alpha: 0.35),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(28),
                          onTap: loading ? null : _verify,
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
                                : const Row(
                                    mainAxisSize: MainAxisSize.min,
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

class _OtpBox extends StatelessWidget {
  const _OtpBox({
    required this.digit,
    required this.isDark,
    required this.isActive,
  });

  final String digit;
  final bool isDark;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final borderColor = isActive
        ? const Color(0xFF3DF416)
        : (isDark ? const Color(0xFF2C333A) : const Color(0xFFD1D5DB));

    return Container(
      width: 48,
      height: 56,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF14171A) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor, width: isActive ? 2 : 1.2),
      ),
      child: Text(
        digit,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: isDark ? Colors.white : const Color(0xFF111827),
        ),
      ),
    );
  }
}

class _Keypad extends StatelessWidget {
  const _Keypad({
    required this.isDark,
    required this.onDigit,
    required this.onBackspace,
  });

  final bool isDark;
  final ValueChanged<String> onDigit;
  final VoidCallback onBackspace;

  @override
  Widget build(BuildContext context) {
    const keys = [
      ['1', '2', '3'],
      ['4', '5', '6'],
      ['7', '8', '9'],
      ['', '0', 'back'],
    ];

    return Column(
      children: [
        for (final row in keys) ...[
          Row(
            children: [
              for (var i = 0; i < row.length; i++) ...[
                if (i > 0) const SizedBox(width: 12),
                Expanded(
                  child: _KeypadKey(
                    isDark: isDark,
                    label: row[i],
                    onTap: () {
                      if (row[i] == 'back') {
                        onBackspace();
                      } else if (row[i].isNotEmpty) {
                        onDigit(row[i]);
                      }
                    },
                  ),
                ),
              ],
            ],
          ),
          if (row != keys.last) const SizedBox(height: 12),
        ],
      ],
    );
  }
}

class _KeypadKey extends StatelessWidget {
  const _KeypadKey({
    required this.isDark,
    required this.label,
    required this.onTap,
  });

  final bool isDark;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    if (label.isEmpty) {
      return const SizedBox(height: 54);
    }

    final isBack = label == 'back';

    return Material(
      color: isDark ? const Color(0xFF181A1D) : Colors.white,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Container(
          height: 54,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isDark ? const Color(0xFF262A2E) : const Color(0xFFE5E7EB),
              width: 1.2,
            ),
          ),
          child: isBack
              ? Icon(
                  Icons.backspace_outlined,
                  size: 22,
                  color: isDark ? Colors.white : const Color(0xFF111827),
                )
              : Text(
                  label,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : const Color(0xFF111827),
                  ),
                ),
        ),
      ),
    );
  }
}
