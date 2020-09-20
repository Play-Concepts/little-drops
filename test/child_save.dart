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

  String input = stdin.readLineSync();

  new File('token.txt').readAsString().then((token) async {
    dynamic body ={
      'name': input,
      'relationship': 'child'
    };
    response = await client.post('https://$pda/$childrenEndpointUrl', body: jsonEncode(body), headers: { 'Content-Type': 'application/json', 'X-Auth-Token': token});
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 201) {
      dynamic body = json.decode(response.body);
      Child child = Child.fromJson(body);
      print(child);
    } else {
      throw Exception("Failed to save Child.");
    }
  }).catchError((error) => print(error));
}