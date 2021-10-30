import 'package:drops/entities/child.dart';
import 'package:drops/entities/profile.dart';
import 'package:drops/repositories/profile_repository.dart';
import 'package:drops/repositories/stories_repository.dart';
import 'package:drops/utils/ld_colors.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class ProfileController extends GetxController {
  final ProfileRepository repo = Get.find<ProfileRepository>();
  final StoriesRepository storiesRepository = Get.find<StoriesRepository>();
  RxList<dynamic>? children = [].obs;
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

  void saveProfile(String name, {Function? onSuccess}) async {
    await repo.saveProfile(name).then((savedProfile) {
      profile.value = savedProfile;
      onSuccess!.call();
    }).catchError((error) {
      Get.snackbar('Error', error.toString(),
          backgroundColor: ldSecondaryColorRed, colorText: ldTextTertiaryColor);
    });
  }

  void upsertProfile(String? recordId, String name,
      {Function? onSuccess}) async {
    Future<Profile> profileFuture = (recordId == null || recordId == '')
        ? repo.saveProfile(name)
        : repo.updateProfile(recordId, name);
    await profileFuture.then((updatedProfile) {
      profile.value = updatedProfile;
      onSuccess!.call();
    }).catchError((error) {
      Get.snackbar('Error', error.toString(),
          backgroundColor: ldSecondaryColorRed, colorText: ldTextTertiaryColor);
    });
  }

  void getChildren() async {
    children!.value = await repo.getChildren();
  }

  void saveChild(String name,
      {String? relationship, Function? onSuccess}) async {
    await repo.saveChild(name, relationship: relationship!).then((savedChild) {
      getChildren();
      onSuccess!.call();
    }).catchError((error) {
      Get.snackbar('Error', error.toString(),
          backgroundColor: ldSecondaryColorRed, colorText: ldTextTertiaryColor);
    });
  }

  void updateChild(String recordId, String name,
      {String? relationship, Function? onSuccess}) async {
    await repo
        .updateChild(recordId, name, relationship: relationship!)
        .then((updatedChild) {
      getChildren();
      onSuccess!.call();
    }).catchError((error) {
      Get.snackbar('Error', error.toString(),
          backgroundColor: ldSecondaryColorRed, colorText: ldTextTertiaryColor);
    });
  }

  void deleteChild(String recordId) async {
    storiesRepository.getStoriesList(recordId).then((stories) {
      stories.forEach((story) {
        storiesRepository.deleteStory(recordId, story.recordId!);
      });
    });
    await repo.deleteChild(recordId);
    getChildren();
  }
}
