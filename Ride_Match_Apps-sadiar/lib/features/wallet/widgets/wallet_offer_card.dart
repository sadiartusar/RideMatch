import 'package:flutter/material.dart';

import '../../../core/constants/app_assets.dart';
import '../models/wallet_model.dart';

class WalletOfferCard extends StatelessWidget {
  const WalletOfferCard({
    super.key,
    required this.offer,
    required this.onTap,
    this.isDark = true,
  });

  final WalletOfferItem offer;
  final VoidCallback onTap;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    const cardBg = Color(0xFF16181B);
    const borderCol = Color(0xFF262B32);
    final isFuel = offer.iconType == 'fuel';
    final imageAsset = isFuel ? AppAssets.fuelOffer : AppAssets.coffeeOffer;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        height: 145,
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: borderCol),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image banner
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: Image.asset(
                  imageAsset,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: const Color(0xFF101215),
                    child: Icon(
                      isFuel ? Icons.local_gas_station_rounded : Icons.coffee_rounded,
                      color: const Color(0xFF32E116),
                      size: 28,
                    ),
                  ),
                ),
              ),
            ),
            // Text Details
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    offer.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${offer.couponCost} Coupon',
                    style: const TextStyle(
                      color: Color(0xFF9CA3AF),
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
