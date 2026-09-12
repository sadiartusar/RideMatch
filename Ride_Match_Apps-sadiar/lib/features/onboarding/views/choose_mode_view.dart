import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/mode_controller.dart';
import '../widgets/mode_card.dart';

class ChooseModeView extends GetView<ModeController> {
  const ChooseModeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Obx(() {
          final saving = controller.isSaving.value;
          final selected = controller.selectedMode.value;

          return ListView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
            children: [
              const Text(
                'Choose your mode',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF111827),
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Ride, drive or do both. Switch anytime. One App. Three ways to move.',
                style: TextStyle(
                  fontSize: 13.5,
                  color: Color(0xFF6B7280),
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 20),
              for (final option in controller.options) ...[
                ModeCard(
                  option: option,
                  isLoading: saving && selected == option.mode,
                  onChoose: () => controller.chooseMode(option.mode),
                ),
                const SizedBox(height: 16),
              ],
              const Text(
                'Note',
                style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF374151),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFF9FAFB),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.info_outline_rounded,
                      size: 18,
                      color: Color(0xFF6B7280),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'The mode can be changed anytime later from the Home '
                        'screen. This setting is not permanent. Initially, '
                        'only one mode will be shown as the default.',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF6B7280),
                          height: 1.45,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Divider(color: Color(0xFFE5E7EB), height: 1),
              const SizedBox(height: 16),
              const Text(
                'Your mode changes, but your identity remains the same.\n'
                'Verification and social links stay with your account.',
                style: TextStyle(
                  fontSize: 11.5,
                  color: Color(0xFF6B7280),
                  height: 1.45,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          );
        }),
      ),
    );
  }
}
