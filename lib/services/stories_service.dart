import 'package:http/http.dart' show Client;
import 'dart:convert';
import 'dart:async';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:drops/entities/story.dart';
import 'package:drops/utils/data_endpoints_config.dart';

class StoriesService {
  Client client = Get.find<Client>();
  final box = GetStorage('global');

  Future<List<Story>> getStories() async {
    if (!box.hasData('token')) {
      throw Exception("Token not found");
    }
    String pda = box.read<String>('pda');
    String token = box.read<String>('token');
    token.split(".").forEach((element) {print(element);});
    final response = await client.get('https://$pda/$storiesEndpointUrl', headers: { 'Content-Type': 'application/json', 'x-auth-token': '$token'});
    if (response.statusCode == 200) {
      Iterable jsonStories = json.decode(response.body);
      return jsonStories.map((e) => Story.fromJson(e)).toList();
    } else {
      throw Exception("Failed to get Stories.");
    }
  }
}