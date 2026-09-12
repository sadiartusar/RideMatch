import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../models/reward_option.dart';

class VoucherAmountGrid extends StatelessWidget {
  const VoucherAmountGrid({
    super.key,
    required this.vouchers,
    required this.selectedDollars,
    required this.onSelect,
  });

  final List<VoucherAmount> vouchers;
  final int? selectedDollars;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'ELECTRIC & GAS VOUCHERS',
          style: TextStyle(
            color: Color(0xFF6B7280),
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFF111827),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            'OPTIONAL DRIVER INCENTIVES',
            style: TextStyle(
              color: AppColors.button,
              fontSize: 10.5,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.6,
            ),
          ),
        ),
        const SizedBox(height: 14),
        LayoutBuilder(
          builder: (context, constraints) {
            const spacing = 10.0;
            const columns = 5;
            final itemWidth =
                (constraints.maxWidth - spacing * (columns - 1)) / columns;

            return Wrap(
              spacing: spacing,
              runSpacing: spacing,
              children: vouchers.map((voucher) {
                final selected = selectedDollars == voucher.dollars;
                return SizedBox(
                  width: itemWidth,
                  height: 44,
                  child: Material(
                    color: selected
                        ? const Color(0xFFECFCE5)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    child: InkWell(
                      onTap: () => onSelect(voucher.dollars),
                      borderRadius: BorderRadius.circular(12),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 160),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: selected
                                ? AppColors.button
                                : const Color(0xFFE5E7EB),
                            width: selected ? 1.5 : 1,
                          ),
                        ),
                        child: Text(
                          voucher.label,
                          style: TextStyle(
                            color: const Color(0xFF111827),
                            fontSize: 14,
                            fontWeight:
                                selected ? FontWeight.w800 : FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
        const SizedBox(height: 12),
        const Text(
          'Note: A 20% processing fee applies to driver settlement amounts.',
          style: TextStyle(
            color: Color(0xFF9CA3AF),
            fontSize: 11.5,
            fontWeight: FontWeight.w500,
            height: 1.35,
          ),
        ),
      ],
    );
  }
}
