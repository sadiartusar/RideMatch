import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../main_nav/widgets/app_mode_bottom_nav.dart';
import '../controllers/match_list_controller.dart';
import '../widgets/match_driver_card.dart';

class MatchListView extends GetView<MatchListController> {
  const MatchListView({super.key});

  static const double _phoneMaxWidth = 430;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Obx(() {
        final isEmpty = controller.isEmpty;
        final background =
            isEmpty ? Colors.white : const Color(0xFFF7F8FA);

        return Scaffold(
          backgroundColor: background,
          body: SafeArea(
            bottom: false,
            child: Align(
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: _phoneMaxWidth),
                child: isEmpty
                    ? _EmptyMatchesView(onBack: controller.goBack)
                    : _MatchListBody(controller: controller),
              ),
            ),
          ),
          bottomNavigationBar: AppModeBottomNav(
            selectedIndex: controller.selectedNavIndex.value,
            onTap: controller.onNavTap,
          ),
        );
      }),
    );
  }
}

class _MatchListBody extends StatelessWidget {
  const _MatchListBody({required this.controller});

  final MatchListController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _MatchListHeader(onBack: controller.goBack),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 2, 20, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                controller.nearbyLabel,
                style: const TextStyle(
                  color: Color(0xFF16A34A),
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                '${controller.displayCurrentNumber}/${controller.totalInitialCount.value}',
                style: const TextStyle(
                  color: Color(0xFF16A34A),
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final style = MatchCardStyle.fromAvailableHeight(
                constraints.maxHeight,
              );
              return Align(
                alignment: Alignment.topCenter,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 4),
                    child: _CardStack(
                      remaining: controller.matches.length,
                      child: MatchDriverCard(
                        key: ValueKey(controller.matches.first.id),
                        match: controller.matches.first,
                        style: style,
                        onSwipeLeft: controller.swipeLeft,
                        onSwipeRight: controller.swipeRight,
                        onRequest: () =>
                            controller.requestRide(controller.matches.first),
                        onPass: controller.passCurrent,
                        onViewProfile: () =>
                            controller.viewProfile(controller.matches.first),
                        onSocialTap: controller.openSocial,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
          child: SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: controller.openFilter,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.button,
                foregroundColor: const Color(0xFF111827),
                elevation: 0,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                'Filter',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _CardStack extends StatelessWidget {
  const _CardStack({
    required this.remaining,
    required this.child,
  });

  final int remaining;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        if (remaining > 1)
          Positioned(
            left: 10,
            right: 10,
            top: 10,
            bottom: 0,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: const Color(0xFFEEF0F3),
                borderRadius: BorderRadius.circular(22),
              ),
            ),
          ),
        Padding(
          padding: EdgeInsets.only(bottom: remaining > 1 ? 10 : 0),
          child: child,
        ),
      ],
    );
  }
}

class _MatchListHeader extends StatelessWidget {
  const _MatchListHeader({required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 2, 4, 0),
      child: SizedBox(
        height: 44,
        child: Row(
          children: [
            IconButton(
              onPressed: onBack,
              visualDensity: VisualDensity.compact,
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 18,
                color: Color(0xFF111827),
              ),
            ),
            const Expanded(
              child: Text(
                'Match List',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF111827),
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.2,
                ),
              ),
            ),
            const SizedBox(width: 48),
          ],
        ),
      ),
    );
  }
}

class _EmptyMatchesView extends StatelessWidget {
  const _EmptyMatchesView({required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _MatchListHeader(onBack: onBack),
        const Expanded(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 36),
              child: Text(
                'If you swipe to the left side, the drive card will automatically disappear.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF111827),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  height: 1.45,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
