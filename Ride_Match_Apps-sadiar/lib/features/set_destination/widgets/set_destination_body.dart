import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../create_mode/controllers/create_mode_controller.dart';
import '../../create_mode/widgets/create_mode_body.dart';
import '../controllers/set_destination_controller.dart';
import 'location_input_card.dart';
import 'quick_routes_section.dart';
import 'set_vibe_body.dart';

/// Find-tab content for Flex / Rider: set vibe → pickup / destination.
class SetDestinationBody extends StatelessWidget {
  const SetDestinationBody({super.key});

  SetDestinationController get _controller {
    SetDestinationController.ensureController();
    return Get.find<SetDestinationController>();
  }

  @override
  Widget build(BuildContext context) {
    final controller = _controller;

    return Obx(() {
      if (controller.step.value == SetDestinationStep.createMode) {
        CreateModeController.ensureController();
        return const CreateModeBody();
      }
      if (controller.step.value == SetDestinationStep.destination) {
        return _DestinationStep(controller: controller);
      }
      return const SetVibeBody();
    });
  }
}

class _DestinationStep extends StatelessWidget {
  const _DestinationStep({required this.controller});

  final SetDestinationController controller;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: const Color(0xFFF8F9FB),
      child: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(painter: _MapGridPainter()),
          ),
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LocationInputCard(
                        pickupController: controller.pickupController,
                        destinationController: controller.destinationController,
                        onUseCurrentLocation: controller.useCurrentLocation,
                      ),
                      const SizedBox(height: 26),
                      Obx(
                        () => QuickRoutesSection(
                          routes: controller.quickRoutes.toList(),
                          onRouteTap: controller.selectQuickRoute,
                        ),
                      ),
                      const SizedBox(height: 36),
                    ],
                  ),
                ),
              ),
              SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 4, 20, 12),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'SEARCH YOUR ROUTE TO DISCOVER SOCIAL RIDE MATCHES',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF9CA3AF),
                          fontSize: 10.5,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.7,
                        ),
                      ),
                      const SizedBox(height: 14),
                      Container(
                        width: double.infinity,
                        height: 56,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(28),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.button.withValues(alpha: 0.45),
                              blurRadius: 18,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: controller.previewRoute,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.button,
                            foregroundColor: const Color(0xFF111827),
                            elevation: 0,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28),
                            ),
                          ),
                          child: const Text(
                            'Route Preview',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF111827),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MapGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFD1D5DB).withValues(alpha: 0.35)
      ..strokeWidth = 0.8;

    const step = 32.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
