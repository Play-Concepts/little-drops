import 'package:http/http.dart' show Client, Response;
import 'dart:io';
import 'dart:convert';
import 'package:drops/utils/data_endpoints_config.dart';
import 'package:drops/entities/profile.dart';

void main() {
  final client = Client();
  final pda = 'terryleehcfdev.hubat.net';
  Response response;
  new File('token.txt').readAsString().then((token) async {
    response = await client.get('https://$pda/$profileEndpointUrl', headers: { 'Content-Type': 'application/json', 'X-Auth-Token': token});
    if (response.statusCode == 200) {
      Iterable body = json.decode(response.body);
      if (body.length==0) throw Exception("Profile Not Found");
      Profile profile = Profile.fromJson(body.first);
      print(profile);
    } else {
      throw Exception("Failed to get Profile.");
    }
  }).catchError((error) => print(error));
}