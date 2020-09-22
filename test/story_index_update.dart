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

  if (args.length != 4)
    throw Exception(
        'dart story_index_save.dart <recordId> <childRecordId> <title> <description>');
  String recordId = args[0];
  String childRecordId = args[1];
  String title = args[2];
  String description = args[3];

  new File('token.txt').readAsString().then((token) async {
    dynamic body = [
      {
        'recordId': recordId,
        'endpoint': '$childrenEndpoint/$childRecordId',
        'data': {'title': title, 'description': description}
      }
    ];
    response = await client.put('https://$pda/$dataEndpointUrl',
        body: jsonEncode(body),
        headers: {'Content-Type': 'application/json', 'X-Auth-Token': token});
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 201) {
      Iterable body = json.decode(response.body);
      if (body.length==0) throw Exception("Story Index Not Saved.");
      Story story = Story.fromJson(body.first);
      print(story);
    } else {
      throw Exception("Failed to save Story.");
    }
  }).catchError((error) => print(error));
}
