import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../main_nav/widgets/app_mode_bottom_nav.dart';
import '../controllers/redeem_history_controller.dart';
import '../models/redemption_history_model.dart';

class RedeemHistoryView extends GetView<RedeemHistoryController> {
  const RedeemHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    const greenAccent = Color(0xFF32E116);
    const redAccent = Color(0xFFEF4444);
    const bgDark = Color(0xFF0F1114);
    const cardBg = Color(0xFF16181B);
    const borderCol = Color(0xFF262B32);

    return Scaffold(
      backgroundColor: bgDark,
      appBar: AppBar(
        backgroundColor: bgDark,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.white, size: 22),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Redeem History',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: false,
        titleSpacing: 0,
        actions: [
          // Notification Bell
          Container(
            width: 38,
            height: 38,
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: cardBg,
              shape: BoxShape.circle,
              border: Border.all(color: borderCol),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.notifications_none_rounded, color: Colors.white, size: 19),
                  onPressed: controller.openNotifications,
                ),
                Positioned(
                  top: 8,
                  right: 9,
                  child: Container(
                    width: 7,
                    height: 7,
                    decoration: const BoxDecoration(
                      color: redAccent,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Hamburger Menu
          Container(
            width: 38,
            height: 38,
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              color: cardBg,
              shape: BoxShape.circle,
              border: Border.all(color: borderCol),
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: const Icon(Icons.menu_rounded, color: Colors.white, size: 19),
              onPressed: controller.openMenu,
            ),
          ),
        ],
      ),
      bottomNavigationBar: Obx(
        () => AppModeBottomNav(
          selectedIndex: controller.selectedNavIndex.value,
          onTap: controller.onNavTap,
          isDark: true,
        ),
      ),
      body: Obx(() {
        final items = controller.filteredItems;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            // Filter Chips Bar
            Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: controller.categories.length,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final cat = controller.categories[index];
                  final isSelected = controller.selectedFilter.value == cat;
                  return InkWell(
                    onTap: () => controller.setFilter(cat),
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? greenAccent : cardBg,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected ? greenAccent : borderCol,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        cat,
                        style: TextStyle(
                          color: isSelected ? Colors.black : const Color(0xFFD1D5DB),
                          fontSize: 13,
                          fontWeight: isSelected ? FontWeight.w900 : FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),

            // History List
            Expanded(
              child: items.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.receipt_long_outlined,
                            size: 56,
                            color: const Color(0xFF6B7280).withValues(alpha: 0.5),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'No redemption history found',
                            style: TextStyle(
                              color: Color(0xFF9CA3AF),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      physics: const BouncingScrollPhysics(),
                      itemCount: items.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return _buildHistoryCard(item);
                      },
                    ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildHistoryCard(RedemptionHistoryModel item) {
    const greenAccent = Color(0xFF32E116);
    const cardBg = Color(0xFF16181B);
    const borderCol = Color(0xFF262B32);

    final isCompleted = item.status == 'COMPLETED';
    final isPending = item.status == 'PENDING';

    final badgeBg = isCompleted
        ? const Color(0xFF112316)
        : (isPending ? const Color(0xFF2A2012) : const Color(0xFF1C2025));

    final badgeTextCol = isCompleted
        ? greenAccent
        : (isPending ? const Color(0xFFF59E0B) : const Color(0xFF6B7280));

    final badgeBorderCol = isCompleted
        ? const Color(0xFF1E4826)
        : (isPending ? const Color(0xFF4A3414) : const Color(0xFF2A3038));

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: borderCol),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left Icon Container
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: const Color(0xFF1D2228),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFF2B323B)),
                ),
                child: Center(
                  child: _buildItemIcon(item.iconType),
                ),
              ),
              const SizedBox(width: 12),

              // Title & Subtitle
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14.5,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      item.displaySubtitle,
                      style: const TextStyle(
                        color: Color(0xFF9CA3AF),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),

              // Value & Status Badge
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    item.valueLabel,
                    style: TextStyle(
                      color: item.valueLabel == 'Free' ? const Color(0xFFD1D5DB) : greenAccent,
                      fontSize: 13.5,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2.5),
                    decoration: BoxDecoration(
                      color: badgeBg,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: badgeBorderCol),
                    ),
                    child: Text(
                      item.status,
                      style: TextStyle(
                        color: badgeTextCol,
                        fontSize: 9,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.4,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Date / Time and optional arrow
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.calendar_today_outlined, color: Color(0xFF6B7280), size: 13),
                  const SizedBox(width: 6),
                  Text(
                    item.dateTimeLabel,
                    style: const TextStyle(
                      color: Color(0xFF6B7280),
                      fontSize: 11.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              if (item.hasDetails)
                const Icon(
                  Icons.chevron_right_rounded,
                  color: Color(0xFF9CA3AF),
                  size: 18,
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildItemIcon(String iconType) {
    switch (iconType) {
      case 'wind':
        return const Icon(Icons.air_rounded, color: Colors.white, size: 22);
      case 'coffee':
        return const Icon(Icons.coffee_rounded, color: Colors.white, size: 22);
      case 'parking':
        return const Text(
          'P',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w900,
          ),
        );
      case 'wash':
        return const Icon(Icons.local_car_wash_rounded, color: Colors.white, size: 22);
      default:
        return const Icon(Icons.local_gas_station_rounded, color: Colors.white, size: 22);
    }
  }
}
