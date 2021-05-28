import 'package:http/http.dart' show Client;
import 'dart:io';
import 'dart:convert';
import 'package:drops/utils/data_endpoints_config.dart';
import 'package:drops/entities/story.dart';
import 'package:http/src/response.dart';

void main(List<String> args) {
  final client = Client();
  final pda = 'terryleehcfdev.hubat.net';
  Response response;

  if (args.length!=3) throw Exception('dart story_index_save.dart <recordId> <title> <description>');
  String recordId = args[0];
  String title = args[1];
  String description = args[2];

  new File('token.txt').readAsString().then((token) async {
    dynamic body ={
      'title': title,
      'description': description
    };
    response = await client.post(
        Uri.parse('https://$pda/$storiesEndpointUrl/$recordId'),
        body: jsonEncode(body),
        headers: { 'Content-Type': 'application/json', 'X-Auth-Token': token});
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 201) {
      dynamic body = json.decode(response.body);
      Story story = Story.fromJson(body);
      print(story);
    } else {
      throw Exception("Failed to save Story.");
    }
  }).catchError((error) => print(error));
}