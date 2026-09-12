import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_match/features/flex_wallet/controller/flex_gas_voucher_controller.dart';


class GasVoucherPaymentView extends StatelessWidget {
  const GasVoucherPaymentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // কন্ট্রোলার ইনিশিয়ালাইজ
    final controller = Get.put(GasVoucherCheckoutController());

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF111827)),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Checkout',
          style: TextStyle(
            color: Color(0xFF111827),
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // অর্ডার সামারি কার্ড
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
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
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.8,
                              color: Color(0xFF9CA3AF),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Obx(() => Text(
                                    '\$${controller.voucherAmount.value.toStringAsFixed(2)} Electric & Gas Voucher',
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF111827),
                                    ),
                                  )),
                              Obx(() => Text(
                                    '\$${controller.voucherAmount.value.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w800,
                                      color: Color(0xFF111827),
                                    ),
                                  )),
                            ],
                          ),
                          const SizedBox(height: 8),
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
                              const Text(
                                'Total to Pay',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF111827),
                                ),
                              ),
                              Obx(() => Text(
                                    '\$${controller.voucherAmount.value.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w900,
                                      color: Color(0xFF15803D),
                                    ),
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // পেমেন্ট মেথড সেকশন
                    const Text(
                      'PAYMENT METHOD',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.8,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // মেথড অপশনস
                    _buildPaymentOption(
                      controller,
                      index: 0,
                      icon: Icons.apple,
                      title: 'Apple Pay / Google Pay',
                      subtitle: 'Fast & Instant checkout',
                    ),
                    const SizedBox(height: 10),
                    _buildPaymentOption(
                      controller,
                      index: 1,
                      icon: Icons.credit_card_rounded,
                      title: 'Credit / Debit Card',
                      subtitle: '•••• 4242 (Visa)',
                    ),
                    const SizedBox(height: 10),
                    _buildPaymentOption(
                      controller,
                      index: 2,
                      icon: Icons.account_balance_wallet_outlined,
                      title: 'RideMatch Balance',
                      subtitle: 'Instant debit from in-app credits',
                    ),
                  ],
                ),
              ),
            ),

            // নিচের পে নাও বাটন
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: Color(0xFFF3F4F6))),
              ),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: Obx(
                  () => ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : () => controller.confirmPayment(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00E63D),
                      foregroundColor: Colors.black,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: controller.isLoading.value
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              color: Colors.black,
                            ),
                          )
                        : Obx(() => Text(
                              'Pay \$${controller.voucherAmount.value.toStringAsFixed(2)} Now',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentOption(
    GasVoucherCheckoutController controller, {
    required int index,
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Obx(() {
      final isSelected = controller.selectedPaymentMethod.value == index;
      return GestureDetector(
        onTap: () => controller.selectPaymentMethod(index),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isSelected ? const Color(0xFF00E63D) : const Color(0xFFE5E7EB),
              width: isSelected ? 1.8 : 1.0,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFFDCFCE7) : const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  color: isSelected ? const Color(0xFF15803D) : const Color(0xFF4B5563),
                  size: 22,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF111827),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
                    ),
                  ],
                ),
              ),
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? const Color(0xFF00E63D) : const Color(0xFFD1D5DB),
                    width: 2,
                  ),
                  color: isSelected ? const Color(0xFF00E63D) : Colors.transparent,
                ),
                child: isSelected
                    ? const Icon(Icons.check, size: 12, color: Colors.black)
                    : null,
              ),
            ],
          ),
        ),
      );
    });
  }
}