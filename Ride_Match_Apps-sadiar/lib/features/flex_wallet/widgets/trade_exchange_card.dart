import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_match/features/flex_wallet/controller/flex_wallet_controller.dart';


class TradeExchangeCard extends GetView<FlexWalletController> {
  const TradeExchangeCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(20),
        image: const DecorationImage(
          image: NetworkImage(
            'https://images.unsplash.com/photo-1512941937669-90a1b58e7e9c?auto=format&fit=crop&w=800&q=80',
          ),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Color(0xCC0F172A),
            BlendMode.darken,
          ),
        ),
      ),
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Trade & Exchange',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Convert rewards into ride credits instantly',
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFFCBD5E1),
            ),
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: controller.onOpenMarketplace,
            child:const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Open Marketplace',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 6),
                Icon(
                  Icons.arrow_forward,
                  size: 14,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}