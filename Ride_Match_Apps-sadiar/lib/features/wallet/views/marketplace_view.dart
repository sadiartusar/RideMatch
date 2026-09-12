import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../main_nav/widgets/app_mode_bottom_nav.dart';
import '../controllers/marketplace_controller.dart';
import '../models/marketplace_coupon_model.dart';
import '../widgets/marketplace_partner_card.dart';

class MarketplaceView extends GetView<MarketplaceController> {
  const MarketplaceView({super.key});

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
          'Marketplace',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: false,
        titleSpacing: 0,
        actions: [
          // Notification Bell with Red Badge Dot in circular button
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
          // Hamburger Menu in circular button
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
        final partners = controller.filteredPartners;
        final expiring = controller.expiringDeals;

        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. YOUR COUPON WALLET CARD
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: cardBg,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: borderCol),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Your Coupon Wallet',
                      style: TextStyle(
                        color: Color(0xFF9CA3AF),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${controller.totalCoupons}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.5,
                            height: 1.0,
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 2),
                          child: Text(
                            'Coupon',
                            style: TextStyle(
                              color: Color(0xFF9CA3AF),
                              fontSize: 12.5,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // Sub-row: AVAILABLE 850 & EXPIRING 400 (Two independent cards side-by-side)
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                      decoration: BoxDecoration(
                        color: cardBg,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: borderCol),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'AVAILABLE',
                            style: TextStyle(
                              color: Color(0xFF9CA3AF),
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${controller.availableCoupons}',
                            style: const TextStyle(
                              color: greenAccent,
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                      decoration: BoxDecoration(
                        color: cardBg,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: borderCol),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'EXPIRING',
                            style: TextStyle(
                              color: Color(0xFF9CA3AF),
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${controller.expiringCoupons}',
                            style: const TextStyle(
                              color: redAccent,
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // 2. 4 Category Square Buttons (FUEL, PARKING, COFFEE, WASH)
              Row(
                children: [
                  _buildCategoryBtn(name: 'FUEL', icon: Icons.local_gas_station_outlined),
                  const SizedBox(width: 10),
                  _buildCategoryBtn(name: 'PARKING', icon: Icons.local_parking_rounded),
                  const SizedBox(width: 10),
                  _buildCategoryBtn(name: 'COFFEE', icon: Icons.coffee_rounded),
                  const SizedBox(width: 10),
                  _buildCategoryBtn(name: 'WASH', icon: Icons.local_car_wash_outlined),
                ],
              ),
              const SizedBox(height: 22),

              // 3. FEATURED PARTNERS Section Header
              const Text(
                'FEATURED PARTNERS',
                style: TextStyle(
                  color: Color(0xFF9CA3AF),
                  fontSize: 11.5,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.8,
                ),
              ),
              const SizedBox(height: 12),

              // Featured Partner Cards
              ...partners.map((partner) {
                return MarketplacePartnerCard(
                  partner: partner,
                  onRedeem: () => controller.openPartnerDetail(partner),
                );
              }),
              const SizedBox(height: 8),

              // 4. EXPIRING SOON Section Header
              const Text(
                'EXPIRING SOON',
                style: TextStyle(
                  color: Color(0xFF9CA3AF),
                  fontSize: 11.5,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.8,
                ),
              ),
              const SizedBox(height: 12),

              // Expiring items list
              ...expiring.map((deal) {
                return _buildExpiringDealTile(deal);
              }),

              const SizedBox(height: 24),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildCategoryBtn({required String name, required IconData icon}) {
    const cardBg = Color(0xFF16181B);
    const borderCol = Color(0xFF262B32);
    final isSelected = controller.selectedCategory.value.toUpperCase() == name.toUpperCase();

    return Expanded(
      child: InkWell(
        onTap: () => controller.selectCategory(name),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          height: 72,
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF1C221D) : cardBg,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected ? const Color(0xFF32E116) : borderCol,
              width: isSelected ? 1.5 : 1.0,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isSelected ? const Color(0xFF32E116) : const Color(0xFF9CA3AF),
                size: 22,
              ),
              const SizedBox(height: 6),
              Text(
                name,
                style: TextStyle(
                  color: isSelected ? Colors.white : const Color(0xFF9CA3AF),
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExpiringDealTile(MarketplacePartnerModel deal) {
    const cardBg = Color(0xFF16181B);
    const borderCol = Color(0xFF262B32);
    const redAccent = Color(0xFFEF4444);
    final isCoffee = deal.category == 'Coffee';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderCol),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          // Left red accent stripe
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            width: 4,
            child: Container(
              color: redAccent,
            ),
          ),
          // Content
          InkWell(
            onTap: () => controller.openPartnerDetail(deal),
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                children: [
                  // Icon
                  Icon(
                    isCoffee ? Icons.coffee_outlined : Icons.shopping_bag_outlined,
                    color: redAccent,
                    size: 22,
                  ),
                  const SizedBox(width: 14),
                  // Title & Subtitle
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          deal.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          deal.subtitle,
                          style: const TextStyle(
                            color: redAccent,
                            fontSize: 10.5,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Chevron
                  Container(
                    width: 24,
                    height: 24,
                    decoration: const BoxDecoration(
                      color: Color(0xFF0F1114),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.chevron_right_rounded,
                      color: Color(0xFF9CA3AF),
                      size: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
