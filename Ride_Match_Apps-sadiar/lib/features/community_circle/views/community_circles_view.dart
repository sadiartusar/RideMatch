import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../controllers/community_circles_controller.dart';
import '../widgets/community_circle_card.dart';
import '../widgets/community_search_field.dart';
import '../widgets/community_top_bar.dart';

class CommunityCirclesView extends GetView<CommunityCirclesController> {
  const CommunityCirclesView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CommunityCirclesController>();
    final isDark = controller.isDark;
    final scaffold = isDark ? const Color(0xFF0D0F11) : const Color(0xFFF7F7F5);

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
                  title: 'Community Circles',
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
                ),
              ),
              Expanded(
                child: Obx(() {
                  final items = controller.filteredCircles;
                  if (items.isEmpty) {
                    return Center(
                      child: Text(
                        'No circles found',
                        style: TextStyle(
                          color: isDark
                              ? const Color(0xFF9CA3AF)
                              : const Color(0xFF6B7280),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  }

                  return ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                    itemCount: items.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final circle = items[index];
                      return CommunityCircleCard(
                        circle: circle,
                        isDark: isDark,
                        onJoinTap: () => controller.toggleJoin(circle),
                        onViewDetails: () => controller.openDetails(circle),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
