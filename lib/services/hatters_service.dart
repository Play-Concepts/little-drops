import 'package:http/http.dart' show Client;
import 'dart:convert';
import 'dart:async';
import 'package:get/get.dart';
import 'package:drops/utils/service_config.dart';
import 'package:drops/entities/pda.dart';
import 'package:jose/jose.dart';

class HattersService {
  Client client = Get.find<Client>();

  Future<Pda> isRegistered(String type, String typeValue) async {
    final response = await client.get('$hattersUrl$type=${Uri.encodeComponent(typeValue)}');
    if (response.statusCode == 200)
      return Pda.fromJson(json.decode(response.body));
    else
      throw Exception("Failed to check PDAs.");
  }

  String loginUrl(String hatName) {
    return 'https://$hatName/#/hatlogin?name=$applicationId&redirect=$callbackUrl&fallback=$fallbackUrl';
  }

  String signupUrl(String email) {
    return '$daasUrl?email=$email&application_id=$applicationId&redirect_uri=$callbackUrl';
  }

  String extractPda(String token) {
    var signature = JsonWebSignature.fromCompactSerialization(token);
    return signature.unverifiedPayload.jsonContent['iss'];
  }
}
