import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/routes/app_routes.dart';
import '../../drawer/controllers/app_drawer_controller.dart';
import '../../drawer/models/drawer_nav_item.dart';
import '../../main_nav/mode_theme.dart';
import '../models/community_circle_model.dart';

class CommunityCirclesController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  final RxString searchQuery = ''.obs;
  final RxList<CommunityCircleModel> circles =
      RxList<CommunityCircleModel>(CommunityCircleModel.demos);

  bool get isDark => ModeTheme.isDark;

  @override
  void onInit() {
    super.onInit();
    searchController.addListener(() {
      searchQuery.value = searchController.text.trim();
    });
  }

  List<CommunityCircleModel> get filteredCircles {
    final query = searchQuery.value.toLowerCase();
    if (query.isEmpty) return circles.toList();
    return circles
        .where((c) => c.name.toLowerCase().contains(query))
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
      selectedId: DrawerNavId.communityCircles,
      isDark: isDark,
      onOpenNotifications: openNotifications,
      onChangeMode: () => Get.toNamed(AppRoutes.chooseMode),
    );
  }

  void toggleJoin(CommunityCircleModel circle) {
    final index = circles.indexWhere((c) => c.id == circle.id);
    if (index == -1) return;
    final next = !circles[index].isJoined;
    circles[index] = circles[index].copyWith(isJoined: next);
    Get.snackbar(
      next ? 'Joined' : 'Left Circle',
      next ? 'You joined ${circle.name}.' : 'You left ${circle.name}.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF1F2937),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }

  void openDetails(CommunityCircleModel circle) {
    Get.toNamed(
      AppRoutes.communityDetails,
      arguments: {'circleId': circle.id},
    );
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
