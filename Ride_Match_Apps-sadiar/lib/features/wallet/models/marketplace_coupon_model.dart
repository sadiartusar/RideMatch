import '../../../core/constants/app_assets.dart';

class MarketplacePartnerModel {
  const MarketplacePartnerModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.category,
    required this.couponCost,
    required this.validityEnds,
    required this.rating,
    required this.reviewCount,
    required this.overviewText,
    this.imageAsset,
    this.isVerified = true,
    this.isExpiringSoon = false,
  });

  final String id;
  final String title;
  final String subtitle;
  final String category;
  final int couponCost;
  final String validityEnds;
  final double rating;
  final int reviewCount;
  final String overviewText;
  final String? imageAsset;
  final bool isVerified;
  final bool isExpiringSoon;

  static const List<MarketplacePartnerModel> demoPartners = [
    MarketplacePartnerModel(
      id: 'shell_h2',
      title: 'Premium Shell Hydrogen',
      subtitle: 'Save 25 Coupons per KG',
      category: 'Fuel',
      couponCost: 210,
      validityEnds: 'ENDS OCT 24',
      rating: 4.9,
      reviewCount: 120,
      imageAsset: AppAssets.shellStation,
      overviewText:
          'This premium hydrogen fuel benefit is designed exclusively for high-performance drivers within the network. Valid at all Shell Hydrogen VIP locations. It is a non-invasive, seamless liquidity with an 8-minute fill expect, perfect for long-distance commuters looking to maximize their ride profitability.',
      isVerified: true,
    ),
    MarketplacePartnerModel(
      id: 'tesla_supercharger',
      title: 'Tesla Supercharger',
      subtitle: 'Free 50kWh Session',
      category: 'EV',
      couponCost: 180,
      validityEnds: 'ENDS NOV 15',
      rating: 4.8,
      reviewCount: 95,
      imageAsset: AppAssets.teslaStation,
      overviewText:
          'Enjoy fast, high-output EV charging at all Tesla Supercharger network stations across the metropolitan region. Instant redemption code activated at the stall.',
      isVerified: true,
    ),
  ];

  static const List<MarketplacePartnerModel> expiringSoonDeals = [
    MarketplacePartnerModel(
      id: 'starbucks_coffee',
      title: 'Starbucks Coffee',
      subtitle: 'EXPIRES IN 4H 12M',
      category: 'Coffee',
      couponCost: 30,
      validityEnds: 'ENDS IN 4H 12M',
      rating: 4.9,
      reviewCount: 240,
      overviewText:
          'Complimentary handcrafted beverage at any participating Starbucks drive-thru or counter.',
      isVerified: true,
      isExpiringSoon: true,
    ),
    MarketplacePartnerModel(
      id: 'zara_discount',
      title: 'Zara Discount',
      subtitle: 'EXPIRES IN 6H 45M',
      category: 'Retail',
      couponCost: 40,
      validityEnds: 'ENDS IN 6H 45M',
      rating: 4.8,
      reviewCount: 150,
      overviewText:
          'Exclusive 10% discount voucher for RideMatch drivers on apparel and accessories.',
      isVerified: true,
      isExpiringSoon: true,
    ),
  ];
}
