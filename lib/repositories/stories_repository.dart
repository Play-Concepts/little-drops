import 'package:drops/entities/story_chapter.dart';
import 'package:drops/services/delete_service.dart';
import 'package:drops/services/stories_service.dart';
import 'package:drops/utils/data_keys.dart';
import 'package:get/get.dart';
import 'package:drops/entities/story.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:convert';

class StoriesRepository {
  final StoriesService storiesService = Get.find<StoriesService>();
  final DeleteService deleteService = Get.find<DeleteService>();
  final GetStorage box = GetStorage(dkStore);

  Future<List<Story>> getStoriesList(String childId) {
    if (box.hasData('$dkStories-$childId')) {
      Iterable jsonStories = json.decode(box.read<String>('$dkStories-$childId')!);
      List<Story> storiesList = jsonStories.map((jsonObject) => Story.fromJson(jsonObject)).toList();
      return Future.value(storiesList);
    }
    return storiesService.getStoriesList(childId);
  }

  Future<Story> saveStoryIndex(String childId, String title, String description) => storiesService.saveStoryIndex(childId, title, description);
  Future<Story> updateStoryIndex(String childId, String storyId, String title, String description) => storiesService.updateStoryIndex(childId, storyId, title, description);

  Future<StoryChapter> saveStoryChapter(String childId, String storyId, String title, String story, int index) => storiesService.saveStoryChapter(childId, storyId, title, story, index);
  Future<StoryChapter> updateStoryChapter(
      String childId, String storyId, String storyChapterId,
      String title, String story, int index) => storiesService.updateStoryChapter(childId, storyId, storyChapterId, title, story, index);

  Future<List<StoryChapter>> getStoryChapters(String childId, String storyId) {
    if (box.hasData('$dkStories-$childId-$storyId')) {
      Iterable jsonStories = json.decode(box.read<String>('$dkStories-$childId-$storyId')!);
      List<StoryChapter> storyChapters = jsonStories.map((jsonObject) => StoryChapter.fromJson(jsonObject)).toList();
      return Future.value(storyChapters);
    }
    return storiesService.getStoryChapters(childId, storyId);
  }

  Future<void> deleteStory(String childId, String storyId) async {
    List<StoryChapter> chapters = await getStoryChapters(childId, storyId);
    List<String> recordIds = chapters.map((e) => e.recordId!).toList();

    recordIds.add(storyId);

    await deleteService.deleteAll(recordIds).then((value) async {
      await box.remove('$dkStories-$childId-$storyId');
      await box.remove('$dkStories-$childId');
    });
  }

  Future<bool> deleteStoryChapters(String childId, String storyId, List<String> recordIds) async {
    await box.remove('$dkStories-$childId-$storyId');
    return deleteService.deleteAll(recordIds);
  }
}