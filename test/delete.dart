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

  if (args.length!=1) throw Exception('dart delete.dart <recordId>');
  String recordId = args[0];

  new File('token.txt').readAsString().then((token) async {
    response = await client.delete('https://$pda/$dataEndpointUrl?records=$recordId', headers: { 'Content-Type': 'application/json', 'X-Auth-Token': token});
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      print(json.decode(response.body)['message']);
    } else {
      throw Exception("Failed to delete Child.");
    }
  }).catchError((error) => print(error));
}