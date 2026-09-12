import 'package:flutter/material.dart';

import '../models/driver_trust_item_model.dart';

class DriverTrustSetupCard extends StatelessWidget {
  const DriverTrustSetupCard({
    super.key,
    required this.percentage,
    required this.items,
    required this.onItemTap,
  });

  final int percentage;
  final List<DriverTrustItemModel> items;
  final ValueChanged<DriverTrustItemModel> onItemTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: const Color(0xFF171A1D),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF262B32),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Text(
                  'Driver Trust Setup',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.2,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF103314),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  '$percentage% READY',
                  style: const TextStyle(
                    color: Color(0xFF32E116),
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: SizedBox(
              height: 4,
              child: LinearProgressIndicator(
                value: (percentage / 100).clamp(0.0, 1.0),
                backgroundColor: const Color(0xFF2C3138),
                valueColor:
                    const AlwaysStoppedAnimation<Color>(Color(0xFF32E116)),
              ),
            ),
          ),
          const SizedBox(height: 18),
          // 2-column checklist chips
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: items.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 3.2,
            ),
            itemBuilder: (context, index) {
              final item = items[index];
              return _TrustChip(
                item: item,
                onTap: () => onItemTap(item),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _TrustChip extends StatelessWidget {
  const _TrustChip({
    required this.item,
    required this.onTap,
  });

  final DriverTrustItemModel item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isDone = item.isCompleted;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: isDone ? const Color(0xFF0F3214) : const Color(0xFF1A1D21),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isDone ? const Color(0xFF1B5924) : const Color(0xFF282C33),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              isDone ? Icons.check_circle_rounded : _iconForPending(item.id),
              color: isDone
                  ? const Color(0xFF32E116)
                  : const Color(0xFF9CA3AF),
              size: 18,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                item.label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: isDone
                      ? const Color(0xFF32E116)
                      : const Color(0xFF9CA3AF),
                  fontSize: 13,
                  fontWeight: isDone ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _iconForPending(String id) {
    if (id == 'license') {
      return Icons.radio_button_unchecked_rounded;
    }
    return Icons.more_horiz_rounded;
  }
}
