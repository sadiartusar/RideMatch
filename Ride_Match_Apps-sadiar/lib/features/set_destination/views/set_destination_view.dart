import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../controllers/set_destination_controller.dart';
import '../widgets/set_destination_body.dart';

/// Standalone set-destination route (no bottom nav — home shell owns navigation).
class SetDestinationView extends GetView<SetDestinationController> {
  const SetDestinationView({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: const Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          bottom: false,
          child: SetDestinationBody(),
        ),
      ),
    );
  }
}
