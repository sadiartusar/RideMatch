class MatchFilterModel {
  MatchFilterModel({
    this.distanceRadiusKm = 5.0,
    this.genderPreference = 'Any',
    this.religion = 'No Preference',
    List<String>? selectedInterests,
    this.verifiedProfilesOnly = true,
  }) : selectedInterests = selectedInterests ?? ['Music', 'Travel'];

  double distanceRadiusKm;
  String genderPreference;
  String religion;
  List<String> selectedInterests;
  bool verifiedProfilesOnly;

  static const List<String> genderOptions = [
    'Any',
    'Male only',
    'Female only',
    'Non-binary',
  ];

  static const List<String> religionOptions = [
    'No Preference',
    'Jewish',
    'Muslim',
    'Christian',
    'Druze',
    'Secular',
    'Others',
  ];

  static const List<String> interestOptions = [
    'Music',
    'Tech',
    'Travel',
    'Business',
    'Fitness',
  ];
}
