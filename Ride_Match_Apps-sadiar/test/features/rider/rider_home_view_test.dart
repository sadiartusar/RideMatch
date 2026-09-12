import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:ride_match/core/storage/secure_storage_service.dart';
import 'package:ride_match/features/onboarding/services/mode_service.dart';
import 'package:ride_match/features/rider/controllers/rider_home_controller.dart';
import 'package:ride_match/features/rider/views/rider_home_view.dart';

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
  late RiderHomeController riderController;

  setUp(() {
    Get.reset();
    fakeStorage = _FakeSecureStorageService();
    Get.put<SecureStorageService>(fakeStorage, permanent: true);
    modeService = ModeService(secureStorage: fakeStorage);
    Get.put<ModeService>(modeService, permanent: true);
    riderController = RiderHomeController(modeService: modeService);
    Get.put<RiderHomeController>(riderController);
  });

  tearDown(() {
    Get.reset();
  });

  testWidgets('RiderHomeView renders all dashboard sections and elements',
      (tester) async {
    tester.view.physicalSize = const Size(1170, 2532);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      const GetMaterialApp(
        home: RiderHomeView(),
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
    expect(find.text('Search your route to find the best match.'), findsOneWidget);
    expect(find.text('DESTINATION'), findsOneWidget);
    expect(find.text('Set Destination'), findsOneWidget);

    // Scroll to see middle sections
    await tester.drag(find.byType(SingleChildScrollView), const Offset(0, -600));
    await tester.pumpAndSettle();

    // Verify Verification Card
    expect(find.text('Verification 60%'), findsOneWidget);
    expect(find.text('PENDING'), findsOneWidget);
    expect(find.text('Complete ID'), findsOneWidget);

    // Verify Commute Circles
    expect(find.text('Commute Circles'), findsOneWidget);
    expect(find.text('View all'), findsOneWidget);
    expect(find.text('French Speakers'), findsOneWidget);
    expect(find.text('Tech Enthusiasts'), findsOneWidget);
    expect(find.text('Foodies Unites'), findsOneWidget);
    expect(find.text('Women-only'), findsOneWidget);

    // Scroll further down
    await tester.drag(find.byType(SingleChildScrollView), const Offset(0, -600));
    await tester.pumpAndSettle();

    // Verify Social Trust
    expect(find.text('Social Trust'), findsOneWidget);
    expect(find.text('SOCIAL LINKS:'), findsOneWidget);
    expect(find.text('Facebook Connected'), findsOneWidget);
    expect(find.text('Instagram Connected'), findsOneWidget);
    expect(find.text('TikTok Connected'), findsOneWidget);
    expect(find.text('LinkedIn Connected'), findsOneWidget);

    // Verify Earn more coupons
    expect(find.text('Earn more coupons'), findsOneWidget);
    expect(find.text('VIEW ALL'), findsOneWidget);
    expect(find.text('Watch & Answer'), findsOneWidget);
    expect(find.text('Invite a Friend'), findsOneWidget);

    // Verify Safety First
    expect(find.text('Safety First'), findsOneWidget);
    expect(find.text('Learn more'), findsOneWidget);

    // Verify Bottom Navigation items
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Find'), findsOneWidget);
    expect(find.text('Chat'), findsOneWidget);
    expect(find.text('Wallet'), findsOneWidget);
    expect(find.text('Profile'), findsOneWidget);
  });

  testWidgets('RiderHomeView destination field works correctly', (tester) async {
    tester.view.physicalSize = const Size(1170, 2532);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      const GetMaterialApp(
        home: RiderHomeView(),
      ),
    );
    await tester.pumpAndSettle();

    // Enter text in destination field
    final textFieldFinder = find.byType(TextField);
    expect(textFieldFinder, findsOneWidget);

    await tester.enterText(textFieldFinder, 'Downtown Central');
    expect(riderController.destinationController.text, 'Downtown Central');

    // Scroll until Set Destination is visible and tap
    await tester.scrollUntilVisible(
      find.text('Set Destination'),
      100,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Set Destination'));
    await tester.pumpAndSettle();

    // Let snackbar finish
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();
  });
}
