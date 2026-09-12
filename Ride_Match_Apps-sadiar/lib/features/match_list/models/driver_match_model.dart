import '../../../core/constants/app_assets.dart';

enum DriverSocialPlatform { facebook, instagram, tiktok, linkedin }

class DriverSocialLink {
  const DriverSocialLink({
    required this.platform,
    required this.label,
  });

  final DriverSocialPlatform platform;
  final String label;
}

class DriverMatchModel {
  const DriverMatchModel({
    required this.id,
    required this.name,
    this.avatarAsset = AppAssets.profileHero,
    required this.matchPercentage,
    this.isVerified = true,
    required this.rating,
    required this.bio,
    required this.detourMinutes,
    required this.vehicle,
    required this.sharedKm,
    required this.tags,
    this.socialLinks = const [
      DriverSocialLink(
        platform: DriverSocialPlatform.facebook,
        label: 'Facebook',
      ),
      DriverSocialLink(
        platform: DriverSocialPlatform.instagram,
        label: 'Instagram',
      ),
      DriverSocialLink(
        platform: DriverSocialPlatform.tiktok,
        label: 'TikTok',
      ),
      DriverSocialLink(
        platform: DriverSocialPlatform.linkedin,
        label: 'LinkedIn',
      ),
    ],
  });

  final String id;
  final String name;
  final String avatarAsset;
  final int matchPercentage;
  final bool isVerified;
  final double rating;
  final String bio;
  final int detourMinutes;
  final String vehicle;
  final double sharedKm;
  final List<String> tags;
  final List<DriverSocialLink> socialLinks;

  String get detourText => '$detourMinutes mins detour';

  String get gender {
    final match = tags.where(
      (tag) => tag == 'Male' || tag == 'Female' || tag == 'Non-binary',
    );
    return match.isEmpty ? 'Any' : match.first;
  }

  static List<DriverMatchModel> get defaultMatches => [
        const DriverMatchModel(
          id: 'driver_1',
          name: 'Jack M. Kees',
          avatarAsset: AppAssets.profileHero,
          matchPercentage: 88,
          rating: 4.9,
          bio:
              'Tech enthusiast. Daily commute from Palo Alto. Love jazz music.',
          detourMinutes: 9,
          vehicle: 'Tesla 3 (2022)',
          sharedKm: 5.2,
          tags: ['Startup', 'Christian', 'Single', 'Male'],
        ),
        const DriverMatchModel(
          id: 'driver_2',
          name: 'Sarah Jenkins',
          avatarAsset: AppAssets.profileGallery1,
          matchPercentage: 92,
          rating: 4.8,
          bio:
              'Product designer. Quiet morning rides and good playlists only.',
          detourMinutes: 4,
          vehicle: 'Honda Civic (2021)',
          sharedKm: 6.8,
          tags: ['Design', 'Eco-friendly', 'Single', 'Female'],
        ),
        const DriverMatchModel(
          id: 'driver_3',
          name: 'David Chen',
          avatarAsset: AppAssets.profileGallery2,
          matchPercentage: 79,
          rating: 4.7,
          bio:
              'Software engineer at Stanford Research. Podcasts and audiobooks fan.',
          detourMinutes: 6,
          vehicle: 'Toyota Prius (2020)',
          sharedKm: 4.1,
          tags: ['Developer', 'Stanford', 'Single', 'Male'],
        ),
      ];
}
