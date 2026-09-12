import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_match/features/flex_wallet/controller/flex_wallet_controller.dart';
import 'package:ride_match/features/flex_wallet/views/missions_view.dart';
import 'package:ride_match/features/flex_wallet/widgets/active_missions_card.dart';
import 'package:ride_match/features/flex_wallet/widgets/coupon_summary_card.dart';
import 'package:ride_match/features/flex_wallet/widgets/earned_wallet_card.dart';
import 'package:ride_match/features/flex_wallet/widgets/escrow_card.dart';
import 'package:ride_match/features/flex_wallet/widgets/gas_vouchers_card.dart';
import 'package:ride_match/features/flex_wallet/widgets/recent_activity_section.dart';
import 'package:ride_match/features/flex_wallet/widgets/trade_exchange_card.dart';
import 'package:ride_match/features/flex_wallet/widgets/travel_wallet_card.dart';
import 'package:ride_match/features/main_nav/main_tab_nav.dart';

class FlexWalletView extends GetView<FlexWalletController> {
  const FlexWalletView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 🔥 Obx দিয়ে বর্তমান স্টেপ অনুযায়ী স্ক্রিন সুইপ করবে
    return Obx(() {
      switch (controller.currentStep.value) {
        case FlexWalletStep.payment:
          return _buildPaymentStep(context);
        case FlexWalletStep.success:
          return _buildSuccessStep(context);

        case FlexWalletStep.missions: // 👈 এখানে MissionsView লোড হবে
        return const MissionsView();
        case FlexWalletStep.main:
        default:
          return _buildMainWalletStep(context);
      }
    });
  }

  // ==========================================================
  // ১. মূল ওয়ালেট স্ক্রিন
  // ==========================================================
  Widget _buildMainWalletStep(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F8FA),
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1E2022)),
          onPressed: () => MainTabNav.showHome(),
        ),
        title: const Text(
          'Wallet',
          style: TextStyle(
            color: Color(0xFF1E2022),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(color: Colors.grey.shade200, shape: BoxShape.circle),
            child: Stack(
              children: [
                IconButton(
                  icon: const Icon(Icons.notifications_none, color: Color(0xFF333333), size: 22),
                  onPressed: () => Get.snackbar('Notifications', 'No new alerts'),
                ),
                Positioned(
                  right: 12,
                  top: 12,
                  child: Container(
                    width: 7,
                    height: 7,
                    decoration: const BoxDecoration(color: Colors.redAccent, shape: BoxShape.circle),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(color: Colors.grey.shade200, shape: BoxShape.circle),
            child: IconButton(
              icon: const Icon(Icons.menu, color: Color(0xFF333333), size: 22),
              onPressed: () => Get.snackbar('Menu', 'Wallet Settings'),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CouponSummaryCard(),
              const SizedBox(height: 16),
              const TravelWalletCard(),
              const SizedBox(height: 16),
              const EarnedWalletCard(),
              const SizedBox(height: 16),
              const GasVouchersCard(),
              const SizedBox(height: 20),
              const ActiveMissionsCard(),
              const SizedBox(height: 16),
              const RecentActivitySection(),
              const SizedBox(height: 16),
              const EscrowCard(),
              const SizedBox(height: 16),
              const TradeExchangeCard(),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.onEarnMoreCoupons,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00E63D),
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: const Text(
                    'Earn More Coupons',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // ২. ট্রানজাকশন / পেমেন্ট স্ক্রিন (selectedTxAmount ব্যবহার করা হয়েছে)
  // ==========================================================
  Widget _buildPaymentStep(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF111827)),
          onPressed: controller.backToWallet, // ✅ controller.backToWallet
        ),
        title: const Text(
          'Checkout',
          style: TextStyle(color: Color(0xFF111827), fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // অর্ডার সামারি
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFE5E7EB)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'ORDER SUMMARY',
                            style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF9CA3AF)),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Obx(() => Text(
                                    '\$${controller.selectedTxAmount.value.toStringAsFixed(2)} Electric & Gas Voucher',
                                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                  )),
                              Obx(() => Text(
                                    '\$${controller.selectedTxAmount.value.toStringAsFixed(2)}',
                                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w900),
                                  )),
                            ],
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'Allocated to driver fuel compensation during matches',
                            style: TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 14),
                            child: Divider(height: 1, color: Color(0xFFF3F4F6)),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Total to Pay', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                              Obx(() => Text(
                                    '\$${controller.selectedTxAmount.value.toStringAsFixed(2)}',
                                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Color(0xFF00C836)),
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'PAYMENT METHOD',
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF6B7280)),
                    ),
                    const SizedBox(height: 12),
                    _buildPaymentTile(index: 0, icon: Icons.apple, title: 'Apple Pay / Google Pay', subtitle: 'Fast & Instant checkout'),
                    const SizedBox(height: 10),
                    _buildPaymentTile(index: 1, icon: Icons.credit_card, title: 'Credit / Debit Card', subtitle: '•••• 4242 (Visa)'),
                    const SizedBox(height: 10),
                    _buildPaymentTile(index: 2, icon: Icons.account_balance_wallet_outlined, title: 'RideMatch Balance', subtitle: 'Instant debit from credits'),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              color: Colors.white,
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: Obx(
                  () => ElevatedButton(
                    onPressed: controller.isProcessingPayment.value ? null : controller.confirmPayment,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00E63D),
                      foregroundColor: Colors.black,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    child: controller.isProcessingPayment.value
                        ? const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.black))
                        : Text(
                            'Pay \$${controller.selectedTxAmount.value.toStringAsFixed(2)} Now',
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // ৩. ট্রানজাকশন সাকসেস স্ক্রিন
  // ==========================================================
  Widget _buildSuccessStep(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF111827)),
          onPressed: controller.backToWallet, // ✅ controller.backToWallet
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              // গ্রিন টিক
              Container(
                width: 80,
                height: 80,
                decoration: const BoxDecoration(color: Color(0xFF00E63D), shape: BoxShape.circle),
                child: const Icon(Icons.check, color: Colors.white, size: 46),
              ),
              const SizedBox(height: 24),
              const Text(
                'Electric / Gas\nVoucher Ready!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Color(0xFF111827), height: 1.25),
              ),
              const SizedBox(height: 10),
              Obx(() => Text(
                    'Your \$${controller.selectedTxAmount.value.toStringAsFixed(2)} gas voucher has been\nadded to your Travel Wallet and is\nready to use.',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 13, color: Color(0xFF6B7280), height: 1.4),
                  )),
              const SizedBox(height: 32),
              // ভাউচার সামারি কার্ড
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                ),
                child: Column(
                  children: [
                    Obx(() => Text(
                          '\$${controller.selectedTxAmount.value.toStringAsFixed(2)} Electric & Gas Voucher',
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF111827)),
                        )),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('TRANSACTION ID:', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF9CA3AF))),
                        Obx(() => Text(controller.lastTxId.value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF374151)))),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Pro Tip বক্স
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0FDF4),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFBBF7D0)),
                ),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.lightbulb_outline, color: Color(0xFF15803D), size: 18),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Pro Tip: Drivers in your network prioritize ride requests with gas incentives during peak hours.',
                        style: TextStyle(fontSize: 11, color: Color(0xFF166534), height: 1.3),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              // View Wallet বাটন
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: controller.backToWallet, // ✅ controller.backToWallet
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00E63D),
                    foregroundColor: Colors.black,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  child: const Text('View Wallet', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentTile({required int index, required IconData icon, required String title, required String subtitle}) {
    return Obx(() {
      final isSelected = controller.selectedPaymentMethod.value == index;
      return GestureDetector(
        onTap: () => controller.selectPaymentMethod(index),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: isSelected ? const Color(0xFF00E63D) : const Color(0xFFE5E7EB), width: isSelected ? 1.8 : 1),
          ),
          child: Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFFDCFCE7) : const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: isSelected ? const Color(0xFF15803D) : const Color(0xFF4B5563), size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF111827))),
                    Text(subtitle, style: const TextStyle(fontSize: 11, color: Color(0xFF6B7280))),
                  ],
                ),
              ),
              Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: isSelected ? const Color(0xFF00E63D) : const Color(0xFFD1D5DB), width: 2),
                  color: isSelected ? const Color(0xFF00E63D) : Colors.transparent,
                ),
                child: isSelected ? const Icon(Icons.check, size: 12, color: Colors.black) : null,
              ),
            ],
          ),
        ),
      );
    });
  }
}