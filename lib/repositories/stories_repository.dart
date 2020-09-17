import 'package:drops/services/stories_service.dart';
import 'package:get/get.dart';
import 'package:drops/entities/story.dart';

class StoriesRepository {
  final StoriesService storiesService = Get.find<StoriesService>();

  Future<List<Story>> getStories() => storiesService.getStories();
}