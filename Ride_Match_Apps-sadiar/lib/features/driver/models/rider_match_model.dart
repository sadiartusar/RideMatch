import '../../../core/constants/app_assets.dart';

class RiderMatchModel {
  const RiderMatchModel({
    required this.id,
    required this.name,
    this.avatarAsset = AppAssets.profileHero,
    this.avatarUrl,
    required this.matchPercentage,
    this.isVerified = true,
    required this.detourMinutes,
    required this.bio,
    required this.sharedKm,
    required this.rideCount,
    required this.tags,
    this.rewardBrand = 'Starbucks',
    this.rewardDetail = '1 Coupon',
    this.incentiveTitle = 'Electric / Gas Voucher',
    this.incentiveSubtitle = 'Rider is offering \$12',
    this.incentiveValue = 12.00,
    this.platformFee = -2.40,
    this.netEarnings = 9.60,
    required this.preMatchMessage,
  });

  final String id;
  final String name;
  final String avatarAsset;
  final String? avatarUrl;
  final int matchPercentage;
  final bool isVerified;
  final int detourMinutes;
  final String bio;
  final double sharedKm;
  final int rideCount;
  final List<String> tags;
  final String rewardBrand;
  final String rewardDetail;
  final String incentiveTitle;
  final String incentiveSubtitle;
  final double incentiveValue;
  final double platformFee;
  final double netEarnings;
  final String preMatchMessage;

  String get detourText => '$detourMinutes min Detour';

  static List<RiderMatchModel> get defaultMatches => [
        const RiderMatchModel(
          id: 'rider_1',
          name: 'Marcus Miller',
          avatarAsset: AppAssets.profileHero,
          matchPercentage: 88,
          isVerified: true,
          detourMinutes: 2,
          bio: 'Tech enthusiast. Daily commute from Palo Alto. Love jazz music.',
          sharedKm: 5.2,
          rideCount: 120,
          tags: ['Startup', 'Christian', 'Single', 'Male'],
          rewardBrand: 'Starbucks',
          rewardDetail: '1 Coupon',
          incentiveTitle: 'Electric / Gas Voucher',
          incentiveSubtitle: 'Rider is offering \$12',
          incentiveValue: 12.00,
          platformFee: -2.40,
          netEarnings: 9.60,
          preMatchMessage:
              'Hey! 👋 Heading To Chinatown Around 10:30 AM. I Have Coffee ☕ With Me — Want To Share The Ride?',
        ),
        const RiderMatchModel(
          id: 'rider_2',
          name: 'Sarah Jenkins',
          avatarAsset: AppAssets.profileGallery1,
          matchPercentage: 92,
          isVerified: true,
          detourMinutes: 3,
          bio: 'Product Designer at FinTech. Quiet rides preferred in the morning.',
          sharedKm: 6.8,
          rideCount: 84,
          tags: ['Design', 'Eco-friendly', 'Female'],
          rewardBrand: 'Blue Bottle',
          rewardDetail: '1 Coffee Voucher',
          incentiveTitle: 'Commute Allowance Voucher',
          incentiveSubtitle: 'Rider is offering \$15',
          incentiveValue: 15.00,
          platformFee: -3.00,
          netEarnings: 12.00,
          preMatchMessage:
              'Good morning! Heading to downtown Palo Alto. On time and ready at the pickup spot.',
        ),
        const RiderMatchModel(
          id: 'rider_3',
          name: 'David Chen',
          avatarAsset: AppAssets.profileGallery2,
          matchPercentage: 79,
          isVerified: true,
          detourMinutes: 5,
          bio: 'Software engineer at Stanford Research. Podcast and audiobooks fan.',
          sharedKm: 4.1,
          rideCount: 42,
          tags: ['Developer', 'Stanford', 'Male'],
          rewardBrand: 'Philz Coffee',
          rewardDetail: 'Free Pastry Coupon',
          incentiveTitle: 'Gas Contribution',
          incentiveSubtitle: 'Rider is offering \$10',
          incentiveValue: 10.00,
          platformFee: -2.00,
          netEarnings: 8.00,
          preMatchMessage:
              'Hi there! Can we share the ride towards Tech Park? Happy to split costs!',
        ),
      ];
}
