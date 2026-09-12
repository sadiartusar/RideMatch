import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../driver/controllers/driver_home_controller.dart';
import '../../driver/models/driver_trust_item_model.dart';
import '../../flex/controllers/flex_home_controller.dart';
import '../../main_nav/mode_theme.dart';
import '../../rider/controllers/rider_home_controller.dart';
import '../models/edit_profile_model.dart';

class EditProfileController extends GetxController {
  bool get isDark => ModeTheme.isDark;
  late final TextEditingController fullNameController;
  late final TextEditingController titleController;
  late final TextEditingController aboutController;
  late final TextEditingController modelController;
  late final TextEditingController plateController;

  final RxList<String> languages = <String>[].obs;
  final RxList<String> rewards = <String>[].obs;
  final RxList<SocialTrustLink> socialLinks = <SocialTrustLink>[].obs;
  final RxList<DriverDocumentItem> documents = <DriverDocumentItem>[].obs;
  final RxBool blackboxEnabled = true.obs;

  late final EditProfileModel model;

  @override
  void onInit() {
    super.onInit();
    model = EditProfileModel.demo;
    fullNameController = TextEditingController(text: model.fullName);
    titleController = TextEditingController(text: model.professionalTitle);
    aboutController = TextEditingController(text: model.aboutMe);
    modelController = TextEditingController(text: model.vehicleModel);
    plateController = TextEditingController(text: model.plateNumber);

    languages.assignAll(model.languages);
    rewards.assignAll(model.rewards);
    socialLinks.assignAll(model.socialLinks);
    documents.assignAll(model.documents);
    blackboxEnabled.value = model.blackboxEnabled;
  }

  @override
  void onClose() {
    fullNameController.dispose();
    titleController.dispose();
    aboutController.dispose();
    modelController.dispose();
    plateController.dispose();
    super.onClose();
  }

  void goBack() => Get.back();

  void removeLanguage(String value) => languages.remove(value);

  void addLanguage() {
    const options = ['Spanish', 'German', 'Arabic', 'Hindi'];
    for (final option in options) {
      if (!languages.contains(option)) {
        languages.add(option);
        return;
      }
    }
  }

  void removeReward(String value) => rewards.remove(value);

  void addReward() {
    const options = ['Toll Coupon', 'Wash Coupon', 'Charge Coupon'];
    for (final option in options) {
      if (!rewards.contains(option)) {
        rewards.add(option);
        return;
      }
    }
  }

  void uploadDocument(int index) {
    final current = documents[index];
    documents[index] = DriverDocumentItem(
      label: current.label,
      icon: current.icon,
      isUploaded: true,
    );
  }

  void toggleBlackbox(bool value) => blackboxEnabled.value = value;

  void removeSocial(int index) => socialLinks.removeAt(index);

  void updateSocialLink(int index, String value) {
    final current = socialLinks[index];
    socialLinks[index] = SocialTrustLink(
      platform: current.platform,
      icon: current.icon,
      brandColor: current.brandColor,
      profileLink: value,
      isVerified: value.trim().isNotEmpty,
    );
  }

  void addPlatform() {
    Get.snackbar(
      'Social Trust',
      'More platforms coming soon.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF1F2937),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }

  void editPhoto(int index) {
    Get.snackbar(
      'Edit Photo',
      'Photo $index editor coming soon.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF1F2937),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }

  void addMorePhotos() {
    Get.snackbar(
      'Photos',
      'Add more photos coming soon.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF1F2937),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }

  void updateVehiclePhoto() {
    Get.snackbar(
      'Vehicle Photo',
      'Update vehicle photo coming soon.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF1F2937),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }

  void save() {
    _markProfileComplete();

    Get.snackbar(
      'Profile Complete',
      'Your verification profile has been updated.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF166534),
      colorText: const Color(0xFF4ADE80),
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
    Future.delayed(const Duration(milliseconds: 400), Get.back);
  }

  void _markProfileComplete() {
    if (Get.isRegistered<RiderHomeController>()) {
      Get.find<RiderHomeController>().verificationPercent.value = 100;
    }
    if (Get.isRegistered<FlexHomeController>()) {
      Get.find<FlexHomeController>().verificationPercent.value = 100;
    }
    if (Get.isRegistered<DriverHomeController>()) {
      final driver = Get.find<DriverHomeController>();
      driver.trustItems.assignAll(
        driver.trustItems
            .map(
              (item) => DriverTrustItemModel(
                id: item.id,
                label: item.label,
                isCompleted: true,
                route: item.route,
              ),
            )
            .toList(),
      );
    }

    // Mark remaining documents as uploaded when finishing profile.
    for (var i = 0; i < documents.length; i++) {
      final current = documents[i];
      if (!current.isUploaded) {
        documents[i] = DriverDocumentItem(
          label: current.label,
          icon: current.icon,
          isUploaded: true,
        );
      }
    }
  }
}
