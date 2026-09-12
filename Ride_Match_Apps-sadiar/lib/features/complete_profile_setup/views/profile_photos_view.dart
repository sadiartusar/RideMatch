import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../core/routes/app_routes.dart';
import '../../onboarding/models/user_mode.dart';
import '../../onboarding/services/mode_service.dart';
import '../controllers/verification_controller.dart';
import '../widgets/upload_photo_popup.dart';

class ProfilePhotosView extends StatefulWidget {
  const ProfilePhotosView({super.key});

  @override
  State<ProfilePhotosView> createState() => _ProfilePhotosViewState();
}

class _ProfilePhotosViewState extends State<ProfilePhotosView> {
  /// First 3 slots are required; extras come from "Add more".
  final List<bool> _filled = [false, false, false];
  ModeService? _modeService;

  @override
  void initState() {
    super.initState();
    if (Get.isRegistered<ModeService>()) {
      _modeService = Get.find<ModeService>();
    }
  }

  Future<void> _openUpload(int index) async {
    final isDark = _modeService?.currentMode == UserMode.driver;
    final uploaded = await UploadPhotoPopup.show(isDark: isDark);
    if (!uploaded || !mounted) return;
    setState(() => _filled[index] = true);
  }

  void _addMore() {
    setState(() => _filled.add(false));
  }

  void _continue() {
    if (Get.isRegistered<VerificationController>()) {
      Get.find<VerificationController>().finishProfilePhotos();
    } else {
      Get.toNamed(AppRoutes.completeProfile);
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
                          'Add at least 3 photos',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.5,
                            color: isDark ? Colors.white : const Color(0xFF111827),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Use clear photos that help others recognize and trust you.',
                          style: TextStyle(
                            fontSize: 14.5,
                            height: 1.4,
                            color: isDark
                                ? const Color(0xFF9CA3AF)
                                : const Color(0xFF6B7280),
                          ),
                        ),
                        const SizedBox(height: 22),
                        _PhotoGrid(
                          isDark: isDark,
                          filled: _filled,
                          onTapSlot: _openUpload,
                          onAddMore: _addMore,
                        ),
                        const SizedBox(height: 18),
                        _QualityHint(isDark: isDark),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(22, 8, 22, 12),
                  child: Column(
                    children: [
                      const _SetupProgress(currentStep: 1, totalSteps: 5),
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
                            color: isDark
                                ? const Color(0xFF9CA3AF)
                                : const Color(0xFF6B7280),
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

class _PhotoGrid extends StatelessWidget {
  const _PhotoGrid({
    required this.isDark,
    required this.filled,
    required this.onTapSlot,
    required this.onAddMore,
  });

  final bool isDark;
  final List<bool> filled;
  final ValueChanged<int> onTapSlot;
  final VoidCallback onAddMore;

  @override
  Widget build(BuildContext context) {
    final tile = isDark ? const Color(0xFF1B1E23) : const Color(0xFFF3F4F6);
    final iconColor = isDark ? const Color(0xFF6B7280) : const Color(0xFF9CA3AF);

    return LayoutBuilder(
      builder: (context, constraints) {
        final gap = 10.0;
        final sideSize = (constraints.maxWidth - gap * 2) / 3;
        final mainSize = sideSize * 2 + gap;

        return Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: mainSize,
                  height: mainSize,
                  child: _PhotoTile(
                    isDark: isDark,
                    filled: filled.isNotEmpty && filled[0],
                    isPrimary: true,
                    background: tile,
                    iconColor: iconColor,
                    onTap: () => onTapSlot(0),
                  ),
                ),
                SizedBox(width: gap),
                Column(
                  children: [
                    SizedBox(
                      width: sideSize,
                      height: sideSize,
                      child: _PhotoTile(
                        isDark: isDark,
                        filled: filled.length > 1 && filled[1],
                        background: tile,
                        iconColor: iconColor,
                        onTap: () => onTapSlot(1),
                      ),
                    ),
                    SizedBox(height: gap),
                    SizedBox(
                      width: sideSize,
                      height: sideSize,
                      child: _PhotoTile(
                        isDark: isDark,
                        filled: filled.length > 2 && filled[2],
                        background: tile,
                        iconColor: iconColor,
                        onTap: () => onTapSlot(2),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            if (filled.length > 3) ...[
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  for (var i = 3; i < filled.length; i++)
                    SizedBox(
                      width: sideSize,
                      height: sideSize,
                      child: _PhotoTile(
                        isDark: isDark,
                        filled: filled[i],
                        background: tile,
                        iconColor: iconColor,
                        onTap: () => onTapSlot(i),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 10),
            ],
            Material(
              color: tile,
              borderRadius: BorderRadius.circular(14),
              child: InkWell(
                borderRadius: BorderRadius.circular(14),
                onTap: onAddMore,
                child: Container(
                  width: double.infinity,
                  height: 52,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: isDark
                          ? const Color(0xFF262A2E)
                          : const Color(0xFFE5E7EB),
                    ),
                  ),
                  child: Text(
                    'Add more +',
                    style: TextStyle(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w600,
                      color: isDark
                          ? const Color(0xFF9CA3AF)
                          : const Color(0xFF6B7280),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _PhotoTile extends StatelessWidget {
  const _PhotoTile({
    required this.isDark,
    required this.filled,
    required this.background,
    required this.iconColor,
    required this.onTap,
    this.isPrimary = false,
  });

  final bool isDark;
  final bool filled;
  final bool isPrimary;
  final Color background;
  final Color iconColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: background,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Stack(
          children: [
            Center(
              child: filled
                  ? Icon(
                      Icons.person_rounded,
                      size: isPrimary ? 64 : 36,
                      color: const Color(0xFF3DF416),
                    )
                  : Icon(
                      isPrimary
                          ? Icons.add_a_photo_outlined
                          : Icons.add_rounded,
                      size: isPrimary ? 36 : 28,
                      color: iconColor,
                    ),
            ),
            if (isPrimary)
              Positioned(
                right: 10,
                bottom: 10,
                child: Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: const Color(0xFF3DF416),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.edit_rounded,
                    size: 18,
                    color: Color(0xFF0F172A),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _QualityHint extends StatelessWidget {
  const _QualityHint({required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF14171A) : const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? const Color(0xFF262A2E) : const Color(0xFFE5E7EB),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: const BoxDecoration(
              color: Color(0xFFF59E0B),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.star_rounded, size: 16, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'QUALITY HINT',
                  style: TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.7,
                    color: isDark
                        ? const Color(0xFFD1D5DB)
                        : const Color(0xFF4B5563),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Friendly, clear, and recent photos work best. Avoid filters or group photos where you aren\'t clearly visible.',
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.4,
                    color: isDark
                        ? const Color(0xFF9CA3AF)
                        : const Color(0xFF6B7280),
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

class _SetupProgress extends StatelessWidget {
  const _SetupProgress({
    required this.currentStep,
    required this.totalSteps,
  });

  final int currentStep;
  final int totalSteps;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            final progress = (currentStep + 1) / totalSteps;
            return Stack(
              alignment: Alignment.centerLeft,
              children: [
                Container(
                  height: 3,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE5E7EB),
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
                Container(
                  height: 3,
                  width: constraints.maxWidth * progress,
                  decoration: BoxDecoration(
                    color: const Color(0xFF3DF416),
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
                Positioned(
                  left: (constraints.maxWidth * progress) - 5,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: Color(0xFF3DF416),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 14),
        Row(
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
        ),
      ],
    );
  }
}
