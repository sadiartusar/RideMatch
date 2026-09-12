import 'package:flutter/material.dart';

class EditProfileModel {
  const EditProfileModel({
    required this.fullName,
    required this.professionalTitle,
    required this.aboutMe,
    required this.languages,
    required this.rewards,
    required this.vehicleModel,
    required this.plateNumber,
    required this.vehicleFeatures,
    required this.documents,
    required this.blackboxEnabled,
    required this.socialLinks,
  });

  final String fullName;
  final String professionalTitle;
  final String aboutMe;
  final List<String> languages;
  final List<String> rewards;
  final String vehicleModel;
  final String plateNumber;
  final List<VehicleFeature> vehicleFeatures;
  final List<DriverDocumentItem> documents;
  final bool blackboxEnabled;
  final List<SocialTrustLink> socialLinks;

  static const EditProfileModel demo = EditProfileModel(
    fullName: 'Jack M. Kees',
    professionalTitle: 'Professional, verified, and eco-friendly driver.',
    aboutMe:
        'Experienced city driver with a strong safety record. Friendly rides, clean cabin, and reliable on-time pickups across downtown routes.',
    languages: ['Hebrew', 'English', 'French'],
    rewards: ['Fuel Coupon', 'Coffee Coupon', 'Parking Coupon'],
    vehicleModel: 'Tesla Model 3',
    plateNumber: 'DA-1342',
    vehicleFeatures: [
      VehicleFeature(label: '4 Seats', icon: Icons.event_seat_outlined),
      VehicleFeature(label: 'AC', icon: Icons.ac_unit_rounded),
      VehicleFeature(label: 'Electric', icon: Icons.ev_station_outlined),
      VehicleFeature(label: 'Premium', icon: Icons.verified_user_outlined),
    ],
    documents: [
      DriverDocumentItem(
        label: 'Driving License',
        icon: Icons.description_outlined,
        isUploaded: true,
      ),
      DriverDocumentItem(
        label: 'Commercial Insurance',
        icon: Icons.shield_outlined,
        isUploaded: false,
      ),
      DriverDocumentItem(
        label: 'Vehicle Registration',
        icon: Icons.grid_view_rounded,
        isUploaded: false,
      ),
    ],
    blackboxEnabled: true,
    socialLinks: [
      SocialTrustLink(
        platform: 'LinkedIn',
        icon: Icons.business_center_rounded,
        brandColor: Color(0xFF0A66C2),
        profileLink: 'linkedin.com/in/alex-rivas-le',
        isVerified: true,
      ),
      SocialTrustLink(
        platform: 'Instagram',
        icon: Icons.camera_alt_rounded,
        brandColor: Color(0xFFE1306C),
        profileLink: 'instagram.com/alex_vibe',
        isVerified: true,
      ),
      SocialTrustLink(
        platform: 'Tiktok',
        icon: Icons.music_note_rounded,
        brandColor: Color(0xFF111827),
        profileLink: 'tiktok.com/@alex_vibe',
        isVerified: false,
      ),
      SocialTrustLink(
        platform: 'Facebook',
        icon: Icons.facebook_rounded,
        brandColor: Color(0xFF1877F2),
        profileLink: 'facebook.com/yourprofile',
        isVerified: false,
      ),
    ],
  );
}

class VehicleFeature {
  const VehicleFeature({required this.label, required this.icon});

  final String label;
  final IconData icon;
}

class DriverDocumentItem {
  const DriverDocumentItem({
    required this.label,
    required this.icon,
    required this.isUploaded,
  });

  final String label;
  final IconData icon;
  final bool isUploaded;
}

class SocialTrustLink {
  const SocialTrustLink({
    required this.platform,
    required this.icon,
    required this.brandColor,
    required this.profileLink,
    required this.isVerified,
  });

  final String platform;
  final IconData icon;
  final Color brandColor;
  final String profileLink;
  final bool isVerified;
}
