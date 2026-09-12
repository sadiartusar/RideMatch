import 'dart:math' as math;
import 'package:flutter/material.dart';

import '../models/rider_match_model.dart';

class DriverRiderMatchCard extends StatefulWidget {
  const DriverRiderMatchCard({
    super.key,
    required this.match,
    required this.onSwipeLeft,
    required this.onSwipeRight,
    required this.onOfferRide,
    required this.onPass,
    required this.onViewProfile,
    required this.onReplyPreMatch,
  });

  final RiderMatchModel match;
  final VoidCallback onSwipeLeft;
  final VoidCallback onSwipeRight;
  final VoidCallback onOfferRide;
  final VoidCallback onPass;
  final VoidCallback onViewProfile;
  final VoidCallback onReplyPreMatch;

  @override
  State<DriverRiderMatchCard> createState() => _DriverRiderMatchCardState();
}

class _DriverRiderMatchCardState extends State<DriverRiderMatchCard>
    with SingleTickerProviderStateMixin {
  Offset _dragOffset = Offset.zero;

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      _dragOffset += details.delta;
    });
  }

  void _onPanEnd(DragEndDetails details) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (_dragOffset.dx < -screenWidth * 0.28) {
      // Swiped Left
      widget.onSwipeLeft();
    } else if (_dragOffset.dx > screenWidth * 0.28) {
      // Swiped Right
      widget.onSwipeRight();
    }
    setState(() {
      _dragOffset = Offset.zero;
    });
  }

  @override
  Widget build(BuildContext context) {
    final match = widget.match;
    final rotationAngle = (_dragOffset.dx / 300) * (math.pi / 16);

    return GestureDetector(
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      child: Transform.translate(
        offset: _dragOffset,
        child: Transform.rotate(
          angle: rotationAngle,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFF171A1D),
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                color: const Color(0xFF262B32),
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.45),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Top Photo Header with Match Badge
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(21),
                      ),
                      child: Image.asset(
                        match.avatarAsset,
                        width: double.infinity,
                        height: 220,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 220,
                            color: const Color(0xFF2A2E35),
                            alignment: Alignment.center,
                            child: const Icon(
                              Icons.person,
                              size: 80,
                              color: Colors.white30,
                            ),
                          );
                        },
                      ),
                    ),
                    // Match Percentage Badge Top Right
                    Positioned(
                      top: 14,
                      right: 14,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.75),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.white24,
                            width: 0.8,
                          ),
                        ),
                        child: Text(
                          '${match.matchPercentage}% Match',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // Card Body Content
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name & Detour Pill
                      Row(
                        children: [
                          if (match.isVerified) ...[
                            const Icon(
                              Icons.check_circle,
                              color: Color(0xFF32E116),
                              size: 18,
                            ),
                            const SizedBox(width: 6),
                          ],
                          Expanded(
                            child: Text(
                              match.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                letterSpacing: -0.2,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF122C19),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: const Color(0xFF1C5A2B),
                                width: 1,
                              ),
                            ),
                            child: Text(
                              match.detourText,
                              style: const TextStyle(
                                color: Color(0xFF32E116),
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Bio Quote
                      Text(
                        '"${match.bio}"',
                        style: const TextStyle(
                          color: Color(0xFF9CA3AF),
                          fontSize: 13,
                          fontStyle: FontStyle.italic,
                          height: 1.35,
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Commute metrics (Share & Rides)
                      Row(
                        children: [
                          const Icon(
                            Icons.alt_route_rounded,
                            color: Color(0xFF9CA3AF),
                            size: 16,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'You share ${match.sharedKm} km',
                            style: const TextStyle(
                              color: Color(0xFFD1D5DB),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.directions_car_outlined,
                            color: Color(0xFF9CA3AF),
                            size: 16,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '${match.rideCount} Rides',
                            style: const TextStyle(
                              color: Color(0xFFD1D5DB),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      // Tag Chips
                      Wrap(
                        spacing: 8,
                        runSpacing: 6,
                        children: match.tags.map((tag) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF111417),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: const Color(0xFF232830),
                                width: 1,
                              ),
                            ),
                            child: Text(
                              tag,
                              style: const TextStyle(
                                color: Color(0xFF32E116),
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 16),
                      // Offer Rewards Section
                      const Text(
                        'OFFER REWARDS',
                        style: TextStyle(
                          color: Color(0xFF6B7280),
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.8,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFF121417),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: const Color(0xFF22272E),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: const Color(0xFF16381D),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                Icons.local_cafe_rounded,
                                color: Color(0xFF32E116),
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  match.rewardBrand,
                                  style: const TextStyle(
                                    color: Color(0xFF32E116),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  match.rewardDetail,
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
                      ),
                      const SizedBox(height: 14),
                      // Offer Incentive Section
                      const Text(
                        'OFFER INCENTIVE',
                        style: TextStyle(
                          color: Color(0xFF6B7280),
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.8,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: const Color(0xFF121417),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: const Color(0xFF22272E),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 36,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF1D2228),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Icon(
                                    Icons.bolt_rounded,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        match.incentiveTitle,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        match.incentiveSubtitle,
                                        style: const TextStyle(
                                          color: Color(0xFF9CA3AF),
                                          fontSize: 11,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Value',
                                  style: TextStyle(
                                    color: Color(0xFF9CA3AF),
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  '\$${match.incentiveValue.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Platform Fee (20%)',
                                  style: TextStyle(
                                    color: Color(0xFF9CA3AF),
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  '-\$${match.platformFee.abs().toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    color: Color(0xFFEF4444),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Container(
                              height: 1,
                              color: const Color(0xFF242931),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Your Net Earnings',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                Text(
                                  '\$${match.netEarnings.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    color: Color(0xFF32E116),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 14),
                      // Pre-Match Message Section
                      const Text(
                        'PRE-MATCH MESSAGE',
                        style: TextStyle(
                          color: Color(0xFF32E116),
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.8,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFF121417),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: const Color(0xFF22272E),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.chat_bubble_outline_rounded,
                                  color: Color(0xFF32E116),
                                  size: 16,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    match.preMatchMessage,
                                    style: const TextStyle(
                                      color: Color(0xFFD1D5DB),
                                      fontSize: 12,
                                      fontStyle: FontStyle.italic,
                                      height: 1.35,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Align(
                              alignment: Alignment.centerRight,
                              child: InkWell(
                                onTap: widget.onReplyPreMatch,
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 2,
                                  ),
                                  child: Text(
                                    'Reply',
                                    style: TextStyle(
                                      color: Color(0xFF9CA3AF),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Action Buttons: Offer Ride & Pass
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 46,
                              child: ElevatedButton(
                                onPressed: widget.onOfferRide,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF1E5B28),
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Text(
                                  'Offer Ride',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: SizedBox(
                              height: 46,
                              child: ElevatedButton(
                                onPressed: widget.onPass,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF3B3116),
                                  foregroundColor: const Color(0xFFEAB308),
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Text(
                                  'Pass',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      // View Profile full width button
                      SizedBox(
                        width: double.infinity,
                        height: 46,
                        child: OutlinedButton(
                          onPressed: widget.onViewProfile,
                          style: OutlinedButton.styleFrom(
                            backgroundColor: const Color(0xFF121417),
                            foregroundColor: Colors.white,
                            side: const BorderSide(
                              color: Color(0xFF262B32),
                              width: 1,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'View Profile',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
