import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/routes/app_routes.dart';
import '../../drawer/controllers/app_drawer_controller.dart';
import '../../drawer/models/drawer_nav_item.dart';
import '../../main_nav/main_tab_nav.dart';
import '../../main_nav/mode_theme.dart';
import '../../onboarding/services/mode_service.dart';
import '../models/chat_models.dart';

class ChatListController extends GetxController {
  ChatListController({this.isDarkMode});

  /// Optional override when ModeService is unavailable.
  final bool? isDarkMode;

  final TextEditingController searchController = TextEditingController();
  final RxString searchQuery = ''.obs;
  final RxList<ChatThreadModel> threads =
      RxList<ChatThreadModel>(ChatThreadModel.demos);

  /// Always follow the active mode theme (Driving = dark).
  bool get isDark {
    if (Get.isRegistered<ModeService>()) {
      return ModeTheme.isDark;
    }
    return isDarkMode == true;
  }

  @override
  void onInit() {
    super.onInit();
    searchController.addListener(() {
      searchQuery.value = searchController.text.trim();
    });
  }

  List<ChatThreadModel> get filteredThreads {
    final query = searchQuery.value.toLowerCase();
    if (query.isEmpty) return threads;
    return threads
        .where(
          (t) =>
              t.name.toLowerCase().contains(query) ||
              t.lastMessage.toLowerCase().contains(query),
        )
        .toList();
  }

  void goBack() {
    if (MainTabNav.hasHomeController) {
      MainTabNav.showHome();
      return;
    }
    Get.back();
  }

  void openNotifications() {
    Get.toNamed(
      AppRoutes.notifications,
      arguments: {'isDark': isDark},
    );
  }

  void openMenu() {
    AppDrawerController.open(
      userName: 'Chat',
      selectedId: DrawerNavId.home,
      isDark: isDark,
      onOpenNotifications: openNotifications,
      onChangeMode: () => Get.toNamed(AppRoutes.chooseMode),
    );
  }

  void openThread(ChatThreadModel thread) {
    Get.toNamed(
      AppRoutes.chatDetails,
      arguments: {
        'thread': thread,
        'isDark': isDark,
      },
    );
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
