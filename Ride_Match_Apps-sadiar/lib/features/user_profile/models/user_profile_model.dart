import 'package:flutter/material.dart';

import '../../../core/constants/app_assets.dart';
import '../../match_list/models/driver_match_model.dart';

class UserProfileStat {
  const UserProfileStat({
    required this.value,
    required this.label,
  });

  final String value;
  final String label;
}

class UserProfileAmenity {
  const UserProfileAmenity({
    required this.label,
    required this.icon,
  });

  final String label;
  final IconData icon;
}

class UserProfileReward {
  const UserProfileReward({
    required this.label,
    required this.icon,
  });

  final String label;
  final IconData icon;
}

class UserProfileCircle {
  const UserProfileCircle({
    required this.id,
    required this.name,
    required this.memberCount,
    required this.icon,
  });

  final String id;
  final String name;
  final String memberCount;
  final IconData icon;
}

class UserProfileReview {
  const UserProfileReview({
    required this.name,
    required this.quote,
    required this.rating,
    required this.avatarAsset,
  });

  final String name;
  final String quote;
  final double rating;
  final String avatarAsset;
}

enum UserProfileSocialPlatform { facebook, instagram, tiktok, linkedin }

class UserProfileSocialLink {
  const UserProfileSocialLink({
    required this.label,
    required this.platform,
  });

  final String label;
  final UserProfileSocialPlatform platform;
}

class UserProfileModel {
  const UserProfileModel({
    required this.id,
    required this.name,
    required this.headline,
    required this.avatarAsset,
    required this.isVerified,
    required this.rating,
    required this.rides,
    required this.memberSince,
    required this.interests,
    required this.matchPercentage,
    required this.recommendationChips,
    required this.evHighlightChip,
    required this.vehicleName,
    required this.vehicleColor,
    required this.plateNumber,
    required this.vehicleAsset,
    required this.amenities,
    required this.experienceYears,
    required this.acceptanceRate,
    required this.onTimeRate,
    required this.cancellationRate,
    required this.languages,
    required this.rewards,
    required this.nidVerified,
    required this.licenseVerified,
    required this.socialLinks,
    required this.circles,
    required this.about,
    required this.reviews,
  });

  final String id;
  final String name;
  final String headline;
  final String avatarAsset;
  final bool isVerified;
  final double rating;
  final int rides;
  final String memberSince;
  final List<String> interests;
  final int matchPercentage;
  final List<String> recommendationChips;
  final String evHighlightChip;
  final String vehicleName;
  final String vehicleColor;
  final String plateNumber;
  final String vehicleAsset;
  final List<UserProfileAmenity> amenities;
  final int experienceYears;
  final int acceptanceRate;
  final int onTimeRate;
  final int cancellationRate;
  final List<String> languages;
  final List<UserProfileReward> rewards;
  final bool nidVerified;
  final bool licenseVerified;
  final List<UserProfileSocialLink> socialLinks;
  final List<UserProfileCircle> circles;
  final String about;
  final List<UserProfileReview> reviews;

  List<UserProfileStat> get stats => [
        UserProfileStat(
          value: rating.toStringAsFixed(1),
          label: 'RATING',
        ),
        UserProfileStat(
          value: '$rides',
          label: 'RIDES',
        ),
        UserProfileStat(
          value: memberSince,
          label: 'SINCE',
        ),
      ];

