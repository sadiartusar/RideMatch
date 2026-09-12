class ProfileModel {
  const ProfileModel({
    required this.name,
    required this.headline,
    required this.badgeLabel,
    required this.bio,
    required this.interests,
    required this.profession,
    required this.languages,
    required this.ridePersonality,
    required this.trustScore,
    required this.rides,
    required this.kmShared,
    required this.isIdVerified,
    required this.totalCoupons,
    required this.travelCoupons,
    required this.earnedCoupons,
    required this.expiringCoupons,
    required this.genderPreference,
    required this.ageRange,
    required this.carType,
    required this.verifiedOnly,
    required this.socialLinks,
    required this.activeMissions,
    required this.sharedRides,
  });

  final String name;
  final String headline;
  final String badgeLabel;
  final String bio;
  final List<String> interests;
  final String profession;
  final String languages;
  final String ridePersonality;
  final double trustScore;
  final int rides;
  final int kmShared;
  final bool isIdVerified;
  final int totalCoupons;
  final int travelCoupons;
  final int earnedCoupons;
  final int expiringCoupons;
  final String genderPreference;
  final String ageRange;
  final String carType;
  final bool verifiedOnly;
  final List<ProfileSocialLink> socialLinks;
  final int activeMissions;
  final int sharedRides;

  static const ProfileModel demo = ProfileModel(
    name: 'Marcus Miller',
    headline: 'Product Lead at FinGo',
    badgeLabel: 'Verified Rider',
    bio:
        'Sustainability enthusiast & product designer. Open to good coffee and networking! ☕✨',
    interests: ['Tech', 'Sustainability', 'Cycling', 'Startups'],
    profession: 'Product Designer at EcoStream',
    languages: 'English, Spanish',
    ridePersonality: 'Networking vibe, Music on',
    trustScore: 4.9,
    rides: 124,
    kmShared: 1240,
    isIdVerified: true,
    totalCoupons: 750,
    travelCoupons: 425,
    earnedCoupons: 120,
    expiringCoupons: 50,
    genderPreference: 'No preference',
    ageRange: '20 - 45 years',
    carType: 'Eco-friendly',
    verifiedOnly: true,
    socialLinks: [
      ProfileSocialLink(label: 'Facebook', icon: ProfileSocialIcon.facebook),
      ProfileSocialLink(label: 'Instagram', icon: ProfileSocialIcon.instagram),
      ProfileSocialLink(label: 'Tiktok', icon: ProfileSocialIcon.tiktok),
      ProfileSocialLink(label: 'LinkedIn', icon: ProfileSocialIcon.linkedin),
    ],
    activeMissions: 3,
    sharedRides: 18,
  );
}

enum ProfileSocialIcon { facebook, instagram, tiktok, linkedin }

class ProfileSocialLink {
  const ProfileSocialLink({
    required this.label,
    required this.icon,
  });

  final String label;
  final ProfileSocialIcon icon;
}
