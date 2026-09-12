import 'package:flutter/material.dart';

class VoucherAmount {
  const VoucherAmount({required this.dollars});

  final int dollars;

  String get label => '\$$dollars';

  static const List<VoucherAmount> defaults = [
    VoucherAmount(dollars: 2),
    VoucherAmount(dollars: 4),
    VoucherAmount(dollars: 6),
    VoucherAmount(dollars: 8),
    VoucherAmount(dollars: 10),
    VoucherAmount(dollars: 12),
    VoucherAmount(dollars: 14),
    VoucherAmount(dollars: 16),
    VoucherAmount(dollars: 18),
    VoucherAmount(dollars: 20),
  ];
}

enum RewardKind { merchant, special }

class RewardOption {
  const RewardOption({
    required this.id,
    required this.title,
    required this.couponCost,
    required this.kind,
    required this.icon,
    this.expiresInDays,
  });

  final String id;
  final String title;
  final int couponCost;
  final RewardKind kind;
  final IconData icon;
  final int? expiresInDays;

  String get couponLabel =>
      couponCost == 1 ? '1 Coupon' : '$couponCost Coupons';

  static const List<RewardOption> merchants = [
    RewardOption(
      id: 'shell_hydrogen',
      title: 'Shell Hydrogen',
      couponCost: 2,
      kind: RewardKind.merchant,
      icon: Icons.local_gas_station_rounded,
    ),
    RewardOption(
      id: 'starbucks',
      title: 'Starbucks',
      couponCost: 1,
      kind: RewardKind.merchant,
      icon: Icons.local_cafe_rounded,
    ),
    RewardOption(
      id: 'city_parking',
      title: 'City Parking',
      couponCost: 2,
      kind: RewardKind.merchant,
      icon: Icons.local_parking_rounded,
    ),
    RewardOption(
      id: 'partner_merchant',
      title: 'Partner Merchant',
      couponCost: 1,
      kind: RewardKind.merchant,
      icon: Icons.shopping_bag_outlined,
    ),
  ];

  static const RewardOption specialOffer = RewardOption(
    id: 'special_offer',
    title: 'Special Offer',
    couponCost: 3,
    kind: RewardKind.special,
    icon: Icons.star_rounded,
    expiresInDays: 2,
  );
}
