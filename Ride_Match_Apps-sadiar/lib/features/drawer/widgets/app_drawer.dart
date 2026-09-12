import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../models/drawer_nav_item.dart';
import 'drawer_nav_tile.dart';
import 'drawer_profile_header.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    super.key,
    required this.userName,
    this.isVerified = true,
    this.avatarUrl,
    this.selectedId = DrawerNavId.home,
    required this.onItemSelected,
    this.isDark = false,
  });

  final String userName;
  final bool isVerified;
  final String? avatarUrl;
  final DrawerNavId selectedId;
  final ValueChanged<DrawerNavId> onItemSelected;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final double maxWidth = MediaQuery.sizeOf(context).width * 0.78;
    final Color background =
        isDark ? const Color(0xFF16181B) : Colors.white;
    final Color dividerColor =
        isDark ? AppColors.darkBorder : AppColors.border;
    final Color preferencesColor =
        isDark ? AppColors.darkTextSecondary : AppColors.textSecondary;

    return Container(
      width: maxWidth.clamp(280, 340),
      height: double.infinity,
      decoration: BoxDecoration(
        color: background,
        borderRadius: const BorderRadius.horizontal(
          right: Radius.circular(28),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.45 : 0.18),
            blurRadius: 24,
            offset: const Offset(4, 0),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Material(
        color: background,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(22, 12, 22, 8),
                child: DrawerProfileHeader(
                  name: userName,
                  isVerified: isVerified,
                  avatarUrl: avatarUrl,
                  isDark: isDark,
                  onProfileTap: () => onItemSelected(DrawerNavId.profile),
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(14, 0, 14, 16),
                  children: [
                    for (final item in DrawerNavItem.primary)
                      DrawerNavTile(
                        item: item,
                        isSelected: item.id == selectedId,
                        isDark: isDark,
                        onTap: () => onItemSelected(item.id),
                      ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 14),
                      child: Divider(
                        height: 1,
                        thickness: 1,
                        color: dividerColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(14, 0, 14, 10),
                      child: Text(
                        'PREFERENCES',
                        style: TextStyle(
                          color: preferencesColor,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),
                    for (final item in DrawerNavItem.preferences)
                      DrawerNavTile(
                        item: item,
                        isSelected: false,
                        isDark: isDark,
                        onTap: () => onItemSelected(item.id),
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

/// Opens the left side navigation drawer as a modal overlay.
Future<T?> showAppDrawer<T>({
  required String userName,
  bool isVerified = true,
  String? avatarUrl,
  DrawerNavId selectedId = DrawerNavId.home,
  bool isDark = false,
  required ValueChanged<DrawerNavId> onItemSelected,
}) {
  final context = Get.overlayContext ?? Get.context;
  if (context == null) return Future.value();

  return showGeneralDialog<T>(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Close drawer',
    barrierColor: Colors.black.withValues(alpha: isDark ? 0.65 : 0.45),
    transitionDuration: const Duration(milliseconds: 260),
    pageBuilder: (context, animation, secondaryAnimation) {
      void close() {
        if (Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        }
      }

      return Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: close,
              child: const SizedBox.expand(),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(-1, 0),
                end: Offset.zero,
              ).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeOutCubic,
                  reverseCurve: Curves.easeInCubic,
                ),
              ),
              child: AppDrawer(
                userName: userName,
                isVerified: isVerified,
                avatarUrl: avatarUrl,
                selectedId: selectedId,
                isDark: isDark,
                  onItemSelected: (id) {
                  close();
                  // Wait for the drawer dialog to finish closing before
                  // pushing a new route (avoids empty/broken pages).
                  Future<void>.delayed(const Duration(milliseconds: 280), () {
                    onItemSelected(id);
                  });
                },
              ),
            ),
          ),
        ],
      );
    },
  );
}
