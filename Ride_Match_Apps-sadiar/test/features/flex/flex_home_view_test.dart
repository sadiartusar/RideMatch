import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:ride_match/core/storage/secure_storage_service.dart';
import 'package:ride_match/features/flex/controllers/flex_home_controller.dart';
import 'package:ride_match/features/flex/views/flex_home_view.dart';
import 'package:ride_match/features/onboarding/services/mode_service.dart';

class _FakeSecureStorageService extends SecureStorageService {
  _FakeSecureStorageService() : super();

  final Map<String, String> _storage = {};

  @override
  Future<String?> read(String key) async => _storage[key];

  @override
  Future<void> write(String key, String value) async {
    _storage[key] = value;
  }

  @override
  Future<void> delete(String key) async {
    _storage.remove(key);
  }
}

void main() {
  late _FakeSecureStorageService fakeStorage;
  late ModeService modeService;
  late FlexHomeController flexController;

  setUp(() {
    Get.reset();
    fakeStorage = _FakeSecureStorageService();
    Get.put<SecureStorageService>(fakeStorage, permanent: true);
    modeService = ModeService(secureStorage: fakeStorage);
    Get.put<ModeService>(modeService, permanent: true);
    flexController = FlexHomeController(modeService: modeService);
    Get.put<FlexHomeController>(flexController);
  });

  tearDown(() {
    Get.reset();
  });

  testWidgets('FlexHomeView renders with Flex tab active and full dashboard sections',
      (tester) async {
    tester.view.physicalSize = const Size(1170, 2532);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      const GetMaterialApp(
        home: FlexHomeView(),
      ),
    );
    await tester.pumpAndSettle();

    // Verify header elements
    expect(find.text('Jeremy M. Ralston'), findsOneWidget);
    expect(find.text('VERIFIED MEMBER'), findsOneWidget);

    // Verify mode selector
    expect(find.text('Flex'), findsOneWidget);
    expect(find.text('Riding'), findsOneWidget);
    expect(find.text('Driving'), findsOneWidget);

    // Verify Welcome hero & quote
    expect(find.text('Welcome, Alex'), findsOneWidget);
    expect(find.text('One profile. Three states. Real-time mobility.'),
        findsOneWidget);
    expect(
        find.text('"Your next best move is based on route, wallet, and trust."'),
        findsOneWidget);

    // Verify Welcome Offer card
    expect(find.text('WELCOME OFFER'), findsOneWidget);
    expect(find.text("You've got 500 starter\ncoupons"), findsOneWidget);
    expect(find.text('Open Wallet'), findsOneWidget);

    // Verify Destination card
    expect(find.text('Where are you going?'), findsOneWidget);
    expect(find.text('Set Destination'), findsOneWidget);

    // Scroll down to see middle sections
    await tester.drag(find.byType(SingleChildScrollView), const Offset(0, -600));
    await tester.pumpAndSettle();

    // Verify Verification Card & Commute Circles
    expect(find.text('Verification 60%'), findsOneWidget);
    expect(find.text('Commute Circles'), findsOneWidget);
    expect(find.text('French Speakers'), findsOneWidget);

    // Scroll further down
    await tester.drag(find.byType(SingleChildScrollView), const Offset(0, -600));
    await tester.pumpAndSettle();

    // Verify Social Trust & Earn more coupons & Safety First
    expect(find.text('Social Trust'), findsOneWidget);
    expect(find.text('Earn more coupons'), findsOneWidget);
    expect(find.text('Safety First'), findsOneWidget);

    // Verify Bottom Navigation items
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Find'), findsOneWidget);
    expect(find.text('Chat'), findsOneWidget);
    expect(find.text('Wallet'), findsOneWidget);
    expect(find.text('Profile'), findsOneWidget);
  });
}
