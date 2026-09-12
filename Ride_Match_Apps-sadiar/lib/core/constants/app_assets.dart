abstract class AppAssets {
  AppAssets._();

  static const String navHome = 'assets/icons/nav/nav_home.png';
  static const String navRoute = 'assets/icons/nav/nav_route.png';
  static const String navChat = 'assets/icons/nav/nav_chat.png';
  static const String navWallet = 'assets/icons/nav/nav_wallet.png';
  static const String navProfile = 'assets/icons/nav/nav_profile.png';

  static const String profileHero = 'assets/images/profile/profile_hero.jpg';
  static const String profileGallery1 = 'assets/images/profile/gallery_1.jpg';
  static const String profileGallery2 = 'assets/images/profile/gallery_2.jpg';
  static const String profileGallery3 = 'assets/images/profile/gallery_3.jpg';
  static const String profileVehicle = 'assets/images/profile/vehicle.jpg';

  // Marketplace & Wallet
  static const String shellStation = 'assets/images/marketplace/shell_station.jpg';
  static const String teslaStation = 'assets/images/marketplace/tesla_station.jpg';
  static const String fuelOffer = 'assets/images/marketplace/fuel_offer.jpg';
  static const String coffeeOffer = 'assets/images/marketplace/coffee_offer.jpg';

  /// Same person shown with different crops in the gallery.
  static const List<String> profileGallery = [
    profileHero,
    profileHero,
    profileHero,
  ];
}
