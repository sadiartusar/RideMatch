import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../models/reward_option.dart';

class AvailableRewardsSection extends StatelessWidget {
  const AvailableRewardsSection({
    super.key,
    required this.rewards,
    required this.specialOffer,
    required this.selectedId,
    required this.onSelect,
  });

  final List<RewardOption> rewards;
  final RewardOption specialOffer;
  final String? selectedId;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'AVAILABLE REWARDS',
          style: TextStyle(
            color: Color(0xFF6B7280),
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(height: 14),
        LayoutBuilder(
          builder: (context, constraints) {
            const spacing = 12.0;
            final itemWidth = (constraints.maxWidth - spacing) / 2;
            return Wrap(
              spacing: spacing,
              runSpacing: spacing,
              children: rewards.map((reward) {
                final selected = selectedId == reward.id;
                return SizedBox(
                  width: itemWidth,
                  child: _MerchantRewardCard(
                    reward: reward,
                    isSelected: selected,
                    onTap: () => onSelect(reward.id),
                  ),
                );
              }).toList(),
            );
          },
        ),
        const SizedBox(height: 12),
        _SpecialOfferCard(
          reward: specialOffer,
          isSelected: selectedId == specialOffer.id,
          onTap: () => onSelect(specialOffer.id),
        ),
      ],
    );
  }
}

class _MerchantRewardCard extends StatelessWidget {
  const _MerchantRewardCard({
    required this.reward,
    required this.isSelected,
    required this.onTap,
  });

  final RewardOption reward;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    const selectedFg = Color(0xFF166534);

    return Material(
      color: isSelected ? AppColors.button : const Color(0xFFF3F4F6),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          padding: const EdgeInsets.fromLTRB(14, 14, 14, 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFF22C55E).withValues(alpha: 0.35)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  reward.icon,
                  size: 22,
                  color: selectedFg,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                reward.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: isSelected ? selectedFg : const Color(0xFF111827),
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                reward.couponLabel,
                style: TextStyle(
                  color: isSelected
                      ? selectedFg.withValues(alpha: 0.85)
                      : const Color(0xFF9CA3AF),
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SpecialOfferCard extends StatelessWidget {
  const _SpecialOfferCard({
    required this.reward,
    required this.isSelected,
    required this.onTap,
  });

  final RewardOption reward;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected ? const Color(0xFFECFCE5) : const Color(0xFFF3F4F6),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected ? AppColors.button : Colors.transparent,
              width: 1.5,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: const Color(0xFFFBBF24),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  reward.icon,
                  color: const Color(0xFF111827),
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      reward.title,
                      style: const TextStyle(
                        color: Color(0xFF111827),
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      reward.couponLabel,
                      style: const TextStyle(
                        color: Color(0xFF9CA3AF),
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              if (reward.expiresInDays != null)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEE2E2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Expires in ${reward.expiresInDays} days',
                    style: const TextStyle(
                      color: Color(0xFFDC2626),
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
