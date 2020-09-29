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

  Future<List<Story>> getStoriesList(String childRecordId) async {
    if (!box.hasData(dkToken)) {
      throw Exception("Token not found");
    }
    String pda = box.read<String>(dkPda);
    String token = box.read<String>(dkToken);

    final response = await client.get(
        'https://$pda/$storiesEndpointUrl/$childRecordId',
        headers: {'Content-Type': 'application/json', 'x-auth-token': token});
    if (response.statusCode == 200) {
      box.write(dkToken, response.headers['x-auth-token']);
      box.write('$dkStories-$childRecordId', response.body);
      Iterable jsonStories = json.decode(response.body);
      List<Story> result =
          jsonStories.map((jsonObject) => Story.fromJson(jsonObject)).toList();

      return result;
    } else {
      throw Exception("Failed to get Stories.");
    }
  }

  Future<List<StoryChapter>> getStoryChapters(String childRecordId, String storyId) async {
    if (!box.hasData(dkToken)) {
      throw Exception("Token not found");
    }
    String pda = box.read<String>(dkPda);
    String token = box.read<String>(dkToken);

    final response = await client.get(
        'https://$pda/$storiesEndpointUrl/$childRecordId/$storyId?orderBy=index',
        headers: {'Content-Type': 'application/json', 'x-auth-token': token});
    if (response.statusCode == 200) {
      box.write(dkToken, response.headers['x-auth-token']);
      box.write('$dkStories-$childRecordId-$storyId', response.body);
      Iterable jsonStories = json.decode(response.body);
      List<StoryChapter> result =
      jsonStories.map((jsonObject) => StoryChapter.fromJson(jsonObject)).toList();

      return result;
    } else {
      throw Exception("Failed to get Story Chapters.");
    }
  }

  Future<Story> saveStoryIndex(
      String childRecordId, String title, String description) async {
    if (!box.hasData(dkToken)) {
      throw Exception("Token not found");
    }
    String pda = box.read<String>(dkPda);
    String token = box.read<String>(dkToken);

    dynamic data = {'title': title, 'description': description};

    final response = await client.post(
        'https://$pda/$storiesEndpointUrl/$childRecordId',
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json', 'x-auth-token': token});
    if (response.statusCode == 201) {
      box.write(dkToken, response.headers['x-auth-token']);
      box.remove('$dkStories-$childRecordId');
      dynamic body = json.decode(response.body);
      return Story.fromJson(body);
    } else {
      throw Exception("Failed to get Stories.");
    }
  }

  Future<Story> updateStoryIndex(String recordId, String childRecordId,
      String title, String description) async {
    if (!box.hasData(dkToken)) {
      throw Exception("Token not found");
    }
    String pda = box.read<String>(dkPda);
    String token = box.read<String>(dkToken);

    dynamic data = [
      {
        'recordId': recordId,
        'endpoint': '$storiesEndpoint/$childRecordId',
        'data': {'title': title, 'description': description}
      }
    ];

    final response = await client.post(
        'https://$pda/$dataEndpointUrl',
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json', 'x-auth-token': token});
    if (response.statusCode == 201) {
      box.write(dkToken, response.headers['x-auth-token']);
      box.remove('$dkStories-$childRecordId');
      Iterable body = json.decode(response.body);
      if (body.length==0) throw Exception("Story Index Not Saved.");
      return Story.fromJson(body.first);
    } else {
      throw Exception("Failed to get Stories.");
    }
  }
}
