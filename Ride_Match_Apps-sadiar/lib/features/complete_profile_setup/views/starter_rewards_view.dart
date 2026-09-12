import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../core/routes/app_routes.dart';
import '../controllers/verification_controller.dart';

class StarterRewardsView extends StatelessWidget {
  const StarterRewardsView({super.key});

  Future<void> _goToDashboard() async {
    if (Get.isRegistered<VerificationController>()) {
      await Get.find<VerificationController>().finishStarterRewards();
    } else {
      Get.offAllNamed(AppRoutes.chooseMode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              const Expanded(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 28),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          width: 280,
                          height: 260,
                          child: _RewardsHero(),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'You received',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.5,
                            color: Color(0xFF111827),
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          '500 coupons',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.5,
                            color: Color(0xFF3DF416),
                          ),
                        ),
                        const SizedBox(height: 14),
                        const Text(
                          'Welcome to the RideMatch community!\nYour starter rewards are ready to use for\nzero-cash rides.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14.5,
                            height: 1.45,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF6B7280),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(22, 8, 22, 20),
                child: SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: Material(
                    color: const Color(0xFF3DF416),
                    borderRadius: BorderRadius.circular(28),
                    elevation: 2,
                    shadowColor: const Color(0xFF3DF416).withValues(alpha: 0.35),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(28),
                      onTap: _goToDashboard,
                      child: const Center(
                        child: Text(
                          'GO TO DASHBOARD',
                          style: TextStyle(
                            fontSize: 14.5,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.6,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RewardsHero extends StatelessWidget {
  const _RewardsHero();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 210,
          height: 210,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF3DF416).withValues(alpha: 0.28),
                blurRadius: 60,
                spreadRadius: 8,
              ),
            ],
          ),
        ),
        Container(
          width: 168,
          height: 168,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                Color(0xFF2A2F36),
                Color(0xFF15181C),
              ],
            ),
          ),
        ),
        Positioned(
          top: 28,
          left: 36,
          child: Icon(
            Icons.star_rounded,
            size: 18,
            color: const Color(0xFFFBBF24).withValues(alpha: 0.9),
          ),
        ),
        Positioned(
          left: 28,
          top: 118,
          child: Text(
            '+',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w300,
              color: const Color(0xFF9CA3AF).withValues(alpha: 0.7),
            ),
          ),
        ),
        Positioned(
          top: 42,
          right: 42,
          child: Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFF86EFAC).withValues(alpha: 0.7),
                width: 1.5,
              ),
            ),
          ),
        ),
        Positioned(
          right: 34,
          bottom: 58,
          child: Container(
            width: 28,
            height: 20,
            decoration: BoxDecoration(
              color: const Color(0xFF3DF416),
              borderRadius: BorderRadius.circular(5),
            ),
            child: const Icon(
              Icons.star_rounded,
              size: 12,
              color: Colors.white,
            ),
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 92,
              height: 78,
              decoration: BoxDecoration(
                color: const Color(0xFF2C333A),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.35),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin: const EdgeInsets.only(top: 6),
                      width: 78,
                      height: 18,
                      decoration: BoxDecoration(
                        color: const Color(0xFF5EEAD4).withValues(alpha: 0.55),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 14,
                      height: 78,
                      color: const Color(0xFF5EEAD4).withValues(alpha: 0.45),
                    ),
                  ),
                ],
              ),
            ),
            Transform.translate(
              offset: const Offset(0, -40),
              child: const Icon(
                Icons.card_giftcard_rounded,
                size: 54,
                color: Color(0xFF3DF416),
              ),
            ),
          ],
        ),
        Positioned(
          bottom: 48,
          child: Container(
            width: 70,
            height: 10,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(999),
              gradient: RadialGradient(
                colors: [
                  const Color(0xFF3DF416).withValues(alpha: 0.55),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
