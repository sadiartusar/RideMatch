import 'package:flutter/material.dart';

import '../models/user_profile_model.dart';
import 'user_profile_section_label.dart';

class UserProfileRewards extends StatelessWidget {
  const UserProfileRewards({
    super.key,
    required this.rewards,
  });

  final List<UserProfileReward> rewards;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const UserProfileSectionLabel('DRIVER REWARDS & PERKS'),
        const SizedBox(height: 10),
        Row(
          children: [
            for (var i = 0; i < rewards.length; i++) ...[
              if (i > 0) const SizedBox(width: 10),
              Expanded(child: _RewardCard(reward: rewards[i])),
            ],
          ],
        ),
      ],
    );
  }
}

class _RewardCard extends StatelessWidget {
  const _RewardCard({required this.reward});

  final UserProfileReward reward;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 16, 8, 14),
      decoration: BoxDecoration(
        color: const Color(0xFFFBF6E8),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Icon(
            reward.icon,
            color: const Color(0xFF6B5C28),
            size: 26,
          ),
          const SizedBox(height: 10),
          Text(
            reward.label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF4A401C),
              fontSize: 12.5,
              fontWeight: FontWeight.w800,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
