import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/constants/app_constants.dart';
import '../core/routes/app_pages.dart';
import '../core/theme/app_theme.dart';
import 'app_bindings.dart';

/// Root application widget. Configuration only — no business logic.
class RideMatchApp extends StatelessWidget {
  const RideMatchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.light,
      initialBinding: AppBindings(),
      initialRoute: AppPages.initial,
      getPages: AppPages.pages,
      defaultTransition: Transition.cupertino,
      transitionDuration: AppConstants.defaultAnimationDuration,
    );
  }
}
