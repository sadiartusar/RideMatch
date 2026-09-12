# Ride Match — Architecture

A pragmatic **Feature-First** architecture built on **Flutter + GetX + Dio**.

Guiding principle:

```
APP      = application configuration
CORE     = infrastructure
FEATURES = business functionality
SHARED   = genuinely reusable components
```

No Clean Architecture use-case layers, no repositories-for-the-sake-of-repositories, no
second state-management package. The flow is intentionally short and readable.

---

## 1. Top-level structure

```
lib/
├── app/         application startup & configuration
├── core/        infrastructure shared by every feature
├── features/    all business functionality
├── shared/      widgets/components/models reused by multiple features
└── main.dart    entry point only
```

---

## 2. `app/` — application configuration

| File | Responsibility |
| --- | --- |
| `app.dart` | Root widget (`GetMaterialApp`): theme, routes, initial binding, transitions |
| `app_bindings.dart` | Global GetX dependency registration (`SecureStorageService`, `ApiClient`) |
| `app_config.dart` | Environment enum + per-environment base URL and logging flags |
| `app_initializer.dart` | Pre-first-frame work: binding init, environment selection, Firebase later |

`main.dart` stays minimal:

```dart
Future<void> main() async {
  await AppInitializer.run(environment: Environment.development);
  runApp(const RideMatchApp());
}
```

**Rule:** no business logic in `app/`.

---

## 3. `core/` — infrastructure only

```
core/
├── constants/     app + api constants
├── errors/        ApiException & ApiErrorType
├── network/       api_client.dart, api_endpoints.dart, interceptors/
├── realtime/      realtime_service.dart (interface, not implemented yet)
├── routes/        app_routes.dart, app_pages.dart
├── storage/       secure_storage_service.dart, storage_keys.dart
├── theme/         app_theme, app_colors, app_text_styles, app_dimensions
├── utils/         logger.dart, validators.dart
└── widgets/       app_button, app_text_field, app_loading, app_error_view
```

**Rule:** `core/` must never import from `features/`, and never contain
business-specific logic.

```
WRONG:   core/booking_service.dart
CORRECT: features/booking/services/booking_service.dart

WRONG:   core/trip_controller.dart
CORRECT: features/trip/controllers/trip_controller.dart
```

`core/` also does not read `AppConfig` directly. Configuration is *injected downward*:
`AppBindings` passes `baseUrl` and `enableLogging` into `ApiClient`, and
`AppInitializer` sets `AppLogger.enabled`. This keeps `core/` independently testable.

---

## 4. `features/` — business functionality

Every feature is self-contained and uses the same six folders:

```
features/<feature>/
├── bindings/      GetX dependency injection for the feature
├── controllers/   UI/application state (GetxController)
├── models/        feature data models
├── services/      API/data operations via ApiClient
├── views/         screens
└── widgets/       widgets used only by this feature
```

Feature directories currently scaffolded:

```
auth, onboarding, home,
flex, rider, driver,
booking, trip, map, payment, wallet,
chat, notification, history, rating, profile, support, settings
```

### Mode journeys (Flex / Rider / Driver)

Auth (login/signup) and Choose Mode are **common**.

After mode selection, each journey lives in its own feature folder:

- `features/flex/` — Flex home + Flex-only screens; can open Rider/Driver entry points
- `features/rider/` — Rider journey UI + rider-specific logic
- `features/driver/` — Driver journey UI + driver-specific logic

Shared capabilities (trip, map, chat, wallet, payment) stay as separate features and are
reused by modes — do not triplicate them under each mode folder.

`ModeService` persists `StorageKeys.userMode` and resolves the post-auth route.

Only `auth`, `onboarding`, `home`, `flex`, `rider`, `driver`, and `trip` contain Dart
files today. **Files are created when the feature is actually built** — empty placeholder
classes are not committed.

---

## 5. Data flow

```
View (UI)
   ↓  calls controller methods
Controller (GetxController)   — state: loading / success / error / empty
   ↓  calls service methods
Service                       — request/response shaping, storage, realtime
   ↓
ApiClient (Dio)               — base URL, headers, timeouts, interceptors, error mapping
   ↓
Backend API
```

Concrete example:

```
LoginView → AuthController.login() → AuthService.login() → ApiClient.post() → REST API
```

### Forbidden dependencies

```
UI → ApiClient
UI → Dio
Feature A → Feature B's controller
core/ → features/
```

```dart
// WRONG
onPressed: () => Dio().get(...)

// CORRECT
onPressed: controller.login
```

---

## 6. GetX usage

### State

Reactive fields on the controller, `Obx` in the view:

```dart
final RxBool isLoading = false.obs;
final RxString errorMessage = ''.obs;
final Rxn<UserModel> currentUser = Rxn<UserModel>();
```

```dart
Obx(() => controller.isLoading.value
    ? const AppLoading()
    : AppButton(label: 'Login', onPressed: controller.login))
```

### Controllers

Feature-scoped and small. There is deliberately **no `AppController`** holding all app
state — only genuinely global state (session, connectivity) may be global, and it lives
in the feature that owns it (e.g. `AuthController`).

---

## 7. Dependency injection

Two levels only.

**Global** — `app/app_bindings.dart`, registered as `initialBinding`:

```dart
Get.put<SecureStorageService>(SecureStorageService(), permanent: true);
Get.put<ApiClient>(ApiClient(...), permanent: true);
```

