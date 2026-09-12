import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../core/routes/app_routes.dart';
import '../../onboarding/models/user_mode.dart';
import '../../onboarding/services/mode_service.dart';
import '../controllers/verification_controller.dart';

class TellUsMoreView extends StatefulWidget {
  const TellUsMoreView({super.key});

  @override
  State<TellUsMoreView> createState() => _TellUsMoreViewState();
}

class _TellUsMoreViewState extends State<TellUsMoreView> {
  ModeService? _modeService;

  String _into = 'Gaming';
  String _conversation = 'Deep Talk';
  String _industry = 'Design';
  String _commute = 'Silent';

  static const _intoOptions = ['Fitness', 'Gaming', 'Jazz'];
  static const _conversationOptions = ['Deep Talk', 'Small Talk', 'Quiet'];
  static const _industryOptions = ['Startups', 'Design', 'Social Impact'];
  static const _commuteOptions = ['Professional', 'Social', 'Silent'];

  @override
  void initState() {
    super.initState();
    if (Get.isRegistered<ModeService>()) {
      _modeService = Get.find<ModeService>();
    }
  }

  void _continue() {
    if (Get.isRegistered<VerificationController>()) {
      Get.find<VerificationController>().finishTellUsMore();
    } else {
      Get.toNamed(AppRoutes.socialConnect);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final mode = _modeService?.rxCurrentMode.value;
      final isDark = mode == UserMode.driver;
      final backgroundColor = isDark ? const Color(0xFF0B0D0F) : Colors.white;
      final overlayStyle = isDark
          ? SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent)
          : SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent);

      final titleColor = isDark ? Colors.white : const Color(0xFF111827);
      final subtitleColor =
          isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280);

      return AnnotatedRegion<SystemUiOverlayStyle>(
        value: overlayStyle,
        child: Scaffold(
          backgroundColor: backgroundColor,
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(22, 20, 22, 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tell us more about you',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.5,
                            height: 1.15,
                            color: titleColor,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Help us personalize your matches.',
                          style: TextStyle(
                            fontSize: 14.5,
                            height: 1.4,
                            color: subtitleColor,
                          ),
                        ),
                        const SizedBox(height: 28),
                        _QuestionBlock(
                          isDark: isDark,
                          question: 'What are you into?',
                          options: _intoOptions,
                          selected: _into,
                          onChanged: (value) => setState(() => _into = value),
                        ),
                        const SizedBox(height: 26),
                        _QuestionBlock(
                          isDark: isDark,
                          question: 'What kind of conversations do you enjoy?',
                          options: _conversationOptions,
                          selected: _conversation,
                          onChanged: (value) =>
                              setState(() => _conversation = value),
                        ),
                        const SizedBox(height: 26),
                        _QuestionBlock(
                          isDark: isDark,
                          question: 'What industries or topics interest you?',
                          options: _industryOptions,
                          selected: _industry,
                          onChanged: (value) =>
                              setState(() => _industry = value),
                        ),
                        const SizedBox(height: 26),
                        _QuestionBlock(
                          isDark: isDark,
                          question:
                              'What kind of commute connections do you prefer?',
                          options: _commuteOptions,
                          selected: _commute,
                          onChanged: (value) =>
                              setState(() => _commute = value),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(22, 8, 22, 12),
                  child: Column(
                    children: [
                      const _SetupDots(currentStep: 4, totalSteps: 6),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        height: 54,
                        child: Material(
                          color: const Color(0xFF3DF416),
                          borderRadius: BorderRadius.circular(28),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(28),
                            onTap: _continue,
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'CONTINUE',
                                  style: TextStyle(
                                    fontSize: 14.5,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 0.6,
                                    color: Color(0xFF0F172A),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Icon(
                                  Icons.arrow_forward,
                                  size: 18,
                                  color: Color(0xFF0F172A),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextButton(
                        onPressed: () => Get.back(),
                        child: Text(
                          'Back',
                          style: TextStyle(
                            fontSize: 14.5,
                            fontWeight: FontWeight.w600,
                            color: subtitleColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class _QuestionBlock extends StatelessWidget {
  const _QuestionBlock({
    required this.isDark,
    required this.question,
    required this.options,
    required this.selected,
    required this.onChanged,
  });

  final bool isDark;
  final String question;
  final List<String> options;
  final String selected;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question,
          style: TextStyle(
            fontSize: 15.5,
            fontWeight: FontWeight.w800,
            color: isDark ? Colors.white : const Color(0xFF111827),
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            for (final option in options)
              _OptionChip(
                isDark: isDark,
                label: option,
                selected: selected == option,
                onTap: () => onChanged(option),
              ),
          ],
        ),
      ],
    );
  }
}

class _OptionChip extends StatelessWidget {
  const _OptionChip({
    required this.isDark,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final bool isDark;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected
          ? const Color(0xFF3DF416)
          : (isDark ? const Color(0xFF1B1E23) : const Color(0xFFF3F4F6)),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: selected
                  ? const Color(0xFF0F172A)
                  : (isDark ? Colors.white : const Color(0xFF111827)),
            ),
          ),
        ),
      ),
    );
  }
}

class _SetupDots extends StatelessWidget {
  const _SetupDots({
    required this.currentStep,
    required this.totalSteps,
  });

  final int currentStep;
  final int totalSteps;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalSteps, (index) {
        final active = index == currentStep;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: active ? 22 : 7,
          height: 7,
          decoration: BoxDecoration(
            color: active
                ? const Color(0xFF3DF416)
                : const Color(0xFF9CA3AF),
            borderRadius: BorderRadius.circular(999),
          ),
        );
      }),
    );
  }
}
