import 'package:http/http.dart' show Client;
import 'dart:convert';
import 'dart:io';

void main() async {
  final pda = 'terryleehcfdev.hubat.net';
  Client client = Client();
  String username = 'terryleehcfdev';
  String password = 'roger-weary-edges';

  final response = await client.get(Uri.parse('https://$pda/users/access_token'),
      headers: { 'Content-Type': 'application/json', 'username': username, 'password': password});
  if (response.statusCode == 200) {
    new File('token.txt').writeAsStringSync(json.decode(response.body)['accessToken']);
  } else {
    throw Exception("Failed to get Stories.");
  }

}