import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/chat_list_controller.dart';
import 'chat_list_top_bar.dart';
import 'chat_search_field.dart';
import 'chat_thread_tile.dart';

/// Chat inbox content for the home shell (shared bottom nav).
class ChatListBody extends StatelessWidget {
  const ChatListBody({super.key});

  ChatListController get _controller {
    if (Get.isRegistered<ChatListController>()) {
      return Get.find<ChatListController>();
    }
    return Get.put(ChatListController());
  }

  @override
  Widget build(BuildContext context) {
    final controller = _controller;
    final isDark = controller.isDark;
    final scaffold = isDark ? const Color(0xFF0D0F11) : Colors.white;

    return ColoredBox(
      color: scaffold,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 16, 8),
            child: ChatListTopBar(
              onBack: controller.goBack,
              onNotificationTap: controller.openNotifications,
              onMenuTap: controller.openMenu,
              isDark: isDark,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
            child: ChatSearchField(
              controller: controller.searchController,
              isDark: isDark,
            ),
          ),
          Expanded(
            child: Obx(() {
              final items = controller.filteredThreads;
              if (items.isEmpty) {
                return Center(
                  child: Text(
                    'No conversations found',
                    style: TextStyle(
                      color: isDark
                          ? const Color(0xFF9CA3AF)
                          : const Color(0xFF6B7280),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final thread = items[index];
                  return ChatThreadTile(
                    thread: thread,
                    isDark: isDark,
                    onTap: () => controller.openThread(thread),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
