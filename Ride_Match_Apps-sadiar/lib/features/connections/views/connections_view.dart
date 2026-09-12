import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../community_circle/widgets/community_search_field.dart';
import '../../community_circle/widgets/community_top_bar.dart';
import '../controllers/connections_controller.dart';
import '../widgets/connection_friend_card.dart';

class ConnectionsView extends GetView<ConnectionsController> {
  const ConnectionsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ConnectionsController>();
    final isDark = controller.isDark;
    final scaffold = isDark ? const Color(0xFF0D0F11) : const Color(0xFFF7F7F5);
    final muted = isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280);
    final border =
        isDark ? const Color(0xFF2C333A) : const Color(0xFFD1D5DB);

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
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 8, 16, 8),
                child: CommunityTopBar(
                  title: 'Connections',
                  onBack: controller.goBack,
                  onNotificationTap: controller.openNotifications,
                  onMenuTap: controller.openMenu,
                  isDark: isDark,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
                child: CommunitySearchField(
                  controller: controller.searchController,
                  isDark: isDark,
                  hintText: 'Search friends...',
                ),
              ),
              Expanded(
                child: Obx(() {
                  final items = controller.filteredFriends;
                  if (items.isEmpty) {
                    return Center(
                      child: Text(
                        'No friends found',
                        style: TextStyle(
                          color: muted,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  }

                  return ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                    itemCount: items.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final friend = items[index];
                      return ConnectionFriendCard(
                        friend: friend,
                        isDark: isDark,
                        onChat: () => controller.openChat(friend),
                        onProfile: () => controller.openProfile(friend),
                        onUnfriend: () => controller.unfriend(friend),
                      );
                    },
                  );
                }),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: OutlinedButton(
                    onPressed: controller.openRequests,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: muted,
                      side: BorderSide(color: border),
                      backgroundColor:
                          isDark ? const Color(0xFF16181B) : Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text(
                      'View requests',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
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
  }
}
