import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ride_match/core/constants/app_constants.dart';
import 'package:ride_match/core/theme/app_theme.dart';
import 'package:ride_match/core/widgets/app_button.dart';
import 'package:ride_match/features/trip/models/trip_status.dart';

void main() {
  test('app constants are configured', () {
    expect(AppConstants.appName, 'Ride Match');
  });

  test('trip status foundation is available', () {
    expect(TripStatus.idle.displayName, 'Idle');
    expect(TripStatus.started.isActive, isTrue);
    expect(TripStatus.completed.isActive, isFalse);
  });

  testWidgets('AppButton renders and responds', (tester) async {
    var tapped = false;

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        home: Scaffold(
          body: AppButton(label: 'Continue', onPressed: () => tapped = true),
        ),
      ),
    );

    expect(find.text('Continue'), findsOneWidget);
    await tester.tap(find.text('Continue'));
    expect(tapped, isTrue);
  });
}
