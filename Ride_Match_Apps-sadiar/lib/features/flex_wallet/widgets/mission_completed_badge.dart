import 'package:flutter/material.dart';

class MissionCompletedBadge extends StatelessWidget {
  final int couponsEarned;

  const MissionCompletedBadge({Key? key, required this.couponsEarned}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 250,
          height: 250,
          decoration: BoxDecoration(
            color: const Color(0xFFDCFCE7).withOpacity(0.8),
            borderRadius: BorderRadius.circular(48),
          ),
        ),
        Container(
          width: 236,
          height: 236,
          decoration: BoxDecoration(
            color: const Color(0xFF0F7A1D),
            borderRadius: BorderRadius.circular(44),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF0F7A1D).withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: const BoxDecoration(
                  color: Color(0xFF00E63D),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.card_giftcard, color: Colors.black, size: 34),
              ),
              const SizedBox(height: 20),
              Text(
                '+$couponsEarned COUPONS EARNED',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.italic,
                  letterSpacing: 0.5,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}