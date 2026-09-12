import 'package:get/get.dart';
import 'package:ride_match/features/flex_wallet/bindings/flex_wallet_binding.dart';
import 'package:ride_match/features/flex_wallet/views/flex_wallet_view.dart';
import 'package:ride_match/features/flex_wallet/views/gas_voucher_payment_view.dart';
import 'package:ride_match/features/flex_wallet/views/gas_voucher_success_view.dart';
import 'package:ride_match/features/flex_wallet/views/mission_quiz_view.dart';
import 'package:ride_match/features/flex_wallet/views/missions_view.dart';
import 'package:ride_match/features/flex_wallet/views/quiz_completed_view.dart';

import '../../features/auth/bindings/auth_binding.dart';
import '../../features/auth/views/apple_sign_in_view.dart';
import '../../features/auth/views/auth_welcome_view.dart';
import '../../features/auth/views/email_login_view.dart';
import '../../features/auth/views/email_signup_view.dart';
import '../../features/auth/views/google_sign_in_view.dart';
import '../../features/auth/views/otp_view.dart';
import '../../features/auth/views/phone_entry_view.dart';
import '../../features/auth/views/phone_login_view.dart';
import '../../features/auth/views/phone_signup_view.dart';
import '../../features/auth/views/splash_view.dart';
import '../../features/chat/bindings/chat_details_binding.dart';
import '../../features/chat/bindings/chat_list_binding.dart';
import '../../features/chat/views/chat_details_view.dart';
import '../../features/chat/views/chat_list_view.dart';
import '../../features/community_circle/bindings/community_circles_binding.dart';
import '../../features/community_circle/bindings/community_details_binding.dart';
import '../../features/community_circle/views/community_circles_view.dart';
import '../../features/community_circle/views/community_details_view.dart';
import '../../features/connections/bindings/connection_requests_binding.dart';
import '../../features/connections/bindings/connections_binding.dart';
import '../../features/connections/views/connection_requests_view.dart';
import '../../features/connections/views/connections_view.dart';
import '../../features/driver/bindings/driver_binding.dart';
import '../../features/driver/bindings/driver_chat_binding.dart';
import '../../features/driver/bindings/driver_live_ride_binding.dart';
import '../../features/driver/bindings/driver_match_confirm_binding.dart';
import '../../features/driver/bindings/driver_match_list_binding.dart';
import '../../features/driver/bindings/driver_pre_match_chat_binding.dart';
import '../../features/driver/bindings/driver_set_route_binding.dart';
import '../../features/driver/views/driver_chat_view.dart';
import '../../features/driver/views/driver_home_view.dart';
import '../../features/driver/views/driver_live_ride_view.dart';
import '../../features/driver/views/driver_match_confirm_view.dart';
import '../../features/driver/views/driver_match_empty_view.dart';
import '../../features/driver/views/driver_match_list_view.dart';
import '../../features/driver/views/driver_pre_match_chat_view.dart';
import '../../features/driver/views/driver_set_route_view.dart';
import '../../features/edit_profile/bindings/edit_profile_binding.dart';
import '../../features/edit_profile/views/edit_profile_view.dart';
import '../../features/flex/bindings/flex_binding.dart';
import '../../features/flex/views/flex_home_view.dart';
import '../../features/home/bindings/home_binding.dart';
import '../../features/home/views/home_view.dart';
import '../../features/notifications/bindings/notifications_binding.dart';
import '../../features/notifications/views/notifications_view.dart';
import '../../features/onboarding/bindings/mode_binding.dart';
import '../../features/onboarding/bindings/onboarding_binding.dart';
import '../../features/onboarding/views/choose_mode_view.dart';
import '../../features/onboarding/views/onboarding_view.dart';
import '../../features/profile/bindings/profile_binding.dart';
import '../../features/profile/views/profile_view.dart';
import '../../features/rider/bindings/rider_binding.dart';
import '../../features/rider/views/rider_home_view.dart';
import '../../features/ride_verification/bindings/rate_trip_binding.dart';
import '../../features/ride_verification/bindings/ride_impact_binding.dart';
import '../../features/ride_verification/bindings/ride_verified_binding.dart';
import '../../features/ride_verification/bindings/ride_verify_binding.dart';
import '../../features/ride_verification/views/rate_trip_view.dart';
import '../../features/ride_verification/views/ride_impact_view.dart';
import '../../features/ride_verification/views/ride_verified_view.dart';
import '../../features/ride_verification/views/ride_verify_view.dart';
import '../../features/settings/bindings/settings_binding.dart';
import '../../features/settings/views/settings_view.dart';
import '../../features/create_mode/bindings/create_mode_binding.dart';
import '../../features/create_mode/views/create_mode_view.dart';
import '../../features/match_list/bindings/match_confirm_binding.dart';
import '../../features/match_list/bindings/match_list_binding.dart';
import '../../features/match_list/views/match_confirm_view.dart';
import '../../features/match_list/views/match_list_view.dart';
import '../../features/pre_match_chat/bindings/pre_match_chat_binding.dart';
import '../../features/pre_match_chat/views/pre_match_chat_view.dart';
import '../../features/user_profile/bindings/user_profile_binding.dart';
import '../../features/user_profile/views/user_profile_view.dart';
import '../../features/select_reward/bindings/select_reward_binding.dart';
import '../../features/select_reward/views/select_reward_view.dart';
import '../../features/set_destination/bindings/set_destination_binding.dart';
import '../../features/set_destination/views/set_destination_view.dart';
import '../../features/complete_profile_setup/bindings/verification_binding.dart';
import '../../features/complete_profile_setup/views/background_check_view.dart';
import '../../features/complete_profile_setup/views/complete_profile_view.dart';
import '../../features/complete_profile_setup/views/connect_mode_filter_view.dart';
import '../../features/complete_profile_setup/views/profile_photos_view.dart';
import '../../features/complete_profile_setup/views/social_connect_view.dart';
import '../../features/complete_profile_setup/views/starter_rewards_view.dart';
import '../../features/complete_profile_setup/views/tell_us_more_view.dart';
import '../../features/complete_profile_setup/views/verification_hub_view.dart';
import '../../features/wallet/bindings/coupon_detail_binding.dart';
import '../../features/wallet/bindings/marketplace_binding.dart';
import '../../features/wallet/bindings/redeem_confirm_binding.dart';
import '../../features/wallet/bindings/redeem_history_binding.dart';
import '../../features/wallet/bindings/redeemed_success_binding.dart';
import '../../features/wallet/bindings/wallet_binding.dart';
import '../../features/wallet/views/coupon_detail_view.dart';
import '../../features/wallet/views/marketplace_view.dart';
import '../../features/wallet/views/redeem_confirm_view.dart';
import '../../features/wallet/views/redeem_history_view.dart';
import '../../features/wallet/views/redeemed_success_view.dart';
import '../../features/wallet/views/wallet_view.dart';
import 'app_routes.dart';

