import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../main_nav/main_tab_nav.dart';
import '../../main_nav/widgets/app_mode_bottom_nav.dart';
import '../controller/flex_missions_controller.dart';
import '../widgets/quiz_option_tile.dart';

class MissionQuizView extends GetView<FlexMissionsController> {
  const MissionQuizView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F8F6),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9F8F6),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1E2022)),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Mission',
          style: TextStyle(color: Color(0xFF1E2022), fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'PROGRESS',
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF9CA3AF)),
                      ),
                      const SizedBox(height: 4),
                      Obx(() => Text.rich(
                            TextSpan(
                              text: '0${controller.currentQuestionIndex.value + 1} ',
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1E2022)),
                              children: [
                                TextSpan(
                                  text: '/0${controller.totalQuestions.value}',
                                  style: const TextStyle(fontSize: 13, color: Color(0xFF9CA3AF)),
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF59E0B),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      '+12 Rewards',
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Obx(() => ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: (controller.currentQuestionIndex.value + 1) / controller.totalQuestions.value,
                      backgroundColor: const Color(0xFFE5E7EB),
                      valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF00E63D)),
                      minHeight: 4,
                    ),
                  )),
              const SizedBox(height: 20),
              Obx(() => Text(
                    controller.currentQuestion.question,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Color(0xFF4B5563)),
                  )),
              const SizedBox(height: 28),
              Expanded(
                child: Obx(() {
                  final q = controller.currentQuestion;
                  const letters = ['A', 'B', 'C', 'D'];
                  return ListView.separated(
                    itemCount: q.options.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 14),
                    itemBuilder: (context, index) {
                      return QuizOptionTile(
                        letter: letters[index],
                        optionText: q.options[index],
                        isSelected: controller.selectedOptionIndex.value == index,
                        onTap: () => controller.selectOption(index),
                      );
                    },
                  );
                }),
              ),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: controller.onContinueQuiz,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00E63D),
                    foregroundColor: Colors.black,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  child: const Text('Continue', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
      bottomNavigationBar: AppModeBottomNav(
        selectedIndex: MainTabNav.walletIndex,
        onTap: (index) {
          if (index == MainTabNav.homeIndex) MainTabNav.showHome();
          else if (index == MainTabNav.findIndex) MainTabNav.showRoute();
          else if (index == MainTabNav.chatIndex) MainTabNav.showChat();
          else if (index == MainTabNav.walletIndex) MainTabNav.showWallet();
          else if (index == MainTabNav.profileIndex) MainTabNav.showProfile();
        },
      ),
    );
  }
}