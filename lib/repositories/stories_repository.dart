import 'package:drops/entities/story_chapter.dart';
import 'package:drops/services/stories_service.dart';
import 'package:drops/utils/data_keys.dart';
import 'package:get/get.dart';
import 'package:drops/entities/story.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:convert';

class StoriesRepository {
  final StoriesService storiesService = Get.find<StoriesService>();
  final GetStorage box = GetStorage(dkStore);

  Future<List<Story>> getStoriesList(String childRecordId) {
    if (box.hasData('$dkStories-$childRecordId')) {
      Iterable jsonStories = json.decode(box.read<String>('$dkStories-$childRecordId'));
      List<Story> storiesList = jsonStories.map((jsonObject) => Story.fromJson(jsonObject)).toList();
      return Future.value(storiesList);
    }
    return storiesService.getStoriesList(childRecordId);
  }

  Future<Story> saveStoryIndex(String childRecordId, String title, String description) => storiesService.saveStoryIndex(childRecordId, title, description);

  Future<List<StoryChapter>> getStoryChapters(String childRecordId, String storyId) {
    if (box.hasData('$dkStories-$childRecordId-$storyId')) {
      Iterable jsonStories = json.decode(box.read<String>('$dkStories-$childRecordId-$storyId'));
      List<StoryChapter> storyChapters = jsonStories.map((jsonObject) => StoryChapter.fromJson(jsonObject)).toList();
      return Future.value(storyChapters);
    }
    return storiesService.getStoryChapters(childRecordId, storyId);
  }
}