class AppPages {
  AppPages._();

  static const String initial = AppRoutes.splash;

  static final List<GetPage<dynamic>> pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.onboarding,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: AppRoutes.authWelcome,
      page: () => const AuthWelcomeView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.emailLogin,
      page: () => const EmailLoginView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.emailSignup,
      page: () => const EmailSignupView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.phoneEntry,
      page: () => const PhoneEntryView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.phoneLogin,
      page: () => const PhoneLoginView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.phoneSignup,
      page: () => const PhoneSignupView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.googleSignIn,
      page: () => const GoogleSignInView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.appleSignIn,
      page: () => const AppleSignInView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.otp,
      page: () => const OtpView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.verificationHub,
      page: () => const VerificationHubView(),
      binding: VerificationBinding(),
    ),
    GetPage(
      name: AppRoutes.profilePhotos,
      page: () => const ProfilePhotosView(),
      binding: VerificationBinding(),
    ),
    GetPage(
      name: AppRoutes.completeProfile,
      page: () => const CompleteProfileView(),
      binding: VerificationBinding(),
    ),
    GetPage(
      name: AppRoutes.connectModeFilter,
      page: () => const ConnectModeFilterView(),
      binding: VerificationBinding(),
    ),
    GetPage(
      name: AppRoutes.tellUsMore,
      page: () => const TellUsMoreView(),
      binding: VerificationBinding(),
    ),
    GetPage(
      name: AppRoutes.socialConnect,
      page: () => const SocialConnectView(),
      binding: VerificationBinding(),
    ),
    GetPage(
      name: AppRoutes.backgroundCheck,
      page: () => const BackgroundCheckView(),
      binding: VerificationBinding(),
    ),
    GetPage(
      name: AppRoutes.starterRewards,
      page: () => const StarterRewardsView(),
      binding: VerificationBinding(),
    ),
    GetPage(
      name: AppRoutes.chooseMode,
      page: () => const ChooseModeView(),
      binding: ModeBinding(),
    ),
    GetPage(
      name: AppRoutes.flexHome,
      page: () => const FlexHomeView(),
      binding: FlexBinding(),
    ),
    GetPage(
      name: AppRoutes.riderHome,
      page: () => const RiderHomeView(),
      binding: RiderBinding(),
    ),
    GetPage(
      name: AppRoutes.driverHome,
      page: () => const DriverHomeView(),
      binding: DriverBinding(),
    ),
    GetPage(
      name: AppRoutes.driverSetRoute,
      page: () => const DriverSetRouteView(),
      binding: DriverSetRouteBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: AppRoutes.driverMatchList,
      page: () => const DriverMatchListView(),
      binding: DriverMatchListBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: AppRoutes.driverMatchEmpty,
      page: () => const DriverMatchEmptyView(),
      binding: DriverMatchListBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: AppRoutes.driverPreMatchChat,
      page: () => const DriverPreMatchChatView(),
      binding: DriverPreMatchChatBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: AppRoutes.driverChat,
      page: () => const DriverChatView(),
      binding: DriverChatBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: AppRoutes.driverMatchConfirm,
      page: () => const DriverMatchConfirmView(),
      binding: DriverMatchConfirmBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: AppRoutes.driverLiveRide,
      page: () => const DriverLiveRideView(),
      binding: DriverLiveRideBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: AppRoutes.notifications,
      page: () => const NotificationsView(),
      binding: NotificationsBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: AppRoutes.chat,
      page: () => const ChatListView(),
      binding: ChatListBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: AppRoutes.chatDetails,
      page: () => const ChatDetailsView(),
      binding: ChatDetailsBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: AppRoutes.rideVerify,
      page: () => const RideVerifyView(),
      binding: RideVerifyBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: AppRoutes.rideVerified,
      page: () => const RideVerifiedView(),
      binding: RideVerifiedBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: AppRoutes.rideImpact,
      page: () => const RideImpactView(),
      binding: RideImpactBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: AppRoutes.rateTrip,
      page: () => const RateTripView(),
      binding: RateTripBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: AppRoutes.editProfile,
      page: () => const EditProfileView(),
      binding: EditProfileBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: AppRoutes.settings,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: AppRoutes.communityCircles,
      page: () => const CommunityCirclesView(),
      binding: CommunityCirclesBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: AppRoutes.communityDetails,
      page: () => const CommunityDetailsView(),
      binding: CommunityDetailsBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: AppRoutes.connections,
      page: () => const ConnectionsView(),
      binding: ConnectionsBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: AppRoutes.connectionRequests,
      page: () => const ConnectionRequestsView(),
      binding: ConnectionRequestsBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 250),
    ),

    // GetPage(
    //   name: AppRoutes.wallet,
    //   page: () => const WalletView(),
    //   binding: WalletBinding(),
    //   transition: Transition.fadeIn,
    //   transitionDuration: const Duration(milliseconds: 250),
    // ),
    GetPage(
      name: AppRoutes.wallet,
      page: () => const WalletView(),
      binding: WalletBinding(),
      transition: Transition.noTransition,
      transitionDuration: Duration.zero,
    ),
    GetPage(
      name: AppRoutes.marketplace,
      page: () => const MarketplaceView(),
      binding: MarketplaceBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: AppRoutes.couponDetail,
      page: () => const CouponDetailView(),
      binding: CouponDetailBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: AppRoutes.redeemConfirm,
      page: () => const RedeemConfirmView(),
      binding: RedeemConfirmBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: AppRoutes.redeemedSuccess,
      page: () => const RedeemedSuccessView(),
      binding: RedeemedSuccessBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: AppRoutes.redeemHistory,
      page: () => const RedeemHistoryView(),
      binding: RedeemHistoryBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: AppRoutes.setDestination,
      page: () => const SetDestinationView(),
      binding: SetDestinationBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: AppRoutes.createMode,
      page: () => const CreateModeView(),
      binding: CreateModeBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: AppRoutes.selectReward,
      page: () => const SelectRewardView(),
      binding: SelectRewardBinding(),
    ),
    GetPage(
      name: AppRoutes.matchList,
      page: () => const MatchListView(),
      binding: MatchListBinding(),
    ),
    GetPage(
      name: AppRoutes.matchConfirm,
      page: () => const MatchConfirmView(),
      binding: MatchConfirmBinding(),
    ),
    GetPage(
      name: AppRoutes.userProfile,
      page: () => const UserProfileView(),
      binding: UserProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.preMatchChat,
      page: () => const PreMatchChatView(),
      binding: PreMatchChatBinding(),
    ),
    // Kept for backwards compatibility; prefer mode homes.
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.flexWallet,
      page: () => const FlexWalletView(),
      binding: FlexWalletBinding(),
      transition: Transition.noTransition,
      transitionDuration: Duration.zero,
    ),
     GetPage(
      name: AppRoutes.gasVoucherPayment,
      page: () => const GasVoucherPaymentView(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: AppRoutes.gasVoucherSuccess,
      page: () => const GasVoucherSuccessView(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 250),
    ),

    GetPage(
  name: AppRoutes.missions,
  page: () => const MissionsView(),
  binding: FlexWalletBinding(),
),
GetPage(
  name: AppRoutes.missionQuiz,
  page: () => const MissionQuizView(),
  binding: FlexWalletBinding(),
  transition: Transition.noTransition,
      transitionDuration: Duration.zero,
),
GetPage(
  name: AppRoutes.quizCompleted,
  page: () => const QuizCompletedView(),
  binding: FlexWalletBinding(),
  transition: Transition.noTransition,
      transitionDuration: Duration.zero,
),
  ];
}
