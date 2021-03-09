import 'package:http/http.dart' show Client;
import 'dart:convert';
import 'dart:async';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:drops/entities/profile.dart';
import 'package:drops/entities/child.dart';
import 'package:drops/utils/data_endpoints_config.dart';
import 'package:drops/utils/data_keys.dart';

class ProfileService {
  Client client = Get.find<Client>();
  final GetStorage box = GetStorage(dkStore);

  Future<Profile> getProfile() async {
    if (!box.hasData(dkToken)) {
      throw Exception("Token not found");
    }
    String pda = box.read<String>(dkPda);
    String token = box.read<String>(dkToken);

    final response = await client.get(Uri.parse('https://$pda/$profileEndpointUrl'),
        headers: { 'Content-Type': 'application/json', 'X-Auth-Token': token});
    if (response.statusCode == 200) {
      String responseData = utf8.decode(response.bodyBytes);
      box.write(dkToken, response.headers['x-auth-token']);
      Iterable body = json.decode(responseData);
      if (body.length==0) throw Exception("Profile Not Found");
      box.write(dkProfile, responseData);
      return Profile.fromJson(body.first);
    } else {
      throw Exception("Failed to get Profile.");
    }
  }

  Future<Profile> saveProfile(String name) async {
    if (!box.hasData(dkToken)) {
      throw Exception("Token not found");
    }
    String pda = box.read<String>(dkPda);
    String token = box.read<String>(dkToken);

    dynamic data ={
      'name': name
    };
    final response = await client.post(
        Uri.parse('https://$pda/$profileEndpointUrl'),
        body: jsonEncode(data),
        headers: { 'Content-Type': 'application/json', 'X-Auth-Token': token});
    if (response.statusCode == 201) {
      String responseData = utf8.decode(response.bodyBytes);
      box.write(dkToken, response.headers['x-auth-token']);
      box.remove(dkProfile);
      dynamic body = json.decode(responseData);
      return Profile.fromJson(body);
    } else {
      throw Exception("Failed to save Profile.");
    }
  }

  Future<Profile> updateProfile(String recordId, String name) async {
    if (!box.hasData(dkToken)) {
      throw Exception("Token not found");
    }
    String pda = box.read<String>(dkPda);
    String token = box.read<String>(dkToken);

    dynamic data =[{
      'recordId': recordId,
      'endpoint': profileEndpoint,
      'data': {
        'name': name
      }
    }];

    final response = await client.put(
        Uri.parse('https://$pda/$dataEndpointUrl'),
        body: jsonEncode(data),
        headers: { 'Content-Type': 'application/json', 'X-Auth-Token': token});
    if (response.statusCode == 201) {
      String responseData = utf8.decode(response.bodyBytes);
      box.write(dkToken, response.headers['x-auth-token']);
      box.remove(dkProfile);
      Iterable body = json.decode(responseData);
      return Profile.fromJson(body.first);
    } else {
      throw Exception("Failed to Update Profile.");
    }
  }

  Future<List<Child>> getChildren() async {
    if (!box.hasData(dkToken)) {
      throw Exception("Token not found");
    }
    String pda = box.read<String>(dkPda);
    String token = box.read<String>(dkToken);

    final response = await client.get(
        Uri.parse('https://$pda/$childrenEndpointUrl'),
        headers: { 'Content-Type': 'application/json', 'X-Auth-Token': token});
    if (response.statusCode == 200) {
      String responseData = utf8.decode(response.bodyBytes);
      box.write(dkToken, response.headers['x-auth-token']);
      box.write(dkChildren, responseData);
      Iterable body = json.decode(responseData);
      List<Child> children = body.map((jsonObject) => Child.fromJson(jsonObject)).toList();
      return children;
    } else {
      throw Exception("Failed to get Children.");
    }
  }

  Future<Child> saveChild(String name, { String relationship: 'child', String gender: '', String ageGroup: ''}) async {
    if (!box.hasData(dkToken)) {
      throw Exception("Token not found");
    }
    String pda = box.read<String>(dkPda);
    String token = box.read<String>(dkToken);

    dynamic data = {
      'name': name,
      'relationship': relationship,
      'gender': gender,
      'ageGroup': ageGroup
    };
    final response = await client.post(
        Uri.parse('https://$pda/$childrenEndpointUrl'),
        body: jsonEncode(data),
        headers: { 'Content-Type': 'application/json', 'X-Auth-Token': token});
    if (response.statusCode == 201) {
      String responseData = utf8.decode(response.bodyBytes);
      box.write(dkToken, response.headers['x-auth-token']);
      dynamic body = json.decode(responseData);
      box.remove(dkChildren);
      return Child.fromJson(body);
    } else {
      throw Exception("Failed to save Child.");
    }
  }

  Future<Child> updateChild(String recordId, String name, { String relationship: 'child', String gender: '', String ageGroup: ''}) async {
    if (!box.hasData(dkToken)) {
      throw Exception("Token not found");
    }
    String pda = box.read<String>(dkPda);
    String token = box.read<String>(dkToken);

    dynamic data =[{
      'recordId': recordId,
      'endpoint': childrenEndpoint,
      'data': {
        'name': name,
        'relationship': relationship,
        'gender': gender,
        'ageGroup': ageGroup
      }
    }];
    final response = await client.put(
        Uri.parse('https://$pda/$dataEndpointUrl'),
        body: jsonEncode(data),
        headers: { 'Content-Type': 'application/json', 'X-Auth-Token': token});
    if (response.statusCode == 201) {
      String responseData = utf8.decode(response.bodyBytes);
      box.write(dkToken, response.headers['x-auth-token']);
      box.remove(dkChildren);
      Iterable body = json.decode(responseData);
      return Child.fromJson(body.first);
    } else {
      throw Exception("Failed to save Child.");
    }
  }
}