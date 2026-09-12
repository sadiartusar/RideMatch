abstract class AppRoutes {
  AppRoutes._();

  // Auth — splash & welcome
  static const String splash = '/splash';
  static const String authWelcome = '/auth-welcome';

  // Auth — email
  static const String emailLogin = '/email-login';
  static const String emailSignup = '/email-signup';

  // Auth — phone
  static const String phoneEntry = '/phone-entry';
  static const String phoneLogin = '/phone-login';
  static const String phoneSignup = '/phone-signup';

  // Auth — social
  static const String googleSignIn = '/google-sign-in';
  static const String appleSignIn = '/apple-sign-in';

  // Auth — verify / profile setup
  static const String otp = '/otp';
  static const String verificationHub = '/verification-hub';
  static const String profilePhotos = '/profile-photos';
  static const String completeProfile = '/complete-profile';
  static const String connectModeFilter = '/connect-mode-filter';
  static const String tellUsMore = '/tell-us-more';
  static const String socialConnect = '/social-connect';
  static const String backgroundCheck = '/background-check';
  static const String starterRewards = '/starter-rewards';

  // Onboarding / mode
  static const String onboarding = '/onboarding';
  static const String chooseMode = '/choose-mode';

  /// Legacy alias — redirects to the active mode home.
  static const String home = '/home';

  // Mode homes & journeys
  static const String flexHome = '/flex';
  static const String riderHome = '/rider';
  static const String driverHome = '/driver';
  static const String driverSetRoute = '/driver-set-route';
  static const String driverMatchList = '/driver-match-list';
  static const String driverMatchEmpty = '/driver-match-empty';
  static const String driverPreMatchChat = '/driver-pre-match-chat';
  static const String driverChat = '/driver-chat';
  static const String driverMatchConfirm = '/driver-match-confirm';
  static const String driverLiveRide = '/driver-live-ride';
   

  // Shared capabilities
  static const String notifications = '/notifications';
  static const String chat = '/chat';
  static const String chatDetails = '/chat-details';
  static const String booking = '/booking';
  static const String trip = '/trip';
  static const String rideVerify = '/ride-verify';
  static const String rideVerified = '/ride-verified';
  static const String rideImpact = '/ride-impact';
  static const String rateTrip = '/rate-trip';
  static const String payment = '/payment';
  static const String profile = '/profile';
  static const String editProfile = '/edit-profile';
  static const String settings = '/settings';
  static const String communityCircles = '/community-circles';
  static const String communityDetails = '/community-details';
  static const String connections = '/connections';
  static const String connectionRequests = '/connection-requests';

  // Wallet & Marketplace
  static const String wallet = '/wallet';
  static const String marketplace = '/marketplace';
  static const String couponDetail = '/coupon-detail';
  static const String redeemConfirm = '/redeem-confirm';
  static const String redeemedSuccess = '/redeemed-success';
  static const String redeemHistory = '/redeem-history';
  static const String flexWallet = '/flexWallet';
  static const String gasVoucherPayment = '/gas-voucher-payment';
  static const String gasVoucherSuccess = '/gas-voucher-success';
  static const String missions = '/missions';
  static const String missionQuiz = '/mission-quiz';
  static const String quizCompleted = '/quiz-completed';
  

  /// Find tab set-destination flow (Flex / Rider only).
  static const String setDestination = '/set-destination';

  /// After Route Preview — choose Ride Request vs Offer Seats.
  static const String createMode = '/create-mode';

  /// Select reward / coupons for a ride request.
  static const String selectReward = '/select-reward';

  /// Rider match list after offering a reward.
  static const String matchList = '/match-list';

  /// Rider match confirm after requesting a driver.
  static const String matchConfirm = '/match-confirm';

  /// Public driver / user profile opened from match list.
  static const String userProfile = '/user-profile';

  /// Rider pre-match chat after requesting a driver.
  static const String preMatchChat = '/pre-match-chat';
}
