import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../controllers/edit_profile_controller.dart';
import '../widgets/edit_driver_documents_section.dart';
import '../widgets/edit_form_fields.dart';
import '../widgets/edit_photo_grid.dart';
import '../widgets/edit_social_trust_section.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = controller.isDark;
    final scaffold = isDark ? const Color(0xFF0D0F11) : Colors.white;
    final titleColor = isDark ? Colors.white : const Color(0xFF111827);
    final sectionLabel =
        isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: (isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark)
          .copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor:
            isDark ? const Color(0xFF0B0D0F) : Colors.white,
        systemNavigationBarIconBrightness:
            isDark ? Brightness.light : Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: scaffold,
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: controller.goBack,
                      icon: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 20,
                        color: titleColor,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Profile',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: titleColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      EditPhotoGrid(
                        isDark: isDark,
                        onEditPhoto: controller.editPhoto,
                        onAddMore: controller.addMorePhotos,
                      ),
                      const SizedBox(height: 22),
                      Center(
                        child: Text(
                          'VERIFIED IDENTITY',
                          style: TextStyle(
                            color: sectionLabel,
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      EditLabeledField(
                        label: 'Full Name',
                        controller: controller.fullNameController,
                        isDark: isDark,
                      ),
                      const SizedBox(height: 14),
                      EditLabeledField(
                        label: 'Professional Title',
                        controller: controller.titleController,
                        maxLines: 2,
                        isDark: isDark,
                      ),
                      const SizedBox(height: 14),
                      EditLabeledField(
                        label: 'About Me',
                        controller: controller.aboutController,
                        maxLines: 5,
                        isDark: isDark,
                      ),
                      const SizedBox(height: 18),
                      Obx(
                        () => EditTagSection(
                          title: 'Languages',
                          tags: controller.languages.toList(),
                          addLabel: '+ Add Language',
                          onRemove: controller.removeLanguage,
                          onAdd: controller.addLanguage,
                          isDark: isDark,
                        ),
                      ),
                      const SizedBox(height: 18),
                      Obx(
                        () => EditTagSection(
                          title: 'Driver Rewards & Perks',
                          tags: controller.rewards.toList(),
                          addLabel: '+ Add Reward',
                          onRemove: controller.removeReward,
                          onAdd: controller.addReward,
                          isDark: isDark,
                        ),
                      ),
                      const SizedBox(height: 22),
                      Obx(
                        () => EditDriverDocumentsSection(
                          modelController: controller.modelController,
                          plateController: controller.plateController,
                          features: controller.model.vehicleFeatures,
                          documents: controller.documents.toList(),
                          blackboxEnabled: controller.blackboxEnabled.value,
                          onUpdateVehiclePhoto: controller.updateVehiclePhoto,
                          onUploadDocument: controller.uploadDocument,
                          onToggleBlackbox: controller.toggleBlackbox,
                          isDark: isDark,
                        ),
                      ),
                      const SizedBox(height: 18),
                      Obx(
                        () => EditSocialTrustSection(
                          links: controller.socialLinks.toList(),
                          onRemove: controller.removeSocial,
                          onLinkChanged: controller.updateSocialLink,
                          onAddMore: controller.addPlatform,
                          isDark: isDark,
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        height: 54,
                        child: ElevatedButton(
                          onPressed: controller.save,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.button,
                            foregroundColor: AppColors.buttonForeground,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: const Text(
                            'Save',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
