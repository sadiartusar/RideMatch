import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../core/routes/app_routes.dart';
import '../../onboarding/models/user_mode.dart';
import '../../onboarding/services/mode_service.dart';
import '../controllers/verification_controller.dart';
import '../widgets/add_social_popup.dart';

class _SocialPlatform {
  _SocialPlatform({
    required this.name,
    required this.brandColor,
    required this.icon,
    required this.initialLink,
    this.removable = false,
    this.verified = false,
    this.useGradient = false,
  }) : controller = TextEditingController(text: initialLink);

  final String name;
  final Color brandColor;
  final FaIconData icon;
  final String initialLink;
  final bool removable;
  final bool verified;
  final bool useGradient;
  final TextEditingController controller;

  void dispose() => controller.dispose();

  static _SocialPlatform fromName({
    required String name,
    required String link,
    bool removable = false,
    bool verified = false,
  }) {
    switch (name) {
      case 'LinkedIn':
        return _SocialPlatform(
          name: name,
          brandColor: const Color(0xFF0A66C2),
          icon: FontAwesomeIcons.linkedinIn,
          initialLink: link,
          removable: removable,
          verified: verified,
        );
      case 'Instagram':
        return _SocialPlatform(
          name: name,
          brandColor: const Color(0xFFE1306C),
          icon: FontAwesomeIcons.instagram,
          initialLink: link,
          removable: removable,
          verified: verified,
          useGradient: true,
        );
      case 'Tiktok':
        return _SocialPlatform(
          name: name,
          brandColor: const Color(0xFF111827),
          icon: FontAwesomeIcons.tiktok,
          initialLink: link,
          removable: removable,
          verified: verified,
        );
      case 'Facebook':
        return _SocialPlatform(
          name: name,
          brandColor: const Color(0xFF1877F2),
          icon: FontAwesomeIcons.facebookF,
          initialLink: link,
          removable: removable,
          verified: verified,
        );
      case 'X':
        return _SocialPlatform(
          name: name,
          brandColor: const Color(0xFF111827),
          icon: FontAwesomeIcons.xTwitter,
          initialLink: link,
          removable: removable,
          verified: verified,
        );
      case 'YouTube':
        return _SocialPlatform(
          name: name,
          brandColor: const Color(0xFFFF0000),
          icon: FontAwesomeIcons.youtube,
          initialLink: link,
          removable: removable,
          verified: verified,
        );
      default:
        return _SocialPlatform(
          name: name,
          brandColor: const Color(0xFF3DF416),
          icon: FontAwesomeIcons.link,
          initialLink: link,
          removable: removable,
          verified: verified,
        );
    }
  }
}

class SocialConnectView extends StatefulWidget {
  const SocialConnectView({super.key});

  @override
  State<SocialConnectView> createState() => _SocialConnectViewState();
}

class _SocialConnectViewState extends State<SocialConnectView> {
  ModeService? _modeService;

  late final List<_SocialPlatform> _platforms;

  @override
  void initState() {
    super.initState();
    if (Get.isRegistered<ModeService>()) {
      _modeService = Get.find<ModeService>();
    }
    _platforms = [
      _SocialPlatform.fromName(
        name: 'LinkedIn',
        link: 'linkedin.com/in/alex-rivas-lead',
        removable: true,
        verified: true,
      ),
      _SocialPlatform.fromName(
        name: 'Instagram',
        link: 'instagram.com/alex_vibe',
        removable: true,
        verified: true,
      ),
      _SocialPlatform.fromName(
        name: 'Tiktok',
        link: 'tiktok.com/@alex_vibe',
      ),
      _SocialPlatform.fromName(
        name: 'Facebook',
        link: 'facebook.com/yourprofile',
      ),
    ];
  }

  @override
  void dispose() {
    for (final platform in _platforms) {
      platform.dispose();
    }
    super.dispose();
  }

  Future<void> _addPlatform() async {
    final isDark = _modeService?.currentMode == UserMode.driver;
    final link = await AddSocialPopup.show(isDark: isDark);
    if (link == null || link.isEmpty) return;

    final name = _guessPlatformName(link);
    setState(() {
      _platforms.add(
        _SocialPlatform.fromName(
          name: name,
          link: link,
          removable: true,
          verified: true,
        ),
      );
    });
  }

  String _guessPlatformName(String link) {
    final lower = link.toLowerCase();
    if (lower.contains('linkedin')) return 'LinkedIn';
    if (lower.contains('instagram')) return 'Instagram';
    if (lower.contains('tiktok')) return 'Tiktok';
    if (lower.contains('facebook') || lower.contains('fb.com')) {
      return 'Facebook';
    }
    if (lower.contains('twitter') || lower.contains('x.com')) return 'X';
    if (lower.contains('youtube')) return 'YouTube';
    return 'Social';
  }

  void _removePlatform(int index) {
    setState(() {
      _platforms[index].dispose();
      _platforms.removeAt(index);
    });
  }

