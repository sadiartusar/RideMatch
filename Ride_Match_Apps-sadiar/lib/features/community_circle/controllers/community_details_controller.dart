import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/routes/app_routes.dart';
import '../../drawer/controllers/app_drawer_controller.dart';
import '../../drawer/models/drawer_nav_item.dart';
import '../../main_nav/mode_theme.dart';
import '../controllers/community_circles_controller.dart';
import '../models/community_circle_model.dart';

class CommunityDetailsController extends GetxController {
  late final String circleId;
  final Rxn<CommunityCircleModel> circle = Rxn<CommunityCircleModel>();

  bool get isDark => ModeTheme.isDark;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args is Map && args['circleId'] is String) {
      circleId = args['circleId'] as String;
    } else if (args is String) {
      circleId = args;
    } else {
      circleId = CommunityCircleModel.demos.first.id;
    }
    _loadCircle();
  }

  void _loadCircle() {
    if (Get.isRegistered<CommunityCirclesController>()) {
      final list = Get.find<CommunityCirclesController>().circles;
      circle.value = list.firstWhere(
        (c) => c.id == circleId,
        orElse: () => CommunityCircleModel.demos.first,
      );
      return;
    }
    circle.value = CommunityCircleModel.demos.firstWhere(
      (c) => c.id == circleId,
      orElse: () => CommunityCircleModel.demos.first,
    );
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

  void toggleJoin() {
    final current = circle.value;
    if (current == null) return;
    final next = !current.isJoined;
    circle.value = current.copyWith(isJoined: next);

    if (Get.isRegistered<CommunityCirclesController>()) {
      final listController = Get.find<CommunityCirclesController>();
      final index =
          listController.circles.indexWhere((c) => c.id == current.id);
      if (index != -1) {
        listController.circles[index] =
            listController.circles[index].copyWith(isJoined: next);
      }
    }

    Get.snackbar(
      next ? 'Joined' : 'Left Circle',
      next ? 'You joined ${current.name}.' : 'You left ${current.name}.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF1F2937),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }
}
