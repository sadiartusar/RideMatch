import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_match/features/flex_wallet/controller/flex_wallet_controller.dart';


class EscrowCard extends GetView<FlexWalletController> {
  const EscrowCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFE5E7EB), width: 0.8),
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
            InkWell(
              onTap: controller.toggleEscrow,
              child: Row(
                children: [
                  const Icon(Icons.lock_outline, size: 16, color: Color(0xFF6B7280)),
                  const SizedBox(width: 8),
                  const Text(
                    'LOCKED IN ESCROW',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.8,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    controller.isEscrowExpanded.value ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                    size: 20,
                    color: const Color(0xFF00C836),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              controller.escrowRideId.value,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Color(0xFF9CA3AF),
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              '${controller.escrowCoupons.value} Coupons',
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E2022),
              ),
            ),
            if (controller.isEscrowExpanded.value) ...[
              const SizedBox(height: 12),
              const Divider(height: 1, color: Color(0xFFF3F4F6)),
              const SizedBox(height: 10),
              const Text(
                'Coupons are held securely during trip and automatically released once driver finishes route.',
                style: TextStyle(
                  fontSize: 11,
                  color: Color(0xFF6B7280),
                  height: 1.4,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}