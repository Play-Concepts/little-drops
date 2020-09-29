import 'package:drops/entities/child.dart';
import 'package:drops/entities/story.dart';
import 'package:drops/repositories/stories_repository.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class StoriesController extends GetxController {
  final StoriesRepository repo = Get.find<StoriesRepository>();
  RxList<dynamic> stories = [].obs;
  RxList<dynamic> storyChapters = [].obs;
  RxInt totalStoriesCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void getStories(String childId) async{
    print("Getting stories");
    stories.value = await repo.getStoriesList(childId);
  }

  Future<void> getTotalStoriesCount(List<Child> children) async {
    int total = 0;
    await children.forEach((child) async {
      List<Story> stories = await repo.getStoriesList(child.recordId);
      total += stories.length;
    });
    totalStoriesCount.value = total;
  }

  void getStoryChapters(String childId, String storyId) async{
    storyChapters.value = await repo.getStoryChapters(childId, storyId);
    print(storyChapters.value);
  }
}