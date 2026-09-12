import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../core/routes/app_routes.dart';
import '../../onboarding/models/user_mode.dart';
import '../../onboarding/services/mode_service.dart';
import '../controllers/verification_controller.dart';
import '../widgets/add_interest_popup.dart';
import '../widgets/add_language_popup.dart';

class CompleteProfileView extends StatefulWidget {
  const CompleteProfileView({super.key});

  @override
  State<CompleteProfileView> createState() => _CompleteProfileViewState();
}

class _CompleteProfileViewState extends State<CompleteProfileView> {
  ModeService? _modeService;

  final _nameController = TextEditingController();
  final _bioController = TextEditingController();
  final _industryController = TextEditingController();

  final List<String> _interests = [
    'Tech',
    'Music',
    'Sports',
    'Books',
    'AI',
    'Travel',
    'Startups',
  ];
  final Set<String> _selectedInterests = {'Tech', 'Startups'};

  final List<String> _languages = [
    'English',
    'Spanish',
    'French',
    'Mandarin',
  ];
  final Set<String> _selectedLanguages = {'English'};

  @override
  void initState() {
    super.initState();
    if (Get.isRegistered<ModeService>()) {
      _modeService = Get.find<ModeService>();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    _industryController.dispose();
    super.dispose();
  }

  void _toggleInterest(String value) {
    setState(() {
      if (_selectedInterests.contains(value)) {
        _selectedInterests.remove(value);
      } else {
        _selectedInterests.add(value);
      }
    });
  }

  void _toggleLanguage(String value) {
    setState(() {
      if (_selectedLanguages.contains(value)) {
        _selectedLanguages.remove(value);
      } else {
        _selectedLanguages.add(value);
      }
    });
  }

  Future<void> _addInterest() async {
    final isDark = _modeService?.currentMode == UserMode.driver;
    final value = await AddInterestPopup.show(isDark: isDark);
    if (value == null || value.isEmpty) return;
    setState(() {
      if (!_interests.contains(value)) _interests.add(value);
      _selectedInterests.add(value);
    });
  }

  Future<void> _addLanguage() async {
    final isDark = _modeService?.currentMode == UserMode.driver;
    final value = await AddLanguagePopup.show(isDark: isDark);
    if (value == null || value.isEmpty) return;
    setState(() {
      if (!_languages.contains(value)) _languages.add(value);
      _selectedLanguages.add(value);
    });
  }

  void _continue() {
    if (Get.isRegistered<VerificationController>()) {
      Get.find<VerificationController>().finishCompleteProfile();
    } else {
      Get.toNamed(AppRoutes.connectModeFilter);
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
                          'Complete Profile',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.5,
                            color: titleColor,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Your profile helps our AI curate the perfect ride matches based on your professional vibe.',
                          style: TextStyle(
                            fontSize: 14.5,
                            height: 1.4,
                            color: subtitleColor,
                          ),
                        ),
                        const SizedBox(height: 28),
                        _IdentityRow(isDark: isDark),
                        const SizedBox(height: 28),
                        _UnderlineField(
                          isDark: isDark,
                          label: 'Full Name',
                          hint: 'e.g. Jordan Sterling',
                          controller: _nameController,
                          textCapitalization: TextCapitalization.words,
                        ),
                        const SizedBox(height: 22),
                        _UnderlineField(
                          isDark: isDark,
                          label: 'Short Bio',
                          hint: 'Tell us about your journey...',
                          controller: _bioController,
                          textCapitalization: TextCapitalization.sentences,
                        ),
                        const SizedBox(height: 22),
                        _UnderlineField(
                          isDark: isDark,
                          label: 'Industry',
                          hint: 'Tech / Design',
                          controller: _industryController,
                          textCapitalization: TextCapitalization.words,
                        ),
                        const SizedBox(height: 28),
                        _SectionHeader(
                          isDark: isDark,
                          title: 'Interests & Hobbies',
                          actionLabel: 'ADD MORE',
                          onAction: _addInterest,
                        ),
                        const SizedBox(height: 14),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: [
                            for (final interest in _interests)
                              _SelectableChip(
                                isDark: isDark,
                                label: interest,
                                selected: _selectedInterests.contains(interest),
                                showCheck: true,
                                onTap: () => _toggleInterest(interest),
                              ),
                          ],
                        ),
                        const SizedBox(height: 28),
                        Text(
                          'Languages',
                          style: TextStyle(
                            fontSize: 15.5,
                            fontWeight: FontWeight.w800,
                            color: titleColor,
                          ),
                        ),
                        const SizedBox(height: 14),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: [
                            for (final language in _languages)
                              _SelectableChip(
                                isDark: isDark,
                                label: language,
                                selected: _selectedLanguages.contains(language),
                                showCheck: false,
                                onTap: () => _toggleLanguage(language),
                              ),
                            _AddChip(isDark: isDark, onTap: _addLanguage),
                          ],
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
                      const _SetupDots(currentStep: 2, totalSteps: 6),
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

class _IdentityRow extends StatelessWidget {
  const _IdentityRow({required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isDark ? const Color(0xFF1B1E23) : const Color(0xFF1F2937),
            border: Border.all(
              color: isDark ? const Color(0xFF262A2E) : const Color(0xFFE5E7EB),
              width: 2,
            ),
          ),
          child: const Icon(
            Icons.person_rounded,
            size: 42,
            color: Color(0xFF3DF416),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'IDENTITY',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.8,
                  color: isDark ? Colors.white : const Color(0xFF111827),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Your updated photo. Match trust will increase by 40%.',
                style: TextStyle(
                  fontSize: 13.5,
                  height: 1.35,
                  color: isDark
                      ? const Color(0xFF9CA3AF)
                      : const Color(0xFF6B7280),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _UnderlineField extends StatelessWidget {
  const _UnderlineField({
    required this.isDark,
    required this.label,
    required this.hint,
    required this.controller,
    this.textCapitalization = TextCapitalization.none,
  });

  final bool isDark;
  final String label;
  final String hint;
  final TextEditingController controller;
  final TextCapitalization textCapitalization;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 15.5,
            fontWeight: FontWeight.w800,
            color: isDark ? Colors.white : const Color(0xFF111827),
          ),
        ),
        TextField(
          controller: controller,
          textCapitalization: textCapitalization,
          cursorColor: const Color(0xFF3DF416),
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: isDark ? Colors.white : const Color(0xFF111827),
          ),
          decoration: InputDecoration(
            isDense: true,
            hintText: hint,
            hintStyle: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: isDark
                  ? const Color(0xFF6B7280)
                  : const Color(0xFF9CA3AF),
            ),
            contentPadding: const EdgeInsets.only(top: 10, bottom: 10),
            border: UnderlineInputBorder(
              borderSide: BorderSide(
                color: isDark
                    ? const Color(0xFF374151)
                    : const Color(0xFFD1D5DB),
              ),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: isDark
                    ? const Color(0xFF374151)
                    : const Color(0xFFD1D5DB),
              ),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF3DF416), width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.isDark,
    required this.title,
    required this.actionLabel,
    required this.onAction,
  });

  final bool isDark;
  final String title;
  final String actionLabel;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 15.5,
              fontWeight: FontWeight.w800,
              color: isDark ? Colors.white : const Color(0xFF111827),
            ),
          ),
        ),
        GestureDetector(
          onTap: onAction,
          child: const Text(
            'ADD MORE',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.6,
              color: Color(0xFF3DF416),
            ),
          ),
        ),
      ],
    );
  }
}

