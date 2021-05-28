import 'package:drops/entities/story_chapter.dart';
import 'package:http/http.dart' show Client;
import 'dart:convert';
import 'dart:async';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:drops/entities/story.dart';
import 'package:drops/utils/data_endpoints_config.dart';
import 'package:drops/utils/data_keys.dart';

class StoriesService {
  Client client = Get.find<Client>();
  final GetStorage box = GetStorage(dkStore);

  Future<List<Story>> getStoriesList(String childId) async {
    if (!box.hasData(dkToken)) {
      throw Exception("Token not found");
    }
    String? pda = box.read<String>(dkPda);
    String? token = box.read<String>(dkToken);

    final response = await client.get(
        Uri.parse('https://$pda/$storiesEndpointUrl/$childId'),
        headers: {'Content-Type': 'application/json', 'x-auth-token': token!});
    if (response.statusCode == 200) {
      String responseData = utf8.decode(response.bodyBytes);
      box.write(dkToken, response.headers['x-auth-token']);
      box.write('$dkStories-$childId', responseData);
      Iterable jsonStories = json.decode(responseData);
      List<Story> result =
          jsonStories.map((jsonObject) => Story.fromJson(jsonObject)).toList();

      return result;
    } else {
      throw Exception("Failed to get Stories.");
    }
  }

  Future<List<StoryChapter>> getStoryChapters(String childId, String storyId) async {
    if (!box.hasData(dkToken)) {
      throw Exception("Token not found");
    }
    String? pda = box.read<String>(dkPda);
    String? token = box.read<String>(dkToken);

    final response = await client.get(
        Uri.parse('https://$pda/$storiesEndpointUrl/$childId/$storyId?orderBy=index'),
        headers: {'Content-Type': 'application/json', 'x-auth-token': token!});
    if (response.statusCode == 200) {
      String responseData = utf8.decode(response.bodyBytes);
      box.write(dkToken, response.headers['x-auth-token']);
      box.write('$dkStories-$childId-$storyId', responseData);
      Iterable jsonStories = json.decode(responseData);
      List<StoryChapter> result =
      jsonStories.map((jsonObject) => StoryChapter.fromJson(jsonObject)).toList();

      return result;
    } else {
      throw Exception("Failed to get Story Chapters.");
    }
  }

  Future<Story> saveStoryIndex(
      String childId, String title, String description) async {
    if (!box.hasData(dkToken)) {
      throw Exception("Token not found");
    }
    String? pda = box.read<String>(dkPda);
    String? token = box.read<String>(dkToken);

    dynamic data = {'title': title, 'description': description};

    final response = await client.post(
        Uri.parse('https://$pda/$storiesEndpointUrl/$childId'),
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json', 'x-auth-token': token!});
    if (response.statusCode == 201) {
      String responseData = utf8.decode(response.bodyBytes);
      box.write(dkToken, response.headers['x-auth-token']);
      box.remove('$dkStories-$childId');
      dynamic body = json.decode(responseData);
      return Story.fromJson(body);
    } else {
      throw Exception("Failed to get Stories.");
    }
  }

  Future<Story> updateStoryIndex(String childId, String storyId,
      String title, String description) async {
    if (!box.hasData(dkToken)) {
      throw Exception("Token not found");
    }
    String? pda = box.read<String>(dkPda);
    String? token = box.read<String>(dkToken);

    dynamic data = [
      {
        'recordId': storyId,
        'endpoint': '$storiesEndpoint/$childId',
        'data': {'title': title, 'description': description}
      }
    ];

    final response = await client.put(
        Uri.parse('https://$pda/$dataEndpointUrl'),
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json', 'x-auth-token': token!});
    if (response.statusCode == 201) {
      String responseData = utf8.decode(response.bodyBytes);
      box.write(dkToken, response.headers['x-auth-token']);
      box.remove('$dkStories-$childId');
      Iterable body = json.decode(responseData);
      if (body.length==0) throw Exception("Story Index Not Saved.");
      return Story.fromJson(body.first);
    } else {
      throw Exception("Failed to update Story.");
    }
  }

  Future<StoryChapter> saveStoryChapter(
      String childId, String storyId, String title, String story, int index) async {
    if (!box.hasData(dkToken)) {
      throw Exception("Token not found");
    }
    String? pda = box.read<String>(dkPda);
    String? token = box.read<String>(dkToken);

    dynamic data = {'title': title, 'story': story, 'index': index};

    final response = await client.post(
        Uri.parse('https://$pda/$storiesEndpointUrl/$childId/$storyId'),
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json', 'x-auth-token': token!});
    if (response.statusCode == 201) {
      String responseData = utf8.decode(response.bodyBytes);
      box.write(dkToken, response.headers['x-auth-token']);
      box.remove('$dkStories-$childId-$storyId');
      dynamic body = json.decode(responseData);
      return StoryChapter.fromJson(body);
    } else {
      throw Exception("Failed to save Story Chapter.");
    }
  }

  Future<StoryChapter> updateStoryChapter(
      String childId, String storyId, String storyChapterId,
      String title, String story, int index) async {
    if (!box.hasData(dkToken)) {
      throw Exception("Token not found");
    }
    String? pda = box.read<String>(dkPda);
    String? token = box.read<String>(dkToken);

    dynamic data = [
      {
        'recordId': storyChapterId,
        'endpoint': '$storiesEndpoint/$childId/$storyId',
        'data': {'title': title, 'story': story, 'index': index}
      }
    ];

    final response = await client.put(
        Uri.parse('https://$pda/$dataEndpointUrl'),
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json', 'x-auth-token': token!});
    if (response.statusCode == 201) {
      String responseData = utf8.decode(response.bodyBytes);
      box.write(dkToken, response.headers['x-auth-token']);
      box.remove('$dkStories-$childId-$storyId');
      Iterable body = json.decode(responseData);
      if (body.length==0) throw Exception("Story Chapter Not Saved.");
      return StoryChapter.fromJson(body.first);
    } else {
      throw Exception("Failed to update Story Chapter.");
    }
  }
}
