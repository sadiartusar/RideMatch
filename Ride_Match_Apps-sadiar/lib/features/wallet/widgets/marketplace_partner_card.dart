import 'package:flutter/material.dart';

import '../models/marketplace_coupon_model.dart';

class MarketplacePartnerCard extends StatelessWidget {
  const MarketplacePartnerCard({
    super.key,
    required this.partner,
    required this.onRedeem,
    this.isDark = true,
  });

  final MarketplacePartnerModel partner;
  final VoidCallback onRedeem;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    const cardBg = Color(0xFF16181B);
    const borderCol = Color(0xFF262B32);

    final isFuel = partner.category == 'Fuel';
    final isEV = partner.category == 'EV';

    return Container(
      height: 165,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: borderCol, width: 1),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // 1. Background Image or Gradient Fallback
          if (partner.imageAsset != null)
            Image.asset(
              partner.imageAsset!,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: isFuel
                        ? [const Color(0xFF241B08), const Color(0xFF0F151B)]
                        : (isEV
                            ? [const Color(0xFF0F2027), const Color(0xFF203A43)]
                            : [const Color(0xFF16251C), const Color(0xFF0F151B)]),
                  ),
                ),
                child: Center(
                  child: Icon(
                    isFuel ? Icons.local_gas_station_rounded : Icons.electric_car_rounded,
                    size: 56,
                    color: Colors.white24,
                  ),
                ),
              ),
            )
          else
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: isFuel
                      ? [const Color(0xFF241B08), const Color(0xFF0F151B)]
                      : [const Color(0xFF0F2027), const Color(0xFF203A43)],
                ),
              ),
            ),

          // 2. Dark Vignette / Gradient Overlay for Text Readability
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.15),
                    Colors.black.withValues(alpha: 0.4),
                    Colors.black.withValues(alpha: 0.85),
                  ],
                  stops: const [0.0, 0.45, 1.0],
                ),
              ),
            ),
          ),

          // 3. Bottom Text & REDEEM Button Overlay
          Positioned(
            left: 14,
            right: 14,
            bottom: 12,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        partner.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.2,
                          shadows: [
                            Shadow(
                              color: Colors.black87,
                              blurRadius: 6,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        partner.subtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Color(0xFFD1D5DB),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          shadows: [
                            Shadow(
                              color: Colors.black87,
                              blurRadius: 4,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                // Silver / Light-grey REDEEM button matching screenshot
                SizedBox(
                  width: 88,
                  height: 38,
                  child: ElevatedButton(
                    onPressed: onRedeem,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD1D5DB),
                      foregroundColor: const Color(0xFF111827),
                      elevation: 0,
                      minimumSize: Size.zero,
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'REDEEM',
                      style: TextStyle(
                        color: Color(0xFF111827),
                        fontSize: 12.5,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.5,
                      ),
                    ),
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
