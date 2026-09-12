import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../models/match_filter_model.dart';

class MatchListFilterSheet extends StatefulWidget {
  const MatchListFilterSheet({
    super.key,
    required this.onApply,
    this.initialFilter,
  });

  final ValueChanged<MatchFilterModel> onApply;
  final MatchFilterModel? initialFilter;

  @override
  State<MatchListFilterSheet> createState() => _MatchListFilterSheetState();
}

class _MatchListFilterSheetState extends State<MatchListFilterSheet> {
  late double _distanceRadius;
  late String _genderPreference;
  late String _religion;
  late Set<String> _selectedInterests;
  late bool _verifiedProfilesOnly;

  @override
  void initState() {
    super.initState();
    final filter = widget.initialFilter ?? MatchFilterModel();
    _distanceRadius = filter.distanceRadiusKm;
    _genderPreference = filter.genderPreference;
    _religion = filter.religion;
    _selectedInterests = filter.selectedInterests.toSet();
    _verifiedProfilesOnly = filter.verifiedProfilesOnly;
  }

  void _reset() {
    setState(() {
      _distanceRadius = 5.0;
      _genderPreference = 'Any';
      _religion = 'No Preference';
      _selectedInterests = {'Music', 'Travel'};
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
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFE5E7EB),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F9FB),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Filters',
                      style: TextStyle(
                        color: Color(0xFF111827),
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
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Distance Radius',
                          style: TextStyle(
                            color: Color(0xFF111827),
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
                                  color: Color(0xFF16A34A),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              const TextSpan(
                                text: 'km',
                                style: TextStyle(
                                  color: Color(0xFF16A34A),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: AppColors.button,
                        inactiveTrackColor: const Color(0xFFE5E7EB),
                        thumbColor: AppColors.button,
                        overlayColor: AppColors.button.withValues(alpha: 0.2),
                        trackHeight: 3,
                      ),
                      child: Slider(
                        value: _distanceRadius,
                        min: 1.0,
                        max: 20.0,
                        divisions: 19,
                        onChanged: (val) =>
                            setState(() => _distanceRadius = val),
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
                              color: Color(0xFF9CA3AF),
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            '20KM',
                            style: TextStyle(
                              color: Color(0xFF9CA3AF),
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildSectionHeader('Gender Preference'),
                    const SizedBox(height: 8),
                    _buildSingleSelectChips(
                      options: MatchFilterModel.genderOptions,
                      selected: _genderPreference,
                      onSelect: (val) =>
                          setState(() => _genderPreference = val),
                    ),
                    const SizedBox(height: 20),
                    _buildSectionHeader('Religion'),
                    const SizedBox(height: 8),
                    _buildSingleSelectChips(
                      options: MatchFilterModel.religionOptions,
                      selected: _religion,
                      onSelect: (val) => setState(() => _religion = val),
                    ),
                    const SizedBox(height: 20),
                    _buildSectionHeader('Interests / Hobbies'),
                    const SizedBox(height: 8),
                    _buildMultiSelectChips(
                      options: MatchFilterModel.interestOptions,
                      selectedSet: _selectedInterests,
                    ),
                    const SizedBox(height: 22),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Verified Profiles Only',
                              style: TextStyle(
                                color: Color(0xFF111827),
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Higher safety, Manually Reviewed',
                              style: TextStyle(
                                color: Color(0xFF6B7280),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        Switch(
                          value: _verifiedProfilesOnly,
                          onChanged: (val) =>
                              setState(() => _verifiedProfilesOnly = val),
                          activeThumbColor: AppColors.button,
                          activeTrackColor:
                              AppColors.button.withValues(alpha: 0.35),
                          inactiveThumbColor: const Color(0xFF9CA3AF),
                          inactiveTrackColor: const Color(0xFFE5E7EB),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                    widget.onApply(
                      MatchFilterModel(
                        distanceRadiusKm: _distanceRadius,
                        genderPreference: _genderPreference,
                        religion: _religion,
                        selectedInterests: _selectedInterests.toList(),
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
        color: Color(0xFF6B7280),
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
              color: isSelected ? AppColors.button : const Color(0xFFF8F9FB),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: isSelected ? AppColors.button : const Color(0xFFE5E7EB),
              ),
            ),
            child: Text(
              opt,
              style: TextStyle(
                color: isSelected
                    ? AppColors.buttonForeground
                    : const Color(0xFF4B5563),
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
              color: isSelected ? AppColors.button : const Color(0xFFF8F9FB),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: isSelected ? AppColors.button : const Color(0xFFE5E7EB),
              ),
            ),
            child: Text(
              opt,
              style: TextStyle(
                color: isSelected
                    ? AppColors.buttonForeground
                    : const Color(0xFF4B5563),
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
