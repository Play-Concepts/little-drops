import 'package:http/http.dart' show Client;
import 'dart:io';
import 'dart:convert';
import 'package:drops/utils/data_endpoints_config.dart';
import 'package:drops/entities/child.dart';
import 'package:http/src/response.dart';

void main(List<String> args) {
  final client = Client();
  final pda = 'terryleehcfdev.hubat.net';
  Response response;

  if (args.length!=2) throw Exception('dart child_update.dart <recordId> <name>');
  String recordId = args[0];
  String input = args[1];

  new File('token.txt').readAsString().then((token) async {
    dynamic body =[{
      'recordId': recordId,
      'endpoint': childrenEndpoint,
      'data': {
        'name': input,
        'relationship': 'child'
      }
    }];
    response = await client.put('https://$pda/$dataEndpointUrl', body: jsonEncode(body), headers: { 'Content-Type': 'application/json', 'X-Auth-Token': token});
    if (response.statusCode == 201) {
      Iterable body = json.decode(response.body);
      if (body.length==0) throw Exception("Child Not Updated.");
      Child profile = Child.fromJson(body.first);
      print(profile);
    } else {
      throw Exception("Failed to update Child.");
    }
  }).catchError((error) => print(error));
}