import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../core/routes/app_routes.dart';
import '../../onboarding/models/user_mode.dart';
import '../../onboarding/services/mode_service.dart';
import '../controllers/verification_controller.dart';

enum ConnectMode { friends, professional, dating }

enum CoRiderGender { any, female, male, other }

enum RideVibe { quiet, social, noPreference }

class ConnectModeFilterView extends StatefulWidget {
  const ConnectModeFilterView({super.key});

  @override
  State<ConnectModeFilterView> createState() => _ConnectModeFilterViewState();
}

class _ConnectModeFilterViewState extends State<ConnectModeFilterView> {
  ModeService? _modeService;

  ConnectMode _connectMode = ConnectMode.friends;
  CoRiderGender _gender = CoRiderGender.female;
  RangeValues _ageRange = const RangeValues(25, 45);
  RideVibe _rideVibe = RideVibe.social;

  @override
  void initState() {
    super.initState();
    if (Get.isRegistered<ModeService>()) {
      _modeService = Get.find<ModeService>();
    }
  }

  void _continue() {
    if (Get.isRegistered<VerificationController>()) {
      Get.find<VerificationController>().finishConnectModeFilter();
    } else {
      Get.toNamed(AppRoutes.tellUsMore);
    }
  }

  String get _ageLabel {
    final start = _ageRange.start.round();
    final end = _ageRange.end.round();
    final endLabel = end >= 65 ? '65+' : '$end';
    return '$start - $endLabel';
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
                          'Choose how you want to connect',
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
                          'Tailor your ride experience by selecting your preferred connection mode and basic filters.',
                          style: TextStyle(
                            fontSize: 14.5,
                            height: 1.4,
                            color: subtitleColor,
                          ),
                        ),
                        const SizedBox(height: 26),
                        Text(
                          'Connect Mode',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: titleColor,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _ConnectModeCard(
                          isDark: isDark,
                          selected: _connectMode == ConnectMode.friends,
                          icon: Icons.group_rounded,
                          title: 'Friends',
                          subtitle: 'Ride with people you know or mutuals.',
                          onTap: () => setState(
                            () => _connectMode = ConnectMode.friends,
                          ),
                        ),
                        const SizedBox(height: 10),
                        _ConnectModeCard(
                          isDark: isDark,
                          selected: _connectMode == ConnectMode.professional,
                          icon: Icons.work_outline_rounded,
                          title: 'Professional',
                          subtitle: 'Networking and quiet focused rides.',
                          onTap: () => setState(
                            () => _connectMode = ConnectMode.professional,
                          ),
                        ),
                        const SizedBox(height: 10),
                        _ConnectModeCard(
                          isDark: isDark,
                          selected: _connectMode == ConnectMode.dating,
                          icon: Icons.favorite_rounded,
                          iconColor: const Color(0xFF166534),
                          title: 'Dating',
                          titleSuffix: '(Optional)',
                          subtitle: 'Meet new people with similar interests.',
                          onTap: () => setState(
                            () => _connectMode = ConnectMode.dating,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _InfoBanner(isDark: isDark),
                        const SizedBox(height: 28),
                        Text(
                          'Basic Filters',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: titleColor,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Preferred Co-rider Gender',
                          style: TextStyle(
                            fontSize: 14.5,
                            fontWeight: FontWeight.w700,
                            color: titleColor,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _GenderGrid(
                          isDark: isDark,
                          selected: _gender,
                          onChanged: (value) =>
                              setState(() => _gender = value),
                        ),
                        const SizedBox(height: 22),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Age Range',
                                style: TextStyle(
                                  fontSize: 14.5,
                                  fontWeight: FontWeight.w700,
                                  color: titleColor,
                                ),
                              ),
                            ),
                            Text(
                              _ageLabel,
                              style: const TextStyle(
                                fontSize: 14.5,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF3DF416),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            trackHeight: 4,
                            activeTrackColor: const Color(0xFF166534),
                            inactiveTrackColor: isDark
                                ? const Color(0xFF374151)
                                : const Color(0xFFE5E7EB),
                            rangeThumbShape: const _GreenBorderThumb(),
                            thumbColor: Colors.white,
                            overlayColor:
                                const Color(0xFF3DF416).withValues(alpha: 0.15),
                            rangeTrackShape:
                                const RoundedRectRangeSliderTrackShape(),
                          ),
                          child: RangeSlider(
                            values: _ageRange,
                            min: 18,
                            max: 65,
                            divisions: 47,
                            onChanged: (values) {
                              setState(() => _ageRange = values);
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '18',
                                style: TextStyle(
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w600,
                                  color: subtitleColor,
                                ),
                              ),
                              Text(
                                '65+',
                                style: TextStyle(
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w600,
                                  color: subtitleColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 22),
                        Text(
                          'Ride Vibe',
                          style: TextStyle(
                            fontSize: 14.5,
                            fontWeight: FontWeight.w700,
                            color: titleColor,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _RideVibeSection(
                          isDark: isDark,
                          selected: _rideVibe,
                          onChanged: (value) =>
                              setState(() => _rideVibe = value),
                        ),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(22, 8, 22, 12),
                  child: Column(
                    children: [
                      const _SetupDots(currentStep: 3, totalSteps: 6),
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

class _ConnectModeCard extends StatelessWidget {
  const _ConnectModeCard({
    required this.isDark,
    required this.selected,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.titleSuffix,
    this.iconColor,
  });

  final bool isDark;
  final bool selected;
  final IconData icon;
  final String title;
  final String? titleSuffix;
  final String subtitle;
  final VoidCallback onTap;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final bg = selected
        ? const Color(0xFF3DF416)
        : (isDark ? const Color(0xFF1B1E23) : const Color(0xFFF3F4F6));
    final titleColor = const Color(0xFF111827);
    final subtitleColor = selected
        ? const Color(0xFF1F2937)
        : (isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280));

    return Material(
      color: bg,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: selected
                      ? null
                      : [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.04),
                            blurRadius: 6,
                          ),
                        ],
                ),
                child: Icon(
                  icon,
                  size: 22,
                  color: iconColor ??
                      (selected
                          ? const Color(0xFF111827)
                          : const Color(0xFF374151)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 15.5,
                            fontWeight: FontWeight.w800,
                            color: isDark && !selected
                                ? Colors.white
                                : titleColor,
                          ),
                        ),
                        if (titleSuffix != null) ...[
                          const SizedBox(width: 6),
                          Text(
                            titleSuffix!,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: selected
                                  ? const Color(0xFF374151)
                                  : (isDark
                                      ? const Color(0xFF9CA3AF)
                                      : const Color(0xFF6B7280)),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 13,
                        height: 1.3,
                        color: subtitleColor,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: selected ? Colors.white : Colors.transparent,
                  border: Border.all(
                    color: selected
                        ? Colors.white
                        : (isDark
                            ? const Color(0xFF6B7280)
                            : const Color(0xFF9CA3AF)),
                    width: 2,
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

class _InfoBanner extends StatelessWidget {
  const _InfoBanner({required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF14171A) : const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline_rounded,
            size: 18,
            color: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'RideMatch is not a dating app. Dating mode is purely optional and requires mutual opt-in.',
              style: TextStyle(
                fontSize: 12.5,
                height: 1.35,
                color: isDark
                    ? const Color(0xFF9CA3AF)
                    : const Color(0xFF6B7280),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GenderGrid extends StatelessWidget {
  const _GenderGrid({
    required this.isDark,
    required this.selected,
    required this.onChanged,
  });

  final bool isDark;
  final CoRiderGender selected;
  final ValueChanged<CoRiderGender> onChanged;

  @override
  Widget build(BuildContext context) {
    const options = [
      (CoRiderGender.any, 'Any'),
      (CoRiderGender.female, 'Female'),
      (CoRiderGender.male, 'Male'),
      (CoRiderGender.other, 'Other'),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: options.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 2.8,
      ),
      itemBuilder: (context, index) {
        final option = options[index];
        final isSelected = selected == option.$1;
        return Material(
          color: isSelected
              ? const Color(0xFF3DF416)
              : (isDark ? const Color(0xFF1B1E23) : Colors.white),
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () => onChanged(option.$1),
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF3DF416)
                      : (isDark
                          ? const Color(0xFF374151)
                          : const Color(0xFFE5E7EB)),
                ),
              ),
              child: Text(
                option.$2,
                style: TextStyle(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w700,
                  color: isSelected
                      ? Colors.white
                      : (isDark ? Colors.white : const Color(0xFF111827)),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _RideVibeSection extends StatelessWidget {
  const _RideVibeSection({
    required this.isDark,
    required this.selected,
    required this.onChanged,
  });

  final bool isDark;
  final RideVibe selected;
  final ValueChanged<RideVibe> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _VibeChip(
                isDark: isDark,
                selected: selected == RideVibe.quiet,
                label: 'Quiet',
                icon: Icons.volume_off_rounded,
                onTap: () => onChanged(RideVibe.quiet),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _VibeChip(
                isDark: isDark,
                selected: selected == RideVibe.social,
                label: 'Social',
                icon: Icons.chat_bubble_outline_rounded,
                onTap: () => onChanged(RideVibe.social),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        _VibeChip(
          isDark: isDark,
          selected: selected == RideVibe.noPreference,
          label: 'No Preference',
          onTap: () => onChanged(RideVibe.noPreference),
          fullWidth: true,
        ),
      ],
    );
  }
}

class _VibeChip extends StatelessWidget {
  const _VibeChip({
    required this.isDark,
    required this.selected,
    required this.label,
    required this.onTap,
    this.icon,
    this.fullWidth = false,
  });

  final bool isDark;
  final bool selected;
  final String label;
  final IconData? icon;
  final VoidCallback onTap;
  final bool fullWidth;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected
          ? const Color(0xFF3DF416)
          : (isDark ? const Color(0xFF1B1E23) : Colors.white),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          width: fullWidth ? double.infinity : null,
          height: 48,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: selected
                  ? const Color(0xFF3DF416)
                  : (isDark
                      ? const Color(0xFF374151)
                      : const Color(0xFFE5E7EB)),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  size: 18,
                  color: selected
                      ? Colors.white
                      : (isDark
                          ? const Color(0xFF9CA3AF)
                          : const Color(0xFF6B7280)),
                ),
                const SizedBox(width: 8),
              ],
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: selected
                      ? Colors.white
                      : (isDark ? Colors.white : const Color(0xFF111827)),
                ),
              ),
            ],
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

class _GreenBorderThumb extends RangeSliderThumbShape {
  const _GreenBorderThumb();

  static const double _radius = 11;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return const Size.fromRadius(_radius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    bool isDiscrete = false,
    bool isEnabled = false,
    bool? isOnTop,
    required SliderThemeData sliderTheme,
    TextDirection? textDirection,
    Thumb? thumb,
    bool? isPressed,
  }) {
    final canvas = context.canvas;
    canvas.drawCircle(
      center,
      _radius,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.fill,
    );
    canvas.drawCircle(
      center,
      _radius,
      Paint()
        ..color = const Color(0xFF166534)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5,
    );
  }
}
