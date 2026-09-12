import 'package:get/get.dart';
import 'flex_wallet_controller.dart';

class QuizQuestion {
  final String question;
  final List<String> options;
  final int correctIndex;

  QuizQuestion({
    required this.question,
    required this.options,
    required this.correctIndex,
  });
}

class FlexMissionsController extends GetxController {
  // Weekly & Daily Stats
  final weeklyEarnings = 35.obs;
  final dailyCompleted = 2.obs;
  final dailyTotal = 5.obs;

  // final currentStep = FlexWalletStep.main.obs;
  // Quiz State
  final currentQuestionIndex = 0.obs;
  final totalQuestions = 3.obs;
  final selectedOptionIndex = 0.obs;
  final earnedQuizReward = 12.obs;

  final questions = <QuizQuestion>[
    QuizQuestion(
      question: 'Which Starbucks cup helps reduce waste?',
      options: [
        'The Reusable Cup',
        'Single-use Plastic Cup',
        'The Standard Paper Cup',
      ],
      correctIndex: 0,
    ),
    QuizQuestion(
      question: 'What is the optimal tire pressure for fuel efficiency?',
      options: [
        'Recommended PSI on door jamb',
        'Maximum sidewall PSI',
        'Under-inflated by 10 PSI',
      ],
      correctIndex: 0,
    ),
    QuizQuestion(
      question: 'Carpooling reduces carbon emissions by roughly:',
      options: ['Up to 50% per passenger', 'Less than 5%', 'No difference'],
      correctIndex: 0,
    ),
  ].obs;

  QuizQuestion get currentQuestion => questions[currentQuestionIndex.value];

  void selectOption(int index) {
    selectedOptionIndex.value = index;
  }

  void onContinueQuiz() {
    if (currentQuestionIndex.value < questions.length - 1) {
      currentQuestionIndex.value++;
      selectedOptionIndex.value = -1;
    } else {
      // Reward Add
      if (Get.isRegistered<FlexWalletController>()) {
        final wallet = Get.find<FlexWalletController>();
        wallet.totalCoupons.value += earnedQuizReward.value;
        wallet.recentActivities.insert(
          0,
          ActivityItem(
            title: 'Quiz Reward',
            date: 'Just now',
            amount: '+${earnedQuizReward.value}',
            isPositive: true,
          ),
        );
      }
      weeklyEarnings.value += earnedQuizReward.value;
      dailyCompleted.value = (dailyCompleted.value + 1).clamp(
        0,
        dailyTotal.value,
      );
       Get.offNamed('/quiz-completed');
    }
  }

  // void onClaimNextReward() {
  //   currentQuestionIndex.value = 0;
  //   selectedOptionIndex.value = 0;
  //   Get.offNamedUntil('/missions', (route) => route.settings.name == '/missions' || route.isFirst);
  // }

  void onClaimNextReward() {
    currentQuestionIndex.value = 0;
    selectedOptionIndex.value = 0;

    if (Get.isRegistered<FlexWalletController>()) {
      Get.find<FlexWalletController>().currentStep.value =
          FlexWalletStep.missions;
    }

    Get.until((route) => route.isFirst);
  }

  // void onBackToMissions() {
  //   currentQuestionIndex.value = 0;
  //   selectedOptionIndex.value = 0;
  //   Get.offNamedUntil('/missions', (route) => route.settings.name == '/missions' || route.isFirst);
  // }

  void onBackToMissions() {
    currentQuestionIndex.value = 0;
    selectedOptionIndex.value = 0;

    if (Get.isRegistered<FlexWalletController>()) {
      Get.find<FlexWalletController>().currentStep.value =
          FlexWalletStep.missions;
    }

    Get.until((route) => route.isFirst);
  }

  void onDailyCheckIn() =>
      Get.snackbar('Daily Check-in', '+5 Coupons claimed!');
  void onCarbonHero() =>
      Get.snackbar('Carbon Hero', 'Walk 2km today to earn +15 coupons!');
  void onWatchAd() =>
      Get.snackbar('Sponsored Ad', 'Playing Bolt video ad (+10 Pts)...');
  void onSendInvite() => Get.snackbar(
    'Invite Friends',
    'Share link copied! Earn +50 coupons per referral.',
  );
}
