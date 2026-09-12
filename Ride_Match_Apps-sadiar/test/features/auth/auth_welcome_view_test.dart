import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:ride_match/core/storage/secure_storage_service.dart';
import 'package:ride_match/features/auth/controllers/auth_controller.dart';
import 'package:ride_match/features/auth/views/auth_welcome_view.dart';
import 'package:ride_match/features/onboarding/models/user_mode.dart';
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

class _MockAuthController extends GetxController implements AuthController {
  @override
  final RxBool isLoading = false.obs;

  @override
  final RxString errorMessage = ''.obs;

  String? lastContinueEmail;

  @override
  Future<void> continueWithEmail(String email) async {
    lastContinueEmail = email;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  late _FakeSecureStorageService fakeStorage;
  late ModeService modeService;
  late _MockAuthController mockAuthController;

  setUp(() {
    Get.reset();
    fakeStorage = _FakeSecureStorageService();
    modeService = ModeService(secureStorage: fakeStorage);
    Get.put<ModeService>(modeService, permanent: true);
    mockAuthController = _MockAuthController();
    Get.put<AuthController>(mockAuthController, permanent: true);
  });

  testWidgets('AuthWelcomeView renders white screen when Rider mode is active', (
    tester,
  ) async {
    await modeService.setMode(UserMode.rider);

    await tester.pumpWidget(
      const GetMaterialApp(
        home: AuthWelcomeView(),
      ),
    );

    expect(find.text('RIDEMATCH'), findsOneWidget);
    expect(find.text('Welcome Back'), findsOneWidget);
    expect(find.text('Sign in or create an account to start matching'), findsOneWidget);
    expect(find.text('Continue with Apple'), findsOneWidget);
    expect(find.text('Continue with Google'), findsOneWidget);
    expect(find.text('Continue with Phone'), findsOneWidget);
    expect(find.text('EMAIL'), findsOneWidget);
    expect(find.text('Continue'), findsOneWidget);

    final scaffold = tester.widget<Scaffold>(find.byType(Scaffold));
    expect(scaffold.backgroundColor, Colors.white);
  });

  testWidgets('AuthWelcomeView renders white screen when Flex mode is active', (
    tester,
  ) async {
    await modeService.setMode(UserMode.flex);

    await tester.pumpWidget(
      const GetMaterialApp(
        home: AuthWelcomeView(),
      ),
    );

    final scaffold = tester.widget<Scaffold>(find.byType(Scaffold));
    expect(scaffold.backgroundColor, Colors.white);
  });

  testWidgets('AuthWelcomeView renders dark UI when Driver mode is active', (
    tester,
  ) async {
    await modeService.setMode(UserMode.driver);

    await tester.pumpWidget(
      const GetMaterialApp(
        home: AuthWelcomeView(),
      ),
    );

    final scaffold = tester.widget<Scaffold>(find.byType(Scaffold));
    expect(scaffold.backgroundColor, const Color(0xFF0B0D0F));

    final welcomeText = tester.widget<Text>(find.text('Welcome Back'));
    expect(welcomeText.style?.color, Colors.white);
  });

  testWidgets('Tapping Continue starts email continue flow', (tester) async {
    await modeService.setMode(UserMode.rider);

    await tester.pumpWidget(
      const GetMaterialApp(
        home: AuthWelcomeView(),
      ),
    );

    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();

    expect(mockAuthController.lastContinueEmail, 'carlton.johnson@email.com');
  });
}