  static const UserProfileModel demo = UserProfileModel(
    id: 'driver_1',
    name: 'Jack M. Kees',
    headline: 'Professional, verified, and eco-friendly driver.',
    avatarAsset: AppAssets.profileHero,
    isVerified: true,
    rating: 4.8,
    rides: 120,
    memberSince: '2025',
    interests: ['Marketing', 'Tech', 'Startup'],
    matchPercentage: 98,
    recommendationChips: [
      'Near pickup',
      'High rating',
      'Low cancellation',
    ],
    evHighlightChip: 'EV Vehicle',
    vehicleName: 'Tesla Model 3',
    vehicleColor: 'Midnight Silver Metallic',
    plateNumber: 'DA-1342',
    vehicleAsset: AppAssets.profileVehicle,
    amenities: [
      UserProfileAmenity(
        label: '4 Seats',
        icon: Icons.groups_rounded,
      ),
      UserProfileAmenity(
        label: 'AC',
        icon: Icons.ac_unit_rounded,
      ),
      UserProfileAmenity(
        label: 'Electric',
        icon: Icons.energy_savings_leaf_rounded,
      ),
      UserProfileAmenity(
        label: 'Premium',
        icon: Icons.diamond_outlined,
      ),
    ],
    experienceYears: 7,
    acceptanceRate: 96,
    onTimeRate: 98,
    cancellationRate: 0,
    languages: ['HEBREW', 'ENGLISH', 'FRENCH'],
    rewards: [
      UserProfileReward(
        label: 'Fuel\nCoupon',
        icon: Icons.local_gas_station_rounded,
      ),
      UserProfileReward(
        label: 'Coffee\nCoupon',
        icon: Icons.local_cafe_rounded,
      ),
      UserProfileReward(
        label: 'Parking\nCredit',
        icon: Icons.local_parking_rounded,
      ),
    ],
    nidVerified: true,
    licenseVerified: true,
    socialLinks: [
      UserProfileSocialLink(
        label: 'Facebook',
        platform: UserProfileSocialPlatform.facebook,
      ),
      UserProfileSocialLink(
        label: 'Instagram',
        platform: UserProfileSocialPlatform.instagram,
      ),
      UserProfileSocialLink(
        label: 'TikTok',
        platform: UserProfileSocialPlatform.tiktok,
      ),
      UserProfileSocialLink(
        label: 'LinkedIn',
        platform: UserProfileSocialPlatform.linkedin,
      ),
    ],
    circles: [
      UserProfileCircle(
        id: 'french_speakers',
        name: 'French Speakers',
        memberCount: '1.2k members',
        icon: Icons.translate_rounded,
      ),
      UserProfileCircle(
        id: 'tech_enthusiasts',
        name: 'Tech Enthusiasts',
        memberCount: '3.1k members',
        icon: Icons.settings_outlined,
      ),
      UserProfileCircle(
        id: 'foodies_unites',
        name: 'Foodies Unites',
        memberCount: '2.5k members',
        icon: Icons.lunch_dining_rounded,
      ),
      UserProfileCircle(
        id: 'women_only',
        name: 'Women-only',
        memberCount: '1.7k members',
        icon: Icons.female_rounded,
      ),
    ],
    about:
        'I enjoy safe, friendly, and reliable city rides. My goal is to make every journey as comfortable as possible.',
    reviews: [
      UserProfileReview(
        name: 'Sarah Jenkins',
        quote:
            'Very polite and on time. The Tesla was spotless and the drive was incredibly smooth.',
        rating: 5,
        avatarAsset: AppAssets.profileGallery1,
      ),
      UserProfileReview(
        name: 'Marcus Thorne',
        quote:
            "Smooth ride, professional demeanor. Best driver I've had this week.",
        rating: 5,
        avatarAsset: AppAssets.profileGallery2,
      ),
    ],
  );

  static UserProfileModel fromMatch(DriverMatchModel match) {
    return demo.copyWith(
      id: match.id,
      name: match.name,
      headline: match.bio,
      avatarAsset: match.avatarAsset,
      isVerified: match.isVerified,
      rating: match.rating,
      interests: match.tags.take(3).toList(),
      matchPercentage: match.matchPercentage,
      vehicleName: match.vehicle,
    );
  }

  UserProfileModel copyWith({
    String? id,
    String? name,
    String? headline,
    String? avatarAsset,
    bool? isVerified,
    double? rating,
    int? rides,
    String? memberSince,
    List<String>? interests,
    int? matchPercentage,
    String? vehicleName,
  }) {
    return UserProfileModel(
      id: id ?? this.id,
      name: name ?? this.name,
      headline: headline ?? this.headline,
      avatarAsset: avatarAsset ?? this.avatarAsset,
      isVerified: isVerified ?? this.isVerified,
      rating: rating ?? this.rating,
      rides: rides ?? this.rides,
      memberSince: memberSince ?? this.memberSince,
      interests: interests ?? this.interests,
      matchPercentage: matchPercentage ?? this.matchPercentage,
      recommendationChips: recommendationChips,
      evHighlightChip: evHighlightChip,
      vehicleName: vehicleName ?? this.vehicleName,
      vehicleColor: vehicleColor,
      plateNumber: plateNumber,
      vehicleAsset: vehicleAsset,
      amenities: amenities,
      experienceYears: experienceYears,
      acceptanceRate: acceptanceRate,
      onTimeRate: onTimeRate,
      cancellationRate: cancellationRate,
      languages: languages,
      rewards: rewards,
      nidVerified: nidVerified,
      licenseVerified: licenseVerified,
      socialLinks: socialLinks,
      circles: circles,
      about: about,
      reviews: reviews,
    );
  }
}
