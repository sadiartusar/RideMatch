import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../models/user_profile_model.dart';
import 'user_profile_section_label.dart';

class UserProfileVehicleSection extends StatelessWidget {
  const UserProfileVehicleSection({
    super.key,
    required this.profile,
  });

  final UserProfileModel profile;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const UserProfileSectionLabel('VEHICLE'),
        const SizedBox(height: 10),
        _VehicleBanner(profile: profile),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: profile.amenities.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            mainAxisExtent: 92,
          ),
          itemBuilder: (context, index) {
            final amenity = profile.amenities[index];
            return _AmenityCard(amenity: amenity);
          },
        ),
      ],
    );
  }
}

class _VehicleBanner extends StatelessWidget {
  const _VehicleBanner({required this.profile});

  final UserProfileModel profile;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: SizedBox(
        height: 168,
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              profile.vehicleAsset,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const ColoredBox(
                  color: Color(0xFFE5E7EB),
                  child: Icon(
                    Icons.directions_car_rounded,
                    size: 56,
                    color: Color(0xFF9CA3AF),
                  ),
                );
              },
            ),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Color(0x99000000),
                    Color(0xCC000000),
                  ],
                  stops: [0.35, 0.72, 1],
                ),
              ),
            ),
            Positioned(
              left: 16,
              right: 16,
              bottom: 14,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          profile.vehicleName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.3,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          profile.vehicleColor,
                          style: const TextStyle(
                            color: Color(0xFFD1D5DB),
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xCC111827),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0x66FFFFFF)),
                    ),
                    child: Text(
                      profile.plateNumber,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AmenityCard extends StatelessWidget {
  const _AmenityCard({required this.amenity});

  final UserProfileAmenity amenity;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEAE8E2)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            amenity.icon,
            color: AppColors.success,
            size: 26,
          ),
          const SizedBox(height: 8),
          Text(
            amenity.label,
            style: const TextStyle(
              color: Color(0xFF111827),
              fontSize: 13.5,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
