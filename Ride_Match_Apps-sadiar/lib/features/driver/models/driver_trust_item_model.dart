class DriverTrustItemModel {
  const DriverTrustItemModel({
    required this.id,
    required this.label,
    required this.isCompleted,
    this.route,
  });

  final String id;
  final String label;
  final bool isCompleted;
  final String? route;

  static const List<DriverTrustItemModel> initialItems = [
    DriverTrustItemModel(
      id: 'photo',
      label: 'Photo',
      isCompleted: true,
    ),
    DriverTrustItemModel(
      id: 'bio',
      label: 'Bio',
      isCompleted: true,
    ),
    DriverTrustItemModel(
      id: 'vehicle',
      label: 'Vehicle',
      isCompleted: true,
    ),
    DriverTrustItemModel(
      id: 'license',
      label: 'License',
      isCompleted: false,
    ),
    DriverTrustItemModel(
      id: 'insurance',
      label: 'Insurance',
      isCompleted: false,
    ),
    DriverTrustItemModel(
      id: 'background_check',
      label: 'Background Check',
      isCompleted: false,
    ),
    DriverTrustItemModel(
      id: 'language',
      label: 'Language',
      isCompleted: true,
    ),
    DriverTrustItemModel(
      id: 'badges',
      label: 'Badges',
      isCompleted: false,
    ),
  ];
}
