import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_match/core/routes/app_routes.dart';
import 'package:ride_match/features/flex_wallet/controller/flex_wallet_controller.dart';

class GasVouchersCard extends GetView<FlexWalletController> {
  const GasVouchersCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with fuel icon
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: const Color(0xFFDCFCE7),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.local_gas_station_rounded,
                  size: 18,
                  color: Color(0xFF15803D),
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                'Gas Vouchers',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E2022),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Boost your ride requests with extra gas incentives for drivers.',
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFF6B7280),
              height: 1.3,
            ),
          ),
          const SizedBox(height: 12),

          // 3-Metric Bar
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFF9FAFB),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFF3F4F6)),
            ),
            child: Row(
              children: [
                _buildStatItem('AVAILABLE', controller.gasAvailable),
                _buildDivider(),
                _buildStatItem('OFFERED', controller.gasOffered),
                _buildDivider(),
                _buildStatItem('USED', controller.gasUsed),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // Amount Selector Grid (2 rows of 5)
          Obx(
            () => GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.voucherAmounts.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 1.4,
              ),
              itemBuilder: (context, index) {
                final amt = controller.voucherAmounts[index];
                final isSelected =
                    controller.selectedVoucherAmount.value == amt;
                return GestureDetector(
                  onTap: () => controller.selectVoucherAmount(amt),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFFDCFCE7)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xFF00E63D)
                            : const Color(0xFFE5E7EB),
                        width: isSelected ? 1.8 : 1,
                      ),
                    ),
                    child: Text(
                      '\$$amt',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: isSelected
                            ? const Color(0xFF065F46)
                            : const Color(0xFF374151),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),

          // Buy Voucher Dark Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              // onPressed: controller.onBuyGasVoucher,
            onPressed: controller.goToPayment,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E2022),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Buy Electric & Gas Voucher',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Disclaimer Footnote
          const Center(
            child: Text(
              '*100% of this goes to drivers to cover travel adjustments.*',
              style: TextStyle(
                fontSize: 10,
                color: Color(0xFF9CA3AF),
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, RxInt value) {
    return Expanded(
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.bold,
              color: Color(0xFF9CA3AF),
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 2),
          Obx(
            () => Text(
              '\$${value.value}',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: Color(0xFF1E2022),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(width: 1, height: 24, color: const Color(0xFFE5E7EB));
  }
}
