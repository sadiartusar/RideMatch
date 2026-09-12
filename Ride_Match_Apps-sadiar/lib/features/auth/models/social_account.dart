class SocialAccount {
  const SocialAccount({
    required this.name,
    required this.email,
    required this.initials,
    required this.avatarColor,
  });

  final String name;
  final String email;
  final String initials;
  final int avatarColor;
}

abstract class SocialDemoAccounts {
  SocialDemoAccounts._();

  static const googleAccounts = [
    SocialAccount(
      name: 'Carlton Johnson',
      email: 'carlton.johnson@gmail.com',
      initials: 'CJ',
      avatarColor: 0xFF334155,
    ),
    SocialAccount(
      name: 'Sarah Miller',
      email: 's.miller.creative@gmail.com',
      initials: 'SM',
      avatarColor: 0xFF7C3AED,
    ),
  ];

  static const appleAccount = SocialAccount(
    name: 'Carlton G. Johnson',
    email: 'carlton.j@icloud.com',
    initials: 'CJ',
    avatarColor: 0xFF334155,
  );
}