**Per feature** — a `Bindings` class attached to the route:

```dart
class BookingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookingService>(
      () => BookingService(apiClient: Get.find<ApiClient>()),
    );
    Get.lazyPut<BookingController>(
      () => BookingController(bookingService: Get.find<BookingService>()),
    );
  }
}
```

Guidelines:

- Dependencies are constructor-injected, so controllers/services are unit-testable.
- `lazyPut` for normal feature screens; `permanent: true` only for session-lifetime
  objects (`AuthService`, `AuthController`).
- Do not instantiate feature controllers inside widgets.

---

## 8. Routing

Centralised in `core/routes/`.

```dart
// app_routes.dart — names only
abstract class AppRoutes {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String home = '/home';
}
```

```dart
// app_pages.dart — name + page + binding
GetPage(name: AppRoutes.home, page: () => const HomeView(), binding: HomeBinding()),
```

Navigate with `Get.toNamed(AppRoutes.home)` / `Get.offAllNamed(...)`. Never construct a
view directly for navigation, and never hardcode a route string at a call site.

---

## 9. Networking

`core/network/api_client.dart` is the single Dio instance. It owns:

base URL · headers · timeouts · interceptors · request execution ·
error normalisation into `ApiException`

Interceptors:

- `auth_interceptor.dart` — attaches the bearer token from secure storage; hook for
  refresh-token retry.
- `logging_interceptor.dart` — request/response/error logging, attached only when the
  environment enables logging.

Endpoints live in `core/network/api_endpoints.dart`:

```dart
static const String login = '/auth/login';
```

**No hardcoded URLs inside features.**

### Error handling

`ApiClient` maps `DioException` to a typed `ApiException` (`timeout`, `noInternet`,
`unauthorized`, `forbidden`, `notFound`, `validation`, `server`, `unknown`). Controllers
therefore contain no HTTP-status logic — they only translate an error into UI state:

```dart
try {
  ...
} on ApiException catch (e) {
  errorMessage.value = e.message;
}
```

---

## 10. Storage

`core/storage/secure_storage_service.dart` wraps `flutter_secure_storage` for sensitive
values (access token, refresh token, user id). Keys are centralised:

```dart
StorageKeys.accessToken
StorageKeys.refreshToken
StorageKeys.userId
```

Non-sensitive preferences should later use a separate service — not secure storage.

---

## 11. Realtime (prepared, not implemented)

`core/realtime/realtime_service.dart` defines the interface only
(`connect`, `disconnect`, `isConnected`). A WebSocket/Socket.IO implementation will be
added later.

Intended flow — identical to REST:

```
RealtimeService → Feature Service → Controller → UI
```

Feature-specific realtime handling (driver location, trip status, chat messages) belongs
in that feature's service, not in `core/`. Widgets never touch sockets.

---

## 12. `shared/`

```
shared/
├── widgets/       reusable widgets used by 2+ features
├── components/    larger composite UI pieces
└── models/        cross-feature models
```

`shared/` is not a dumping ground. If only booking uses it, it belongs in
`features/booking/widgets/`. Generic design-system widgets stay in `core/widgets/`.

---

## 13. How to add a new feature

Example: `wallet`.

1. Create the folders you actually need under `lib/features/wallet/`.
2. `models/wallet_model.dart` — data model with `fromJson`/`toJson`.
3. `services/wallet_service.dart` — takes `ApiClient` via constructor, uses
   `ApiEndpoints.*`. Add any new endpoint constants to `api_endpoints.dart`.
4. `controllers/wallet_controller.dart` — takes the service via constructor, exposes
   `Rx` state, catches `ApiException`.
5. `views/wallet_view.dart` — reads state through `Obx`, calls controller methods only.
6. `bindings/wallet_binding.dart` — `lazyPut` the service and controller.
7. Add `AppRoutes.wallet` and a `GetPage` entry with `WalletBinding()`.
8. Run `dart format .` and `flutter analyze`.

---

## 14. Rules developers must follow

1. Respect the flow: **UI → Controller → Service → ApiClient**.
2. UI never touches Dio or `ApiClient`.
3. No feature imports another feature's controller. Communicate via routes/arguments, or
   promote genuinely shared logic to `core/` or `shared/`.
4. `core/` never imports `features/`.
5. Feature-specific models, services and controllers stay in their feature.
6. No hardcoded URLs, colours, text styles, spacing or secrets.
7. All API paths go through `ApiEndpoints`; all storage keys through `StorageKeys`.
8. Keep controllers small and single-purpose; no god controllers.
9. Register dependencies through bindings, not manual instantiation in widgets.
10. Null safety everywhere; constructor injection for testability.
11. Only add a file when it is needed — no speculative empty classes.
12. Do not introduce another state-management or DI package.

---

## 15. Current implementation status

Implemented as a proof that the architecture works:

- App initialization, global bindings, theming (light + dark), GetX routing
- `Splash → Login → Home` flow
- `AuthController`, `AuthService` (mocked login), `UserModel`
- `HomeController`, `HomeView`
- `ApiClient` with auth/logging interceptors and error normalisation
- `SecureStorageService` with centralised keys
- Reusable widgets: `AppButton`, `AppTextField`, `AppLoading`, `AppErrorView`

Intentionally **not** implemented: payments, full booking, Google Maps, driver tracking,
chat backend, WebSocket transport, production API integration. `AuthService` uses mock
logic with the real request shape documented inline.
