import 'package:drops/repositories/stories_repository.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class StoriesController extends GetxController {
  final StoriesRepository repo = Get.find<StoriesRepository>();
  RxList<dynamic> stories = [].obs;

  @override
  void onInit() {
    super.onInit();
  }

  void getStories(String childId) async{
    print("Getting stories");
    stories.value = await repo.getStoriesList(childId);
  }
}