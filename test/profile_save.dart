import 'package:http/http.dart' show Client;
import 'dart:io';
import 'dart:convert';
import 'package:drops/utils/data_endpoints_config.dart';
import 'package:drops/entities/profile.dart';
import 'package:http/src/response.dart';

void main() {
  final client = Client();
  final pda = 'terryleehcfdev.hubat.net';
  Response response;

  String input = stdin.readLineSync();

  new File('token.txt').readAsString().then((token) async {
    dynamic body ={
      'name': input
    };
    response = await client.post('https://$pda/$profileEndpointUrl', body: jsonEncode(body), headers: { 'Content-Type': 'application/json', 'X-Auth-Token': token});
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 201) {
      dynamic body = json.decode(response.body);
      Profile profile = Profile.fromJson(body);
      print(profile);
    } else {
      throw Exception("Failed to save Profile.");
    }
  }).catchError((error) => print(error));
}