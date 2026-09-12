import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_dimensions.dart';
import '../../../core/widgets/app_loading.dart';
import '../../onboarding/services/mode_service.dart';
import '../controllers/home_controller.dart';

/// Legacy entry that forwards to the active mode home.
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!Get.isRegistered<ModeService>()) return;
      final route = await Get.find<ModeService>().resolvePostAuthRoute();
      Get.offAllNamed(route);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Ensure binding still creates HomeController if registered.
    if (Get.isRegistered<HomeController>()) {
      Get.find<HomeController>();
    }
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(AppDimensions.spacingLg),
        child: AppLoading(message: 'Loading your mode...'),
      ),
    );
  }
}
