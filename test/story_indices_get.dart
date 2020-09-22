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

  if (args.length!=1) throw Exception('dart story_indices_get.dart <childRecordId>');
  String recordId = args[0];

  new File('token.txt').readAsString().then((token) async {
    response = await client.get('https://$pda/$storiesEndpointUrl/$recordId', headers: { 'Content-Type': 'application/json', 'X-Auth-Token': token});
    if (response.statusCode == 200) {
      Iterable body = json.decode(response.body);
      if (body.length==0) throw Exception("Stories Not Found");
      body.map((jsonObject) => Story.fromJson(jsonObject)).toList().forEach((story) { print(story);});
    } else {
      throw Exception("Failed to get Stories.");
    }
  }).catchError((error) => print(error));
}