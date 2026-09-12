import 'package:flutter/material.dart';

class SafetyBannerCarousel extends StatelessWidget {
  const SafetyBannerCarousel({
    super.key,
    required this.pageController,
    required this.currentIndex,
    required this.pageCount,
    required this.onPageChanged,
    required this.isDark,
  });

  final PageController pageController;
  final int currentIndex;
  final int pageCount;
  final ValueChanged<int> onPageChanged;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 168,
          child: PageView.builder(
            controller: pageController,
            itemCount: pageCount,
            onPageChanged: onPageChanged,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 1),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: isDark
                        ? const [Color(0xFF1F2937), Color(0xFF111827)]
                        : const [Color(0xFF9CA3AF), Color(0xFF6B7280)],
                  ),
                ),
                clipBehavior: Clip.antiAlias,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Icon(
                          Icons.person_rounded,
                          size: 140,
                          color: Colors.white.withValues(alpha: 0.22),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(18, 22, 110, 18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Your safety is our priority.',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              height: 1.25,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Verified members enjoy 40% faster pickups.',
                            style: TextStyle(
                              fontSize: 13,
                              height: 1.35,
                              fontWeight: FontWeight.w500,
                              color: Colors.white.withValues(alpha: 0.9),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(pageCount, (index) {
            final active = index == currentIndex;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: active ? 22 : 7,
              height: 7,
              decoration: BoxDecoration(
                color: active
                    ? const Color(0xFF3DF416)
                    : (isDark
                        ? const Color(0xFF4B5563)
                        : const Color(0xFFD1D5DB)),
                borderRadius: BorderRadius.circular(999),
              ),
            );
          }),
        ),
      ],
    );
  }
}
