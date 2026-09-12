import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../models/driver_filter_model.dart';
import 'driver_filter_map_preview.dart';

class DriverMatchFilterSheet extends StatefulWidget {
  const DriverMatchFilterSheet({
    super.key,
    required this.onApply,
    this.initialFilter,
  });

  final ValueChanged<DriverFilterModel> onApply;
  final DriverFilterModel? initialFilter;

  @override
  State<DriverMatchFilterSheet> createState() => _DriverMatchFilterSheetState();
}

class _DriverMatchFilterSheetState extends State<DriverMatchFilterSheet> {
  late double _distanceRadius;
  late String _genderPreference;
  late String _religion;
  late Set<String> _selectedInterests;
  late Set<String> _selectedProfessions;
  late Set<String> _selectedLanguages;
  late bool _verifiedProfilesOnly;

  @override
  void initState() {
    super.initState();
    final filter = widget.initialFilter ?? DriverFilterModel();
    _distanceRadius = filter.distanceRadiusKm;
    _genderPreference = filter.genderPreference;
    _religion = filter.religion;
    _selectedInterests = filter.selectedInterests.toSet();
    _selectedProfessions = filter.selectedProfessions.toSet();
    _selectedLanguages = filter.selectedLanguages.toSet();
    _verifiedProfilesOnly = filter.verifiedProfilesOnly;
  }

  void _reset() {
    setState(() {
      _distanceRadius = 5.0;
      _genderPreference = 'Any';
      _religion = 'No Preference';
      _selectedInterests = {'Music', 'Travel'};
      _selectedProfessions = {'Healthcare'};
      _selectedLanguages = {'English', 'Hebrew'};
      _verifiedProfilesOnly = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.88,
      ),
      decoration: const BoxDecoration(
        color: Color(0xFF14171A),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            // Top Handle
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            // Header Bar: Filters & Reset
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFF1B1E22),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Filters',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    InkWell(
                      onTap: _reset,
                      child: const Text(
                        'Reset',
                        style: TextStyle(
                          color: Color(0xFFEF4444),
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Scrollable Options List
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Distance Radius Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Distance Radius',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '${_distanceRadius.round()} ',
                                style: const TextStyle(
                                  color: Color(0xFF32E116),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              const TextSpan(
                                text: 'km',
                                style: TextStyle(
                                  color: Color(0xFF32E116),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // Map preview visual
                    DriverFilterMapPreview(radiusKm: _distanceRadius),
                    const SizedBox(height: 8),
                    // Slider
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: const Color(0xFF32E116),
                        inactiveTrackColor: const Color(0xFF262B32),
                        thumbColor: const Color(0xFF32E116),
                        overlayColor:
                            const Color(0xFF32E116).withValues(alpha: 0.2),
                        trackHeight: 3,
                      ),
                      child: Slider(
                        value: _distanceRadius,
                        min: 1.0,
                        max: 20.0,
                        divisions: 19,
                        onChanged: (val) => setState(() => _distanceRadius = val),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '1KM',
                            style: TextStyle(
                              color: Color(0xFF6B7280),
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            '20KM',
                            style: TextStyle(
                              color: Color(0xFF6B7280),
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Gender Preference
                    _buildSectionHeader('Gender Preference'),
                    const SizedBox(height: 8),
                    _buildSingleSelectChips(
                      options: DriverFilterModel.genderOptions,
                      selected: _genderPreference,
                      onSelect: (val) => setState(() => _genderPreference = val),
                    ),
                    const SizedBox(height: 20),
                    // Religion
                    _buildSectionHeader('Religion'),
                    const SizedBox(height: 8),
                    _buildSingleSelectChips(
                      options: DriverFilterModel.religionOptions,
                      selected: _religion,
                      onSelect: (val) => setState(() => _religion = val),
                    ),
                    const SizedBox(height: 20),
                    // Interests / Hobbies
                    _buildSectionHeader('Interests / Hobbies'),
                    const SizedBox(height: 8),
                    _buildMultiSelectChips(
                      options: DriverFilterModel.interestOptions,
                      selectedSet: _selectedInterests,
                    ),
                    const SizedBox(height: 20),
                    // Profession / Industry
                    _buildSectionHeader('Profession / Industry'),
                    const SizedBox(height: 8),
                    _buildMultiSelectChips(
                      options: DriverFilterModel.professionOptions,
                      selectedSet: _selectedProfessions,
                    ),
                    const SizedBox(height: 20),
                    // Languages
                    _buildSectionHeader('Languages'),
                    const SizedBox(height: 8),
                    _buildMultiSelectChips(
                      options: DriverFilterModel.languageOptions,
                      selectedSet: _selectedLanguages,
                    ),
                    const SizedBox(height: 22),
                    // Verified Profiles Only switch
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Verified Profiles Only',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Higher safety, Manually Reviewed',
                              style: TextStyle(
                                color: Color(0xFF9CA3AF),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        Switch(
                          value: _verifiedProfilesOnly,
                          onChanged: (val) =>
                              setState(() => _verifiedProfilesOnly = val),
                          activeThumbColor: const Color(0xFF32E116),
                          activeTrackColor:
                              const Color(0xFF32E116).withValues(alpha: 0.35),
                          inactiveThumbColor: const Color(0xFF6B7280),
                          inactiveTrackColor: const Color(0xFF23272E),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            // Apply Filters CTA button
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                    widget.onApply(
                      DriverFilterModel(
                        distanceRadiusKm: _distanceRadius,
                        genderPreference: _genderPreference,
                        religion: _religion,
                        selectedInterests: _selectedInterests.toList(),
                        selectedProfessions: _selectedProfessions.toList(),
                        selectedLanguages: _selectedLanguages.toList(),
                        verifiedProfilesOnly: _verifiedProfilesOnly,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.button,
                    foregroundColor: AppColors.buttonForeground,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'Apply Filters',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Color(0xFF9CA3AF),
        fontSize: 13,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _buildSingleSelectChips({
    required List<String> options,
    required String selected,
    required ValueChanged<String> onSelect,
  }) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: options.map((opt) {
        final isSelected = opt == selected;
        return GestureDetector(
          onTap: () => onSelect(opt),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
            decoration: BoxDecoration(
              color: isSelected
                  ? const Color(0xFF32E116)
                  : const Color(0xFF191C20),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: isSelected
                    ? const Color(0xFF32E116)
                    : const Color(0xFF282C33),
              ),
            ),
            child: Text(
              opt,
              style: TextStyle(
                color: isSelected ? Colors.black : Colors.white70,
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildMultiSelectChips({
    required List<String> options,
    required Set<String> selectedSet,
  }) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: options.map((opt) {
        final isSelected = selectedSet.contains(opt);
        return GestureDetector(
          onTap: () {
            setState(() {
              if (isSelected) {
                selectedSet.remove(opt);
              } else {
                selectedSet.add(opt);
              }
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
            decoration: BoxDecoration(
              color: isSelected
                  ? const Color(0xFF32E116)
                  : const Color(0xFF191C20),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: isSelected
                    ? const Color(0xFF32E116)
                    : const Color(0xFF282C33),
              ),
            ),
            child: Text(
              opt,
              style: TextStyle(
                color: isSelected ? Colors.black : Colors.white70,
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
