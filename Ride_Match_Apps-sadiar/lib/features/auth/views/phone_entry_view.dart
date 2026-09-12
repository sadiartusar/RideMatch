import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../onboarding/models/user_mode.dart';
import '../../onboarding/services/mode_service.dart';
import '../controllers/auth_controller.dart';

/// First step of phone auth: enter phone, then branch new vs existing.
class PhoneEntryView extends StatefulWidget {
  const PhoneEntryView({super.key});

  @override
  State<PhoneEntryView> createState() => _PhoneEntryViewState();
}

class _PhoneEntryViewState extends State<PhoneEntryView> {
  final _phoneController = TextEditingController(text: '+1-587 1XXXXXXXXX');
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
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _continue() async {
    await _authController.continueWithPhone(_phoneController.text);
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
                    'Continue with Phone',
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
                  Text(
                    'ENTER YOUR PHONE NUMBER',
                    style: TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.8,
                      color: isDark
                          ? const Color(0xFF9CA3AF)
                          : const Color(0xFF6B7280),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (_) => _continue(),
                    style: TextStyle(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w500,
                      color: isDark ? Colors.white : const Color(0xFF111827),
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: isDark
                          ? const Color(0xFF1B1E23)
                          : const Color(0xFFF3F4F6),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
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
                          color: isDark
                              ? const Color(0xFF3DF416)
                              : const Color(0xFF15803D),
                          width: 1.2,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
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
                                    'Continue',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800,
                                      color: Color(0xFF0F172A),
                                    ),
                                  ),
                          ),
                        ),
                      );
                    }),
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
