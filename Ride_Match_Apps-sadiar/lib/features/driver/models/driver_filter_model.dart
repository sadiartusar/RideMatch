class DriverFilterModel {
  DriverFilterModel({
    this.distanceRadiusKm = 5.0,
    this.genderPreference = 'Any',
    this.religion = 'No Preference',
    List<String>? selectedInterests,
    List<String>? selectedProfessions,
    List<String>? selectedLanguages,
    this.verifiedProfilesOnly = true,
  })  : selectedInterests = selectedInterests ?? ['Music', 'Travel'],
        selectedProfessions = selectedProfessions ?? ['Healthcare'],
        selectedLanguages = selectedLanguages ?? ['English', 'Hebrew'];

  double distanceRadiusKm;
  String genderPreference;
  String religion;
  List<String> selectedInterests;
  List<String> selectedProfessions;
  List<String> selectedLanguages;
  bool verifiedProfilesOnly;

  static final List<String> genderOptions = [
    'Any',
    'Male only',
    'Female only',
    'Non-binary',
  ];

  static final List<String> religionOptions = [
    'No Preference',
    'Jewish',
    'Muslim',
    'Christian',
    'Druze',
    'Secular',
    'Others',
  ];

  static final List<String> interestOptions = [
    'Music',
    'Tech',
    'Travel',
    'Business',
    'Fitness',
  ];

  static final List<String> professionOptions = [
    'Healthcare',
    'Tech',
    'Finance',
    'Creative',
  ];

  static final List<String> languageOptions = [
    'English',
    'Hebrew',
    'Arabic',
    'French',
  ];
}
