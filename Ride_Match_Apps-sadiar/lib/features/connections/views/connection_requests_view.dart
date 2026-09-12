import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../community_circle/widgets/community_top_bar.dart';
import '../controllers/connection_requests_controller.dart';
import '../widgets/connection_request_cards.dart';

class ConnectionRequestsView extends GetView<ConnectionRequestsController> {
  const ConnectionRequestsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ConnectionRequestsController>();
    final isDark = controller.isDark;
    final scaffold = isDark ? const Color(0xFF0D0F11) : const Color(0xFFF7F7F5);
    final muted = isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280);
    final tabTrack =
        isDark ? const Color(0xFF1B1E23) : const Color(0xFFF3F4F6);

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
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                child: Obx(() {
                  final tab = controller.selectedTab.value;
                  return Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: tabTrack,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: _TabChip(
                            label: 'Incoming',
                            selected: tab == ConnectionRequestTab.incoming,
                            onTap: () => controller
                                .selectTab(ConnectionRequestTab.incoming),
                            isDark: isDark,
                          ),
                        ),
                        Expanded(
                          child: _TabChip(
                            label: 'Outgoing',
                            selected: tab == ConnectionRequestTab.outgoing,
                            onTap: () => controller
                                .selectTab(ConnectionRequestTab.outgoing),
                            isDark: isDark,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
              Expanded(
                child: Obx(() {
                  final tab = controller.selectedTab.value;
                  if (tab == ConnectionRequestTab.incoming) {
                    return _IncomingBody(
                      controller: controller,
                      isDark: isDark,
                      muted: muted,
                    );
                  }
                  return _OutgoingBody(
                    controller: controller,
                    isDark: isDark,
                    muted: muted,
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

class _TabChip extends StatelessWidget {
  const _TabChip({
    required this.label,
    required this.selected,
    required this.onTap,
    required this.isDark,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? AppColors.button : Colors.transparent,
      borderRadius: BorderRadius.circular(11),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(11),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: selected
                  ? AppColors.buttonForeground
                  : (isDark
                      ? const Color(0xFF9CA3AF)
                      : const Color(0xFF6B7280)),
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}

class _IncomingBody extends StatelessWidget {
  const _IncomingBody({
    required this.controller,
    required this.isDark,
    required this.muted,
  });

  final ConnectionRequestsController controller;
  final bool isDark;
  final Color muted;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final items = controller.incoming.toList();
      return ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: isDark
                    ? const Color(0xFF1B1E23)
                    : const Color(0xFFE5E7EB),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '${controller.incomingCount} Requests',
                style: TextStyle(
                  color: muted,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          if (items.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 48),
              child: Center(
                child: Text(
                  'No incoming requests',
                  style: TextStyle(
                    color: muted,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            )
          else
            for (var i = 0; i < items.length; i++) ...[
              if (i > 0) const SizedBox(height: 12),
              IncomingRequestCard(
                request: items[i],
                isDark: isDark,
                onAccept: () => controller.acceptIncoming(items[i]),
                onIgnore: () => controller.ignoreIncoming(items[i]),
              ),
            ],
        ],
      );
    });
  }
}

class _OutgoingBody extends StatelessWidget {
  const _OutgoingBody({
    required this.controller,
    required this.isDark,
    required this.muted,
  });

  final ConnectionRequestsController controller;
  final bool isDark;
  final Color muted;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final chips = controller.outgoingFilterChips;
      final selected = controller.outgoingFilter.value;
      final items = controller.filteredOutgoing;

      return Column(
        children: [
          const SizedBox(height: 12),
          SizedBox(
            height: 36,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: chips.length,
              separatorBuilder: (_, _) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final chip = chips[index];
                final active = chip.status == null
                    ? selected == null
                    : selected == chip.status;
                return GestureDetector(
                  onTap: () {
                    if (chip.status == null) {
                      controller.setOutgoingFilter(null);
                    } else {
                      controller.setOutgoingFilter(chip.status);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: active
                          ? (isDark
                              ? const Color(0xFF2C333A)
                              : const Color(0xFFE5E7EB))
                          : (isDark
                              ? const Color(0xFF1B1E23)
                              : const Color(0xFFF3F4F6)),
                      borderRadius: BorderRadius.circular(20),
                      border: active
                          ? Border.all(
                              color: isDark
                                  ? AppColors.button
                                  : const Color(0xFFD1D5DB),
                            )
                          : null,
                    ),
                    child: Text(
                      chip.label,
                      style: TextStyle(
                        color: isDark
                            ? Colors.white
                            : const Color(0xFF374151),
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: items.isEmpty
                ? Center(
                    child: Text(
                      'No outgoing requests',
                      style: TextStyle(
                        color: muted,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                    itemCount: items.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final request = items[index];
                      return OutgoingRequestCard(
                        request: request,
                        isDark: isDark,
                        onCancel: () => controller.cancelOutgoing(request),
                        onMessage: () => controller.messageOutgoing(request),
                        onResend: () => controller.resendOutgoing(request),
                      );
                    },
                  ),
          ),
        ],
      );
    });
  }
}
