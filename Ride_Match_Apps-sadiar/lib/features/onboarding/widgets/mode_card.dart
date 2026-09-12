import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../models/mode_option.dart';
import 'mode_feature_chip.dart';

class ModeCard extends StatelessWidget {
  const ModeCard({
    super.key,
    required this.option,
    required this.onChoose,
    this.isLoading = false,
  });

  final ModeOption option;
  final VoidCallback onChoose;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE5E7EB), width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              color: AppColors.splashBackground,
              shape: BoxShape.circle,
            ),
            child: Icon(option.icon, color: Colors.black, size: 24),
          ),
          const SizedBox(height: 16),
          Text(
            option.title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: Color(0xFF111827),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            option.description,
            style: const TextStyle(
              fontSize: 13.5,
              color: Color(0xFF6B7280),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final tag in option.tags) ModeFeatureChip(label: tag),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: OutlinedButton(
              onPressed: isLoading ? null : onChoose,
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF1F2937),
                side: const BorderSide(color: Color(0xFFE5E7EB)),
                backgroundColor: const Color(0xFFF9FAFB),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Color(0xFF1F2937),
                      ),
                    )
                  : Text(
                      option.buttonLabel,
                      style: const TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1F2937),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
