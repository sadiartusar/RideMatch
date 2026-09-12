import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../models/quick_route_model.dart';

class QuickRoutesSection extends StatelessWidget {
  const QuickRoutesSection({
    super.key,
    required this.routes,
    required this.onRouteTap,
  });

  final List<QuickRouteModel> routes;
  final ValueChanged<QuickRouteModel> onRouteTap;

  @override
  Widget build(BuildContext context) {
    final primary =
        routes.where((r) => r.kind == QuickRouteKind.primary).toList();
    final secondary =
        routes.where((r) => r.kind != QuickRouteKind.primary).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Routes',
          style: TextStyle(
            color: Color(0xFF111827),
            fontSize: 20,
            fontWeight: FontWeight.w900,
            letterSpacing: -0.4,
          ),
        ),
        const SizedBox(height: 14),
        ...primary.map(
          (route) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _PrimaryRouteCard(
              route: route,
              onTap: () => onRouteTap(route),
            ),
          ),
        ),
        if (secondary.length >= 2)
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: _SecondaryRouteCard(
                    route: secondary[0],
                    onTap: () => onRouteTap(secondary[0]),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _SecondaryRouteCard(
                    route: secondary[1],
                    onTap: () => onRouteTap(secondary[1]),
                  ),
                ),
              ],
            ),
          )
        else
          ...secondary.map(
            (route) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _SecondaryRouteCard(
                route: route,
                onTap: () => onRouteTap(route),
              ),
            ),
          ),
      ],
    );
  }
}

class _PrimaryRouteCard extends StatelessWidget {
  const _PrimaryRouteCard({
    required this.route,
    required this.onTap,
  });

  final QuickRouteModel route;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFF3F4F6),
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.button,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  route.icon,
                  color: const Color(0xFF111827),
                  size: 24,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      route.title,
                      style: const TextStyle(
                        color: Color(0xFF111827),
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      route.subtitle,
                      style: const TextStyle(
                        color: Color(0xFF9CA3AF),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: Color(0xFF9CA3AF),
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SecondaryRouteCard extends StatelessWidget {
  const _SecondaryRouteCard({
    required this.route,
    required this.onTap,
  });

  final QuickRouteModel route;
  final VoidCallback onTap;

  Color get _iconBg {
    return switch (route.kind) {
      QuickRouteKind.airport => const Color(0xFFFBBF24),
      QuickRouteKind.recent => const Color(0xFFE5E7EB),
      QuickRouteKind.primary => AppColors.button,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFF3F4F6),
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 14, 14, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: _iconBg,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  route.icon,
                  color: const Color(0xFF111827),
                  size: 20,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                route.title,
                style: const TextStyle(
                  color: Color(0xFF111827),
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                route.subtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Color(0xFF9CA3AF),
                  fontSize: 12.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
