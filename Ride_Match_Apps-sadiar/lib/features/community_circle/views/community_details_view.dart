import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../controllers/community_details_controller.dart';
import '../models/community_circle_model.dart';
import '../widgets/community_details_widgets.dart';
import '../widgets/community_top_bar.dart';

class CommunityDetailsView extends GetView<CommunityDetailsController> {
  const CommunityDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CommunityDetailsController>();
    final isDark = controller.isDark;
    final scaffold = isDark ? const Color(0xFF0D0F11) : const Color(0xFFF7F7F5);
    final titleColor = isDark ? Colors.white : const Color(0xFF111827);
    final bodyColor =
        isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280);

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
                  title: 'Community Details',
                  onBack: controller.goBack,
                  onNotificationTap: controller.openNotifications,
                  onMenuTap: controller.openMenu,
                  isDark: isDark,
                ),
              ),
              Expanded(
                child: Obx(() {
                  final circle = controller.circle.value;
                  if (circle == null) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return ListView(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                    children: [
                      Text(
                        circle.name,
                        style: TextStyle(
                          color: titleColor,
                          fontSize: 26,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: CommunityStatCard(
                              label: 'Total Circles',
                              value: circle.membersLabel,
                              isDark: isDark,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: CommunityStatCard(
                              label: 'Active Now',
                              value: circle.activeTodayLabel,
                              valueColor: isDark
                                  ? AppColors.button
                                  : const Color(0xFF15803D),
                              isDark: isDark,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 22),
                      Text(
                        'About this Circle',
                        style: TextStyle(
                          color: titleColor,
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        circle.about,
                        style: TextStyle(
                          color: bodyColor,
                          fontSize: 14.5,
                          height: 1.45,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 22),
                      Text(
                        'Members',
                        style: TextStyle(
                          color: titleColor,
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ..._memberRows(circle.members, isDark),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        height: 54,
                        child: ElevatedButton(
                          onPressed: controller.toggleJoin,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.button,
                            foregroundColor: AppColors.buttonForeground,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Text(
                            circle.isJoined ? 'Joined' : 'Join Circle',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _memberRows(
    List<CommunityCircleMember> members,
    bool isDark,
  ) {
    final widgets = <Widget>[];
    for (var i = 0; i < members.length; i += 2) {
      final left = members[i];
      final right = i + 1 < members.length ? members[i + 1] : null;
      widgets.add(
        Padding(
          padding: EdgeInsets.only(bottom: i + 2 < members.length ? 12 : 0),
          child: Row(
            children: [
              Expanded(
                child: CommunityMemberCard(member: left, isDark: isDark),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: right == null
                    ? const SizedBox.shrink()
                    : CommunityMemberCard(member: right, isDark: isDark),
              ),
            ],
          ),
        ),
      );
    }
    return widgets;
  }
}
