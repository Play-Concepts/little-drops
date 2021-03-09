import 'package:http/http.dart' show Client;
import 'dart:async';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:drops/utils/data_endpoints_config.dart';
import 'package:drops/utils/data_keys.dart';

class DeleteService {
  Client client = Get.find<Client>();
  final GetStorage box = GetStorage(dkStore);

  Future<bool> deleteAll(List<String> recordIds) async {
    if (!box.hasData(dkToken)) {
      throw Exception("Token not found");
    }
    String pda = box.read<String>(dkPda);
    String token = box.read<String>(dkToken);

    String queryParams = recordIds.map((recordId) => 'records=$recordId').join('&');
    final response = await client.delete(
        Uri.parse('https://$pda/$dataEndpointUrl?$queryParams'),
        headers: {'Content-Type': 'application/json', 'x-auth-token': token});
    if (response.statusCode == 200) {
      box.write(dkToken, response.headers['x-auth-token']);
      return Future.value(true);
    } else {
      throw Exception("Failed to get Stories.");
    }
  }

  Future<bool> delete(String recordId) => deleteAll([recordId]);
}
