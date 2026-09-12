import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:ride_match/core/storage/secure_storage_service.dart';
import 'package:ride_match/features/driver/controllers/driver_home_controller.dart';
import 'package:ride_match/features/driver/models/driver_availability_status.dart';
import 'package:ride_match/features/driver/views/driver_home_view.dart';
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
  late DriverHomeController driverController;

  setUp(() {
    Get.reset();
    fakeStorage = _FakeSecureStorageService();
    Get.put<SecureStorageService>(fakeStorage, permanent: true);
    modeService = ModeService(secureStorage: fakeStorage);
    Get.put<ModeService>(modeService, permanent: true);
    driverController = DriverHomeController(modeService: modeService);
    Get.put<DriverHomeController>(driverController);
  });

  tearDown(() {
    Get.reset();
  });

  testWidgets('DriverHomeView renders all dashboard sections and elements',
      (tester) async {
    tester.view.physicalSize = const Size(1170, 2532);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      const GetMaterialApp(
        home: DriverHomeView(),
      ),
    );
    await tester.pumpAndSettle();

    // Verify header elements
    expect(find.text('Jeremy M. Ralston'), findsOneWidget);
    expect(find.text('NOT VERIFIED MEMBER'), findsOneWidget);

    // Verify mode selector
    expect(find.text('Flex'), findsOneWidget);
    expect(find.text('Riding'), findsOneWidget);
    expect(find.text('Driving'), findsOneWidget);

    // Verify Welcome hero
    expect(find.text('Welcome, Alex'), findsOneWidget);
    expect(find.text('Your driver side is ready to set up.'), findsOneWidget);
    expect(find.text('One profile. Drive when you want. Receive securely.'),
        findsOneWidget);

    // Verify Receiving Wallet card
    expect(find.text('Receiving Wallet'), findsOneWidget);
    expect(find.text('Open Wallet'), findsOneWidget);

    // Verify Set Route card
    expect(find.text('Set your route to find nearby riders'), findsOneWidget);
    expect(find.text('Set Route'), findsOneWidget);

    // Verify Availability Status
    expect(find.text('AVAILABILITY STATUS'), findsOneWidget);
    expect(find.text('Available'), findsOneWidget);
    expect(find.text('Busy'), findsOneWidget);
    expect(find.text('Offline'), findsOneWidget);
    expect(find.text('Scheduled Commute'), findsOneWidget);

    // Scroll to see more sections
    await tester.drag(find.byType(SingleChildScrollView), const Offset(0, -600));
    await tester.pumpAndSettle();

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

    // Verify Build your trust
    expect(find.text('Build your trust'), findsOneWidget);
    expect(find.text('SOCIAL LINKS:'), findsOneWidget);
    expect(find.text('Facebook Connected'), findsOneWidget);
    expect(find.text('Instagram Connected'), findsOneWidget);
    expect(find.text('TikTok Connected'), findsOneWidget);
    expect(find.text('LinkedIn Connected'), findsOneWidget);

    // Verify Driver Trust Setup
    expect(find.text('Driver Trust Setup'), findsOneWidget);
    expect(find.text('50% READY'), findsOneWidget);
    expect(find.text('Photo'), findsOneWidget);
    expect(find.text('Bio'), findsOneWidget);
    expect(find.text('Vehicle'), findsOneWidget);
    expect(find.text('License'), findsOneWidget);

    // Verify Safety First
    expect(find.text('Safety First'), findsOneWidget);

    // Verify Bottom Navigation items
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Route'), findsOneWidget);
    expect(find.text('Chat'), findsOneWidget);
    expect(find.text('Wallet'), findsOneWidget);
    expect(find.text('Profile'), findsOneWidget);
  });

  testWidgets('DriverHomeView toggles availability status', (tester) async {
    tester.view.physicalSize = const Size(1170, 2532);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      const GetMaterialApp(
        home: DriverHomeView(),
      ),
    );
    await tester.pumpAndSettle();

    expect(
        driverController.availabilityStatus.value, DriverAvailabilityStatus.available);

    // Scroll to Busy and tap
    await tester.scrollUntilVisible(
      find.text('Busy'),
      100,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Busy'));
    await tester.pumpAndSettle();

    expect(driverController.availabilityStatus.value, DriverAvailabilityStatus.busy);

    // Scroll to Scheduled Commute and tap
    await tester.scrollUntilVisible(
      find.text('Scheduled Commute'),
      100,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Scheduled Commute'));
    await tester.pumpAndSettle();

    expect(driverController.availabilityStatus.value,
        DriverAvailabilityStatus.scheduledCommute);

    // Let snackbar timer finish
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();
  });
}
