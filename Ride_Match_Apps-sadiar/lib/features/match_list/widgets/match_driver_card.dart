import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../models/driver_match_model.dart';
import 'match_social_links.dart';

class MatchCardStyle {
  const MatchCardStyle({
    required this.photoHeight,
    required this.padding,
    required this.sectionGap,
    required this.buttonHeight,
    required this.socialExtent,
  });

  final double photoHeight;
  final double padding;
  final double sectionGap;
  final double buttonHeight;
  final double socialExtent;

  factory MatchCardStyle.fromAvailableHeight(double available) {
    return MatchCardStyle(
      photoHeight: (available * 0.24).clamp(118.0, 148.0),
      padding: 12.0,
      sectionGap: 8.0,
      buttonHeight: 44.0,
      socialExtent: 42.0,
    );
  }
}

class MatchDriverCard extends StatefulWidget {
  const MatchDriverCard({
    super.key,
    required this.match,
    required this.style,
    required this.onSwipeLeft,
    required this.onSwipeRight,
    required this.onRequest,
    required this.onPass,
    required this.onViewProfile,
    required this.onSocialTap,
  });

  final DriverMatchModel match;
  final MatchCardStyle style;
  final VoidCallback onSwipeLeft;
  final VoidCallback onSwipeRight;
  final VoidCallback onRequest;
  final VoidCallback onPass;
  final VoidCallback onViewProfile;
  final ValueChanged<DriverSocialLink> onSocialTap;

  @override
  State<MatchDriverCard> createState() => _MatchDriverCardState();
}

class _MatchDriverCardState extends State<MatchDriverCard> {
  Offset _dragOffset = Offset.zero;

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    setState(() {
      _dragOffset += Offset(details.delta.dx, 0);
    });
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (_dragOffset.dx < -screenWidth * 0.28) {
      widget.onSwipeLeft();
      return;
    }
    if (_dragOffset.dx > screenWidth * 0.28) {
      widget.onSwipeRight();
    }
    setState(() {
      _dragOffset = Offset.zero;
    });
  }

  @override
  Widget build(BuildContext context) {
    final match = widget.match;
    final style = widget.style;
    final rotationAngle = (_dragOffset.dx / 300) * (math.pi / 16);

    return GestureDetector(
      onHorizontalDragUpdate: _onHorizontalDragUpdate,
      onHorizontalDragEnd: _onHorizontalDragEnd,
      child: Transform.translate(
        offset: _dragOffset,
        child: Transform.rotate(
          angle: rotationAngle,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            padding: EdgeInsets.all(style.padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Stack(
                    children: [
                      Image.asset(
                        match.avatarAsset,
                        width: double.infinity,
                        height: style.photoHeight,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: style.photoHeight,
                            color: const Color(0xFFE5E7EB),
                            alignment: Alignment.center,
                            child: const Icon(
                              Icons.person,
                              size: 64,
                              color: Color(0xFF9CA3AF),
                            ),
                          );
                        },
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(8, 5, 10, 5),
                          decoration: BoxDecoration(
                            color: const Color(0xFF9AF05C),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 7,
                                height: 7,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF15803D),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                '${match.matchPercentage}% Match',
                                style: const TextStyle(
                                  color: Color(0xFF111827),
                                  fontSize: 11,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    if (match.isVerified) ...[
                      const Icon(
                        Icons.check_circle,
                        color: Color(0xFF22C55E),
                        size: 18,
                      ),
                      const SizedBox(width: 6),
                    ],
                    Expanded(
                      child: Text(
                        match.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Color(0xFF111827),
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.2,
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.star_rounded,
                      color: Color(0xFFF5C518),
                      size: 16,
                    ),
                    const SizedBox(width: 3),
                    Text(
                      match.rating.toStringAsFixed(1),
                      style: const TextStyle(
                        color: Color(0xFF6B7280),
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  '"${match.bio}"',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 12.5,
                    fontStyle: FontStyle.italic,
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.turn_slight_left_rounded,
                      color: Color(0xFFF59E0B),
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Flexible(
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: match.detourText,
                              style: const TextStyle(
                                color: Color(0xFFF59E0B),
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            TextSpan(
                              text: ' • ${match.vehicle}',
                              style: const TextStyle(
                                color: Color(0xFF6B7280),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.alt_route_rounded,
                      color: Color(0xFF9CA3AF),
                      size: 15,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'You share ${match.sharedKm} km',
                      style: const TextStyle(
                        color: Color(0xFF6B7280),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: match.tags.map((tag) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEAF8C8),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        tag,
                        style: const TextStyle(
                          color: Color(0xFF3F8A28),
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 10),
                MatchSocialLinks(
                  links: match.socialLinks,
                  tileHeight: style.socialExtent,
                  onTap: widget.onSocialTap,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: style.buttonHeight,
                        child: ElevatedButton(
                          onPressed: widget.onRequest,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFC8F25A),
                            foregroundColor: const Color(0xFF111827),
                            elevation: 0,
                            shadowColor: Colors.transparent,
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: const Text(
                            'Request',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: SizedBox(
                        height: style.buttonHeight,
                        child: ElevatedButton(
                          onPressed: widget.onPass,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFF3E2A6),
                            foregroundColor: const Color(0xFF111827),
                            elevation: 0,
                            shadowColor: Colors.transparent,
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: const Text(
                            'Pass',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  height: style.buttonHeight,
                  child: OutlinedButton(
                    onPressed: widget.onViewProfile,
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF111827),
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      side: const BorderSide(
                        color: Color(0xFFE6E8EC),
                        width: 1,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text(
                      'View Profile',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
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
