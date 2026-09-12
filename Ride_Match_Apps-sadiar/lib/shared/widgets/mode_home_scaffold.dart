import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimensions.dart';
import '../../core/widgets/app_button.dart';

/// Lightweight shell used by Rider / Driver / Flex homes until full UI lands.
class ModeHomeScaffold extends StatelessWidget {
  const ModeHomeScaffold({
    super.key,
    required this.title,
    required this.subtitle,
    required this.userName,
    required this.onChangeMode,
    required this.onLogout,
    this.actions = const [],
  });

  final String title;
  final String subtitle;
  final String userName;
  final VoidCallback onChangeMode;
  final VoidCallback onLogout;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
            tooltip: 'Change mode',
            onPressed: onChangeMode,
            icon: const Icon(Icons.swap_horiz_rounded),
          ),
          IconButton(
            tooltip: 'Logout',
            onPressed: onLogout,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppDimensions.spacingLg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hello, $userName', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: AppDimensions.spacingSm),
            Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: AppDimensions.spacingLg),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppDimensions.spacingMd),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkSurface : AppColors.surface,
                borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
                border: Border.all(
                  color: isDark ? AppColors.darkBorder : AppColors.border,
                ),
              ),
              child: Text(
                'You are in $title mode. Journey screens for this flow will '
                'live under features/${title.toLowerCase()}/.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            if (actions.isNotEmpty) ...[
              const SizedBox(height: AppDimensions.spacingLg),
              ...actions,
            ],
            const Spacer(),
            AppButton(label: 'Change mode', onPressed: onChangeMode),
            const SizedBox(height: AppDimensions.spacingMd),
            AppButton(label: 'Sign out', onPressed: onLogout),
          ],
        ),
      ),
    );
  }
}
