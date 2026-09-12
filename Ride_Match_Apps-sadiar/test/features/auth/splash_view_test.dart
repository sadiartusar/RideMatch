import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:ride_match/core/theme/app_colors.dart';
import 'package:ride_match/features/auth/controllers/auth_controller.dart';
import 'package:ride_match/features/auth/views/splash_view.dart';

class _MockAuthController extends GetxController implements AuthController {
  @override
  Future<void> bootstrap() async {}

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  testWidgets('SplashView renders logo, underline, tagline, and progress indicator', (tester) async {
    Get.put<AuthController>(_MockAuthController());

    await tester.pumpWidget(
      const MaterialApp(
        home: SplashView(),
      ),
    );

    expect(find.text('RideMatch'), findsOneWidget);
    expect(find.text('Meet. Move. Match.'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    final scaffold = tester.widget<Scaffold>(find.byType(Scaffold));
    expect(scaffold.backgroundColor, AppColors.splashBackground);

    // Fast-forward splash timer
    await tester.pump(const Duration(milliseconds: 1600));
  });
}
