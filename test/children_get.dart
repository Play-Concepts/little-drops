import 'package:http/http.dart' show Client;
import 'dart:io';
import 'dart:convert';
import 'package:drops/utils/data_endpoints_config.dart';
import 'package:drops/entities/child.dart';
import 'package:http/src/response.dart';

void main() {
  final client = Client();
  final pda = 'terryleehcfdev.hubat.net';
  Response response;
  new File('token.txt').readAsString().then((token) async {
    response = await client.get(Uri.parse('https://$pda/$childrenEndpointUrl'),
        headers: { 'Content-Type': 'application/json', 'X-Auth-Token': token});
    if (response.statusCode == 200) {
      print(response.body);
      Iterable body = json.decode(response.body);
      if (body.length==0) throw Exception("Children Not Found");
      body.map((jsonObject) => Child.fromJson(jsonObject)).toList().forEach((child) { print(child);});
    } else {
      throw Exception("Failed to get Children.");
    }
  }).catchError((error) => print(error));
}