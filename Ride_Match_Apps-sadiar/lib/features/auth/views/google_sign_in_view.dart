import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../onboarding/models/user_mode.dart';
import '../../onboarding/services/mode_service.dart';
import '../controllers/auth_controller.dart';
import '../models/social_account.dart';

class GoogleSignInView extends StatefulWidget {
  const GoogleSignInView({super.key});

  @override
  State<GoogleSignInView> createState() => _GoogleSignInViewState();
}

class _GoogleSignInViewState extends State<GoogleSignInView> {
  late final AuthController _authController;
  ModeService? _modeService;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _authController = Get.find<AuthController>();
    if (Get.isRegistered<ModeService>()) {
      _modeService = Get.find<ModeService>();
    }
  }

  Future<void> _continue() async {
    final account = SocialDemoAccounts.googleAccounts[_selectedIndex];
    await _authController.completeSocialSignIn(account.email);
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
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
                          'Sign in with Google',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.4,
                            color: isDark ? Colors.white : const Color(0xFF111827),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'to continue to RideMatch',
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
                          decoration: BoxDecoration(
                            color: isDark
                                ? const Color(0xFF14171A)
                                : const Color(0xFFF3F4F6),
                            borderRadius: BorderRadius.circular(22),
                          ),
                          child: Column(
                            children: [
                              for (var i = 0;
                                  i < SocialDemoAccounts.googleAccounts.length;
                                  i++) ...[
                                if (i > 0)
                                  Divider(
                                    height: 1,
                                    thickness: 1,
                                    color: isDark
                                        ? const Color(0xFF262A2E)
                                        : const Color(0xFFE5E7EB),
                                  ),
                                _GoogleAccountTile(
                                  account: SocialDemoAccounts.googleAccounts[i],
                                  isDark: isDark,
                                  selected: _selectedIndex == i,
                                  onTap: () => setState(() => _selectedIndex = i),
                                ),
                              ],
                              Divider(
                                height: 1,
                                thickness: 1,
                                color: isDark
                                    ? const Color(0xFF262A2E)
                                    : const Color(0xFFE5E7EB),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.snackbar(
                                    'Add Account',
                                    'Add another Google account coming soon.',
                                  );
                                },
                                borderRadius: const BorderRadius.vertical(
                                  bottom: Radius.circular(22),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 14,
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 44,
                                        height: 44,
                                        decoration: BoxDecoration(
                                          color: isDark
                                              ? const Color(0xFF1B1E23)
                                              : Colors.white,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.person_add_alt_1_rounded,
                                          color: isDark
                                              ? const Color(0xFF9CA3AF)
                                              : const Color(0xFF6B7280),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Text(
                                        'Add another account',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: isDark
                                              ? Colors.white
                                              : const Color(0xFF111827),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
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

class _GoogleAccountTile extends StatelessWidget {
  const _GoogleAccountTile({
    required this.account,
    required this.isDark,
    required this.selected,
    required this.onTap,
  });

  final SocialAccount account;
  final bool isDark;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 22,
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
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      color: const Color(0xFF3DF416),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isDark ? const Color(0xFF14171A) : Colors.white,
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    account.name,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: isDark ? Colors.white : const Color(0xFF111827),
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
            if (selected)
              const Icon(Icons.check_circle, color: Color(0xFF3DF416), size: 22),
          ],
        ),
      ),
    );
  }
}
