import 'package:drops/entities/profile.dart';
import 'package:drops/repositories/profile_repository.dart';
import 'package:drops/utils/ld_colors.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class ProfileController extends GetxController {
  final ProfileRepository repo = Get.find<ProfileRepository>();
  RxList<dynamic> children = [].obs;
  Rx<Profile> profile = Profile().obs;

  @override
  void onInit() {
    getProfile();
    getChildren();
    super.onInit();
  }

  void getProfile() async {
    profile.value = await repo.getProfile();
  }

  void saveProfile(String name, {Function onSuccess}) async {
    await repo.saveProfile(name)
        .then((savedProfile) {
      profile.value = savedProfile;
      onSuccess.call();
    }).catchError((error) {
      Get.snackbar('Error', error.toString(),
          backgroundColor: ldSecondaryColorRed,
          colorText: ldTextTertiaryColor);
    });
  }

  void updateProfile(String recordId, String name, {Function onSuccess}) async {
    await repo.updateProfile(recordId, name)
        .then((updatedToken) {
      profile.value = updatedToken;
      onSuccess.call();
    }).catchError((error) {
      Get.snackbar('Error', error.toString(),
          backgroundColor: ldSecondaryColorRed,
          colorText: ldTextTertiaryColor);
    });
  }

  void getChildren() async {
    children.value = await repo.getChildren();
  }
}
