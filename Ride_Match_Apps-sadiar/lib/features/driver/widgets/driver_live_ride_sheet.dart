import 'package:flutter/material.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/theme/app_colors.dart';

class DriverLiveRideSheet extends StatelessWidget {
  const DriverLiveRideSheet({
    super.key,
    this.riderName = 'Marcus Miller',
    this.riderRides = 124,
    this.etaMinutes = 12,
    this.arrivalTime = '8:52 AM',
    this.remainingKm = 3.1,
    this.sharedKm = 4.8,
    this.scrollController,
    required this.onCallRider,
    required this.onEmergencySos,
    required this.onMessageRider,
    required this.onVerifyCompletion,
  });

  final String riderName;
  final int riderRides;
  final int etaMinutes;
  final String arrivalTime;
  final double remainingKm;
  final double sharedKm;
  final ScrollController? scrollController;
  final VoidCallback onCallRider;
  final VoidCallback onEmergencySos;
  final VoidCallback onMessageRider;
  final VoidCallback onVerifyCompletion;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF14171A),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 18,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: SingleChildScrollView(
        controller: scrollController,
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag Handle
            Center(
              child: Container(
                width: 38,
                height: 4,
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),

            // ESTIMATED ARRIVAL Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'ESTIMATED ARRIVAL',
                      style: TextStyle(
                        color: Color(0xFF9CA3AF),
                        fontSize: 9.5,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.8,
                      ),
                    ),
                    const SizedBox(height: 2),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '$etaMinutes ',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const TextSpan(
                            text: 'min',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      arrivalTime,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${remainingKm.toStringAsFixed(1)} km remaining',
                      style: const TextStyle(
                        color: Color(0xFF9CA3AF),
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              'You share ${sharedKm.toStringAsFixed(1)} km of this route',
              style: const TextStyle(
                color: Color(0xFF6B7280),
                fontSize: 11.5,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 12),

            // Rider Card with Call button
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF191C20),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: const Color(0xFF262A30),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage(AppAssets.profileHero),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          riderName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '$riderRides Rides',
                          style: const TextStyle(
                            color: Color(0xFF9CA3AF),
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: onCallRider,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E242B),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFF2E353F),
                          width: 1,
                        ),
                      ),
                      child: const Icon(
                        Icons.call,
                        color: Color(0xFF32E116),
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Vertical Timeline (Pickup completed -> Shared route in progress -> Destination)
            Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Column(
                children: [
                  _buildTimelineStep(
                    icon: Icons.check_circle_rounded,
                    iconColor: const Color(0xFF32E116),
                    title: 'Pickup completed',
                    isCompleted: true,
                  ),
                  _buildTimelineLine(isCompleted: true),
                  _buildTimelineStep(
                    icon: Icons.radio_button_checked_rounded,
                    iconColor: const Color(0xFF32E116),
                    title: 'Shared route in progress',
                    isCompleted: true,
                  ),
                  _buildTimelineLine(isCompleted: false),
                  _buildTimelineStep(
                    icon: Icons.radio_button_unchecked_rounded,
                    iconColor: const Color(0xFF4B5563),
                    title: 'Destination ahead',
                    isCompleted: false,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // SOS & Message Buttons
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: onEmergencySos,
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2A1515),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFF4A2020),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEF4444),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text(
                              'SOS',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 9.5,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Emergency SOS',
                            style: TextStyle(
                              color: Color(0xFFEF4444),
                              fontSize: 11.5,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: InkWell(
                    onTap: onMessageRider,
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF181C20),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFF262B32),
                          width: 1,
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.chat_bubble_outline_rounded,
                            color: Color(0xFF32E116),
                            size: 15,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Message Rider',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11.5,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Blackbox Recording
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF132A18),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: const Color(0xFF1F5128),
                  width: 1,
                ),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.videocam_outlined,
                    color: Color(0xFF32E116),
                    size: 16,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Blackbox Recording Active',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11.5,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          'Trip data is recorded for safety.',
                          style: TextStyle(
                            color: Color(0xFF9CA3AF),
                            fontSize: 10.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 6),

            // Escrow Reward
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF16191D),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: const Color(0xFF262B32),
                  width: 1,
                ),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.lock_outline_rounded,
                    color: Color(0xFFEAB308),
                    size: 16,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Reward held in escrow',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11.5,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          'Released after verified ride completion.',
                          style: TextStyle(
                            color: Color(0xFF9CA3AF),
                            fontSize: 10.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Verify Ride Completion Button
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: onVerifyCompletion,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.button,
                  foregroundColor: AppColors.buttonForeground,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Verify Ride Completion',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineStep({
    required IconData icon,
    required Color iconColor,
    required String title,
    required bool isCompleted,
  }) {
    return Row(
      children: [
        Icon(icon, size: 15, color: iconColor),
        const SizedBox(width: 10),
        Text(
          title,
          style: TextStyle(
            color: isCompleted ? Colors.white : const Color(0xFF6B7280),
            fontSize: 11.5,
            fontWeight: isCompleted ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildTimelineLine({required bool isCompleted}) {
    return Container(
      margin: const EdgeInsets.only(left: 6.5),
      width: 2,
      height: 10,
      color: isCompleted ? const Color(0xFF32E116) : const Color(0xFF374151),
    );
  }
}
