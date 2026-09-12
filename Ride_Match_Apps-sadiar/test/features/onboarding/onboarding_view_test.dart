import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:ride_match/core/storage/secure_storage_service.dart';
import 'package:ride_match/features/onboarding/bindings/mode_binding.dart';
import 'package:ride_match/features/onboarding/controllers/onboarding_controller.dart';
import 'package:ride_match/features/onboarding/models/user_mode.dart';
import 'package:ride_match/features/onboarding/services/mode_service.dart';
import 'package:ride_match/features/onboarding/views/choose_mode_view.dart';
import 'package:ride_match/features/onboarding/views/onboarding_view.dart';

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

  setUp(() {
    Get.reset();
    fakeStorage = _FakeSecureStorageService();
    Get.put<SecureStorageService>(fakeStorage, permanent: true);
    modeService = ModeService(secureStorage: fakeStorage);
    Get.put<ModeService>(modeService, permanent: true);
    Get.put<OnboardingController>(OnboardingController(modeService: modeService));
  });

  testWidgets('OnboardingView renders first slide and advances on CONTINUE', (tester) async {
    await tester.pumpWidget(
      GetMaterialApp(
        initialRoute: '/onboarding',
        getPages: [
          GetPage(name: '/onboarding', page: () => const OnboardingView()),
          GetPage(
            name: '/choose-mode',
            page: () => const ChooseModeView(),
            binding: ModeBinding(),
          ),
        ],
      ),
    );

    // Slide 1 checks
    expect(find.textContaining('Share the'), findsOneWidget);
    expect(find.textContaining('Journey'), findsOneWidget);
    expect(find.text('Sarah J.'), findsOneWidget);
    expect(find.text('Marcus T.'), findsOneWidget);
    expect(find.text('CONTINUE'), findsOneWidget);
    expect(find.text('Skip'), findsOneWidget);

    // Tap CONTINUE -> moves to Slide 2
    await tester.tap(find.text('CONTINUE'));
    await tester.pumpAndSettle();

    // Slide 2 checks
    expect(find.text('Verified and\nprotected'), findsOneWidget);
    expect(find.text('SOS ACTIVE'), findsOneWidget);
    expect(find.text('CONTINUE'), findsOneWidget);

    // Tap CONTINUE -> moves to Slide 3
    await tester.tap(find.text('CONTINUE'));
    await tester.pumpAndSettle();

    // Slide 3 checks
    expect(find.text('Make Every Journey\nRewarding'), findsOneWidget);
    expect(find.text('Gain instead of earn'), findsOneWidget);
    expect(find.text('12.5kg'), findsOneWidget);
    expect(find.text('GET STARTED'), findsOneWidget);
    expect(find.text('Skip'), findsNothing);
  });

  testWidgets('Tapping GET STARTED navigates to ChooseModeView and records completion', (tester) async {
    await tester.pumpWidget(
      GetMaterialApp(
        initialRoute: '/onboarding',
        getPages: [
          GetPage(name: '/onboarding', page: () => const OnboardingView()),
          GetPage(
            name: '/choose-mode',
            page: () => const ChooseModeView(),
            binding: ModeBinding(),
          ),
        ],
      ),
    );

    final controller = Get.find<OnboardingController>();
    controller.pageController.jumpToPage(2);
    await tester.pumpAndSettle();

    expect(find.text('GET STARTED'), findsOneWidget);
    await tester.tap(find.text('GET STARTED'));
    await tester.pumpAndSettle();

    final hasCompleted = await modeService.hasCompletedOnboarding();
    expect(hasCompleted, isTrue);

    // Should now be on Choose your mode
    expect(find.text('Choose your mode'), findsOneWidget);
    expect(find.text('Choose Flex'), findsOneWidget);
  });

  testWidgets('ChooseModeView renders options, tags, note and handles role selection', (tester) async {
    tester.view.physicalSize = const Size(1080, 4000);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(
      GetMaterialApp(
        initialRoute: '/choose-mode',
        getPages: [
          GetPage(
            name: '/choose-mode',
            page: () => const ChooseModeView(),
            binding: ModeBinding(),
          ),
          GetPage(name: '/auth-welcome', page: () => const SizedBox()),
        ],
      ),
    );

    expect(find.text('Choose your mode'), findsOneWidget);
    expect(find.text('Flex'), findsOneWidget);
    expect(find.text('Rider'), findsOneWidget);
    expect(find.text('Driver'), findsOneWidget);
    expect(find.text('Note'), findsOneWidget);
    expect(find.textContaining('The mode can be changed anytime later'), findsOneWidget);

    // Tap Choose Rider
    await tester.tap(find.text('Choose Rider'));
    await tester.pumpAndSettle();

    expect(modeService.currentMode, UserMode.rider);
  });
}
