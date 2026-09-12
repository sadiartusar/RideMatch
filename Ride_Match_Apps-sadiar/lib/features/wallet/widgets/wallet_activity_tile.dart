import 'package:flutter/material.dart';

import '../models/wallet_model.dart';

class WalletActivityTile extends StatelessWidget {
  const WalletActivityTile({
    super.key,
    required this.item,
    this.isDark = true,
  });

  final WalletActivityItem item;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    const greenAccent = Color(0xFF32E116);
    const cardBg = Color(0xFF16181B);
    const borderCol = Color(0xFF262B32);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderCol),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          // Left green accent border line
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            width: 3.5,
            child: Container(
              color: greenAccent,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                // Checkmark icon in dark circle
                Container(
                  width: 34,
                  height: 34,
                  decoration: const BoxDecoration(
                    color: Color(0xFF101215),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.check_circle_outline_rounded,
                    color: Color(0xFF9CA3AF),
                    size: 18,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13.5,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        item.dateTimeLabel,
                        style: const TextStyle(
                          color: Color(0xFF9CA3AF),
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  item.amountLabel,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14.5,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
