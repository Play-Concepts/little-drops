import 'package:drops/repositories/profile_repository.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class ProfileController extends GetxController {
  final ProfileRepository repo = Get.find<ProfileRepository>();
  RxList<dynamic> children = [].obs;

  @override
  void onInit() {
    print('init get children');
    getChildren();
    super.onInit();
  }

  void getChildren() async{
    print("Getting children");
    children.value = await repo.getChildren();
  }
}
