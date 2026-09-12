import 'package:flutter/material.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../models/edit_profile_model.dart';

class EditDriverDocumentsSection extends StatelessWidget {
  const EditDriverDocumentsSection({
    super.key,
    required this.modelController,
    required this.plateController,
    required this.features,
    required this.documents,
    required this.blackboxEnabled,
    required this.onUpdateVehiclePhoto,
    required this.onUploadDocument,
    required this.onToggleBlackbox,
    this.isDark = false,
  });

  final TextEditingController modelController;
  final TextEditingController plateController;
  final List<VehicleFeature> features;
  final List<DriverDocumentItem> documents;
  final bool blackboxEnabled;
  final VoidCallback onUpdateVehiclePhoto;
  final ValueChanged<int> onUploadDocument;
  final ValueChanged<bool> onToggleBlackbox;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final cardBg = isDark ? const Color(0xFF16181B) : Colors.white;
    final border = isDark ? AppColors.darkBorder : AppColors.border;
    final titleColor = isDark ? Colors.white : const Color(0xFF111827);
    final muted = isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280);
    final fieldBg = isDark ? const Color(0xFF1B1E23) : const Color(0xFFF3F4F6);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.directions_car_filled_outlined, color: muted, size: 18),
            const SizedBox(width: 8),
            Text(
              'Driver Documents',
              style: TextStyle(
                color: titleColor,
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: border),
          ),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        AppAssets.profileVehicle,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: const Color(0xFF1F2937),
                            child: const Icon(
                              Icons.directions_car_rounded,
                              color: Color(0xFF9CA3AF),
                              size: 48,
                            ),
                          );
                        },
                      ),
                      Positioned(
                        left: 10,
                        bottom: 10,
                        child: InkWell(
                          onTap: onUpdateVehiclePhoto,
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xCC111827),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.note_add_outlined,
                                  size: 14,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 6),
                                Text(
                                  'Update Photo',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _MiniField(
                      label: 'MODEL',
                      controller: modelController,
                      fill: fieldBg,
                      isDark: isDark,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _MiniField(
                      label: 'PLATE NUMBER',
                      controller: plateController,
                      fill: fieldBg,
                      isDark: isDark,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: features.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 2.8,
                ),
                itemBuilder: (context, index) {
                  final feature = features[index];
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: fieldBg,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: border),
                    ),
                    child: Row(
                      children: [
                        Icon(feature.icon, size: 16, color: muted),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            feature.label,
                            style: TextStyle(
                              color: titleColor,
                              fontSize: 12.5,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.check_box_rounded,
                          size: 18,
                          color: AppColors.button,
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),
              for (var i = 0; i < documents.length; i++) ...[
                _DocumentRow(
                  item: documents[i],
                  isDark: isDark,
                  onUpload: () => onUploadDocument(i),
                ),
                if (i != documents.length - 1) const SizedBox(height: 8),
              ],
            ],
          ),
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: border),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.videocam_rounded,
                color: AppColors.button,
                size: 20,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Blackbox Recording',
                  style: TextStyle(
                    color: muted,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                height: 24,
                width: 24,
                child: Checkbox(
                  value: blackboxEnabled,
                  onChanged: (value) => onToggleBlackbox(value ?? false),
                  activeColor: AppColors.button,
                  checkColor: const Color(0xFF0F172A),
                  side: BorderSide(color: border),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MiniField extends StatelessWidget {
  const _MiniField({
    required this.label,
    required this.controller,
    required this.fill,
    required this.isDark,
  });

  final String label;
  final TextEditingController controller;
  final Color fill;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF9CA3AF),
            fontSize: 10,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.6,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          style: TextStyle(
            color: isDark ? Colors.white : const Color(0xFF111827),
            fontSize: 13.5,
            fontWeight: FontWeight.w700,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: fill,
            isDense: true,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}

class _DocumentRow extends StatelessWidget {
  const _DocumentRow({
    required this.item,
    required this.isDark,
    required this.onUpload,
  });

  final DriverDocumentItem item;
  final bool isDark;
  final VoidCallback onUpload;

  @override
  Widget build(BuildContext context) {
    final muted = isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280);
    final title = isDark ? Colors.white : const Color(0xFF111827);
    final rowBg = isDark ? const Color(0xFF1B1E23) : const Color(0xFFF8FAFC);
    final border = isDark ? AppColors.darkBorder : AppColors.border;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: rowBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: border),
      ),
      child: Row(
        children: [
          Icon(item.icon, size: 18, color: muted),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              item.label,
              style: TextStyle(
                color: title,
                fontSize: 13.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          if (item.isUploaded)
            Container(
              width: 24,
              height: 24,
              decoration: const BoxDecoration(
                color: AppColors.button,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_rounded,
                size: 14,
                color: Color(0xFF0F172A),
              ),
            )
          else
            GestureDetector(
              onTap: onUpload,
              child: Text(
                'UPLOAD',
                style: TextStyle(
                  color: muted,
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.4,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
