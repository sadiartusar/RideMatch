import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:ride_match/core/routes/app_routes.dart';
import 'package:ride_match/features/match_list/bindings/match_confirm_binding.dart';
import 'package:ride_match/features/match_list/controllers/match_confirm_controller.dart';
import 'package:ride_match/features/match_list/controllers/match_list_controller.dart';
import 'package:ride_match/features/match_list/views/match_confirm_view.dart';
import 'package:ride_match/features/match_list/views/match_list_view.dart';

void main() {
  setUp(() {
    Get.reset();
    Get.put<MatchListController>(MatchListController());
  });

  tearDown(() {
    Get.reset();
  });

  testWidgets('MatchConfirmView shows request sent UI', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;
    tester.view.padding = const FakeViewPadding(top: 47, bottom: 34);
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPadding);

    Get.put<MatchConfirmController>(MatchConfirmController());

    await tester.pumpWidget(
      const GetMaterialApp(
        home: MatchConfirmView(),
      ),
    );
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.text('Match Confirm'), findsOneWidget);
    expect(find.text('Great Match!'), findsOneWidget);
    expect(find.text('REQUEST SENT'), findsOneWidget);
    expect(find.text('Waiting for Driver Confirmation'), findsOneWidget);
    expect(find.text('AI Matching Rationale'), findsOneWidget);
    expect(find.textContaining('Best match for'), findsOneWidget);
    expect(find.text('High rating and verified profile'), findsOneWidget);
    expect(find.text('Excellent'), findsOneWidget);
    expect(find.text('Pre-Match Chat'), findsOneWidget);
    expect(find.text('View Full Profile'), findsOneWidget);
    expect(find.text('Continue'), findsOneWidget);
  });

  testWidgets('Requesting a driver opens Match Confirm', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      GetMaterialApp(
        home: const MatchListView(),
        getPages: [
          GetPage(
            name: AppRoutes.matchConfirm,
            page: () => const MatchConfirmView(),
            binding: MatchConfirmBinding(),
          ),
        ],
      ),
    );
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('Request'));
    await tester.tap(find.text('Request'));
    await tester.pumpAndSettle();

    expect(find.text('Match Confirm'), findsOneWidget);
    expect(find.text('REQUEST SENT'), findsOneWidget);
    expect(find.text('Waiting for Driver Confirmation'), findsOneWidget);
  });

  testWidgets('Swiping a driver card right opens Match Confirm', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      GetMaterialApp(
        home: const MatchListView(),
        getPages: [
          GetPage(
            name: AppRoutes.matchConfirm,
            page: () => const MatchConfirmView(),
            binding: MatchConfirmBinding(),
          ),
        ],
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Jack M. Kees'), findsOneWidget);
    await tester.timedDrag(
      find.text('Jack M. Kees'),
      const Offset(220, 0),
      const Duration(milliseconds: 300),
    );
    await tester.pumpAndSettle();

    expect(find.text('Match Confirm'), findsOneWidget);
    expect(find.text('REQUEST SENT'), findsOneWidget);
  });
}