  void _finish() {
    if (Get.isRegistered<VerificationController>()) {
      Get.find<VerificationController>().finishSocialConnect();
    } else {
      Get.toNamed(AppRoutes.backgroundCheck);
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
                          'Social Connect',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.5,
                            color: titleColor,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Link your social profiles to increase your trust score and unlock AI matches.',
                          style: TextStyle(
                            fontSize: 14.5,
                            height: 1.4,
                            color: subtitleColor,
                          ),
                        ),
                        const SizedBox(height: 22),
                        for (var i = 0; i < _platforms.length; i++) ...[
                          _SocialCard(
                            isDark: isDark,
                            platform: _platforms[i],
                            onRemove: _platforms[i].removable
                                ? () => _removePlatform(i)
                                : null,
                          ),
                          const SizedBox(height: 12),
                        ],
                        _AddMorePlatformsButton(
                          isDark: isDark,
                          onTap: _addPlatform,
                        ),
                        const SizedBox(height: 26),
                        Text(
                          'Trust Badges',
                          style: TextStyle(
                            fontSize: 15.5,
                            fontWeight: FontWeight.w800,
                            color: isDark
                                ? const Color(0xFFD1D5DB)
                                : const Color(0xFF4B5563),
                          ),
                        ),
                        const SizedBox(height: 12),
                        const _TrustBadgesRow(),
                        const SizedBox(height: 14),
                        _PrivacyNote(isDark: isDark),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(22, 8, 22, 12),
                  child: Column(
                    children: [
                      const _SetupDots(currentStep: 5, totalSteps: 6),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        height: 54,
                        child: Material(
                          color: const Color(0xFF3DF416),
                          borderRadius: BorderRadius.circular(28),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(28),
                            onTap: _finish,
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'FINISH',
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

class _SocialCard extends StatelessWidget {
  const _SocialCard({
    required this.isDark,
    required this.platform,
    this.onRemove,
  });

  final bool isDark;
  final _SocialPlatform platform;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    final cardBg = isDark ? const Color(0xFF14171A) : Colors.white;
    final borderColor =
        isDark ? const Color(0xFF262A2E) : const Color(0xFFE5E7EB);
    final labelColor =
        isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280);
    final fieldBg =
        isDark ? const Color(0xFF1B1E23) : const Color(0xFFF3F4F6);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: platform.useGradient ? null : platform.brandColor,
                  gradient: platform.useGradient
                      ? const LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Color(0xFFF58529),
                            Color(0xFFDD2A7B),
                            Color(0xFF8134AF),
                            Color(0xFF515BD4),
                          ],
                        )
                      : null,
                ),
                child: Center(
                  child: FaIcon(
                    platform.icon,
                    size: 16,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  platform.name,
                  style: TextStyle(
                    fontSize: 15.5,
                    fontWeight: FontWeight.w800,
                    color: isDark ? Colors.white : const Color(0xFF111827),
                  ),
                ),
              ),
              if (onRemove != null)
                Material(
                  color: isDark
                      ? const Color(0xFF1B1E23)
                      : const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(999),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(999),
                    onTap: onRemove,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      child: Text(
                        'Remove',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF6B7280),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Profile Link',
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: labelColor,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: fieldBg,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: platform.controller,
                    style: TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w500,
                      color: isDark ? Colors.white : const Color(0xFF111827),
                    ),
                    decoration: InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                      hintText: '${platform.name.toLowerCase()}.com/yourprofile',
                      hintStyle: TextStyle(
                        fontSize: 13.5,
                        color: isDark
                            ? const Color(0xFF6B7280)
                            : const Color(0xFF9CA3AF),
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                if (platform.verified)
                  Container(
                    width: 24,
                    height: 24,
                    decoration: const BoxDecoration(
                      color: Color(0xFF3DF416),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check_rounded,
                      size: 16,
                      color: Color(0xFF0F172A),
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

class _AddMorePlatformsButton extends StatelessWidget {
  const _AddMorePlatformsButton({
    required this.isDark,
    required this.onTap,
  });

  final bool isDark;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedBorderPainter(
        color: isDark ? const Color(0xFF4B5563) : const Color(0xFFD1D5DB),
        radius: 14,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: SizedBox(
            width: double.infinity,
            height: 54,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isDark
                          ? const Color(0xFF9CA3AF)
                          : const Color(0xFF6B7280),
                    ),
                  ),
                  child: Icon(
                    Icons.add_rounded,
                    size: 16,
                    color: isDark
                        ? const Color(0xFF9CA3AF)
                        : const Color(0xFF6B7280),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  'Add More Platforms',
                  style: TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w700,
                    color: isDark
                        ? const Color(0xFFD1D5DB)
                        : const Color(0xFF374151),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TrustBadgesRow extends StatelessWidget {
  const _TrustBadgesRow();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: _TrustBadge(
            icon: Icons.verified_user_rounded,
            label: 'Verified Identity',
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: _TrustBadge(
            icon: Icons.speed_rounded,
            label: '98% Reliability',
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: _TrustBadge(
            icon: Icons.eco_rounded,
            label: 'Carbon Warrior',
          ),
        ),
      ],
    );
  }
}

class _TrustBadge extends StatelessWidget {
  const _TrustBadge({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 14, 8, 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: Color(0xFFDCFCE7),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 22, color: const Color(0xFF166534)),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              height: 1.2,
              color: Color(0xFF374151),
            ),
          ),
        ],
      ),
    );
  }
}

class _PrivacyNote extends StatelessWidget {
  const _PrivacyNote({required this.isDark});

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
              'Your social data is used only for trust verification and matching compatibility. We never post on your behalf.',
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

class _DashedBorderPainter extends CustomPainter {
  _DashedBorderPainter({
    required this.color,
    required this.radius,
  });

  final Color color;
  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.4
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Offset.zero & size,
          Radius.circular(radius),
        ),
      );

    const dashWidth = 6.0;
    const dashSpace = 4.0;
    for (final metric in path.computeMetrics()) {
      var distance = 0.0;
      while (distance < metric.length) {
        final next = distance + dashWidth;
        canvas.drawPath(
          metric.extractPath(distance, next.clamp(0, metric.length)),
          paint,
        );
        distance = next + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedBorderPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.radius != radius;
  }
}
