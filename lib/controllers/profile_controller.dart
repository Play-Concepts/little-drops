import 'package:drops/entities/profile.dart';
import 'package:drops/repositories/profile_repository.dart';
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

  void getChildren() async {
    children.value = await repo.getChildren();
  }
}
