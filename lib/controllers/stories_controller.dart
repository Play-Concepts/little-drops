import 'package:drops/entities/child.dart';
import 'package:drops/entities/story.dart';
import 'package:drops/repositories/stories_repository.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';

import 'package:drops/utils/data_keys.dart';

class StoriesController extends GetxController {
  final StoriesRepository repo = Get.find<StoriesRepository>();
  final GetStorage box = GetStorage(dkStore);

  RxList<dynamic> stories = [].obs;
  RxList<dynamic> storyChapters = [].obs;
  RxList<dynamic> storiesEdit = [].obs;
  RxList<dynamic> storyChaptersEdit = [].obs;
  RxInt totalStoriesCount = 0.obs;

  RxString selectChildId = ''.obs;
  RxString selectChildName = ''.obs;

  RxString selectChildIdEdit = ''.obs;
  RxString selectChildNameEdit = ''.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void getStories(String childId, {editMode: false}) async {
    if (editMode)
      storiesEdit.value = await repo.getStoriesList(childId);
    else {
      box.write(dkLastSelectedChild, childId);
      stories.value = await repo.getStoriesList(childId);
    }
  }

  Future<void> getTotalStoriesCount(List<Child> children) async {
    int total = 0;
    await children.forEach((child) async {
      List<Story> stories = await repo.getStoriesList(child.recordId);
      total += stories.length;
    });
    totalStoriesCount.value = total;
  }

  void getStoryChapters(String childId, String storyId, {editMode: false}) async {
    if (editMode)
      storyChaptersEdit.value = await repo.getStoryChapters(childId, storyId);
    else
      storyChapters.value = await repo.getStoryChapters(childId, storyId);
  }

  void deleteStory(String childId, String storyId) async {
    await repo.deleteStory(childId, storyId);
    storiesEdit.value = await repo.getStoriesList(childId);
    if (childId==box.read<String>(dkLastSelectedChild))
      stories.value = await repo.getStoriesList(childId);
  }

  void reset() {
    stories.value = [];
    storyChapters.value = [];
    storiesEdit.value = [];
    storyChaptersEdit.value = [];

    selectChildId.value = '';
    selectChildName.value = '';
    selectChildIdEdit.value = '';
    selectChildNameEdit.value = '';
  }
}