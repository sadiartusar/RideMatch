import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../main_nav/widgets/app_mode_bottom_nav.dart';
import '../controllers/redeemed_success_controller.dart';

class RedeemedSuccessView extends GetView<RedeemedSuccessController> {
  const RedeemedSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    final item = controller.redemptionItem;
    const greenAccent = Color(0xFF32E116);
    const bgDark = Color(0xFF0F1114);
    const cardBg = Color(0xFF16181B);
    const borderCol = Color(0xFF262B32);

    return Scaffold(
      backgroundColor: bgDark,
      bottomNavigationBar: Obx(
        () => AppModeBottomNav(
          selectedIndex: controller.selectedNavIndex.value,
          onTap: controller.onNavTap,
          isDark: true,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 36),

              // 1. Glowing Green Concentric Checkmark Icon
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF122818),
                  boxShadow: [
                    BoxShadow(
                      color: greenAccent.withValues(alpha: 0.25),
                      blurRadius: 32,
                      spreadRadius: 8,
                    ),
                  ],
                ),
                child: Center(
                  child: Container(
                    width: 52,
                    height: 52,
                    decoration: const BoxDecoration(
                      color: greenAccent,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check_rounded,
                      color: Colors.black,
                      size: 32,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // 2. Headings
              const Text(
                'Redeemed Successfully',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Your voucher is ready for use at any ${item.merchant.split(' ').first} station.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF9CA3AF),
                  fontSize: 12.5,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 36),

              // 3. RECEIPT DETAILS Card
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
                      'RECEIPT DETAILS',
                      style: TextStyle(
                        color: Color(0xFF9CA3AF),
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.8,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildReceiptItem(label: 'Order ID', value: item.orderId),
                    const SizedBox(height: 14),
                    _buildReceiptItem(label: 'Date / Time', value: item.dateTimeLabel),
                    const SizedBox(height: 14),
                    _buildReceiptItem(label: 'Merchant', value: item.merchant),
                  ],
                ),
              ),
              const SizedBox(height: 36),

              // 4. View History Button (Primary glowing green)
              SizedBox(
                width: double.infinity,
                height: 52,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: greenAccent.withValues(alpha: 0.35),
                        blurRadius: 16,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: controller.goToHistory,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: greenAccent,
                      foregroundColor: Colors.black,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'View History',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // 5. BACK TO MARKETPLACE Button
              SizedBox(
                width: double.infinity,
                height: 44,
                child: TextButton(
                  onPressed: controller.backToMarketplace,
                  child: const Text(
                    'BACK TO MARKETPLACE',
                    style: TextStyle(
                      color: Color(0xFFD1D5DB),
                      fontSize: 12.5,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.8,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReceiptItem({required String label, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF9CA3AF),
            fontSize: 12.5,
            fontWeight: FontWeight.w500,
          ),
        ),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