class _SelectableChip extends StatelessWidget {
  const _SelectableChip({
    required this.isDark,
    required this.label,
    required this.selected,
    required this.showCheck,
    required this.onTap,
  });

  final bool isDark;
  final String label;
  final bool selected;
  final bool showCheck;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final unselectedBg =
        isDark ? const Color(0xFF1B1E23) : const Color(0xFFF3F4F6);
    final unselectedText =
        isDark ? const Color(0xFFE5E7EB) : const Color(0xFF111827);

    return Material(
      color: selected ? const Color(0xFF3DF416) : unselectedBg,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            14,
            10,
            showCheck && selected ? 10 : 14,
            10,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w700,
                  color: selected ? const Color(0xFF0F172A) : unselectedText,
                ),
              ),
              if (showCheck && selected) ...[
                const SizedBox(width: 6),
                const Icon(
                  Icons.check_rounded,
                  size: 16,
                  color: Color(0xFF0F172A),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _AddChip extends StatelessWidget {
  const _AddChip({required this.isDark, required this.onTap});

  final bool isDark;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isDark ? const Color(0xFF1B1E23) : const Color(0xFFF3F4F6),
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: const SizedBox(
          width: 40,
          height: 40,
          child: Icon(
            Icons.add_rounded,
            size: 20,
            color: Color(0xFF6B7280),
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
