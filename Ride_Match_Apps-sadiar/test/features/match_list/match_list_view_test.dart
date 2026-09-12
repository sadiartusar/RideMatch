import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:ride_match/features/match_list/controllers/match_list_controller.dart';
import 'package:ride_match/features/match_list/views/match_list_view.dart';

void main() {
  late MatchListController controller;

  setUp(() {
    Get.reset();
    controller = MatchListController();
    Get.put<MatchListController>(controller);
  });

  tearDown(() {
    Get.reset();
  });

  testWidgets('MatchListView shows driver cards and pass advances to next',
      (tester) async {
    tester.view.physicalSize = const Size(1170, 2532);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      const GetMaterialApp(
        home: MatchListView(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Match List'), findsOneWidget);
    expect(find.text('3 Drivers nearby'), findsOneWidget);
    expect(find.text('1/3'), findsOneWidget);
    expect(find.text('Jack M. Kees'), findsOneWidget);
    expect(find.text('Request'), findsOneWidget);
    expect(find.text('Pass'), findsOneWidget);
    expect(find.text('Filter'), findsOneWidget);

    await tester.ensureVisible(find.text('Pass'));
    await tester.tap(find.text('Pass'));
    await tester.pumpAndSettle();

    expect(find.text('Jack M. Kees'), findsNothing);
    expect(find.text('Sarah Jenkins'), findsOneWidget);
    expect(find.text('3 Drivers nearby'), findsOneWidget);
    expect(find.text('2/3'), findsOneWidget);

    await tester.ensureVisible(find.text('Pass'));
    await tester.tap(find.text('Pass'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Pass'));
    await tester.tap(find.text('Pass'));
    await tester.pumpAndSettle();

    expect(
      find.text(
        'If you swipe to the left side, the drive card will automatically disappear.',
      ),
      findsOneWidget,
    );
    expect(find.text('Filter'), findsNothing);
  });

  testWidgets('MatchListView fits a phone viewport without overflow',
      (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;
    tester.view.padding = const FakeViewPadding(top: 47, bottom: 34);
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPadding);

    await tester.pumpWidget(
      const GetMaterialApp(
        home: MatchListView(),
      ),
    );
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.text('Match List'), findsOneWidget);
    expect(find.text('Jack M. Kees'), findsOneWidget);
    expect(find.text('Filter'), findsOneWidget);
    expect(find.text('View Profile'), findsOneWidget);
  });
}
