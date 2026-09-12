import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../controllers/settings_controller.dart';
import '../widgets/settings_section.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = controller.isDark;
    final scaffold = isDark ? const Color(0xFF0D0F11) : Colors.white;
    final titleColor = isDark ? Colors.white : const Color(0xFF111827);
    final actionBg =
        isDark ? const Color(0xFF1B1E23) : const Color(0xFFF3F4F6);
    final actionBorder =
        isDark ? AppColors.darkBorder : AppColors.border;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: (isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark)
          .copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor:
            isDark ? const Color(0xFF0B0D0F) : Colors.white,
        systemNavigationBarIconBrightness:
            isDark ? Brightness.light : Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: scaffold,
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 8, 16, 12),
                child: Row(
                  children: [
                    InkWell(
                      onTap: controller.goBack,
                      borderRadius: BorderRadius.circular(22),
                      child: SizedBox(
                        width: 40,
                        height: 40,
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 20,
                          color: titleColor,
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        'Settings',
                        style: TextStyle(
                          color: titleColor,
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.4,
                        ),
                      ),
                    ),
                    _CircleAction(
                      background: actionBg,
                      border: actionBorder,
                      onTap: controller.openNotifications,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Icon(
                            Icons.notifications_none_rounded,
                            color: titleColor,
                            size: 22,
                          ),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: Color(0xFFEF4444),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    _CircleAction(
                      background: actionBg,
                      border: actionBorder,
                      onTap: controller.openMenu,
                      child: Icon(
                        Icons.menu_rounded,
                        color: titleColor,
                        size: 22,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 28),
                  children: [
                    Obx(
                      () => SettingsSectionCard(
                        title: 'PREFERENCES',
                        isDark: isDark,
                        children: [
                          SettingsToggleTile(
                            icon: Icons.notifications_none_rounded,
                            label: 'Notifications',
                            value: controller.notificationsEnabled.value,
                            onChanged: controller.toggleNotifications,
                            isDark: isDark,
                          ),
                          SettingsNavTile(
                            icon: Icons.language_rounded,
                            label: 'Language',
                            value: controller.language.value,
                            onTap: controller.openLanguage,
                            isDark: isDark,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 22),
                    Obx(
                      () => SettingsSectionCard(
                        title: 'PRIVACY & SECURITY',
                        isDark: isDark,
                        children: [
                          SettingsNavTile(
                            icon: Icons.shield_outlined,
                            label: 'Profile Visibility',
                            value: controller.profileVisibility.value,
                            onTap: controller.openProfileVisibility,
                            isDark: isDark,
                          ),
                          SettingsNavTile(
                            icon: Icons.description_outlined,
                            label: 'Terms of Service',
                            onTap: controller.openTerms,
                            isDark: isDark,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 22),
                    SettingsSectionCard(
                      title: 'SUPPORT',
                      isDark: isDark,
                      children: [
                        SettingsNavTile(
                          icon: Icons.help_outline_rounded,
                          label: 'Help Center',
                          onTap: controller.openHelpCenter,
                          isDark: isDark,
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),
                    Center(
                      child: TextButton.icon(
                        onPressed: controller.deleteAccount,
                        icon: const Icon(
                          Icons.delete_outline_rounded,
                          color: AppColors.error,
                          size: 20,
                        ),
                        label: const Text(
                          'Delete Account',
                          style: TextStyle(
                            color: AppColors.error,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
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
    );
  }
}

class _CircleAction extends StatelessWidget {
  const _CircleAction({
    required this.child,
    required this.onTap,
    required this.background,
    required this.border,
  });

  final Widget child;
  final VoidCallback onTap;
  final Color background;
  final Color border;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22),
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: background,
          shape: BoxShape.circle,
          border: Border.all(color: border),
        ),
        alignment: Alignment.center,
        child: child,
      ),
    );
  }
}
