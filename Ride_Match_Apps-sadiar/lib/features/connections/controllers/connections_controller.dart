import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/routes/app_routes.dart';
import '../../drawer/controllers/app_drawer_controller.dart';
import '../../drawer/models/drawer_nav_item.dart';
import '../../main_nav/mode_theme.dart';
import '../models/connection_models.dart';

class ConnectionsController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  final RxString searchQuery = ''.obs;
  final RxList<ConnectionFriend> friends =
      RxList<ConnectionFriend>(ConnectionFriend.demos);

  bool get isDark => ModeTheme.isDark;

  @override
  void onInit() {
    super.onInit();
    searchController.addListener(() {
      searchQuery.value = searchController.text.trim();
    });
  }

  List<ConnectionFriend> get filteredFriends {
    final query = searchQuery.value.toLowerCase();
    if (query.isEmpty) return friends.toList();
    return friends
        .where((f) => f.name.toLowerCase().contains(query))
        .toList();
  }

  void goBack() => Get.back();

  void openNotifications() {
    Get.toNamed(
      AppRoutes.notifications,
      arguments: {'isDark': isDark},
    );
  }

  void openMenu() {
    AppDrawerController.open(
      userName: 'Member',
      selectedId: DrawerNavId.connections,
      isDark: isDark,
      onOpenNotifications: openNotifications,
      onChangeMode: () => Get.toNamed(AppRoutes.chooseMode),
    );
  }

  void openChat(ConnectionFriend friend) {
    Get.toNamed(AppRoutes.chatDetails);
  }

  void openProfile(ConnectionFriend friend) {
    Get.snackbar(
      'Profile',
      "Opening ${friend.name}'s profile.",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF1F2937),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }

  void unfriend(ConnectionFriend friend) {
    friends.removeWhere((f) => f.id == friend.id);
    Get.snackbar(
      'Unfriended',
      'You unfriended ${friend.name}.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF1F2937),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }

  void openRequests() {
    Get.toNamed(AppRoutes.connectionRequests);
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
