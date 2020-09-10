import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:drops/services/HattersService.dart';
import 'package:drops/entities/Pda.dart';

class HattersController extends GetxController {
  final HattersService hattersService = Get.find<HattersService>();

  Future<Pda> isRegistered(String type, String typeValue) => hattersService.isRegistered(type, typeValue);
  String loginUrl(String hatName) => hattersService.loginUrl(hatName);
  String signupUrl(String email) => hattersService.signupUrl(email);

  bool isEmailValid(String value) => GetUtils.isEmail(value);
}
