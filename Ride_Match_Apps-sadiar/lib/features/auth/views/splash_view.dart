import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../controllers/auth_controller.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future<void>.delayed(AppConstants.splashDuration);
      if (!mounted) return;
      await Get.find<AuthController>().bootstrap();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.splashBackground,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'RideMatch',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF101010),
                        letterSpacing: -0.8,
                      ),
                    ),
                    SizedBox(height: 12),
                    SizedBox(
                      width: 76,
                      height: 3.5,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Color(0xFF101010),
                          borderRadius: BorderRadius.all(Radius.circular(2)),
                        ),
                      ),
                    ),
                    SizedBox(height: 24),
                    Text(
                      'Meet. Move. Match.',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF4A4A4A),
                        letterSpacing: 0.2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 28),
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF101010)),
                  backgroundColor: Colors.black12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
