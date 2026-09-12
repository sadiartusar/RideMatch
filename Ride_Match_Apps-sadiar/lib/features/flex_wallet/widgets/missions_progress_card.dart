import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/flex_missions_controller.dart';

class MissionsProgressCard extends GetView<FlexMissionsController> {
  const MissionsProgressCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: BoxDecoration(
        color: const Color(0xFF0F7A1D),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'WEEKLY EARNINGS',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.8,
                  color: Color(0xFFA7F3D0),
                ),
              ),
              const SizedBox(height: 4),
              Obx(() => Text(
                    '+${controller.weeklyEarnings.value}',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  )),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                'DAILY PROGRESS',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.8,
                  color: Color(0xFFA7F3D0),
                ),
              ),
              const SizedBox(height: 4),
              Obx(() => Text(
                    '${controller.dailyCompleted.value}/${controller.dailyTotal.value} Done',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}